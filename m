Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267673AbUHENRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267673AbUHENRJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 09:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267674AbUHENRI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 09:17:08 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:11156 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S267673AbUHENN7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 09:13:59 -0400
Date: Thu, 5 Aug 2004 15:14:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: zfcp host adapater.
Message-ID: <20040805131416.GE8251@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapater.

From: Heiko Carstens <heiko.carstens@de.ibm.com>
From: Andreas Herrmann <aherrman@de.ibm.com>

zfcp host adapater change:
 - Fix call to close_physical_port to prevent devices going offline
   after error recovery.
 - Fix return value of sysfs port_remove attribute store function.
 - Replace reboot notifier with device driver shutdown function.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_aux.c        |   25 +------------------------
 drivers/s390/scsi/zfcp_ccw.c        |   21 ++++++++++++++++++++-
 drivers/s390/scsi/zfcp_def.h        |    8 +++-----
 drivers/s390/scsi/zfcp_fsf.c        |    8 +++++++-
 drivers/s390/scsi/zfcp_sysfs_port.c |    8 +++++---
 5 files changed, 36 insertions(+), 34 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Thu Aug  5 14:21:01 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.114 $"
+#define ZFCP_AUX_REVISION "$Revision: 1.115 $"
 
 #include "zfcp_ext.h"
 
@@ -41,8 +41,6 @@
 /* written against the module interface */
 static int __init  zfcp_module_init(void);
 
-int zfcp_reboot_handler(struct notifier_block *, unsigned long, void *);
-
 /* FCP related */
 static void zfcp_ns_gid_pn_handler(unsigned long);
 
@@ -338,9 +336,6 @@
 	/* initialise configuration rw lock */
 	rwlock_init(&zfcp_data.config_lock);
 
-	zfcp_data.reboot_notifier.notifier_call = zfcp_reboot_handler;
-	register_reboot_notifier(&zfcp_data.reboot_notifier);
-
 	/* save address of data structure managing the driver module */
 	zfcp_data.scsi_host_template.module = THIS_MODULE;
 
@@ -357,7 +352,6 @@
 	goto out;
 
  out_ccw_register:
-	unregister_reboot_notifier(&zfcp_data.reboot_notifier);
 	misc_deregister(&zfcp_cfdc_misc);
  out_misc_register:
 #ifdef CONFIG_S390_SUPPORT
@@ -370,23 +364,6 @@
 }
 
 /*
- * This function is called automatically by the kernel whenever a reboot or a 
- * shut-down is initiated and zfcp is still loaded
- *
- * locks:       zfcp_data.config_sema is taken prior to shutting down the module
- *              and removing all structures
- * returns:     NOTIFY_DONE in all cases
- */
-int
-zfcp_reboot_handler(struct notifier_block *notifier, unsigned long code,
-		    void *ptr)
-{
-	zfcp_ccw_unregister();
-	return NOTIFY_DONE;
-}
-
-
-/*
  * function:    zfcp_cfdc_dev_ioctl
  *
  * purpose:     Handle control file upload/download transaction via IOCTL
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	Wed Jun 16 07:19:02 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ccw.c	Thu Aug  5 14:21:01 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_CCW_C_REVISION "$Revision: 1.55 $"
+#define ZFCP_CCW_C_REVISION "$Revision: 1.56 $"
 
 #include "zfcp_ext.h"
 
@@ -37,6 +37,7 @@
 static int zfcp_ccw_set_online(struct ccw_device *);
 static int zfcp_ccw_set_offline(struct ccw_device *);
 static int zfcp_ccw_notify(struct ccw_device *, int);
+static void zfcp_ccw_shutdown(struct device *);
 
 static struct ccw_device_id zfcp_ccw_device_id[] = {
 	{CCW_DEVICE_DEVTYPE(ZFCP_CONTROL_UNIT_TYPE,
@@ -59,6 +60,9 @@
 	.set_online  = zfcp_ccw_set_online,
 	.set_offline = zfcp_ccw_set_offline,
 	.notify      = zfcp_ccw_notify,
+	.driver      = {
+		.shutdown = zfcp_ccw_shutdown,
+	},
 };
 
 MODULE_DEVICE_TABLE(ccw, zfcp_ccw_device_id);
@@ -287,4 +291,19 @@
 	ccw_driver_unregister(&zfcp_ccw_driver);
 }
 
+/**
+ * zfcp_ccw_shutdown - gets called on reboot/shutdown
+ *
+ * Makes sure that QDIO queues are down when the system gets stopped.
+ */
+static void
+zfcp_ccw_shutdown(struct device *dev)
+{
+	struct zfcp_adapter *adapter;
+
+	adapter = dev_get_drvdata(dev);
+	zfcp_erp_adapter_shutdown(adapter, 0);
+	zfcp_erp_wait(adapter);
+}
+
 #undef ZFCP_LOG_AREA
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Thu Aug  5 14:20:39 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Thu Aug  5 14:21:01 2004
@@ -33,7 +33,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.78 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.81 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -42,6 +42,7 @@
 #include <linux/miscdevice.h>
 #include <linux/major.h>
 #include <linux/blkdev.h>
+#include <linux/delay.h>
 #include <scsi/scsi.h>
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_cmnd.h>
@@ -55,7 +56,6 @@
 #include <asm/qdio.h>
 #include <asm/debug.h>
 #include <asm/ebcdic.h>
-#include <linux/reboot.h>
 #include <linux/mempool.h>
 #include <linux/syscalls.h>
 #include <linux/ioctl.h>
@@ -70,7 +70,7 @@
 /********************* GENERAL DEFINES *********************************/
 
 /* zfcp version number, it consists of major, minor, and patch-level number */
-#define ZFCP_VERSION		"4.0.0"
+#define ZFCP_VERSION		"4.1.3"
 
 static inline void *
 zfcp_sg_to_address(struct scatterlist *list)
@@ -1074,8 +1074,6 @@
 						       lists */
 	struct semaphore        config_sema;        /* serialises configuration
 						       changes */
-	struct notifier_block	reboot_notifier;     /* used to register cleanup
-							functions */
 	atomic_t		loglevel;            /* current loglevel */
 	char                    init_busid[BUS_ID_SIZE];
 	wwn_t                   init_wwpn;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Thu Aug  5 14:21:00 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Thu Aug  5 14:21:01 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.53 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.55 $"
 
 #include "zfcp_ext.h"
 
@@ -2619,6 +2619,7 @@
 {
 	int retval = 0;
 	unsigned long lock_flags;
+	volatile struct qdio_buffer_element *sbale;
 
 	/* setup new FSF request */
 	retval = zfcp_fsf_req_create(erp_action->adapter,
@@ -2635,6 +2636,11 @@
 		goto out;
 	}
 
+	sbale = zfcp_qdio_sbale_req(erp_action->fsf_req,
+				    erp_action->fsf_req->sbal_curr, 0);
+	sbale[0].flags |= SBAL_FLAGS0_TYPE_READ;
+	sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
+
 	/* mark port as being closed */
 	atomic_set_mask(ZFCP_STATUS_PORT_PHYS_CLOSING,
 			&erp_action->port->status);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	Wed Jun 16 07:20:04 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c	Thu Aug  5 14:21:01 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.40 $"
+#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.41 $"
 
 #include "zfcp_ext.h"
 
@@ -125,7 +125,7 @@
 	struct zfcp_unit *unit;
 	fcp_lun_t fcp_lun;
 	char *endp;
-	int retval = -EINVAL;
+	int retval = 0;
 
 	down(&zfcp_data.config_sema);
 
@@ -136,8 +136,10 @@
 	}
 
 	fcp_lun = simple_strtoull(buf, &endp, 0);
-	if ((endp + 1) < (buf + count))
+	if ((endp + 1) < (buf + count)) {
+		retval = -EINVAL;
 		goto out;
+	}
 
 	write_lock_irq(&zfcp_data.config_lock);
 	unit = zfcp_get_unit_by_lun(port, fcp_lun);
