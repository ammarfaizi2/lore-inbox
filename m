Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269038AbUIHOdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269038AbUIHOdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269032AbUIHObn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 10:31:43 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:35031 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S268382AbUIHO2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 10:28:03 -0400
Date: Wed, 8 Sep 2004 17:28:08 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [patch]   Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel
Message-ID: <20040908142808.GA11795@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040907134517.GA1016@mellanox.co.il> <20040907141524.GA13862@wotan.suse.de> <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de> <20040907181641.GB2154@mellanox.co.il> <20040908065548.GE27886@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908065548.GE27886@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> > Wait, I think that a properly coded ioctl can always
> > figure out this is a compat call by looking at the command
> > (see example below).
> > So maybe we can live with just one new entry point with these
> > semantics?
> 
> I think two is cleaner. And needing 8 bytes more for a file_operations
> structure is not exactly a catastrophe.
> 
> -Andi

OK.
Here (below) is an attempt at a patch.
There are two new entrypoints in file operations (for native and compat ioctls)
both called without BKL being taken at any point.


Since with this approach I cant call sys_ioctl directly from compat_sys_ioctl,
I had to split the common code into a routine std_sys_ioctl.
This handles ioctls which are common for all files, 
(mostly without BKL, too - which made it possible to remove compat
macros for these commands ) - and returns status indicating whether ioctl was
handled.

I declared it in linux/ioctl.h, let me know if that's a good place for her.

Boots fine, now to update the driver and check how this works.
I'll follow up, test some more and benchmark this, hopefully tomorrow.

Pls let me know what do you think.

MST

diff -ruwp linux-2.6.8.1/include/linux/fs.h linux-2.6.8.1-new/include/linux/fs.h
--- linux-2.6.8.1/include/linux/fs.h	2004-09-07 19:33:43.000000000 +0300
+++ linux-2.6.8.1-new/include/linux/fs.h	2004-09-08 07:18:20.000000000 +0300
@@ -879,6 +879,8 @@ struct file_operations {
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
+	int (*ioctl_native) (struct inode *, struct file *, unsigned int, unsigned long);
+	int (*ioctl_compat) (struct inode *, struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
diff -ruwp linux-2.6.8.1/include/linux/ioctl.h linux-2.6.8.1-new/include/linux/ioctl.h
--- linux-2.6.8.1/include/linux/ioctl.h	2004-08-14 13:54:50.000000000 +0300
+++ linux-2.6.8.1-new/include/linux/ioctl.h	2004-09-08 07:40:19.000000000 +0300
@@ -3,5 +3,11 @@
 
 #include <asm/ioctl.h>
 
+/* Handles standard ioctl calls */
+struct file;
+int std_sys_ioctl(
+  unsigned int fd, unsigned int cmd, unsigned long arg,
+  struct file * filp, int* error);
+
 #endif /* _LINUX_IOCTL_H */
diff -ruwp linux-2.6.8.1/fs/ioctl.c linux-2.6.8.1-new/fs/ioctl.c
--- linux-2.6.8.1/fs/ioctl.c	2004-09-07 19:30:28.000000000 +0300
+++ linux-2.6.8.1-new/fs/ioctl.c	2004-09-08 07:38:03.000000000 +0300
@@ -35,7 +35,9 @@ static int file_ioctl(struct file *filp,
 			if ((error = get_user(block, p)) != 0)
 				return error;
 
+			lock_kernel();
 			res = mapping->a_ops->bmap(mapping, block);
+			unlock_kernel();
 			return put_user(res, p);
 		}
 		case FIGETBSZ:
@@ -45,29 +47,21 @@ static int file_ioctl(struct file *filp,
 		case FIONREAD:
 			return put_user(i_size_read(inode) - filp->f_pos, p);
 	}
-	if (filp->f_op && filp->f_op->ioctl)
-		return filp->f_op->ioctl(inode, filp, cmd, arg);
 	return -ENOTTY;
 }
 
 
-asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+EXPORT_SYMBOL(std_sys_ioctl);
+int std_sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg,
+  struct file * filp, long* status)
 {	
-	struct file * filp;
+	int on,error;
 	unsigned int flag;
-	int on, error = -EBADF;
-
-	filp = fget(fd);
-	if (!filp)
-		goto out;
-
 	error = security_file_ioctl(filp, cmd, arg);
 	if (error) {
-                fput(filp);
-                goto out;
+		*status=error;
+		return 0;
         }
-
-	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
 			set_close_on_exec(fd, 1);
@@ -99,8 +93,11 @@ asmlinkage long sys_ioctl(unsigned int f
 
 			/* Did FASYNC state change ? */
 			if ((flag ^ filp->f_flags) & FASYNC) {
-				if (filp->f_op && filp->f_op->fasync)
+				if (filp->f_op && filp->f_op->fasync) {
+					lock_kernel();
 					error = filp->f_op->fasync(fd, filp, on);
+					unlock_kernel();
+				}
 				else error = -ENOTTY;
 			}
 			if (error != 0)
@@ -124,13 +121,44 @@ asmlinkage long sys_ioctl(unsigned int f
 			break;
 		default:
 			error = -ENOTTY;
-			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
+			if (S_ISREG(filp->f_dentry->d_inode->i_mode)) {
 				error = file_ioctl(filp, cmd, arg);
-			else if (filp->f_op && filp->f_op->ioctl)
-				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
 	}
+			if (error == -ENOTTY) return 1;
+	}
+	*status=error;
+	return 0;
+}
+
+
+
+asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{	
+	struct file * filp;
+	int error = -EBADF;
+	int fput_needed;
+
+	filp = fget_light(fd,&fput_needed);
+	if (!filp)
+		goto out;
+
+	if (!std_sys_ioctl(fd,cmd,arg,filp,&error)) {
+		goto out;
+	}
+
+	if (filp->f_op && filp->f_op->ioctl_native)
+		error = filp->f_op->ioctl_native(
+				filp->f_dentry->d_inode,
+				filp, cmd, arg);
+	else if (filp->f_op && filp->f_op->ioctl) {
+		lock_kernel();
+		error = filp->f_op->ioctl(
+				filp->f_dentry->d_inode,
+				filp, cmd, arg);
 	unlock_kernel();
-	fput(filp);
+	}
+
+	fput_light(filp,fput_needed);
 
 out:
 	return error;
diff -ruwp linux-2.6.8.1/fs/compat.c linux-2.6.8.1-new/fs/compat.c
--- linux-2.6.8.1/fs/compat.c	2004-08-14 13:55:31.000000000 +0300
+++ linux-2.6.8.1-new/fs/compat.c	2004-09-08 07:33:51.000000000 +0300
@@ -387,13 +387,17 @@ asmlinkage long compat_sys_ioctl(unsigne
 	struct file * filp;
 	int error = -EBADF;
 	struct ioctl_trans *t;
+	int fput_needed;
 
-	filp = fget(fd);
+	filp = fget_light(fd, &fput_needed);
 	if(!filp)
 		goto out2;
 
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
+	if (!std_sys_ioctl(fd,cmd,arg,filp,&error))
+		goto out;
+	else if (filp->f_op && filp->f_op->ioctl_compat) {
+		error = filp->f_op->ioctl_compat( filp->f_dentry->d_inode,
+				filp, cmd, arg);
 		goto out;
 	}
 
@@ -406,11 +410,12 @@ asmlinkage long compat_sys_ioctl(unsigne
 	if (t) {
 		if (t->handler) { 
 			error = t->handler(fd, cmd, arg, filp);
-			unlock_kernel();
-		} else {
-			unlock_kernel();
-			error = sys_ioctl(fd, cmd, arg);
+		} else if (filp->f_op && filp->f_op->ioctl) {
+			error = filp->f_op->ioctl(
+					filp->f_dentry->d_inode,
+					filp, cmd, arg);
 		}
+		unlock_kernel();
 	} else {
 		unlock_kernel();
 		if (cmd >= SIOCDEVPRIVATE && cmd <= (SIOCDEVPRIVATE + 15)) {
@@ -446,7 +451,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 		}
 	}
 out:
-	fput(filp);
+	fput_light(filp, fput_needed);
 out2:
 	return error;
 }
diff -ruwp linux-2.6.8.1/include/linux/compat_ioctl.h linux-2.6.8.1-new/include/linux/compat_ioctl.h
--- linux-2.6.8.1/include/linux/compat_ioctl.h	2004-08-14 13:56:23.000000000 +0300
+++ linux-2.6.8.1-new/include/linux/compat_ioctl.h	2004-09-07 20:19:24.000000000 +0300
@@ -54,15 +54,6 @@ COMPATIBLE_IOCTL(FBIOPUT_VSCREENINFO)
 COMPATIBLE_IOCTL(FBIOPAN_DISPLAY)
 COMPATIBLE_IOCTL(FBIOGET_CON2FBMAP)
 COMPATIBLE_IOCTL(FBIOPUT_CON2FBMAP)
-/* Little f */
-COMPATIBLE_IOCTL(FIOCLEX)
-COMPATIBLE_IOCTL(FIONCLEX)
-COMPATIBLE_IOCTL(FIOASYNC)
-COMPATIBLE_IOCTL(FIONBIO)
-COMPATIBLE_IOCTL(FIONREAD)  /* This is also TIOCINQ */
-/* 0x00 */
-COMPATIBLE_IOCTL(FIBMAP)
-COMPATIBLE_IOCTL(FIGETBSZ)
 /* 0x03 -- HD/IDE ioctl's used by hdparm and friends.
  *         Some need translations, these do not.
  */
diff -ruwp linux-2.6.8.1/arch/x86_64/ia32/ia32_ioctl.c linux-2.6.8.1-new/arch/x86_64/ia32/ia32_ioctl.c
--- linux-2.6.8.1/arch/x86_64/ia32/ia32_ioctl.c	2004-08-14 13:55:32.000000000 +0300
+++ linux-2.6.8.1-new/arch/x86_64/ia32/ia32_ioctl.c	2004-09-07 20:19:05.000000000 +0300
@@ -188,7 +188,6 @@ COMPATIBLE_IOCTL(RTC_RD_TIME)
 COMPATIBLE_IOCTL(RTC_SET_TIME)
 COMPATIBLE_IOCTL(RTC_WKALM_SET)
 COMPATIBLE_IOCTL(RTC_WKALM_RD)
-COMPATIBLE_IOCTL(FIOQSIZE)
 
 /* And these ioctls need translation */
 HANDLE_IOCTL(TIOCGDEV, tiocgdev)
