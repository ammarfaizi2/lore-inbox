Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264877AbTK3IEL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 03:04:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264879AbTK3IEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 03:04:11 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:56249 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264877AbTK3IEF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 03:04:05 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [2.6 RFC/PATCH] Input: possible deadlock in i8042
Date: Sun, 30 Nov 2003 03:03:57 -0500
User-Agent: KMail/1.5.4
Cc: Vojtech Pavlik <vojtech@suse.cz>, Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311300303.57654.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If request_irq fails in i8042_open it will call serio_unregister_port,
which takes serio_sem. i8042_open may be called:

serio_register_port - serio_find_dev - dev->connect
serio_register_device - dev->connect

Both serio_register_port and serio_register_device take serio_sem as well.

I think that serio_{register|unregister}_port can be converted into
submitting requests to kseriod thus removing deadlock on the serio_sem.

The patch below is on top of serio* patches in Andrew Morton's -mm tree.

Dmitry

===================================================================


ChangeSet@1.1512, 2003-11-30 02:42:54-05:00, dtor_core@ameritech.net
  Input: Use kseriod to register/unregister serio ports


 serio.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

===================================================================

diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Sun Nov 30 03:01:40 2003
+++ b/drivers/input/serio/serio.c	Sun Nov 30 03:01:40 2003
@@ -83,8 +83,10 @@
 	}
 }
 
-#define SERIO_RESCAN	1
-#define SERIO_RECONNECT	2
+#define SERIO_RESCAN		1
+#define SERIO_RECONNECT		2
+#define SERIO_REGISTER_PORT	3
+#define SERIO_UNREGISTER_PORT	4
 
 static DECLARE_WAIT_QUEUE_HEAD(serio_wait);
 static DECLARE_COMPLETION(serio_exited);
@@ -111,6 +113,14 @@
 			goto event_done;
 		
 		switch (event->type) {
+			case SERIO_REGISTER_PORT :
+				__serio_register_port(event->serio);
+				break;
+
+			case SERIO_UNREGISTER_PORT :
+				__serio_unregister_port(event->serio);
+				break;
+
 			case SERIO_RECONNECT :
 				if (event->serio->dev && event->serio->dev->reconnect)
 					if (event->serio->dev->reconnect(event->serio) == 0)
@@ -192,9 +202,7 @@
 
 void serio_register_port(struct serio *serio)
 {
-	down(&serio_sem);
-	__serio_register_port(serio);
-	up(&serio_sem);
+	serio_queue_event(serio, SERIO_REGISTER_PORT);
 }
 
 /*
@@ -210,9 +218,7 @@
 
 void serio_unregister_port(struct serio *serio)
 {
-	down(&serio_sem);
-	__serio_unregister_port(serio);
-	up(&serio_sem);
+	serio_queue_event(serio, SERIO_UNREGISTER_PORT);
 }
 
 /*

