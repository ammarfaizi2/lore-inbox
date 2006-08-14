Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWHNRt1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWHNRt1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWHNRt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:49:27 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:60342 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932479AbWHNRtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:49:25 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:48:17 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 4/8] ieee1394: sbp2: recheck node generation in
 sbp2_update
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
Message-ID: <tkrat.791447945588f08e@s5r6.in-berlin.de>
References: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While sbp2_update() is doing its duties after a bus reset, another reset
could happen.  Don't accept new requests until the next undisturbed
sbp2_update() or until sbp2_remove().

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-08-14 00:22:32.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-08-14 00:27:15.000000000 +0200
@@ -812,11 +812,12 @@ static int sbp2_update(struct unit_direc
 	 */
 	sbp2scsi_complete_all_commands(scsi_id, DID_BUS_BUSY);
 
-	/* Make sure we unblock requests (since this is likely after a bus
-	 * reset). */
-	atomic_set(&scsi_id->unfinished_reset, 0);
-	scsi_unblock_requests(scsi_id->scsi_host);
-
+	/* Accept new commands unless there was another bus reset in the
+	 * meantime. */
+	if (hpsb_node_entry_valid(scsi_id->ne)) {
+		atomic_set(&scsi_id->unfinished_reset, 0);
+		scsi_unblock_requests(scsi_id->scsi_host);
+	}
 	return 0;
 }
 


