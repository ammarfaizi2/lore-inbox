Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbUKLGhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbUKLGhV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 01:37:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbUKLGfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 01:35:48 -0500
Received: from smtp811.mail.sc5.yahoo.com ([66.163.170.81]:14494 "HELO
	smtp811.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262462AbUKLGfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 01:35:08 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/7] Add serio start() and stop() methods
Date: Fri, 12 Nov 2004 01:29:56 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200411120127.01473.dtor_core@ameritech.net> <200411120129.04300.dtor_core@ameritech.net>
In-Reply-To: <200411120129.04300.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200411120129.58520.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



===================================================================


ChangeSet@1.1986, 2004-11-11 23:04:12-05:00, dtor_core@ameritech.net
  Input: add serio->start() and serio->stop() callback methods that
         are called whenever serio port is finishes being registered
         or unregistered. The callbacks are useful for drivers that
         share interrupt between several ports and there is a danger
         that interrupt handler will reference port that was just
         unregistered.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/serio/serio.c |    8 +++++++-
 include/linux/serio.h       |    2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-11-12 01:00:20 -05:00
+++ b/drivers/input/serio/serio.c	2004-11-12 01:00:20 -05:00
@@ -328,7 +328,10 @@
 	serio->dev.release = serio_release_port;
 	if (serio->parent)
 		serio->dev.parent = &serio->parent->dev;
-	device_register(&serio->dev);
+	device_initialize(&serio->dev);
+	if (serio->start)
+		serio->start(serio);
+	device_add(&serio->dev);
 }
 
 /*
@@ -350,6 +353,9 @@
 		up_write(&serio_bus.subsys.rwsem);
 		put_driver(&drv->driver);
 	}
+
+	if (serio->stop)
+		serio->stop(serio);
 
 	if (serio->parent) {
 		spin_lock_irqsave(&serio->parent->lock, flags);
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-11-12 01:00:20 -05:00
+++ b/include/linux/serio.h	2004-11-12 01:00:20 -05:00
@@ -42,6 +42,8 @@
 	int (*write)(struct serio *, unsigned char);
 	int (*open)(struct serio *);
 	void (*close)(struct serio *);
+	int (*start)(struct serio *);
+	void (*stop)(struct serio *);
 
 	struct serio *parent, *child;
 
