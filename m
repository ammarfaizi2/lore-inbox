Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbTKPNLT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262827AbTKPNLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:11:19 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:4224 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262805AbTKPNLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:11:08 -0500
Date: Sun, 16 Nov 2003 14:11:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>, vojtech@ucw.cz
Subject: Corrected drivermodel for i8042.c
Message-ID: <20031116131134.GA301@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Here's (slightly) better patch. i8042_controller_init() can not be
__init when it is called from _resume() function.
								Pavel

--- clean/drivers/input/serio/i8042.c	2003-09-28 22:05:48.000000000 +0200
+++ linux/drivers/input/serio/i8042.c	2003-11-15 23:42:43.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/serio.h>
+#include <linux/sysdev.h>
 
 #include <asm/io.h>
 
@@ -398,18 +399,15 @@
  * desired.
  */
 	
-static int __init i8042_controller_init(void)
+static int i8042_controller_init(void)
 {
-
 /*
  * Test the i8042. We need to know if it thinks it's working correctly
  * before doing anything else.
  */
 
 	i8042_flush();
-
 	if (i8042_reset) {
-
 		unsigned char param;
 
 		if (i8042_command(&param, I8042_CMD_CTL_TEST)) {
@@ -783,6 +781,33 @@
 	values->mux = index;
 }
 
+static int i8042_resume_port(struct serio *port)
+{
+	struct serio_dev *dev = port->dev;
+	if (dev) {
+		dev->disconnect(port);
+		dev->connect(port, dev);
+	}	
+}
+
+static int i8042_resume(struct sys_device *dev)
+{
+	if (i8042_controller_init())
+		printk(KERN_ERR "i8042: resume failed\n");
+	i8042_resume_port(&i8042_kbd_port);
+	return 0;
+}
+
+static struct sysdev_class kbc_sysclass = {
+	set_kset_name("i8042"),
+	.resume = i8042_resume,
+};
+
+static struct sys_device device_i8042 = {
+	.id	= 0,
+	.cls	= &kbc_sysclass,
+};
+
 int __init i8042_init(void)
 {
 	int i;
@@ -819,6 +845,14 @@
 
 	register_reboot_notifier(&i8042_notifier);
 
+	{
+		int error = sysdev_class_register(&kbc_sysclass);
+		if (!error)
+			error = sys_device_register(&device_i8042);
+		if (error)
+			printk(KERN_CRIT "Unable to register i8042 to driver model\n");
+	}
+
 	return 0;
 }
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
