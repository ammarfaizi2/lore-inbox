Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbTHWGby (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 02:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261462AbTHWGby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 02:31:54 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:53116 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261702AbTHWGbt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 02:31:49 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] 2/3 Serio: possible race in handle_events
Date: Sat, 23 Aug 2003 01:31:45 -0500
User-Agent: KMail/1.5.1
Cc: Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200308230131.45474.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The event handling in serio is racy because serio_handle_events does not
check whether serio in event list is still alive or has already been freed.
One possible solution is to check whether serio in question is still 
registered in serio_list and skip events referring to unknown serios.

Dmitry

diff -urN --exclude-from=/usr/src/exclude 2.6.0-test4/drivers/input/serio/serio.c linux-2.6.0-test4/drivers/input/serio/serio.c
--- 2.6.0-test4/drivers/input/serio/serio.c	2003-08-22 23:26:50.000000000 -0500
+++ linux-2.6.0-test4/drivers/input/serio/serio.c	2003-08-22 23:25:20.000000000 -0500
@@ -85,6 +85,16 @@
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
 
+static int is_known_serio(struct serio *serio)
+{
+	struct serio *s;
+	
+	list_for_each_entry(s, &serio_list, node)
+		if (s == serio)
+			return 1;
+	return 0;
+}
+
 void serio_handle_events(void)
 {
 	struct list_head *node, *next;
@@ -93,17 +103,21 @@
 	list_for_each_safe(node, next, &serio_event_list) {
 		event = container_of(node, struct serio_event, node);	
 
+		down(&serio_sem);
+		if (!is_known_serio(event->serio))
+			goto event_done;
+		
 		switch (event->type) {
 			case SERIO_RESCAN :
-				down(&serio_sem);
 				if (event->serio->dev && event->serio->dev->disconnect)
 					event->serio->dev->disconnect(event->serio);
 				serio_find_dev(event->serio);
-				up(&serio_sem);
 				break;
 			default:
 				break;
 		}
+event_done:	
+		up(&serio_sem);
 		list_del_init(node);
 		kfree(event);
 	}
