Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbUDHOo5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 10:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbUDHOo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 10:44:56 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:51440 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S261897AbUDHObW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 10:31:22 -0400
Date: Thu, 8 Apr 2004 16:31:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] s390 (9/12): zfcp log messages part 2.
Message-ID: <20040408143105.GJ1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zfcp host adapter log message cleanup part 2:
 - Shorten log output.
 - Increase log level for some messages.
 - Always print leading zeroes for wwpn and fcp-lun.

diffstat:
 drivers/s390/scsi/zfcp_fsf.c  |  707 ++++++++++++++++--------------------------
 drivers/s390/scsi/zfcp_fsf.h  |   23 -
 drivers/s390/scsi/zfcp_qdio.c |  102 ++----
 drivers/s390/scsi/zfcp_scsi.c |   94 ++---
 4 files changed, 365 insertions(+), 561 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Thu Apr  8 15:21:28 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Thu Apr  8 15:21:29 2004
@@ -255,8 +255,7 @@
 
 	/* cleanup request if requested by initiator */
 	if (likely(cleanup)) {
-		ZFCP_LOG_TRACE("removing FSF request 0x%lx\n",
-			       (unsigned long) fsf_req);
+		ZFCP_LOG_TRACE("removing FSF request %p\n", fsf_req);
 		/*
 		 * lock must not be held here since it will be
 		 * grabed by the called routine, too
@@ -264,8 +263,7 @@
 		zfcp_fsf_req_cleanup(fsf_req);
 	} else {
 		/* notify initiator waiting for the requests completion */
-		ZFCP_LOG_TRACE("waking initiator of FSF request 0x%lx\n",
-			       (unsigned long) fsf_req);
+		ZFCP_LOG_TRACE("waking initiator of FSF request %p\n",fsf_req);
 		/*
 		 * FIXME: Race! We must not access fsf_req here as it might have been
 		 * cleaned up already due to the set ZFCP_STATUS_FSFREQ_COMPLETED
@@ -302,7 +300,7 @@
 	int retval = 0;
 	struct zfcp_adapter *adapter = fsf_req->adapter;
 
-	ZFCP_LOG_DEBUG("QTCB is at 0x%lx\n", (unsigned long) fsf_req->qtcb);
+	ZFCP_LOG_DEBUG("QTCB is at %p\n", fsf_req->qtcb);
 
 	if (fsf_req->status & ZFCP_STATUS_FSFREQ_DISMISSED) {
 		ZFCP_LOG_DEBUG("fsf_req 0x%lx has been dismissed\n",
@@ -357,18 +355,6 @@
 
 	case FSF_PROT_QTCB_VERSION_ERROR:
 		ZFCP_LOG_FLAGS(0, "FSF_PROT_QTCB_VERSION_ERROR\n");
-		/* DEBUG */
-		ZFCP_LOG_NORMAL("fsf_req=0x%lx, qtcb=0x%lx (0x%lx, 0x%lx)\n",
-				(unsigned long) fsf_req,
-				(unsigned long) fsf_req->qtcb,
-				((unsigned long) fsf_req) & 0xFFFFFF00,
-				(unsigned
-				 long) ((struct zfcp_fsf_req
-					 *) (((unsigned long) fsf_req) &
-					     0xFFFFFF00))->qtcb);
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
-			      (char *) (((unsigned long) fsf_req) & 0xFFFFFF00),
-			      sizeof (struct zfcp_fsf_req));
 		ZFCP_LOG_NORMAL("error: The adapter %s contains "
 				"microcode of version 0x%x, the device driver "
 				"only supports 0x%x. Aborting.\n",
@@ -417,17 +403,6 @@
 				"that used on adapter %s. "
 				"Stopping all operations on this adapter.\n",
 				zfcp_get_busid_by_adapter(adapter));
-		ZFCP_LOG_NORMAL("fsf_req=0x%lx, qtcb=0x%lx (0x%lx, 0x%lx)\n",
-				(unsigned long) fsf_req,
-				(unsigned long) fsf_req->qtcb,
-				((unsigned long) fsf_req) & 0xFFFFFF00,
-				(unsigned long) (
-					(struct zfcp_fsf_req *) (
-						((unsigned long)
-						 fsf_req) & 0xFFFFFF00))->qtcb);
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
-			      (char *) (((unsigned long) fsf_req) & 0xFFFFFF00),
-			      sizeof (struct zfcp_fsf_req));
 		debug_text_exception(adapter->erp_dbf, 0, "prot_unsup_qtcb");
 		zfcp_erp_adapter_shutdown(adapter, 0);
 		zfcp_cmd_dbf_event_fsf("unsqtcbt", fsf_req,
@@ -450,7 +425,7 @@
 	case FSF_PROT_DUPLICATE_REQUEST_ID:
 		ZFCP_LOG_FLAGS(0, "FSF_PROT_DUPLICATE_REQUEST_IDS\n");
 		if (fsf_req->qtcb) {
-			ZFCP_LOG_NORMAL("bug: The request identifier  0x%Lx "
+			ZFCP_LOG_NORMAL("bug: The request identifier 0x%Lx "
 					"to the adapter %s is ambiguous. "
 					"Stopping all operations on this "
 					"adapter.\n",
@@ -459,13 +434,13 @@
 					 req_handle),
 					zfcp_get_busid_by_adapter(adapter));
 		} else {
-			ZFCP_LOG_NORMAL("bug: The request identifier  0x%lx "
+			ZFCP_LOG_NORMAL("bug: The request identifier %p "
 					"to the adapter %s is ambiguous. "
 					"Stopping all operations on this "
 					"adapter. "
 					"(bug: got this for an unsolicited "
 					"status read request)\n",
-					(unsigned long) fsf_req,
+					fsf_req,
 					zfcp_get_busid_by_adapter(adapter));
 		}
 		debug_text_exception(adapter->erp_dbf, 0, "prot_dup_id");
@@ -584,19 +559,6 @@
 				"(debug info 0x%x).\n",
 				zfcp_get_busid_by_adapter(adapter),
 				fsf_req->qtcb->prefix.prot_status);
-		ZFCP_LOG_NORMAL("fsf_req=0x%lx, qtcb=0x%lx (0x%lx, 0x%lx)\n",
-				(unsigned long) fsf_req,
-				(unsigned long) fsf_req->qtcb,
-				((unsigned long) fsf_req) & 0xFFFFFF00,
-				(unsigned
-				 long) ((struct zfcp_fsf_req
-					 *) (((unsigned long) fsf_req) &
-					     0xFFFFFF00))->qtcb);
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
-			      (char *) (((unsigned long) fsf_req) & 0xFFFFFF00),
-			      sizeof (struct zfcp_fsf_req));
-		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL, (char *) fsf_req->qtcb,
-			      sizeof(struct fsf_qtcb));
 		debug_text_event(adapter->erp_dbf, 0, "prot_inval:");
 		debug_exception(adapter->erp_dbf, 0,
 				&fsf_req->qtcb->prefix.prot_status,
@@ -779,9 +741,7 @@
 	int retval = 0;
 
 	if (unlikely(fsf_req->status & ZFCP_STATUS_FSFREQ_ERROR)) {
-		ZFCP_LOG_TRACE("fsf_req=0x%lx, QTCB=0x%lx\n",
-			       (unsigned long) fsf_req,
-			       (unsigned long) (fsf_req->qtcb));
+		ZFCP_LOG_TRACE("fsf_req=%p, QTCB=%p\n", fsf_req, fsf_req->qtcb);
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_TRACE,
 			      (char *) fsf_req->qtcb, sizeof(struct fsf_qtcb));
 	}
@@ -852,10 +812,8 @@
 		ZFCP_LOG_FLAGS(2, "FSF_QTCB_UNKNOWN\n");
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		ZFCP_LOG_NORMAL("bug: Command issued by the device driver is "
-				"not supported by the adapter %s "
-				"(debug info 0x%lx 0x%x).\n",
-				zfcp_get_busid_by_adapter(fsf_req->adapter),
-				(unsigned long) fsf_req, fsf_req->fsf_command);
+				"not supported by the adapter %s\n",
+				zfcp_get_busid_by_adapter(fsf_req->adapter));
 		if (fsf_req->fsf_command != fsf_req->qtcb->header.fsf_command)
 			ZFCP_LOG_NORMAL
 			    ("bug: Command issued by the device driver differs "
@@ -898,9 +856,8 @@
 				     adapter->pool.fsf_req_status_read,
 				     &lock_flags, &fsf_req);
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "unsolicited status buffer for "
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Could not create unsolicited status "
+			      "buffer for adapter %s.\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		goto failed_req_create;
 	}
@@ -932,8 +889,7 @@
 		goto failed_req_send;
 	}
 
-	ZFCP_LOG_TRACE("Status Read request initiated "
-		       "(adapter busid=%s)\n",
+	ZFCP_LOG_TRACE("Status Read request initiated (adapter%s)\n",
 		       zfcp_get_busid_by_adapter(adapter));
 	debug_text_event(adapter->req_dbf, 1, "unso");
 	goto out;
@@ -967,9 +923,9 @@
 	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
 
 	if (!port || (port->d_id != (status_buffer->d_id & ZFCP_DID_MASK))) {
-		ZFCP_LOG_NORMAL("bug: Re-open port indication received for the "
-				"non-existing port with DID 0x%3.3x, on "
-				"the adapter %s. Ignored.\n",
+		ZFCP_LOG_NORMAL("bug: Reopen port indication received for"
+				"nonexisting port with d_id 0x%08x on "
+				"adapter %s. Ignored.\n",
 				status_buffer->d_id & ZFCP_DID_MASK,
 				zfcp_get_busid_by_adapter(adapter));
 		goto out;
@@ -994,9 +950,9 @@
 		debug_exception(adapter->erp_dbf, 0,
 				&status_buffer->status_subtype, sizeof (u32));
 		ZFCP_LOG_NORMAL("bug: Undefined status subtype received "
-				"for a re-open indication on the port with "
-				"DID 0x%3.3x, on the adapter "
-				"%s. Ignored. (debug info 0x%x)\n",
+				"for a reopen indication on port with "
+				"d_id 0x%08x on the adapter %s. "
+				"Ignored. (debug info 0x%x)\n",
 				status_buffer->d_id,
 				zfcp_get_busid_by_adapter(adapter),
 				status_buffer->status_subtype);
@@ -1064,9 +1020,8 @@
 	case FSF_STATUS_READ_LINK_UP:
 		ZFCP_LOG_FLAGS(1, "FSF_STATUS_READ_LINK_UP\n");
 		debug_text_event(adapter->erp_dbf, 2, "unsol_link_up:");
-		ZFCP_LOG_INFO("The local link to the adapter %s "
-			      "was re-plugged. "
-			      "Re-starting operations on this adapter..\n",
+		ZFCP_LOG_INFO("Local link to adapter %s was replugged. "
+			      "Restarting operations on this adapter\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		/* All ports should be marked as ready to run again */
 		zfcp_erp_modify_adapter_status(adapter,
@@ -1081,9 +1036,8 @@
 	case FSF_STATUS_READ_CFDC_UPDATED:
 		ZFCP_LOG_FLAGS(1, "FSF_STATUS_READ_CFDC_UPDATED\n");
 		debug_text_event(adapter->erp_dbf, 2, "unsol_cfdc_update:");
-		ZFCP_LOG_NORMAL(
-			"CFDC has been updated on the adapter %s\n",
-			zfcp_get_busid_by_adapter(adapter));
+		ZFCP_LOG_INFO("CFDC has been updated on the adapter %s\n",
+			      zfcp_get_busid_by_adapter(adapter));
 		break;
 
 	case FSF_STATUS_READ_CFDC_HARDENED:
@@ -1091,21 +1045,17 @@
 		debug_text_event(adapter->erp_dbf, 2, "unsol_cfdc_harden:");
 		switch (status_buffer->status_subtype) {
 		case FSF_STATUS_READ_SUB_CFDC_HARDENED_ON_SE:
-			ZFCP_LOG_NORMAL(
-				"CFDC of the adapter %s "
-				"has been saved on the SE\n",
-				zfcp_get_busid_by_adapter(adapter));
+			ZFCP_LOG_INFO("CFDC of adapter %s saved on SE\n",
+				      zfcp_get_busid_by_adapter(adapter));
 			break;
 		case FSF_STATUS_READ_SUB_CFDC_HARDENED_ON_SE2:
-			ZFCP_LOG_NORMAL(
-				"CFDC of the adapter %s "
-				"has been copied to the secondary SE\n",
+			ZFCP_LOG_INFO("CFDC of adapter %s has been copied "
+				      "to the secondary SE\n",
 				zfcp_get_busid_by_adapter(adapter));
 			break;
 		default:
-			ZFCP_LOG_NORMAL(
-				"CFDC of the adapter %s has been hardened\n",
-				zfcp_get_busid_by_adapter(adapter));
+			ZFCP_LOG_INFO("CFDC of adapter %s has been hardened\n",
+				      zfcp_get_busid_by_adapter(adapter));
 		}
 		break;
 
@@ -1114,11 +1064,10 @@
 		debug_exception(adapter->erp_dbf, 0,
 				&status_buffer->status_type, sizeof (u32));
 		ZFCP_LOG_NORMAL("bug: An unsolicited status packet of unknown "
-				"type was received by the zfcp-driver "
-				"(debug info 0x%x)\n",
+				"type was received (debug info 0x%x)\n",
 				status_buffer->status_type);
-		ZFCP_LOG_DEBUG("Dump of status_read_buffer 0x%lx:\n",
-			       (unsigned long) status_buffer);
+		ZFCP_LOG_DEBUG("Dump of status_read_buffer %p:\n",
+			       status_buffer);
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
 			      (char *) status_buffer,
 			      sizeof (struct fsf_status_read_buffer));
@@ -1142,17 +1091,15 @@
 	 */
 	retval = zfcp_fsf_status_read(adapter, 0);
 	if (retval < 0) {
-		ZFCP_LOG_INFO("Outbound queue busy. "
-			      "Could not create use an "
-			      "unsolicited status read request for "
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("Failed to create unsolicited status read "
+			      "request for the adapter %s.\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		/* temporary fix to avoid status read buffer shortage */
 		adapter->status_read_failed++;
 		if ((ZFCP_STATUS_READS_RECOM - adapter->status_read_failed)
 		    < ZFCP_STATUS_READ_FAILED_THRESHOLD) {
-			ZFCP_LOG_INFO("restart adapter due to status read "
-				      "buffer shortage (busid %s)\n",
+			ZFCP_LOG_INFO("restart adapter %s due to status read "
+				      "buffer shortage\n",
 				      zfcp_get_busid_by_adapter(adapter));
 			zfcp_erp_adapter_reopen(adapter, 0);
 		}
@@ -1188,11 +1135,9 @@
 				     req_flags, adapter->pool.fsf_req_abort,
 				     &lock_flags, &fsf_req);
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "abort command request on the device with "
-			      "the FCP-LUN 0x%Lx connected to "
-			      "the port with WWPN 0x%Lx connected to "
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Failed to create an abort command "
+			      "request for lun 0x%016Lx on port 0x%016Lx "
+			      "on adapter %s.\n",
 			      unit->fcp_lun,
 			      unit->port->wwpn,
 			      zfcp_get_busid_by_adapter(adapter));
@@ -1218,9 +1163,8 @@
 	retval = zfcp_fsf_req_send(fsf_req, NULL);
 	if (retval) {
 		del_timer(&adapter->scsi_er_timer);
-		ZFCP_LOG_INFO("error: Could not send an abort command request "
-			      "for a command on the adapter %s, "
-			      "port WWPN 0x%Lx and unit LUN 0x%Lx\n",
+		ZFCP_LOG_INFO("error: Failed to send abort command request "
+			      "on adapter %s, port 0x%016Lx, unit 0x%016Lx\n",
 			      zfcp_get_busid_by_adapter(adapter),
 			      unit->port->wwpn, unit->fcp_lun);
 		zfcp_fsf_req_free(fsf_req);
@@ -1229,10 +1173,10 @@
 	}
 
 	ZFCP_LOG_DEBUG("Abort FCP Command request initiated "
-		       "(adapter busid=%s, port d_id=0x%x, "
-		       "unit fcp_lun=0x%Lx, old_req_id=0x%lx)\n",
+		       "(adapter%s, port d_id=0x%08x, "
+		       "unit x%016Lx, old_req_id=0x%lx)\n",
 		       zfcp_get_busid_by_adapter(adapter),
-		       (unsigned int) unit->port->d_id,
+		       unit->port->d_id,
 		       unit->fcp_lun, old_req_id);
  out:
 	write_unlock_irqrestore(&adapter->request_queue.queue_lock, lock_flags);
@@ -1276,10 +1220,9 @@
 			 */
 		} else {
 			ZFCP_LOG_FLAGS(1, "FSF_PORT_HANDLE_NOT_VALID\n");
-			ZFCP_LOG_INFO("Temporary port identifier (handle) 0x%x "
-				      "for the port with WWPN 0x%Lx connected "
-				      "to the adapter %s is not valid. This "
-				      "may happen occasionally.\n",
+			ZFCP_LOG_INFO("Temporary port identifier 0x%x for "
+				      "port 0x%016Lx on adapter %s invalid. "
+				      "This may happen occasionally.\n",
 				      unit->port->handle,
 				      unit->port->wwpn,
 				      zfcp_get_busid_by_unit(unit));
@@ -1310,11 +1253,9 @@
 		} else {
 			ZFCP_LOG_FLAGS(1, "FSF_LUN_HANDLE_NOT_VALID\n");
 			ZFCP_LOG_INFO
-			    ("Warning: Temporary LUN identifier (handle) 0x%x "
-			     "of the logical unit with FCP-LUN 0x%Lx at "
-			     "the remote port with WWPN 0x%Lx connected "
-			     "to the adapter %s is "
-			     "not valid. This may happen in rare cases."
+			    ("Warning: Temporary LUN identifier 0x%x of LUN "
+			     "0x%016Lx on port 0x%016Lx on adapter %s is "
+			     "invalid. This may happen in rare cases. "
 			     "Trying to re-establish link.\n",
 			     unit->handle,
 			     unit->fcp_lun,
@@ -1348,10 +1289,9 @@
 	case FSF_PORT_BOXED:
 		/* 2 */
 		ZFCP_LOG_FLAGS(0, "FSF_PORT_BOXED\n");
-		ZFCP_LOG_DEBUG("The remote port "
-			       "with WWPN 0x%Lx on the adapter %s "
-			       "needs to be reopened\n",
-			       unit->port->wwpn, zfcp_get_busid_by_unit(unit));
+		ZFCP_LOG_INFO("Remote port 0x%016Lx on adapter %s needs to "
+			      "be reopened\n", unit->port->wwpn,
+			      zfcp_get_busid_by_unit(unit));
 		debug_text_event(new_fsf_req->adapter->erp_dbf, 2,
 				 "fsf_s_pboxed");
 		zfcp_erp_port_reopen(unit->port, 0);
@@ -1465,8 +1405,8 @@
 				  ZFCP_WAIT_FOR_SBAL | ZFCP_REQ_AUTO_CLEANUP,
 				  pool, &lock_flags, &fsf_req);
 	if (ret < 0) {
-                ZFCP_LOG_INFO("error: out of memory. Could not create CT "
-			      "request (FC-GS). (adapter: %s)\n",
+                ZFCP_LOG_INFO("error: Could not create CT request (FC-GS) for "
+			      "adapter: %s\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		goto failed_req;
 	}
@@ -1495,9 +1435,8 @@
                                                 ct->req, ct->req_count,
                                                 ZFCP_MAX_SBALS_PER_CT_REQ);
                 if (bytes <= 0) {
-                        ZFCP_LOG_INFO("error: out of resources (outbuf). "
-                                      "Could not create CT request (FC-GS). "
-				      "(adapter: %s)\n",
+                        ZFCP_LOG_INFO("error: creation of CT request failed "
+				      "on adapter %s\n",
 				      zfcp_get_busid_by_adapter(adapter));
                         if (bytes == 0)
                                 ret = -ENOMEM;
@@ -1513,9 +1452,8 @@
                                                 ct->resp, ct->resp_count,
                                                 ZFCP_MAX_SBALS_PER_CT_REQ);
                 if (bytes <= 0) {
-                        ZFCP_LOG_INFO("error: out of resources (inbuf). "
-                                      "Could not create a CT request (FC-GS). "
-				      "(adapter: %s)\n",
+                        ZFCP_LOG_INFO("error: creation of CT request failed "
+				      "on adapter %s\n",
 				      zfcp_get_busid_by_adapter(adapter));
                         if (bytes == 0)
                                 ret = -ENOMEM;
@@ -1528,8 +1466,8 @@
         } else {
                 /* reject send generic request */
 		ZFCP_LOG_INFO(
-			"error: microcode does not support chained SBALs."
-                        "CT request (FC-GS) too big. (adapter: %s)\n",
+			"error: microcode does not support chained SBALs,"
+                        "CT request too big (adapter %s)\n",
 			zfcp_get_busid_by_adapter(adapter));
                 ret = -EOPNOTSUPP;
                 goto failed_send;
@@ -1544,14 +1482,13 @@
 	/* start QDIO request for this FSF request */
 	ret = zfcp_fsf_req_send(fsf_req, ct->timer);
 	if (ret) {
-		ZFCP_LOG_DEBUG("error: out of resources. Could not send CT "
-			       "request (FC-GS). (adapter: %s, "
-			       "port WWPN 0x%Lx)\n",
+		ZFCP_LOG_DEBUG("error: initiation of CT request failed "
+			       "(adapter %s, port 0x%016Lx)\n",
 			       zfcp_get_busid_by_adapter(adapter), port->wwpn);
 		goto failed_send;
 	}
 
-	ZFCP_LOG_DEBUG("CT request initiated. (adapter: %s, port WWPN 0x%Lx)\n",
+	ZFCP_LOG_DEBUG("CT request initiated (adapter %s, port 0x%016Lx)\n",
 		       zfcp_get_busid_by_adapter(adapter), port->wwpn);
 	goto out;
 
@@ -1609,15 +1546,15 @@
         case FSF_SERVICE_CLASS_NOT_SUPPORTED :
 		ZFCP_LOG_FLAGS(2, "FSF_SERVICE_CLASS_NOT_SUPPORTED\n");
 		if (adapter->fc_service_class <= 3) {
-			ZFCP_LOG_INFO("error: The adapter %s does "
-					"not support fibre-channel class %d.\n",
-					zfcp_get_busid_by_port(port),
+			ZFCP_LOG_INFO("error: adapter %s does not support fc "
+				      "class %d.\n",
+				      zfcp_get_busid_by_port(port),
 				      adapter->fc_service_class);
 		} else {
 			ZFCP_LOG_INFO("bug: The fibre channel class at the "
 				      "adapter %s is invalid. "
 				      "(debug info %d)\n",
-			     zfcp_get_busid_by_port(port),
+				      zfcp_get_busid_by_port(port),
 				      adapter->fc_service_class);
 		}
 		/* stop operation for this adapter */
@@ -1653,8 +1590,7 @@
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
 		ZFCP_LOG_NORMAL("Access denied, cannot send generic command "
-				"to a port with WWPN 0x%Lx connected "
-				"to the adapter %s\n", port->wwpn,
+				"to port 0x%016Lx on adapter %s\n", port->wwpn,
 				zfcp_get_busid_by_port(port));
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
@@ -1675,8 +1611,7 @@
 
         case FSF_GENERIC_COMMAND_REJECTED :
 		ZFCP_LOG_FLAGS(2, "FSF_GENERIC_COMMAND_REJECTED\n");
-		ZFCP_LOG_INFO("warning: The port with WWPN 0x%Lx connected to "
-			      "the adapter %s has "
+		ZFCP_LOG_INFO("warning: The port 0x%016Lx on adapter %s has "
 			      "rejected a generic services command.\n",
 			      port->wwpn, zfcp_get_busid_by_port(port));
 		ZFCP_LOG_INFO("status qualifier:\n");
@@ -1689,11 +1624,9 @@
 
         case FSF_PORT_HANDLE_NOT_VALID :
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_HANDLE_NOT_VALID\n");
-		ZFCP_LOG_DEBUG("Temporary port identifier (handle) 0x%x "
-			       "for the port with WWPN 0x%Lx connected to "
-			       "the adapter %s is "
-			       "not valid. This may happen occasionally.\n",
-			       port->handle,
+		ZFCP_LOG_DEBUG("Temporary port identifier 0x%x for port "
+			       "0x%016Lx on adapter %s invalid. This may "
+			       "happen occasionally.\n", port->handle,
 			       port->wwpn, zfcp_get_busid_by_port(port));
 		ZFCP_LOG_INFO("status qualifier:\n");
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_INFO,
@@ -1706,8 +1639,7 @@
 
 	case FSF_REQUEST_BUF_NOT_VALID :
 		ZFCP_LOG_FLAGS(2, "FSF_REQUEST_BUF_NOT_VALID\n");
-		ZFCP_LOG_NORMAL("error: The port with WWPN 0x%Lx connected to "
-				"the adapter %s has "
+		ZFCP_LOG_NORMAL("error: The port 0x%016Lx on adapter %s has "
 				"rejected a generic services command "
 				"due to invalid request buffer.\n",
 				port->wwpn, zfcp_get_busid_by_port(port));
@@ -1717,8 +1649,7 @@
 
 	case FSF_RESPONSE_BUF_NOT_VALID :
 		ZFCP_LOG_FLAGS(2, "FSF_RESPONSE_BUF_NOT_VALID\n");
-		ZFCP_LOG_NORMAL("error: The port with WWPN 0x%Lx connected to "
-				"the adapter %s has "
+		ZFCP_LOG_NORMAL("error: The port 0x%016Lx on adapter %s has "
 				"rejected a generic services command "
 				"due to invalid response buffer.\n",
 				port->wwpn, zfcp_get_busid_by_port(port));
@@ -1728,8 +1659,7 @@
 
         case FSF_PORT_BOXED :
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_BOXED\n");
-		ZFCP_LOG_DEBUG("The remote port "
-			       "with WWPN 0x%Lx on the adapter %s "
+		ZFCP_LOG_INFO("The remote port 0x%016Lx on adapter %s "
 			       "needs to be reopened\n",
 			       port->wwpn, zfcp_get_busid_by_port(port));
 		debug_text_event(adapter->erp_dbf, 2, "fsf_s_pboxed");
@@ -1778,8 +1708,8 @@
 				  ZFCP_WAIT_FOR_SBAL|ZFCP_REQ_AUTO_CLEANUP,
 				  NULL, &lock_flags, &fsf_req);
 	if (ret < 0) {
-                ZFCP_LOG_INFO("error: out of memory. Could not create ELS "
-			      "request. (adapter: %s, port did: 0x%06x)\n",
+                ZFCP_LOG_INFO("error: creation of ELS request failed "
+			      "(adapter %s, port d_id: 0x%08x)\n",
                               zfcp_get_busid_by_adapter(adapter), port->d_id);
                 goto failed_req;
 	}
@@ -1803,9 +1733,8 @@
                                                 els->req, els->req_count,
                                                 ZFCP_MAX_SBALS_PER_ELS_REQ);
                 if (bytes <= 0) {
-                        ZFCP_LOG_INFO("error: out of resources (outbuf). "
-                                      "Could not create ELS request. "
-				      "(adapter: %s, port did: 0x%06x)\n",
+                        ZFCP_LOG_INFO("error: creation of ELS request failed "
+				      "(adapter %s, port d_id: 0x%08x)\n",
 				      zfcp_get_busid_by_adapter(adapter),
 				      port->d_id);
                         if (bytes == 0) {
@@ -1822,9 +1751,8 @@
                                                 els->resp, els->resp_count,
                                                 ZFCP_MAX_SBALS_PER_ELS_REQ);
                 if (bytes <= 0) {
-                        ZFCP_LOG_INFO("error: out of resources (inbuf). "
-                                      "Could not create ELS request. "
-				      "(adapter: %s, port did: 0x%06x)\n",
+                        ZFCP_LOG_INFO("error: creation of ELS request failed "
+				      "(adapter %s, port d_id: 0x%08x)\n",
 				      zfcp_get_busid_by_adapter(adapter),
 				      port->d_id);
                         if (bytes == 0) {
@@ -1837,9 +1765,9 @@
                 fsf_req->qtcb->bottom.support.resp_buf_length = bytes;
         } else {
                 /* reject request */
-		ZFCP_LOG_INFO("error: microcode does not support chained SBALs."
-                              "ELS request too big. "
-			      "(adapter: %s, port did: 0x%06x)\n",
+		ZFCP_LOG_INFO("error: microcode does not support chained SBALs"
+                              ", ELS request too big (adapter %s, "
+			      "port d_id: 0x%08x)\n",
 			      zfcp_get_busid_by_adapter(adapter), port->d_id);
                 ret = -EOPNOTSUPP;
                 goto failed_send;
@@ -1856,13 +1784,13 @@
 	/* start QDIO request for this FSF request */
 	ret = zfcp_fsf_req_send(fsf_req, NULL);
 	if (ret) {
-		ZFCP_LOG_DEBUG("error: out of resources. Could not send ELS "
-                               "request. (adapter: %s, port WWPN 0x%Lx)\n",
+		ZFCP_LOG_DEBUG("error: initiation of ELS request failed "
+			       "(adapter %s, port 0x%016Lx)\n",
 			       zfcp_get_busid_by_adapter(adapter), port->wwpn);
 		goto failed_send;
 	}
 
-	ZFCP_LOG_DEBUG("ELS request initiated (adapter: %s, port WWPN 0x%Lx)\n",
+	ZFCP_LOG_DEBUG("ELS request initiated (adapter %s, port 0x%016Lx)\n",
 		       zfcp_get_busid_by_adapter(adapter), port->wwpn);
 	goto out;
 
@@ -1915,12 +1843,12 @@
 	case FSF_SERVICE_CLASS_NOT_SUPPORTED:
 		ZFCP_LOG_FLAGS(2, "FSF_SERVICE_CLASS_NOT_SUPPORTED\n");
 		if (adapter->fc_service_class <= 3) {
-			ZFCP_LOG_INFO("error: The adapter %s does "
-				      "not support fibre-channel class %d.\n",
+			ZFCP_LOG_INFO("error: adapter %s does "
+				      "not support fibrechannel class %d.\n",
 				      zfcp_get_busid_by_port(port),
 				      adapter->fc_service_class);
 		} else {
-			ZFCP_LOG_INFO("bug: The fibre channel class at the "
+			ZFCP_LOG_INFO("bug: The fibrechannel class at "
 				      "adapter %s is invalid. "
 				      "(debug info %d)\n",
 				      zfcp_get_busid_by_port(port),
@@ -1964,9 +1892,8 @@
 
 	case FSF_ELS_COMMAND_REJECTED:
 		ZFCP_LOG_FLAGS(2, "FSF_ELS_COMMAND_REJECTED\n");
-		ZFCP_LOG_INFO("The ELS command has been rejected because "
-			      "a command filter in the FCP channel prohibited "
-			      "sending of the ELS to the SAN "
+		ZFCP_LOG_INFO("ELS has been rejected because command filter "
+			      "prohibited sending "
 			      "(adapter: %s, wwpn=0x%016Lx)\n",
 			      zfcp_get_busid_by_port(port), port->wwpn);
 
@@ -2084,9 +2011,8 @@
 				     erp_action->adapter->pool.fsf_req_erp,
 				     &lock_flags, &(erp_action->fsf_req));
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "exchange configuration data request for"
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Could not create exchange configuration "
+			      "data request for adapter %s.\n",
 			      zfcp_get_busid_by_adapter(erp_action->adapter));
 		goto out;
 	}
@@ -2098,14 +2024,13 @@
 
 	erp_action->fsf_req->erp_action = erp_action;
 	erp_action->fsf_req->qtcb->bottom.config.feature_selection =
-		FSF_FEATURE_CFDC |
-		FSF_FEATURE_LOST_SAN_NOTIFICATION;
+		FSF_FEATURE_CFDC;
 
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
 	if (retval) {
 		ZFCP_LOG_INFO
-		    ("error: Could not send an exchange configuration data "
+		    ("error: Could not send exchange configuration data "
 		     "command on the adapter %s\n",
 		     zfcp_get_busid_by_adapter(erp_action->adapter));
 		zfcp_fsf_req_free(erp_action->fsf_req);
@@ -2113,8 +2038,8 @@
 		goto out;
 	}
 
-	ZFCP_LOG_DEBUG("Exchange Configuration Data request initiated "
-		       "(adapter busid=%s)\n",
+	ZFCP_LOG_DEBUG("exchange configuration data request initiated "
+		       "(adapter %s)\n",
 		       zfcp_get_busid_by_adapter(erp_action->adapter));
 
  out:
@@ -2228,10 +2153,9 @@
 		switch (adapter->fc_topology) {
 		case FSF_TOPO_P2P:
 			ZFCP_LOG_FLAGS(1, "FSF_TOPO_P2P\n");
-			ZFCP_LOG_NORMAL("error: Point-to-point fibre-channel "
-					"configuration detected "
-					"at the adapter %s, not "
-					"supported, shutting down adapter\n",
+			ZFCP_LOG_NORMAL("error: Point-to-point fibrechannel "
+					"configuration detected at adapter %s "
+					"unsupported, shutting down adapter\n",
 					zfcp_get_busid_by_adapter(adapter));
 			debug_text_event(fsf_req->adapter->erp_dbf, 0,
 					 "top-p-to-p");
@@ -2239,10 +2163,9 @@
 			return -EIO;
 		case FSF_TOPO_AL:
 			ZFCP_LOG_FLAGS(1, "FSF_TOPO_AL\n");
-			ZFCP_LOG_NORMAL("error: Arbitrated loop fibre-channel "
-					"topology detected "
-					"at the adapter %s, not "
-					"supported, shutting down adapter\n",
+			ZFCP_LOG_NORMAL("error: Arbitrated loop fibrechannel "
+					"topology detected at adapter %s "
+					"unsupported, shutting down adapter\n",
 					zfcp_get_busid_by_adapter(adapter));
 			debug_text_event(fsf_req->adapter->erp_dbf, 0,
 					 "top-al");
@@ -2250,13 +2173,12 @@
 			return -EIO;
 		case FSF_TOPO_FABRIC:
 			ZFCP_LOG_FLAGS(1, "FSF_TOPO_FABRIC\n");
-			ZFCP_LOG_INFO("Switched fabric fibre-channel "
-				      "network detected "
-				      "at the adapter %s.\n",
+			ZFCP_LOG_INFO("Switched fabric fibrechannel "
+				      "network detected at adapter %s.\n",
 				      zfcp_get_busid_by_adapter(adapter));
 			break;
 		default:
-			ZFCP_LOG_NORMAL("bug: The fibre-channel topology "
+			ZFCP_LOG_NORMAL("bug: The fibrechannel topology "
 					"reported by the exchange "
 					"configuration command for "
 					"the adapter %s is not "
@@ -2332,10 +2254,8 @@
 				     erp_action->adapter->pool.fsf_req_erp,
 				     &lock_flags, &(erp_action->fsf_req));
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "open port request for "
-			      "the port with WWPN 0x%Lx connected to "
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Could not create open port request "
+			      "for port 0x%016Lx on adapter %s.\n",
 			      erp_action->port->wwpn,
 			      zfcp_get_busid_by_adapter(erp_action->adapter));
 		goto out;
@@ -2354,10 +2274,8 @@
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
 	if (retval) {
-		ZFCP_LOG_INFO("error: Could not send an "
-			      "open port request for "
-			      "the port with WWPN 0x%Lx connected to "
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Could not send open port request for "
+			      "port 0x%016Lx on adapter %s.\n",
 			      erp_action->port->wwpn,
 			      zfcp_get_busid_by_adapter(erp_action->adapter));
 		zfcp_fsf_req_free(erp_action->fsf_req);
@@ -2365,8 +2283,8 @@
 		goto out;
 	}
 
-	ZFCP_LOG_DEBUG("Open Port request initiated "
-		       "(adapter busid=%s, port wwpn=0x%Lx)\n",
+	ZFCP_LOG_DEBUG("open port request initiated "
+		       "(adapter %s,  port 0x%016Lx)\n",
 		       zfcp_get_busid_by_adapter(erp_action->adapter),
 		       erp_action->port->wwpn);
  out:
@@ -2404,8 +2322,7 @@
 
 	case FSF_PORT_ALREADY_OPEN:
 		ZFCP_LOG_FLAGS(0, "FSF_PORT_ALREADY_OPEN\n");
-		ZFCP_LOG_NORMAL("bug: The remote port with WWPN=0x%Lx "
-				"connected to the adapter %s "
+		ZFCP_LOG_NORMAL("bug: remote port 0x%016Lx on adapter %s "
 				"is already open.\n",
 				port->wwpn, zfcp_get_busid_by_port(port));
 		debug_text_exception(fsf_req->adapter->erp_dbf, 0,
@@ -2418,8 +2335,8 @@
 
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
-		ZFCP_LOG_NORMAL("Access denied, cannot open port "
-			"with WWPN 0x%Lx connected to the adapter %s\n",
+		ZFCP_LOG_NORMAL("Access denied, cannot open port 0x%016Lx "
+				"on adapter %s\n",
 			port->wwpn, zfcp_get_busid_by_port(port));
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
@@ -2442,8 +2359,7 @@
 	case FSF_MAXIMUM_NUMBER_OF_PORTS_EXCEEDED:
 		ZFCP_LOG_FLAGS(1, "FSF_MAXIMUM_NUMBER_OF_PORTS_EXCEEDED\n");
 		ZFCP_LOG_INFO("error: The FSF adapter is out of resources. "
-			      "The remote port with WWPN=0x%Lx "
-			      "connected to the adapter %s "
+			      "The remote port 0x%016Lx on adapter %s "
 			      "could not be opened. Disabling it.\n",
 			      port->wwpn, zfcp_get_busid_by_port(port));
 		debug_text_event(fsf_req->adapter->erp_dbf, 1,
@@ -2471,9 +2387,9 @@
 			break;
 		case FSF_SQ_NO_RETRY_POSSIBLE:
 			ZFCP_LOG_FLAGS(0, "FSF_SQ_NO_RETRY_POSSIBLE\n");
-			ZFCP_LOG_NORMAL("The remote port with WWPN=0x%Lx "
-					"connected to the adapter %s "
-					"could not be opened. Disabling it.\n",
+			ZFCP_LOG_NORMAL("The remote port 0x%016Lx on "
+					"adapter %s could not be opened. "
+					"Disabling it.\n",
 					port->wwpn,
 					zfcp_get_busid_by_port(port));
 			debug_text_exception(fsf_req->adapter->erp_dbf, 0,
@@ -2499,11 +2415,9 @@
 		ZFCP_LOG_FLAGS(3, "FSF_GOOD\n");
 		/* save port handle assigned by FSF */
 		port->handle = header->port_handle;
-		ZFCP_LOG_INFO("The remote port (WWPN=0x%Lx) via adapter "
-			      "(busid=%s) was opened, it's "
-			      "port handle is 0x%x\n",
-			      port->wwpn,
-			      zfcp_get_busid_by_port(port),
+		ZFCP_LOG_INFO("The remote port 0x%016Lx via adapter %s "
+			      "was opened, it's port handle is 0x%x\n",
+			      port->wwpn, zfcp_get_busid_by_port(port),
 			      port->handle);
 		/* mark port as open */
 		atomic_set_mask(ZFCP_STATUS_COMMON_OPEN |
@@ -2539,9 +2453,9 @@
 				/* skip sanity check and assume wwpn is ok */
 			} else {
 				if (plogi->serv_param.wwpn != port->wwpn) {
-					ZFCP_LOG_INFO("warning: D_ID of port "
-						      "with WWPN 0x%Lx changed "
-						      "during open\n", port->wwpn);
+					ZFCP_LOG_INFO("warning: d_id of port "
+						      "0x%016Lx changed during "
+						      "open\n", port->wwpn);
 					debug_text_event(
 						fsf_req->adapter->erp_dbf, 0,
 						"fsf_s_did_change:");
@@ -2591,9 +2505,8 @@
 				     erp_action->adapter->pool.fsf_req_erp,
 				     &lock_flags, &(erp_action->fsf_req));
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create a "
-			      "close port request for WWPN 0x%Lx connected to "
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Could not create a close port request "
+			      "for port 0x%016Lx on adapter %s.\n",
 			      erp_action->port->wwpn,
 			      zfcp_get_busid_by_adapter(erp_action->adapter));
 		goto out;
@@ -2613,9 +2526,8 @@
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
 	if (retval) {
-		ZFCP_LOG_INFO("error: Could not send a "
-			      "close port request for WWPN 0x%Lx connected to "
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Could not send a close port request for "
+			      "port 0x%016Lx on adapter %s.\n",
 			      erp_action->port->wwpn,
 			      zfcp_get_busid_by_adapter(erp_action->adapter));
 		zfcp_fsf_req_free(erp_action->fsf_req);
@@ -2623,8 +2535,8 @@
 		goto out;
 	}
 
-	ZFCP_LOG_TRACE("Close Port request initiated "
-		       "(adapter busid=%s, port wwpn=0x%Lx)\n",
+	ZFCP_LOG_TRACE("close port request initiated "
+		       "(adapter %s, port 0x%016Lx)\n",
 		       zfcp_get_busid_by_adapter(erp_action->adapter),
 		       erp_action->port->wwpn);
  out:
@@ -2658,11 +2570,9 @@
 
 	case FSF_PORT_HANDLE_NOT_VALID:
 		ZFCP_LOG_FLAGS(1, "FSF_PORT_HANDLE_NOT_VALID\n");
-		ZFCP_LOG_INFO("Temporary port identifier (handle) 0x%x "
-			      "for the port with WWPN 0x%Lx connected to "
-			      "the adapter %s is "
-			      "not valid. This may happen occasionally.\n",
-			      port->handle,
+		ZFCP_LOG_INFO("Temporary port identifier 0x%x for port "
+			      "0x%016Lx on adapter %s invalid. This may happen "
+			      "occasionally.\n", port->handle,
 			      port->wwpn, zfcp_get_busid_by_port(port));
 		ZFCP_LOG_DEBUG("status qualifier:\n");
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
@@ -2684,11 +2594,9 @@
 
 	case FSF_GOOD:
 		ZFCP_LOG_FLAGS(3, "FSF_GOOD\n");
-		ZFCP_LOG_TRACE("remote port (WWPN=0x%Lx) via adapter "
-			       "(busid=%s) closed, port handle 0x%x\n",
-			       port->wwpn,
-			       zfcp_get_busid_by_port(port),
-			       port->handle);
+		ZFCP_LOG_TRACE("remote port 0x016%Lx on adapter %s closed, "
+			       "port handle 0x%x\n", port->wwpn,
+			       zfcp_get_busid_by_port(port), port->handle);
 		zfcp_erp_modify_port_status(port,
 					    ZFCP_STATUS_COMMON_OPEN,
 					    ZFCP_CLEAR);
@@ -2732,12 +2640,11 @@
 				     erp_action->adapter->pool.fsf_req_erp,
 				     &lock_flags, &erp_action->fsf_req);
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create a "
-			      "close physical port request for "
-			      "the port with WWPN 0x%Lx connected to "
-			      "the adapter %s.\n",
-			      erp_action->port->wwpn,
-			      zfcp_get_busid_by_adapter(erp_action->adapter));
+		ZFCP_LOG_INFO("error: Could not create close physical port "
+			      "request (adapter %s, port 0x%016Lx)\n",
+			      zfcp_get_busid_by_adapter(erp_action->adapter),
+			      erp_action->port->wwpn);
+
 		goto out;
 	}
 
@@ -2754,18 +2661,17 @@
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
 	if (retval) {
-		ZFCP_LOG_INFO("error: Could not send an close physical port "
-			      "request for the port with WWPN 0x%Lx connected "
-			      "to the adapter %s.\n",
-			      erp_action->port->wwpn,
-			      zfcp_get_busid_by_adapter(erp_action->adapter));
+		ZFCP_LOG_INFO("error: Could not send close physical port "
+			      "request (adapter %s, port 0x%016Lx)\n",
+			      zfcp_get_busid_by_adapter(erp_action->adapter),
+			      erp_action->port->wwpn);
 		zfcp_fsf_req_free(erp_action->fsf_req);
 		erp_action->fsf_req = NULL;
 		goto out;
 	}
 
-	ZFCP_LOG_TRACE("Close Physical Port request initiated "
-		       "(adapter busid=%s, port wwpn=0x%Lx)\n",
+	ZFCP_LOG_TRACE("close physical port request initiated "
+		       "(adapter %s, port 0x%016Lx)\n",
 		       zfcp_get_busid_by_adapter(erp_action->adapter),
 		       erp_action->port->wwpn);
  out:
@@ -2803,13 +2709,12 @@
 
 	case FSF_PORT_HANDLE_NOT_VALID:
 		ZFCP_LOG_FLAGS(1, "FSF_PORT_HANDLE_NOT_VALID\n");
-		ZFCP_LOG_INFO("Temporary port identifier (handle) 0x%x "
-			      "for the port with WWPN 0x%Lx connected to "
-			      "the adapter %s is not valid. This may happen "
-			      "occasionally.\n",
+		ZFCP_LOG_INFO("Temporary port identifier 0x%x invalid"
+			      "(adapter %s, port 0x%016Lx). "
+			      "This may happen occasionally.\n",
 			      port->handle,
-			      port->wwpn,
-			      zfcp_get_busid_by_port(port));
+			      zfcp_get_busid_by_port(port),
+			      port->wwpn);
 		ZFCP_LOG_DEBUG("status qualifier:\n");
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
 			      (char *) &header->fsf_status_qual,
@@ -2823,8 +2728,8 @@
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
 		ZFCP_LOG_NORMAL("Access denied, cannot close "
-				"physical port with WWPN 0x%Lx connected to "
-				"the adapter %s\n", port->wwpn,
+				"physical port 0x%016Lx on "
+				"adapter %s\n", port->wwpn,
 				zfcp_get_busid_by_port(port));
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
@@ -2845,7 +2750,7 @@
 
 	case FSF_PORT_BOXED:
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_BOXED\n");
-		ZFCP_LOG_DEBUG("The remote port with WWPN 0x%Lx on the adapter "
+		ZFCP_LOG_DEBUG("The remote port 0x%016Lx on adapter "
 			       "%s needs to be reopened but it was attempted "
 			       "to close it physically.\n",
 			       port->wwpn,
@@ -2890,9 +2795,8 @@
 
 	case FSF_GOOD:
 		ZFCP_LOG_FLAGS(3, "FSF_GOOD\n");
-		ZFCP_LOG_DEBUG("Remote port (WWPN=0x%Lx) via adapter "
-			       "(busid=%s) physically closed, "
-			       "port handle 0x%x\n",
+		ZFCP_LOG_DEBUG("Remote port 0x%016Lx via adapter %s "
+			       "physically closed, port handle 0x%x\n",
 			       port->wwpn,
 			       zfcp_get_busid_by_port(port), port->handle);
 		/* can't use generic zfcp_erp_modify_port_status because
@@ -2945,10 +2849,8 @@
 				     erp_action->adapter->pool.fsf_req_erp,
 				     &lock_flags, &(erp_action->fsf_req));
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "open unit request for FCP-LUN 0x%Lx connected "
-			      "to the port with WWPN 0x%Lx connected to "
-			      "the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Could not create open unit request for "
+			      "unit 0x%016Lx on port 0x%016Lx on adapter %s.\n",
 			      erp_action->unit->fcp_lun,
 			      erp_action->unit->port->wwpn,
 			      zfcp_get_busid_by_adapter(erp_action->adapter));
@@ -2967,15 +2869,13 @@
 	atomic_set_mask(ZFCP_STATUS_COMMON_OPENING, &erp_action->unit->status);
 	erp_action->fsf_req->data.open_unit.unit = erp_action->unit;
 	erp_action->fsf_req->erp_action = erp_action;
-//	erp_action->fsf_req->qtcb->bottom.support.option =
-//		FSF_OPEN_LUN_UNSOLICITED_SENSE_DATA;
 
 	/* start QDIO request for this FSF request */
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
 	if (retval) {
 		ZFCP_LOG_INFO("error: Could not send an open unit request "
-			      "on the adapter %s, port WWPN 0x%Lx for "
-			      "unit LUN 0x%Lx\n",
+			      "on the adapter %s, port 0x%016Lx for "
+			      "unit 0x%016Lx\n",
 			      zfcp_get_busid_by_adapter(erp_action->adapter),
 			      erp_action->port->wwpn,
 			      erp_action->unit->fcp_lun);
@@ -2984,8 +2884,8 @@
 		goto out;
 	}
 
-	ZFCP_LOG_TRACE("Open LUN request initiated (adapter busid=%s, "
-		       "port wwpn=0x%Lx, unit fcp_lun=0x%Lx)\n",
+	ZFCP_LOG_TRACE("Open LUN request initiated (adapter %s, "
+		       "port 0x%016Lx, unit 0x%016Lx)\n",
 		       zfcp_get_busid_by_adapter(erp_action->adapter),
 		       erp_action->port->wwpn, erp_action->unit->fcp_lun);
  out:
@@ -3026,10 +2926,9 @@
 
 	case FSF_PORT_HANDLE_NOT_VALID:
 		ZFCP_LOG_FLAGS(1, "FSF_PORT_HANDLE_NOT_VALID\n");
-		ZFCP_LOG_INFO("Temporary port identifier (handle) 0x%x "
-			      "for the port with WWPN 0x%Lx connected to "
-			      "the adapter %s is "
-			      "not valid. This may happen occasionally.\n",
+		ZFCP_LOG_INFO("Temporary port identifier 0x%x "
+			      "for port 0x%016Lx on adapter %s invalid "
+			      "This may happen occasionally\n",
 			      unit->port->handle,
 			      unit->port->wwpn, zfcp_get_busid_by_unit(unit));
 		ZFCP_LOG_DEBUG("status qualifier:\n");
@@ -3043,10 +2942,8 @@
 
 	case FSF_LUN_ALREADY_OPEN:
 		ZFCP_LOG_FLAGS(0, "FSF_LUN_ALREADY_OPEN\n");
-		ZFCP_LOG_NORMAL("bug: Attempted to open the logical unit "
-				"with FCP-LUN 0x%Lx at "
-				"the remote port with WWPN 0x%Lx connected "
-				"to the adapter %s twice.\n",
+		ZFCP_LOG_NORMAL("bug: Attempted to open unit 0x%016Lx on "
+				"remote port 0x%016Lx on adapter %s twice.\n",
 				unit->fcp_lun,
 				unit->port->wwpn, zfcp_get_busid_by_unit(unit));
 		debug_text_exception(adapter->erp_dbf, 0,
@@ -3056,11 +2953,10 @@
 
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
-		ZFCP_LOG_NORMAL("Access denied, cannot open unit "
-				"with FCP-LUN 0x%Lx at the remote port with "
-				"WWPN 0x%Lx connected to the adapter %s\n",
-			unit->fcp_lun, unit->port->wwpn,
-			zfcp_get_busid_by_unit(unit));
+		ZFCP_LOG_NORMAL("Access denied, cannot open unit 0x%016Lx on "
+				"remote port 0x%016Lx on adapter %s\n",
+				unit->fcp_lun, unit->port->wwpn,
+				zfcp_get_busid_by_unit(unit));
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
 			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
@@ -3081,8 +2977,7 @@
 
 	case FSF_PORT_BOXED:
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_BOXED\n");
-		ZFCP_LOG_DEBUG("The remote port "
-			       "with WWPN 0x%Lx on the adapter %s "
+		ZFCP_LOG_DEBUG("The remote port 0x%016Lx on adapter %s "
 			       "needs to be reopened\n",
 			       unit->port->wwpn, zfcp_get_busid_by_unit(unit));
 		debug_text_event(adapter->erp_dbf, 2, "fsf_s_pboxed");
@@ -3093,16 +2988,18 @@
 
 	case FSF_LUN_SHARING_VIOLATION :
 		ZFCP_LOG_FLAGS(2, "FSF_LUN_SHARING_VIOLATION\n");
-		subtable = header->fsf_status_qual.halfword[4];
-		rule = header->fsf_status_qual.halfword[5];
-		if (rule == 0xFFFF) {
+		if (header->fsf_status_qual.word[0] != 0) {
 			ZFCP_LOG_NORMAL("FCP-LUN 0x%Lx at the remote port "
-					"with WWPN 0x%Lx connected to the "
-					"adapter %s is already in use\n",
+					"with WWPN 0x%Lx "
+					"connected to the adapter %s "
+					"is already in use in LPAR%d\n",
 					unit->fcp_lun,
 					unit->port->wwpn,
-					zfcp_get_busid_by_unit(unit));
+					zfcp_get_busid_by_unit(unit),
+					header->fsf_status_qual.fsf_queue_designator.hla);
 		} else {
+			subtable = header->fsf_status_qual.halfword[4];
+			rule = header->fsf_status_qual.halfword[5];
 			switch (subtable) {
 			case FSF_SQ_CFDC_SUBTABLE_OS:
 			case FSF_SQ_CFDC_SUBTABLE_PORT_WWPN:
@@ -3134,9 +3031,8 @@
 		ZFCP_LOG_FLAGS(1, "FSF_MAXIMUM_NUMBER_OF_LUNS_EXCEEDED\n");
 		ZFCP_LOG_INFO("error: The adapter ran out of resources. "
 			      "There is no handle (temporary port identifier) "
-			      "available for the unit with FCP-LUN 0x%Lx "
-			      "at the remote port with WWPN 0x%Lx connected "
-			      "to the adapter %s\n",
+			      "available for unit 0x%016Lx on port 0x%016Lx "
+			      "on adapter %s\n",
 			      unit->fcp_lun,
 			      unit->port->wwpn,
 			      zfcp_get_busid_by_unit(unit));
@@ -3193,18 +3089,14 @@
 		ZFCP_LOG_FLAGS(3, "FSF_GOOD\n");
 		/* save LUN handle assigned by FSF */
 		unit->handle = header->lun_handle;
-		ZFCP_LOG_TRACE("unit (FCP_LUN=0x%Lx) of remote port "
-			       "(WWPN=0x%Lx) via adapter (busid=%s) opened, "
-			       "port handle 0x%x, access flag 0x%02x\n",
+		ZFCP_LOG_TRACE("unit 0x%016Lx on remote port 0x%016Lx on "
+			       "adapter %s opened, port handle 0x%x\n",
 			       unit->fcp_lun,
 			       unit->port->wwpn,
 			       zfcp_get_busid_by_unit(unit),
-			       unit->handle,
-			       bottom->lun_access);
+			       unit->handle);
 		/* mark unit as open */
 		atomic_set_mask(ZFCP_STATUS_COMMON_OPEN, &unit->status);
-		if (adapter->supported_features & FSF_FEATURE_CFDC)
-			unit->lun_access = bottom->lun_access;
 		retval = 0;
 		break;
 
@@ -3250,10 +3142,8 @@
 				     erp_action->adapter->pool.fsf_req_erp,
 				     &lock_flags, &(erp_action->fsf_req));
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create a "
-			      "close unit request for FCP-LUN 0x%Lx "
-			      "connected to the port with WWPN 0x%Lx connected "
-			      "to the adapter %s.\n",
+		ZFCP_LOG_INFO("error: Could not create close unit request for "
+			      "unit 0x%016Lx on port 0x%016Lx on adapter %s.\n",
 			      erp_action->unit->fcp_lun,
 			      erp_action->port->wwpn,
 			      zfcp_get_busid_by_adapter(erp_action->adapter));
@@ -3276,8 +3166,7 @@
 	retval = zfcp_fsf_req_send(erp_action->fsf_req, &erp_action->timer);
 	if (retval) {
 		ZFCP_LOG_INFO("error: Could not send a close unit request for "
-			      "FCP-LUN 0x%Lx connected to the port with "
-			      "WWPN 0x%Lx connected to the adapter %s.\n",
+			      "unit 0x%016Lx on port 0x%016Lx onadapter %s.\n",
 			      erp_action->unit->fcp_lun,
 			      erp_action->port->wwpn,
 			      zfcp_get_busid_by_adapter(erp_action->adapter));
@@ -3286,8 +3175,8 @@
 		goto out;
 	}
 
-	ZFCP_LOG_TRACE("Close LUN request initiated (adapter busid=%s, "
-		       "port wwpn=0x%Lx, unit fcp_lun=0x%Lx)\n",
+	ZFCP_LOG_TRACE("Close LUN request initiated (adapter %s, "
+		       "port 0x%016Lx, unit 0x%016Lx)\n",
 		       zfcp_get_busid_by_adapter(erp_action->adapter),
 		       erp_action->port->wwpn, erp_action->unit->fcp_lun);
  out:
@@ -3321,9 +3210,8 @@
 
 	case FSF_PORT_HANDLE_NOT_VALID:
 		ZFCP_LOG_FLAGS(1, "FSF_PORT_HANDLE_NOT_VALID\n");
-		ZFCP_LOG_INFO("Temporary port identifier (handle) 0x%x "
-			      "for the port with WWPN 0x%Lx connected to "
-			      "the adapter %s is not valid. This may "
+		ZFCP_LOG_INFO("Temporary port identifier 0x%x for port "
+			      "0x%016Lx on adapter %s invalid. This may "
 			      "happen in rare circumstances\n",
 			      unit->port->handle,
 			      unit->port->wwpn,
@@ -3343,11 +3231,9 @@
 
 	case FSF_LUN_HANDLE_NOT_VALID:
 		ZFCP_LOG_FLAGS(1, "FSF_LUN_HANDLE_NOT_VALID\n");
-		ZFCP_LOG_INFO("Temporary LUN identifier (handle) 0x%x "
-			      "of the logical unit with FCP-LUN 0x%Lx at "
-			      "the remote port with WWPN 0x%Lx connected "
-			      "to the adapter %s is "
-			      "not valid. This may happen occasionally.\n",
+		ZFCP_LOG_INFO("Temporary LUN identifier 0x%x of unit "
+			      "0x%016Lx on port 0x%016Lx on adapter %s is "
+			      "invalid. This may happen occasionally.\n",
 			      unit->handle,
 			      unit->fcp_lun,
 			      unit->port->wwpn,
@@ -3367,8 +3253,7 @@
 
 	case FSF_PORT_BOXED:
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_BOXED\n");
-		ZFCP_LOG_DEBUG("The remote port "
-			       "with WWPN 0x%Lx on the adapter %s "
+		ZFCP_LOG_DEBUG("The remote port 0x%016Lx on adapter %s "
 			       "needs to be reopened\n",
 			       unit->port->wwpn,
 			       zfcp_get_busid_by_unit(unit));
@@ -3414,9 +3299,8 @@
 
 	case FSF_GOOD:
 		ZFCP_LOG_FLAGS(3, "FSF_GOOD\n");
-		ZFCP_LOG_TRACE("unit (FCP_LUN=0x%Lx) of remote port "
-			       "(WWPN=0x%Lx) via adapter (busid=%s) closed, "
-			       "port handle 0x%x \n",
+		ZFCP_LOG_TRACE("unit 0x%016Lx on port 0x%016Lx on adapter %s "
+			       "closed, port handle 0x%x\n",
 			       unit->fcp_lun,
 			       unit->port->wwpn,
 			       zfcp_get_busid_by_unit(unit),
@@ -3468,10 +3352,9 @@
 				     adapter->pool.fsf_req_scsi,
 				     &lock_flags, &fsf_req);
 	if (unlikely(retval < 0)) {
-		ZFCP_LOG_DEBUG("error: Out of resources. Could not create an "
-			       "FCP command request for FCP-LUN 0x%Lx "
-			       "connected to the port with WWPN 0x%Lx "
-			       "connected to the adapter %s.\n",
+		ZFCP_LOG_DEBUG("error: Could not create FCP command request "
+			       "for unit 0x%016Lx on port 0x%016Lx on "
+			       "adapter %s\n",
 			       unit->fcp_lun,
 			       unit->port->wwpn,
 			       zfcp_get_busid_by_adapter(adapter));
@@ -3496,8 +3379,7 @@
 
 	fsf_req->data.send_fcp_command_task.start_jiffies = jiffies;
 	fsf_req->data.send_fcp_command_task.unit = unit;
-	ZFCP_LOG_DEBUG("unit=0x%lx, unit_fcp_lun=0x%Lx\n",
-		       (unsigned long) unit, unit->fcp_lun);
+	ZFCP_LOG_DEBUG("unit=%p, fcp_lun=0x%016Lx\n", unit, unit->fcp_lun);
 
 	/* set handles of unit and its parent port in QTCB */
 	fsf_req->qtcb->header.lun_handle = unit->handle;
@@ -3592,9 +3474,9 @@
 		retval = -EIO;
 	} else {
 		ZFCP_LOG_NORMAL("error: No truncation implemented but "
-					"required. Shutting down unit "
-					"(busid=%s, WWPN=0x%16.16Lx, "
-					"FCP_LUN=0x%16.16Lx)\n",
+				"required. Shutting down unit "
+				"(adapter %s, port 0x%016Lx, "
+				"unit 0x%016Lx)\n",
 				zfcp_get_busid_by_unit(unit),
 				unit->port->wwpn,
 				unit->fcp_lun);
@@ -3617,17 +3499,16 @@
 	 */
 	retval = zfcp_fsf_req_send(fsf_req, NULL);
 	if (unlikely(retval < 0)) {
-		ZFCP_LOG_INFO("error: Could not send an FCP command request "
-			      "for a command on the adapter %s, "
-			      "port WWPN 0x%Lx and unit LUN 0x%Lx\n",
+		ZFCP_LOG_INFO("error: Could not send FCP command request "
+			      "on adapter %s, port 0x%016Lx, unit 0x%016Lx\n",
 			      zfcp_get_busid_by_adapter(adapter),
 			      unit->port->wwpn,
 			      unit->fcp_lun);
 		goto send_failed;
 	}
 
-	ZFCP_LOG_TRACE("Send FCP Command initiated (adapter busid=%s, "
-		       "port wwpn=0x%Lx, unit fcp_lun=0x%Lx)\n",
+	ZFCP_LOG_TRACE("Send FCP Command initiated (adapter %s, "
+		       "port 0x%016Lx, unit 0x%016Lx)\n",
 		       zfcp_get_busid_by_adapter(adapter),
 		       unit->port->wwpn,
 		       unit->fcp_lun);
@@ -3676,10 +3557,9 @@
 				     adapter->pool.fsf_req_scsi,
 				     &lock_flags, &fsf_req);
 	if (retval < 0) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "FCP command (task management) request for "
-			      "the adapter %s, port with "
-			      "WWPN 0x%Lx and FCP_LUN 0x%Lx.\n",
+		ZFCP_LOG_INFO("error: Could not create FCP command (task "
+			      "management) request for adapter %s, port "
+			      " 0x%016Lx, unit 0x%016Lx.\n",
 			      zfcp_get_busid_by_adapter(adapter),
 			      unit->port->wwpn, unit->fcp_lun);
 		goto out;
@@ -3722,8 +3602,8 @@
 	if (retval) {
 		del_timer(&adapter->scsi_er_timer);
 		ZFCP_LOG_INFO("error: Could not send an FCP-command (task "
-			      "management) on the adapter %s, port WWPN "
-			      "0x%Lx for unit LUN 0x%Lx\n",
+			      "management) on adapter %s, port 0x%016Lx for "
+			      "unit LUN 0x%016Lx\n",
 			      zfcp_get_busid_by_adapter(adapter),
 			      unit->port->wwpn,
 			      unit->fcp_lun);
@@ -3733,8 +3613,8 @@
 	}
 
 	ZFCP_LOG_TRACE("Send FCP Command (task management function) initiated "
-		       "(adapter busid=%s, port wwpn=0x%Lx, "
-		       "unit fcp_lun=0x%Lx, tm_flags=0x%x)\n",
+		       "(adapter %s, port 0x%016Lx, unit 0x%016Lx, "
+		       "tm_flags=0x%x)\n",
 		       zfcp_get_busid_by_adapter(adapter),
 		       unit->port->wwpn,
 		       unit->fcp_lun,
@@ -3776,9 +3656,8 @@
 
 	case FSF_PORT_HANDLE_NOT_VALID:
 		ZFCP_LOG_FLAGS(1, "FSF_PORT_HANDLE_NOT_VALID\n");
-		ZFCP_LOG_INFO("Temporary port identifier (handle) 0x%x "
-			      "for the port with WWPN 0x%Lx connected to "
-			      "the adapter %s is not valid.\n",
+		ZFCP_LOG_INFO("Temporary port identifier 0x%x for port "
+			      "0x%016Lx on adapter %s invalid\n",
 			      unit->port->handle,
 			      unit->port->wwpn, zfcp_get_busid_by_unit(unit));
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_DEBUG,
@@ -3792,11 +3671,9 @@
 
 	case FSF_LUN_HANDLE_NOT_VALID:
 		ZFCP_LOG_FLAGS(1, "FSF_LUN_HANDLE_NOT_VALID\n");
-		ZFCP_LOG_INFO("Temporary LUN identifier (handle) 0x%x "
-			      "of the logical unit with FCP-LUN 0x%Lx at "
-			      "the remote port with WWPN 0x%Lx connected "
-			      "to the adapter %s is "
-			      "not valid. This may happen occasionally.\n",
+		ZFCP_LOG_INFO("Temporary LUN identifier 0x%x for unit "
+			      "0x%016Lx on port 0x%016Lx on adapter %s is "
+			      "invalid. This may happen occasionally.\n",
 			      unit->handle,
 			      unit->fcp_lun,
 			      unit->port->wwpn,
@@ -3813,16 +3690,13 @@
 
 	case FSF_HANDLE_MISMATCH:
 		ZFCP_LOG_FLAGS(0, "FSF_HANDLE_MISMATCH\n");
-		ZFCP_LOG_NORMAL("bug: The port handle (temporary port "
-				"identifier) 0x%x has changed unexpectedly. "
-				"This was detected upon receiveing the "
-				"response of a command send to the unit with "
-				"FCP-LUN 0x%Lx at the remote port with WWPN "
-				"0x%Lx connected to the adapter %s.\n",
+		ZFCP_LOG_NORMAL("bug: The port handle 0x%x has changed "
+				"unexpectedly. (adapter %s, port 0x%016Lx, "
+				"unit 0x%016Lx)\n",
 				unit->port->handle,
-				unit->fcp_lun,
+				zfcp_get_busid_by_unit(unit),
 				unit->port->wwpn,
-				zfcp_get_busid_by_unit(unit));
+				unit->fcp_lun);
 		ZFCP_LOG_NORMAL("status qualifier:\n");
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
 			      (char *) &header->fsf_status_qual,
@@ -3841,11 +3715,11 @@
 		ZFCP_LOG_FLAGS(0, "FSF_SERVICE_CLASS_NOT_SUPPORTED\n");
 		if (fsf_req->adapter->fc_service_class <= 3) {
 			ZFCP_LOG_NORMAL("error: The adapter %s does "
-					"not support fibre-channel class %d.\n",
+					"not support fibrechannel class %d.\n",
 					zfcp_get_busid_by_unit(unit),
 					fsf_req->adapter->fc_service_class);
 		} else {
-			ZFCP_LOG_NORMAL("bug: The fibre channel class at the "
+			ZFCP_LOG_NORMAL("bug: The fibrechannel class at "
 					"adapter %s is invalid. "
 					"(debug info %d)\n",
 					zfcp_get_busid_by_unit(unit),
@@ -3864,10 +3738,9 @@
 
 	case FSF_FCPLUN_NOT_VALID:
 		ZFCP_LOG_FLAGS(0, "FSF_FCPLUN_NOT_VALID\n");
-		ZFCP_LOG_NORMAL("bug: The FCP LUN 0x%Lx behind the remote port "
-				"of WWPN0x%Lx via the adapter %s does not have "
-				"the correct unit handle (temporary unit "
-				"identifier) 0x%x\n",
+		ZFCP_LOG_NORMAL("bug: unit 0x%016Lx on port 0x%016Lx on "
+				"adapter %s does not have correct unit "
+				"handle 0x%x\n",
 				unit->fcp_lun,
 				unit->port->wwpn,
 				zfcp_get_busid_by_unit(unit),
@@ -3888,11 +3761,10 @@
 
 	case FSF_ACCESS_DENIED:
 		ZFCP_LOG_FLAGS(2, "FSF_ACCESS_DENIED\n");
-		ZFCP_LOG_NORMAL("Access denied, cannot send FCP "
-				"command to the unit with FCP-LUN 0x%Lx at the "
-				"remote port with WWPN 0x%Lx connected to the "
+		ZFCP_LOG_NORMAL("Access denied, cannot send FCP command to "
+				"unit 0x%016Lx on port 0x%016Lx on "
 				"adapter %s\n",	unit->fcp_lun, unit->port->wwpn,
-			zfcp_get_busid_by_unit(unit));
+				zfcp_get_busid_by_unit(unit));
 		for (counter = 0; counter < 2; counter++) {
 			subtable = header->fsf_status_qual.halfword[counter * 2];
 			rule = header->fsf_status_qual.halfword[counter * 2 + 1];
@@ -3912,9 +3784,8 @@
 
 	case FSF_DIRECTION_INDICATOR_NOT_VALID:
 		ZFCP_LOG_FLAGS(0, "FSF_DIRECTION_INDICATOR_NOT_VALID\n");
-		ZFCP_LOG_INFO("bug: Invalid data direction given for the unit "
-			      "with FCP LUN 0x%Lx at the remote port with "
-			      "WWPN 0x%Lx via the adapter %s "
+		ZFCP_LOG_INFO("bug: Invalid data direction given for unit "
+			      "0x%016Lx on port 0x%016Lx on adapter %s "
 			      "(debug info %d)\n",
 			      unit->fcp_lun,
 			      unit->port->wwpn,
@@ -3935,9 +3806,8 @@
 	case FSF_INBOUND_DATA_LENGTH_NOT_VALID:
 		ZFCP_LOG_FLAGS(0, "FSF_INBOUND_DATA_LENGTH_NOT_VALID\n");
 		ZFCP_LOG_NORMAL("bug: An invalid inbound data length field "
-				"was found in a command for the unit with "
-				"FCP LUN 0x%Lx of the remote port "
-				"with WWPN 0x%Lx via the adapter %s.\n",
+				"was found in a command for unit 0x%016Lx "
+				"on port 0x%016Lx on adapter %s.\n",
 				unit->fcp_lun,
 				unit->port->wwpn, zfcp_get_busid_by_unit(unit));
 		/* stop operation for this adapter */
@@ -3955,9 +3825,8 @@
 	case FSF_OUTBOUND_DATA_LENGTH_NOT_VALID:
 		ZFCP_LOG_FLAGS(0, "FSF_OUTBOUND_DATA_LENGTH_NOT_VALID\n");
 		ZFCP_LOG_NORMAL("bug: An invalid outbound data length field "
-				"was found in a command for the unit with "
-				"FCP LUN 0x%Lx of the remote port "
-				"with WWPN 0x%Lx via the adapter %s\n.",
+				"was found in a command unit 0x%016Lx on port "
+				"0x%016Lx on adapter %s\n",
 				unit->fcp_lun,
 				unit->port->wwpn,
 				zfcp_get_busid_by_unit(unit));
@@ -3975,9 +3844,8 @@
 		ZFCP_LOG_FLAGS(0, "FSF_CMND_LENGTH_NOT_VALID\n");
 		ZFCP_LOG_NORMAL
 		    ("bug: An invalid control-data-block length field "
-		     "was found in a command for the unit with "
-		     "FCP LUN 0x%Lx of the remote port "
-		     "with WWPN 0x%Lx via the adapter %s " "(debug info %d)\n",
+		     "was found in a command for unit 0x%016Lx on port "
+		     "0x%016Lx on adapter %s " "(debug info %d)\n",
 		     unit->fcp_lun, unit->port->wwpn,
 		     zfcp_get_busid_by_unit(unit),
 		     fsf_req->qtcb->bottom.io.fcp_cmnd_length);
@@ -3994,8 +3862,7 @@
 
 	case FSF_PORT_BOXED:
 		ZFCP_LOG_FLAGS(2, "FSF_PORT_BOXED\n");
-		ZFCP_LOG_DEBUG("The remote port "
-			       "with WWPN 0x%Lx on the adapter %s "
+		ZFCP_LOG_DEBUG("The remote port 0x%016Lx on adapter %s "
 			       "needs to be reopened\n",
 			       unit->port->wwpn, zfcp_get_busid_by_unit(unit));
 		debug_text_event(fsf_req->adapter->erp_dbf, 2, "fsf_s_pboxed");
@@ -4010,9 +3877,8 @@
 	case FSF_LUN_BOXED:
 		ZFCP_LOG_FLAGS(0, "FSF_LUN_BOXED\n");
 		ZFCP_LOG_NORMAL(
-			"The remote unit with FCP-LUN 0x%Lx "
-			"at the remote port with WWPN 0x%Lx "
-			"connected to the adapter %s needs to be reopened\n",
+			"unit 0x%016Lx on port 0x%016Lx on adapter %s needs "
+			"to be reopened\n",
 			unit->fcp_lun, unit->port->wwpn,
 			zfcp_get_busid_by_unit(unit));
 		debug_text_event(fsf_req->adapter->erp_dbf, 1, "fsf_s_lboxed");
@@ -4119,9 +3985,8 @@
 	scpnt = fsf_req->data.send_fcp_command_task.scsi_cmnd;
 	if (unlikely(!scpnt)) {
 		ZFCP_LOG_DEBUG
-		    ("Command with fsf_req 0x%lx is not associated to "
-		     "a scsi command anymore. Aborted?\n",
-		     (unsigned long) fsf_req);
+		    ("Command with fsf_req %p is not associated to "
+		     "a scsi command anymore. Aborted?\n", fsf_req);
 		goto out;
 	}
 	if (unlikely(fsf_req->status & ZFCP_STATUS_FSFREQ_ABORTED)) {
@@ -4179,12 +4044,10 @@
 			ZFCP_LOG_FLAGS(0, "RSP_CODE_LENGTH_MISMATCH\n");
 			/* hardware bug */
 			ZFCP_LOG_NORMAL("bug: FCP response code indictates "
-					" that the fibre-channel protocol data "
+					"that the fibrechannel protocol data "
 					"length differs from the burst length. "
-					"The problem occured on the unit "
-					"with FCP LUN 0x%Lx connected to the "
-					"port with WWPN 0x%Lx at the "
-					"adapter %s",
+					"The problem occured on unit 0x%016Lx "
+					"on port 0x%016Lx on adapter %s",
 					unit->fcp_lun,
 					unit->port->wwpn,
 					zfcp_get_busid_by_unit(unit));
@@ -4199,11 +4062,10 @@
 			ZFCP_LOG_FLAGS(0, "RSP_CODE_FIELD_INVALID\n");
 			/* driver or hardware bug */
 			ZFCP_LOG_NORMAL("bug: FCP response code indictates "
-					"that the fibre-channel protocol data "
-					"fields were incorrectly set-up. "
+					"that the fibrechannel protocol data "
+					"fields were incorrectly set up. "
 					"The problem occured on the unit "
-					"with FCP LUN 0x%Lx connected to the "
-					"port with WWPN 0x%Lx at the "
+					"0x%016Lx on port 0x%016Lx on "
 					"adapter %s",
 					unit->fcp_lun,
 					unit->port->wwpn,
@@ -4220,12 +4082,10 @@
 			/* hardware bug */
 			ZFCP_LOG_NORMAL("bug: The FCP response code indicates "
 					"that conflicting  values for the "
-					"fibre-channel payload offset from the "
+					"fibrechannel payload offset from the "
 					"header were found. "
-					"The problem occured on the unit "
-					"with FCP LUN 0x%Lx connected to the "
-					"port with WWPN 0x%Lx at the "
-					"adapter %s.\n",
+					"The problem occured on unit 0x%016Lx "
+					"on port 0x%016Lx on adapter %s.\n",
 					unit->fcp_lun,
 					unit->port->wwpn,
 					zfcp_get_busid_by_unit(unit));
@@ -4240,10 +4100,8 @@
 			ZFCP_LOG_NORMAL("bug: An invalid FCP response "
 					"code was detected for a command. "
 					"The problem occured on the unit "
-					"with FCP LUN 0x%Lx connected to the "
-					"port with WWPN 0x%Lx at the "
-					"adapter %s "
-					"(debug info 0x%x)\n",
+					"0x%016Lx on port 0x%016Lx on "
+					"adapter %s (debug info 0x%x)\n",
 					unit->fcp_lun,
 					unit->port->wwpn,
 					zfcp_get_busid_by_unit(unit),
@@ -4283,9 +4141,7 @@
 	/* check for overrun */
 	if (unlikely(fcp_rsp_iu->validity.bits.fcp_resid_over)) {
 		ZFCP_LOG_INFO("A data overrun was detected for a command. "
-			      "This happened for a command to the unit "
-			      "with FCP LUN 0x%Lx connected to the "
-			      "port with WWPN 0x%Lx at the adapter %s. "
+			      "unit 0x%016Lx, port 0x%016Lx, adapter %s. "
 			      "The response data length is "
 			      "%d, the original length was %d.\n",
 			      unit->fcp_lun,
@@ -4298,9 +4154,7 @@
 	/* check for underrun */
 	if (unlikely(fcp_rsp_iu->validity.bits.fcp_resid_under)) {
 		ZFCP_LOG_DEBUG("A data underrun was detected for a command. "
-			       "This happened for a command to the unit "
-			       "with FCP LUN 0x%Lx connected to the "
-			       "port with WWPN 0x%Lx at the adapter %s. "
+			       "unit 0x%016Lx, port 0x%016Lx, adapter %s. "
 			       "The response data length is "
 			       "%d, the original length was %d.\n",
 			       unit->fcp_lun,
@@ -4467,9 +4321,7 @@
 		ZFCP_LOG_FLAGS(0, "RSP_CODE_TASKMAN_UNSUPP\n");
 		ZFCP_LOG_NORMAL("bug: A reuested task management function "
 				"is not supported on the target device "
-				"The corresponding device is the unit with "
-				"FCP LUN 0x%Lx at the port "
-				"with WWPN 0x%Lx at the adapter %s\n ",
+				"unit 0x%016Lx, port 0x%016Lx, adapter %s\n ",
 				unit->fcp_lun,
 				unit->port->wwpn,
 				zfcp_get_busid_by_unit(unit));
@@ -4479,9 +4331,7 @@
 		ZFCP_LOG_FLAGS(0, "RSP_CODE_TASKMAN_FAILED\n");
 		ZFCP_LOG_NORMAL("bug: A reuested task management function "
 				"failed to complete successfully. "
-				"The corresponding device is the unit with "
-				"FCP LUN 0x%Lx at the port "
-				"with WWPN 0x%Lx at the adapter %s.\n",
+				"unit 0x%016Lx, port 0x%016Lx, adapter %s.\n",
 				unit->fcp_lun,
 				unit->port->wwpn,
 				zfcp_get_busid_by_unit(unit));
@@ -4490,9 +4340,7 @@
 	default:
 		ZFCP_LOG_NORMAL("bug: An invalid FCP response "
 				"code was detected for a command. "
-				"The problem occured on the unit "
-				"with FCP LUN 0x%Lx connected to the "
-				"port with WWPN 0x%Lx at the adapter %s "
+				"unit 0x%016Lx, port 0x%016Lx, adapter %s "
 				"(debug info 0x%x)\n",
 				unit->fcp_lun,
 				unit->port->wwpn,
@@ -4835,8 +4683,8 @@
 					   signal);
 		if (signal) {
 			ZFCP_LOG_DEBUG("Caught signal %i while waiting for the "
-				       "completion of the request at 0x%lx\n",
-				       signal, (unsigned long) fsf_req);
+				       "completion of the request at %p\n",
+				       signal, fsf_req);
 			retval = signal;
 			goto out;
 		}
@@ -5033,10 +4881,10 @@
 	if (likely(fsf_req->qtcb)) {
 		fsf_req->qtcb->prefix.req_seq_no = adapter->fsf_req_seq_no;
 		fsf_req->seq_no = adapter->fsf_req_seq_no;
-		ZFCP_LOG_TRACE("FSF request 0x%lx of adapter 0x%lx gets "
+		ZFCP_LOG_TRACE("FSF request %p of adapter %s gets "
 			       "FSF sequence counter value of %i\n",
-			       (unsigned long) fsf_req,
-			       (unsigned long) adapter,
+			       fsf_req,
+			       zfcp_get_busid_by_adapter(adapter),
 			       fsf_req->qtcb->prefix.req_seq_no);
 	} else
 		inc_seq_no = 0;
@@ -5052,18 +4900,18 @@
 		add_timer(timer);
 	}
 
-	ZFCP_LOG_TRACE("request queue of adapter with busid=%s: "
+	ZFCP_LOG_TRACE("request queue of adapter %s: "
 		       "next free SBAL is %i, %i free SBALs\n",
 		       zfcp_get_busid_by_adapter(adapter),
 		       req_queue->free_index,
 		       atomic_read(&req_queue->free_count));
 
-	ZFCP_LOG_DEBUG("Calling do QDIO busid=%s, flags=0x%x, queue_no=%i, "
-		       "index_in_queue=%i, count=%i, buffers=0x%lx\n",
+	ZFCP_LOG_DEBUG("calling do_QDIO adapter %s, flags=0x%x, queue_no=%i, "
+		       "index_in_queue=%i, count=%i, buffers=%p\n",
 		       zfcp_get_busid_by_adapter(adapter),
 		       QDIO_FLAG_SYNC_OUTPUT,
 		       0, fsf_req->sbal_first, fsf_req->sbal_number,
-		       (unsigned long) &req_queue->buffer[fsf_req->sbal_first]);
+		       &req_queue->buffer[fsf_req->sbal_first]);
 
 	/*
 	 * adjust the number of free SBALs in request queue as well as
@@ -5126,8 +4974,9 @@
 		if (likely(inc_seq_no)) {
 			adapter->fsf_req_seq_no++;
 			ZFCP_LOG_TRACE
-			    ("FSF sequence counter value of adapter 0x%lx "
-			     "increased to %i\n", (unsigned long) adapter,
+			    ("FSF sequence counter value of adapter %s "
+			     "increased to %i\n",
+			     zfcp_get_busid_by_adapter(adapter),
 			     adapter->fsf_req_seq_no);
 		}
 		/* count FSF requests pending */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.h linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.h	Thu Apr  8 15:21:28 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.h	Thu Apr  8 15:21:29 2004
@@ -196,23 +196,16 @@
 /* channel features */
 #define FSF_FEATURE_QTCB_SUPPRESSION            0x00000001
 #define FSF_FEATURE_CFDC			0x00000002
-#define FSF_FEATURE_LOST_SAN_NOTIFICATION       0x00000008
 #define FSF_FEATURE_HBAAPI_MANAGEMENT           0x00000010
 #define FSF_FEATURE_ELS_CT_CHAINED_SBALS        0x00000020
 
 /* option */
 #define FSF_OPEN_LUN_SUPPRESS_BOXING		0x00000001
-#define FSF_OPEN_LUN_UNSOLICITED_SENSE_DATA	0x00000002
 
 /* adapter types */
 #define FSF_ADAPTER_TYPE_FICON                  0x00000001
 #define FSF_ADAPTER_TYPE_FICON_EXPRESS          0x00000002
 
-/* flags */
-#define FSF_CFDC_OPEN_LUN_ALLOWED		0x01
-#define FSF_CFDC_EXCLUSIVE_ACCESS		0x02
-#define FSF_CFDC_OUTBOUND_TRANSFER_ALLOWED	0x10
-
 /* port types */
 #define FSF_HBA_PORTTYPE_UNKNOWN		0x00000001
 #define FSF_HBA_PORTTYPE_NOTPRESENT		0x00000003
@@ -328,18 +321,7 @@
 	u8  byte[FSF_STATUS_QUALIFIER_SIZE];
 	u16 halfword[FSF_STATUS_QUALIFIER_SIZE / sizeof (u16)];
 	u32 word[FSF_STATUS_QUALIFIER_SIZE / sizeof (u32)];
-	struct {
-		u32 this_cmd;
-		u32 aborted_cmd;
-	} port_handle;
-	struct {
-		u32 this_cmd;
-		u32 aborted_cmd;
-	} lun_handle;
-	struct {
-		u64 found;
-		u64 expected;
-	} fcp_lun;
+	struct fsf_queue_designator fsf_queue_designator;
 } __attribute__ ((packed));
 
 struct fsf_qtcb_header {
@@ -399,8 +381,7 @@
 	u32 service_class;
 	u8  res3[3];
 	u8  timeout;
-	u32 lun_access;
-	u8  res4[180];
+	u8  res4[184];
 	u32 els1_length;
 	u32 els2_length;
 	u32 req_buf_length;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_qdio.c linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c
--- linux-2.6/drivers/s390/scsi/zfcp_qdio.c	Thu Apr  8 15:21:28 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c	Thu Apr  8 15:21:29 2004
@@ -76,16 +76,15 @@
 	struct qdio_buffer *first_in_page = NULL;
 
 	qdio_buffers_per_page = PAGE_SIZE / sizeof (struct qdio_buffer);
-	ZFCP_LOG_TRACE("Buffers per page %d.\n", qdio_buffers_per_page);
+	ZFCP_LOG_TRACE("buffers_per_page=%d\n", qdio_buffers_per_page);
 
 	for (buf_pos = 0; buf_pos < count; buf_pos++) {
 		if (page_pos == 0) {
 			cur_buf[buf_pos] = (struct qdio_buffer *)
 			    get_zeroed_page(GFP_KERNEL);
 			if (cur_buf[buf_pos] == NULL) {
-				ZFCP_LOG_INFO("error: Could not allocate "
-					      "memory for qdio transfer "
-					      "structures.\n");
+				ZFCP_LOG_INFO("error: allocation of "
+					      "QDIO buffer failed \n");
 				goto out;
 			}
 			first_in_page = cur_buf[buf_pos];
@@ -115,7 +114,7 @@
 	int qdio_buffers_per_page;
 
 	qdio_buffers_per_page = PAGE_SIZE / sizeof (struct qdio_buffer);
-	ZFCP_LOG_TRACE("Buffers per page %d.\n", qdio_buffers_per_page);
+	ZFCP_LOG_TRACE("buffers_per_page=%d\n", qdio_buffers_per_page);
 
 	for (buf_pos = 0; buf_pos < count; buf_pos += qdio_buffers_per_page)
 		free_page((unsigned long) cur_buf[buf_pos]);
@@ -133,9 +132,8 @@
 	    zfcp_qdio_buffers_enqueue(&(adapter->request_queue.buffer[0]),
 				      QDIO_MAX_BUFFERS_PER_Q);
 	if (buffer_count < QDIO_MAX_BUFFERS_PER_Q) {
-		ZFCP_LOG_DEBUG("error: Out of memory allocating "
-			       "request queue, only %d buffers got. "
-			       "Binning them.\n", buffer_count);
+		ZFCP_LOG_DEBUG("only %d QDIO buffers allocated for request "
+			       "queue\n", buffer_count);
 		zfcp_qdio_buffers_dequeue(&(adapter->request_queue.buffer[0]),
 					  buffer_count);
 		retval = -ENOMEM;
@@ -146,12 +144,11 @@
 	    zfcp_qdio_buffers_enqueue(&(adapter->response_queue.buffer[0]),
 				      QDIO_MAX_BUFFERS_PER_Q);
 	if (buffer_count < QDIO_MAX_BUFFERS_PER_Q) {
-		ZFCP_LOG_DEBUG("error: Out of memory allocating "
-			       "response queue, only %d buffers got. "
-			       "Binning them.\n", buffer_count);
+		ZFCP_LOG_DEBUG("only %d QDIO buffers allocated for response "
+			       "queue", buffer_count);
 		zfcp_qdio_buffers_dequeue(&(adapter->response_queue.buffer[0]),
 					  buffer_count);
-		ZFCP_LOG_TRACE("Deallocating request_queue Buffers.\n");
+		ZFCP_LOG_TRACE("freeing request_queue buffers\n");
 		zfcp_qdio_buffers_dequeue(&(adapter->request_queue.buffer[0]),
 					  QDIO_MAX_BUFFERS_PER_Q);
 		retval = -ENOMEM;
@@ -165,11 +162,11 @@
 void
 zfcp_qdio_free_queues(struct zfcp_adapter *adapter)
 {
-	ZFCP_LOG_TRACE("Deallocating request_queue Buffers.\n");
+	ZFCP_LOG_TRACE("freeing request_queue buffers\n");
 	zfcp_qdio_buffers_dequeue(&(adapter->request_queue.buffer[0]),
 				  QDIO_MAX_BUFFERS_PER_Q);
 
-	ZFCP_LOG_TRACE("Deallocating response_queue Buffers.\n");
+	ZFCP_LOG_TRACE("freeing response_queue buffers\n");
 	zfcp_qdio_buffers_dequeue(&(adapter->response_queue.buffer[0]),
 				  QDIO_MAX_BUFFERS_PER_Q);
 }
@@ -237,8 +234,8 @@
 
 		ZFCP_LOG_FLAGS(1, "QDIO_STATUS_LOOK_FOR_ERROR \n");
 
-		ZFCP_LOG_INFO("A qdio problem occured. The status, qdio_error "
-			      "and siga_error are 0x%x, 0x%x and 0x%x\n",
+		ZFCP_LOG_INFO("QDIO problem occurred (status=0x%x, "
+			      "qdio_error=0x%x, siga_error=0x%x)\n",
 			      status, qdio_error, siga_error);
 
 		if (status & QDIO_STATUS_ACTIVATE_CHECK_CONDITION) {
@@ -273,8 +270,8 @@
 			ZFCP_LOG_FLAGS(1, "SLSB_P_OUTPUT_ERROR\n");
 			break;
 		default:
-			ZFCP_LOG_NORMAL("bug: Unknown qdio error reported "
-					"(debug info 0x%x)\n", qdio_error);
+			ZFCP_LOG_NORMAL("bug: unknown QDIO error 0x%x\n",
+					qdio_error);
 			break;
 		}
 		/* Restarting IO on the failed adapter from scratch */
@@ -317,7 +314,7 @@
 	adapter = (struct zfcp_adapter *) int_parm;
 	queue = &adapter->request_queue;
 
-	ZFCP_LOG_DEBUG("busid=%s, first=%d, count=%d\n",
+	ZFCP_LOG_DEBUG("adapter %s, first=%d, elements_processed=%d\n",
 		       zfcp_get_busid_by_adapter(adapter),
 		       first_element, elements_processed);
 
@@ -336,7 +333,7 @@
 	atomic_add(elements_processed, &queue->free_count);
 	ZFCP_LOG_DEBUG("free_count=%d\n", atomic_read(&queue->free_count));
 	wake_up(&adapter->request_wq);
-	ZFCP_LOG_DEBUG("Elements_processed = %d, free count=%d\n",
+	ZFCP_LOG_DEBUG("elements_processed=%d, free count=%d\n",
 		       elements_processed, atomic_read(&queue->free_count));
  out:
 	return;
@@ -383,7 +380,7 @@
 	 */
 
 	buffere = &(queue->buffer[first_element]->element[0]);
-	ZFCP_LOG_DEBUG("first BUFFERE flags=0x%x \n", buffere->flags);
+	ZFCP_LOG_DEBUG("first BUFFERE flags=0x%x\n", buffere->flags);
 	/*
 	 * go through all SBALs from input queue currently
 	 * returned by QDIO layer
@@ -406,19 +403,20 @@
 						       (void *) buffere->addr);
 
 			if (retval) {
-				ZFCP_LOG_NORMAL
-				    ("bug: Inbound packet seems not to "
-				     "have been sent at all. It will be "
-				     "ignored. (debug info 0x%lx, 0x%lx, "
-				     "%d, %d, %s)\n",
-				     (unsigned long) buffere->addr,
-				     (unsigned long) &(buffere->addr),
-				     first_element, elements_processed,
-				     zfcp_get_busid_by_adapter(adapter));
-				ZFCP_LOG_NORMAL("Dump of inbound BUFFER %d "
-						"BUFFERE %d at address 0x%lx\n",
-						buffer_index, buffere_index,
-						(unsigned long) buffer);
+				ZFCP_LOG_NORMAL("bug: unexpected inbound "
+						"packet on adapter %s "
+						"(reqid=0x%lx, "
+						"first_element=%d, "
+						"elements_processed=%d)\n",
+						zfcp_get_busid_by_adapter(adapter),
+						(unsigned long) buffere->addr,
+						first_element,
+						elements_processed);
+				ZFCP_LOG_NORMAL("hex dump of inbound buffer "
+						"at address %p "
+						"(buffer_index=%d, "
+						"buffere_index=%d)\n", buffer,
+						buffer_index, buffere_index);
 				ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
 					      (char *) buffer, SBAL_SIZE);
 			}
@@ -445,8 +443,9 @@
 	count = atomic_read(&queue->free_count) + elements_processed;
 	start = queue->free_index;
 
-	ZFCP_LOG_TRACE("Calling do QDIO busid=%s, flags=0x%x, queue_no=%i, "
-		       "index_in_queue=%i, count=%i, buffers=0x%lx\n",
+	ZFCP_LOG_TRACE("calling do_QDIO on adapter %s (flags=0x%x, "
+		       "queue_no=%i, index_in_queue=%i, count=%i, "
+		       "buffers=0x%lx\n",
 		       zfcp_get_busid_by_adapter(adapter),
 		       QDIO_FLAG_SYNC_INPUT | QDIO_FLAG_UNDER_INTERRUPT,
 		       0, start, count, (unsigned long) &queue->buffer[start]);
@@ -457,15 +456,16 @@
 
 	if (unlikely(retval)) {
 		atomic_set(&queue->free_count, count);
-		ZFCP_LOG_DEBUG("Inbound data regions could not be cleared "
-			       "Transfer queues may be down. "
-			       "(info %d, %d, %d)\n", count, start, retval);
+		ZFCP_LOG_DEBUG("clearing of inbound data regions failed, "
+			       "queues may be down "
+			       "(count=%d, start=%d, retval=%d)\n",
+			       count, start, retval);
 	} else {
 		queue->free_index += count;
 		queue->free_index %= QDIO_MAX_BUFFERS_PER_Q;
 		atomic_set(&queue->free_count, 0);
-		ZFCP_LOG_TRACE("%i buffers successfully enqueued to response "
-			       "queue starting at position %i\n", count, start);
+		ZFCP_LOG_TRACE("%i buffers enqueued to response "
+			       "queue at position %i\n", count, start);
 	}
  out:
 	return;
@@ -491,8 +491,7 @@
 
 	/* invalid (per convention used in this driver) */
 	if (unlikely(!sbale_addr)) {
-		ZFCP_LOG_NORMAL
-		    ("bug: Inbound data faulty, contains null-pointer!\n");
+		ZFCP_LOG_NORMAL("bug: invalid reqid\n");
 		retval = -EINVAL;
 		goto out;
 	}
@@ -501,11 +500,9 @@
 	fsf_req = (struct zfcp_fsf_req *) sbale_addr;
 
 	if (unlikely(adapter != fsf_req->adapter)) {
-		ZFCP_LOG_NORMAL("bug: An inbound FSF acknowledgement was not "
-				"correct (debug info 0x%lx, 0x%lx, 0%lx) \n",
-				(unsigned long) fsf_req,
-				(unsigned long) fsf_req->adapter,
-				(unsigned long) adapter);
+		ZFCP_LOG_NORMAL("bug: invalid reqid (fsf_req=%p, "
+				"fsf_req->adapter=%p, adapter=%p)\n",
+				fsf_req, fsf_req->adapter, adapter);
 		retval = -EINVAL;
 		goto out;
 	}
@@ -515,10 +512,9 @@
 			    &fsf_req->qtcb->prefix.req_seq_no, sizeof (u32));
 	}
 
-	ZFCP_LOG_TRACE("fsf_req at 0x%lx, QTCB at 0x%lx\n",
-		       (unsigned long) fsf_req, (unsigned long) fsf_req->qtcb);
+	ZFCP_LOG_TRACE("fsf_req at %p, QTCB at %p\n", fsf_req, fsf_req->qtcb);
 	if (likely(fsf_req->qtcb)) {
-		ZFCP_LOG_TRACE("HEX DUMP OF 1ST BUFFERE PAYLOAD (QTCB):\n");
+		ZFCP_LOG_TRACE("hex dump of QTCB:\n");
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_TRACE, (char *) fsf_req->qtcb,
 			      sizeof(struct fsf_qtcb));
 	}
@@ -889,8 +885,8 @@
 	for (cur_pos = first; cur_pos < (first + clean_count); cur_pos++) {
 		index = cur_pos % QDIO_MAX_BUFFERS_PER_Q;
 		memset(buf[index], 0, sizeof (struct qdio_buffer));
-		ZFCP_LOG_TRACE("zeroing BUFFER %d at address 0x%lx\n",
-			       index, (unsigned long) buf[index]);
+		ZFCP_LOG_TRACE("zeroing BUFFER %d at address %p\n",
+			       index, buf[index]);
 	}
 }
 
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Thu Apr  8 15:21:28 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Thu Apr  8 15:21:29 2004
@@ -212,8 +212,8 @@
 		unit->device = NULL;
 		zfcp_unit_put(unit);
 	} else {
-		ZFCP_LOG_INFO("no unit associated with SCSI device at "
-			      "address 0x%lx\n", (unsigned long) sdpnt);
+		ZFCP_LOG_NORMAL("bug: no unit associated with SCSI device at "
+				"address %p\n", sdpnt);
 	}
 }
 
@@ -273,11 +273,9 @@
 	if (unlikely(
 	      atomic_test_mask(ZFCP_STATUS_COMMON_ERP_FAILED, &unit->status) ||
 	     !atomic_test_mask(ZFCP_STATUS_COMMON_RUNNING, &unit->status))) {
-		ZFCP_LOG_DEBUG("Stopping SCSI IO on the unit with "
-			       "FCP LUN 0x%Lx connected to the port "
-			       "with WWPN 0x%Lx at the adapter %s.\n",
-			       unit->fcp_lun,
-			       unit->port->wwpn,
+		ZFCP_LOG_DEBUG("stopping SCSI I/O on unit 0x%016Lx on port "
+			       "0x%016Lx on adapter %s\n",
+			       unit->fcp_lun, unit->port->wwpn,
 			       zfcp_get_busid_by_adapter(adapter));
 		zfcp_scsi_command_fail(scpnt, DID_ERROR);
 		goto out;
@@ -285,8 +283,8 @@
 
 	if (unlikely(
 	     !atomic_test_mask(ZFCP_STATUS_COMMON_UNBLOCKED, &unit->status))) {
-		ZFCP_LOG_DEBUG("adapter %s not ready or unit with LUN 0x%Lx "
-			       "on the port with WWPN 0x%Lx in recovery.\n",
+		ZFCP_LOG_DEBUG("adapter %s not ready or unit 0x%016Lx "
+			       "on port 0x%016Lx in recovery\n",
 			       zfcp_get_busid_by_unit(unit),
 			       unit->fcp_lun, unit->port->wwpn);
 		retval = SCSI_MLQUEUE_DEVICE_BUSY;
@@ -297,7 +295,7 @@
 					     ZFCP_REQ_AUTO_CLEANUP);
 
 	if (unlikely(tmp < 0)) {
-		ZFCP_LOG_DEBUG("error: Could not send a Send FCP Command\n");
+		ZFCP_LOG_DEBUG("error: initiation of Send FCP Cmnd failed\n");
 		retval = SCSI_MLQUEUE_HOST_BUSY;
 	} else {
 		debug_text_event(adapter->req_dbf, 3, "q_scpnt");
@@ -443,11 +441,8 @@
 	       scpnt->cmnd,
 	       min(scpnt->cmd_len, (unsigned char) ZFCP_ABORT_DBF_LENGTH));
 
-	 /*TRACE*/
-	    ZFCP_LOG_INFO
-	    ("Aborting for adapter=0x%lx, busid=%s, scsi_cmnd=0x%lx\n",
-	     (unsigned long) adapter, zfcp_get_busid_by_adapter(adapter),
-	     (unsigned long) scpnt);
+	ZFCP_LOG_INFO("aborting scsi_cmnd=%p on adapter %s\n",
+		      scpnt, zfcp_get_busid_by_adapter(adapter));
 
 	spin_unlock_irq(scsi_host->host_lock);
 
@@ -469,7 +464,7 @@
 	 */
 	req_data = (union zfcp_req_data *) scpnt->host_scribble;
 	/* DEBUG */
-	ZFCP_LOG_DEBUG("req_data=0x%lx\n", (unsigned long) req_data);
+	ZFCP_LOG_DEBUG("req_data=%p\n", req_data);
 	if (!req_data) {
 		ZFCP_LOG_DEBUG("late command completion overtook abort\n");
 		/*
@@ -489,11 +484,10 @@
 	dbf_timeout =
 	    (jiffies - req_data->send_fcp_command_task.start_jiffies) / HZ;
 
-	/* DEBUG */
-	ZFCP_LOG_DEBUG("old_fsf_req=0x%lx\n", (unsigned long) old_fsf_req);
+	ZFCP_LOG_DEBUG("old_fsf_req=%p\n", old_fsf_req);
 	if (!old_fsf_req) {
 		write_unlock_irqrestore(&adapter->abort_lock, flags);
-		ZFCP_LOG_NORMAL("bug: No old fsf request found.\n");
+		ZFCP_LOG_NORMAL("bug: no old fsf request found\n");
 		ZFCP_LOG_NORMAL("req_data:\n");
 		ZFCP_HEX_DUMP(ZFCP_LOG_LEVEL_NORMAL,
 			      (char *) req_data, sizeof (union zfcp_req_data));
@@ -517,8 +511,7 @@
 	 * Since this lock will not be held, fsf_req may complete
 	 * late and may be released meanwhile.
 	 */
-	ZFCP_LOG_DEBUG("unit=0x%lx, unit_fcp_lun=0x%Lx\n",
-		       (unsigned long) unit, unit->fcp_lun);
+	ZFCP_LOG_DEBUG("unit 0x%016Lx (%p)\n", unit->fcp_lun, unit);
 
 	/*
 	 * The 'Abort FCP Command' routine may block (call schedule)
@@ -533,18 +526,18 @@
 	new_fsf_req = zfcp_fsf_abort_fcp_command((unsigned long) old_fsf_req,
 						 adapter,
 						 unit, ZFCP_WAIT_FOR_SBAL);
-	ZFCP_LOG_DEBUG("new_fsf_req=0x%lx\n", (unsigned long) new_fsf_req);
+	ZFCP_LOG_DEBUG("new_fsf_req=%p\n", new_fsf_req);
 	if (!new_fsf_req) {
 		retval = FAILED;
-		ZFCP_LOG_DEBUG("warning: Could not abort SCSI command "
-			       "at 0x%lx\n", (unsigned long) scpnt);
+		ZFCP_LOG_NORMAL("error: initiation of Abort FCP Cmnd "
+				"failed\n");
 		strncpy(dbf_result, "##nores", ZFCP_ABORT_DBF_LENGTH);
 		goto out;
 	}
 
 	/* wait for completion of abort */
-	ZFCP_LOG_DEBUG("Waiting for cleanup....\n");
-#ifdef 1
+	ZFCP_LOG_DEBUG("waiting for cleanup...\n");
+#if 1
 	/*
 	 * FIXME:
 	 * copying zfcp_fsf_req_wait_and_cleanup code is not really nice
@@ -615,11 +608,11 @@
 	spin_unlock_irq(scsi_host->host_lock);
 
 	if (!unit) {
-		ZFCP_LOG_NORMAL("bug: Tried to reset a non existant unit.\n");
+		ZFCP_LOG_NORMAL("bug: Tried reset for nonexistent unit\n");
 		retval = SUCCESS;
 		goto out;
 	}
-	ZFCP_LOG_NORMAL("Resetting Device fcp_lun=0x%Lx\n", unit->fcp_lun);
+	ZFCP_LOG_NORMAL("resetting unit 0x%016Lx\n", unit->fcp_lun);
 
 	/*
 	 * If we do not know whether the unit supports 'logical unit reset'
@@ -633,18 +626,15 @@
 		retval =
 		    zfcp_task_management_function(unit, LOGICAL_UNIT_RESET);
 		if (retval) {
-			ZFCP_LOG_DEBUG
-			    ("logical unit reset failed (unit=0x%lx)\n",
-			     (unsigned long) unit);
+			ZFCP_LOG_DEBUG("unit reset failed (unit=%p)\n", unit);
 			if (retval == -ENOTSUPP)
 				atomic_set_mask
 				    (ZFCP_STATUS_UNIT_NOTSUPPUNITRESET,
 				     &unit->status);
 			/* fall through and try 'target reset' next */
 		} else {
-			ZFCP_LOG_DEBUG
-			    ("logical unit reset succeeded (unit=0x%lx)\n",
-			     (unsigned long) unit);
+			ZFCP_LOG_DEBUG("unit reset succeeded (unit=%p)\n",
+				       unit);
 			/* avoid 'target reset' */
 			retval = SUCCESS;
 			goto out;
@@ -652,12 +642,10 @@
 	}
 	retval = zfcp_task_management_function(unit, TARGET_RESET);
 	if (retval) {
-		ZFCP_LOG_DEBUG("target reset failed (unit=0x%lx)\n",
-			       (unsigned long) unit);
+		ZFCP_LOG_DEBUG("target reset failed (unit=%p)\n", unit);
 		retval = FAILED;
 	} else {
-		ZFCP_LOG_DEBUG("target reset succeeded (unit=0x%lx)\n",
-			       (unsigned long) unit);
+		ZFCP_LOG_DEBUG("target reset succeeded (unit=%p)\n", unit);
 		retval = SUCCESS;
 	}
  out:
@@ -677,13 +665,9 @@
 	fsf_req = zfcp_fsf_send_fcp_command_task_management
 	    (adapter, unit, tm_flags, ZFCP_WAIT_FOR_SBAL);
 	if (!fsf_req) {
-		ZFCP_LOG_INFO("error: Out of resources. Could not create a "
-			      "task management (abort, reset, etc) request "
-			      "for the unit with FCP-LUN 0x%Lx connected to "
-			      "the port with WWPN 0x%Lx connected to "
-			      "the adapter %s.\n",
-			      unit->fcp_lun,
-			      unit->port->wwpn,
+		ZFCP_LOG_INFO("error: creation of task management request "
+			      "failed for unit 0x%016Lx on port 0x%016Lx on  "
+			      "adapter %s\n", unit->fcp_lun, unit->port->wwpn,
 			      zfcp_get_busid_by_adapter(adapter));
 		retval = -ENOMEM;
 		goto out;
@@ -722,10 +706,8 @@
 	spin_unlock_irq(scsi_host->host_lock);
 
 	unit = (struct zfcp_unit *) scpnt->device->hostdata;
-	 /*DEBUG*/
-	    ZFCP_LOG_NORMAL("Resetting because of problems with "
-			    "unit=0x%lx, unit_fcp_lun=0x%Lx\n",
-			    (unsigned long) unit, unit->fcp_lun);
+	ZFCP_LOG_NORMAL("bus reset because of problems with "
+			"unit 0x%016Lx\n", unit->fcp_lun);
 	zfcp_erp_adapter_reopen(unit->port->adapter, 0);
 	zfcp_erp_wait(unit->port->adapter);
 	retval = SUCCESS;
@@ -751,10 +733,8 @@
 	spin_unlock_irq(scsi_host->host_lock);
 
 	unit = (struct zfcp_unit *) scpnt->device->hostdata;
-	 /*DEBUG*/
-	    ZFCP_LOG_NORMAL("Resetting because of problems with "
-			    "unit=0x%lx, unit_fcp_lun=0x%Lx\n",
-			    (unsigned long) unit, unit->fcp_lun);
+	ZFCP_LOG_NORMAL("host reset because of problems with "
+			"unit 0x%016Lx\n", unit->fcp_lun);
 	zfcp_erp_adapter_reopen(unit->port->adapter, 0);
 	zfcp_erp_wait(unit->port->adapter);
 	retval = SUCCESS;
@@ -780,15 +760,13 @@
 	adapter->scsi_host = scsi_host_alloc(&zfcp_data.scsi_host_template,
 					     sizeof (struct zfcp_adapter *));
 	if (!adapter->scsi_host) {
-		ZFCP_LOG_NORMAL("error: Not enough free memory. "
-				"Could not register adapter %s "
-				"with the SCSI-stack.\n",
+		ZFCP_LOG_NORMAL("error: registration with SCSI stack failed "
+				"for adapter %s ",
 				zfcp_get_busid_by_adapter(adapter));
 		retval = -EIO;
 		goto out;
 	}
-	ZFCP_LOG_DEBUG("host registered, scsi_host at 0x%lx\n",
-		       (unsigned long) adapter->scsi_host);
+	ZFCP_LOG_DEBUG("host registered, scsi_host=%p\n", adapter->scsi_host);
 
 	/* tell the SCSI stack some characteristics of this adapter */
 	adapter->scsi_host->max_id = 1;
