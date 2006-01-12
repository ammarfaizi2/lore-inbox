Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964939AbWALERI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964939AbWALERI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:17:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWALEP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:15:58 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:16813 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965013AbWALEPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:30 -0500
Subject: [PATCH -mm 6/10] unshare system call -v5 : unshare files
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137039003.7488.214.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:10:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 6/10] unshare system call: allow unsharing of files

If the file descriptor structure is being shared, allocate a new one and
copy information from the current, shared, structure.

Changes since -v4 of this patch submitted on 12/13/05:
	- Fixed intermittent oops encountered when starting wine applications.
	  Instead of passing current task structure to dup_fd and obtaining
	  files pointer from it, pass the old files pointer because
	  copy_files, when called from unshare_files, clears the
	  current->files pointer.

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 fork.c |   81 ++++++++++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 51 insertions(+), 30 deletions(-)

diff -Naurp 2.6.15-mm3+unsh-vm/kernel/fork.c 2.6.15-mm3+unsh-fd/kernel/fork.c
--- 2.6.15-mm3+unsh-vm/kernel/fork.c	2006-01-12 00:47:33.000000000 +0000
+++ 2.6.15-mm3+unsh-fd/kernel/fork.c	2006-01-12 00:56:53.000000000 +0000
@@ -620,32 +620,17 @@ out:
 	return newf;
 }
 
-static int copy_files(unsigned long clone_flags, struct task_struct * tsk)
+/*
+ * Allocate a new files structure and copy contents from the
+ * passed in files structure.
+ */
+static struct files_struct *dup_fd(struct files_struct *oldf, int *errorp)
 {
-	struct files_struct *oldf, *newf;
+	struct files_struct *newf;
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
-
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
@@ -674,9 +659,9 @@ static int copy_files(unsigned long clon
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
@@ -725,10 +710,8 @@ static int copy_files(unsigned long clon
 		memset(&new_fdt->close_on_exec->fds_bits[start], 0, left);
 	}
 
-	tsk->files = newf;
-	error = 0;
 out:
-	return error;
+	return newf;
 
 out_release:
 	free_fdset (new_fdt->close_on_exec, new_fdt->max_fdset);
@@ -738,6 +721,40 @@ out_release:
 	goto out;
 }
 
+static int copy_files(unsigned long clone_flags, struct task_struct * tsk)
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
+	newf = dup_fd(oldf, &error);
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
@@ -1463,15 +1480,19 @@ static int unshare_vm(unsigned long unsh
 }
 
 /*
- * Unsharing of files for tasks created with CLONE_FILES is not supported yet
+ * Unshare file descriptor table if it is being shared
  */
 static int unshare_fd(unsigned long unshare_flags, struct files_struct **new_fdp)
 {
 	struct files_struct *fd = current->files;
+	int error = 0;
 
 	if ((unshare_flags & CLONE_FILES) &&
-	    (fd && atomic_read(&fd->count) > 1))
-		return -EINVAL;
+	    (fd && atomic_read(&fd->count) > 1)) {
+		*new_fdp = dup_fd(fd, &error);
+		if (!*new_fdp)
+			return error;
+	}
 
 	return 0;
 }


