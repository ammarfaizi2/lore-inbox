Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUG2Oet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUG2Oet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 10:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267199AbUG2Ob4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 10:31:56 -0400
Received: from styx.suse.cz ([82.119.242.94]:27286 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264965AbUG2OIM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 10:08:12 -0400
To: torvalds@osdl.org, vojtech@suse.cz, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=US-ASCII
Subject: [PATCH 32/47] make connect and disconnect methods mandatory for serio
Content-Transfer-Encoding: 7BIT
Date: Thu, 29 Jul 2004 16:09:56 +0200
X-Mailer: gregkh_patchbomb_levon_offspring
In-Reply-To: <10911101961887@twilight.ucw.cz>
From: Vojtech Pavlik <vojtech@suse.cz>
Message-Id: <10911101961099@twilight.ucw.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can pull this changeset from:
	bk://kernel.bkbits.net/vojtech/input

===================================================================

ChangeSet@1.1757.15.27, 2004-06-29 01:25:59-05:00, dtor_core@ameritech.net
  Input: make connect and disconnect methods mandatory for serio
         drivers since that's where serio_{open|close} are called
         from to actually bind driver to a port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 serio.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Thu Jul 29 14:39:41 2004
+++ b/drivers/input/serio/serio.c	Thu Jul 29 14:39:41 2004
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

