Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbUKKRbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbUKKRbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 12:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbUKKRau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:30:50 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:6876 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262305AbUKKRRR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:17:17 -0500
Date: Thu, 11 Nov 2004 18:17:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 8/10] s390: zfcp host adapter.
Message-ID: <20041111171706.GJ4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 8/10] s390: zfcp host adapter.

From: Andreas Herrmann <aherrman@de.ibm.com>

zfcp host adapter change:
 - Avoid usage of unregister debug feature.
 - Avoid race when unregistering debug feature.
 - Corrected some log messages for WKA ports.
 - Don't pass NULL pointer to debug_register_view and debug_set_level.
 - Some coding style cleanup.
 - Fix race between scsi_add_device and deregistration of the adapter.
 - Shorten & rename zfcp_els/zfcp_els_handler.
 - Remove unused code for unused ELS commands.
 - Evaluate response instead of request in adisc handler.
 - Allocate qdio queue structures below 2GB.
 - Remove ifdefs around ioctl32.h.
 - Use CONFIG_COMPAT instead of CONFIG_S390_SUPPORT.
 - Use semaphore in zfcp_ccw_shutdown.
 - Strip down debug_register/debug_unregister.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_aux.c |   67 +++----
 drivers/s390/scsi/zfcp_ccw.c |    4 
 drivers/s390/scsi/zfcp_def.h |   97 +---------
 drivers/s390/scsi/zfcp_erp.c |  384 +++++++++++++++----------------------------
 drivers/s390/scsi/zfcp_fsf.c |   64 +++----
 5 files changed, 217 insertions(+), 399 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c	2004-11-11 15:06:59.000000000 +0100
@@ -29,8 +29,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-/* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.135 $"
+#define ZFCP_AUX_REVISION "$Revision: 1.144 $"
 
 #include "zfcp_ext.h"
 
@@ -61,7 +60,7 @@
 #define ZFCP_CFDC_IOC \
 	_IOWR(ZFCP_CFDC_IOC_MAGIC, 0, struct zfcp_cfdc_sense_data)
 
-#ifdef CONFIG_S390_SUPPORT
+#ifdef CONFIG_COMPAT
 static struct ioctl_trans zfcp_ioctl_trans = {ZFCP_CFDC_IOC, (void*) sys_ioctl};
 #endif
 
@@ -147,7 +146,7 @@
 	int i;
 	unsigned long flags;
 
-	write_lock_irqsave(&adapter->cmd_dbf_lock, flags);
+	spin_lock_irqsave(&adapter->dbf_lock, flags);
 	if (zfcp_fsf_req_is_scsi_cmnd(fsf_req)) {
 		scsi_cmnd = fsf_req->data.send_fcp_command_task.scsi_cmnd;
 		debug_text_event(adapter->cmd_dbf, level, "fsferror");
@@ -166,7 +165,7 @@
 				    (char *) add_data + i,
 				    min(ZFCP_CMD_DBF_LENGTH, add_length - i));
 	}
-	write_unlock_irqrestore(&adapter->cmd_dbf_lock, flags);
+	spin_unlock_irqrestore(&adapter->dbf_lock, flags);
 }
 
 /* XXX additionally log unit if available */
@@ -183,7 +182,7 @@
 	adapter = (struct zfcp_adapter *) scsi_cmnd->device->host->hostdata[0];
 	req_data = (union zfcp_req_data *) scsi_cmnd->host_scribble;
 	fsf_req = (req_data ? req_data->send_fcp_command_task.fsf_req : NULL);
-	write_lock_irqsave(&adapter->cmd_dbf_lock, flags);
+	spin_lock_irqsave(&adapter->dbf_lock, flags);
 	debug_text_event(adapter->cmd_dbf, level, "hostbyte");
 	debug_text_event(adapter->cmd_dbf, level, text);
 	debug_event(adapter->cmd_dbf, level, &scsi_cmnd->result, sizeof (u32));
@@ -200,7 +199,7 @@
 		debug_text_event(adapter->cmd_dbf, level, "");
 		debug_text_event(adapter->cmd_dbf, level, "");
 	}
-	write_unlock_irqrestore(&adapter->cmd_dbf_lock, flags);
+	spin_unlock_irqrestore(&adapter->dbf_lock, flags);
 }
 
 void
@@ -280,7 +279,7 @@
 		goto out_unit;
 	up(&zfcp_data.config_sema);
 	ccw_device_set_online(adapter->ccw_device);
-	wait_event(unit->scsi_add_wq, atomic_read(&unit->scsi_add_work) == 0);
+	zfcp_erp_wait(adapter);
 	down(&zfcp_data.config_sema);
 	zfcp_unit_put(unit);
  out_unit:
@@ -310,14 +309,13 @@
 	if (!zfcp_transport_template)
 		return -ENODEV;
 
-#ifdef CONFIG_S390_SUPPORT
 	retval = register_ioctl32_conversion(zfcp_ioctl_trans.cmd,
 					     zfcp_ioctl_trans.handler);
 	if (retval != 0) {
 		ZFCP_LOG_INFO("registration of ioctl32 conversion failed\n");
-		goto out_ioctl32;
+		goto out;
 	}
-#endif
+
 	retval = misc_register(&zfcp_cfdc_misc);
 	if (retval != 0) {
 		ZFCP_LOG_INFO("registration of misc device "
@@ -352,11 +350,7 @@
  out_ccw_register:
 	misc_deregister(&zfcp_cfdc_misc);
  out_misc_register:
-#ifdef CONFIG_S390_SUPPORT
 	unregister_ioctl32_conversion(zfcp_ioctl_trans.cmd);
- out_ioctl32:
-#endif
-
  out:
 	return retval;
 }
@@ -868,7 +862,6 @@
 		return NULL;
 	memset(unit, 0, sizeof (struct zfcp_unit));
 
-	init_waitqueue_head(&unit->scsi_add_wq);
 	/* initialise reference count stuff */
 	atomic_set(&unit->refcount, 0);
 	init_waitqueue_head(&unit->remove_wq);
@@ -1042,11 +1035,11 @@
 	char dbf_name[20];
 
 	/* debug feature area which records SCSI command failures (hostbyte) */
-	rwlock_init(&adapter->cmd_dbf_lock);
+	spin_lock_init(&adapter->dbf_lock);
+
 	sprintf(dbf_name, ZFCP_CMD_DBF_NAME "%s",
 		zfcp_get_busid_by_adapter(adapter));
-	adapter->cmd_dbf = debug_register(dbf_name,
-					  ZFCP_CMD_DBF_INDEX,
+	adapter->cmd_dbf = debug_register(dbf_name, ZFCP_CMD_DBF_INDEX,
 					  ZFCP_CMD_DBF_AREAS,
 					  ZFCP_CMD_DBF_LENGTH);
 	debug_register_view(adapter->cmd_dbf, &debug_hex_ascii_view);
@@ -1055,40 +1048,38 @@
 	/* debug feature area which records SCSI command aborts */
 	sprintf(dbf_name, ZFCP_ABORT_DBF_NAME "%s",
 		zfcp_get_busid_by_adapter(adapter));
-	adapter->abort_dbf = debug_register(dbf_name,
-					    ZFCP_ABORT_DBF_INDEX,
+	adapter->abort_dbf = debug_register(dbf_name, ZFCP_ABORT_DBF_INDEX,
 					    ZFCP_ABORT_DBF_AREAS,
 					    ZFCP_ABORT_DBF_LENGTH);
 	debug_register_view(adapter->abort_dbf, &debug_hex_ascii_view);
 	debug_set_level(adapter->abort_dbf, ZFCP_ABORT_DBF_LEVEL);
 
-	/* debug feature area which records SCSI command aborts */
+	/* debug feature area which records incoming ELS commands */
 	sprintf(dbf_name, ZFCP_IN_ELS_DBF_NAME "%s",
 		zfcp_get_busid_by_adapter(adapter));
-	adapter->in_els_dbf = debug_register(dbf_name,
-					     ZFCP_IN_ELS_DBF_INDEX,
+	adapter->in_els_dbf = debug_register(dbf_name, ZFCP_IN_ELS_DBF_INDEX,
 					     ZFCP_IN_ELS_DBF_AREAS,
 					     ZFCP_IN_ELS_DBF_LENGTH);
 	debug_register_view(adapter->in_els_dbf, &debug_hex_ascii_view);
 	debug_set_level(adapter->in_els_dbf, ZFCP_IN_ELS_DBF_LEVEL);
 
-
 	/* debug feature area which records erp events */
 	sprintf(dbf_name, ZFCP_ERP_DBF_NAME "%s",
 		zfcp_get_busid_by_adapter(adapter));
-	adapter->erp_dbf = debug_register(dbf_name,
-					  ZFCP_ERP_DBF_INDEX,
+	adapter->erp_dbf = debug_register(dbf_name, ZFCP_ERP_DBF_INDEX,
 					  ZFCP_ERP_DBF_AREAS,
 					  ZFCP_ERP_DBF_LENGTH);
 	debug_register_view(adapter->erp_dbf, &debug_hex_ascii_view);
 	debug_set_level(adapter->erp_dbf, ZFCP_ERP_DBF_LEVEL);
 
-	if (adapter->cmd_dbf && adapter->abort_dbf &&
-	    adapter->in_els_dbf && adapter->erp_dbf)
-		return 0;
+	if (!(adapter->cmd_dbf && adapter->abort_dbf &&
+	      adapter->in_els_dbf && adapter->erp_dbf)) {
+		zfcp_adapter_debug_unregister(adapter);
+		return -ENOMEM;
+	}
+
+	return 0;
 
-	zfcp_adapter_debug_unregister(adapter);
-	return -ENOMEM;
 }
 
 /**
@@ -1098,10 +1089,14 @@
 void
 zfcp_adapter_debug_unregister(struct zfcp_adapter *adapter)
 {
-	debug_unregister(adapter->erp_dbf);
-	debug_unregister(adapter->cmd_dbf);
-	debug_unregister(adapter->abort_dbf);
-	debug_unregister(adapter->in_els_dbf);
+ 	debug_unregister(adapter->abort_dbf);
+ 	debug_unregister(adapter->cmd_dbf);
+ 	debug_unregister(adapter->erp_dbf);
+ 	debug_unregister(adapter->in_els_dbf);
+	adapter->abort_dbf = NULL;
+	adapter->cmd_dbf = NULL;
+	adapter->erp_dbf = NULL;
+	adapter->in_els_dbf = NULL;
 }
 
 void
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-patched/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_ccw.c	2004-11-11 15:06:59.000000000 +0100
@@ -27,7 +27,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_CCW_C_REVISION "$Revision: 1.57 $"
+#define ZFCP_CCW_C_REVISION "$Revision: 1.58 $"
 
 #include "zfcp_ext.h"
 
@@ -302,9 +302,11 @@
 {
 	struct zfcp_adapter *adapter;
 
+	down(&zfcp_data.config_sema);
 	adapter = dev_get_drvdata(dev);
 	zfcp_erp_adapter_shutdown(adapter, 0);
 	zfcp_erp_wait(adapter);
+	up(&zfcp_data.config_sema);
 }
 
 #undef ZFCP_LOG_AREA
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-patched/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_def.h	2004-11-11 15:06:59.000000000 +0100
@@ -34,7 +34,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.98 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.107 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -61,9 +61,7 @@
 #include <linux/mempool.h>
 #include <linux/syscalls.h>
 #include <linux/ioctl.h>
-#ifdef CONFIG_S390_SUPPORT
 #include <linux/ioctl32.h>
-#endif
 
 /************************ DEBUG FLAGS *****************************************/
 
@@ -71,8 +69,7 @@
 
 /********************* GENERAL DEFINES *********************************/
 
-/* zfcp version number, it consists of major, minor, and patch-level number */
-#define ZFCP_VERSION		"4.1.4"
+#define ZFCP_VERSION		"4.2.0"
 
 /**
  * zfcp_sg_to_address - determine kernel address from struct scatterlist
@@ -290,11 +287,11 @@
 #define R_A_TOV				10 /* seconds */
 #define ZFCP_ELS_TIMEOUT		(2 * R_A_TOV)
 
-#define ZFCP_LS_RTV			0x0E
-#define ZFCP_LS_RLS			0x0F
-#define ZFCP_LS_PDISC			0x50
+#define ZFCP_LS_RLS			0x0f
 #define ZFCP_LS_ADISC			0x52
-#define ZFCP_LS_RTV_E_D_TOV_FLAG	0x04000000
+#define ZFCP_LS_RPS			0x56
+#define ZFCP_LS_RSCN			0x61
+#define ZFCP_LS_RNID			0x78
 
 struct zfcp_ls_rjt_par {
 	u8 action;
@@ -303,82 +300,22 @@
  	u8 vendor_unique;
 } __attribute__ ((packed));
 
-struct zfcp_ls_rtv {
-	u8		code;
-	u8		field[3];
-} __attribute__ ((packed));
-
-struct zfcp_ls_rtv_acc {
-	u8		code;
-	u8		field[3];
-	u32		r_a_tov;
-	u32		e_d_tov;
-	u32		qualifier;
-} __attribute__ ((packed));
-
-struct zfcp_ls_rls {
-	u8		code;
-	u8		field[3];
-	fc_id_t		port_id;
-} __attribute__ ((packed));
-
-struct zfcp_ls_rls_acc {
-	u8		code;
-	u8		field[3];
-	u32		link_failure_count;
-	u32		loss_of_sync_count;
-	u32		loss_of_signal_count;
-	u32		prim_seq_prot_error;
-	u32		invalid_transmition_word;
-	u32		invalid_crc_count;
-} __attribute__ ((packed));
-
-struct zfcp_ls_pdisc {
-	u8		code;
-	u8		field[3];
-	u8		common_svc_parm[16];
-		wwn_t	wwpn;
-	wwn_t		wwnn;
-	struct {
-		u8	class1[16];
-		u8	class2[16];
-		u8	class3[16];
-	} svc_parm;
-	u8		reserved[16];
-	u8		vendor_version[16];
-} __attribute__ ((packed));
-
-struct zfcp_ls_pdisc_acc {
-	u8		code;
-	u8		field[3];
-	u8		common_svc_parm[16];
-	wwn_t		wwpn;
-	wwn_t		wwnn;
-	struct {
-		u8	class1[16];
-		u8	class2[16];
-		u8	class3[16];
-	} svc_parm;
-	u8		reserved[16];
-	u8		vendor_version[16];
-} __attribute__ ((packed));
-
 struct zfcp_ls_adisc {
 	u8		code;
 	u8		field[3];
-	fc_id_t		hard_nport_id;
-	wwn_t		wwpn;
-	wwn_t		wwnn;
-	fc_id_t		nport_id;
+	u32		hard_nport_id;
+	u64		wwpn;
+	u64		wwnn;
+	u32		nport_id;
 } __attribute__ ((packed));
 
 struct zfcp_ls_adisc_acc {
 	u8		code;
 	u8		field[3];
-	fc_id_t		hard_nport_id;
-	wwn_t		wwpn;
-	wwn_t		wwnn;
-	fc_id_t		nport_id;
+	u32		hard_nport_id;
+	u64		wwpn;
+	u64		wwnn;
+	u32		nport_id;
 } __attribute__ ((packed));
 
 struct zfcp_rc_entry {
@@ -490,7 +427,7 @@
 /* logging routine for zfcp */
 #define _ZFCP_LOG(fmt, args...) \
 	printk(KERN_ERR ZFCP_NAME": %s(%d): " fmt, __FUNCTION__, \
-	       __LINE__ , ##args);
+	       __LINE__ , ##args)
 
 #define ZFCP_LOG(level, fmt, args...) \
 do { \
@@ -956,7 +893,7 @@
 	debug_info_t            *abort_dbf;
 	debug_info_t            *in_els_dbf;
 	debug_info_t            *cmd_dbf;
-	rwlock_t                cmd_dbf_lock;
+	spinlock_t              dbf_lock;
 	struct zfcp_adapter_mempool	pool;      /* Adapter memory pools */
 	struct qdio_initialize  qdio_init_data;    /* for qdio_establish */
 	struct device           generic_services;  /* directory for WKA ports */
@@ -1006,8 +943,6 @@
         struct scsi_device     *device;        /* scsi device struct pointer */
 	struct zfcp_erp_action erp_action;     /* pending error recovery */
         atomic_t               erp_counter;
-	atomic_t               scsi_add_work;  /* used to synchronize */
-	wait_queue_head_t      scsi_add_wq;    /* wait for scsi_add_device */
 };
 
 /* FSF request */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c	2004-11-11 15:06:59.000000000 +0100
@@ -32,12 +32,12 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.69 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.76 $"
 
 #include "zfcp_ext.h"
 
-static int zfcp_els(struct zfcp_port *, u8);
-static void zfcp_els_handler(unsigned long);
+static int zfcp_erp_adisc(struct zfcp_adapter *, fc_id_t);
+static void zfcp_erp_adisc_handler(unsigned long);
 
 static int zfcp_erp_adapter_reopen_internal(struct zfcp_adapter *, int);
 static int zfcp_erp_port_forced_reopen_internal(struct zfcp_port *, int);
@@ -294,162 +294,125 @@
 }
 
 
-/*
- * function:    zfcp_els
- *
- * purpose:     Originator of the ELS commands
- *
- * returns:     0       - Operation completed successfuly
- *              -EINVAL - Unknown IOCTL command or invalid sense data record
- *              -ENOMEM - Insufficient memory
- *              -EPERM  - Cannot create or queue FSF request
+/**
+ * zfcp_erp_adisc - send ADISC ELS command
+ * @adapter: adapter structure
+ * @d_id: d_id of port where ADISC is sent to
  */
 int
-zfcp_els(struct zfcp_port *port, u8 ls_code)
+zfcp_erp_adisc(struct zfcp_adapter *adapter, fc_id_t d_id)
 {
 	struct zfcp_send_els *send_els;
-	struct zfcp_ls_rls *rls;
-	struct zfcp_ls_pdisc *pdisc;
 	struct zfcp_ls_adisc *adisc;
-	struct page *page = NULL;
-	void *req;
+	void *address = NULL;
 	int retval = 0;
+	struct timer_list *timer;
 
 	send_els = kmalloc(sizeof(struct zfcp_send_els), GFP_ATOMIC);
 	if (send_els == NULL)
 		goto nomem;
+	memset(send_els, 0, sizeof(*send_els));
 
 	send_els->req = kmalloc(sizeof(struct scatterlist), GFP_ATOMIC);
 	if (send_els->req == NULL)
 		goto nomem;
-	send_els->req_count = 1;
+	memset(send_els->req, 0, sizeof(*send_els->req));
 
 	send_els->resp = kmalloc(sizeof(struct scatterlist), GFP_ATOMIC);
 	if (send_els->resp == NULL)
 		goto nomem;
-	send_els->resp_count = 1;
+	memset(send_els->resp, 0, sizeof(*send_els->resp));
 
-	page = alloc_pages(GFP_ATOMIC, 0);
-	if (page == NULL)
+	address = (void *) get_zeroed_page(GFP_ATOMIC);
+	if (address == NULL)
 		goto nomem;
-	send_els->req->page = page;
-	send_els->resp->page = page;
-	send_els->req->offset = 0;
-	send_els->resp->offset = PAGE_SIZE >> 1;
-
-	send_els->adapter = port->adapter;
-	send_els->d_id = port->d_id;
-	send_els->ls_code = ls_code;
-	send_els->handler = zfcp_els_handler;
-	send_els->handler_data = (unsigned long)send_els;
-	send_els->completion = NULL;
-
-	req = zfcp_sg_to_address(send_els->req);
-	memset(req, 0, PAGE_SIZE);
-
-	*(u32*)req = 0;
-	*(u8*)req = ls_code;
-
-	switch (ls_code) {
-
-	case ZFCP_LS_RTV:
-		send_els->req->length = sizeof(struct zfcp_ls_rtv);
-		send_els->resp->length = sizeof(struct zfcp_ls_rtv_acc);
-		ZFCP_LOG_INFO("RTV request from s_id 0x%08x to d_id 0x%08x\n",
-			      port->adapter->s_id, port->d_id);
-		break;
-
-	case ZFCP_LS_RLS:
-		send_els->req->length = sizeof(struct zfcp_ls_rls);
-		send_els->resp->length = sizeof(struct zfcp_ls_rls_acc);
-		rls = (struct zfcp_ls_rls*)req;
-		rls->port_id = port->adapter->s_id;
-		ZFCP_LOG_INFO("RLS request from s_id 0x%08x to d_id 0x%08x "
-			      "(port_id=0x%08x)\n",
-			      port->adapter->s_id, port->d_id, rls->port_id);
-		break;
-
-	case ZFCP_LS_PDISC:
-		send_els->req->length = sizeof(struct zfcp_ls_pdisc);
-		send_els->resp->length = sizeof(struct zfcp_ls_pdisc_acc);
-		pdisc = (struct zfcp_ls_pdisc*)req;
-		pdisc->wwpn = port->adapter->wwpn;
-		pdisc->wwnn = port->adapter->wwnn;
-		ZFCP_LOG_INFO("PDISC request from s_id 0x%08x to d_id 0x%08x "
-			      "(wwpn=0x%016Lx, wwnn=0x%016Lx)\n",
-			      port->adapter->s_id, port->d_id,
-			      pdisc->wwpn, pdisc->wwnn);
-		break;
-
-	case ZFCP_LS_ADISC:
-		send_els->req->length = sizeof(struct zfcp_ls_adisc);
-		send_els->resp->length = sizeof(struct zfcp_ls_adisc_acc);
-		adisc = (struct zfcp_ls_adisc*)req;
-		adisc->hard_nport_id = port->adapter->s_id;
-		adisc->wwpn = port->adapter->wwpn;
-		adisc->wwnn = port->adapter->wwnn;
-		adisc->nport_id = port->adapter->s_id;
-		ZFCP_LOG_INFO("ADISC request from s_id 0x%08x to d_id 0x%08x "
-			      "(wwpn=0x%016Lx, wwnn=0x%016Lx, "
-			      "hard_nport_id=0x%08x, nport_id=0x%08x)\n",
-			      port->adapter->s_id, port->d_id,
-			      adisc->wwpn, adisc->wwnn,
-			      adisc->hard_nport_id, adisc->nport_id);
-		break;
 
-	default:
-		ZFCP_LOG_NORMAL("ELS command code 0x%02x is not supported\n",
-				ls_code);
-		retval = -EINVAL;
-		goto invalid_ls_code;
-	}
+	zfcp_address_to_sg(address, send_els->req);
+	address += PAGE_SIZE >> 1;
+	zfcp_address_to_sg(address, send_els->resp);
+	send_els->req_count = send_els->resp_count = 1;
+
+	send_els->adapter = adapter;
+	send_els->d_id = d_id;
+	send_els->handler = zfcp_erp_adisc_handler;
+	send_els->handler_data = (unsigned long) send_els;
+
+	adisc = zfcp_sg_to_address(send_els->req);
+	send_els->ls_code = adisc->code = ZFCP_LS_ADISC;
+
+	send_els->req->length = sizeof(struct zfcp_ls_adisc);
+	send_els->resp->length = sizeof(struct zfcp_ls_adisc_acc);
+
+	/* acc. to FC-FS, hard_nport_id in ADISC should not be set for ports
+	   without FC-AL-2 capability, so we don't set it */
+	adisc->wwpn = adapter->wwpn;
+	adisc->wwnn = adapter->wwnn;
+	adisc->nport_id = adapter->s_id;
+	ZFCP_LOG_INFO("ADISC request from s_id 0x%08x to d_id 0x%08x "
+		      "(wwpn=0x%016Lx, wwnn=0x%016Lx, "
+		      "hard_nport_id=0x%08x, nport_id=0x%08x)\n",
+		      adapter->s_id, d_id, (wwn_t) adisc->wwpn,
+		      (wwn_t) adisc->wwnn, adisc->hard_nport_id,
+		      adisc->nport_id);
+
+	timer = kmalloc(sizeof(struct timer_list), GFP_ATOMIC);
+	if (!timer)
+		goto nomem;
+
+	init_timer(timer);
+	timer->function = zfcp_fsf_request_timeout_handler;
+	timer->data = (unsigned long) adapter;
+	timer->expires = ZFCP_FSF_REQUEST_TIMEOUT;
+	send_els->timer = timer;
 
 	retval = zfcp_fsf_send_els(send_els);
 	if (retval != 0) {
 		ZFCP_LOG_NORMAL("error: initiation of Send ELS failed for port "
-				"0x%016Lx on adapter %s\n",
-				port->wwpn, zfcp_get_busid_by_port(port));
-		retval = -EPERM;
+				"0x%08x on adapter %s\n", d_id,
+				zfcp_get_busid_by_adapter(adapter));
+		del_timer_sync(send_els->timer);
+		goto freemem;
 	}
 
 	goto out;
 
-nomem:
-	ZFCP_LOG_DEBUG("out of memory\n");
+ nomem:
 	retval = -ENOMEM;
-
-invalid_ls_code:
-	if (page != NULL)
-		__free_pages(page, 0);
+ freemem:
+	if (address != NULL)
+		__free_pages(send_els->req->page, 0);
 	if (send_els != NULL) {
-		if (send_els->req != NULL)
-			kfree(send_els->req);
-		if (send_els->resp != NULL)
-			kfree(send_els->resp);
+		kfree(send_els->timer);
+		kfree(send_els->req);
+		kfree(send_els->resp);
 		kfree(send_els);
 	}
-
-out:
+ out:
 	return retval;
 }
 
 
 /**
- * zfcp_els_handler - handler for ELS commands
+ * zfcp_erp_adisc_handler - handler for ADISC ELS command
  * @data: pointer to struct zfcp_send_els
- * If ELS failed (LS_RJT or timed out) forced reopen of the port is triggered.
+ *
+ * If ADISC failed (LS_RJT or timed out) forced reopen of the port is triggered.
  */
 void
-zfcp_els_handler(unsigned long data)
+zfcp_erp_adisc_handler(unsigned long data)
 {
-	struct zfcp_send_els *send_els = (struct zfcp_send_els*)data;
+	struct zfcp_send_els *send_els;
 	struct zfcp_port *port;
-	struct zfcp_ls_rtv_acc *rtv;
-	struct zfcp_ls_rls_acc *rls;
-	struct zfcp_ls_pdisc_acc *pdisc;
+	struct zfcp_adapter *adapter;
+	fc_id_t d_id;
 	struct zfcp_ls_adisc_acc *adisc;
-	void *req, *resp;
-	u8 req_code;
+
+	send_els = (struct zfcp_send_els *) data;
+
+	del_timer(send_els->timer);
+
+	adapter = send_els->adapter;
+	d_id = send_els->d_id;
 
 	read_lock(&zfcp_data.config_lock);
 	port = zfcp_get_port_by_did(send_els->adapter, send_els->d_id);
@@ -459,91 +422,60 @@
 
 	/* request rejected or timed out */
 	if (send_els->status != 0) {
-		ZFCP_LOG_NORMAL("ELS request timed out, force physical port "
-				"reopen of port 0x%016Lx on adapter %s\n",
-				port->wwpn, zfcp_get_busid_by_port(port));
-		debug_text_event(port->adapter->erp_dbf, 3, "forcreop");
+		ZFCP_LOG_NORMAL("ELS request rejected/timed out, "
+				"force physical port reopen "
+				"(adapter %s, port d_id=0x%08x)\n",
+				zfcp_get_busid_by_adapter(adapter), d_id);
+		debug_text_event(adapter->erp_dbf, 3, "forcreop");
 		if (zfcp_erp_port_forced_reopen(port, 0))
-			ZFCP_LOG_NORMAL("reopen of remote port 0x%016Lx "
-					"on adapter %s failed\n", port->wwpn,
-					zfcp_get_busid_by_port(port));
+			ZFCP_LOG_NORMAL("failed reopen of port "
+					"(adapter %s, wwpn=0x%016Lx)\n",
+					zfcp_get_busid_by_port(port),
+					port->wwpn);
 		goto out;
 	}
 
-	req = zfcp_sg_to_address(send_els->req);
-	resp = zfcp_sg_to_address(send_els->resp);
-	req_code = *(u8*)req;
-
-	switch (req_code) {
-
-	case ZFCP_LS_RTV:
-		rtv = (struct zfcp_ls_rtv_acc*)resp;
-		ZFCP_LOG_INFO("RTV response from d_id 0x%08x to s_id "
-			      "0x%08x (R_A_TOV=%ds E_D_TOV=%d%cs)\n",
-			      port->d_id, port->adapter->s_id,
-			      rtv->r_a_tov, rtv->e_d_tov,
-			      rtv->qualifier &
-			      ZFCP_LS_RTV_E_D_TOV_FLAG ? 'n' : 'm');
-		break;
-
-	case ZFCP_LS_RLS:
-		rls = (struct zfcp_ls_rls_acc*)resp;
-		ZFCP_LOG_INFO("RLS response from d_id 0x%08x to s_id "
-			      "0x%08x (link_failure_count=%u, "
-			      "loss_of_sync_count=%u, "
-			      "loss_of_signal_count=%u, "
-			      "primitive_sequence_protocol_error=%u, "
-			      "invalid_transmition_word=%u, "
-			      "invalid_crc_count=%u)\n",
-			      port->d_id, port->adapter->s_id,
-			      rls->link_failure_count,
-			      rls->loss_of_sync_count,
-			      rls->loss_of_signal_count,
-			      rls->prim_seq_prot_error,
-			      rls->invalid_transmition_word,
-			      rls->invalid_crc_count);
-		break;
-
-	case ZFCP_LS_PDISC:
-		pdisc = (struct zfcp_ls_pdisc_acc*)resp;
-		ZFCP_LOG_INFO("PDISC response from d_id 0x%08x to s_id "
-			      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
-			      "vendor='%-16s')\n", port->d_id,
-			      port->adapter->s_id, pdisc->wwpn,
-			      pdisc->wwnn, pdisc->vendor_version);
-		break;
-
-	case ZFCP_LS_ADISC:
-		adisc = (struct zfcp_ls_adisc_acc*)resp;
-		ZFCP_LOG_INFO("ADISC response from d_id 0x%08x to s_id "
-			      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
-			      "hard_nport_id=0x%08x, "
-			      "nport_id=0x%08x)\n", port->d_id,
-			      port->adapter->s_id, adisc->wwpn,
-			      adisc->wwnn, adisc->hard_nport_id,
-			      adisc->nport_id);
-		/* FIXME: set wwnn in during open port */
-		if (port->wwnn == 0)
-			port->wwnn = adisc->wwnn;
-		break;
+	adisc = zfcp_sg_to_address(send_els->resp);
+
+	ZFCP_LOG_INFO("ADISC response from d_id 0x%08x to s_id "
+		      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
+		      "hard_nport_id=0x%08x, nport_id=0x%08x)\n",
+		      d_id, adapter->s_id, (wwn_t) adisc->wwpn,
+		      (wwn_t) adisc->wwnn, adisc->hard_nport_id,
+		      adisc->nport_id);
+
+	/* set wwnn for port */
+	if (port->wwnn == 0)
+		port->wwnn = adisc->wwnn;
+
+	if (port->wwpn != adisc->wwpn) {
+		ZFCP_LOG_NORMAL("d_id assignment changed, reopening "
+				"port (adapter %s, wwpn=0x%016Lx, "
+				"adisc_resp_wwpn=0x%016Lx)\n",
+				zfcp_get_busid_by_port(port),
+				port->wwpn, (wwn_t) adisc->wwpn);
+		if (zfcp_erp_port_reopen(port, 0))
+			ZFCP_LOG_NORMAL("failed reopen of port "
+					"(adapter %s, wwpn=0x%016Lx)\n",
+					zfcp_get_busid_by_port(port),
+					port->wwpn);
 	}
 
  out:
 	zfcp_port_put(port);
 	__free_pages(send_els->req->page, 0);
+	kfree(send_els->timer);
 	kfree(send_els->req);
 	kfree(send_els->resp);
 	kfree(send_els);
 }
 
 
-/*
- * function:    zfcp_test_link
- *
- * purpose:     Test a status of a link to a remote port using the ELS command ADISC
+/**
+ * zfcp_test_link - lightweight link test procedure
+ * @port: port to be tested
  *
- * returns:     0       - Link is OK
- *              -EPERM  - Port forced reopen failed
+ * Test status of a link to a remote port using the ELS command ADISC.
  */
 int
 zfcp_test_link(struct zfcp_port *port)
@@ -551,7 +483,7 @@
 	int retval;
 
 	zfcp_port_get(port);
-	retval = zfcp_els(port, ZFCP_LS_ADISC);
+	retval = zfcp_erp_adisc(port->adapter, port->d_id);
 	if (retval != 0) {
 		zfcp_port_put(port);
 		ZFCP_LOG_NORMAL("reopen needed for port 0x%016Lx "
@@ -1541,8 +1473,14 @@
 	zfcp_erp_modify_port_status(port,
 				    ZFCP_STATUS_COMMON_ERP_FAILED, ZFCP_SET);
 
-	ZFCP_LOG_NORMAL("port erp failed on port 0x%016Lx on adapter %s\n",
-			port->wwpn, zfcp_get_busid_by_port(port));
+	if (atomic_test_mask(ZFCP_STATUS_PORT_WKA, &port->status))
+		ZFCP_LOG_NORMAL("port erp failed (adapter %s, "
+				"port d_id=0x%08x)\n",
+				zfcp_get_busid_by_port(port), port->d_id);
+	else
+		ZFCP_LOG_NORMAL("port erp failed (adapter %s, wwpn=0x%016Lx)\n",
+				zfcp_get_busid_by_port(port), port->wwpn);
+
 	debug_text_event(port->adapter->erp_dbf, 2, "p_pfail");
 	debug_event(port->adapter->erp_dbf, 2, &port->wwpn, sizeof (wwn_t));
 }
@@ -1678,63 +1616,6 @@
 	     !(ZFCP_STATUS_ERP_CLOSE_ONLY & erp_status));
 }
 
-/**
- * zfcp_erp_scsi_add_device
- * @data: pointer to a struct zfcp_unit
- *
- * Registers a logical unit with the SCSI stack.
- */
-static void
-zfcp_erp_scsi_add_device(void *data)
-{
-	struct {
-		struct zfcp_unit  *unit;
-		struct work_struct work;
-	} *p;
-
-	p = data;
-	scsi_add_device(p->unit->port->adapter->scsi_host,
-			0, p->unit->port->scsi_id, p->unit->scsi_lun);
-	atomic_set(&p->unit->scsi_add_work, 0);
-	wake_up(&p->unit->scsi_add_wq);
-	zfcp_unit_put(p->unit);
-	kfree(p);
-}
-
-/**
- * zfcp_erp_schedule_work
- * @unit: pointer to unit which should be registered with SCSI stack
- *
- * Schedules work which registers a unit with the SCSI stack
- */
-static int
-zfcp_erp_schedule_work(struct zfcp_unit *unit)
-{
-	struct {
-		struct zfcp_unit * unit;
-		struct work_struct work;
-	} *p;
-
-	if (atomic_compare_and_swap(0, 1, &unit->scsi_add_work))
-		return 0;
-
-	if ((p = kmalloc(sizeof(*p), GFP_KERNEL)) == NULL) {
-		ZFCP_LOG_NORMAL("error: registration at SCSI stack failed for "
-				"unit 0x%016Lx on port 0x%016Lx on "
-				"adapter %s\n", unit->fcp_lun, unit->port->wwpn,
-				zfcp_get_busid_by_unit(unit));
-		atomic_set(&unit->scsi_add_work, 0);
-		return -ENOMEM;
-	}
-
-	zfcp_unit_get(unit);
-	memset(p, 0, sizeof(*p));
-	INIT_WORK(&p->work, zfcp_erp_scsi_add_device, p);
-	p->unit = unit;
-	schedule_work(&p->work);
-	return 0;
-}
-
 /*
  * function:	
  *
@@ -2717,10 +2598,13 @@
 			/* nameserver port may live again */
 			atomic_set_mask(ZFCP_STATUS_COMMON_RUNNING,
 					&adapter->nameserver_port->status);
-			if (zfcp_erp_port_reopen(adapter->nameserver_port, 0) >= 0) {
-				erp_action->step = ZFCP_ERP_STEP_NAMESERVER_OPEN;
+			if (zfcp_erp_port_reopen(adapter->nameserver_port, 0)
+			    >= 0) {
+				erp_action->step =
+					ZFCP_ERP_STEP_NAMESERVER_OPEN;
 				retval = ZFCP_ERP_CONTINUES;
-			} else  retval = ZFCP_ERP_FAILED;
+			} else
+				retval = ZFCP_ERP_FAILED;
 			break;
 		}
 		/* else nameserver port is already open, fall through */
@@ -3467,9 +3351,11 @@
 	switch (action) {
 	case ZFCP_ERP_ACTION_REOPEN_UNIT:
 		if ((result == ZFCP_ERP_SUCCEEDED)
-		    && (!atomic_test_mask(ZFCP_STATUS_UNIT_TEMPORARY, &unit->status))
+		    && (!atomic_test_mask(ZFCP_STATUS_UNIT_TEMPORARY,
+					  &unit->status))
 		    && (!unit->device))
-			zfcp_erp_schedule_work(unit);
+ 			scsi_add_device(unit->port->adapter->scsi_host, 0,
+ 					unit->port->scsi_id, unit->scsi_lun);
 		zfcp_unit_put(unit);
 		break;
 	case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c	2004-11-11 15:06:59.000000000 +0100
@@ -30,7 +30,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.76 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.80 $"
 
 #include "zfcp_ext.h"
 
@@ -784,12 +784,12 @@
 		zfcp_fsf_exchange_config_data_handler(fsf_req);
 		break;
 
-	case FSF_QTCB_EXCHANGE_PORT_DATA :
+	case FSF_QTCB_EXCHANGE_PORT_DATA:
 		ZFCP_LOG_FLAGS(2, "FSF_QTCB_EXCHANGE_PORT_DATA\n");
 		zfcp_fsf_exchange_port_data_handler(fsf_req);
 		break;
 
-	case FSF_QTCB_SEND_ELS :
+	case FSF_QTCB_SEND_ELS:
 		ZFCP_LOG_FLAGS(2, "FSF_QTCB_SEND_ELS\n");
 		zfcp_fsf_send_els_handler(fsf_req);
 		break;
@@ -1521,20 +1521,18 @@
 	header = &fsf_req->qtcb->header;
 	bottom = &fsf_req->qtcb->bottom.support;
 
-	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR) {
-		/* do not set ZFCP_STATUS_FSFREQ_ABORTSUCCEEDED */
+	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR)
 		goto skip_fsfstatus;
-	}
 
 	/* evaluate FSF status in QTCB */
 	switch (header->fsf_status) {
 
-        case FSF_GOOD :
+        case FSF_GOOD:
                 ZFCP_LOG_FLAGS(2,"FSF_GOOD\n");
                 retval = 0;
 		break;
 
-        case FSF_SERVICE_CLASS_NOT_SUPPORTED :
+        case FSF_SERVICE_CLASS_NOT_SUPPORTED:
 		ZFCP_LOG_FLAGS(2, "FSF_SERVICE_CLASS_NOT_SUPPORTED\n");
 		if (adapter->fc_service_class <= 3) {
 			ZFCP_LOG_INFO("error: adapter %s does not support fc "
@@ -1550,21 +1548,21 @@
 		}
 		/* stop operation for this adapter */
 		debug_text_exception(adapter->erp_dbf, 0, "fsf_s_class_nsup");
-		zfcp_erp_adapter_shutdown(port->adapter, 0);
+		zfcp_erp_adapter_shutdown(adapter, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
-        case FSF_ADAPTER_STATUS_AVAILABLE :
+        case FSF_ADAPTER_STATUS_AVAILABLE:
                 ZFCP_LOG_FLAGS(2, "FSF_ADAPTER_STATUS_AVAILABLE\n");
                 switch (header->fsf_status_qual.word[0]){
-                case FSF_SQ_INVOKE_LINK_TEST_PROCEDURE :
+                case FSF_SQ_INVOKE_LINK_TEST_PROCEDURE:
 			ZFCP_LOG_FLAGS(2,"FSF_SQ_INVOKE_LINK_TEST_PROCEDURE\n");
 			/* reopening link to port */
 			debug_text_event(adapter->erp_dbf, 1, "fsf_sq_ltest");
 			zfcp_test_link(port);
 			fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 			break;
-                case FSF_SQ_ULP_DEPENDENT_ERP_REQUIRED :
+                case FSF_SQ_ULP_DEPENDENT_ERP_REQUIRED:
 			ZFCP_LOG_FLAGS(2,"FSF_SQ_ULP_DEPENDENT_ERP_REQUIRED\n");
 			/* ERP strategy will escalate */
 			debug_text_event(adapter->erp_dbf, 1, "fsf_sq_ulp");
@@ -1580,9 +1578,9 @@
 
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
-		ZFCP_LOG_NORMAL("Access denied, cannot send generic command "
-				"to port 0x%016Lx on adapter %s\n", port->wwpn,
-				zfcp_get_busid_by_port(port));
+		ZFCP_LOG_NORMAL("access denied, cannot send generic service "
+				"command (adapter %s, port d_id=0x%08x)\n",
+				zfcp_get_busid_by_port(port), port->d_id);
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
 			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
@@ -1600,11 +1598,11 @@
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
-        case FSF_GENERIC_COMMAND_REJECTED :
+        case FSF_GENERIC_COMMAND_REJECTED:
 		ZFCP_LOG_FLAGS(2, "FSF_GENERIC_COMMAND_REJECTED\n");
-		ZFCP_LOG_INFO("warning: The port 0x%016Lx on adapter %s has "
-			      "rejected a generic services command.\n",
-			      port->wwpn, zfcp_get_busid_by_port(port));
+		ZFCP_LOG_INFO("generic service command rejected "
+			      "(adapter %s, port d_id=0x%08x)\n",
+			      zfcp_get_busid_by_port(port), port->d_id);
 		ZFCP_LOG_INFO("status qualifier:\n");
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_INFO,
 			      (char *) &header->fsf_status_qual,
@@ -1613,7 +1611,7 @@
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
-        case FSF_PORT_HANDLE_NOT_VALID :
+        case FSF_PORT_HANDLE_NOT_VALID:
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_HANDLE_NOT_VALID\n");
 		ZFCP_LOG_DEBUG("Temporary port identifier 0x%x for port "
 			       "0x%016Lx on adapter %s invalid. This may "
@@ -1624,15 +1622,15 @@
 			      (char *) &header->fsf_status_qual,
 			      sizeof (union fsf_status_qual));
 		debug_text_event(adapter->erp_dbf, 1, "fsf_s_phandle_nv");
-		zfcp_erp_adapter_reopen(port->adapter, 0);
+		zfcp_erp_adapter_reopen(adapter, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
-        case FSF_PORT_BOXED :
+        case FSF_PORT_BOXED:
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_BOXED\n");
-		ZFCP_LOG_INFO("The remote port 0x%016Lx on adapter %s "
-			       "needs to be reopened\n",
-			       port->wwpn, zfcp_get_busid_by_port(port));
+		ZFCP_LOG_INFO("port needs to be reopened "
+			      "(adapter %s, port d_id=0x%08x)\n",
+			      zfcp_get_busid_by_port(port), port->d_id);
 		debug_text_event(adapter->erp_dbf, 2, "fsf_s_pboxed");
 		zfcp_erp_port_reopen(port, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR
@@ -1674,7 +1672,7 @@
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
-       default :
+       default:
 		ZFCP_LOG_NORMAL("bug: An unknown FSF Status was presented "
 				"(debug info 0x%x)\n", header->fsf_status);
 		debug_text_event(adapter->erp_dbf, 0, "fsf_sq_inval:");
@@ -1959,8 +1957,8 @@
 
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
-		ZFCP_LOG_NORMAL("Access denied, cannot send ELS "
-				"(adapter: %s, port d_id: 0x%08x)\n",
+		ZFCP_LOG_NORMAL("access denied, cannot send ELS command "
+				"(adapter %s, port d_id=0x%08x)\n",
 				zfcp_get_busid_by_adapter(adapter), d_id);
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
@@ -2335,7 +2333,7 @@
 		return;
 
 	switch (fsf_req->qtcb->header.fsf_status) {
-        case FSF_GOOD :
+        case FSF_GOOD:
                 ZFCP_LOG_FLAGS(2,"FSF_GOOD\n");
                 bottom = &fsf_req->qtcb->bottom.port;
                 memcpy(data, bottom, sizeof(*data));
@@ -2589,7 +2587,8 @@
 		/* should never occure, subtype not set in zfcp_fsf_open_port */
 		ZFCP_LOG_FLAGS(2, "FSF_UNKNOWN_OP_SUBTYPE\n");
 		ZFCP_LOG_INFO("unknown operation subtype (adapter: %s, "
-			      "op_subtype=0x%x)\n", zfcp_get_busid_by_port(port),
+			      "op_subtype=0x%x)\n",
+			      zfcp_get_busid_by_port(port),
 			      fsf_req->qtcb->bottom.support.operation_subtype);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -3118,7 +3117,7 @@
 			ZFCP_STATUS_FSFREQ_RETRY;
 		break;
 
-	case FSF_LUN_SHARING_VIOLATION :
+	case FSF_LUN_SHARING_VIOLATION:
 		ZFCP_LOG_FLAGS(2, "FSF_LUN_SHARING_VIOLATION\n");
 		if (header->fsf_status_qual.word[0] != 0) {
 			ZFCP_LOG_NORMAL("FCP-LUN 0x%Lx at the remote port "
@@ -4621,7 +4620,8 @@
 	case FSF_UNKNOWN_OP_SUBTYPE:
 		ZFCP_LOG_FLAGS(2, "FSF_UNKNOWN_OP_SUBTYPE\n");
 		ZFCP_LOG_NORMAL("unknown operation subtype (adapter: %s, "
-				"op_subtype=0x%x)\n", zfcp_get_busid_by_adapter(adapter),
+				"op_subtype=0x%x)\n",
+				zfcp_get_busid_by_adapter(adapter),
 				bottom->operation_subtype);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		retval = -EINVAL;
