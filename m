Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261297AbULPPpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbULPPpW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 10:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261189AbULPPpW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 10:45:22 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:7100 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S261297AbULPPo2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 10:44:28 -0500
Date: Fri, 17 Dec 2004 03:43:45 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andrew Morton <akpm@osdl.org>
Cc: Andi Kleen <ak@suse.de>, mingo@elte.hu, rlrevell@joe-job.com,
       tiwai@suse.de, mst@mellanox.co.il, linux-kernel@vger.kernel.org,
       pavel@suse.cz, discuss@x86-64.org, gordon.jin@intel.com,
       alsa-devel@lists.sourceforge.net, greg@kroah.com
Subject: [PATCH] unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041217014345.GA11926@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215065650.GM27225@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Andrew!
Since I didnt get any negative comments on this (and some positive)
Andi Kleen suggested I submit the following patch to you.
It boots fine for me, please consider for mainline inclusion.

Dependencies:
The patch below is against 2.6.10-rc3. Please note it replaces
Ingo's ->unlocked_ioctl patch from rc3-mm1, so you have to back that off
before applying mine to mm:

http://kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc3/2.6.10-rc3-mm1/broken-out/unlocked_ioctl.patch

Please mail me directly with comments since I'm not on the list.

Changes from the last version I posted ( http://lkml.org/lkml/2004/12/15/62 )
- Two whitespace cleanups. I hope its all good now.
- Arnd Bergmann's idea: make it possible to go back from ioctl_compat
  to hash lookup (good for static ioctl tables) by returning -ENOIOCTLCMD
  from ioctl_compat
- Petr Vandrovec's idea: add HAVE_... macros to make it easier for
  out-of-kernel modules to detect the new file_operations.

Description:
The patch introduces two new methods (ioctl_native and ioctl_compat):
ioctl_native is called on native ioctl syscall, without BKL being taken,
and is, in that respect, equivalent to Ingo's unlocked_ioctl (which is
why it conflicts).
ioctl_compat is called on compat (i.e. 32 bit app on 64 bit OS) ioctl,
again without BKL being taken.
If a new call is not defined, default to the old behaviour.
(It should be possible for me to build a patch that applies on top of Ingo's
unlocked_ioctl, if its really needed let me know and I'll look at it the next
week.)


Motivation: Quoting Andi Kleen:
> Hallo,
> 
> There seems to be an unfixable module unload race in the current
> register_ioctl32_conversion support. The problem is that
> there is no way to wait for a conversion handler is blocked
> in a sleeping *_user access before module unloading. The module
> count is also not increase in this case.
> ...

[Snip]

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

There was an additional motivation for my patch:
As noted by  Juergen Kreileder, the compat hash does not work
for ioctls that encode additional information in the command, like this:

#define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)

Comments?

Thanks,
MST

Signed-off-by: Michael Tsirkin <mst@mellanox.co.il>

diff -rup linux-2.6.10-rc3/Documentation/filesystems/Locking linux-2.6.10-rc3-mstioctl/Documentation/filesystems/Locking
--- linux-2.6.10-rc3/Documentation/filesystems/Locking	2004-12-16 15:20:36.000000000 +0200
+++ linux-2.6.10-rc3-mstioctl/Documentation/filesystems/Locking	2004-12-16 18:25:35.289970464 +0200
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
 
diff -rup linux-2.6.10-rc3/include/linux/fs.h linux-2.6.10-rc3-mstioctl/include/linux/fs.h
--- linux-2.6.10-rc3/include/linux/fs.h	2004-12-16 15:20:46.000000000 +0200
+++ linux-2.6.10-rc3-mstioctl/include/linux/fs.h	2004-12-16 18:25:35.291970160 +0200
@@ -900,6 +900,12 @@ typedef struct {
 
 typedef int (*read_actor_t)(read_descriptor_t *, struct page *, unsigned long, unsigned long);
 
+/* These macros are for out of kernel modules to test that
+ * the kernel supports the ioctl_native and ioctl_compat
+ * fields in struct file_operations. */
+#define HAVE_IOCTL_COMPAT 1
+#define HAVE_IOCTL_NATIVE 1
+
 /*
  * NOTE:
  * read, write, poll, fsync, readv, writev can be called
@@ -915,6 +921,24 @@ struct file_operations {
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
+	 * Return -ENOIOCTLCMD if you dont handle it.
+	 * Note that only the low 32 bit of the return code are passed
+	 * to the user-space application. */
+	long (*ioctl_compat) (struct inode *, struct file *, unsigned int, unsigned long);
 	int (*mmap) (struct file *, struct vm_area_struct *);
 	int (*open) (struct inode *, struct file *);
 	int (*flush) (struct file *);
diff -rup linux-2.6.10-rc3/include/linux/ioctl.h linux-2.6.10-rc3-mstioctl/include/linux/ioctl.h
--- linux-2.6.10-rc3/include/linux/ioctl.h	2004-12-16 15:19:34.000000000 +0200
+++ linux-2.6.10-rc3-mstioctl/include/linux/ioctl.h	2004-12-16 18:25:35.291970160 +0200
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
 
diff -rup linux-2.6.10-rc3/fs/ioctl.c linux-2.6.10-rc3-mstioctl/fs/ioctl.c
--- linux-2.6.10-rc3/fs/ioctl.c	2004-12-16 15:20:45.000000000 +0200
+++ linux-2.6.10-rc3-mstioctl/fs/ioctl.c	2004-12-16 18:27:21.000899960 +0200
@@ -36,7 +36,9 @@ static int file_ioctl(struct file *filp,
 			if ((error = get_user(block, p)) != 0)
 				return error;
 
+			lock_kernel();
 			res = mapping->a_ops->bmap(mapping, block);
+			unlock_kernel();
 			return put_user(res, p);
 		}
 		case FIGETBSZ:
@@ -46,29 +48,21 @@ static int file_ioctl(struct file *filp,
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
+		  struct file *filp, long *status)
+{
 	unsigned int flag;
-	int on, error = -EBADF;
-
-	filp = fget(fd);
-	if (!filp)
-		goto out;
+	int on, error, unknown = 0;
 
 	error = security_file_ioctl(filp, cmd, arg);
-	if (error) {
-                fput(filp);
+	if (error)
                 goto out;
-        }
 
-	lock_kernel();
 	switch (cmd) {
 		case FIOCLEX:
 			set_close_on_exec(fd, 1);
@@ -100,8 +94,11 @@ asmlinkage long sys_ioctl(unsigned int f
 
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
@@ -125,15 +122,46 @@ asmlinkage long sys_ioctl(unsigned int f
 			break;
 		default:
 			error = -ENOTTY;
-			if (S_ISREG(filp->f_dentry->d_inode->i_mode))
+			if (S_ISREG(filp->f_dentry->d_inode->i_mode)) {
 				error = file_ioctl(filp, cmd, arg);
-			else if (filp->f_op && filp->f_op->ioctl)
-				error = filp->f_op->ioctl(filp->f_dentry->d_inode, filp, cmd, arg);
+			}
+			if (error == -ENOTTY) {
+				unknown = 1;
+				goto out;
+			}
+			break;
+	}
+out:
+	*status = error;
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
+	if (!filp)
+		goto out2;
+
+	if (!std_sys_ioctl(fd, cmd, arg, filp, &error))
+		goto out;
+
+	if (filp->f_op && filp->f_op->ioctl_native)
+		error = filp->f_op->ioctl_native(filp->f_dentry->d_inode,
+						 filp, cmd, arg);
+	else if (filp->f_op && filp->f_op->ioctl) {
+		lock_kernel();
+		error = filp->f_op->ioctl(filp->f_dentry->d_inode,
+					  filp, cmd, arg);
+		unlock_kernel();
 	}
-	unlock_kernel();
-	fput(filp);
 
 out:
+	fput_light(filp, fput_needed);
+out2:
 	return error;
 }
 
diff -rup linux-2.6.10-rc3/fs/compat.c linux-2.6.10-rc3-mstioctl/fs/compat.c
--- linux-2.6.10-rc3/fs/compat.c	2004-12-16 15:20:45.000000000 +0200
+++ linux-2.6.10-rc3-mstioctl/fs/compat.c	2004-12-16 18:26:23.013715352 +0200
@@ -401,16 +401,21 @@ asmlinkage long compat_sys_ioctl(unsigne
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
+	if (!filp)
 		goto out2;
 
-	if (!filp->f_op || !filp->f_op->ioctl) {
-		error = sys_ioctl (fd, cmd, arg);
+	if (!std_sys_ioctl(fd, cmd, arg, filp, &error))
 		goto out;
+	else if (filp->f_op && filp->f_op->ioctl_compat) {
+		error = filp->f_op->ioctl_compat(filp->f_dentry->d_inode,
+						 filp, cmd, arg);
+		if (error != -ENOIOCTLCMD)
+			goto out;
 	}
 
 	down_read(&ioctl32_sem);
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
