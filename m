Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267707AbUG2Ozn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267707AbUG2Ozn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:55:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267673AbUG2OzO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:55:14 -0400
Received: from styx.suse.cz ([82.119.242.94]:60053 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264767AbUG2OIH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:07 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 2/47] Fix locking in i8042.c and serio.c
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:54 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101941048@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101942422@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1612.24.2, 2004-05-28 18:24:08+02:00, vojtech@suse.cz
  input: An attempt at fixing locking in i8042.c and serio.c


 drivers/input/serio/i8042.c |    4 ++
 drivers/input/serio/serio.c |   64 +++++++++++++++++++++++++++++++++++++-------
 include/linux/serio.h       |    2 -
 3 files changed, 59 insertions(+), 11 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Thu Jul 29 14:42:23 2004
+++ b/drivers/input/serio/i8042.c	Thu Jul 29 14:42:23 2004
@@ -95,6 +95,7 @@
 /*
  * The i8042_wait_read() and i8042_wait_write functions wait for the i8042 to
  * be ready for reading values from it / writing values to it.
+ * Called always with i8042_lock held.
  */
 
 static int i8042_wait_read(void)
@@ -677,6 +678,7 @@
 
 static int i8042_controller_init(void)
 {
+	unsigned long flags;
 
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
@@ -723,12 +725,14 @@
  * Handle keylock.
  */
 
+	spin_lock_irqsave(&i8042_lock, flags);
 	if (~i8042_read_status() & I8042_STR_KEYLOCK) {
 		if (i8042_unlock)
 			i8042_ctr |= I8042_CTR_IGNKEYLOCK;
 		 else
 			printk(KERN_WARNING "i8042.c: Warning: Keylock active.\n");
 	}
+	spin_unlock_irqrestore(&i8042_lock, flags);
 
 /*
  * If the chip is configured into nontranslated mode by the BIOS, don't
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:42:23 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:42:23 2004
@@ -67,12 +67,18 @@
 	struct list_head node;
 };
 
-static DECLARE_MUTEX(serio_sem);
+
+spinlock_t serio_lock = SPIN_LOCK_UNLOCKED;	/* protects serio_event_list and serio->dev */
+static DECLARE_MUTEX(serio_sem);		/* protects serio_list and serio_dev_list */
 static LIST_HEAD(serio_list);
 static LIST_HEAD(serio_dev_list);
 static LIST_HEAD(serio_event_list);
 static int serio_pid;
 
+/*
+ * serio_find_dev() must be called with serio_sem down.
+ */
+
 static void serio_find_dev(struct serio *serio)
 {
 	struct serio_dev *dev;
@@ -96,22 +102,42 @@
 static void serio_invalidate_pending_events(struct serio *serio)
 {
 	struct serio_event *event;
+	unsigned long flags;
+
+	spin_lock_irqsave(&serio_lock, flags);
 
 	list_for_each_entry(event, &serio_event_list, node)
 		if (event->serio == serio)
 			event->serio = NULL;
+
+	spin_unlock_irqrestore(&serio_lock, flags);
 }
 
 void serio_handle_events(void)
 {
-	struct list_head *node, *next;
+	struct list_head *node;
 	struct serio_event *event;
+	unsigned long flags;
+
+	
+	while (1) {
+
+		spin_lock_irqsave(&serio_lock, flags);
+		
+		if (list_empty(&serio_event_list)) {
+			spin_unlock_irqrestore(&serio_lock, flags);
+			break;
+		}
 
-	list_for_each_safe(node, next, &serio_event_list) {
+		node = serio_event_list.next;
 		event = container_of(node, struct serio_event, node);
+		list_del_init(node);
+
+		spin_unlock_irqrestore(&serio_lock, flags);
 
 		down(&serio_sem);
-		if (event->serio == NULL)
+
+		if (event->serio == NULL) /*!!!*/
 			goto event_done;
 
 		switch (event->type) {
@@ -139,7 +165,6 @@
 		}
 event_done:
 		up(&serio_sem);
-		list_del_init(node);
 		kfree(event);
 	}
 }
@@ -178,12 +203,18 @@
 
 void serio_rescan(struct serio *serio)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&serio_lock, flags);
 	serio_queue_event(serio, SERIO_RESCAN);
+	spin_unlock_irqrestore(&serio_lock, flags);
 }
 
 void serio_reconnect(struct serio *serio)
 {
+	unsigned long flags;
+	spin_lock_irqsave(&serio_lock, flags);
 	serio_queue_event(serio, SERIO_RECONNECT);
+	spin_unlock_irqrestore(&serio_lock, flags);
 }
 
 irqreturn_t serio_interrupt(struct serio *serio,
@@ -191,17 +222,22 @@
 {
 	irqreturn_t ret = IRQ_NONE;
 
+	spin_lock_irq(&serio_lock);
+
         if (serio->dev && serio->dev->interrupt) {
                 ret = serio->dev->interrupt(serio, data, flags, regs);
 	} else {
 		if (!flags) {
-			if ((serio->type == SERIO_8042 ||
-				serio->type == SERIO_8042_XL) && (data != 0xaa))
-					return ret;
-			serio_rescan(serio);
-			ret = IRQ_HANDLED;
+			if ((serio->type != SERIO_8042 &&
+			     serio->type != SERIO_8042_XL) || (data == 0xaa)) {
+				serio_queue_event(serio, SERIO_RESCAN);
+				ret = IRQ_HANDLED;
+			}
 		}
 	}
+	
+	spin_unlock_irq(&serio_lock);
+
 	return ret;
 }
 
@@ -292,7 +328,11 @@
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 int serio_open(struct serio *serio, struct serio_dev *dev)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&serio_lock, flags);
 	serio->dev = dev;
+	spin_unlock_irqrestore(&serio_lock, flags);
 	if (serio->open && serio->open(serio)) {
 		serio->dev = NULL;
 		return -1;
@@ -303,9 +343,13 @@
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
+	unsigned long flags;
+
 	if (serio->close)
 		serio->close(serio);
+	spin_lock_irqsave(&serio_lock, flags);
 	serio->dev = NULL;
+	spin_unlock_irqrestore(&serio_lock, flags);
 }
 
 static int __init serio_init(void)
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Thu Jul 29 14:42:23 2004
+++ b/include/linux/serio.h	Thu Jul 29 14:42:23 2004
@@ -36,7 +36,7 @@
 	int (*open)(struct serio *);
 	void (*close)(struct serio *);
 
-	struct serio_dev *dev;
+	struct serio_dev *dev; /* Accessed from interrupt, writes must be protected by serio_lock */
 
 	struct list_head node;
 };

