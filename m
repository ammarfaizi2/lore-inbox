Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262705AbTKPNFQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 08:05:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTKPNFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 08:05:16 -0500
Received: from gprs145-223.eurotel.cz ([160.218.145.223]:640 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262705AbTKPNFH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 08:05:07 -0500
Date: Sun, 16 Nov 2003 14:05:27 +0100
From: Pavel Machek <pavel@ucw.cz>
To: vojtech@ucw.cz, kernel list <linux-kernel@vger.kernel.org>
Subject: suspend/resume support for i8042
Message-ID: <20031116130527.GA243@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

How does this one look?

I'm not 100% sure it is the correct way, because if I try to handle
mouse the same way, I loose keyboard :-(. Any ideas how to do this
better?
								Pavel


--- tmp/linux/drivers/input/serio/i8042.c	2003-11-16 13:57:24.000000000 +0100
+++ linux/drivers/input/serio/i8042.c	2003-11-15 23:42:43.000000000 +0100
@@ -18,6 +18,7 @@
 #include <linux/reboot.h>
 #include <linux/init.h>
 #include <linux/serio.h>
+#include <linux/sysdev.h>
 
 #include <asm/io.h>
 
@@ -780,6 +781,33 @@
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
@@ -816,6 +845,14 @@
 
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
