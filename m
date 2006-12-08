Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164318AbWLHBFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164318AbWLHBFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 20:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164317AbWLHBFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 20:05:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:46638 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164309AbWLHBFU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 20:05:20 -0500
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 8 Dec 2006 12:05:31 +1100
Message-Id: <1061208010531.21294@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 001 of 5] md: Remove some old ifdefed-out code from raid5.c
References: <20061208120132.21203.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There are some vestiges of old code that was used for bypassing the
stripe cache on reads in raid5.c.  This was never updated after the
change from buffer_heads to bios, but was left as a reminder.

That functionality has nowe been implemented in a completely different
way, so the old code can go.


Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |   63 ---------------------------------------------------
 1 file changed, 63 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-12-06 14:23:10.000000000 +1100
+++ ./drivers/md/raid5.c	2006-12-06 14:31:26.000000000 +1100
@@ -544,35 +544,7 @@ static int raid5_end_read_request(struct
 	}
 
 	if (uptodate) {
-#if 0
-		struct bio *bio;
-		unsigned long flags;
-		spin_lock_irqsave(&conf->device_lock, flags);
-		/* we can return a buffer if we bypassed the cache or
-		 * if the top buffer is not in highmem.  If there are
-		 * multiple buffers, leave the extra work to
-		 * handle_stripe
-		 */
-		buffer = sh->bh_read[i];
-		if (buffer &&
-		    (!PageHighMem(buffer->b_page)
-		     || buffer->b_page == bh->b_page )
-			) {
-			sh->bh_read[i] = buffer->b_reqnext;
-			buffer->b_reqnext = NULL;
-		} else
-			buffer = NULL;
-		spin_unlock_irqrestore(&conf->device_lock, flags);
-		if (sh->bh_page[i]==bh->b_page)
-			set_buffer_uptodate(bh);
-		if (buffer) {
-			if (buffer->b_page != bh->b_page)
-				memcpy(buffer->b_data, bh->b_data, bh->b_size);
-			buffer->b_end_io(buffer, 1);
-		}
-#else
 		set_bit(R5_UPTODATE, &sh->dev[i].flags);
-#endif
 		if (test_bit(R5_ReadError, &sh->dev[i].flags)) {
 			rdev = conf->disks[i].rdev;
 			printk(KERN_INFO "raid5:%s: read error corrected (%lu sectors at %llu on %s)\n",
@@ -618,14 +590,6 @@ static int raid5_end_read_request(struct
 		}
 	}
 	rdev_dec_pending(conf->disks[i].rdev, conf->mddev);
-#if 0
-	/* must restore b_page before unlocking buffer... */
-	if (sh->bh_page[i] != bh->b_page) {
-		bh->b_page = sh->bh_page[i];
-		bh->b_data = page_address(bh->b_page);
-		clear_buffer_uptodate(bh);
-	}
-#endif
 	clear_bit(R5_LOCKED, &sh->dev[i].flags);
 	set_bit(STRIPE_HANDLE, &sh->state);
 	release_stripe(sh);
@@ -1619,15 +1583,6 @@ static void handle_stripe5(struct stripe
 				} else if (test_bit(R5_Insync, &dev->flags)) {
 					set_bit(R5_LOCKED, &dev->flags);
 					set_bit(R5_Wantread, &dev->flags);
-#if 0
-					/* if I am just reading this block and we don't have
-					   a failed drive, or any pending writes then sidestep the cache */
-					if (sh->bh_read[i] && !sh->bh_read[i]->b_reqnext &&
-					    ! syncing && !failed && !to_write) {
-						sh->bh_cache[i]->b_page =  sh->bh_read[i]->b_page;
-						sh->bh_cache[i]->b_data =  sh->bh_read[i]->b_data;
-					}
-#endif
 					locked++;
 					PRINTK("Reading block %d (sync=%d)\n", 
 						i, syncing);
@@ -1645,9 +1600,6 @@ static void handle_stripe5(struct stripe
 			dev = &sh->dev[i];
 			if ((dev->towrite || i == sh->pd_idx) &&
 			    (!test_bit(R5_LOCKED, &dev->flags) 
-#if 0
-|| sh->bh_page[i]!=bh->b_page
-#endif
 				    ) &&
 			    !test_bit(R5_UPTODATE, &dev->flags)) {
 				if (test_bit(R5_Insync, &dev->flags)
@@ -1659,9 +1611,6 @@ static void handle_stripe5(struct stripe
 			/* Would I have to read this buffer for reconstruct_write */
 			if (!test_bit(R5_OVERWRITE, &dev->flags) && i != sh->pd_idx &&
 			    (!test_bit(R5_LOCKED, &dev->flags) 
-#if 0
-|| sh->bh_page[i] != bh->b_page
-#endif
 				    ) &&
 			    !test_bit(R5_UPTODATE, &dev->flags)) {
 				if (test_bit(R5_Insync, &dev->flags)) rcw++;
@@ -2197,15 +2146,6 @@ static void handle_stripe6(struct stripe
 				} else if (test_bit(R5_Insync, &dev->flags)) {
 					set_bit(R5_LOCKED, &dev->flags);
 					set_bit(R5_Wantread, &dev->flags);
-#if 0
-					/* if I am just reading this block and we don't have
-					   a failed drive, or any pending writes then sidestep the cache */
-					if (sh->bh_read[i] && !sh->bh_read[i]->b_reqnext &&
-					    ! syncing && !failed && !to_write) {
-						sh->bh_cache[i]->b_page =  sh->bh_read[i]->b_page;
-						sh->bh_cache[i]->b_data =  sh->bh_read[i]->b_data;
-					}
-#endif
 					locked++;
 					PRINTK("Reading block %d (sync=%d)\n",
 						i, syncing);
@@ -2224,9 +2164,6 @@ static void handle_stripe6(struct stripe
 			if (!test_bit(R5_OVERWRITE, &dev->flags)
 			    && i != pd_idx && i != qd_idx
 			    && (!test_bit(R5_LOCKED, &dev->flags)
-#if 0
-				|| sh->bh_page[i] != bh->b_page
-#endif
 				    ) &&
 			    !test_bit(R5_UPTODATE, &dev->flags)) {
 				if (test_bit(R5_Insync, &dev->flags)) rcw++;
