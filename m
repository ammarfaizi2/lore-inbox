Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262306AbUKKSaW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262306AbUKKSaW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 13:30:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262322AbUKKRhj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 12:37:39 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:14556 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262306AbUKKRRa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 12:17:30 -0500
Date: Thu, 11 Nov 2004 18:17:20 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 9/10] s390: zfcp read-only lun sharing.
Message-ID: <20041111171720.GK4900@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 9/10] s390: zfcp read-only lun sharing.

From: Volker Sameske <sameske@de.ibm.com>

zfcp host adapter:
 - Add read-only lun sharing feature.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_def.h        |    8 ++
 drivers/s390/scsi/zfcp_erp.c        |    8 +-
 drivers/s390/scsi/zfcp_fsf.c        |  118 ++++++++++++++++++++++++++++++------
 drivers/s390/scsi/zfcp_fsf.h        |   14 +++-
 drivers/s390/scsi/zfcp_sysfs_port.c |    4 +
 drivers/s390/scsi/zfcp_sysfs_unit.c |   10 +++
 6 files changed, 140 insertions(+), 22 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-patched/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	2004-11-11 15:07:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_def.h	2004-11-11 15:07:00.000000000 +0100
@@ -13,6 +13,7 @@
  *            Stefan Bader <stefan.bader@de.ibm.com> 
  *            Heiko Carstens <heiko.carstens@de.ibm.com> 
  *            Andreas Herrmann <aherrman@de.ibm.com>
+ *            Volker Sameske <sameske@de.ibm.com>
  * 
  * This program is free software; you can redistribute it and/or modify 
  * it under the terms of the GNU General Public License as published by 
@@ -378,6 +379,9 @@
 
 #define ZFCP_NAME               "zfcp"
 
+/* read-only LUN sharing switch initial value */
+#define ZFCP_RO_LUN_SHARING_DEFAULTS 0
+
 /* independent log areas */
 #define ZFCP_LOG_AREA_OTHER	0
 #define ZFCP_LOG_AREA_SCSI	1
@@ -528,6 +532,7 @@
 #define ZFCP_STATUS_PORT_NO_WWPN		0x00000008
 #define ZFCP_STATUS_PORT_NO_SCSI_ID		0x00000010
 #define ZFCP_STATUS_PORT_INVALID_WWPN		0x00000020
+#define ZFCP_STATUS_PORT_ACCESS_DENIED		0x00000040
 
 /* for ports with well known addresses */
 #define ZFCP_STATUS_PORT_WKA \
@@ -536,6 +541,9 @@
 
 /* logical unit status */
 #define ZFCP_STATUS_UNIT_NOTSUPPUNITRESET       0x00000001
+#define ZFCP_STATUS_UNIT_ACCESS_DENIED          0x00000002
+#define ZFCP_STATUS_UNIT_ACCESS_SHARED          0x00000004
+#define ZFCP_STATUS_UNIT_ACCESS_READONLY        0x00000008
 #define ZFCP_STATUS_UNIT_TEMPORARY		0x00000010
 
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	2004-11-11 15:07:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_erp.c	2004-11-11 15:07:00.000000000 +0100
@@ -2810,7 +2810,8 @@
 			  ZFCP_STATUS_COMMON_CLOSING |
 			  ZFCP_STATUS_PORT_DID_DID |
 			  ZFCP_STATUS_PORT_PHYS_CLOSING |
-			  ZFCP_STATUS_PORT_INVALID_WWPN, &port->status);
+			  ZFCP_STATUS_PORT_INVALID_WWPN |
+			  ZFCP_STATUS_PORT_ACCESS_DENIED, &port->status);
 	return retval;
 }
 
@@ -3014,7 +3015,10 @@
 	debug_event(adapter->erp_dbf, 5, &unit->fcp_lun, sizeof (fcp_lun_t));
 
 	atomic_clear_mask(ZFCP_STATUS_COMMON_OPENING |
-			  ZFCP_STATUS_COMMON_CLOSING, &unit->status);
+			  ZFCP_STATUS_COMMON_CLOSING |
+			  ZFCP_STATUS_UNIT_ACCESS_DENIED |
+			  ZFCP_STATUS_UNIT_ACCESS_SHARED |
+			  ZFCP_STATUS_UNIT_ACCESS_READONLY, &unit->status);
 
 	return retval;
 }
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	2004-11-11 15:07:00.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.c	2004-11-11 15:07:00.000000000 +0100
@@ -13,6 +13,7 @@
  *            Stefan Bader <stefan.bader@de.ibm.com>
  *            Heiko Carstens <heiko.carstens@de.ibm.com>
  *            Andreas Herrmann <aherrman@de.ibm.com>
+ *            Volker Sameske <sameske@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -993,6 +994,15 @@
 		zfcp_fsf_incoming_els(fsf_req);
 		break;
 
+	case FSF_STATUS_READ_SENSE_DATA_AVAIL:
+		ZFCP_LOG_FLAGS(1, "FSF_STATUS_READ_SENSE_DATA_AVAIL\n");
+		debug_text_event(adapter->erp_dbf, 3, "unsol_sense:");
+		ZFCP_LOG_INFO("unsolicited sense data received (adapter %s)\n",
+			      zfcp_get_busid_by_adapter(adapter));
+                ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL, (char *) status_buffer,
+                              sizeof(struct fsf_status_read_buffer));
+		break;
+
 	case FSF_STATUS_READ_BIT_ERROR_THRESHOLD:
 		ZFCP_LOG_FLAGS(1, "FSF_STATUS_READ_BIT_ERROR_THRESHOLD\n");
 		debug_text_event(adapter->erp_dbf, 3, "unsol_bit_err:");
@@ -1290,6 +1300,22 @@
 		    | ZFCP_STATUS_FSFREQ_RETRY;
 		break;
 
+	case FSF_LUN_BOXED:
+                ZFCP_LOG_FLAGS(0, "FSF_LUN_BOXED\n");
+                ZFCP_LOG_INFO(
+                        "unit 0x%016Lx on port 0x%016Lx on adapter %s needs "
+                        "to be reopened\n",
+                        unit->fcp_lun, unit->port->wwpn,
+                        zfcp_get_busid_by_unit(unit));
+                debug_text_event(new_fsf_req->adapter->erp_dbf, 1, "fsf_s_lboxed");
+                zfcp_erp_unit_reopen(unit, 0);
+                zfcp_cmd_dbf_event_fsf("unitbox", new_fsf_req,
+                        &new_fsf_req->qtcb->header.fsf_status_qual,
+                        sizeof(union fsf_status_qual));
+                new_fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR
+                        | ZFCP_STATUS_FSFREQ_RETRY;
+                break;
+
 	case FSF_ADAPTER_STATUS_AVAILABLE:
 		/* 2 */
 		ZFCP_LOG_FLAGS(0, "FSF_ADAPTER_STATUS_AVAILABLE\n");
@@ -2034,7 +2060,7 @@
 
 	erp_action->fsf_req->erp_action = erp_action;
 	erp_action->fsf_req->qtcb->bottom.config.feature_selection =
-		FSF_FEATURE_CFDC;
+		(FSF_FEATURE_CFDC | FSF_FEATURE_LUN_SHARING);
 
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
@@ -2467,6 +2493,7 @@
 			}
 		}
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_access");
+		atomic_set_mask(ZFCP_STATUS_PORT_ACCESS_DENIED, &port->status);
 		zfcp_erp_port_failed(port);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -2997,6 +3024,8 @@
 		erp_action->port->handle;
 	erp_action->fsf_req->qtcb->bottom.support.fcp_lun =
 		erp_action->unit->fcp_lun;
+	erp_action->fsf_req->qtcb->bottom.support.option =
+		FSF_OPEN_LUN_SUPPRESS_BOXING;
 	atomic_set_mask(ZFCP_STATUS_COMMON_OPENING, &erp_action->unit->status);
 	erp_action->fsf_req->data.open_unit.unit = erp_action->unit;
 	erp_action->fsf_req->erp_action = erp_action;
@@ -3040,18 +3069,31 @@
 	struct zfcp_unit *unit;
 	struct fsf_qtcb_header *header;
 	struct fsf_qtcb_bottom_support *bottom;
+	struct fsf_queue_designator *queue_designator;
 	u16 subtable, rule, counter;
+	u32 allowed, exclusive, readwrite;
+
 
-	adapter = fsf_req->adapter;
 	unit = fsf_req->data.open_unit.unit;
-	header = &fsf_req->qtcb->header;
-	bottom = &fsf_req->qtcb->bottom.support;
 
 	if (fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR) {
 		/* don't change unit status in our bookkeeping */
 		goto skip_fsfstatus;
 	}
 
+	adapter = fsf_req->adapter;
+	header = &fsf_req->qtcb->header;
+	bottom = &fsf_req->qtcb->bottom.support;
+	queue_designator = &header->fsf_status_qual.fsf_queue_designator;
+	allowed = bottom->lun_access_info & FSF_UNIT_ACCESS_OPEN_LUN_ALLOWED;
+	exclusive = bottom->lun_access_info & FSF_UNIT_ACCESS_EXCLUSIVE_ACCESS;
+	readwrite = bottom->lun_access_info & FSF_UNIT_ACCESS_OUTBOUND_TRANSFER;
+
+        atomic_clear_mask(ZFCP_STATUS_UNIT_ACCESS_DENIED |
+			  ZFCP_STATUS_UNIT_ACCESS_SHARED |
+			  ZFCP_STATUS_UNIT_ACCESS_READONLY,
+			  &unit->status);
+
 	/* evaluate FSF status in QTCB */
 	switch (header->fsf_status) {
 
@@ -3102,6 +3144,11 @@
 			}
 		}
 		debug_text_event(adapter->erp_dbf, 1, "fsf_s_access");
+		atomic_set_mask(ZFCP_STATUS_UNIT_ACCESS_DENIED, &unit->status);
+		atomic_clear_mask(ZFCP_STATUS_UNIT_ACCESS_SHARED,
+				  &unit->status);
+                atomic_clear_mask(ZFCP_STATUS_UNIT_ACCESS_READONLY,
+				  &unit->status);
 		zfcp_erp_unit_failed(unit);
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
@@ -3123,11 +3170,12 @@
 			ZFCP_LOG_NORMAL("FCP-LUN 0x%Lx at the remote port "
 					"with WWPN 0x%Lx "
 					"connected to the adapter %s "
-					"is already in use in LPAR%d\n",
+					"is already in use in LPAR%d, CSS%d\n",
 					unit->fcp_lun,
 					unit->port->wwpn,
 					zfcp_get_busid_by_unit(unit),
-					header->fsf_status_qual.fsf_queue_designator.hla);
+					queue_designator->hla,
+					queue_designator->cssid);
 		} else {
 			subtable = header->fsf_status_qual.halfword[4];
 			rule = header->fsf_status_qual.halfword[5];
@@ -3228,6 +3276,39 @@
 			       unit->handle);
 		/* mark unit as open */
 		atomic_set_mask(ZFCP_STATUS_COMMON_OPEN, &unit->status);
+
+		if (adapter->supported_features & FSF_FEATURE_LUN_SHARING){
+			if (!exclusive)
+		                atomic_set_mask(ZFCP_STATUS_UNIT_ACCESS_SHARED,
+						&unit->status);
+
+			if (!readwrite) {
+                		atomic_set_mask(
+					ZFCP_STATUS_UNIT_ACCESS_READONLY,
+					&unit->status);
+                		ZFCP_LOG_NORMAL("read-only access for unit "
+						"(adapter %s, wwpn=0x%016Lx, "
+						"fcp_lun=0x%016Lx)\n",
+						zfcp_get_busid_by_unit(unit),
+						unit->port->wwpn,
+						unit->fcp_lun);
+        		}
+
+        		if (exclusive && !readwrite) {
+                		ZFCP_LOG_NORMAL("exclusive access of read-only "
+						"unit not supported\n");
+				zfcp_erp_unit_failed(unit);
+				fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+				zfcp_erp_unit_shutdown(unit, 0);
+        		} else if (!exclusive && readwrite) {
+                		ZFCP_LOG_NORMAL("shared access of read-write "
+						"unit not supported\n");
+                		zfcp_erp_unit_failed(unit);
+				fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+				zfcp_erp_unit_shutdown(unit, 0);
+        		}
+		}
+
 		retval = 0;
 		break;
 
@@ -3477,6 +3558,7 @@
 	unsigned long lock_flags;
 	int real_bytes = 0;
 	int retval = 0;
+	int mask;
 
 	/* setup new FSF request */
 	retval = zfcp_fsf_req_create(adapter, FSF_QTCB_FCP_CMND, req_flags,
@@ -3561,14 +3643,15 @@
 	/* set FCP_LUN in FCP_CMND IU in QTCB */
 	fcp_cmnd_iu->fcp_lun = unit->fcp_lun;
 
+	mask = ZFCP_STATUS_UNIT_ACCESS_READONLY |
+		ZFCP_STATUS_UNIT_ACCESS_SHARED;
+
 	/* set task attributes in FCP_CMND IU in QTCB */
-	if (likely(scsi_cmnd->device->simple_tags)) {
+	if (likely((scsi_cmnd->device->simple_tags) ||
+		   (atomic_test_mask(mask, &unit->status))))
 		fcp_cmnd_iu->task_attribute = SIMPLE_Q;
-		ZFCP_LOG_TRACE("setting SIMPLE_Q task attribute\n");
-	} else {
+	else
 		fcp_cmnd_iu->task_attribute = UNTAGGED;
-		ZFCP_LOG_TRACE("setting UNTAGGED task attribute\n");
-	}
 
 	/* set additional length of FCP_CDB in FCP_CMND IU in QTCB, if needed */
 	if (unlikely(scsi_cmnd->cmd_len > FCP_CDB_LENGTH)) {
@@ -3962,16 +4045,15 @@
 
 	case FSF_LUN_BOXED:
 		ZFCP_LOG_FLAGS(0, "FSF_LUN_BOXED\n");
-		ZFCP_LOG_NORMAL(
-			"unit 0x%016Lx on port 0x%016Lx on adapter %s needs "
-			"to be reopened\n",
-			unit->fcp_lun, unit->port->wwpn,
-			zfcp_get_busid_by_unit(unit));
+		ZFCP_LOG_NORMAL("unit needs to be reopened (adapter %s, "
+				"wwpn=0x%016Lx, fcp_lun=0x%016Lx)\n",
+				zfcp_get_busid_by_unit(unit),
+				unit->port->wwpn, unit->fcp_lun);
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_lboxed");
 		zfcp_erp_unit_reopen(unit, 0);
 		zfcp_cmd_dbf_event_fsf("unitbox", fsf_req,
-			&header->fsf_status_qual,
-			sizeof(union fsf_status_qual));
+				       &header->fsf_status_qual,
+				       sizeof(union fsf_status_qual));
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR
 			| ZFCP_STATUS_FSFREQ_RETRY;
 		break;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.h linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.h
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.h	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_fsf.h	2004-11-11 15:07:00.000000000 +0100
@@ -11,8 +11,9 @@
  *            Aron Zeh
  *            Wolfgang Taphorn
  *            Stefan Bader <stefan.bader@de.ibm.com> 
- *            Heiko Carstens <heiko.carstens@de.ibm.com> 
+ *            Heiko Carstens <heiko.carstens@de.ibm.com>
  *            Andreas Herrmann <aherrman@de.ibm.com>
+ *            Volker Sameske <sameske@de.ibm.com>
  * 
  * This program is free software; you can redistribute it and/or modify 
  * it under the terms of the GNU General Public License as published by 
@@ -150,6 +151,7 @@
 /* status types in status read buffer */
 #define FSF_STATUS_READ_PORT_CLOSED		0x00000001
 #define FSF_STATUS_READ_INCOMING_ELS		0x00000002
+#define FSF_STATUS_READ_SENSE_DATA_AVAIL        0x00000003
 #define FSF_STATUS_READ_BIT_ERROR_THRESHOLD	0x00000004
 #define FSF_STATUS_READ_LINK_DOWN		0x00000005 /* FIXME: really? */
 #define FSF_STATUS_READ_LINK_UP          	0x00000006
@@ -192,11 +194,13 @@
 /* channel features */
 #define FSF_FEATURE_QTCB_SUPPRESSION            0x00000001
 #define FSF_FEATURE_CFDC			0x00000002
+#define FSF_FEATURE_LUN_SHARING			0x00000004
 #define FSF_FEATURE_HBAAPI_MANAGEMENT           0x00000010
 #define FSF_FEATURE_ELS_CT_CHAINED_SBALS        0x00000020
 
 /* option */
 #define FSF_OPEN_LUN_SUPPRESS_BOXING		0x00000001
+#define FSF_OPEN_LUN_REPLICATE_SENSE		0x00000002
 
 /* adapter types */
 #define FSF_ADAPTER_TYPE_FICON                  0x00000001
@@ -228,6 +232,11 @@
 #define FSF_IOSTAT_FABRIC_RJT			0x00000005
 #define FSF_IOSTAT_LS_RJT			0x00000009
 
+/* open LUN access flags*/
+#define FSF_UNIT_ACCESS_OPEN_LUN_ALLOWED        0x01000000
+#define FSF_UNIT_ACCESS_EXCLUSIVE_ACCESS        0x02000000
+#define FSF_UNIT_ACCESS_OUTBOUND_TRANSFER       0x10000000
+
 struct fsf_queue_designator;
 struct fsf_status_read_buffer;
 struct fsf_port_closed_payload;
@@ -381,7 +390,8 @@
 	u32 service_class;
 	u8  res3[3];
 	u8  timeout;
-	u8  res4[184];
+        u32 lun_access_info;
+        u8  res4[180];
 	u32 els1_length;
 	u32 els2_length;
 	u32 req_buf_length;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_port.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_port.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_port.c	2004-11-11 15:07:00.000000000 +0100
@@ -11,6 +11,7 @@
  *      Martin Peschke <mpeschke@de.ibm.com>
  *	Heiko Carstens <heiko.carstens@de.ibm.com>
  *      Andreas Herrmann <aherrman@de.ibm.com>
+ *      Volker Sameske <sameske@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -69,6 +70,8 @@
 ZFCP_DEFINE_PORT_ATTR(scsi_id, "0x%x\n", port->scsi_id);
 ZFCP_DEFINE_PORT_ATTR(in_recovery, "%d\n", atomic_test_mask
 		      (ZFCP_STATUS_COMMON_ERP_INUSE, &port->status));
+ZFCP_DEFINE_PORT_ATTR(access_denied, "%d\n", atomic_test_mask
+		      (ZFCP_STATUS_PORT_ACCESS_DENIED, &port->status));
 
 /**
  * zfcp_sysfs_unit_add_store - add a unit to sysfs tree
@@ -245,6 +248,7 @@
 	&dev_attr_status.attr,
 	&dev_attr_wwnn.attr,
 	&dev_attr_d_id.attr,
+	&dev_attr_access_denied.attr,
 	NULL
 };
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_unit.c
--- linux-2.6/drivers/s390/scsi/zfcp_sysfs_unit.c	2004-11-11 15:06:39.000000000 +0100
+++ linux-2.6-patched/drivers/s390/scsi/zfcp_sysfs_unit.c	2004-11-11 15:07:00.000000000 +0100
@@ -11,6 +11,7 @@
  *      Martin Peschke <mpeschke@de.ibm.com>
  *	Heiko Carstens <heiko.carstens@de.ibm.com>
  *      Andreas Herrmann <aherrman@de.ibm.com>
+ *      Volker Sameske <sameske@de.ibm.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
@@ -67,6 +68,12 @@
 ZFCP_DEFINE_UNIT_ATTR(scsi_lun, "0x%x\n", unit->scsi_lun);
 ZFCP_DEFINE_UNIT_ATTR(in_recovery, "%d\n", atomic_test_mask
 		      (ZFCP_STATUS_COMMON_ERP_INUSE, &unit->status));
+ZFCP_DEFINE_UNIT_ATTR(access_denied, "%d\n", atomic_test_mask
+		      (ZFCP_STATUS_UNIT_ACCESS_DENIED, &unit->status));
+ZFCP_DEFINE_UNIT_ATTR(access_shared, "%d\n", atomic_test_mask
+		      (ZFCP_STATUS_UNIT_ACCESS_SHARED, &unit->status));
+ZFCP_DEFINE_UNIT_ATTR(access_readonly, "%d\n", atomic_test_mask
+		      (ZFCP_STATUS_UNIT_ACCESS_READONLY, &unit->status));
 
 /**
  * zfcp_sysfs_unit_failed_store - failed state of unit
@@ -135,6 +142,9 @@
 	&dev_attr_failed.attr,
 	&dev_attr_in_recovery.attr,
 	&dev_attr_status.attr,
+	&dev_attr_access_denied.attr,
+	&dev_attr_access_shared.attr,
+	&dev_attr_access_readonly.attr,
 	NULL
 };
 
