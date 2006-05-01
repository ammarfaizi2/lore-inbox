Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWEAK2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWEAK2q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 06:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWEAK2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 06:28:45 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3976 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751172AbWEAK2o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 06:28:44 -0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH 03/14] move call of audit_free() into do_exit()
Message-Id: <E1FaVdz-00051G-ID@ZenIV.linux.org.uk>
From: Al Viro <viro@ftp.linux.org.uk>
Date: Mon, 01 May 2006 11:28:43 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>
Date: Wed Mar 29 20:30:19 2006 -0500

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

---

 kernel/auditsc.c |    9 +--------
 kernel/exit.c    |    3 +++
 kernel/fork.c    |    2 --
 3 files changed, 4 insertions(+), 10 deletions(-)

fa84cb935d4ec601528f5e2f0d5d31e7876a5044
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 4052f0a..8ec52ff 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -698,19 +698,12 @@ static void audit_log_exit(struct audit_
  * audit_free - free a per-task audit context
  * @tsk: task whose audit context block to free
  *
- * Called from copy_process and __put_task_struct.
+ * Called from copy_process and do_exit
  */
 void audit_free(struct task_struct *tsk)
 {
 	struct audit_context *context;
 
-	/*
-	 * No need to lock the task - when we execute audit_free()
-	 * then the task has no external references anymore, and
-	 * we are tearing it down. (The locking also confuses
-	 * DEBUG_LOCKDEP - this freeing may occur in softirq
-	 * contexts as well, via RCU.)
-	 */
 	context = audit_get_context(tsk, 0, 0);
 	if (likely(!context))
 		return;
diff --git a/kernel/exit.c b/kernel/exit.c
index f86434d..e95b932 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -35,6 +35,7 @@ #include <linux/mutex.h>
 #include <linux/futex.h>
 #include <linux/compat.h>
 #include <linux/pipe_fs_i.h>
+#include <linux/audit.h> /* for audit_free() */
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
@@ -910,6 +911,8 @@ #ifdef CONFIG_COMPAT
 	if (unlikely(tsk->compat_robust_list))
 		compat_exit_robust_list(tsk);
 #endif
+	if (unlikely(tsk->audit_context))
+		audit_free(tsk);
 	exit_mm(tsk);
 
 	exit_sem(tsk);
diff --git a/kernel/fork.c b/kernel/fork.c
index d2fa57d..ac8100e 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -114,8 +114,6 @@ void __put_task_struct(struct task_struc
 	WARN_ON(atomic_read(&tsk->usage));
 	WARN_ON(tsk == current);
 
-	if (unlikely(tsk->audit_context))
-		audit_free(tsk);
 	security_task_free(tsk);
 	free_uid(tsk->user);
 	put_group_info(tsk->group_info);
-- 
1.3.0.g0080f

