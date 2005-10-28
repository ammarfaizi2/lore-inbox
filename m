Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965175AbVJ1HgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965175AbVJ1HgI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 03:36:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbVJ1HgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 03:36:07 -0400
Received: from [85.8.13.51] ([85.8.13.51]:52882 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S965175AbVJ1HgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 03:36:04 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Use command class to determine read-only status.
Date: Fri, 28 Oct 2005 09:36:05 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051028073605.4108.41408.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If a card doesn't support the "write block" command class then
any attempts to open the device should reflect this by denying
write access.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc_block.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -97,7 +97,8 @@ static int mmc_blk_open(struct inode *in
 		ret = 0;
 
 		if ((filp->f_mode & FMODE_WRITE) &&
-			mmc_card_readonly(md->queue.card))
+			(!(md->queue.card->csd.cmdclass & CCC_BLOCK_WRITE) ||
+			mmc_card_readonly(md->queue.card)))
 			ret = -EROFS;
 	}
 
@@ -407,10 +408,12 @@ static int mmc_blk_probe(struct mmc_card
 	if (err)
 		goto out;
 
-	printk(KERN_INFO "%s: %s %s %dKiB %s\n",
+	printk(KERN_INFO "%s: %s %s %dKiB",
 		md->disk->disk_name, mmc_card_id(card), mmc_card_name(card),
-		(card->csd.capacity << card->csd.read_blkbits) / 1024,
-		mmc_card_readonly(card)?"(ro)":"");
+		(card->csd.capacity << card->csd.read_blkbits) / 1024);
+	if (mmc_card_readonly(card) || !(card->csd.cmdclass & CCC_BLOCK_WRITE))
+		printk("(ro)");
+	printk("\n");
 
 	mmc_set_drvdata(card, md);
 	add_disk(md->disk);

