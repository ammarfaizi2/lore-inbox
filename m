Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267600AbUG2O45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267600AbUG2O45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267586AbUG2OxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:53:21 -0400
Received: from styx.suse.cz ([82.119.242.94]:24470 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264929AbUG2OIL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:11 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 22/47] rearrangements and cleanups in serio.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:55 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101951574@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101951399@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.152.2, 2004-06-12 13:55:01+02:00, vojtech@suse.cz
  Input: rearrangements and cleanups in serio.c
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 serio.c |  191 ++++++++++++++++++++++++++++++++++------------------------------
 1 files changed, 102 insertions(+), 89 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:40:37 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:40:37 2004
@@ -1,11 +1,9 @@
 /*
- * $Id: serio.c,v 1.15 2002/01/22 21:12:03 vojtech Exp $
- *
- *  Copyright (c) 1999-2001 Vojtech Pavlik
- */
-
-/*
  *  The Serio abstraction module
+ *
+ *  Copyright (c) 1999-2004 Vojtech Pavlik
+ *  Copyright (c) 2004 Dmitry Torokhov
+ *  Copyright (c) 2003 Daniele Bellucci
  */
 
 /*
@@ -26,10 +24,6 @@
  * Should you need to contact me, the author, you can do so either by
  * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
  * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
- *
- * Changes:
- * 20 Jul. 2003    Daniele Bellucci <bellucda@tiscali.it>
- *                 Minor cleanups.
  */
 
 #include <linux/stddef.h>
@@ -61,23 +55,11 @@
 EXPORT_SYMBOL(serio_rescan);
 EXPORT_SYMBOL(serio_reconnect);
 
-struct serio_event {
-	int type;
-	struct serio *serio;
-	struct list_head node;
-};
-
-
-static spinlock_t serio_event_lock = SPIN_LOCK_UNLOCKED;	/* protects serio_event_list */
 static DECLARE_MUTEX(serio_sem);				/* protects serio_list and serio_dev_list */
 static LIST_HEAD(serio_list);
 static LIST_HEAD(serio_dev_list);
-static LIST_HEAD(serio_event_list);
-static int serio_pid;
 
-/*
- * serio_find_dev() must be called with serio_sem down.
- */
+/* serio_find_dev() must be called with serio_sem down.  */
 
 static void serio_find_dev(struct serio *serio)
 {
@@ -91,54 +73,74 @@
 	}
 }
 
-#define SERIO_RESCAN		1
-#define SERIO_RECONNECT		2
-#define SERIO_REGISTER_PORT	3
-#define SERIO_UNREGISTER_PORT	4
+/*
+ * Serio event processing.
+ */
 
+struct serio_event {
+	int type;
+	struct serio *serio;
+	struct list_head node;
+};
+
+enum serio_event_type {
+	SERIO_RESCAN,
+	SERIO_RECONNECT,
+	SERIO_REGISTER_PORT,
+	SERIO_UNREGISTER_PORT,
+};
+
+static spinlock_t serio_event_lock = SPIN_LOCK_UNLOCKED;	/* protects serio_event_list */
+static LIST_HEAD(serio_event_list);
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
+static int serio_pid;
 
-static void serio_remove_pending_events(struct serio *serio)
+static void serio_queue_event(struct serio *serio, int event_type)
 {
-	struct list_head *node, *next;
-	struct serio_event *event;
 	unsigned long flags;
+	struct serio_event *event;
 
 	spin_lock_irqsave(&serio_event_lock, flags);
 
-	list_for_each_safe(node, next, &serio_event_list) {
-		event = container_of(node, struct serio_event, node);
-		if (event->serio == serio) {
-			list_del_init(node);
-			kfree(event);
-		}
+	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
+		event->type = event_type;
+		event->serio = serio;
+
+		list_add_tail(&event->node, &serio_event_list);
+		wake_up(&serio_wait);
 	}
 
 	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
 
-void serio_handle_events(void)
+static struct serio_event *serio_get_event(void)
 {
-	struct list_head *node;
 	struct serio_event *event;
+	struct list_head *node;
 	unsigned long flags;
 
+	spin_lock_irqsave(&serio_event_lock, flags);
 
-	while (1) {
+	if (list_empty(&serio_event_list)) {
+		spin_unlock_irqrestore(&serio_event_lock, flags);
+		return NULL;
+	}
 
-		spin_lock_irqsave(&serio_event_lock, flags);
+	node = serio_event_list.next;
+	event = container_of(node, struct serio_event, node);
+	list_del_init(node);
 
-		if (list_empty(&serio_event_list)) {
-			spin_unlock_irqrestore(&serio_event_lock, flags);
-			break;
-		}
+	spin_unlock_irqrestore(&serio_event_lock, flags);
 
-		node = serio_event_list.next;
-		event = container_of(node, struct serio_event, node);
-		list_del_init(node);
+	return event;
+}
 
-		spin_unlock_irqrestore(&serio_event_lock, flags);
+static void serio_handle_events(void)
+{
+	struct serio_event *event;
+
+	while ((event = serio_get_event())) {
 
 		down(&serio_sem);
 
@@ -171,6 +173,26 @@
 	}
 }
 
+static void serio_remove_pending_events(struct serio *serio)
+{
+	struct list_head *node, *next;
+	struct serio_event *event;
+	unsigned long flags;
+
+	spin_lock_irqsave(&serio_event_lock, flags);
+
+	list_for_each_safe(node, next, &serio_event_list) {
+		event = container_of(node, struct serio_event, node);
+		if (event->serio == serio) {
+			list_del_init(node);
+			kfree(event);
+		}
+	}
+
+	spin_unlock_irqrestore(&serio_event_lock, flags);
+}
+
+
 static int serio_thread(void *nothing)
 {
 	lock_kernel();
@@ -190,23 +212,10 @@
 	complete_and_exit(&serio_exited, 0);
 }
 
-static void serio_queue_event(struct serio *serio, int event_type)
-{
-	unsigned long flags;
-	struct serio_event *event;
-
-	spin_lock_irqsave(&serio_event_lock, flags);
-
-	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
-		event->type = event_type;
-		event->serio = serio;
-
-		list_add_tail(&event->node, &serio_event_list);
-		wake_up(&serio_wait);
-	}
 
-	spin_unlock_irqrestore(&serio_event_lock, flags);
-}
+/*
+ * Serio port operations
+ */
 
 void serio_rescan(struct serio *serio)
 {
@@ -218,31 +227,6 @@
 	serio_queue_event(serio, SERIO_RECONNECT);
 }
 
-irqreturn_t serio_interrupt(struct serio *serio,
-		unsigned char data, unsigned int dfl, struct pt_regs *regs)
-{
-	unsigned long flags;
-	irqreturn_t ret = IRQ_NONE;
-
-	spin_lock_irqsave(&serio->lock, flags);
-
-        if (likely(serio->dev)) {
-                ret = serio->dev->interrupt(serio, data, dfl, regs);
-	} else {
-		if (!dfl) {
-			if ((serio->type != SERIO_8042 &&
-			     serio->type != SERIO_8042_XL) || (data == 0xaa)) {
-				serio_rescan(serio);
-				ret = IRQ_HANDLED;
-			}
-		}
-	}
-
-	spin_unlock_irqrestore(&serio->lock, flags);
-
-	return ret;
-}
-
 void serio_register_port(struct serio *serio)
 {
 	down(&serio_sem);
@@ -302,6 +286,10 @@
 		serio->dev->disconnect(serio);
 }
 
+/*
+ * Serio device operations
+ */
+
 void serio_register_device(struct serio_dev *dev)
 {
 	struct serio *serio;
@@ -355,6 +343,31 @@
 	spin_lock_irqsave(&serio->lock, flags);
 	serio->dev = NULL;
 	spin_unlock_irqrestore(&serio->lock, flags);
+}
+
+irqreturn_t serio_interrupt(struct serio *serio,
+		unsigned char data, unsigned int dfl, struct pt_regs *regs)
+{
+	unsigned long flags;
+	irqreturn_t ret = IRQ_NONE;
+
+	spin_lock_irqsave(&serio->lock, flags);
+
+        if (likely(serio->dev)) {
+                ret = serio->dev->interrupt(serio, data, dfl, regs);
+	} else {
+		if (!dfl) {
+			if ((serio->type != SERIO_8042 &&
+			     serio->type != SERIO_8042_XL) || (data == 0xaa)) {
+				serio_rescan(serio);
+				ret = IRQ_HANDLED;
+			}
+		}
+	}
+
+	spin_unlock_irqrestore(&serio->lock, flags);
+
+	return ret;
 }
 
 static int __init serio_init(void)

