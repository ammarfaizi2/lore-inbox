Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261804AbUDHOyF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261794AbUDHOyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:54:05 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:37548 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP id S261867AbUDHOah
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:30:37 -0400
Date: Thu, 8 Apr 2004 16:30:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] s390 (7/12): zfcp fixes (without kfree hack).
Message-ID: <20040408143020.GH1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zfcp host adapter fixes:
 - Reuse freed scsi_ids and scsi_luns for mappings.
 - Order list of ports/units by assigned scsi_id/scsi_lun.
 - Don't update max_id/max_lun in scsi_host anymore.
 - Get rid of all magics.
 - Add owner field to ccw_driver structure.
 - Avoid deadlock on bus->subsys.rwsem.
 - Use a macro for all scsi device sysfs attributes.
 - Change proc_name from "dummy" to "zfcp".
 - Don't wait for scsi_add_device to complete while holding a semaphore.
 - Cleanup include files in zfcp_aux.c & zfcp_def.h.
 - Get rid of zfcp_erp_fsf_req_handler.
 - Proper link up/down handling.
 - Avoid possible NULL pointer dereference in zfcp_erp_schedule_work.
 - Remove module_exit function. Without an external release function for
   the zfcp_port/zfcp_unit objects module unloading is racy.

diffstat:
 drivers/s390/scsi/zfcp_aux.c           |  435 ++++++++++-----------------------
 drivers/s390/scsi/zfcp_ccw.c           |   22 -
 drivers/s390/scsi/zfcp_def.h           |   53 +---
 drivers/s390/scsi/zfcp_erp.c           |   32 --
 drivers/s390/scsi/zfcp_ext.h           |    6 
 drivers/s390/scsi/zfcp_fsf.c           |  421 ++++++++++++++++---------------
 drivers/s390/scsi/zfcp_fsf.h           |   16 -
 drivers/s390/scsi/zfcp_qdio.c          |   19 -
 drivers/s390/scsi/zfcp_scsi.c          |  121 +++------
 drivers/s390/scsi/zfcp_sysfs_adapter.c |   31 --
 drivers/s390/scsi/zfcp_sysfs_port.c    |   12 
 drivers/s390/scsi/zfcp_sysfs_unit.c    |    8 
 12 files changed, 459 insertions(+), 717 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Sun Apr  4 05:38:26 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Thu Apr  8 15:21:27 2004
@@ -29,43 +29,10 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.98 $"
-
-/********************** INCLUDES *********************************************/
-
-#include <linux/init.h>
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/ctype.h>
-#include <linux/mm.h>
-#include <linux/timer.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
-#include <linux/version.h>
-#include <linux/list.h>
-#include <linux/interrupt.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/time.h>
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/workqueue.h>
-#include <linux/syscalls.h>
+#define ZFCP_AUX_REVISION "$Revision: 1.105 $"
 
 #include "zfcp_ext.h"
 
-#include <asm/semaphore.h>
-#include <asm/io.h>
-#include <asm/irq.h>
-#include <asm/ebcdic.h>
-#include <asm/cpcmd.h>		/* Debugging only */
-#include <asm/processor.h>	/* Debugging only */
-
-#include <linux/miscdevice.h>
-#include <linux/major.h>
-
 /* accumulated log level (module parameter) */
 static u32 loglevel = ZFCP_LOG_LEVEL_DEFAULTS;
 static char *device;
@@ -73,7 +40,6 @@
 
 /* written against the module interface */
 static int __init  zfcp_module_init(void);
-static void __exit zfcp_module_exit(void);
 
 int zfcp_reboot_handler(struct notifier_block *, unsigned long, void *);
 
@@ -120,7 +86,6 @@
 
 /* declare driver module init/cleanup functions */
 module_init(zfcp_module_init);
-module_exit(zfcp_module_exit);
 
 MODULE_AUTHOR("Heiko Carstens <heiko.carstens@de.ibm.com>, "
 	      "Martin Peschke <mpeschke@de.ibm.com>, "
@@ -272,7 +237,6 @@
 zfcp_cmd_dbf_event_fsf(const char *text, struct zfcp_fsf_req *fsf_req,
 		       void *add_data, int add_length)
 {
-#ifdef ZFCP_DEBUG_COMMANDS
 	struct zfcp_adapter *adapter = fsf_req->adapter;
 	struct scsi_cmnd *scsi_cmnd;
 	int level = 3;
@@ -299,7 +263,6 @@
 				    min(ZFCP_CMD_DBF_LENGTH, add_length - i));
 	}
 	write_unlock_irqrestore(&adapter->cmd_dbf_lock, flags);
-#endif
 }
 
 /* XXX additionally log unit if available */
@@ -307,7 +270,6 @@
 void
 zfcp_cmd_dbf_event_scsi(const char *text, struct scsi_cmnd *scsi_cmnd)
 {
-#ifdef ZFCP_DEBUG_COMMANDS
 	struct zfcp_adapter *adapter;
 	union zfcp_req_data *req_data;
 	struct zfcp_fsf_req *fsf_req;
@@ -335,14 +297,12 @@
 		debug_text_event(adapter->cmd_dbf, level, "");
 	}
 	write_unlock_irqrestore(&adapter->cmd_dbf_lock, flags);
-#endif
 }
 
 void
 zfcp_in_els_dbf_event(struct zfcp_adapter *adapter, const char *text,
 		      struct fsf_status_read_buffer *status_buffer, int length)
 {
-#ifdef ZFCP_DEBUG_INCOMING_ELS
 	int level = 1;
 	int i;
 
@@ -353,7 +313,6 @@
 			    level,
 			    (char *) status_buffer->payload + i,
 			    min(ZFCP_IN_ELS_DBF_LENGTH, length - i));
-#endif
 }
 
 /**
@@ -421,8 +380,8 @@
 		goto out_unit;
 	up(&zfcp_data.config_sema);
 	ccw_device_set_online(adapter->ccw_device);
-	down(&zfcp_data.config_sema);
 	wait_event(unit->scsi_add_wq, atomic_read(&unit->scsi_add_work) == 0);
+	down(&zfcp_data.config_sema);
 	zfcp_unit_put(unit);
  out_unit:
 	zfcp_port_put(port);
@@ -518,21 +477,6 @@
 	return retval;
 }
 
-static void __exit
-zfcp_module_exit(void)
-{
-	unregister_reboot_notifier(&zfcp_data.reboot_notifier);
-	zfcp_ccw_unregister();
-	misc_deregister(&zfcp_cfdc_misc);
-#ifdef CONFIG_S390_SUPPORT
-	unregister_ioctl32_conversion(zfcp_ioctl_trans.cmd);
-#endif
-#ifdef ZFCP_STAT_REQSIZES
-	zfcp_statistics_clear_all();
-#endif
-	ZFCP_LOG_DEBUG("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
-}
-
 /*
  * This function is called automatically by the kernel whenever a reboot or a 
  * shut-down is initiated and zfcp is still loaded
@@ -784,7 +728,7 @@
 zfcp_sg_list_alloc(struct zfcp_sg_list *sg_list, size_t size)
 {
 	struct scatterlist *sg;
-	int i;
+	unsigned int i;
 	int retval = 0;
 
 	sg_list->count = size >> PAGE_SHIFT;
@@ -826,7 +770,7 @@
 zfcp_sg_list_free(struct zfcp_sg_list *sg_list)
 {
 	struct scatterlist *sg;
-	int i;
+	unsigned int i;
 	int retval = 0;
 
 	BUG_ON((sg_list->sg == NULL) || (sg_list == NULL));
@@ -978,7 +922,9 @@
 struct zfcp_unit *
 zfcp_unit_enqueue(struct zfcp_port *port, fcp_lun_t fcp_lun)
 {
-	struct zfcp_unit *unit;
+	struct zfcp_unit *unit, *tmp_unit;
+	scsi_lun_t scsi_lun;
+	int found;
 
 	/*
 	 * check that there is no unit with this FCP_LUN already in list
@@ -1002,13 +948,7 @@
 	init_waitqueue_head(&unit->remove_wq);
 
 	unit->port = port;
-	/*
-	 * FIXME: reuse of scsi_luns!
-	 */
-	unit->scsi_lun = port->max_scsi_lun + 1;
 	unit->fcp_lun = fcp_lun;
-	unit->common_magic = ZFCP_MAGIC;
-	unit->specific_magic = ZFCP_MAGIC_UNIT;
 
 	/* setup for sysfs registration */
 	snprintf(unit->sysfs_device.bus_id, BUS_ID_SIZE, "0x%016llx", fcp_lun);
@@ -1025,43 +965,29 @@
 	}
 
 	if (zfcp_sysfs_unit_create_files(&unit->sysfs_device)) {
-		/*
-		 * failed to create all sysfs attributes, therefore the unit
-		 * must be put on the unit_remove listhead of the port where
-		 * the release function expects it.
-		 */
-		write_lock_irq(&zfcp_data.config_lock);
-		list_add_tail(&unit->list, &port->unit_remove_lh);
-		write_unlock_irq(&zfcp_data.config_lock);
 		device_unregister(&unit->sysfs_device);
 		return NULL;
 	}
 
-	/*
-	 * update max SCSI LUN of logical units attached to parent remote port
-	 */
-	port->max_scsi_lun++;
-
-	/*
-	 * update max SCSI LUN of logical units attached to parent adapter
-	 */
-	if (port->adapter->max_scsi_lun < port->max_scsi_lun)
-		port->adapter->max_scsi_lun = port->max_scsi_lun;
-
-	/*
-	 * update max SCSI LUN of logical units attached to host (SCSI stack)
-	 */
-	if (port->adapter->scsi_host &&
-	    (port->adapter->scsi_host->max_lun < port->max_scsi_lun))
-		port->adapter->scsi_host->max_lun = port->max_scsi_lun + 1;
-
 	zfcp_unit_get(unit);
 
-	/* unit is new and needs to be added to list */
+	scsi_lun = 0;
+	found = 0;
 	write_lock_irq(&zfcp_data.config_lock);
+	list_for_each_entry(tmp_unit, &port->unit_list_head, list) {
+		if (tmp_unit->scsi_lun != scsi_lun) {
+			found = 1;
+			break;
+		}
+		scsi_lun++;
+	}
+	unit->scsi_lun = scsi_lun;
+	if (found)
+		list_add_tail(&unit->list, &tmp_unit->list);
+	else
+		list_add_tail(&unit->list, &port->unit_list_head);
 	atomic_clear_mask(ZFCP_STATUS_COMMON_REMOVE, &unit->status);
 	atomic_set_mask(ZFCP_STATUS_COMMON_RUNNING, &unit->status);
-	list_add_tail(&unit->list, &port->unit_list_head);
 	write_unlock_irq(&zfcp_data.config_lock);
 
 	port->units++;
@@ -1070,21 +996,17 @@
 	return unit;
 }
 
-/* locks:  config_sema must be held */
 void
 zfcp_unit_dequeue(struct zfcp_unit *unit)
 {
-	/* remove specified unit data structure from list */
+	zfcp_unit_wait(unit);
 	write_lock_irq(&zfcp_data.config_lock);
 	list_del(&unit->list);
 	write_unlock_irq(&zfcp_data.config_lock);
-
 	unit->port->units--;
 	zfcp_port_put(unit->port);
-
-	kfree(unit);
-
-	return;
+	zfcp_sysfs_unit_remove_files(&unit->sysfs_device);
+	device_unregister(&unit->sysfs_device);
 }
 
 static void *
@@ -1154,7 +1076,7 @@
 
 	adapter->pool.data_status_read =
 		mempool_create(ZFCP_POOL_STATUS_READ_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free,
+			       zfcp_mempool_alloc, zfcp_mempool_free, 
 			       (void *) sizeof(struct fsf_status_read_buffer));
 
 	if (NULL == adapter->pool.data_status_read) {
@@ -1198,6 +1120,91 @@
 		mempool_destroy(adapter->pool.data_gid_pn);
 }
 
+/**
+ * zfcp_adapter_debug_register - registers debug feature for an adapter
+ * @adapter: pointer to adapter for which debug features should be registered
+ * return: -ENOMEM on error, 0 otherwise
+ */
+int
+zfcp_adapter_debug_register(struct zfcp_adapter *adapter)
+{
+	char dbf_name[20];
+
+	/* debug feature area which records fsf request sequence numbers */
+	sprintf(dbf_name, ZFCP_REQ_DBF_NAME "%s",
+		zfcp_get_busid_by_adapter(adapter));
+	adapter->req_dbf = debug_register(dbf_name,
+					  ZFCP_REQ_DBF_INDEX,
+					  ZFCP_REQ_DBF_AREAS,
+					  ZFCP_REQ_DBF_LENGTH);
+	debug_register_view(adapter->req_dbf, &debug_hex_ascii_view);
+	debug_set_level(adapter->req_dbf, ZFCP_REQ_DBF_LEVEL);
+	debug_text_event(adapter->req_dbf, 1, "zzz");
+
+	/* debug feature area which records SCSI command failures (hostbyte) */
+	rwlock_init(&adapter->cmd_dbf_lock);
+	sprintf(dbf_name, ZFCP_CMD_DBF_NAME "%s",
+		zfcp_get_busid_by_adapter(adapter));
+	adapter->cmd_dbf = debug_register(dbf_name,
+					  ZFCP_CMD_DBF_INDEX,
+					  ZFCP_CMD_DBF_AREAS,
+					  ZFCP_CMD_DBF_LENGTH);
+	debug_register_view(adapter->cmd_dbf, &debug_hex_ascii_view);
+	debug_set_level(adapter->cmd_dbf, ZFCP_CMD_DBF_LEVEL);
+
+	/* debug feature area which records SCSI command aborts */
+	sprintf(dbf_name, ZFCP_ABORT_DBF_NAME "%s",
+		zfcp_get_busid_by_adapter(adapter));
+	adapter->abort_dbf = debug_register(dbf_name,
+					    ZFCP_ABORT_DBF_INDEX,
+					    ZFCP_ABORT_DBF_AREAS,
+					    ZFCP_ABORT_DBF_LENGTH);
+	debug_register_view(adapter->abort_dbf, &debug_hex_ascii_view);
+	debug_set_level(adapter->abort_dbf, ZFCP_ABORT_DBF_LEVEL);
+
+	/* debug feature area which records SCSI command aborts */
+	sprintf(dbf_name, ZFCP_IN_ELS_DBF_NAME "%s",
+		zfcp_get_busid_by_adapter(adapter));
+	adapter->in_els_dbf = debug_register(dbf_name,
+					     ZFCP_IN_ELS_DBF_INDEX,
+					     ZFCP_IN_ELS_DBF_AREAS,
+					     ZFCP_IN_ELS_DBF_LENGTH);
+	debug_register_view(adapter->in_els_dbf, &debug_hex_ascii_view);
+	debug_set_level(adapter->in_els_dbf, ZFCP_IN_ELS_DBF_LEVEL);
+
+
+	/* debug feature area which records erp events */
+	sprintf(dbf_name, ZFCP_ERP_DBF_NAME "%s",
+		zfcp_get_busid_by_adapter(adapter));
+	adapter->erp_dbf = debug_register(dbf_name,
+					  ZFCP_ERP_DBF_INDEX,
+					  ZFCP_ERP_DBF_AREAS,
+					  ZFCP_ERP_DBF_LENGTH);
+	debug_register_view(adapter->erp_dbf, &debug_hex_ascii_view);
+	debug_set_level(adapter->erp_dbf, ZFCP_ERP_DBF_LEVEL);
+
+	if (adapter->req_dbf && adapter->cmd_dbf && adapter->abort_dbf &&
+	    adapter->in_els_dbf && adapter->erp_dbf)
+		return 0;
+
+	zfcp_adapter_debug_unregister(adapter);
+	return -ENOMEM;
+}
+
+/**
+ * zfcp_adapter_debug_unregister - unregisters debug feature for an adapter
+ * @adapter: pointer to adapter for which debug features should be unregistered
+ */
+void
+zfcp_adapter_debug_unregister(struct zfcp_adapter *adapter)
+{
+	debug_unregister(adapter->erp_dbf);
+	debug_unregister(adapter->req_dbf);
+	debug_unregister(adapter->cmd_dbf);
+	debug_unregister(adapter->abort_dbf);
+	debug_unregister(adapter->in_els_dbf);
+}
+
 /*
  * Enqueues an adapter at the end of the adapter list in the driver data.
  * All adapter internal structures are set up.
@@ -1213,7 +1220,6 @@
 {
 	int retval = 0;
 	struct zfcp_adapter *adapter;
-	char dbf_name[20];
 
 	/*
 	 * Note: It is safe to release the list_lock, as any list changes 
@@ -1246,10 +1252,6 @@
 	if (retval)
 		goto failed_low_mem_buffers;
 
-	/* set magics */
-	adapter->common_magic = ZFCP_MAGIC;
-	adapter->specific_magic = ZFCP_MAGIC_ADAPTER;
-
 	/* initialise reference count stuff */
 	atomic_set(&adapter->refcount, 0);
 	init_waitqueue_head(&adapter->remove_wq);
@@ -1292,103 +1294,6 @@
 	if (zfcp_sysfs_adapter_create_files(&ccw_device->dev))
 		goto sysfs_failed;
 
-#ifdef ZFCP_DEBUG_REQUESTS
-	/* debug feature area which records fsf request sequence numbers */
-	sprintf(dbf_name, ZFCP_REQ_DBF_NAME "%s",
-		zfcp_get_busid_by_adapter(adapter));
-	adapter->req_dbf = debug_register(dbf_name,
-					  ZFCP_REQ_DBF_INDEX,
-					  ZFCP_REQ_DBF_AREAS,
-					  ZFCP_REQ_DBF_LENGTH);
-	if (!adapter->req_dbf) {
-		ZFCP_LOG_INFO
-		    ("error: Out of resources. Request debug feature for "
-		     "adapter %s could not be generated.\n",
-		     zfcp_get_busid_by_adapter(adapter));
-		retval = -ENOMEM;
-		goto failed_req_dbf;
-	}
-	debug_register_view(adapter->req_dbf, &debug_hex_ascii_view);
-	debug_set_level(adapter->req_dbf, ZFCP_REQ_DBF_LEVEL);
-	debug_text_event(adapter->req_dbf, 1, "zzz");
-#endif				/* ZFCP_DEBUG_REQUESTS */
-
-#ifdef ZFCP_DEBUG_COMMANDS
-	/* debug feature area which records SCSI command failures (hostbyte) */
-	rwlock_init(&adapter->cmd_dbf_lock);
-	sprintf(dbf_name, ZFCP_CMD_DBF_NAME "%s",
-		zfcp_get_busid_by_adapter(adapter));
-	adapter->cmd_dbf = debug_register(dbf_name,
-					  ZFCP_CMD_DBF_INDEX,
-					  ZFCP_CMD_DBF_AREAS,
-					  ZFCP_CMD_DBF_LENGTH);
-	if (!adapter->cmd_dbf) {
-		ZFCP_LOG_INFO
-		    ("error: Out of resources. Command debug feature for "
-		     "adapter %s could not be generated.\n",
-		     zfcp_get_busid_by_adapter(adapter));
-		retval = -ENOMEM;
-		goto failed_cmd_dbf;
-	}
-	debug_register_view(adapter->cmd_dbf, &debug_hex_ascii_view);
-	debug_set_level(adapter->cmd_dbf, ZFCP_CMD_DBF_LEVEL);
-#endif				/* ZFCP_DEBUG_COMMANDS */
-
-#ifdef ZFCP_DEBUG_ABORTS
-	/* debug feature area which records SCSI command aborts */
-	sprintf(dbf_name, ZFCP_ABORT_DBF_NAME "%s",
-		zfcp_get_busid_by_adapter(adapter));
-	adapter->abort_dbf = debug_register(dbf_name,
-					    ZFCP_ABORT_DBF_INDEX,
-					    ZFCP_ABORT_DBF_AREAS,
-					    ZFCP_ABORT_DBF_LENGTH);
-	if (!adapter->abort_dbf) {
-		ZFCP_LOG_INFO
-		    ("error: Out of resources. Abort debug feature for "
-		     "adapter %s could not be generated.\n",
-		     zfcp_get_busid_by_adapter(adapter));
-		retval = -ENOMEM;
-		goto failed_abort_dbf;
-	}
-	debug_register_view(adapter->abort_dbf, &debug_hex_ascii_view);
-	debug_set_level(adapter->abort_dbf, ZFCP_ABORT_DBF_LEVEL);
-#endif				/* ZFCP_DEBUG_ABORTS */
-
-#ifdef ZFCP_DEBUG_INCOMING_ELS
-	/* debug feature area which records SCSI command aborts */
-	sprintf(dbf_name, ZFCP_IN_ELS_DBF_NAME "%s",
-		zfcp_get_busid_by_adapter(adapter));
-	adapter->in_els_dbf = debug_register(dbf_name,
-					     ZFCP_IN_ELS_DBF_INDEX,
-					     ZFCP_IN_ELS_DBF_AREAS,
-					     ZFCP_IN_ELS_DBF_LENGTH);
-	if (!adapter->in_els_dbf) {
-		ZFCP_LOG_INFO("error: Out of resources. ELS debug feature for "
-			      "adapter %s could not be generated.\n",
-			      zfcp_get_busid_by_adapter(adapter));
-		retval = -ENOMEM;
-		goto failed_in_els_dbf;
-	}
-	debug_register_view(adapter->in_els_dbf, &debug_hex_ascii_view);
-	debug_set_level(adapter->in_els_dbf, ZFCP_IN_ELS_DBF_LEVEL);
-#endif				/* ZFCP_DEBUG_INCOMING_ELS */
-
-	sprintf(dbf_name, ZFCP_ERP_DBF_NAME "%s",
-		zfcp_get_busid_by_adapter(adapter));
-	adapter->erp_dbf = debug_register(dbf_name,
-					  ZFCP_ERP_DBF_INDEX,
-					  ZFCP_ERP_DBF_AREAS,
-					  ZFCP_ERP_DBF_LENGTH);
-	if (!adapter->erp_dbf) {
-		ZFCP_LOG_INFO("error: Out of resources. ERP debug feature for "
-			      "adapter %s could not be generated.\n",
-			      zfcp_get_busid_by_adapter(adapter));
-		retval = -ENOMEM;
-		goto failed_erp_dbf;
-	}
-	debug_register_view(adapter->erp_dbf, &debug_hex_ascii_view);
-	debug_set_level(adapter->erp_dbf, ZFCP_ERP_DBF_LEVEL);
-
 	/* put allocated adapter at list tail */
 	write_lock_irq(&zfcp_data.config_lock);
 	atomic_clear_mask(ZFCP_STATUS_COMMON_REMOVE, &adapter->status);
@@ -1399,27 +1304,6 @@
 
 	goto out;
 
- failed_erp_dbf:
-#ifdef ZFCP_DEBUG_INCOMING_ELS
-	debug_unregister(adapter->in_els_dbf);
- failed_in_els_dbf:
-#endif
-
-#ifdef ZFCP_DEBUG_ABORTS
-	debug_unregister(adapter->abort_dbf);
- failed_abort_dbf:
-#endif
-
-#ifdef ZFCP_DEBUG_COMMANDS
-	debug_unregister(adapter->cmd_dbf);
- failed_cmd_dbf:
-#endif
-
-#ifdef ZFCP_DEBUG_REQUESTS
-	debug_unregister(adapter->req_dbf);
- failed_req_dbf:
-#endif
-	zfcp_sysfs_adapter_remove_files(&ccw_device->dev);
  sysfs_failed:
 	dev_set_drvdata(&ccw_device->dev, NULL);
  failed_low_mem_buffers:
@@ -1488,23 +1372,6 @@
 		     "mechanism for adapter %s\n",
 		     zfcp_get_busid_by_adapter(adapter));
 
-	debug_unregister(adapter->erp_dbf);
-
-#ifdef ZFCP_DEBUG_REQUESTS
-	debug_unregister(adapter->req_dbf);
-#endif
-
-#ifdef ZFCP_DEBUG_COMMANDS
-	debug_unregister(adapter->cmd_dbf);
-#endif
-#ifdef ZFCP_DEBUG_ABORTS
-	debug_unregister(adapter->abort_dbf);
-#endif
-
-#ifdef ZFCP_DEBUG_INCOMING_ELS
-	debug_unregister(adapter->in_els_dbf);
-#endif
-
 	zfcp_free_low_mem_buffers(adapter);
 	/* free memory of adapter data structure and queues */
 	zfcp_qdio_free_queues(adapter);
@@ -1515,25 +1382,20 @@
 }
 
 /*
- * Enqueues a remote port at the end of the port list.
- * All port internal structures are set-up and the proc-fs entry is also 
- * allocated. Some SCSI-stack structures are modified for the port.
+ * Enqueues a remote port to the port list. All port internal structures
+ * are set up and the sysfs entry is also generated.
  *
- * returns:	0            if a new port was successfully enqueued
- *              ZFCP_KNOWN   if a port with the requested wwpn already exists
- *              -ENOMEM      if allocation failed
- *              -EINVAL      if at least one of the specified parameters was wrong
+ * returns:     pointer to port or NULL
  * locks:       config_sema must be held to serialise changes to the port list
- *              within this function (must not be held on entry)
  */
 struct zfcp_port *
 zfcp_port_enqueue(struct zfcp_adapter *adapter, wwn_t wwpn, u32 status)
 {
-	struct zfcp_port *port;
-	int check_scsi_id;
+	struct zfcp_port *port, *tmp_port;
 	int check_wwpn;
+	scsi_id_t scsi_id;
+	int found;
 
-	check_scsi_id = !(status & ZFCP_STATUS_PORT_NO_SCSI_ID);
 	check_wwpn = !(status & ZFCP_STATUS_PORT_NO_WWPN);
 
 	/*
@@ -1561,17 +1423,11 @@
 
 	port->adapter = adapter;
 
-	if (check_scsi_id)
-		port->scsi_id = adapter->max_scsi_id + 1;
-
 	if (check_wwpn)
 		port->wwpn = wwpn;
 
 	atomic_set_mask(status, &port->status);
 
-	port->common_magic = ZFCP_MAGIC;
-	port->specific_magic = ZFCP_MAGIC_PORT;
-
 	/* setup for sysfs registration */
 	if (status & ZFCP_STATUS_PORT_NAMESERVER)
 		snprintf(port->sysfs_device.bus_id, BUS_ID_SIZE, "nameserver");
@@ -1591,41 +1447,32 @@
 	}
 
 	if (zfcp_sysfs_port_create_files(&port->sysfs_device, status)) {
-		/*
-		 * failed to create all sysfs attributes, therefore the port
-		 * must be put on the port_remove listhead of the adapter
-		 * where the release function expects it.
-		 */
-		write_lock_irq(&zfcp_data.config_lock);
-		list_add_tail(&port->list, &adapter->port_remove_lh);
-		write_unlock_irq(&zfcp_data.config_lock);
 		device_unregister(&port->sysfs_device);
 		return NULL;
 	}
 
-	if (check_scsi_id) {
-		/*
-		 * update max. SCSI ID of remote ports attached to
-		 * "parent" adapter if necessary
-		 * (do not care about the adapters own SCSI ID)
-		 */
-		adapter->max_scsi_id++;
-
-		/*
-		 * update max. SCSI ID of remote ports attached to
-		 * "parent" host (SCSI stack) if necessary
-		 */
-		if (adapter->scsi_host &&
-		    (adapter->scsi_host->max_id < adapter->max_scsi_id + 1))
-			adapter->scsi_host->max_id = adapter->max_scsi_id + 1;
-	}
-
 	zfcp_port_get(port);
 
+	scsi_id = 1;
+	found = 0;
 	write_lock_irq(&zfcp_data.config_lock);
+	list_for_each_entry(tmp_port, &adapter->port_list_head, list) {
+		if (atomic_test_mask(ZFCP_STATUS_PORT_NO_SCSI_ID,
+				     &tmp_port->status))
+			continue;
+		if (tmp_port->scsi_id != scsi_id) {
+			found = 1;
+			break;
+		}
+		scsi_id++;
+	}
+	port->scsi_id = scsi_id;
+	if (found)
+		list_add_tail(&port->list, &tmp_port->list);
+	else
+		list_add_tail(&port->list, &adapter->port_list_head);
 	atomic_clear_mask(ZFCP_STATUS_COMMON_REMOVE, &port->status);
 	atomic_set_mask(ZFCP_STATUS_COMMON_RUNNING, &port->status);
-	list_add_tail(&port->list, &adapter->port_list_head);
 	write_unlock_irq(&zfcp_data.config_lock);
 
 	adapter->ports++;
@@ -1634,26 +1481,18 @@
 	return port;
 }
 
-/*
- * returns:	0 - struct zfcp_port data structure successfully removed
- *		!0 - struct zfcp_port data structure could not be removed
- *			(e.g. still used)
- * locks :	port list write lock is assumed to be held by caller
- */
 void
 zfcp_port_dequeue(struct zfcp_port *port)
 {
-	/* remove specified port from list */
+	zfcp_port_wait(port);
 	write_lock_irq(&zfcp_data.config_lock);
 	list_del(&port->list);
 	write_unlock_irq(&zfcp_data.config_lock);
-
 	port->adapter->ports--;
 	zfcp_adapter_put(port->adapter);
-
-	kfree(port);
-
-	return;
+	zfcp_sysfs_port_remove_files(&port->sysfs_device,
+				     atomic_read(&port->status));
+	device_unregister(&port->sysfs_device);
 }
 
 /* Enqueues a nameserver port */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	Sun Apr  4 05:36:52 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c	Thu Apr  8 15:21:27 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_CCW_C_REVISION "$Revision: 1.48 $"
+#define ZFCP_CCW_C_REVISION "$Revision: 1.52 $"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -55,6 +55,7 @@
 };
 
 static struct ccw_driver zfcp_ccw_driver = {
+	.owner       = THIS_MODULE,
 	.name        = ZFCP_NAME,
 	.ids         = zfcp_ccw_device_id,
 	.probe       = zfcp_ccw_probe,
@@ -130,14 +131,9 @@
 
 	list_for_each_entry_safe(port, p, &adapter->port_remove_lh, list) {
 		list_for_each_entry_safe(unit, u, &port->unit_remove_lh, list) {
-			zfcp_unit_wait(unit);
-			zfcp_sysfs_unit_remove_files(&unit->sysfs_device);
-			device_unregister(&unit->sysfs_device);
+			zfcp_unit_dequeue(unit);
 		}
-		zfcp_port_wait(port);
-		zfcp_sysfs_port_remove_files(&port->sysfs_device,
-					     atomic_read(&port->status));
-		device_unregister(&port->sysfs_device);
+		zfcp_port_dequeue(port);
 	}
 	zfcp_adapter_wait(adapter);
 	zfcp_adapter_dequeue(adapter);
@@ -163,13 +159,16 @@
 	down(&zfcp_data.config_sema);
 	adapter = dev_get_drvdata(&ccw_device->dev);
 
-	retval = zfcp_erp_thread_setup(adapter);
+	retval = zfcp_adapter_debug_register(adapter);
+	if (retval)
+		goto out;
+	retval = zfcp_erp_thread_setup(adapter); 
 	if (retval) {
 		ZFCP_LOG_INFO("error: out of resources. "
 			      "error recovery thread for adapter %s "
 			      "could not be started\n",
 			      zfcp_get_busid_by_adapter(adapter));
-		goto out;
+		goto out_erp_thread;
 	}
 
 	retval = zfcp_adapter_scsi_register(adapter);
@@ -183,6 +182,8 @@
 
  out_scsi_register:
 	zfcp_erp_thread_kill(adapter);
+ out_erp_thread:
+	zfcp_adapter_debug_unregister(adapter);
  out:
 	up(&zfcp_data.config_sema);
 	return retval;
@@ -208,6 +209,7 @@
 	zfcp_erp_wait(adapter);
 	zfcp_adapter_scsi_unregister(adapter);
 	zfcp_erp_thread_kill(adapter);
+	zfcp_adapter_debug_unregister(adapter);
 	up(&zfcp_data.config_sema);
 	return 0;
 }
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Sun Apr  4 05:37:23 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Thu Apr  8 15:21:27 2004
@@ -33,25 +33,29 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.62 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.71 $"
 
 /*************************** INCLUDES *****************************************/
 
+#include <linux/init.h>
+#include <linux/moduleparam.h>
+#include <linux/miscdevice.h>
+#include <linux/major.h>
 #include <linux/blkdev.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
-#include "../../scsi/scsi.h"
 #include "../../fc4/fc.h"
-#include "zfcp_fsf.h"			/* FSF SW Interface */
+#include "zfcp_fsf.h"
 #include <asm/ccwdev.h>
 #include <asm/qdio.h>
 #include <asm/debug.h>
 #include <asm/ebcdic.h>
 #include <linux/reboot.h>
 #include <linux/mempool.h>
+#include <linux/syscalls.h>
 #include <linux/ioctl.h>
 #ifdef CONFIG_S390_SUPPORT
 #include <linux/ioctl32.h>
@@ -60,10 +64,6 @@
 /************************ DEBUG FLAGS *****************************************/
 
 #define	ZFCP_PRINT_FLAGS
-#define	ZFCP_DEBUG_REQUESTS     /* fsf_req tracing */
-#define ZFCP_DEBUG_COMMANDS     /* host_byte tracing */
-#define ZFCP_DEBUG_ABORTS       /* scsi_cmnd abort tracing */
-#define ZFCP_DEBUG_INCOMING_ELS /* incoming ELS tracing */
 #define	ZFCP_STAT_REQSIZES
 #define	ZFCP_STAT_QUEUES
 
@@ -723,11 +723,6 @@
 
 #define ZFCP_CFDC_MAX_CONTROL_FILE_SIZE		127 * 1024
 
-static const char zfcp_act_subtable_type[5][8] = {
-	{"unknown"}, {"OS"}, {"WWPN"}, {"DID"}, {"LUN"}
-};
-
-
 /************************* STRUCTURE DEFINITIONS *****************************/
 
 struct zfcp_fsf_req;
@@ -937,8 +932,6 @@
 
 
 struct zfcp_adapter {
-	u32			common_magic;	   /* driver common magic */
-	u32			specific_magic;	   /* struct specific magic */
 	struct list_head	list;              /* list of adapters */
 	atomic_t                refcount;          /* reference count */
 	wait_queue_head_t	remove_wq;         /* can be used to wait for
@@ -956,14 +949,12 @@
         u32			hardware_version;  /* of FCP channel */
         u8			serial_number[32]; /* of hardware */
 	struct Scsi_Host	*scsi_host;	   /* Pointer to mid-layer */
-
+	unsigned short          scsi_host_no;      /* Assigned host number */
 	unsigned char		name[9];
 	struct list_head	port_list_head;	   /* remote port list */
 	struct list_head        port_remove_lh;    /* head of ports to be
 						      removed */
 	u32			ports;	           /* number of remote ports */
-	scsi_id_t		max_scsi_id;	   /* largest SCSI ID */
-	scsi_lun_t		max_scsi_lun;	   /* largest SCSI LUN */
         struct timer_list       scsi_er_timer;     /* SCSI err recovery watch */
 	struct list_head	fsf_req_list_head; /* head of FSF req list */
 	rwlock_t		fsf_req_list_lock; /* lock for ops on list of
@@ -1003,9 +994,13 @@
 	struct qdio_initialize  qdio_init_data;    /* for qdio_establish */
 };
 
+/*
+ * the struct device sysfs_device must be at the beginning of this structure.
+ * pointer to struct device is used to free port structure in release function
+ * of the device. don't change!
+ */
 struct zfcp_port {
-	u32		       common_magic;   /* driver wide common magic */
-	u32		       specific_magic; /* structure specific magic */
+	struct device          sysfs_device;   /* sysfs device */
 	struct list_head       list;	       /* list of remote ports */
 	atomic_t               refcount;       /* reference count */
 	wait_queue_head_t      remove_wq;      /* can be used to wait for
@@ -1020,37 +1015,36 @@
 	wwn_t		       wwnn;	       /* WWNN if known */
 	wwn_t		       wwpn;	       /* WWPN */
 	fc_id_t		       d_id;	       /* D_ID */
-	scsi_lun_t	       max_scsi_lun;   /* largest SCSI LUN */
 	u32		       handle;	       /* handle assigned by FSF */
 	struct zfcp_erp_action erp_action;     /* pending error recovery */
         atomic_t               erp_counter;
-	struct device          sysfs_device;   /* sysfs device */
 };
 
+/* the struct device sysfs_device must be at the beginning of this structure.
+ * pointer to struct device is used to free unit structure in release function
+ * of the device. don't change!
+ */
 struct zfcp_unit {
-	u32		       common_magic;   /* driver wide common magic */
-	u32		       specific_magic; /* structure specific magic */
+	struct device          sysfs_device;   /* sysfs device */
 	struct list_head       list;	       /* list of logical units */
 	atomic_t               refcount;       /* reference count */
 	wait_queue_head_t      remove_wq;      /* can be used to wait for
 						  refcount drop to zero */
 	struct zfcp_port       *port;	       /* remote port of unit */
 	atomic_t	       status;	       /* status of this logical unit */
+	u32		       lun_access;     /* access flags for this unit */
 	scsi_lun_t	       scsi_lun;       /* own SCSI LUN */
 	fcp_lun_t	       fcp_lun;	       /* own FCP_LUN */
 	u32		       handle;	       /* handle assigned by FSF */
         struct scsi_device     *device;        /* scsi device struct pointer */
 	struct zfcp_erp_action erp_action;     /* pending error recovery */
         atomic_t               erp_counter;
-	struct device          sysfs_device;   /* sysfs device */
 	atomic_t               scsi_add_work;  /* used to synchronize */
 	wait_queue_head_t      scsi_add_wq;    /* wait for scsi_add_device */
 };
 
 /* FSF request */
 struct zfcp_fsf_req {
-	u32		       common_magic;   /* driver wide common magic */
-	u32		       specific_magic; /* structure specific magic */
 	struct list_head       list;	       /* list of FSF requests */
 	struct zfcp_adapter    *adapter;       /* adapter request belongs to */
 	u8		       sbal_number;    /* nr of SBALs free for use */
@@ -1158,13 +1152,6 @@
 #define ZFCP_INTERRUPTIBLE	1
 #define ZFCP_UNINTERRUPTIBLE	0
 
-/* some magics which may be used to authenticate data structures */
-#define ZFCP_MAGIC		0xFCFCFCFC
-#define ZFCP_MAGIC_ADAPTER	0xAAAAAAAA
-#define ZFCP_MAGIC_PORT		0xBBBBBBBB
-#define ZFCP_MAGIC_UNIT		0xCCCCCCCC
-#define ZFCP_MAGIC_FSFREQ	0xEEEEEEEE
-
 #ifndef atomic_test_mask
 #define atomic_test_mask(mask, target) \
            ((atomic_read(target) & mask) == mask)
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Sun Apr  4 05:36:26 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Thu Apr  8 15:21:27 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.44 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.49 $"
 
 #include "zfcp_ext.h"
 
@@ -1202,7 +1202,7 @@
  * returns:	0 - there was an action to handle
  *		!0 - otherwise
  */
-static int
+int
 zfcp_erp_async_handler(struct zfcp_erp_action *erp_action,
 		       unsigned long set_mask)
 {
@@ -1218,28 +1218,6 @@
 }
 
 /*
- * purpose:	is called for finished FSF requests related to erp,
- *		moves concerned erp action to 'ready' queue and
- *		signals erp thread to process it,
- *		besides it cancels a timeout
- */
-void
-zfcp_erp_fsf_req_handler(struct zfcp_fsf_req *fsf_req)
-{
-	struct zfcp_erp_action *erp_action = fsf_req->erp_action;
-	struct zfcp_adapter *adapter = fsf_req->adapter;
-
-	debug_text_event(adapter->erp_dbf, 3, "a_frh");
-	debug_event(adapter->erp_dbf, 3, &erp_action->action, sizeof (int));
-
-	if (erp_action) {
-		debug_event(adapter->erp_dbf, 3, &erp_action->action,
-			    sizeof (int));
-		zfcp_erp_async_handler(erp_action, 0);
-	}
-}
-
-/*
  * purpose:	is called for erp_action which was slept waiting for
  *		memory becoming avaliable,
  *		will trigger that this action will be continued
@@ -1892,7 +1870,7 @@
 			      unit->fcp_lun,
 			      unit->port->wwpn,
 			      zfcp_get_busid_by_unit(unit));
-		atomic_set(&p->unit->scsi_add_work, 0);
+		atomic_set(&unit->scsi_add_work, 0);
 		return -ENOMEM;
 	}
 
@@ -2500,10 +2478,8 @@
 		    ("bug: Could not clean QDIO (data transfer mechanism) "
 		     "queues. (debug info %i).\n", retval_cleanup);
 	}
-#ifdef ZFCP_DEBUG_REQUESTS
 	else
 		debug_text_event(adapter->req_dbf, 1, "q_clean");
-#endif				/* ZFCP_DEBUG_REQUESTS */
 
  failed_qdio_establish:
 	atomic_clear_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status);
@@ -2577,9 +2553,7 @@
 		     zfcp_get_busid_by_adapter(adapter));
 	} else {
 		ZFCP_LOG_DEBUG("queues cleaned up\n");
-#ifdef ZFCP_DEBUG_REQUESTS
 		debug_text_event(adapter->req_dbf, 1, "q_clean");
-#endif				/* ZFCP_DEBUG_REQUESTS */
 	}
 
 	/*
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	Sun Apr  4 05:36:45 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h	Thu Apr  8 15:21:27 2004
@@ -31,7 +31,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.45 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.49 $"
 
 #include "zfcp_def.h"
 
@@ -55,7 +55,9 @@
 extern struct zfcp_port *zfcp_get_port_by_wwpn(struct zfcp_adapter *,
 					       wwn_t wwpn);
 extern struct zfcp_adapter *zfcp_adapter_enqueue(struct ccw_device *);
+extern int    zfcp_adapter_debug_register(struct zfcp_adapter *);
 extern void   zfcp_adapter_dequeue(struct zfcp_adapter *);
+extern void   zfcp_adapter_debug_unregister(struct zfcp_adapter *);
 extern struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *, wwn_t, u32);
 extern void   zfcp_port_dequeue(struct zfcp_port *);
 extern struct zfcp_unit *zfcp_unit_enqueue(struct zfcp_port *, fcp_lun_t);
@@ -158,7 +160,7 @@
 extern int  zfcp_erp_thread_setup(struct zfcp_adapter *);
 extern int  zfcp_erp_thread_kill(struct zfcp_adapter *);
 extern int  zfcp_erp_wait(struct zfcp_adapter *);
-extern void zfcp_erp_fsf_req_handler(struct zfcp_fsf_req *);
+extern int  zfcp_erp_async_handler(struct zfcp_erp_action *, unsigned long);
 
 extern int  zfcp_test_link(struct zfcp_port *);
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Sun Apr  4 05:37:37 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Thu Apr  8 15:21:27 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.29 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.43 $"
 
 #include "zfcp_ext.h"
 
@@ -78,6 +78,11 @@
 	[FSF_QTCB_UPLOAD_CONTROL_FILE] =  FSF_SUPPORT_COMMAND
 };
 
+static const char zfcp_act_subtable_type[5][8] = {
+	{"unknown"}, {"OS"}, {"WWPN"}, {"DID"}, {"LUN"}
+};
+
+
 /****************************************************************/
 /*************** FSF related Functions  *************************/
 /****************************************************************/
@@ -320,7 +325,7 @@
 			     sizeof(struct fsf_qtcb));
 			goto forget_log;
 		}
-		if ((fsf_req->qtcb->header.log_start +
+		if ((size_t) (fsf_req->qtcb->header.log_start +
 		     fsf_req->qtcb->header.log_length)
 		    > sizeof(struct fsf_qtcb)) {
 			ZFCP_LOG_NORMAL("bug: ULP (FSF logging) log data ends "
@@ -388,7 +393,6 @@
 				zfcp_get_busid_by_adapter(adapter),
 				fsf_req->qtcb->prefix.prot_status_qual.
 				sequence_error.exp_req_seq_no);
-#ifdef ZFCP_DEBUG_REQUESTS
 		debug_text_event(adapter->req_dbf, 1, "exp_seq!");
 		debug_event(adapter->req_dbf, 1,
 			    &fsf_req->qtcb->prefix.prot_status_qual.
@@ -396,7 +400,6 @@
 		debug_text_event(adapter->req_dbf, 1, "qtcb_seq!");
 		debug_exception(adapter->req_dbf, 1,
 				&fsf_req->qtcb->prefix.req_seq_no, 4);
-#endif				/* ZFCP_DEBUG_REQUESTS */
 		debug_text_exception(adapter->erp_dbf, 0, "prot_seq_err");
 		/* restart operation on this adapter */
 		zfcp_erp_adapter_reopen(adapter, 0);
@@ -771,6 +774,8 @@
 static int
 zfcp_fsf_req_dispatch(struct zfcp_fsf_req *fsf_req)
 {
+	struct zfcp_erp_action *erp_action = fsf_req->erp_action;
+	struct zfcp_adapter *adapter = fsf_req->adapter;
 	int retval = 0;
 
 	if (unlikely(fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR)) {
@@ -861,7 +866,13 @@
 			     fsf_req->qtcb->header.fsf_command);
 	}
 
-        zfcp_erp_fsf_req_handler(fsf_req);
+	if (!erp_action)
+		return retval;
+
+	debug_text_event(adapter->erp_dbf, 3, "a_frh");
+	debug_event(adapter->erp_dbf, 3, &erp_action->action, sizeof (int));
+	zfcp_erp_async_handler(erp_action, 0);
+
 	return retval;
 }
 
@@ -924,9 +935,7 @@
 	ZFCP_LOG_TRACE("Status Read request initiated "
 		       "(adapter busid=%s)\n",
 		       zfcp_get_busid_by_adapter(adapter));
-#ifdef ZFCP_DEBUG_REQUESTS
 	debug_text_event(adapter->req_dbf, 1, "unso");
-#endif
 	goto out;
 
  failed_req_send:
@@ -1044,8 +1053,12 @@
 
 	case FSF_STATUS_READ_LINK_DOWN:
 		ZFCP_LOG_FLAGS(1, "FSF_STATUS_READ_LINK_DOWN\n");
-
-		/* Unneccessary, ignoring.... */
+		debug_text_event(adapter->erp_dbf, 0, "unsol_link_down:");
+		ZFCP_LOG_INFO("Local link to adapter %s is down\n",
+			      zfcp_get_busid_by_adapter(adapter));
+		atomic_set_mask(ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED,
+				&adapter->status);
+		zfcp_erp_adapter_failed(adapter);
 		break;
 
 	case FSF_STATUS_READ_LINK_UP:
@@ -1065,27 +1078,6 @@
 
 		break;
 
-	case FSF_STATUS_READ_NOTIFICATION_LOST:
-		ZFCP_LOG_FLAGS(1, "FSF_STATUS_READ_NOTIFICATION_LOST\n");
-		debug_text_event(adapter->erp_dbf, 2, "unsol_not_lost:");
-		switch (status_buffer->status_subtype) {
-		case FSF_STATUS_READ_SUB_LOST_CFDC_UPDATED:
-			ZFCP_LOG_NORMAL(
-				"The unsolicited status information about "
-				"CFDC update on the adapter %s is lost "
-				"due to the lack of internal resources\n",
-				zfcp_get_busid_by_adapter(adapter));
-			break;
-		case FSF_STATUS_READ_SUB_LOST_CFDC_HARDENED:
-			ZFCP_LOG_NORMAL(
-				"The unsolicited status information about "
-				"CFDC harden on the adapter %s is lost "
-				"due to the lack of internal resources\n",
-				zfcp_get_busid_by_adapter(adapter));
-			break;
-		}
-		break;
-
 	case FSF_STATUS_READ_CFDC_UPDATED:
 		ZFCP_LOG_FLAGS(1, "FSF_STATUS_READ_CFDC_UPDATED\n");
 		debug_text_event(adapter->erp_dbf, 2, "unsol_cfdc_update:");
@@ -1344,16 +1336,10 @@
 	case FSF_FCP_COMMAND_DOES_NOT_EXIST:
 		ZFCP_LOG_FLAGS(2, "FSF_FCP_COMMAND_DOES_NOT_EXIST\n");
 		retval = 0;
-#ifdef ZFCP_DEBUG_REQUESTS
-		/*
-		 * debug feature area which records
-		 * fsf request sequence numbers
-		 */
 		debug_text_event(new_fsf_req->adapter->req_dbf, 3, "no_exist");
 		debug_event(new_fsf_req->adapter->req_dbf, 3,
 			    &new_fsf_req->qtcb->bottom.support.req_handle,
 			    sizeof (unsigned long));
-#endif				/* ZFCP_DEBUG_REQUESTS */
 		debug_text_event(new_fsf_req->adapter->erp_dbf, 3,
 				 "fsf_s_no_exist");
 		new_fsf_req->status |= ZFCP_STATUS_FSFREQ_ABORTNOTNEEDED;
@@ -1670,20 +1656,19 @@
 				"to a port with WWPN 0x%Lx connected "
 				"to the adapter %s\n", port->wwpn,
 				zfcp_get_busid_by_port(port));
-		counter = 0;
-		do {
-			subtable = header->fsf_status_qual.halfword[counter++];
-			rule = header->fsf_status_qual.halfword[counter++];
+		for (counter = 0; counter < 2; counter++) {
+			subtable = header->fsf_status_qual.halfword[counter * 2];
+			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
 			switch (subtable) {
 			case FSF_SQ_CFDC_SUBTABLE_OS:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_DID:
 			case FSF_SQ_CFDC_SUBTABLE_LUN:
-       				ZFCP_LOG_NORMAL("Access denied (%s rule %d)\n",
+       				ZFCP_LOG_INFO("Access denied (%s rule %d)\n",
 					zfcp_act_subtable_type[subtable], rule);
 				break;
 			}
-		} while (counter < 4);
+		}
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -2036,20 +2021,19 @@
 		ZFCP_LOG_NORMAL("Access denied, cannot send ELS "
 				"(adapter: %s, wwpn=0x%016Lx)\n",
 				zfcp_get_busid_by_port(port), port->wwpn);
-		counter = 0;
-		do {
-			subtable = header->fsf_status_qual.halfword[counter++];
-			rule = header->fsf_status_qual.halfword[counter++];
+		for (counter = 0; counter < 2; counter++) {
+			subtable = header->fsf_status_qual.halfword[counter * 2];
+			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
 			switch (subtable) {
 			case FSF_SQ_CFDC_SUBTABLE_OS:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_DID:
 			case FSF_SQ_CFDC_SUBTABLE_LUN:
-				ZFCP_LOG_NORMAL("Access denied (%s rule %d)\n",
+				ZFCP_LOG_INFO("Access denied (%s rule %d)\n",
 					zfcp_act_subtable_type[subtable], rule);
 				break;
 			}
-		} while (counter < 4);
+		}
 		debug_text_event(adapter->erp_dbf, 1, "fsf_s_access");
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -2114,7 +2098,8 @@
 
 	erp_action->fsf_req->erp_action = erp_action;
 	erp_action->fsf_req->qtcb->bottom.config.feature_selection =
-		FSF_FEATURE_CFDC;
+		FSF_FEATURE_CFDC |
+		FSF_FEATURE_LOST_SAN_NOTIFICATION;
 
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
@@ -2138,6 +2123,84 @@
 	return retval;
 }
 
+/**
+ * zfcp_fsf_exchange_config_evaluate
+ * @fsf_req: fsf_req which belongs to xchg config data request
+ * @xchg_ok: specifies if xchg config data was incomplete or complete (0/1)
+ *
+ * returns: -EIO on error, 0 otherwise
+ */
+static int
+zfcp_fsf_exchange_config_evaluate(struct zfcp_fsf_req *fsf_req, int xchg_ok)
+{
+	struct fsf_qtcb_bottom_config *bottom;
+	struct zfcp_adapter *adapter = fsf_req->adapter;
+
+	bottom = &fsf_req->qtcb->bottom.config;
+	ZFCP_LOG_DEBUG("low/high QTCB version 0x%x/0x%x of FSF\n",
+		       bottom->low_qtcb_version, bottom->high_qtcb_version);
+	adapter->fsf_lic_version = bottom->lic_version;
+	adapter->supported_features = bottom->supported_features;
+
+	if (xchg_ok) {
+		adapter->wwnn = bottom->nport_serv_param.wwnn;
+		adapter->wwpn = bottom->nport_serv_param.wwpn;
+		adapter->s_id = bottom->s_id & ZFCP_DID_MASK;
+		adapter->fc_topology = bottom->fc_topology;
+		adapter->fc_link_speed = bottom->fc_link_speed;
+		adapter->hydra_version = bottom->adapter_type;
+	} else {
+		adapter->wwnn = 0;
+		adapter->wwpn = 0;
+		adapter->s_id = 0;
+		adapter->fc_topology = 0;
+		adapter->fc_link_speed = 0;
+		adapter->hydra_version = 0;
+	}
+
+	if(adapter->supported_features & FSF_FEATURE_HBAAPI_MANAGEMENT){
+		adapter->hardware_version = bottom->hardware_version;
+		memcpy(adapter->serial_number, bottom->serial_number, 17);
+		EBCASC(adapter->serial_number, sizeof(adapter->serial_number));
+	}
+
+	ZFCP_LOG_INFO("The adapter %s reported the following characteristics:\n"
+		      "WWNN 0x%016Lx, "
+		      "WWPN 0x%016Lx, "
+		      "S_ID 0x%08x,\n"
+		      "adapter version 0x%x, "
+		      "LIC version 0x%x, "
+		      "FC link speed %d Gb/s\n",
+		      zfcp_get_busid_by_adapter(adapter),
+		      adapter->wwnn,
+		      adapter->wwpn,
+		      (unsigned int) adapter->s_id,
+		      adapter->hydra_version,
+		      adapter->fsf_lic_version,
+		      adapter->fc_link_speed);
+	if (ZFCP_QTCB_VERSION < bottom->low_qtcb_version) {
+		ZFCP_LOG_NORMAL("error: the adapter %s "
+				"only supports newer control block "
+				"versions in comparison to this device "
+				"driver (try updated device driver)\n",
+				zfcp_get_busid_by_adapter(adapter));
+		debug_text_event(adapter->erp_dbf, 0, "low_qtcb_ver");
+		zfcp_erp_adapter_shutdown(adapter, 0);
+		return -EIO;
+	}
+	if (ZFCP_QTCB_VERSION > bottom->high_qtcb_version) {
+		ZFCP_LOG_NORMAL("error: the adapter %s "
+				"only supports older control block "
+				"versions than this device driver uses"
+				"(consider a microcode upgrade)\n",
+				zfcp_get_busid_by_adapter(adapter));
+		debug_text_event(adapter->erp_dbf, 0, "high_qtcb_ver");
+		zfcp_erp_adapter_shutdown(adapter, 0);
+		return -EIO;
+	}
+	return 0;
+}
+
 /*
  * function:    zfcp_fsf_exchange_config_data_handler
  *
@@ -2148,81 +2211,20 @@
 static int
 zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *fsf_req)
 {
-	int retval = -EIO;
 	struct fsf_qtcb_bottom_config *bottom;
 	struct zfcp_adapter *adapter = fsf_req->adapter;
 
-	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR) {
-		/* don't set any value, stay with the old (unitialized) ones */
-		goto skip_fsfstatus;
-	}
+	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR)
+		return -EIO;
 
-	/* evaluate FSF status in QTCB */
 	switch (fsf_req->qtcb->header.fsf_status) {
 
 	case FSF_GOOD:
 		ZFCP_LOG_FLAGS(2, "FSF_GOOD\n");
-		bottom = &fsf_req->qtcb->bottom.config;
-		/* only log QTCB versions for now */
-		ZFCP_LOG_DEBUG("low QTCB version 0x%x of FSF, "
-			       "high QTCB version 0x%x of FSF, \n",
-			       bottom->low_qtcb_version,
-			       bottom->high_qtcb_version);
-		adapter->wwnn = bottom->nport_serv_param.wwnn;
-		adapter->wwpn = bottom->nport_serv_param.wwpn;
-		adapter->s_id = bottom->s_id & ZFCP_DID_MASK;
-		adapter->hydra_version = bottom->adapter_type;
-		adapter->fsf_lic_version = bottom->lic_version;
-		adapter->fc_topology = bottom->fc_topology;
-		adapter->fc_link_speed = bottom->fc_link_speed;
-                adapter->supported_features = bottom->supported_features;
 
-		if(adapter->supported_features & FSF_FEATURE_HBAAPI_MANAGEMENT){
-			adapter->hardware_version = bottom->hardware_version;
-                        /* copy just first 17 bytes */
-                        memcpy(adapter->serial_number,
-                               bottom->serial_number, 17);
-                        EBCASC(adapter->serial_number,
-                               sizeof(adapter->serial_number));
-		}
+		if (zfcp_fsf_exchange_config_evaluate(fsf_req, 1))
+			return -EIO;
 
-		ZFCP_LOG_INFO("The adapter %s reported "
-			      "the following characteristics:\n"
-			      "WWNN 0x%16.16Lx, "
-			      "WWPN 0x%16.16Lx, "
-			      "S_ID 0x%6.6x,\n"
-			      "adapter version 0x%x, "
-			      "LIC version 0x%x, "
-			      "FC link speed %d Gb/s\n",
-			      zfcp_get_busid_by_adapter(adapter),
-			      adapter->wwnn,
-			      adapter->wwpn,
-			      (unsigned int) adapter->s_id,
-			      adapter->hydra_version,
-			      adapter->fsf_lic_version,
-			      adapter->fc_link_speed);
-		if (ZFCP_QTCB_VERSION < bottom->low_qtcb_version) {
-			ZFCP_LOG_NORMAL("error: the adapter %s "
-					"only supports newer control block "
-					"versions in comparison to this device "
-					"driver (try updated device driver)\n",
-					zfcp_get_busid_by_adapter(adapter));
-			debug_text_event(fsf_req->adapter->erp_dbf, 0,
-					 "low_qtcb_ver");
-			zfcp_erp_adapter_shutdown(adapter, 0);
-			goto skip_fsfstatus;
-		}
-		if (ZFCP_QTCB_VERSION > bottom->high_qtcb_version) {
-			ZFCP_LOG_NORMAL("error: the adapter %s "
-					"only supports older control block "
-					"versions than this device driver uses"
-					"(consider a microcode upgrade)\n",
-					zfcp_get_busid_by_adapter(adapter));
-			debug_text_event(fsf_req->adapter->erp_dbf, 0,
-					 "high_qtcb_ver");
-			zfcp_erp_adapter_shutdown(adapter, 0);
-			goto skip_fsfstatus;
-		}
 		switch (adapter->fc_topology) {
 		case FSF_TOPO_P2P:
 			ZFCP_LOG_FLAGS(1, "FSF_TOPO_P2P\n");
@@ -2234,7 +2236,7 @@
 			debug_text_event(fsf_req->adapter->erp_dbf, 0,
 					 "top-p-to-p");
 			zfcp_erp_adapter_shutdown(adapter, 0);
-			goto skip_fsfstatus;
+			return -EIO;
 		case FSF_TOPO_AL:
 			ZFCP_LOG_FLAGS(1, "FSF_TOPO_AL\n");
 			ZFCP_LOG_NORMAL("error: Arbitrated loop fibre-channel "
@@ -2245,7 +2247,7 @@
 			debug_text_event(fsf_req->adapter->erp_dbf, 0,
 					 "top-al");
 			zfcp_erp_adapter_shutdown(adapter, 0);
-			goto skip_fsfstatus;
+			return -EIO;
 		case FSF_TOPO_FABRIC:
 			ZFCP_LOG_FLAGS(1, "FSF_TOPO_FABRIC\n");
 			ZFCP_LOG_INFO("Switched fabric fibre-channel "
@@ -2264,8 +2266,9 @@
 			debug_text_exception(fsf_req->adapter->erp_dbf, 0,
 					     "unknown-topo");
 			zfcp_erp_adapter_shutdown(adapter, 0);
-			goto skip_fsfstatus;
+			return -EIO;
 		}
+		bottom = &fsf_req->qtcb->bottom.config;
 		if (bottom->max_qtcb_size < sizeof(struct fsf_qtcb)) {
 			ZFCP_LOG_NORMAL("bug: Maximum QTCB size (%d bytes) "
 					"allowed by the adapter %s "
@@ -2279,22 +2282,32 @@
 			debug_event(fsf_req->adapter->erp_dbf, 0,
 				    &bottom->max_qtcb_size, sizeof (u32));
 			zfcp_erp_adapter_shutdown(adapter, 0);
-			goto skip_fsfstatus;
+			return -EIO;
 		}
 		atomic_set_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK,
 				&adapter->status);
-		retval = 0;
-
 		break;
+	case FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE:
+		debug_text_event(adapter->erp_dbf, 0, "xchg-inco");
+
+		if (zfcp_fsf_exchange_config_evaluate(fsf_req, 0))
+			return -EIO;
 
+		ZFCP_LOG_INFO("Local link to adapter %s is down\n",
+			      zfcp_get_busid_by_adapter(adapter));
+		atomic_set_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK |
+				ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED,
+				&adapter->status);
+		zfcp_erp_adapter_failed(adapter);
+		break;
 	default:
-		/* retval is -EIO by default */
 		debug_text_event(fsf_req->adapter->erp_dbf, 0, "fsf-stat-ng");
 		debug_event(fsf_req->adapter->erp_dbf, 0,
 			    &fsf_req->qtcb->header.fsf_status, sizeof (u32));
+		zfcp_erp_adapter_shutdown(adapter, 0);
+		return -EIO;
 	}
- skip_fsfstatus:
-	return retval;
+	return 0;
 }
 
 /*
@@ -2408,20 +2421,19 @@
 		ZFCP_LOG_NORMAL("Access denied, cannot open port "
 			"with WWPN 0x%Lx connected to the adapter %s\n",
 			port->wwpn, zfcp_get_busid_by_port(port));
-		counter = 0;
-		do {
-			subtable = header->fsf_status_qual.halfword[counter++];
-			rule = header->fsf_status_qual.halfword[counter++];
+		for (counter = 0; counter < 2; counter++) {
+			subtable = header->fsf_status_qual.halfword[counter * 2];
+			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
 			switch (subtable) {
 			case FSF_SQ_CFDC_SUBTABLE_OS:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_DID:
 			case FSF_SQ_CFDC_SUBTABLE_LUN:
-				ZFCP_LOG_NORMAL("Access denied (%s rule %d)\n",
+				ZFCP_LOG_INFO("Access denied (%s rule %d)\n",
 					zfcp_act_subtable_type[subtable], rule);
 				break;
 			}
-		} while (counter < 4);
+		}
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
 		zfcp_erp_port_failed(port);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
@@ -2814,20 +2826,19 @@
 				"physical port with WWPN 0x%Lx connected to "
 				"the adapter %s\n", port->wwpn,
 				zfcp_get_busid_by_port(port));
-		counter = 0;
-		do {
-			subtable = header->fsf_status_qual.halfword[counter++];
-			rule = header->fsf_status_qual.halfword[counter++];
+		for (counter = 0; counter < 2; counter++) {
+			subtable = header->fsf_status_qual.halfword[counter * 2];
+			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
 			switch (subtable) {
 			case FSF_SQ_CFDC_SUBTABLE_OS:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_DID:
 			case FSF_SQ_CFDC_SUBTABLE_LUN:
-	       			ZFCP_LOG_NORMAL("Access denied (%s rule %d)\n",
+	       			ZFCP_LOG_INFO("Access denied (%s rule %d)\n",
 					zfcp_act_subtable_type[subtable], rule);
 				break;
 			}
-		} while (counter < 4);
+		}
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -2956,8 +2967,8 @@
 	atomic_set_mask(ZFCP_STATUS_COMMON_OPENING, &erp_action->unit->status);
 	erp_action->fsf_req->data.open_unit.unit = erp_action->unit;
 	erp_action->fsf_req->erp_action = erp_action;
-	erp_action->fsf_req->qtcb->bottom.support.option =
-		FSF_OPEN_LUN_SUPPRESS_BOXING;
+//	erp_action->fsf_req->qtcb->bottom.support.option =
+//		FSF_OPEN_LUN_UNSOLICITED_SENSE_DATA;
 
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
@@ -2994,12 +3005,16 @@
 zfcp_fsf_open_unit_handler(struct zfcp_fsf_req *fsf_req)
 {
 	int retval = -EINVAL;
+	struct zfcp_adapter *adapter;
 	struct zfcp_unit *unit;
 	struct fsf_qtcb_header *header;
+	struct fsf_qtcb_bottom_support *bottom;
 	u16 subtable, rule, counter;
 
+	adapter = fsf_req->adapter;
 	unit = fsf_req->data.open_unit.unit;
 	header = &fsf_req->qtcb->header;
+	bottom = &fsf_req->qtcb->bottom.support;
 
 	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR) {
 		/* don't change unit status in our bookkeeping */
@@ -3021,7 +3036,7 @@
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
 			      (char *) &header->fsf_status_qual,
 			      sizeof (union fsf_status_qual));
-		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_ph_nv");
+		debug_text_event(adapter->erp_dbf, 1, "fsf_s_ph_nv");
 		zfcp_erp_adapter_reopen(unit->port->adapter, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -3034,7 +3049,7 @@
 				"to the adapter %s twice.\n",
 				unit->fcp_lun,
 				unit->port->wwpn, zfcp_get_busid_by_unit(unit));
-		debug_text_exception(fsf_req->adapter->erp_dbf, 0,
+		debug_text_exception(adapter->erp_dbf, 0,
 				     "fsf_s_uopen");
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -3046,21 +3061,20 @@
 				"WWPN 0x%Lx connected to the adapter %s\n",
 			unit->fcp_lun, unit->port->wwpn,
 			zfcp_get_busid_by_unit(unit));
-		counter = 0;
-		do {
-			subtable = header->fsf_status_qual.halfword[counter++];
-			rule = header->fsf_status_qual.halfword[counter++];
+		for (counter = 0; counter < 2; counter++) {
+			subtable = header->fsf_status_qual.halfword[counter * 2];
+			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
 			switch (subtable) {
 			case FSF_SQ_CFDC_SUBTABLE_OS:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_DID:
 			case FSF_SQ_CFDC_SUBTABLE_LUN:
-				ZFCP_LOG_NORMAL("Access denied (%s rule %d)\n",
+				ZFCP_LOG_INFO("Access denied (%s rule %d)\n",
 					zfcp_act_subtable_type[subtable], rule);
 				break;
 			}
-		} while (counter < 4);
-		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
+		}
+		debug_text_event(adapter->erp_dbf, 1, "fsf_s_access");
 		zfcp_erp_unit_failed(unit);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -3071,7 +3085,7 @@
 			       "with WWPN 0x%Lx on the adapter %s "
 			       "needs to be reopened\n",
 			       unit->port->wwpn, zfcp_get_busid_by_unit(unit));
-		debug_text_event(fsf_req->adapter->erp_dbf, 2, "fsf_s_pboxed");
+		debug_text_event(adapter->erp_dbf, 2, "fsf_s_pboxed");
 		zfcp_erp_port_reopen(unit->port, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR |
 			ZFCP_STATUS_FSFREQ_RETRY;
@@ -3079,30 +3093,38 @@
 
 	case FSF_LUN_SHARING_VIOLATION :
 		ZFCP_LOG_FLAGS(2, "FSF_LUN_SHARING_VIOLATION\n");
-		ZFCP_LOG_NORMAL("error: FCP-LUN 0x%Lx at "
-				"the remote port with WWPN 0x%Lx connected "
-				"to the adapter %s "
-				"is already owned by another operating system "
-				"instance (LPAR or VM guest)\n",
-				unit->fcp_lun,
-				unit->port->wwpn,
-				zfcp_get_busid_by_unit(unit));
 		subtable = header->fsf_status_qual.halfword[4];
 		rule = header->fsf_status_qual.halfword[5];
-		switch (subtable) {
-		case FSF_SQ_CFDC_SUBTABLE_OS:
-		case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
-		case FSF_SQ_CFDC_SUBTABLE_PORT_DID:
-		case FSF_SQ_CFDC_SUBTABLE_LUN:
-			ZFCP_LOG_NORMAL("Access denied (%s rule %d)\n",
-				zfcp_act_subtable_type[subtable], rule);
-			break;
+		if (rule == 0xFFFF) {
+			ZFCP_LOG_NORMAL("FCP-LUN 0x%Lx at the remote port "
+					"with WWPN 0x%Lx connected to the "
+					"adapter %s is already in use\n",
+					unit->fcp_lun,
+					unit->port->wwpn,
+					zfcp_get_busid_by_unit(unit));
+		} else {
+			switch (subtable) {
+			case FSF_SQ_CFDC_SUBTABLE_OS:
+			case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
+			case FSF_SQ_CFDC_SUBTABLE_PORT_DID:
+			case FSF_SQ_CFDC_SUBTABLE_LUN:
+				ZFCP_LOG_NORMAL("Access to FCP-LUN 0x%Lx at the "
+						"remote port with WWPN 0x%Lx "
+						"connected to the adapter %s "
+						"is denied (%s rule %d)\n",
+						unit->fcp_lun,
+						unit->port->wwpn,
+						zfcp_get_busid_by_unit(unit),
+						zfcp_act_subtable_type[subtable],
+						rule);
+				break;
+			}
 		}
-		ZFCP_LOG_NORMAL("Additional sense data is presented:\n");
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
+		ZFCP_LOG_DEBUG("status qualifier:\n");
+		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
 			      (char *) &header->fsf_status_qual,
 			      sizeof (union fsf_status_qual));
-		debug_text_event(fsf_req->adapter->erp_dbf, 2,
+		debug_text_event(adapter->erp_dbf, 2,
 				 "fsf_s_l_sh_vio");
 		zfcp_erp_unit_failed(unit);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
@@ -3118,7 +3140,7 @@
 			      unit->fcp_lun,
 			      unit->port->wwpn,
 			      zfcp_get_busid_by_unit(unit));
-		debug_text_event(fsf_req->adapter->erp_dbf, 1,
+		debug_text_event(adapter->erp_dbf, 1,
 				 "fsf_s_max_units");
 		zfcp_erp_unit_failed(unit);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
@@ -3131,7 +3153,7 @@
 			ZFCP_LOG_FLAGS(2,
 				       "FSF_SQ_INVOKE_LINK_TEST_PROCEDURE\n");
 			/* Re-establish link to port */
-			debug_text_event(fsf_req->adapter->erp_dbf, 1,
+			debug_text_event(adapter->erp_dbf, 1,
 					 "fsf_sq_ltest");
 			zfcp_erp_port_reopen(unit->port, 0);
 			fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
@@ -3140,7 +3162,7 @@
 			ZFCP_LOG_FLAGS(2,
 				       "FSF_SQ_ULP_DEPENDENT_ERP_REQUIRED\n");
 			/* ERP strategy will escalate */
-			debug_text_event(fsf_req->adapter->erp_dbf, 1,
+			debug_text_event(adapter->erp_dbf, 1,
 					 "fsf_sq_ulp");
 			fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 			break;
@@ -3148,27 +3170,41 @@
 			ZFCP_LOG_NORMAL
 			    ("bug: Wrong status qualifier 0x%x arrived.\n",
 			     header->fsf_status_qual.word[0]);
-			debug_text_event(fsf_req->adapter->erp_dbf, 0,
+			debug_text_event(adapter->erp_dbf, 0,
 					 "fsf_sq_inval:");
-			debug_exception(fsf_req->adapter->erp_dbf, 0,
+			debug_exception(adapter->erp_dbf, 0,
 					&header->fsf_status_qual.word[0],
 				sizeof (u32));
 		}
 		break;
 
+	case FSF_INVALID_COMMAND_OPTION:
+		ZFCP_LOG_FLAGS(2, "FSF_INVALID_COMMAND_OPTION\n");
+		ZFCP_LOG_NORMAL(
+			"Invalid option 0x%x has been specified "
+			"in QTCB bottom sent to the adapter %s\n",
+			bottom->option,
+			zfcp_get_busid_by_adapter(adapter));
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		retval = -EINVAL;
+		break;
+
 	case FSF_GOOD:
 		ZFCP_LOG_FLAGS(3, "FSF_GOOD\n");
 		/* save LUN handle assigned by FSF */
 		unit->handle = header->lun_handle;
 		ZFCP_LOG_TRACE("unit (FCP_LUN=0x%Lx) of remote port "
 			       "(WWPN=0x%Lx) via adapter (busid=%s) opened, "
-			       "port handle 0x%x \n",
+			       "port handle 0x%x, access flag 0x%02x\n",
 			       unit->fcp_lun,
 			       unit->port->wwpn,
 			       zfcp_get_busid_by_unit(unit),
-			       unit->handle);
+			       unit->handle,
+			       bottom->lun_access);
 		/* mark unit as open */
 		atomic_set_mask(ZFCP_STATUS_COMMON_OPEN, &unit->status);
+		if (adapter->supported_features & FSF_FEATURE_CFDC)
+			unit->lun_access = bottom->lun_access;
 		retval = 0;
 		break;
 
@@ -3176,8 +3212,8 @@
 		ZFCP_LOG_NORMAL("bug: An unknown FSF Status was presented "
 				"(debug info 0x%x)\n",
 				header->fsf_status);
-		debug_text_event(fsf_req->adapter->erp_dbf, 0, "fsf_s_inval:");
-		debug_exception(fsf_req->adapter->erp_dbf, 0,
+		debug_text_event(adapter->erp_dbf, 0, "fsf_s_inval:");
+		debug_exception(adapter->erp_dbf, 0,
 				&header->fsf_status, sizeof (u32));
 		break;
 	}
@@ -3454,15 +3490,11 @@
 	 * (need this for look up on normal command completion)
 	 */
 	fsf_req->data.send_fcp_command_task.scsi_cmnd = scsi_cmnd;
-#ifdef ZFCP_DEBUG_REQUESTS
 	debug_text_event(adapter->req_dbf, 3, "fsf/sc");
 	debug_event(adapter->req_dbf, 3, &fsf_req, sizeof (unsigned long));
 	debug_event(adapter->req_dbf, 3, &scsi_cmnd, sizeof (unsigned long));
-#endif				/* ZFCP_DEBUG_REQUESTS */
-#ifdef ZFCP_DEBUG_ABORTS
-	fsf_req->data.send_fcp_command_task.start_jiffies = jiffies;
-#endif
 
+	fsf_req->data.send_fcp_command_task.start_jiffies = jiffies;
 	fsf_req->data.send_fcp_command_task.unit = unit;
 	ZFCP_LOG_DEBUG("unit=0x%lx, unit_fcp_lun=0x%Lx\n",
 		       (unsigned long) unit, unit->fcp_lun);
@@ -3605,10 +3637,8 @@
  no_fit:
  failed_scsi_cmnd:
 	/* dequeue new FSF request previously enqueued */
-#ifdef ZFCP_DEBUG_REQUESTS
 	debug_text_event(adapter->req_dbf, 3, "fail_sc");
 	debug_event(adapter->req_dbf, 3, &scsi_cmnd, sizeof (unsigned long));
-#endif				/* ZFCP_DEBUG_REQUESTS */
 
 	zfcp_fsf_req_free(fsf_req);
 	fsf_req = NULL;
@@ -3863,20 +3893,19 @@
 				"remote port with WWPN 0x%Lx connected to the "
 				"adapter %s\n",	unit->fcp_lun, unit->port->wwpn,
 			zfcp_get_busid_by_unit(unit));
-		counter = 0;
-		do {
-			subtable = header->fsf_status_qual.halfword[counter++];
-			rule = header->fsf_status_qual.halfword[counter++];
+		for (counter = 0; counter < 2; counter++) {
+			subtable = header->fsf_status_qual.halfword[counter * 2];
+			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
 			switch (subtable) {
 			case FSF_SQ_CFDC_SUBTABLE_OS:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_DID:
 			case FSF_SQ_CFDC_SUBTABLE_LUN:
-				ZFCP_LOG_NORMAL("Access denied (%s rule %d)\n",
+				ZFCP_LOG_INFO("Access denied (%s rule %d)\n",
 					zfcp_act_subtable_type[subtable], rule);
 				break;
 			}
-		} while (counter < 4);
+		}
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -4384,7 +4413,6 @@
 	 * the new eh
 	 */
 	/* always call back */
-#ifdef ZFCP_DEBUG_REQUESTS
 	debug_text_event(fsf_req->adapter->req_dbf, 2, "ok_done:");
 	debug_event(fsf_req->adapter->req_dbf, 2, &scpnt,
 		    sizeof (unsigned long));
@@ -4392,7 +4420,6 @@
 		    sizeof (unsigned long));
 	debug_event(fsf_req->adapter->req_dbf, 2, &fsf_req,
 		    sizeof (unsigned long));
-#endif /* ZFCP_DEBUG_REQUESTS */
 	(scpnt->scsi_done) (scpnt);
 	/*
 	 * We must hold this lock until scsi_done has been called.
@@ -4505,15 +4532,13 @@
 	int direction;
 	int retval = 0;
 
-#if 0
-	if (!(adapter->features & FSF_FEATURE_CFDC)) {
+	if (!(adapter->supported_features & FSF_FEATURE_CFDC)) {
 		ZFCP_LOG_INFO(
 			"Adapter %s does not support control file\n",
 			zfcp_get_busid_by_adapter(adapter));
 		retval = -EOPNOTSUPP;
-		goto no_act_support;
+		goto no_cfdc_support;
 	}
-#endif
 
 	switch (fsf_command) {
 
@@ -4595,6 +4620,7 @@
 	write_unlock_irqrestore(&adapter->request_queue.queue_lock, lock_flags);
 
 invalid_command:
+no_cfdc_support:
 	return retval;
 }
 
@@ -4932,11 +4958,6 @@
                 goto failed_sbals;
 	}
 
-
-	/* set magics */
-	fsf_req->common_magic = ZFCP_MAGIC;
-	fsf_req->specific_magic = ZFCP_MAGIC_FSFREQ;
-
 	fsf_req->adapter = adapter;	/* pointer to "parent" adapter */
 	fsf_req->fsf_command = fsf_cmd;
 	fsf_req->sbal_number = 1;
@@ -5085,7 +5106,6 @@
 			 "to request queue.\n");
 	} else {
 		req_queue->distance_from_int = new_distance_from_int;
-#ifdef ZFCP_DEBUG_REQUESTS
 		debug_text_event(adapter->req_dbf, 1, "o:a/seq");
 		debug_event(adapter->req_dbf, 1, &fsf_req,
 			    sizeof (unsigned long));
@@ -5095,7 +5115,6 @@
 		} else {
 			debug_text_event(adapter->req_dbf, 1, "nocb");
 		}
-#endif				/* ZFCP_DEBUG_REQUESTS */
 		/*
 		 * increase FSF sequence counter -
 		 * this must only be done for request successfully enqueued to
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.h linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.h	Sun Apr  4 05:38:00 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h	Thu Apr  8 15:21:27 2004
@@ -108,6 +108,7 @@
 #define FSF_CONFLICTS_OVERRULED			0x00000058
 #define FSF_PORT_BOXED				0x00000059
 #define FSF_LUN_BOXED				0x0000005A
+#define FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE	0x0000005B
 #define FSF_PAYLOAD_SIZE_MISMATCH		0x00000060
 #define FSF_REQUEST_SIZE_TOO_LARGE		0x00000061
 #define FSF_RESPONSE_SIZE_TOO_LARGE		0x00000062
@@ -156,7 +157,6 @@
 #define FSF_STATUS_READ_BIT_ERROR_THRESHOLD	0x00000004
 #define FSF_STATUS_READ_LINK_DOWN		0x00000005 /* FIXME: really? */
 #define FSF_STATUS_READ_LINK_UP          	0x00000006
-#define FSF_STATUS_READ_NOTIFICATION_LOST	0x00000009
 #define FSF_STATUS_READ_CFDC_UPDATED		0x0000000A
 #define FSF_STATUS_READ_CFDC_HARDENED		0x0000000B
 
@@ -165,8 +165,6 @@
 #define FSF_STATUS_READ_SUB_ERROR_PORT		0x00000002
 
 /* status subtypes for CFDC */
-#define FSF_STATUS_READ_SUB_LOST_CFDC_UPDATED	0x00000020
-#define FSF_STATUS_READ_SUB_LOST_CFDC_HARDENED	0x00000040
 #define FSF_STATUS_READ_SUB_CFDC_HARDENED_ON_SE	0x00000002
 #define FSF_STATUS_READ_SUB_CFDC_HARDENED_ON_SE2 0x0000000F
 
@@ -198,18 +196,23 @@
 /* channel features */
 #define FSF_FEATURE_QTCB_SUPPRESSION            0x00000001
 #define FSF_FEATURE_CFDC			0x00000002
-#define FSF_FEATURE_SENSEDATA_REPLICATION       0x00000004
 #define FSF_FEATURE_LOST_SAN_NOTIFICATION       0x00000008
 #define FSF_FEATURE_HBAAPI_MANAGEMENT           0x00000010
 #define FSF_FEATURE_ELS_CT_CHAINED_SBALS        0x00000020
 
 /* option */
 #define FSF_OPEN_LUN_SUPPRESS_BOXING		0x00000001
+#define FSF_OPEN_LUN_UNSOLICITED_SENSE_DATA	0x00000002
 
 /* adapter types */
 #define FSF_ADAPTER_TYPE_FICON                  0x00000001
 #define FSF_ADAPTER_TYPE_FICON_EXPRESS          0x00000002
 
+/* flags */
+#define FSF_CFDC_OPEN_LUN_ALLOWED		0x01
+#define FSF_CFDC_EXCLUSIVE_ACCESS		0x02
+#define FSF_CFDC_OUTBOUND_TRANSFER_ALLOWED	0x10
+
 /* port types */
 #define FSF_HBA_PORTTYPE_UNKNOWN		0x00000001
 #define FSF_HBA_PORTTYPE_NOTPRESENT		0x00000003
@@ -394,9 +397,10 @@
 	u64 res2;
 	u64 req_handle;
 	u32 service_class;
-	u8 res3[3];
+	u8  res3[3];
 	u8  timeout;
-	u8 res4[184];
+	u32 lun_access;
+	u8  res4[180];
 	u32 els1_length;
 	u32 els2_length;
 	u32 req_buf_length;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_qdio.c linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c
--- linux-2.6/drivers/s390/scsi/zfcp_qdio.c	Sun Apr  4 05:36:18 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c	Thu Apr  8 15:21:27 2004
@@ -28,7 +28,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_QDIO_C_REVISION "$Revision: 1.13 $"
+#define ZFCP_QDIO_C_REVISION "$Revision: 1.16 $"
 
 #include "zfcp_ext.h"
 
@@ -485,11 +485,9 @@
 	struct zfcp_fsf_req *fsf_req;
 	int retval = 0;
 
-#ifdef ZFCP_DEBUG_REQUESTS
 	/* Note: seq is entered later */
 	debug_text_event(adapter->req_dbf, 1, "i:a/seq");
 	debug_event(adapter->req_dbf, 1, &sbale_addr, sizeof (unsigned long));
-#endif				/* ZFCP_DEBUG_REQUESTS */
 
 	/* invalid (per convention used in this driver) */
 	if (unlikely(!sbale_addr)) {
@@ -502,17 +500,6 @@
 	/* valid request id and thus (hopefully :) valid fsf_req address */
 	fsf_req = (struct zfcp_fsf_req *) sbale_addr;
 
-	if (unlikely((fsf_req->common_magic != ZFCP_MAGIC) ||
-	             (fsf_req->specific_magic != ZFCP_MAGIC_FSFREQ))) {
-		ZFCP_LOG_NORMAL("bug: An inbound FSF acknowledgement was "
-				"faulty (debug info 0x%x, 0x%x, 0x%lx)\n",
-				fsf_req->common_magic,
-				fsf_req->specific_magic,
-				(unsigned long) fsf_req);
-		retval = -EINVAL;
-		goto out;
-	}
-
 	if (unlikely(adapter != fsf_req->adapter)) {
 		ZFCP_LOG_NORMAL("bug: An inbound FSF acknowledgement was not "
 				"correct (debug info 0x%lx, 0x%lx, 0%lx) \n",
@@ -522,13 +509,11 @@
 		retval = -EINVAL;
 		goto out;
 	}
-#ifdef ZFCP_DEBUG_REQUESTS
 	/* debug feature stuff (test for QTCB: remember new unsol. status!) */
 	if (likely(fsf_req->qtcb)) {
 		debug_event(adapter->req_dbf, 1,
 			    &fsf_req->qtcb->prefix.req_seq_no, sizeof (u32));
 	}
-#endif				/* ZFCP_DEBUG_REQUESTS */
 
 	ZFCP_LOG_TRACE("fsf_req at 0x%lx, QTCB at 0x%lx\n",
 		       (unsigned long) fsf_req, (unsigned long) fsf_req->qtcb);
@@ -665,7 +650,7 @@
 
 /**
  * zfcp_qdio_sbals_zero - initialize SBALs between first and last in queue
- *	with zero from
+ *	with zero from 
  */
 static inline int
 zfcp_qdio_sbals_zero(struct zfcp_qdio_queue *queue, int first, int last)
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Sun Apr  4 05:36:57 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Thu Apr  8 15:21:27 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.52 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.59 $"
 
 #include <linux/blkdev.h>
 
@@ -48,14 +48,15 @@
 static int zfcp_scsi_eh_host_reset_handler(struct scsi_cmnd *);
 static int zfcp_task_management_function(struct zfcp_unit *, u8);
 
-static struct zfcp_unit *zfcp_unit_lookup(struct zfcp_adapter *, int, int, int);
+static struct zfcp_unit *zfcp_unit_lookup(struct zfcp_adapter *, int, scsi_id_t,
+					  scsi_lun_t);
 
 static struct device_attribute *zfcp_sysfs_sdev_attrs[];
 
 struct zfcp_data zfcp_data = {
 	.scsi_host_template = {
 	      name:	               ZFCP_NAME,
-	      proc_name:               "dummy",
+	      proc_name:               "zfcp",
 	      proc_info:               NULL,
 	      detect:	               NULL,
 	      slave_alloc:             zfcp_scsi_slave_alloc,
@@ -299,12 +300,9 @@
 		ZFCP_LOG_DEBUG("error: Could not send a Send FCP Command\n");
 		retval = SCSI_MLQUEUE_HOST_BUSY;
 	} else {
-
-#ifdef ZFCP_DEBUG_REQUESTS
 		debug_text_event(adapter->req_dbf, 3, "q_scpnt");
 		debug_event(adapter->req_dbf, 3, &scpnt,
 			    sizeof (unsigned long));
-#endif				/* ZFCP_DEBUG_REQUESTS */
 	}
 
 out:
@@ -376,7 +374,8 @@
  * context:	
  */
 static struct zfcp_unit *
-zfcp_unit_lookup(struct zfcp_adapter *adapter, int channel, int id, int lun)
+zfcp_unit_lookup(struct zfcp_adapter *adapter, int channel, scsi_id_t id,
+		 scsi_lun_t lun)
 {
 	struct zfcp_port *port;
 	struct zfcp_unit *unit, *retval = NULL;
@@ -426,8 +425,6 @@
 	unsigned long flags;
 	u32 status = 0;
 
-
-#ifdef ZFCP_DEBUG_ABORTS
 	/* the components of a abort_dbf record (fixed size record) */
 	u64 dbf_scsi_cmnd = (unsigned long) scpnt;
 	char dbf_opcode[ZFCP_ABORT_DBF_LENGTH];
@@ -445,7 +442,6 @@
 	memcpy(dbf_opcode,
 	       scpnt->cmnd,
 	       min(scpnt->cmd_len, (unsigned char) ZFCP_ABORT_DBF_LENGTH));
-#endif
 
 	 /*TRACE*/
 	    ZFCP_LOG_INFO
@@ -488,11 +484,11 @@
 
 	/* Figure out which fsf_req needs to be aborted. */
 	old_fsf_req = req_data->send_fcp_command_task.fsf_req;
-#ifdef ZFCP_DEBUG_ABORTS
+
 	dbf_fsf_req = (unsigned long) old_fsf_req;
 	dbf_timeout =
 	    (jiffies - req_data->send_fcp_command_task.start_jiffies) / HZ;
-#endif
+
 	/* DEBUG */
 	ZFCP_LOG_DEBUG("old_fsf_req=0x%lx\n", (unsigned long) old_fsf_req);
 	if (!old_fsf_req) {
@@ -548,7 +544,7 @@
 
 	/* wait for completion of abort */
 	ZFCP_LOG_DEBUG("Waiting for cleanup....\n");
-#ifdef ZFCP_DEBUG_ABORTS
+#ifdef 1
 	/*
 	 * FIXME:
 	 * copying zfcp_fsf_req_wait_and_cleanup code is not really nice
@@ -584,8 +580,7 @@
 		strncpy(dbf_result, "##fail", ZFCP_ABORT_DBF_LENGTH);
 	}
 
-      out:
-#ifdef ZFCP_DEBUG_ABORTS
+ out:
 	debug_event(adapter->abort_dbf, 1, &dbf_scsi_cmnd, sizeof (u64));
 	debug_event(adapter->abort_dbf, 1, &dbf_opcode, ZFCP_ABORT_DBF_LENGTH);
 	debug_event(adapter->abort_dbf, 1, &dbf_wwn, sizeof (wwn_t));
@@ -598,7 +593,7 @@
 	debug_event(adapter->abort_dbf, 1, &dbf_fsf_qual[0], sizeof (u64));
 	debug_event(adapter->abort_dbf, 1, &dbf_fsf_qual[1], sizeof (u64));
 	debug_text_event(adapter->abort_dbf, 1, dbf_result);
-#endif
+
 	spin_lock_irq(scsi_host->host_lock);
 	return retval;
 }
@@ -796,12 +791,17 @@
 		       (unsigned long) adapter->scsi_host);
 
 	/* tell the SCSI stack some characteristics of this adapter */
-	adapter->scsi_host->max_id = adapter->max_scsi_id + 1;
-	adapter->scsi_host->max_lun = adapter->max_scsi_lun + 1;
+	adapter->scsi_host->max_id = 1;
+	adapter->scsi_host->max_lun = 1;
 	adapter->scsi_host->max_channel = 0;
 	adapter->scsi_host->unique_id = unique_id++;	/* FIXME */
 	adapter->scsi_host->max_cmd_len = ZFCP_MAX_SCSI_CMND_LENGTH;
 	/*
+	 * Reverse mapping of the host number to avoid race condition
+	 */
+	adapter->scsi_host_no = adapter->scsi_host->host_no;
+
+	/*
 	 * save a pointer to our own adapter data structure within
 	 * hostdata field of SCSI host data structure
 	 */
@@ -835,6 +835,7 @@
 	scsi_remove_host(shost);
 	scsi_host_put(shost);
 	adapter->scsi_host = NULL;
+	adapter->scsi_host_no = 0;
 	atomic_clear_mask(ZFCP_STATUS_ADAPTER_REGISTERED, &adapter->status);
 
 	return;
@@ -850,68 +851,32 @@
 	add_timer(&adapter->scsi_er_timer);
 }
 
-/**
- * zfcp_sysfs_hba_id_show - display hba_id of scsi device
- * @dev: pointer to belonging device
- * @buf: pointer to input buffer
- *
- * "hba_id" attribute of a scsi device. Displays hba_id (bus_id)
- * of the adapter belonging to a scsi device.
- */
-static ssize_t
-zfcp_sysfs_hba_id_show(struct device *dev, char *buf)
-{
-	struct scsi_device *sdev;
-	struct zfcp_unit *unit;
-
-	sdev = to_scsi_device(dev);
-	unit = (struct zfcp_unit *) sdev->hostdata;
-	return sprintf(buf, "%s\n", zfcp_get_busid_by_unit(unit));
-}
-
-static DEVICE_ATTR(hba_id, S_IRUGO, zfcp_sysfs_hba_id_show, NULL);
-
-/**
- * zfcp_sysfs_wwpn_show - display wwpn of scsi device
- * @dev: pointer to belonging device
- * @buf: pointer to input buffer
- *
- * "wwpn" attribute of a scsi device. Displays wwpn of the port
- * belonging to a scsi device.
- */
-static ssize_t
-zfcp_sysfs_wwpn_show(struct device *dev, char *buf)
-{
-	struct scsi_device *sdev;
-	struct zfcp_unit *unit;
-
-	sdev = to_scsi_device(dev);
-	unit = (struct zfcp_unit *) sdev->hostdata;
-	return sprintf(buf, "0x%016llx\n", unit->port->wwpn);
-}
-
-static DEVICE_ATTR(wwpn, S_IRUGO, zfcp_sysfs_wwpn_show, NULL);
 
 /**
- * zfcp_sysfs_fcp_lun_show - display fcp lun of scsi device
- * @dev: pointer to belonging device
- * @buf: pointer to input buffer
- *
- * "fcp_lun" attribute of a scsi device. Displays fcp_lun of the unit
- * belonging to a scsi device.
- */
-static ssize_t
-zfcp_sysfs_fcp_lun_show(struct device *dev, char *buf)
-{
-	struct scsi_device *sdev;
-	struct zfcp_unit *unit;
-
-	sdev = to_scsi_device(dev);
-	unit = (struct zfcp_unit *) sdev->hostdata;
-	return sprintf(buf, "0x%016llx\n", unit->fcp_lun);
-}
-
-static DEVICE_ATTR(fcp_lun, S_IRUGO, zfcp_sysfs_fcp_lun_show, NULL);
+ * ZFCP_DEFINE_SCSI_ATTR
+ * @_name:   name of show attribute
+ * @_format: format string
+ * @_value:  value to print
+ *
+ * Generates attribute for a unit.
+ */
+#define ZFCP_DEFINE_SCSI_ATTR(_name, _format, _value)                    \
+static ssize_t zfcp_sysfs_scsi_##_name##_show(struct device *dev,        \
+                                              char *buf)                 \
+{                                                                        \
+        struct scsi_device *sdev;                                        \
+        struct zfcp_unit *unit;                                          \
+                                                                         \
+        sdev = to_scsi_device(dev);                                      \
+        unit = sdev->hostdata;                                           \
+        return sprintf(buf, _format, _value);                            \
+}                                                                        \
+                                                                         \
+static DEVICE_ATTR(_name, S_IRUGO, zfcp_sysfs_scsi_##_name##_show, NULL);
+
+ZFCP_DEFINE_SCSI_ATTR(hba_id, "%s\n", zfcp_get_busid_by_unit(unit));
+ZFCP_DEFINE_SCSI_ATTR(wwpn, "0x%016llx\n", unit->port->wwpn);
+ZFCP_DEFINE_SCSI_ATTR(fcp_lun, "0x%016llx\n", unit->fcp_lun);
 
 static struct device_attribute *zfcp_sysfs_sdev_attrs[] = {
 	&dev_attr_fcp_lun,
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c	Sun Apr  4 05:36:14 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c	Thu Apr  8 15:21:27 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.30 $"
+#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.32 $"
 
 #include <asm/ccwdev.h>
 #include "zfcp_ext.h"
@@ -75,6 +75,7 @@
 ZFCP_DEFINE_ADAPTER_ATTR(hardware_version, "0x%08x\n",
 			 adapter->hardware_version);
 ZFCP_DEFINE_ADAPTER_ATTR(serial_number, "%17s\n", adapter->serial_number);
+ZFCP_DEFINE_ADAPTER_ATTR(scsi_host_no, "0x%x\n", adapter->scsi_host_no);
 
 /**
  * zfcp_sysfs_adapter_in_recovery_show - recovery state of adapter
@@ -100,30 +101,6 @@
 		   zfcp_sysfs_adapter_in_recovery_show, NULL);
 
 /**
- * zfcp_sysfs_adapter_scsi_host_no_show - display scsi_host_no of adapter
- * @dev: pointer to belonging device
- * @buf: pointer to input buffer
- *
- * "scsi_host_no" attribute of adapter. Displays the SCSI host number.
- */
-static ssize_t
-zfcp_sysfs_adapter_scsi_host_no_show(struct device *dev, char *buf)
-{
-	struct zfcp_adapter *adapter;
-	unsigned short host_no = 0;
-
-	down(&zfcp_data.config_sema);
-	adapter = dev_get_drvdata(dev);
-	if (adapter->scsi_host)
-		host_no = adapter->scsi_host->host_no;
-	up(&zfcp_data.config_sema);
-	return sprintf(buf, "0x%x\n", host_no);
-}
-
-static DEVICE_ATTR(scsi_host_no, S_IRUGO, zfcp_sysfs_adapter_scsi_host_no_show,
-		   NULL);
-
-/**
  * zfcp_sysfs_port_add_store - add a port to sysfs tree
  * @dev: pointer to belonging device
  * @buf: pointer to input buffer
@@ -219,9 +196,7 @@
 	zfcp_erp_port_shutdown(port, 0);
 	zfcp_erp_wait(adapter);
 	zfcp_port_put(port);
-	zfcp_sysfs_port_remove_files(&port->sysfs_device,
-				     atomic_read(&port->status));
-	device_unregister(&port->sysfs_device);
+	zfcp_port_dequeue(port);
  out:
 	up(&zfcp_data.config_sema);
 	return retval ? retval : count;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	Sun Apr  4 05:38:18 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c	Thu Apr  8 15:21:27 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.37 $"
+#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.39 $"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -43,11 +43,7 @@
 void
 zfcp_sysfs_port_release(struct device *dev)
 {
-	struct zfcp_port *port;
-
-	port = dev_get_drvdata(dev);
-	zfcp_port_dequeue(port);
-	return;
+	kfree(dev);
 }
 
 /**
@@ -112,7 +108,6 @@
 
 	zfcp_erp_unit_reopen(unit, 0);
 	zfcp_erp_wait(unit->port->adapter);
-	wait_event(unit->scsi_add_wq, atomic_read(&unit->scsi_add_work) == 0);
 	zfcp_unit_put(unit);
  out:
 	up(&zfcp_data.config_sema);
@@ -168,8 +163,7 @@
 	zfcp_erp_unit_shutdown(unit, 0);
 	zfcp_erp_wait(unit->port->adapter);
 	zfcp_unit_put(unit);
-	zfcp_sysfs_unit_remove_files(&unit->sysfs_device);
-	device_unregister(&unit->sysfs_device);
+	zfcp_unit_dequeue(unit);
  out:
 	up(&zfcp_data.config_sema);
 	return retval ? retval : count;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c	Sun Apr  4 05:38:28 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_unit.c	Thu Apr  8 15:21:27 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.23 $"
+#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.24 $"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -43,11 +43,7 @@
 void
 zfcp_sysfs_unit_release(struct device *dev)
 {
-	struct zfcp_unit *unit;
-
-	unit = dev_get_drvdata(dev);
-	zfcp_unit_dequeue(unit);
-	return;
+	kfree(dev);
 }
 
 /**
