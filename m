Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264910AbUF1Kuz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbUF1Kuz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 06:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264911AbUF1Kuz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 06:50:55 -0400
Received: from ee.oulu.fi ([130.231.61.23]:4541 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S264910AbUF1Kut (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 06:50:49 -0400
Date: Mon, 28 Jun 2004 13:50:38 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: SERIO_USERDEV patch (was: Re: [PATCH 0/19] New set of input patches)
In-Reply-To: <xb7d63kj8ue.fsf@savona.informatik.uni-freiburg.de>
Message-ID: <Pine.GSO.4.58.0406281344510.2958@stekt37>
References: <xb7d63kj8ue.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Mon, Jun 28, 2004 at 12:08:21AM -0500, Dmitry Torokhov wrote:
>    >> 10-serio_raw.patch - raw access to serio data ala 2.4
>    >> /dev/psaux
>    Vojtech> OK, finally those who insist on /dev/psaux can shut up

Nice. So serio_userdev is now out of question and I can stop maintaining
it?

Here's still the last version against clean 2.6.7 kernel (but it certainly
won't apply after Dmitry's changes):

http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.7-userdev.20040625.patch

Nothing new, just updated for 2.6.7.

P.S. I'm looking for documentation about the __user thing. Is there any?

And just for completeness here's the diff between serio.c and serio-core.c
(which is renamed by the patch):

--- linux-2.6.7/drivers/input/serio/serio.c	Fri Jun 25 13:38:11 2004
+++ linux-2.6.7userdev/drivers/input/serio/serio-core.c	Fri Jun 25 14:06:31 2004
@@ -30,6 +30,8 @@
  * Changes:
  * 20 Jul. 2003    Daniele Bellucci <bellucda@tiscali.it>
  *                 Minor cleanups.
+ * 31  May  2004   Tuukka Toivonen <tuukkat@ee.oulu.fi>
+ *                 Added hooks for serio-dev.c, renamed from serio.c.
  */

 #include <linux/stddef.h>
@@ -43,6 +45,10 @@
 #include <linux/suspend.h>
 #include <linux/slab.h>

+#ifdef CONFIG_SERIO_USERDEV
+#include "serio-dev.h"
+#endif
+
 MODULE_AUTHOR("Vojtech Pavlik <vojtech@ucw.cz>");
 MODULE_DESCRIPTION("Serio abstraction core");
 MODULE_LICENSE("GPL");
@@ -67,16 +73,20 @@
 	struct list_head node;
 };

-static DECLARE_MUTEX(serio_sem);
-static LIST_HEAD(serio_list);
+DECLARE_MUTEX(serio_sem);
+LIST_HEAD(serio_list);
 static LIST_HEAD(serio_dev_list);
 static LIST_HEAD(serio_event_list);
 static int serio_pid;

-static void serio_find_dev(struct serio *serio)
+void serio_find_dev(struct serio *serio)
 {
 	struct serio_dev *dev;

+#ifdef CONFIG_SERIO_USERDEV
+	if (serio_userdev_writers(serio) > 0)
+		return;
+#endif
 	list_for_each_entry(dev, &serio_dev_list, node) {
 		if (serio->dev)
 			break;
@@ -189,18 +199,25 @@
 irqreturn_t serio_interrupt(struct serio *serio,
 		unsigned char data, unsigned int flags, struct pt_regs *regs)
 {
-	irqreturn_t ret = IRQ_NONE;
+	irqreturn_t r, ret = IRQ_NONE;
+	int rescan = 1;

-        if (serio->dev && serio->dev->interrupt) {
-                ret = serio->dev->interrupt(serio, data, flags, regs);
-	} else {
-		if (!flags) {
-			if ((serio->type == SERIO_8042 ||
-				serio->type == SERIO_8042_XL) && (data != 0xaa))
-					return ret;
-			serio_rescan(serio);
-			ret = IRQ_HANDLED;
-		}
+#ifdef CONFIG_SERIO_USERDEV
+	ret = serio_userdev_newbyte(serio, data);
+	if (ret == IRQ_HANDLED)
+		rescan = 0;
+#endif
+	if (serio->dev && serio->dev->interrupt) {
+		r = serio->dev->interrupt(serio, data, flags, regs);
+		if (ret == IRQ_NONE) ret = r;
+		rescan = 0;
+	}
+	if (rescan && !flags) {
+		if ((serio->type == SERIO_8042 ||
+			serio->type == SERIO_8042_XL) && (data != 0xaa))
+				return ret;
+		serio_rescan(serio);
+		ret = IRQ_HANDLED;
 	}
 	return ret;
 }
@@ -231,6 +248,9 @@
 {
 	list_add_tail(&serio->node, &serio_list);
 	serio_find_dev(serio);
+#ifdef CONFIG_SERIO_USERDEV
+	serio_userdev_init(serio);
+#endif
 }

 void serio_unregister_port(struct serio *serio)
@@ -257,6 +277,11 @@
  */
 void __serio_unregister_port(struct serio *serio)
 {
+#ifdef CONFIG_SERIO_USERDEV
+	/* Here we assume that the interrupt handler is not anymore
+	 * called and is not still executing from previous call */
+	serio_userdev_cleanup(serio);
+#endif
 	serio_invalidate_pending_events(serio);
 	list_del_init(&serio->node);
 	if (serio->dev && serio->dev->disconnect)
@@ -268,9 +293,14 @@
 	struct serio *serio;
 	down(&serio_sem);
 	list_add_tail(&dev->node, &serio_dev_list);
-	list_for_each_entry(serio, &serio_list, node)
+	list_for_each_entry(serio, &serio_list, node) {
+#ifdef CONFIG_SERIO_USERDEV
+		if (serio_userdev_writers(serio) > 0)
+			continue;
+#endif
 		if (!serio->dev && dev->connect)
 			dev->connect(serio, dev);
+	}
 	up(&serio_sem);
 }

@@ -293,7 +323,13 @@
 int serio_open(struct serio *serio, struct serio_dev *dev)
 {
 	serio->dev = dev;
-	if (serio->open && serio->open(serio)) {
+#ifdef CONFIG_SERIO_USERDEV
+	/* When there are processes having the userdev open,
+	 * the port is already open and needs not to be re-opened. */
+	if (serio_userdev_users(serio) > 0)
+		return 0;
+#endif
+	if (serio->open(serio)) {
 		serio->dev = NULL;
 		return -1;
 	}
@@ -303,7 +339,10 @@
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
-	if (serio->close)
+#ifdef CONFIG_SERIO_USERDEV
+	/* Close only if the port is not open by userspace drivers */
+	if (serio_userdev_users(serio) <= 0)
+#endif
 		serio->close(serio);
 	serio->dev = NULL;
 }
