Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUESLKO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUESLKO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 07:10:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbUESLKN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 07:10:13 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:52953 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S263596AbUESLCK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 07:02:10 -0400
Date: Wed, 19 May 2004 13:02:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (3/4): zfcp host adapater.
Message-ID: <20040519110206.GD5888@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapter.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

zfcp host adapter change:
 - Remove misplaced dot in error message.
 - Remove unused performance statistics code.

diffstat:
 drivers/s390/scsi/zfcp_aux.c           |  105 ---------------------------------
 drivers/s390/scsi/zfcp_ccw.c           |    6 -
 drivers/s390/scsi/zfcp_def.h           |   27 --------
 drivers/s390/scsi/zfcp_erp.c           |   35 -----------
 drivers/s390/scsi/zfcp_ext.h           |    6 -
 drivers/s390/scsi/zfcp_fsf.c           |    8 --
 drivers/s390/scsi/zfcp_qdio.c          |   19 -----
 drivers/s390/scsi/zfcp_scsi.c          |    4 -
 drivers/s390/scsi/zfcp_sysfs_adapter.c |    4 -
 drivers/s390/scsi/zfcp_sysfs_driver.c  |    4 -
 drivers/s390/scsi/zfcp_sysfs_port.c    |    6 -
 drivers/s390/scsi/zfcp_sysfs_unit.c    |    6 -
 12 files changed, 13 insertions(+), 217 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Mon May 10 04:33:21 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Wed May 19 12:47:29 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.107 $"
+#define ZFCP_AUX_REVISION "$Revision: 1.108 $"
 
 #include "zfcp_ext.h"
 
@@ -47,12 +47,6 @@
 static void zfcp_ns_gid_pn_handler(unsigned long);
 
 /* miscellaneous */
-#ifdef ZFCP_STAT_REQSIZES
-static int zfcp_statistics_init_all(void);
-static int zfcp_statistics_clear_all(void);
-static int zfcp_statistics_clear(struct list_head *);
-static int zfcp_statistics_new(struct list_head *, u32);
-#endif
 
 static inline int zfcp_sg_list_alloc(struct zfcp_sg_list *, size_t);
 static inline int zfcp_sg_list_free(struct zfcp_sg_list *);
@@ -136,96 +130,6 @@
 
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_OTHER
 
-#ifdef ZFCP_STAT_REQSIZES
-
-static int
-zfcp_statistics_clear(struct list_head *head)
-{
-	int retval = 0;
-	unsigned long flags;
-	struct zfcp_statistics *stat, *tmp;
-
-	write_lock_irqsave(&zfcp_data.stat_lock, flags);
-	list_for_each_entry_safe(stat, tmp, head, list) {
-		list_del(&stat->list);
-		kfree(stat);
-	}
-	write_unlock_irqrestore(&zfcp_data.stat_lock, flags);
-
-	return retval;
-}
-
-/* Add new statistics entry */
-static int
-zfcp_statistics_new(struct list_head *head, u32 num)
-{
-	int retval = 0;
-	struct zfcp_statistics *stat;
-
-	stat = kmalloc(sizeof (struct zfcp_statistics), GFP_ATOMIC);
-	if (stat) {
-		memset(stat, 0, sizeof (struct zfcp_statistics));
-		stat->num = num;
-		stat->occurrence = 1;
-		list_add_tail(&stat->list, head);
-	} else
-		zfcp_data.stat_errors++;
-
-	return retval;
-}
-
-int
-zfcp_statistics_inc(struct list_head *head, u32 num)
-{
-	int retval = 0;
-	unsigned long flags;
-	struct zfcp_statistics *stat;
-
-	write_lock_irqsave(&zfcp_data.stat_lock, flags);
-	list_for_each_entry(stat, head, list) {
-		if (stat->num == num) {
-			stat->occurrence++;
-			goto unlock;
-		}
-	}
-	/* occurrence must be initialized to 1 */
-	zfcp_statistics_new(head, num);
- unlock:
-	write_unlock_irqrestore(&zfcp_data.stat_lock, flags);
-	return retval;
-}
-
-static int
-zfcp_statistics_init_all(void)
-{
-	int retval = 0;
-
-	rwlock_init(&zfcp_data.stat_lock);
-	INIT_LIST_HEAD(&zfcp_data.read_req_head);
-	INIT_LIST_HEAD(&zfcp_data.write_req_head);
-	INIT_LIST_HEAD(&zfcp_data.read_sg_head);
-	INIT_LIST_HEAD(&zfcp_data.write_sg_head);
-	INIT_LIST_HEAD(&zfcp_data.read_sguse_head);
-	INIT_LIST_HEAD(&zfcp_data.write_sguse_head);
-	return retval;
-}
-
-static int
-zfcp_statistics_clear_all(void)
-{
-	int retval = 0;
-
-	zfcp_statistics_clear(&zfcp_data.read_req_head);
-	zfcp_statistics_clear(&zfcp_data.write_req_head);
-	zfcp_statistics_clear(&zfcp_data.read_sg_head);
-	zfcp_statistics_clear(&zfcp_data.write_sg_head);
-	zfcp_statistics_clear(&zfcp_data.read_sguse_head);
-	zfcp_statistics_clear(&zfcp_data.write_sguse_head);
-	return retval;
-}
-
-#endif /* ZFCP_STAT_REQSIZES */
-
 static inline int
 zfcp_fsf_req_is_scsi_cmnd(struct zfcp_fsf_req *fsf_req)
 {
@@ -406,10 +310,6 @@
 	/* initialize adapters to be removed list head */
 	INIT_LIST_HEAD(&zfcp_data.adapter_remove_lh);
 
-#ifdef ZFCP_STAT_REQSIZES
-	zfcp_statistics_init_all();
-#endif
-
 #ifdef CONFIG_S390_SUPPORT
 	retval = register_ioctl32_conversion(zfcp_ioctl_trans.cmd,
 					     zfcp_ioctl_trans.handler);
@@ -460,9 +360,6 @@
 	unregister_ioctl32_conversion(zfcp_ioctl_trans.cmd);
  out_ioctl32:
 #endif
-#ifdef ZFCP_STAT_REQSIZES
-	zfcp_statistics_clear_all();
-#endif
 
  out:
 	return retval;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c	Wed May 19 12:47:29 2004
@@ -26,13 +26,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_CCW_C_REVISION "$Revision: 1.54 $"
+#define ZFCP_CCW_C_REVISION "$Revision: 1.55 $"
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <asm/ccwdev.h>
 #include "zfcp_ext.h"
-#include "zfcp_def.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Mon May 10 04:32:38 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Wed May 19 12:47:29 2004
@@ -33,7 +33,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.72 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.73 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -64,8 +64,6 @@
 /************************ DEBUG FLAGS *****************************************/
 
 #define	ZFCP_PRINT_FLAGS
-#define	ZFCP_STAT_REQSIZES
-#define	ZFCP_STAT_QUEUES
 
 /********************* GENERAL DEFINES *********************************/
 
@@ -1080,31 +1078,8 @@
 	char                    init_busid[BUS_ID_SIZE];
 	wwn_t                   init_wwpn;
 	fcp_lun_t               init_fcp_lun;
-#ifdef ZFCP_STAT_REQSIZES                            /* Statistical accounting
-							of processed data */
-	struct list_head	read_req_head;
-	struct list_head	write_req_head;
-	struct list_head	read_sg_head;
-	struct list_head	write_sg_head;
-	struct list_head	read_sguse_head;
-	struct list_head	write_sguse_head;
-	unsigned long		stat_errors;
-	rwlock_t		stat_lock;
-#endif
-#ifdef ZFCP_STAT_QUEUES
-        atomic_t                outbound_queue_full;
-	atomic_t		outbound_total;
-#endif
 };
 
-#ifdef ZFCP_STAT_REQSIZES
-struct zfcp_statistics {
-        struct list_head list;
-        u32 num;
-        u32 occurrence;
-};
-#endif
-
 struct zfcp_sg_list {
 	struct scatterlist *sg;
 	unsigned int count;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Wed May 19 12:47:29 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.52 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.54 $"
 
 #include "zfcp_ext.h"
 
@@ -126,37 +126,6 @@
 static void zfcp_erp_timeout_handler(unsigned long);
 static inline void zfcp_erp_timeout_init(struct zfcp_erp_action *);
 
-/*
- * function:	zfcp_erp_adapter_shutdown_all
- *
- * purpose:	recursively calls zfcp_erp_adapter_shutdown to stop all
- *              IO on each adapter, return all outstanding packets and 
- *              relinquish all IRQs
- *              Note: This function waits for completion of all shutdowns
- *
- * returns:     0 in all cases
- */
-int
-zfcp_erp_adapter_shutdown_all(void)
-{
-	int retval = 0;
-	unsigned long flags;
-	struct zfcp_adapter *adapter;
-
-	read_lock_irqsave(&zfcp_data.config_lock, flags);
-	list_for_each_entry(adapter, &zfcp_data.adapter_list_head, list)
-	    zfcp_erp_adapter_shutdown(adapter, 0);
-	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
-
-	/*
-	 * FIXME : need to take config_lock but cannot, since we schedule here.
-	 */
-	/* start all shutdowns first before any waiting to allow for concurreny */
-	list_for_each_entry(adapter, &zfcp_data.adapter_list_head, list)
-	    zfcp_erp_wait(adapter);
-
-	return retval;
-}
 
 /*
  * function:	zfcp_fsf_scsi_er_timeout_handler
@@ -2328,7 +2297,7 @@
 
 	if (qdio_establish(&adapter->qdio_init_data) != 0) {
 		ZFCP_LOG_INFO("error: establishment of QDIO queues failed "
-			      "on adapter %s\n.",
+			      "on adapter %s\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		goto failed_qdio_establish;
 	}
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	Mon May 10 04:32:26 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h	Wed May 19 12:47:29 2004
@@ -31,7 +31,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.49 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.50 $"
 
 #include "zfcp_def.h"
 
@@ -141,7 +141,6 @@
 extern void zfcp_erp_modify_adapter_status(struct zfcp_adapter *, u32, int);
 extern int  zfcp_erp_adapter_reopen(struct zfcp_adapter *, int);
 extern int  zfcp_erp_adapter_shutdown(struct zfcp_adapter *, int);
-extern int  zfcp_erp_adapter_shutdown_all(void);
 extern void zfcp_erp_adapter_failed(struct zfcp_adapter *);
 
 extern void zfcp_erp_modify_port_status(struct zfcp_port *, u32, int);
@@ -169,7 +168,4 @@
 extern void zfcp_cmd_dbf_event_scsi(const char *, struct scsi_cmnd *);
 extern void zfcp_in_els_dbf_event(struct zfcp_adapter *, const char *,
 				  struct fsf_status_read_buffer *, int);
-#ifdef ZFCP_STAT_REQSIZES
-extern int  zfcp_statistics_inc(struct list_head *, u32);
-#endif
 #endif	/* ZFCP_EXT_H */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Wed May 19 12:46:53 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Wed May 19 12:47:29 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.46 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.47 $"
 
 #include "zfcp_ext.h"
 
@@ -4809,9 +4809,6 @@
 	goto success;
 
  failed_sbals:
-#ifdef ZFCP_STAT_QUEUES
-	atomic_inc(&zfcp_data.outbound_queue_full);
-#endif
 /* dequeue new FSF request previously enqueued */
 	zfcp_fsf_req_free(fsf_req);
 	fsf_req = NULL;
@@ -4948,9 +4945,6 @@
 		}
 		/* count FSF requests pending */
 		atomic_inc(&adapter->fsf_reqs_active);
-#ifdef ZFCP_STAT_QUEUES
-		atomic_inc(&zfcp_data.outbound_total);
-#endif
 	}
 	return retval;
 }
diff -urN linux-2.6/drivers/s390/scsi/zfcp_qdio.c linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c
--- linux-2.6/drivers/s390/scsi/zfcp_qdio.c	Mon May 10 04:32:00 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c	Wed May 19 12:47:29 2004
@@ -28,7 +28,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_QDIO_C_REVISION "$Revision: 1.18 $"
+#define ZFCP_QDIO_C_REVISION "$Revision: 1.19 $"
 
 #include "zfcp_ext.h"
 
@@ -682,12 +682,6 @@
 	sbale = zfcp_qdio_sbale_curr(fsf_req);
 	sbale->addr = addr;
 	sbale->length = length;
-
-#ifdef ZFCP_STAT_REQSIZES
-        if (sbtype == SBAL_FLAGS0_TYPE_READ)
-                zfcp_statistics_inc(&zfcp_data.read_sg_head, length);
-        else    zfcp_statistics_inc(&zfcp_data.write_sg_head, length);
-#endif
 }
 
 /**
@@ -770,18 +764,7 @@
 	/* assume that no other SBALEs are to follow in the same SBAL */
 	sbale = zfcp_qdio_sbale_curr(fsf_req);
 	sbale->flags |= SBAL_FLAGS_LAST_ENTRY;
-
 out:
-#ifdef ZFCP_STAT_REQSIZES
-	if (sbtype == SBAL_FLAGS0_TYPE_READ) {
-		zfcp_statistics_inc(&zfcp_data.read_sguse_head, sg_count);
-		zfcp_statistics_inc(&zfcp_data.read_req_head, bytes);
-	} else	{
-		zfcp_statistics_inc(&zfcp_data.write_sguse_head, sg_count);
-        	zfcp_statistics_inc(&zfcp_data.write_req_head, bytes);
-	}
-#endif
-
 	return bytes;
 }
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Mon May 10 04:32:28 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Wed May 19 12:47:29 2004
@@ -31,9 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.61 $"
-
-#include <linux/blkdev.h>
+#define ZFCP_SCSI_REVISION "$Revision: 1.62 $"
 
 #include "zfcp_ext.h"
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c	Mon May 10 04:31:58 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c	Wed May 19 12:47:29 2004
@@ -26,11 +26,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.32 $"
+#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.33 $"
 
-#include <asm/ccwdev.h>
 #include "zfcp_ext.h"
-#include "zfcp_def.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_driver.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_driver.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_driver.c	Mon May 10 04:33:13 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_driver.c	Wed May 19 12:47:29 2004
@@ -26,11 +26,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_DRIVER_C_REVISION "$Revision: 1.12 $"
+#define ZFCP_SYSFS_DRIVER_C_REVISION "$Revision: 1.14 $"
 
-#include <asm/ccwdev.h>
 #include "zfcp_ext.h"
-#include "zfcp_def.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	Mon May 10 04:33:20 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c	Wed May 19 12:47:29 2004
@@ -26,13 +26,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.39 $"
+#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.40 $"
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <asm/ccwdev.h>
 #include "zfcp_ext.h"
-#include "zfcp_def.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c	Mon May 10 04:33:22 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_unit.c	Wed May 19 12:47:29 2004
@@ -26,13 +26,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.24 $"
+#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.25 $"
 
-#include <linux/init.h>
-#include <linux/module.h>
-#include <asm/ccwdev.h>
 #include "zfcp_ext.h"
-#include "zfcp_def.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
 
