Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267160AbTA0LVD>; Mon, 27 Jan 2003 06:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267162AbTA0LVD>; Mon, 27 Jan 2003 06:21:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:64411 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S267160AbTA0LVB>;
	Mon, 27 Jan 2003 06:21:01 -0500
Date: Mon, 27 Jan 2003 12:30:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>,
       Andrea Arcangeli <andrea@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Solved 2.4.21-pre3aa1 and RAID-0 issue (was: Re: 2.4.21-pre3aa1 and RAID0 issue]
Message-ID: <20030127113002.GB889@suse.de>
References: <200212270856.13419.harisri@bigpond.com> <200301222007.48055.harisri@bigpond.com> <200301230102.25399.harisri@bigpond.com> <200301271441.11112.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301271441.11112.harisri@bigpond.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27 2003, Srihari Vijayaraghavan wrote:
> Hello Andrea,
> 
> On Thursday 23 January 2003 01:02, Srihari Vijayaraghavan wrote:
> > ...
> > Ok. I did some more testing, and this is what happens:
> > /sbin/raidstart /dev/md0 executes and exits fine under 2.4.21-pre3. Where
> > as under 2.4.21-pre3aa1 it starts executing but _never_ exits (I waited for
> > few minutes). I had to kill it using alt + sysrq + k.
> > ...
> 
> The 9985_blk-atomic-aa5 patch is causing this regression. Backing this patch 
> out of 2.4.21-pre3aa1 makes it to work nicely with Software RAID-0.

Could you please try this patch on top of 2.4.21-pre3aa1 instead of
backing out blk-atomic? Does that work, too? Thanks!

===== drivers/md/md.c 1.38 vs edited =====
--- 1.38/drivers/md/md.c	Thu Jan 16 00:15:01 2003
+++ edited/drivers/md/md.c	Mon Jan 27 12:23:41 2003
@@ -494,6 +494,7 @@
 	bh.b_page = page;
 	bh.b_reqnext = NULL;
 	bh.b_data = page_address(page);
+	bh.b_elv_sequence = 0;
 	generic_make_request(rw, &bh);
 
 	run_task_queue(&tq_disk);
===== drivers/md/raid1.c 1.15 vs edited =====
--- 1.15/drivers/md/raid1.c	Sat Aug 31 02:20:48 2002
+++ edited/drivers/md/raid1.c	Mon Jan 27 12:27:44 2003
@@ -686,6 +686,7 @@
  		mbh->b_list       = BUF_LOCKED;
  		mbh->b_end_io     = raid1_end_request;
  		mbh->b_private    = r1_bh;
+		mbh->b_elv_sequence = bh->b_elv_sequence;
 
 		mbh->b_next = r1_bh->mirror_bh_list;
 		r1_bh->mirror_bh_list = mbh;
@@ -1456,6 +1457,7 @@
 	bh->b_private = r1_bh;
 	bh->b_blocknr = sector_nr;
 	bh->b_rsector = sector_nr;
+	bh->b_elv_sequence = 0;
 	init_waitqueue_head(&bh->b_wait);
 
 	generic_make_request(READ, bh);

-- 
Jens Axboe

