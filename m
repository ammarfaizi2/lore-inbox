Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261961AbVANL72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbVANL72 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 06:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261962AbVANL72
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 06:59:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:19929 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261961AbVANL7R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 06:59:17 -0500
Date: Fri, 14 Jan 2005 03:58:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Reuben Farrelly <reuben-lkml@reub.net>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: Breakage with raid in 2.6.11-rc1-mm1 [Regression in mm]
Message-Id: <20050114035852.3b5ff1a3.akpm@osdl.org>
In-Reply-To: <6.2.0.14.2.20050114233439.01cbb8d8@tornado.reub.net>
References: <6.2.0.14.2.20050114233439.01cbb8d8@tornado.reub.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly <reuben-lkml@reub.net> wrote:
>
> Something seems to have broken with 2.6.11-rc1-mm1, which worked ok with 
> 2.6.10-mm3.
> 
> NET: Registered protocol family 17
> Starting balanced_irq
> BIOS EDD facility v0.16 2004-Jun-25, 2 devices found
> md: Autodetecting RAID arrays.
> md: autorun ...
> md: ... autorun DONE.
> VFS: Waiting 19sec for root device...
> VFS: Waiting 18sec for root device...
> VFS: Waiting 17sec for root device...
> VFS: Waiting 16sec for root device...
> VFS: Waiting 15sec for root device...
> VFS: Waiting 14sec for root device...
> VFS: Waiting 13sec for root device...
> VFS: Waiting 12sec for root device...
> VFS: Waiting 11sec for root device...
> VFS: Waiting 10sec for root device...
> VFS: Waiting 9sec for root device...
> VFS: Waiting 8sec for root device...
> VFS: Waiting 7sec for root device...
> VFS: Waiting 6sec for root device...
> VFS: Waiting 5sec for root device...
> VFS: Waiting 4sec for root device...
> VFS: Waiting 3sec for root device...
> VFS: Waiting 2sec for root device...
> VFS: Waiting 1sec for root device...
> VFS: Cannot open root device "md2" or unknown-block(0,0)
> Please append a correct "root=" boot option
> Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(0,0)
> 
> The system is running 5 RAID-1 partitions, and md2 is the root as per 
> grub.conf.  Problem seems to be that raid autodetection finds no raid 
> partitions :(
> 
> The two ST380013AS SATA drives are detected earlier in the boot, so I don't 
> think that's the problem..

hm, the only raidy thing we have in there is the below.  Maybe you could
try reverting that?


--- 25/drivers/md/raid5.c~raid5-overlapping-read-hack	2005-01-09 22:20:40.211246912 -0800
+++ 25-akpm/drivers/md/raid5.c	2005-01-09 22:20:40.216246152 -0800
@@ -232,6 +232,7 @@ static struct stripe_head *__find_stripe
 }
 
 static void unplug_slaves(mddev_t *mddev);
+static void raid5_unplug_device(request_queue_t *q);
 
 static struct stripe_head *get_active_stripe(raid5_conf_t *conf, sector_t sector,
 					     int pd_idx, int noblock) 
@@ -793,7 +794,7 @@ static void compute_parity(struct stripe
  * toread/towrite point to the first in a chain. 
  * The bi_next chain must be in order.
  */
-static void add_stripe_bio (struct stripe_head *sh, struct bio *bi, int dd_idx, int forwrite)
+static int add_stripe_bio (struct stripe_head *sh, struct bio *bi, int dd_idx, int forwrite)
 {
 	struct bio **bip;
 	raid5_conf_t *conf = sh->raid_conf;
@@ -810,10 +811,10 @@ static void add_stripe_bio (struct strip
 	else
 		bip = &sh->dev[dd_idx].toread;
 	while (*bip && (*bip)->bi_sector < bi->bi_sector) {
-		BUG_ON((*bip)->bi_sector + ((*bip)->bi_size >> 9) > bi->bi_sector);
+		if ((*bip)->bi_sector + ((*bip)->bi_size >> 9) > bi->bi_sector)
+			return 0; /* cannot add just now due to overlap */
 		bip = & (*bip)->bi_next;
 	}
-/* FIXME do I need to worry about overlapping bion */
 	if (*bip && bi->bi_next && (*bip) != bi->bi_next)
 		BUG();
 	if (*bip)
@@ -840,6 +841,7 @@ static void add_stripe_bio (struct strip
 		if (sector >= sh->dev[dd_idx].sector + STRIPE_SECTORS)
 			set_bit(R5_OVERWRITE, &sh->dev[dd_idx].flags);
 	}
+	return 1;
 }
 
 
@@ -1413,7 +1415,15 @@ static int make_request (request_queue_t
 		sh = get_active_stripe(conf, new_sector, pd_idx, (bi->bi_rw&RWA_MASK));
 		if (sh) {
 
-			add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK));
+			while (!add_stripe_bio(sh, bi, dd_idx, (bi->bi_rw&RW_MASK))) {
+				/* add failed due to overlap.  Flush everything
+				 * and wait a while
+				 * FIXME - overlapping requests should be handled better
+				 */
+				raid5_unplug_device(mddev->queue);
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout(1);
+			}
 
 			raid5_plug_device(conf);
 			handle_stripe(sh);
_

