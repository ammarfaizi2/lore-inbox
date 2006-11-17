Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755908AbWKQVBQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908AbWKQVBQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755901AbWKQVBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:01:16 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:2476 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755902AbWKQVBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:01:12 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 01/15] aic94xx: Handle REQ_DEVICE_RESET
Date: Fri, 17 Nov 2006 13:07:40 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210740.17052.34278.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements a REQ_DEVICE_RESET handler for the aic94xx
driver.  Like the earlier REQ_TASK_ABORT patch, this patch defers
the device reset to the Scsi_Host's workqueue, which has the added
benefit of ensuring that the device reset does not happen at the
same time that the ABORT TASK TMFs that are issued in anticipation
of it are being processed.  After the phy reset, the busted drive
should go away and be re-detected later, which is indeed what
I've seen on both a x260 and a x206m.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/aic94xx/aic94xx_scb.c  |   52 ++++++++++++++++++++++++++++++-----
 drivers/scsi/libsas/sas_init.c      |    2 +
 drivers/scsi/libsas/sas_scsi_host.c |    1 +
 include/scsi/libsas.h               |    1 +
 include/scsi/scsi_transport_sas.h   |    2 +
 5 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/aic94xx/aic94xx_scb.c b/drivers/scsi/aic94xx/aic94xx_scb.c
index 1911c5d..7145531 100644
--- a/drivers/scsi/aic94xx/aic94xx_scb.c
+++ b/drivers/scsi/aic94xx/aic94xx_scb.c
@@ -342,6 +342,28 @@ void asd_invalidate_edb(struct asd_ascb 
 			asd_printk("couldn't post escb, err:%d\n", i);
 	}
 }
+ 
+/* hard reset a phy later */
+static void do_phy_reset_later(void *data)
+{
+	struct sas_phy *sas_phy = data;
+	int error;
+
+	ASD_DPRINTK("%s: About to hard reset phy %d\n", __FUNCTION__,
+		    sas_phy->identify.phy_identifier);
+	/* Reset device port */
+	error = sas_phy_reset(sas_phy, 1);
+	if (error)
+		ASD_DPRINTK("%s: Hard reset of phy %d failed (%d).\n",
+			    __FUNCTION__, sas_phy->identify.phy_identifier,
+			    error);
+}
+
+static void phy_reset_later(struct sas_phy *sas_phy, struct Scsi_Host *shost)
+{
+	INIT_WORK(&sas_phy->reset_work, do_phy_reset_later, sas_phy);
+	queue_work(shost->work_q, &sas_phy->reset_work);
+}
 
 /* start up the ABORT TASK tmf... */
 static void task_kill_later(struct asd_ascb *ascb)
@@ -402,7 +424,9 @@ static void escb_tasklet_complete(struct
 		goto out;
 	}
 	case REQ_DEVICE_RESET: {
-		struct asd_ascb *a, *b;
+		struct Scsi_Host *shost = sas_ha->core.shost;
+		struct sas_phy *dev_phy;
+		struct asd_ascb *a;
 		u16 conn_handle;
 
 		conn_handle = *((u16*)(&dl->status_block[1]));
@@ -412,17 +436,31 @@ static void escb_tasklet_complete(struct
 			    dl->status_block[3]);
 
 		/* Kill all pending tasks and reset the device */
-		list_for_each_entry_safe(a, b, &asd_ha->seq.pend_q, list) {
-			struct sas_task *task = a->uldd_task;
-			struct domain_device *dev = task->dev;
+		dev_phy = NULL;
+		list_for_each_entry(a, &asd_ha->seq.pend_q, list) {
+			struct sas_task *task;
+			struct domain_device *dev;
 			u16 x;
 
-			x = *((u16*)(&dev->lldd_dev));
-			if (x == conn_handle)
+			task = a->uldd_task;
+			if (!task)
+				continue;
+			dev = task->dev;
+
+			x = (u16)dev->lldd_dev;
+			if (x == conn_handle) {
+				dev_phy = dev->port->phy;
 				task_kill_later(a);
+			}
 		}
 
-		/* FIXME: Reset device port (huh?) */
+		/* Reset device port */
+		if (!dev_phy) {
+			ASD_DPRINTK("%s: No pending commands; can't reset.\n",
+				    __FUNCTION__);
+			goto out;
+		}
+		phy_reset_later(dev_phy, shost);
 		goto out;
 	}
 	case SIGNAL_NCQ_ERROR:
diff --git a/drivers/scsi/libsas/sas_init.c b/drivers/scsi/libsas/sas_init.c
index a2b479a..0fb347b 100644
--- a/drivers/scsi/libsas/sas_init.c
+++ b/drivers/scsi/libsas/sas_init.c
@@ -144,7 +144,7 @@ static int sas_get_linkerrors(struct sas
 	return sas_smp_get_phy_events(phy);
 }
 
-static int sas_phy_reset(struct sas_phy *phy, int hard_reset)
+int sas_phy_reset(struct sas_phy *phy, int hard_reset)
 {
 	int ret;
 	enum phy_func reset_type;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 6ccbb62..5c6e6f2 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -925,3 +925,4 @@ EXPORT_SYMBOL_GPL(sas_slave_alloc);
 EXPORT_SYMBOL_GPL(sas_target_destroy);
 EXPORT_SYMBOL_GPL(sas_ioctl);
 EXPORT_SYMBOL_GPL(sas_task_abort);
+EXPORT_SYMBOL_GPL(sas_phy_reset);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 7da678d..921db78 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -605,6 +605,7 @@ struct sas_domain_function_template {
 extern int sas_register_ha(struct sas_ha_struct *);
 extern int sas_unregister_ha(struct sas_ha_struct *);
 
+int sas_phy_reset(struct sas_phy *phy, int hard_reset);
 int sas_queue_up(struct sas_task *task);
 extern int sas_queuecommand(struct scsi_cmnd *,
 		     void (*scsi_done)(struct scsi_cmnd *));
diff --git a/include/scsi/scsi_transport_sas.h b/include/scsi/scsi_transport_sas.h
index 5302437..59633a8 100644
--- a/include/scsi/scsi_transport_sas.h
+++ b/include/scsi/scsi_transport_sas.h
@@ -73,6 +73,8 @@ struct sas_phy {
 
 	/* for the list of phys belonging to a port */
 	struct list_head	port_siblings;
+
+	struct work_struct      reset_work;
 };
 
 #define dev_to_phy(d) \
