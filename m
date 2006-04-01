Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751350AbWDATQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751350AbWDATQN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 14:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbWDATQN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 14:16:13 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:56807 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1751350AbWDATQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 14:16:13 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Sat, 1 Apr 2006 21:11:41 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] sbp2: fix spinlock recursion
To: Linus Torvalds <torvalds@osdl.org>
cc: stable@kernel.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net,
       Jody McIntyre <scjody@modernduck.com>, Andrew Morton <akpm@osdl.org>
Message-ID: <tkrat.11bf8809a766b402@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-Spam-Score: (0.835) AWL,BAYES_50
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2util_mark_command_completed takes a lock which was already taken by
sbp2scsi_complete_all_commands.  This is a regression in Linux 2.6.15.
Reported by Kristian Harms at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=187394

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/sbp2.c |   32 +++++++++++++++-----------------
 1 files changed, 15 insertions(+), 17 deletions(-)

--- linux-2.6.16.1/drivers/ieee1394/sbp2.c.orig	2006-04-01 19:06:31.000000000 +0200
+++ linux-2.6.16.1/drivers/ieee1394/sbp2.c	2006-04-01 19:07:00.000000000 +0200
@@ -495,22 +495,17 @@ static struct sbp2_command_info *sbp2uti
 /*
  * This function finds the sbp2_command for a given outstanding SCpnt.
  * Only looks at the inuse list.
+ * Must be called with scsi_id->sbp2_command_orb_lock held.
  */
-static struct sbp2_command_info *sbp2util_find_command_for_SCpnt(struct scsi_id_instance_data *scsi_id, void *SCpnt)
+static struct sbp2_command_info *sbp2util_find_command_for_SCpnt(
+		struct scsi_id_instance_data *scsi_id, void *SCpnt)
 {
 	struct sbp2_command_info *command;
-	unsigned long flags;
 
-	spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
-	if (!list_empty(&scsi_id->sbp2_command_orb_inuse)) {
-		list_for_each_entry(command, &scsi_id->sbp2_command_orb_inuse, list) {
-			if (command->Current_SCpnt == SCpnt) {
-				spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
+	if (!list_empty(&scsi_id->sbp2_command_orb_inuse))
+		list_for_each_entry(command, &scsi_id->sbp2_command_orb_inuse, list)
+			if (command->Current_SCpnt == SCpnt)
 				return command;
-			}
-		}
-	}
-	spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 	return NULL;
 }
 
@@ -579,17 +574,15 @@ static void sbp2util_free_command_dma(st
 
 /*
  * This function moves a command to the completed orb list.
+ * Must be called with scsi_id->sbp2_command_orb_lock held.
  */
-static void sbp2util_mark_command_completed(struct scsi_id_instance_data *scsi_id,
-					    struct sbp2_command_info *command)
+static void sbp2util_mark_command_completed(
+		struct scsi_id_instance_data *scsi_id,
+		struct sbp2_command_info *command)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
 	list_del(&command->list);
 	sbp2util_free_command_dma(command);
 	list_add_tail(&command->list, &scsi_id->sbp2_command_orb_completed);
-	spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 }
 
 /*
@@ -2177,7 +2170,9 @@ static int sbp2_handle_status_write(stru
 		 * Matched status with command, now grab scsi command pointers and check status
 		 */
 		SCpnt = command->Current_SCpnt;
+		spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
 		sbp2util_mark_command_completed(scsi_id, command);
+		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
 		if (SCpnt) {
 
@@ -2513,6 +2508,7 @@ static int sbp2scsi_abort(struct scsi_cm
 		(struct scsi_id_instance_data *)SCpnt->device->host->hostdata[0];
 	struct sbp2scsi_host_info *hi = scsi_id->hi;
 	struct sbp2_command_info *command;
+	unsigned long flags;
 
 	SBP2_ERR("aborting sbp2 command");
 	scsi_print_command(SCpnt);
@@ -2523,6 +2519,7 @@ static int sbp2scsi_abort(struct scsi_cm
 		 * Right now, just return any matching command structures
 		 * to the free pool.
 		 */
+		spin_lock_irqsave(&scsi_id->sbp2_command_orb_lock, flags);
 		command = sbp2util_find_command_for_SCpnt(scsi_id, SCpnt);
 		if (command) {
 			SBP2_DEBUG("Found command to abort");
@@ -2540,6 +2537,7 @@ static int sbp2scsi_abort(struct scsi_cm
 				command->Current_done(command->Current_SCpnt);
 			}
 		}
+		spin_unlock_irqrestore(&scsi_id->sbp2_command_orb_lock, flags);
 
 		/*
 		 * Initiate a fetch agent reset.


