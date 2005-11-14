Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932164AbVKNVeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932164AbVKNVeE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 16:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbVKNVd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 16:33:57 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:63185 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932147AbVKNVdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 16:33:25 -0500
Message-Id: <20051114212530.973026000@sergelap>
References: <20051114212341.724084000@sergelap>
Date: Mon, 14 Nov 2005 15:23:54 -0600
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Dave Hansen <haveblue@us.ibm.com>
Subject: [RFC] [PATCH 13/13] Define new task_pid api
Content-Disposition: inline; filename=BC-define-pid-handlers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replace-Subject: Define new task_pid api
From: Serge Hallyn <serue@us.ibm.com>

Actually define the task_pid() and task_tgid() functions.  Also
replace pid with __pid so as to make sure any missed accessors are
caught.

The resulting object code seems to be identical in most cases, and is
actually shorter in cases where current->pid is used twice in a row,
as it does not dereference task-> twice.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 include/linux/sched.h |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6.15-rc1/include/linux/sched.h
===================================================================
--- linux-2.6.15-rc1.orig/include/linux/sched.h
+++ linux-2.6.15-rc1/include/linux/sched.h
@@ -733,8 +733,8 @@ struct task_struct {
 	/* ??? */
 	unsigned long personality;
 	unsigned did_exec:1;
-	pid_t pid;
-	pid_t tgid;
+	pid_t __pid;
+	pid_t __tgid;
 	/* 
 	 * pointers to (original) parent process, youngest child, younger sibling,
 	 * older sibling, respectively.  (p->father can be replaced with 
@@ -878,6 +878,16 @@ static inline int pid_alive(struct task_
 	return p->pids[PIDTYPE_PID].nr != 0;
 }
 
+static inline pid_t task_pid(const struct task_struct *p)
+{
+	return p->__pid;
+}
+
+static inline pid_t task_tgid(const struct task_struct *p)
+{
+	return p->__tgid;
+}
+
 extern void free_task(struct task_struct *tsk);
 extern void __put_task_struct(struct task_struct *tsk);
 #define get_task_struct(tsk) do { atomic_inc(&(tsk)->usage); } while(0)
@@ -1202,7 +1212,7 @@ extern void wait_task_inactive(task_t * 
 
 extern task_t * FASTCALL(next_thread(const task_t *p));
 
-#define thread_group_leader(p)	(p->pid == p->tgid)
+#define thread_group_leader(p)	(task_pid(p) == task_tgid(p))
 
 static inline int thread_group_empty(task_t *p)
 {

--

