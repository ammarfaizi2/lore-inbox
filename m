Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTDDFMd (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 00:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263471AbTDDFK5 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 00:10:57 -0500
Received: from out004pub.verizon.net ([206.46.170.142]:34781 "EHLO
	out004.verizon.net") by vger.kernel.org with ESMTP id S263427AbTDDFJm (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 00:09:42 -0500
Date: Thu, 3 Apr 2003 21:18:16 -0800
From: "Randy.Dunlap" <randy.dunlap@verizon.net>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] earlier keyboard init
Message-Id: <20030403211816.202b5ba8.randy.dunlap@verizon.net>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out004.verizon.net from [4.64.238.61] at Thu, 3 Apr 2003 23:21:06 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch (to 2.5.66) enables earlier SysRq during kernel init.
This is done by changing some initcall levels for kbd/serio/input etc.

Please apply, at least to -mm for testing.

Thanks,
-- 
~Randy



diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/char/keyboard.c linux-2566-kbd/drivers/char/keyboard.c
--- linux-2566-pv/drivers/char/keyboard.c	2003-03-24 14:00:19.000000000 -0800
+++ linux-2566-kbd/drivers/char/keyboard.c	2003-03-31 21:44:07.000000000 -0800
@@ -1232,3 +1232,5 @@
 
 	return 0;
 }
+
+arch_initcall(kbd_init);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/char/mem.c linux-2566-kbd/drivers/char/mem.c
--- linux-2566-pv/drivers/char/mem.c	2003-03-24 14:00:39.000000000 -0800
+++ linux-2566-kbd/drivers/char/mem.c	2003-03-30 15:16:03.000000000 -0800
@@ -716,4 +716,4 @@
 	return 0;
 }
 
-__initcall(chr_dev_init);
+arch_initcall(chr_dev_init);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/char/vt.c linux-2566-kbd/drivers/char/vt.c
--- linux-2566-pv/drivers/char/vt.c	2003-03-24 14:01:23.000000000 -0800
+++ linux-2566-kbd/drivers/char/vt.c	2003-03-31 21:43:49.000000000 -0800
@@ -2536,7 +2536,6 @@
 	if (tty_register_driver(&console_driver))
 		panic("Couldn't register console driver\n");
 
-	kbd_init();
 	console_map_init();
 #ifdef CONFIG_PROM_CONSOLE
 	prom_con_init();
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/input/input.c linux-2566-kbd/drivers/input/input.c
--- linux-2566-pv/drivers/input/input.c	2003-03-24 14:00:44.000000000 -0800
+++ linux-2566-kbd/drivers/input/input.c	2003-03-31 21:56:18.000000000 -0800
@@ -717,5 +717,5 @@
 	devclass_unregister(&input_devclass);
 }
 
-module_init(input_init);
+postcore_initcall(input_init);
 module_exit(input_exit);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/input/keyboard/atkbd.c linux-2566-kbd/drivers/input/keyboard/atkbd.c
--- linux-2566-pv/drivers/input/keyboard/atkbd.c	2003-03-24 14:01:16.000000000 -0800
+++ linux-2566-kbd/drivers/input/keyboard/atkbd.c	2003-03-31 21:57:24.000000000 -0800
@@ -597,5 +597,5 @@
 	serio_unregister_device(&atkbd_dev);
 }
 
-module_init(atkbd_init);
+arch_initcall(atkbd_init);
 module_exit(atkbd_exit);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/input/serio/i8042.c linux-2566-kbd/drivers/input/serio/i8042.c
--- linux-2566-pv/drivers/input/serio/i8042.c	2003-03-24 14:00:00.000000000 -0800
+++ linux-2566-kbd/drivers/input/serio/i8042.c	2003-03-31 21:45:18.000000000 -0800
@@ -870,5 +870,5 @@
 	i8042_platform_exit();
 }
 
-module_init(i8042_init);
+arch_initcall(i8042_init);
 module_exit(i8042_exit);
diff -Naur -X /home/rddunlap/doc/dontdiff_osdl linux-2566-pv/drivers/input/serio/serio.c linux-2566-kbd/drivers/input/serio/serio.c
--- linux-2566-pv/drivers/input/serio/serio.c	2003-03-24 13:59:54.000000000 -0800
+++ linux-2566-kbd/drivers/input/serio/serio.c	2003-03-31 21:57:55.000000000 -0800
@@ -216,5 +216,5 @@
 	wait_for_completion(&serio_exited);
 }
 
-module_init(serio_init);
+postcore_initcall(serio_init);
 module_exit(serio_exit);
