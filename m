Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965149AbWIEFIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965149AbWIEFIj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 01:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWIEFIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 01:08:39 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:60141 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965149AbWIEFIi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 01:08:38 -0400
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Clean up expand_fdtable() and expand_files().
Date: Mon, 4 Sep 2006 22:08:36 -0700
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609042208.36894.vlobanov@speakeasy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch performs a code cleanup against the expand_fdtable() and 
expand_files() functions inside fs/file.c. It aims to make the flow of code 
within these functions simpler and easier to understand, via added comments 
and modest refactoring. The patch was generated against 2.6.18-rc5-mm1, and 
was successfully run live. Please apply.

(I'm trying out KMail for this patch. I tested this mailer beforehand to make 
sure the patch will come out unmangled, but, as with all things software, 
success is far from guaranteed. :) Please yell if the patch is borked.)

Signed-off-by: Vadim Lobanov <vlobanov@speakeasy.net>

diff -Npru linux-a/fs/file.c linux-b/fs/file.c
--- linux-a/fs/file.c	2006-09-01 20:34:12.000000000 -0700
+++ linux-b/fs/file.c	2006-09-04 16:42:33.000000000 -0700
@@ -296,37 +296,30 @@ static int expand_fdtable(struct files_s
 	__releases(files->file_lock)
 	__acquires(files->file_lock)
 {
-	int error = 0;
-	struct fdtable *fdt;
-	struct fdtable *nfdt = NULL;
+	struct fdtable *new_fdt, *cur_fdt;
 
 	spin_unlock(&files->file_lock);
-	nfdt = alloc_fdtable(nr);
-	if (!nfdt) {
-		error = -ENOMEM;
-		spin_lock(&files->file_lock);
-		goto out;
-	}
-
+	new_fdt = alloc_fdtable(nr);
 	spin_lock(&files->file_lock);
-	fdt = files_fdtable(files);
+	if (!new_fdt)
+		return -ENOMEM;
 	/*
-	 * Check again since another task may have expanded the
-	 * fd table while we dropped the lock
+	 * Check again since another task may have expanded the fd table while
+	 * we dropped the lock
 	 */
-	if (nr >= fdt->max_fds || nr >= fdt->max_fdset) {
-		copy_fdtable(nfdt, fdt);
+	cur_fdt = files_fdtable(files);
+	if (nr >= cur_fdt->max_fds || nr >= cur_fdt->max_fdset) {
+		/* Continue as planned */
+		copy_fdtable(new_fdt, cur_fdt);
+		rcu_assign_pointer(files->fdt, new_fdt);
+		free_fdtable(cur_fdt);
 	} else {
-		/* Somebody expanded while we dropped file_lock */
+		/* Somebody else expanded, so undo our attempt */
 		spin_unlock(&files->file_lock);
-		__free_fdtable(nfdt);
+		__free_fdtable(new_fdt);
 		spin_lock(&files->file_lock);
-		goto out;
 	}
-	rcu_assign_pointer(files->fdt, nfdt);
-	free_fdtable(fdt);
-out:
-	return error;
+	return 1;
 }
 
 /*
@@ -336,23 +329,19 @@ out:
  */
 int expand_files(struct files_struct *files, int nr)
 {
-	int err, expand = 0;
 	struct fdtable *fdt;
 
 	fdt = files_fdtable(files);
-	if (nr >= fdt->max_fdset || nr >= fdt->max_fds) {
-		if (fdt->max_fdset >= NR_OPEN ||
-			fdt->max_fds >= NR_OPEN || nr >= NR_OPEN) {
-			err = -EMFILE;
-			goto out;
-		}
-		expand = 1;
-		if ((err = expand_fdtable(files, nr)))
-			goto out;
-	}
-	err = expand;
-out:
-	return err;
+	/* Do we need to expand? */
+	if (nr < fdt->max_fdset && nr < fdt->max_fds)
+		return 0;
+	/* Can we expand? */
+	if (fdt->max_fdset >= NR_OPEN || fdt->max_fds >= NR_OPEN ||
+	    nr >= NR_OPEN)
+		return -EMFILE;
+
+	/* All good, so we try */
+	return expand_fdtable(files, nr);
 }
 
 static void __devinit fdtable_defer_list_init(int cpu)
