Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbTKBEDq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 23:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261397AbTKBEDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 23:03:46 -0500
Received: from ginger.lcs.mit.edu ([18.26.0.82]:45828 "EHLO ginger.lcs.mit.edu")
	by vger.kernel.org with ESMTP id S261368AbTKBEDn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 23:03:43 -0500
Message-Id: <200311020403.hA243XWB025951@ginger.lcs.mit.edu>
From: Tim Shepard <shep@alum.mit.edu>
To: linux-usb-devel@lists.sourceforge.net
cc: linux-kernel@vger.kernel.org
Subject: (2.6.0-test9) usb_storage/uhci_hcd much slower write than linux-2.4
Date: Sat, 01 Nov 2003 23:03:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a 160 GB USB 2.0 drive which I plug into my two identical
laptops for purposes of doing file system backups (runs overnight).
The laptops unfortunately only have USB 1.1 interfaces, but it has
been fast enough for doing the backups when running linux-2.4.

I now have one laptop running linux-2.6.0-test9, and have found that
the write speed is more than 5 times slower than it is under 2.4
kernels (linux-2.4.21-rc1 in particular, but earlier 2.4 kernels as
well).  This is no longer fast enough.  My full backup (using dump)
which could complete in about 5 hours under linux-2.4 now would take
more than 25 hours under linux-2.6, so I now have to reboot into
linux-2.4 to do an overnight full backup.

But reads are a little bit faster under linux-2.6.  Reads from the
USB drive (of a big file that has not been read since rebooting) are
about 1.33 times faster under linux-2.6.0-test9 than under
linux-2.4.


uhci_hcd and usb_storage are the relevant modules in linux-2.6.0-test9.
usb-uhci and usb-storage are the relevant modules in linux-2.4.21-rc1.

I'm seeing 147,000 bytes/sec write speed under linux-2.6.0-test9.
I'm seeing 774,000 bytes/sec write speed under linux-2.4.21-rc1.

The write speeds which I measured are to a new file in an ext3 file
system (which spans the entire 160 GB usb drive), and I included the
time to do a sync (since it takes almost no time to write a file that
fits in memory), e.g.:

   $ mkdir /usb_drive/tmp
   $ sync
   $ time dd if=/dev/zero bs=4k count=8192 of=/usb_drive/tmp/tmp && time sync
   8192+0 records in
   8192+0 records out
   33554432 bytes transferred in 0.730587 seconds (45928043 bytes/sec)
   
   real    0m1.155s
   user    0m0.013s
   sys     0m0.580s
   
   real    3m46.462s
   user    0m0.001s
   sys     0m0.004s
   $ dc
   4096 8192 * p
   33554432
   1.155  3 60 * 46.462 + + p
   227.617
   / p
   147416


(that is 147,000 bytes/sec)

The relevant output from lspci -v is:

  00:05.0 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ISA (rev 02)
	  Flags: bus master, medium devsel, latency 0
  
  00:05.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-if 80 [Master])
	  Flags: bus master, medium devsel, latency 64
	  I/O ports at 1000 [size=16]
  
  00:05.2 USB Controller: Intel Corp. 82371AB/EB/MB PIIX4 USB (rev 01) (prog-if 00 [UHCI])
	  Flags: bus master, medium devsel, latency 64, IRQ 11
	  I/O ports at ffe0 [size=32]
  
  00:05.3 Bridge: Intel Corp. 82371AB/EB/MB PIIX4 ACPI (rev 02)
	  Flags: medium devsel, IRQ 9


Has anyone else noticed that their writes to usb_storage over USB 1.1
are much slower since upgrading to a linux-2.6.0-test* kernel?

Anyone have any ideas how I might be able to recover the (somewhat)
faster write speed while running a linux-2.6.0-test* kernel?

			-Tim Shepard
