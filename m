Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262335AbUKKRh0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262335AbUKKRh0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:37:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbUKKRe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:34:57 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:7413 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S262300AbUKKRRn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:17:43 -0500
Date: Thu, 11 Nov 2004 18:17:32 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 10/10] s390: zfcp act enhancements.
Message-ID: <20041111171732.GL4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 10/10] s390: zfcp act enhancements.

From: Andreas Herrmann <aherrman@de.ibm.com>
From: Maxim Shchetynin <maxim@de.ibm.com>

zfcp host adapter changes:
 - Add access control enhancements.
 - Add event callbacks.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_aux.c        |  179 +++++++++++++++++++++++++++++++++---
 drivers/s390/scsi/zfcp_def.h        |   40 ++++++--
 drivers/s390/scsi/zfcp_erp.c        |  154 ++++++++++++++++++++++++++----
 drivers/s390/scsi/zfcp_ext.h        |   26 +++++
 drivers/s390/scsi/zfcp_fsf.c        |  110 ++++++++++++++++------
 drivers/s390/scsi/zfcp_fsf.h        |    6 -
 drivers/s390/scsi/zfcp_scsi.c       |    5 -
 drivers/s390/scsi/zfcp_sysfs_port.c |    4 
 drivers/s390/scsi/zfcp_sysfs_unit.c |    8 -
 9 files changed, 454 insertions(+), 78 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	2004-11-11 15:07:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c	2004-11-11 15:07:01.000000000 +0100
@@ -45,14 +45,6 @@
 static void zfcp_ns_gid_pn_handler(unsigned long);
 
 /* miscellaneous */
-
-static inline int zfcp_sg_list_alloc(struct zfcp_sg_list *, size_t);
-static inline void zfcp_sg_list_free(struct zfcp_sg_list *);
-static inline int zfcp_sg_list_copy_from_user(struct zfcp_sg_list *,
-					      void __user *, size_t);
-static inline int zfcp_sg_list_copy_to_user(void __user *,
-					    struct zfcp_sg_list *, size_t);
-
 static int zfcp_cfdc_dev_ioctl(struct inode *, struct file *,
 	unsigned int, unsigned long);
 
@@ -345,8 +337,11 @@
 	if (zfcp_device_setup(device))
 		zfcp_init_device_configure();
 
+	init_waitqueue_head(&zfcp_callbacks.wq);
+
 	goto out;
 
+
  out_ccw_register:
 	misc_deregister(&zfcp_cfdc_misc);
  out_misc_register:
@@ -564,7 +559,7 @@
  * elements of the scatter-gather list. The maximum size of a single element
  * in the scatter-gather list is PAGE_SIZE.
  */
-static inline int
+int
 zfcp_sg_list_alloc(struct zfcp_sg_list *sg_list, size_t size)
 {
 	struct scatterlist *sg;
@@ -612,7 +607,7 @@
  * Memory for each element in the scatter-gather list is freed.
  * Finally sg_list->sg is freed itself and sg_list->count is reset.
  */
-static inline void
+void
 zfcp_sg_list_free(struct zfcp_sg_list *sg_list)
 {
 	struct scatterlist *sg;
@@ -657,7 +652,7 @@
  * @size: number of bytes to be copied
  * Return: 0 on success, -EFAULT if copy_from_user fails.
  */
-static inline int
+int
 zfcp_sg_list_copy_from_user(struct zfcp_sg_list *sg_list,
 			    void __user *user_buffer,
                             size_t size)
@@ -695,7 +690,7 @@
  * @size: number of bytes to be copied
  * Return: 0 on success, -EFAULT if copy_to_user fails
  */
-static inline int
+int
 zfcp_sg_list_copy_to_user(void __user  *user_buffer,
 			  struct zfcp_sg_list *sg_list,
                           size_t size)
@@ -1423,6 +1418,8 @@
 
 	zfcp_adapter_get(adapter);
 
+	zfcp_cb_port_add(port);
+
 	return port;
 }
 
@@ -1650,6 +1647,7 @@
 	else
 		zfcp_fsf_incoming_els_unknown(adapter, status_buffer);
 
+	zfcp_cb_incoming_els(adapter, status_buffer->payload);
 }
 
 
@@ -1976,4 +1974,161 @@
 	return ret;
 }
 
+
+#undef ZFCP_LOG_AREA
+
+/****************************************************************/
+/******* HBA API Support related Functions  *********************/
+/****************************************************************/
+#define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_FC
+
+struct zfcp_callbacks zfcp_callbacks = { };
+
+/**
+ * zfcp_register_callbacks - register callbacks for event handling in HBA API
+ * @callbacks: set of callback functions to be registered
+ */
+void
+zfcp_register_callbacks(struct zfcp_callbacks *callbacks)
+{
+	zfcp_callbacks.incoming_els = callbacks->incoming_els;
+	zfcp_callbacks.link_down = callbacks->link_down;
+	zfcp_callbacks.link_up = callbacks->link_up;
+	zfcp_callbacks.adapter_add = callbacks->adapter_add;
+	zfcp_callbacks.port_add = callbacks->port_add;
+	zfcp_callbacks.unit_add = callbacks->unit_add;
+}
+
+/**
+ * zfcp_unregister_callbacks - deregister callbacks for event handling
+ */
+void
+zfcp_unregister_callbacks(void)
+{
+	zfcp_callbacks.incoming_els = NULL;
+	zfcp_callbacks.link_down = NULL;
+	zfcp_callbacks.link_up = NULL;
+	zfcp_callbacks.adapter_add = NULL;
+	zfcp_callbacks.port_add = NULL;
+	zfcp_callbacks.unit_add = NULL;
+
+	/* wait until all callbacks returned */
+	wait_event(zfcp_callbacks.wq,
+		   atomic_read(&zfcp_callbacks.refcount) == 0);
+}
+
+/**
+ * zfcp_cb_incoming_els - make callback for incoming els
+ * @adpater: adapter where ELS was received
+ * @payload: received ELS payload
+ */
+void
+zfcp_cb_incoming_els(struct zfcp_adapter *adapter, void *payload)
+{
+	zfcp_cb_incoming_els_t cb;
+
+	atomic_inc(&zfcp_callbacks.refcount);
+	cb = zfcp_callbacks.incoming_els;
+	if (cb)
+		cb(adapter, payload);
+	if (atomic_dec_return(&zfcp_callbacks.refcount) == 0)
+		wake_up(&zfcp_callbacks.wq);
+}
+
+/**
+ * zfcp_cb_link_down - make callback for link down event
+ * @adapter: adapter where link down occurred
+ */
+void
+zfcp_cb_link_down(struct zfcp_adapter *adapter)
+{
+	zfcp_cb_link_down_t cb;
+	atomic_inc(&zfcp_callbacks.refcount);
+	cb = zfcp_callbacks.link_down;
+	if (cb)
+		cb(adapter);
+	if (atomic_dec_return(&zfcp_callbacks.refcount) == 0)
+		wake_up(&zfcp_callbacks.wq);
+}
+
+/**
+ * zfcp_cb_link_up - make callback for link up event
+ * @adapter: adapter where link up occurred
+ */
+void
+zfcp_cb_link_up(struct zfcp_adapter *adapter)
+{
+	zfcp_cb_link_up_t cb;
+	atomic_inc(&zfcp_callbacks.refcount);
+	cb = zfcp_callbacks.link_up;
+	if (cb)
+		cb(adapter);
+	if (atomic_dec_return(&zfcp_callbacks.refcount) == 0)
+		wake_up(&zfcp_callbacks.wq);
+}
+
+/**
+ * zfcp_cb_adapter_add - make callback for adapter add event
+ * @adapter: adapter which was added/activated
+ */
+void
+zfcp_cb_adapter_add(struct zfcp_adapter *adapter)
+{
+	zfcp_cb_adapter_add_t cb;
+	atomic_inc(&zfcp_callbacks.refcount);
+	cb = zfcp_callbacks.adapter_add;
+	if (cb)
+		cb(adapter);
+	if (atomic_dec_return(&zfcp_callbacks.refcount) == 0)
+		wake_up(&zfcp_callbacks.wq);
+}
+
+/**
+ * zfcp_cb_port_add - make callback for port add event
+ * @port: port which was added
+ */
+void
+zfcp_cb_port_add(struct zfcp_port *port)
+{
+	zfcp_cb_port_add_t cb;
+	atomic_inc(&zfcp_callbacks.refcount);
+	cb = zfcp_callbacks.port_add;
+	if (cb)
+		cb(port);
+	if (atomic_dec_return(&zfcp_callbacks.refcount) == 0)
+		wake_up(&zfcp_callbacks.wq);
+}
+
+/**
+ * zfcp_cb_unit_add - make callback for unit add event
+ * @unit: unit which was added
+ */
+void
+zfcp_cb_unit_add(struct zfcp_unit *unit)
+{
+	zfcp_cb_unit_add_t cb;
+	atomic_inc(&zfcp_callbacks.refcount);
+	cb = zfcp_callbacks.unit_add;
+	if (cb)
+		cb(unit);
+	if (atomic_dec_return(&zfcp_callbacks.refcount) == 0)
+		wake_up(&zfcp_callbacks.wq);
+}
+
 #undef ZFCP_LOG_AREA
+
+EXPORT_SYMBOL(zfcp_sg_list_alloc);
+EXPORT_SYMBOL(zfcp_sg_list_free);
+EXPORT_SYMBOL(zfcp_sg_size);
+EXPORT_SYMBOL(zfcp_sg_list_copy_from_user);
+EXPORT_SYMBOL(zfcp_sg_list_copy_to_user);
+EXPORT_SYMBOL(zfcp_get_unit_by_lun);
+EXPORT_SYMBOL(zfcp_get_port_by_wwpn);
+EXPORT_SYMBOL(zfcp_get_port_by_did);
+EXPORT_SYMBOL(zfcp_get_adapter_by_busid);
+EXPORT_SYMBOL(zfcp_register_callbacks);
+EXPORT_SYMBOL(zfcp_unregister_callbacks);
+EXPORT_SYMBOL(zfcp_port_enqueue);
+EXPORT_SYMBOL(zfcp_unit_enqueue);
+EXPORT_SYMBOL(zfcp_unit_dequeue);
+EXPORT_SYMBOL(zfcp_check_ct_response);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-patched/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	2004-11-11 15:07:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_def.h	2004-11-11 15:07:01.000000000 +0100
@@ -490,8 +490,8 @@
  * Note, the leftmost status byte is common among adapter, port 
  * and unit
  */
-#define ZFCP_COMMON_FLAGS                       0xff000000
-#define ZFCP_SPECIFIC_FLAGS                     0x00ffffff
+#define ZFCP_COMMON_FLAGS			0xfff00000
+#define ZFCP_SPECIFIC_FLAGS			0x000fffff
 
 /* common status bits */
 #define ZFCP_STATUS_COMMON_REMOVE		0x80000000
@@ -502,6 +502,7 @@
 #define ZFCP_STATUS_COMMON_OPEN                 0x04000000
 #define ZFCP_STATUS_COMMON_CLOSING              0x02000000
 #define ZFCP_STATUS_COMMON_ERP_INUSE		0x01000000
+#define ZFCP_STATUS_COMMON_ACCESS_DENIED	0x00800000
 
 /* adapter status */
 #define ZFCP_STATUS_ADAPTER_QDIOUP		0x00000002
@@ -540,12 +541,10 @@
 		 ZFCP_STATUS_PORT_NO_SCSI_ID)
 
 /* logical unit status */
-#define ZFCP_STATUS_UNIT_NOTSUPPUNITRESET       0x00000001
-#define ZFCP_STATUS_UNIT_ACCESS_DENIED          0x00000002
-#define ZFCP_STATUS_UNIT_ACCESS_SHARED          0x00000004
-#define ZFCP_STATUS_UNIT_ACCESS_READONLY        0x00000008
-#define ZFCP_STATUS_UNIT_TEMPORARY		0x00000010
-
+#define ZFCP_STATUS_UNIT_NOTSUPPUNITRESET	0x00000001
+#define ZFCP_STATUS_UNIT_TEMPORARY		0x00000002
+#define ZFCP_STATUS_UNIT_SHARED			0x00000004
+#define ZFCP_STATUS_UNIT_READONLY		0x00000008
 
 /* FSF request status (this does not have a common part) */
 #define ZFCP_STATUS_FSFREQ_NOT_INIT		0x00000000
@@ -1119,4 +1118,29 @@
 	wait_event(adapter->remove_wq, atomic_read(&adapter->refcount) == 0);
 }
 
+
+/*
+ *  stuff needed for callback handling
+ */
+
+typedef void (*zfcp_cb_incoming_els_t) (struct zfcp_adapter *, void *);
+typedef void (*zfcp_cb_link_down_t) (struct zfcp_adapter *);
+typedef void (*zfcp_cb_link_up_t) (struct zfcp_adapter *);
+typedef void (*zfcp_cb_adapter_add_t) (struct zfcp_adapter *);
+typedef void (*zfcp_cb_port_add_t) (struct zfcp_port *);
+typedef void (*zfcp_cb_unit_add_t) (struct zfcp_unit *);
+
+struct zfcp_callbacks {
+	atomic_t refcount;
+	wait_queue_head_t wq;
+	zfcp_cb_incoming_els_t incoming_els;
+	zfcp_cb_link_down_t link_down;
+	zfcp_cb_link_up_t link_up;
+	zfcp_cb_adapter_add_t adapter_add;
+	zfcp_cb_port_add_t port_add;
+	zfcp_cb_unit_add_t unit_add;
+};
+
+extern struct zfcp_callbacks zfcp_callbacks;
+
 #endif /* ZFCP_DEF_H */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	2004-11-11 15:07:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c	2004-11-11 15:07:01.000000000 +0100
@@ -32,7 +32,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.76 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.79 $"
 
 #include "zfcp_ext.h"
 
@@ -1785,34 +1785,22 @@
 static int
 zfcp_erp_strategy_check_queues(struct zfcp_adapter *adapter)
 {
-	int retval = 0;
 	unsigned long flags;
-	struct zfcp_port *nport = adapter->nameserver_port;
 
 	read_lock_irqsave(&zfcp_data.config_lock, flags);
 	read_lock(&adapter->erp_lock);
 	if (list_empty(&adapter->erp_ready_head) &&
 	    list_empty(&adapter->erp_running_head)) {
-		if (nport
-		    && atomic_test_mask(ZFCP_STATUS_COMMON_OPEN,
-					&nport->status)) {
-			debug_text_event(adapter->erp_dbf, 4, "a_cq_nspsd");
-			/* taking down nameserver port */
-			zfcp_erp_port_reopen_internal(nport,
-						      ZFCP_STATUS_COMMON_RUNNING |
-						      ZFCP_STATUS_COMMON_ERP_FAILED);
-		} else {
 			debug_text_event(adapter->erp_dbf, 4, "a_cq_wake");
 			atomic_clear_mask(ZFCP_STATUS_ADAPTER_ERP_PENDING,
 					  &adapter->status);
 			wake_up(&adapter->erp_done_wqh);
-		}
 	} else
 		debug_text_event(adapter->erp_dbf, 5, "a_cq_notempty");
 	read_unlock(&adapter->erp_lock);
 	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
 
-	return retval;
+	return 0;
 }
 
 /**
@@ -2808,10 +2796,11 @@
 
 	atomic_clear_mask(ZFCP_STATUS_COMMON_OPENING |
 			  ZFCP_STATUS_COMMON_CLOSING |
+			  ZFCP_STATUS_COMMON_ACCESS_DENIED |
 			  ZFCP_STATUS_PORT_DID_DID |
 			  ZFCP_STATUS_PORT_PHYS_CLOSING |
-			  ZFCP_STATUS_PORT_INVALID_WWPN |
-			  ZFCP_STATUS_PORT_ACCESS_DENIED, &port->status);
+			  ZFCP_STATUS_PORT_INVALID_WWPN,
+			  &port->status);
 	return retval;
 }
 
@@ -3016,9 +3005,10 @@
 
 	atomic_clear_mask(ZFCP_STATUS_COMMON_OPENING |
 			  ZFCP_STATUS_COMMON_CLOSING |
-			  ZFCP_STATUS_UNIT_ACCESS_DENIED |
-			  ZFCP_STATUS_UNIT_ACCESS_SHARED |
-			  ZFCP_STATUS_UNIT_ACCESS_READONLY, &unit->status);
+			  ZFCP_STATUS_COMMON_ACCESS_DENIED |
+			  ZFCP_STATUS_UNIT_SHARED |
+			  ZFCP_STATUS_UNIT_READONLY,
+			  &unit->status);
 
 	return retval;
 }
@@ -3357,9 +3347,11 @@
 		if ((result == ZFCP_ERP_SUCCEEDED)
 		    && (!atomic_test_mask(ZFCP_STATUS_UNIT_TEMPORARY,
 					  &unit->status))
-		    && (!unit->device))
+		    && (!unit->device)) {
  			scsi_add_device(unit->port->adapter->scsi_host, 0,
  					unit->port->scsi_id, unit->scsi_lun);
+			zfcp_cb_unit_add(unit);
+		}
 		zfcp_unit_put(unit);
 		break;
 	case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
@@ -3478,4 +3470,126 @@
 	list_move(&erp_action->list, &erp_action->adapter->erp_ready_head);
 }
 
+/*
+ * function:	zfcp_erp_port_access_denied
+ *
+ * purpose:
+ */
+void
+zfcp_erp_port_access_denied(struct zfcp_port *port)
+{
+	struct zfcp_adapter *adapter = port->adapter;
+	unsigned long flags;
+
+	debug_text_event(adapter->erp_dbf, 3, "p_access_block");
+	debug_event(adapter->erp_dbf, 3, &port->wwpn, sizeof(wwn_t));
+	read_lock_irqsave(&zfcp_data.config_lock, flags);
+	zfcp_erp_modify_port_status(port,
+		ZFCP_STATUS_COMMON_ERP_FAILED | ZFCP_STATUS_COMMON_ACCESS_DENIED,
+		ZFCP_SET);
+	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
+}
+
+/*
+ * function:	zfcp_erp_unit_access_denied
+ *
+ * purpose:
+ */
+void
+zfcp_erp_unit_access_denied(struct zfcp_unit *unit)
+{
+	struct zfcp_adapter *adapter = unit->port->adapter;
+
+	debug_text_event(adapter->erp_dbf, 3, "u_access_block");
+	debug_event(adapter->erp_dbf, 3, &unit->fcp_lun, sizeof(fcp_lun_t));
+	zfcp_erp_modify_unit_status(unit,
+		ZFCP_STATUS_COMMON_ERP_FAILED | ZFCP_STATUS_COMMON_ACCESS_DENIED,
+		ZFCP_SET);
+}
+
+/*
+ * function:	zfcp_erp_adapter_access_changed
+ *
+ * purpose:
+ */
+void
+zfcp_erp_adapter_access_changed(struct zfcp_adapter *adapter)
+{
+	struct zfcp_port *port;
+	unsigned long flags;
+
+	debug_text_event(adapter->erp_dbf, 3, "a_access_unblock");
+	debug_event(adapter->erp_dbf, 3, &adapter->name, 8);
+
+	zfcp_erp_port_access_changed(adapter->nameserver_port);
+	read_lock_irqsave(&zfcp_data.config_lock, flags);
+	list_for_each_entry(port, &adapter->port_list_head, list)
+		if (port != adapter->nameserver_port)
+			zfcp_erp_port_access_changed(port);
+	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
+}
+
+/*
+ * function:	zfcp_erp_port_access_changed
+ *
+ * purpose:
+ */
+void
+zfcp_erp_port_access_changed(struct zfcp_port *port)
+{
+	struct zfcp_adapter *adapter = port->adapter;
+	struct zfcp_unit *unit;
+
+	debug_text_event(adapter->erp_dbf, 3, "p_access_unblock");
+	debug_event(adapter->erp_dbf, 3, &port->wwpn, sizeof(wwn_t));
+
+	if (!atomic_test_mask(ZFCP_STATUS_COMMON_ACCESS_DENIED, &port->status)) {
+		if (!atomic_test_mask(ZFCP_STATUS_PORT_WKA, &port->status))
+			list_for_each_entry(unit, &port->unit_list_head, list)
+				zfcp_erp_unit_access_changed(unit);
+		return;
+	}
+
+	ZFCP_LOG_NORMAL("Trying to reopen port 0x%016Lx on adapter %s "
+			"due to update to access control table\n",
+			port->wwpn, zfcp_get_busid_by_adapter(adapter));
+	if (zfcp_erp_port_reopen(port, ZFCP_STATUS_COMMON_ERP_FAILED) != 0)
+		ZFCP_LOG_NORMAL("Reopen of port 0x%016Lx on adapter %s failed\n",
+				port->wwpn, zfcp_get_busid_by_adapter(adapter));
+}
+
+/*
+ * function:	zfcp_erp_unit_access_changed
+ *
+ * purpose:
+ */
+void
+zfcp_erp_unit_access_changed(struct zfcp_unit *unit)
+{
+	struct zfcp_adapter *adapter = unit->port->adapter;
+
+	debug_text_event(adapter->erp_dbf, 3, "u_access_unblock");
+	debug_event(adapter->erp_dbf, 3, &unit->fcp_lun, sizeof(fcp_lun_t));
+
+	if (!atomic_test_mask(ZFCP_STATUS_COMMON_ACCESS_DENIED, &unit->status))
+		return;
+
+	ZFCP_LOG_NORMAL("Trying to reopen unit 0x%016Lx "
+			"on port 0x%016Lx on adapter %s "
+			"due to update to access control table\n",
+			unit->fcp_lun, unit->port->wwpn,
+			zfcp_get_busid_by_adapter(adapter));
+	if (zfcp_erp_unit_reopen(unit, ZFCP_STATUS_COMMON_ERP_FAILED) != 0)
+		ZFCP_LOG_NORMAL("Reopen of unit 0x%016Lx "
+				"on port 0x%016Lx on adapter %s failed\n",
+				unit->fcp_lun, unit->port->wwpn,
+				zfcp_get_busid_by_adapter(adapter));
+}
+
 #undef ZFCP_LOG_AREA
+
+EXPORT_SYMBOL(zfcp_erp_wait);
+EXPORT_SYMBOL(zfcp_erp_port_reopen);
+EXPORT_SYMBOL(zfcp_erp_unit_reopen);
+EXPORT_SYMBOL(zfcp_erp_unit_shutdown);
+EXPORT_SYMBOL(zfcp_fsf_request_timeout_handler);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-patched/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_ext.h	2004-11-11 15:07:01.000000000 +0100
@@ -32,7 +32,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.58 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.60 $"
 
 #include "zfcp_def.h"
 
@@ -171,10 +171,34 @@
 
 extern int  zfcp_test_link(struct zfcp_port *);
 
+extern void zfcp_erp_port_access_denied(struct zfcp_port *);
+extern void zfcp_erp_unit_access_denied(struct zfcp_unit *);
+extern void zfcp_erp_adapter_access_changed(struct zfcp_adapter *);
+extern void zfcp_erp_port_access_changed(struct zfcp_port *);
+extern void zfcp_erp_unit_access_changed(struct zfcp_unit *);
+
 /******************************** AUX ****************************************/
 extern void zfcp_cmd_dbf_event_fsf(const char *, struct zfcp_fsf_req *,
 				   void *, int);
 extern void zfcp_cmd_dbf_event_scsi(const char *, struct scsi_cmnd *);
 extern void zfcp_in_els_dbf_event(struct zfcp_adapter *, const char *,
 				  struct fsf_status_read_buffer *, int);
+extern int zfcp_sg_list_alloc(struct zfcp_sg_list *, size_t);
+extern void zfcp_sg_list_free(struct zfcp_sg_list *);
+extern int zfcp_sg_list_copy_from_user(struct zfcp_sg_list *, void __user *,
+				       size_t);
+extern int zfcp_sg_list_copy_to_user(void __user *, struct zfcp_sg_list *,
+				     size_t);
+extern size_t zfcp_sg_size(struct scatterlist *, unsigned int);
+
+void zfcp_register_callbacks(struct zfcp_callbacks *);
+void zfcp_unregister_callbacks(void);
+
+extern void zfcp_cb_incoming_els(struct zfcp_adapter *, void *);
+extern void zfcp_cb_link_down(struct zfcp_adapter *);
+extern void zfcp_cb_link_up(struct zfcp_adapter *);
+extern void zfcp_cb_adapter_add(struct zfcp_adapter *);
+extern void zfcp_cb_port_add(struct zfcp_port *);
+extern void zfcp_cb_unit_add(struct zfcp_unit *);
+
 #endif	/* ZFCP_EXT_H */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	2004-11-11 15:07:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c	2004-11-11 15:07:01.000000000 +0100
@@ -31,7 +31,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.80 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.83 $"
 
 #include "zfcp_ext.h"
 
@@ -1020,6 +1020,8 @@
 		atomic_set_mask(ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED,
 				&adapter->status);
 		zfcp_erp_adapter_failed(adapter);
+
+		zfcp_cb_link_down(adapter);
 		break;
 
 	case FSF_STATUS_READ_LINK_UP:
@@ -1036,6 +1038,8 @@
 					ZFCP_STATUS_ADAPTER_LINK_UNPLUGGED
 					| ZFCP_STATUS_COMMON_ERP_FAILED);
 
+		zfcp_cb_link_up(adapter);
+
 		break;
 
 	case FSF_STATUS_READ_CFDC_UPDATED:
@@ -1043,6 +1047,7 @@
 		debug_text_event(adapter->erp_dbf, 2, "unsol_cfdc_update:");
 		ZFCP_LOG_INFO("CFDC has been updated on the adapter %s\n",
 			      zfcp_get_busid_by_adapter(adapter));
+		zfcp_erp_adapter_access_changed(adapter);
 		break;
 
 	case FSF_STATUS_READ_CFDC_HARDENED:
@@ -1620,7 +1625,8 @@
 				break;
 			}
 		}
-		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
+		debug_text_event(adapter->erp_dbf, 1, "fsf_s_access");
+		zfcp_erp_port_access_denied(port);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
@@ -2000,6 +2006,11 @@
 			}
 		}
 		debug_text_event(adapter->erp_dbf, 1, "fsf_s_access");
+		read_lock(&zfcp_data.config_lock);
+		port = zfcp_get_port_by_did(adapter, d_id);
+		if (port != NULL)
+			zfcp_erp_port_access_denied(port);
+		read_unlock(&zfcp_data.config_lock);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
@@ -2244,6 +2255,8 @@
 		}
 		atomic_set_mask(ZFCP_STATUS_ADAPTER_XCONFIG_OK,
 				&adapter->status);
+		zfcp_cb_adapter_add(adapter);
+
 		break;
 	case FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE:
 		debug_text_event(adapter->erp_dbf, 0, "xchg-inco");
@@ -2478,7 +2491,7 @@
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
 		ZFCP_LOG_NORMAL("Access denied, cannot open port 0x%016Lx "
 				"on adapter %s\n",
-			port->wwpn, zfcp_get_busid_by_port(port));
+				port->wwpn, zfcp_get_busid_by_port(port));
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
 			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
@@ -2493,8 +2506,7 @@
 			}
 		}
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
-		atomic_set_mask(ZFCP_STATUS_PORT_ACCESS_DENIED, &port->status);
-		zfcp_erp_port_failed(port);
+		zfcp_erp_port_access_denied(port);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
@@ -2886,9 +2898,8 @@
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
 		ZFCP_LOG_NORMAL("Access denied, cannot close "
-				"physical port 0x%016Lx on "
-				"adapter %s\n", port->wwpn,
-				zfcp_get_busid_by_port(port));
+				"physical port 0x%016Lx on adapter %s\n",
+				port->wwpn, zfcp_get_busid_by_port(port));
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
 			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
@@ -2903,6 +2914,7 @@
 			}
 		}
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
+		zfcp_erp_port_access_denied(port);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
@@ -3073,7 +3085,6 @@
 	u16 subtable, rule, counter;
 	u32 allowed, exclusive, readwrite;
 
-
 	unit = fsf_req->data.open_unit.unit;
 
 	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR) {
@@ -3085,15 +3096,62 @@
 	header = &fsf_req->qtcb->header;
 	bottom = &fsf_req->qtcb->bottom.support;
 	queue_designator = &header->fsf_status_qual.fsf_queue_designator;
-	allowed = bottom->lun_access_info & FSF_UNIT_ACCESS_OPEN_LUN_ALLOWED;
-	exclusive = bottom->lun_access_info & FSF_UNIT_ACCESS_EXCLUSIVE_ACCESS;
+
+	allowed   = bottom->lun_access_info & FSF_UNIT_ACCESS_OPEN_LUN_ALLOWED;
+	exclusive = bottom->lun_access_info & FSF_UNIT_ACCESS_EXCLUSIVE;
 	readwrite = bottom->lun_access_info & FSF_UNIT_ACCESS_OUTBOUND_TRANSFER;
 
-        atomic_clear_mask(ZFCP_STATUS_UNIT_ACCESS_DENIED |
-			  ZFCP_STATUS_UNIT_ACCESS_SHARED |
-			  ZFCP_STATUS_UNIT_ACCESS_READONLY,
+	if (!adapter->supported_features & FSF_FEATURE_CFDC)
+		goto no_cfdc;
+
+	atomic_clear_mask(ZFCP_STATUS_COMMON_ACCESS_DENIED |
+			  ZFCP_STATUS_UNIT_SHARED |
+			  ZFCP_STATUS_UNIT_READONLY,
 			  &unit->status);
 
+	if (!allowed)
+		atomic_set_mask(ZFCP_STATUS_COMMON_ACCESS_DENIED, &unit->status);
+
+	if (!adapter->supported_features & FSF_FEATURE_LUN_SHARING)
+		goto no_lun_sharing;
+
+	if (!exclusive)
+		atomic_set_mask(ZFCP_STATUS_UNIT_SHARED, &unit->status);
+
+	if (!readwrite) {
+		atomic_set_mask(ZFCP_STATUS_UNIT_READONLY, &unit->status);
+		ZFCP_LOG_NORMAL("Unit 0x%016Lx on port 0x%016Lx on adapter %s "
+				"accessed read-only\n", unit->fcp_lun,
+				unit->port->wwpn, zfcp_get_busid_by_unit(unit));
+	}
+
+	if (exclusive && !readwrite) {
+		ZFCP_LOG_NORMAL("Exclusive access of read-only unit not "
+				"supported\n");
+		zfcp_erp_unit_failed(unit);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		goto skip_fsfstatus;
+	}
+	if (!exclusive && readwrite) {
+		ZFCP_LOG_NORMAL("Shared access of read-write unit is not "
+				"supported\n");
+		zfcp_erp_unit_failed(unit);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		goto skip_fsfstatus;
+	}
+
+ no_lun_sharing:
+ no_cfdc:
+	if (!(adapter->supported_features & FSF_FEATURE_CFDC) &&
+	    (adapter->supported_features & FSF_FEATURE_LUN_SHARING)) {
+		ZFCP_LOG_NORMAL("LUN sharing without access control is not "
+				"supported.\n");
+		zfcp_erp_unit_failed(unit);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		goto skip_fsfstatus;
+	}
+
+
 	/* evaluate FSF status in QTCB */
 	switch (header->fsf_status) {
 
@@ -3144,12 +3202,7 @@
 			}
 		}
 		debug_text_event(adapter->erp_dbf, 1, "fsf_s_access");
-		atomic_set_mask(ZFCP_STATUS_UNIT_ACCESS_DENIED, &unit->status);
-		atomic_clear_mask(ZFCP_STATUS_UNIT_ACCESS_SHARED,
-				  &unit->status);
-                atomic_clear_mask(ZFCP_STATUS_UNIT_ACCESS_READONLY,
-				  &unit->status);
-		zfcp_erp_unit_failed(unit);
+		zfcp_erp_unit_access_denied(unit);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
@@ -3279,13 +3332,12 @@
 
 		if (adapter->supported_features & FSF_FEATURE_LUN_SHARING){
 			if (!exclusive)
-		                atomic_set_mask(ZFCP_STATUS_UNIT_ACCESS_SHARED,
+		                atomic_set_mask(ZFCP_STATUS_UNIT_SHARED,
 						&unit->status);
 
 			if (!readwrite) {
-                		atomic_set_mask(
-					ZFCP_STATUS_UNIT_ACCESS_READONLY,
-					&unit->status);
+                		atomic_set_mask(ZFCP_STATUS_UNIT_READONLY,
+						&unit->status);
                 		ZFCP_LOG_NORMAL("read-only access for unit "
 						"(adapter %s, wwpn=0x%016Lx, "
 						"fcp_lun=0x%016Lx)\n",
@@ -3322,7 +3374,7 @@
 		break;
 	}
 
-      skip_fsfstatus:
+ skip_fsfstatus:
 	atomic_clear_mask(ZFCP_STATUS_COMMON_OPENING, &unit->status);
 	return retval;
 }
@@ -3643,8 +3695,7 @@
 	/* set FCP_LUN in FCP_CMND IU in QTCB */
 	fcp_cmnd_iu->fcp_lun = unit->fcp_lun;
 
-	mask = ZFCP_STATUS_UNIT_ACCESS_READONLY |
-		ZFCP_STATUS_UNIT_ACCESS_SHARED;
+	mask = ZFCP_STATUS_UNIT_READONLY | ZFCP_STATUS_UNIT_SHARED;
 
 	/* set task attributes in FCP_CMND IU in QTCB */
 	if (likely((scsi_cmnd->device->simple_tags) ||
@@ -3986,6 +4037,7 @@
 			}
 		}
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
+		zfcp_erp_unit_access_denied(unit);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
@@ -5086,3 +5138,7 @@
 }
 
 #undef ZFCP_LOG_AREA
+
+EXPORT_SYMBOL(zfcp_fsf_exchange_port_data);
+EXPORT_SYMBOL(zfcp_fsf_send_ct);
+EXPORT_SYMBOL(zfcp_fsf_send_els);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.h linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.h
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.h	2004-11-11 15:07:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.h	2004-11-11 15:07:01.000000000 +0100
@@ -233,9 +233,9 @@
 #define FSF_IOSTAT_LS_RJT			0x00000009
 
 /* open LUN access flags*/
-#define FSF_UNIT_ACCESS_OPEN_LUN_ALLOWED        0x01000000
-#define FSF_UNIT_ACCESS_EXCLUSIVE_ACCESS        0x02000000
-#define FSF_UNIT_ACCESS_OUTBOUND_TRANSFER       0x10000000
+#define FSF_UNIT_ACCESS_OPEN_LUN_ALLOWED	0x01000000
+#define FSF_UNIT_ACCESS_EXCLUSIVE		0x02000000
+#define FSF_UNIT_ACCESS_OUTBOUND_TRANSFER	0x10000000
 
 struct fsf_queue_designator;
 struct fsf_status_read_buffer;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c	2004-11-11 15:07:01.000000000 +0100
@@ -32,7 +32,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.71 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.72 $"
 
 #include "zfcp_ext.h"
 
@@ -948,3 +948,6 @@
 };
 
 #undef ZFCP_LOG_AREA
+
+EXPORT_SYMBOL(zfcp_data);
+EXPORT_SYMBOL(zfcp_scsi_command_sync);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	2004-11-11 15:07:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_port.c	2004-11-11 15:07:01.000000000 +0100
@@ -28,7 +28,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.46 $"
+#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.47 $"
 
 #include "zfcp_ext.h"
 
@@ -71,7 +71,7 @@
 ZFCP_DEFINE_PORT_ATTR(in_recovery, "%d\n", atomic_test_mask
 		      (ZFCP_STATUS_COMMON_ERP_INUSE, &port->status));
 ZFCP_DEFINE_PORT_ATTR(access_denied, "%d\n", atomic_test_mask
-		      (ZFCP_STATUS_PORT_ACCESS_DENIED, &port->status));
+		      (ZFCP_STATUS_COMMON_ACCESS_DENIED, &port->status));
 
 /**
  * zfcp_sysfs_unit_add_store - add a unit to sysfs tree
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c	2004-11-11 15:07:01.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_unit.c	2004-11-11 15:07:01.000000000 +0100
@@ -28,7 +28,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.29 $"
+#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.30 $"
 
 #include "zfcp_ext.h"
 
@@ -69,11 +69,11 @@
 ZFCP_DEFINE_UNIT_ATTR(in_recovery, "%d\n", atomic_test_mask
 		      (ZFCP_STATUS_COMMON_ERP_INUSE, &unit->status));
 ZFCP_DEFINE_UNIT_ATTR(access_denied, "%d\n", atomic_test_mask
-		      (ZFCP_STATUS_UNIT_ACCESS_DENIED, &unit->status));
+		      (ZFCP_STATUS_COMMON_ACCESS_DENIED, &unit->status));
 ZFCP_DEFINE_UNIT_ATTR(access_shared, "%d\n", atomic_test_mask
-		      (ZFCP_STATUS_UNIT_ACCESS_SHARED, &unit->status));
+		      (ZFCP_STATUS_UNIT_SHARED, &unit->status));
 ZFCP_DEFINE_UNIT_ATTR(access_readonly, "%d\n", atomic_test_mask
-		      (ZFCP_STATUS_UNIT_ACCESS_READONLY, &unit->status));
+		      (ZFCP_STATUS_UNIT_READONLY, &unit->status));
 
 /**
  * zfcp_sysfs_unit_failed_store - failed state of unit
