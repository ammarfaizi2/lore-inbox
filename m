Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUF3RSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUF3RSn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 13:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266767AbUF3RSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 13:18:43 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:47611 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S266481AbUF3RIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 13:08:42 -0400
Date: Wed, 30 Jun 2004 19:09:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: zfcp host adapter.
Message-ID: <20040630170906.GE3266@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapter.

From: Heiko Carstens <heiko.carstens@de.ibm.com>
From: Andreas Herrmann <aherrman@de.ibm.com>
From: Maxim Shchetynin <maxim@de.ibm.com>

zfcp host adapter changes:
 - Exploit FC transport class and autoselect SCSI_FC_ATTRS for zfcp.
 - Fix acl download to zfcp controller.
 - Change message loglevels to make zfcp less noisy.
 - Don't wait for SBAL to finish for command aborts after a timeout
   and for logical unit or target resets.
 - Force reopen of port if link test failed.
 - Fix race between qdio_shutdown and do_QDIO.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/defconfig           |    2 
 drivers/s390/scsi/zfcp_aux.c  |   13 ++++--
 drivers/s390/scsi/zfcp_def.h  |   20 +++++----
 drivers/s390/scsi/zfcp_erp.c  |   87 +++++++++++++++++-------------------------
 drivers/s390/scsi/zfcp_ext.h  |    4 +
 drivers/s390/scsi/zfcp_fsf.c  |   23 +++++++----
 drivers/s390/scsi/zfcp_scsi.c |   51 +++++++++++++++++++++---
 drivers/scsi/Kconfig          |    1 
 8 files changed, 123 insertions(+), 78 deletions(-)

diff -urN linux-2.6/arch/s390/defconfig linux-2.6-s390/arch/s390/defconfig
--- linux-2.6/arch/s390/defconfig	Wed Jun 30 17:06:35 2004
+++ linux-2.6-s390/arch/s390/defconfig	Wed Jun 30 17:06:38 2004
@@ -124,7 +124,7 @@
 # SCSI Transport Attributes
 #
 # CONFIG_SCSI_SPI_ATTRS is not set
-# CONFIG_SCSI_FC_ATTRS is not set
+CONFIG_SCSI_FC_ATTRS=y
 
 #
 # SCSI low-level drivers
diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Wed Jun 16 07:20:26 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Wed Jun 30 17:06:38 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.108 $"
+#define ZFCP_AUX_REVISION "$Revision: 1.114 $"
 
 #include "zfcp_ext.h"
 
@@ -310,6 +310,10 @@
 	/* initialize adapters to be removed list head */
 	INIT_LIST_HEAD(&zfcp_data.adapter_remove_lh);
 
+	zfcp_transport_template = fc_attach_transport(&zfcp_transport_functions);
+	if (!zfcp_transport_template)
+		return -ENODEV;
+
 #ifdef CONFIG_S390_SUPPORT
 	retval = register_ioctl32_conversion(zfcp_ioctl_trans.cmd,
 					     zfcp_ioctl_trans.handler);
@@ -414,7 +418,7 @@
 		retval = -ENOMEM;
 		goto out;
 	}
-	sg_list->count = 0;
+	memset(sg_list, 0, sizeof(*sg_list));
 
 	if (command != ZFCP_CFDC_IOC) {
 		ZFCP_LOG_INFO("IOC request code 0x%x invalid\n", command);
@@ -599,6 +603,7 @@
 	sg_list->sg = kmalloc(sg_list->count * sizeof(struct scatterlist),
 			      GFP_KERNEL);
 	if (sg_list->sg == NULL) {
+		sg_list->count = 0;
 		retval = -ENOMEM;
 		goto out;
 	}
@@ -635,11 +640,13 @@
 	unsigned int i;
 	int retval = 0;
 
-	BUG_ON((sg_list->sg == NULL) || (sg_list == NULL));
+	BUG_ON(sg_list == NULL);
 
 	for (i = 0, sg = sg_list->sg; i < sg_list->count; i++, sg++)
 		__free_pages(sg->page, 0);
 
+	kfree(sg_list->sg);
+
 	return retval;
 }
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Wed Jun 16 07:19:36 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Wed Jun 30 17:06:38 2004
@@ -33,7 +33,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.73 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.75 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -47,6 +47,8 @@
 #include <scsi/scsi_cmnd.h>
 #include <scsi/scsi_device.h>
 #include <scsi/scsi_host.h>
+#include <scsi/scsi_transport.h>
+#include <scsi/scsi_transport_fc.h>
 #include "../../fc4/fc.h"
 #include "zfcp_fsf.h"
 #include <asm/ccwdev.h>
@@ -509,14 +511,14 @@
 
 /* all log-level defaults are combined to generate initial log-level */
 #define ZFCP_LOG_LEVEL_DEFAULTS \
-	(ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_INFO, ZFCP_LOG_AREA_OTHER) | \
-	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_INFO, ZFCP_LOG_AREA_SCSI) | \
-	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_INFO, ZFCP_LOG_AREA_FSF) | \
-	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_INFO, ZFCP_LOG_AREA_CONFIG) | \
-	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_INFO, ZFCP_LOG_AREA_CIO) | \
-	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_INFO, ZFCP_LOG_AREA_QDIO) | \
-	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_INFO, ZFCP_LOG_AREA_ERP) | \
-	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_INFO, ZFCP_LOG_AREA_FC))
+	(ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_NORMAL, ZFCP_LOG_AREA_OTHER) | \
+	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_NORMAL, ZFCP_LOG_AREA_SCSI) | \
+	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_NORMAL, ZFCP_LOG_AREA_FSF) | \
+	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_NORMAL, ZFCP_LOG_AREA_CONFIG) | \
+	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_NORMAL, ZFCP_LOG_AREA_CIO) | \
+	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_NORMAL, ZFCP_LOG_AREA_QDIO) | \
+	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_NORMAL, ZFCP_LOG_AREA_ERP) | \
+	 ZFCP_SET_LOG_NIBBLE(ZFCP_LOG_LEVEL_NORMAL, ZFCP_LOG_AREA_FC))
 
 /* check whether we have the right level for logging */
 #define ZFCP_LOG_CHECK(level) \
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Wed Jun 16 07:19:01 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Wed Jun 30 17:06:38 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.54 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.56 $"
 
 #include "zfcp_ext.h"
 
@@ -435,8 +435,20 @@
 	u8 req_code, resp_code;
 	int retval = 0;
 
-	if (send_els->status != 0)
+	if (send_els->status != 0) {
+		ZFCP_LOG_NORMAL("ELS request timed out, physical port reopen "
+				"of port 0x%016Lx on adapter %s failed\n",
+				port->wwpn, zfcp_get_busid_by_port(port));
+		debug_text_event(port->adapter->erp_dbf, 3, "forcreop");
+		retval = zfcp_erp_port_forced_reopen(port, 0);
+		if (retval != 0) {
+			ZFCP_LOG_NORMAL("reopen of remote port 0x%016Lx "
+					"on adapter %s failed\n", port->wwpn,
+					zfcp_get_busid_by_port(port));
+			retval = -EPERM;
+		}
 		goto skip_fsfstatus;
+	}
 
 	req = (void*)((page_to_pfn(send_els->req->page) << PAGE_SHIFT) + send_els->req->offset);
 	resp = (void*)((page_to_pfn(send_els->resp->page) << PAGE_SHIFT) + send_els->resp->offset);
@@ -2286,7 +2298,6 @@
 	int i;
 	volatile struct qdio_buffer_element *sbale;
 	struct zfcp_adapter *adapter = erp_action->adapter;
-	int retval_cleanup = 0;
 
 	if (atomic_test_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status)) {
 		ZFCP_LOG_NORMAL("bug: second attempt to set up QDIO on "
@@ -2301,7 +2312,7 @@
 			      zfcp_get_busid_by_adapter(adapter));
 		goto failed_qdio_establish;
 	}
-	ZFCP_LOG_DEBUG("queues established\n");
+	debug_text_event(adapter->erp_dbf, 3, "qdio_est");
 
 	if (qdio_activate(adapter->ccw_device, 0) != 0) {
 		ZFCP_LOG_INFO("error: activation of QDIO queues failed "
@@ -2309,7 +2320,7 @@
 			      zfcp_get_busid_by_adapter(adapter));
 		goto failed_qdio_activate;
 	}
-	ZFCP_LOG_DEBUG("queues activated\n");
+	debug_text_event(adapter->erp_dbf, 3, "qdio_act");
 
 	/*
 	 * put buffers into response queue,
@@ -2357,19 +2368,15 @@
 	/* NOP */
 
  failed_qdio_activate:
-	/* DEBUG */
-	//__ZFCP_WAIT_EVENT_TIMEOUT(timeout, 0);
-	/* cleanup queues previously established */
-	retval_cleanup = qdio_shutdown(adapter->ccw_device,
-				       QDIO_FLAG_CLEANUP_USING_CLEAR);
-	if (retval_cleanup) {
-		ZFCP_LOG_NORMAL("bug: shutdown of QDIO queues failed "
-				"(retval=%d)\n", retval_cleanup);
+	debug_text_event(adapter->erp_dbf, 3, "qdio_down1a");
+	while (qdio_shutdown(adapter->ccw_device,
+			     QDIO_FLAG_CLEANUP_USING_CLEAR) == -EINPROGRESS) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ);
 	}
+	debug_text_event(adapter->erp_dbf, 3, "qdio_down1b");
 
  failed_qdio_establish:
-	atomic_clear_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status);
-
  failed_sanity:
 	retval = ZFCP_ERP_FAILED;
 
@@ -2401,42 +2408,22 @@
 		goto out;
 	}
 
-	/* cleanup queues previously established */
-
 	/*
-	 * MUST NOT LOCK - qdio_cleanup might call schedule
-	 * FIXME: need another way to make cleanup safe
+	 * Get queue_lock and clear QDIOUP flag. Thus it's guaranteed that
+	 * do_QDIO won't be called while qdio_shutdown is in progress.
 	 */
-	/* Note:
-	 * We need the request_queue lock here, otherwise there exists the 
-	 * following race:
-	 * 
-	 * queuecommand calls create_fcp_commmand_task...calls req_create, 
-	 * gets sbal x to x+y - meanwhile adapter reopen is called, completes 
-	 * - req_send calls do_QDIO for sbal x to x+y, i.e. wrong indices.
-	 *
-	 * with lock:
-	 * queuecommand calls create_fcp_commmand_task...calls req_create, 
-	 * gets sbal x to x+y - meanwhile adapter reopen is called, waits 
-	 * - req_send calls do_QDIO for sbal x to x+y, i.e. wrong indices 
-	 * but do_QDIO fails as adapter_reopen is still waiting for the lock
-	 * OR
-	 * queuecommand calls create_fcp_commmand_task...calls req_create 
-	 * - meanwhile adapter reopen is called...completes,
-	 * - gets sbal 0 to 0+y, - req_send calls do_QDIO for sbal 0 to 0+y, 
-	 * i.e. correct indices...though an fcp command is called before 
-	 * exchange config data...that should be fine, however
-	 */
-	if (qdio_shutdown(adapter->ccw_device, QDIO_FLAG_CLEANUP_USING_CLEAR)) {
-		/*
-		 * FIXME(design):
-		 * What went wrong? What to do best? Proper retval?
-		 */
-		ZFCP_LOG_NORMAL("bug: shutdown of QDIO queues failed on "
-				"adapter %s\n",
-				zfcp_get_busid_by_adapter(adapter));
-	} else
-		ZFCP_LOG_DEBUG("queues cleaned up\n");
+
+	write_lock_irq(&adapter->request_queue.queue_lock);
+	atomic_clear_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status);
+	write_unlock_irq(&adapter->request_queue.queue_lock);
+
+	debug_text_event(adapter->erp_dbf, 3, "qdio_down2a");
+	while (qdio_shutdown(adapter->ccw_device,
+			     QDIO_FLAG_CLEANUP_USING_CLEAR) == -EINPROGRESS) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(HZ);
+	}
+	debug_text_event(adapter->erp_dbf, 3, "qdio_down2b");
 
 	/*
 	 * First we had to stop QDIO operation.
@@ -2459,8 +2446,6 @@
 	adapter->request_queue.free_index = 0;
 	atomic_set(&adapter->request_queue.free_count, 0);
 	adapter->request_queue.distance_from_int = 0;
-
-	atomic_clear_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status);
  out:
 	return retval;
 }
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	Wed Jun 16 07:19:01 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h	Wed Jun 30 17:06:38 2004
@@ -31,7 +31,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.50 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.51 $"
 
 #include "zfcp_def.h"
 
@@ -136,6 +136,8 @@
 				   struct scsi_cmnd *scsi_cmnd);
 extern int zfcp_scsi_command_sync(struct zfcp_unit *unit,
 				  struct scsi_cmnd *scsi_cmnd);
+extern struct scsi_transport_template *zfcp_transport_template;
+extern struct fc_function_template zfcp_transport_functions;
 
 /******************************** ERP ****************************************/
 extern void zfcp_erp_modify_adapter_status(struct zfcp_adapter *, u32, int);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Wed Jun 16 07:19:43 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Wed Jun 30 17:06:38 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.47 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.49 $"
 
 #include "zfcp_ext.h"
 
@@ -3997,15 +3997,14 @@
 	scpnt->result |= fcp_rsp_iu->scsi_status;
 	if (unlikely(fcp_rsp_iu->scsi_status)) {
 		/* DEBUG */
-		ZFCP_LOG_NORMAL("status for SCSI Command:\n");
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
+		ZFCP_LOG_DEBUG("status for SCSI Command:\n");
+		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
 			      scpnt->cmnd, scpnt->cmd_len);
-
-		ZFCP_LOG_NORMAL("SCSI status code 0x%x\n",
+		ZFCP_LOG_DEBUG("SCSI status code 0x%x\n",
 				fcp_rsp_iu->scsi_status);
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
+		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
 			      (void *) fcp_rsp_iu, sizeof (struct fcp_rsp_iu));
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
+		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
 			      zfcp_get_fcp_sns_info_ptr(fcp_rsp_iu),
 			      fcp_rsp_iu->fcp_sns_len);
 	}
@@ -4782,6 +4781,16 @@
                 goto failed_sbals;
 	}
 
+	/*
+	 * We hold queue_lock here. Check if QDIOUP is set and let request fail
+	 * if it is not set (see also *_open_qdio and *_close_qdio).
+	 */
+
+	if (!atomic_test_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status)) {
+		write_unlock_irqrestore(&req_queue->queue_lock, *lock_flags);
+		goto failed_sbals;
+	}
+
 	fsf_req->adapter = adapter;	/* pointer to "parent" adapter */
 	fsf_req->fsf_command = fsf_cmd;
 	fsf_req->sbal_number = 1;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Wed Jun 16 07:19:17 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Wed Jun 30 17:06:38 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.62 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.65 $"
 
 #include "zfcp_ext.h"
 
@@ -51,6 +51,8 @@
 
 static struct device_attribute *zfcp_sysfs_sdev_attrs[];
 
+struct scsi_transport_template *zfcp_transport_template;
+
 struct zfcp_data zfcp_data = {
 	.scsi_host_template = {
 	      name:	               ZFCP_NAME,
@@ -508,8 +510,7 @@
 	ZFCP_LOG_DEBUG("unit 0x%016Lx (%p)\n", unit->fcp_lun, unit);
 
 	/*
-	 * The 'Abort FCP Command' routine may block (call schedule)
-	 * because it may wait for a free SBAL.
+	 * We block (call schedule)
 	 * That's why we must release the lock and enable the
 	 * interrupts before.
 	 * On the other hand we do not need the lock anymore since
@@ -518,8 +519,7 @@
 	write_unlock_irqrestore(&adapter->abort_lock, flags);
 	/* call FSF routine which does the abort */
 	new_fsf_req = zfcp_fsf_abort_fcp_command((unsigned long) old_fsf_req,
-						 adapter,
-						 unit, ZFCP_WAIT_FOR_SBAL);
+						 adapter, unit, 0);
 	ZFCP_LOG_DEBUG("new_fsf_req=%p\n", new_fsf_req);
 	if (!new_fsf_req) {
 		retval = FAILED;
@@ -657,7 +657,7 @@
 
 	/* issue task management function */
 	fsf_req = zfcp_fsf_send_fcp_command_task_management
-	    (adapter, unit, tm_flags, ZFCP_WAIT_FOR_SBAL);
+		(adapter, unit, tm_flags, 0);
 	if (!fsf_req) {
 		ZFCP_LOG_INFO("error: creation of task management request "
 			      "failed for unit 0x%016Lx on port 0x%016Lx on  "
@@ -768,6 +768,7 @@
 	adapter->scsi_host->max_channel = 0;
 	adapter->scsi_host->unique_id = unique_id++;	/* FIXME */
 	adapter->scsi_host->max_cmd_len = ZFCP_MAX_SCSI_CMND_LENGTH;
+	adapter->scsi_host->transportt = zfcp_transport_template;
 	/*
 	 * Reverse mapping of the host number to avoid race condition
 	 */
@@ -823,6 +824,44 @@
 	add_timer(&adapter->scsi_er_timer);
 }
 
+/*
+ * Support functions for FC transport class
+ */
+static void
+zfcp_get_port_id(struct scsi_device *sdev)
+{
+	struct zfcp_unit *unit;
+
+	unit = (struct zfcp_unit *) sdev->hostdata;
+	fc_port_id(sdev) = unit->port->d_id;
+}
+
+static void
+zfcp_get_port_name(struct scsi_device *sdev)
+{
+	struct zfcp_unit *unit;
+
+	unit = (struct zfcp_unit *) sdev->hostdata;
+	fc_port_name(sdev) = unit->port->wwpn;
+}
+
+static void
+zfcp_get_node_name(struct scsi_device *sdev)
+{
+	struct zfcp_unit *unit;
+
+	unit = (struct zfcp_unit *) sdev->hostdata;
+	fc_node_name(sdev) = unit->port->wwnn;
+}
+
+struct fc_function_template zfcp_transport_functions = {
+	.get_port_id = zfcp_get_port_id,
+	.get_port_name = zfcp_get_port_name,
+	.get_node_name = zfcp_get_node_name,
+	.show_port_id = 1,
+	.show_port_name = 1,
+	.show_node_name = 1,
+};
 
 /**
  * ZFCP_DEFINE_SCSI_ATTR
diff -urN linux-2.6/drivers/scsi/Kconfig linux-2.6-s390/drivers/scsi/Kconfig
--- linux-2.6/drivers/scsi/Kconfig	Wed Jun 30 17:06:16 2004
+++ linux-2.6-s390/drivers/scsi/Kconfig	Wed Jun 30 17:06:38 2004
@@ -1738,6 +1738,7 @@
 config ZFCP
 	tristate "FCP host bus adapter driver for IBM eServer zSeries"
 	depends on ARCH_S390 && SCSI
+	select SCSI_FC_ATTRS
 	help
           If you want to access SCSI devices attached to your IBM eServer
           zSeries by means of Fibre Channel interfaces say Y.
