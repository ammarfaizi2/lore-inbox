Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965136AbWCTQmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965136AbWCTQmO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:42:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWCTQmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:42:13 -0500
Received: from a1819.adsl.pool.eol.hu ([81.0.120.41]:35519 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964890AbWCTQmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:42:09 -0500
To: matthew@wil.cx
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20060320153202.GH8980@parisc-linux.org> (message from Matthew
	Wilcox on Mon, 20 Mar 2006 08:32:02 -0700)
Subject: Re: DoS with POSIX file locks?
References: <E1FLIlF-0007zR-00@dorka.pomaz.szeredi.hu> <20060320121107.GE8980@parisc-linux.org> <E1FLJLs-00085u-00@dorka.pomaz.szeredi.hu> <20060320123950.GF8980@parisc-linux.org> <E1FLJsF-0008A7-00@dorka.pomaz.szeredi.hu> <20060320153202.GH8980@parisc-linux.org>
Message-Id: <E1FLNRi-0000We-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 20 Mar 2006 17:41:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Things look fairly straightforward if the accounting is done in
> > files_struct instead of task_struct.  At least for POSIX locks.  I
> > haven't looked at flocks or leases yet.
> 
> I was thinking that would work, yes.  It might not be worth worrying
> about accounting for leases/flocks since each process can only have one
> of those per open file anyway.

Here's a minimally tested patch.  The only tricky part is when the
unlock splits an existing lock in two.

Also the limit checking is sloppy when the lock is split, and in that
case allows the counter to go one above the limit.

> > steal_locks() might cause problems, but that function should be gotten
> > rid of anyway.
> 
> I quite agree.  Now we need to find a better way to solve the problem it
> papers over.

steal_locks() is not yet handled in this patch.  Any ideas on what to
do with it?

Miklos

Index: linux/fs/locks.c
===================================================================
--- linux.orig/fs/locks.c	2006-03-20 06:53:29.000000000 +0100
+++ linux/fs/locks.c	2006-03-20 17:25:11.000000000 +0100
@@ -539,6 +539,11 @@ static void locks_wake_up_blocks(struct 
 	}
 }
 
+static int posix_lock_account(struct file_lock *fl)
+{
+	return IS_POSIX(fl) && fl->fl_owner == current->files;
+}
+
 /* Insert file lock fl into an inode's lock list at the position indicated
  * by pos. At the same time add the lock to the global file lock list.
  */
@@ -550,6 +555,9 @@ static void locks_insert_lock(struct fil
 	fl->fl_next = *pos;
 	*pos = fl;
 
+	if (posix_lock_account(fl))
+		atomic_inc(&current->files->posix_lock_ctr);
+
 	if (fl->fl_ops && fl->fl_ops->fl_insert)
 		fl->fl_ops->fl_insert(fl);
 }
@@ -564,6 +572,9 @@ static void locks_delete_lock(struct fil
 {
 	struct file_lock *fl = *thisfl_p;
 
+	if (posix_lock_account(fl))
+		atomic_dec(&current->files->posix_lock_ctr);
+
 	*thisfl_p = fl->fl_next;
 	fl->fl_next = NULL;
 	list_del_init(&fl->fl_link);
@@ -769,6 +780,15 @@ out:
 	return error;
 }
 
+static int posix_lock_allow(struct file_lock *request)
+{
+	if (!posix_lock_account(request))
+		return 1;
+
+	return atomic_read(&current->files->posix_lock_ctr) <
+		current->signal->rlim[RLIMIT_LOCKS].rlim_cur;
+}
+
 EXPORT_SYMBOL(posix_lock_file);
 
 static int __posix_lock_file(struct inode *inode, struct file_lock *request)
@@ -816,13 +836,16 @@ static int __posix_lock_file(struct inod
 	if (!(new_fl && new_fl2))
 		goto out;
 
+	/* If request is not unlock, check against resource limits.
+	 * If an existing lock is split, then the lock counter might
+	 * go one above the limit
+	 */
+	if (request->fl_type != F_UNLCK && !posix_lock_allow(request))
+		goto out;
+
 	/*
-	 * We've allocated the new locks in advance, so there are no
-	 * errors possible (and no blocking operations) from here on.
-	 * 
 	 * Find the first old lock with the same owner as the new lock.
 	 */
-	
 	before = &inode->i_flock;
 
 	/* First skip locks owned by other processes.  */
@@ -927,7 +950,18 @@ static int __posix_lock_file(struct inod
 		if (left == right) {
 			/* The new lock breaks the old one in two pieces,
 			 * so we have to use the second new lock.
+			 *
+			 * This is the only case, when an unlock
+			 * operation increases the number of used
+			 * locks, luckily nothing has yet been
+			 * touched.  So check rlimit...
 			 */
+			if (request->fl_type == F_UNLCK &&
+			    !posix_lock_allow(request)) {
+				error = -ENOLCK;
+				goto out;
+			}
+
 			left = new_fl2;
 			new_fl2 = NULL;
 			locks_copy_lock(left, right);
Index: linux/include/linux/file.h
===================================================================
--- linux.orig/include/linux/file.h	2006-03-20 06:53:29.000000000 +0100
+++ linux/include/linux/file.h	2006-03-20 15:33:05.000000000 +0100
@@ -40,6 +40,7 @@ struct files_struct {
 	fd_set open_fds_init;
 	struct file * fd_array[NR_OPEN_DEFAULT];
 	spinlock_t file_lock;     /* Protects concurrent writers.  Nests inside tsk->alloc_lock */
+	atomic_t posix_lock_ctr;
 };
 
 #define files_fdtable(files) (rcu_dereference((files)->fdt))
Index: linux/kernel/fork.c
===================================================================
--- linux.orig/kernel/fork.c	2006-03-20 06:53:29.000000000 +0100
+++ linux/kernel/fork.c	2006-03-20 17:14:30.000000000 +0100
@@ -618,6 +618,7 @@ static struct files_struct *alloc_files(
 	fdt->free_files = NULL;
 	fdt->next = NULL;
 	rcu_assign_pointer(newf->fdt, fdt);
+	atomic_set(&newf->posix_lock_ctr, 0);
 out:
 	return newf;
 }



