Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263151AbTI3G2O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 02:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263149AbTI3G2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 02:28:14 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:33213 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263141AbTI3G2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 02:28:05 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: [PATCH 1/6] serio: rename serio_[un]register_slave_port to __serio_[un]register_port
Date: Tue, 30 Sep 2003 01:06:20 -0500
User-Agent: KMail/1.5.4
Cc: akpm@osdl.org, petero2@telia.com, linux-kernel@vger.kernel.org
References: <200309300052.49908.dtor_core@ameritech.net>
In-Reply-To: <200309300052.49908.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309300106.20744.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Input: rename serio_{register|unregister}_slave_port to 
       __serio_{register|unregister}_port to better follow
       locked/lockless naming convention


 drivers/input/mouse/synaptics.c |    4 ++--
 drivers/input/serio/serio.c     |   23 ++++++++++-------------
 include/linux/serio.h           |    4 ++--
 3 files changed, 14 insertions(+), 17 deletions(-)

===================================================================

diff -Nru a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
--- a/drivers/input/mouse/synaptics.c	Tue Sep 30 01:02:23 2003
+++ b/drivers/input/mouse/synaptics.c	Tue Sep 30 01:02:23 2003
@@ -294,7 +294,7 @@
 	port->driver = psmouse;
 
 	printk(KERN_INFO "serio: %s port at %s\n", port->name, psmouse->phys);
-	serio_register_slave_port(port);
+	__serio_register_port(port);	/* already have serio_sem */
 
 	/* adjust the touchpad to child's choice of protocol */
 	child = port->private;
@@ -406,7 +406,7 @@
 	if (psmouse->type == PSMOUSE_SYNAPTICS && priv) {
 		synaptics_mode_cmd(psmouse, 0);
 		if (priv->ptport) {
-			serio_unregister_slave_port(priv->ptport);
+			__serio_unregister_port(priv->ptport); /* already have serio_sem */
 			kfree(priv->ptport);
 		}
 		kfree(priv);
diff -Nru a/drivers/input/serio/serio.c b/drivers/input/serio/serio.c
--- a/drivers/input/serio/serio.c	Tue Sep 30 01:02:23 2003
+++ b/drivers/input/serio/serio.c	Tue Sep 30 01:02:23 2003
@@ -49,9 +49,9 @@
 
 EXPORT_SYMBOL(serio_interrupt);
 EXPORT_SYMBOL(serio_register_port);
-EXPORT_SYMBOL(serio_register_slave_port);
+EXPORT_SYMBOL(__serio_register_port);
 EXPORT_SYMBOL(serio_unregister_port);
-EXPORT_SYMBOL(serio_unregister_slave_port);
+EXPORT_SYMBOL(__serio_unregister_port);
 EXPORT_SYMBOL(serio_register_device);
 EXPORT_SYMBOL(serio_unregister_device);
 EXPORT_SYMBOL(serio_open);
@@ -163,17 +163,16 @@
 void serio_register_port(struct serio *serio)
 {
 	down(&serio_sem);
-	list_add_tail(&serio->node, &serio_list);
-	serio_find_dev(serio);
+	__serio_register_port(serio);
 	up(&serio_sem);
 }
 
 /*
- * Same as serio_register_port but does not try to acquire serio_sem.
- * Should be used when registering a serio from other input device's
+ * Should only be called directly if serio_sem has already been taken,
+ * for example when unregistering a serio from other input device's 
  * connect() function.
  */
-void serio_register_slave_port(struct serio *serio)
+void __serio_register_port(struct serio *serio)
 {
 	list_add_tail(&serio->node, &serio_list);
 	serio_find_dev(serio);
@@ -182,18 +181,16 @@
 void serio_unregister_port(struct serio *serio)
 {
 	down(&serio_sem);
-	list_del_init(&serio->node);
-	if (serio->dev && serio->dev->disconnect)
-		serio->dev->disconnect(serio);
+	__serio_unregister_port(serio);
 	up(&serio_sem);
 }
 
 /*
- * Same as serio_unregister_port but does not try to acquire serio_sem.
- * Should be used when unregistering a serio from other input device's
+ * Should only be called directly if serio_sem has already been taken,
+ * for example when unregistering a serio from other input device's 
  * disconnect() function.
  */
-void serio_unregister_slave_port(struct serio *serio)
+void __serio_unregister_port(struct serio *serio)
 {
 	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
diff -Nru a/include/linux/serio.h b/include/linux/serio.h
--- a/include/linux/serio.h	Tue Sep 30 01:02:23 2003
+++ b/include/linux/serio.h	Tue Sep 30 01:02:23 2003
@@ -65,9 +65,9 @@
 irqreturn_t serio_interrupt(struct serio *serio, unsigned char data, unsigned int flags, struct pt_regs *regs);
 
 void serio_register_port(struct serio *serio);
-void serio_register_slave_port(struct serio *serio);
+void __serio_register_port(struct serio *serio);
 void serio_unregister_port(struct serio *serio);
-void serio_unregister_slave_port(struct serio *serio);
+void __serio_unregister_port(struct serio *serio);
 void serio_register_device(struct serio_dev *dev);
 void serio_unregister_device(struct serio_dev *dev);
 

