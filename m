Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWBZXyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWBZXyL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 18:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWBZXyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 18:54:11 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59029 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750750AbWBZXyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 18:54:09 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 27 Feb 2006 00:52:53 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.15.4] sbp2: fix another deadlock after disconnection
To: stable@kernel.org
cc: linux-kernel@vger.kernel.org
Message-ID: <tkrat.efa2081c5664aec6@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (-0.508) AWL,BAYES_05
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2: fix another deadlock after disconnection

If there were commands enqueued but not completed before an SBP-2 unit
was unplugged (or an attempt to reconnect failed), knodemgrd or any
process which tried to remove the device would sleep uninterruptibly
in blk_execute_rq().  Therefore make sure that all commands are
completed when sbp2 retreats.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Same as commit bf637ec3ef4159da3dd156ecf6f6987d8c8c5dae in Linus' tree.

Index: linux-2.6.15.4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.15.4.orig/drivers/ieee1394/sbp2.c	2006-02-27 00:29:50.000000000 +0100
+++ linux-2.6.15.4/drivers/ieee1394/sbp2.c	2006-02-27 00:31:19.000000000 +0100
@@ -650,9 +650,15 @@ static int sbp2_remove(struct device *de
 	if (!scsi_id)
 		return 0;
 
-	/* Trigger shutdown functions in scsi's highlevel. */
-	if (scsi_id->scsi_host)
+	if (scsi_id->scsi_host) {
+		/* Get rid of enqueued commands if there is no chance to
+		 * send them. */
+		if (!sbp2util_node_is_available(scsi_id))
+			sbp2scsi_complete_all_commands(scsi_id, DID_NO_CONNECT);
+		/* scsi_remove_device() will trigger shutdown functions of SCSI
+		 * highlevel drivers which would deadlock if blocked. */
 		scsi_unblock_requests(scsi_id->scsi_host);
+	}
 	sdev = scsi_id->sdev;
 	if (sdev) {
 		scsi_id->sdev = NULL;


