Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbSLNBR7>; Fri, 13 Dec 2002 20:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbSLNBR7>; Fri, 13 Dec 2002 20:17:59 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37125 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S267482AbSLNBR4>;
	Fri, 13 Dec 2002 20:17:56 -0500
Date: Fri, 13 Dec 2002 17:23:54 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@transmeta.com
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [BK PATCH] USB changes for 2.5.51
Message-ID: <20021214012354.GG30093@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This also includes a fix in the driver core hotplug call.

Please pull from:  bk://linuxusb.bkbits.net/linus-2.5

thanks,

greg k-h


 drivers/base/hotplug.c             |    7 
 drivers/usb/class/Kconfig          |    5 
 drivers/usb/class/usblp.c          |   24 ++-
 drivers/usb/core/hub.c             |   32 +++-
 drivers/usb/core/usb.c             |   35 ++++
 drivers/usb/image/scanner.c        |   45 ++----
 drivers/usb/image/scanner.h        |    4 
 drivers/usb/net/pegasus.c          |   31 +++-
 drivers/usb/serial/Makefile        |    2 
 drivers/usb/serial/bus.c           |  138 ++++++++++++++++++
 drivers/usb/serial/usb-serial.c    |  275 ++++++++++++++++++++-----------------
 drivers/usb/serial/usb-serial.h    |   14 +
 drivers/usb/storage/unusual_devs.h |   16 +-
 drivers/usb/usb-skeleton.c         |  128 ++++++-----------
 include/linux/usb.h                |    3 
 sound/usb/usbaudio.c               |    4 
 16 files changed, 491 insertions(+), 272 deletions(-)
-----

ChangeSet@1.877, 2002-12-13 13:52:12-08:00, petkan@users.sourceforge.net
  [PATCH] USB: pegasus kmalloc/kfree stuff
  
  I made the changes to the set/get_registers code.

 drivers/usb/net/pegasus.c |   31 +++++++++++++++++++++++++------
 1 files changed, 25 insertions(+), 6 deletions(-)
------

ChangeSet@1.876, 2002-12-12 14:49:26-08:00, greg@kroah.com
  [PATCH] USB: usb-skeleton: removed static array of devices.
  
  This allowed a lock to be removed.
  Also removed the MOD_* functions, and some remove logic was cleaned
  up by Oliver Neukum.

 drivers/usb/usb-skeleton.c |   94 +++++++++++++--------------------------------
 1 files changed, 29 insertions(+), 65 deletions(-)
------

ChangeSet@1.875, 2002-12-12 14:25:55-08:00, greg@kroah.com
  [PATCH] USB: Fix compile errors with usb-skeleton driver.
  

 drivers/usb/usb-skeleton.c |   34 +++++++++++++++++-----------------
 1 files changed, 17 insertions(+), 17 deletions(-)
------

ChangeSet@1.874, 2002-12-12 13:23:14-08:00, nobita@t-online.de
  [PATCH] support for Sony Cybershot F717 digital camera / usb-storage
  
  here is an id-patch to get the Sony Cybershot F717 6meg pixel digital
  camera working with the standard usb-storage device driver.

 drivers/usb/storage/unusual_devs.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.872, 2002-12-12 12:39:31-08:00, khaho@koti.soon.fi
  [PATCH] USB: start to remove static minor based arrays in drivers
  
  Here are minimal usb_find_interface() patches for the core, usblp and
  scanner.
  
  Basic design is:
  - device major (USB_MAJOR for now) and minor are stored in probe()
     function to struct usb_interface as kdev_t
  - open() can use new core function usb_find_interface() to find matching
    device in drivers device list
  - disconnect() will set kdev_t struct usb_interface to NODEV, so open
    wont open it anymore without new probe()
  
  I tested these patches and they work for me. I will work on small patches
  of other work in these drivers (like removal of lock_kernel/unlock_kernel
  in usblp, fixing the disconnect problems in both drivers etc.). Those
  patches would be very small too, but there will be quite many.

 drivers/usb/class/usblp.c   |   24 ++++++++++++++---------
 drivers/usb/core/usb.c      |   35 ++++++++++++++++++++++++++++++++++
 drivers/usb/image/scanner.c |   45 +++++++++++++++-----------------------------
 drivers/usb/image/scanner.h |    4 ---
 include/linux/usb.h         |    3 ++
 5 files changed, 70 insertions(+), 41 deletions(-)
------

ChangeSet@1.871, 2002-12-12 12:36:38-08:00, greg@kroah.com
  [PATCH] usbaudio.c: fix for urb callback function change
  

 sound/usb/usbaudio.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)
------

ChangeSet@1.870, 2002-12-12 11:58:03-08:00, greg@kroah.com
  [PATCH] USB: Moved usb-serial bus specific code to a separate file.
  

 drivers/usb/serial/Makefile     |    2 
 drivers/usb/serial/bus.c        |  138 ++++++++++++++++++++++++++++++++++++++++
 drivers/usb/serial/usb-serial.c |  130 +++++--------------------------------
 drivers/usb/serial/usb-serial.h |    5 +
 4 files changed, 162 insertions(+), 113 deletions(-)
------

ChangeSet@1.869, 2002-12-12 09:38:05-08:00, greg@kroah.com
  [PATCH] Driver core: Fix class leak in class_hotplug.
  
  Thanks to Pat Mochel for pointing this out to me.

 drivers/base/hotplug.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)
------

ChangeSet@1.865.1.1, 2002-12-11 16:11:32+01:00, marcel@holtmann.org
  [PATCH] Disable bluetty.o if Bluetooth subsystem is used
  
  This patch disables the USB Bluetooth TTY driver (bluetty.o) from
  the drivers/usb/class directory if the Linux Bluetooth subsystem
  is selected.

 drivers/usb/class/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)
------

ChangeSet@1.868, 2002-12-10 17:02:12-08:00, greg@kroah.com
  [PATCH] USB: Added usb-serial driver core bus support.
  
  This means that all individual usb-serial ports show up as their
  own devices in the driver model tree.

 drivers/usb/serial/usb-serial.c |  145 ++++++++++++++++++++++++++++++++++++----
 drivers/usb/serial/usb-serial.h |    9 ++
 2 files changed, 139 insertions(+), 15 deletions(-)
------

ChangeSet@1.867, 2002-12-10 15:05:29-08:00, marekm@amelek.gda.pl
  [PATCH] Datafab KECF-USB / Sagatek DCS-CF / Simpletech UCF-100
  
  sorry to bother you again - now that 2.4.20 is out, is there any
  chance to include this in 2.4.21?  I've been trying since 2.4.19,
  a few other UNUSUAL_DEV entries were added, but not this one...
  
  The device works fine with the patch (and doesn't work at all without
  it) for me and a few other people (devices with different "marketing"
  names, the same vendor:device id), no one has reported any problems.
  The patch has been in the 2.4-ac tree for a while, too.

 drivers/usb/storage/unusual_devs.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)
------

ChangeSet@1.866, 2002-12-10 14:18:40-08:00, zaitcev@redhat.com
  [PATCH] Patch for debounce in 2.5
  
  I was getting annoyed that nobody fixed the obviously broken
  debounce loop, so I had to go ahead and fix that.

 drivers/usb/core/hub.c |   32 +++++++++++++++++++++++---------
 1 files changed, 23 insertions(+), 9 deletions(-)
------

