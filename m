Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264656AbUF1FLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264656AbUF1FLv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 01:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264655AbUF1FLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 01:11:40 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:22943 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264650AbUF1FKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 01:10:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/19] serio connect/disconnect mandatory
Date: Mon, 28 Jun 2004 00:10:44 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200406280008.21465.dtor_core@ameritech.net> <200406280009.37987.dtor_core@ameritech.net>
In-Reply-To: <200406280009.37987.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406280010.46417.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1776, 2004-06-27 15:45:16-05:00, dtor_core@ameritech.net
  Input: make connect and disconnect methods mandatory for serio
         drivers since that's where serio_{open|close} are called
         from to actually bind driver to a port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-27 17:47:10 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-27 17:47:10 -05:00
@@ -68,8 +68,7 @@
 	list_for_each_entry(dev, &serio_dev_list, node) {
 		if (serio->dev)
 			break;
-		if (dev->connect)
-			dev->connect(serio, dev);
+		dev->connect(serio, dev);
 	}
 }
 
@@ -160,7 +159,7 @@
 				/* reconnect failed - fall through to rescan */
 
 			case SERIO_RESCAN :
-				if (event->serio->dev && event->serio->dev->disconnect)
+				if (event->serio->dev)
 					event->serio->dev->disconnect(event->serio);
 				serio_find_dev(event->serio);
 				break;
@@ -282,7 +281,7 @@
 {
 	serio_remove_pending_events(serio);
 	list_del_init(&serio->node);
-	if (serio->dev && serio->dev->disconnect)
+	if (serio->dev)
 		serio->dev->disconnect(serio);
 }
 
@@ -296,7 +295,7 @@
 	down(&serio_sem);
 	list_add_tail(&dev->node, &serio_dev_list);
 	list_for_each_entry(serio, &serio_list, node)
-		if (!serio->dev && dev->connect)
+		if (!serio->dev)
 			dev->connect(serio, dev);
 	up(&serio_sem);
 }
@@ -309,7 +308,7 @@
 	list_del_init(&dev->node);
 
 	list_for_each_entry(serio, &serio_list, node) {
-		if (serio->dev == dev && dev->disconnect)
+		if (serio->dev == dev)
 			dev->disconnect(serio);
 		serio_find_dev(serio);
 	}
