Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261602AbVAXUgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbVAXUgT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 15:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261640AbVAXUfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 15:35:40 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:45101 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261632AbVAXUZc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 15:25:32 -0500
Date: Mon, 24 Jan 2005 22:26:09 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, chrisw@osdl.org,
       davem@davemloft.net
Subject: [PATCH] move common compat ioctls to hash
Message-ID: <20050124202609.GA15057@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050118072133.GB76018@muc.de> <20050118110432.GE23127@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
The new ioctl code in fs/compat.c can be streamlined a little
using the compat hash instead of an explicit switch statement.

The attached patch is against 2.6.11-rc2-bk2.
Andi, could you please comment? Does this make sence?

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff -rup linux-2.6.10/fs/compat.c linux-2.6.10-rc2-bk2/fs/compat.c
--- linux-2.6.10/fs/compat.c	2005-01-24 21:47:17.252499536 +0200
+++ linux-2.6.10-rc2-bk2/fs/compat.c	2005-01-24 22:06:00.254777240 +0200
@@ -439,37 +439,10 @@ asmlinkage long compat_sys_ioctl(unsigne
 	if (!filp)
 		goto out;
 
-	/*
-	 * To allow the compat_ioctl handlers to be self contained
-	 * we need to check the common ioctls here first.
-	 * Just handle them with the standard handlers below.
-	 */
-	switch (cmd) {
-	case FIOCLEX:
-	case FIONCLEX:
-	case FIONBIO:
-	case FIOASYNC:
-	case FIOQSIZE:
-		break;
-
-	case FIBMAP:
-	case FIGETBSZ:
-	case FIONREAD:
-		if (S_ISREG(filp->f_dentry->d_inode->i_mode))
-			break;
-		/*FALL THROUGH*/
-
-	default:
-		if (filp->f_op && filp->f_op->compat_ioctl) {
-			error = filp->f_op->compat_ioctl(filp, cmd, arg);
-			if (error != -ENOIOCTLCMD)
-				goto out_fput;
-		}
-
-		if (!filp->f_op ||
-		    (!filp->f_op->ioctl && !filp->f_op->unlocked_ioctl))
-			goto do_ioctl;
-		break;
+	if (filp->f_op && filp->f_op->compat_ioctl) {
+		error = filp->f_op->compat_ioctl(filp, cmd, arg);
+		if (error != -ENOIOCTLCMD)
+			goto out_fput;
 	}
 
 	/* When register_ioctl32_conversion is finally gone remove
@@ -509,7 +482,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 	}
 
 	up_read(&ioctl32_sem);
- do_ioctl:
+ 
 	error = sys_ioctl(fd, cmd, arg);
  out_fput:
 	fput_light(filp, fput_needed);
diff -rup linux-2.6.10/fs/ioctl.c linux-2.6.10-rc2-bk2/fs/ioctl.c
--- linux-2.6.10/fs/ioctl.c	2005-01-24 21:47:17.400477040 +0200
+++ linux-2.6.10-rc2-bk2/fs/ioctl.c	2005-01-24 22:05:38.346107864 +0200
@@ -80,7 +80,7 @@ static int file_ioctl(struct file *filp,
 
 /*
  * When you add any new common ioctls to the switches above and below
- * please update compat_sys_ioctl() too.
+ * please update compat_ioctl.h too.
  */
 asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
 {
diff -rup linux-2.6.10/include/linux/compat_ioctl.h linux-2.6.10-rc2-bk2/include/linux/compat_ioctl.h
--- linux-2.6.10/include/linux/compat_ioctl.h	2005-01-24 21:47:21.486855816 +0200
+++ linux-2.6.10-rc2-bk2/include/linux/compat_ioctl.h	2005-01-24 22:06:22.349418344 +0200
@@ -10,6 +10,15 @@
 #define ULONG_IOCTL(cmd)  HANDLE_IOCTL((cmd),(ioctl_trans_handler_t)sys_ioctl)
 #endif
 
+/* Common stuff */
+HANDLE_IOCTL(FIOCLEX)
+HANDLE_IOCTL(FIONCLEX)
+HANDLE_IOCTL(FIONBIO)
+HANDLE_IOCTL(FIOASYNC)
+HANDLE_IOCTL(FIOQSIZE)
+HANDLE_IOCTL(FIBMAP)
+HANDLE_IOCTL(FIGETBSZ)
+HANDLE_IOCTL(FIONREAD)
 /* Big T */
 COMPATIBLE_IOCTL(TCGETA)
 COMPATIBLE_IOCTL(TCSETA)


-- 
I dont speak for Mellanox.
