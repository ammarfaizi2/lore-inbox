Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264203AbTFUNqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 09:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbTFUNiQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 09:38:16 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:21922 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S262525AbTFUNiB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 09:38:01 -0400
Subject: [PATCH 3/11] input: Add locking to serio.c
In-Reply-To: <10562035172703@twilight.ucw.cz>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 21 Jun 2003 15:51:57 +0200
Message-Id: <10562035173660@twilight.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Vojtech Pavlik <vojtech@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1361, 2003-06-21 04:34:11-07:00, vojtech@kernel.bkbits.net
  input: Add locking to serio.c


 serio.c |   13 +++++++++++++
 1 files changed, 13 insertions(+)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Sat Jun 21 15:25:06 2003
+++ b/drivers/input/serio/serio.c	Sat Jun 21 15:25:06 2003
@@ -58,6 +58,7 @@
 	struct list_head node;
 };
 
+static DECLARE_MUTEX(serio_sem);
 static LIST_HEAD(serio_list);
 static LIST_HEAD(serio_dev_list);
 static LIST_HEAD(serio_event_list);
@@ -90,9 +91,11 @@
 
 		switch (event->type) {
 			case SERIO_RESCAN :
+				down(&serio_sem);
 				if (event->serio->dev && event->serio->dev->disconnect)
 					event->serio->dev->disconnect(event->serio);
 				serio_find_dev(event->serio);
+				up(&serio_sem);
 				break;
 			default:
 				break;
@@ -153,30 +156,37 @@
 
 void serio_register_port(struct serio *serio)
 {
+	down(&serio_sem);
 	list_add_tail(&serio->node, &serio_list);
 	serio_find_dev(serio);
+	up(&serio_sem);
 }
 
 void serio_unregister_port(struct serio *serio)
 {
+	down(&serio_sem);
 	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
 		serio->dev->disconnect(serio);
+	up(&serio_sem);
 }
 
 void serio_register_device(struct serio_dev *dev)
 {
 	struct serio *serio;
+	down(&serio_sem);
 	list_add_tail(&dev->node, &serio_dev_list);
 	list_for_each_entry(serio, &serio_list, node)
 		if (!serio->dev && dev->connect)
 			dev->connect(serio, dev);
+	up(&serio_sem);
 }
 
 void serio_unregister_device(struct serio_dev *dev)
 {
 	struct serio *serio;
 
+	down(&serio_sem);
 	list_del_init(&dev->node);
 
 	list_for_each_entry(serio, &serio_list, node) {
@@ -184,8 +194,10 @@
 			dev->disconnect(serio);
 		serio_find_dev(serio);
 	}
+	up(&serio_sem);
 }
 
+/* called from serio_dev->connect/disconnect methods under serio_sem */
 int serio_open(struct serio *serio, struct serio_dev *dev)
 {
 	if (serio->open(serio))
@@ -194,6 +206,7 @@
 	return 0;
 }
 
+/* called from serio_dev->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
 	serio->close(serio);

