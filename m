Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932212AbWHNRyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932212AbWHNRyW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbWHNRyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:54:22 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41143 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932212AbWHNRyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:54:20 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:53:18 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 8/8] ieee1394: sbp2: prevent rare deadlock in
 shutdown
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
Message-ID: <tkrat.fee9f136ea5d8e54@s5r6.in-berlin.de>
References: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scsi_remove_device() may go into uninterruptible sleep if blocked.
Therefore sbp2_remove() unblocks the Scsi_Host before the device is
requested to be removed.  But there could be another 1394 bus reset
after that which would block the host again.  The 1394 subsystem won't
call sbp2_update() concurrently to sbp2_remove(), which is why there is
no chance for sbp2_remove() to be unblocked by sbp2_update().

The fix is to tell sbp2's bus reset handler when a device is to be shut
down so that it skips scsi_block_requests() on that host.  As before,
any new commands after a reset without reconnect will be failed quickly
by sbp2scsi_queuecommand().

In the long term, means to go without scsi_block_requests() should be
found.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   21 +++++++++++----------
 drivers/ieee1394/sbp2.h |    9 ++++++++-
 2 files changed, 19 insertions(+), 11 deletions(-)

Index: linux/drivers/ieee1394/sbp2.h
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.h	2006-08-14 12:46:13.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.h	2006-08-14 17:21:32.000000000 +0200
@@ -348,10 +348,17 @@ struct scsi_id_instance_data {
 	/* Device specific workarounds/brokeness */
 	unsigned workarounds;
 
-	atomic_t unfinished_reset;
+	atomic_t state;
 	struct work_struct protocol_work;
 };
 
+/* For use in scsi_id_instance_data.state */
+enum sbp2lu_state_types {
+	SBP2LU_STATE_RUNNING,		/* all normal */
+	SBP2LU_STATE_IN_RESET,		/* between bus reset and reconnect */
+	SBP2LU_STATE_IN_SHUTDOWN	/* when sbp2_remove was called */
+};
+
 /* Sbp2 host data structure (one per IEEE1394 host) */
 struct sbp2scsi_host_info {
 	struct hpsb_host *host;		/* IEEE1394 host */
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-08-14 12:46:15.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-08-14 12:46:16.000000000 +0200
@@ -488,7 +488,7 @@ static void sbp2util_notify_fetch_agent(
 	 * There is a small window after a bus reset within which the node
 	 * entry's generation is current but the reconnect wasn't completed.
 	 */
-	if (atomic_read(&scsi_id->unfinished_reset))
+	if (unlikely(atomic_read(&scsi_id->state) == SBP2LU_STATE_IN_RESET))
 		return;
 
 	if (hpsb_node_write(scsi_id->ne,
@@ -499,7 +499,7 @@ static void sbp2util_notify_fetch_agent(
 	 * Now accept new SCSI commands, unless a bus reset happended during
 	 * hpsb_node_write.
 	 */
-	if (!atomic_read(&scsi_id->unfinished_reset))
+	if (likely(atomic_read(&scsi_id->state) != SBP2LU_STATE_IN_RESET))
 		scsi_unblock_requests(scsi_id->scsi_host);
 }
 
@@ -766,7 +766,7 @@ static int sbp2_remove(struct device *de
 			sbp2scsi_complete_all_commands(scsi_id, DID_NO_CONNECT);
 		/* scsi_remove_device() will trigger shutdown functions of SCSI
 		 * highlevel drivers which would deadlock if blocked. */
-		atomic_set(&scsi_id->unfinished_reset, 0);
+		atomic_set(&scsi_id->state, SBP2LU_STATE_IN_SHUTDOWN);
 		scsi_unblock_requests(scsi_id->scsi_host);
 	}
 	sdev = scsi_id->sdev;
@@ -821,7 +821,7 @@ static int sbp2_update(struct unit_direc
 	/* Accept new commands unless there was another bus reset in the
 	 * meantime. */
 	if (hpsb_node_entry_valid(scsi_id->ne)) {
-		atomic_set(&scsi_id->unfinished_reset, 0);
+		atomic_set(&scsi_id->state, SBP2LU_STATE_RUNNING);
 		scsi_unblock_requests(scsi_id->scsi_host);
 	}
 	return 0;
@@ -852,7 +852,7 @@ static struct scsi_id_instance_data *sbp
 	INIT_LIST_HEAD(&scsi_id->sbp2_command_orb_completed);
 	INIT_LIST_HEAD(&scsi_id->scsi_list);
 	spin_lock_init(&scsi_id->sbp2_command_orb_lock);
-	atomic_set(&scsi_id->unfinished_reset, 0);
+	atomic_set(&scsi_id->state, SBP2LU_STATE_RUNNING);
 	INIT_WORK(&scsi_id->protocol_work, NULL, NULL);
 
 	ud->device.driver_data = scsi_id;
@@ -936,13 +936,14 @@ static void sbp2_host_reset(struct hpsb_
 	struct scsi_id_instance_data *scsi_id;
 
 	hi = hpsb_get_hostinfo(&sbp2_highlevel, host);
-
-	if (hi) {
-		list_for_each_entry(scsi_id, &hi->scsi_ids, scsi_list) {
-			atomic_set(&scsi_id->unfinished_reset, 1);
+	if (!hi)
+		return;
+	list_for_each_entry(scsi_id, &hi->scsi_ids, scsi_list)
+		if (likely(atomic_read(&scsi_id->state) !=
+			   SBP2LU_STATE_IN_SHUTDOWN)) {
+			atomic_set(&scsi_id->state, SBP2LU_STATE_IN_RESET);
 			scsi_block_requests(scsi_id->scsi_host);
 		}
-	}
 }
 
 /*


