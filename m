Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbVALPwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbVALPwB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbVALPvj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:51:39 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:60655 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261234AbVALPu0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:50:26 -0500
From: pmeda@akamai.com
Date: Wed, 12 Jan 2005 07:53:59 -0800
Message-Id: <200501121553.HAA02079@allur.sanmateo.akamai.com>
To: akpm@osdl.org
Subject: [patch] file_table:expand_files() code cleanup
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


expand_files() cleanup: Make expand_files() common code for fork.c:fork/copy_files(),
open.c:open/get_unused_fd() and fcntl.c:dup/locate_fd().

expand_files() does both expand_fd_array and expand_fd_set based on
the need.  This is used in dup(). open() and fork() duplicates the work of expand files.
At all places we check for expanding fd array, we also check for expanding fdset. There
is no need of checking and calling them seperately.

This change also moves the expand_files to file.c from fcntl.c, and makes the
expand_fd_array and expand_fd_set local to that file.


Signed-off-by: Prasanna Meda <pmeda@akamai.com>

--- a/include/linux/file.h	Tue Jan 11 22:45:47 2005
+++ b/include/linux/file.h	Tue Jan 11 22:46:24 2005
@@ -53,12 +53,12 @@
 extern void filp_dtor(void * objp, struct kmem_cache_s *cachep, unsigned long dflags);
 
 extern struct file ** alloc_fd_array(int);
-extern int expand_fd_array(struct files_struct *, int nr);
 extern void free_fd_array(struct file **, int);
 
 extern fd_set *alloc_fdset(int);
-extern int expand_fdset(struct files_struct *, int nr);
 extern void free_fdset(fd_set *, int);
+
+extern int expand_files(struct files_struct *, int nr);
 
 static inline struct file * fcheck_files(struct files_struct *files, unsigned int fd)
 {
--- a/fs/fcntl.c	Tue Jan 11 21:57:19 2005
+++ b/fs/fcntl.c	Tue Jan 11 22:03:23 2005
@@ -41,38 +41,6 @@
 	return res;
 }
 
-
-/* Expand files.  Return <0 on error; 0 nothing done; 1 files expanded,
- * we may have blocked. 
- *
- * Should be called with the files->file_lock spinlock held for write.
- */
-static int expand_files(struct files_struct *files, int nr)
-{
-	int err, expand = 0;
-#ifdef FDSET_DEBUG	
-	printk (KERN_ERR "%s %d: nr = %d\n", __FUNCTION__, current->pid, nr);
-#endif
-	
-	if (nr >= files->max_fdset) {
-		expand = 1;
-		if ((err = expand_fdset(files, nr)))
-			goto out;
-	}
-	if (nr >= files->max_fds) {
-		expand = 1;
-		if ((err = expand_fd_array(files, nr)))
-			goto out;
-	}
-	err = expand;
- out:
-#ifdef FDSET_DEBUG	
-	if (err)
-		printk (KERN_ERR "%s %d: return %d\n", __FUNCTION__, current->pid, err);
-#endif
-	return err;
-}
-
 /*
  * locate_fd finds a free file descriptor in the open_fds fdset,
  * expanding the fd arrays if necessary.  Must be called with the
--- a/fs/file.c	Tue Jan 11 21:57:30 2005
+++ b/fs/file.c	Tue Jan 11 22:58:54 2005
@@ -53,7 +53,7 @@
  * spinlock held for write.
  */
 
-int expand_fd_array(struct files_struct *files, int nr)
+static int expand_fd_array(struct files_struct *files, int nr)
 	__releases(files->file_lock)
 	__acquires(files->file_lock)
 {
@@ -158,7 +158,7 @@
  * Expand the fdset in the files_struct.  Called with the files spinlock
  * held for write.
  */
-int expand_fdset(struct files_struct *files, int nr)
+static int expand_fdset(struct files_struct *files, int nr)
 	__releases(file->file_lock)
 	__acquires(file->file_lock)
 {
@@ -227,5 +227,36 @@
 		free_fdset(new_execset, nfds);
 	spin_lock(&files->file_lock);
 	return error;
+}
+
+/* 
+ * Expand files.
+ * Return <0 on error; 0 nothing done; 1 files expanded, we may have blocked. 
+ * Should be called with the files->file_lock spinlock held for write.
+ */
+int expand_files(struct files_struct *files, int nr)
+{
+	int err, expand = 0;
+#ifdef FDSET_DEBUG
+	printk (KERN_ERR "%s %d: nr = %d\n", __FUNCTION__, current->pid, nr);
+#endif
+
+	if (nr >= files->max_fdset) {
+		expand = 1;
+		if ((err = expand_fdset(files, nr)))
+			goto out;
+	}
+	if (nr >= files->max_fds) {
+		expand = 1;
+		if ((err = expand_fd_array(files, nr)))
+			goto out;
+	}
+	err = expand;
+ out:
+#ifdef FDSET_DEBUG
+	if (err)
+		printk (KERN_ERR "%s %d: return %d\n", __FUNCTION__, current->pid, err);
+#endif
+	return err;
 }
 
--- a/fs/open.c	Tue Jan 11 22:04:38 2005
+++ b/fs/open.c	Tue Jan 11 22:11:31 2005
@@ -856,26 +856,18 @@
 	if (fd >= current->signal->rlim[RLIMIT_NOFILE].rlim_cur)
 		goto out;
 
-	/* Do we need to expand the fdset array? */
-	if (fd >= files->max_fdset) {
-		error = expand_fdset(files, fd);
-		if (!error) {
-			error = -EMFILE;
-			goto repeat;
-		}
-		goto out;
-	}
-	
-	/* 
-	 * Check whether we need to expand the fd array.
-	 */
-	if (fd >= files->max_fds) {
-		error = expand_fd_array(files, fd);
-		if (!error) {
-			error = -EMFILE;
-			goto repeat;
-		}
+	/* Do we need to expand the fd array or fd set?  */
+	error = expand_files(files, fd);
+	if (error < 0)
 		goto out;
+
+	if (error) {
+		/*
+	 	 * If we needed to expand the fs array we
+		 * might have blocked - try again.
+		 */
+		error = -EMFILE;
+		goto repeat;
 	}
 
 	FD_SET(fd, files->open_fds);
--- a/kernel/fork.c	Tue Jan 11 21:57:04 2005
+++ b/kernel/fork.c	Tue Jan 11 22:53:15 2005
@@ -550,7 +550,7 @@
 {
 	struct files_struct *oldf, *newf;
 	struct file **old_fds, **new_fds;
-	int open_files, nfds, size, i, error = 0;
+	int open_files, size, i, error = 0, expand;
 
 	/*
 	 * A background process may not have any files ...
@@ -585,36 +585,32 @@
 	newf->open_fds	    = &newf->open_fds_init;
 	newf->fd	    = &newf->fd_array[0];
 
-	/* We don't yet have the oldf readlock, but even if the old
-           fdset gets grown now, we'll only copy up to "size" fds */
-	size = oldf->max_fdset;
-	if (size > __FD_SETSIZE) {
-		newf->max_fdset = 0;
-		spin_lock(&newf->file_lock);
-		error = expand_fdset(newf, size-1);
-		spin_unlock(&newf->file_lock);
-		if (error)
-			goto out_release;
-	}
 	spin_lock(&oldf->file_lock);
 
-	open_files = count_open_files(oldf, size);
+	open_files = count_open_files(oldf, oldf->max_fdset);
+	expand = 0;
 
 	/*
-	 * Check whether we need to allocate a larger fd array.
-	 * Note: we're not a clone task, so the open count won't
-	 * change.
+	 * Check whether we need to allocate a larger fd array or fd set.
+	 * Note: we're not a clone task, so the open count won't  change.
 	 */
-	nfds = NR_OPEN_DEFAULT;
-	if (open_files > nfds) {
-		spin_unlock(&oldf->file_lock);
+	if (open_files > newf->max_fdset) {
+		newf->max_fdset = 0;
+		expand = 1;
+	}
+	if (open_files > newf->max_fds) {
 		newf->max_fds = 0;
+		expand = 1;
+	}
+
+	/* if the old fdset gets grown now, we'll only copy up to "size" fds */
+	if (expand) {
+		spin_unlock(&oldf->file_lock);
 		spin_lock(&newf->file_lock);
-		error = expand_fd_array(newf, open_files-1);
+		error = expand_files(newf, open_files-1);
 		spin_unlock(&newf->file_lock);
-		if (error) 
+		if (error < 0)
 			goto out_release;
-		nfds = newf->max_fds;
 		spin_lock(&oldf->file_lock);
 	}
 
@@ -663,6 +659,7 @@
 out_release:
 	free_fdset (newf->close_on_exec, newf->max_fdset);
 	free_fdset (newf->open_fds, newf->max_fdset);
+	free_fd_array(newf->fd, newf->max_fds);
 	kmem_cache_free(files_cachep, newf);
 	goto out;
 }
