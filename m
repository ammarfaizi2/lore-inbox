Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261523AbSIXBio>; Mon, 23 Sep 2002 21:38:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261524AbSIXBin>; Mon, 23 Sep 2002 21:38:43 -0400
Received: from air-2.osdl.org ([65.172.181.6]:1152 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261523AbSIXBii>;
	Mon, 23 Sep 2002 21:38:38 -0400
Date: Mon, 23 Sep 2002 18:45:26 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org
Subject: [BK PATCH] driver model updates
Message-ID: <Pine.LNX.4.44.0209231833020.966-200000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="346834433-1225963352-1032831926=:966"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--346834433-1225963352-1032831926=:966
Content-Type: TEXT/PLAIN; charset=US-ASCII


Hey there.

Here is the latest round of driver model infrastructure updates. To 
summarize, these changes do:

- Add system bus type, and struct sys_device for system-level devices.
- convert i8259.c and time.c to use this interface. This gives us in 
driverfs: 

[mochel@cherise mochel]$ tree -d /sys/bus/system/
/sys/bus/system/
|-- devices
|   |-- pic0 -> ../../../root/sys/pic0
|   `-- rtc0 -> ../../../root/sys/rtc0
`-- drivers
    |-- cpu
    `-- pic


- add struct cpu, a default CPU driver, and a CPU device class. 
- Register CPU devices on boot, which gives us in driverfs: 

[mochel@cherise mochel]$ tree -d /sys/class/cpu/
/sys/class/cpu/
|-- devices
|   |-- 0 -> ../../../root/sys/cpu0
|   `-- 1 -> ../../../root/sys/cpu1
`-- drivers


- add struct platform_device to represent platform (legacy) devices. 
- convert floppy.c to use this interface.
- This gives us in driverfs:

[mochel@cherise mochel]$ tree -d /sys/bus/platform/
/sys/bus/platform/
|-- devices
|   `-- floppy0 -> ../../../root/legacy/floppy0
`-- drivers

- add support for multi-board systems (e.g. Numa-Q) and mechanism for 
  setting the what board a system device resides on. 


I've attached the entire tree(1) output of my driverfs partition for my 
dual P4 workstation, to give an idea of what the entire picture looks 
like. It's coming together nicely, except..

ACPI is still ugly, and doesn't deserve a top-level directory. The next 
item on my list is to create a common place for firmware drivers to place 
their stuff, and integrate some of the related patches I've received. 

Please apply.

Thanks,

	-pat

Please pull from 

	bk://ldm.bkbits.net/linux-2.5

This will update the following files:

 arch/i386/kernel/cpu/common.c |   35 +++++++++++
 arch/i386/kernel/i8259.c      |   20 ++++--
 arch/i386/kernel/time.c       |   15 ++--
 drivers/base/Makefile         |    7 +-
 drivers/base/core.c           |   54 ++++++++---------
 drivers/base/cpu.c            |   28 ++++++++
 drivers/base/platform.c       |   41 ++++++++++++-
 drivers/base/sys.c            |  131 ++++++++++++++++++++++++++++++++++++------
 drivers/block/floppy.c        |   19 +++---
 drivers/usb/core/usb.c        |   10 ++-
 include/linux/cpu.h           |   28 ++++++++
 include/linux/device.h        |   36 ++++++++++-
 12 files changed, 350 insertions(+), 74 deletions(-)

through these ChangeSets:

<mochel@osdl.org> (02/09/23 1.607)
   driver model: add better platform device support.
   
   Platform devices are devices commonly found on the motherboard of systems. This
   includes legacy devices (serial ports, floppy controllers, parallel ports, etc)
   and host bridges to peripheral buses. 
   
   We already had a platform bus type, which gives a way to group platform devices
   and drivers, and allow each to be bound to each other dynamically. Though before,
   it didn't do anything. It still doesn't do much, but we now have:
   
   - struct platform_device, which generically describes platform deviecs. This only
     includes a name and id in addition to a struct device, but more may be added later.
   
   - implelemnt platform_device_register() and platform_device_unregister() to handle
     adding and removing these devices. 
   
   - Create legacy_bus - a default parent device for legacy devices. 
   
   - Change the floppy driver to define a platform_device (instead of a sys_device). 
     In driverfs, this gives us now:
   
   a# tree -d /sys/bus/platform/
   /sys/bus/platform/
   |-- devices
   |   `-- floppy0 -> ../../../root/legacy/floppy0
   `-- drivers
   
   and
   
   # tree -d /sys/root/legacy/
   /sys/root/legacy/
   `-- floppy0

<mochel@osdl.org> (02/09/23 1.603.1.5)
   driver model: add support for multi-board systems.
   
   - device struct sys_root for describing the individual boards of a multi-board
     system.
   
   - allow for registration of alternate device roots.
   
   - check if struct sys_device::root is set on registration, and add it as a child of
     an alternative root, if it's set. 

<mochel@osdl.org> (02/09/23 1.603.1.4)
   driver model: add support for CPUs.
   
   - Create struct cpu to generically describe cpus (it simply contains
     a struct sys_device in it).
   
   - Define an array of size NR_CPUS in arch/i386/kernel/cpu/common.c 
     and register each on bootup. This gives us something like:
   
   # tree -d /sys/root/sys/
   /sys/root/sys/
   |-- cpu0
   |-- pic0
   `-- rtc0
   
   and:
   
   # tree -d /sys/bus/system/devices/
   /sys/bus/system/devices/
   |-- cpu0 -> ../../../root/sys/cpu0
   
   - Define arch-specific CPU driver that's also registered on boot.
     That gives us: 
   
   # tree -d /sys/bus/system/drivers/
   /sys/bus/system/drivers/
   |-- cpu
   
   - Create a CPU device class that's registered very early. That 
     gives us all the CPUs in the system in one place:
   
   # tree -d /sys/class/cpu/
   /sys/class/cpu/
   |-- devices
   |   `-- 0 -> ../../../root/sys/cpu0
   `-- drivers
   
   Other archs are encouraged to do the same.

<mochel@osdl.org> (02/09/23 1.603.1.3)
   USB: fixup handling of generic USB driver.
   
   The generic driver is used by the virtual USB bridge device. This makes sure that
   the driver is registered before we try to use it (and it gets the bus type right).
   
   We also check for equality when matching devices to drivers, because we don't 
   want to match any device to it. 

<mochel@osdl.org> (02/09/23 1.603.1.2)
   Driver model: handle devices registered with ->driver set.
   
   In some cases, especially when dealing with system and platform devices, a 
   device's driver is known when the device is registered. We still want to add
   the device to the driver's list and add it to the class.
   
   This makes splits driver binding into probe() and attach(). If the device already
   has a driver, we simply call attach(). Otherwise, we try to match it on the bus
   and still call found_match().
   
   This requires that all drivers that are referenced are registered beforehand.

<mochel@osdl.org> (02/09/23 1.603.1.1)
   Driver model: improve support for system devices.
     
   - Create struct sys_device to describe system-level devices (CPUs, PICs, etc.). This 
     structure includes a 'name' and 'id' field for drivers to fill in with a simple
     canonical name (like 'pic' or 'floppy') and the id of the device relative to its 
     discovery in the system (it's enumerated value).
   
     The core then constructs the bus_id for the device from these, giving them meaningful
     names when exporting them to userspace:
   
   # tree -d /sys/root/sys/
   /sys/root/sys/
   |-- pic0
   `-- rtc0
   
   - Replace 
   	int register_sys_device(struct device * dev);
   	with 
   	int sys_device_register(struct sys_device * sysdev);
   
   - Fixup the users of the API.
   
   - Add a system_bus_type for devices to associate themselves with. This provides a 
     bus/system/ directory in driverfs that looks like:
   
   # tree -d /sys/bus/system/
   /sys/bus/system/
   |-- devices
   |   |-- pic0 -> ../../../root/sys/pic0
   |   `-- rtc0 -> ../../../root/sys/rtc0
   `-- drivers
       `-- pic


--346834433-1225963352-1032831926=:966
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="p4.tree"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0209231845260.966@cherise.pdx.osdl.net>
Content-Description: 
Content-Disposition: attachment; filename="p4.tree"

L3N5cy8NCnwtLSBhY3BpDQp8ICAgYC0tIEFDUEkNCnwgICAgICAgfC0tIENQ
VTANCnwgICAgICAgfC0tIENQVTENCnwgICAgICAgfC0tIEZBTg0KfCAgICAg
ICB8LS0gUFdSRg0KfCAgICAgICB8LS0gVEhSTQ0KfCAgICAgICBgLS0gX1NC
DQp8ICAgICAgICAgICB8LS0gRldIDQp8ICAgICAgICAgICB8LS0gTUVNDQp8
ICAgICAgICAgICB8LS0gUENJMA0KfCAgICAgICAgICAgfCAgIHwtLSBDT1BS
DQp8ICAgICAgICAgICB8ICAgfC0tIERNQTENCnwgICAgICAgICAgIHwgICB8
LS0gRUNQMQ0KfCAgICAgICAgICAgfCAgIHwtLSBGREMwDQp8ICAgICAgICAg
ICB8ICAgfC0tIEhVQjANCnwgICAgICAgICAgIHwgICB8LS0gSFVCQQ0KfCAg
ICAgICAgICAgfCAgIHwgICBgLS0gSFVCQg0KfCAgICAgICAgICAgfCAgIHwt
LSBIVUJDDQp8ICAgICAgICAgICB8ICAgfC0tIElDSFgNCnwgICAgICAgICAg
IHwgICB8ICAgfC0tIFBSSU0NCnwgICAgICAgICAgIHwgICB8ICAgfCAgIHwt
LSBNQVNUDQp8ICAgICAgICAgICB8ICAgfCAgIHwgICBgLS0gU0xBVg0KfCAg
ICAgICAgICAgfCAgIHwgICBgLS0gU0VDTg0KfCAgICAgICAgICAgfCAgIHwg
ICAgICAgfC0tIE1BU1QNCnwgICAgICAgICAgIHwgICB8ICAgICAgIGAtLSBT
TEFWDQp8ICAgICAgICAgICB8ICAgfC0tIElSREENCnwgICAgICAgICAgIHwg
ICB8LS0gTE5LMA0KfCAgICAgICAgICAgfCAgIHwtLSBMTksxDQp8ICAgICAg
ICAgICB8ICAgfC0tIExOS0ENCnwgICAgICAgICAgIHwgICB8LS0gTE5LQg0K
fCAgICAgICAgICAgfCAgIHwtLSBMTktDDQp8ICAgICAgICAgICB8ICAgfC0t
IExOS0QNCnwgICAgICAgICAgIHwgICB8LS0gTE5LRQ0KfCAgICAgICAgICAg
fCAgIHwtLSBMTktGDQp8ICAgICAgICAgICB8ICAgfC0tIExQVDENCnwgICAg
ICAgICAgIHwgICB8LS0gUElDDQp8ICAgICAgICAgICB8ICAgfC0tIFBTMksN
CnwgICAgICAgICAgIHwgICB8LS0gUFMyTQ0KfCAgICAgICAgICAgfCAgIHwt
LSBQWDQwDQp8ICAgICAgICAgICB8ICAgfC0tIFBYNDMNCnwgICAgICAgICAg
IHwgICB8LS0gUlRDDQp8ICAgICAgICAgICB8ICAgfC0tIFNQS1INCnwgICAg
ICAgICAgIHwgICB8LS0gU1lTUg0KfCAgICAgICAgICAgfCAgIHwtLSBUTVIN
CnwgICAgICAgICAgIHwgICB8LS0gVUFSMQ0KfCAgICAgICAgICAgfCAgIHwt
LSBVQVIyDQp8ICAgICAgICAgICB8ICAgYC0tIFVTQjANCnwgICAgICAgICAg
IGAtLSBQV1JCDQp8LS0gYnVzDQp8ICAgfC0tIGlkZQ0KfCAgIHwgICB8LS0g
ZGV2aWNlcw0KfCAgIHwgICB8ICAgfC0tIDAuMCAtPiAuLi8uLi8uLi9yb290
L3BjaTAvMDA6MWYuMS9pZGUwLzAuMA0KfCAgIHwgICB8ICAgfC0tIDAuMSAt
PiAuLi8uLi8uLi9yb290L3BjaTAvMDA6MWYuMS9pZGUwLzAuMQ0KfCAgIHwg
ICB8ICAgfC0tIDEuMCAtPiAuLi8uLi8uLi9yb290L3BjaTAvMDA6MWYuMS9p
ZGUxLzEuMA0KfCAgIHwgICB8ICAgYC0tIDEuMSAtPiAuLi8uLi8uLi9yb290
L3BjaTAvMDA6MWYuMS9pZGUxLzEuMQ0KfCAgIHwgICBgLS0gZHJpdmVycw0K
fCAgIHwtLSBwY2kNCnwgICB8ICAgfC0tIGRldmljZXMNCnwgICB8ICAgfCAg
IHwtLSAwMDowMC4wIC0+IC4uLy4uLy4uL3Jvb3QvcGNpMC8wMDowMC4wDQp8
ICAgfCAgIHwgICB8LS0gMDA6MDEuMCAtPiAuLi8uLi8uLi9yb290L3BjaTAv
MDA6MDEuMA0KfCAgIHwgICB8ICAgfC0tIDAwOjAyLjAgLT4gLi4vLi4vLi4v
cm9vdC9wY2kwLzAwOjAyLjANCnwgICB8ICAgfCAgIHwtLSAwMDoxZS4wIC0+
IC4uLy4uLy4uL3Jvb3QvcGNpMC8wMDoxZS4wDQp8ICAgfCAgIHwgICB8LS0g
MDA6MWYuMCAtPiAuLi8uLi8uLi9yb290L3BjaTAvMDA6MWYuMA0KfCAgIHwg
ICB8ICAgfC0tIDAwOjFmLjEgLT4gLi4vLi4vLi4vcm9vdC9wY2kwLzAwOjFm
LjENCnwgICB8ICAgfCAgIHwtLSAwMDoxZi4yIC0+IC4uLy4uLy4uL3Jvb3Qv
cGNpMC8wMDoxZi4yDQp8ICAgfCAgIHwgICB8LS0gMDA6MWYuMyAtPiAuLi8u
Li8uLi9yb290L3BjaTAvMDA6MWYuMw0KfCAgIHwgICB8ICAgfC0tIDAwOjFm
LjUgLT4gLi4vLi4vLi4vcm9vdC9wY2kwLzAwOjFmLjUNCnwgICB8ICAgfCAg
IHwtLSAwMTowMC4wIC0+IC4uLy4uLy4uL3Jvb3QvcGNpMC8wMDowMS4wLzAx
OjAwLjANCnwgICB8ICAgfCAgIHwtLSAwMjoxZi4wIC0+IC4uLy4uLy4uL3Jv
b3QvcGNpMC8wMDowMi4wLzAyOjFmLjANCnwgICB8ICAgfCAgIHwtLSAwMzow
MC4wIC0+IC4uLy4uLy4uL3Jvb3QvcGNpMC8wMDowMi4wLzAyOjFmLjAvMDM6
MDAuMA0KfCAgIHwgICB8ICAgYC0tIDA0OjA0LjAgLT4gLi4vLi4vLi4vcm9v
dC9wY2kwLzAwOjFlLjAvMDQ6MDQuMA0KfCAgIHwgICBgLS0gZHJpdmVycw0K
fCAgIHwgICAgICAgfC0tIEludGVsIElDSA0KfCAgIHwgICAgICAgfC0tIElu
dGVsIElDSCBKb3lzdGljaw0KfCAgIHwgICAgICAgfC0tIFBJSVggSURFDQp8
ICAgfCAgICAgICB8LS0gYWdwZ2FydA0KfCAgIHwgICAgICAgfC0tIGUxMDAN
CnwgICB8ICAgICAgIGAtLSBzZXJpYWwNCnwgICB8LS0gcGxhdGZvcm0NCnwg
ICB8ICAgfC0tIGRldmljZXMNCnwgICB8ICAgfCAgIGAtLSBmbG9wcHkwIC0+
IC4uLy4uLy4uL3Jvb3QvbGVnYWN5L2Zsb3BweTANCnwgICB8ICAgYC0tIGRy
aXZlcnMNCnwgICB8LS0gc3lzdGVtDQp8ICAgfCAgIHwtLSBkZXZpY2VzDQp8
ICAgfCAgIHwgICB8LS0gY3B1MCAtPiAuLi8uLi8uLi9yb290L3N5cy9jcHUw
DQp8ICAgfCAgIHwgICB8LS0gY3B1MSAtPiAuLi8uLi8uLi9yb290L3N5cy9j
cHUxDQp8ICAgfCAgIHwgICB8LS0gcGljMCAtPiAuLi8uLi8uLi9yb290L3N5
cy9waWMwDQp8ICAgfCAgIHwgICBgLS0gcnRjMCAtPiAuLi8uLi8uLi9yb290
L3N5cy9ydGMwDQp8ICAgfCAgIGAtLSBkcml2ZXJzDQp8ICAgfCAgICAgICB8
LS0gY3B1DQp8ICAgfCAgICAgICBgLS0gcGljDQp8ICAgYC0tIHVzYg0KfCAg
ICAgICB8LS0gZGV2aWNlcw0KfCAgICAgICBgLS0gZHJpdmVycw0KfCAgICAg
ICAgICAgfC0tIGh1Yg0KfCAgICAgICAgICAgYC0tIHVzYmZzDQp8LS0gY2xh
c3MNCnwgICB8LS0gY3B1DQp8ICAgfCAgIHwtLSBkZXZpY2VzDQp8ICAgfCAg
IHwgICB8LS0gMCAtPiAuLi8uLi8uLi9yb290L3N5cy9jcHUwDQp8ICAgfCAg
IHwgICBgLS0gMSAtPiAuLi8uLi8uLi9yb290L3N5cy9jcHUxDQp8ICAgfCAg
IGAtLSBkcml2ZXJzDQp8ICAgYC0tIGlucHV0DQp8ICAgICAgIHwtLSBkZXZp
Y2VzDQp8ICAgICAgIHwtLSBkcml2ZXJzDQp8ICAgICAgIGAtLSBtb3VzZQ0K
YC0tIHJvb3QNCiAgICB8LS0gbGVnYWN5DQogICAgfCAgIGAtLSBmbG9wcHkw
DQogICAgfC0tIHBjaTANCiAgICB8ICAgfC0tIDAwOjAwLjANCiAgICB8ICAg
fC0tIDAwOjAxLjANCiAgICB8ICAgfCAgIGAtLSAwMTowMC4wDQogICAgfCAg
IHwtLSAwMDowMi4wDQogICAgfCAgIHwgICBgLS0gMDI6MWYuMA0KICAgIHwg
ICB8ICAgICAgIGAtLSAwMzowMC4wDQogICAgfCAgIHwtLSAwMDoxZS4wDQog
ICAgfCAgIHwgICBgLS0gMDQ6MDQuMA0KICAgIHwgICB8LS0gMDA6MWYuMA0K
ICAgIHwgICB8LS0gMDA6MWYuMQ0KICAgIHwgICB8ICAgfC0tIGlkZTANCiAg
ICB8ICAgfCAgIHwgICB8LS0gMC4wDQogICAgfCAgIHwgICB8ICAgYC0tIDAu
MQ0KICAgIHwgICB8ICAgYC0tIGlkZTENCiAgICB8ICAgfCAgICAgICB8LS0g
MS4wDQogICAgfCAgIHwgICAgICAgYC0tIDEuMQ0KICAgIHwgICB8LS0gMDA6
MWYuMg0KICAgIHwgICB8LS0gMDA6MWYuMw0KICAgIHwgICBgLS0gMDA6MWYu
NQ0KICAgIGAtLSBzeXMNCiAgICAgICAgfC0tIGNwdTANCiAgICAgICAgfC0t
IGNwdTENCiAgICAgICAgfC0tIHBpYzANCiAgICAgICAgYC0tIHJ0YzANCg0K
MTM1IGRpcmVjdG9yaWVzDQo=
--346834433-1225963352-1032831926=:966--
