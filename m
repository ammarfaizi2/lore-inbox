Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316978AbSF0VRQ>; Thu, 27 Jun 2002 17:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316979AbSF0VRP>; Thu, 27 Jun 2002 17:17:15 -0400
Received: from [148.246.64.61] ([148.246.64.61]:18436 "EHLO zion.sytes.net")
	by vger.kernel.org with ESMTP id <S316978AbSF0VRM>;
	Thu, 27 Jun 2002 17:17:12 -0400
Date: Thu, 27 Jun 2002 16:19:22 -0500
From: Felipe Contreras <al593181@mail.mty.itesm.mx>
To: linux-kernel@vger.kernel.org
Subject: Very weird bug in fs/exec.c
Message-ID: <20020627211922.GA14184@zion.mty.itesm.mx>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've found a weird bug that seems to only happend in my system. It makes
recursive makes segfault, like:

test:
	( make -v )

After a lot of work tracking it I finally found what causes it, I'm attaching
the patch that generates the bug, it's a diff from 2.5.18 to 2.5.19.

I'm saying it's weird because just adding a printk before do_execve returns
successfully makes the bug dissapear.

BTW, yes, my system is very special.

-- 
Felipe Contreras

--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="bug.diff"

--- a/fs/exec.c	Wed May 29 11:43:02 2002
+++ b/fs/exec.c	Wed May 29 11:43:02 2002
@@ -391,48 +391,31 @@
 	return result;
 }
 
-static int exec_mmap(void)
+static int exec_mmap(struct mm_struct *mm)
 {
-	struct mm_struct * mm, * old_mm;
+	struct mm_struct * old_mm, *active_mm;
 
-	old_mm = current->mm;
-	if (old_mm && atomic_read(&old_mm->mm_users) == 1) {
-		mm_release();
-		exit_mmap(old_mm);
-		return 0;
-	}
-
-	mm = mm_alloc();
-	if (mm) {
-		struct mm_struct *active_mm;
-
-		if (init_new_context(current, mm)) {
-			mmdrop(mm);
-			return -ENOMEM;
-		}
+	/* Add it to the list of mm's */
+	spin_lock(&mmlist_lock);
+	list_add(&mm->mmlist, &init_mm.mmlist);
+	mmlist_nr++;
+	spin_unlock(&mmlist_lock);
 
-		/* Add it to the list of mm's */
-		spin_lock(&mmlist_lock);
-		list_add(&mm->mmlist, &init_mm.mmlist);
-		mmlist_nr++;
-		spin_unlock(&mmlist_lock);
-
-		task_lock(current);
-		active_mm = current->active_mm;
-		current->mm = mm;
-		current->active_mm = mm;
-		activate_mm(active_mm, mm);
-		task_unlock(current);
-		mm_release();
-		if (old_mm) {
-			if (active_mm != old_mm) BUG();
-			mmput(old_mm);
-			return 0;
-		}
-		mmdrop(active_mm);
+	task_lock(current);
+	old_mm = current->mm;
+	active_mm = current->active_mm;
+	current->mm = mm;
+	current->active_mm = mm;
+	activate_mm(active_mm, mm);
+	task_unlock(current);
+	mm_release();
+	if (old_mm) {
+		if (active_mm != old_mm) BUG();
+		mmput(old_mm);
 		return 0;
 	}
-	return -ENOMEM;
+	mmdrop(active_mm);
+	return 0;
 }
 
 /*
@@ -571,7 +554,7 @@
 	/* 
 	 * Release all of the old mmap stuff
 	 */
-	retval = exec_mmap();
+	retval = exec_mmap(bprm->mm);
 	if (retval) goto mmap_failed;
 
 	/* This is the point of no return */
@@ -902,17 +885,23 @@
 	bprm.sh_bang = 0;
 	bprm.loader = 0;
 	bprm.exec = 0;
-	if ((bprm.argc = count(argv, bprm.p / sizeof(void *))) < 0) {
-		allow_write_access(file);
-		fput(file);
-		return bprm.argc;
-	}
 
-	if ((bprm.envc = count(envp, bprm.p / sizeof(void *))) < 0) {
-		allow_write_access(file);
-		fput(file);
-		return bprm.envc;
-	}
+	bprm.mm = mm_alloc();
+	retval = -ENOMEM;
+	if (!bprm.mm)
+		goto out_file;
+
+	retval = init_new_context(current, bprm.mm);
+	if (retval < 0)
+		goto out_mm;
+
+	bprm.argc = count(argv, bprm.p / sizeof(void *));
+	if ((retval = bprm.argc) < 0)
+		goto out_mm;
+
+	bprm.envc = count(envp, bprm.p / sizeof(void *));
+	if ((retval = bprm.envc) < 0)
+		goto out_mm;
 
 	retval = prepare_binprm(&bprm);
 	if (retval < 0) 
@@ -938,16 +927,20 @@
 
 out:
 	/* Something went wrong, return the inode and free the argument pages*/
-	allow_write_access(bprm.file);
-	if (bprm.file)
-		fput(bprm.file);
-
 	for (i = 0 ; i < MAX_ARG_PAGES ; i++) {
 		struct page * page = bprm.page[i];
 		if (page)
 			__free_page(page);
 	}
 
+out_mm:
+	mmdrop(bprm.mm);
+
+out_file:
+	if (bprm.file) {
+		allow_write_access(bprm.file);
+		fput(bprm.file);
+	}
 	return retval;
 }
 
--- a/include/linux/binfmts.h	Wed May 29 11:43:03 2002
+++ b/include/linux/binfmts.h	Wed May 29 11:43:03 2002
@@ -22,6 +22,7 @@
 struct linux_binprm{
 	char buf[BINPRM_BUF_SIZE];
 	struct page *page[MAX_ARG_PAGES];
+	struct mm_struct *mm;
 	unsigned long p; /* current top of mem */
 	int sh_bang;
 	struct file * file;

--BOKacYhQ+x31HxR3--
