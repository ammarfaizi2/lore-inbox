Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312994AbSC0LzW>; Wed, 27 Mar 2002 06:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312995AbSC0LzN>; Wed, 27 Mar 2002 06:55:13 -0500
Received: from coppermount.upnet.ru ([195.161.15.100]:53386 "HELO
	coppermount.upnet.ru") by vger.kernel.org with SMTP
	id <S312994AbSC0LzD>; Wed, 27 Mar 2002 06:55:03 -0500
Date: Wed, 27 Mar 2002 16:56:27 +0500
From: berk <berk@madfire.net>
X-Mailer: The Bat! (v1.49)
Reply-To: berk <berk@madfire.net>
Organization: kraft
X-Priority: 3 (Normal)
Message-ID: <309870813.20020327165627@madfire.net>
To: linux-kernel@vger.kernel.org
CC: torvalds@transmeta.com
Subject: [PATCH] Easydisk support for 2.4.9+ kernels
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dunno if this is already patched or not.. i'm not too much inet guy..
but just in case its needed by someone, here goes USB EasyDisk patch
for kernel USB support (my kernel is 2.4.9-13 and works fine with it).

The patch:
==== cut here: easydisk-2.4.9-13.patch ====
--- drivers/usb/storage/unusual_devs.h.old      Tue Mar 26 13:39:18 2002
+++ drivers/usb/storage/unusual_devs.h  Tue Mar 26 15:31:55 2002
@@ -413,3 +413,10 @@
                 US_SC_ISD200, US_PR_BULK, isd200_Initialization,
                 0 ),
 #endif
+
+/* EasyDisk support. Submitted by Stanislav Karchebny <berk@madfire.net> */
+UNUSUAL_DEV(  0x1065, 0x2136, 0x0000, 0x0001,
+                "Global Channel Solutions",
+                "EasyDisk EDxxxx",
+                US_SC_SCSI, US_PR_BULK, NULL,
+                US_FL_MODE_XLATE | US_FL_START_STOP | US_FL_FIX_INQUIRY),
==== cut here: easydisk-2.4.9-13.patch ====


The story behind:

My experiences with EasyDisk under Linux.

After I figured out how to connect EasyDisk to Linux, it all seems very easy.
But heh... I spent 4 hours trying until I caught it!

1. Kernel configuration.

I use 2.4.9-13 kernel, and it worked fine. Later kernels should work also.
I presume kernels down to 2.4.? should work fine also.
All you need in kernel is USB support and SCSI support.

When configuring kernel, answer 'Y' or 'M' to the following options:
(these screens presume you are doing 'make menuconfig', in case of text-only
or X configuration, they might seem a bit different but the options names 
are exactly the same).

$ make menuconfig

SCSI Support  --->
   - [Y/M] SCSI support
      - [Y/M] SCSI disk support

If you don't have SCSI disks or other hardware, that should be enough.
Otherwise, add support for your hardware as usual.

USB support  --->
   - [Y/M] Support for USB
   --- USB Controllers <- choose support for your controller
      Read docs, if completely unsure, select them all, 
      the kernel will figure out the right one.
      This is OHCI for my AMD Viper chipset...
      (In 99% cases it will be UHCI for Intel chipsets)
   --- USB Device Class Drivers
   [Y/M] USB Mass Storage Support
   You don't have to enable support for any of the devices listed under this
   item. They have nothing to do with EasyDisk anyway...
   
Now, exit and save your configuration. If you chosen all of the above options
as a Module, you won't need to rebuild your kernel, just build modules.

Now its time to patch the USB driver.
Copy included easydisk-2.4.9-13.patch to the Linux kernel source root,
e.g. in /usr/src/linux-2.4

$ cp easydisk-2.4.9-13.patch /usr/src/linux-2.4

Now say

$ cd /usr/src/linux-2.4
$ patch -p0 < easydisk-2.4.9-13.patch

This adds EasyDisk support to the kernel USB code.

Now do

$ make modules
$ make modules_install

(This presumes you selected the above config options as modules.
If you didn't, then your should do complete kernel rebuild/install/reboot
process.)

Now unplug and plug back your EasyDisk.
Look in /var/log/messages for a following lines:

Mar 26 15:33:29 rage kernel: hub.c: USB new device connect on bus1/1, assigned device number 9
Mar 26 15:33:32 rage kernel: usb_control/bulk_msg: timeout
Mar 26 15:33:32 rage kernel: Manufacturer: CCYU TECHNOLOGY
Mar 26 15:33:32 rage kernel: Product: EasyDisk Portable Device
Mar 26 15:33:32 rage kernel: SerialNumber: 20131576
Mar 26 15:33:32 rage kernel: usb.c: USB device 9 (vend/prod 0x1065/0x2136) is not claimed by any active driver.
[easydisk usb parameters skipped]
Mar 26 15:33:32 rage /sbin/hotplug: arguments (usb) env (PWD=/etc/hotplug HOSTNAME=rage DEVICE=/proc/bus/usb/001/009 INTERFACE=8/6/80 ACTION=add DEBUG=kernel MACHTYPE=i386-asplinux-linux-gnu OLDPWD=/ DEVFS=/proc/bus/usb TYPE=0/0/0 SHLVL=1 SHELL=/bin/bash HOSTTYPE=i386 OSTYPE=linux-gnu HOME=/ TERM=dumb PATH=/bin:/sbin:/usr/sbin:/usr/bin PRODUCT=1065/2136/1 _=/usr/bin/env)
Mar 26 15:33:32 rage /sbin/hotplug: invoke /etc/hotplug/usb.agent ()
Mar 26 15:33:33 rage /etc/hotplug/usb.agent: Modprobe and setup usb-storage for USB product 1065/2136/1
Mar 26 15:33:33 rage kernel: Initializing USB Mass Storage driver...
Mar 26 15:33:33 rage kernel: usb.c: registered new driver usb-storage
Mar 26 15:33:33 rage kernel: scsi0 : SCSI emulation for USB Mass Storage devices
Mar 26 15:33:33 rage kernel:   Vendor: Global C  Model: EasyDisk EDxxxx   Rev: 0001
Mar 26 15:33:33 rage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Mar 26 15:33:33 rage kernel: Attached scsi removable disk sda at scsi0, channel 0, id 0, lun 0
Mar 26 15:33:33 rage kernel: SCSI device sda: 127042 512-byte hdwr sectors (65 MB)
Mar 26 15:33:33 rage kernel: sda: test WP failed, assume Write Enabled
Mar 26 15:33:33 rage kernel:  /dev/scsi/host0/bus0/target0/lun0:<7>usb-storage: queuecommand() called
Mar 26 15:33:33 rage kernel:  p1 p2 p3 p4
Mar 26 15:33:33 rage kernel: USB Mass Storage support registered.

Now you are happy EasyDisk Linux user! =)
You can mount your EasyDisk using device name /dev/sda.

$ mkdir -p /mnt/ed
$ mount /dev/sda /mnt/ed

-- 
madly deep diver


