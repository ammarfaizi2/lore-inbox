Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbUCSB5e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 20:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261943AbUCSB5d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 20:57:33 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:11729 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262154AbUCSB5L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 20:57:11 -0500
Date: Fri, 19 Mar 2004 02:57:09 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04.1 2/5
Message-ID: <20040319015708.GB31040@MAIL.13thfloor.at>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org> <20040315075723.GD31818@MAIL.13thfloor.at> <20040318121650.GI31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040318121650.GI31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:16:50PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Mar 15, 2004 at 08:57:23AM +0100, Herbert Poetzl wrote:
> > -void update_atime(struct inode *inode)
> > +void update_atime(struct inode *inode, struct vfsmount *mnt)

Hi Alexander!

> _Hell_, no.  

thanks for looking at the code ;)

> Proper solution is to move the callers upstream instead of 
> propagating vfsmounts downstream.  That, BTW, was the main reason
> for readdir() patch.

it that what you have in mind?

	 -· update_atime()
	  ¦-· __generic_file_aio_read()         [done]
	  ¦ 
	  ¦-· autofs4_update_usage()            [removed]
	  ¦ ¦-· autofs4_revalidate()            [done]
	  ¦ ¦-· autofs4_root_revalidate()       [done]
	  ¦ ¦-· try_to_fill_dentry()            [done,NULL]
	  ¦ '-· try_to_fill_dentry()            [done,NULL]
	  ¦     
	  ¦-· coda_readdir()                    [done]
	  ¦-· do_follow_link()                  [done]
	  ¦-· do_generic_mapping_read()         [done]
	  ¦-· do_shmem_file_read()              [done]
	  ¦     
	  ¦-· generic_file_mmap()               [done]
	  ¦-· hugetlbfs_file_mmap()             [done]
	  ¦ 
	  ¦-· nfsd_readlink()                   [done]
	  ¦-· open_namei()                      [done]
	  ¦-· pipe_readv()                      [done]
	  ¦-· random_read()                     [done]
	  ¦-· shmem_mmap()                      [done]
	  ¦-· sys_readlink()                    [done]
	  ¦ 
	  ¦-· unix_find_other()                 [done,NULL]
	  ¦     
	  '-· vfs_readdir()                     [done]

> BTW, update_atime() is exported.  And it's 2.6 now...

patch is also available at:
http://www.13thfloor.at/patches/patch-2.6.5-rc1-bk3-bme0.04.2-atime.diff

best,
Herbert


diff -NurpP --minimal linux-2.6.5-rc1-bk3/drivers/char/random.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/drivers/char/random.c
--- linux-2.6.5-rc1-bk3/drivers/char/random.c	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/drivers/char/random.c	2004-03-19 01:43:33.000000000 +0100
@@ -1640,9 +1640,9 @@ random_read(struct file * file, char * b
 	/*
 	 * If we gave the user some bytes, update the access time.
 	 */
-	if (count != 0) {
+	if ((count != 0) &&
+		may_update_atime(file->f_dentry->d_inode, file->f_vfsmnt))
 		update_atime(file->f_dentry->d_inode);
-	}
 	
 	return (count ? count : retval);
 }
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/autofs/root.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/autofs/root.c
--- linux-2.6.5-rc1-bk3/fs/autofs/root.c	2004-03-11 03:55:27.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/autofs/root.c	2004-03-19 01:17:58.000000000 +0100
@@ -129,8 +129,10 @@ static int try_to_fill_dentry(struct den
 
 	/* We don't update the usages for the autofs daemon itself, this
 	   is necessary for recursive autofs mounts */
-	if ( !autofs_oz_mode(sbi) ) {
+	if (!autofs_oz_mode(sbi)) {
 		autofs_update_usage(&sbi->dirhash,ent);
+		if (may_update_atime(dentry->d_inode, NULL))
+			update_atime(dentry->d_inode);
 	}
 
 	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/autofs4/root.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/autofs4/root.c
--- linux-2.6.5-rc1-bk3/fs/autofs4/root.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/autofs4/root.c	2004-03-19 02:22:01.000000000 +0100
@@ -15,6 +15,8 @@
 #include <linux/stat.h>
 #include <linux/param.h>
 #include <linux/time.h>
+#include <linux/fs.h>
+#include <linux/namei.h>
 #include <linux/smp_lock.h>
 #include "autofs_i.h"
 
@@ -60,10 +62,8 @@ static void autofs4_update_usage(struct 
 	for(; dentry != top; dentry = dentry->d_parent) {
 		struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
-		if (ino) {
-			update_atime(dentry->d_inode);
+		if (ino)
 			ino->last_used = jiffies;
-		}
 	}
 }
 
@@ -129,8 +129,11 @@ static int try_to_fill_dentry(struct den
 
 	/* We don't update the usages for the autofs daemon itself, this
 	   is necessary for recursive autofs mounts */
-	if (!autofs4_oz_mode(sbi))
+	if (!autofs4_oz_mode(sbi)) {
 		autofs4_update_usage(dentry);
+		if (may_update_atime(dentry->d_inode, NULL))
+			update_atime(dentry->d_inode);
+	}
 
 	dentry->d_flags &= ~DCACHE_AUTOFS_PENDING;
 	return 1;
@@ -177,9 +180,11 @@ static int autofs4_root_revalidate(struc
 	spin_unlock(&dcache_lock);
 
 	/* Update the usage list */
-	if (!oz_mode)
+	if (!oz_mode) {
 		autofs4_update_usage(dentry);
-
+		if (may_update_atime(dentry->d_inode, nd->mnt))
+			update_atime(dentry->d_inode);
+	}
 	return 1;
 }
 
@@ -187,9 +192,11 @@ static int autofs4_revalidate(struct den
 {
 	struct autofs_sb_info *sbi = autofs4_sbi(dentry->d_sb);
 
-	if (!autofs4_oz_mode(sbi))
+	if (!autofs4_oz_mode(sbi)) {
 		autofs4_update_usage(dentry);
-
+		if (may_update_atime(dentry->d_inode, nd->mnt))
+			update_atime(dentry->d_inode);
+	}
 	return 1;
 }
 
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/coda/dir.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/coda/dir.c
--- linux-2.6.5-rc1-bk3/fs/coda/dir.c	2004-03-16 10:21:19.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/coda/dir.c	2004-03-19 01:27:56.000000000 +0100
@@ -512,7 +512,8 @@ int coda_readdir(struct file *coda_file,
 		ret = -ENOENT;
 		if (!IS_DEADDIR(host_inode)) {
 			ret = host_file->f_op->readdir(host_file, filldir, dirent);
-			update_atime(host_inode);
+			if (may_update_atime(host_inode, host_file->f_vfsmnt))
+				update_atime(host_inode);
 		}
 	}
 out:
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/hugetlbfs/inode.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/hugetlbfs/inode.c
--- linux-2.6.5-rc1-bk3/fs/hugetlbfs/inode.c	2004-03-18 22:49:57.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/hugetlbfs/inode.c	2004-03-19 01:34:21.000000000 +0100
@@ -62,7 +62,8 @@ static int hugetlbfs_file_mmap(struct fi
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
 	down(&inode->i_sem);
-	update_atime(inode);
+	if (may_update_atime(inode, file->f_vfsmnt))
+		update_atime(inode);
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
 	ret = hugetlb_prefault(mapping, vma);
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/inode.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/inode.c
--- linux-2.6.5-rc1-bk3/fs/inode.c	2004-03-16 10:21:19.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/inode.c	2004-03-19 02:31:59.000000000 +0100
@@ -1145,13 +1145,6 @@ void update_atime(struct inode *inode)
 {
 	struct timespec now;
 
-	if (IS_NOATIME(inode))
-		return;
-	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode))
-		return;
-	if (IS_RDONLY(inode))
-		return;
-
 	now = current_kernel_time();
 	if (inode_times_differ(inode, &inode->i_atime, &now)) {
 		inode->i_atime = now;
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/namei.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/namei.c
--- linux-2.6.5-rc1-bk3/fs/namei.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/namei.c	2004-03-19 01:40:53.000000000 +0100
@@ -412,7 +412,8 @@ static inline int do_follow_link(struct 
 		goto loop;
 	current->link_count++;
 	current->total_link_count++;
-	update_atime(dentry->d_inode);
+	if (may_update_atime(dentry->d_inode, nd->mnt))
+		update_atime(dentry->d_inode);
 	err = dentry->d_inode->i_op->follow_link(dentry, nd);
 	current->link_count--;
 	return err;
@@ -1368,7 +1369,8 @@ do_link:
 	error = security_inode_follow_link(dentry, nd);
 	if (error)
 		goto exit_dput;
-	update_atime(dentry->d_inode);
+	if (may_update_atime(dentry->d_inode, nd->mnt))
+		update_atime(dentry->d_inode);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
 	dput(dentry);
 	if (error)
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/namespace.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/namespace.c
--- linux-2.6.5-rc1-bk3/fs/namespace.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/namespace.c	2004-03-19 02:48:01.000000000 +0100
@@ -206,37 +206,39 @@ static int show_vfsmnt(struct seq_file *
 	struct vfsmount *mnt = v;
 	int err = 0;
 	static struct proc_fs_info {
-		int flag;
-		char *str;
+		int s_flag;
+		int mnt_flag;
+		char *set_str;
+		char *unset_str;
 	} fs_info[] = {
-		{ MS_SYNCHRONOUS, ",sync" },
-		{ MS_DIRSYNC, ",dirsync" },
-		{ MS_MANDLOCK, ",mand" },
-		{ MS_NOATIME, ",noatime" },
-		{ MS_NODIRATIME, ",nodiratime" },
-		{ 0, NULL }
-	};
-	static struct proc_fs_info mnt_info[] = {
-		{ MNT_NOSUID, ",nosuid" },
-		{ MNT_NODEV, ",nodev" },
-		{ MNT_NOEXEC, ",noexec" },
-		{ 0, NULL }
+		{ MS_RDONLY, MNT_RDONLY, "ro", "rw" },
+		{ MS_SYNCHRONOUS, 0, ",sync", NULL },
+		{ MS_DIRSYNC, 0, ",dirsync", NULL },
+		{ MS_MANDLOCK, 0, ",mand", NULL },
+		{ MS_NOATIME, MNT_NOATIME, ",noatime", NULL },
+		{ MS_NODIRATIME, MNT_NODIRATIME, ",nodiratime", NULL },
+		{ 0, MNT_NOSUID, ",nosuid", NULL },
+		{ 0, MNT_NODEV, ",nodev", NULL },
+		{ 0, MNT_NOEXEC, ",noexec", NULL },
+		{ 0, 0, NULL, NULL }
 	};
-	struct proc_fs_info *fs_infop;
+	struct proc_fs_info *p;
+	unsigned long s_flags = mnt->mnt_sb->s_flags;
+	int mnt_flags = mnt->mnt_flags;
 
 	mangle(m, mnt->mnt_devname ? mnt->mnt_devname : "none");
 	seq_putc(m, ' ');
 	seq_path(m, mnt, mnt->mnt_root, " \t\n\\");
 	seq_putc(m, ' ');
 	mangle(m, mnt->mnt_sb->s_type->name);
-	seq_puts(m, mnt->mnt_sb->s_flags & MS_RDONLY ? " ro" : " rw");
-	for (fs_infop = fs_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_sb->s_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
-	}
-	for (fs_infop = mnt_info; fs_infop->flag; fs_infop++) {
-		if (mnt->mnt_flags & fs_infop->flag)
-			seq_puts(m, fs_infop->str);
+	for (p = fs_info; (p->s_flag | p->mnt_flag) ; p++) {
+		if ((s_flags & p->s_flag) || (mnt_flags & p->mnt_flag)) {
+			if (p->set_str)
+				seq_puts(m, p->set_str);
+		} else {
+			if (p->unset_str)
+				seq_puts(m, p->unset_str);
+		}
 	}
 	if (mnt->mnt_sb->s_op->show_options)
 		err = mnt->mnt_sb->s_op->show_options(m, mnt);
@@ -522,11 +524,13 @@ out_unlock:
 /*
  * do loopback mount.
  */
-static int do_loopback(struct nameidata *nd, char *old_name, int recurse)
+static int do_loopback(struct nameidata *nd, char *old_name, unsigned long flags, int mnt_flags)
 {
 	struct nameidata old_nd;
 	struct vfsmount *mnt = NULL;
+	int recurse = flags & MS_REC;
 	int err = mount_is_safe(nd);
+
 	if (err)
 		return err;
 	if (!old_name || !*old_name)
@@ -553,6 +557,7 @@ static int do_loopback(struct nameidata 
 			spin_unlock(&vfsmount_lock);
 		} else
 			mntput(mnt);
+		mnt->mnt_flags = mnt_flags;
 	}
 
 	up_write(&current->namespace->sem);
@@ -759,12 +764,18 @@ long do_mount(char * dev_name, char * di
 		((char *)data_page)[PAGE_SIZE - 1] = 0;
 
 	/* Separate the per-mountpoint flags */
+	if (flags & MS_RDONLY)
+		mnt_flags |= MNT_RDONLY;
 	if (flags & MS_NOSUID)
 		mnt_flags |= MNT_NOSUID;
 	if (flags & MS_NODEV)
 		mnt_flags |= MNT_NODEV;
 	if (flags & MS_NOEXEC)
 		mnt_flags |= MNT_NOEXEC;
+	if (flags & MS_NOATIME)
+		mnt_flags |= MNT_NOATIME;
+	if (flags & MS_NODIRATIME)
+		mnt_flags |= MNT_NODIRATIME;
 	flags &= ~(MS_NOSUID|MS_NOEXEC|MS_NODEV);
 
 	/* ... and get the mountpoint */
@@ -780,7 +791,7 @@ long do_mount(char * dev_name, char * di
 		retval = do_remount(&nd, flags & ~MS_REMOUNT, mnt_flags,
 				    data_page);
 	else if (flags & MS_BIND)
-		retval = do_loopback(&nd, dev_name, flags & MS_REC);
+		retval = do_loopback(&nd, dev_name, flags, mnt_flags);
 	else if (flags & MS_MOVE)
 		retval = do_move_mount(&nd, dev_name);
 	else
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/nfsd/vfs.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/nfsd/vfs.c
--- linux-2.6.5-rc1-bk3/fs/nfsd/vfs.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/nfsd/vfs.c	2004-03-19 02:27:08.000000000 +0100
@@ -1143,7 +1143,8 @@ nfsd_readlink(struct svc_rqst *rqstp, st
 	if (!inode->i_op || !inode->i_op->readlink)
 		goto out;
 
-	update_atime(inode);
+	if (may_update_atime(inode, fhp->fh_export->ex_mnt))
+		update_atime(inode);
 	/* N.B. Why does this call need a get_fs()??
 	 * Remove the set_fs and watch the fireworks:-) --okir
 	 */
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/pipe.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/pipe.c
--- linux-2.6.5-rc1-bk3/fs/pipe.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/pipe.c	2004-03-19 01:42:17.000000000 +0100
@@ -164,7 +164,8 @@ pipe_readv(struct file *filp, const stru
 		wake_up_interruptible(PIPE_WAIT(*inode));
 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
-	if (ret > 0)
+	if ((ret > 0) &&
+		may_update_atime(inode, filp->f_vfsmnt))
 		update_atime(inode);
 	return ret;
 }
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/readdir.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/readdir.c
--- linux-2.6.5-rc1-bk3/fs/readdir.c	2004-03-16 10:21:20.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/readdir.c	2004-03-19 01:48:32.000000000 +0100
@@ -32,7 +32,8 @@ int vfs_readdir(struct file *file, filld
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
 		res = file->f_op->readdir(file, buf, filler);
-		update_atime(inode);
+		if (may_update_atime(inode, file->f_vfsmnt))
+			update_atime(inode);
 	}
 	up(&inode->i_sem);
 out:
diff -NurpP --minimal linux-2.6.5-rc1-bk3/fs/stat.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/stat.c
--- linux-2.6.5-rc1-bk3/fs/stat.c	2004-03-11 03:55:23.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/fs/stat.c	2004-03-19 01:45:44.000000000 +0100
@@ -272,7 +272,8 @@ asmlinkage long sys_readlink(const char 
 		if (inode->i_op && inode->i_op->readlink) {
 			error = security_inode_readlink(nd.dentry);
 			if (!error) {
-				update_atime(inode);
+				if (may_update_atime(inode, nd.mnt))
+					update_atime(inode);
 				error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
 			}
 		}
diff -NurpP --minimal linux-2.6.5-rc1-bk3/include/linux/fs.h linux-2.6.5-rc1-bk3-bme0.04.2-atime/include/linux/fs.h
--- linux-2.6.5-rc1-bk3/include/linux/fs.h	2004-03-16 10:21:20.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/include/linux/fs.h	2004-03-19 02:33:01.000000000 +0100
@@ -19,6 +19,7 @@
 #include <linux/cache.h>
 #include <linux/radix-tree.h>
 #include <linux/kobject.h>
+#include <linux/mount.h>
 #include <asm/atomic.h>
 
 struct iovec;
@@ -751,6 +753,22 @@ extern int vfs_rmdir(struct inode *, str
 extern int vfs_unlink(struct inode *, struct dentry *);
 extern int vfs_rename(struct inode *, struct dentry *, struct inode *, struct dentry *);
 
+static inline int may_update_atime(struct inode *inode, struct vfsmount *mnt)
+{
+	if (IS_RDONLY(inode) ||
+		(mnt && MNT_IS_RDONLY(mnt)))
+		return 0;
+	if (IS_NOATIME(inode) ||
+		(mnt && MNT_IS_NOATIME(mnt)))
+		return 0;
+	if (S_ISDIR(inode->i_mode) &&
+		(IS_NODIRATIME(inode) ||
+		(mnt && MNT_IS_NODIRATIME(mnt))))
+		return 0;
+	return 1;
+}
+
+
 /*
  * File types
  *
diff -NurpP --minimal linux-2.6.5-rc1-bk3/include/linux/mount.h linux-2.6.5-rc1-bk3-bme0.04.2-atime/include/linux/mount.h
--- linux-2.6.5-rc1-bk3/include/linux/mount.h	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/include/linux/mount.h	2004-03-19 00:36:56.000000000 +0100
@@ -14,9 +14,12 @@
 
 #include <linux/list.h>
 
-#define MNT_NOSUID	1
-#define MNT_NODEV	2
-#define MNT_NOEXEC	4
+#define MNT_RDONLY	1
+#define MNT_NOSUID	2
+#define MNT_NODEV	4
+#define MNT_NOEXEC	8
+#define MNT_NOATIME	1024
+#define MNT_NODIRATIME	2048
 
 struct vfsmount
 {
@@ -33,6 +36,10 @@ struct vfsmount
 	struct list_head mnt_list;
 };
 
+#define	MNT_IS_RDONLY(m)	((m) && ((m)->mnt_flags & MNT_RDONLY))
+#define	MNT_IS_NOATIME(m)	((m) && ((m)->mnt_flags & MNT_NOATIME))
+#define	MNT_IS_NODIRATIME(m)	((m) && ((m)->mnt_flags & MNT_NODIRATIME))
+
 static inline struct vfsmount *mntget(struct vfsmount *mnt)
 {
 	if (mnt)
diff -NurpP --minimal linux-2.6.5-rc1-bk3/mm/filemap.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/mm/filemap.c
--- linux-2.6.5-rc1-bk3/mm/filemap.c	2004-03-18 22:49:57.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/mm/filemap.c	2004-03-19 02:11:00.000000000 +0100
@@ -21,6 +21,7 @@
 #include <linux/mman.h>
 #include <linux/pagemap.h>
 #include <linux/file.h>
+#include <linux/mount.h>
 #include <linux/uio.h>
 #include <linux/hash.h>
 #include <linux/writeback.h>
@@ -725,7 +726,8 @@ no_cached_page:
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
-	update_atime(inode);
+	if (may_update_atime(inode, filp->f_vfsmnt))
+		update_atime(inode);
 }
 
 EXPORT_SYMBOL(do_generic_mapping_read);
@@ -820,7 +822,8 @@ __generic_file_aio_read(struct kiocb *io
 			if (retval > 0)
 				*ppos = pos + retval;
 		}
-		update_atime(filp->f_dentry->d_inode);
+		if (may_update_atime(filp->f_dentry->d_inode, filp->f_vfsmnt))
+			update_atime(filp->f_dentry->d_inode);
 		goto out;
 	}
 
@@ -1357,7 +1360,8 @@ int generic_file_mmap(struct file * file
 
 	if (!mapping->a_ops->readpage)
 		return -ENOEXEC;
-	update_atime(inode);
+	if (may_update_atime(inode, file->f_vfsmnt))
+		update_atime(inode);
 	vma->vm_ops = &generic_file_vm_ops;
 	return 0;
 }
diff -NurpP --minimal linux-2.6.5-rc1-bk3/mm/shmem.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/mm/shmem.c
--- linux-2.6.5-rc1-bk3/mm/shmem.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/mm/shmem.c	2004-03-19 02:12:34.000000000 +0100
@@ -1067,7 +1067,8 @@ static int shmem_mmap(struct file *file,
 	ops = &shmem_vm_ops;
 	if (!S_ISREG(inode->i_mode))
 		return -EACCES;
-	update_atime(inode);
+	if (may_update_atime(inode, file->f_vfsmnt))
+		update_atime(inode);
 	vma->vm_ops = ops;
 	return 0;
 }
@@ -1363,7 +1364,8 @@ static void do_shmem_file_read(struct fi
 	}
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
-	update_atime(inode);
+	if (may_update_atime(inode, filp->f_vfsmnt))
+		update_atime(inode);
 }
 
 static ssize_t shmem_file_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
diff -NurpP --minimal linux-2.6.5-rc1-bk3/net/unix/af_unix.c linux-2.6.5-rc1-bk3-bme0.04.2-atime/net/unix/af_unix.c
--- linux-2.6.5-rc1-bk3/net/unix/af_unix.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.5-rc1-bk3-bme0.04.2-atime/net/unix/af_unix.c	2004-03-19 01:47:43.000000000 +0100
@@ -706,7 +706,7 @@ static struct sock *unix_find_other(stru
 		if (u) {
 			struct dentry *dentry;
 			dentry = unix_sk(u)->dentry;
-			if (dentry)
+			if (dentry && may_update_atime(dentry->d_inode, NULL))
 				update_atime(dentry->d_inode);
 		} else
 			goto fail;
