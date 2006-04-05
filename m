Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWDEAJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWDEAJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 20:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWDEAAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 20:00:52 -0400
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:8336 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S1750951AbWDEAAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 20:00:47 -0400
Date: Tue, 4 Apr 2006 17:00:00 -0700
From: gregkh@suse.de
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Jody McIntyre <scjody@modernduck.com>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 06/26] sbp2: fix spinlock recursion
Message-ID: <20060405000000.GG27049@kroah.com>
References: <20060404235634.696852000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sbp2-fix-spinlock-recursion.patch"
In-Reply-To: <20060404235927.GA27049@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sbp2util_mark_command_completed takes a lock which was already taken by
sbp2scsi_complete_all_commands.  This is a regression in Linux 2.6.15.
Reported by Kristian Harms at
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=187394

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/ieee1394/sbp2.c |   32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

--- linux-2.6.16.1.orig/drivers/ieee1394/sbp2.c
+++ linux-2.6.16.1/drivers/ieee1394/sbp2.c
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

--
