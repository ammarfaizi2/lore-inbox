Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965026AbWALERH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWALERH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWALEQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:16:00 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:48612 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964939AbWALEP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:28 -0500
Subject: [PATCH -mm 5/10] unshare system call -v5 : unshare vm
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137039000.7488.212.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:10:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH -mm 5/10] unshare system call: allow unsharing of vm

If vm structure is being shared, allocate a new one and
copy information from the current, shared, structure.

Changes since -v4 of this patch submitted on 12/13/05:
	- none

Signed-off-by: Janak Desai <janak@us.ibm.com>

---

 fork.c |   87 +++++++++++++++++++++++++++++++++++++++++------------------------
 1 files changed, 56 insertions(+), 31 deletions(-)

diff -Naurp 2.6.15-mm3+unsh-ns/kernel/fork.c 2.6.15-mm3+unsh-vm/kernel/fork.c
--- 2.6.15-mm3+unsh-ns/kernel/fork.c	2006-01-12 00:39:49.000000000 +0000
+++ 2.6.15-mm3+unsh-vm/kernel/fork.c	2006-01-12 00:47:33.000000000 +0000
@@ -446,6 +446,55 @@ void mm_release(struct task_struct *tsk,
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
@@ -473,43 +522,17 @@ static int copy_mm(unsigned long clone_f
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
@@ -1423,18 +1446,20 @@ static int unshare_sighand(unsigned long
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


