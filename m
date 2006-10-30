Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161462AbWJ3XTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161462AbWJ3XTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 18:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161542AbWJ3XTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 18:19:00 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:32896 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1161462AbWJ3XS6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 18:18:58 -0500
Message-ID: <45468860.5060103@us.ibm.com>
Date: Mon, 30 Oct 2006 15:18:56 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Alexis Bruemmer <alexisb@us.ibm.com>
Subject: [PATCH] 3/3: Handle REQ_TASK_ABORT in aic94xx
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch straightens out the code that distinguishes the various escb
opcodes in escb_tasklet_complete so that they can be handled correctly. 
It also provides all the necessary code to create a workqueue item that
tells libsas to abort a sas_task.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

--

diff --git a/drivers/scsi/aic94xx/aic94xx_scb.c b/drivers/scsi/aic94xx/aic94xx_scb.c
index 7ee49b5..1911c5d 100644
--- a/drivers/scsi/aic94xx/aic94xx_scb.c
+++ b/drivers/scsi/aic94xx/aic94xx_scb.c
@@ -25,6 +25,7 @@
  */
 
 #include <linux/pci.h>
+#include <scsi/scsi_host.h>
 
 #include "aic94xx.h"
 #include "aic94xx_reg.h"
@@ -342,6 +343,18 @@ void asd_invalidate_edb(struct asd_ascb 
 	}
 }
 
+/* start up the ABORT TASK tmf... */
+static void task_kill_later(struct asd_ascb *ascb)
+{
+	struct asd_ha_struct *asd_ha = ascb->ha;
+	struct sas_ha_struct *sas_ha = &asd_ha->sas_ha;
+	struct Scsi_Host *shost = sas_ha->core.shost;
+	struct sas_task *task = ascb->uldd_task;
+
+	INIT_WORK(&task->abort_work, (void (*)(void *))sas_task_abort, task);
+	queue_work(shost->work_q, &task->abort_work);
+}
+
 static void escb_tasklet_complete(struct asd_ascb *ascb,
 				  struct done_list_struct *dl)
 {
@@ -368,6 +381,58 @@ static void escb_tasklet_complete(struct
 			    ascb->scb->header.opcode);
 	}
 
+	/* Catch these before we mask off the sb_opcode bits */
+	switch (sb_opcode) {
+	case REQ_TASK_ABORT: {
+		struct asd_ascb *a, *b;
+		u16 tc_abort;
+
+		tc_abort = *((u16*)(&dl->status_block[1]));
+		tc_abort = le16_to_cpu(tc_abort);
+
+		ASD_DPRINTK("%s: REQ_TASK_ABORT, reason=0x%X\n",
+			    __FUNCTION__, dl->status_block[3]);
+
+		/* Find the pending task and abort it. */
+		list_for_each_entry_safe(a, b, &asd_ha->seq.pend_q, list)
+			if (a->tc_index == tc_abort) {
+				task_kill_later(a);
+				break;
+			}
+		goto out;
+	}
+	case REQ_DEVICE_RESET: {
+		struct asd_ascb *a, *b;
+		u16 conn_handle;
+
+		conn_handle = *((u16*)(&dl->status_block[1]));
+		conn_handle = le16_to_cpu(conn_handle);
+
+		ASD_DPRINTK("%s: REQ_DEVICE_RESET, reason=0x%X\n", __FUNCTION__,
+			    dl->status_block[3]);
+
+		/* Kill all pending tasks and reset the device */
+		list_for_each_entry_safe(a, b, &asd_ha->seq.pend_q, list) {
+			struct sas_task *task = a->uldd_task;
+			struct domain_device *dev = task->dev;
+			u16 x;
+
+			x = *((u16*)(&dev->lldd_dev));
+			if (x == conn_handle)
+				task_kill_later(a);
+		}
+
+		/* FIXME: Reset device port (huh?) */
+		goto out;
+	}
+	case SIGNAL_NCQ_ERROR:
+		ASD_DPRINTK("%s: SIGNAL_NCQ_ERROR\n", __FUNCTION__);
+		goto out;
+	case CLEAR_NCQ_ERROR:
+		ASD_DPRINTK("%s: CLEAR_NCQ_ERROR\n", __FUNCTION__);
+		goto out;
+	}
+
 	sb_opcode &= ~DL_PHY_MASK;
 
 	switch (sb_opcode) {
@@ -397,22 +462,6 @@ static void escb_tasklet_complete(struct
 		sas_phy_disconnected(sas_phy);
 		sas_ha->notify_port_event(sas_phy, PORTE_TIMER_EVENT);
 		break;
-	case REQ_TASK_ABORT:
-		ASD_DPRINTK("%s: phy%d: REQ_TASK_ABORT\n", __FUNCTION__,
-			    phy_id);
-		break;
-	case REQ_DEVICE_RESET:
-		ASD_DPRINTK("%s: phy%d: REQ_DEVICE_RESET\n", __FUNCTION__,
-			    phy_id);
-		break;
-	case SIGNAL_NCQ_ERROR:
-		ASD_DPRINTK("%s: phy%d: SIGNAL_NCQ_ERROR\n", __FUNCTION__,
-			    phy_id);
-		break;
-	case CLEAR_NCQ_ERROR:
-		ASD_DPRINTK("%s: phy%d: CLEAR_NCQ_ERROR\n", __FUNCTION__,
-			    phy_id);
-		break;
 	default:
 		ASD_DPRINTK("%s: phy%d: unknown event:0x%x\n", __FUNCTION__,
 			    phy_id, sb_opcode);
@@ -432,7 +481,7 @@ static void escb_tasklet_complete(struct
 
 		break;
 	}
-
+out:
 	asd_invalidate_edb(ascb, edb);
 }
 
