Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161539AbWJ3XSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161539AbWJ3XSn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161464AbWJ3XSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:18:43 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:41965 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161461AbWJ3XSl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:18:41 -0500
Message-ID: <4546884F.2080904@us.ibm.com>
Date: Mon, 30 Oct 2006 15:18:39 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] 1/3: Modify libsas error handler to use scsi_eh_* functions
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an EH done queue to sas_ha, converts the error handling
strategy function and the sas_scsi_task_done functions in libsas to use
the scsi_eh_* commands for error'd commands, and adds checks for the
INITIATOR_ABORTED flag so that we do the right thing if a sas_task has
been aborted by the initiator.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--

diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index c836a23..a2b479a 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -112,6 +112,8 @@ int sas_register_ha(struct sas_ha_struct
 		}
 	}
 
+	INIT_LIST_HEAD(&sas_ha->eh_done_q);
+
 	return 0;
 
 Undo_ports:
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 349e9a7..50aac70 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -29,6 +29,7 @@ #include <scsi/scsi_host.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi.h>
+#include <scsi/scsi_eh.h>
 #include <scsi/scsi_transport.h>
 #include <scsi/scsi_transport_sas.h>
 #include <scsi/sas_ata.h>
@@ -48,6 +49,7 @@ static void sas_scsi_task_done(struct sa
 {
 	struct task_status_struct *ts = &task->task_status;
 	struct scsi_cmnd *sc = task->uldd_task;
+	struct sas_ha_struct *sas_ha = SHOST_TO_SAS_HA(sc->device->host);
 	unsigned ts_flags = task->task_state_flags;
 	int hs = 0, stat = 0;
 
@@ -118,7 +120,7 @@ static void sas_scsi_task_done(struct sa
 	sas_free_task(task);
 	/* This is very ugly but this is how SCSI Core works. */
 	if (ts_flags & SAS_TASK_STATE_ABORTED)
-		scsi_finish_command(sc);
+		scsi_eh_finish_cmd(sc, &sas_ha->eh_done_q);
 	else
 		sc->scsi_done(sc);
 }
@@ -315,6 +317,15 @@ static enum task_disposition sas_scsi_fi
 		spin_unlock_irqrestore(&core->task_queue_lock, flags);
 	}
 
+	spin_lock_irqsave(&task->task_state_lock, flags);
+	if (task->task_state_flags & SAS_TASK_INITIATOR_ABORTED) {
+		spin_unlock_irqrestore(&task->task_state_lock, flags);
+		SAS_DPRINTK("%s: task 0x%p already aborted\n",
+			    __FUNCTION__, task);
+		return TASK_IS_ABORTED;
+	}
+	spin_unlock_irqrestore(&task->task_state_lock, flags);
+
 	for (i = 0; i < 5; i++) {
 		SAS_DPRINTK("%s: aborting task 0x%p\n", __FUNCTION__, task);
 		res = si->dft->lldd_abort_task(task);
@@ -417,13 +428,16 @@ Again:
 	SAS_DPRINTK("going over list...\n");
 	list_for_each_entry_safe(cmd, n, &error_q, eh_entry) {
 		struct sas_task *task = TO_SAS_TASK(cmd);
+		list_del_init(&cmd->eh_entry);
 
+		if (!task) {
+			SAS_DPRINTK("%s: taskless cmd?!\n", __FUNCTION__);
+			continue;
+		}
 		SAS_DPRINTK("trying to find task 0x%p\n", task);
-		list_del_init(&cmd->eh_entry);
 		res = sas_scsi_find_task(task);
 
 		cmd->eh_eflags = 0;
-		shost->host_failed--;
 
 		switch (res) {
 		case TASK_IS_DONE:
@@ -499,6 +513,7 @@ Again:
 		}
 	}
 out:
+	scsi_eh_flush_done_q(&ha->eh_done_q);
 	SAS_DPRINTK("--- Exit %s\n", __FUNCTION__);
 	return;
 clear_q:
@@ -516,12 +531,18 @@ enum scsi_eh_timer_return sas_scsi_timed
 	unsigned long flags;
 
 	if (!task) {
-		SAS_DPRINTK("command 0x%p, task 0x%p, timed out: EH_HANDLED\n",
+		SAS_DPRINTK("command 0x%p, task 0x%p, gone: EH_HANDLED\n",
 			    cmd, task);
 		return EH_HANDLED;
 	}
 
 	spin_lock_irqsave(&task->task_state_lock, flags);
+	if (task->task_state_flags & SAS_TASK_INITIATOR_ABORTED) {
+		spin_unlock_irqrestore(&task->task_state_lock, flags);
+		SAS_DPRINTK("command 0x%p, task 0x%p, aborted by initiator: "
+			    "EH_NOT_HANDLED\n", cmd, task);
+		return EH_NOT_HANDLED;
+	}
 	if (task->task_state_flags & SAS_TASK_STATE_DONE) {
 		spin_unlock_irqrestore(&task->task_state_lock, flags);
 		SAS_DPRINTK("command 0x%p, task 0x%p, timed out: EH_HANDLED\n",
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 3704fbf..914019a 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -346,6 +346,8 @@ struct sas_ha_struct {
 	void (*notify_phy_event)(struct asd_sas_phy *, enum phy_event);
 
 	void *lldd_ha;		  /* not touched by sas class code */
+
+	struct list_head eh_done_q;
 };
 
 #define SHOST_TO_SAS_HA(_shost) (*(struct sas_ha_struct **)(_shost)->hostdata)
@@ -538,9 +540,10 @@ struct sas_task {
 
 
 
-#define SAS_TASK_STATE_PENDING  1
-#define SAS_TASK_STATE_DONE     2
-#define SAS_TASK_STATE_ABORTED  4
+#define SAS_TASK_STATE_PENDING      1
+#define SAS_TASK_STATE_DONE         2
+#define SAS_TASK_STATE_ABORTED      4
+#define SAS_TASK_INITIATOR_ABORTED  8
 
 static inline struct sas_task *sas_alloc_task(gfp_t flags)
 {

