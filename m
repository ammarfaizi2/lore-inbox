Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWGWU5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWGWU5m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 16:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751317AbWGWU5m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 16:57:42 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:27841 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751316AbWGWU5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 16:57:42 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 23 Jul 2006 22:56:07 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc1-mm2 2/6] ieee1394: sbp2: discard return value of
 sbp2_link_orb_command
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
Message-ID: <tkrat.b6336d1c43109bd5@s5r6.in-berlin.de>
References: <tkrat.25e69df87688def6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.91) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since sbp2 is at the moment unable to do anything with the return value
of sbp2_link_orb_command, just discard it.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |    8 +++-----
 drivers/ieee1394/sbp2.h |    5 -----
 2 files changed, 3 insertions(+), 10 deletions(-)

TODO:
Alas sbp2 initiates 1394 write requests to the target's ORB_POINTER and
DOORBELL registers from atomic context.  These write transactions should
be moved into non-atomic context, i.e. a kthread or workqueue.  That way
typical failures of sbp2util_node_write_no_wait can be avoided in the
first place, and there are better possibilities to recover from
remaining failures.

Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-07-23 10:11:10.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-07-23 10:26:32.000000000 +0200
@@ -1964,7 +1964,7 @@ static void sbp2_create_command_orb(stru
 /*
  * This function is called in order to begin a regular SBP-2 command.
  */
-static int sbp2_link_orb_command(struct scsi_id_instance_data *scsi_id,
+static void sbp2_link_orb_command(struct scsi_id_instance_data *scsi_id,
 				 struct sbp2_command_info *command)
 {
 	struct sbp2scsi_host_info *hi = scsi_id->hi;
@@ -2030,11 +2030,9 @@ static int sbp2_link_orb_command(struct 
 
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
Index: linux/drivers/ieee1394/sbp2.h
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.h	2006-07-23 10:08:51.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.h	2006-07-23 10:23:26.000000000 +0200
@@ -390,11 +390,6 @@ static int sbp2_logout_device(struct scs
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



