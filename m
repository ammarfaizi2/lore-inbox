Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVARHVl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVARHVl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 02:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbVARHVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 02:21:41 -0500
Received: from colin2.muc.de ([193.149.48.15]:50438 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261155AbVARHVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 02:21:35 -0500
Date: 18 Jan 2005 08:21:33 +0100
Date: Tue, 18 Jan 2005 08:21:33 +0100
From: Andi Kleen <ak@muc.de>
To: akpm@osdl.org, mst@mellanox.co.il, hch@infradead.org,
       linux-kernel@vger.kernel.org
Cc: chrisw@osdl.org, davem@davemloft.net
Subject: [PATCH] Some fixes for compat ioctl
Message-ID: <20050118072133.GB76018@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While doing some compat_ioctl conversions I noticed a few issues
in compat_sys_ioctl:

- It is not completely compatible to old ->ioctl because 
the traditional common ioctls are not checked before it. I added
a check for those. The main advantage is that the handler 
now works the same as a traditional handler even when it returns
-EINVAL
- The private socket ioctl check should only apply for sockets.
- There was a security hook missing.  Drawback is that it uses
the same hook now, and the LSM module cannot distingush between
32bit and 64bit clients. But it'll have to live with that for now.

Signed-off-by: Andi Kleen <ak@muc.de>

diff -u linux-2.6.11-rc1-bk4/fs/ioctl.c-o linux-2.6.11-rc1-bk4/fs/ioctl.c
--- linux-2.6.11-rc1-bk4/fs/ioctl.c-o	2005-01-17 10:39:40.000000000 +0100
+++ linux-2.6.11-rc1-bk4/fs/ioctl.c	2005-01-17 21:57:09.000000000 +0100
@@ -78,6 +78,10 @@
 }
 
 
+/* 
+ * When you add any new common ioctls to the switches above and below
+ * please update compat_sys_ioctl() too.
+ */ 
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
 	struct file * filp;
diff -u linux-2.6.11-rc1-bk4/fs/compat.c-o linux-2.6.11-rc1-bk4/fs/compat.c
--- linux-2.6.11-rc1-bk4/fs/compat.c-o	2005-01-17 10:39:40.000000000 +0100
+++ linux-2.6.11-rc1-bk4/fs/compat.c	2005-01-18 08:04:11.000000000 +0100
@@ -25,6 +25,7 @@
 #include <linux/file.h>
 #include <linux/vfs.h>
 #include <linux/ioctl32.h>
+#include <linux/ioctl.h>
 #include <linux/init.h>
 #include <linux/sockios.h>	/* for SIOCDEVPRIVATE */
 #include <linux/smb.h>
@@ -47,6 +48,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
+#include <asm/ioctls.h>
 
 /*
  * Not all architectures have sys_utime, so implement this in terms
@@ -437,16 +439,41 @@
 	if (!filp)
 		goto out;
 
-	if (filp->f_op && filp->f_op->compat_ioctl) {
-		error = filp->f_op->compat_ioctl(filp, cmd, arg);
-		if (error != -ENOIOCTLCMD)
-			goto out_fput;
-	}
-
-	if (!filp->f_op ||
-	    (!filp->f_op->ioctl && !filp->f_op->unlocked_ioctl))
-		goto do_ioctl;
+	/* 
+	 * To allow the compat_ioctl handlers to be self contained
+	 * we need to check the common ioctls here first.
+	 * Just handle them with the standard handlers below.
+	 */ 
+	switch (cmd) { 
+	case FIOCLEX:
+	case FIONCLEX:
+	case FIONBIO:
+	case FIOASYNC:
+	case FIOQSIZE:
+		break; 
+
+	case FIBMAP:
+	case FIGETBSZ:
+	case FIONREAD:
+		if (S_ISREG(filp->f_dentry->d_inode->i_mode))
+			break;
+		/*FALL THROUGH*/
 
+	default:
+		if (filp->f_op && filp->f_op->compat_ioctl) {
+			error = filp->f_op->compat_ioctl(filp, cmd, arg);
+			if (error != -ENOIOCTLCMD)
+				goto out_fput;
+		}
+		
+		if (!filp->f_op ||
+		    (!filp->f_op->ioctl && !filp->f_op->unlocked_ioctl))
+			goto do_ioctl;
+		break;
+	}
+		   	
+	/* When register_ioctl32_conversion is finally gone remove
+	   this lock! -AK */
 	down_read(&ioctl32_sem);
 	for (t = ioctl32_hash_table[ioctl32_hash(cmd)]; t; t = t->next) {
 		if (t->cmd == cmd)
@@ -454,7 +481,8 @@
 	}
 	up_read(&ioctl32_sem);
 
-	if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
+	if (S_ISSOCK(filp->f_dentry->d_inode->i_mode) &&
+	    cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
 		error = siocdevprivate_ioctl(fd, cmd, arg);
 	} else {
 		static int count;
@@ -468,6 +496,11 @@
 
  found_handler:
 	if (t->handler) {
+		/* RED-PEN how should LSM module know it's handling 32bit? */
+		error = security_file_ioctl(filp, cmd, arg);
+		if (error)
+			goto out_fput;
+
 		lock_kernel();
 		error = t->handler(fd, cmd, arg, filp);
 		unlock_kernel();
