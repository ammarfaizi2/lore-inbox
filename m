Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932076AbWH0LiP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbWH0LiP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 07:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWH0LiP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 07:38:15 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:44160 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932076AbWH0LiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 07:38:15 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 27 Aug 2006 13:34:59 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4 4/5] ieee1394: sbp2: discard return value of
 sbp2_link_orb_command
To: Linus Torvalds <torvalds@osdl.org>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
Message-ID: <tkrat.1888ec150ee2a9d9@s5r6.in-berlin.de>
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since sbp2 is at the moment unable to do anything with the return value
of sbp2_link_orb_command, just discard it.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux-2.6.18-rc4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/ieee1394/sbp2.c	2006-08-27 12:37:13.000000000 +0200
+++ linux-2.6.18-rc4/drivers/ieee1394/sbp2.c	2006-08-27 12:37:44.000000000 +0200
@@ -1974,7 +1974,7 @@ static void sbp2_create_command_orb(stru
 /*
  * This function is called in order to begin a regular SBP-2 command.
  */
-static int sbp2_link_orb_command(struct scsi_id_instance_data *scsi_id,
+static void sbp2_link_orb_command(struct scsi_id_instance_data *scsi_id,
 				 struct sbp2_command_info *command)
 {
 	struct sbp2scsi_host_info *hi = scsi_id->hi;
@@ -2040,11 +2040,9 @@ static int sbp2_link_orb_command(struct 
 
 	SBP2_ORB_DEBUG("write to %s register, command orb %p",
 			last_orb ? "DOORBELL" : "ORB_POINTER", command_orb);
-	if (sbp2util_node_write_no_wait(scsi_id->ne, addr, data, length) < 0) {
+	if (sbp2util_node_write_no_wait(scsi_id->ne, addr, data, length))
 		SBP2_ERR("sbp2util_node_write_no_wait failed.\n");
-		return -EIO;
-	}
-	return 0;
+	/* We rely on SCSI EH to deal with _node_write_ failures. */
 }
 
 /*
Index: linux-2.6.18-rc4/drivers/ieee1394/sbp2.h
===================================================================
--- linux-2.6.18-rc4.orig/drivers/ieee1394/sbp2.h	2006-08-27 12:37:13.000000000 +0200
+++ linux-2.6.18-rc4/drivers/ieee1394/sbp2.h	2006-08-27 12:37:44.000000000 +0200
@@ -391,11 +391,6 @@ static int sbp2_logout_device(struct scs
 static int sbp2_handle_status_write(struct hpsb_host *host, int nodeid, int destid,
 				    quadlet_t *data, u64 addr, size_t length, u16 flags);
 static int sbp2_agent_reset(struct scsi_id_instance_data *scsi_id, int wait);
-static int sbp2_link_orb_command(struct scsi_id_instance_data *scsi_id,
-				 struct sbp2_command_info *command);
-static int sbp2_send_command(struct scsi_id_instance_data *scsi_id,
-			     struct scsi_cmnd *SCpnt,
-			     void (*done)(struct scsi_cmnd *));
 static unsigned int sbp2_status_to_sense_data(unchar *sbp2_status,
 					      unchar *sense_data);
 static void sbp2_parse_unit_directory(struct scsi_id_instance_data *scsi_id,


