Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWEAK2Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWEAK2Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:28:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWEAK2Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:28:25 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3464 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751120AbWEAK2Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:28:24 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 01/14] deal with deadlocks in audit_free()
Message-Id: <E1FaVdf-00050r-HP@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:28:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed Mar 29 20:02:55 2006 -0500

Don't assume that audit_log_exit() et.al. are called for the context of
current; pass task explictly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 kernel/auditsc.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

45d9bb0e37668b7c64d1e49e98fbc4733c23b334
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7f160df..4052f0a 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -536,13 +536,13 @@ error_path:
 	return;
 }
 
-static void audit_log_task_info(struct audit_buffer *ab, gfp_t gfp_mask)
+static void audit_log_task_info(struct audit_buffer *ab, struct task_struct *tsk, gfp_t gfp_mask)
 {
-	char name[sizeof(current->comm)];
-	struct mm_struct *mm = current->mm;
+	char name[sizeof(tsk->comm)];
+	struct mm_struct *mm = tsk->mm;
 	struct vm_area_struct *vma;
 
-	get_task_comm(name, current);
+	get_task_comm(name, tsk);
 	audit_log_format(ab, " comm=");
 	audit_log_untrustedstring(ab, name);
 
@@ -551,7 +551,7 @@ static void audit_log_task_info(struct a
 
 	/*
 	 * this is brittle; all callers that pass GFP_ATOMIC will have
-	 * NULL current->mm and we won't get here.
+	 * NULL tsk->mm and we won't get here.
 	 */
 	down_read(&mm->mmap_sem);
 	vma = mm->mmap;
@@ -569,7 +569,7 @@ static void audit_log_task_info(struct a
 	audit_log_task_context(ab, gfp_mask);
 }
 
-static void audit_log_exit(struct audit_context *context, gfp_t gfp_mask)
+static void audit_log_exit(struct audit_context *context, struct task_struct *tsk, gfp_t gfp_mask)
 {
 	int i;
 	struct audit_buffer *ab;
@@ -587,8 +587,8 @@ static void audit_log_exit(struct audit_
 		audit_log_format(ab, " success=%s exit=%ld", 
 				 (context->return_valid==AUDITSC_SUCCESS)?"yes":"no",
 				 context->return_code);
-	if (current->signal->tty && current->signal->tty->name)
-		tty = current->signal->tty->name;
+	if (tsk->signal && tsk->signal->tty && tsk->signal->tty->name)
+		tty = tsk->signal->tty->name;
 	else
 		tty = "(none)";
 	audit_log_format(ab,
@@ -720,7 +720,7 @@ void audit_free(struct task_struct *tsk)
 	 * We use GFP_ATOMIC here because we might be doing this 
 	 * in the context of the idle thread */
 	if (context->in_syscall && context->auditable)
-		audit_log_exit(context, GFP_ATOMIC);
+		audit_log_exit(context, tsk, GFP_ATOMIC);
 
 	audit_free_context(context);
 }
@@ -839,7 +839,7 @@ void audit_syscall_exit(struct task_stru
 		goto out;
 
 	if (context->in_syscall && context->auditable)
-		audit_log_exit(context, GFP_KERNEL);
+		audit_log_exit(context, tsk, GFP_KERNEL);
 
 	context->in_syscall = 0;
 	context->auditable  = 0;
-- 
1.3.0.g0080f

