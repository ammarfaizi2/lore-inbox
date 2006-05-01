Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWEAKat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWEAKat (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbWEAK37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:29:59 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5256 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751173AbWEAK3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:29:14 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 06/14] no need to wank with task_lock() and pinning task down in audit_syscall_exit()
Message-Id: <E1FaVeT-00051m-JE@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:29:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed Mar 29 20:26:24 2006 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 kernel/auditsc.c |   10 +---------
 1 files changed, 1 insertions(+), 9 deletions(-)

97e94c453073a2aba4bb5e0825ddc5e923debf11
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 7ed82b0..8aca4ab 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -329,7 +329,6 @@ static enum audit_state audit_filter_sys
 	return AUDIT_BUILD_CONTEXT;
 }
 
-/* This should be called with task_lock() held. */
 static inline struct audit_context *audit_get_context(struct task_struct *tsk,
 						      int return_valid,
 						      int return_code)
@@ -823,15 +822,10 @@ void audit_syscall_exit(int valid, long 
 	struct task_struct *tsk = current;
 	struct audit_context *context;
 
-	get_task_struct(tsk);
-	task_lock(tsk);
 	context = audit_get_context(tsk, valid, return_code);
-	task_unlock(tsk);
 
-	/* Not having a context here is ok, since the parent may have
-	 * called __put_task_struct. */
 	if (likely(!context))
-		goto out;
+		return;
 
 	if (context->in_syscall && context->auditable)
 		audit_log_exit(context, tsk);
@@ -849,8 +843,6 @@ void audit_syscall_exit(int valid, long 
 		audit_free_aux(context);
 		tsk->audit_context = context;
 	}
- out:
-	put_task_struct(tsk);
 }
 
 /**
-- 
1.3.0.g0080f

