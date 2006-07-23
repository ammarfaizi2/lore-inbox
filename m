Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751328AbWGWVBt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751328AbWGWVBt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:01:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWGWVBt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:01:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:6082 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751321AbWGWVBr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:01:47 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 23 Jul 2006 23:00:16 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc1-mm2 6/6] ieee1394: sbp2: convert
 sbp2util_down_timeout to waitqueue
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
Message-ID: <tkrat.8af4b4844f2dd615@s5r6.in-berlin.de>
References: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.913) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The waitqueue API is used to replace a custom wait mechanism.  Only one
global waitqueue (instead of per-device waitqueues or completions) is
added because there is usually just one waiter.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   51 +++++++++++++++++-----------------------
 drivers/ieee1394/sbp2.h |    4 +--
 2 files changed, 24 insertions(+), 31 deletions(-)

Index: linux/drivers/ieee1394/sbp2.h
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.h	2006-07-23 10:26:48.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.h	2006-07-23 13:19:35.000000000 +0200
@@ -320,9 +320,9 @@ struct scsi_id_instance_data {
 	u64 status_fifo_addr;
 
 	/*
-	 * Variable used for logins, reconnects, logouts, query logins
+	 * Waitqueue flag for logins, reconnects, logouts, query logins
 	 */
-	atomic_t sbp2_login_complete;
+	int access_complete:1;
 
 	/*
 	 * Pool of command orbs, so we can have more than overlapped command per id
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-07-23 12:49:15.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-07-23 18:57:47.000000000 +0200
@@ -55,12 +55,12 @@
 #include <linux/smp_lock.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/wait.h>
 
 #include <asm/current.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/byteorder.h>
-#include <asm/atomic.h>
 #include <asm/system.h>
 #include <asm/scatterlist.h>
 
@@ -420,21 +420,23 @@ static void sbp2util_packet_dump(void *b
 #define sbp2util_packet_dump(w,x,y,z)
 #endif
 
+static DECLARE_WAIT_QUEUE_HEAD(access_wq);
+
 /*
- * Goofy routine that basically does a down_timeout function.
+ * Waits for completion of an SBP-2 access request.
+ * Returns nonzero if timed out or prematurely interrupted.
  */
-static int sbp2util_down_timeout(atomic_t *done, int timeout)
+static int sbp2util_access_timeout(struct scsi_id_instance_data *scsi_id,
+				   int timeout)
 {
-	int i;
+	long leftover = wait_event_interruptible_timeout(
+				access_wq, scsi_id->access_complete, timeout);
 
-	for (i = timeout; (i > 0 && atomic_read(done) == 0); i-= HZ/10) {
-		if (msleep_interruptible(100))	/* 100ms */
-			return 1;
-	}
-	return (i > 0) ? 0 : 1;
+	scsi_id->access_complete = 0;
+	return leftover <= 0;
 }
 
-/* Free's an allocated packet */
+/* Frees an allocated packet */
 static void sbp2_free_packet(struct hpsb_packet *packet)
 {
 	hpsb_free_tlabel(packet);
@@ -794,7 +796,6 @@ static struct scsi_id_instance_data *sbp
 	scsi_id->speed_code = IEEE1394_SPEED_100;
 	scsi_id->max_payload_size = sbp2_speedto_max_payload[IEEE1394_SPEED_100];
 	scsi_id->status_fifo_addr = CSR1212_INVALID_ADDR_SPACE;
-	atomic_set(&scsi_id->sbp2_login_complete, 0);
 	INIT_LIST_HEAD(&scsi_id->sbp2_command_orb_inuse);
 	INIT_LIST_HEAD(&scsi_id->sbp2_command_orb_completed);
 	INIT_LIST_HEAD(&scsi_id->scsi_list);
@@ -1187,11 +1188,9 @@ static int sbp2_query_logins(struct scsi
 	data[1] = scsi_id->query_logins_orb_dma;
 	sbp2util_cpu_to_be32_buffer(data, 8);
 
-	atomic_set(&scsi_id->sbp2_login_complete, 0);
-
 	hpsb_node_write(scsi_id->ne, scsi_id->sbp2_management_agent_addr, data, 8);
 
-	if (sbp2util_down_timeout(&scsi_id->sbp2_login_complete, 2*HZ)) {
+	if (sbp2util_access_timeout(scsi_id, 2*HZ)) {
 		SBP2_INFO("Error querying logins to SBP-2 device - timed out");
 		return -EIO;
 	}
@@ -1279,15 +1278,13 @@ static int sbp2_login_device(struct scsi
 	data[1] = scsi_id->login_orb_dma;
 	sbp2util_cpu_to_be32_buffer(data, 8);
 
-	atomic_set(&scsi_id->sbp2_login_complete, 0);
-
 	hpsb_node_write(scsi_id->ne, scsi_id->sbp2_management_agent_addr, data, 8);
 
 	/*
 	 * Wait for login status (up to 20 seconds)...
 	 */
-	if (sbp2util_down_timeout(&scsi_id->sbp2_login_complete, 20*HZ)) {
-		SBP2_ERR("Error logging into SBP-2 device - login timed-out");
+	if (sbp2util_access_timeout(scsi_id, 20*HZ)) {
+		SBP2_ERR("Error logging into SBP-2 device - timed out");
 		return -EIO;
 	}
 
@@ -1374,21 +1371,17 @@ static int sbp2_logout_device(struct scs
 	data[1] = scsi_id->logout_orb_dma;
 	sbp2util_cpu_to_be32_buffer(data, 8);
 
-	atomic_set(&scsi_id->sbp2_login_complete, 0);
-
 	error = hpsb_node_write(scsi_id->ne,
 				scsi_id->sbp2_management_agent_addr, data, 8);
 	if (error)
 		return error;
 
 	/* Wait for device to logout...1 second. */
-	if (sbp2util_down_timeout(&scsi_id->sbp2_login_complete, HZ))
+	if (sbp2util_access_timeout(scsi_id, HZ))
 		return -EIO;
 
 	SBP2_INFO("Logged out of SBP-2 device");
-
 	return 0;
-
 }
 
 /*
@@ -1436,8 +1429,6 @@ static int sbp2_reconnect_device(struct 
 	data[1] = scsi_id->reconnect_orb_dma;
 	sbp2util_cpu_to_be32_buffer(data, 8);
 
-	atomic_set(&scsi_id->sbp2_login_complete, 0);
-
 	error = hpsb_node_write(scsi_id->ne,
 				scsi_id->sbp2_management_agent_addr, data, 8);
 	if (error)
@@ -1446,8 +1437,8 @@ static int sbp2_reconnect_device(struct 
 	/*
 	 * Wait for reconnect status (up to 1 second)...
 	 */
-	if (sbp2util_down_timeout(&scsi_id->sbp2_login_complete, HZ)) {
-		SBP2_ERR("Error reconnecting to SBP-2 device - reconnect timed-out");
+	if (sbp2util_access_timeout(scsi_id, HZ)) {
+		SBP2_ERR("Error reconnecting to SBP-2 device - timed out");
 		return -EIO;
 	}
 
@@ -2215,8 +2206,10 @@ static int sbp2_handle_status_write(stru
 		if ((sb->ORB_offset_lo == scsi_id->reconnect_orb_dma) ||
 		    (sb->ORB_offset_lo == scsi_id->login_orb_dma) ||
 		    (sb->ORB_offset_lo == scsi_id->query_logins_orb_dma) ||
-		    (sb->ORB_offset_lo == scsi_id->logout_orb_dma))
-			atomic_set(&scsi_id->sbp2_login_complete, 1);
+		    (sb->ORB_offset_lo == scsi_id->logout_orb_dma)) {
+			scsi_id->access_complete = 1;
+			wake_up_interruptible(&access_wq);
+		}
 	}
 
 	if (SCpnt) {


