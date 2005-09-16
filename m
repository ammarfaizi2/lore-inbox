Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161154AbVIPKD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161154AbVIPKD6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161151AbVIPKD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:03:58 -0400
Received: from havoc.gtf.org ([69.61.125.42]:23789 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1161150AbVIPKD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:03:57 -0400
Date: Fri, 16 Sep 2005 06:03:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [git patch] libata fix
Message-ID: <20050916100351.GA21329@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please pull from 'upstream-fixes' branch of
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev.git

to obtain the following fix:


 drivers/scsi/libata-core.c |   37 +++++++++++++++++++++++--------------
 1 files changed, 23 insertions(+), 14 deletions(-)

commit 7fb6ec287a05d7a71ec086d8bc9a452d5e16ff1a
Author: Jeff Garzik <jgarzik@pobox.com>
Date:   Fri Sep 16 06:01:48 2005 -0400

    [libata] fix PIO completion race
    
    Make sure we that completion is the final action we take; prior to this
    change, another CPU may have changed ap->pio_task_state before we tested
    it a final time.
    
    Spotted by, and original patch by Albert Lee @ IBM.
    
    Also includes a minor optimization:  eliminate a ton of unnecessary
    queue_work() calls, simply by jumping to the beginning of the FSM
    function ata_pio_task().

diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -2465,9 +2465,12 @@ static unsigned long ata_pio_poll(struct
  *
  *	LOCKING:
  *	None.  (executing in kernel thread context)
+ *
+ *	RETURNS:
+ *	Non-zero if qc completed, zero otherwise.
  */
 
-static void ata_pio_complete (struct ata_port *ap)
+static int ata_pio_complete (struct ata_port *ap)
 {
 	struct ata_queued_cmd *qc;
 	u8 drv_stat;
@@ -2486,14 +2489,14 @@ static void ata_pio_complete (struct ata
 		if (drv_stat & (ATA_BUSY | ATA_DRQ)) {
 			ap->pio_task_state = PIO_ST_LAST_POLL;
 			ap->pio_task_timeout = jiffies + ATA_TMOUT_PIO;
-			return;
+			return 0;
 		}
 	}
 
 	drv_stat = ata_wait_idle(ap);
 	if (!ata_ok(drv_stat)) {
 		ap->pio_task_state = PIO_ST_ERR;
-		return;
+		return 0;
 	}
 
 	qc = ata_qc_from_tag(ap, ap->active_tag);
@@ -2502,6 +2505,10 @@ static void ata_pio_complete (struct ata
 	ap->pio_task_state = PIO_ST_IDLE;
 
 	ata_poll_qc_complete(qc, drv_stat);
+
+	/* another command may start at this point */
+
+	return 1;
 }
 
 
@@ -2709,7 +2716,7 @@ static void __atapi_pio_bytes(struct ata
 
 next_sg:
 	if (unlikely(qc->cursg >= qc->n_elem)) {
-		/* 
+		/*
 		 * The end of qc->sg is reached and the device expects
 		 * more data to transfer. In order not to overrun qc->sg
 		 * and fulfill length specified in the byte count register,
@@ -2721,7 +2728,7 @@ next_sg:
 		unsigned int i;
 
 		if (words) /* warning if bytes > 1 */
-			printk(KERN_WARNING "ata%u: %u bytes trailing data\n", 
+			printk(KERN_WARNING "ata%u: %u bytes trailing data\n",
 			       ap->id, bytes);
 
 		for (i = 0; i < words; i++)
@@ -2849,9 +2856,7 @@ static void ata_pio_block(struct ata_por
 	if (is_atapi_taskfile(&qc->tf)) {
 		/* no more data to transfer or unsupported ATAPI command */
 		if ((status & ATA_DRQ) == 0) {
-			ap->pio_task_state = PIO_ST_IDLE;
-
-			ata_poll_qc_complete(qc, status);
+			ap->pio_task_state = PIO_ST_LAST;
 			return;
 		}
 
@@ -2887,7 +2892,12 @@ static void ata_pio_error(struct ata_por
 static void ata_pio_task(void *_data)
 {
 	struct ata_port *ap = _data;
-	unsigned long timeout = 0;
+	unsigned long timeout;
+	int qc_completed;
+
+fsm_start:
+	timeout = 0;
+	qc_completed = 0;
 
 	switch (ap->pio_task_state) {
 	case PIO_ST_IDLE:
@@ -2898,7 +2908,7 @@ static void ata_pio_task(void *_data)
 		break;
 
 	case PIO_ST_LAST:
-		ata_pio_complete(ap);
+		qc_completed = ata_pio_complete(ap);
 		break;
 
 	case PIO_ST_POLL:
@@ -2913,10 +2923,9 @@ static void ata_pio_task(void *_data)
 	}
 
 	if (timeout)
-		queue_delayed_work(ata_wq, &ap->pio_task,
-				   timeout);
-	else
-		queue_work(ata_wq, &ap->pio_task);
+		queue_delayed_work(ata_wq, &ap->pio_task, timeout);
+	else if (!qc_completed)
+		goto fsm_start;
 }
 
 static void atapi_request_sense(struct ata_port *ap, struct ata_device *dev,
