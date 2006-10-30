Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161546AbWJ3XTz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161546AbWJ3XTz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161545AbWJ3XTx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:19:53 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:30340 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161311AbWJ3XTw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:19:52 -0500
Message-ID: <4546885A.8060202@us.ibm.com>
Date: Mon, 30 Oct 2006 15:18:50 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] 2/3: Add sas_abort_task to libsas
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an external function, sas_abort_task, to enable LLDDs
to abort sas_tasks.  It also adds a work_struct so that the actual
work of aborting a task can be shifted from tasklet context (in the
LLDD) onto the scsi_host's workqueue.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 50aac70..8bb8eea 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -34,6 +34,7 @@ #include <scsi/scsi_transport.h>
 #include <scsi/scsi_transport_sas.h>
 #include <scsi/sas_ata.h>
 #include "../scsi_sas_internal.h"
+#include "../scsi_transport_api.h"
 
 #include <linux/err.h>
 #include <linux/blkdev.h>
@@ -855,6 +856,64 @@ void sas_target_destroy(struct scsi_targ
 	return;
 }
 
+static int do_sas_task_abort(struct sas_task *task)
+{
+	struct scsi_cmnd *sc = task->uldd_task;
+	struct sas_internal *si =
+		to_sas_internal(task->dev->port->ha->core.shost->transportt);
+	unsigned long flags;
+	int res;
+
+	spin_lock_irqsave(&task->task_state_lock, flags);
+	if (task->task_state_flags & SAS_TASK_STATE_ABORTED) {
+		spin_unlock_irqrestore(&task->task_state_lock, flags);
+		SAS_DPRINTK("%s: Task %p already aborted.\n", __FUNCTION__,
+			    task);
+		return 0;
+	}
+
+	task->task_state_flags |= SAS_TASK_INITIATOR_ABORTED;
+	if (!(task->task_state_flags & SAS_TASK_STATE_DONE))
+		task->task_state_flags |= SAS_TASK_STATE_ABORTED;
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
+
+	if (!si->dft->lldd_abort_task)
+		return -ENODEV;
+
+	res = si->dft->lldd_abort_task(task);
+	if ((task->task_state_flags & SAS_TASK_STATE_DONE) ||
+	    (res == TMF_RESP_FUNC_COMPLETE))
+	{
+		/* SMP commands don't have scsi_cmds(?) */
+		if (!sc) {
+			task->task_done(task);
+			return 0;
+		}
+		scsi_req_abort_cmd(sc);
+		scsi_schedule_eh(sc->device->host);
+		return 0;
+	}
+
+	spin_lock_irqsave(&task->task_state_lock, flags);
+	task->task_state_flags &= ~SAS_TASK_INITIATOR_ABORTED;
+	if (!(task->task_state_flags & SAS_TASK_STATE_DONE))
+		task->task_state_flags &= ~SAS_TASK_STATE_ABORTED;
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
+
+	return -EAGAIN;
+}
+
+void sas_task_abort(struct sas_task *task)
+{
+	int i;
+
+	for (i = 0; i < 5; i++)
+		if (!do_sas_task_abort(task))
+			return;
+
+	SAS_DPRINTK("%s: Could not kill task!\n", __FUNCTION__);
+}
+
 EXPORT_SYMBOL_GPL(sas_queuecommand);
 EXPORT_SYMBOL_GPL(sas_target_alloc);
 EXPORT_SYMBOL_GPL(sas_slave_configure);
@@ -865,3 +924,4 @@ EXPORT_SYMBOL_GPL(sas_bios_param);
 EXPORT_SYMBOL_GPL(sas_slave_alloc);
 EXPORT_SYMBOL_GPL(sas_target_destroy);
 EXPORT_SYMBOL_GPL(sas_ioctl);
+EXPORT_SYMBOL_GPL(sas_task_abort);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 914019a..7da678d 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -536,6 +536,8 @@ struct sas_task {
 
 	void   *lldd_task;	  /* for use by LLDDs */
 	void   *uldd_task;
+
+	struct work_struct abort_work;
 };
 
 
@@ -639,5 +641,6 @@ void sas_init_dev(struct domain_device *
 extern void sas_target_destroy(struct scsi_target *);
 extern int sas_slave_alloc(struct scsi_device *);
 extern int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg);
+void sas_task_abort(struct sas_task *task);
 
 #endif /* _SASLIB_H_ */
