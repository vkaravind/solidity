pragma solidity ^0.4.11;

contract DeviceContract {

	
  	 struct device { //device structure
          uint deviceId; // device ID 
          bytes32 deviceName; //name of device
          bool verified;  // if device verified
          address userAddress; // device owner
          uint index;// device index
      }

     mapping (uint => device) private   devices;
     uint[] private  deviceIndex;

      event LogNewDevice   ( uint  indexed deviceId, uint index, bytes32 deviceName, address userAddress);

     function AddDevice( //create a new device
       uint deviceId,
       bytes32 deviceName,
       bool verified,
       address userAddress)
       public
       returns(uint index)
    {
       if(IsDevice(deviceId)) throw;
        devices[deviceId].deviceId = deviceId;
        devices[deviceId].deviceName = deviceName;
        devices[deviceId].verified = verified;
        devices[deviceId].userAddress = userAddress;
        devices[deviceId].index = deviceIndex.push(deviceId)-1;
        LogNewDevice(
          deviceId,
          devices[deviceId].index,
          deviceName,
          userAddress
        );
        return deviceIndex.length-1;
     }

    function IsDevice(uint deviceId)
      public
      constant
      returns(bool isIndeed)
    {
      if(deviceIndex.length == 0) return false;
      return (deviceIndex[devices[deviceId].index] == deviceId);
    }
    
    function Getdevice(uint deviceId)
       public
       constant
       returns( bytes32 deviceName, bool verified, uint index)
     {
       if(!IsDevice(deviceId)) throw;
       return(
         devices[deviceId].deviceName,
         devices[deviceId].verified,
         devices[deviceId].index);
     }
}
