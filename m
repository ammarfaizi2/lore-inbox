Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263161AbUDUOyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263161AbUDUOyh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 10:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263165AbUDUOyP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 10:54:15 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:15557 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP id S263161AbUDUOsZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:48:25 -0400
Date: Wed, 21 Apr 2004 16:48:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH] s390 (6/9): zfcp adapter fixes.
Message-ID: <20040421144807.GG2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapter changes.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

zfcp host adapter changes:
 - Fix error recovery stall in case of unavailable nameserver.
 - Reset host_scribble field to NULL in scsi_cmd.
 - Remove request debug code.

diffstat:
 drivers/s390/scsi/zfcp_aux.c  |   16 ++--------------
 drivers/s390/scsi/zfcp_def.h  |   15 +--------------
 drivers/s390/scsi/zfcp_erp.c  |   25 +++++++++++++------------
 drivers/s390/scsi/zfcp_fsf.c  |   41 ++++-------------------------------------
 drivers/s390/scsi/zfcp_qdio.c |   11 +----------
 drivers/s390/scsi/zfcp_scsi.c |    6 +-----
 6 files changed, 22 insertions(+), 92 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_aux.c linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c
--- linux-2.6/drivers/s390/scsi/zfcp_aux.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_aux.c	Wed Apr 21 16:29:39 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_AUX_REVISION "$Revision: 1.105 $"
+#define ZFCP_AUX_REVISION "$Revision: 1.107 $"
 
 #include "zfcp_ext.h"
 
@@ -1078,17 +1078,6 @@
 {
 	char dbf_name[20];
 
-	/* debug feature area which records fsf request sequence numbers */
-	sprintf(dbf_name, ZFCP_REQ_DBF_NAME "%s",
-		zfcp_get_busid_by_adapter(adapter));
-	adapter->req_dbf = debug_register(dbf_name,
-					  ZFCP_REQ_DBF_INDEX,
-					  ZFCP_REQ_DBF_AREAS,
-					  ZFCP_REQ_DBF_LENGTH);
-	debug_register_view(adapter->req_dbf, &debug_hex_ascii_view);
-	debug_set_level(adapter->req_dbf, ZFCP_REQ_DBF_LEVEL);
-	debug_text_event(adapter->req_dbf, 1, "zzz");
-
 	/* debug feature area which records SCSI command failures (hostbyte) */
 	rwlock_init(&adapter->cmd_dbf_lock);
 	sprintf(dbf_name, ZFCP_CMD_DBF_NAME "%s",
@@ -1131,7 +1120,7 @@
 	debug_register_view(adapter->erp_dbf, &debug_hex_ascii_view);
 	debug_set_level(adapter->erp_dbf, ZFCP_ERP_DBF_LEVEL);
 
-	if (adapter->req_dbf && adapter->cmd_dbf && adapter->abort_dbf &&
+	if (adapter->cmd_dbf && adapter->abort_dbf &&
 	    adapter->in_els_dbf && adapter->erp_dbf)
 		return 0;
 
@@ -1147,7 +1136,6 @@
 zfcp_adapter_debug_unregister(struct zfcp_adapter *adapter)
 {
 	debug_unregister(adapter->erp_dbf);
-	debug_unregister(adapter->req_dbf);
 	debug_unregister(adapter->cmd_dbf);
 	debug_unregister(adapter->abort_dbf);
 	debug_unregister(adapter->in_els_dbf);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Wed Apr 21 16:29:39 2004
@@ -33,7 +33,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.71 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.72 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -450,19 +450,12 @@
 #define ZFCP_ERP_DBF_LEVEL     3
 #define ZFCP_ERP_DBF_NAME      "zfcperp"
 
-#define ZFCP_REQ_DBF_INDEX     1
-#define ZFCP_REQ_DBF_AREAS     1
-#define ZFCP_REQ_DBF_LENGTH    8
-#define ZFCP_REQ_DBF_LEVEL     1
-#define ZFCP_REQ_DBF_NAME      "zfcpreq"
-
 #define ZFCP_CMD_DBF_INDEX     2
 #define ZFCP_CMD_DBF_AREAS     1
 #define ZFCP_CMD_DBF_LENGTH    8
 #define ZFCP_CMD_DBF_LEVEL     3
 #define ZFCP_CMD_DBF_NAME      "zfcpcmd"
 
-
 #define ZFCP_ABORT_DBF_INDEX   2
 #define ZFCP_ABORT_DBF_AREAS   1
 #define ZFCP_ABORT_DBF_LENGTH  8
@@ -475,11 +468,6 @@
 #define ZFCP_IN_ELS_DBF_LEVEL  6
 #define ZFCP_IN_ELS_DBF_NAME   "zfcpels"
 
-#define ZFCP_ADAPTER_REQ_DBF_INDEX  4 
-#define ZFCP_ADAPTER_REQ_DBF_AREAS  1
-#define ZFCP_ADAPTER_REQ_DBF_LENGTH 8
-#define ZFCP_ADAPTER_REQ_DBF_LEVEL  6
-
 /******************** LOGGING MACROS AND DEFINES *****************************/
 
 /*
@@ -986,7 +974,6 @@
 	struct zfcp_port	*nameserver_port;  /* adapter's nameserver */
         debug_info_t            *erp_dbf;          /* S/390 debug features */
 	debug_info_t            *abort_dbf;
-	debug_info_t            *req_dbf;
 	debug_info_t            *in_els_dbf;
 	debug_info_t            *cmd_dbf;
 	rwlock_t                cmd_dbf_lock;
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Wed Apr 21 16:29:39 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.49 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.51 $"
 
 #include "zfcp_ext.h"
 
@@ -1865,6 +1865,7 @@
 	case ZFCP_ERP_FAILED :
 		atomic_inc(&port->erp_counter);
 		if (atomic_read(&port->erp_counter) > ZFCP_MAX_ERPS)
+			zfcp_erp_port_failed(port);
 		break;
 	case ZFCP_ERP_EXIT :
 		/* nothing */
@@ -1874,7 +1875,6 @@
 	if (atomic_test_mask(ZFCP_STATUS_COMMON_ERP_FAILED, &port->status)) {
 		zfcp_erp_port_block(port, 0); /* for ZFCP_ERP_SUCCEEDED */
 		result = ZFCP_ERP_EXIT;
-			zfcp_erp_port_failed(port);
 	}
 
 	return result;
@@ -2397,8 +2397,6 @@
 		ZFCP_LOG_NORMAL("bug: shutdown of QDIO queues failed "
 				"(retval=%d)\n", retval_cleanup);
 	}
-	else
-		debug_text_event(adapter->req_dbf, 1, "q_clean");
 
  failed_qdio_establish:
 	atomic_clear_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status);
@@ -2468,10 +2466,8 @@
 		ZFCP_LOG_NORMAL("bug: shutdown of QDIO queues failed on "
 				"adapter %s\n",
 				zfcp_get_busid_by_adapter(adapter));
-	} else {
+	} else
 		ZFCP_LOG_DEBUG("queues cleaned up\n");
-		debug_text_event(adapter->req_dbf, 1, "q_clean");
-	}
 
 	/*
 	 * First we had to stop QDIO operation.
@@ -2834,9 +2830,10 @@
 			/* nameserver port may live again */
 			atomic_set_mask(ZFCP_STATUS_COMMON_RUNNING,
 					&adapter->nameserver_port->status);
-			zfcp_erp_port_reopen(adapter->nameserver_port, 0);
-			erp_action->step = ZFCP_ERP_STEP_NAMESERVER_OPEN;
-			retval = ZFCP_ERP_CONTINUES;
+			if (zfcp_erp_port_reopen(adapter->nameserver_port, 0) >= 0) {
+				erp_action->step = ZFCP_ERP_STEP_NAMESERVER_OPEN;
+				retval = ZFCP_ERP_CONTINUES;
+			} else  retval = ZFCP_ERP_FAILED;
 			break;
 		}
 		/* else nameserver port is already open, fall through */
@@ -2972,6 +2969,10 @@
 			debug_text_event(adapter->erp_dbf, 3, "p_pstnsw_w");
 			debug_event(adapter->erp_dbf, 3,
 				    &erp_action->port->wwpn, sizeof (wwn_t));
+			if (atomic_test_mask(
+				    ZFCP_STATUS_COMMON_ERP_FAILED,
+				    &adapter->nameserver_port->status))
+				zfcp_erp_port_failed(erp_action->port);
 			zfcp_erp_action_ready(erp_action);
 		}
 	}
@@ -3357,7 +3358,7 @@
 			struct zfcp_adapter *adapter,
 			struct zfcp_port *port, struct zfcp_unit *unit)
 {
-	int retval = -1;
+	int retval = 1;
 	struct zfcp_erp_action *erp_action = NULL;
 	int stronger_action = 0;
 	u32 status = 0;
@@ -3376,7 +3377,7 @@
 
 	if (!atomic_test_mask(ZFCP_STATUS_ADAPTER_ERP_THREAD_UP,
 			      &adapter->status))
-		goto out;
+		return -EIO;
 
 	debug_event(adapter->erp_dbf, 4, &action, sizeof (int));
 	/* check whether we really need this */
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Wed Apr 21 16:29:39 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.43 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.45 $"
 
 #include "zfcp_ext.h"
 
@@ -379,13 +379,6 @@
 				zfcp_get_busid_by_adapter(adapter),
 				fsf_req->qtcb->prefix.prot_status_qual.
 				sequence_error.exp_req_seq_no);
-		debug_text_event(adapter->req_dbf, 1, "exp_seq!");
-		debug_event(adapter->req_dbf, 1,
-			    &fsf_req->qtcb->prefix.prot_status_qual.
-			    sequence_error.exp_req_seq_no, 4);
-		debug_text_event(adapter->req_dbf, 1, "qtcb_seq!");
-		debug_exception(adapter->req_dbf, 1,
-				&fsf_req->qtcb->prefix.req_seq_no, 4);
 		debug_text_exception(adapter->erp_dbf, 0, "prot_seq_err");
 		/* restart operation on this adapter */
 		zfcp_erp_adapter_reopen(adapter, 0);
@@ -891,7 +884,6 @@
 
 	ZFCP_LOG_TRACE("Status Read request initiated (adapter%s)\n",
 		       zfcp_get_busid_by_adapter(adapter));
-	debug_text_event(adapter->req_dbf, 1, "unso");
 	goto out;
 
  failed_req_send:
@@ -1277,10 +1269,6 @@
 	case FSF_FCP_COMMAND_DOES_NOT_EXIST:
 		ZFCP_LOG_FLAGS(2, "FSF_FCP_COMMAND_DOES_NOT_EXIST\n");
 		retval = 0;
-		debug_text_event(new_fsf_req->adapter->req_dbf, 3, "no_exist");
-		debug_event(new_fsf_req->adapter->req_dbf, 3,
-			    &new_fsf_req->qtcb->bottom.support.req_handle,
-			    sizeof (unsigned long));
 		debug_text_event(new_fsf_req->adapter->erp_dbf, 3,
 				 "fsf_s_no_exist");
 		new_fsf_req->status |= ZFCP_STATUS_FSFREQ_ABORTNOTNEEDED;
@@ -3373,10 +3361,6 @@
 	 * (need this for look up on normal command completion)
 	 */
 	fsf_req->data.send_fcp_command_task.scsi_cmnd = scsi_cmnd;
-	debug_text_event(adapter->req_dbf, 3, "fsf/sc");
-	debug_event(adapter->req_dbf, 3, &fsf_req, sizeof (unsigned long));
-	debug_event(adapter->req_dbf, 3, &scsi_cmnd, sizeof (unsigned long));
-
 	fsf_req->data.send_fcp_command_task.start_jiffies = jiffies;
 	fsf_req->data.send_fcp_command_task.unit = unit;
 	ZFCP_LOG_DEBUG("unit=%p, fcp_lun=0x%016Lx\n", unit, unit->fcp_lun);
@@ -3517,12 +3501,9 @@
  send_failed:
  no_fit:
  failed_scsi_cmnd:
-	/* dequeue new FSF request previously enqueued */
-	debug_text_event(adapter->req_dbf, 3, "fail_sc");
-	debug_event(adapter->req_dbf, 3, &scsi_cmnd, sizeof (unsigned long));
-
 	zfcp_fsf_req_free(fsf_req);
 	fsf_req = NULL;
+	scsi_cmnd->host_scribble = NULL;
  success:
  failed_req_create:
 	write_unlock_irqrestore(&adapter->request_queue.queue_lock, lock_flags);
@@ -4267,14 +4248,9 @@
 	 * the new eh
 	 */
 	/* always call back */
-	debug_text_event(fsf_req->adapter->req_dbf, 2, "ok_done:");
-	debug_event(fsf_req->adapter->req_dbf, 2, &scpnt,
-		    sizeof (unsigned long));
-	debug_event(fsf_req->adapter->req_dbf, 2, &scpnt->scsi_done,
-		    sizeof (unsigned long));
-	debug_event(fsf_req->adapter->req_dbf, 2, &fsf_req,
-		    sizeof (unsigned long));
+
 	(scpnt->scsi_done) (scpnt);
+
 	/*
 	 * We must hold this lock until scsi_done has been called.
 	 * Otherwise we may call scsi_done after abort regarding this
@@ -4954,15 +4930,6 @@
 			 "to request queue.\n");
 	} else {
 		req_queue->distance_from_int = new_distance_from_int;
-		debug_text_event(adapter->req_dbf, 1, "o:a/seq");
-		debug_event(adapter->req_dbf, 1, &fsf_req,
-			    sizeof (unsigned long));
-		if (likely(inc_seq_no)) {
-			debug_event(adapter->req_dbf, 1,
-				    &adapter->fsf_req_seq_no, sizeof (u32));
-		} else {
-			debug_text_event(adapter->req_dbf, 1, "nocb");
-		}
 		/*
 		 * increase FSF sequence counter -
 		 * this must only be done for request successfully enqueued to
diff -urN linux-2.6/drivers/s390/scsi/zfcp_qdio.c linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c
--- linux-2.6/drivers/s390/scsi/zfcp_qdio.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_qdio.c	Wed Apr 21 16:29:39 2004
@@ -28,7 +28,7 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#define ZFCP_QDIO_C_REVISION "$Revision: 1.16 $"
+#define ZFCP_QDIO_C_REVISION "$Revision: 1.18 $"
 
 #include "zfcp_ext.h"
 
@@ -485,10 +485,6 @@
 	struct zfcp_fsf_req *fsf_req;
 	int retval = 0;
 
-	/* Note: seq is entered later */
-	debug_text_event(adapter->req_dbf, 1, "i:a/seq");
-	debug_event(adapter->req_dbf, 1, &sbale_addr, sizeof (unsigned long));
-
 	/* invalid (per convention used in this driver) */
 	if (unlikely(!sbale_addr)) {
 		ZFCP_LOG_NORMAL("bug: invalid reqid\n");
@@ -506,11 +502,6 @@
 		retval = -EINVAL;
 		goto out;
 	}
-	/* debug feature stuff (test for QTCB: remember new unsol. status!) */
-	if (likely(fsf_req->qtcb)) {
-		debug_event(adapter->req_dbf, 1,
-			    &fsf_req->qtcb->prefix.req_seq_no, sizeof (u32));
-	}
 
 	ZFCP_LOG_TRACE("fsf_req at %p, QTCB at %p\n", fsf_req, fsf_req->qtcb);
 	if (likely(fsf_req->qtcb)) {
diff -urN linux-2.6/drivers/s390/scsi/zfcp_scsi.c linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c
--- linux-2.6/drivers/s390/scsi/zfcp_scsi.c	Wed Apr 21 16:29:16 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_scsi.c	Wed Apr 21 16:29:39 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_SCSI
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_SCSI_REVISION "$Revision: 1.59 $"
+#define ZFCP_SCSI_REVISION "$Revision: 1.60 $"
 
 #include <linux/blkdev.h>
 
@@ -297,10 +297,6 @@
 	if (unlikely(tmp < 0)) {
 		ZFCP_LOG_DEBUG("error: initiation of Send FCP Cmnd failed\n");
 		retval = SCSI_MLQUEUE_HOST_BUSY;
-	} else {
-		debug_text_event(adapter->req_dbf, 3, "q_scpnt");
-		debug_event(adapter->req_dbf, 3, &scpnt,
-			    sizeof (unsigned long));
 	}
 
 out:
