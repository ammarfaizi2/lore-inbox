Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUEQQPc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUEQQPc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 12:15:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbUEQQPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 12:15:32 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:60650 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S261802AbUEQQOx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 12:14:53 -0400
Subject: [PATCH] revert behaviour of pty allocation in 2.6
From: Andrew Clayton <andrew@digital-domain.net>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="=-xJN3sQaGI7+hf+Jt9bfR"
Message-Id: <1084810491.2155.24.camel@alpha.digital-domain.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 May 2004 17:14:51 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xJN3sQaGI7+hf+Jt9bfR
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello,

Here is a patch which is mainly 

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm5/broken-out/pty-allocation-first-fit.patch

with a couple of changes.

That patch didn't quite work....


It changes back to the old behaviour of re-allocating used pty's 
rather then just allocating them sequentially.


This is my first kernel patch, but it seems to work and do 
the right thing ;)


It is against 2.6.6-bk3 

(I've also attached it, if this gets mangled inline)


Please CC me in any replies.

Cheers,

Andrew Clayton



tty_io.c |   51 +++++++++++++++++++++++++++++++++++++++++----------
1 files changed, 41 insertions(+), 10 deletions(-)


diff -up a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	2004-05-17 15:24:07.829691814 +0100
+++ b/drivers/char/tty_io.c	2004-05-17 15:25:25.659976275 +0100
@@ -91,6 +91,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -128,6 +129,8 @@ DECLARE_MUTEX(tty_sem);
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
+static DEFINE_IDR(allocated_ptys);
+static DECLARE_MUTEX(allocated_ptys_lock);
 #endif
 
 extern void disable_early_printk(void);
@@ -1295,6 +1298,14 @@ static void release_dev(struct file * fi
 		o_tty->ldisc = ldiscs[N_TTY];
 	}
 
+#ifdef CONFIG_UNIX98_PTYS
+	if (filp->f_dentry->d_inode->i_rdev == MKDEV(TTYAUX_MAJOR,2)) {
+		down(&allocated_ptys_lock);
+		idr_remove(&allocated_ptys, idx);
+		up(&allocated_ptys_lock);
+	}
+#endif
+
 	/* 
 	 * The release_mem function takes care of the details of clearing
 	 * the slots and preserving the termios structure.
@@ -1319,7 +1330,7 @@ static int tty_open(struct inode * inode
 	struct tty_struct *tty;
 	int noctty, retval;
 	struct tty_driver *driver;
-	int index;
+	int res, index = -1;
 	dev_t device = inode->i_rdev;
 	unsigned short saved_flags = filp->f_flags;
 retry_open:
@@ -1362,22 +1373,33 @@ retry_open:
 #ifdef CONFIG_UNIX98_PTYS
 	if (device == MKDEV(TTYAUX_MAJOR,2)) {
 		/* find a device that is not in use. */
-		static int next_ptmx_dev = 0;
-		retval = -1;
+		down(&allocated_ptys_lock);
+		if (!idr_pre_get(&allocated_ptys, GFP_KERNEL)) {
+			up(&allocated_ptys_lock);
+			return -ENOMEM;
+		}
+		res = idr_get_new(&allocated_ptys, NULL);
+		index = res & MAX_ID_MASK;
+		if (index >= pty_limit) {
+			idr_remove(&allocated_ptys, index);
+			up(&allocated_ptys_lock);
+			return -EIO;
+		}
 		driver = ptm_driver;
-		while (driver->refcount < pty_limit) {
-			index = next_ptmx_dev;
-			next_ptmx_dev = (next_ptmx_dev+1) % driver->num;
-			if (!init_dev(driver, index, &tty))
-				goto ptmx_found; /* ok! */
+		retval = init_dev(driver, index, &tty);
+		if (retval) {
+			idr_remove(&allocated_ptys, index);
+			up(&allocated_ptys_lock);
+			return retval;
 		}
-		return -EIO; /* no free ptys */
-	ptmx_found:
 		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
 		if (devpts_pty_new(tty->link)) {
 			/* BADNESS - need to destroy both ptm and pts! */
+			idr_remove(&allocated_ptys, index);
+			up(&allocated_ptys_lock);
 			return -ENOMEM;
 		}
+		up(&allocated_ptys_lock);
 		noctty = 1;
 	} else
 #endif
@@ -1415,6 +1437,14 @@ got_driver:
 		       tty->name);
 #endif
 
+#ifdef CONFIG_UNIX98_PTYS
+		if (index != -1) {
+			down(&allocated_ptys_lock);
+			idr_remove(&allocated_ptys, index);
+			up(&allocated_ptys_lock);
+		}
+#endif
+
 		release_dev(filp);
 		if (retval != -ERESTARTSYS)
 			return retval;
@@ -2400,6 +2430,7 @@ static struct cdev vc0_cdev;
  */
 static int __init tty_init(void)
 {
+	idr_init(&allocated_ptys);
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)


--=-xJN3sQaGI7+hf+Jt9bfR
Content-Disposition: attachment; filename=pty-allocation-fix.patch
Content-Type: text/x-patch; name=pty-allocation-fix.patch; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

--- a/drivers/char/tty_io.c	2004-05-17 15:24:07.829691814 +0100
+++ b/drivers/char/tty_io.c	2004-05-17 15:25:25.659976275 +0100
@@ -91,6 +91,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -128,6 +129,8 @@ DECLARE_MUTEX(tty_sem);
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
+static DEFINE_IDR(allocated_ptys);
+static DECLARE_MUTEX(allocated_ptys_lock);
 #endif
 
 extern void disable_early_printk(void);
@@ -1295,6 +1298,14 @@ static void release_dev(struct file * fi
 		o_tty->ldisc = ldiscs[N_TTY];
 	}
 
+#ifdef CONFIG_UNIX98_PTYS
+	if (filp->f_dentry->d_inode->i_rdev == MKDEV(TTYAUX_MAJOR,2)) {
+		down(&allocated_ptys_lock);
+		idr_remove(&allocated_ptys, idx);
+		up(&allocated_ptys_lock);
+	}
+#endif
+
 	/* 
 	 * The release_mem function takes care of the details of clearing
 	 * the slots and preserving the termios structure.
@@ -1319,7 +1330,7 @@ static int tty_open(struct inode * inode
 	struct tty_struct *tty;
 	int noctty, retval;
 	struct tty_driver *driver;
-	int index;
+	int res, index = -1;
 	dev_t device = inode->i_rdev;
 	unsigned short saved_flags = filp->f_flags;
 retry_open:
@@ -1362,22 +1373,33 @@ retry_open:
 #ifdef CONFIG_UNIX98_PTYS
 	if (device == MKDEV(TTYAUX_MAJOR,2)) {
 		/* find a device that is not in use. */
-		static int next_ptmx_dev = 0;
-		retval = -1;
+		down(&allocated_ptys_lock);
+		if (!idr_pre_get(&allocated_ptys, GFP_KERNEL)) {
+			up(&allocated_ptys_lock);
+			return -ENOMEM;
+		}
+		res = idr_get_new(&allocated_ptys, NULL);
+		index = res & MAX_ID_MASK;
+		if (index >= pty_limit) {
+			idr_remove(&allocated_ptys, index);
+			up(&allocated_ptys_lock);
+			return -EIO;
+		}
 		driver = ptm_driver;
-		while (driver->refcount < pty_limit) {
-			index = next_ptmx_dev;
-			next_ptmx_dev = (next_ptmx_dev+1) % driver->num;
-			if (!init_dev(driver, index, &tty))
-				goto ptmx_found; /* ok! */
+		retval = init_dev(driver, index, &tty);
+		if (retval) {
+			idr_remove(&allocated_ptys, index);
+			up(&allocated_ptys_lock);
+			return retval;
 		}
-		return -EIO; /* no free ptys */
-	ptmx_found:
 		set_bit(TTY_PTY_LOCK, &tty->flags); /* LOCK THE SLAVE */
 		if (devpts_pty_new(tty->link)) {
 			/* BADNESS - need to destroy both ptm and pts! */
+			idr_remove(&allocated_ptys, index);
+			up(&allocated_ptys_lock);
 			return -ENOMEM;
 		}
+		up(&allocated_ptys_lock);
 		noctty = 1;
 	} else
 #endif
@@ -1415,6 +1437,14 @@ got_driver:
 		       tty->name);
 #endif
 
+#ifdef CONFIG_UNIX98_PTYS
+		if (index != -1) {
+			down(&allocated_ptys_lock);
+			idr_remove(&allocated_ptys, index);
+			up(&allocated_ptys_lock);
+		}
+#endif
+
 		release_dev(filp);
 		if (retval != -ERESTARTSYS)
 			return retval;
@@ -2400,6 +2430,7 @@ static struct cdev vc0_cdev;
  */
 static int __init tty_init(void)
 {
+	idr_init(&allocated_ptys);
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)

--=-xJN3sQaGI7+hf+Jt9bfR--

