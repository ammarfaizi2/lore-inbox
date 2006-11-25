Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757858AbWKYG6x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757858AbWKYG6x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 01:58:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757767AbWKYG6x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 01:58:53 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:14518 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1757858AbWKYG6w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 01:58:52 -0500
Message-ID: <4567E9A8.70209@us.ibm.com>
Date: Fri, 24 Nov 2006 22:58:48 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061115)
MIME-Version: 1.0
To: "Darrick J. Wong" <djwong@us.ibm.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH v2] libsas: Don't give scsi_cmnds to the EH if they never
 made it to the SAS LLDD or have already returned
References: <20061117210737.17052.67041.stgit@localhost.localdomain> <20061117210749.17052.56317.stgit@localhost.localdomain>
In-Reply-To: <20061117210749.17052.56317.stgit@localhost.localdomain>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

This second version amends the aic94xx portion to set the
TASK_AT_INITIATOR flag for all sas_tasks that were passed to
lldd_execute_task.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/aic94xx/aic94xx_task.c |    9 +++++++++
 drivers/scsi/aic94xx/aic94xx_tmf.c  |    4 +++-
 drivers/scsi/libsas/sas_scsi_host.c |    7 +++++++
 include/scsi/libsas.h               |    1 +
 4 files changed, 20 insertions(+), 1 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_task.c b/drivers/scsi/aic94xx/aic94xx_task.c
index d202ed5..e2ad5be 100644
--- a/drivers/scsi/aic94xx/aic94xx_task.c
+++ b/drivers/scsi/aic94xx/aic94xx_task.c
@@ -349,6 +349,7 @@ Again:
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
 	task->task_state_flags &= ~SAS_TASK_STATE_PENDING;
+	task->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
 	task->task_state_flags |= SAS_TASK_STATE_DONE;
 	if (unlikely((task->task_state_flags & SAS_TASK_STATE_ABORTED))) {
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
@@ -557,6 +558,7 @@ int asd_execute_task(struct sas_task *ta
 	struct sas_task *t = task;
 	struct asd_ascb *ascb = NULL, *a;
 	struct asd_ha_struct *asd_ha = task->dev->port->ha->lldd_ha;
+	unsigned long flags;
 
 	res = asd_can_queue(asd_ha, num);
 	if (res)
@@ -599,6 +601,10 @@ int asd_execute_task(struct sas_task *ta
 		}
 		if (res)
 			goto out_err_unmap;
+
+		spin_lock_irqsave(&t->task_state_lock, flags);
+		t->task_state_flags |= SAS_TASK_AT_INITIATOR;
+		spin_unlock_irqrestore(&t->task_state_lock, flags);
 	}
 	list_del_init(&alist);
 
@@ -617,6 +623,9 @@ out_err_unmap:
 			if (a == b)
 				break;
 			t = a->uldd_task;
+			spin_lock_irqsave(&t->task_state_lock, flags);
+			t->task_state_flags &= ~SAS_TASK_AT_INITIATOR;
+			spin_unlock_irqrestore(&t->task_state_lock, flags);
 			switch (t->task_proto) {
 			case SATA_PROTO:
 			case SAS_PROTO_STP:
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
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index e064aac..c3fc8d6 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -542,6 +542,13 @@ enum scsi_eh_timer_return sas_scsi_timed
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
index c4a8af1..33b72ae 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -538,6 +538,7 @@ #define SAS_TASK_STATE_PENDING      1
 #define SAS_TASK_STATE_DONE         2
 #define SAS_TASK_STATE_ABORTED      4
 #define SAS_TASK_INITIATOR_ABORTED  8
+#define SAS_TASK_AT_INITIATOR       16
 
 static inline struct sas_task *sas_alloc_task(gfp_t flags)
 {
