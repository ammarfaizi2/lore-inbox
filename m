Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbUK3CM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbUK3CM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbUK3CLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:11:46 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:42456 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261941AbUK3CKe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:10:34 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org,
       Ian.Pratt@cl.cam.ac.uk
Subject: [3/7] Xen VMM #3: runtime disable of VT console
In-reply-to: Your message of "Tue, 30 Nov 2004 02:03:45 GMT."
             <E1CYxMo-0005GB-00@mta1.cl.cam.ac.uk> 
Date: Tue, 30 Nov 2004 02:10:33 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CYxTN-0005Kb-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch enables the VT console to be disabled at runtime even if it
is built into the kernel. Arch xen needs this to avoid trying to
initialise a VT in virtual machine that doesn't have access to the
console hardware.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---


diff -Nurp pristine-linux-2.6.10-rc2/drivers/char/tty_io.c tmp-linux-2.6.10-rc2-xen.patch/drivers/char/tty_io.c
--- pristine-linux-2.6.10-rc2/drivers/char/tty_io.c	2004-11-30 01:19:44.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/drivers/char/tty_io.c	2004-11-30 00:41:24.000000000 +0000
@@ -131,6 +131,8 @@ LIST_HEAD(tty_drivers);			/* linked list
    vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
 
+int console_use_vt = 1;
+
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
@@ -2964,14 +2966,19 @@ static int __init tty_init(void)
 #endif
 
 #ifdef CONFIG_VT
-	cdev_init(&vc0_cdev, &console_fops);
-	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
-	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
-		panic("Couldn't register /dev/tty0 driver\n");
-	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
-	class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
+	if (console_use_vt) {
+		cdev_init(&vc0_cdev, &console_fops);
+		if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
+		    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1,
+					   "/dev/vc/0") < 0)
+			panic("Couldn't register /dev/tty0 driver\n");
+		devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR,
+			      "vc/0");
+		class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL,
+					"tty0");
 
-	vty_init();
+		vty_init();
+	}
 #endif
 	return 0;
 }

