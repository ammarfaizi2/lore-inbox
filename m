Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261571AbUKWULO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261571AbUKWULO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 15:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbUKWUK4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 15:10:56 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:47559 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261490AbUKWUF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 15:05:58 -0500
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [2.6.10-rc2] ehci_hcd causes oops after some use of usb harddisk
Date: Tue, 23 Nov 2004 12:03:40 -0800
User-Agent: KMail/1.7.1
Cc: Jan De Luyck <lkml@kcore.org>, linux-kernel@vger.kernel.org,
       linux-usb-users@lists.sourceforge.net
References: <200411231912.05504.lkml@kcore.org>
In-Reply-To: <200411231912.05504.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411231203.41184.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 23 November 2004 10:12, Jan De Luyck cross-posted to the world:
> 
> Nov 23 18:49:45 precious kernel:  offline device
> Nov 23 18:49:45 precious kernel: scsi4 (0:0): rejecting I/O to offline device
> Nov 23 18:49:45 precious last message repeated 343 times
> Nov 23 18:49:45 precious kernel: xfs_force_shutdown(sda1,0x1) called from line 353 of file fs/xfs/xfs_rw.c.  Return address = 0xc0244e4b
> Nov 23 18:49:45 precious kernel:  target4:0:0: Illegal state transition <NULL>->cancel
> Nov 23 18:49:45 precious kernel: Badness in scsi_device_set_state at drivers/scsi/scsi_lib.c:1717
> Nov 23 18:49:45 precious kernel:  [pg0+550150217/1069249536] scsi_device_set_state+0xc9/0x130 [scsi_mod]
> Nov 23 18:49:45 precious kernel:  [pg0+550129384/1069249536] scsi_device_cancel+0x28/0x126 [scsi_mod]
> Nov 23 18:49:45 precious kernel:  [pg0+550129744/1069249536] scsi_device_cancel_cb+0x0/0x20 [scsi_mod]
> Nov 23 18:49:46 precious kernel:  [device_for_each_child+61/112] device_for_each_child+0x3d/0x70
> Nov 23 18:49:46 precious kernel:  [pg0+550129825/1069249536] scsi_host_cancel+0x31/0xc0 [scsi_mod]
> Nov 23 18:49:46 precious kernel:  [pg0+550129744/1069249536] scsi_device_cancel_cb+0x0/0x20 [scsi_mod]
> Nov 23 18:49:46 precious kernel:  [kobject_put+31/48] kobject_put+0x1f/0x30
> Nov 23 18:49:46 precious kernel:  [kobject_put+31/48] kobject_put+0x1f/0x30
> Nov 23 18:49:46 precious kernel:  [kobject_release+0/16] kobject_release+0x0/0x10
> Nov 23 18:49:46 precious kernel:  [pg0+550159998/1069249536] scsi_remove_device+0x7e/0xb0 [scsi_mod]
> Nov 23 18:49:46 precious kernel:  [pg0+550130001/1069249536] scsi_remove_host+0x21/0x70 [scsi_mod]
> Nov 23 18:49:46 precious kernel:  [pg0+550764147/1069249536] storage_disconnect+0x83/0x9b [usb_storage]
> Nov 23 18:49:46 precious kernel:  [pg0+552829238/1069249536] usb_unbind_interface+0x86/0x90 [usbcore]
> Nov 23 18:49:46 precious kernel:  [device_release_driver+134/144] device_release_driver+0x86/0x90
> Nov 23 18:49:46 precious kernel:  [bus_remove_device+100/176] bus_remove_device+0x64/0xb0
> Nov 23 18:49:46 precious kernel:  [device_del+93/160] device_del+0x5d/0xa0
> Nov 23 18:49:46 precious kernel:  [pg0+552859256/1069249536] usb_disable_device+0xb8/0x100 [usbcore]
> Nov 23 18:49:46 precious kernel:  [pg0+552838870/1069249536] usb_disconnect+0xa6/0x150 [usbcore]
> Nov 23 18:49:46 precious kernel:  [pg0+552843783/1069249536] hub_port_connect_change+0x3c7/0x400 [usbcore]
> Nov 23 18:49:46 precious kernel:  [pg0+552833879/1069249536] clear_port_feature+0x57/0x60 [usbcore]
> Nov 23 18:49:46 precious kernel:  [pg0+552844465/1069249536] hub_events+0x271/0x3c0 [usbcore]
> Nov 23 18:49:46 precious kernel:  [pg0+552844853/1069249536] hub_thread+0x35/0x120 [usbcore]
> Nov 23 18:49:46 precious kernel:  [autoremove_wake_function+0/96] autoremove_wake_function+0x0/0x60

That would be a bug in the SCSI code; I think I've seen a patch
for that get merged into more recent BK trees ...


> while nothing changed to the state of the USB device...

Clearly not true ... the device got disconnected.  That's the
only issue here that's _possibly_ related to the ehci_hcd driver.

Never having seen that particular failure mode myself, all I
can do is say "gee, that's odd".  It actually looks more like
the device is spontaneously disconnecting itself (some other
folk report the same issue) than that Linux does anything to
provoke it into such a snit fit.  Are you sure you didn't get
messages about something like an overcurrent event on that port?


> Any hints? This is rather annoying, as I do want to be able
> to use this at it's full speed... 

"Full speed" is 12 Mbit/second.  "High speed" is 480 Mbit/sec.  :)
 
> lsusb -v for the specific device:
> Bus 001 Device 002: ID 05e3:0702 Genesys Logic, Inc. USB 2.0 IDE Adapter
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0        64
>   idVendor           0x05e3 Genesys Logic, Inc.
>   idProduct          0x0702 USB 2.0 IDE Adapter

... those GeneSys devices have been sufficiently problematic that I,
for one, won't investigate bug reports involving them any more.  The
devices have several problems where they lock up when Linux does
perfectly legal things.  Avoid them.

- Dave
