Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTLAHSa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTLAHSa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:18:30 -0500
Received: from smtp806.mail.sc5.yahoo.com ([66.163.168.185]:4454 "HELO
	smtp806.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263464AbTLAHSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:18:22 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: [RFC/PATCH 1/3] Input: resume support for i8042 (atkbd & psmouse)
Date: Mon, 1 Dec 2003 02:15:56 -0500
User-Agent: KMail/1.5.4
Cc: Pavel Machek <pavel@ucw.cz>, Vojtech Pavlik <vojtech@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312010215.58533.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is an attempt to implement resume for i8042 using serio_reconnect
facility that can be found in -mm kernels. It also depends on bunch of 
other changes in input subsystem all of which can be found here:
http://www.geocities.com/dt_or/input

They should apply cleanly to -test11.

Dmitry 

===================================================================


ChangeSet@1.1514, 2003-12-01 01:41:05-05:00, dtor_core@ameritech.net
  Input: add i8042 to sysfs, implement resume methods using
         serio_reconnect facility


 i8042.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 81 insertions(+), 9 deletions(-)


===================================================================



diff -Nru a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
--- a/drivers/input/serio/i8042.c	Mon Dec  1 01:45:25 2003
+++ b/drivers/input/serio/i8042.c	Mon Dec  1 01:45:25 2003
@@ -17,6 +17,7 @@
 #include <linux/config.h>
 #include <linux/reboot.h>
 #include <linux/init.h>
+#include <linux/sysdev.h>
 #include <linux/serio.h>
 
 #include <asm/io.h>
@@ -61,6 +62,8 @@
 static unsigned char i8042_mux_open;
 struct timer_list i8042_timer;
 
+static int i8042_sysdev_initialized;
+
 /*
  * Shared IRQ's require a device pointer, but this driver doesn't support
  * multiple devices
@@ -214,16 +217,35 @@
 }
 
 /*
- * i8042_open() is called when a port is open by the higher layer.
- * It allocates the interrupt and enables it in the chip.
+ * i8042_activate_port() enables port on a chip.
  */
 
-static int i8042_open(struct serio *port)
+static int i8042_activate_port(struct serio *port)
 {
 	struct i8042_values *values = port->driver;
 
 	i8042_flush();
 
+	i8042_ctr |= values->irqen;
+
+	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
+		i8042_ctr &= ~values->irqen;
+		return -1;
+	}
+
+	return 0;
+}
+
+
+/*
+ * i8042_open() is called when a port is open by the higher layer.
+ * It allocates the interrupt and calls i8042_enable_port.
+ */
+
+static int i8042_open(struct serio *port)
+{
+	struct i8042_values *values = port->driver;
+
 	if (values->mux != -1)
 		if (i8042_mux_open++)
 			return 0;
@@ -234,10 +256,8 @@
 		goto irq_fail;
 	}
 
-	i8042_ctr |= values->irqen;
-
-	if (i8042_command(&i8042_ctr, I8042_CMD_CTL_WCTR)) {
-		printk(KERN_ERR "i8042.c: Can't write CTR while opening %s, unregistering the port\n", values->name);
+	if (i8042_activate_port(port)) {
+		printk(KERN_ERR "i8042.c: Can't activate %s, unregistering the port\n", values->name);
 		goto ctr_fail;
 	}
 
@@ -246,7 +266,6 @@
 	return 0;
 
 ctr_fail:
-	i8042_ctr &= ~values->irqen;
 	free_irq(values->irq, i8042_request_irq_cookie);
 
 irq_fail:
@@ -406,7 +425,7 @@
  * desired.
  */
 	
-static int __init i8042_controller_init(void)
+static int i8042_controller_init(void)
 {
 
 /*
@@ -541,6 +560,37 @@
 }
 
 /*
+ * Here we try to reset everything back to a state in which suspended
+ */
+
+static int i8042_controller_resume(struct sys_device *dev)
+{
+	int i;
+
+	if (i8042_controller_init()) {
+		printk(KERN_ERR "i8042: resume failed\n");
+		return -1;
+	}
+
+/*
+ * Reconnect anything that was connected to the ports.
+ */
+
+	if (i8042_kbd_values.exists && i8042_activate_port(&i8042_kbd_port) == 0)
+		serio_reconnect(&i8042_kbd_port);
+
+	if (i8042_aux_values.exists && i8042_activate_port(&i8042_aux_port) == 0)
+		serio_reconnect(&i8042_aux_port);
+
+	for (i = 0; i < 4; i++)
+		if (i8042_mux_values[i].exists && i8042_activate_port(i8042_mux_port + i) == 0)
+			serio_reconnect(i8042_mux_port + i);
+
+	return 0;
+}
+
+
+/*
  * i8042_check_mux() checks whether the controller supports the PS/2 Active
  * Multiplexing specification by Synaptics, Phoenix, Insyde and
  * LCS/Telegraphics.
@@ -791,6 +841,16 @@
 	values->mux = index;
 }
 
+static struct sysdev_class kbc_sysclass = {
+       set_kset_name("i8042"),
+       .resume = i8042_controller_resume,
+};
+
+static struct sys_device device_i8042 = {
+       .id     = 0,
+       .cls    = &kbc_sysclass,
+};
+
 int __init i8042_init(void)
 {
 	int i;
@@ -825,6 +885,13 @@
 	i8042_timer.function = i8042_timer_func;
 	mod_timer(&i8042_timer, jiffies + I8042_POLL_PERIOD);
 
+        if (sysdev_class_register(&kbc_sysclass) == 0) {
+                if (sys_device_register(&device_i8042) == 0)
+			i8042_sysdev_initialized = 1;
+		else
+			sysdev_class_unregister(&kbc_sysclass);
+        }
+
 	register_reboot_notifier(&i8042_notifier);
 
 	return 0;
@@ -835,6 +902,11 @@
 	int i;
 
 	unregister_reboot_notifier(&i8042_notifier);
+
+	if (i8042_sysdev_initialized) {
+		sys_device_unregister(&device_i8042);
+		sysdev_class_unregister(&kbc_sysclass);
+	}
 
 	del_timer(&i8042_timer);
 
