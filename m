Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755916AbWKQVBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755916AbWKQVBr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:01:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755913AbWKQVBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:01:39 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:23482 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1755901AbWKQVBZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:25 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 04/15] libsas: Don't give scsi_cmnds to the EH if they never made it to the SAS LLDD or have already returned
Date: Fri, 17 Nov 2006 13:07:49 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210749.17052.56317.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a system with many SAS targets, it appears possible that a scsi_cmnd
can time out without ever making it to the SAS LLDD or at the same time
that a completion is occurring.  In both of these cases, telling the
LLDD to abort the sas_task makes no sense because the LLDD won't know
about the sas_task; what we really want to do is to increase the timer.
Note that this involves creating another sas_task bit to indicate
whether or not the task has been sent to the LLDD; I could have
implemented this by slightly redefining SAS_TASK_STATE_PENDING, but
this way seems cleaner.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/aic94xx/aic94xx_task.c |    9 +++++++++
 drivers/scsi/aic94xx/aic94xx_tmf.c  |    4 +++-
 drivers/scsi/libsas/sas_ata.c       |    1 -
 drivers/scsi/libsas/sas_scsi_host.c |    7 +++++++
 include/scsi/libsas.h               |    1 +
 5 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index 9840708..466b492 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -349,6 +349,7 @@ Again:
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
+	task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
 	if (unlikely((task->task_state_flags & SAS_TASK_STATE_ABORTED))) {
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
@@ -556,6 +557,7 @@ int asd_execute_task(struct sas_task *ta
 	struct sas_task *t = task;
 	struct asd_ascb *ascb = NULL, *a;
 	struct asd_ha_struct *asd_ha = task->dev->port->ha->lldd_ha;
+	unsigned long flags;
 
 	res = asd_can_queue(asd_ha, num);
 	if (res)
@@ -601,9 +603,16 @@ int asd_execute_task(struct sas_task *ta
 	}
 	list_del_init(&alist);
 
+	spin_lock_irqsave(&task->task_state_lock, flags);
+	task->task_state_flags |= SAS_TASK_AT_INITIATOR;
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
+
 	res = asd_post_ascb_list(asd_ha, ascb, num);
 	if (unlikely(res)) {
 		a = NULL;
+		spin_lock_irqsave(&task->task_state_lock, flags);
+		task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
+		spin_unlock_irqrestore(&task->task_state_lock, flags);
 		__list_add(&alist, ascb->list.prev, &ascb->list);
 		goto out_err_unmap;
 	}
diff --git a/drivers/scsi/aic94xx/aic94xx_tmf.c b/drivers/scsi/aic94xx/aic94xx_tmf.c
index 6123438..686cea1 100644
--- a/drivers/scsi/aic94xx/aic94xx_tmf.c
+++ b/drivers/scsi/aic94xx/aic94xx_tmf.c
@@ -345,7 +345,7 @@ static inline int asd_clear_nexus(struct
 int asd_abort_task(struct sas_task *task)
 {
 	struct asd_ascb *tascb = task->lldd_task;
-	struct asd_ha_struct *asd_ha = tascb->ha;
+	struct asd_ha_struct *asd_ha;
 	int res = 1;
 	unsigned long flags;
 	struct asd_ascb *ascb = NULL;
@@ -360,6 +360,8 @@ int asd_abort_task(struct sas_task *task
 	}
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
+	asd_ha = tascb->ha;
+
 	ascb = asd_ascb_alloc_list(asd_ha, &res, GFP_KERNEL);
 	if (!ascb)
 		return -ENOMEM;
diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
index de42b5b..f92f035 100644
--- a/drivers/scsi/libsas/sas_ata.c
+++ b/drivers/scsi/libsas/sas_ata.c
@@ -161,7 +161,6 @@ static unsigned int sas_ata_qc_issue(str
 	task->data_dir = qc->dma_dir;
 	task->scatter = qc->__sg;
 	task->ata_task.retry_count = 1;
-	task->task_state_flags = SAS_TASK_STATE_PENDING;
 
 	switch (qc->tf.protocol) {
 	case ATA_PROT_NCQ:
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 5c6e6f2..7cc7a1e 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -550,6 +550,13 @@ enum scsi_eh_timer_return sas_scsi_timed
 			    cmd, task);
 		return EH_HANDLED;
 	}
+	if (!(task->task_state_flags & SAS_TASK_AT_INITIATOR)) {
+		spin_unlock_irqrestore(&task->task_state_lock, flags);
+		SAS_DPRINTK("command 0x%p, task 0x%p, not at initiator: "
+			    "EH_RESET_TIMER\n",
+			    cmd, task);
+		return EH_RESET_TIMER;
+	}
 	task->task_state_flags |= SAS_TASK_STATE_ABORTED;
 	spin_unlock_irqrestore(&task->task_state_lock, flags);
 
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 921db78..d2ec1be 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -546,6 +546,7 @@ #define SAS_TASK_STATE_PENDING      1
 #define SAS_TASK_STATE_DONE         2
 #define SAS_TASK_STATE_ABORTED      4
 #define SAS_TASK_INITIATOR_ABORTED  8
+#define SAS_TASK_AT_INITIATOR       16
 
 static inline struct sas_task *sas_alloc_task(gfp_t flags)
 {
