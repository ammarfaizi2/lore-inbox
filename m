Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263175AbTI3Gcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263148AbTI3G2w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:28:52 -0400
Received: from smtp808.mail.sc5.yahoo.com ([66.163.168.187]:44633 "HELO
	smtp808.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263150AbTI3G2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:28:12 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/6] serio: possible race between port removal and kseriod
Date: Tue, 30 Sep 2003 01:15:51 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, petero2@telia.com, linux-kernel@vger.kernel.org
References: <200309300052.49908.dtor_core@ameritech.net> <200309300106.20744.dtor_core@ameritech.net>
In-Reply-To: <200309300106.20744.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200309300112.50076.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: There is a possibility that serio might get deleted while there
       are outstanding events involving that serio waiting for kseriod
       to process them. Invalidate them so kseriod thread will just
       drop dead events.


 serio.c |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Tue Sep 30 01:07:17 2003
+++ b/drivers/input/serio/serio.c	Tue Sep 30 01:07:17 2003
@@ -87,6 +87,15 @@
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
 
+static void serio_invalidate_pending_events(struct serio *serio)
+{
+	struct serio_event *event;
+	
+	list_for_each_entry(event, &serio_event_list, node)
+		if (event->serio == serio)
+			event->serio = NULL;
+}
+
 void serio_handle_events(void)
 {
 	struct list_head *node, *next;
@@ -95,17 +104,21 @@
 	list_for_each_safe(node, next, &serio_event_list) {
 		event = container_of(node, struct serio_event, node);	
 
+		down(&serio_sem);
+		if (event->serio == NULL)
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
@@ -192,6 +205,7 @@
  */
 void __serio_unregister_port(struct serio *serio)
 {
+	serio_invalidate_pending_events(serio);
 	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
 		serio->dev->disconnect(serio);

