Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131525AbRCQCYl>; Fri, 16 Mar 2001 21:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131531AbRCQCYc>; Fri, 16 Mar 2001 21:24:32 -0500
Received: from warden.digitalinsight.com ([208.29.163.2]:16845 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id <S131525AbRCQCYW>; Fri, 16 Mar 2001 21:24:22 -0500
Date: Fri, 16 Mar 2001 18:18:06 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: Tim Jansen <tim@tjansen.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [RFC/Patch] Device Registry
In-Reply-To: <20010317031033.A958@tjansen.de>
Message-ID: <Pine.LNX.4.33.0103161816400.11295-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim, what is it that this is designed to do that devfs doesn't (or
can't) do?

David Lang

On Sat, 17 Mar 2001, Tim Jansen wrote:

> Date: Sat, 17 Mar 2001 03:10:33 +0100
> From: Tim Jansen <tim@tjansen.de>
> To: linux-kernel@vger.kernel.org
> Subject: [RFC/Patch] Device Registry
>
> RFC: Linux Device Registry
> ==========================
>
> Summary
> -------
> The device registry provides a /proc file in text format that contains
> a list of all connected physical devices. Each list entry
> includes (as far as available) the name and vendor of the device, its
> location/topological information, the device files (/dev) that the
> driver(s) have registered and a unique DeviceID that makes it possible to
> find the device after a reboot.
> An experimental patch for 2.4.2 can be found at http://www.tjansen.de/devreg
>
>
> Reasons for the Device Registry
> -------------------------------
> Finding the available devices with the current Linux kernel is difficult
> and not always possible. For example the only way to get all printers on
> Linux is to open all devices in /dev that could represent one, but
> this has some limitations. The first problem is that the user-space app must
> know which files should be probed. The /dev/lpX files are candidates
> and for USB printers also /dev/usb/lpX. Everytime a new bus for printers
> is added there is a new range of device files that must be probed, for
> example for IEEE1394/FireWire printers user-space apps would have to probe
> the /dev/ieee1394/lpX (or whatever their names will be). This makes it
> impossible to write forward-compatible user-space applications.
>
> Even if the application knows which devices are actual printers they
> must be presented to the user so that he can select one of them,
> and for this things like the printers name and vendor are neccessary.
> Unfortunately every bus has a different facility to provide these
> information. Parallel ports expose them in /proc/sys/dev/parport; USB
> shows them in usbdevfs, but it is not possible to figure out which
> /dev/usb/lpX file belongs to which physical printer. And as IEEE1394 will
> have to implement another method to get information about the printer
> device, user-apps today have no chance to get show them when kernel support is
> ready.
>
> The next problem is associated with hotplugging. If you have two printers
> attached to the USB bus, say an Epson and a HP printer, you dont know
> their device files. If you turn on the Epson printer and then the HP printer,
> the Epson will be /dev/usb/lp0 and the HP /dev/usb/lp1. When you first
> power on the HP on the next reboot (or turn off the Epson before you turn the
> HP on) it will be on /dev/usb/lp0.
>
> Sometimes devices have several independent interfaces that belong together.
> For example there are USB scanners with buttons that are intended to trigger
> actions by user-space applications like starting a scan. The USB driver uses
> two separate drivers for them, in the case of a scanner it would use a HID
> driver (there is a patch available for non-keyboards/mice/joystick input
> devices) and a regular scanner driver. A similar setup is also common for USB
> audio devices.
> With the current implementation it is not possible to find out which device
> files represent which physical device.
>
>
> Solutions provided by the Device Registry
> -----------------------------------------
> The Device Registry (DevReg) puts a text list of all physical devices
> into /proc/devreg. Each entry consists of:
>
> - the model and vendor name of the device (if available)
> - the type of the device (for example hub/usb)
> - the bus/location of the device (for example COM2 or USB)
> - topology information (to build a tree of all devices)
> - the unique DeviceID to find the device after a reboot
> - the device files (if devfs is used) and the major/minor number of
>   the device files and the interface it implements (for example OSS or V4L)
>
> This should be sufficient for the following use cases:
> - find all devices that implement a interface (for example
>   all OSS devices) and present them to the user he can chose one
> - get the DeviceID of a device so its device file can be found after a
>   reboot
> - find a device file for a DeviceID
> - show all devices in the computer
>
> Finding a device with a DeviceID instead of a device file name is neither
> supported by current applications nor by other Unix-like operating
> systems. Therefore, to stay compatible with existing software, a user-space
> daemon could take care of creating stable names for devices.
> For example, if you have the Epson and HP printer from the example above,
> the daemon could create two symlinks called /dev/lpEpson and /dev/lpHP that
> always point to the correct device file as long as the physical device is
> connected.
> As the format of the /proc/devreg file is relatively complex a user-space
> library that implements the use cases given above will be provided.
>
>
> DeviceID
> --------
> Each device get a unique device id. The id is a string in the format
> "bus-type/location/model/serialnum". bus-type is "usb" or "pci"
> for the currently supported busses. location is
> "busnumber:slotnumber" for PCI devices and
> "busnumber[:1st-hub-model:1st-hub-vendor[:2nd-hub-model:2nd-hub-vendor..]]"
> for USB devices. The format of the model is "vendorID:deviceID" for
> both USB and PCI. The serial number is driver and device specific,
> ethernet adapters would take their hardware address here. For
> those devices that cannot be identified the field should be empty.
> When finding devices the app should try to get an exact match first.
> If this is not possible, it should try to find a match with
> identical model and serial number but different location.
>
>
> Device Type
> -----------
> To display the devices for the user an identification of the type (or class)
> of the device is needed. The format is "base-type[/sub-type]", for example
> "network-adapter/ethernet" or "controller/scsi". The classes should
> be managed centrally to avoid duplicate entries.
> The device type is intentionally simple and does not reflect
> all possible devices. This makes it possible to provide icons for all
> device types, but also prevents uncommon devices from being categorized.
> For example an integrated keyboard and pointing device could only be
> represented as a generic input device (unless they get really popular and a
> they new class is created for them). Therefore an application that
> tries to find a device should always search for interfaces and not for
> the device types.
>
>
> Subdevices
> ----------
> A device can have subdevices. This is useful for multi-functional devices,
> for example an integrated USB and FireWire controller. In this case there
> is a list entry for the card itself with the device-type "multi-functional".
> The device files are associated with the sub-device, not with the super
> device.
>
>
> Device File Interface
> ---------------------
> To describe the interface of a device file a simple string in the
> format "category/apiname/devicename" is used. The devicename field
> is empty if the API only uses a single file per device.
> For example, the OSS sound API would use the string "sound/oss/dsp"
> for its "/dev/dsp" file. ALSA device files start with "sound/alsa".
>
>
> Text file format
> ----------------
> Each device in the file format consists of several lines in the format
> "category/field-name=value". There is one value per line, the devices
> are separated by blank lines. User-space apps must ignore those fields
> that they don't know.
> Fields, one per device in this order:
> common/number=<DEVICE-NUMBER>
> 	a number of the device for this list. Required.
> common/parent=<PARENT-NUMBER>
> 	the number of the device's topological parent. This is intended
> 	for busses like USB that use hubs (see also common/superdevice).
> 	Required for all devices that are not at the top-level of their bus
> 	or subdevices.
> common/superdevice=<SUPERDEVICE-NUMBER>
> 	the number of the devies superdevice. This is intended for
> 	multi-functional devices, for example an integrated FireWire and USB
> 	adapter. Required for subdevices.
> common/bus=<BUS-NAME>
> 	the bus of the device, e.g. usb, pci or parport. Required.
> common/type=<TYPE-NAME>
> 	the type of the device, e.g. network-adapter/ethernet, hub/usb,
>         repeater/firewire, controller/usb. See above. Required.
> common/deviceid=<DEVICE/ID>
> 	the DeviceID as described above. Required.
> common/name=<MODEL-NAME>
> 	the device's name. Can come from the device (USB) or from a
> 	database in the kernel (PCI). Required.
> common/vendor=<VENDOR-NAME>
> 	the device's vendor. Can come from the device (USB) or from a
> 	database in the kernel (PCI). Optional.
> common/location=<LOCATION>
> 	the location of the device. For example USB, PCI, AGP or COM2.
> 	Required.
> common/internal=(true|false)
> 	if true it is an internal device. Optional.
>
> After the common lines there can be fields for other categories.
> For example devices on the PCI bus could have fields that contain the
> model and vendor id. The name of a field that contains the model id would
> be "pci/modelid". This could eventually replace the bus-specific file
> systems on /proc/bus.
> At the end of device entry follow the lines that list the device files.
> For each device files there must be three or four fields in the following
> order:
>
> devfile/interface=<DEVICE-FILE-INTERFACE>
> 	The interface that the device file implements, see above. Required.
> devfile/name=<DEVICE-FILENAME>
> 	The file name of the device relative to the device directory (in
> 	other word, without the leading '/dev'). Only if devfs is available.
> devfile/major=<MAJOR-NUM>
> 	The major number of the device. Required.
> devfile/minor=<MINOR-NUM>
> 	The minor number of the device. Required.
>
>
> Alternative representations
> ---------------------------
> Other representations of the device registry are possible. If desired a binary
> format could be implemented using a (R)IFF-like, chunk-based format. However
> parsing it would not be significantly easier than the text-based format as it
> is not possible to represent the data of a list entry with a simple struct.
>
> Another alternative is to use a file per device in a directory-structure.
> With the right structure, for example a directory per interface, this could
> improve the scalability of certain user-space operations on machines with a
> very large number of devices, but it would also increase complexity
> significantly. Optimal performance and scalability could be archived by
> implementing ioctl search functions.
>
> Implementation
> --------------
> The patch can be downloaded from
> http://www.tjansen.de/devreg/devreg-2.4.2-0.1.patch.gz . Just apply it,
> then select CONFIG_DEVREG (in the general section). CONFIG_PROCFS_FS must
> also be enabled, and using CONFIG_DEVFS_FS is recommended but not required.
> Be careful with modules, the patch breaks a few interfaces so that some old
> modules will not work anymore. Either compile without any (important)
> modules, or change the kernel version in the top-level Makefile.
> After compilation, reboot and you should see the /proc/devreg file.
>
> The patch currently supports only PCI and USB devices. The following drivers
> will register types and/or device files:
> hid/USB, hub/USB, emu10k1/PCI.
> The following PCI drivers should work, but are untested (all sound cards):
> via82cxxx, trident, sonicvibes, maestro3, maestro, i810_audio, esssolo1,
> es1371, es1370, cs46xx, cs4281
>
> You can find the kernel API, a preview of the user-space API and some other
> stuff on http://www.tjansen.de/devreg
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

