Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbTFFQyG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 12:54:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbTFFQyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 12:54:06 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:48802 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262037AbTFFQyD
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Fri, 6 Jun 2003 12:54:03 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16096.51799.485147.930465@laputa.namesys.com>
Date: Fri, 6 Jun 2003 21:07:35 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>
Cc: Oleg Drokin <Green@Namesys.COM>, Jeff Dike <jdike@karaya.com>
Subject: [PATCH]: fix kobject initialization in drivers/char/tty_io.c
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
X-Uboat-Death-Message: ATTACKED BY SMALL GNATS. SINKING. U-898.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

in 2.5.70, UML fails to boot with

Initializing stdio console driver
Badness in kobject_get at lib/kobject.c:351

it seems that problem is that drivers/char/tty_io.c:tty_init() is now
called after arch/um/stdio_console.c:stdio_init(), and when the latter
calls tty_register_driver(), neither tty_kobj, nor tty_cdev are yet
initialized. Below is a work around.

Nikita.
===== drivers/char/tty_io.c 1.105 vs edited =====
--- 1.105/drivers/char/tty_io.c	Fri Jun  6 02:19:36 2003
+++ edited/drivers/char/tty_io.c	Fri Jun  6 20:27:05 2003
@@ -2233,6 +2233,19 @@
 EXPORT_SYMBOL(tty_unregister_device);
 
 static struct kobject tty_kobj = {.name = "tty"};
+static struct cdev tty_cdev, console_cdev;
+static int kobj_bootstraped = 0;
+static void kobj_bootstrap(void)
+{
+	if (!kobj_bootstraped) {
+		kobj_bootstraped = 1;
+		strcpy(tty_cdev.kobj.name, "dev.tty");
+		cdev_init(&tty_cdev, &tty_fops);
+		tty_kobj.kset = tty_cdev.kobj.kset;
+		kobject_register(&tty_kobj);
+	}
+}
+
 /*
  * Called by a tty driver to register itself.
  */
@@ -2261,6 +2274,8 @@
 	if (error < 0)
 		return error;
 
+	kobj_bootstrap();
+
 	driver->cdev.kobj.parent = &tty_kobj;
 	strcpy(driver->cdev.kobj.name, driver->name);
 	for (s = strchr(driver->cdev.kobj.name, '/'); s; s = strchr(s, '/'))
@@ -2372,7 +2387,6 @@
 
 postcore_initcall(tty_class_init);
  
-static struct cdev tty_cdev, console_cdev;
 #ifdef CONFIG_UNIX98_PTYS
 static struct cdev ptmx_cdev;
 #endif
@@ -2386,8 +2400,7 @@
  */
 void __init tty_init(void)
 {
-	strcpy(tty_cdev.kobj.name, "dev.tty");
-	cdev_init(&tty_cdev, &tty_fops);
+	kobj_bootstrap();
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
 		panic("Couldn't register /dev/tty driver\n");
@@ -2401,9 +2414,6 @@
 		panic("Couldn't register /dev/console driver\n");
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
 	tty_add_class_device ("console", MKDEV(TTYAUX_MAJOR, 1), NULL);
-
-	tty_kobj.kset = tty_cdev.kobj.kset;
-	kobject_register(&tty_kobj);
 
 #ifdef CONFIG_UNIX98_PTYS
 	strcpy(ptmx_cdev.kobj.name, "dev.ptmx");

