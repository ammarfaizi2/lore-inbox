Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261305AbSJPSyl>; Wed, 16 Oct 2002 14:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSJPSyl>; Wed, 16 Oct 2002 14:54:41 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:52491 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261305AbSJPSxs>;
	Wed, 16 Oct 2002 14:53:48 -0400
Date: Wed, 16 Oct 2002 11:59:28 -0700
From: Greg KH <greg@kroah.com>
To: netdev@oss.sgi.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] change format of LSM hooks
Message-ID: <20021016185927.GA25475@kroah.com>
References: <20021015194545.GC15864@kroah.com> <20021015.124502.130514745.davem@redhat.com> <20021015201209.GE15864@kroah.com> <20021015.131037.96602290.davem@redhat.com> <20021015202828.GG15864@kroah.com> <20021016000706.GI16966@kroah.com> <20021016081539.GF20421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021016081539.GF20421@kroah.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2002 at 01:15:40AM -0700, Greg KH wrote:
> On Tue, Oct 15, 2002 at 05:07:06PM -0700, Greg KH wrote:
> > 
> > I'll work on fixing up the rest of the hooks, and removing the external
> > reference to security_ops, and actually test this thing, later this
> > evening.
> 
> Here's all the hooks converted over to function calls.  Chris Wright
> pointed out I need to do some extra work with the existing capabilities
> hooks, but I'll do that in the morning.

Ok, here's a working version (I'm typing from it right now), with all of
the capability logic working again.  This does make the
security/built-in.o file this size with CONFIG_SECURITY=y

   text    data     bss     dec     hex filename
   1611       0       0    1611     64b security/built-in.o

But this is due to the code there being moved from other parts of the
kernel in the initial LSM merge, so there is no real increased code
size.

It's also now pretty easy to tweak things to drop capability support
alltogether, which should save the above space, and make the embedded
people happy.  If we ever end up with a CONFIG_REALLY_SMALL option, I'll
make those changes.

Could people please look this over and offer any comments?  I'm
especially interested in comments regarding the changes I've made to
security/Config.in, security/Makefile, include/linux/security.h and
security/capability.c.  Again, this is against 2.5.43.

If no one has any problems with this, I'll send it on to Linus later
this evening.

thanks,

greg k-h

===== arch/arm/kernel/ptrace.c 1.14 vs edited =====
--- 1.14/arch/arm/kernel/ptrace.c	Sun Oct 13 07:32:28 2002
+++ edited/arch/arm/kernel/ptrace.c	Wed Oct 16 00:46:07 2002
@@ -719,8 +719,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
===== arch/i386/kernel/ptrace.c 1.13 vs edited =====
--- 1.13/arch/i386/kernel/ptrace.c	Fri Jul 19 16:00:55 2002
+++ edited/arch/i386/kernel/ptrace.c	Tue Oct 15 22:24:45 2002
@@ -160,8 +160,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
===== arch/ia64/kernel/ptrace.c 1.12 vs edited =====
--- 1.12/arch/ia64/kernel/ptrace.c	Tue Sep 17 23:22:09 2002
+++ edited/arch/ia64/kernel/ptrace.c	Wed Oct 16 00:45:53 2002
@@ -1101,8 +1101,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		current->ptrace |= PT_PTRACED;
 		ret = 0;
===== arch/ppc/kernel/ptrace.c 1.10 vs edited =====
--- 1.10/arch/ppc/kernel/ptrace.c	Sun Sep 15 21:51:59 2002
+++ edited/arch/ppc/kernel/ptrace.c	Wed Oct 16 00:45:41 2002
@@ -166,8 +166,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
===== arch/ppc64/kernel/ptrace.c 1.3 vs edited =====
--- 1.3/arch/ppc64/kernel/ptrace.c	Wed Aug 28 23:42:43 2002
+++ edited/arch/ppc64/kernel/ptrace.c	Wed Oct 16 00:45:16 2002
@@ -59,8 +59,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
===== arch/ppc64/kernel/ptrace32.c 1.5 vs edited =====
--- 1.5/arch/ppc64/kernel/ptrace32.c	Wed Aug 28 23:42:43 2002
+++ edited/arch/ppc64/kernel/ptrace32.c	Wed Oct 16 00:45:29 2002
@@ -48,8 +48,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
===== arch/ppc64/kernel/sys_ppc32.c 1.24 vs edited =====
--- 1.24/arch/ppc64/kernel/sys_ppc32.c	Fri Oct 11 19:04:17 2002
+++ edited/arch/ppc64/kernel/sys_ppc32.c	Wed Oct 16 00:15:31 2002
@@ -53,6 +53,7 @@
 #include <linux/mman.h>
 #include <linux/sysctl.h>
 #include <linux/binfmts.h>
+#include <linux/security.h>
 
 #include <asm/types.h>
 #include <asm/ipc.h>
@@ -3519,8 +3520,7 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	retval = security_ops->bprm_alloc_security(&bprm);
-	if (retval) 
+	if ((retval = security_bprm_alloc(&bprm)))
 		goto out;
 
 	retval = prepare_binprm(&bprm);
@@ -3543,7 +3543,7 @@
 	retval = search_binary_handler(&bprm,regs);
 	if (retval >= 0) {
 		/* execve success */
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 		return retval;
 	}
 
@@ -3556,7 +3556,7 @@
 	}
 
 	if (bprm.security)
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 
 out_mm:
 	mmdrop(bprm.mm);
===== arch/s390/kernel/ptrace.c 1.9 vs edited =====
--- 1.9/arch/s390/kernel/ptrace.c	Fri Oct  4 09:16:18 2002
+++ edited/arch/s390/kernel/ptrace.c	Wed Oct 16 00:44:51 2002
@@ -330,8 +330,7 @@
 		ret = -EPERM;
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
===== arch/s390x/kernel/ptrace.c 1.8 vs edited =====
--- 1.8/arch/s390x/kernel/ptrace.c	Fri Oct  4 09:16:18 2002
+++ edited/arch/s390x/kernel/ptrace.c	Wed Oct 16 00:44:40 2002
@@ -32,6 +32,7 @@
 #include <linux/errno.h>
 #include <linux/ptrace.h>
 #include <linux/user.h>
+#include <linux/security.h>
 
 #include <asm/segment.h>
 #include <asm/page.h>
@@ -568,8 +569,7 @@
 		ret = -EPERM;
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
===== arch/sparc/kernel/ptrace.c 1.11 vs edited =====
--- 1.11/arch/sparc/kernel/ptrace.c	Sat Aug 24 04:08:41 2002
+++ edited/arch/sparc/kernel/ptrace.c	Wed Oct 16 00:44:06 2002
@@ -291,8 +291,7 @@
 			pt_error_return(regs, EPERM);
 			goto out;
 		}
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret) {
+		if ((ret = security_ptrace(current->parent, current))) {
 			pt_error_return(regs, -ret);
 			goto out;
 		}
===== arch/sparc64/kernel/ptrace.c 1.16 vs edited =====
--- 1.16/arch/sparc64/kernel/ptrace.c	Sat Aug 24 03:59:14 2002
+++ edited/arch/sparc64/kernel/ptrace.c	Wed Oct 16 00:43:53 2002
@@ -140,8 +140,7 @@
 			pt_error_return(regs, EPERM);
 			goto out;
 		}
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret) {
+		if ((ret = security_ptrace(current->parent, current))) {
 			pt_error_return(regs, -ret);
 			goto out;
 		}
===== arch/sparc64/kernel/sys_sparc32.c 1.39 vs edited =====
--- 1.39/arch/sparc64/kernel/sys_sparc32.c	Mon Oct 14 05:17:46 2002
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Wed Oct 16 00:14:27 2002
@@ -2972,8 +2972,7 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	retval = security_ops->bprm_alloc_security(&bprm);
-	if (retval) 
+	if ((retval = security_bprm_alloc(&bprm)))
 		goto out;
 
 	retval = prepare_binprm(&bprm);
@@ -2996,7 +2995,7 @@
 	retval = search_binary_handler(&bprm, regs);
 	if (retval >= 0) {
 		/* execve success */
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 		return retval;
 	}
 
@@ -3009,7 +3008,7 @@
 	}
 
 	if (bprm.security)
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 
 out_mm:
 	mmdrop(bprm.mm);
===== arch/um/kernel/ptrace.c 1.1 vs edited =====
--- 1.1/arch/um/kernel/ptrace.c	Fri Sep  6 10:50:31 2002
+++ edited/arch/um/kernel/ptrace.c	Wed Oct 16 00:43:41 2002
@@ -33,8 +33,7 @@
 		if (current->ptrace & PT_PTRACED)
 			goto out;
 
-		ret = security_ops->ptrace(current->parent, current);
-		if(ret)
+		if ((ret = security_ptrace(current->parent, current)))
  			goto out;
 
 		/* set the ptrace bit in the process flags. */
===== arch/x86_64/kernel/ptrace.c 1.4 vs edited =====
--- 1.4/arch/x86_64/kernel/ptrace.c	Fri Oct 11 16:52:38 2002
+++ edited/arch/x86_64/kernel/ptrace.c	Wed Oct 16 00:43:30 2002
@@ -178,8 +178,7 @@
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED)
 			goto out;
-		ret = security_ops->ptrace(current->parent, current);
-		if (ret)
+		if ((ret = security_ptrace(current->parent, current)))
 			goto out;
 		/* set the ptrace bit in the process flags. */
 		current->ptrace |= PT_PTRACED;
===== drivers/base/fs/class.c 1.2 vs edited =====
--- 1.2/drivers/base/fs/class.c	Mon Aug 26 08:39:22 2002
+++ edited/drivers/base/fs/class.c	Tue Oct 15 22:24:45 2002
@@ -7,6 +7,8 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
+#include <linux/limits.h>
+#include <linux/stat.h>
 #include "fs.h"
 
 static struct driver_dir_entry class_dir;
===== drivers/base/fs/intf.c 1.2 vs edited =====
--- 1.2/drivers/base/fs/intf.c	Mon Aug 26 09:24:18 2002
+++ edited/drivers/base/fs/intf.c	Tue Oct 15 22:24:45 2002
@@ -4,6 +4,8 @@
 
 #include <linux/device.h>
 #include <linux/slab.h>
+#include <linux/limits.h>
+#include <linux/errno.h>
 #include "fs.h"
 
 /**
===== fs/attr.c 1.10 vs edited =====
--- 1.10/fs/attr.c	Mon Jul 22 03:12:48 2002
+++ edited/fs/attr.c	Tue Oct 15 23:50:23 2002
@@ -153,13 +153,12 @@
 	}
 
 	if (inode->i_op && inode->i_op->setattr) {
-		error = security_ops->inode_setattr(dentry, attr);
-		if (!error)
+		if (!(error = security_inode_setattr(dentry, attr)))
 			error = inode->i_op->setattr(dentry, attr);
 	} else {
 		error = inode_change_ok(inode, attr);
 		if (!error)
-			error = security_ops->inode_setattr(dentry, attr);
+			error = security_inode_setattr(dentry, attr);
 		if (!error) {
 			if ((ia_valid & ATTR_UID && attr->ia_uid != inode->i_uid) ||
 			    (ia_valid & ATTR_GID && attr->ia_gid != inode->i_gid))
===== fs/dquot.c 1.48 vs edited =====
--- 1.48/fs/dquot.c	Sun Oct 13 08:39:23 2002
+++ edited/fs/dquot.c	Tue Oct 15 22:55:27 2002
@@ -69,6 +69,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/proc_fs.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -1305,8 +1306,7 @@
 	error = -EIO;
 	if (!f->f_op || !f->f_op->read || !f->f_op->write)
 		goto out_f;
-	error = security_ops->quota_on(f);
-	if (error)
+	if ((error = security_quota_on(f)))
 		goto out_f;
 	inode = f->f_dentry->d_inode;
 	error = -EACCES;
===== fs/exec.c 1.51 vs edited =====
--- 1.51/fs/exec.c	Sun Oct 13 09:32:22 2002
+++ edited/fs/exec.c	Tue Oct 15 23:03:20 2002
@@ -43,6 +43,7 @@
 #include <linux/namei.h>
 #include <linux/proc_fs.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgalloc.h>
@@ -818,8 +819,7 @@
 	}
 
 	/* fill in binprm security blob */
-	retval = security_ops->bprm_set_security(bprm);
-	if (retval)
+	if ((retval = security_bprm_set(bprm)))
 		return retval;
 
 	memset(bprm->buf,0,BINPRM_BUF_SIZE);
@@ -867,7 +867,7 @@
 	if(do_unlock)
 		unlock_kernel();
 
-	security_ops->bprm_compute_creds(bprm);
+	security_bprm_compute_creds(bprm);
 }
 
 void remove_arg_zero(struct linux_binprm *bprm)
@@ -936,8 +936,7 @@
 	    }
 	}
 #endif
-	retval = security_ops->bprm_check_security(bprm);
-	if (retval) 
+	if ((retval = security_bprm_check(bprm)))
 		return retval;
 
 	/* kernel module loader fixup */
@@ -1033,8 +1032,7 @@
 	if ((retval = bprm.envc) < 0)
 		goto out_mm;
 
-	retval = security_ops->bprm_alloc_security(&bprm);
-	if (retval) 
+	if ((retval = security_bprm_alloc(&bprm)))
 		goto out;
 
 	retval = prepare_binprm(&bprm);
@@ -1057,7 +1055,7 @@
 	retval = search_binary_handler(&bprm,regs);
 	if (retval >= 0) {
 		/* execve success */
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 		return retval;
 	}
 
@@ -1070,7 +1068,7 @@
 	}
 
 	if (bprm.security)
-		security_ops->bprm_free_security(&bprm);
+		security_bprm_free(&bprm);
 
 out_mm:
 	mmdrop(bprm.mm);
===== fs/fcntl.c 1.20 vs edited =====
--- 1.20/fs/fcntl.c	Sun Oct 13 08:39:40 2002
+++ edited/fs/fcntl.c	Wed Oct 16 00:04:50 2002
@@ -274,8 +274,7 @@
 {
 	int err;
 	
-	err = security_ops->file_set_fowner(filp);
-	if (err)
+	if ((err = security_file_set_fowner(filp)))
 		return err;
 
 	f_modown(filp, arg, current->uid, current->euid, force);
@@ -368,8 +367,7 @@
 	if (!filp)
 		goto out;
 
-	err = security_ops->file_fcntl(filp, cmd, arg);
-	if (err) {
+	if ((err = security_file_fcntl(filp, cmd, arg))) {
 		fput(filp);
 		return err;
 	}
@@ -392,8 +390,7 @@
 	if (!filp)
 		goto out;
 
-	err = security_ops->file_fcntl(filp, cmd, arg);
-	if (err) {
+	if ((err = security_file_fcntl(filp, cmd, arg))) {
 		fput(filp);
 		return err;
 	}
@@ -444,7 +441,7 @@
 	if (!sigio_perm(p, fown))
 		return;
 
-	if (security_ops->file_send_sigiotask(p, fown, fd, reason))
+	if (security_file_send_sigiotask(p, fown, fd, reason))
 		return;
 
 	switch (fown->signum) {
===== fs/file_table.c 1.13 vs edited =====
--- 1.13/fs/file_table.c	Sun Oct 13 08:39:40 2002
+++ edited/fs/file_table.c	Wed Oct 16 00:04:27 2002
@@ -46,7 +46,7 @@
 		files_stat.nr_free_files--;
 	new_one:
 		memset(f, 0, sizeof(*f));
-		if (security_ops->file_alloc_security(f)) {
+		if (security_file_alloc(f)) {
 			list_add(&f->f_list, &free_list);
 			files_stat.nr_free_files++;
 			file_list_unlock();
@@ -127,7 +127,7 @@
 
 	if (file->f_op && file->f_op->release)
 		file->f_op->release(inode, file);
-	security_ops->file_free_security(file);
+	security_file_free(file);
 	fops_put(file->f_op);
 	if (file->f_mode & FMODE_WRITE)
 		put_write_access(inode);
@@ -160,7 +160,7 @@
 void put_filp(struct file *file)
 {
 	if(atomic_dec_and_test(&file->f_count)) {
-		security_ops->file_free_security(file);
+		security_file_free(file);
 		file_list_lock();
 		list_del(&file->f_list);
 		list_add(&file->f_list, &free_list);
===== fs/inode.c 1.74 vs edited =====
--- 1.74/fs/inode.c	Sun Oct 13 08:39:23 2002
+++ edited/fs/inode.c	Tue Oct 15 23:49:49 2002
@@ -120,7 +120,7 @@
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
 		inode->i_security = NULL;
-		if (security_ops->inode_alloc_security(inode)) {
+		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
 				inode->i_sb->s_op->destroy_inode(inode);
 			else
@@ -146,7 +146,7 @@
 {
 	if (inode_has_buffers(inode))
 		BUG();
-	security_ops->inode_free_security(inode);
+	security_inode_free(inode);
 	if (inode->i_sb->s_op->destroy_inode) {
 		inode->i_sb->s_op->destroy_inode(inode);
 	} else {
@@ -922,7 +922,7 @@
 	if (inode->i_data.nrpages)
 		truncate_inode_pages(&inode->i_data, 0);
 
-	security_ops->inode_delete(inode);
+	security_inode_delete(inode);
 
 	if (op && op->delete_inode) {
 		void (*delete)(struct inode *) = op->delete_inode;
===== fs/ioctl.c 1.5 vs edited =====
--- 1.5/fs/ioctl.c	Mon Jul 22 03:12:48 2002
+++ edited/fs/ioctl.c	Wed Oct 16 00:06:16 2002
@@ -59,8 +59,7 @@
 		goto out;
 	error = 0;
 
-	error = security_ops->file_ioctl(filp, cmd, arg);
-        if (error) {
+	if ((error = security_file_ioctl(filp, cmd, arg))) {
                 fput(filp);
                 goto out;
         }
===== fs/locks.c 1.30 vs edited =====
--- 1.30/fs/locks.c	Thu Sep 26 10:36:16 2002
+++ edited/fs/locks.c	Wed Oct 16 00:06:00 2002
@@ -122,6 +122,7 @@
 #include <linux/timer.h>
 #include <linux/time.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 
 #include <asm/semaphore.h>
 #include <asm/uaccess.h>
@@ -1170,8 +1171,7 @@
 		return -EACCES;
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
-	error = security_ops->file_lock(filp, arg);
-	if (error)
+	if ((error = security_file_lock(filp, arg)))
 		return error;
 
 	lock_kernel();
@@ -1284,8 +1284,7 @@
 	if (error)
 		goto out_putf;
 
-	error = security_ops->file_lock(filp, cmd);
-	if (error)
+	if ((error = security_file_lock(filp, cmd)))
 		goto out_free;
 
 	for (;;) {
@@ -1434,8 +1433,7 @@
 		goto out;
 	}
 
-	error = security_ops->file_lock(filp, file_lock->fl_type);
-	if (error)
+	if ((error = security_file_lock(filp, file_lock->fl_type)))
 		goto out;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
@@ -1574,8 +1572,7 @@
 		goto out;
 	}
 
-	error = security_ops->file_lock(filp, file_lock->fl_type);
-	if (error)
+	if ((error = security_file_lock(filp, file_lock->fl_type)))
 		goto out;
 
 	if (filp->f_op && filp->f_op->lock != NULL) {
===== fs/namei.c 1.56 vs edited =====
--- 1.56/fs/namei.c	Tue Sep 17 12:52:27 2002
+++ edited/fs/namei.c	Tue Oct 15 23:47:28 2002
@@ -218,7 +218,7 @@
 	if (retval)
 		return retval;
 
-	return security_ops->inode_permission(inode, mask);
+	return security_inode_permission(inode, mask);
 }
 
 /*
@@ -340,7 +340,7 @@
 
 	return -EACCES;
 ok:
-	return security_ops->inode_permission_lite(inode, MAY_EXEC);
+	return security_inode_permission_lite(inode, MAY_EXEC);
 }
 
 /*
@@ -374,7 +374,7 @@
 				dput(dentry);
 			else {
 				result = dentry;
-				security_ops->inode_post_lookup(dir, result);
+				security_inode_post_lookup(dir, result);
 			}
 		}
 		up(&dir->i_sem);
@@ -413,8 +413,7 @@
 		current->state = TASK_RUNNING;
 		schedule();
 	}
-	err = security_ops->inode_follow_link(dentry, nd);
-	if (err)
+	if ((err = security_inode_follow_link(dentry, nd)))
 		goto loop;
 	current->link_count++;
 	current->total_link_count++;
@@ -918,7 +917,7 @@
 		dentry = inode->i_op->lookup(inode, new);
 		if (!dentry) {
 			dentry = new;
-			security_ops->inode_post_lookup(inode, dentry);
+			security_inode_post_lookup(inode, dentry);
 		} else
 			dput(new);
 	}
@@ -1125,14 +1124,13 @@
 		return -EACCES;	/* shouldn't it be ENOSYS? */
 	mode &= S_IALLUGO;
 	mode |= S_IFREG;
-	error = security_ops->inode_create(dir, dentry, mode);
-	if (error)
+	if ((error = security_inode_create(dir, dentry, mode)))
 		return error;
 	DQUOT_INIT(dir);
 	error = dir->i_op->create(dir, dentry, mode);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_create(dir, dentry, mode);
+		security_inode_post_create(dir, dentry, mode);
 	}
 	return error;
 }
@@ -1344,8 +1342,7 @@
 	 * stored in nd->last.name and we will have to putname() it when we
 	 * are done. Procfs-like symlinks just set LAST_BIND.
 	 */
-	error = security_ops->inode_follow_link(dentry, nd);
-	if (error)
+	if ((error = security_inode_follow_link(dentry, nd)))
 		goto exit_dput;
 	UPDATE_ATIME(dentry->d_inode);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
@@ -1410,15 +1407,14 @@
 	if (!dir->i_op || !dir->i_op->mknod)
 		return -EPERM;
 
-	error = security_ops->inode_mknod(dir, dentry, mode, dev);
-	if (error)
+	if ((error = security_inode_mknod(dir, dentry, mode, dev)))
 		return error;
 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mknod(dir, dentry, mode, dev);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_mknod(dir, dentry, mode, dev);
+		security_inode_post_mknod(dir, dentry, mode, dev);
 	}
 	return error;
 }
@@ -1478,15 +1474,14 @@
 		return -EPERM;
 
 	mode &= (S_IRWXUGO|S_ISVTX);
-	error = security_ops->inode_mkdir(dir, dentry, mode);
-	if (error)
+	if ((error = security_inode_mkdir(dir, dentry, mode)))
 		return error;
 
 	DQUOT_INIT(dir);
 	error = dir->i_op->mkdir(dir, dentry, mode);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_mkdir(dir,dentry, mode);
+		security_inode_post_mkdir(dir,dentry, mode);
 	}
 	return error;
 }
@@ -1570,8 +1565,7 @@
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		error = security_ops->inode_rmdir(dir, dentry);
-		if (!error) {
+		if (!(error = security_inode_rmdir(dir, dentry))) {
 			error = dir->i_op->rmdir(dir, dentry);
 			if (!error)
 				dentry->d_inode->i_flags |= S_DEAD;
@@ -1644,10 +1638,8 @@
 	if (d_mountpoint(dentry))
 		error = -EBUSY;
 	else {
-		error = security_ops->inode_unlink(dir, dentry);
-		if (!error) {
+		if (!(error = security_inode_unlink(dir, dentry)))
 			error = dir->i_op->unlink(dir, dentry);
-		}
 	}
 	up(&dentry->d_inode->i_sem);
 	if (!error) {
@@ -1709,15 +1701,14 @@
 	if (!dir->i_op || !dir->i_op->symlink)
 		return -EPERM;
 
-	error = security_ops->inode_symlink(dir, dentry, oldname);
-	if (error)
+	if ((error = security_inode_symlink(dir, dentry, oldname)))
 		return error;
 
 	DQUOT_INIT(dir);
 	error = dir->i_op->symlink(dir, dentry, oldname);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_symlink(dir, dentry, oldname);
+		security_inode_post_symlink(dir, dentry, oldname);
 	}
 	return error;
 }
@@ -1780,8 +1771,7 @@
 	if (S_ISDIR(old_dentry->d_inode->i_mode))
 		return -EPERM;
 
-	error = security_ops->inode_link(old_dentry, dir, new_dentry);
-	if (error)
+	if ((error = security_inode_link(old_dentry, dir, new_dentry)))
 		return error;
 
 	down(&old_dentry->d_inode->i_sem);
@@ -1790,7 +1780,7 @@
 	up(&old_dentry->d_inode->i_sem);
 	if (!error) {
 		inode_dir_notify(dir, DN_CREATE);
-		security_ops->inode_post_link(old_dentry, dir, new_dentry);
+		security_inode_post_link(old_dentry, dir, new_dentry);
 	}
 	return error;
 }
@@ -1889,8 +1879,7 @@
 			return error;
 	}
 
-	error = security_ops->inode_rename(old_dir, old_dentry, new_dir, new_dentry);
-	if (error)
+	if ((error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry)))
 		return error;
 
 	target = new_dentry->d_inode;
@@ -1912,8 +1901,8 @@
 	}
 	if (!error) {
 		d_move(old_dentry,new_dentry);
-		security_ops->inode_post_rename(old_dir, old_dentry,
-							new_dir, new_dentry);
+		security_inode_post_rename(old_dir, old_dentry,
+					   new_dir, new_dentry);
 	}
 	return error;
 }
@@ -1924,8 +1913,7 @@
 	struct inode *target;
 	int error;
 
-	error = security_ops->inode_rename(old_dir, old_dentry, new_dir, new_dentry);
-	if (error)
+	if ((error = security_inode_rename(old_dir, old_dentry, new_dir, new_dentry)))
 		return error;
 
 	dget(new_dentry);
@@ -1940,7 +1928,7 @@
 		/* The following d_move() should become unconditional */
 		if (!(old_dir->i_sb->s_type->fs_flags & FS_ODD_RENAME))
 			d_move(old_dentry, new_dentry);
-		security_ops->inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
+		security_inode_post_rename(old_dir, old_dentry, new_dir, new_dentry);
 	}
 	if (target)
 		up(&target->i_sem);
===== fs/namespace.c 1.29 vs edited =====
--- 1.29/fs/namespace.c	Tue Sep 17 12:52:27 2002
+++ edited/fs/namespace.c	Tue Oct 15 23:17:32 2002
@@ -19,6 +19,7 @@
 #include <linux/seq_file.h>
 #include <linux/namespace.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -288,8 +289,7 @@
 	struct super_block * sb = mnt->mnt_sb;
 	int retval = 0;
 
-	retval = security_ops->sb_umount(mnt, flags);
-	if (retval)
+	if ((retval = security_sb_umount(mnt, flags)))
 		return retval;
 
 	/*
@@ -341,7 +341,7 @@
 		DQUOT_OFF(sb);
 		acct_auto_close(sb);
 		unlock_kernel();
-		security_ops->sb_umount_close(mnt);
+		security_sb_umount_close(mnt);
 		spin_lock(&dcache_lock);
 	}
 	retval = -EBUSY;
@@ -352,7 +352,7 @@
 	}
 	spin_unlock(&dcache_lock);
 	if (retval)
-		security_ops->sb_umount_busy(mnt);
+		security_sb_umount_busy(mnt);
 	up_write(&current->namespace->sem);
 	return retval;
 }
@@ -470,8 +470,7 @@
 	if (IS_DEADDIR(nd->dentry->d_inode))
 		goto out_unlock;
 
-	err = security_ops->sb_check_sb(mnt, nd);
-	if (err)
+	if ((err = security_sb_check_sb(mnt, nd)))
 		goto out_unlock;
 
 	spin_lock(&dcache_lock);
@@ -487,7 +486,7 @@
 out_unlock:
 	up(&nd->dentry->d_inode->i_sem);
 	if (!err)
-		security_ops->sb_post_addmount(mnt, nd);
+		security_sb_post_addmount(mnt, nd);
 	return err;
 }
 
@@ -558,7 +557,7 @@
 		nd->mnt->mnt_flags=mnt_flags;
 	up_write(&sb->s_umount);
 	if (!err)
-		security_ops->sb_post_remount(nd->mnt, flags, data);
+		security_sb_post_remount(nd->mnt, flags, data);
 	return err;
 }
 
@@ -741,8 +740,7 @@
 	if (retval)
 		return retval;
 
-	retval = security_ops->sb_mount(dev_name, &nd, type_page, flags, data_page);
-	if (retval)
+	if ((retval = security_sb_mount(dev_name, &nd, type_page, flags, data_page)))
 		goto dput_out;
 
 	if (flags & MS_REMOUNT)
@@ -939,8 +937,7 @@
 	if (error)
 		goto out1;
 
-	error = security_ops->sb_pivotroot(&old_nd, &new_nd);
-	if (error) {
+	if ((error = security_sb_pivotroot(&old_nd, &new_nd))) {
 		path_release(&old_nd);
 		goto out1;
 	}
@@ -989,7 +986,7 @@
 	attach_mnt(new_nd.mnt, &root_parent);
 	spin_unlock(&dcache_lock);
 	chroot_fs_refs(&user_nd, &new_nd);
-	security_ops->sb_post_pivotroot(&user_nd, &new_nd);
+	security_sb_post_pivotroot(&user_nd, &new_nd);
 	error = 0;
 	path_release(&root_parent);
 	path_release(&parent_nd);
===== fs/open.c 1.28 vs edited =====
--- 1.28/fs/open.c	Sun Oct 13 08:39:40 2002
+++ edited/fs/open.c	Tue Oct 15 23:19:46 2002
@@ -30,8 +30,7 @@
 		retval = -ENOSYS;
 		if (sb->s_op && sb->s_op->statfs) {
 			memset(buf, 0, sizeof(struct statfs));
-			retval = security_ops->sb_statfs(sb);
-			if (retval)
+			if ((retval = security_sb_statfs(sb)))
 				return retval;
 			retval = sb->s_op->statfs(sb, buf);
 		}
===== fs/quota.c 1.8 vs edited =====
--- 1.8/fs/quota.c	Mon Jul 22 03:12:48 2002
+++ edited/fs/quota.c	Tue Oct 15 22:54:46 2002
@@ -98,7 +98,7 @@
 		if (!capable(CAP_SYS_ADMIN))
 			return -EPERM;
 
-	return security_ops->quotactl (cmd, type, id, sb);
+	return security_quotactl (cmd, type, id, sb);
 }
 
 /* Resolve device pathname to superblock */
===== fs/read_write.c 1.19 vs edited =====
--- 1.19/fs/read_write.c	Thu Oct 10 14:36:26 2002
+++ edited/fs/read_write.c	Wed Oct 16 00:08:14 2002
@@ -121,8 +121,7 @@
 	if (!file)
 		goto bad;
 
-	retval = security_ops->file_llseek(file);
-	if (retval) {
+	if ((retval = security_file_llseek(file))) {
 		fput(file);
 		goto bad;
 	}
@@ -153,8 +152,7 @@
 	if (!file)
 		goto bad;
 
-	retval = security_ops->file_llseek(file);
-	if (retval)
+	if ((retval = security_file_llseek(file)))
 		goto out_putf;
 
 	retval = -EINVAL;
@@ -203,8 +201,7 @@
 
 	ret = locks_verify_area(FLOCK_VERIFY_READ, inode, file, *pos, count);
 	if (!ret) {
-		ret = security_ops->file_permission (file, MAY_READ);
-		if (!ret) {
+		if (!(ret = security_file_permission (file, MAY_READ))) {
 			if (file->f_op->read)
 				ret = file->f_op->read(file, buf, count, pos);
 			else
@@ -243,8 +240,7 @@
 
 	ret = locks_verify_area(FLOCK_VERIFY_WRITE, inode, file, *pos, count);
 	if (!ret) {
-		ret = security_ops->file_permission (file, MAY_WRITE);
-		if (!ret) {
+		if (!(ret = security_file_permission (file, MAY_WRITE))) {
 			if (file->f_op->write)
 				ret = file->f_op->write(file, buf, count, pos);
 			else
@@ -475,8 +471,7 @@
 		goto bad_file;
 	if (file->f_op && (file->f_mode & FMODE_READ) &&
 	    (file->f_op->readv || file->f_op->read)) {
-		ret = security_ops->file_permission (file, MAY_READ);
-		if (!ret)
+		if (!(ret = security_file_permission (file, MAY_READ)))
 			ret = do_readv_writev(READ, file, vector, nr_segs);
 	}
 	fput(file);
@@ -498,8 +493,7 @@
 		goto bad_file;
 	if (file->f_op && (file->f_mode & FMODE_WRITE) &&
 	    (file->f_op->writev || file->f_op->write)) {
-		ret = security_ops->file_permission (file, MAY_WRITE);
-		if (!ret)
+		if (!(ret = security_file_permission (file, MAY_WRITE)))
 			ret = do_readv_writev(WRITE, file, vector, nr_segs);
 	}
 	fput(file);
===== fs/readdir.c 1.9 vs edited =====
--- 1.9/fs/readdir.c	Mon Jul 22 03:12:48 2002
+++ edited/fs/readdir.c	Wed Oct 16 00:06:40 2002
@@ -11,6 +11,7 @@
 #include <linux/file.h>
 #include <linux/smp_lock.h>
 #include <linux/fs.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -21,8 +22,7 @@
 	if (!file->f_op || !file->f_op->readdir)
 		goto out;
 
-	res = security_ops->file_permission(file, MAY_READ);
-	if (res)
+	if ((res = security_file_permission(file, MAY_READ)))
 		goto out;
 
 	down(&inode->i_sem);
===== fs/stat.c 1.13 vs edited =====
--- 1.13/fs/stat.c	Mon Jul 22 03:12:48 2002
+++ edited/fs/stat.c	Tue Oct 15 23:49:19 2002
@@ -39,8 +39,7 @@
 	struct inode *inode = dentry->d_inode;
 	int retval;
 
-	retval = security_ops->inode_getattr(mnt, dentry);
-	if (retval)
+	if ((retval = security_inode_getattr(mnt, dentry)))
 		return retval;
 
 	if (inode->i_op->getattr)
@@ -238,8 +237,7 @@
 
 		error = -EINVAL;
 		if (inode->i_op && inode->i_op->readlink) {
-			error = security_ops->inode_readlink(nd.dentry);
-			if (!error) {
+			if (!(error = security_inode_readlink(nd.dentry))) {
 				UPDATE_ATIME(inode);
 				error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
 			}
===== fs/super.c 1.83 vs edited =====
--- 1.83/fs/super.c	Mon Sep  9 14:00:57 2002
+++ edited/fs/super.c	Tue Oct 15 23:18:44 2002
@@ -29,9 +29,9 @@
 #include <linux/quotaops.h>
 #include <linux/namei.h>
 #include <linux/buffer_head.h>		/* for fsync_super() */
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
-#include <linux/security.h>
 
 void get_filesystem(struct file_system_type *fs);
 void put_filesystem(struct file_system_type *fs);
@@ -51,7 +51,7 @@
 	struct super_block *s = kmalloc(sizeof(struct super_block),  GFP_USER);
 	if (s) {
 		memset(s, 0, sizeof(struct super_block));
-		if (security_ops->sb_alloc_security(s)) {
+		if (security_sb_alloc(s)) {
 			kfree(s);
 			s = NULL;
 			goto out;
@@ -85,7 +85,7 @@
  */
 static inline void destroy_super(struct super_block *s)
 {
-	security_ops->sb_free_security(s);
+	security_sb_free(s);
 	kfree(s);
 }
 
===== fs/xattr.c 1.7 vs edited =====
--- 1.7/fs/xattr.c	Mon Jul 22 03:12:48 2002
+++ edited/fs/xattr.c	Tue Oct 15 23:51:34 2002
@@ -13,6 +13,7 @@
 #include <linux/file.h>
 #include <linux/xattr.h>
 #include <linux/namei.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 /*
@@ -85,9 +86,7 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->setxattr) {
-		error = security_ops->inode_setxattr(d, kname, kvalue,
-				size, flags);
-		if (error)
+		if ((error = security_inode_setxattr(d, kname, kvalue, size, flags)))
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->setxattr(d, kname, kvalue, size, flags);
@@ -163,8 +162,7 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->getxattr) {
-		error = security_ops->inode_getxattr(d, kname);
-		if (error)
+		if ((error = security_inode_getxattr(d, kname)))
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->getxattr(d, kname, kvalue, size);
@@ -236,8 +234,7 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->listxattr) {
-		error = security_ops->inode_listxattr(d);
-		if (error)
+		if ((error = security_inode_listxattr(d)))
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->listxattr(d, klist, size);
@@ -311,8 +308,7 @@
 
 	error = -EOPNOTSUPP;
 	if (d->d_inode->i_op && d->d_inode->i_op->removexattr) {
-		error = security_ops->inode_removexattr(d, kname);
-		if (error)
+		if ((error = security_inode_removexattr(d, kname)))
 			goto out;
 		down(&d->d_inode->i_sem);
 		error = d->d_inode->i_op->removexattr(d, kname);
===== fs/proc/base.c 1.31 vs edited =====
--- 1.31/fs/proc/base.c	Sat Sep 28 08:36:29 2002
+++ edited/fs/proc/base.c	Tue Oct 15 23:22:02 2002
@@ -28,6 +28,7 @@
 #include <linux/namespace.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
+#include <linux/security.h>
 
 /*
  * For hysterical raisins we keep the same inumbers as in the old procfs.
@@ -394,7 +395,7 @@
 };
 
 #define MAY_PTRACE(p) \
-(p==current||(p->parent==current&&(p->ptrace & PT_PTRACED)&&p->state==TASK_STOPPED&&security_ops->ptrace(current,p)==0))
+(p==current||(p->parent==current&&(p->ptrace & PT_PTRACED)&&p->state==TASK_STOPPED&&security_ptrace(current,p)==0))
 
 
 static int mem_open(struct inode* inode, struct file* file)
===== include/linux/sched.h 1.107 vs edited =====
--- 1.107/include/linux/sched.h	Tue Oct 15 15:32:40 2002
+++ edited/include/linux/sched.h	Tue Oct 15 22:24:46 2002
@@ -596,9 +596,11 @@
 		       unsigned long, const char *, void *);
 extern void free_irq(unsigned int, void *);
 
+
+#ifdef CONFIG_SECURITY
 /* capable prototype and code moved to security.[hc] */
 #include <linux/security.h>
-#if 0
+#else
 static inline int capable(int cap)
 {
 	if (cap_raised(current->cap_effective, cap)) {
@@ -607,7 +609,7 @@
 	}
 	return 0;
 }
-#endif	/* if 0 */
+#endif
 
 /*
  * Routines for handling mm_structs
===== include/linux/security.h 1.4 vs edited =====
--- 1.4/include/linux/security.h	Tue Oct  8 02:20:18 2002
+++ edited/include/linux/security.h	Wed Oct 16 10:44:28 2002
@@ -22,8 +22,6 @@
 #ifndef __LINUX_SECURITY_H
 #define __LINUX_SECURITY_H
 
-#ifdef __KERNEL__
-
 #include <linux/fs.h>
 #include <linux/binfmts.h>
 #include <linux/signal.h>
@@ -33,6 +31,20 @@
 #include <linux/shm.h>
 #include <linux/msg.h>
 
+
+/* These functions are in security/capability.c and are used
+ * as the default capabilities functions */
+extern int cap_capable (struct task_struct *tsk, int cap);
+extern int cap_ptrace (struct task_struct *parent, struct task_struct *child);
+extern int cap_capget (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern int cap_capset_check (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern void cap_capset_set (struct task_struct *target, kernel_cap_t *effective, kernel_cap_t *inheritable, kernel_cap_t *permitted);
+extern int cap_bprm_set_security (struct linux_binprm *bprm);
+extern void cap_bprm_compute_creds (struct linux_binprm *bprm);
+extern int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid, int flags);
+extern void cap_task_kmod_set_label (void);
+extern void cap_task_reparent_to_init (struct task_struct *p);
+
 /*
  * Values used in the task_security_ops calls
  */
@@ -48,6 +60,9 @@
 /* setfsuid or setfsgid, id0 == fsuid or fsgid */
 #define LSM_SETID_FS	8
 
+
+#ifdef CONFIG_SECURITY
+
 /* forward declares to avoid warnings */
 struct sk_buff;
 struct net_device;
@@ -848,6 +863,531 @@
 	                            struct security_operations *ops);
 };
 
+/* global variables */
+extern struct security_operations *security_ops;
+
+/* inline stuff */
+static inline int security_ptrace (struct task_struct * parent, struct task_struct * child)
+{
+	return security_ops->ptrace (parent, child);
+}
+
+static inline int security_capget (struct task_struct *target,
+				   kernel_cap_t *effective,
+				   kernel_cap_t *inheritable,
+				   kernel_cap_t *permitted)
+{
+	return security_ops->capget (target, effective, inheritable, permitted);
+}
+
+static inline int security_capset_check (struct task_struct *target,
+					 kernel_cap_t *effective,
+					 kernel_cap_t *inheritable,
+					 kernel_cap_t *permitted)
+{
+	return security_ops->capset_check (target, effective, inheritable, permitted);
+}
+
+static inline void security_capset_set (struct task_struct *target,
+					kernel_cap_t *effective,
+					kernel_cap_t *inheritable,
+					kernel_cap_t *permitted)
+{
+	security_ops->capset_set (target, effective, inheritable, permitted);
+}
+
+static inline int security_acct (struct file *file)
+{
+	return security_ops->acct (file);
+}
+
+static inline int security_quotactl (int cmds, int type, int id,
+				     struct super_block *sb)
+{
+	return security_ops->quotactl (cmds, type, id, sb);
+}
+
+static inline int security_quota_on (struct file * file)
+{
+	return security_ops->quota_on (file);
+}
+
+static inline int security_bprm_alloc (struct linux_binprm *bprm)
+{
+	return security_ops->bprm_alloc_security (bprm);
+}
+static inline void security_bprm_free (struct linux_binprm *bprm)
+{
+	security_ops->bprm_free_security (bprm);
+}
+static inline void security_bprm_compute_creds (struct linux_binprm *bprm)
+{
+	security_ops->bprm_compute_creds (bprm);
+}
+static inline int security_bprm_set (struct linux_binprm *bprm)
+{
+	return security_ops->bprm_set_security (bprm);
+}
+static inline int security_bprm_check (struct linux_binprm *bprm)
+{
+	return security_ops->bprm_check_security (bprm);
+}
+
+static inline int security_sb_alloc (struct super_block *sb)
+{
+	return security_ops->sb_alloc_security (sb);
+}
+
+static inline void security_sb_free (struct super_block *sb)
+{
+	security_ops->sb_free_security (sb);
+}
+
+static inline int security_sb_statfs (struct super_block *sb)
+{
+	return security_ops->sb_statfs (sb);
+}
+
+static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
+				    char *type, unsigned long flags,
+				    void *data)
+{
+	return security_ops->sb_mount (dev_name, nd, type, flags, data);
+}
+
+static inline int security_sb_check_sb (struct vfsmount *mnt,
+					struct nameidata *nd)
+{
+	return security_ops->sb_check_sb (mnt, nd);
+}
+
+static inline int security_sb_umount (struct vfsmount *mnt, int flags)
+{
+	return security_ops->sb_umount (mnt, flags);
+}
+
+static inline void security_sb_umount_close (struct vfsmount *mnt)
+{
+	security_ops->sb_umount_close (mnt);
+}
+
+static inline void security_sb_umount_busy (struct vfsmount *mnt)
+{
+	security_ops->sb_umount_busy (mnt);
+}
+
+static inline void security_sb_post_remount (struct vfsmount *mnt,
+					     unsigned long flags, void *data)
+{
+	security_ops->sb_post_remount (mnt, flags, data);
+}
+
+static inline void security_sb_post_mountroot (void)
+{
+	security_ops->sb_post_mountroot ();
+}
+
+static inline void security_sb_post_addmount (struct vfsmount *mnt,
+					      struct nameidata *mountpoint_nd)
+{
+	security_ops->sb_post_addmount (mnt, mountpoint_nd);
+}
+
+static inline int security_sb_pivotroot (struct nameidata *old_nd,
+					 struct nameidata *new_nd)
+{
+	return security_ops->sb_pivotroot (old_nd, new_nd);
+}
+
+static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
+					       struct nameidata *new_nd)
+{
+	security_ops->sb_post_pivotroot (old_nd, new_nd);
+}
+
+static inline int security_inode_alloc (struct inode *inode)
+{
+	return security_ops->inode_alloc_security (inode);
+}
+
+static inline void security_inode_free (struct inode *inode)
+{
+	security_ops->inode_free_security (inode);
+}
+	
+static inline int security_inode_create (struct inode *dir,
+					 struct dentry *dentry,
+					 int mode)
+{
+	return security_ops->inode_create (dir, dentry, mode);
+}
+
+static inline void security_inode_post_create (struct inode *dir,
+					       struct dentry *dentry,
+					       int mode)
+{
+	security_ops->inode_post_create (dir, dentry, mode);
+}
+
+static inline int security_inode_link (struct dentry *old_dentry,
+				       struct inode *dir,
+				       struct dentry *new_dentry)
+{
+	return security_ops->inode_link (old_dentry, dir, new_dentry);
+}
+
+static inline void security_inode_post_link (struct dentry *old_dentry,
+					     struct inode *dir,
+					     struct dentry *new_dentry)
+{
+	security_ops->inode_post_link (old_dentry, dir, new_dentry);
+}
+
+static inline int security_inode_unlink (struct inode *dir,
+					 struct dentry *dentry)
+{
+	return security_ops->inode_unlink (dir, dentry);
+}
+
+static inline int security_inode_symlink (struct inode *dir,
+					  struct dentry *dentry,
+					  const char *old_name)
+{
+	return security_ops->inode_symlink (dir, dentry, old_name);
+}
+
+static inline void security_inode_post_symlink (struct inode *dir,
+						struct dentry *dentry,
+						const char *old_name)
+{
+	security_ops->inode_post_symlink (dir, dentry, old_name);
+}
+
+static inline int security_inode_mkdir (struct inode *dir,
+					struct dentry *dentry,
+					int mode)
+{
+	return security_ops->inode_mkdir (dir, dentry, mode);
+}
+
+static inline void security_inode_post_mkdir (struct inode *dir,
+					      struct dentry *dentry,
+					      int mode)
+{
+	security_ops->inode_post_mkdir (dir, dentry, mode);
+}
+
+static inline int security_inode_rmdir (struct inode *dir,
+					struct dentry *dentry)
+{
+	return security_ops->inode_rmdir (dir, dentry);
+}
+
+static inline int security_inode_mknod (struct inode *dir,
+					struct dentry *dentry,
+					int mode, dev_t dev)
+{
+	return security_ops->inode_mknod (dir, dentry, mode, dev);
+}
+
+static inline void security_inode_post_mknod (struct inode *dir,
+					      struct dentry *dentry,
+					      int mode, dev_t dev)
+{
+	security_ops->inode_post_mknod (dir, dentry, mode, dev);
+}
+
+static inline int security_inode_rename (struct inode *old_dir,
+					 struct dentry *old_dentry,
+					 struct inode *new_dir,
+					 struct dentry *new_dentry)
+{
+	return security_ops->inode_rename (old_dir, old_dentry,
+					   new_dir, new_dentry);
+}
+
+static inline void security_inode_post_rename (struct inode *old_dir,
+					       struct dentry *old_dentry,
+					       struct inode *new_dir,
+					       struct dentry *new_dentry)
+{
+	security_ops->inode_post_rename (old_dir, old_dentry,
+						new_dir, new_dentry);
+}
+
+static inline int security_inode_readlink (struct dentry *dentry)
+{
+	return security_ops->inode_readlink (dentry);
+}
+
+static inline int security_inode_follow_link (struct dentry *dentry,
+					      struct nameidata *nd)
+{
+	return security_ops->inode_follow_link (dentry, nd);
+}
+
+static inline int security_inode_permission (struct inode *inode, int mask)
+{
+	return security_ops->inode_permission (inode, mask);
+}
+
+static inline int security_inode_permission_lite (struct inode *inode,
+						  int mask)
+{
+	return security_ops->inode_permission_lite (inode, mask);
+}
+
+static inline int security_inode_setattr (struct dentry *dentry,
+					  struct iattr *attr)
+{
+	return security_ops->inode_setattr (dentry, attr);
+}
+
+static inline int security_inode_getattr (struct vfsmount *mnt,
+					  struct dentry *dentry)
+{
+	return security_ops->inode_getattr (mnt, dentry);
+}
+
+static inline void security_inode_post_lookup (struct inode *inode,
+					       struct dentry *dentry)
+{
+	security_ops->inode_post_lookup (inode, dentry);
+}
+
+static inline void security_inode_delete (struct inode *inode)
+{
+	security_ops->inode_delete (inode);
+}
+
+static inline int security_inode_setxattr (struct dentry *dentry, char *name,
+					   void *value, size_t size, int flags)
+{
+	return security_ops->inode_setxattr (dentry, name, value, size, flags);
+}
+
+static inline int security_inode_getxattr (struct dentry *dentry, char *name)
+{
+	return security_ops->inode_getxattr (dentry, name);
+}
+
+static inline int security_inode_listxattr (struct dentry *dentry)
+{
+	return security_ops->inode_listxattr (dentry);
+}
+
+static inline int security_inode_removexattr (struct dentry *dentry, char *name)
+{
+	return security_ops->inode_removexattr (dentry, name);
+}
+
+static inline int security_file_permission (struct file *file, int mask)
+{
+	return security_ops->file_permission (file, mask);
+}
+
+static inline int security_file_alloc (struct file *file)
+{
+	return security_ops->file_alloc_security (file);
+}
+
+static inline void security_file_free (struct file *file)
+{
+	security_ops->file_free_security (file);
+}
+
+static inline int security_file_llseek (struct file *file)
+{
+	return security_ops->file_llseek (file);
+}
+
+static inline int security_file_ioctl (struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return security_ops->file_ioctl (file, cmd, arg);
+}
+
+static inline int security_file_mmap (struct file *file, unsigned long prot,
+				      unsigned long flags)
+{
+	return security_ops->file_mmap (file, prot, flags);
+}
+
+static inline int security_file_mprotect (struct vm_area_struct *vma,
+					  unsigned long prot)
+{
+	return security_ops->file_mprotect (vma, prot);
+}
+
+static inline int security_file_lock (struct file *file, unsigned int cmd)
+{
+	return security_ops->file_lock (file, cmd);
+}
+
+static inline int security_file_fcntl (struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return security_ops->file_fcntl (file, cmd, arg);
+}
+
+static inline int security_file_set_fowner (struct file *file)
+{
+	return security_ops->file_set_fowner (file);
+}
+
+static inline int security_file_send_sigiotask (struct task_struct *tsk,
+						struct fown_struct *fown,
+						int fd, int reason)
+{
+	return security_ops->file_send_sigiotask (tsk, fown, fd, reason);
+}
+
+static inline int security_file_receive (struct file *file)
+{
+	return security_ops->file_receive (file);
+}
+
+static inline int security_task_create (unsigned long clone_flags)
+{
+	return security_ops->task_create (clone_flags);
+}
+
+static inline int security_task_alloc (struct task_struct *p)
+{
+	return security_ops->task_alloc_security (p);
+}
+
+static inline void security_task_free (struct task_struct *p)
+{
+	security_ops->task_free_security (p);
+}
+
+static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
+					int flags)
+{
+	return security_ops->task_setuid (id0, id1, id2, flags);
+}
+
+static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_euid,
+					     uid_t old_suid, int flags)
+{
+	return security_ops->task_post_setuid (old_ruid, old_euid, old_suid, flags);
+}
+
+static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
+					int flags)
+{
+	return security_ops->task_setgid (id0, id1, id2, flags);
+}
+
+static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
+{
+	return security_ops->task_setpgid (p, pgid);
+}
+
+static inline int security_task_getpgid (struct task_struct *p)
+{
+	return security_ops->task_getpgid (p);
+}
+
+static inline int security_task_getsid (struct task_struct *p)
+{
+	return security_ops->task_getsid (p);
+}
+
+static inline int security_task_setgroups (int gidsetsize, gid_t *grouplist)
+{
+	return security_ops->task_setgroups (gidsetsize, grouplist);
+}
+
+static inline int security_task_setnice (struct task_struct *p, int nice)
+{
+	return security_ops->task_setnice (p, nice);
+}
+
+static inline int security_task_setrlimit (unsigned int resource,
+					   struct rlimit *new_rlim)
+{
+	return security_ops->task_setrlimit (resource, new_rlim);
+}
+
+static inline int security_task_setscheduler (struct task_struct *p,
+					      int policy,
+					      struct sched_param *lp)
+{
+	return security_ops->task_setscheduler (p, policy, lp);
+}
+
+static inline int security_task_getscheduler (struct task_struct *p)
+{
+	return security_ops->task_getscheduler (p);
+}
+
+static inline int security_task_kill (struct task_struct *p,
+				      struct siginfo *info, int sig)
+{
+	return security_ops->task_kill (p, info, sig);
+}
+
+static inline int security_task_wait (struct task_struct *p)
+{
+	return security_ops->task_wait (p);
+}
+
+static inline int security_task_prctl (int option, unsigned long arg2,
+				       unsigned long arg3,
+				       unsigned long arg4,
+				       unsigned long arg5)
+{
+	return security_ops->task_prctl (option, arg2, arg3, arg4, arg5);
+}
+
+static inline void security_task_kmod_set_label (void)
+{
+	security_ops->task_kmod_set_label ();
+}
+
+static inline void security_task_reparent_to_init (struct task_struct *p)
+{
+	security_ops->task_reparent_to_init (p);
+}
+
+static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
+					   short flag)
+{
+	return security_ops->ipc_permission (ipcp, flag);
+}
+
+static inline int security_msg_queue_alloc (struct msg_queue *msq)
+{
+	return security_ops->msg_queue_alloc_security (msq);
+}
+
+static inline void security_msg_queue_free (struct msg_queue *msq)
+{
+	security_ops->msg_queue_free_security (msq);
+}
+
+static inline int security_shm_alloc (struct shmid_kernel *shp)
+{
+	return security_ops->shm_alloc_security (shp);
+}
+
+static inline void security_shm_free (struct shmid_kernel *shp)
+{
+	security_ops->shm_free_security (shp);
+}
+
+static inline int security_sem_alloc (struct sem_array *sma)
+{
+	return security_ops->sem_alloc_security (sma);
+}
+
+static inline void security_sem_free (struct sem_array *sma)
+{
+	security_ops->sem_free_security (sma);
+}
+
 
 /* prototypes */
 extern int security_scaffolding_startup	(void);
@@ -857,11 +1397,501 @@
 extern int mod_unreg_security	(const char *name, struct security_operations *ops);
 extern int capable		(int cap);
 
-/* global variables */
-extern struct security_operations *security_ops;
 
+#else /* CONFIG_SECURITY */
+
+/*
+ * This is the default capabilities functionality.  Most of these functions
+ * are just stubbed out, but a few must call the proper capable code.
+ */
+
+static inline int security_scaffolding_startup (void)
+{
+	return 0;
+}
+
+static inline int security_ptrace (struct task_struct *parent, struct task_struct * child)
+{
+	return cap_ptrace (parent, child);
+}
+
+static inline int security_capget (struct task_struct *target,
+				   kernel_cap_t *effective,
+				   kernel_cap_t *inheritable,
+				   kernel_cap_t *permitted)
+{
+	return cap_capget (target, effective, inheritable, permitted);
+}
+
+static inline int security_capset_check (struct task_struct *target,
+					 kernel_cap_t *effective,
+					 kernel_cap_t *inheritable,
+					 kernel_cap_t *permitted)
+{
+	return cap_capset_check (target, effective, inheritable, permitted);
+}
+
+static inline void security_capset_set (struct task_struct *target,
+					kernel_cap_t *effective,
+					kernel_cap_t *inheritable,
+					kernel_cap_t *permitted)
+{
+	cap_capset_set (target, effective, inheritable, permitted);
+}
+
+static inline int security_acct (struct file *file)
+{
+	return 0;
+}
+
+static inline int security_quotactl (int cmds, int type, int id,
+				     struct super_block * sb)
+{
+	return 0;
+}
+
+static inline int security_quota_on (struct file * file)
+{
+	return 0;
+}
+
+static inline int security_bprm_alloc (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static inline void security_bprm_free (struct linux_binprm *bprm)
+{ }
+
+static inline void security_bprm_compute_creds (struct linux_binprm *bprm)
+{ 
+	cap_bprm_compute_creds (bprm);
+}
+
+static inline int security_bprm_set (struct linux_binprm *bprm)
+{
+	return cap_bprm_set_security (bprm);
+}
+
+static inline int security_bprm_check (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static inline int security_sb_alloc (struct super_block *sb)
+{
+	return 0;
+}
+
+static inline void security_sb_free (struct super_block *sb)
+{ }
+
+static inline int security_sb_statfs (struct super_block *sb)
+{
+	return 0;
+}
+
+static inline int security_sb_mount (char *dev_name, struct nameidata *nd,
+				    char *type, unsigned long flags,
+				    void *data)
+{
+	return 0;
+}
+
+static inline int security_sb_check_sb (struct vfsmount *mnt,
+					struct nameidata *nd)
+{
+	return 0;
+}
+
+static inline int security_sb_umount (struct vfsmount *mnt, int flags)
+{
+	return 0;
+}
+
+static inline void security_sb_umount_close (struct vfsmount *mnt)
+{ }
+
+static inline void security_sb_umount_busy (struct vfsmount *mnt)
+{ }
+
+static inline void security_sb_post_remount (struct vfsmount *mnt,
+					     unsigned long flags, void *data)
+{ }
+
+static inline void security_sb_post_mountroot (void)
+{ }
+
+static inline void security_sb_post_addmount (struct vfsmount *mnt,
+					      struct nameidata *mountpoint_nd)
+{ }
+
+static inline int security_sb_pivotroot (struct nameidata *old_nd,
+					 struct nameidata *new_nd)
+{
+	return 0;
+}
+
+static inline void security_sb_post_pivotroot (struct nameidata *old_nd,
+					       struct nameidata *new_nd)
+{ }
+
+static inline int security_inode_alloc (struct inode *inode)
+{
+	return 0;
+}
+
+static inline void security_inode_free (struct inode *inode)
+{ }
+	
+static inline int security_inode_create (struct inode *dir,
+					 struct dentry *dentry,
+					 int mode)
+{
+	return 0;
+}
+
+static inline void security_inode_post_create (struct inode *dir,
+					       struct dentry *dentry,
+					       int mode)
+{ }
+
+static inline int security_inode_link (struct dentry *old_dentry,
+				       struct inode *dir,
+				       struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static inline void security_inode_post_link (struct dentry *old_dentry,
+					     struct inode *dir,
+					     struct dentry *new_dentry)
+{ }
+
+static inline int security_inode_unlink (struct inode *dir,
+					 struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_inode_symlink (struct inode *dir,
+					  struct dentry *dentry,
+					  const char *old_name)
+{
+	return 0;
+}
+
+static inline void security_inode_post_symlink (struct inode *dir,
+						struct dentry *dentry,
+						const char *old_name)
+{ }
+
+static inline int security_inode_mkdir (struct inode *dir,
+					struct dentry *dentry,
+					int mode)
+{
+	return 0;
+}
+
+static inline void security_inode_post_mkdir (struct inode *dir,
+					      struct dentry *dentry,
+					      int mode)
+{ }
+
+static inline int security_inode_rmdir (struct inode *dir,
+					struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_inode_mknod (struct inode *dir,
+					struct dentry *dentry,
+					int mode, dev_t dev)
+{
+	return 0;
+}
+
+static inline void security_inode_post_mknod (struct inode *dir,
+					      struct dentry *dentry,
+					      int mode, dev_t dev)
+{ }
+
+static inline int security_inode_rename (struct inode *old_dir,
+					 struct dentry *old_dentry,
+					 struct inode *new_dir,
+					 struct dentry *new_dentry)
+{
+	return 0;
+}
+
+static inline void security_inode_post_rename (struct inode *old_dir,
+					       struct dentry *old_dentry,
+					       struct inode *new_dir,
+					       struct dentry *new_dentry)
+{ }
+
+static inline int security_inode_readlink (struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_inode_follow_link (struct dentry *dentry,
+					      struct nameidata *nd)
+{
+	return 0;
+}
+
+static inline int security_inode_permission (struct inode *inode, int mask)
+{
+	return 0;
+}
+
+static inline int security_inode_permission_lite (struct inode *inode,
+						  int mask)
+{
+	return 0;
+}
+
+static inline int security_inode_setattr (struct dentry *dentry,
+					  struct iattr *attr)
+{
+	return 0;
+}
+
+static inline int security_inode_getattr (struct vfsmount *mnt,
+					  struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline void security_inode_post_lookup (struct inode *inode,
+					       struct dentry *dentry)
+{ }
+
+static inline void security_inode_delete (struct inode *inode)
+{ }
+
+static inline int security_inode_setxattr (struct dentry *dentry, char *name,
+					   void *value, size_t size, int flags)
+{
+	return 0;
+}
+
+static inline int security_inode_getxattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static inline int security_inode_listxattr (struct dentry *dentry)
+{
+	return 0;
+}
+
+static inline int security_inode_removexattr (struct dentry *dentry, char *name)
+{
+	return 0;
+}
+
+static inline int security_file_permission (struct file *file, int mask)
+{
+	return 0;
+}
+
+static inline int security_file_alloc (struct file *file)
+{
+	return 0;
+}
+
+static inline void security_file_free (struct file *file)
+{ }
+
+static inline int security_file_llseek (struct file *file)
+{
+	return 0;
+}
+
+static inline int security_file_ioctl (struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return 0;
+}
+
+static inline int security_file_mmap (struct file *file, unsigned long prot,
+				      unsigned long flags)
+{
+	return 0;
+}
+
+static inline int security_file_mprotect (struct vm_area_struct *vma,
+					  unsigned long prot)
+{
+	return 0;
+}
+
+static inline int security_file_lock (struct file *file, unsigned int cmd)
+{
+	return 0;
+}
+
+static inline int security_file_fcntl (struct file *file, unsigned int cmd,
+				       unsigned long arg)
+{
+	return 0;
+}
+
+static inline int security_file_set_fowner (struct file *file)
+{
+	return 0;
+}
+
+static inline int security_file_send_sigiotask (struct task_struct *tsk,
+						struct fown_struct *fown,
+						int fd, int reason)
+{
+	return 0;
+}
+
+static inline int security_file_receive (struct file *file)
+{
+	return 0;
+}
+
+static inline int security_task_create (unsigned long clone_flags)
+{
+	return 0;
+}
+
+static inline int security_task_alloc (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline void security_task_free (struct task_struct *p)
+{ }
+
+static inline int security_task_setuid (uid_t id0, uid_t id1, uid_t id2,
+					int flags)
+{
+	return 0;
+}
+
+static inline int security_task_post_setuid (uid_t old_ruid, uid_t old_euid,
+					     uid_t old_suid, int flags)
+{
+	return cap_task_post_setuid (old_ruid, old_euid, old_suid, flags);
+}
+
+static inline int security_task_setgid (gid_t id0, gid_t id1, gid_t id2,
+					int flags)
+{
+	return 0;
+}
+
+static inline int security_task_setpgid (struct task_struct *p, pid_t pgid)
+{
+	return 0;
+}
+
+static inline int security_task_getpgid (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int security_task_getsid (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int security_task_setgroups (int gidsetsize, gid_t *grouplist)
+{
+	return 0;
+}
+
+static inline int security_task_setnice (struct task_struct *p, int nice)
+{
+	return 0;
+}
+
+static inline int security_task_setrlimit (unsigned int resource,
+					   struct rlimit *new_rlim)
+{
+	return 0;
+}
+
+static inline int security_task_setscheduler (struct task_struct *p,
+					      int policy,
+					      struct sched_param *lp)
+{
+	return 0;
+}
+
+static inline int security_task_getscheduler (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int security_task_kill (struct task_struct *p,
+				      struct siginfo *info, int sig)
+{
+	return 0;
+}
+
+static inline int security_task_wait (struct task_struct *p)
+{
+	return 0;
+}
+
+static inline int security_task_prctl (int option, unsigned long arg2,
+				       unsigned long arg3,
+				       unsigned long arg4,
+				       unsigned long arg5)
+{
+	return 0;
+}
+
+static inline void security_task_kmod_set_label (void)
+{
+	cap_task_kmod_set_label ();
+}
+
+static inline void security_task_reparent_to_init (struct task_struct *p)
+{
+	cap_task_reparent_to_init (p);
+}
+
+static inline int security_ipc_permission (struct kern_ipc_perm *ipcp,
+					   short flag)
+{
+	return 0;
+}
+
+static inline int security_msg_queue_alloc (struct msg_queue *msq)
+{
+	return 0;
+}
+
+static inline void security_msg_queue_free (struct msg_queue *msq)
+{ }
+
+static inline int security_shm_alloc (struct shmid_kernel *shp)
+{
+	return 0;
+}
+
+static inline void security_shm_free (struct shmid_kernel *shp)
+{ }
+
+static inline int security_sem_alloc (struct sem_array *sma)
+{
+	return 0;
+}
+
+static inline void security_sem_free (struct sem_array *sma)
+{ }
+
+
+#endif	/* CONFIG_SECURITY */
 
-#endif /* __KERNEL__ */
 
 #endif /* ! __LINUX_SECURITY_H */
 
===== init/do_mounts.c 1.25 vs edited =====
--- 1.25/init/do_mounts.c	Fri Oct  4 13:51:37 2002
+++ edited/init/do_mounts.c	Wed Oct 16 00:36:15 2002
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/suspend.h>
 #include <linux/root_dev.h>
+#include <linux/security.h>
 
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
@@ -799,7 +800,7 @@
 	sys_umount("/dev", 0);
 	sys_mount(".", "/", NULL, MS_MOVE, NULL);
 	sys_chroot(".");
-	security_ops->sb_post_mountroot();
+	security_sb_post_mountroot();
 	mount_devfs_fs ();
 }
 
===== ipc/msg.c 1.7 vs edited =====
--- 1.7/ipc/msg.c	Tue Oct  8 02:20:42 2002
+++ edited/ipc/msg.c	Wed Oct 16 00:37:48 2002
@@ -101,15 +101,14 @@
 	msq->q_perm.key = key;
 
 	msq->q_perm.security = NULL;
-	retval = security_ops->msg_queue_alloc_security(msq);
-	if (retval) {
+	if ((retval = security_msg_queue_alloc(msq))) {
 		kfree(msq);
 		return retval;
 	}
 
 	id = ipc_addid(&msg_ids, &msq->q_perm, msg_ctlmni);
 	if(id == -1) {
-		security_ops->msg_queue_free_security(msq);
+		security_msg_queue_free(msq);
 		kfree(msq);
 		return -ENOSPC;
 	}
@@ -281,7 +280,7 @@
 		free_msg(msg);
 	}
 	atomic_sub(msq->q_cbytes, &msg_bytes);
-	security_ops->msg_queue_free_security(msq);
+	security_msg_queue_free(msq);
 	kfree(msq);
 }
 
===== ipc/sem.c 1.12 vs edited =====
--- 1.12/ipc/sem.c	Tue Oct  8 02:20:46 2002
+++ edited/ipc/sem.c	Wed Oct 16 00:38:28 2002
@@ -136,15 +136,14 @@
 	sma->sem_perm.key = key;
 
 	sma->sem_perm.security = NULL;
-	retval = security_ops->sem_alloc_security(sma);
-	if (retval) {
+	if ((retval = security_sem_alloc(sma))) {
 		ipc_free(sma, size);
 		return retval;
 	}
 
 	id = ipc_addid(&sem_ids, &sma->sem_perm, sc_semmni);
 	if(id == -1) {
-		security_ops->sem_free_security(sma);
+		security_sem_free(sma);
 		ipc_free(sma, size);
 		return -ENOSPC;
 	}
@@ -427,7 +426,7 @@
 
 	used_sems -= sma->sem_nsems;
 	size = sizeof (*sma) + sma->sem_nsems * sizeof (struct sem);
-	security_ops->sem_free_security(sma);
+	security_sem_free(sma);
 	ipc_free(sma, size);
 }
 
===== ipc/shm.c 1.18 vs edited =====
--- 1.18/ipc/shm.c	Tue Oct  8 02:29:20 2002
+++ edited/ipc/shm.c	Wed Oct 16 00:39:00 2002
@@ -116,7 +116,7 @@
 	shm_unlock(shp->id);
 	shmem_lock(shp->shm_file, 0);
 	fput (shp->shm_file);
-	security_ops->shm_free_security(shp);
+	security_shm_free(shp);
 	kfree (shp);
 }
 
@@ -188,8 +188,7 @@
 	shp->shm_flags = (shmflg & S_IRWXUGO);
 
 	shp->shm_perm.security = NULL;
-	error = security_ops->shm_alloc_security(shp);
-	if (error) {
+	if ((error = security_shm_alloc(shp))) {
 		kfree(shp);
 		return error;
 	}
@@ -222,7 +221,7 @@
 no_id:
 	fput(file);
 no_file:
-	security_ops->shm_free_security(shp);
+	security_shm_free(shp);
 	kfree(shp);
 	return error;
 }
===== ipc/util.c 1.6 vs edited =====
--- 1.6/ipc/util.c	Tue Oct  8 02:01:30 2002
+++ edited/ipc/util.c	Wed Oct 16 00:39:12 2002
@@ -264,7 +264,7 @@
 	    !capable(CAP_IPC_OWNER))
 		return -1;
 
-	return security_ops->ipc_permission(ipcp, flag);
+	return security_ipc_permission(ipcp, flag);
 }
 
 /*
===== kernel/acct.c 1.12 vs edited =====
--- 1.12/kernel/acct.c	Mon Jul 22 03:12:48 2002
+++ edited/kernel/acct.c	Tue Oct 15 22:53:28 2002
@@ -49,6 +49,7 @@
 #include <linux/acct.h>
 #include <linux/file.h>
 #include <linux/tty.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 /*
@@ -222,8 +223,7 @@
 		}
 	}
 
-	error = security_ops->acct(file);
-	if (error)
+	if ((error = security_acct(file)))
 		return error;
 
 	spin_lock(&acct_globals.lock);
===== kernel/capability.c 1.6 vs edited =====
--- 1.6/kernel/capability.c	Sat Sep 14 06:18:49 2002
+++ edited/kernel/capability.c	Tue Oct 15 22:34:12 2002
@@ -8,6 +8,7 @@
  */ 
 
 #include <linux/mm.h>
+#include <linux/security.h>
 #include <asm/uaccess.h>
 
 unsigned securebits = SECUREBITS_DEFAULT; /* systemwide security settings */
@@ -63,7 +64,7 @@
      data.permitted = cap_t(target->cap_permitted);
      data.inheritable = cap_t(target->cap_inheritable); 
      data.effective = cap_t(target->cap_effective);
-     ret = security_ops->capget(target, &data.effective, &data.inheritable, &data.permitted);
+     ret = security_capget(target, &data.effective, &data.inheritable, &data.permitted);
 
 out:
      read_unlock(&tasklist_lock); 
@@ -88,7 +89,7 @@
      do_each_thread(g, target) {
              if (target->pgrp != pgrp)
                      continue;
-	     security_ops->capset_set(target, effective, inheritable, permitted);
+	     security_capset_set(target, effective, inheritable, permitted);
      } while_each_thread(g, target);
 }
 
@@ -105,7 +106,7 @@
      do_each_thread(g, target) {
              if (target == current || target->pid == 1)
                      continue;
-	     security_ops->capset_set(target, effective, inheritable, permitted);
+	     security_capset_set(target, effective, inheritable, permitted);
      } while_each_thread(g, target);
 }
 
@@ -163,7 +164,7 @@
 
      ret = -EPERM;
 
-     if (security_ops->capset_check(target, &effective, &inheritable, &permitted))
+     if (security_capset_check(target, &effective, &inheritable, &permitted))
 	     goto out;
 
      if (!cap_issubset(inheritable, cap_combine(target->cap_inheritable,
@@ -190,7 +191,7 @@
              else            /* all procs in process group */
                      cap_set_pg(-pid, &effective, &inheritable, &permitted);
      } else {
-	     security_ops->capset_set(target, &effective, &inheritable, &permitted);
+	     security_capset_set(target, &effective, &inheritable, &permitted);
      }
 
 out:
===== kernel/exit.c 1.72 vs edited =====
--- 1.72/kernel/exit.c	Tue Oct 15 15:08:06 2002
+++ edited/kernel/exit.c	Wed Oct 16 00:35:10 2002
@@ -67,7 +67,7 @@
 		wait_task_inactive(p);
 
 	atomic_dec(&p->user->processes);
-	security_ops->task_free_security(p);
+	security_task_free(p);
 	free_uid(p->user);
 	write_lock_irq(&tasklist_lock);
 	if (unlikely(p->ptrace))
@@ -248,7 +248,7 @@
 	/* cpus_allowed? */
 	/* rt_priority? */
 	/* signals? */
-	security_ops->task_reparent_to_init(current);
+	security_task_reparent_to_init(current);
 	memcpy(current->rlim, init_task.rlim, sizeof(*(current->rlim)));
 	current->user = INIT_USER;
 
@@ -774,7 +774,7 @@
 	if (current->tgid != p->tgid && delay_group_leader(p))
 		return 2;
 
-	if (security_ops->task_wait(p))
+	if (security_task_wait(p))
 		return 0;
 
 	return 1;
===== kernel/fork.c 1.87 vs edited =====
--- 1.87/kernel/fork.c	Mon Oct  7 15:17:19 2002
+++ edited/kernel/fork.c	Wed Oct 16 00:28:30 2002
@@ -682,8 +682,7 @@
 	if ((clone_flags & CLONE_DETACHED) && !(clone_flags & CLONE_THREAD))
 		return ERR_PTR(-EINVAL);
 
-	retval = security_ops->task_create(clone_flags);
-	if (retval)
+	if ((retval = security_task_create(clone_flags)))
 		goto fork_out;
 
 	retval = -ENOMEM;
@@ -772,7 +771,7 @@
 	INIT_LIST_HEAD(&p->local_pages);
 
 	retval = -ENOMEM;
-	if (security_ops->task_alloc_security(p))
+	if (security_task_alloc(p))
 		goto bad_fork_cleanup;
 	/* copy all the process information */
 	if (copy_semundo(clone_flags, p))
@@ -922,7 +921,7 @@
 bad_fork_cleanup_semundo:
 	exit_semundo(p);
 bad_fork_cleanup_security:
-	security_ops->task_free_security(p);
+	security_task_free(p);
 bad_fork_cleanup:
 	if (p->pid > 0)
 		free_pidmap(p->pid);
===== kernel/kmod.c 1.15 vs edited =====
--- 1.15/kernel/kmod.c	Tue Oct  1 01:54:49 2002
+++ edited/kernel/kmod.c	Wed Oct 16 00:28:59 2002
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 #include <linux/file.h>
 #include <linux/workqueue.h>
+#include <linux/security.h>
 
 #include <asm/uaccess.h>
 
@@ -134,7 +135,7 @@
 	/* Give kmod all effective privileges.. */
 	curtask->euid = curtask->fsuid = 0;
 	curtask->egid = curtask->fsgid = 0;
-	security_ops->task_kmod_set_label();
+	security_task_kmod_set_label();
 
 	/* Allow execve args to be in kernel space. */
 	set_fs(KERNEL_DS);
===== kernel/ptrace.c 1.18 vs edited =====
--- 1.18/kernel/ptrace.c	Sun Sep 15 19:57:15 2002
+++ edited/kernel/ptrace.c	Wed Oct 16 00:11:10 2002
@@ -14,6 +14,7 @@
 #include <linux/pagemap.h>
 #include <linux/smp_lock.h>
 #include <linux/ptrace.h>
+#include <linux/security.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
@@ -100,8 +101,7 @@
 	/* the same process cannot be attached many times */
 	if (task->ptrace & PT_PTRACED)
 		goto bad;
-	retval = security_ops->ptrace(current, task);
-	if (retval)
+	if ((retval = security_ptrace(current, task)))
 		goto bad;
 
 	/* Go */
===== kernel/sched.c 1.140 vs edited =====
--- 1.140/kernel/sched.c	Mon Oct 14 05:30:06 2002
+++ edited/kernel/sched.c	Wed Oct 16 00:29:50 2002
@@ -1329,8 +1329,7 @@
 	if (nice > 19)
 		nice = 19;
 
-	retval = security_ops->task_setnice(current, nice);
-	if (retval)
+	if ((retval = security_task_setnice(current, nice)))
 		return retval;
 
 	set_user_nice(current, nice);
@@ -1451,8 +1450,7 @@
 	    !capable(CAP_SYS_NICE))
 		goto out_unlock;
 
-	retval = security_ops->task_setscheduler(p, policy, &lp);
-	if (retval)
+	if ((retval = security_task_setscheduler(p, policy, &lp)))
 		goto out_unlock;
 
 	array = p->array;
@@ -1515,8 +1513,7 @@
 	read_lock(&tasklist_lock);
 	p = find_process_by_pid(pid);
 	if (p) {
-		retval = security_ops->task_getscheduler(p);
-		if (!retval)
+		if (!(retval = security_task_getscheduler(p)))
 			retval = p->policy;
 	}
 	read_unlock(&tasklist_lock);
@@ -1545,8 +1542,7 @@
 	if (!p)
 		goto out_unlock;
 
-	retval = security_ops->task_getscheduler(p);
-	if (retval)
+	if ((retval = security_task_getscheduler(p)))
 		goto out_unlock;
 
 	lp.sched_priority = p->rt_priority;
@@ -1778,8 +1774,7 @@
 	if (!p)
 		goto out_unlock;
 
-	retval = security_ops->task_getscheduler(p);
-	if (retval)
+	if ((retval = security_task_getscheduler(p)))
 		goto out_unlock;
 
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
===== kernel/signal.c 1.48 vs edited =====
--- 1.48/kernel/signal.c	Thu Oct  3 02:26:00 2002
+++ edited/kernel/signal.c	Wed Oct 16 00:30:19 2002
@@ -18,6 +18,7 @@
 #include <linux/fs.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/security.h>
 #include <asm/param.h>
 #include <asm/uaccess.h>
 #include <asm/siginfo.h>
@@ -706,8 +707,7 @@
 	ret = -EPERM;
 	if (bad_signal(sig, info, t))
 		goto out;
-	ret = security_ops->task_kill(t, info, sig);
-	if (ret)
+	if ((ret = security_task_kill(t, info, sig)))
 		goto out;
 
 	/* The null signal is a permissions and process existence probe.
===== kernel/sys.c 1.30 vs edited =====
--- 1.30/kernel/sys.c	Tue Oct 15 14:45:52 2002
+++ edited/kernel/sys.c	Wed Oct 16 00:33:50 2002
@@ -204,6 +204,7 @@
 cond_syscall(sys_quotactl)
 cond_syscall(sys_acct)
 cond_syscall(sys_lookup_dcookie)
+cond_syscall(sys_security)
 
 static int set_one_prio(struct task_struct *p, int niceval, int error)
 {
@@ -479,8 +480,7 @@
 	int new_egid = old_egid;
 	int retval;
 
-	retval = security_ops->task_setgid(rgid, egid, (gid_t)-1, LSM_SETID_RE);
-	if (retval)
+	if ((retval = security_task_setgid(rgid, egid, (gid_t)-1, LSM_SETID_RE)))
 		return retval;
 
 	if (rgid != (gid_t) -1) {
@@ -525,8 +525,7 @@
 	int old_egid = current->egid;
 	int retval;
 
-	retval = security_ops->task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID);
-	if (retval)
+	if ((retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_ID)))
 		return retval;
 
 	if (capable(CAP_SETGID))
@@ -599,8 +598,7 @@
 	int old_ruid, old_euid, old_suid, new_ruid, new_euid;
 	int retval;
 
-	retval = security_ops->task_setuid(ruid, euid, (uid_t)-1, LSM_SETID_RE);
-	if (retval)
+	if ((retval = security_task_setuid(ruid, euid, (uid_t)-1, LSM_SETID_RE)))
 		return retval;
 
 	new_ruid = old_ruid = current->uid;
@@ -638,7 +636,7 @@
 		current->suid = current->euid;
 	current->fsuid = current->euid;
 
-	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
+	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RE);
 }
 
 
@@ -660,8 +658,7 @@
 	int old_ruid, old_suid, new_ruid, new_suid;
 	int retval;
 
-	retval = security_ops->task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID);
-	if (retval)
+	if ((retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_ID)))
 		return retval;
 
 	old_ruid = new_ruid = current->uid;
@@ -683,7 +680,7 @@
 	current->fsuid = current->euid = uid;
 	current->suid = new_suid;
 
-	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
+	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_ID);
 }
 
 
@@ -698,8 +695,7 @@
 	int old_suid = current->suid;
 	int retval;
 
-	retval = security_ops->task_setuid(ruid, euid, suid, LSM_SETID_RES);
-	if (retval)
+	if ((retval = security_task_setuid(ruid, euid, suid, LSM_SETID_RES)))
 		return retval;
 
 	if (!capable(CAP_SETUID)) {
@@ -729,7 +725,7 @@
 	if (suid != (uid_t) -1)
 		current->suid = suid;
 
-	return security_ops->task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
+	return security_task_post_setuid(old_ruid, old_euid, old_suid, LSM_SETID_RES);
 }
 
 asmlinkage long sys_getresuid(uid_t *ruid, uid_t *euid, uid_t *suid)
@@ -750,8 +746,7 @@
 {
 	int retval;
 
-	retval = security_ops->task_setgid(rgid, egid, sgid, LSM_SETID_RES);
-	if (retval)
+	if ((retval = security_task_setgid(rgid, egid, sgid, LSM_SETID_RES)))
 		return retval;
 
 	if (!capable(CAP_SETGID)) {
@@ -804,8 +799,7 @@
 	int old_fsuid;
 	int retval;
 
-	retval = security_ops->task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
-	if (retval)
+	if ((retval = security_task_setuid(uid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS)))
 		return retval;
 
 	old_fsuid = current->fsuid;
@@ -821,8 +815,7 @@
 		current->fsuid = uid;
 	}
 
-	retval = security_ops->task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS);
-	if (retval)
+	if ((retval = security_task_post_setuid(old_fsuid, (uid_t)-1, (uid_t)-1, LSM_SETID_FS)))
 		return retval;
 
 	return old_fsuid;
@@ -836,8 +829,7 @@
 	int old_fsgid;
 	int retval;
 
-	retval = security_ops->task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS);
-	if (retval)
+	if ((retval = security_task_setgid(gid, (gid_t)-1, (gid_t)-1, LSM_SETID_FS)))
 		return retval;
 
 	old_fsgid = current->fsgid;
@@ -962,8 +954,7 @@
 
 		retval = -ESRCH;
 		if (p) {
-			retval = security_ops->task_getpgid(p);
-			if (!retval)
+			if (!(retval = security_task_getpgid(p)))
 				retval = p->pgrp;
 		}
 		read_unlock(&tasklist_lock);
@@ -990,8 +981,7 @@
 
 		retval = -ESRCH;
 		if(p) {
-			retval = security_ops->task_getsid(p);
-			if (!retval)
+			if (!(retval = security_task_getsid(p)))
 				retval = p->session;
 		}
 		read_unlock(&tasklist_lock);
@@ -1072,8 +1062,7 @@
 		return -EINVAL;
 	if(copy_from_user(groups, grouplist, gidsetsize * sizeof(gid_t)))
 		return -EFAULT;
-	retval = security_ops->task_setgroups(gidsetsize, groups);
-	if (retval)
+	if ((retval = security_task_setgroups(gidsetsize, groups)))
 		return retval;
 	memcpy(current->groups, groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
@@ -1236,8 +1225,7 @@
 			return -EPERM;
 	}
 
-	retval = security_ops->task_setrlimit(resource, &new_rlim);
-	if (retval)
+	if ((retval = security_task_setrlimit(resource, &new_rlim)))
 		return retval;
 
 	*old_rlim = new_rlim;
@@ -1311,8 +1299,7 @@
 	int error = 0;
 	int sig;
 
-	error = security_ops->task_prctl(option, arg2, arg3, arg4, arg5);
-	if (error)
+	if ((error = security_task_prctl(option, arg2, arg3, arg4, arg5)))
 		return error;
 
 	switch (option) {
===== kernel/uid16.c 1.2 vs edited =====
--- 1.2/kernel/uid16.c	Fri Jul 19 16:00:55 2002
+++ edited/kernel/uid16.c	Wed Oct 16 00:30:43 2002
@@ -140,8 +140,7 @@
 		return -EFAULT;
 	for (i = 0 ; i < gidsetsize ; i++)
 		new_groups[i] = (gid_t)groups[i];
-	i = security_ops->task_setgroups(gidsetsize, new_groups);
-	if (i)
+	if ((i = security_task_setgroups(gidsetsize, new_groups)))
 		return i;
 	memcpy(current->groups, new_groups, gidsetsize * sizeof(gid_t));
 	current->ngroups = gidsetsize;
===== mm/mmap.c 1.53 vs edited =====
--- 1.53/mm/mmap.c	Tue Oct 15 15:08:06 2002
+++ edited/mm/mmap.c	Wed Oct 16 00:36:48 2002
@@ -498,8 +498,7 @@
 		}
 	}
 
-	error = security_ops->file_mmap(file, prot, flags);
-	if (error)
+	if ((error = security_file_mmap(file, prot, flags)))
 		return error;
 		
 	/* Clear old maps */
===== mm/mprotect.c 1.19 vs edited =====
--- 1.19/mm/mprotect.c	Tue Oct  1 16:43:14 2002
+++ edited/mm/mprotect.c	Wed Oct 16 00:36:58 2002
@@ -262,8 +262,7 @@
 			goto out;
 		}
 
-		error = security_ops->file_mprotect(vma, prot);
-		if (error)
+		if ((error = security_file_mprotect(vma, prot)))
 			goto out;
 
 		if (vma->vm_end > end) {
===== net/core/scm.c 1.3 vs edited =====
--- 1.3/net/core/scm.c	Mon Jul 22 03:12:48 2002
+++ edited/net/core/scm.c	Wed Oct 16 00:41:37 2002
@@ -217,8 +217,7 @@
 	for (i=0, cmfptr=(int*)CMSG_DATA(cm); i<fdmax; i++, cmfptr++)
 	{
 		int new_fd;
-		err = security_ops->file_receive(fp[i]);
-		if (err)
+		if ((err = security_file_receive(fp[i])))
 			break;
 		err = get_unused_fd();
 		if (err < 0)
===== net/decnet/af_decnet.c 1.18 vs edited =====
--- 1.18/net/decnet/af_decnet.c	Tue Oct  8 07:02:41 2002
+++ edited/net/decnet/af_decnet.c	Wed Oct 16 00:42:30 2002
@@ -113,6 +113,7 @@
 #include <linux/inet.h>
 #include <linux/route.h>
 #include <linux/netfilter.h>
+#include <linux/security.h>
 #include <net/sock.h>
 #include <net/tcp.h>
 #include <asm/system.h>
@@ -794,7 +795,7 @@
 	 * dn_prot_sock ? Would be nice if the capable call would go there
 	 * too.
 	 */
-	if (security_ops->dn_prot_sock(saddr) &&
+	if (security_dn_prot_sock(saddr) &&
 	    !capable(CAP_NET_BIND_SERVICE) || 
 	    saddr->sdn_objnum || (saddr->sdn_flags & SDF_WILD))
 		return -EACCES;
===== security/Config.in 1.3 vs edited =====
--- 1.3/security/Config.in	Sat Jul 20 12:05:09 2002
+++ edited/security/Config.in	Tue Oct 15 22:24:46 2002
@@ -3,5 +3,8 @@
 #
 mainmenu_option next_comment
 comment 'Security options'
-define_bool CONFIG_SECURITY_CAPABILITIES y
+bool 'Enable different security models' CONFIG_SECURITY
+if [ "$CONFIG_SECURITY" = "y" ]; then
+   dep_tristate '  Default Linux Capabilities' CONFIG_SECURITY_CAPABILITIES $CONFIG_SECURITY
+fi
 endmenu
===== security/Makefile 1.1 vs edited =====
--- 1.1/security/Makefile	Fri Jul 19 15:55:56 2002
+++ edited/security/Makefile	Wed Oct 16 11:28:47 2002
@@ -3,11 +3,15 @@
 #
 
 # Objects that export symbols
-export-objs	:= security.o
+export-objs	:= security.o capability.o
 
-# Object file lists
-obj-y		:= security.o dummy.o
+# if we don't select a security model, use the default capabilities
+ifneq ($(CONFIG_SECURITY),y)
+obj-y		+= capability.o
+endif
 
+# Object file lists
+obj-$(CONFIG_SECURITY)			+= security.o dummy.o
 obj-$(CONFIG_SECURITY_CAPABILITIES)	+= capability.o
 
 include $(TOPDIR)/Rules.make
===== security/capability.c 1.6 vs edited =====
--- 1.6/security/capability.c	Tue Oct  8 02:01:30 2002
+++ edited/security/capability.c	Wed Oct 16 11:30:04 2002
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/sched.h>
 #include <linux/security.h>
 #include <linux/file.h>
 #include <linux/mm.h>
@@ -19,10 +20,7 @@
 #include <linux/skbuff.h>
 #include <linux/netlink.h>
 
-/* flag to keep track of how we were registered */
-static int secondary;
-
-static int cap_capable (struct task_struct *tsk, int cap)
+int cap_capable (struct task_struct *tsk, int cap)
 {
 	/* Derived from include/linux/sched.h:capable. */
 	if (cap_raised (tsk->cap_effective, cap))
@@ -31,23 +29,7 @@
 		return -EPERM;
 }
 
-static int cap_sys_security (unsigned int id, unsigned int call,
-			     unsigned long *args)
-{
-	return -ENOSYS;
-}
-
-static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
-{
-	return 0;
-}
-
-static int cap_quota_on (struct file *f)
-{
-	return 0;
-}
-
-static int cap_ptrace (struct task_struct *parent, struct task_struct *child)
+int cap_ptrace (struct task_struct *parent, struct task_struct *child)
 {
 	/* Derived from arch/i386/kernel/ptrace.c:sys_ptrace. */
 	if (!cap_issubset (child->cap_permitted, current->cap_permitted) &&
@@ -57,8 +39,8 @@
 		return 0;
 }
 
-static int cap_capget (struct task_struct *target, kernel_cap_t * effective,
-		       kernel_cap_t * inheritable, kernel_cap_t * permitted)
+int cap_capget (struct task_struct *target, kernel_cap_t *effective,
+		kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	/* Derived from kernel/capability.c:sys_capget. */
 	*effective = cap_t (target->cap_effective);
@@ -67,10 +49,8 @@
 	return 0;
 }
 
-static int cap_capset_check (struct task_struct *target,
-			     kernel_cap_t * effective,
-			     kernel_cap_t * inheritable,
-			     kernel_cap_t * permitted)
+int cap_capset_check (struct task_struct *target, kernel_cap_t *effective,
+		      kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	/* Derived from kernel/capability.c:sys_capset. */
 	/* verify restrictions on target's new Inheritable set */
@@ -95,27 +75,15 @@
 	return 0;
 }
 
-static void cap_capset_set (struct task_struct *target,
-			    kernel_cap_t * effective,
-			    kernel_cap_t * inheritable,
-			    kernel_cap_t * permitted)
+void cap_capset_set (struct task_struct *target, kernel_cap_t *effective,
+		     kernel_cap_t *inheritable, kernel_cap_t *permitted)
 {
 	target->cap_effective = *effective;
 	target->cap_inheritable = *inheritable;
 	target->cap_permitted = *permitted;
 }
 
-static int cap_acct (struct file *file)
-{
-	return 0;
-}
-
-static int cap_bprm_alloc_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static int cap_bprm_set_security (struct linux_binprm *bprm)
+int cap_bprm_set_security (struct linux_binprm *bprm)
 {
 	/* Copied from fs/exec.c:prepare_binprm. */
 
@@ -143,23 +111,13 @@
 	return 0;
 }
 
-static int cap_bprm_check_security (struct linux_binprm *bprm)
-{
-	return 0;
-}
-
-static void cap_bprm_free_security (struct linux_binprm *bprm)
-{
-	return;
-}
-
 /* Copied from fs/exec.c */
 static inline int must_not_trace_exec (struct task_struct *p)
 {
 	return (p->ptrace & PT_PTRACED) && !(p->ptrace & PT_PTRACE_CAP);
 }
 
-static void cap_bprm_compute_creds (struct linux_binprm *bprm)
+void cap_bprm_compute_creds (struct linux_binprm *bprm)
 {
 	/* Derived from fs/exec.c:compute_creds. */
 	kernel_cap_t new_permitted, working;
@@ -204,6 +162,160 @@
 	current->keep_capabilities = 0;
 }
 
+/* moved from kernel/sys.c. */
+/* 
+ * cap_emulate_setxuid() fixes the effective / permitted capabilities of
+ * a process after a call to setuid, setreuid, or setresuid.
+ *
+ *  1) When set*uiding _from_ one of {r,e,s}uid == 0 _to_ all of
+ *  {r,e,s}uid != 0, the permitted and effective capabilities are
+ *  cleared.
+ *
+ *  2) When set*uiding _from_ euid == 0 _to_ euid != 0, the effective
+ *  capabilities of the process are cleared.
+ *
+ *  3) When set*uiding _from_ euid != 0 _to_ euid == 0, the effective
+ *  capabilities are set to the permitted capabilities.
+ *
+ *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should 
+ *  never happen.
+ *
+ *  -astor 
+ *
+ * cevans - New behaviour, Oct '99
+ * A process may, via prctl(), elect to keep its capabilities when it
+ * calls setuid() and switches away from uid==0. Both permitted and
+ * effective sets will be retained.
+ * Without this change, it was impossible for a daemon to drop only some
+ * of its privilege. The call to setuid(!=0) would drop all privileges!
+ * Keeping uid 0 is not an option because uid 0 owns too many vital
+ * files..
+ * Thanks to Olaf Kirch and Peter Benie for spotting this.
+ */
+static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
+					int old_suid)
+{
+	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
+	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
+	    !current->keep_capabilities) {
+		cap_clear (current->cap_permitted);
+		cap_clear (current->cap_effective);
+	}
+	if (old_euid == 0 && current->euid != 0) {
+		cap_clear (current->cap_effective);
+	}
+	if (old_euid != 0 && current->euid == 0) {
+		current->cap_effective = current->cap_permitted;
+	}
+}
+
+int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
+			  int flags)
+{
+	switch (flags) {
+	case LSM_SETID_RE:
+	case LSM_SETID_ID:
+	case LSM_SETID_RES:
+		/* Copied from kernel/sys.c:setreuid/setuid/setresuid. */
+		if (!issecure (SECURE_NO_SETUID_FIXUP)) {
+			cap_emulate_setxuid (old_ruid, old_euid, old_suid);
+		}
+		break;
+	case LSM_SETID_FS:
+		{
+			uid_t old_fsuid = old_ruid;
+
+			/* Copied from kernel/sys.c:setfsuid. */
+
+			/*
+			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
+			 *          if not, we might be a bit too harsh here.
+			 */
+
+			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
+				if (old_fsuid == 0 && current->fsuid != 0) {
+					cap_t (current->cap_effective) &=
+					    ~CAP_FS_MASK;
+				}
+				if (old_fsuid != 0 && current->fsuid == 0) {
+					cap_t (current->cap_effective) |=
+					    (cap_t (current->cap_permitted) &
+					     CAP_FS_MASK);
+				}
+			}
+			break;
+		}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+void cap_task_kmod_set_label (void)
+{
+	cap_set_full (current->cap_effective);
+	return;
+}
+
+void cap_task_reparent_to_init (struct task_struct *p)
+{
+	p->cap_effective = CAP_INIT_EFF_SET;
+	p->cap_inheritable = CAP_INIT_INH_SET;
+	p->cap_permitted = CAP_FULL_SET;
+	p->keep_capabilities = 0;
+	return;
+}
+
+EXPORT_SYMBOL(cap_capable);
+EXPORT_SYMBOL(cap_ptrace);
+EXPORT_SYMBOL(cap_capget);
+EXPORT_SYMBOL(cap_capset_check);
+EXPORT_SYMBOL(cap_capset_set);
+EXPORT_SYMBOL(cap_bprm_set_security);
+EXPORT_SYMBOL(cap_bprm_compute_creds);
+EXPORT_SYMBOL(cap_task_post_setuid);
+EXPORT_SYMBOL(cap_task_kmod_set_label);
+EXPORT_SYMBOL(cap_task_reparent_to_init);
+
+#ifdef CONFIG_SECURITY
+
+static int cap_sys_security (unsigned int id, unsigned int call,
+			     unsigned long *args)
+{
+	return -ENOSYS;
+}
+
+static int cap_quotactl (int cmds, int type, int id, struct super_block *sb)
+{
+	return 0;
+}
+
+static int cap_quota_on (struct file *f)
+{
+	return 0;
+}
+
+static int cap_acct (struct file *file)
+{
+	return 0;
+}
+
+static int cap_bprm_alloc_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static int cap_bprm_check_security (struct linux_binprm *bprm)
+{
+	return 0;
+}
+
+static void cap_bprm_free_security (struct linux_binprm *bprm)
+{
+	return;
+}
+
 static int cap_sb_alloc_security (struct super_block *sb)
 {
 	return 0;
@@ -512,96 +624,6 @@
 	return 0;
 }
 
-/* moved from kernel/sys.c. */
-/* 
- * cap_emulate_setxuid() fixes the effective / permitted capabilities of
- * a process after a call to setuid, setreuid, or setresuid.
- *
- *  1) When set*uiding _from_ one of {r,e,s}uid == 0 _to_ all of
- *  {r,e,s}uid != 0, the permitted and effective capabilities are
- *  cleared.
- *
- *  2) When set*uiding _from_ euid == 0 _to_ euid != 0, the effective
- *  capabilities of the process are cleared.
- *
- *  3) When set*uiding _from_ euid != 0 _to_ euid == 0, the effective
- *  capabilities are set to the permitted capabilities.
- *
- *  fsuid is handled elsewhere. fsuid == 0 and {r,e,s}uid!= 0 should 
- *  never happen.
- *
- *  -astor 
- *
- * cevans - New behaviour, Oct '99
- * A process may, via prctl(), elect to keep its capabilities when it
- * calls setuid() and switches away from uid==0. Both permitted and
- * effective sets will be retained.
- * Without this change, it was impossible for a daemon to drop only some
- * of its privilege. The call to setuid(!=0) would drop all privileges!
- * Keeping uid 0 is not an option because uid 0 owns too many vital
- * files..
- * Thanks to Olaf Kirch and Peter Benie for spotting this.
- */
-static inline void cap_emulate_setxuid (int old_ruid, int old_euid,
-					int old_suid)
-{
-	if ((old_ruid == 0 || old_euid == 0 || old_suid == 0) &&
-	    (current->uid != 0 && current->euid != 0 && current->suid != 0) &&
-	    !current->keep_capabilities) {
-		cap_clear (current->cap_permitted);
-		cap_clear (current->cap_effective);
-	}
-	if (old_euid == 0 && current->euid != 0) {
-		cap_clear (current->cap_effective);
-	}
-	if (old_euid != 0 && current->euid == 0) {
-		current->cap_effective = current->cap_permitted;
-	}
-}
-
-static int cap_task_post_setuid (uid_t old_ruid, uid_t old_euid, uid_t old_suid,
-				 int flags)
-{
-	switch (flags) {
-	case LSM_SETID_RE:
-	case LSM_SETID_ID:
-	case LSM_SETID_RES:
-		/* Copied from kernel/sys.c:setreuid/setuid/setresuid. */
-		if (!issecure (SECURE_NO_SETUID_FIXUP)) {
-			cap_emulate_setxuid (old_ruid, old_euid, old_suid);
-		}
-		break;
-	case LSM_SETID_FS:
-		{
-			uid_t old_fsuid = old_ruid;
-
-			/* Copied from kernel/sys.c:setfsuid. */
-
-			/*
-			 * FIXME - is fsuser used for all CAP_FS_MASK capabilities?
-			 *          if not, we might be a bit too harsh here.
-			 */
-
-			if (!issecure (SECURE_NO_SETUID_FIXUP)) {
-				if (old_fsuid == 0 && current->fsuid != 0) {
-					cap_t (current->cap_effective) &=
-					    ~CAP_FS_MASK;
-				}
-				if (old_fsuid != 0 && current->fsuid == 0) {
-					cap_t (current->cap_effective) |=
-					    (cap_t (current->cap_permitted) &
-					     CAP_FS_MASK);
-				}
-			}
-			break;
-		}
-	default:
-		return -EINVAL;
-	}
-
-	return 0;
-}
-
 static int cap_task_setgid (gid_t id0, gid_t id1, gid_t id2, int flags)
 {
 	return 0;
@@ -664,21 +686,6 @@
 	return 0;
 }
 
-static void cap_task_kmod_set_label (void)
-{
-	cap_set_full (current->cap_effective);
-	return;
-}
-
-static void cap_task_reparent_to_init (struct task_struct *p)
-{
-	p->cap_effective = CAP_INIT_EFF_SET;
-	p->cap_inheritable = CAP_INIT_INH_SET;
-	p->cap_permitted = CAP_FULL_SET;
-	p->keep_capabilities = 0;
-	return;
-}
-
 static int cap_ipc_permission (struct kern_ipc_perm *ipcp, short flag)
 {
 	return 0;
@@ -838,6 +845,10 @@
 #define MY_NAME "capability"
 #endif
 
+/* flag to keep track of how we were registered */
+static int secondary;
+
+
 static int __init capability_init (void)
 {
 	/* register ourselves with the security framework */
@@ -877,3 +888,5 @@
 
 MODULE_DESCRIPTION("Standard Linux Capabilities Security Module");
 MODULE_LICENSE("GPL");
+
+#endif	/* CONFIG_SECURITY */
