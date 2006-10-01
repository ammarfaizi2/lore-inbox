Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbWJAMms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbWJAMms (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 08:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWJAMmr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 08:42:47 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:9871 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932134AbWJAMmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 08:42:45 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Properly use the new multi block-write error handling
Date: Sun, 01 Oct 2006 14:42:47 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20061001124247.17004.44788.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new multi block-write error reporting flag and properly tell the
block layer how much data was transferred before the error.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc_block.c |   24 +++++++++++++++++-------
 1 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index db0e8ad..c1293f1 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -158,13 +158,13 @@ static int mmc_blk_issue_rq(struct mmc_q
 {
 	struct mmc_blk_data *md = mq->data;
 	struct mmc_card *card = md->queue.card;
+	struct mmc_blk_request brq;
 	int ret;
 
 	if (mmc_card_claim_host(card))
 		goto cmd_err;
 
 	do {
-		struct mmc_blk_request brq;
 		struct mmc_command cmd;
 		u32 readcmd, writecmd;
 
@@ -278,17 +278,27 @@ #endif
  cmd_err:
 	mmc_card_release_host(card);
 
+	ret = 1;
+
 	/*
-	 * This is a little draconian, but until we get proper
-	 * error handling sorted out here, its the best we can
-	 * do - especially as some hosts have no idea how much
-	 * data was transferred before the error occurred.
+	 * For writes and where the host claims to support proper
+	 * error reporting, we first ok the successful blocks.
+	 *
+	 * For reads we just fail the entire chunk as that should
+	 * be safe in all cases.
 	 */
+	if (rq_data_dir(req) != READ &&
+	    (card->host->caps & MMC_CAP_MULTIWRITE)) {
+		spin_lock_irq(&md->lock);
+		ret = end_that_request_chunk(req, 1, brq.data.bytes_xfered);
+		spin_unlock_irq(&md->lock);
+	}
+
 	spin_lock_irq(&md->lock);
-	do {
+	while (ret) {
 		ret = end_that_request_chunk(req, 0,
 				req->current_nr_sectors << 9);
-	} while (ret);
+	}
 
 	add_disk_randomness(req->rq_disk);
 	blkdev_dequeue_request(req);

