Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754871AbWKOCU1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871AbWKOCU1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 21:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754840AbWKOCU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 21:20:27 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:33751 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751859AbWKOCU0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 21:20:26 -0500
Message-ID: <455A7968.5080307@us.ibm.com>
Date: Tue, 14 Nov 2006 18:20:24 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] sas_ata: Abort sas_task on error in sas_ata_post_internal
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new field, lldd_task, to ata_queued_cmd so that libata
users such as libsas can associate some data with a qc.  The particular
ambition with this patch is to associate a sas_task with a qc; that way,
if libata decides to timeout a command, we can come back (in
sas_ata_post_internal) and abort the sas task.

I do wonder, however--is it necessary to reset the phy on error, or will
the libata error handler take care of it?  (Assuming that I provide one,
of course.)  This patch, as it is today, works well enough to clean
things up when an ATA device probe attempt fails halfway through the probe,
though I'm not sure this is always the right thing to do... and I haven't
anything to inject errors into the SATA stack.

This patch applies against aic94xx-sas + the big heap of other patches
that I've sent in to this mailing list, and like most of them is rather
experimental.  It works for me, but it might eat you instead.

--

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index 9208b8b..b7e6593 100644
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
@@ -166,6 +173,7 @@ static unsigned int sas_ata_qc_issue(str
 	task->scatter = qc->__sg;
 	task->ata_task.retry_count = 1;
 	task->task_state_flags = SAS_TASK_STATE_PENDING;
+	qc->lldd_task = task;
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NCQ:
@@ -237,8 +245,24 @@ static void sas_ata_post_internal(struct
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
