Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267875AbUG2PG7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267875AbUG2PG7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 11:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267824AbUG2O67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:58:59 -0400
Received: from styx.suse.cz ([82.119.242.94]:9622 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264808AbUG2OII convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:08 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 9/47] Fixes in serio locking.
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101941439@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101943643@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1722.66.2, 2004-06-02 09:37:24+02:00, vojtech@suse.cz
  input: Fixes in serio locking. We need per-serio lock for passthrough
         ports, some locks were missing, and spin_lock_irq was wishful
         thinking in serio_interrupt. There is no guarantee
         that serio_interrupt won't be called twice at the same time.
  
  Signed-off-by: Vojtech Pavlik <vojtech@suse.cz>


 drivers/input/serio/serio.c |   55 +++++++++++++++++++++++---------------------
 include/linux/serio.h       |    3 ++
 2 files changed, 32 insertions(+), 26 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:41:50 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:41:50 2004
@@ -68,8 +68,8 @@
 };
 
 
-spinlock_t serio_lock = SPIN_LOCK_UNLOCKED;	/* protects serio_event_list and serio->dev */
-static DECLARE_MUTEX(serio_sem);		/* protects serio_list and serio_dev_list */
+spinlock_t serio_event_lock = SPIN_LOCK_UNLOCKED;	/* protects serio_event_list */
+static DECLARE_MUTEX(serio_sem);			/* protects serio_list and serio_dev_list */
 static LIST_HEAD(serio_list);
 static LIST_HEAD(serio_dev_list);
 static LIST_HEAD(serio_event_list);
@@ -104,13 +104,13 @@
 	struct serio_event *event;
 	unsigned long flags;
 
-	spin_lock_irqsave(&serio_lock, flags);
+	spin_lock_irqsave(&serio_event_lock, flags);
 
 	list_for_each_entry(event, &serio_event_list, node)
 		if (event->serio == serio)
 			event->serio = NULL;
 
-	spin_unlock_irqrestore(&serio_lock, flags);
+	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
 
 void serio_handle_events(void)
@@ -119,13 +119,13 @@
 	struct serio_event *event;
 	unsigned long flags;
 
-	
+
 	while (1) {
 
-		spin_lock_irqsave(&serio_lock, flags);
-		
+		spin_lock_irqsave(&serio_event_lock, flags);
+
 		if (list_empty(&serio_event_list)) {
-			spin_unlock_irqrestore(&serio_lock, flags);
+			spin_unlock_irqrestore(&serio_event_lock, flags);
 			break;
 		}
 
@@ -133,7 +133,7 @@
 		event = container_of(node, struct serio_event, node);
 		list_del_init(node);
 
-		spin_unlock_irqrestore(&serio_lock, flags);
+		spin_unlock_irqrestore(&serio_event_lock, flags);
 
 		down(&serio_sem);
 
@@ -190,8 +190,11 @@
 
 static void serio_queue_event(struct serio *serio, int event_type)
 {
+	unsigned long flags;
 	struct serio_event *event;
 
+	spin_lock_irqsave(&serio_event_lock, flags);
+
 	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
 		event->type = event_type;
 		event->serio = serio;
@@ -199,44 +202,41 @@
 		list_add_tail(&event->node, &serio_event_list);
 		wake_up(&serio_wait);
 	}
+
+	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
 
 void serio_rescan(struct serio *serio)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&serio_lock, flags);
 	serio_queue_event(serio, SERIO_RESCAN);
-	spin_unlock_irqrestore(&serio_lock, flags);
 }
 
 void serio_reconnect(struct serio *serio)
 {
-	unsigned long flags;
-	spin_lock_irqsave(&serio_lock, flags);
 	serio_queue_event(serio, SERIO_RECONNECT);
-	spin_unlock_irqrestore(&serio_lock, flags);
 }
 
 irqreturn_t serio_interrupt(struct serio *serio,
-		unsigned char data, unsigned int flags, struct pt_regs *regs)
+		unsigned char data, unsigned int dfl, struct pt_regs *regs)
 {
+	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
-	spin_lock_irq(&serio_lock);
+	spin_lock_irqsave(&serio->lock, flags);
 
         if (serio->dev && serio->dev->interrupt) {
-                ret = serio->dev->interrupt(serio, data, flags, regs);
+                ret = serio->dev->interrupt(serio, data, dfl, regs);
 	} else {
-		if (!flags) {
+		if (!dfl) {
 			if ((serio->type != SERIO_8042 &&
 			     serio->type != SERIO_8042_XL) || (data == 0xaa)) {
-				serio_queue_event(serio, SERIO_RESCAN);
+				serio_rescan(serio);
 				ret = IRQ_HANDLED;
 			}
 		}
 	}
-	
-	spin_unlock_irq(&serio_lock);
+
+	spin_unlock_irqrestore(&serio->lock, flags);
 
 	return ret;
 }
@@ -265,6 +265,7 @@
  */
 void __serio_register_port(struct serio *serio)
 {
+	spin_lock_init(&serio->lock);
 	list_add_tail(&serio->node, &serio_list);
 	serio_find_dev(serio);
 }
@@ -330,11 +331,13 @@
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&serio_lock, flags);
+	spin_lock_irqsave(&serio->lock, flags);
 	serio->dev = dev;
-	spin_unlock_irqrestore(&serio_lock, flags);
+	spin_unlock_irqrestore(&serio->lock, flags);
 	if (serio->open && serio->open(serio)) {
+		spin_lock_irqsave(&serio->lock, flags);
 		serio->dev = NULL;
+		spin_unlock_irqrestore(&serio->lock, flags);
 		return -1;
 	}
 	return 0;
@@ -347,9 +350,9 @@
 
 	if (serio->close)
 		serio->close(serio);
-	spin_lock_irqsave(&serio_lock, flags);
+	spin_lock_irqsave(&serio->lock, flags);
 	serio->dev = NULL;
-	spin_unlock_irqrestore(&serio_lock, flags);
+	spin_unlock_irqrestore(&serio->lock, flags);
 }
 
 static int __init serio_init(void)
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Thu Jul 29 14:41:50 2004
+++ b/include/linux/serio.h	Thu Jul 29 14:41:50 2004
@@ -17,6 +17,7 @@
 #ifdef __KERNEL__
 
 #include <linux/list.h>
+#include <linux/spinlock.h>
 
 struct serio {
 	void *private;
@@ -31,6 +32,8 @@
 
 	unsigned long type;
 	unsigned long event;
+
+	spinlock_t lock;
 
 	int (*write)(struct serio *, unsigned char);
 	int (*open)(struct serio *);

