Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbUFRIr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbUFRIr7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 04:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUFRIpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 04:45:22 -0400
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:35413 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265048AbUFRIox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 04:44:53 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 3/11] serio connect/disconnect mandatory
Date: Fri, 18 Jun 2004 03:38:22 -0500
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, Vojtech Pavlik <vojtech@suse.cz>,
       vojtech@ucw.cz
References: <200406180335.52843.dtor_core@ameritech.net> <200406180337.17457.dtor_core@ameritech.net> <200406180337.47669.dtor_core@ameritech.net>
In-Reply-To: <200406180337.47669.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200406180338.42624.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1792, 2004-06-17 18:16:15-05:00, dtor_core@ameritech.net
  Input: make connect and disconnect methods mandatory for serio
         drivers since that's where serio_{open|close} are called
         from to actually bind driver to a port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-06-18 03:15:15 -05:00
+++ b/drivers/input/serio/serio.c	2004-06-18 03:15:15 -05:00
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
