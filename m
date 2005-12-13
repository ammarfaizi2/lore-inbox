Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030342AbVLMWzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbVLMWzW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 17:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbVLMWzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 17:55:19 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:65238 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030342AbVLMWzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 17:55:09 -0500
Subject: [PATCH -mm 8/9] unshare system call: allow unsharing of vm
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: viro@ftp.linux.org.uk, chrisw@osdl.org, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, mingo@elte.hu,
       linuxram@us.ibm.com, jmorris@namei.org, sds@tycho.nsa.gov,
       janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134514301.11972.210.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Tue, 13 Dec 2005 17:54:56 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
[PATCH -mm 8/9] unshare system call: allow unsharing of vm

If vm structure is being shared, allocate a new one and
copy information from the current, shared, structure.

Changes since the first submission of this patch on 12/12/05:
	- Removed an unnecessary local variable (12/13/05)
 
Signed-off-by: Janak Desai <janak@us.ibm.com>
 
---
 
 fork.c |   87 +++++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 56 insertions(+), 31 deletions(-)
 
diff -Naurp 2.6.15-rc5-mm2+patch/kernel/fork.c 2.6.15-rc5-mm2+patch8/kernel/fork.c
--- 2.6.15-rc5-mm2+patch/kernel/fork.c	2005-12-13 18:38:26.000000000 +0000
+++ 2.6.15-rc5-mm2+patch8/kernel/fork.c	2005-12-13 19:40:56.000000000 +0000
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
@@ -1422,18 +1445,20 @@ static int unshare_sighand(unsigned long
 }
 
 /*
- * Unsharing of vm for tasks created with CLONE_VM is not supported yet
+ * Unshare vm if it is being shared
  */
 static int unshare_vm(unsigned long unshare_flags, struct mm_struct **new_mmp)
 {
 	struct mm_struct *mm = current->mm;
 
 	if ((unshare_flags & CLONE_VM) &&
-	    (mm && atomic_read(&mm->mm_users) > 1))
-		return -EINVAL;
+	    (mm && atomic_read(&mm->mm_users) > 1)) {
+		*new_mmp = dup_mm(current);
+		if (!*new_mmp)
+			return -ENOMEM;
+	}
 
 	return 0;
-
 }
 
 /*


