Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbUFCKWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUFCKWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 06:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUFCKWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 06:22:32 -0400
Received: from ee.oulu.fi ([130.231.61.23]:54939 "EHLO ee.oulu.fi")
	by vger.kernel.org with ESMTP id S263147AbUFCKVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 06:21:46 -0400
Date: Thu, 3 Jun 2004 13:21:21 +0300 (EEST)
From: Tuukka Toivonen <tuukkat@ee.oulu.fi>
X-X-Sender: tuukkat@stekt37
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Sau Dan Lee <danlee@informatik.uni-freiburg.de>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Re: SERIO_USERDEV patch for 2.6
In-Reply-To: <Pine.GSO.4.58.0406011105330.6922@stekt37>
Message-ID: <Pine.GSO.4.58.0406031241330.8752@stekt37>
References: <xb7r7t2b3mb.fsf@savona.informatik.uni-freiburg.de>
 <20040530111847.GA1377@ucw.cz> <xb71xl2b0to.fsf@savona.informatik.uni-freiburg.de>
 <20040530124353.GB1496@ucw.cz> <xb7aczq9he1.fsf@savona.informatik.uni-freiburg.de>
 <20040530134246.GA1828@ucw.cz> <Pine.GSO.4.58.0406011105330.6922@stekt37>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

New version released which addresses the issues you mentioned:
wget \
http://www.ee.oulu.fi/~tuukkat/tmp/linux-2.6.6-userdev.20040603.patch

>On Sun, 30 May 2004, Vojtech Pavlik wrote:
>>Coexisting would mean that when someone wants to open the raw device,
>>the serio layer would disconnect the psmouse driver, and give control to
>>the raw device instead. I believe that could work.

Done, with slight modification: if the device is opened in read-only mode,
the kernel drivers are not disconnected. This way the serio port could be
controlled via IOCTL even when assigned to kernel drivers, if it ever
becomes useful. Useful also for debugging etc.

>>I'd like to keep it separate from the
>>serio.c file, although it's obvious it'll require to be linked to it
>>statically, because it needs hooks there

Done. It's now in serio-dev.c. I also added serio-dev.h, which
unfortunately is slightly messy so that I was able to inline some
functions. It would be trivial to clean it up, if I wouldn't inline
those functions.

I also had to rename serio.c into serio-core.c, which makes the actual
changes into the file unobvious from the patch above. I made a separate
diff about that, shown below (just for easy comparison).

The last change I made converts slashes '/' into underscores '_' (so
eg. isa0060/serio0 is changed to isa0060_serio0 in /proc/misc, /dev
with devfs, and /sys) because Sau Dan Lee reported that slashes don't work
well with sysfs.

I tested the patch in a couple of machines, especially the new features.
Seems to work finely.

Compared to Dmitry's rawdev patch, this has a number of advantages:

- Supports all serio ports without any additional
  kernel parameters. Binding between kernel/user driver is done
  automatically.

- Supports multiple drivers on the same port, unlike Dmitry's rawdev,
  which works just similarly as 2.4.x psaux which didn't work with e.g.
  X11 and gpm together without a repeater feed, because multiple
  drivers are fighting for the byte streams.
  (Doesn't still allow multiple kernel drivers nor a kernel driver
  with a complete user drivers with write access since the required
  infrastructure is missing in serio.c aka serio-core.c: kernel internal
  drivers can't lock a port).

- Dmitry's rawdev appears to assign port numbers quite randomly. If some
  changes in i8042.c are done which register the ports in different order,
  rawdev would give ports different numbers, and since it doesn't appear
  to otherwise be possible to detect from userland which is which, drivers
  would use bad ports.
  It's even worse if also other port drivers than i8042.c would support
  raw devices, because then the module loading order would matter.
  (or so it looks from the code, I didn't actually try it).

[Do not apply the patch below, apply the complete patch given above]

--- linux-2.6.6/drivers/input/serio/serio.c	Wed Jun  2 20:23:11 2004
+++ linux-2.6.6userdev/drivers/input/serio/serio-core.c	Wed Jun  2 23:30:21 2004
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

@@ -293,6 +323,12 @@
 int serio_open(struct serio *serio, struct serio_dev *dev)
 {
 	serio->dev = dev;
+#ifdef CONFIG_SERIO_USERDEV
+	/* When there are processes having the userdev open,
+	 * the port is already open and needs not to be re-opened. */
+	if (serio_userdev_users(serio) > 0)
+		return 0;
+#endif
 	if (serio->open(serio)) {
 		serio->dev = NULL;
 		return -1;
@@ -303,7 +339,11 @@
 /* called from serio_dev->connect/disconnect methods under serio_sem */
 void serio_close(struct serio *serio)
 {
-	serio->close(serio);
+#ifdef CONFIG_SERIO_USERDEV
+	/* Close only if the port is not open by userspace drivers */
+	if (serio_userdev_users(serio) <= 0)
+#endif
+		serio->close(serio);
 	serio->dev = NULL;
 }

