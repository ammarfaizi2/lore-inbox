Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264688AbTFCIfC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:35:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264736AbTFCIfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:35:02 -0400
Received: from h-64-105-35-63.SNVACAID.covad.net ([64.105.35.63]:4739 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP id S264688AbTFCIfB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:35:01 -0400
Date: Tue, 3 Jun 2003 01:48:58 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200306030848.h538mwE22282@freya.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Counter-kludge for 2.5.x hanging when writing to block device
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	For at least the past few months, the Linux 2.5 kernels have
hung when I try to write a large amount of data to a block device.
I most commonly notice this when trying to clear a disk with a command
like "dd if=/dev/zero of=/dev/discs/disc1/disc".  Sometimes doing
an mkfs on a big file system is enough to cause the hang.
I wrote a little program to repeatedly write a 4kB block of zeroes
to the kernel so I could track how far it got before hanging, and it
would write 210-215MB of zeroes to the disk on a computer that had
512MB of RAM before hanging.  When these hangs occur, other processes
continue to run fine, and I can do syncs, which return, but the
hung process never resumes.  In the past, I've verified with a
printk that it is looping in balance_dirty_pages, repeatedly
calling blk_congestion_wait, and never leaving the loop.

	Here is a counter-kludge that seems to stop the problem.
This is certainly not the "right" fix.  It just illustrates a way
to stop the problem.

	By the way, I say "counter-kludge", because I get the impression
that blk_congestion_wait is itself a kludge, since it calls
blk_run_queues and waits a fixed amount of time, 100ms in this case,
potentially a big waste of time, rather than awaiting some more
accurate criterion.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."


--- linux-2.5.70-bk7/mm/page-writeback.c	2003-06-02 14:02:39.000000000 -0700
+++ linux/mm/page-writeback.c	2003-06-02 13:59:31.000000000 -0700
@@ -177,7 +177,12 @@
 			if (pages_written >= write_chunk)
 				break;		/* We've done our duty */
 		}
+#if 0				/* AJR */
 		blk_congestion_wait(WRITE, HZ/10);
+#else
+		blk_run_queues();
+		break;
+#endif
 	}
 
 	if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)
