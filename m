Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266347AbUG0O4m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266347AbUG0O4m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 10:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266362AbUG0O4l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 10:56:41 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:11219 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S266347AbUG0Oxl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 10:53:41 -0400
Date: Tue, 27 Jul 2004 16:53:52 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: zfcp host adapter.
Message-ID: <20040727145352.GC8126@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: zfcp host adapter.

From: Heiko Carstens <heiko.carstens@de.ibm.com>
From: Maxim Shchetynin <maxim@de.ibm.com>

zfcp host adapter changes:
 - Get rid of ZFCP_WAIT_EVENT_TIMEOUT macro.
 - Correct an error log mesage.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 drivers/s390/scsi/zfcp_def.h |   28 +---------------------------
 drivers/s390/scsi/zfcp_erp.c |   11 +++--------
 drivers/s390/scsi/zfcp_fsf.c |   12 ++++++------
 3 files changed, 10 insertions(+), 41 deletions(-)

diff -urN linux-2.6/drivers/s390/scsi/zfcp_def.h linux-2.6-s390/drivers/s390/scsi/zfcp_def.h
--- linux-2.6/drivers/s390/scsi/zfcp_def.h	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_def.h	Tue Jul 27 16:36:28 2004
@@ -33,7 +33,7 @@
 #define ZFCP_DEF_H
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_DEF_REVISION "$Revision: 1.75 $"
+#define ZFCP_DEF_REVISION "$Revision: 1.78 $"
 
 /*************************** INCLUDES *****************************************/
 
@@ -1125,32 +1125,6 @@
 		if (ZFCP_LOG_CHECK(level)) { \
 			_zfcp_hex_dump(addr, count); \
 		}
-/*
- * Not yet optimal but useful:
- * Waits until the condition is met or the timeout occurs.
- * The condition may be a function call. This allows to
- * execute some additional instructions in addition
- * to a simple condition check.
- * The timeout is modified on exit and holds the remaining time.
- * Thus it is zero if a timeout ocurred, i.e. the condition was 
- * not met in the specified interval.
- */
-#define __ZFCP_WAIT_EVENT_TIMEOUT(timeout, condition) \
-do { \
-	set_current_state(TASK_UNINTERRUPTIBLE); \
-	while (!(condition) && timeout) \
-		timeout = schedule_timeout(timeout); \
-	current->state = TASK_RUNNING; \
-} while (0);
-
-#define ZFCP_WAIT_EVENT_TIMEOUT(waitqueue, timeout, condition) \
-do { \
-	wait_queue_t entry; \
-	init_waitqueue_entry(&entry, current); \
-	add_wait_queue(&waitqueue, &entry); \
-	__ZFCP_WAIT_EVENT_TIMEOUT(timeout, condition) \
-	remove_wait_queue(&waitqueue, &entry); \
-} while (0);
 
 #define zfcp_get_busid_by_adapter(adapter) (adapter->ccw_device->dev.bus_id)
 #define zfcp_get_busid_by_port(port) (zfcp_get_busid_by_adapter(port->adapter))
diff -urN linux-2.6/drivers/s390/scsi/zfcp_erp.c linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c
--- linux-2.6/drivers/s390/scsi/zfcp_erp.c	Tue Jul 27 16:35:49 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_erp.c	Tue Jul 27 16:36:28 2004
@@ -31,7 +31,7 @@
 #define ZFCP_LOG_AREA			ZFCP_LOG_AREA_ERP
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_ERP_REVISION "$Revision: 1.56 $"
+#define ZFCP_ERP_REVISION "$Revision: 1.60 $"
 
 #include "zfcp_ext.h"
 
@@ -436,8 +436,8 @@
 	int retval = 0;
 
 	if (send_els->status != 0) {
-		ZFCP_LOG_NORMAL("ELS request timed out, physical port reopen "
-				"of port 0x%016Lx on adapter %s failed\n",
+		ZFCP_LOG_NORMAL("ELS request timed out, force physical port "
+				"reopen of port 0x%016Lx on adapter %s\n",
 				port->wwpn, zfcp_get_busid_by_port(port));
 		debug_text_event(port->adapter->erp_dbf, 3, "forcreop");
 		retval = zfcp_erp_port_forced_reopen(port, 0);
@@ -2187,11 +2187,6 @@
 		ZFCP_LOG_INFO("Waiting to allow the adapter %s "
 			      "to recover itself\n",
 			      zfcp_get_busid_by_adapter(adapter));
-		/*
-		 * SUGGESTION: substitute by
-		 * timeout = ZFCP_TYPE2_RECOVERY_TIME;
-		 * __ZFCP_WAIT_EVENT_TIMEOUT(timeout, 0);
-		 */
 		timeout = ZFCP_TYPE2_RECOVERY_TIME;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		schedule_timeout(timeout);
diff -urN linux-2.6/drivers/s390/scsi/zfcp_fsf.c linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c
--- linux-2.6/drivers/s390/scsi/zfcp_fsf.c	Tue Jul 27 16:36:28 2004
+++ linux-2.6-s390/drivers/s390/scsi/zfcp_fsf.c	Tue Jul 27 16:36:28 2004
@@ -29,7 +29,7 @@
  */
 
 /* this drivers version (do not edit !!! generated and updated by cvs) */
-#define ZFCP_FSF_C_REVISION "$Revision: 1.49 $"
+#define ZFCP_FSF_C_REVISION "$Revision: 1.53 $"
 
 #include "zfcp_ext.h"
 
@@ -4717,14 +4717,14 @@
 		      unsigned long *lock_flags)
 {
         int condition;
-        unsigned long timeout = ZFCP_SBAL_TIMEOUT;
         struct zfcp_qdio_queue *req_queue = &adapter->request_queue;
 
         if (unlikely(req_flags & ZFCP_WAIT_FOR_SBAL)) {
-                ZFCP_WAIT_EVENT_TIMEOUT(adapter->request_wq, timeout,
-                                        (condition =
-                                         (zfcp_fsf_req_create_sbal_check)
-                                         (lock_flags, req_queue, 1)));
+                wait_event_interruptible_timeout(adapter->request_wq,
+						 (condition =
+						  zfcp_fsf_req_create_sbal_check
+						  (lock_flags, req_queue, 1)),
+						 ZFCP_SBAL_TIMEOUT);
                 if (!condition) {
                         return -EIO;
 		}
