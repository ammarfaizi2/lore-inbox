Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUCOH56 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 02:57:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUCOH56
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 02:57:58 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:63438 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262132AbUCOH5Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 02:57:25 -0500
Date: Mon, 15 Mar 2004 08:57:23 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Bind Mount Extensions 0.04.1 2/5
Message-ID: <20040315075723.GD31818@MAIL.13thfloor.at>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040315035506.GB30948@MAIL.13thfloor.at> <20040314201457.23fdb96e.akpm@osdl.org> <20040315042541.GA31412@MAIL.13thfloor.at> <20040314203427.27857fd9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040314203427.27857fd9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -NurpP --minimal linux-2.6.4-20040314_2308/include/linux/fs.h linux-2.6.4-20040314_2308-bme0.04.1/include/linux/fs.h
--- linux-2.6.4-20040314_2308/include/linux/fs.h	2004-03-15 05:41:50.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/include/linux/fs.h	2004-03-15 06:42:13.000000000 +0100
@@ -214,7 +216,7 @@ extern int leases_enable, dir_notify_ena
 #include <asm/byteorder.h>
 
 /* Used to be a macro which just called the function, now just a function */
-extern void update_atime (struct inode *);
+extern void update_atime (struct inode *, struct vfsmount *);
 
 extern void inode_init(unsigned long);
 extern void mnt_init(unsigned long);
@@ -1409,7 +1411,7 @@ extern void simple_release_fs(struct vfs
 extern int inode_change_ok(struct inode *, struct iattr *);
 extern int inode_setattr(struct inode *, struct iattr *);
 
-extern void inode_update_time(struct inode *inode, int ctime_too);
+extern void inode_update_time(struct inode *inode, int ctime_too, struct vfsmount *mount);
 
 static inline ino_t parent_ino(struct dentry *dentry)
 {
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/inode.c linux-2.6.4-20040314_2308-bme0.04.1/fs/inode.c
--- linux-2.6.4-20040314_2308/fs/inode.c	2004-03-15 05:41:49.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/inode.c	2004-03-15 06:32:33.000000000 +0100
@@ -1141,15 +1142,16 @@ static int inode_times_differ(struct ino
  *	This function automatically handles read only file systems and media,
  *	as well as the "noatime" flag and inode specific "noatime" markers.
  */
-void update_atime(struct inode *inode)
+void update_atime(struct inode *inode, struct vfsmount *mnt)
 {
 	struct timespec now;
 
-	if (IS_NOATIME(inode))
+	if (IS_NOATIME(inode) || MNT_IS_NOATIME(mnt))
 		return;
-	if (IS_NODIRATIME(inode) && S_ISDIR(inode->i_mode))
+	if (S_ISDIR(inode->i_mode) &&
+		(IS_NODIRATIME(inode) || MNT_IS_NODIRATIME(mnt)))
 		return;
-	if (IS_RDONLY(inode))
+	if (IS_RDONLY(inode, mnt))
 		return;
 
 	now = current_kernel_time();
diff -NurpP --minimal linux-2.6.4-20040314_2308/drivers/char/random.c linux-2.6.4-20040314_2308-bme0.04.1/drivers/char/random.c
--- linux-2.6.4-20040314_2308/drivers/char/random.c	2004-03-11 03:55:22.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/drivers/char/random.c	2004-03-15 06:02:34.000000000 +0100
@@ -1641,7 +1641,7 @@ random_read(struct file * file, char * b
 	 * If we gave the user some bytes, update the access time.
 	 */
 	if (count != 0) {
-		update_atime(file->f_dentry->d_inode);
+		update_atime(file->f_dentry->d_inode, file->f_vfsmnt);
 	}
 	
 	return (count ? count : retval);
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/autofs4/root.c linux-2.6.4-20040314_2308-bme0.04.1/fs/autofs4/root.c
--- linux-2.6.4-20040314_2308/fs/autofs4/root.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/autofs4/root.c	2004-03-15 06:02:34.000000000 +0100
@@ -61,7 +61,8 @@ static void autofs4_update_usage(struct 
 		struct autofs_info *ino = autofs4_dentry_ino(dentry);
 
 		if (ino) {
-			update_atime(dentry->d_inode);
+			/* Al Viro said: unconditional */
+			update_atime(dentry->d_inode, 0);
 			ino->last_used = jiffies;
 		}
 	}
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/coda/dir.c linux-2.6.4-20040314_2308-bme0.04.1/fs/coda/dir.c
--- linux-2.6.4-20040314_2308/fs/coda/dir.c	2004-03-15 05:41:49.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/coda/dir.c	2004-03-15 06:59:42.000000000 +0100
@@ -512,7 +512,7 @@ int coda_readdir(struct file *coda_file,
 		ret = -ENOENT;
 		if (!IS_DEADDIR(host_inode)) {
 			ret = host_file->f_op->readdir(host_file, filldir, dirent);
-			update_atime(host_inode);
+			update_atime(host_inode, host_file->f_vfsmnt);
 		}
 	}
 out:
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/hugetlbfs/inode.c linux-2.6.4-20040314_2308-bme0.04.1/fs/hugetlbfs/inode.c
--- linux-2.6.4-20040314_2308/fs/hugetlbfs/inode.c	2004-03-11 03:55:44.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/hugetlbfs/inode.c	2004-03-15 06:02:34.000000000 +0100
@@ -62,7 +62,7 @@ static int hugetlbfs_file_mmap(struct fi
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);
 
 	down(&inode->i_sem);
-	update_atime(inode);
+	update_atime(inode, file->f_vfsmnt);
 	vma->vm_flags |= VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops = &hugetlb_vm_ops;
 	ret = hugetlb_prefault(mapping, vma);
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/namei.c linux-2.6.4-20040314_2308-bme0.04.1/fs/namei.c
--- linux-2.6.4-20040314_2308/fs/namei.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/namei.c	2004-03-15 07:29:50.000000000 +0100
@@ -412,7 +416,7 @@ static inline int do_follow_link(struct 
 		goto loop;
 	current->link_count++;
 	current->total_link_count++;
-	update_atime(dentry->d_inode);
+	update_atime(dentry->d_inode, nd->mnt);
 	err = dentry->d_inode->i_op->follow_link(dentry, nd);
 	current->link_count--;
 	return err;
@@ -1368,7 +1390,7 @@ do_link:
 	error = security_inode_follow_link(dentry, nd);
 	if (error)
 		goto exit_dput;
-	update_atime(dentry->d_inode);
+	update_atime(dentry->d_inode, nd->mnt);
 	error = dentry->d_inode->i_op->follow_link(dentry, nd);
 	dput(dentry);
 	if (error)
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/nfsd/vfs.c linux-2.6.4-20040314_2308-bme0.04.1/fs/nfsd/vfs.c
--- linux-2.6.4-20040314_2308/fs/nfsd/vfs.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/nfsd/vfs.c	2004-03-15 06:19:48.000000000 +0100
@@ -1143,7 +1143,7 @@ nfsd_readlink(struct svc_rqst *rqstp, st
 	if (!inode->i_op || !inode->i_op->readlink)
 		goto out;
 
-	update_atime(inode);
+	update_atime(inode, fhp->fh_export->ex_mnt);
 	/* N.B. Why does this call need a get_fs()??
 	 * Remove the set_fs and watch the fireworks:-) --okir
 	 */
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/pipe.c linux-2.6.4-20040314_2308-bme0.04.1/fs/pipe.c
--- linux-2.6.4-20040314_2308/fs/pipe.c	2004-03-11 03:55:28.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/pipe.c	2004-03-15 06:30:26.000000000 +0100
@@ -165,7 +165,7 @@ pipe_readv(struct file *filp, const stru
 		kill_fasync(PIPE_FASYNC_WRITERS(*inode), SIGIO, POLL_OUT);
 	}
 	if (ret > 0)
-		update_atime(inode);
+		update_atime(inode, filp->f_vfsmnt);
 	return ret;
 }
 
@@ -263,7 +263,7 @@ pipe_writev(struct file *filp, const str
 		kill_fasync(PIPE_FASYNC_READERS(*inode), SIGIO, POLL_IN);
 	}
 	if (ret > 0)
-		inode_update_time(inode, 1);	/* mtime and ctime */
+		inode_update_time(inode, 1, filp->f_vfsmnt);	/* mtime and ctime */
 	return ret;
 }
 
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/readdir.c linux-2.6.4-20040314_2308-bme0.04.1/fs/readdir.c
--- linux-2.6.4-20040314_2308/fs/readdir.c	2004-03-15 05:41:49.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/readdir.c	2004-03-15 06:54:08.000000000 +0100
@@ -32,7 +32,7 @@ int vfs_readdir(struct file *file, filld
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
 		res = file->f_op->readdir(file, buf, filler);
-		update_atime(inode);
+		update_atime(inode, file->f_vfsmnt);
 	}
 	up(&inode->i_sem);
 out:
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/reiserfs/file.c linux-2.6.4-20040314_2308-bme0.04.1/fs/reiserfs/file.c
--- linux-2.6.4-20040314_2308/fs/reiserfs/file.c	2004-03-11 03:55:21.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/reiserfs/file.c	2004-03-15 06:30:43.000000000 +0100
@@ -1061,7 +1061,7 @@ ssize_t reiserfs_file_write( struct file
 	goto out;
 
     remove_suid(file->f_dentry);
-    inode_update_time(inode, 1); /* Both mtime and ctime */
+    inode_update_time(inode, 1, file->f_vfsmnt); /* Both mtime and ctime */
 
     // Ok, we are done with all the checks.
 
diff -NurpP --minimal linux-2.6.4-20040314_2308/fs/stat.c linux-2.6.4-20040314_2308-bme0.04.1/fs/stat.c
--- linux-2.6.4-20040314_2308/fs/stat.c	2004-03-11 03:55:23.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/fs/stat.c	2004-03-15 06:02:34.000000000 +0100
@@ -272,7 +272,7 @@ asmlinkage long sys_readlink(const char 
 		if (inode->i_op && inode->i_op->readlink) {
 			error = security_inode_readlink(nd.dentry);
 			if (!error) {
-				update_atime(inode);
+				update_atime(inode, nd.mnt);
 				error = inode->i_op->readlink(nd.dentry, buf, bufsiz);
 			}
 		}
diff -NurpP --minimal linux-2.6.4-20040314_2308/ipc/shm.c linux-2.6.4-20040314_2308-bme0.04.1/ipc/shm.c
--- linux-2.6.4-20040314_2308/ipc/shm.c	2004-03-11 03:55:27.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/ipc/shm.c	2004-03-15 06:02:34.000000000 +0100
@@ -149,7 +149,7 @@ static void shm_close (struct vm_area_st
 
 static int shm_mmap(struct file * file, struct vm_area_struct * vma)
 {
-	update_atime(file->f_dentry->d_inode);
+	update_atime(file->f_dentry->d_inode, file->f_vfsmnt);
 	vma->vm_ops = &shm_vm_ops;
 	shm_inc(file->f_dentry->d_inode->i_ino);
 	return 0;
diff -NurpP --minimal linux-2.6.4-20040314_2308/mm/filemap.c linux-2.6.4-20040314_2308-bme0.04.1/mm/filemap.c
--- linux-2.6.4-20040314_2308/mm/filemap.c	2004-03-11 03:55:25.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/mm/filemap.c	2004-03-15 06:31:00.000000000 +0100
@@ -725,7 +725,7 @@ no_cached_page:
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
 	if (cached_page)
 		page_cache_release(cached_page);
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 }
 
 EXPORT_SYMBOL(do_generic_mapping_read);
@@ -820,7 +820,7 @@ __generic_file_aio_read(struct kiocb *io
 			if (retval > 0)
 				*ppos = pos + retval;
 		}
-		update_atime(filp->f_dentry->d_inode);
+		update_atime(filp->f_dentry->d_inode, filp->f_vfsmnt);
 		goto out;
 	}
 
@@ -1357,7 +1357,7 @@ int generic_file_mmap(struct file * file
 
 	if (!mapping->a_ops->readpage)
 		return -ENOEXEC;
-	update_atime(inode);
+	update_atime(inode, file->f_vfsmnt);
 	vma->vm_ops = &generic_file_vm_ops;
 	return 0;
 }
@@ -1783,7 +1783,7 @@ generic_file_aio_write_nolock(struct kio
 		goto out;
 
 	remove_suid(file->f_dentry);
-	inode_update_time(inode, 1);
+	inode_update_time(inode, 1, file->f_vfsmnt);
 
 	/* coalesce the iovecs and go direct-to-BIO for O_DIRECT */
 	if (unlikely(file->f_flags & O_DIRECT)) {
diff -NurpP --minimal linux-2.6.4-20040314_2308/mm/shmem.c linux-2.6.4-20040314_2308-bme0.04.1/mm/shmem.c
--- linux-2.6.4-20040314_2308/mm/shmem.c	2004-03-11 03:55:26.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/mm/shmem.c	2004-03-15 06:02:34.000000000 +0100
@@ -1067,7 +1067,7 @@ static int shmem_mmap(struct file *file,
 	ops = &shmem_vm_ops;
 	if (!S_ISREG(inode->i_mode))
 		return -EACCES;
-	update_atime(inode);
+	update_atime(inode, file->f_vfsmnt);
 	vma->vm_ops = ops;
 	return 0;
 }
@@ -1363,7 +1363,7 @@ static void do_shmem_file_read(struct fi
 	}
 
 	*ppos = ((loff_t) index << PAGE_CACHE_SHIFT) + offset;
-	update_atime(inode);
+	update_atime(inode, filp->f_vfsmnt);
 }
 
 static ssize_t shmem_file_read(struct file *filp, char __user *buf, size_t count, loff_t *ppos)
diff -NurpP --minimal linux-2.6.4-20040314_2308/net/unix/af_unix.c linux-2.6.4-20040314_2308-bme0.04.1/net/unix/af_unix.c
--- linux-2.6.4-20040314_2308/net/unix/af_unix.c	2004-03-11 03:55:35.000000000 +0100
+++ linux-2.6.4-20040314_2308-bme0.04.1/net/unix/af_unix.c	2004-03-15 06:02:34.000000000 +0100
@@ -691,7 +691,7 @@ static struct sock *unix_find_other(stru
 			goto put_fail;
 
 		if (u->sk_type == type)
-			update_atime(nd.dentry->d_inode);
+			update_atime(nd.dentry->d_inode, nd.mnt);
 
 		path_release(&nd);
 
@@ -707,7 +707,7 @@ static struct sock *unix_find_other(stru
 			struct dentry *dentry;
 			dentry = unix_sk(u)->dentry;
 			if (dentry)
-				update_atime(dentry->d_inode);
+				update_atime(dentry->d_inode, nd.mnt);
 		} else
 			goto fail;
 	}
