Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751136AbWEAK3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbWEAK3J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWEAK3I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:29:08 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:4488 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751136AbWEAK2y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:28:54 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 04/14] drop gfp_mask in audit_log_exit()
Message-Id: <E1FaVe9-00051R-If@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:28:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed Mar 29 20:17:10 2006 -0500

now we can do that - all callers are process-synchronous and do not hold
any locks.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 kernel/auditsc.c |   62 ++++++++++++++++++++++++++++--------------------------
 1 files changed, 32 insertions(+), 30 deletions(-)

e495149b173d8e133e1f6f2eb86fd97be7e92010
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 8ec52ff..ba0ec1b 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -506,7 +506,7 @@ static inline void audit_free_context(st
 		printk(KERN_ERR "audit: freed %d contexts\n", count);
 }
 
-static void audit_log_task_context(struct audit_buffer *ab, gfp_t gfp_mask)
+static void audit_log_task_context(struct audit_buffer *ab)
 {
 	char *ctx = NULL;
 	ssize_t len = 0;
@@ -518,7 +518,7 @@ static void audit_log_task_context(struc
 		return;
 	}
 
-	ctx = kmalloc(len, gfp_mask);
+	ctx = kmalloc(len, GFP_KERNEL);
 	if (!ctx)
 		goto error_path;
 
@@ -536,47 +536,46 @@ error_path:
 	return;
 }
 
-static void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk, gfp_t gfp_mask)
+static void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk)
 {
 	char name[sizeof(tsk->comm)];
 	struct mm_struct *mm = tsk->mm;
 	struct vm_area_struct *vma;
 
+	/* tsk == current */
+
 	get_task_comm(name, tsk);
 	audit_log_format(ab, " comm=");
 	audit_log_untrustedstring(ab, name);
 
-	if (!mm)
-		return;
-
-	/*
-	 * this is brittle; all callers that pass GFP_ATOMIC will have
-	 * NULL tsk->mm and we won't get here.
-	 */
-	down_read(&mm->mmap_sem);
-	vma = mm->mmap;
-	while (vma) {
-		if ((vma->vm_flags & VM_EXECUTABLE) &&
-		    vma->vm_file) {
-			audit_log_d_path(ab, "exe=",
-					 vma->vm_file->f_dentry,
-					 vma->vm_file->f_vfsmnt);
-			break;
+	if (mm) {
+		down_read(&mm->mmap_sem);
+		vma = mm->mmap;
+		while (vma) {
+			if ((vma->vm_flags & VM_EXECUTABLE) &&
+			    vma->vm_file) {
+				audit_log_d_path(ab, "exe=",
+						 vma->vm_file->f_dentry,
+						 vma->vm_file->f_vfsmnt);
+				break;
+			}
+			vma = vma->vm_next;
 		}
-		vma = vma->vm_next;
+		up_read(&mm->mmap_sem);
 	}
-	up_read(&mm->mmap_sem);
-	audit_log_task_context(ab, gfp_mask);
+	audit_log_task_context(ab);
 }
 
-static void audit_log_exit(struct audit_context *context, struct task_struct *tsk, gfp_t gfp_mask)
+static void audit_log_exit(struct audit_context *context, struct task_struct *tsk)
 {
 	int i;
 	struct audit_buffer *ab;
 	struct audit_aux_data *aux;
 	const char *tty;
 
-	ab = audit_log_start(context, gfp_mask, AUDIT_SYSCALL);
+	/* tsk == current */
+
+	ab = audit_log_start(context, GFP_KERNEL, AUDIT_SYSCALL);
 	if (!ab)
 		return;		/* audit_panic has been called */
 	audit_log_format(ab, "arch=%x syscall=%d",
@@ -607,12 +606,12 @@ static void audit_log_exit(struct audit_
 		  context->gid,
 		  context->euid, context->suid, context->fsuid,
 		  context->egid, context->sgid, context->fsgid, tty);
-	audit_log_task_info(ab, gfp_mask);
+	audit_log_task_info(ab, tsk);
 	audit_log_end(ab);
 
 	for (aux = context->aux; aux; aux = aux->next) {
 
-		ab = audit_log_start(context, gfp_mask, aux->type);
+		ab = audit_log_start(context, GFP_KERNEL, aux->type);
 		if (!ab)
 			continue; /* audit_panic has been called */
 
@@ -649,7 +648,7 @@ static void audit_log_exit(struct audit_
 	}
 
 	if (context->pwd && context->pwdmnt) {
-		ab = audit_log_start(context, gfp_mask, AUDIT_CWD);
+		ab = audit_log_start(context, GFP_KERNEL, AUDIT_CWD);
 		if (ab) {
 			audit_log_d_path(ab, "cwd=", context->pwd, context->pwdmnt);
 			audit_log_end(ab);
@@ -659,7 +658,7 @@ static void audit_log_exit(struct audit_
 		unsigned long ino  = context->names[i].ino;
 		unsigned long pino = context->names[i].pino;
 
-		ab = audit_log_start(context, gfp_mask, AUDIT_PATH);
+		ab = audit_log_start(context, GFP_KERNEL, AUDIT_PATH);
 		if (!ab)
 			continue; /* audit_panic has been called */
 
@@ -712,8 +711,9 @@ void audit_free(struct task_struct *tsk)
 	 * function (e.g., exit_group), then free context block. 
 	 * We use GFP_ATOMIC here because we might be doing this 
 	 * in the context of the idle thread */
+	/* that can happen only if we are called from do_exit() */
 	if (context->in_syscall && context->auditable)
-		audit_log_exit(context, tsk, GFP_ATOMIC);
+		audit_log_exit(context, tsk);
 
 	audit_free_context(context);
 }
@@ -821,6 +821,8 @@ void audit_syscall_exit(struct task_stru
 {
 	struct audit_context *context;
 
+	/* tsk == current */
+
 	get_task_struct(tsk);
 	task_lock(tsk);
 	context = audit_get_context(tsk, valid, return_code);
@@ -832,7 +834,7 @@ void audit_syscall_exit(struct task_stru
 		goto out;
 
 	if (context->in_syscall && context->auditable)
-		audit_log_exit(context, tsk, GFP_KERNEL);
+		audit_log_exit(context, tsk);
 
 	context->in_syscall = 0;
 	context->auditable  = 0;
-- 
1.3.0.g0080f

