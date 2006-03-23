Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWCWRvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWCWRvd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWCWRvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:51:33 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:20628 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1751361AbWCWRvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:51:32 -0500
To: akpm@osdl.org
CC: trond.myklebust@fys.uio.no, chrisw@sous-sol.org, matthew@wil.cx,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove steal_locks()
Message-Id: <E1FMTxP-00063O-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 23 Mar 2006 18:50:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the steal_locks() function.

steal_locks() doesn't work correctly with any filesystem that does
it's own lock management, including NFS, CIFS, etc.

In addition it has weird semantics on local filesystems in case tasks
sharing file-descriptor tables are doing POSIX locking operations in
parallel to execve().

The steal_locks() function has an effect on applications doing:

clone(CLONE_FILES)
  /* in child */
  lock
  execve
  lock

POSIX locks acquired before execve (by "child", "parent" or any
further task sharing files_struct) will after the execve be owned
exclusively by "child".

According to Chris Wright some LSB/LTP kind of suite triggers without
the stealing behavior, but there's no known real-world application
that would also fail.

Apps using NPTL are not affected, since all other threads are killed
before execve.

Apps using LinuxThreads are only affected if they

  - have multiple threads during exec (LinuxThreads doesn't kill other
    threads, the app may do it with pthread_kill_other_threads_np())
  - rely on POSIX locks being inherited across exec

Both conditions are documented, but not their interaction.

Apps using clone() natively are affected if they

  - use clone(CLONE_FILES)
  - rely on POSIX locks being inherited across exec

The above scenarios are unlikely, but possible.

If the patch is vetoed, there's a plan B, that involves mostly keeping
the weird stealing semantics, but changing the way lock ownership is
handled so that network and local filesystems work consistently.

That would add more complexity though, so this solution seems to be
preferred by most people.

Signed-off-by: Miklos Szeredi <miklos@szeredi.hu>

Index: linux/fs/binfmt_elf.c
===================================================================
--- linux.orig/fs/binfmt_elf.c	2006-03-22 16:09:10.000000000 +0100
+++ linux/fs/binfmt_elf.c	2006-03-22 16:11:13.000000000 +0100
@@ -754,7 +754,6 @@ static int load_elf_binary(struct linux_
 
 	/* Discard our unneeded old files struct */
 	if (files) {
-		steal_locks(files);
 		put_files_struct(files);
 		files = NULL;
 	}
Index: linux/fs/binfmt_misc.c
===================================================================
--- linux.orig/fs/binfmt_misc.c	2006-03-22 16:09:10.000000000 +0100
+++ linux/fs/binfmt_misc.c	2006-03-22 16:11:13.000000000 +0100
@@ -203,7 +203,6 @@ static int load_misc_binary(struct linux
 		goto _error;
 
 	if (files) {
-		steal_locks(files);
 		put_files_struct(files);
 		files = NULL;
 	}
Index: linux/fs/exec.c
===================================================================
--- linux.orig/fs/exec.c	2006-03-22 16:09:10.000000000 +0100
+++ linux/fs/exec.c	2006-03-22 16:11:13.000000000 +0100
@@ -859,7 +859,6 @@ int flush_old_exec(struct linux_binprm *
 	bprm->mm = NULL;		/* We're using it now */
 
 	/* This is the point of no return */
-	steal_locks(files);
 	put_files_struct(files);
 
 	current->sas_ss_sp = current->sas_ss_size = 0;
Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-03-22 16:10:23.000000000 +0100
+++ linux/fs/locks.c	2006-03-22 16:11:13.000000000 +0100
@@ -2174,58 +2174,6 @@ int lock_may_write(struct inode *inode, 
 
 EXPORT_SYMBOL(lock_may_write);
 
-static inline void __steal_locks(struct file *file, fl_owner_t from)
-{
-	struct inode *inode = file->f_dentry->d_inode;
-	struct file_lock *fl = inode->i_flock;
-
-	while (fl) {
-		if (fl->fl_file == file && fl->fl_owner == from)
-			fl->fl_owner = current->files;
-		fl = fl->fl_next;
-	}
-}
-
-/* When getting ready for executing a binary, we make sure that current
- * has a files_struct on its own. Before dropping the old files_struct,
- * we take over ownership of all locks for all file descriptors we own.
- * Note that we may accidentally steal a lock for a file that a sibling
- * has created since the unshare_files() call.
- */
-void steal_locks(fl_owner_t from)
-{
-	struct files_struct *files = current->files;
-	int i, j;
-	struct fdtable *fdt;
-
-	if (from == files)
-		return;
-
-	lock_kernel();
-	j = 0;
-	rcu_read_lock();
-	fdt = files_fdtable(files);
-	for (;;) {
-		unsigned long set;
-		i = j * __NFDBITS;
-		if (i >= fdt->max_fdset || i >= fdt->max_fds)
-			break;
-		set = fdt->open_fds->fds_bits[j++];
-		while (set) {
-			if (set & 1) {
-				struct file *file = fdt->fd[i];
-				if (file)
-					__steal_locks(file, from);
-			}
-			i++;
-			set >>= 1;
-		}
-	}
-	rcu_read_unlock();
-	unlock_kernel();
-}
-EXPORT_SYMBOL(steal_locks);
-
 static int __init filelock_init(void)
 {
 	filelock_cache = kmem_cache_create("file_lock_cache",
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2006-03-22 16:09:10.000000000 +0100
+++ linux/include/linux/fs.h	2006-03-22 16:11:13.000000000 +0100
@@ -767,7 +767,6 @@ extern int setlease(struct file *, long,
 extern int lease_modify(struct file_lock **, int);
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
 extern int lock_may_write(struct inode *, loff_t start, unsigned long count);
-extern void steal_locks(fl_owner_t from);
 
 struct fasync_struct {
 	int	magic;
