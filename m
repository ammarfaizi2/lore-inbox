Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266257AbUIONfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266257AbUIONfB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 09:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUIONdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 09:33:06 -0400
Received: from mail.mellanox.co.il ([194.90.237.34]:48688 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S266233AbUIONaI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 09:30:08 -0400
Date: Wed, 15 Sep 2004 16:19:55 +0300
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: [patch] Re: [discuss] speed up compatible ioctls in linux kernel
Message-ID: <20040915131955.GA9274@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20040907142530.GB1016@mellanox.co.il> <20040907142945.GB20981@wotan.suse.de> <20040907143702.GC1016@mellanox.co.il> <20040907144452.GC20981@wotan.suse.de> <20040907144543.GA1340@mellanox.co.il> <20040907151022.GA32287@wotan.suse.de> <20040907181641.GB2154@mellanox.co.il> <20040908065548.GE27886@wotan.suse.de> <20040908142808.GA11795@mellanox.co.il> <20040908143852.GA27411@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040908143852.GA27411@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: [patch]   Re: [discuss] f_ops flag to speed up compatible ioctls in linux kernel":
> On Wed, Sep 08, 2004 at 05:28:08PM +0300, Michael S. Tsirkin wrote:
> > --- linux-2.6.8.1/include/linux/fs.h	2004-09-07 19:33:43.000000000 +0300
> > +++ linux-2.6.8.1-new/include/linux/fs.h	2004-09-08 07:18:20.000000000 +0300
> > @@ -879,6 +879,8 @@ struct file_operations {
> >  	int (*readdir) (struct file *, void *, filldir_t);
> >  	unsigned int (*poll) (struct file *, struct poll_table_struct *);
> >  	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
> > +	int (*ioctl_native) (struct inode *, struct file *, unsigned int, unsigned long);
> > +	int (*ioctl_compat) (struct inode *, struct file *, unsigned int, unsigned long);
> 
> Define these as long, not int.  No need to waste 32 perfectly good bits on 
> 64bit platforms.
> 
> The main thing missing is documentation. You need clear comments what
> the locking rules are and what compat is good for.
> 
> And you should change the code style to follow Documentation/CodingStyle
> 
> Other than that it looks ok to me.
> 
> -Andi

OK, here (below) is an updated version. I added a bit of documentation
and fixed two coding style issues that I found, if there are more issues
please let me know.

There are two new calls done without taking the BKL at any point -
for native and compat ioctls. A separate call for compat ioctl
makes it possible to avoid the (IMO ugly) hash lookup altogether.

I made the calls return long although this means a driver can not just
reuse hos old "ioctl" function - the return type has to be changed.
Otherwise ioctl_native/ioctl_compat are a drop-in replacement.


Toy benchmark:   ioctl does a switch and takes a semaphore (note
dual processor results may be more drastic of there is no semaphore to
serialise on).

single process test:

before:
time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.592u 8.313s 0:08.91 99.8%     0+0k 0+0io 0pf+0w
time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.669u 5.684s 0:06.36 99.6%     0+0k 0+0io 0pf+0w

after:
time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.749u 5.133s 0:05.91 99.3%     0+0k 0+0io 1pf+0w
time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.583u 5.424s 0:06.01 99.8%     0+0k 0+0io 0pf+0w

System time reduced by 20% for 32 bit test.

Dual process (on dual CPU):

before:

time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0 & ; time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0 &
wait
[2]  + Done                          /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.777u 28.376s 0:29.15 99.9%    0+0k 0+0io 0pf+0w
[1]  + Done                          /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
1.113u 28.179s 0:29.32 99.8%    0+0k 0+0io 0pf+0w


time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0 & ; time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0 &
wait
[2]  + Done                          /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.551u 12.367s 0:12.92 99.9%    0+0k 0+0io 0pf+0w
[1]  + Done                          /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.554u 12.447s 0:13.01 99.8%    0+0k 0+0io 0pf+0w

after:

time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.749u 5.133s 0:05.91 99.3%     0+0k 0+0io 1pf+0w
time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.583u 5.424s 0:06.01 99.8%     0+0k 0+0io 0pf+0w
time /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0 & ; time /tmp/ioctltest32
/dev/mst/mt23108_pci_cr0 &
wait
[2]  + Done                          /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.626u 9.947s 0:10.60 99.6%     0+0k 0+0io 0pf+0w
[1]  + Done                          /tmp/ioctltest32 /dev/mst/mt23108_pci_cr0
0.660u 10.039s 0:10.70 99.9%    0+0k 0+0io 0pf+0w


time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0 & ; time /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0 &
wait
[2]  + Done                          /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.473u 9.857s 0:10.37 99.5%     0+0k 0+0io 0pf+0w
[1]  + Done                          /tmp/ioctltest64 /dev/mst/mt23108_pci_cr0
0.632u 9.813s 0:10.44 100.0%    0+0k 0+0io 0pf+0w

Almost 50% improvement for 32 bit code.

MST



diff -ru linux-2.6.8.1/include/linux/fs.h linux-2.6.8.1-new/include/linux/fs.h
--- linux-2.6.8.1/include/linux/fs.h	2004-09-14 21:20:43.000000000 +0300
+++ linux-2.6.8.1-new/include/linux/fs.h	2004-09-15 15:12:38.474626592 +0300
@@ -879,6 +879,22 @@
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
+	/* The following two calls are a replacement for the ioctl call above.
+	 * They take precedence over ioctl - if set, ioctl will not be used.
+	 * Unlike ioctl, BKL is not taken: drivers shall manage their own
+	 * locking. */
+
+	/* If ioctl_native is set, it is used instead 
+	 * of ioctl for native ioctl syscalls.
+	 * Note that standard glibc ioctl trims the return code to int,
+	 * so dont try to put 64 bit there, unless you know what you are doing.
+	 */
+	long (*ioctl_native) (struct inode *, struct file *, unsigned int, unsigned long);
+	/* If ioctl_compat is set, it is used for compatibility ioctl
+	 * (i.e. a 32 bit binary running on a 64 bit OS).
+	 * Note that only the low 32 bit of the return code are passed to the
+	 * user-space application. */
+	long (*ioctl_compat) (struct inode *, struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
diff -ru linux-2.6.8.1/Documentation/filesystems/Locking linux-2.6.8.1-new/Documentation/filesystems/Locking
--- linux-2.6.8.1/Documentation/filesystems/Locking	2004-09-14 21:20:57.000000000 +0300
+++ linux-2.6.8.1-new/Documentation/filesystems/Locking	2004-09-15 15:23:35.149796792 +0300
@@ -331,6 +331,10 @@
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int,
 			unsigned long);
+	long (*ioctl_native) (struct inode *, struct file *, unsigned int,
+			unsigned long);
+	long (*ioctl_compat) (struct inode *, struct file *, unsigned int,
+			unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
@@ -364,6 +368,8 @@
 readdir: 		no
 poll:			no
 ioctl:			yes	(see below)
+ioctl_native:		no	(see below)
+ioctl_compat:		no	(see below)
 mmap:			no
 open:			maybe	(see below)
 flush:			no
@@ -409,6 +415,9 @@
 anything that resembles union-mount we won't have a struct file for all
 components. And there are other reasons why the current interface is a mess...
 
+->ioctl() on regular files is superceded by the ->ioctl_native() and
+->ioctl_compat() pair. The lock is not taken for these new calls.
+
 ->read on directories probably must go away - we should just enforce -EISDIR
 in sys_read() and friends.
 
diff -ru linux-2.6.8.1/fs/compat.c linux-2.6.8.1-new/fs/compat.c
--- linux-2.6.8.1/fs/compat.c	2004-09-14 21:20:56.000000000 +0300
+++ linux-2.6.8.1-new/fs/compat.c	2004-09-15 15:15:04.384444928 +0300
@@ -385,15 +385,19 @@
 				unsigned long arg)
 {
 	struct file * filp;
-	int error = -EBADF;
+	long error = -EBADF;
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
 
@@ -406,11 +410,12 @@
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
@@ -446,7 +451,7 @@
 		}
 	}
 out:
-	fput(filp);
+	fput_light(filp, fput_needed);
 out2:
 	return error;
 }
diff -ru linux-2.6.8.1/fs/ioctl.c linux-2.6.8.1-new/fs/ioctl.c
--- linux-2.6.8.1/fs/ioctl.c	2004-09-14 21:20:56.000000000 +0300
+++ linux-2.6.8.1-new/fs/ioctl.c	2004-09-15 15:13:16.065911848 +0300
@@ -35,7 +35,9 @@
 			if ((error = get_user(block, p)) != 0)
 				return error;
 
+			lock_kernel();
 			res = mapping->a_ops->bmap(mapping, block);
+			unlock_kernel();
 			return put_user(res, p);
 		}
 		case FIGETBSZ:
@@ -45,29 +47,17 @@
 		case FIONREAD:
 			return put_user(i_size_read(inode) - filp->f_pos, p);
 	}
-	if (filp->f_op && filp->f_op->ioctl)
-		return filp->f_op->ioctl(inode, filp, cmd, arg);
 	return -ENOTTY;
 }
 
 
-asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
-{	
-	struct file * filp;
+EXPORT_SYMBOL(std_sys_ioctl);
+int std_sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg,
+	struct file * filp, int* error)
+{
+	int on;
 	unsigned int flag;
-	int on, error = -EBADF;
-
-	filp = fget(fd);
-	if (!filp)
-		goto out;
-
-	error = security_file_ioctl(filp, cmd, arg);
-	if (error) {
-                fput(filp);
-                goto out;
-        }
-
-	lock_kernel();
+	*error = security_file_ioctl(filp, cmd, arg);
 	switch (cmd) {
 		case FIOCLEX:
 			set_close_on_exec(fd, 1);
@@ -78,7 +68,7 @@
 			break;
 
 		case FIONBIO:
-			if ((error = get_user(on, (int __user *)arg)) != 0)
+			if ((*error = get_user(on, (int __user *)arg)) != 0)
 				break;
 			flag = O_NONBLOCK;
 #ifdef __sparc__
@@ -93,17 +83,20 @@
 			break;
 
 		case FIOASYNC:
-			if ((error = get_user(on, (int __user *)arg)) != 0)
+			if ((*error = get_user(on, (int __user *)arg)) != 0)
 				break;
 			flag = on ? FASYNC : 0;
 
 			/* Did FASYNC state change ? */
 			if ((flag ^ filp->f_flags) & FASYNC) {
-				if (filp->f_op && filp->f_op->fasync)
-					error = filp->f_op->fasync(fd, filp, on);
-				else error = -ENOTTY;
+				if (filp->f_op && filp->f_op->fasync) {
+					lock_kernel();
+					*error = filp->f_op->fasync(fd, filp, on);
+					unlock_kernel();
+				}
+				else *error = -ENOTTY;
 			}
-			if (error != 0)
+			if (*error != 0)
 				break;
 
 			if (on)
@@ -117,20 +110,50 @@
 			    S_ISREG(filp->f_dentry->d_inode->i_mode) ||
 			    S_ISLNK(filp->f_dentry->d_inode->i_mode)) {
 				loff_t res = inode_get_bytes(filp->f_dentry->d_inode);
-				error = copy_to_user((loff_t __user *)arg, &res, sizeof(res)) ? -EFAULT : 0;
+				*error = copy_to_user((loff_t __user *)arg, &res, sizeof(res)) ? -EFAULT : 0;
 			}
 			else
-				error = -ENOTTY;
+				*error = -ENOTTY;
 			break;
 		default:
-			error = -ENOTTY;
-			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
-				error = file_ioctl(filp, cmd, arg);
-			else if (filp->f_op && filp->f_op->ioctl)
-				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+			*error = -ENOTTY;
+			if (S_ISREG(filp->f_dentry->d_inode->i_mode)) {
+				*error = file_ioctl(filp, cmd, arg);
+			}
+			if (*error == -ENOTTY) return 1;
 	}
-	unlock_kernel();
-	fput(filp);
+	return 0;
+}
+
+
+
+asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{	
+	struct file * filp;
+	long error = -EBADF;
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
+		unlock_kernel();
+	}
+
+	fput_light(filp,fput_needed);
 
 out:
 	return error;
diff -ru linux-2.6.8.1/include/linux/ioctl.h linux-2.6.8.1-new/include/linux/ioctl.h
--- linux-2.6.8.1/include/linux/ioctl.h	2004-09-14 21:20:43.000000000 +0300
+++ linux-2.6.8.1-new/include/linux/ioctl.h	2004-09-13 18:04:23.000000000 +0300
@@ -3,5 +3,10 @@
 
 #include <asm/ioctl.h>
 
+/* Handles standard ioctl calls */
+struct file;
+int std_sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg,
+	struct file * filp, int* error);
+
 #endif /* _LINUX_IOCTL_H */
 
diff -ru linux-2.6.8.1/include/linux/compat_ioctl.h linux-2.6.8.1-new/include/linux/compat_ioctl.h
--- linux-2.6.8.1/include/linux/compat_ioctl.h	2004-09-14 21:20:43.000000000 +0300
+++ linux-2.6.8.1-new/include/linux/compat_ioctl.h	2004-09-07 20:19:24.000000000 +0300
@@ -54,15 +54,6 @@
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
diff -ru linux-2.6.8.1/arch/x86_64/ia32/ia32_ioctl.c linux-2.6.8.1-new/arch/x86_64/ia32/ia32_ioctl.c
--- linux-2.6.8.1/arch/x86_64/ia32/ia32_ioctl.c	2004-09-14 21:20:50.000000000 +0300
+++ linux-2.6.8.1-new/arch/x86_64/ia32/ia32_ioctl.c	2004-09-07 20:19:05.000000000 +0300
@@ -188,7 +188,6 @@
 COMPATIBLE_IOCTL(RTC_SET_TIME)
 COMPATIBLE_IOCTL(RTC_WKALM_SET)
 COMPATIBLE_IOCTL(RTC_WKALM_RD)
-COMPATIBLE_IOCTL(FIOQSIZE)
 
 /* And these ioctls need translation */
 HANDLE_IOCTL(TIOCGDEV, tiocgdev)
