Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265837AbUGHHCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265837AbUGHHCG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 03:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265825AbUGHHBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 03:01:04 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:50818 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265828AbUGHG7S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 02:59:18 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 4/8] New set of input patches
Date: Thu, 8 Jul 2004 01:57:15 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407080155.07827.dtor_core@ameritech.net> <200407080156.05021.dtor_core@ameritech.net> <200407080156.32341.dtor_core@ameritech.net>
In-Reply-To: <200407080156.32341.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200407080157.17205.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1823, 2004-07-08 00:24:20-05:00, dtor_core@ameritech.net
  Input: add serio_pause_rx and serio_continue_rx so drivers can protect
         their critical sections from port's interrupt handler
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/serio/serio.c |   18 ++++++++----------
 include/linux/serio.h       |   21 +++++++++++++++++++--
 2 files changed, 27 insertions(+), 12 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-07-08 01:35:14 -05:00
+++ b/drivers/input/serio/serio.c	2004-07-08 01:35:14 -05:00
@@ -541,15 +541,14 @@
 /* called from serio_driver->connect/disconnect methods under serio_sem */
 int serio_open(struct serio *serio, struct serio_driver *drv)
 {
-	unsigned long flags;
-
-	spin_lock_irqsave(&serio->lock, flags);
+	serio_pause_rx(serio);
 	serio->drv = drv;
-	spin_unlock_irqrestore(&serio->lock, flags);
+	serio_continue_rx(serio);
+
 	if (serio->open && serio->open(serio)) {
-		spin_lock_irqsave(&serio->lock, flags);
+		serio_pause_rx(serio);
 		serio->drv = NULL;
-		spin_unlock_irqrestore(&serio->lock, flags);
+		serio_continue_rx(serio);
 		return -1;
 	}
 	return 0;
@@ -558,13 +557,12 @@
 /* called from serio_driver->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
-	unsigned long flags;
-
 	if (serio->close)
 		serio->close(serio);
-	spin_lock_irqsave(&serio->lock, flags);
+
+	serio_pause_rx(serio);
 	serio->drv = NULL;
-	spin_unlock_irqrestore(&serio->lock, flags);
+	serio_continue_rx(serio);
 }
 
 irqreturn_t serio_interrupt(struct serio *serio,
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-07-08 01:35:14 -05:00
+++ b/include/linux/serio.h	2004-07-08 01:35:14 -05:00
@@ -35,7 +35,7 @@
 	unsigned long type;
 	unsigned long event;
 
-	spinlock_t lock;
+	spinlock_t lock;		/* protects critical sections from port's interrupt handler */
 
 	int (*write)(struct serio *, unsigned char);
 	int (*open)(struct serio *);
@@ -43,7 +43,7 @@
 
 	struct serio *parent, *child;
 
-	struct serio_driver *drv; /* Accessed from interrupt, writes must be protected by serio_lock */
+	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock */
 
 	struct device dev;
 
@@ -81,6 +81,7 @@
 void serio_register_port_delayed(struct serio *serio);
 void serio_unregister_port(struct serio *serio);
 void serio_unregister_port_delayed(struct serio *serio);
+
 void serio_register_driver(struct serio_driver *drv);
 void serio_unregister_driver(struct serio_driver *drv);
 
@@ -103,6 +104,22 @@
 	if (serio->drv && serio->drv->cleanup)
 		serio->drv->cleanup(serio);
 }
+
+
+/*
+ * Use the following fucntions to protect critical sections in
+ * driver code from port's interrupt handler
+ */
+static __inline__ void serio_pause_rx(struct serio *serio)
+{
+	spin_lock_irq(&serio->lock);
+}
+
+static __inline__ void serio_continue_rx(struct serio *serio)
+{
+	spin_unlock_irq(&serio->lock);
+}
+
 
 #endif
 
