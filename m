Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263973AbTHWGhQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 02:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263877AbTHWGgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 02:36:20 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:28312 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261362AbTHWGb4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 02:31:56 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] 3/3 Serio: support reconnecting keeping same input device
Date: Sat, 23 Aug 2003 01:31:53 -0500
User-Agent: KMail/1.5.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308230131.53734.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below introduces a new serio_dev method "reconnect". It's 
purpose is to re-initialize attached hardware while keeping the same 
input device. 

Reconnect can be used for example during resume or with somewhat broken
hardware like my laptop/docking station which resets the touchpad back
in relative mode without telling anyone whenever I dock or un-dock. The 
regular disconnect/connect solution is not working because clients (like
XFree) like to keep the original input device open so after connecting 
the touchpad it will create a brand new input device. With reconnect the
driver has an option to re-initialize hardware but keep the same input 
device (given that hardware didn't change).

If reconnect fails serio automatically fall back to disconnect/reconnect 
scheme.

What you think?

Dmitry

P.S. I have a new patch for Synaptics touchpad that makes use of this new 
functionality that I will sent to the LKML shortly 

diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/serio/serio.c linux-2.6.0-test4/drivers/input/serio/serio.c
--- 2.6.0-test4/drivers/input/serio/serio.c	2003-08-22 23:33:02.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/serio/serio.c	2003-08-22 23:41:57.000000000 -0500
@@ -55,6 +55,7 @@
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
 EXPORT_SYMBOL(serio_rescan);
+EXPORT_SYMBOL(serio_reconnect);
 
 struct serio_event {
 	int type;
@@ -81,6 +82,7 @@
 }
 
 #define SERIO_RESCAN	1
+#define SERIO_RECONNECT	2
 
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
@@ -108,6 +110,12 @@
 			goto event_done;
 		
 		switch (event->type) {
+			case SERIO_RECONNECT :
+				if (event->serio->dev && event->serio->dev->reconnect)
+					if (event->serio->dev->reconnect(event->serio) == 0)
+						break;
+				/* reconnect failed - fall through to rescan */
+				
 			case SERIO_RESCAN :
 				if (event->serio->dev && event->serio->dev->disconnect)
 					event->serio->dev->disconnect(event->serio);
@@ -142,18 +150,27 @@
 	complete_and_exit(&serio_exited, 0);
 }
 
-void serio_rescan(struct serio *serio)
+static void serio_queue_event(struct serio *serio, int event_type)
 {
 	struct serio_event *event;
 
-	if (!(event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC)))
-		return;
+	if ((event = kmalloc(sizeof(struct serio_event), GFP_ATOMIC))) {
+		event->type = event_type;
+		event->serio = serio;
+
+		list_add_tail(&event->node, &serio_event_list);
+		wake_up(&serio_wait);
+	}
+}
 
-	event->type = SERIO_RESCAN;
-	event->serio = serio;
+void serio_rescan(struct serio *serio)
+{
+	serio_queue_event(serio, SERIO_RESCAN);
+}
 
-	list_add_tail(&event->node, &serio_event_list);
-	wake_up(&serio_wait);
+void serio_reconnect(struct serio *serio)
+{
+	serio_queue_event(serio, SERIO_RECONNECT);
 }
 
 irqreturn_t serio_interrupt(struct serio *serio,
diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/include/linux/serio.h linux-2.6.0-test4/include/linux/serio.h
--- 2.6.0-test4/include/linux/serio.h	2003-07-27 12:03:20.000000000 -0500
+++ linux-2.6.0-test4/include/linux/serio.h	2003-08-22 23:36:08.000000000 -0500
@@ -53,6 +53,7 @@
 	irqreturn_t (*interrupt)(struct serio *, unsigned char,
 			unsigned int, struct pt_regs *);
 	void (*connect)(struct serio *, struct serio_dev *dev);
+	int  (*reconnect)(struct serio *);
 	void (*disconnect)(struct serio *);
 	void (*cleanup)(struct serio *);
 
@@ -62,6 +63,7 @@
 int serio_open(struct serio *serio, struct serio_dev *dev);
 void serio_close(struct serio *serio);
 void serio_rescan(struct serio *serio);
+void serio_reconnect(struct serio *serio);
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs);
 
 void serio_register_port(struct serio *serio);
