Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422685AbWKHTnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422685AbWKHTnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 14:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422690AbWKHTnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 14:43:17 -0500
Received: from brick.kernel.dk ([62.242.22.158]:1898 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1422685AbWKHTnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 14:43:16 -0500
Date: Wed, 8 Nov 2006 20:45:32 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Alex Romosan <romosan@sycorax.lbl.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc5: known regressions
Message-ID: <20061108194532.GB4527@kernel.dk>
References: <Pine.LNX.4.64.0611071829340.3667@g5.osdl.org> <20061108085235.GT4729@stusta.de> <20061108093442.GB19471@kernel.dk> <87ejsd3gcr.fsf@sycorax.lbl.gov> <20061108192924.GA4527@kernel.dk> <87ac313f1d.fsf@sycorax.lbl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ac313f1d.fsf@sycorax.lbl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08 2006, Alex Romosan wrote:
> Jens Axboe <jens.axboe@oracle.com> writes:
> 
> > It helps a lot, thanks! I may ask you to retest with another patch,
> > if you don't mind.
> 
> send the patches, i'll test them all. thanks.

If you could retest with something crazy like this, then that would
likely help:

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 7c47e62..010acfa 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -630,6 +630,9 @@ static void cdrom_end_request (ide_drive
 	struct request *rq = HWGROUP(drive)->rq;
 	int nsectors = rq->hard_cur_sectors;
 
+	if (blk_pc_request(rq) && rq->cmd[0] == 0x12)
+		printk("ide-cd: end INQ rq %p\n", rq);
+
 	if (blk_sense_request(rq) && uptodate) {
 		/*
 		 * For REQ_TYPE_SENSE, "rq->buffer" points to the original
@@ -1671,6 +1674,9 @@ static ide_startstop_t cdrom_newpc_intr(
 	xfer_func_t *xferfunc;
 	unsigned long flags;
 
+	if (rq->cmd[0] == 0x12)
+		printk("ide-cd: newpc %p\n", rq);
+
 	/* Check for errors. */
 	dma_error = 0;
 	dma = info->dma;
@@ -1789,6 +1795,8 @@ static ide_startstop_t cdrom_newpc_intr(
 	return ide_started;
 
 end_request:
+	if (rq->cmd[0] == 0x12)
+		printk("ide-cd: newpc end INQ %p\n", rq);
 	if (!rq->data_len)
 		post_transform_command(rq);
 
@@ -1959,7 +1967,13 @@ static ide_startstop_t cdrom_do_block_pc
 {
 	struct cdrom_info *info = drive->driver_data;
 
-	rq->cmd_flags |= REQ_QUIET;
+	if (rq->cmd[0] == 0x12) {
+		printk("ide-cd: starting INQ %p\n", rq);
+		if (rq_data_dir(rq) == WRITE)
+			printk("ide-cd: INQ with write set seen\n");
+	}
+	if (!rq->bio && rq->biotail)
+		printk("ide-cd: no bio, but biotail\n");
 
 	info->dma = 0;
 

-- 
Jens Axboe

