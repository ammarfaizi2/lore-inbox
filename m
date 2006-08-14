Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932447AbWHNRsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbWHNRsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWHNRsg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:48:36 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50614 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932447AbWHNRsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:48:35 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:47:18 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 3/8] ieee1394: sbp2: safer agent reset in error
 handlers
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
Message-ID: <tkrat.86ddb7884efd1aa6@s5r6.in-berlin.de>
References: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
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
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-08-14 00:21:55.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-08-14 00:22:32.000000000 +0200
@@ -2588,7 +2588,7 @@ static int sbp2scsi_abort(struct scsi_cm
 		/*
 		 * Initiate a fetch agent reset.
 		 */
-		sbp2_agent_reset(scsi_id, 0);
+		sbp2_agent_reset(scsi_id, 1);
 		sbp2scsi_complete_all_commands(scsi_id, DID_BUS_BUSY);
 	}
 
@@ -2607,7 +2607,7 @@ static int sbp2scsi_reset(struct scsi_cm
 
 	if (sbp2util_node_is_available(scsi_id)) {
 		SBP2_ERR("Generating sbp2 fetch agent reset");
-		sbp2_agent_reset(scsi_id, 0);
+		sbp2_agent_reset(scsi_id, 1);
 	}
 
 	return SUCCESS;


