Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWGWVAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWGWVAN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 17:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbWGWVAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 17:00:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:48833 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751320AbWGWVAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 17:00:10 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 23 Jul 2006 22:58:42 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc1-mm2 4/6] ieee1394: sbp2: safer initialization of
 status fifo
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
Message-ID: <tkrat.8472ac8ba4249f16@s5r6.in-berlin.de>
References: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.911) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sbp2's copy of the status fifo was cleared when management ORBs or new
command ORBs were prepared.  The latter had potential for a race
condition if the block layer's soft IRQ and the 1394 LLD's interrupt
handler ran on different CPUs.  It would also yield wrong status if a
command was completed with non-zero completion status before other
commands that had zero completion status, and no new command was
enqueued in the meantime.
   
Now, the status buffer is cleared right before it is written.  Thus it
ends up in the following simpler and safer access pattern:
 - sbp2_alloc_device: allocates and implicitly clears once,
 - sbp2_handle_status_write: clears, writes, and reads,
 - sbp2_query_logins, sbp2_login_device, sbp2_reconnect_device: read.
The latter three do not race with sbp2_handle_status_write because of
how the protocol works.

As a tiny optimization, the first two quadlets of the status never need
to be cleared.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   80 +++++++++++++++-------------------------
 1 files changed, 30 insertions(+), 50 deletions(-)

Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-07-23 10:19:29.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-07-23 10:21:07.000000000 +0200
@@ -1182,7 +1182,6 @@ static int sbp2_query_logins(struct scsi
 			     "sbp2 query logins orb", scsi_id->query_logins_orb_dma);
 
 	memset(scsi_id->query_logins_response, 0, sizeof(struct sbp2_query_logins_response));
-	memset(&scsi_id->status_block, 0, sizeof(struct sbp2_status_block));
 
 	data[0] = ORB_SET_NODE_ID(hi->host->node_id);
 	data[1] = scsi_id->query_logins_orb_dma;
@@ -1278,7 +1277,6 @@ static int sbp2_login_device(struct scsi
 			     "sbp2 login orb", scsi_id->login_orb_dma);
 
 	memset(scsi_id->login_response, 0, sizeof(struct sbp2_login_response));
-	memset(&scsi_id->status_block, 0, sizeof(struct sbp2_status_block));
 
 	data[0] = ORB_SET_NODE_ID(hi->host->node_id);
 	data[1] = scsi_id->login_orb_dma;
@@ -1445,14 +1443,6 @@ static int sbp2_reconnect_device(struct 
 	sbp2util_packet_dump(scsi_id->reconnect_orb, sizeof(struct sbp2_reconnect_orb),
 			     "sbp2 reconnect orb", scsi_id->reconnect_orb_dma);
 
-	/*
-	 * Initialize status fifo
-	 */
-	memset(&scsi_id->status_block, 0, sizeof(struct sbp2_status_block));
-
-	/*
-	 * Ok, let's write to the target's management agent register
-	 */
 	data[0] = ORB_SET_NODE_ID(hi->host->node_id);
 	data[1] = scsi_id->reconnect_orb_dma;
 	sbp2util_cpu_to_be32_buffer(data, 8);
@@ -2069,11 +2059,6 @@ static int sbp2_send_command(struct scsi
 			     "sbp2 command orb", command->command_orb_dma);
 
 	/*
-	 * Initialize status fifo
-	 */
-	memset(&scsi_id->status_block, 0, sizeof(struct sbp2_status_block));
-
-	/*
 	 * Link up the orb, and ring the doorbell if needed
 	 */
 	sbp2_link_orb_command(scsi_id, command);
@@ -2114,12 +2099,14 @@ static unsigned int sbp2_status_to_sense
 /*
  * This function deals with status writes from the SBP-2 device
  */
-static int sbp2_handle_status_write(struct hpsb_host *host, int nodeid, int destid,
-				    quadlet_t *data, u64 addr, size_t length, u16 fl)
+static int sbp2_handle_status_write(struct hpsb_host *host, int nodeid,
+				    int destid, quadlet_t *data, u64 addr,
+				    size_t length, u16 fl)
 {
 	struct sbp2scsi_host_info *hi;
 	struct scsi_id_instance_data *scsi_id = NULL, *scsi_id_tmp;
 	struct scsi_cmnd *SCpnt = NULL;
+	struct sbp2_status_block *sb;
 	u32 scsi_status = SBP2_SCSI_STATUS_GOOD;
 	struct sbp2_command_info *command;
 	unsigned long flags;
@@ -2158,19 +2145,21 @@ static int sbp2_handle_status_write(stru
 	}
 
 	/*
-	 * Put response into scsi_id status fifo...
+	 * Put response into scsi_id status fifo buffer. The first two bytes
+	 * come in big endian bit order. Often the target writes only a
+	 * truncated status block, minimally the first two quadlets. The rest
+	 * is implied to be zeros.
 	 */
-	memcpy(&scsi_id->status_block, data, length);
+	sb = &scsi_id->status_block;
+	memset(sb->command_set_dependent, 0, sizeof(sb->command_set_dependent));
+	memcpy(sb, data, length);
+	sbp2util_be32_to_cpu_buffer(sb, 8);
 
 	/*
-	 * Byte swap first two quadlets (8 bytes) of status for processing
+	 * Handle command ORB status here if necessary. First, need to match
+	 * status with command.
 	 */
-	sbp2util_be32_to_cpu_buffer(&scsi_id->status_block, 8);
-
-	/*
-	 * Handle command ORB status here if necessary. First, need to match status with command.
-	 */
-	command = sbp2util_find_command_for_orb(scsi_id, scsi_id->status_block.ORB_offset_lo);
+	command = sbp2util_find_command_for_orb(scsi_id, sb->ORB_offset_lo);
 	if (command) {
 
 		SBP2_DEBUG("Found status for command ORB");
@@ -2185,7 +2174,8 @@ static int sbp2_handle_status_write(stru
 		outstanding_orb_decr;
 
 		/*
-		 * Matched status with command, now grab scsi command pointers and check status
+		 * Matched status with command, now grab scsi command pointers
+		 * and check status.
 		 */
 		SCpnt = command->Current_SCpnt;
 		spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
@@ -2193,28 +2183,22 @@ static int sbp2_handle_status_write(stru
 		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
 		if (SCpnt) {
-
 			/*
-			 * See if the target stored any scsi status information
+			 * See if the target stored any scsi status information.
 			 */
-			if (STATUS_GET_LENGTH(scsi_id->status_block.ORB_offset_hi_misc) > 1) {
-				/*
-				 * Translate SBP-2 status to SCSI sense data
-				 */
+			if (STATUS_GET_LENGTH(sb->ORB_offset_hi_misc) > 1) {
 				SBP2_DEBUG("CHECK CONDITION");
-				scsi_status = sbp2_status_to_sense_data((unchar *)&scsi_id->status_block, SCpnt->sense_buffer);
+				scsi_status = sbp2_status_to_sense_data(
+					(unchar *)sb, SCpnt->sense_buffer);
 			}
 
 			/*
-			 * Check to see if the dead bit is set. If so, we'll have to initiate
-			 * a fetch agent reset.
+			 * Check to see if the dead bit is set. If so, we'll
+			 * have to initiate a fetch agent reset.
 			 */
-			if (STATUS_GET_DEAD_BIT(scsi_id->status_block.ORB_offset_hi_misc)) {
-
-				/*
-				 * Initiate a fetch agent reset.
-				 */
-				SBP2_DEBUG("Dead bit set - initiating fetch agent reset");
+			if (STATUS_GET_DEAD_BIT(sb->ORB_offset_hi_misc)) {
+				SBP2_DEBUG("Dead bit set - "
+					   "initiating fetch agent reset");
                                 sbp2_agent_reset(scsi_id, 0);
 			}
 
@@ -2235,21 +2219,17 @@ static int sbp2_handle_status_write(stru
 		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
 	} else {
-
 		/*
 		 * It's probably a login/logout/reconnect status.
 		 */
-		if ((scsi_id->login_orb_dma == scsi_id->status_block.ORB_offset_lo) ||
-		    (scsi_id->query_logins_orb_dma == scsi_id->status_block.ORB_offset_lo) ||
-		    (scsi_id->reconnect_orb_dma == scsi_id->status_block.ORB_offset_lo) ||
-		    (scsi_id->logout_orb_dma == scsi_id->status_block.ORB_offset_lo)) {
+		if ((sb->ORB_offset_lo == scsi_id->reconnect_orb_dma) ||
+		    (sb->ORB_offset_lo == scsi_id->login_orb_dma) ||
+		    (sb->ORB_offset_lo == scsi_id->query_logins_orb_dma) ||
+		    (sb->ORB_offset_lo == scsi_id->logout_orb_dma))
 			atomic_set(&scsi_id->sbp2_login_complete, 1);
-		}
 	}
 
 	if (SCpnt) {
-
-		/* Complete the SCSI command. */
 		SBP2_DEBUG("Completing SCSI command");
 		sbp2scsi_complete_command(scsi_id, scsi_status, SCpnt,
 					  command->Current_done);


