Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbUCPOOx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 09:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUCPONI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 09:13:08 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:20916 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261739AbUCPNxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 08:53:15 -0500
Date: Tue, 16 Mar 2004 14:51:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] s390 (8/10): zfcp fixes.
Message-ID: <20040316135155.GI2785@mschwid3.boeblingen.de.ibm.com>
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
 - Replace release function for device structures by kfree. Move struct
   device to the start of struct zfcp_port/zfcp_unit to make it work.
 - Avoid deadlock on bus->subsys.rwsem.
 - Use a macro for all scsi device sysfs attributes.
 - Change proc_name from "dummy" to "zfcp".
 - Don't wait for scsi_add_device to complete while holding a semaphore.
 - Cleanup include files in zfcp_aux.c & zfcp_def.h.
 - Get rid of zfcp_erp_fsf_req_handler.

diffstat:
 drivers/s390/scsi/zfcp_aux.c           |  191 ++++++++-------------------------
 drivers/s390/scsi/zfcp_ccw.c           |   14 --
 drivers/s390/scsi/zfcp_def.h           |   44 +++----
 drivers/s390/scsi/zfcp_erp.c           |   26 ----
 drivers/s390/scsi/zfcp_ext.h           |    6 -
 drivers/s390/scsi/zfcp_fsf.c           |  185 +++++++++++++++++--------------
 drivers/s390/scsi/zfcp_fsf.h           |   12 +-
 drivers/s390/scsi/zfcp_qdio.c          |   15 --
 drivers/s390/scsi/zfcp_scsi.c          |   98 +++++-----------
 drivers/s390/scsi/zfcp_sysfs_adapter.c |   31 -----
 drivers/s390/scsi/zfcp_sysfs_port.c    |   20 ---
 drivers/s390/scsi/zfcp_sysfs_unit.c    |   16 --
 12 files changed, 236 insertions(+), 422 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Thu Mar 11 03:55:54 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Tue Mar 16 14:03:14 2004
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
+#define ZFCP_AUX_REVISION "$Revision: 1.103 $"
 
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
@@ -421,8 +388,8 @@
 		goto out_unit;
 	up(&zfcp_data.config_sema);
 	ccw_device_set_online(adapter->ccw_device);
-	down(&zfcp_data.config_sema);
 	wait_event(unit->scsi_add_wq, atomic_read(&unit->scsi_add_work) == 0);
+	down(&zfcp_data.config_sema);
 	zfcp_unit_put(unit);
  out_unit:
 	zfcp_port_put(port);
@@ -978,7 +945,9 @@
 struct zfcp_unit *
 zfcp_unit_enqueue(struct zfcp_port *port, fcp_lun_t fcp_lun)
 {
-	struct zfcp_unit *unit;
+	struct zfcp_unit *unit, *tmp_unit;
+	scsi_lun_t scsi_lun;
+	int found;
 
 	/*
 	 * check that there is no unit with this FCP_LUN already in list
@@ -1002,18 +971,12 @@
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
 	unit->sysfs_device.parent = &port->sysfs_device;
-	unit->sysfs_device.release = zfcp_sysfs_unit_release;
+	unit->sysfs_device.release = (void (*)(struct device *))kfree;
 	dev_set_drvdata(&unit->sysfs_device, unit);
 
 	/* mark unit unusable as long as sysfs registration is not complete */
@@ -1025,43 +988,29 @@
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
@@ -1070,21 +1019,17 @@
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
@@ -1154,7 +1099,7 @@
 
 	adapter->pool.data_status_read =
 		mempool_create(ZFCP_POOL_STATUS_READ_NR,
-			       zfcp_mempool_alloc, zfcp_mempool_free,
+			       zfcp_mempool_alloc, zfcp_mempool_free, 
 			       (void *) sizeof(struct fsf_status_read_buffer));
 
 	if (NULL == adapter->pool.data_status_read) {
@@ -1246,10 +1191,6 @@
 	if (retval)
 		goto failed_low_mem_buffers;
 
-	/* set magics */
-	adapter->common_magic = ZFCP_MAGIC;
-	adapter->specific_magic = ZFCP_MAGIC_ADAPTER;
-
 	/* initialise reference count stuff */
 	atomic_set(&adapter->refcount, 0);
 	init_waitqueue_head(&adapter->remove_wq);
@@ -1515,25 +1456,20 @@
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
@@ -1561,17 +1497,11 @@
 
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
@@ -1579,7 +1509,7 @@
 		snprintf(port->sysfs_device.bus_id,
 			 BUS_ID_SIZE, "0x%016llx", wwpn);
 	port->sysfs_device.parent = &adapter->ccw_device->dev;
-	port->sysfs_device.release = zfcp_sysfs_port_release;
+	port->sysfs_device.release = (void (*)(struct device *))kfree;
 	dev_set_drvdata(&port->sysfs_device, port);
 
 	/* mark port unusable as long as sysfs registration is not complete */
@@ -1591,41 +1521,32 @@
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
@@ -1634,26 +1555,18 @@
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
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	Thu Mar 11 03:55:24 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c	Tue Mar 16 14:03:14 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_CCW_C_REVISION "$Revision: 1.48 $"
+#define ZFCP_CCW_C_REVISION "$Revision: 1.51 $"
 
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
@@ -163,7 +159,7 @@
 	down(&zfcp_data.config_sema);
 	adapter = dev_get_drvdata(&ccw_device->dev);
 
-	retval = zfcp_erp_thread_setup(adapter);
+	retval = zfcp_erp_thread_setup(adapter); 
 	if (retval) {
 		ZFCP_LOG_INFO("error: out of resources. "
 			      "error recovery thread for adapter %s "
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Thu Mar 11 03:55:28 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Tue Mar 16 14:03:14 2004
@@ -33,25 +33,29 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.62 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.69 $"
 
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
@@ -937,8 +941,6 @@
 
 
 struct zfcp_adapter {
-	u32			common_magic;	   /* driver common magic */
-	u32			specific_magic;	   /* struct specific magic */
 	struct list_head	list;              /* list of adapters */
 	atomic_t                refcount;          /* reference count */
 	wait_queue_head_t	remove_wq;         /* can be used to wait for
@@ -956,14 +958,12 @@
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
@@ -1003,9 +1003,13 @@
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
@@ -1020,37 +1024,36 @@
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
@@ -1158,13 +1161,6 @@
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
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Thu Mar 11 03:55:23 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Tue Mar 16 14:07:24 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.44 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.46 $"
 
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
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	Thu Mar 11 03:55:23 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h	Tue Mar 16 14:07:55 2004
@@ -31,7 +31,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.45 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.48 $"
 
 #include "zfcp_def.h"
 
@@ -46,8 +46,6 @@
 extern void zfcp_sysfs_port_remove_files(struct device *, u32);
 extern int  zfcp_sysfs_unit_create_files(struct device *);
 extern void zfcp_sysfs_unit_remove_files(struct device *);
-extern void zfcp_sysfs_port_release(struct device *);
-extern void zfcp_sysfs_unit_release(struct device *);
 
 /**************************** CONFIGURATION  *********************************/
 extern struct zfcp_unit *zfcp_get_unit_by_lun(struct zfcp_port *,
@@ -158,7 +156,7 @@
 extern int  zfcp_erp_thread_setup(struct zfcp_adapter *);
 extern int  zfcp_erp_thread_kill(struct zfcp_adapter *);
 extern int  zfcp_erp_wait(struct zfcp_adapter *);
-extern void zfcp_erp_fsf_req_handler(struct zfcp_fsf_req *);
+extern int  zfcp_erp_async_handler(struct zfcp_erp_action *, unsigned long);
 
 extern int  zfcp_test_link(struct zfcp_port *);
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Thu Mar 11 03:55:36 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Tue Mar 16 14:08:08 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.29 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.38 $"
 
 #include "zfcp_ext.h"
 
@@ -771,6 +771,8 @@
 static int
 zfcp_fsf_req_dispatch(struct zfcp_fsf_req *fsf_req)
 {
+	struct zfcp_erp_action *erp_action = fsf_req->erp_action;
+	struct zfcp_adapter *adapter = fsf_req->adapter;
 	int retval = 0;
 
 	if (unlikely(fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR)) {
@@ -861,7 +863,13 @@
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
 
@@ -1670,20 +1678,19 @@
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
@@ -2036,20 +2043,19 @@
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
@@ -2114,7 +2120,8 @@
 
 	erp_action->fsf_req->erp_action = erp_action;
 	erp_action->fsf_req->qtcb->bottom.config.feature_selection =
-		FSF_FEATURE_CFDC;
+		FSF_FEATURE_CFDC |
+		FSF_FEATURE_LOST_SAN_NOTIFICATION;
 
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
@@ -2408,20 +2415,19 @@
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
@@ -2814,20 +2820,19 @@
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
@@ -2956,8 +2961,8 @@
 	atomic_set_mask(ZFCP_STATUS_COMMON_OPENING, &erp_action->unit->status);
 	erp_action->fsf_req->data.open_unit.unit = erp_action->unit;
 	erp_action->fsf_req->erp_action = erp_action;
-	erp_action->fsf_req->qtcb->bottom.support.option =
-		FSF_OPEN_LUN_SUPPRESS_BOXING;
+//	erp_action->fsf_req->qtcb->bottom.support.option =
+//		FSF_OPEN_LUN_UNSOLICITED_SENSE_DATA;
 
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
@@ -2994,12 +2999,16 @@
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
@@ -3021,7 +3030,7 @@
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
 			      (char *) &header->fsf_status_qual,
 			      sizeof (union fsf_status_qual));
-		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_ph_nv");
+		debug_text_event(adapter->erp_dbf, 1, "fsf_s_ph_nv");
 		zfcp_erp_adapter_reopen(unit->port->adapter, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -3034,7 +3043,7 @@
 				"to the adapter %s twice.\n",
 				unit->fcp_lun,
 				unit->port->wwpn, zfcp_get_busid_by_unit(unit));
-		debug_text_exception(fsf_req->adapter->erp_dbf, 0,
+		debug_text_exception(adapter->erp_dbf, 0,
 				     "fsf_s_uopen");
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -3046,21 +3055,20 @@
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
@@ -3071,7 +3079,7 @@
 			       "with WWPN 0x%Lx on the adapter %s "
 			       "needs to be reopened\n",
 			       unit->port->wwpn, zfcp_get_busid_by_unit(unit));
-		debug_text_event(fsf_req->adapter->erp_dbf, 2, "fsf_s_pboxed");
+		debug_text_event(adapter->erp_dbf, 2, "fsf_s_pboxed");
 		zfcp_erp_port_reopen(unit->port, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR |
 			ZFCP_STATUS_FSFREQ_RETRY;
@@ -3079,30 +3087,38 @@
 
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
+		ZFCP_LOG_DEBUG("status qualifier:\n");
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
 			      (char *) &header->fsf_status_qual,
 			      sizeof (union fsf_status_qual));
-		debug_text_event(fsf_req->adapter->erp_dbf, 2,
+		debug_text_event(adapter->erp_dbf, 2,
 				 "fsf_s_l_sh_vio");
 		zfcp_erp_unit_failed(unit);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
@@ -3118,7 +3134,7 @@
 			      unit->fcp_lun,
 			      unit->port->wwpn,
 			      zfcp_get_busid_by_unit(unit));
-		debug_text_event(fsf_req->adapter->erp_dbf, 1,
+		debug_text_event(adapter->erp_dbf, 1,
 				 "fsf_s_max_units");
 		zfcp_erp_unit_failed(unit);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
@@ -3131,7 +3147,7 @@
 			ZFCP_LOG_FLAGS(2,
 				       "FSF_SQ_INVOKE_LINK_TEST_PROCEDURE\n");
 			/* Re-establish link to port */
-			debug_text_event(fsf_req->adapter->erp_dbf, 1,
+			debug_text_event(adapter->erp_dbf, 1,
 					 "fsf_sq_ltest");
 			zfcp_erp_port_reopen(unit->port, 0);
 			fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
@@ -3140,7 +3156,7 @@
 			ZFCP_LOG_FLAGS(2,
 				       "FSF_SQ_ULP_DEPENDENT_ERP_REQUIRED\n");
 			/* ERP strategy will escalate */
-			debug_text_event(fsf_req->adapter->erp_dbf, 1,
+			debug_text_event(adapter->erp_dbf, 1,
 					 "fsf_sq_ulp");
 			fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 			break;
@@ -3148,27 +3164,41 @@
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
 
@@ -3176,8 +3206,8 @@
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
@@ -4505,15 +4534,13 @@
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
 
@@ -4595,6 +4622,7 @@
 	write_unlock_irqrestore(&adapter->request_queue.queue_lock, lock_flags);
 
 invalid_command:
+no_cfdc_support:
 	return retval;
 }
 
@@ -4932,11 +4960,6 @@
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
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.h linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.h	Thu Mar 11 03:55:43 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h	Tue Mar 16 14:03:14 2004
@@ -198,18 +198,23 @@
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
@@ -394,9 +399,10 @@
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
--- linux-2.6/drivers/s390/scsi/zfcp_qdio.c	Thu Mar 11 03:55:22 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c	Tue Mar 16 14:03:14 2004
@@ -28,7 +28,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_QDIO_C_REVISION "$Revision: 1.13 $"
+#define ZFCP_QDIO_C_REVISION "$Revision: 1.15 $"
 
 #include "zfcp_ext.h"
 
@@ -502,17 +502,6 @@
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
@@ -665,7 +654,7 @@
 
 /**
  * zfcp_qdio_sbals_zero - initialize SBALs between first and last in queue
- *	with zero from
+ *	with zero from 
  */
 static inline int
 zfcp_qdio_sbals_zero(struct zfcp_qdio_queue *queue, int first, int last)
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Thu Mar 11 03:55:26 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Tue Mar 16 14:03:14 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.52 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.57 $"
 
 #include <linux/blkdev.h>
 
@@ -55,7 +55,7 @@
 struct zfcp_data zfcp_data = {
 	.scsi_host_template = {
 	      name:	               ZFCP_NAME,
-	      proc_name:               "dummy",
+	      proc_name:               "zfcp",
 	      proc_info:               NULL,
 	      detect:	               NULL,
 	      slave_alloc:             zfcp_scsi_slave_alloc,
@@ -796,12 +796,17 @@
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
@@ -835,6 +840,7 @@
 	scsi_remove_host(shost);
 	scsi_host_put(shost);
 	adapter->scsi_host = NULL;
+	adapter->scsi_host_no = 0;
 	atomic_clear_mask(ZFCP_STATUS_ADAPTER_REGISTERED, &adapter->status);
 
 	return;
@@ -850,68 +856,32 @@
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
 
 /**
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
-
-/**
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
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c	Thu Mar 11 03:55:21 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c	Tue Mar 16 14:03:14 2004
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
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	Thu Mar 11 03:55:44 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c	Tue Mar 16 14:03:14 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.37 $"
+#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.39 $"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -37,20 +37,6 @@
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
 
 /**
- * zfcp_sysfs_port_release - gets called when a struct device port is released
- * @dev: pointer to belonging device
- */
-void
-zfcp_sysfs_port_release(struct device *dev)
-{
-	struct zfcp_port *port;
-
-	port = dev_get_drvdata(dev);
-	zfcp_port_dequeue(port);
-	return;
-}
-
-/**
  * ZFCP_DEFINE_PORT_ATTR
  * @_name:   name of show attribute
  * @_format: format string
@@ -112,7 +98,6 @@
 
 	zfcp_erp_unit_reopen(unit, 0);
 	zfcp_erp_wait(unit->port->adapter);
-	wait_event(unit->scsi_add_wq, atomic_read(&unit->scsi_add_work) == 0);
 	zfcp_unit_put(unit);
  out:
 	up(&zfcp_data.config_sema);
@@ -168,8 +153,7 @@
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
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c	Thu Mar 11 03:56:03 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_unit.c	Tue Mar 16 14:03:14 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.23 $"
+#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.24 $"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -37,20 +37,6 @@
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
 
 /**
- * zfcp_sysfs_unit_release - gets called when a struct device unit is released
- * @dev: pointer to belonging device
- */
-void
-zfcp_sysfs_unit_release(struct device *dev)
-{
-	struct zfcp_unit *unit;
-
-	unit = dev_get_drvdata(dev);
-	zfcp_unit_dequeue(unit);
-	return;
-}
-
-/**
  * ZFCP_DEFINE_UNIT_ATTR
  * @_name:   name of show attribute
  * @_format: format string
