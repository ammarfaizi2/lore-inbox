Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263147AbTI3Gcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263152AbTI3G2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:28:38 -0400
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:11874 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S263147AbTI3G2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:28:08 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 5/6] serio: reconnect facility
Date: Tue, 30 Sep 2003 01:23:47 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, petero2@telia.com, linux-kernel@vger.kernel.org
References: <200309300052.49908.dtor_core@ameritech.net> <200309300114.57761.dtor_core@ameritech.net> <200309300120.51661.dtor_core@ameritech.net>
In-Reply-To: <200309300120.51661.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309300123.47737.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: serio_reconnect added. Similar to serio_rescan but gives driver
       a chance to re-initialize keeping the same input device.


 drivers/input/serio/serio.c |   31 ++++++++++++++++++++++++-------
 include/linux/serio.h       |    2 ++
 2 files changed, 26 insertions(+), 7 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Tue Sep 30 01:22:43 2003
+++ b/drivers/input/serio/serio.c	Tue Sep 30 01:22:43 2003
@@ -57,6 +57,7 @@
 EXPORT_SYMBOL(serio_open);
 EXPORT_SYMBOL(serio_close);
 EXPORT_SYMBOL(serio_rescan);
+EXPORT_SYMBOL(serio_reconnect);
 
 struct serio_event {
 	int type;
@@ -83,6 +84,7 @@
 }
 
 #define SERIO_RESCAN	1
+#define SERIO_RECONNECT	2
 
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
@@ -109,6 +111,12 @@
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
@@ -143,18 +151,27 @@
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
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Tue Sep 30 01:22:43 2003
+++ b/include/linux/serio.h	Tue Sep 30 01:22:43 2003
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

