Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVGGBoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVGGBoL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 21:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262418AbVGGBms
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 21:42:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:39106 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262399AbVGGBlq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 21:41:46 -0400
X-Authenticated: #25753041
From: Genadz Batsyan <gbatyan@gmx.net>
To: linux-kernel@vger.kernel.org
Subject: overriding keyboard driver in a module
Date: Thu, 7 Jul 2005 03:41:40 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507070341.41095.gbatyan@gmx.net>
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing a little tool to allow intercepting keyboard events and 
substituting them with other events / swallowing events / emitting additional 
events on a low level before normal processing by kernel.
http://kbd-mangler.sourceforge.net/

Currently to have precedense over the keyboard driver I'm using a patch 
against drivers/input/keyboard/atkbd.c

Well, I guess, patching kernel is unthinkable for most linux users, so I 
thought, maybe there is a way to do it without the kernel patch.
Is it possible to write a kernel module to intercept keyboard events
and have precedense over the kernel driver?

If anyone is interested, below is my patch.
 I know it's damn dirty (especially the last_dev thingy :-)
but take it easy, it's my first kernel undertaking, a product of a few days, 
and most importantly - it works.

Any kind of suggestions would be appreciated a lot.

-----------------------

--- linux-2.6.11.6-orig/drivers/input/keyboard/atkbd.c	2005-03-26 
04:28:48.000000000 +0100
+++ linux-2.6.11.6-patched/drivers/input/keyboard/atkbd.c	2005-07-01 
22:15:52.000000000 +0200
@@ -34,6 +34,10 @@
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
+
+#define CONFIG_KBD_INTERCEPTOR 1
+
+
 static int atkbd_set = 2;
 module_param_named(set, atkbd_set, int, 0);
 MODULE_PARM_DESC(set, "Select keyboard code set (2 = default, 3 = PS/2 
native)");
@@ -229,18 +233,79 @@
 ATKBD_DEFINE_ATTR(softraw);
 
 
-static void atkbd_report_key(struct input_dev *dev, struct pt_regs *regs, int 
code, int value)
+
+
+
+#ifdef CONFIG_KBD_INTERCEPTOR
+
+typedef int (*KBD_INTERCEPTOR)(int *, int *);
+
+static KBD_INTERCEPTOR kbd_interceptor;
+static struct input_dev *last_dev;
+
+#endif
+
+
+
+
+static void _atkbd_report_key(struct input_dev *dev, int code, int value)
 {
-	input_regs(dev, regs);
 	if (value == 3) {
 		input_report_key(dev, code, 1);
 		input_sync(dev);
 		input_report_key(dev, code, 0);
 	} else
 		input_event(dev, EV_KEY, code, value);
+}
+
+static void atkbd_report_key(struct input_dev *dev, struct pt_regs *regs, int 
code, int value)
+{
+	input_regs(dev, regs);
+
+#ifdef CONFIG_KBD_INTERCEPTOR
+        if (kbd_interceptor && kbd_interceptor(&code, &value))
+        {
+                return;
+        }
+#endif
+	_atkbd_report_key(dev, code, value);
 	input_sync(dev);
 }
 
+#ifdef CONFIG_KBD_INTERCEPTOR
+KBD_INTERCEPTOR kbd_set_interceptor(KBD_INTERCEPTOR interceptor)
+{
+        KBD_INTERCEPTOR old = kbd_interceptor;
+        kbd_interceptor = interceptor;
+        return old;
+}
+
+void kbd_emit_key(int code, int down)
+{
+    if (last_dev)
+        _atkbd_report_key(last_dev, code, down);
+    else
+        printk("kbd_emit_key: input_dev not set\n");
+}
+void kbd_emit_sync()
+{
+    if (last_dev)
+        input_sync(last_dev);
+    else
+        printk("kbd_emit_key: input_dev not set\n");
+}
+
+
+EXPORT_SYMBOL(kbd_set_interceptor);
+EXPORT_SYMBOL(kbd_emit_key);
+EXPORT_SYMBOL(kbd_emit_sync);
+
+#endif
+
+
+
+
+
 /*
  * atkbd_interrupt(). Here takes place processing of data received from
  * the keyboard into events.
@@ -660,6 +725,10 @@
 {
 	struct atkbd *atkbd = serio->private;
 
+#ifdef CONFIG_KBD_INTERCEPTOR
+        last_dev = NULL;
+#endif
+
 	atkbd_disable(atkbd);
 
 	/* make sure we don't have a command in flight */
@@ -847,6 +916,10 @@
 
 	input_register_device(&atkbd->dev);
 
+#ifdef CONFIG_KBD_INTERCEPTOR
+	last_dev = &atkbd->dev;
+#endif
+
 	device_create_file(&serio->dev, &atkbd_attr_extra);
 	device_create_file(&serio->dev, &atkbd_attr_scroll);
 	device_create_file(&serio->dev, &atkbd_attr_set);
@@ -1097,6 +1170,9 @@
 
 int __init atkbd_init(void)
 {
+#ifdef CONFIG_KBD_INTERCEPTOR
+        last_dev = NULL;
+#endif
 	serio_register_driver(&atkbd_drv);
 	return 0;
 }



