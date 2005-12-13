Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbVLMNqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbVLMNqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:46:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVLMNnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:43:42 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:15809 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932236AbVLMNn1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:43:27 -0500
Subject: [PATCH -mm 8/9] unshare system call: allow unsharing of vm
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134481313.25431.193.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 08:43:16 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH -mm 8/9] unshare system call: allow unsharing of vm

 fork.c |   90 +++++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 58 insertions(+), 32 deletions(-)
 
 
diff -Naurp 2.6.15-rc5-mm2+patch/kernel/fork.c 2.6.15-rc5-mm2+patch8/kernel/fork.c
--- 2.6.15-rc5-mm2+patch/kernel/fork.c	2005-12-12 19:31:48.000000000 +0000
+++ 2.6.15-rc5-mm2+patch8/kernel/fork.c	2005-12-12 22:20:29.000000000 +0000
@@ -445,6 +445,55 @@ void mm_release(struct task_struct *tsk,
 	}
 }
 
+/*
+ * Allocate a new mm structure and copy contents from the
+ * mm structure of the passed in task structure.
+ */
+static struct mm_struct *dup_mm(struct task_struct *tsk)
+{
+	struct mm_struct *mm, *oldmm = current->mm;
+	int err;
+
+	if (!oldmm)
+		return NULL;
+
+	mm = allocate_mm();
+	if (!mm)
+		goto fail_nomem;
+
+	memcpy(mm, oldmm, sizeof(*mm));
+
+	if (!mm_init(mm))
+		goto fail_nomem;
+
+	if (init_new_context(tsk, mm))
+		goto fail_nocontext;
+
+	err = dup_mmap(mm, oldmm);
+	if (err)
+		goto free_pt;
+
+	mm->hiwater_rss = get_mm_rss(mm);
+	mm->hiwater_vm = mm->total_vm;
+
+	return mm;
+
+free_pt:
+	mmput(mm);
+
+fail_nomem:
+	return NULL;
+
+fail_nocontext:
+	/*
+	 * If init_new_context() failed, we cannot use mmput() to free the mm
+	 * because it calls destroy_context()
+	 */
+	mm_free_pgd(mm);
+	free_mm(mm);
+	return NULL;
+}
+
 static int copy_mm(unsigned long clone_flags, struct task_struct * tsk)
 {
 	struct mm_struct * mm, *oldmm;
@@ -472,43 +521,17 @@ static int copy_mm(unsigned long clone_f
 	}
 
 	retval = -ENOMEM;
-	mm = allocate_mm();
+	mm = dup_mm(tsk);
 	if (!mm)
 		goto fail_nomem;
 
-	/* Copy the current MM stuff.. */
-	memcpy(mm, oldmm, sizeof(*mm));
-	if (!mm_init(mm))
-		goto fail_nomem;
-
-	if (init_new_context(tsk,mm))
-		goto fail_nocontext;
-
-	retval = dup_mmap(mm, oldmm);
-	if (retval)
-		goto free_pt;
-
-	mm->hiwater_rss = get_mm_rss(mm);
-	mm->hiwater_vm = mm->total_vm;
-
 good_mm:
 	tsk->mm = mm;
 	tsk->active_mm = mm;
 	return 0;
 
-free_pt:
-	mmput(mm);
 fail_nomem:
 	return retval;
-
-fail_nocontext:
-	/*
-	 * If init_new_context() failed, we cannot use mmput() to free the mm
-	 * because it calls destroy_context()
-	 */
-	mm_free_pgd(mm);
-	free_mm(mm);
-	return retval;
 }
 
 static inline struct fs_struct *__copy_fs_struct(struct fs_struct *old)
@@ -1422,18 +1445,21 @@ static int unshare_sighand(unsigned long
 }
 
 /*
- * Unsharing of vm for tasks created with CLONE_VM is not supported yet
+ * Unshare vm if it is being shared
  */
 static int unshare_vm(unsigned long unshare_flags, struct mm_struct **new_mmp)
 {
-	struct mm_struct *mm = current->mm;
+	struct mm_struct *mm = current->mm, *new_mm;
 
 	if ((unshare_flags & CLONE_VM) &&
-	    (mm && atomic_read(&mm->mm_users) > 1))
-		return -EINVAL;
+	    (mm && atomic_read(&mm->mm_users) > 1)) {
+		new_mm = dup_mm(current);
+		if (!new_mm)
+			return -ENOMEM;
+		*new_mmp = new_mm;
+	}
 
 	return 0;
-
 }
 
 /*


