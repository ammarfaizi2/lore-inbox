Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264848AbTFCI4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 04:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264849AbTFCI4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 04:56:54 -0400
Received: from ns.suse.de ([213.95.15.193]:22794 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264848AbTFCI4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 04:56:51 -0400
Date: Tue, 3 Jun 2003 11:10:18 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Counter-kludge for 2.5.x hanging when writing to block device
Message-ID: <20030603091018.GI482@suse.de>
References: <200306030848.h538mwE22282@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306030848.h538mwE22282@freya.yggdrasil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03 2003, Adam J. Richter wrote:
> 	For at least the past few months, the Linux 2.5 kernels have
> hung when I try to write a large amount of data to a block device.
> I most commonly notice this when trying to clear a disk with a command
> like "dd if=/dev/zero of=/dev/discs/disc1/disc".  Sometimes doing
> an mkfs on a big file system is enough to cause the hang.
> I wrote a little program to repeatedly write a 4kB block of zeroes
> to the kernel so I could track how far it got before hanging, and it
> would write 210-215MB of zeroes to the disk on a computer that had
> 512MB of RAM before hanging.  When these hangs occur, other processes
> continue to run fine, and I can do syncs, which return, but the
> hung process never resumes.  In the past, I've verified with a
> printk that it is looping in balance_dirty_pages, repeatedly
> calling blk_congestion_wait, and never leaving the loop.
> 
> 	Here is a counter-kludge that seems to stop the problem.
> This is certainly not the "right" fix.  It just illustrates a way
> to stop the problem.
> 
> 	By the way, I say "counter-kludge", because I get the impression
> that blk_congestion_wait is itself a kludge, since it calls
> blk_run_queues and waits a fixed amount of time, 100ms in this case,
> potentially a big waste of time, rather than awaiting some more
> accurate criterion.

Does something like this work? Andrew, what's the point of doing the
wait if the queue isn't congested?! I haven't even checked if this gets
the job done, I think it would be cleaner to pass in the backing dev
info to blk_congestion_wait so we can make the decision in there.

===== mm/page-writeback.c 1.66 vs edited =====
--- 1.66/mm/page-writeback.c	Sun Jun  1 23:12:47 2003
+++ edited/mm/page-writeback.c	Tue Jun  3 11:09:13 2003
@@ -152,6 +152,7 @@
 			.sync_mode	= WB_SYNC_NONE,
 			.older_than_this = NULL,
 			.nr_to_write	= write_chunk,
+			.encountered_congestion = 0,
 		};
 
 		get_dirty_limits(&ps, &background_thresh, &dirty_thresh);
@@ -178,7 +179,8 @@
 			if (pages_written >= write_chunk)
 				break;		/* We've done our duty */
 		}
-		blk_congestion_wait(WRITE, HZ/10);
+		if (wbc.encountered_congestion)
+			blk_congestion_wait(WRITE, HZ/10);
 	}
 
 	if (nr_reclaimable + ps.nr_writeback <= dirty_thresh)

-- 
Jens Axboe

