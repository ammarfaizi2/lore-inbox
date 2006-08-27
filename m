Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750976AbWH0Lau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750976AbWH0Lau (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 07:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750981AbWH0Lat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 07:30:49 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59117 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1750976AbWH0Lat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 07:30:49 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sun, 27 Aug 2006 13:27:34 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4 2/5] ieee1394: sbp2: safer agent reset in error
 handlers
To: Linus Torvalds <torvalds@osdl.org>
cc: Ben Collins <bcollins@ubuntu.com>, linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
Message-ID: <tkrat.12ec5ccf1e05e90e@s5r6.in-berlin.de>
References: <tkrat.bbaf8d081f6a31b7@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scsi_host_template's eh_abort_handler and eh_device_reset_handler
are allowed to sleep.  Use this to run sbp2_agent_reset in the more
reliable mode which returns _after_ its write transaction was finished.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux-2.6.18-rc4/drivers/ieee1394/sbp2.c
===================================================================
--- linux-2.6.18-rc4.orig/drivers/ieee1394/sbp2.c	2006-08-27 12:35:40.000000000 +0200
+++ linux-2.6.18-rc4/drivers/ieee1394/sbp2.c	2006-08-27 12:36:50.000000000 +0200
@@ -2583,7 +2583,7 @@ static int sbp2scsi_abort(struct scsi_cm
 		/*
 		 * Initiate a fetch agent reset.
 		 */
-		sbp2_agent_reset(scsi_id, 0);
+		sbp2_agent_reset(scsi_id, 1);
 		sbp2scsi_complete_all_commands(scsi_id, DID_BUS_BUSY);
 	}
 
@@ -2602,7 +2602,7 @@ static int sbp2scsi_reset(struct scsi_cm
 
 	if (sbp2util_node_is_available(scsi_id)) {
 		SBP2_ERR("Generating sbp2 fetch agent reset");
-		sbp2_agent_reset(scsi_id, 0);
+		sbp2_agent_reset(scsi_id, 1);
 	}
 
 	return SUCCESS;


