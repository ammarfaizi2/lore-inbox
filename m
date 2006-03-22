Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWCVMRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWCVMRc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 07:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWCVMRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 07:17:31 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:56500 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1750838AbWCVMRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 07:17:30 -0500
To: trond.myklebust@fys.uio.no
CC: chrisw@sous-sol.org, matthew@wil.cx, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-reply-to: <1143025967.12871.9.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Wed, 22 Mar 2006 06:12:47 -0500)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu>
	 <20060320121107.GE8980@parisc-linux.org>
	 <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu>
	 <20060320123950.GF8980@parisc-linux.org>
	 <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu>
	 <20060320153202.GH8980@parisc-linux.org>
	 <1142878975.7991.13.camel@lade.trondhjem.org>
	 <E1FLdPd-00020d-00@dorka.pomaz.szeredi.hu>
	 <1142962083.7987.37.camel@lade.trondhjem.org>
	 <E1FLl7L-0002u9-00@dorka.pomaz.szeredi.hu>
	 <20060321191605.GB15997@sorel.sous-sol.org>
	 <E1FLwjC-0000kJ-00@dorka.pomaz.szeredi.hu> <1143025967.12871.9.camel@lade.trondhjem.org>
Message-Id: <E1FM2Gi-0001LF-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 22 Mar 2006 13:16:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > i concur with Trond, there's no sane way to get rid of it w/out
> > > formalizing CLONE_FILES and locks on exec
> > 
> > Probably there is.  It would involve allocating a separate
> > lock-owner-ID stored in files_struct but separate from it.  But it's
> > more complicated than simply not propagating locks on exec in the
> > CLONE_FILES case.
> 
> That doesn't solve the fundamental problem.
> 
> You would still have to be able to tell a remote server that some locks
> which previously belonged to one owner are being reallocated to several
> owners.

No changing of lock owner is involved, that's the whole point.

Instead of trying to explain, here's a untested/unfinished patch
showing the idea.

Miklos

Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-03-22 11:20:15.000000000 +0100
+++ linux/fs/locks.c	2006-03-22 13:03:47.000000000 +0100
@@ -333,7 +333,7 @@ static int flock_to_posix_lock(struct fi
 	if (fl->fl_end < fl->fl_start)
 		return -EOVERFLOW;
 	
-	fl->fl_owner = current->files;
+	fl->fl_owner = current->files->lock_owner;
 	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
@@ -379,7 +379,7 @@ static int flock64_to_posix_lock(struct 
 	if (fl->fl_end < fl->fl_start)
 		return -EOVERFLOW;
 	
-	fl->fl_owner = current->files;
+	fl->fl_owner = current->files->lock_owner;
 	fl->fl_pid = current->tgid;
 	fl->fl_file = filp;
 	fl->fl_flags = FL_POSIX;
@@ -432,7 +432,7 @@ static struct lock_manager_operations le
  */
 static int lease_init(struct file *filp, int type, struct file_lock *fl)
  {
-	fl->fl_owner = current->files;
+	fl->fl_owner = current->files->lock_owner;
 	fl->fl_pid = current->tgid;
 
 	fl->fl_file = filp;
@@ -1003,7 +1003,7 @@ EXPORT_SYMBOL(posix_lock_file_wait);
  */
 int locks_mandatory_locked(struct inode *inode)
 {
-	fl_owner_t owner = current->files;
+	fl_owner_t owner = current->files->lock_owner;
 	struct file_lock *fl;
 
 	/*
@@ -1041,7 +1041,7 @@ int locks_mandatory_area(int read_write,
 	int error;
 
 	locks_init_lock(&fl);
-	fl.fl_owner = current->files;
+	fl.fl_owner = current->files->lock_owner;
 	fl.fl_pid = current->tgid;
 	fl.fl_file = filp;
 	fl.fl_flags = FL_POSIX | FL_ACCESS;
@@ -1141,7 +1141,7 @@ int __break_lease(struct inode *inode, u
 		goto out;
 
 	for (fl = flock; fl && IS_LEASE(fl); fl = fl->fl_next)
-		if (fl->fl_owner == current->files)
+		if (fl->fl_owner == current->files->lock_owner)
 			i_have_this_lease = 1;
 
 	if (mode & FMODE_WRITE) {
@@ -2183,55 +2183,23 @@ int lock_may_write(struct inode *inode, 
 
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
 /* When getting ready for executing a binary, we make sure that current
  * has a files_struct on its own. Before dropping the old files_struct,
  * we take over ownership of all locks for all file descriptors we own.
  * Note that we may accidentally steal a lock for a file that a sibling
  * has created since the unshare_files() call.
  */
-void steal_locks(fl_owner_t from)
+void steal_locks(struct files_struct *from)
 {
 	struct files_struct *files = current->files;
-	int i, j;
-	struct fdtable *fdt;
+	struct lock_owner *tmp;
 
 	if (from == files)
 		return;
 
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
+	tmp = from->lock_owner;
+	from->lock_owner = files->lock_owner;
+	files->lock_owner = tmp;
 }
 EXPORT_SYMBOL(steal_locks);
 
Index: linux/include/linux/fs.h
===================================================================
--- linux.orig/include/linux/fs.h	2006-03-22 11:20:15.000000000 +0100
+++ linux/include/linux/fs.h	2006-03-22 12:59:09.000000000 +0100
@@ -678,7 +678,7 @@ extern spinlock_t files_lock;
  *
  * Lockd stuffs a "host" pointer into this.
  */
-typedef struct files_struct *fl_owner_t;
+typedef struct lock_owner *fl_owner_t;
 
 struct file_lock_operations {
 	void (*fl_insert)(struct file_lock *);	/* lock insertion callback */
@@ -767,7 +767,7 @@ extern int setlease(struct file *, long,
 extern int lease_modify(struct file_lock **, int);
 extern int lock_may_read(struct inode *, loff_t start, unsigned long count);
 extern int lock_may_write(struct inode *, loff_t start, unsigned long count);
-extern void steal_locks(fl_owner_t from);
+extern void steal_locks(struct files_struct *from);
 
 struct fasync_struct {
 	int	magic;
Index: linux/fs/fcntl.c
===================================================================
--- linux.orig/fs/fcntl.c	2006-03-20 06:53:29.000000000 +0100
+++ linux/fs/fcntl.c	2006-03-22 13:02:36.000000000 +0100
@@ -177,7 +177,7 @@ asmlinkage long sys_dup2(unsigned int ol
 	spin_unlock(&files->file_lock);
 
 	if (tofree)
-		filp_close(tofree, files);
+		filp_close(tofree, files->lock_owner);
 	err = newfd;
 out:
 	return err;
Index: linux/fs/open.c
===================================================================
--- linux.orig/fs/open.c	2006-03-20 06:53:29.000000000 +0100
+++ linux/fs/open.c	2006-03-22 13:01:39.000000000 +0100
@@ -1159,7 +1159,7 @@ asmlinkage long sys_close(unsigned int f
 	FD_CLR(fd, fdt->close_on_exec);
 	__put_unused_fd(files, fd);
 	spin_unlock(&files->file_lock);
-	return filp_close(filp, files);
+	return filp_close(filp, files->lock_owner);
 
 out_unlock:
 	spin_unlock(&files->file_lock);
Index: linux/include/linux/file.h
===================================================================
--- linux.orig/include/linux/file.h	2006-03-22 11:20:15.000000000 +0100
+++ linux/include/linux/file.h	2006-03-22 12:28:21.000000000 +0100
@@ -29,6 +29,11 @@ struct fdtable {
 	struct fdtable *next;
 };
 
+struct lock_owner {
+	/* lock accounting will go in here */
+	int dummy;
+};
+
 /*
  * Open file table structure
  */
@@ -40,6 +45,7 @@ struct files_struct {
 	fd_set open_fds_init;
 	struct file * fd_array[NR_OPEN_DEFAULT];
 	spinlock_t file_lock;     /* Protects concurrent writers.  Nests inside tsk->alloc_lock */
+	struct lock_owner *lock_owner;
 };
 
 #define files_fdtable(files) (rcu_dereference((files)->fdt))
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2006-03-22 11:20:15.000000000 +0100
+++ linux/kernel/fork.c	2006-03-22 12:48:51.000000000 +0100
@@ -605,6 +605,7 @@ static struct files_struct *alloc_files(
 		goto out;
 
 	atomic_set(&newf->count, 1);
+	newf->lock_owner = kmalloc(sizeof(struct lock_owner), SLAB_KERNEL);
 
 	spin_lock_init(&newf->file_lock);
 	fdt = &newf->fdtab;
Index: linux/kernel/exit.c
===================================================================
--- linux.orig/kernel/exit.c	2006-03-22 13:12:20.000000000 +0100
+++ linux/kernel/exit.c	2006-03-22 13:12:50.000000000 +0100
@@ -395,7 +395,7 @@ static void close_files(struct files_str
 			if (set & 1) {
 				struct file * file = xchg(&fdt->fd[i], NULL);
 				if (file)
-					filp_close(file, files);
+					filp_close(file, files->lock_owner);
 			}
 			i++;
 			set >>= 1;
@@ -422,6 +422,7 @@ void fastcall put_files_struct(struct fi
 
 	if (atomic_dec_and_test(&files->count)) {
 		close_files(files);
+		kfree(files->lock_owner);
 		/*
 		 * Free the fd and fdset arrays if we expanded them.
 		 * If the fdtable was embedded, pass files for freeing






