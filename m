Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129331AbRBIBIx>; Thu, 8 Feb 2001 20:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129718AbRBIBIn>; Thu, 8 Feb 2001 20:08:43 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:59399 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129553AbRBIBIb>; Thu, 8 Feb 2001 20:08:31 -0500
Date: Thu, 8 Feb 2001 17:08:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux-2.4.2-pre2
Message-ID: <Pine.LNX.4.10.10102081650410.18668-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok, the patch is reasonably big, mainly due to a new architecture (cris)
and some updates to others (arm and mips).

But what's interesting here are actually three very small patches:

 - mm/memory.c (PageReserved() check): this could corrupt the shared zero
   page if you used direct IO, and thus make your system unusable
 - elevator fix (another missed re-initialization in __make_request(), and
   this time we made sure to check that everything else _is_ initialized)
 - IDE driver multi-mode write fix (ide_multwrite()).

The first would only hit you if you used raw IO (and had some unlucky
timing etc), and very few people do.

The second can cause disk corruption with pretty much any disk (seen at
least on SCSI under heavy load). Not necessarily easy to trigger, but
still..

The third can cause disk corruption on IDE disks if you are using PIO
writes with multi-mode and irq unmasking enabled.

All three are quite nasty, but not all that easy to trigger (and have been
around for ages in the 2.3.x series - which only goes to show you how
important it is to have gotten a lot of new testers). Special thanks go to
Russell King for debugging the IDE driver thing with some heroic tracing
stuff.

I'd like people to test it out a bit before I'll make a real 2.4.2
release, but the three bugs do make it clear that a 2.4.2 will have to
happen soonish. The rest of the patches are quite cosmetic in comparison
even if they are much bigger..

			Linus

----- ChangeLog -----

-pre2:
 - driver sync up with Alan
 - Andrew Morton: wakeup cleanup and race fix
 - Paul Mackerras: macintosh driver updates.
 - don't trust "page_count()" on reserved pages!
 - Russell King: fix serious IDE multimode write bug!
 - me, Jens, others: fix elevator problem
 - ARM, MIPS and cris architecture updates
 - alpha updates: better page clear/copy, avoid kernel lock in execve
 - USB and firewire updates
 - ISDN updates
 - Irda updates

-pre1:
 - XMM: don't allow illegal mxcsr values
 - ACPI: handle non-existent battery strings gracefully
 - Compaq Smart Array driver update
 - Kanoj Sarcar: serial console hardware flow control support
 - ide-cs: revert toc-valid cache checking in 2.4.1
 - Vojtech Pavlik: update via82cxxx driver to handle the vt82c686
 - raid5 graceful failure handling fix
 - ne2k-pci: enable device before asking the irq number
 - sis900 driver update
 - riva FB driver update
 - fix silly inode hashing pessimization
 - add SO_ACCEPTCONN for SuS
 - remove modinfo hack workaround, all newer modutils do it correctly
 - datagram socket shutdown fix
 - mark process as running when it takes a page-fault

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
