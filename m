Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262331AbULOLm7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbULOLm7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 06:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbULOLm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 06:42:59 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:52151 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262331AbULOLmp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 06:42:45 -0500
Date: Wed, 15 Dec 2004 13:42:46 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041215114246.GB12187@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20041215065650.GM27225@wotan.suse.de> <20041215074635.GC11501@mellanox.co.il> <20041215080020.GT27225@wotan.suse.de> <20041215082128.GA11889@mellanox.co.il> <20041215082917.GW27225@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041215082917.GW27225@wotan.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Andi Kleen (ak@suse.de) "Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.":
> On Wed, Dec 15, 2004 at 10:21:28AM +0200, Michael S. Tsirkin wrote:
> > > > 2. As noted by  Juergen Kreileder, the compat hash does not work
> > > >    for ioctls that encode additional information in the command, like this:
> > > > 
> > > > #define EVIOCGBIT(ev,len)  _IOC(_IOC_READ, 'E', 0x20 + ev, len)
> > > > 
> > > > I post the patch (updated for 2.6.10-rc2, boots) that I built for
> > > > Juergen, below. If there's interest, let me know.
> > > 
> > > Patch looks good to me, except for some messed up white space
> > > that is probably easily fixed.
> > 
> > I did try so .. Where? :)
> 
> Most of it actually. But perhaps your mailer just messed up the patch?
> 
> Anyways, if there are no negative comments I would recommend you
> submit your patch (preferably in a non messed up form) to akpm@osdl.org
> for inclusion into -mm*. The other parts of the proposal (converting
> the existing users and deprecating register_ioctl32_conversion) could be 
> attacked then.
> 
> There is also some related work that could be done easily then,
> e.g. the network stack ioctls currently drop the BKL as first thing.
> With ioctl_native that could be probably done better. There may 
> be other such low hanging fruit areas too.
> 
> -Andi

OK, so here's a cleaned-up version, against 2.6.10-rc3.
Please comment (and please Cc me, I'm not on the list).
If there are no negative comments I will try to submit to akpm@osdl.org

Andi, I'm trying again with an in-line patch,
if the white-space is mangled by the mail system again,
please let me know so I know to resend as an attachment.

Thanks,
MST

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>

diff -rpu linux-2.6.10-rc3-orig/Documentation/filesystems/Locking linux-2.6.10-rc3/Documentation/filesystems/Locking
--- linux-2.6.10-rc3-orig/Documentation/filesystems/Locking	2004-12-15 11:22:12.412171568 +0200
+++ linux-2.6.10-rc3/Documentation/filesystems/Locking	2004-12-15 11:24:47.441603512 +0200
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
 
diff -rpu linux-2.6.10-rc3-orig/include/linux/fs.h linux-2.6.10-rc3/include/linux/fs.h
--- linux-2.6.10-rc3-orig/include/linux/fs.h	2004-12-15 11:22:15.977629536 +0200
+++ linux-2.6.10-rc3/include/linux/fs.h	2004-12-15 11:24:47.444603056 +0200
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
diff -rpu linux-2.6.10-rc3-orig/include/linux/ioctl.h linux-2.6.10-rc3/include/linux/ioctl.h
--- linux-2.6.10-rc3-orig/include/linux/ioctl.h	2004-10-18 23:53:22.000000000 +0200
+++ linux-2.6.10-rc3/include/linux/ioctl.h	2004-12-15 11:24:47.445602904 +0200
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
 
diff -rpu linux-2.6.10-rc3-orig/fs/ioctl.c linux-2.6.10-rc3/fs/ioctl.c
--- linux-2.6.10-rc3-orig/fs/ioctl.c	2004-12-15 11:22:15.397717696 +0200
+++ linux-2.6.10-rc3/fs/ioctl.c	2004-12-15 13:09:30.314461656 +0200
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
 	}
-	unlock_kernel();
-	fput(filp);
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
+	}
 
 out:
+	fput_light(filp, fput_needed);
+out2:
 	return error;
 }
 
diff -rpu linux-2.6.10-rc3-orig/fs/compat.c linux-2.6.10-rc3/fs/compat.c
--- linux-2.6.10-rc3-orig/fs/compat.c	2004-12-15 11:22:15.332727576 +0200
+++ linux-2.6.10-rc3/fs/compat.c	2004-12-15 13:03:22.778335640 +0200
@@ -401,15 +401,19 @@ asmlinkage long compat_sys_ioctl(unsigne
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
+		goto out;
+	else if (filp->f_op && filp->f_op->ioctl_compat) {
+		error = filp->f_op->ioctl_compat(filp->f_dentry->d_inode,
+						 filp, cmd, arg);
 		goto out;
 	}
 
@@ -425,9 +429,12 @@ asmlinkage long compat_sys_ioctl(unsigne
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
@@ -466,7 +473,7 @@ asmlinkage long compat_sys_ioctl(unsigne
 		}
 	}
 out:
-	fput(filp);
+	fput_light(filp, fput_needed);
 out2:
 	return error;
 }
