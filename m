Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbUKQX5k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbUKQX5k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 18:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262581AbUKQX4T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 18:56:19 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:30372 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S262536AbUKQXvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 18:51:16 -0500
To: linux-kernel@vger.kernel.org
cc: Ian.Pratt@cl.cam.ac.uk, akpm@osdl.org, Keir.Fraser@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, alan@redhat.com
Subject: [patch 3] Xen core patch : runtime VT console disable
Date: Wed, 17 Nov 2004 23:51:14 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CUZZz-00055l-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch enables the VT console to be disabled at runtime even if it
is built into the kernel. arch-xen needs this to avoid trying to
initialise a VT in virtual machine that doesn't have access to the
console hardware.

Signed-off-by: ian.pratt@cl.cam.ac.uk

---

diff -Nurp pristine-linux-2.6.9/drivers/char/tty_io.c linux-2.6.9-xen-sparse/drivers/char/tty_io.c       
--- pristine-linux-2.6.9/drivers/char/tty_io.c  2004-10-18 22:54:32.000000000 +0100
+++ linux-2.6.9-xen-sparse/drivers/char/tty_io.c        2004-11-17 01:51:48.000000000 +0000
@@ -131,6 +131,8 @@ LIST_HEAD(tty_drivers);                     /* linked list
    vt.c for deeply disgusting hack reasons */
 DECLARE_MUTEX(tty_sem);
 
+int console_use_vt = 1;
+
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;  /* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;          /* Config limit on Unix98 ptys */
@@ -1739,7 +1741,7 @@ retry_open:
                goto got_driver;
        }
 #ifdef CONFIG_VT
-       if (device == MKDEV(TTY_MAJOR,0)) {
+       if (console_use_vt && device == MKDEV(TTY_MAJOR,0)) {
                extern int fg_console;
                extern struct tty_driver *console_driver;
                driver = console_driver;
@@ -1959,7 +1961,7 @@ static int tiocswinsz(struct tty_struct 
        if (!memcmp(&tmp_ws, &tty->winsize, sizeof(*arg)))
                return 0;
 #ifdef CONFIG_VT
-       if (tty->driver->type == TTY_DRIVER_TYPE_CONSOLE) {
+       if (console_use_vt && tty->driver->type == TTY_DRIVER_TYPE_CONSOLE) {
                unsigned int currcons = tty->index;
                int rc;
 
@@ -2933,14 +2935,19 @@ static int __init tty_init(void)
 #endif
 
 #ifdef CONFIG_VT
-       cdev_init(&vc0_cdev, &console_fops);
-       if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
-           register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
-               panic("Couldn't register /dev/tty0 driver\n");
-       devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
-       class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
+       if (console_use_vt) {
+               cdev_init(&vc0_cdev, &console_fops);
+               if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
+                   register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1,
+                                          "/dev/vc/0") < 0)
+                       panic("Couldn't register /dev/tty0 driver\n");
+               devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR,
+                             "vc/0");
+               class_simple_device_add(tty_class, MKDEV(TTY_MAJOR, 0), NULL,
+                                       "tty0");
 
-       vty_init();
+               vty_init();
+       }
 #endif
        return 0;
 }

