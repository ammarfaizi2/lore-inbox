Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262274AbVC3Pvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262274AbVC3Pvz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbVC3Pvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:51:55 -0500
Received: from ida.rowland.org ([192.131.102.52]:6660 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S262274AbVC3PvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:51:16 -0500
Date: Wed, 30 Mar 2005 10:51:13 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: kus Kusche Klaus <kus@keba.com>
cc: linux-usb-users@lists.sourceforge.net, <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] 2.6.11: Random SCSI/USB errors when reading from USB memory
 stick
In-Reply-To: <AAD6DA242BC63C488511C611BD51F3673231C0@MAILIT.keba.co.at>
Message-ID: <Pine.LNX.4.44L0.0503301036550.1327-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Mar 2005, kus Kusche Klaus wrote:

> When trying a "dd if=/dev/sda of=/dev/null" (where /dev/sda is an USB
> memory stick), this works fine for some seconds (and actually transfers
> data at around 700-1000 KB/s), but ends up with some I/O errors sooner
> or later, which cause the device to go offline (the stick must be
> replugged to make it accessible again). Sometimes, this causes kernel
> bugchecks and hung "dd" processes (which cannot be terminated even with
> kill -9), see second example.
> 
> Two examples (syslog message outputs) are appended below, in both cases,
> short USB reads seem to initiate the trouble.
> 
> I also tried running a kernel latency test program simultaneously: When
> the errors occur, the latency goes up from less than 1 millisec to about
> 15 millisec (very bad for embedded control systems...).

Latency is the subject of a separate email.  Does this increase in latency 
occur only when you see the errors, or whenever you do a large data 
transfer?  In fact, I would suspect the errors to _decrease_ the latency 
with respect to a normal transfer.

> The error occurred on an intel Pentium 3 (500 MHz) embedded system with
> 440BX chipset and 192 MB RAM. USB is handled by the 440BX (intel 82371
> PIIX4). The UHCI driver shares interrupt 7 with an intel 82559ER 100
> Mbit ethernet controller (which is driven by the e100 driver and active:
> As there is no local keyboard, I access the system by ssh). 
> 
> The system "disk" is a 128 MB CF card directly connected to the 440BX
> primary IDE port and running in PIO mode 2 at about 2 MB/sec peak (but
> it is idle most of the time). There is a SM712 VGA chip running in text
> mode, a 1000 HZ std PC timer, and no other "interesting" device (nothing
> else on the PCI bus or causing any interrupts).
> 
> The error was reproduced with statically linked (no modules)
> vanilla-2.6.11, 2.6.11-gentoo-r3, and
> realtime-preempt-2.6.12-rc1-V0.7.41-11 kernels, all built with gcc
> 3.4.3.
> 
> I tried with two different sticks (an old 64 MB USB 1.x and a 1 GB USB
> 2.x), both show the same problem on all USB interfaces on the target.
> The same dd command works fine on both sticks on my office PC. 

This indicates that the problem lies in the computer, or its USB 
connectors and their electromagnetic environment.

> I suspect some kind of timing / bus / interrupt trouble, either due to
> the interrupt shared between uhci and e100, or due to the extremely slow
> PIO transfers (which seem to block interrupts).

Timing or interrupt trouble wouldn't cause the problems you see.  Bus
utilization can cause problems, but they would be reported differently.  
I think your problem is due either to faulty hardware or to bad signal
propagation.

> What can I do to solve or further analyze the problem?

Replace the USB cable.  Use a separate PCI USB controller card, preferably 
one with a high-speed USB controller

> Thanks!
> 
> *** First example:
> 
> ... trouble starts here:
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: *** thread
> awakened.
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Command READ_10
> (10 bytes)
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:  28 00 00 01 bd c0
> 00 00 f0 00
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Bulk Command S
> 0x43425355 T 0x38e L 122880 F 128 Trg 0 LUN 0 CL 10
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:
> usb_stor_bulk_transfer_buf: xfer 31 bytes
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Status code 0;
> transferred 31/31
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: -- transfer
> complete
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage: Bulk command
> transfer result=0
> Mar 30 10:47:16 OF455 kern.debug kernel: usb-storage:
> usb_stor_bulk_transfer_sglist: xfer 122880 bytes, 30 entries
> Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: Status code -75;
> transferred 19840/122880
> Mar 30 10:47:17 OF455 kern.debug kernel: usb-storage: -- babble

This is not a "short read"; as the log says, it's a "babble".  That means
the computer's USB controller believed the device continued transmitting
past the time when it was supposed to stop.  Assuming the device is
functioning correctly, either the USB controller is bad or the signal was
degraded.

> *** Second example, by far more dramatic:
> 
> ... again, the first noticeable error is a short data read...
> 
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: *** thread
> awakened.
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Command READ_10
> (10 bytes)
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:  28 00 00 01 ba c0
> 00 00 f0 00
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk Command S
> 0x43425355 T 0x386 L 122880 F 128 Trg 0 LUN 0 CL 12
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
> usb_stor_bulk_transfer_buf: xfer 31 bytes
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Status code 0;
> transferred 31/31
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- transfer
> complete
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Bulk command
> transfer result=0
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage:
> usb_stor_bulk_transfer_sglist: xfer 122880 bytes, 2 entries
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: Status code -75;
> transferred 82240/122880
> Mar 30 11:01:45 OF455 kern.debug kernel: usb-storage: -- babble

> ... now, it disables the old device, but immediately autodetects a new
> one
> ... (I have *not* touched the stick!)

Some devices do that at times.  They apparently get so confused they 
disconnect themselves electronically from the USB bus and then reconnect.

> ... and then crashes

> Mar 30 11:02:15 OF455 kern.debug kernel: usb-storage: bus_reset called
> Mar 30 11:02:15 OF455 kern.alert kernel: BUG: Unable to handle kernel
> paging request at virtual address 80000101

This crash is a problem in the SCSI core.  The very latest version of 
usb-storage (which may or may not be available yet in a -mm tree) contains 
a workaround.

Alan Stern

