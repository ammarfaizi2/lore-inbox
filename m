Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268425AbUIQFHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268425AbUIQFHA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 01:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268420AbUIQFHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 01:07:00 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:56744 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268425AbUIQFBn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 01:01:43 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 2/3] serio-pin-driver.patch
Date: Fri, 17 Sep 2004 00:00:19 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200409162358.27678.dtor_core@ameritech.net> <200409162359.45766.dtor_core@ameritech.net>
In-Reply-To: <200409162359.45766.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409170000.21369.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


===================================================================


ChangeSet@1.1903, 2004-09-16 23:06:29-05:00, dtor_core@ameritech.net
  Input: add serio_[un]pin_driver() functions so attribute handlers
         can safely access driver bound to a serio port.
  
  Signed-off-by: Dmitry Torokhov <dtor@mail.ru>


 drivers/input/serio/serio.c |   20 ++++++++++++--------
 include/linux/serio.h       |   16 +++++++++++++++-
 2 files changed, 27 insertions(+), 9 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	2004-09-16 23:31:24 -05:00
+++ b/drivers/input/serio/serio.c	2004-09-16 23:31:24 -05:00
@@ -326,6 +326,7 @@
 	try_module_get(THIS_MODULE);
 
 	spin_lock_init(&serio->lock);
+	init_MUTEX(&serio->drv_sem);
 	list_add_tail(&serio->node, &serio_list);
 	snprintf(serio->dev.bus_id, sizeof(serio->dev.bus_id), "serio%d", serio_no++);
 	serio->dev.bus = &serio_bus;
@@ -595,17 +596,22 @@
 	up(&serio_sem);
 }
 
-/* called from serio_driver->connect/disconnect methods under serio_sem */
-int serio_open(struct serio *serio, struct serio_driver *drv)
+static void serio_set_drv(struct serio *serio, struct serio_driver *drv)
 {
+	down(&serio->drv_sem);
 	serio_pause_rx(serio);
 	serio->drv = drv;
 	serio_continue_rx(serio);
+	up(&serio->drv_sem);
+}
+
+/* called from serio_driver->connect/disconnect methods under serio_sem */
+int serio_open(struct serio *serio, struct serio_driver *drv)
+{
+	serio_set_drv(serio, drv);
 
 	if (serio->open && serio->open(serio)) {
-		serio_pause_rx(serio);
-		serio->drv = NULL;
-		serio_continue_rx(serio);
+		serio_set_drv(serio, NULL);
 		return -1;
 	}
 	return 0;
@@ -617,9 +623,7 @@
 	if (serio->close)
 		serio->close(serio);
 
-	serio_pause_rx(serio);
-	serio->drv = NULL;
-	serio_continue_rx(serio);
+	serio_set_drv(serio, NULL);
 }
 
 irqreturn_t serio_interrupt(struct serio *serio,
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	2004-09-16 23:31:24 -05:00
+++ b/include/linux/serio.h	2004-09-16 23:31:24 -05:00
@@ -45,7 +45,8 @@
 
 	struct serio *parent, *child;
 
-	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock */
+	struct serio_driver *drv;	/* accessed from interrupt, must be protected by serio->lock and serio->sem */
+	struct semaphore drv_sem;	/* protects serio->drv so attributes can pin driver */
 
 	struct device dev;
 
@@ -120,6 +121,19 @@
 static __inline__ void serio_continue_rx(struct serio *serio)
 {
 	spin_unlock_irq(&serio->lock);
+}
+
+/*
+ * Use the following fucntions to pin serio's driver in process context
+ */
+static __inline__ int serio_pin_driver(struct serio *serio)
+{
+	return down_interruptible(&serio->drv_sem);
+}
+
+static __inline__ void serio_unpin_driver(struct serio *serio)
+{
+	up(&serio->drv_sem);
 }
 
 
