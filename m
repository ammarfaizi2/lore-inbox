Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbUL2IHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbUL2IHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 03:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbUL2Hjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 02:39:47 -0500
Received: from smtp802.mail.sc5.yahoo.com ([66.163.168.181]:13487 "HELO
	smtp802.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261380AbUL2Hd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 02:33:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/16] Suppress duplicate events in serio core
Date: Wed, 29 Dec 2004 02:21:26 -0500
User-Agent: KMail/1.6.2
Cc: linux-input@atrey.karlin.mff.cuni.cz, LKML <linux-kernel@vger.kernel.org>
References: <200412290217.36282.dtor_core@ameritech.net> <200412290220.10708.dtor_core@ameritech.net> <200412290220.50228.dtor_core@ameritech.net>
In-Reply-To: <200412290220.50228.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200412290221.33869.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1957.1.31, 2004-11-12 01:27:45-05:00, dtor_core@ameritech.net
  Input: rearrange serio event processing to get rid of duplicate
         events - do not sumbit event into the event queue if similar
         event has not been processed yet; also once event has been
         processed check the queue and delete events of the same type
         that have been accumulated in the mean time.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |   57 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 files changed, 48 insertions(+), 9 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-12-29 01:47:11 -05:00
+++ b/drivers/input/serio/serio.c	2004-12-29 01:47:11 -05:00
@@ -120,13 +120,28 @@
 static DECLARE_COMPLETION(serio_exited);
 static int serio_pid;
 
-static void serio_queue_event(struct serio *serio, int event_type)
+static void serio_queue_event(struct serio *serio, enum serio_event_type event_type)
 {
 	unsigned long flags;
 	struct serio_event *event;
 
 	spin_lock_irqsave(&serio_event_lock, flags);
 
+	/*
+ 	 * Scan event list for the other events for the same serio port,
+	 * starting with the most recent one. If event is the same we
+	 * do not need add new one. If event is of different type we
+	 * need to add this event and should not look further because
+	 * we need to preseve sequence of distinct events.
+ 	 */
+	list_for_each_entry_reverse(event, &serio_event_list, node) {
+		if (event->serio == serio) {
+			if (event->type == event_type)
+				goto out;
+			break;
+		}
+	}
+
 	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
 		event->type = event_type;
 		event->serio = serio;
@@ -135,9 +150,37 @@
 		wake_up(&serio_wait);
 	}
 
+out:
+	spin_unlock_irqrestore(&serio_event_lock, flags);
+}
+
+static void serio_remove_duplicate_events(struct serio_event *event)
+{
+	struct list_head *node, *next;
+	struct serio_event *e;
+	unsigned long flags;
+
+	spin_lock_irqsave(&serio_event_lock, flags);
+
+	list_for_each_safe(node, next, &serio_event_list) {
+		e = container_of(node, struct serio_event, node);
+		if (event->serio == e->serio) {
+			/*
+			 * If this event is of different type we should not
+			 * look further - we only suppress duplicate events
+			 * that were sent back-to-back.
+			 */
+			if (event->type != e->type)
+				break;	/* Stop, when need to preserve event flow */
+			list_del_init(node);
+			kfree(e);
+		}
+	}
+
 	spin_unlock_irqrestore(&serio_event_lock, flags);
 }
 
+
 static struct serio_event *serio_get_event(void)
 {
 	struct serio_event *event;
@@ -192,6 +235,7 @@
 		}
 
 		up(&serio_sem);
+		serio_remove_duplicate_events(event);
 		kfree(event);
 	}
 }
@@ -637,14 +681,9 @@
 
         if (likely(serio->drv)) {
                 ret = serio->drv->interrupt(serio, data, dfl, regs);
-	} else {
-		if (!dfl) {
-			if ((serio->type != SERIO_8042 &&
-			     serio->type != SERIO_8042_XL) || (data == 0xaa)) {
-				serio_rescan(serio);
-				ret = IRQ_HANDLED;
-			}
-		}
+	} else if (!dfl) {
+		serio_rescan(serio);
+		ret = IRQ_HANDLED;
 	}
 
 	spin_unlock_irqrestore(&serio->lock, flags);
