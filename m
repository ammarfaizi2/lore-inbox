Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261475AbUKWSR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261475AbUKWSR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:17:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261479AbUKWSQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:16:17 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:2279 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261384AbUKWSL4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:11:56 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: [2.6.10-rc2] ehci_hcd causes oops after some use of usb harddisk
Date: Tue, 23 Nov 2004 19:12:04 +0100
User-Agent: KMail/1.7.1
Cc: linux-usb-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411231912.05504.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list,

Kernel: 2.6.10-rc2

I'm trying to use an USB harddisk (IDE disk in USB2.0 enclosure) with my linux laptop. Using it at usb-1 speeds with the usb_uhci module causes no problems whatsoever.

When trying to use the drive while claimed with ehci_hcd, it will disconnect after a while, causing my connection to my disk to hang, and the entire USB subsystem with it. (removing modules is no longer possible).

This is after plugging the drive and mounting the XFS filesystem on it:

Nov 23 18:47:26 precious kernel: usb 4-3: new high speed USB device using ehci_hcd and address 2
Nov 23 18:47:27 precious kernel: scsi4 : SCSI emulation for USB Mass Storage devices
Nov 23 18:47:27 precious kernel: usb 2-1: USB disconnect, address 2
Nov 23 18:47:27 precious kernel: usb-storage: device found at 2
Nov 23 18:47:27 precious kernel: usb-storage: waiting for device to settle before scanning
Nov 23 18:47:32 precious kernel:   Vendor: MAXTOR 6  Model: L080J4            Rev: 0811
Nov 23 18:47:32 precious kernel:   Type:   Direct-Access                      ANSI SCSI revision: 00
Nov 23 18:47:32 precious kernel: SCSI device sda: 156355584 512-byte hdwr sectors (80054 MB)
Nov 23 18:47:32 precious kernel: sda: assuming drive cache: write through
Nov 23 18:47:32 precious kernel:  sda: sda1
Nov 23 18:47:32 precious kernel: Attached scsi disk sda at scsi4, channel 0, id 0, lun 0
Nov 23 18:47:32 precious kernel: Attached scsi generic sg0 at scsi4, channel 0, id 0, lun 0,  type 0
Nov 23 18:47:32 precious kernel: usb-storage: device scan complete
Nov 23 18:47:46 precious kernel: XFS mounting filesystem sda1
Nov 23 18:47:46 precious kernel: Ending clean XFS mount for filesystem: sda1

Then I copy some stuff on it. When the actual write starts (eg triggered with sync), the activity led never goes out anymore.

Shortly thereafter:

Nov 23 18:49:45 precious kernel:  offline device
Nov 23 18:49:45 precious kernel: scsi4 (0:0): rejecting I/O to offline device
Nov 23 18:49:45 precious last message repeated 343 times
Nov 23 18:49:45 precious kernel: xfs_force_shutdown(sda1,0x1) called from line 353 of file fs/xfs/xfs_rw.c.  Return address = 0xc0244e4b
Nov 23 18:49:45 precious kernel:  target4:0:0: Illegal state transition <NULL>->cancel
Nov 23 18:49:45 precious kernel: Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1717
Nov 23 18:49:45 precious kernel:  [pg0+550150217/1069249536] scsi_device_set_state+0xc9/0x130 [scsi_mod]
Nov 23 18:49:45 precious kernel:  [pg0+550129384/1069249536] scsi_device_cancel+0x28/0x126 [scsi_mod]
Nov 23 18:49:45 precious kernel:  [pg0+550129744/1069249536] scsi_device_cancel_cb+0x0/0x20 [scsi_mod]
Nov 23 18:49:46 precious kernel:  [device_for_each_child+61/112] device_for_each_child+0x3d/0x70
Nov 23 18:49:46 precious kernel:  [pg0+550129825/1069249536] scsi_host_cancel+0x31/0xc0 [scsi_mod]
Nov 23 18:49:46 precious kernel:  [pg0+550129744/1069249536] scsi_device_cancel_cb+0x0/0x20 [scsi_mod]
Nov 23 18:49:46 precious kernel:  [kobject_put+31/48] kobject_put+0x1f/0x30
Nov 23 18:49:46 precious kernel:  [kobject_put+31/48] kobject_put+0x1f/0x30
Nov 23 18:49:46 precious kernel:  [kobject_release+0/16] kobject_release+0x0/0x10
Nov 23 18:49:46 precious kernel:  [pg0+550159998/1069249536] scsi_remove_device+0x7e/0xb0 [scsi_mod]
Nov 23 18:49:46 precious kernel:  [pg0+550130001/1069249536] scsi_remove_host+0x21/0x70 [scsi_mod]
Nov 23 18:49:46 precious kernel:  [pg0+550764147/1069249536] storage_disconnect+0x83/0x9b [usb_storage]
Nov 23 18:49:46 precious kernel:  [pg0+552829238/1069249536] usb_unbind_interface+0x86/0x90 [usbcore]
Nov 23 18:49:46 precious kernel:  [device_release_driver+134/144] device_release_driver+0x86/0x90
Nov 23 18:49:46 precious kernel:  [bus_remove_device+100/176] bus_remove_device+0x64/0xb0
Nov 23 18:49:46 precious kernel:  [device_del+93/160] device_del+0x5d/0xa0
Nov 23 18:49:46 precious kernel:  [pg0+552859256/1069249536] usb_disable_device+0xb8/0x100 [usbcore]
Nov 23 18:49:46 precious kernel:  [pg0+552838870/1069249536] usb_disconnect+0xa6/0x150 [usbcore]
Nov 23 18:49:46 precious kernel:  [pg0+552843783/1069249536] hub_port_connect_change+0x3c7/0x400 [usbcore]
Nov 23 18:49:46 precious kernel:  [pg0+552833879/1069249536] clear_port_feature+0x57/0x60 [usbcore]
Nov 23 18:49:46 precious kernel:  [pg0+552844465/1069249536] hub_events+0x271/0x3c0 [usbcore]
Nov 23 18:49:46 precious kernel:  [pg0+552844853/1069249536] hub_thread+0x35/0x120 [usbcore]
Nov 23 18:49:46 precious kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60

while nothing changed to the state of the USB device...

Any hints? This is rather annoying, as I do want to be able to use this at it's full speed...

lsusb -v for the specific device:
Bus 001 Device 002: ID 05e3:0702 Genesys Logic, Inc. USB 2.0 IDE Adapter
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x05e3 Genesys Logic, Inc.
  idProduct          0x0702 USB 2.0 IDE Adapter
  bcdDevice            0.02
  iManufacturer           0 
  iProduct                1 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower               96mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk (Zip)
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0

Jan
-- 
Your business will go through a period of considerable expansion.
