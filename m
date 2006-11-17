Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755914AbWKQVEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755914AbWKQVEO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbWKQVEN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:04:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:43488 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755909AbWKQVBq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:46 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 09/15] sas_ata: ata_post_internal should abort the sas_task
Date: Fri, 17 Nov 2006 13:08:12 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210812.17052.94955.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds a new field, lldd_task, to ata_queued_cmd so that libata
users such as libsas can associate some data with a qc.  The particular
ambition with this patch is to associate a sas_task with a qc; that way,
if libata decides to timeout a command, we can come back (in
sas_ata_post_internal) and abort the sas task.

One question remains: Is it necessary to reset the phy on error, or will
the libata error handler take care of it?  (Assuming that one is written,
of course.)  This patch, as it is today, works well enough to clean
things up when an ATA device probe attempt fails halfway through the probe,
though I'm not sure this is always the right thing to do.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/sas_ata.c |   30 +++++++++++++++++++++++++++---
 include/linux/libata.h        |    1 +
 2 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index a33ef6d..209f402 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -88,12 +88,17 @@ static enum ata_completion_errors sas_to
 static void sas_ata_task_done(struct sas_task *task)
 {
 	struct ata_queued_cmd *qc = task->uldd_task;
-	struct domain_device *dev = qc->ap->private_data;
+	struct domain_device *dev;
 	struct task_status_struct *stat = &task->task_status;
 	struct ata_task_resp *resp = (struct ata_task_resp *)stat->buf;
 	enum ata_completion_errors ac;
 	unsigned long flags;
 
+	if (!qc)
+		goto qc_already_gone;
+
+	dev = qc->ap->private_data;
+
 	if (stat->stat == SAS_PROTO_RESPONSE) {
 		ata_tf_from_fis(resp->ending_fis, &dev->sata_dev.tf);
 		qc->err_mask |= ac_err_mask(dev->sata_dev.tf.command);
@@ -113,10 +118,12 @@ static void sas_ata_task_done(struct sas
 		}
 	}
 
+	qc->lldd_task = NULL;
 	spin_lock_irqsave(dev->sata_dev.ap->lock, flags);
 	ata_qc_complete(qc);
 	spin_unlock_irqrestore(dev->sata_dev.ap->lock, flags);
 
+qc_already_gone:
 	list_del_init(&task->list);
 	sas_free_task(task);
 }
@@ -165,6 +172,7 @@ static unsigned int sas_ata_qc_issue(str
 	task->data_dir = qc->dma_dir;
 	task->scatter = qc->__sg;
 	task->ata_task.retry_count = 1;
+	qc->lldd_task = task;
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NCQ:
@@ -236,8 +244,24 @@ static void sas_ata_post_internal(struct
 	if (qc->flags & ATA_QCFLAG_FAILED)
 		qc->err_mask |= AC_ERR_OTHER;
 
-	if (qc->err_mask)
-		SAS_DPRINTK("%s: Failure; reset phy!\n", __FUNCTION__);
+	if (qc->err_mask) {
+		/*
+		 * Find the sas_task and kill it.  By this point,
+		 * libata has decided to kill the qc, so we needn't
+		 * bother with sas_ata_task_done.  But we still
+		 * ought to abort the task.
+		 */
+		struct sas_task *task = qc->lldd_task;
+		struct domain_device *dev = qc->ap->private_data;
+
+		qc->lldd_task = NULL;
+		if (task) {
+			task->uldd_task = NULL;
+			sas_task_abort(task);
+		}
+
+		sas_phy_reset(dev->port->phy, 1);
+	}
 }
 
 static void sas_ata_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
diff --git a/include/linux/libata.h b/include/linux/libata.h
index abd2deb..e2df9d0 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -444,6 +444,7 @@ struct ata_queued_cmd {
 	ata_qc_cb_t		complete_fn;
 
 	void			*private_data;
+	void			*lldd_task;
 };
 
 struct ata_port_stats {
