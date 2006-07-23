Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751324AbWGWVBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751324AbWGWVBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWGWVBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:01:14 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:1986 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751324AbWGWVBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:01:13 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 23 Jul 2006 22:59:47 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc1-mm2 5/6] ieee1394: sbp2: more checks of status
 block
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
Message-ID: <tkrat.1e07144d0042077e@s5r6.in-berlin.de>
References: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.912) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Add checks for the (very unlikely) cases that the target writes too
   little or too much status data or writes unsolicited status.
 - Indicate that these and similar conditions are unlikely().
 - Check the 'resp' and 'sbp_status' fields for possible failure status.
 - Slightly optimize access macros for the status block bitfields.
 - Unify a few related log messages.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   70 +++++++++++++++++-----------------------
 drivers/ieee1394/sbp2.h |   14 ++++----
 2 files changed, 38 insertions(+), 46 deletions(-)

TODO:
Check if status' 'src'==1, then withhold the respective ORB from reuse
until status for any subsequent ORB was received.

Index: linux/drivers/ieee1394/sbp2.h
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.h	2006-07-23 10:11:34.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.h	2006-07-23 10:21:31.000000000 +0200
@@ -180,12 +180,14 @@ struct sbp2_unrestricted_page_table {
 
 #define SBP2_SCSI_STATUS_SELECTION_TIMEOUT	0xff
 
-#define STATUS_GET_ORB_OFFSET_HI(value)         (value & 0xffff)
-#define STATUS_GET_SBP_STATUS(value)            ((value >> 16) & 0xff)
-#define STATUS_GET_LENGTH(value)                ((value >> 24) & 0x7)
-#define STATUS_GET_DEAD_BIT(value)              ((value >> 27) & 0x1)
-#define STATUS_GET_RESP(value)                  ((value >> 28) & 0x3)
-#define STATUS_GET_SRC(value)                   ((value >> 30) & 0x3)
+#define STATUS_GET_SRC(value)			(((value) >> 30) & 0x3)
+#define STATUS_GET_LEN(value)			(((value) >> 24) & 0x7)
+#define STATUS_GET_ORB_OFFSET_HI(value)		((value) & 0x0000ffff)
+#define STATUS_TEST_D(value)			((value) & 0x08000000)
+/* test 'resp' | 'sbp2_status' */
+#define STATUS_TEST_RS(value)			((value) & 0x30ff0000)
+/* test 'resp' | 'dead' | 'sbp2_status' */
+#define STATUS_TEST_RDS(value)			((value) & 0x38ff0000)
 
 struct sbp2_status_block {
 	u32 ORB_offset_hi_misc;
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-07-23 10:21:07.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-07-23 10:21:31.000000000 +0200
@@ -1201,11 +1201,8 @@ static int sbp2_query_logins(struct scsi
 		return -EIO;
 	}
 
-	if (STATUS_GET_RESP(scsi_id->status_block.ORB_offset_hi_misc) ||
-	    STATUS_GET_DEAD_BIT(scsi_id->status_block.ORB_offset_hi_misc) ||
-	    STATUS_GET_SBP_STATUS(scsi_id->status_block.ORB_offset_hi_misc)) {
-
-		SBP2_INFO("Error querying logins to SBP-2 device - timed out");
+	if (STATUS_TEST_RDS(scsi_id->status_block.ORB_offset_hi_misc)) {
+		SBP2_INFO("Error querying logins to SBP-2 device - failed");
 		return -EIO;
 	}
 
@@ -1298,18 +1295,12 @@ static int sbp2_login_device(struct scsi
 	 * Sanity. Make sure status returned matches login orb.
 	 */
 	if (scsi_id->status_block.ORB_offset_lo != scsi_id->login_orb_dma) {
-		SBP2_ERR("Error logging into SBP-2 device - login timed-out");
+		SBP2_ERR("Error logging into SBP-2 device - timed out");
 		return -EIO;
 	}
 
-	/*
-	 * Check status
-	 */
-	if (STATUS_GET_RESP(scsi_id->status_block.ORB_offset_hi_misc) ||
-	    STATUS_GET_DEAD_BIT(scsi_id->status_block.ORB_offset_hi_misc) ||
-	    STATUS_GET_SBP_STATUS(scsi_id->status_block.ORB_offset_hi_misc)) {
-
-		SBP2_ERR("Error logging into SBP-2 device - login failed");
+	if (STATUS_TEST_RDS(scsi_id->status_block.ORB_offset_hi_misc)) {
+		SBP2_ERR("Error logging into SBP-2 device - failed");
 		return -EIO;
 	}
 
@@ -1333,9 +1324,7 @@ static int sbp2_login_device(struct scsi
 	scsi_id->sbp2_command_block_agent_addr &= 0x0000ffffffffffffULL;
 
 	SBP2_INFO("Logged into SBP-2 device");
-
 	return 0;
-
 }
 
 /*
@@ -1466,25 +1455,17 @@ static int sbp2_reconnect_device(struct 
 	 * Sanity. Make sure status returned matches reconnect orb.
 	 */
 	if (scsi_id->status_block.ORB_offset_lo != scsi_id->reconnect_orb_dma) {
-		SBP2_ERR("Error reconnecting to SBP-2 device - reconnect timed-out");
+		SBP2_ERR("Error reconnecting to SBP-2 device - timed out");
 		return -EIO;
 	}
 
-	/*
-	 * Check status
-	 */
-	if (STATUS_GET_RESP(scsi_id->status_block.ORB_offset_hi_misc) ||
-	    STATUS_GET_DEAD_BIT(scsi_id->status_block.ORB_offset_hi_misc) ||
-	    STATUS_GET_SBP_STATUS(scsi_id->status_block.ORB_offset_hi_misc)) {
-
-		SBP2_ERR("Error reconnecting to SBP-2 device - reconnect failed");
+	if (STATUS_TEST_RDS(scsi_id->status_block.ORB_offset_hi_misc)) {
+		SBP2_ERR("Error reconnecting to SBP-2 device - failed");
 		return -EIO;
 	}
 
 	HPSB_DEBUG("Reconnected to SBP-2 device");
-
 	return 0;
-
 }
 
 /*
@@ -2115,18 +2096,19 @@ static int sbp2_handle_status_write(stru
 
 	sbp2util_packet_dump(data, length, "sbp2 status write by device", (u32)addr);
 
-	if (!host) {
+	if (unlikely(length < 8 || length > sizeof(struct sbp2_status_block))) {
+		SBP2_ERR("Wrong size of status block");
+		return RCODE_ADDRESS_ERROR;
+	}
+	if (unlikely(!host)) {
 		SBP2_ERR("host is NULL - this is bad!");
 		return RCODE_ADDRESS_ERROR;
 	}
-
 	hi = hpsb_get_hostinfo(&sbp2_highlevel, host);
-
-	if (!hi) {
+	if (unlikely(!hi)) {
 		SBP2_ERR("host info is NULL - this is bad!");
 		return RCODE_ADDRESS_ERROR;
 	}
-
 	/*
 	 * Find our scsi_id structure by looking at the status fifo address
 	 * written to by the sbp2 device.
@@ -2138,8 +2120,7 @@ static int sbp2_handle_status_write(stru
 			break;
 		}
 	}
-
-	if (!scsi_id) {
+	if (unlikely(!scsi_id)) {
 		SBP2_ERR("scsi_id is NULL - device is gone?");
 		return RCODE_ADDRESS_ERROR;
 	}
@@ -2156,12 +2137,14 @@ static int sbp2_handle_status_write(stru
 	sbp2util_be32_to_cpu_buffer(sb, 8);
 
 	/*
-	 * Handle command ORB status here if necessary. First, need to match
-	 * status with command.
+	 * Ignore unsolicited status. Handle command ORB status.
 	 */
-	command = sbp2util_find_command_for_orb(scsi_id, sb->ORB_offset_lo);
+	if (unlikely(STATUS_GET_SRC(sb->ORB_offset_hi_misc) == 2))
+		command = NULL;
+	else
+		command = sbp2util_find_command_for_orb(scsi_id,
+							sb->ORB_offset_lo);
 	if (command) {
-
 		SBP2_DEBUG("Found status for command ORB");
 		pci_dma_sync_single_for_cpu(hi->host->pdev, command->command_orb_dma,
 					    sizeof(struct sbp2_command_orb),
@@ -2177,16 +2160,23 @@ static int sbp2_handle_status_write(stru
 		 * Matched status with command, now grab scsi command pointers
 		 * and check status.
 		 */
+		/*
+		 * FIXME: If the src field in the status is 1, the ORB DMA must
+		 * not be reused until status for a subsequent ORB is received.
+		 */
 		SCpnt = command->Current_SCpnt;
 		spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
 		sbp2util_mark_command_completed(scsi_id, command);
 		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
 		if (SCpnt) {
+			if (STATUS_TEST_RS(sb->ORB_offset_hi_misc))
+				scsi_status =
+					SBP2_SCSI_STATUS_COMMAND_TERMINATED;
 			/*
 			 * See if the target stored any scsi status information.
 			 */
-			if (STATUS_GET_LENGTH(sb->ORB_offset_hi_misc) > 1) {
+			if (STATUS_GET_LEN(sb->ORB_offset_hi_misc) > 1) {
 				SBP2_DEBUG("CHECK CONDITION");
 				scsi_status = sbp2_status_to_sense_data(
 					(unchar *)sb, SCpnt->sense_buffer);
@@ -2196,7 +2186,7 @@ static int sbp2_handle_status_write(stru
 			 * Check to see if the dead bit is set. If so, we'll
 			 * have to initiate a fetch agent reset.
 			 */
-			if (STATUS_GET_DEAD_BIT(sb->ORB_offset_hi_misc)) {
+			if (STATUS_TEST_D(sb->ORB_offset_hi_misc)) {
 				SBP2_DEBUG("Dead bit set - "
 					   "initiating fetch agent reset");
                                 sbp2_agent_reset(scsi_id, 0);


