Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163542AbWLGWml@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163542AbWLGWml (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163548AbWLGWmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:42:40 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:55785 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1163542AbWLGWmj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:42:39 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <457898D1.2090605@s5r6.in-berlin.de>
Date: Thu, 07 Dec 2006 23:42:25 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux1394-devel@lists.sourceforge.net
CC: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org
Subject: sbp2 workqueue patches
X-Enigmail-Version: 0.94.0.0
Content-Type: multipart/mixed;
 boundary="------------010100040305060102030609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010100040305060102030609
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Just for the record: I inserted the following two patches into my local
git tree while preparing the patch queue for Linus and will push them to
linux1394-2.6.git now.
-- 
Stefan Richter
-=====-=-==- ==-- --===
http://arcgraph.de/sr/

--------------010100040305060102030609
Content-Type: text/plain;
 name="218-ieee1394-sbp2-delayed_work-work_struct.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="218-ieee1394-sbp2-delayed_work-work_struct.patch"

>From d19c77641412a257fa651662b96fec826e9e7e60 Mon Sep 17 00:00:00 2001
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Thu, 7 Dec 2006 22:40:33 +0100
Subject: [PATCH] ieee1394: sbp2: delayed_work -> work_struct

This work is not delayed.

Also bring the code format in a state which reduces my work to merge
pending sbp2 patchs.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   26 +++++++++++---------------
 drivers/ieee1394/sbp2.h |    2 +-
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
index 6bd26a9..5156b88 100644
--- a/drivers/ieee1394/sbp2.c
+++ b/drivers/ieee1394/sbp2.c
@@ -462,23 +462,18 @@ static void sbp2util_notify_fetch_agent(
 
 static void sbp2util_write_orb_pointer(struct work_struct *work)
 {
-	struct scsi_id_instance_data *scsi_id =
-		container_of(work, struct scsi_id_instance_data,
-			     protocol_work.work);
 	quadlet_t data[2];
 
-	data[0] = ORB_SET_NODE_ID(scsi_id->hi->host->node_id);
-	data[1] = scsi_id->last_orb_dma;
+	data[0] = ORB_SET_NODE_ID(
+			(container_of(work, struct scsi_id_instance_data, protocol_work))->hi->host->node_id);
+	data[1] = (container_of(work, struct scsi_id_instance_data, protocol_work))->last_orb_dma;
 	sbp2util_cpu_to_be32_buffer(data, 8);
-	sbp2util_notify_fetch_agent(scsi_id, SBP2_ORB_POINTER_OFFSET, data, 8);
+	sbp2util_notify_fetch_agent(container_of(work, struct scsi_id_instance_data, protocol_work), SBP2_ORB_POINTER_OFFSET, data, 8);
 }
 
 static void sbp2util_write_doorbell(struct work_struct *work)
 {
-	struct scsi_id_instance_data *scsi_id =
-		container_of(work, struct scsi_id_instance_data,
-			     protocol_work.work);
-	sbp2util_notify_fetch_agent(scsi_id, SBP2_DOORBELL_OFFSET, NULL, 4);
+	sbp2util_notify_fetch_agent(container_of(work, struct scsi_id_instance_data, protocol_work), SBP2_DOORBELL_OFFSET, NULL, 4);
 }
 
 /*
@@ -795,7 +790,7 @@ static struct scsi_id_instance_data *sbp
 	INIT_LIST_HEAD(&scsi_id->scsi_list);
 	spin_lock_init(&scsi_id->sbp2_command_orb_lock);
 	atomic_set(&scsi_id->state, SBP2LU_STATE_RUNNING);
-	INIT_DELAYED_WORK(&scsi_id->protocol_work, NULL);
+	INIT_WORK(&scsi_id->protocol_work, NULL);
 
 	ud->device.driver_data = scsi_id;
 
@@ -1578,7 +1573,7 @@ static int sbp2_agent_reset(struct scsi_
 	int retval;
 	unsigned long flags;
 
-	cancel_delayed_work(&scsi_id->protocol_work);
+	/* cancel_delayed_work(&scsi_id->protocol_work); */
 	if (wait)
 		flush_scheduled_work();
 
@@ -1889,10 +1884,11 @@ static void sbp2_link_orb_command(struct
 		 * We do not accept new commands until the job is over.
 		 */
 		scsi_block_requests(scsi_id->scsi_host);
-		PREPARE_DELAYED_WORK(&scsi_id->protocol_work,
+		PREPARE_WORK(&scsi_id->protocol_work,
 			     last_orb ? sbp2util_write_doorbell:
-					sbp2util_write_orb_pointer);
-		schedule_delayed_work(&scsi_id->protocol_work, 0);
+					sbp2util_write_orb_pointer
+			     /* */);
+		schedule_work(&scsi_id->protocol_work);
 	}
 }
 
diff --git a/drivers/ieee1394/sbp2.h b/drivers/ieee1394/sbp2.h
index 7b42420..5483b45 100644
--- a/drivers/ieee1394/sbp2.h
+++ b/drivers/ieee1394/sbp2.h
@@ -342,7 +342,7 @@ struct scsi_id_instance_data {
 	unsigned workarounds;
 
 	atomic_t state;
-	struct delayed_work protocol_work;
+	struct work_struct protocol_work;
 };
 
 /* For use in scsi_id_instance_data.state */
-- 
1.4.2.4


--------------010100040305060102030609
Content-Type: text/plain;
 name*0="219-ieee1394-sbp2-code-formatting-around-work_struct-stuff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="219-ieee1394-sbp2-code-formatting-around-work_struct-stuff.p";
 filename*1="atch"

>From ec9b7e1044d718723d16390179abc6d4c8d9b0a1 Mon Sep 17 00:00:00 2001
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Thu, 7 Dec 2006 23:23:25 +0100
Subject: [PATCH] ieee1394: sbp2: code formatting around work_struct stuff

Merge is finished, can bring the code in readable style again.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/ieee1394/sbp2.c b/drivers/ieee1394/sbp2.c
index ffcd9e4..e68b80b 100644
--- a/drivers/ieee1394/sbp2.c
+++ b/drivers/ieee1394/sbp2.c
@@ -458,17 +458,20 @@ static void sbp2util_notify_fetch_agent(
 
 static void sbp2util_write_orb_pointer(struct work_struct *work)
 {
+	struct sbp2_lu *lu = container_of(work, struct sbp2_lu, protocol_work);
 	quadlet_t data[2];
 
-	data[0] = ORB_SET_NODE_ID((container_of(work, struct sbp2_lu, protocol_work))->hi->host->node_id);
-	data[1] = (container_of(work, struct sbp2_lu, protocol_work))->last_orb_dma;
+	data[0] = ORB_SET_NODE_ID(lu->hi->host->node_id);
+	data[1] = lu->last_orb_dma;
 	sbp2util_cpu_to_be32_buffer(data, 8);
-	sbp2util_notify_fetch_agent(container_of(work, struct sbp2_lu, protocol_work), SBP2_ORB_POINTER_OFFSET, data, 8);
+	sbp2util_notify_fetch_agent(lu, SBP2_ORB_POINTER_OFFSET, data, 8);
 }
 
 static void sbp2util_write_doorbell(struct work_struct *work)
 {
-	sbp2util_notify_fetch_agent(container_of(work, struct sbp2_lu, protocol_work), SBP2_DOORBELL_OFFSET, NULL, 4);
+	struct sbp2_lu *lu = container_of(work, struct sbp2_lu, protocol_work);
+
+	sbp2util_notify_fetch_agent(lu, SBP2_DOORBELL_OFFSET, NULL, 4);
 }
 
 static int sbp2util_create_command_orb_pool(struct sbp2_lu *lu)
@@ -1399,7 +1402,7 @@ static int sbp2_agent_reset(struct sbp2_
 	int retval;
 	unsigned long flags;
 
-	/* cancel_delayed_work(&lu->protocol_work); */
+	/* flush lu->protocol_work */
 	if (wait)
 		flush_scheduled_work();
 
@@ -1682,8 +1685,7 @@ static void sbp2_link_orb_command(struct
 		scsi_block_requests(lu->shost);
 		PREPARE_WORK(&lu->protocol_work,
 			     last_orb ? sbp2util_write_doorbell:
-					sbp2util_write_orb_pointer
-			     /* */);
+					sbp2util_write_orb_pointer);
 		schedule_work(&lu->protocol_work);
 	}
 }
-- 
1.4.2.4


--------------010100040305060102030609--
