Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVLMDAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVLMDAd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 22:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932384AbVLMDAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 22:00:33 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:57505 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932383AbVLMDAW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 22:00:22 -0500
Subject: [PATCH -mm 9/9] unshare system call : allow unsharing of files
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134442764.14136.132.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Mon, 12 Dec 2005 22:00:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 9/9] unshare system call: allow unsharing of files


 fork.c |   82
++++++++++++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 53 insertions(+), 29 deletions(-)
 
 
diff -Naurp 2.6.15-rc5-mm2+patch/kernel/fork.c
2.6.15-rc5-mm2+patch9/kernel/fork.c
--- 2.6.15-rc5-mm2+patch/kernel/fork.c	2005-12-12 19:31:48.000000000
+0000
+++ 2.6.15-rc5-mm2+patch9/kernel/fork.c	2005-12-12 22:30:50.000000000
+0000
@@ -596,32 +596,19 @@ out:
 	return newf;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct *
tsk)
+/*
+ * Allocate a new files structure and copy contents from the
+ * files structure of the passed in task structure.
+ */
+static struct files_struct *dup_fd(struct task_struct *tsk, int
*errorp)
 {
 	struct files_struct *oldf, *newf;
 	struct file **old_fds, **new_fds;
-	int open_files, size, i, error = 0, expand;
+	int open_files, size, i, expand;
 	struct fdtable *old_fdt, *new_fdt;
 
-	/*
-	 * A background process may not have any files ...
-	 */
-	oldf = current->files;
-	if (!oldf)
-		goto out;
+	oldf = tsk->files;
 
-	if (clone_flags & CLONE_FILES) {
-		atomic_inc(&oldf->count);
-		goto out;
-	}
-
-	/*
-	 * Note: we may be using current for both targets (See exec.c)
-	 * This works because we cache current->files (old) as oldf. Don't
-	 * break this.
-	 */
-	tsk->files = NULL;
-	error = -ENOMEM;
 	newf = alloc_files();
 	if (!newf)
 		goto out;
@@ -650,9 +637,9 @@ static int copy_files(unsigned long clon
 	if (expand) {
 		spin_unlock(&oldf->file_lock);
 		spin_lock(&newf->file_lock);
-		error = expand_files(newf, open_files-1);
+		*errorp = expand_files(newf, open_files-1);
 		spin_unlock(&newf->file_lock);
-		if (error < 0)
+		if (*errorp < 0)
 			goto out_release;
 		new_fdt = files_fdtable(newf);
 		/*
@@ -701,10 +688,8 @@ static int copy_files(unsigned long clon
 		memset(&new_fdt->close_on_exec->fds_bits[start], 0, left);
 	}
 
-	tsk->files = newf;
-	error = 0;
 out:
-	return error;
+	return newf;
 
 out_release:
 	free_fdset (new_fdt->close_on_exec, new_fdt->max_fdset);
@@ -714,6 +699,40 @@ out_release:
 	goto out;
 }
 
+static int copy_files(unsigned long clone_flags, struct task_struct *
tsk)
+{
+	struct files_struct *oldf, *newf;
+	int error = 0;
+
+	/*
+	 * A background process may not have any files ...
+	 */
+	oldf = current->files;
+	if (!oldf)
+		goto out;
+
+	if (clone_flags & CLONE_FILES) {
+		atomic_inc(&oldf->count);
+		goto out;
+	}
+
+	/*
+	 * Note: we may be using current for both targets (See exec.c)
+	 * This works because we cache current->files (old) as oldf. Don't
+	 * break this.
+	 */
+	tsk->files = NULL;
+	error = -ENOMEM;
+	newf = dup_fd(current, &error);
+	if (!newf)
+		goto out;
+
+	tsk->files = newf;
+	error = 0;
+out:
+	return error;
+}
+
 /*
  *	Helper to unshare the files of the current task.
  *	We don't want to expose copy_files internals to
@@ -1437,15 +1456,20 @@ static int unshare_vm(unsigned long unsh
 }
 
 /*
- * Unsharing of files for tasks created with CLONE_FILES is not
supported yet
+ * Unshare file descriptor table if it is being shared
  */
 static int unshare_fd(unsigned long unshare_flags, struct files_struct
**new_fdp)
 {
-	struct files_struct *fd = current->files;
+	struct files_struct *fd = current->files, *new_fd;
+	int error = 0;
 
 	if ((unshare_flags & CLONE_FILES) &&
-	    (fd && atomic_read(&fd->count) > 1))
-		return -EINVAL;
+	    (fd && atomic_read(&fd->count) > 1)) {
+		new_fd = dup_fd(current, &error);
+		if (!new_fd)
+			return error;
+		*new_fdp = new_fd;
+	}
 
 	return 0;
 }


