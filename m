Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030706AbWF0HGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030706AbWF0HGA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030712AbWF0HFw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:05:52 -0400
Received: from ns.suse.de ([195.135.220.2]:21379 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030706AbWF0HFn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:05:43 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Tue, 27 Jun 2006 17:05:37 +1000
Message-Id: <1060627070537.26022@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 006 of 12] md: Fix some small races in bitmap plugging in raid5.
References: <20060627170010.25835.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The comment gives more details, but I didn't quite have the
sequencing write, so there was room for races to leave bits
unset in the on-disk bitmap for short periods of time.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./drivers/md/raid5.c |   30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff .prev/drivers/md/raid5.c ./drivers/md/raid5.c
--- .prev/drivers/md/raid5.c	2006-06-27 12:17:33.000000000 +1000
+++ ./drivers/md/raid5.c	2006-06-27 12:17:33.000000000 +1000
@@ -18,6 +18,30 @@
  * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+/*
+ * BITMAP UNPLUGGING:
+ *
+ * The sequencing for updating the bitmap reliably is a little
+ * subtle (and I got it wrong the first time) so it deserves some
+ * explanation.
+ *
+ * We group bitmap updates into batches.  Each batch has a number.
+ * We may write out several batches at once, but that isn't very important.
+ * conf->bm_write is the number of the last batch successfully written.
+ * conf->bm_flush is the number of the last batch that was closed to
+ *    new additions.
+ * When we discover that we will need to write to any block in a stripe
+ * (in add_stripe_bio) we update the in-memory bitmap and record in sh->bm_seq
+ * the number of the batch it will be in. This is bm_flush+1.
+ * When we are ready to do a write, if that batch hasn't been written yet,
+ *   we plug the array and queue the stripe for later.
+ * When an unplug happens, we increment bm_flush, thus closing the current
+ *   batch.
+ * When we notice that bm_flush > bm_write, we write out all pending updates
+ * to the bitmap, and advance bm_write to where bm_flush was.
+ * This may occasionally write a bit out twice, but is sure never to
+ * miss any bits.
+ */
 
 #include <linux/config.h>
 #include <linux/module.h>
@@ -93,7 +117,7 @@ static void __release_stripe(raid5_conf_
 				list_add_tail(&sh->lru, &conf->delayed_list);
 				blk_plug_device(conf->mddev->queue);
 			} else if (test_bit(STRIPE_BIT_DELAY, &sh->state) &&
-				   conf->seq_write == sh->bm_seq) {
+				   sh->bm_seq - conf->seq_write > 0) {
 				list_add_tail(&sh->lru, &conf->bitmap_list);
 				blk_plug_device(conf->mddev->queue);
 			} else {
@@ -1274,9 +1298,9 @@ static int add_stripe_bio(struct stripe_
 		(unsigned long long)sh->sector, dd_idx);
 
 	if (conf->mddev->bitmap && firstwrite) {
-		sh->bm_seq = conf->seq_write;
 		bitmap_startwrite(conf->mddev->bitmap, sh->sector,
 				  STRIPE_SECTORS, 0);
+		sh->bm_seq = conf->seq_flush+1;
 		set_bit(STRIPE_BIT_DELAY, &sh->state);
 	}
 
@@ -2920,7 +2944,7 @@ static void raid5d (mddev_t *mddev)
 	while (1) {
 		struct list_head *first;
 
-		if (conf->seq_flush - conf->seq_write > 0) {
+		if (conf->seq_flush != conf->seq_write) {
 			int seq = conf->seq_flush;
 			spin_unlock_irq(&conf->device_lock);
 			bitmap_unplug(mddev->bitmap);
