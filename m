Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270045AbUJHRqf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270045AbUJHRqf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 13:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270072AbUJHRpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 13:45:10 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:6640 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S270047AbUJHRjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 13:39:00 -0400
Date: Fri, 8 Oct 2004 19:38:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (7/12): zfcp host adapter.
Message-ID: <20041008173848.GH7356@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapter.

From: Andreas Herrmann <aherrman@de.ibm.com>

zfcp host adapter change:
 - Return -EIO if wait_event_interruptible_timeout was interrupted.
 - Reduce stack uage of zfcp_cfdc_dev_ioctl.
 - Make zfcp_sg_list_[alloc,free] more consistent.
 - Store driver version to zfcp_data structure.
 - Add missing FSF states and make corresponding log messages consistent.
 - Always wait for completion in zfcp_scsi_command_sync.
 - Add Andreas to authors list.
 - Add timeout for cfdc upload/download.
 - Add support for temporary units (units not registered to the scsi stack).
 - Allow sending of ELS commands to ports by their d_id.
 - Increase port refcount while link test is running.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_aux.c           |   67 +++++-----
 drivers/s390/scsi/zfcp_ccw.c           |    3 
 drivers/s390/scsi/zfcp_def.h           |   15 +-
 drivers/s390/scsi/zfcp_erp.c           |   30 +++-
 drivers/s390/scsi/zfcp_ext.h           |    3 
 drivers/s390/scsi/zfcp_fsf.c           |  202 ++++++++++++++++++++++-----------
 drivers/s390/scsi/zfcp_fsf.h           |    3 
 drivers/s390/scsi/zfcp_qdio.c          |    3 
 drivers/s390/scsi/zfcp_scsi.c          |   10 -
 drivers/s390/scsi/zfcp_sysfs_adapter.c |    3 
 drivers/s390/scsi/zfcp_sysfs_driver.c  |    5 
 drivers/s390/scsi/zfcp_sysfs_port.c    |    3 
 drivers/s390/scsi/zfcp_sysfs_unit.c    |    3 
 13 files changed, 225 insertions(+), 125 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_aux.c	2004-10-08 19:19:14.000000000 +0200
@@ -12,6 +12,7 @@
  *            Wolfgang Taphorn
  *            Stefan Bader <stefan.bader@de.ibm.com>
  *            Heiko Carstens <heiko.carstens@de.ibm.com>
+ *            Andreas Herrmann <aherrman@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -29,7 +30,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.129 $"
+#define ZFCP_AUX_REVISION "$Revision: 1.135 $"
 
 #include "zfcp_ext.h"
 
@@ -80,6 +81,7 @@
 module_init(zfcp_module_init);
 
 MODULE_AUTHOR("Heiko Carstens <heiko.carstens@de.ibm.com>, "
+	      "Andreas Herrman <aherrman@de.ibm.com>, "
 	      "Martin Peschke <mpeschke@de.ibm.com>, "
 	      "Raimund Schroeder <raimund.schroeder@de.ibm.com>, "
 	      "Wolfgang Taphorn <taphorn@de.ibm.com>, "
@@ -379,7 +381,7 @@
 zfcp_cfdc_dev_ioctl(struct inode *inode, struct file *file,
                     unsigned int command, unsigned long buffer)
 {
-	struct zfcp_cfdc_sense_data sense_data, __user *sense_data_user;
+	struct zfcp_cfdc_sense_data *sense_data, __user *sense_data_user;
 	struct zfcp_adapter *adapter = NULL;
 	struct zfcp_fsf_req *fsf_req = NULL;
 	struct zfcp_sg_list *sg_list = NULL;
@@ -387,6 +389,12 @@
 	char *bus_id = NULL;
 	int retval = 0;
 
+	sense_data = kmalloc(sizeof(struct zfcp_cfdc_sense_data), GFP_KERNEL);
+	if (sense_data == NULL) {
+		retval = -ENOMEM;
+		goto out;
+	}
+
 	sg_list = kmalloc(sizeof(struct zfcp_sg_list), GFP_KERNEL);
 	if (sg_list == NULL) {
 		retval = -ENOMEM;
@@ -406,21 +414,21 @@
 		goto out;
 	}
 
-	retval = copy_from_user(&sense_data, sense_data_user,
+	retval = copy_from_user(sense_data, sense_data_user,
 				sizeof(struct zfcp_cfdc_sense_data));
 	if (retval) {
 		retval = -EFAULT;
 		goto out;
 	}
 
-	if (sense_data.signature != ZFCP_CFDC_SIGNATURE) {
+	if (sense_data->signature != ZFCP_CFDC_SIGNATURE) {
 		ZFCP_LOG_INFO("invalid sense data request signature 0x%08x\n",
 			      ZFCP_CFDC_SIGNATURE);
 		retval = -EINVAL;
 		goto out;
 	}
 
-	switch (sense_data.command) {
+	switch (sense_data->command) {
 
 	case ZFCP_CFDC_CMND_DOWNLOAD_NORMAL:
 		fsf_command = FSF_QTCB_DOWNLOAD_CONTROL_FILE;
@@ -449,7 +457,7 @@
 
 	default:
 		ZFCP_LOG_INFO("invalid command code 0x%08x\n",
-			      sense_data.command);
+			      sense_data->command);
 		retval = -EINVAL;
 		goto out;
 	}
@@ -460,9 +468,9 @@
 		goto out;
 	}
 	snprintf(bus_id, BUS_ID_SIZE, "%d.%d.%04x",
-		(sense_data.devno >> 24),
-		(sense_data.devno >> 16) & 0xFF,
-		(sense_data.devno & 0xFFFF));
+		(sense_data->devno >> 24),
+		(sense_data->devno >> 16) & 0xFF,
+		(sense_data->devno & 0xFFFF));
 
 	read_lock_irq(&zfcp_data.config_lock);
 	adapter = zfcp_get_adapter_by_busid(bus_id);
@@ -478,7 +486,7 @@
 		goto out;
 	}
 
-	if (sense_data.command & ZFCP_CFDC_WITH_CONTROL_FILE) {
+	if (sense_data->command & ZFCP_CFDC_WITH_CONTROL_FILE) {
 		retval = zfcp_sg_list_alloc(sg_list,
 					    ZFCP_CFDC_MAX_CONTROL_FILE_SIZE);
 		if (retval) {
@@ -487,8 +495,8 @@
 		}
 	}
 
-	if ((sense_data.command & ZFCP_CFDC_DOWNLOAD) &&
-	    (sense_data.command & ZFCP_CFDC_WITH_CONTROL_FILE)) {
+	if ((sense_data->command & ZFCP_CFDC_DOWNLOAD) &&
+	    (sense_data->command & ZFCP_CFDC_WITH_CONTROL_FILE)) {
 		retval = zfcp_sg_list_copy_from_user(
 			sg_list, &sense_data_user->control_file,
 			ZFCP_CFDC_MAX_CONTROL_FILE_SIZE);
@@ -498,19 +506,10 @@
 		}
 	}
 
-	retval = zfcp_fsf_control_file(
-		adapter, &fsf_req, fsf_command, option, sg_list);
-	if (retval == -EOPNOTSUPP) {
-		ZFCP_LOG_INFO("adapter does not support cfdc\n");
-		goto out;
-	} else if (retval != 0) {
-		ZFCP_LOG_INFO("initiation of cfdc up/download failed\n");
-		retval = -EPERM;
+	retval = zfcp_fsf_control_file(adapter, &fsf_req, fsf_command,
+				       option, sg_list);
+	if (retval)
 		goto out;
-	}
-
-	wait_event(fsf_req->completion_wq,
-	           fsf_req->status & ZFCP_STATUS_FSFREQ_COMPLETED);
 
 	if ((fsf_req->qtcb->prefix.prot_status != FSF_PROT_GOOD) &&
 	    (fsf_req->qtcb->prefix.prot_status != FSF_PROT_FSF_STATUS_PRESENTED)) {
@@ -518,20 +517,20 @@
 		goto out;
 	}
 
-	sense_data.fsf_status = fsf_req->qtcb->header.fsf_status;
-	memcpy(&sense_data.fsf_status_qual,
+	sense_data->fsf_status = fsf_req->qtcb->header.fsf_status;
+	memcpy(&sense_data->fsf_status_qual,
 	       &fsf_req->qtcb->header.fsf_status_qual,
 	       sizeof(union fsf_status_qual));
-	memcpy(&sense_data.payloads, &fsf_req->qtcb->bottom.support.els, 256);
+	memcpy(&sense_data->payloads, &fsf_req->qtcb->bottom.support.els, 256);
 
-	retval = copy_to_user(sense_data_user, &sense_data,
+	retval = copy_to_user(sense_data_user, sense_data,
 		sizeof(struct zfcp_cfdc_sense_data));
 	if (retval) {
 		retval = -EFAULT;
 		goto out;
 	}
 
-	if (sense_data.command & ZFCP_CFDC_UPLOAD) {
+	if (sense_data->command & ZFCP_CFDC_UPLOAD) {
 		retval = zfcp_sg_list_copy_to_user(
 			&sense_data_user->control_file, sg_list,
 			ZFCP_CFDC_MAX_CONTROL_FILE_SIZE);
@@ -553,6 +552,9 @@
 		kfree(sg_list);
 	}
 
+	if (sense_data != NULL)
+		kfree(sense_data);
+
 	return retval;
 }
 
@@ -588,18 +590,19 @@
 		retval = -ENOMEM;
 		goto out;
 	}
+	memset(sg_list->sg, sg_list->count * sizeof(struct scatterlist), 0);
 
 	for (i = 0, sg = sg_list->sg; i < sg_list->count; i++, sg++) {
 		sg->length = min(size, PAGE_SIZE);
 		sg->offset = 0;
 		address = (void *) get_zeroed_page(GFP_KERNEL);
-		zfcp_address_to_sg(address, sg);
-		if (sg->page == NULL) {
+		if (address == NULL) {
 			sg_list->count = i;
 			zfcp_sg_list_free(sg_list);
 			retval = -ENOMEM;
 			goto out;
 		}
+		zfcp_address_to_sg(address, sg);
 		size -= sg->length;
 	}
 
@@ -624,7 +627,7 @@
 	BUG_ON(sg_list == NULL);
 
 	for (i = 0, sg = sg_list->sg; i < sg_list->count; i++, sg++)
-		__free_pages(sg->page, 0);
+		free_page((unsigned long) zfcp_sg_to_address(sg));
 
 	sg_list->count = 0;
 	kfree(sg_list->sg);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ccw.c linux-2.6-patched/drivers/s390/scsi/zfcp_ccw.c
--- linux-2.6/drivers/s390/scsi/zfcp_ccw.c	2004-08-14 12:55:09.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_ccw.c	2004-10-08 19:19:14.000000000 +0200
@@ -10,6 +10,7 @@
  * Authors:
  *      Martin Peschke <mpeschke@de.ibm.com>
  *	Heiko Carstens <heiko.carstens@de.ibm.com>
+ *      Andreas Herrmann <aherrman@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -26,7 +27,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_CCW_C_REVISION "$Revision: 1.56 $"
+#define ZFCP_CCW_C_REVISION "$Revision: 1.57 $"
 
 #include "zfcp_ext.h"
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-patched/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_def.h	2004-10-08 19:19:14.000000000 +0200
@@ -12,6 +12,7 @@
  *            Wolfgang Taphorn
  *            Stefan Bader <stefan.bader@de.ibm.com> 
  *            Heiko Carstens <heiko.carstens@de.ibm.com> 
+ *            Andreas Herrmann <aherrman@de.ibm.com>
  * 
  * This program is free software; you can redistribute it and/or modify 
  * it under the terms of the GNU General Public License as published by 
@@ -33,7 +34,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.91 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.98 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -71,7 +72,7 @@
 /********************* GENERAL DEFINES *********************************/
 
 /* zfcp version number, it consists of major, minor, and patch-level number */
-#define ZFCP_VERSION		"4.1.3"
+#define ZFCP_VERSION		"4.1.4"
 
 /**
  * zfcp_sg_to_address - determine kernel address from struct scatterlist
@@ -597,7 +598,8 @@
 		 ZFCP_STATUS_PORT_NO_SCSI_ID)
 
 /* logical unit status */
-#define ZFCP_STATUS_UNIT_NOTSUPPUNITRESET	0x00000001
+#define ZFCP_STATUS_UNIT_NOTSUPPUNITRESET       0x00000001
+#define ZFCP_STATUS_UNIT_TEMPORARY		0x00000010
 
 
 /* FSF request status (this does not have a common part) */
@@ -817,7 +819,8 @@
 
 /**
  * struct zfcp_send_els - used to pass parameters to function zfcp_fsf_send_els
- * @port: port where the request is sent to
+ * @adapter: adapter where request is sent from
+ * @d_id: destiniation id of port where request is sent to
  * @req: scatter-gather list for request
  * @resp: scatter-gather list for response
  * @req_count: number of elements in request scatter-gather list
@@ -830,7 +833,8 @@
  * @status: used to pass error status to calling function
  */
 struct zfcp_send_els {
-	struct zfcp_port *port;
+	struct zfcp_adapter *adapter;
+	fc_id_t d_id;
 	struct scatterlist *req;
 	struct scatterlist *resp;
 	unsigned int req_count;
@@ -1055,6 +1059,7 @@
 	char                    init_busid[BUS_ID_SIZE];
 	wwn_t                   init_wwpn;
 	fcp_lun_t               init_fcp_lun;
+	char 			*driver_version;
 };
 
 /**
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c	2004-10-08 19:19:14.000000000 +0200
@@ -12,6 +12,7 @@
  *            Wolfgang Taphorn
  *            Stefan Bader <stefan.bader@de.ibm.com> 
  *            Heiko Carstens <heiko.carstens@de.ibm.com> 
+ *            Andreas Herrmann <aherrman@de.ibm.com>
  * 
  * This program is free software; you can redistribute it and/or modify 
  * it under the terms of the GNU General Public License as published by 
@@ -31,7 +32,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.65 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.69 $"
 
 #include "zfcp_ext.h"
 
@@ -336,7 +337,8 @@
 	send_els->req->offset = 0;
 	send_els->resp->offset = PAGE_SIZE >> 1;
 
-	send_els->port = port;
+	send_els->adapter = port->adapter;
+	send_els->d_id = port->d_id;
 	send_els->ls_code = ls_code;
 	send_els->handler = zfcp_els_handler;
 	send_els->handler_data = (unsigned long)send_els;
@@ -441,7 +443,7 @@
 zfcp_els_handler(unsigned long data)
 {
 	struct zfcp_send_els *send_els = (struct zfcp_send_els*)data;
-	struct zfcp_port *port = send_els->port;
+	struct zfcp_port *port;
 	struct zfcp_ls_rtv_acc *rtv;
 	struct zfcp_ls_rls_acc *rls;
 	struct zfcp_ls_pdisc_acc *pdisc;
@@ -449,6 +451,12 @@
 	void *req, *resp;
 	u8 req_code;
 
+	read_lock(&zfcp_data.config_lock);
+	port = zfcp_get_port_by_did(send_els->adapter, send_els->d_id);
+	read_unlock(&zfcp_data.config_lock);
+
+	BUG_ON(port == NULL);
+
 	/* request rejected or timed out */
 	if (send_els->status != 0) {
 		ZFCP_LOG_NORMAL("ELS request timed out, force physical port "
@@ -521,6 +529,7 @@
 	}
 
  out:
+	zfcp_port_put(port);
 	__free_pages(send_els->req->page, 0);
 	kfree(send_els->req);
 	kfree(send_els->resp);
@@ -541,8 +550,10 @@
 {
 	int retval;
 
+	zfcp_port_get(port);
 	retval = zfcp_els(port, ZFCP_LS_ADISC);
 	if (retval != 0) {
+		zfcp_port_put(port);
 		ZFCP_LOG_NORMAL("reopen needed for port 0x%016Lx "
 				"on adapter %s\n ", port->wwpn,
 				zfcp_get_busid_by_port(port));
@@ -3445,21 +3456,20 @@
 /**
  * zfcp_erp_action_cleanup
  *
- * registers unit with scsi stack if appropiate and fixes reference counts
+ * Register unit with scsi stack if appropiate and fix reference counts.
+ * Note: Temporary units are not registered with scsi stack.
  */
-
 static void
 zfcp_erp_action_cleanup(int action, struct zfcp_adapter *adapter,
 			struct zfcp_port *port, struct zfcp_unit *unit,
 			int result)
 {
-	if ((action == ZFCP_ERP_ACTION_REOPEN_UNIT)
-	    && (result == ZFCP_ERP_SUCCEEDED)
-	    && (!unit->device)) {
-		zfcp_erp_schedule_work(unit);
-	}
 	switch (action) {
 	case ZFCP_ERP_ACTION_REOPEN_UNIT:
+		if ((result == ZFCP_ERP_SUCCEEDED)
+		    && (!atomic_test_mask(ZFCP_STATUS_UNIT_TEMPORARY, &unit->status))
+		    && (!unit->device))
+			zfcp_erp_schedule_work(unit);
 		zfcp_unit_put(unit);
 		break;
 	case ZFCP_ERP_ACTION_REOPEN_PORT_FORCED:
diff -urN linux-2.6/drivers/s390/scsi/zfcp_ext.h linux-2.6-patched/drivers/s390/scsi/zfcp_ext.h
--- linux-2.6/drivers/s390/scsi/zfcp_ext.h	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_ext.h	2004-10-08 19:19:14.000000000 +0200
@@ -12,6 +12,7 @@
  *            Wolfgang Taphorn
  *            Stefan Bader <stefan.bader@de.ibm.com> 
  *            Heiko Carstens <heiko.carstens@de.ibm.com> 
+ *            Andreas Herrmann <aherrman@de.ibm.com>
  * 
  * This program is free software; you can redistribute it and/or modify 
  * it under the terms of the GNU General Public License as published by 
@@ -31,7 +32,7 @@
 #ifndef ZFCP_EXT_H
 #define ZFCP_EXT_H
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_EXT_REVISION "$Revision: 1.57 $"
+#define ZFCP_EXT_REVISION "$Revision: 1.58 $"
 
 #include "zfcp_def.h"
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c	2004-10-08 19:19:14.000000000 +0200
@@ -12,6 +12,7 @@
  *            Wolfgang Taphorn
  *            Stefan Bader <stefan.bader@de.ibm.com>
  *            Heiko Carstens <heiko.carstens@de.ibm.com>
+ *            Andreas Herrmann <aherrman@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -29,7 +30,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.65 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.76 $"
 
 #include "zfcp_ext.h"
 
@@ -1638,6 +1639,41 @@
 		    | ZFCP_STATUS_FSFREQ_RETRY;
 		break;
 
+	/* following states should never occure, all cases avoided
+	   in zfcp_fsf_send_ct - but who knows ... */
+	case FSF_PAYLOAD_SIZE_MISMATCH:
+		ZFCP_LOG_FLAGS(2, "FSF_PAYLOAD_SIZE_MISMATCH\n");
+		ZFCP_LOG_INFO("payload size mismatch (adapter: %s, "
+			      "req_buf_length=%d, resp_buf_length=%d)\n",
+			      zfcp_get_busid_by_adapter(adapter),
+			      bottom->req_buf_length, bottom->resp_buf_length);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		break;
+	case FSF_REQUEST_SIZE_TOO_LARGE:
+		ZFCP_LOG_FLAGS(2, "FSF_REQUEST_SIZE_TOO_LARGE\n");
+		ZFCP_LOG_INFO("request size too large (adapter: %s, "
+			      "req_buf_length=%d)\n",
+			      zfcp_get_busid_by_adapter(adapter),
+			      bottom->req_buf_length);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		break;
+	case FSF_RESPONSE_SIZE_TOO_LARGE:
+		ZFCP_LOG_FLAGS(2, "FSF_RESPONSE_SIZE_TOO_LARGE\n");
+		ZFCP_LOG_INFO("response size too large (adapter: %s, "
+			      "resp_buf_length=%d)\n",
+			      zfcp_get_busid_by_adapter(adapter),
+			      bottom->resp_buf_length);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		break;
+	case FSF_SBAL_MISMATCH:
+		ZFCP_LOG_FLAGS(2, "FSF_SBAL_MISMATCH\n");
+		ZFCP_LOG_INFO("SBAL mismatch (adapter: %s, req_buf_length=%d, "
+			      "resp_buf_length=%d)\n",
+			      zfcp_get_busid_by_adapter(adapter),
+			      bottom->req_buf_length, bottom->resp_buf_length);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		break;
+
        default :
 		ZFCP_LOG_NORMAL("bug: An unknown FSF Status was presented "
 				"(debug info 0x%x)\n", header->fsf_status);
@@ -1666,14 +1702,14 @@
 {
 	volatile struct qdio_buffer_element *sbale;
 	struct zfcp_fsf_req *fsf_req;
-	struct zfcp_port *port;
+	fc_id_t d_id;
 	struct zfcp_adapter *adapter;
 	unsigned long lock_flags;
         int bytes;
 	int ret = 0;
 
-	port = els->port;
-	adapter = port->adapter;
+	d_id = els->d_id;
+	adapter = els->adapter;
 
         ret = zfcp_fsf_req_create(adapter, FSF_QTCB_SEND_ELS,
 				  ZFCP_WAIT_FOR_SBAL|ZFCP_REQ_AUTO_CLEANUP,
@@ -1681,7 +1717,7 @@
 	if (ret < 0) {
                 ZFCP_LOG_INFO("error: creation of ELS request failed "
 			      "(adapter %s, port d_id: 0x%08x)\n",
-                              zfcp_get_busid_by_adapter(adapter), port->d_id);
+                              zfcp_get_busid_by_adapter(adapter), d_id);
                 goto failed_req;
 	}
 
@@ -1706,8 +1742,7 @@
                 if (bytes <= 0) {
                         ZFCP_LOG_INFO("error: creation of ELS request failed "
 				      "(adapter %s, port d_id: 0x%08x)\n",
-				      zfcp_get_busid_by_adapter(adapter),
-				      port->d_id);
+				      zfcp_get_busid_by_adapter(adapter), d_id);
                         if (bytes == 0) {
                                 ret = -ENOMEM;
                         } else {
@@ -1724,8 +1759,7 @@
                 if (bytes <= 0) {
                         ZFCP_LOG_INFO("error: creation of ELS request failed "
 				      "(adapter %s, port d_id: 0x%08x)\n",
-				      zfcp_get_busid_by_adapter(adapter),
-				      port->d_id);
+				      zfcp_get_busid_by_adapter(adapter), d_id);
                         if (bytes == 0) {
                                 ret = -ENOMEM;
                         } else {
@@ -1739,13 +1773,13 @@
 		ZFCP_LOG_INFO("error: microcode does not support chained SBALs"
                               ", ELS request too big (adapter %s, "
 			      "port d_id: 0x%08x)\n",
-			      zfcp_get_busid_by_adapter(adapter), port->d_id);
+			      zfcp_get_busid_by_adapter(adapter), d_id);
                 ret = -EOPNOTSUPP;
                 goto failed_send;
         }
 
 	/* settings in QTCB */
-	fsf_req->qtcb->bottom.support.d_id = port->d_id;
+	fsf_req->qtcb->bottom.support.d_id = d_id;
 	fsf_req->qtcb->bottom.support.service_class = adapter->fc_service_class;
 	fsf_req->qtcb->bottom.support.timeout = ZFCP_ELS_TIMEOUT;
 	fsf_req->data.send_els = els;
@@ -1756,13 +1790,13 @@
 	ret = zfcp_fsf_req_send(fsf_req, els->timer);
 	if (ret) {
 		ZFCP_LOG_DEBUG("error: initiation of ELS request failed "
-			       "(adapter %s, port 0x%016Lx)\n",
-			       zfcp_get_busid_by_adapter(adapter), port->wwpn);
+			       "(adapter %s, port d_id: 0x%08x)\n",
+			       zfcp_get_busid_by_adapter(adapter), d_id);
 		goto failed_send;
 	}
 
-	ZFCP_LOG_DEBUG("ELS request initiated (adapter %s, port 0x%016Lx)\n",
-		       zfcp_get_busid_by_adapter(adapter), port->wwpn);
+	ZFCP_LOG_DEBUG("ELS request initiated (adapter %s, port d_id: "
+		       "0x%08x)\n", zfcp_get_busid_by_adapter(adapter), d_id);
 	goto out;
 
  failed_send:
@@ -1788,6 +1822,7 @@
 static int zfcp_fsf_send_els_handler(struct zfcp_fsf_req *fsf_req)
 {
 	struct zfcp_adapter *adapter;
+	fc_id_t d_id;
 	struct zfcp_port *port;
 	struct fsf_qtcb_header *header;
 	struct fsf_qtcb_bottom_support *bottom;
@@ -1795,9 +1830,9 @@
 	int retval = -EINVAL;
 	u16 subtable, rule, counter;
 
-	adapter = fsf_req->adapter;
 	send_els = fsf_req->data.send_els;
-	port = send_els->port;
+	adapter = send_els->adapter;
+	d_id = send_els->d_id;
 	header = &fsf_req->qtcb->header;
 	bottom = &fsf_req->qtcb->bottom.support;
 
@@ -1816,35 +1851,38 @@
 		if (adapter->fc_service_class <= 3) {
 			ZFCP_LOG_INFO("error: adapter %s does "
 				      "not support fibrechannel class %d.\n",
-				      zfcp_get_busid_by_port(port),
+				      zfcp_get_busid_by_adapter(adapter),
 				      adapter->fc_service_class);
 		} else {
 			ZFCP_LOG_INFO("bug: The fibrechannel class at "
 				      "adapter %s is invalid. "
 				      "(debug info %d)\n",
-				      zfcp_get_busid_by_port(port),
+				      zfcp_get_busid_by_adapter(adapter),
 				      adapter->fc_service_class);
 		}
 		/* stop operation for this adapter */
 		debug_text_exception(adapter->erp_dbf, 0, "fsf_s_class_nsup");
-		zfcp_erp_adapter_shutdown(port->adapter, 0);
+		zfcp_erp_adapter_shutdown(adapter, 0);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 
 	case FSF_ADAPTER_STATUS_AVAILABLE:
 		ZFCP_LOG_FLAGS(2, "FSF_ADAPTER_STATUS_AVAILABLE\n");
 		switch (header->fsf_status_qual.word[0]){
-		case FSF_SQ_INVOKE_LINK_TEST_PROCEDURE: {
+		case FSF_SQ_INVOKE_LINK_TEST_PROCEDURE:
 			ZFCP_LOG_FLAGS(2,"FSF_SQ_INVOKE_LINK_TEST_PROCEDURE\n");
 			debug_text_event(adapter->erp_dbf, 1, "fsf_sq_ltest");
-			if (send_els->ls_code != ZFCP_LS_ADISC)
-				zfcp_test_link(port);
+			if (send_els->ls_code != ZFCP_LS_ADISC) {
+				read_lock(&zfcp_data.config_lock);
+				port = zfcp_get_port_by_did(adapter, d_id);
+				if (port)
+					zfcp_test_link(port);
+				read_unlock(&zfcp_data.config_lock);
+			}
 			fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 			break;
-		}
 		case FSF_SQ_ULP_DEPENDENT_ERP_REQUIRED:
 			ZFCP_LOG_FLAGS(2,"FSF_SQ_ULP_DEPENDENT_ERP_REQUIRED\n");
-			/* ERP strategy will escalate */
 			debug_text_event(adapter->erp_dbf, 1, "fsf_sq_ulp");
 			fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 			retval =
@@ -1869,8 +1907,8 @@
 		ZFCP_LOG_FLAGS(2, "FSF_ELS_COMMAND_REJECTED\n");
 		ZFCP_LOG_INFO("ELS has been rejected because command filter "
 			      "prohibited sending "
-			      "(adapter: %s, wwpn=0x%016Lx)\n",
-			      zfcp_get_busid_by_port(port), port->wwpn);
+			      "(adapter: %s, port d_id: 0x%08x)\n",
+			      zfcp_get_busid_by_adapter(adapter), d_id);
 
 		break;
 
@@ -1880,7 +1918,7 @@
 			"ELS request size and ELS response size must be either "
 			"both 0, or both greater than 0 "
 			"(adapter: %s, req_buf_length=%d resp_buf_length=%d)\n",
-			zfcp_get_busid_by_port(port),
+			zfcp_get_busid_by_adapter(adapter),
 			bottom->req_buf_length,
 			bottom->resp_buf_length);
 		break;
@@ -1893,7 +1931,7 @@
 			"exceeds the size of the buffers "
 			"that have been allocated for ELS request data "
 			"(adapter: %s, req_buf_length=%d)\n",
-			zfcp_get_busid_by_port(port),
+			zfcp_get_busid_by_adapter(adapter),
 			bottom->req_buf_length);
 		break;
 
@@ -1905,15 +1943,25 @@
 			"exceeds the size of the buffers "
 			"that have been allocated for ELS response data "
 			"(adapter: %s, resp_buf_length=%d)\n",
-			zfcp_get_busid_by_port(port),
+			zfcp_get_busid_by_adapter(adapter),
 			bottom->resp_buf_length);
 		break;
 
+	case FSF_SBAL_MISMATCH:
+		/* should never occure, avoided in zfcp_fsf_send_els */
+		ZFCP_LOG_FLAGS(2, "FSF_SBAL_MISMATCH\n");
+		ZFCP_LOG_INFO("SBAL mismatch (adapter: %s, req_buf_length=%d, "
+			      "resp_buf_length=%d)\n",
+			      zfcp_get_busid_by_adapter(adapter),
+			      bottom->req_buf_length, bottom->resp_buf_length);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		break;
+
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
 		ZFCP_LOG_NORMAL("Access denied, cannot send ELS "
-				"(adapter: %s, wwpn=0x%016Lx)\n",
-				zfcp_get_busid_by_port(port), port->wwpn);
+				"(adapter: %s, port d_id: 0x%08x)\n",
+				zfcp_get_busid_by_adapter(adapter), d_id);
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
 			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
@@ -1935,7 +1983,7 @@
 		ZFCP_LOG_NORMAL(
 			"bug: An unknown FSF Status was presented "
 			"(adapter: %s, fsf_status=0x%08x)\n",
-			zfcp_get_busid_by_port(port),
+			zfcp_get_busid_by_adapter(adapter),
 			header->fsf_status);
 		debug_text_event(adapter->erp_dbf, 0, "fsf_sq_inval");
 		debug_exception(adapter->erp_dbf, 0,
@@ -2537,6 +2585,15 @@
 		}
 		break;
 
+	case FSF_UNKNOWN_OP_SUBTYPE:
+		/* should never occure, subtype not set in zfcp_fsf_open_port */
+		ZFCP_LOG_FLAGS(2, "FSF_UNKNOWN_OP_SUBTYPE\n");
+		ZFCP_LOG_INFO("unknown operation subtype (adapter: %s, "
+			      "op_subtype=0x%x)\n", zfcp_get_busid_by_port(port),
+			      fsf_req->qtcb->bottom.support.operation_subtype);
+		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		break;
+
 	default:
 		ZFCP_LOG_NORMAL("bug: An unknown FSF Status was presented "
 				"(debug info 0x%x)\n",
@@ -4306,7 +4363,7 @@
  *              -EOPNOTSUPP - The FCP adapter does not have Control File support
  *              -EINVAL     - Invalid direction specified
  *              -ENOMEM     - Insufficient memory
- *              -EPERM      - Cannot create FSF request or or place it in QDIO queue
+ *              -EPERM      - Cannot create FSF request or place it in QDIO queue
  */
 int
 zfcp_fsf_control_file(struct zfcp_adapter *adapter,
@@ -4318,17 +4375,17 @@
 	struct zfcp_fsf_req *fsf_req;
 	struct fsf_qtcb_bottom_support *bottom;
 	volatile struct qdio_buffer_element *sbale;
+	struct timer_list *timer;
 	unsigned long lock_flags;
 	int req_flags = 0;
 	int direction;
 	int retval = 0;
 
 	if (!(adapter->supported_features & FSF_FEATURE_CFDC)) {
-		ZFCP_LOG_INFO(
-			"Adapter %s does not support control file\n",
-			zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_INFO("cfdc not supported (adapter %s)\n",
+			      zfcp_get_busid_by_adapter(adapter));
 		retval = -EOPNOTSUPP;
-		goto no_cfdc_support;
+		goto out;
 	}
 
 	switch (fsf_command) {
@@ -4346,9 +4403,16 @@
 
 	default:
 		ZFCP_LOG_INFO("Invalid FSF command code 0x%08x\n", fsf_command);
-		goto invalid_command;
+		retval = -EINVAL;
+		goto out;
 	}
 
+	timer = kmalloc(sizeof(struct timer_list), GFP_KERNEL);
+	if (!timer) {
+		retval = -ENOMEM;
+		goto out;
+ 	}
+
 	retval = zfcp_fsf_req_create(adapter, fsf_command, req_flags,
 				     NULL, &lock_flags, &fsf_req);
 	if (retval < 0) {
@@ -4356,7 +4420,7 @@
 			      "adapter %s\n",
 			zfcp_get_busid_by_adapter(adapter));
 		retval = -EPERM;
-		goto out;
+		goto unlock_queue_lock;
 	}
 
 	sbale = zfcp_qdio_sbale_req(fsf_req, fsf_req->sbal_curr, 0);
@@ -4378,40 +4442,46 @@
 				"SBALS for an FSF request to the adapter %s\n",
 				zfcp_get_busid_by_adapter(adapter));
 			retval = -ENOMEM;
-			goto sbals_failed;
+			goto free_fsf_req;
 		}
-	} else {
+	} else
 		sbale[1].flags |= SBAL_FLAGS_LAST_ENTRY;
-	}
 
-	retval = zfcp_fsf_req_send(fsf_req, NULL);
+	init_timer(timer);
+	timer->function = zfcp_fsf_request_timeout_handler;
+	timer->data = (unsigned long) adapter;
+	timer->expires = ZFCP_FSF_REQUEST_TIMEOUT;
+
+	retval = zfcp_fsf_req_send(fsf_req, timer);
 	if (retval < 0) {
-		ZFCP_LOG_INFO(
-			"error: Could not send FSF request to the adapter %s\n",
-			zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_INFO("initiation of cfdc up/download failed"
+			      "(adapter %s)\n",
+			      zfcp_get_busid_by_adapter(adapter));
 		retval = -EPERM;
-		goto queue_failed;
+		goto free_fsf_req;
 	}
+	write_unlock_irqrestore(&adapter->request_queue.queue_lock, lock_flags);
 
-	ZFCP_LOG_NORMAL(
-		"Control file %s FSF request has been sent to the adapter %s\n",
-		fsf_command == FSF_QTCB_DOWNLOAD_CONTROL_FILE ?
+	ZFCP_LOG_NORMAL("Control file %s FSF request has been sent to the "
+			"adapter %s\n",
+			fsf_command == FSF_QTCB_DOWNLOAD_CONTROL_FILE ?
 			"download" : "upload",
-		zfcp_get_busid_by_adapter(adapter));
+			zfcp_get_busid_by_adapter(adapter));
 
-	*fsf_req_ptr = fsf_req;
+	wait_event(fsf_req->completion_wq,
+	           fsf_req->status & ZFCP_STATUS_FSFREQ_COMPLETED);
 
-	goto out;
+	*fsf_req_ptr = fsf_req;
+	del_timer_sync(timer);
+	goto free_timer;
 
-sbals_failed:
-queue_failed:
+ free_fsf_req:
 	zfcp_fsf_req_free(fsf_req);
-
-out:
+ unlock_queue_lock:
 	write_unlock_irqrestore(&adapter->request_queue.queue_lock, lock_flags);
-
-invalid_command:
-no_cfdc_support:
+ free_timer:
+	kfree(timer);
+ out:
 	return retval;
 }
 
@@ -4550,11 +4620,9 @@
 
 	case FSF_UNKNOWN_OP_SUBTYPE:
 		ZFCP_LOG_FLAGS(2, "FSF_UNKNOWN_OP_SUBTYPE\n");
-		ZFCP_LOG_NORMAL(
-			"Invalid operation subtype 0x%x has been specified "
-			"in QTCB bottom sent to the adapter %s\n",
-			bottom->operation_subtype,
-			zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_NORMAL("unknown operation subtype (adapter: %s, "
+				"op_subtype=0x%x)\n", zfcp_get_busid_by_adapter(adapter),
+				bottom->operation_subtype);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		retval = -EINVAL;
 		break;
@@ -4682,6 +4750,8 @@
 						       ZFCP_SBAL_TIMEOUT);
 		if (ret < 0)
 			return ret;
+		if (!ret)
+			return -EIO;
         } else if (!zfcp_fsf_req_sbal_check(lock_flags, req_queue, 1))
                 return -EIO;
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.h linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.h
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.h	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.h	2004-10-08 19:19:14.000000000 +0200
@@ -12,6 +12,7 @@
  *            Wolfgang Taphorn
  *            Stefan Bader <stefan.bader@de.ibm.com> 
  *            Heiko Carstens <heiko.carstens@de.ibm.com> 
+ *            Andreas Herrmann <aherrman@de.ibm.com>
  * 
  * This program is free software; you can redistribute it and/or modify 
  * it under the terms of the GNU General Public License as published by 
@@ -105,6 +106,8 @@
 #define FSF_PAYLOAD_SIZE_MISMATCH		0x00000060
 #define FSF_REQUEST_SIZE_TOO_LARGE		0x00000061
 #define FSF_RESPONSE_SIZE_TOO_LARGE		0x00000062
+#define FSF_SBAL_MISMATCH			0x00000063
+#define FSF_OPEN_PORT_WITHOUT_PRLI		0x00000064
 #define FSF_ADAPTER_STATUS_AVAILABLE		0x000000AD
 #define FSF_FCP_RSP_AVAILABLE			0x000000AF
 #define FSF_UNKNOWN_COMMAND			0x000000E2
diff -urN linux-2.6/drivers/s390/scsi/zfcp_qdio.c linux-2.6-patched/drivers/s390/scsi/zfcp_qdio.c
--- linux-2.6/drivers/s390/scsi/zfcp_qdio.c	2004-08-14 12:54:49.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_qdio.c	2004-10-08 19:19:14.000000000 +0200
@@ -12,6 +12,7 @@
  *      Raimund Schroeder <raimund.schroeder@de.ibm.com>
  *      Wolfgang Taphorn
  *      Heiko Carstens <heiko.carstens@de.ibm.com>
+ *      Andreas Herrmann <aherrman@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -28,7 +29,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_QDIO_C_REVISION "$Revision: 1.19 $"
+#define ZFCP_QDIO_C_REVISION "$Revision: 1.20 $"
 
 #include "zfcp_ext.h"
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_scsi.c	2004-10-08 19:19:14.000000000 +0200
@@ -12,6 +12,7 @@
  *            Wolfgang Taphorn
  *            Stefan Bader <stefan.bader@de.ibm.com> 
  *            Heiko Carstens <heiko.carstens@de.ibm.com> 
+ *            Andreas Herrmann <aherrman@de.ibm.com>
  * 
  * This program is free software; you can redistribute it and/or modify 
  * it under the terms of the GNU General Public License as published by 
@@ -31,7 +32,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.68 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.71 $"
 
 #include "zfcp_ext.h"
 
@@ -79,7 +80,8 @@
 	      unchecked_isa_dma:       0,
 	      use_clustering:          1,
 	      sdev_attrs:              zfcp_sysfs_sdev_attrs,
-	}
+	},
+	.driver_version = ZFCP_VERSION,
 	/* rest initialised with zeros */
 };
 
@@ -331,8 +333,8 @@
 	scpnt->SCp.ptr = (void *) &wait;  /* silent re-use */
 	scpnt->scsi_done = zfcp_scsi_command_sync_handler;
 	ret = zfcp_scsi_command_async(unit->port->adapter, unit, scpnt, timer);
-	if ((ret == 0) && (scpnt->result == 0))
-	wait_for_completion(&wait);
+	if (ret == 0)
+		wait_for_completion(&wait);
 
 	scpnt->SCp.ptr = NULL;
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_adapter.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_adapter.c	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_adapter.c	2004-10-08 19:19:14.000000000 +0200
@@ -10,6 +10,7 @@
  * Authors:
  *      Martin Peschke <mpeschke@de.ibm.com>
  *	Heiko Carstens <heiko.carstens@de.ibm.com>
+ *      Andreas Herrmann <aherrman@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -26,7 +27,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.37 $"
+#define ZFCP_SYSFS_ADAPTER_C_REVISION "$Revision: 1.38 $"
 
 #include "zfcp_ext.h"
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_driver.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_driver.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_driver.c	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_driver.c	2004-10-08 19:19:14.000000000 +0200
@@ -10,6 +10,7 @@
  * Authors:
  *      Martin Peschke <mpeschke@de.ibm.com>
  *	Heiko Carstens <heiko.carstens@de.ibm.com>
+ *      Andreas Herrmann <aherrman@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -26,7 +27,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_DRIVER_C_REVISION "$Revision: 1.15 $"
+#define ZFCP_SYSFS_DRIVER_C_REVISION "$Revision: 1.17 $"
 
 #include "zfcp_ext.h"
 
@@ -85,7 +86,7 @@
 static ssize_t zfcp_sysfs_version_show(struct device_driver *dev,
 					      char *buf)
 {
-	return sprintf(buf, "%s\n", ZFCP_VERSION);
+	return sprintf(buf, "%s\n", zfcp_data.driver_version);
 }
 
 static DRIVER_ATTR(version, S_IRUGO, zfcp_sysfs_version_show, NULL);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_port.c	2004-10-08 19:19:14.000000000 +0200
@@ -10,6 +10,7 @@
  * Authors:
  *      Martin Peschke <mpeschke@de.ibm.com>
  *	Heiko Carstens <heiko.carstens@de.ibm.com>
+ *      Andreas Herrmann <aherrman@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -26,7 +27,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.44 $"
+#define ZFCP_SYSFS_PORT_C_REVISION "$Revision: 1.46 $"
 
 #include "zfcp_ext.h"
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c	2004-10-08 19:19:00.000000000 +0200
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_unit.c	2004-10-08 19:19:14.000000000 +0200
@@ -10,6 +10,7 @@
  * Authors:
  *      Martin Peschke <mpeschke@de.ibm.com>
  *	Heiko Carstens <heiko.carstens@de.ibm.com>
+ *      Andreas Herrmann <aherrman@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -26,7 +27,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.27 $"
+#define ZFCP_SYSFS_UNIT_C_REVISION "$Revision: 1.29 $"
 
 #include "zfcp_ext.h"
 
