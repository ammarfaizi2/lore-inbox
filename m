Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262233AbULOHq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262233AbULOHq5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 02:46:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262303AbULOHq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 02:46:56 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:1614 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262233AbULOHqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 02:46:34 -0500
Date: Wed, 15 Dec 2004 09:46:35 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215074635.GC11501@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215065650.GM27225@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andi!
Quoting r. Andi Kleen (ak@suse.de) "unregister_ioctl32_conversion and modules. ioctl32 revisited.":
> Hallo,
> 
> There seems to be an unfixable module unload race in the current
> register_ioctl32_conversion support. The problem is that
> there is no way to wait for a conversion handler is blocked
> in a sleeping *_user access before module unloading. The module
> count is also not increase in this case.
> 
> I previously thought it could be avoided by always putting
> the compat wrapper into the same module and using the reference
> counting that is done by VFS on ->module of the char device or
> file system converted. But that doesn't work because 
> the ioctl32 lookup is independent from the file descriptor
> and a conversion handler can be entered even after ->release
> when the right number is passed.
> 
> One way to fix it would be to put a pointer to the module
> into the compat ioctl hash table and increase the module count atomically
> from the compat code. But that would bloat the hash table a lot
> and I don't like it very much. Also you would either break the
> register_ioctl32_conversion prototype or make it a macro
> and assume all calls are from the same module, which is also 
> quite ugly.
> 
> A better solution would be to switch the few users of 
> register_ioctl32_conversion() over to a new ->ioctl32 method
> in file_operations and do the conversion from there. This would
> avoid the race because the VFS will take care of the module
> count in open/release.
> 
> Michael did a patch for this some time ago for a different motivation -
> he had some benchmarks where the hash table lookup hurt and it was
> noticeable faster to use a O(1) ->ioctl32 lookup from the file_operations
> for his application.
> 
> An useful side effect would be also to the ability to support 
> a per device ioctl name space. While the core kernel doesn't have
> much (any?) ioctls with duplicated numbers this mistake seems
> to be quite common in out of tree drivers and it is hard to 
> fix without breaking compatibility.
> 
> And it would be faster for this case of course too, so even performance
> critical in kernel ioctls could be slowly converted to ioctl32
> I wouldn't do it for all, because the current central tables work
> reasonably well for them and most ioctls are not speed critical
> anyways.
> 
> As for in kernel code it won't affect much code because near 
> all conversion handlers in the main tree are not modular (alsa 
> is one exception, there are a few others e.g. in some raid drivers). 
> I expect it will be a bigger problem in the future though as ioctl 
> emulation becomes more widespread and is done more in individual drivers.
> 
> averell:lsrc/v2.6/linux% gid register_ioctl32_conversion | wc -l
> 75
> averell:lsrc/v2.6/linux% 
> 
> In tree users are alsa, aaraid, fusion, some s390 stuff, sisfb, alsa
> 
> My proposal would be to dust off Michael's patch and convert 
> all users in tree over to ioctl32 and then deprecate and later remove
> (un)register_ioctl32_conversion 
> 
> Comments?
> 
> -Andi

It certainly helps performance, at least for me.

There were two additional motivations for my patch:
1. Make it possible to avoid the BKL completely by writing
   an ioctl with proper internal locking.
2. As noted by  Juergen Kreileder, the compat hash does not work
   for ioctls that encode additional information in the command, like this:

#define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)

I post the patch (updated for 2.6.10-rc2, boots) that I built for
Juergen, below. If there's interest, let me know.

I'd like to add that my patch does not touch any in-kernel users,
that would have to be done separately, probably as a first step
simply taking the BKL inside ioctl_compat.

MST


Signed-off-by: Michael Tsirkin <mst@mellanox.co.il>

diff -p -ruw linux-2.6.10-rc2-orig/Documentation/filesystems/Locking linux-2.6.10-rc2/Documentation/filesystems/Locking
--- linux-2.6.10-rc2-orig/Documentation/filesystems/Locking	2004-11-19 13:37:15.459406800 +0200
+++ linux-2.6.10-rc2/Documentation/filesystems/Locking	2004-11-19 13:40:34.685119888 +0200
@@ -350,6 +350,10 @@ prototypes:
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
@@ -383,6 +387,8 @@ aio_write:		no
 readdir: 		no
 poll:			no
 ioctl:			yes	(see below)
+ioctl_native:		no	(see below)
+ioctl_compat:		no	(see below)
 mmap:			no
 open:			maybe	(see below)
 flush:			no
@@ -428,6 +434,9 @@ move ->readdir() to inode_operations and
 anything that resembles union-mount we won't have a struct file for all
 components. And there are other reasons why the current interface is a mess...
 
+->ioctl() on regular files is superceded by the ->ioctl_native() and
+->ioctl_compat() pair. The lock is not taken for these new calls.
+
 ->read on directories probably must go away - we should just enforce -EISDIR
 in sys_read() and friends.
 
diff -p -ruw linux-2.6.10-rc2-orig/fs/compat.c linux-2.6.10-rc2/fs/compat.c
--- linux-2.6.10-rc2-orig/fs/compat.c	2004-11-19 13:37:51.937861232 +0200
+++ linux-2.6.10-rc2/fs/compat.c	2004-11-19 14:46:22.293992120 +0200
@@ -401,15 +401,20 @@ asmlinkage long compat_sys_ioctl(unsigne
 				unsigned long arg)
 {
 	struct file * filp;
-	int error = -EBADF;
+	long error = -EBADF;
 	struct ioctl_trans *t;
+	int fput_needed;
 
-	filp = fget(fd);
-	if(!filp)
+	filp = fget_light(fd, &fput_needed);
+	if (!filp) {
 		goto out2;
+	}
 
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
+	if (!std_sys_ioctl(fd, cmd, arg, filp, &error)) {
+		goto out;
+	} else if (filp->f_op && filp->f_op->ioctl_compat) {
+		error = filp->f_op->ioctl_compat(filp->f_dentry->d_inode,
+						 filp, cmd, arg);
 		goto out;
 	}
 
@@ -425,9 +430,12 @@ asmlinkage long compat_sys_ioctl(unsigne
 			error = t->handler(fd, cmd, arg, filp);
 			unlock_kernel();
 			up_read(&ioctl32_sem);
-		} else {
+		} else if (filp->f_op && filp->f_op->ioctl) {
 			up_read(&ioctl32_sem);
-			error = sys_ioctl(fd, cmd, arg);
+			lock_kernel();
+			error = filp->f_op->ioctl(filp->f_dentry->d_inode,
+						  filp, cmd, arg);
+			unlock_kernel();
 		}
 	} else {
 		up_read(&ioctl32_sem);
@@ -466,7 +474,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 		}
 	}
 out:
-	fput(filp);
+	fput_light(filp, fput_needed);
 out2:
 	return error;
 }
diff -p -ruw linux-2.6.10-rc2-orig/fs/ioctl.c linux-2.6.10-rc2/fs/ioctl.c
--- linux-2.6.10-rc2-orig/fs/ioctl.c	2004-11-19 13:37:58.693834168 +0200
+++ linux-2.6.10-rc2/fs/ioctl.c	2004-11-19 14:43:25.713836384 +0200
@@ -36,7 +36,9 @@ static int file_ioctl(struct file *filp,
 			if ((error = get_user(block, p)) != 0)
 				return error;
 
+			lock_kernel();
 			res = mapping->a_ops->bmap(mapping, block);
+			unlock_kernel();
 			return put_user(res, p);
 		}
 		case FIGETBSZ:
@@ -46,29 +48,22 @@ static int file_ioctl(struct file *filp,
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
+		  struct file *filp, long *status)
 {	
-	struct file * filp;
 	unsigned int flag;
-	int on, error = -EBADF;
-
-	filp = fget(fd);
-	if (!filp)
-		goto out;
+	int on, error, unknown=0;
 
 	error = security_file_ioctl(filp, cmd, arg);
 	if (error) {
-                fput(filp);
                 goto out;
         }
 
-	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
 			set_close_on_exec(fd, 1);
@@ -100,8 +95,11 @@ asmlinkage long sys_ioctl(unsigned int f
 
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
@@ -125,15 +123,48 @@ asmlinkage long sys_ioctl(unsigned int f
 			break;
 		default:
 			error = -ENOTTY;
-			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
+			if (S_ISREG(filp->f_dentry->d_inode->i_mode)) {
 				error = file_ioctl(filp, cmd, arg);
-			else if (filp->f_op && filp->f_op->ioctl)
-				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
 	}
+			if (error == -ENOTTY) {
+				unknown=1;
+				goto out;
+			}
+			break;
+	}
+out:
+	*status=error;
+	return unknown;
+}
+
+asmlinkage long sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg)
+{	
+	struct file *filp;
+	long error = -EBADF;
+	int fput_needed;
+
+	filp = fget_light(fd, &fput_needed);
+	if (!filp) {
+		goto out2;
+	}
+
+	if (!std_sys_ioctl(fd, cmd, arg, filp, &error)) {
+		goto out;
+	}
+
+	if (filp->f_op && filp->f_op->ioctl_native) {
+		error = filp->f_op->ioctl_native(filp->f_dentry->d_inode,
+						 filp, cmd, arg);
+	} else if (filp->f_op && filp->f_op->ioctl) {
+		lock_kernel();
+		error = filp->f_op->ioctl(filp->f_dentry->d_inode,
+					  filp, cmd, arg);
 	unlock_kernel();
-	fput(filp);
+	}
 
 out:
+	fput_light(filp, fput_needed);
+  out2:
 	return error;
 }
 
diff -p -ruw linux-2.6.10-rc2-orig/include/linux/fs.h linux-2.6.10-rc2/include/linux/fs.h
--- linux-2.6.10-rc2-orig/include/linux/fs.h	2004-11-19 13:38:00.205604344 +0200
+++ linux-2.6.10-rc2/include/linux/fs.h	2004-11-19 13:40:34.688119432 +0200
@@ -915,6 +915,23 @@ struct file_operations {
 	int (*readdir) (struct file *, void *, filldir_t);
 	unsigned int (*poll) (struct file *, struct poll_table_struct *);
 	int (*ioctl) (struct inode *, struct file *, unsigned int, unsigned long);
+	/* The two calls ioctl_native and ioctl_compat described below
+	 * can be used as a replacement for the ioctl call above. They
+	 * take precedence over ioctl: thus if they are set, ioctl is
+	 * not used.  Unlike ioctl, BKL is not taken: drivers manage
+	 * their own locking. */
+
+	/* If ioctl_native is set, it is used instead of ioctl for
+	 * native ioctl syscalls.
+	 * Note that the standard glibc ioctl trims the return code to
+	 * type int, so dont try to put a 64 bit value there.
+	 */
+	long (*ioctl_native) (struct inode *, struct file *, unsigned int, unsigned long);
+	/* If ioctl_compat is set, it is used for a 32 bit compatible
+	 * ioctl (i.e. a 32 bit binary running on a 64 bit OS).
+	 * Note that only the low 32 bit of the return code are passed
+	 * to the user-space application. */
+	long (*ioctl_compat) (struct inode *, struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
diff -p -ruw linux-2.6.10-rc2-orig/include/linux/ioctl.h linux-2.6.10-rc2/include/linux/ioctl.h
--- linux-2.6.10-rc2-orig/include/linux/ioctl.h	2004-10-18 23:53:22.000000000 +0200
+++ linux-2.6.10-rc2/include/linux/ioctl.h	2004-11-19 14:05:39.123410504 +0200
@@ -3,5 +3,13 @@
 
 #include <asm/ioctl.h>
 
+/* Handles standard ioctl commands, and returns the result in status.
+   Does nothing and returns non-zero if cmd is not one of the standard commands.
+*/
+
+struct file;
+int std_sys_ioctl(unsigned int fd, unsigned int cmd, unsigned long arg,
+		  struct file *filp, long *status);
+
 #endif /* _LINUX_IOCTL_H */
 
