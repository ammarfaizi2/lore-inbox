Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbVGENm6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbVGENm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 09:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVGENm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 09:42:58 -0400
Received: from iolanthe.rowland.org ([192.131.102.54]:37506 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP id S261850AbVGENlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 09:41:18 -0400
Date: Tue, 5 Jul 2005 09:41:14 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: "Roberts-Thomson, James" <James.Roberts-Thomson@NBNZ.CO.NZ>
cc: Stefano Rivoir <s.rivoir@gts.it>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Kernel unable to read partition table on USB
 Memory Key
In-Reply-To: <40BC5D4C2DD333449FBDE8AE961E0C334F9364@psexc03.nbnz.co.nz>
Message-ID: <Pine.LNX.4.44L0.0507050932140.5031-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jul 2005, Roberts-Thomson, James wrote:

> Hi,
> 
> I'm trying to diagnose an issue with a USB "Memory Key" (128Mb Flash drive)
> on my workstation (i386 Linux 2.6.12 kernel, using udev 058).
> 
> When connecting the key, the kernel fails to read the partition table, and
> therefore the block device /dev/sda1 isn't created, so I can't mount the
> volume.  Calling "fdisk" manually, however, makes it all work.

You don't even have to call fdisk.  Probably "touch /dev/sda" would be 
enough.

> When I plug the device into the USB port, the kernel prints the following:
> 
> Jul  5 16:18:38 pc196344 kernel: usb 1-6: new high speed USB device using
> ehci_hcd and address 3
> Jul  5 16:18:39 pc196344 kernel: Initializing USB Mass Storage driver...
> Jul  5 16:18:39 pc196344 kernel: scsi2 : SCSI emulation for USB Mass Storage
> devices
> Jul  5 16:18:39 pc196344 kernel: usbcore: registered new driver usb-storage
> Jul  5 16:18:39 pc196344 kernel: USB Mass Storage support registered.
> Jul  5 16:18:39 pc196344 kernel: usb-storage: device found at 3
> Jul  5 16:18:39 pc196344 kernel: usb-storage: waiting for device to settle
> before scanning
> Jul  5 16:18:44 pc196344 kernel:   Vendor: OTi       Model: Flash Disk
> Rev: 2.00
> Jul  5 16:18:44 pc196344 kernel:   Type:   Direct-Access
> ANSI SCSI revision: 02
> Jul  5 16:18:44 pc196344 kernel: Attached scsi generic sg1 at scsi2, channel
> 0, id 0, lun 0,  type 0
> Jul  5 16:18:44 pc196344 kernel: usb-storage: device scan complete
> Jul  5 16:18:44 pc196344 scsi.agent[12708]: disk at
> /devices/pci0000:00/0000:00:1d.7/usb1/1-6/1-6:1.0/host2/target2:0:0/2:0:0:0
> Jul  5 16:18:44 pc196344 kernel: sda: Unit Not Ready, sense:
> Jul  5 16:18:44 pc196344 kernel: : Current: sense key: Unit Attention
> Jul  5 16:18:44 pc196344 kernel:     Additional sense: Not ready to ready
> change, medium may have changed
> Jul  5 16:18:44 pc196344 kernel: sda : READ CAPACITY failed.
> Jul  5 16:18:44 pc196344 kernel: sda : status=1, message=00, host=0,
> driver=08
> Jul  5 16:18:44 pc196344 kernel: sd: Current: sense key: Unit Attention
> Jul  5 16:18:44 pc196344 kernel:     Additional sense: Not ready to ready
> change, medium may have changed

<snip>

> Clearly, something isn't right here, and the kernel is unable to read block
> 0 (the parition table).  I've tried using the "delay_use" parameter to the
> usb-storage module to increase the delay time to 10 seconds, but still no
> difference.

The device is not supposed to send the "Unit Attention, Not ready to ready
change" message more than once.  It's violating the SCSI protocol by doing 
so.  (In fact it's not supposed to send that message at all; it's 
supposed to send "Power on or reset".)

> If I run "fdisk /dev/sda" however, then the kernel realises there is a
> partition table and it all just works, thus:

For some reason, the device stopped sending that error code and started 
working.

> In the case above, I'd not done anything inside fdisk apart from "q" to
> exit.  
> 
> However, I have tried reparitioning the device; using "dd if=/dev/zero
> of=/dev/sda bs=512 count=1" to zero the partition table and recreate;
> returning the device to the vendor and getting another one - no difference
> at all.

What's stored in the partition table won't matter because the kernel isn't
able to read it in the first place.  Replacing the device won't help,
because the device is behaving as designed and the design is broken.

> The key itself is a NZ vendor "own-name" rebadge, made in Taiwan.  According
> to the vendor's (Dick Smith Electronics, if anyone is interested) website,
> <http://www.dse.co.nz/cgi-bin/dse.storefront/42ca0f440021d23e273fc0a87f9906a
> 8/Product/View/XH8250> the product is based on an "OTi-2168 USB2.0 mass
> storage class controller".

> My previous USB-Key (an IBM 32Mb device which developed a memory "hole" and
> died) worked fine.  This new key also fails to work in a colleagues Fedora
> Core 2 2.4.x kernel machine which much the same issue.  It "just works" when
> used in Windows XP.
> 
> Any help highly valued at this point, and a direct "cc" on any reply would
> also be appreciated.

What might help would be a direct comparison of the commands being sent by 
Linux and by Windows.  If you turn on USB Mass Storage verbose debugging 
(CONFIG_USB_STORAGE_DEBUG) in the kernel configuration then the system 
debugging log will contain the commands sent by usb-storage.  You can use 
a USB sniffer program like USB Snoop (available from Sourceforge) to 
record the commands sent by Windows.  Perhaps looking over the two logs 
will reveal what magic command the device is waiting for.

Alan Stern

