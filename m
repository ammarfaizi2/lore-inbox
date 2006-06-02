Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbWFBULn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbWFBULn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWFBULn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:11:43 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:63697 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932530AbWFBULl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:11:41 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Fri, 2 Jun 2006 22:10:08 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.17-rc5-mm2 09/18] sbp2: remove manipulation of inquiry
 response
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>,
       Ben Collins <bcollins@ubuntu.com>
In-Reply-To: <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
Message-ID: <tkrat.9a30b61b3f17e5ac@s5r6.in-berlin.de>
References: <tkrat.10011841414bfa88@s5r6.in-berlin.de>
 <tkrat.31172d1c0b7ae8e8@s5r6.in-berlin.de>
 <tkrat.51c50df7e692bbfa@s5r6.in-berlin.de>
 <tkrat.f22d0694697e6d7a@s5r6.in-berlin.de>
 <tkrat.ecb0be3f1632e232@s5r6.in-berlin.de>
 <tkrat.687a0a2c67fa40c6@s5r6.in-berlin.de>
 <tkrat.f35772c971022262@s5r6.in-berlin.de>
 <tkrat.df7a29e56d67dd0a@s5r6.in-berlin.de>
 <tkrat.29d9bcd5406eb937@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.886) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code became ineffective a few Linux releases ago and is not
required anyway.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>

Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/sbp2.c	2006-06-01 20:55:42.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.c	2006-06-01 20:55:43.000000000 +0200
@@ -2112,33 +2112,6 @@ static unsigned int sbp2_status_to_sense
 }
 
 /*
- * This function is called after a command is completed, in order to do any necessary SBP-2
- * response data translations for the SCSI stack
- */
-static void sbp2_check_sbp2_response(struct scsi_id_instance_data *scsi_id,
-				     struct scsi_cmnd *SCpnt)
-{
-	u8 *scsi_buf = SCpnt->request_buffer;
-
-	SBP2_DEBUG_ENTER();
-
-	if (SCpnt->cmnd[0] == INQUIRY && (SCpnt->cmnd[1] & 3) == 0) {
-		/*
-		 * Make sure data length is ok. Minimum length is 36 bytes
-		 */
-		if (scsi_buf[4] == 0) {
-			scsi_buf[4] = 36 - 5;
-		}
-
-		/*
-		 * Fix ansi revision and response data format
-		 */
-		scsi_buf[2] |= 2;
-		scsi_buf[3] = (scsi_buf[3] & 0xf0) | 2;
-	}
-}
-
-/*
  * This function deals with status writes from the SBP-2 device
  */
 static int sbp2_handle_status_write(struct hpsb_host *host, int nodeid, int destid,
@@ -2477,13 +2450,6 @@ static void sbp2scsi_complete_command(st
 	}
 
 	/*
-	 * Take care of any sbp2 response data mucking here (RBC stuff, etc.)
-	 */
-	if (SCpnt->result == DID_OK << 16) {
-		sbp2_check_sbp2_response(scsi_id, SCpnt);
-	}
-
-	/*
 	 * If a bus reset is in progress and there was an error, complete
 	 * the command as busy so that it will get retried.
 	 */
Index: linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.17-rc5-mm2.orig/drivers/ieee1394/sbp2.h	2006-06-01 20:55:04.000000000 +0200
+++ linux-2.6.17-rc5-mm2/drivers/ieee1394/sbp2.h	2006-06-01 20:55:43.000000000 +0200
@@ -395,9 +395,8 @@ static int sbp2_link_orb_command(struct 
 static int sbp2_send_command(struct scsi_id_instance_data *scsi_id,
 			     struct scsi_cmnd *SCpnt,
 			     void (*done)(struct scsi_cmnd *));
-static unsigned int sbp2_status_to_sense_data(unchar *sbp2_status, unchar *sense_data);
-static void sbp2_check_sbp2_response(struct scsi_id_instance_data *scsi_id,
-				     struct scsi_cmnd *SCpnt);
+static unsigned int sbp2_status_to_sense_data(unchar *sbp2_status,
+					      unchar *sense_data);
 static void sbp2_parse_unit_directory(struct scsi_id_instance_data *scsi_id,
 				      struct unit_directory *ud);
 static int sbp2_set_busy_timeout(struct scsi_id_instance_data *scsi_id);


