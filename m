Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268246AbUHQNzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268246AbUHQNzm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268245AbUHQNzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:55:41 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:15540 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S268246AbUHQNu7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:50:59 -0400
Date: Tue, 17 Aug 2004 15:51:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: zfcp host adapter.
Message-ID: <20040817135120.GB3192@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapter.

From: Heiko Carstens <heiko.carstens@de.ibm.com>
From: Andreas Herrmann <aherrman@de.ibm.com>
From: Maxim Shchetynin <maxim@de.ibm.com>

zfcp host adapter changes:
 - Use predefined macro to create in_recovery sysfs attributes.
 - Add function to check CT_IU response.
 - Fix handling of rejected ELS commands.
 - Change return value of zfcp_fsf_req_sbal_get to -ERESTARTSYS in some cases.
 - Return proper error code if control file upload/download failed.
 - Remove dead code.
 - Avoid sparse warnings.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_aux.c           |  205 +++++++++++++++++++++++++++++---
 drivers/s390/scsi/zfcp_def.h           |   23 ++-
 drivers/s390/scsi/zfcp_erp.c           |  209 +++++++++------------------------
 drivers/s390/scsi/zfcp_ext.h           |    6 
 drivers/s390/scsi/zfcp_fsf.c           |  121 ++-----------------
 drivers/s390/scsi/zfcp_fsf.h           |    4 
 drivers/s390/scsi/zfcp_scsi.c          |    4 
 drivers/s390/scsi/zfcp_sysfs_adapter.c |   43 +-----
 drivers/s390/scsi/zfcp_sysfs_driver.c  |    4 
 drivers/s390/scsi/zfcp_sysfs_port.c    |   33 -----
 drivers/s390/scsi/zfcp_sysfs_unit.c    |   29 ----
 11 files changed, 311 insertions(+), 370 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Sat Aug 14 12:56:24 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Tue Aug 17 14:38:21 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.115 $"
+#define ZFCP_AUX_REVISION "$Revision: 1.121 $"
 
 #include "zfcp_ext.h"
 
@@ -48,10 +48,10 @@
 
 static inline int zfcp_sg_list_alloc(struct zfcp_sg_list *, size_t);
 static inline int zfcp_sg_list_free(struct zfcp_sg_list *);
-static inline int zfcp_sg_list_copy_from_user(struct zfcp_sg_list *, void *,
-					      size_t);
-static inline int zfcp_sg_list_copy_to_user(void *, struct zfcp_sg_list *,
-					    size_t);
+static inline int zfcp_sg_list_copy_from_user(struct zfcp_sg_list *,
+					      void __user *, size_t);
+static inline int zfcp_sg_list_copy_to_user(void __user *,
+					    struct zfcp_sg_list *, size_t);
 
 static int zfcp_cfdc_dev_ioctl(struct inode *, struct file *,
 	unsigned int, unsigned long);
@@ -95,7 +95,7 @@
 module_param(loglevel, uint, 0);
 MODULE_PARM_DESC(loglevel,
 		 "log levels, 8 nibbles: "
-		 "(unassigned) ERP QDIO DIO Config FSF SCSI Other, "
+		 "(unassigned) FC ERP QDIO CIO Config FSF SCSI Other, "
 		 "levels: 0=none 1=normal 2=devel 3=trace");
 
 #ifdef ZFCP_PRINT_FLAGS
@@ -382,7 +382,7 @@
 zfcp_cfdc_dev_ioctl(struct inode *inode, struct file *file,
                     unsigned int command, unsigned long buffer)
 {
-	struct zfcp_cfdc_sense_data sense_data, *sense_data_user;
+	struct zfcp_cfdc_sense_data sense_data, __user *sense_data_user;
 	struct zfcp_adapter *adapter = NULL;
 	struct zfcp_fsf_req *fsf_req = NULL;
 	struct zfcp_sg_list *sg_list = NULL;
@@ -403,7 +403,7 @@
 		goto out;
 	}
 
-	if ((sense_data_user = (struct zfcp_cfdc_sense_data*)buffer) == NULL) {
+	if ((sense_data_user = (void __user *) buffer) == NULL) {
 		ZFCP_LOG_INFO("sense data record is required\n");
 		retval = -EINVAL;
 		goto out;
@@ -520,6 +520,12 @@
 	wait_event(fsf_req->completion_wq,
 	           fsf_req->status & ZFCP_STATUS_FSFREQ_COMPLETED);
 
+	if ((fsf_req->qtcb->prefix.prot_status != FSF_PROT_GOOD) &&
+	    (fsf_req->qtcb->prefix.prot_status != FSF_PROT_FSF_STATUS_PRESENTED)) {
+		retval = -ENXIO;
+		goto out;
+	}
+
 	sense_data.fsf_status = fsf_req->qtcb->header.fsf_status;
 	memcpy(&sense_data.fsf_status_qual,
 	       &fsf_req->qtcb->header.fsf_status_qual,
@@ -637,7 +643,8 @@
  *              -EFAULT - Memory I/O operation fault
  */
 static inline int
-zfcp_sg_list_copy_from_user(struct zfcp_sg_list *sg_list, void *user_buffer,
+zfcp_sg_list_copy_from_user(struct zfcp_sg_list *sg_list,
+			    void __user *user_buffer,
                             size_t size)
 {
 	struct scatterlist *sg;
@@ -671,7 +678,8 @@
  *              -EFAULT - Memory I/O operation fault
  */
 static inline int
-zfcp_sg_list_copy_to_user(void *user_buffer, struct zfcp_sg_list *sg_list,
+zfcp_sg_list_copy_to_user(void __user  *user_buffer,
+			  struct zfcp_sg_list *sg_list,
                           size_t size)
 {
 	struct scatterlist *sg;
@@ -1646,15 +1654,7 @@
 	ct_iu_req = zfcp_sg_to_address(ct->req);
 	ct_iu_resp = zfcp_sg_to_address(ct->resp);
 
-        if (ct_iu_resp->header.revision != ZFCP_CT_REVISION)
-		goto failed;
-        if (ct_iu_resp->header.gs_type != ZFCP_CT_DIRECTORY_SERVICE)
-		goto failed;
-        if (ct_iu_resp->header.gs_subtype != ZFCP_CT_NAME_SERVER)
-		goto failed;
-        if (ct_iu_resp->header.options != ZFCP_CT_SYNCHRONOUS)
-		goto failed;
-        if (ct_iu_resp->header.cmd_rsp_code != ZFCP_CT_ACCEPT) {
+	if (zfcp_check_ct_response(&ct_iu_resp->header)) {
 		/* FIXME: do we need some specific erp entry points */
 		atomic_set_mask(ZFCP_STATUS_PORT_INVALID_WWPN, &port->status);
 		goto failed;
@@ -1675,7 +1675,7 @@
 		       zfcp_get_busid_by_port(port), port->wwpn, port->d_id);
 	goto out;
 
-failed:
+ failed:
 	ZFCP_LOG_NORMAL("warning: failed gid_pn nameserver request for wwpn "
 			"0x%016Lx for adapter %s\n",
 			port->wwpn, zfcp_get_busid_by_port(port));
@@ -1690,4 +1690,169 @@
 	return;
 }
 
+/* reject CT_IU reason codes acc. to FC-GS-4 */
+static const struct zfcp_rc_entry zfcp_ct_rc[] = {
+	{0x01, "invalid command code"},
+	{0x02, "invalid version level"},
+	{0x03, "logical error"},
+	{0x04, "invalid CT_IU size"},
+	{0x05, "logical busy"},
+	{0x07, "protocol error"},
+	{0x09, "unable to perform command request"},
+	{0x0b, "command not supported"},
+	{0x0d, "server not available"},
+	{0x0e, "session could not be established"},
+	{0xff, "vendor specific error"},
+	{0, NULL},
+};
+
+/* LS_RJT reason codes acc. to FC-FS */
+static const struct zfcp_rc_entry zfcp_ls_rjt_rc[] = {
+	{0x01, "invalid LS_Command code"},
+	{0x03, "logical error"},
+	{0x05, "logical busy"},
+	{0x07, "protocol error"},
+	{0x09, "unable to perform command request"},
+	{0x0b, "command not supported"},
+	{0x0e, "command already in progress"},
+	{0xff, "vendor specific error"},
+	{0, NULL},
+};
+
+/* reject reason codes according to FC-PH/FC-FS */
+static const struct zfcp_rc_entry zfcp_p_rjt_rc[] = {
+	{0x01, "invalid D_ID"},
+	{0x02, "invalid S_ID"},
+	{0x03, "Nx_Port not available, temporary"},
+	{0x04, "Nx_Port not available, permament"},
+	{0x05, "class not supported"},
+	{0x06, "delimiter usage error"},
+	{0x07, "TYPE not supported"},
+	{0x08, "invalid Link_Control"},
+	{0x09, "invalid R_CTL field"},
+	{0x0a, "invalid F_CTL field"},
+	{0x0b, "invalid OX_ID"},
+	{0x0c, "invalid RX_ID"},
+	{0x0d, "invalid SEQ_ID"},
+	{0x0e, "invalid DF_CTL"},
+	{0x0f, "invalid SEQ_CNT"},
+	{0x10, "invalid parameter field"},
+	{0x11, "exchange error"},
+	{0x12, "protocol error"},
+	{0x13, "incorrect length"},
+	{0x14, "unsupported ACK"},
+	{0x15, "class of service not supported by entity at FFFFFE"},
+	{0x16, "login required"},
+	{0x17, "excessive sequences attempted"},
+	{0x18, "unable to establish exchange"},
+	{0x1a, "fabric path not available"},
+	{0x1b, "invalid VC_ID (class 4)"},
+	{0x1c, "invalid CS_CTL field"},
+	{0x1d, "insufficient resources for VC (class 4)"},
+	{0x1f, "invalid class of service"},
+	{0x20, "preemption request rejected"},
+	{0x21, "preemption not enabled"},
+	{0x22, "multicast error"},
+	{0x23, "multicast error terminate"},
+	{0x24, "process login required"},
+	{0xff, "vendor specific reject"},
+	{0, NULL},
+};
+
+/**
+ * zfcp_rc_description - return description for given reaon code
+ * @code: reason code
+ * @rc_table: table of reason codes and descriptions
+ */
+static inline const char *
+zfcp_rc_description(u8 code, const struct zfcp_rc_entry *rc_table)
+{
+	const char *descr = "unknown reason code";
+
+	do {
+		if (code == rc_table->code) {
+			descr = rc_table->description;
+			break;
+		}
+		rc_table++;
+	} while (rc_table->code && rc_table->description);
+
+	return descr;
+}
+
+/**
+ * zfcp_check_ct_response - evaluate reason code for CT_IU
+ * @rjt: response payload to an CT_IU request
+ * Return: 0 for accept CT_IU, 1 for reject CT_IU or invlid response code
+ */
+int
+zfcp_check_ct_response(struct ct_hdr *rjt)
+{
+	if (rjt->cmd_rsp_code == ZFCP_CT_ACCEPT)
+		return 0;
+
+	if (rjt->cmd_rsp_code != ZFCP_CT_REJECT) {
+		ZFCP_LOG_NORMAL("error: invalid Generic Service command/"
+				"response code (0x%04hx)\n",
+				rjt->cmd_rsp_code);
+		return 1;
+	}
+
+	ZFCP_LOG_INFO("Generic Service command rejected\n");
+	ZFCP_LOG_INFO("%s (0x%02x, 0x%02x, 0x%02x)\n",
+		      zfcp_rc_description(rjt->reason_code, zfcp_ct_rc),
+		      (u32) rjt->reason_code, (u32) rjt->reason_code_expl,
+		      (u32) rjt->vendor_unique);
+
+	return 1;
+}
+
+/**
+ * zfcp_print_els_rjt - print reject parameter and description for ELS reject
+ * @rjt_par: reject parameter acc. to FC-PH/FC-FS
+ * @rc_table: table of reason codes and descriptions
+ */
+static inline void
+zfcp_print_els_rjt(struct zfcp_ls_rjt_par *rjt_par,
+		   const struct zfcp_rc_entry *rc_table)
+{
+	ZFCP_LOG_INFO("%s (%02x %02x %02x %02x)\n",
+		      zfcp_rc_description(rjt_par->reason_code, rc_table),
+		      (u32) rjt_par->action, (u32) rjt_par->reason_code,
+		      (u32) rjt_par->reason_expl, (u32) rjt_par->vendor_unique);
+}
+
+/**
+ * zfcp_fsf_handle_els_rjt - evaluate status qualifier/reason code on ELS reject
+ * @sq: status qualifier word
+ * @rjt_par: reject parameter as described in FC-PH and FC-FS
+ * Return: -EROMTEIO for LS_RJT, -EREMCHG for invalid D_ID, -EIO else
+ */
+int
+zfcp_handle_els_rjt(u32 sq, struct zfcp_ls_rjt_par *rjt_par)
+{
+	int ret = -EIO;
+
+	if (sq == FSF_IOSTAT_NPORT_RJT) {
+		ZFCP_LOG_INFO("ELS rejected (P_RJT)\n");
+		zfcp_print_els_rjt(rjt_par, zfcp_p_rjt_rc);
+		/* invalid d_id */
+		if (rjt_par->reason_code == 0x01)
+			ret = -EREMCHG;
+	} else if (sq == FSF_IOSTAT_FABRIC_RJT) {
+		ZFCP_LOG_INFO("ELS rejected (F_RJT)\n");
+		zfcp_print_els_rjt(rjt_par, zfcp_p_rjt_rc);
+		/* invalid d_id */
+		if (rjt_par->reason_code == 0x01)
+			ret = -EREMCHG;
+	} else if (sq == FSF_IOSTAT_LS_RJT) {
+		ZFCP_LOG_INFO("ELS rejected (LS_RJT)\n");
+		zfcp_print_els_rjt(rjt_par, zfcp_ls_rjt_rc);
+		ret = -EREMOTEIO;
+	} else
+		ZFCP_LOG_INFO("unexpected SQ: 0x%02x\n", sq);
+
+	return ret;
+}
+
 #undef ZFCP_LOG_AREA
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Sat Aug 14 12:55:33 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Tue Aug 17 14:38:21 2004
@@ -33,7 +33,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.81 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.83 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -296,13 +296,11 @@
 #define ZFCP_LS_RJT_COMMAND_NOT_SUPPORTED	0x0B
 #define ZFCP_LS_RJT_VENDOR_UNIQUE_ERROR		0xFF
 
-struct zfcp_ls_rjt {
-	u8		code;
-	u8		field[3];
-	u8		reserved;
-	u8	reason_code;
-	u8		reason_expl;
-	u8	vendor_unique;
+struct zfcp_ls_rjt_par {
+	u8 action;
+ 	u8 reason_code;
+ 	u8 reason_expl;
+ 	u8 vendor_unique;
 } __attribute__ ((packed));
 
 struct zfcp_ls_rtv {
@@ -423,6 +421,11 @@
 			specific_id;
 } __attribute__((packed));
 
+struct zfcp_rc_entry {
+	u8 code;
+	const char *description;
+};
+
 /*
  * FC-GS-2 stuff
  */
@@ -431,9 +434,9 @@
 #define ZFCP_CT_NAME_SERVER		0x02
 #define ZFCP_CT_SYNCHRONOUS		0x00
 #define ZFCP_CT_GID_PN			0x0121
-#define ZFCP_CT_GA_NXT			0x0100
 #define ZFCP_CT_MAX_SIZE		0x1020
 #define ZFCP_CT_ACCEPT			0x8002
+#define ZFCP_CT_REJECT			0x8001
 
 /*
  * FC-GS-4 stuff
@@ -851,7 +854,7 @@
         struct zfcp_port *port;
 };
 
-typedef int (*zfcp_send_els_handler_t)(unsigned long);
+typedef void (*zfcp_send_els_handler_t)(unsigned long);
 
 /* used to pass parameters to zfcp_send_els() */
 /* ToDo merge send_ct() and send_els() and corresponding structs */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Sat Aug 14 12:54:51 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Tue Aug 17 14:38:21 2004
@@ -31,12 +31,12 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.61 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.62 $"
 
 #include "zfcp_ext.h"
 
 static int zfcp_els(struct zfcp_port *, u8);
-static int zfcp_els_handler(unsigned long);
+static void zfcp_els_handler(unsigned long);
 
 static int zfcp_erp_adapter_reopen_internal(struct zfcp_adapter *, int);
 static int zfcp_erp_port_forced_reopen_internal(struct zfcp_port *, int);
@@ -324,6 +324,7 @@
 	send_els->completion = NULL;
 
 	req = zfcp_sg_to_address(send_els->req);
+	memset(req, 0, PAGE_SIZE);
 
 	*(u32*)req = 0;
 	*(u8*)req = ls_code;
@@ -412,185 +413,99 @@
 }
 
 
-/*
- * function:    zfcp_els_handler
- *
- * purpose:     Handler for all kind of ELSs
- *
- * returns:     0       - Operation completed successfuly
- *              -ENXIO  - ELS has been rejected
- *              -EPERM  - Port forced reopen failed
+/**
+ * zfcp_els_handler - handler for ELS commands
+ * @data: pointer to struct zfcp_send_els
+ * If ELS failed (LS_RJT or timed out) forced reopen of the port is triggered.
  */
-int
+void
 zfcp_els_handler(unsigned long data)
 {
 	struct zfcp_send_els *send_els = (struct zfcp_send_els*)data;
 	struct zfcp_port *port = send_els->port;
-	struct zfcp_ls_rjt *rjt;
 	struct zfcp_ls_rtv_acc *rtv;
 	struct zfcp_ls_rls_acc *rls;
 	struct zfcp_ls_pdisc_acc *pdisc;
 	struct zfcp_ls_adisc_acc *adisc;
 	void *req, *resp;
-	u8 req_code, resp_code;
-	int retval = 0;
+	u8 req_code;
 
+	/* request rejected or timed out */
 	if (send_els->status != 0) {
 		ZFCP_LOG_NORMAL("ELS request timed out, force physical port "
 				"reopen of port 0x%016Lx on adapter %s\n",
 				port->wwpn, zfcp_get_busid_by_port(port));
 		debug_text_event(port->adapter->erp_dbf, 3, "forcreop");
-		retval = zfcp_erp_port_forced_reopen(port, 0);
-		if (retval != 0) {
+		if (zfcp_erp_port_forced_reopen(port, 0))
 			ZFCP_LOG_NORMAL("reopen of remote port 0x%016Lx "
 					"on adapter %s failed\n", port->wwpn,
 					zfcp_get_busid_by_port(port));
-			retval = -EPERM;
-		}
-		goto skip_fsfstatus;
+		goto out;
 	}
 
-	req = (void*)((page_to_pfn(send_els->req->page) << PAGE_SHIFT) + send_els->req->offset);
-	resp = (void*)((page_to_pfn(send_els->resp->page) << PAGE_SHIFT) + send_els->resp->offset);
+	req = zfcp_sg_to_address(send_els->req);
+	resp = zfcp_sg_to_address(send_els->resp);
 	req_code = *(u8*)req;
-	resp_code = *(u8*)resp;
-
-	switch (resp_code) {
-
-	case ZFCP_LS_RJT:
-		rjt = (struct zfcp_ls_rjt*)resp;
 
-		switch (rjt->reason_code) {
+	switch (req_code) {
 
-		case ZFCP_LS_RJT_INVALID_COMMAND_CODE:
-			ZFCP_LOG_INFO("invalid LS command code "
-				      "(wwpn=0x%016Lx, command=0x%02x)\n",
-				      port->wwpn, req_code);
-			break;
-
-		case ZFCP_LS_RJT_LOGICAL_ERROR:
-			ZFCP_LOG_INFO("logical error (wwpn=0x%016Lx, "
-				      "reason_expl=0x%02x)\n",
-				      port->wwpn, rjt->reason_expl);
-			break;
-
-		case ZFCP_LS_RJT_LOGICAL_BUSY:
-			ZFCP_LOG_INFO("logical busy (wwpn=0x%016Lx, "
-				      "reason_expl=0x%02x)\n",
-				      port->wwpn, rjt->reason_expl);
-			break;
-
-		case ZFCP_LS_RJT_PROTOCOL_ERROR:
-			ZFCP_LOG_INFO("protocol error (wwpn=0x%016Lx, "
-				      "reason_expl=0x%02x)\n",
-				      port->wwpn, rjt->reason_expl);
-			break;
-
-		case ZFCP_LS_RJT_UNABLE_TO_PERFORM:
-			ZFCP_LOG_INFO("unable to perform command requested "
-				      "(wwpn=0x%016Lx, reason_expl=0x%02x)\n",
-				      port->wwpn, rjt->reason_expl);
-			break;
-
-		case ZFCP_LS_RJT_COMMAND_NOT_SUPPORTED:
-			ZFCP_LOG_INFO("command not supported (wwpn=0x%016Lx, "
-				      "command=0x%02x)\n",
-				      port->wwpn, req_code);
-			break;
-
-		case ZFCP_LS_RJT_VENDOR_UNIQUE_ERROR:
-			ZFCP_LOG_INFO("vendor specific error (wwpn=0x%016Lx, "
-				      "vendor_unique=0x%02x)\n",
-				      port->wwpn, rjt->vendor_unique);
-			break;
-
-		default:
-			ZFCP_LOG_NORMAL("ELS rejected by remote port 0x%016Lx "
-					"on adapter %s (reason_code=0x%02x)\n",
-					port->wwpn,
-					zfcp_get_busid_by_port(port),
-					rjt->reason_code);
-		}
-		retval = -ENXIO;
+	case ZFCP_LS_RTV:
+		rtv = (struct zfcp_ls_rtv_acc*)resp;
+		ZFCP_LOG_INFO("RTV response from d_id 0x%08x to s_id "
+			      "0x%08x (R_A_TOV=%ds E_D_TOV=%d%cs)\n",
+			      port->d_id, port->adapter->s_id,
+			      rtv->r_a_tov, rtv->e_d_tov,
+			      rtv->qualifier &
+			      ZFCP_LS_RTV_E_D_TOV_FLAG ? 'n' : 'm');
 		break;
 
-	case ZFCP_LS_ACC:
-		switch (req_code) {
+	case ZFCP_LS_RLS:
+		rls = (struct zfcp_ls_rls_acc*)resp;
+		ZFCP_LOG_INFO("RLS response from d_id 0x%08x to s_id "
+			      "0x%08x (link_failure_count=%u, "
+			      "loss_of_sync_count=%u, "
+			      "loss_of_signal_count=%u, "
+			      "primitive_sequence_protocol_error=%u, "
+			      "invalid_transmition_word=%u, "
+			      "invalid_crc_count=%u)\n",
+			      port->d_id, port->adapter->s_id,
+			      rls->link_failure_count,
+			      rls->loss_of_sync_count,
+			      rls->loss_of_signal_count,
+			      rls->prim_seq_prot_error,
+			      rls->invalid_transmition_word,
+			      rls->invalid_crc_count);
+		break;
 
-		case ZFCP_LS_RTV:
-			rtv = (struct zfcp_ls_rtv_acc*)resp;
-			ZFCP_LOG_INFO("RTV response from d_id 0x%08x to s_id "
-				      "0x%08x (R_A_TOV=%ds E_D_TOV=%d%cs)\n",
-				      port->d_id, port->adapter->s_id,
-				      rtv->r_a_tov, rtv->e_d_tov,
-				      rtv->qualifier &
-				      ZFCP_LS_RTV_E_D_TOV_FLAG ? 'n' : 'm');
-			break;
-
-		case ZFCP_LS_RLS:
-			rls = (struct zfcp_ls_rls_acc*)resp;
-			ZFCP_LOG_INFO("RLS response from d_id 0x%08x to s_id "
-				      "0x%08x (link_failure_count=%u, "
-				      "loss_of_sync_count=%u, "
-				      "loss_of_signal_count=%u, "
-				      "primitive_sequence_protocol_error=%u, "
-				      "invalid_transmition_word=%u, "
-				      "invalid_crc_count=%u)\n",
-				      port->d_id, port->adapter->s_id,
-				      rls->link_failure_count,
-				      rls->loss_of_sync_count,
-				      rls->loss_of_signal_count,
-				      rls->prim_seq_prot_error,
-				      rls->invalid_transmition_word,
-				      rls->invalid_crc_count);
-			break;
-
-		case ZFCP_LS_PDISC:
-			pdisc = (struct zfcp_ls_pdisc_acc*)resp;
-			ZFCP_LOG_INFO("PDISC response from d_id 0x%08x to s_id "
-				      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
-				      "vendor='%-16s')\n", port->d_id,
-				      port->adapter->s_id, pdisc->wwpn,
-				      pdisc->wwnn, pdisc->vendor_version);
-			break;
-
-		case ZFCP_LS_ADISC:
-			adisc = (struct zfcp_ls_adisc_acc*)resp;
-			ZFCP_LOG_INFO("ADISC response from d_id 0x%08x to s_id "
-				      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
-				      "hard_nport_id=0x%08x, "
-				      "nport_id=0x%08x)\n", port->d_id,
-				      port->adapter->s_id, adisc->wwpn,
-				      adisc->wwnn, adisc->hard_nport_id,
-				      adisc->nport_id);
-			/* FIXME: set wwnn in during open port */
-			if (port->wwnn == 0)
-				port->wwnn = adisc->wwnn;
-			break;
-		}
+	case ZFCP_LS_PDISC:
+		pdisc = (struct zfcp_ls_pdisc_acc*)resp;
+		ZFCP_LOG_INFO("PDISC response from d_id 0x%08x to s_id "
+			      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
+			      "vendor='%-16s')\n", port->d_id,
+			      port->adapter->s_id, pdisc->wwpn,
+			      pdisc->wwnn, pdisc->vendor_version);
 		break;
 
-	default:
-		ZFCP_LOG_NORMAL("unknown payload code 0x%02x received for "
-				"request 0x%02x to d_id 0x%08x, reopen needed "
-				"for port 0x%016Lx on adapter %s\n", resp_code,
-				req_code, port->d_id,  port->wwpn,
-				zfcp_get_busid_by_port(port));
-		retval = zfcp_erp_port_forced_reopen(port, 0);
-		if (retval != 0) {
-			ZFCP_LOG_NORMAL("reopen of remote port 0x%016Lx on "
-					"adapter %s failed\n", port->wwpn,
-					zfcp_get_busid_by_port(port));
-			retval = -EPERM;
-		}
+	case ZFCP_LS_ADISC:
+		adisc = (struct zfcp_ls_adisc_acc*)resp;
+		ZFCP_LOG_INFO("ADISC response from d_id 0x%08x to s_id "
+			      "0x%08x (wwpn=0x%016Lx, wwnn=0x%016Lx, "
+			      "hard_nport_id=0x%08x, "
+			      "nport_id=0x%08x)\n", port->d_id,
+			      port->adapter->s_id, adisc->wwpn,
+			      adisc->wwnn, adisc->hard_nport_id,
+			      adisc->nport_id);
+		/* FIXME: set wwnn in during open port */
+		if (port->wwnn == 0)
+			port->wwnn = adisc->wwnn;
+		break;
 	}
 
-skip_fsfstatus:
+ out:
 	__free_pages(send_els->req->page, 0);
 	kfree(send_els->req);
 	kfree(send_els->resp);
-
-	return retval;
+	kfree(send_els);
 }
 
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	Sat Aug 14 12:54:51 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_ext.h	Tue Aug 17 14:38:21 2004
@@ -31,7 +31,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.51 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.53 $"
 
 #include "zfcp_def.h"
 
@@ -117,9 +117,11 @@
 extern struct zfcp_fsf_req *zfcp_fsf_abort_fcp_command(
 	unsigned long, struct zfcp_adapter *, struct zfcp_unit *, int);
 
-/******************************** FCP ****************************************/
+/******************************* FC/FCP **************************************/
 extern int  zfcp_nameserver_enqueue(struct zfcp_adapter *);
 extern int  zfcp_ns_gid_pn_request(struct zfcp_erp_action *);
+extern int  zfcp_check_ct_response(struct ct_hdr *);
+extern int  zfcp_handle_els_rjt(u32, struct zfcp_ls_rjt_par *);
 
 /******************************* SCSI ****************************************/
 extern int  zfcp_adapter_scsi_register(struct zfcp_adapter *);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Sat Aug 14 12:55:47 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Tue Aug 17 14:38:21 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.55 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.59 $"
 
 #include "zfcp_ext.h"
 
@@ -48,7 +48,7 @@
 static int zfcp_fsf_send_ct_handler(struct zfcp_fsf_req *);
 static int zfcp_fsf_send_els_handler(struct zfcp_fsf_req *);
 static int zfcp_fsf_control_file_handler(struct zfcp_fsf_req *);
-static inline int zfcp_fsf_req_create_sbal_check(
+static inline int zfcp_fsf_req_sbal_check(
 	unsigned long *, struct zfcp_qdio_queue *, int);
 static inline int zfcp_use_one_sbal(
 	struct scatterlist *, int, struct scatterlist *, int);
@@ -79,10 +79,9 @@
 };
 
 static const char zfcp_act_subtable_type[5][8] = {
-	{"unknown"}, {"OS"}, {"WWPN"}, {"DID"}, {"LUN"}
+	"unknown", "OS", "WWPN", "DID", "LUN"
 };
 
-
 /****************************************************************/
 /*************** FSF related Functions  *************************/
 /****************************************************************/
@@ -1863,6 +1862,10 @@
 			/* ERP strategy will escalate */
 			debug_text_event(adapter->erp_dbf, 1, "fsf_sq_ulp");
 			fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+			retval =
+			  zfcp_handle_els_rjt(header->fsf_status_qual.word[1],
+					      (struct zfcp_ls_rjt_par *)
+					      &header->fsf_status_qual.word[2]);
 			break;
 		case FSF_SQ_RETRY_IF_POSSIBLE:
 			ZFCP_LOG_FLAGS(2, "FSF_SQ_RETRY_IF_POSSIBLE\n");
@@ -1971,8 +1974,6 @@
 	if (send_els->handler != 0)
 		send_els->handler(send_els->handler_data);
 
-	kfree(send_els);
-
 	return retval;
 }
 
@@ -4157,87 +4158,6 @@
 	}
 
  skip_fsfstatus:
-#if 0
-	/*
-	 * This nasty chop at the problem is not working anymore
-	 * as we do not adjust the retry count anylonger in order
-	 * to have a number of retries that avoids I/O errors.
-	 * The manipulation of the retry count has been removed
-	 * in favour of a safe tape device handling. We must not
-	 * sent SCSI commands more than once to a device if no
-	 * retries are permitted by the high level driver. Generally
-	 * speaking, it was a mess to change retry counts. So it is
-	 * fine that this sort of workaround is gone.
-	 * Then, we had to face a certain number of immediate retries in case of
-	 * busy and queue full conditions (see below).
-	 * This is not acceptable
-	 * for the latter. Queue full conditions are used
-	 * by devices to indicate to a host that the host can rely
-	 * on the completion (or timeout) of at least one outstanding
-	 * command as a suggested trigger for command retries.
-	 * Busy conditions require a different trigger since
-	 * no commands are outstanding for that initiator from the
-	 * devices perspective.
-	 * The drawback of mapping a queue full condition to a
-	 * busy condition is the chance of wasting all retries prior
-	 * to the time when the device indicates that a command
-	 * rejected due to a queue full condition should be re-driven.
-	 * This case would lead to unnecessary I/O errors that
-	 * have to be considered fatal if for example ext3's
-	 * journaling would be torpedoed by such an avoidable
-	 * I/O error.
-	 * So, what issues are there with not mapping a queue-full
-	 * condition to a busy condition?
-	 * Due to the 'exclusive LUN'
-	 * policy enforced by the zSeries FCP channel, this 
-	 * Linux instance is the only initiator with regard to
-	 * this adapter. It is safe to rely on the information
-	 * 'don't disturb me now ... and btw. no other commands
-	 * pending for you' (= queue full) sent by the LU,
-	 * since no other Linux can use this LUN via this adapter
-	 * at the same time. If there is a potential race
-	 * introduced by the FCP channel by not inhibiting Linux A
-	 * to give up a LU with commands pending while Linux B
-	 * grabs this LU and sends commands  - thus providing
-	 * an exploit at the 'exclusive LUN' policy - then this
-	 * issue has to be considered a hardware problem. It should
-	 * be tracked as such if it really occurs. Even if the
-	 * FCP Channel spec. begs exploiters to wait for the
-	 * completion of all request sent to a LU prior to
-	 * closing this LU connection.
-	 * This spec. statement in conjunction with
-	 * the 'exclusive LUN' policy is not consistent design.
-	 * Another issue is how resource constraints for SCSI commands
-	 * might be handled by the FCP channel (just guessing for now).
-	 * If the FCP channel would always map resource constraints,
-	 * e.g. no free FC exchange ID due to I/O stress caused by
-	 * other sharing Linux instances, to faked queue-full
-	 * conditions then this would be a misinterpretation and
-	 * violation of SCSI standards.
-	 * If there are SCSI stack races as indicated below
-	 * then they need to be fixed just there.
-	 * Providing all issue above are not applicable or will
-	 * be fixed appropriately, removing the following hack
-	 * is the right thing to do.
-	 */
-
-	/*
-	 * Note: This is a rather nasty chop at the problem. We cannot 
-	 * risk adding to the mlqueue however as this will block the 
-	 * device. If it is the last outstanding command for this host
-	 * it will remain blocked indefinitely. This would be quite possible
-	 * on the zSeries FCP adapter.
-	 * Also, there exists a race with scsi_insert_special relying on 
-	 * scsi_request_fn to recalculate some command data which may not 
-	 * happen when q->plugged is true in scsi_request_fn
-	 */
-	if (status_byte(scpnt->result) == QUEUE_FULL) {
-		ZFCP_LOG_DEBUG("Changing QUEUE_FULL to BUSY....\n");
-		scpnt->result &= ~(QUEUE_FULL << 1);
-		scpnt->result |= (BUSY << 1);
-	}
-#endif
-
 	ZFCP_LOG_DEBUG("scpnt->result =0x%x\n", scpnt->result);
 
 	zfcp_cmd_dbf_event_scsi("response", scpnt);
@@ -4682,8 +4602,8 @@
 }
 
 static inline int
-zfcp_fsf_req_create_sbal_check(unsigned long *flags,
-			       struct zfcp_qdio_queue *queue, int needed)
+zfcp_fsf_req_sbal_check(unsigned long *flags,
+			struct zfcp_qdio_queue *queue, int needed)
 {
 	write_lock_irqsave(&queue->queue_lock, *flags);
 	if (likely(atomic_read(&queue->free_count) >= needed))
@@ -4713,29 +4633,24 @@
  * @adapter: adapter for which request queue is examined
  * @req_flags: flags indicating whether to wait for needed SBAL or not
  * @lock_flags: lock_flags is queue_lock is taken
- *
- * locking: on success the queue_lock for the request queue of the adapter
- *	is held
+ * Return: 0 on success, otherwise -EIO, or -ERESTARTSYS
+ * Locks: lock adapter->request_queue->queue_lock on success
  */
 static int
 zfcp_fsf_req_sbal_get(struct zfcp_adapter *adapter, int req_flags,
 		      unsigned long *lock_flags)
 {
-        int condition;
+        long ret;
         struct zfcp_qdio_queue *req_queue = &adapter->request_queue;
 
         if (unlikely(req_flags & ZFCP_WAIT_FOR_SBAL)) {
-                wait_event_interruptible_timeout(adapter->request_wq,
-						 (condition =
-						  zfcp_fsf_req_create_sbal_check
-						  (lock_flags, req_queue, 1)),
-						 ZFCP_SBAL_TIMEOUT);
-                if (!condition) {
-                        return -EIO;
-		}
-        } else if (!zfcp_fsf_req_create_sbal_check(lock_flags, req_queue, 1)) {
+                ret = wait_event_interruptible_timeout(adapter->request_wq,
+			zfcp_fsf_req_sbal_check(lock_flags, req_queue, 1),
+						       ZFCP_SBAL_TIMEOUT);
+		if (ret < 0)
+			return ret;
+        } else if (!zfcp_fsf_req_sbal_check(lock_flags, req_queue, 1))
                 return -EIO;
-	}
 
         return 0;
 }
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.h linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.h	Sat Aug 14 12:56:00 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h	Tue Aug 17 14:38:21 2004
@@ -227,6 +227,10 @@
 #define FSF_HBA_PORTSTATE_LINKDOWN		0x00000006
 #define FSF_HBA_PORTSTATE_ERROR			0x00000007
 
+/* IO states of adapter */
+#define FSF_IOSTAT_NPORT_RJT			0x00000004
+#define FSF_IOSTAT_FABRIC_RJT			0x00000005
+#define FSF_IOSTAT_LS_RJT			0x00000009
 
 struct fsf_queue_designator;
 struct fsf_status_read_buffer;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Sat Aug 14 12:56:26 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Tue Aug 17 14:38:21 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.65 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.66 $"
 
 #include "zfcp_ext.h"
 
@@ -430,7 +430,7 @@
 	u64 dbf_fsf_req = 0;
 	u64 dbf_fsf_status = 0;
 	u64 dbf_fsf_qual[2] = { 0, 0 };
-	char dbf_result[ZFCP_ABORT_DBF_LENGTH] = { "##undef" };
+	char dbf_result[ZFCP_ABORT_DBF_LENGTH] = "##undef";
 
 	memset(dbf_opcode, 0, ZFCP_ABORT_DBF_LENGTH);
 	memcpy(dbf_opcode,
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c	Sat Aug 14 12:54:47 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_adapter.c	Tue Aug 17 14:38:21 2004
@@ -26,18 +26,18 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.33 $"
+#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.36 $"
 
 #include "zfcp_ext.h"
 
 #define ZFCP_LOG_AREA                   ZFCP_LOG_AREA_CONFIG
 
 static const char fc_topologies[5][25] = {
-	{"<error>"},
-	{"point-to-point"},
-	{"fabric"},
-	{"arbitrated loop"},
-	{"fabric (virt. adapter)"}
+	"<error>",
+	"point-to-point",
+	"fabric",
+	"arbitrated loop",
+	"fabric (virt. adapter)"
 };
 
 /**
@@ -74,29 +74,8 @@
 			 adapter->hardware_version);
 ZFCP_DEFINE_ADAPTER_ATTR(serial_number, "%17s\n", adapter->serial_number);
 ZFCP_DEFINE_ADAPTER_ATTR(scsi_host_no, "0x%x\n", adapter->scsi_host_no);
-
-/**
- * zfcp_sysfs_adapter_in_recovery_show - recovery state of adapter
- * @dev: pointer to belonging device
- * @buf: pointer to input buffer
- *
- * Show function of "in_recovery" attribute of adapter. Will be
- * "0" if no error recovery is pending for adapter, otherwise "1".
- */
-static ssize_t
-zfcp_sysfs_adapter_in_recovery_show(struct device *dev, char *buf)
-{
-	struct zfcp_adapter *adapter;
-
-	adapter = dev_get_drvdata(dev);
-	if (atomic_test_mask(ZFCP_STATUS_COMMON_ERP_INUSE, &adapter->status))
-		return sprintf(buf, "1\n");
-	else
-		return sprintf(buf, "0\n");
-}
-
-static DEVICE_ATTR(in_recovery, S_IRUGO,
-		   zfcp_sysfs_adapter_in_recovery_show, NULL);
+ZFCP_DEFINE_ADAPTER_ATTR(in_recovery, "%d\n", atomic_test_mask
+			 (ZFCP_STATUS_COMMON_ERP_INUSE, &adapter->status));
 
 /**
  * zfcp_sysfs_port_add_store - add a port to sysfs tree
@@ -138,7 +117,7 @@
 	zfcp_port_put(port);
  out:
 	up(&zfcp_data.config_sema);
-	return retval ? retval : count;
+	return retval ? retval : (ssize_t) count;
 }
 
 static DEVICE_ATTR(port_add, S_IWUSR, NULL, zfcp_sysfs_port_add_store);
@@ -197,7 +176,7 @@
 	zfcp_port_dequeue(port);
  out:
 	up(&zfcp_data.config_sema);
-	return retval ? retval : count;
+	return retval ? retval : (ssize_t) count;
 }
 
 static DEVICE_ATTR(port_remove, S_IWUSR, NULL, zfcp_sysfs_port_remove_store);
@@ -241,7 +220,7 @@
 	zfcp_erp_wait(adapter);
  out:
 	up(&zfcp_data.config_sema);
-	return retval ? retval : count;
+	return retval ? retval : (ssize_t) count;
 }
 
 /**
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_driver.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_driver.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_driver.c	Sat Aug 14 12:56:00 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_driver.c	Tue Aug 17 14:38:21 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_DRIVER_C_REVISION "$Revision: 1.14 $"
+#define ZFCP_SYSFS_DRIVER_C_REVISION "$Revision: 1.15 $"
 
 #include "zfcp_ext.h"
 
@@ -65,7 +65,7 @@
 static ssize_t zfcp_sysfs_loglevel_##_name##_show(struct device_driver *dev,  \
 						  char *buf)                  \
 {                                                                             \
-	return sprintf(buf,"%d\n",				              \
+	return sprintf(buf,"%d\n", (unsigned int)                             \
 		       ZFCP_GET_LOG_VALUE(ZFCP_LOG_AREA_##_define));          \
 }                                                                             \
                                                                               \
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	Sat Aug 14 12:56:22 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_port.c	Tue Aug 17 14:38:21 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.41 $"
+#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.43 $"
 
 #include "zfcp_ext.h"
 
@@ -66,6 +66,8 @@
 ZFCP_DEFINE_PORT_ATTR(wwnn, "0x%016llx\n", port->wwnn);
 ZFCP_DEFINE_PORT_ATTR(d_id, "0x%06x\n", port->d_id);
 ZFCP_DEFINE_PORT_ATTR(scsi_id, "0x%x\n", port->scsi_id);
+ZFCP_DEFINE_PORT_ATTR(in_recovery, "%d\n", atomic_test_mask
+		      (ZFCP_STATUS_COMMON_ERP_INUSE, &port->status));
 
 /**
  * zfcp_sysfs_unit_add_store - add a unit to sysfs tree
@@ -107,7 +109,7 @@
 	zfcp_unit_put(unit);
  out:
 	up(&zfcp_data.config_sema);
-	return retval ? retval : count;
+	return retval ? retval : (ssize_t) count;
 }
 
 static DEVICE_ATTR(unit_add, S_IWUSR, NULL, zfcp_sysfs_unit_add_store);
@@ -164,7 +166,7 @@
 	zfcp_unit_dequeue(unit);
  out:
 	up(&zfcp_data.config_sema);
-	return retval ? retval : count;
+	return retval ? retval : (ssize_t) count;
 }
 
 static DEVICE_ATTR(unit_remove, S_IWUSR, NULL, zfcp_sysfs_unit_remove_store);
@@ -206,7 +208,7 @@
 	zfcp_erp_wait(port->adapter);
  out:
 	up(&zfcp_data.config_sema);
-	return retval ? retval : count;
+	return retval ? retval : (ssize_t) count;
 }
 
 /**
@@ -233,29 +235,6 @@
 		   zfcp_sysfs_port_failed_store);
 
 /**
- * zfcp_sysfs_port_in_recovery_show - recovery state of port
- * @dev: pointer to belonging device
- * @buf: pointer to input buffer
- * 
- * Show function of "in_recovery" attribute of port. Will be
- * "0" if no error recovery is pending for port, otherwise "1".
- */
-static ssize_t
-zfcp_sysfs_port_in_recovery_show(struct device *dev, char *buf)
-{
-	struct zfcp_port *port;
-
-	port = dev_get_drvdata(dev);
-	if (atomic_test_mask(ZFCP_STATUS_COMMON_ERP_INUSE, &port->status))
-		return sprintf(buf, "1\n");
-	else
-		return sprintf(buf, "0\n");
-}
-
-static DEVICE_ATTR(in_recovery, S_IRUGO, zfcp_sysfs_port_in_recovery_show,
-		   NULL);
-
-/**
  * zfcp_port_common_attrs
  * sysfs attributes that are common for all kind of fc ports.
  */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c	Sat Aug 14 12:56:26 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_sysfs_unit.c	Tue Aug 17 14:38:21 2004
@@ -26,7 +26,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.25 $"
+#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.27 $"
 
 #include "zfcp_ext.h"
 
@@ -64,6 +64,8 @@
 
 ZFCP_DEFINE_UNIT_ATTR(status, "0x%08x\n", atomic_read(&unit->status));
 ZFCP_DEFINE_UNIT_ATTR(scsi_lun, "0x%x\n", unit->scsi_lun);
+ZFCP_DEFINE_UNIT_ATTR(in_recovery, "%d\n", atomic_test_mask
+		      (ZFCP_STATUS_COMMON_ERP_INUSE, &unit->status));
 
 /**
  * zfcp_sysfs_unit_failed_store - failed state of unit
@@ -101,7 +103,7 @@
 	zfcp_erp_wait(unit->port->adapter);
  out:
 	up(&zfcp_data.config_sema);
-	return retval ? retval : count;
+	return retval ? retval : (ssize_t) count;
 }
 
 /**
@@ -127,29 +129,6 @@
 static DEVICE_ATTR(failed, S_IWUSR | S_IRUGO, zfcp_sysfs_unit_failed_show,
 		   zfcp_sysfs_unit_failed_store);
 
-/**
- * zfcp_sysfs_unit_in_recovery_show - recovery state of unit
- * @dev: pointer to belonging device
- * @buf: pointer to input buffer
- *
- * Show function of "in_recovery" attribute of unit. Will be
- * "0" if no error recovery is pending for unit, otherwise "1".
- */
-static ssize_t
-zfcp_sysfs_unit_in_recovery_show(struct device *dev, char *buf)
-{
-	struct zfcp_unit *unit;
-
-	unit = dev_get_drvdata(dev);
-	if (atomic_test_mask(ZFCP_STATUS_COMMON_ERP_INUSE, &unit->status))
-		return sprintf(buf, "1\n");
-	else
-		return sprintf(buf, "0\n");
-}
-
-static DEVICE_ATTR(in_recovery, S_IRUGO, zfcp_sysfs_unit_in_recovery_show,
-		   NULL);
-
 static struct attribute *zfcp_unit_attrs[] = {
 	&dev_attr_scsi_lun.attr,
 	&dev_attr_failed.attr,
