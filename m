Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932444AbWHNRq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932444AbWHNRq6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 13:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932447AbWHNRq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 13:46:58 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:36022 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S932444AbWHNRq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 13:46:57 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 14 Aug 2006 19:45:53 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 2.6.18-rc4-mm1 2/8] ieee1394: sbp2: handle
 "sbp2util_node_write_no_wait failed"
To: linux1394-devel@lists.sourceforge.net
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
Message-ID: <tkrat.35f4f9241b5ff7d7@s5r6.in-berlin.de>
References: <tkrat.9b22090d7dd50b12@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix for http://bugzilla.kernel.org/show_bug.cgi?id=6948

Because sbp2 writes to the target's fetch agent's registers from within
atomic context, it cannot sleep to guaranteedly get a free transaction
label.  This may repeatedly lead to "sbp2util_node_write_no_wait failed"
and consequently to SCSI command abortion after timeout.  A likely cause
is that many queue_command softirqs may occur before khpsbpkt (the
ieee1394 driver's thread which cleans up after finished transactions) is
woken up to recycle tlabels.

Sbp2 now schedules a workqueue job whenever sbp2_link_orb_command fails
in sbp2util_node_write_no_wait.  The job will reliably get a transaction
label because it can sleep.

We use the kernel-wide shared workqueue because it is unlikely that the
job itself actually needs to sleep.  In the improbable case that it has
to sleep, it doesn't need to sleep long since the standard transaction
timeout is 100ms.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   71 +++++++++++++++++++++++++++++++++++++---
 drivers/ieee1394/sbp2.h |    3 +
 2 files changed, 69 insertions(+), 5 deletions(-)

Index: linux/drivers/ieee1394/sbp2.h
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.h	2006-08-13 23:40:12.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.h	2006-08-14 00:21:34.000000000 +0200
@@ -347,6 +347,9 @@ struct scsi_id_instance_data {
 
 	/* Device specific workarounds/brokeness */
 	unsigned workarounds;
+
+	atomic_t unfinished_reset;
+	struct work_struct protocol_work;
 };
 
 /* Sbp2 host data structure (one per IEEE1394 host) */
Index: linux/drivers/ieee1394/sbp2.c
===================================================================
--- linux.orig/drivers/ieee1394/sbp2.c	2006-08-14 00:20:26.000000000 +0200
+++ linux/drivers/ieee1394/sbp2.c	2006-08-14 00:21:55.000000000 +0200
@@ -475,6 +475,44 @@ static int sbp2util_node_write_no_wait(s
 	return 0;
 }
 
+static void sbp2util_notify_fetch_agent(struct scsi_id_instance_data *scsi_id,
+					u64 offset, quadlet_t *data, size_t len)
+{
+	/*
+	 * There is a small window after a bus reset within which the node
+	 * entry's generation is current but the reconnect wasn't completed.
+	 */
+	if (atomic_read(&scsi_id->unfinished_reset))
+		return;
+
+	if (hpsb_node_write(scsi_id->ne,
+			    scsi_id->sbp2_command_block_agent_addr + offset,
+			    data, len))
+		SBP2_ERR("sbp2util_notify_fetch_agent failed.");
+	/*
+	 * Now accept new SCSI commands, unless a bus reset happended during
+	 * hpsb_node_write.
+	 */
+	if (!atomic_read(&scsi_id->unfinished_reset))
+		scsi_unblock_requests(scsi_id->scsi_host);
+}
+
+static void sbp2util_write_orb_pointer(void *p)
+{
+	quadlet_t data[2];
+
+	data[0] = ORB_SET_NODE_ID(
+			((struct scsi_id_instance_data *)p)->hi->host->node_id);
+	data[1] = ((struct scsi_id_instance_data *)p)->last_orb_dma;
+	sbp2util_cpu_to_be32_buffer(data, 8);
+	sbp2util_notify_fetch_agent(p, SBP2_ORB_POINTER_OFFSET, data, 8);
+}
+
+static void sbp2util_write_doorbell(void *p)
+{
+	sbp2util_notify_fetch_agent(p, SBP2_DOORBELL_OFFSET, NULL, 4);
+}
+
 /*
  * This function is called to create a pool of command orbs used for
  * command processing. It is called when a new sbp2 device is detected.
@@ -722,6 +760,7 @@ static int sbp2_remove(struct device *de
 			sbp2scsi_complete_all_commands(scsi_id, DID_NO_CONNECT);
 		/* scsi_remove_device() will trigger shutdown functions of SCSI
 		 * highlevel drivers which would deadlock if blocked. */
+		atomic_set(&scsi_id->unfinished_reset, 0);
 		scsi_unblock_requests(scsi_id->scsi_host);
 	}
 	sdev = scsi_id->sdev;
@@ -775,6 +814,7 @@ static int sbp2_update(struct unit_direc
 
 	/* Make sure we unblock requests (since this is likely after a bus
 	 * reset). */
+	atomic_set(&scsi_id->unfinished_reset, 0);
 	scsi_unblock_requests(scsi_id->scsi_host);
 
 	return 0;
@@ -805,6 +845,8 @@ static struct scsi_id_instance_data *sbp
 	INIT_LIST_HEAD(&scsi_id->sbp2_command_orb_completed);
 	INIT_LIST_HEAD(&scsi_id->scsi_list);
 	spin_lock_init(&scsi_id->sbp2_command_orb_lock);
+	atomic_set(&scsi_id->unfinished_reset, 0);
+	INIT_WORK(&scsi_id->protocol_work, NULL, NULL);
 
 	ud->device.driver_data = scsi_id;
 
@@ -889,8 +931,10 @@ static void sbp2_host_reset(struct hpsb_
 	hi = hpsb_get_hostinfo(&sbp2_highlevel, host);
 
 	if (hi) {
-		list_for_each_entry(scsi_id, &hi->scsi_ids, scsi_list)
+		list_for_each_entry(scsi_id, &hi->scsi_ids, scsi_list) {
+			atomic_set(&scsi_id->unfinished_reset, 1);
 			scsi_block_requests(scsi_id->scsi_host);
+		}
 	}
 }
 
@@ -1042,7 +1086,7 @@ static void sbp2_remove_device(struct sc
 		scsi_remove_host(scsi_id->scsi_host);
 		scsi_host_put(scsi_id->scsi_host);
 	}
-
+	flush_scheduled_work();
 	sbp2util_remove_command_orb_pool(scsi_id);
 
 	list_del(&scsi_id->scsi_list);
@@ -1671,6 +1715,10 @@ static int sbp2_agent_reset(struct scsi_
 
 	SBP2_DEBUG_ENTER();
 
+	cancel_delayed_work(&scsi_id->protocol_work);
+	if (wait)
+		flush_scheduled_work();
+
 	data = ntohl(SBP2_AGENT_RESET_DATA);
 	addr = scsi_id->sbp2_command_block_agent_addr + SBP2_AGENT_RESET_OFFSET;
 
@@ -1992,9 +2040,22 @@ static void sbp2_link_orb_command(struct
 
 	SBP2_ORB_DEBUG("write to %s register, command orb %p",
 			last_orb ? "DOORBELL" : "ORB_POINTER", command_orb);
-	if (sbp2util_node_write_no_wait(scsi_id->ne, addr, data, length))
-		SBP2_ERR("sbp2util_node_write_no_wait failed.\n");
-	/* We rely on SCSI EH to deal with _node_write_ failures. */
+	if (sbp2util_node_write_no_wait(scsi_id->ne, addr, data, length)) {
+		/*
+		 * sbp2util_node_write_no_wait failed. We certainly ran out
+		 * of transaction labels, perhaps just because there were no
+		 * context switches which gave khpsbpkt a chance to collect
+		 * free tlabels. Try again in non-atomic context. If necessary,
+		 * the workqueue job will sleep to guaranteedly get a tlabel.
+		 * We do not accept new commands until the job is over.
+		 */
+		scsi_block_requests(scsi_id->scsi_host);
+		PREPARE_WORK(&scsi_id->protocol_work,
+			     last_orb ? sbp2util_write_doorbell:
+					sbp2util_write_orb_pointer,
+			     scsi_id);
+		schedule_work(&scsi_id->protocol_work);
+	}
 }
 
 /*



