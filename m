Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264997AbUG2Sm0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264997AbUG2Sm0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 14:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267453AbUG2OpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:45:00 -0400
Received: from styx.suse.cz ([82.119.242.94]:11158 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264826AbUG2OIJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:09 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 12/47] More locking improvements (and a fix) for serio.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101941969@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101941591@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.84.4, 2004-06-02 16:09:25+02:00, vojtech@suse.cz
  input: More locking improvements (and a fix) for serio. This
         merges both my and Dmitry's changes.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 serio.c |   26 ++++++++++++++------------
 1 files changed, 14 insertions(+), 12 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:41:31 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:41:31 2004
@@ -68,8 +68,8 @@
 };
 
 
-spinlock_t serio_event_lock = SPIN_LOCK_UNLOCKED;	/* protects serio_event_list */
-static DECLARE_MUTEX(serio_sem);			/* protects serio_list and serio_dev_list */
+static spinlock_t serio_event_lock = SPIN_LOCK_UNLOCKED;	/* protects serio_event_list */
+static DECLARE_MUTEX(serio_sem);				/* protects serio_list and serio_dev_list */
 static LIST_HEAD(serio_list);
 static LIST_HEAD(serio_dev_list);
 static LIST_HEAD(serio_event_list);
@@ -99,16 +99,21 @@
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
 
-static void serio_invalidate_pending_events(struct serio *serio)
+static void serio_remove_pending_events(struct serio *serio)
 {
+	struct list_head *node, *next;
 	struct serio_event *event;
 	unsigned long flags;
 
 	spin_lock_irqsave(&serio_event_lock, flags);
 
-	list_for_each_entry(event, &serio_event_list, node)
-		if (event->serio == serio)
-			event->serio = NULL;
+	list_for_each_safe(node, next, &serio_event_list) {
+		event = container_of(node, struct serio_event, node);
+		if (event->serio == serio) {
+			list_del_init(node);
+			kfree(event);
+		}
+	}
 
 	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
@@ -137,9 +142,6 @@
 
 		down(&serio_sem);
 
-		if (event->serio == NULL) /*!!!*/
-			goto event_done;
-
 		switch (event->type) {
 			case SERIO_REGISTER_PORT :
 				__serio_register_port(event->serio);
@@ -163,7 +165,7 @@
 			default:
 				break;
 		}
-event_done:
+
 		up(&serio_sem);
 		kfree(event);
 	}
@@ -224,7 +226,7 @@
 
 	spin_lock_irqsave(&serio->lock, flags);
 
-        if (serio->dev && serio->dev->interrupt) {
+        if (likely(serio->dev)) {
                 ret = serio->dev->interrupt(serio, data, dfl, regs);
 	} else {
 		if (!dfl) {
@@ -294,7 +296,7 @@
  */
 void __serio_unregister_port(struct serio *serio)
 {
-	serio_invalidate_pending_events(serio);
+	serio_remove_pending_events(serio);
 	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
 		serio->dev->disconnect(serio);

