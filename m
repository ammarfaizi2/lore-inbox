Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWHNRvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWHNRvM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWHNRvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:51:12 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:9911 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932409AbWHNRvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:51:11 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:49:55 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 5/8] ieee1394: sbp2: better handling of
 transport errors
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
Message-ID: <tkrat.6cd54dd837fe7eba@s5r6.in-berlin.de>
References: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the target signals a transport failure via status block, complete the
request with DID_BUSY to indicate to the SCSI subsystem that the command
may succeed when retried.

Also log diagnostic information if the status block shows a transport
related problem.  It may point to hardware faults.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   16 +++++++++++-----
 drivers/ieee1394/sbp2.h |    6 +++---
 2 files changed, 14 insertions(+), 8 deletions(-)

Index: linux/drivers/ieee1394/sbp2.h
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.h
+++ linux/drivers/ieee1394/sbp2.h
@@ -181,11 +181,11 @@ struct sbp2_unrestricted_page_table {
 #define SBP2_SCSI_STATUS_SELECTION_TIMEOUT	0xff
 
 #define STATUS_GET_SRC(value)			(((value) >> 30) & 0x3)
+#define STATUS_GET_RESP(value)			(((value) >> 28) & 0x3)
 #define STATUS_GET_LEN(value)			(((value) >> 24) & 0x7)
+#define STATUS_GET_SBP_STATUS(value)		(((value) >> 16) & 0xff)
 #define STATUS_GET_ORB_OFFSET_HI(value)		((value) & 0x0000ffff)
-#define STATUS_TEST_D(value)			((value) & 0x08000000)
-/* test 'resp' | 'sbp2_status' */
-#define STATUS_TEST_RS(value)			((value) & 0x30ff0000)
+#define STATUS_TEST_DEAD(value)			((value) & 0x08000000)
 /* test 'resp' | 'dead' | 'sbp2_status' */
 #define STATUS_TEST_RDS(value)			((value) & 0x38ff0000)
 
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c
+++ linux/drivers/ieee1394/sbp2.c
@@ -2223,28 +2223,34 @@ static int sbp2_handle_status_write(stru
 		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
 		if (SCpnt) {
-			if (STATUS_TEST_RS(sb->ORB_offset_hi_misc))
+			u32 h = sb->ORB_offset_hi_misc;
+			u32 r = STATUS_GET_RESP(h);
+
+			if (r != RESP_STATUS_REQUEST_COMPLETE) {
+				SBP2_WARN("resp 0x%x, sbp_status 0x%x",
+					  r, STATUS_GET_SBP_STATUS(h));
 				scsi_status =
+					r == RESP_STATUS_TRANSPORT_FAILURE ?
+					SBP2_SCSI_STATUS_BUSY :
 					SBP2_SCSI_STATUS_COMMAND_TERMINATED;
+			}
 			/*
 			 * See if the target stored any scsi status information.
 			 */
-			if (STATUS_GET_LEN(sb->ORB_offset_hi_misc) > 1) {
+			if (STATUS_GET_LEN(h) > 1) {
 				SBP2_DEBUG("CHECK CONDITION");
 				scsi_status = sbp2_status_to_sense_data(
 					(unchar *)sb, SCpnt->sense_buffer);
 			}
-
 			/*
 			 * Check to see if the dead bit is set. If so, we'll
 			 * have to initiate a fetch agent reset.
 			 */
-			if (STATUS_TEST_D(sb->ORB_offset_hi_misc)) {
+			if (STATUS_TEST_DEAD(h)) {
 				SBP2_DEBUG("Dead bit set - "
 					   "initiating fetch agent reset");
                                 sbp2_agent_reset(scsi_id, 0);
 			}
-
 			SBP2_ORB_DEBUG("completing command orb %p", &command->command_orb);
 		}
 


