Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbUCBWHP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 17:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUCBWG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 17:06:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:11213 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261946AbUCBWGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 17:06:34 -0500
Date: Tue, 2 Mar 2004 14:08:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: cloos@jhcloos.com, linux-kernel@vger.kernel.org
Subject: Re: something funny about tty's on 2.6.4-rc1-mm1
Message-Id: <20040302140809.6b0ef6f8.akpm@osdl.org>
In-Reply-To: <4044BC48.7060903@zytor.com>
References: <20040301184512.GA21285@hobbes.itsari.int>
	<c2175f$6hn$1@terminus.zytor.com>
	<m3u1175miy.fsf@lugabout.jhcloos.org>
	<4044BC48.7060903@zytor.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> wrote:
>
> > Will patching in the old behavior wrt re-use, while not disrupting
> > the other improvements, be a lot of work?  I've looked thru the src, 
> > but haven't yet spotted the point where the new pis number is chosen.
> 
> Not a lot of work, but the performance would suffer big time.

The (untested) first-fit patch I proposed uses a radix tree, so it should
in fact be faster than the old code.

Are you now thinking that we might need to change the pty allocator?



 drivers/char/tty_io.c |   50 ++++++++++++++++++++++++++++++++++++++++----------
 1 files changed, 40 insertions(+), 10 deletions(-)

diff -puN drivers/char/tty_io.c~pty-allocation-first-fit drivers/char/tty_io.c
--- 25/drivers/char/tty_io.c~pty-allocation-first-fit	2004-02-26 18:59:21.000000000 -0800
+++ 25-akpm/drivers/char/tty_io.c	2004-02-26 18:59:58.000000000 -0800
@@ -91,6 +91,7 @@
 #include <linux/module.h>
 #include <linux/smp_lock.h>
 #include <linux/device.h>
+#include <linux/idr.h>
 
 #include <asm/uaccess.h>
 #include <asm/system.h>
@@ -125,6 +126,8 @@ struct tty_ldisc ldiscs[NR_LDISCS];	/* l
 #ifdef CONFIG_UNIX98_PTYS
 extern struct tty_driver *ptm_driver;	/* Unix98 pty masters; for /dev/ptmx */
 extern int pty_limit;		/* Config limit on Unix98 ptys */
+static struct idr allocated_ptys;
+static DECLARE_MUTEX(allocated_ptys_lock);
 #endif
 
 extern void disable_early_printk(void);
@@ -1305,6 +1308,14 @@ static void release_dev(struct file * fi
 	 */
 	flush_scheduled_work();
 
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
@@ -1329,7 +1340,7 @@ static int tty_open(struct inode * inode
 	struct tty_struct *tty;
 	int noctty, retval;
 	struct tty_driver *driver;
-	int index;
+	int index = -1;
 	dev_t device = inode->i_rdev;
 	unsigned short saved_flags = filp->f_flags;
 retry_open:
@@ -1372,22 +1383,32 @@ retry_open:
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
+		index = idr_get_new(&allocated_ptys, NULL);
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
@@ -1425,6 +1446,14 @@ got_driver:
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
@@ -2435,6 +2464,7 @@ static int __init tty_init(void)
 	kobject_register(&tty_kobj);
 
 #ifdef CONFIG_UNIX98_PTYS
+	idr_init(&allocated_ptys);
 	strcpy(ptmx_cdev.kobj.name, "dev.ptmx");
 	cdev_init(&ptmx_cdev, &tty_fops);
 	if (cdev_add(&ptmx_cdev, MKDEV(TTYAUX_MAJOR, 2), 1) ||

_

