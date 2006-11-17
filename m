Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755927AbWKQVCP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755927AbWKQVCP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755923AbWKQVCN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:02:13 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:481 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1755924AbWKQVCB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:02:01 -0500
From: "Darrick J. Wong" <djwong@us.ibm.com>
Subject: [PATCH 14/15] libsas: Provide a generic SATL registration function
Date: Fri, 17 Nov 2006 13:08:30 -0800
To: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alexisb@us.ibm.com
Message-Id: <20061117210830.17052.40552.stgit@localhost.localdomain>
In-Reply-To: <20061117210737.17052.67041.stgit@localhost.localdomain>
References: <20061117210737.17052.67041.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Decouple libsas and sas_ata so that the latter can be provided as a
plug-in module for the former.  Any module wishing to provide SATL
services registers itself with libsas; when SATA devices are
discovered, libsas will module_get/put as necessary to ensure that
the module cannot go away accidentally.  At this time, the ability
to start a SAS HBA without a SATL, load a SATL later, and then
rerun device discovery; that may be addressed in a later patch.

Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
---

 drivers/scsi/libsas/Kconfig         |   11 +++
 drivers/scsi/libsas/sas_discover.c  |    6 --
 drivers/scsi/libsas/sas_scsi_host.c |  134 ++++++++++++++++++++++++++++++++---
 include/scsi/libsas.h               |   30 +-------
 include/scsi/sas_ata.h              |   37 +++++++++-
 5 files changed, 174 insertions(+), 44 deletions(-)

diff --git a/drivers/scsi/libsas/Kconfig b/drivers/scsi/libsas/Kconfig
index b64e391..9c06eec 100644
--- a/drivers/scsi/libsas/Kconfig
+++ b/drivers/scsi/libsas/Kconfig
@@ -24,12 +24,21 @@ #
 
 config SCSI_SAS_LIBSAS
 	tristate "SAS Domain Transport Attributes"
-	depends on SCSI && ATA
+	depends on SCSI
 	select SCSI_SAS_ATTRS
 	help
 	  This provides transport specific helpers for SAS drivers which
 	  use the domain device construct (like the aic94xxx).
 
+config SCSI_SAS_SATL
+	tristate "Serial ATA Translation Layer (SATL) on SAS controllers"
+	depends on SCSI_SAS_LIBSAS && ATA
+	default y
+	help
+	  This provides an ATA translation layer between libsas and
+	  libata to load SATA devices that are connected to SAS
+	  controllers.
+
 config SCSI_SAS_LIBSAS_DEBUG
 	bool "Compile the SAS Domain Transport Attributes in debug mode"
 	default y
diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index 758b153..01ff15c 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -476,12 +476,6 @@ cont1:
 	if (!dev->parent)
 		sas_sata_propagate_sas_addr(dev);
 
-	/* XXX Hint: register this SATA device with SATL.
-	   When this returns, dev->sata_dev->lu is alive and
-	   present.
-	sas_satl_register_dev(dev);
-	*/
-
 	sas_fill_in_rphy(dev, dev->rphy);
 
 	return 0;
diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 59409be..c1a1e06 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -46,6 +46,9 @@ #include <linux/libata.h>
 #define TO_SAS_TASK(_scsi_cmd)  ((void *)(_scsi_cmd)->host_scribble)
 #define ASSIGN_SAS_TASK(_sc, _t) do { (_sc)->host_scribble = (void *) _t; } while (0)
 
+static DEFINE_SPINLOCK(satl_ops_lock);
+static struct satl_operations *satl_ops;
+
 static void sas_scsi_task_done(struct sas_task *task)
 {
 	struct task_status_struct *ts = &task->task_status;
@@ -215,8 +218,8 @@ int sas_queuecommand(struct scsi_cmnd *c
 			unsigned long flags;
 
 			spin_lock_irqsave(dev->sata_dev.ap->lock, flags);
-			res = ata_sas_queuecmd(cmd, scsi_done,
-					       dev->sata_dev.ap);
+			res = satl_ops->queuecommand(cmd, scsi_done,
+						     dev->sata_dev.ap);
 			spin_unlock_irqrestore(dev->sata_dev.ap->lock, flags);
 			goto out;
 		}
@@ -574,8 +577,9 @@ int sas_ioctl(struct scsi_device *sdev, 
 {
 	struct domain_device *dev = sdev_to_domain_dev(sdev);
 
-	if (dev_is_sata(dev))
-		return ata_scsi_ioctl(sdev, cmd, arg);
+	if (dev_is_sata(dev)) {
+		return satl_ops->ioctl(sdev, cmd, arg);
+	}
 
 	return -EINVAL;
 }
@@ -615,6 +619,29 @@ static inline struct domain_device *sas_
 	return sas_find_dev_by_rphy(rphy);
 }
 
+static int sas_target_alloc_sata(struct domain_device *dev,
+				 struct scsi_target *starget)
+{
+	int res = -ENODEV;
+
+	/* Do we have a SATL available? */
+	if (!get_satl())
+		goto satl_found;
+
+	request_module("sas_ata");
+	if (!get_satl())
+		goto satl_found;
+
+	SAS_DPRINTK("sas_ata not loaded, ignoring SATA devices\n");
+	goto no_satl;
+
+satl_found:
+	res = satl_ops->init_target(dev, starget);
+
+no_satl:
+	return res;
+}
+
 int sas_target_alloc(struct scsi_target *starget)
 {
 	struct domain_device *found_dev = sas_find_target(starget);
@@ -624,7 +651,7 @@ int sas_target_alloc(struct scsi_target 
 		return -ENODEV;
 
 	if (dev_is_sata(found_dev)) {
-		res = sas_ata_init_host_and_port(found_dev, starget);
+		res = sas_target_alloc_sata(found_dev, starget);
 		if (res)
 			return res;
 	}
@@ -644,7 +671,7 @@ int sas_slave_configure(struct scsi_devi
 	BUG_ON(dev->rphy->identify.device_type != SAS_END_DEVICE);
 
 	if (dev_is_sata(dev)) {
-		ata_sas_slave_configure(scsi_dev, dev->sata_dev.ap);
+		satl_ops->configure_port(scsi_dev, dev->sata_dev.ap);
 		return 0;
 	}
 
@@ -672,7 +699,7 @@ void sas_slave_destroy(struct scsi_devic
 	struct domain_device *dev = sdev_to_domain_dev(scsi_dev);
 
 	if (dev_is_sata(dev))
-		ata_port_disable(dev->sata_dev.ap);
+		satl_ops->deactivate_port(dev->sata_dev.ap);
 }
 
 int sas_change_queue_depth(struct scsi_device *scsi_dev, int new_depth)
@@ -849,7 +876,7 @@ int sas_slave_alloc(struct scsi_device *
 	struct domain_device *dev = sdev_to_domain_dev(scsi_dev);
 
 	if (dev_is_sata(dev))
-		return ata_sas_port_init(dev->sata_dev.ap);
+		return satl_ops->init_port(dev->sata_dev.ap);
 
 	return 0;
 }
@@ -861,8 +888,11 @@ void sas_target_destroy(struct scsi_targ
 	if (!found_dev)
 		return;
 
-	if (dev_is_sata(found_dev))
-		ata_sas_port_destroy(found_dev->sata_dev.ap);
+	if (dev_is_sata(found_dev)) {
+		if (found_dev->sata_dev.ap)
+			satl_ops->destroy_port(found_dev->sata_dev.ap);
+		put_satl();
+	}
 
 	return;
 }
@@ -925,6 +955,85 @@ void sas_task_abort(struct sas_task *tas
 	SAS_DPRINTK("%s: Could not kill task!\n", __FUNCTION__);
 }
 
+struct sas_task *sas_alloc_task(gfp_t flags)
+{
+	extern kmem_cache_t *sas_task_cache;
+	struct sas_task *task = kmem_cache_alloc(sas_task_cache, flags);
+
+	if (task) {
+		memset(task, 0, sizeof(*task));
+		INIT_LIST_HEAD(&task->list);
+		spin_lock_init(&task->task_state_lock);
+		task->task_state_flags = SAS_TASK_STATE_PENDING;
+		init_timer(&task->timer);
+		init_completion(&task->completion);
+	}
+
+	return task;
+}
+
+void sas_free_task(struct sas_task *task)
+{
+	if (task) {
+		extern kmem_cache_t *sas_task_cache;
+		BUG_ON(!list_empty(&task->list));
+		kmem_cache_free(sas_task_cache, task);
+	}
+}
+
+/* Jump table to ATA translation layer functions */
+int sas_register_satl(struct satl_operations *ops)
+{
+	int res = -ENODEV;
+
+	spin_lock(&satl_ops_lock);
+	if (satl_ops)
+		goto out;
+	satl_ops = ops;
+	res = 0;
+out:
+	spin_unlock(&satl_ops_lock);
+	return res;
+}
+
+int sas_unregister_satl(struct satl_operations *ops)
+{
+	int res = -ENODEV;
+
+	spin_lock(&satl_ops_lock);
+	if (satl_ops != ops)
+		goto out;
+	satl_ops = NULL;
+	res = 0;
+out:
+	spin_unlock(&satl_ops_lock);
+	return res;
+}
+
+int get_satl(void)
+{
+	int res = -ENODEV;
+
+	spin_lock(&satl_ops_lock);
+
+	if (!satl_ops)
+		goto out;
+	if (!try_module_get(satl_ops->owner))
+		goto out;
+	res = 0;
+
+out:
+	spin_unlock(&satl_ops_lock);
+	return res;
+}
+
+void put_satl(void)
+{
+	spin_lock(&satl_ops_lock);
+	module_put(satl_ops->owner);
+	spin_unlock(&satl_ops_lock);
+}
+
 EXPORT_SYMBOL_GPL(sas_queuecommand);
 EXPORT_SYMBOL_GPL(sas_target_alloc);
 EXPORT_SYMBOL_GPL(sas_slave_configure);
@@ -939,3 +1048,8 @@ EXPORT_SYMBOL_GPL(sas_task_abort);
 EXPORT_SYMBOL_GPL(sas_phy_reset);
 EXPORT_SYMBOL_GPL(sas_phy_enable);
 EXPORT_SYMBOL_GPL(sas_set_phy_speed);
+EXPORT_SYMBOL_GPL(sas_register_satl);
+EXPORT_SYMBOL_GPL(sas_unregister_satl);
+EXPORT_SYMBOL_GPL(sas_queue_up);
+EXPORT_SYMBOL_GPL(sas_alloc_task);
+EXPORT_SYMBOL_GPL(sas_free_task);
diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
index 7dcf593..90748ce 100644
--- a/include/scsi/libsas.h
+++ b/include/scsi/libsas.h
@@ -549,31 +549,8 @@ #define SAS_TASK_STATE_ABORTED      4
 #define SAS_TASK_INITIATOR_ABORTED  8
 #define SAS_TASK_AT_INITIATOR       16
 
-static inline struct sas_task *sas_alloc_task(gfp_t flags)
-{
-	extern kmem_cache_t *sas_task_cache;
-	struct sas_task *task = kmem_cache_alloc(sas_task_cache, flags);
-
-	if (task) {
-		memset(task, 0, sizeof(*task));
-		INIT_LIST_HEAD(&task->list);
-		spin_lock_init(&task->task_state_lock);
-		task->task_state_flags = SAS_TASK_STATE_PENDING;
-		init_timer(&task->timer);
-		init_completion(&task->completion);
-	}
-
-	return task;
-}
-
-static inline void sas_free_task(struct sas_task *task)
-{
-	if (task) {
-		extern kmem_cache_t *sas_task_cache;
-		BUG_ON(!list_empty(&task->list));
-		kmem_cache_free(sas_task_cache, task);
-	}
-}
+struct sas_task *sas_alloc_task(gfp_t flags);
+void sas_free_task(struct sas_task *task);
 
 struct sas_domain_function_template {
 	/* The class calls these to notify the LLDD of an event. */
@@ -649,4 +626,7 @@ extern int sas_slave_alloc(struct scsi_d
 extern int sas_ioctl(struct scsi_device *sdev, int cmd, void __user *arg);
 void sas_task_abort(struct sas_task *task);
 
+int get_satl(void);
+void put_satl(void);
+
 #endif /* _SASLIB_H_ */
diff --git a/include/scsi/sas_ata.h b/include/scsi/sas_ata.h
index 72a1904..bb4a1cb 100644
--- a/include/scsi/sas_ata.h
+++ b/include/scsi/sas_ata.h
@@ -28,12 +28,45 @@ #define _SAS_ATA_H_
 #include <linux/libata.h>
 #include <scsi/libsas.h>
 
+struct satl_operations {
+	struct module *owner;
+
+	int (*init_target) (struct domain_device *found_dev,
+			    struct scsi_target *starget);
+	int  (*queuecommand) (struct scsi_cmnd *cmd,
+			      void (*done)(struct scsi_cmnd *),
+			      struct ata_port *ap);
+	int  (*ioctl) (struct scsi_device *dev, int cmd,
+		       void __user *arg);
+	int  (*configure_port) (struct scsi_device *,
+				struct ata_port *);
+	void (*deactivate_port) (struct ata_port *);
+	void (*destroy_port) (struct ata_port *);
+	int  (*init_port) (struct ata_port *);
+};
+
+int sas_register_satl(struct satl_operations *satl_ops);
+int sas_unregister_satl(struct satl_operations *satl_ops);
+
+#ifdef CONFIG_SCSI_SAS_SATL_MODULE
+# define SAS_ATA_AVAILABLE
+#endif
+
+#ifdef CONFIG_SCSI_SAS_SATL
+# define SAS_ATA_AVAILABLE
+#endif
+
+#ifdef SAS_ATA_AVAILABLE
+
 static inline int dev_is_sata(struct domain_device *dev)
 {
 	return (dev->rphy->identify.target_port_protocols & SAS_PROTOCOL_SATA);
 }
 
-int sas_ata_init_host_and_port(struct domain_device *found_dev,
-			       struct scsi_target *starget);
+#else
+
+#define dev_is_sata(x) (0)
+
+#endif /* SAS_ATA_AVAILABLE */
 
 #endif /* _SAS_ATA_H_ */
