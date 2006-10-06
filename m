Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751788AbWJFEvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbWJFEvd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 00:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751794AbWJFEvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 00:51:33 -0400
Received: from mail1.sea5.speakeasy.net ([69.17.117.3]:48514 "EHLO
	mail1.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751788AbWJFEvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 00:51:32 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org
Subject: [PATCH 3/5] fdtable: Remove the free_files field.
Date: Thu, 5 Oct 2006 21:51:30 -0700
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610052151.30946.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An fdtable can either be embedded inside a files_struct or standalone (after
being expanded). When an fdtable is being discarded after all RCU references
to it have expired, we must either free it directly, in the standalone case,
or free the files_struct it is contained within, in the embedded case.
Currently the free_files field controls this behavior, but we can get rid of
it entirely, as all the necessary information is already recorded. We can
distinguish embedded and standalone fdtables using max_fds, and if it is
embedded we can divine the relevant files_struct using container_of().

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru old/fs/file.c new/fs/file.c
--- old/fs/file.c	2006-10-05 19:31:13.000000000 -0700
+++ new/fs/file.c	2006-10-05 19:32:27.000000000 -0700
@@ -106,7 +106,7 @@ static void free_fdtable_work(struct fdt
 	}
 }
 
-static void free_fdtable_rcu(struct rcu_head *rcu)
+void free_fdtable_rcu(struct rcu_head *rcu)
 {
 	struct fdtable *fdt = container_of(rcu, struct fdtable, rcu);
 	int fdset_size, fdarray_size;
@@ -116,20 +116,15 @@ static void free_fdtable_rcu(struct rcu_
 	fdset_size = fdt->max_fds / 8;
 	fdarray_size = fdt->max_fds * sizeof(struct file *);
 
-	if (fdt->free_files) {
+	if (fdt->max_fds <= NR_OPEN_DEFAULT) {
 		/*
-		 * The this fdtable was embedded in the files structure
-		 * and the files structure itself was getting destroyed.
-		 * It is now safe to free the files structure.
+		 * This fdtable is embedded in the files structure and that
+		 * structure itself is getting destroyed.
 		 */
-		kmem_cache_free(files_cachep, fdt->free_files);
+		kmem_cache_free(files_cachep,
+				container_of(fdt, struct files_struct, fdtab));
 		return;
 	}
-	if (fdt->max_fds <= NR_OPEN_DEFAULT)
-		/*
-		 * The fdtable was embedded
-		 */
-		return;
 	if (fdset_size <= PAGE_SIZE && fdarray_size <= PAGE_SIZE) {
 		kfree(fdt->open_fds);
 		kfree(fdt->close_on_exec);
@@ -152,12 +147,6 @@ static void free_fdtable_rcu(struct rcu_
 	}
 }
 
-void free_fdtable(struct fdtable *fdt)
-{
-	if (fdt->free_files || fdt->max_fds > NR_OPEN_DEFAULT)
-		call_rcu(&fdt->rcu, free_fdtable_rcu);
-}
-
 /*
  * Expand the fdset in the files_struct.  Called with the files spinlock
  * held for write.
@@ -267,7 +256,6 @@ static struct fdtable *alloc_fdtable(int
 		goto out;
 	fdt->fd = new_fds;
 	fdt->max_fds = nfds;
-	fdt->free_files = NULL;
 	return fdt;
 out:
 	free_fdset(new_openset, nfds);
@@ -303,7 +291,8 @@ static int expand_fdtable(struct files_s
 		/* Continue as planned */
 		copy_fdtable(new_fdt, cur_fdt);
 		rcu_assign_pointer(files->fdt, new_fdt);
-		free_fdtable(cur_fdt);
+		if (cur_fdt->max_fds > NR_OPEN_DEFAULT)
+			call_rcu(&cur_fdt->rcu, free_fdtable_rcu);
 	} else {
 		/* Somebody else expanded, so undo our attempt */
 		__free_fdtable(new_fdt);
diff -Npru old/include/linux/file.h new/include/linux/file.h
--- old/include/linux/file.h	2006-10-05 19:31:13.000000000 -0700
+++ new/include/linux/file.h	2006-10-05 19:32:27.000000000 -0700
@@ -32,7 +32,6 @@ struct fdtable {
 	fd_set *close_on_exec;
 	fd_set *open_fds;
 	struct rcu_head rcu;
-	struct files_struct *free_files;
 	struct fdtable *next;
 };
 
@@ -82,7 +81,7 @@ extern fd_set *alloc_fdset(int);
 extern void free_fdset(fd_set *, int);
 
 extern int expand_files(struct files_struct *, int nr);
-extern void free_fdtable(struct fdtable *fdt);
+extern void free_fdtable_rcu(struct rcu_head *rcu);
 extern void __init files_defer_init(void);
 
 static inline struct file * fcheck_files(struct files_struct *files, unsigned 
int fd)
diff -Npru old/include/linux/init_task.h new/include/linux/init_task.h
--- old/include/linux/init_task.h	2006-10-05 19:31:13.000000000 -0700
+++ new/include/linux/init_task.h	2006-10-05 19:32:27.000000000 -0700
@@ -15,7 +15,6 @@
 	.close_on_exec	= (fd_set *)&init_files.close_on_exec_init, \
 	.open_fds	= (fd_set *)&init_files.open_fds_init, 	\
 	.rcu		= RCU_HEAD_INIT, 		\
-	.free_files	= NULL,		 		\
 	.next		= NULL,		 		\
 }
 
diff -Npru old/kernel/exit.c new/kernel/exit.c
--- old/kernel/exit.c	2006-10-05 19:31:13.000000000 -0700
+++ new/kernel/exit.c	2006-10-05 19:32:27.000000000 -0700
@@ -469,11 +469,9 @@ void fastcall put_files_struct(struct fi
 		 * you can free files immediately.
 		 */
 		fdt = files_fdtable(files);
-		if (fdt == &files->fdtab)
-			fdt->free_files = files;
-		else
+		if (fdt != &files->fdtab)
 			kmem_cache_free(files_cachep, files);
-		free_fdtable(fdt);
+		call_rcu(&fdt->rcu, free_fdtable_rcu);
 	}
 }
 
diff -Npru old/kernel/fork.c new/kernel/fork.c
--- old/kernel/fork.c	2006-10-05 19:31:13.000000000 -0700
+++ new/kernel/fork.c	2006-10-05 19:32:27.000000000 -0700
@@ -627,7 +627,6 @@ static struct files_struct *alloc_files(
 	fdt->open_fds = (fd_set *)&newf->open_fds_init;
 	fdt->fd = &newf->fd_array[0];
 	INIT_RCU_HEAD(&fdt->rcu);
-	fdt->free_files = NULL;
 	fdt->next = NULL;
 	rcu_assign_pointer(newf->fdt, fdt);
 out:
