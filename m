Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932095AbWAQO5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbWAQO5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 09:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWAQOun
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 09:50:43 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:23266 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750918AbWAQOua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 09:50:30 -0500
Message-Id: <20060117143326.283450000@sergelap>
References: <20060117143258.150807000@sergelap>
Date: Tue, 17 Jan 2006 08:33:11 -0600
From: Serge Hallyn <serue@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Dave Hansen <haveblue@us.ibm.com>,
       Serge E Hallyn <serue@us.ibm.com>
Subject: RFC [patch 13/34] PID Virtualization Define new task_pid api
Content-Disposition: inline; filename=BC-define-pid-handlers
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually define the task_pid() and task_tgid() functions.  Also
replace pid with __pid so as to make sure any missed accessors are
caught.

The resulting object code seems to be identical in most cases, and is
actually shorter in cases where current->pid is used twice in a row,
as it does not dereference task-> twice.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
Signed-off-by: Serge Hallyn <serue@us.ibm.com>
---
 sched.h |   16 +++++++++++++---
 1 files changed, 13 insertions(+), 3 deletions(-)

Index: linux-2.6.15/include/linux/sched.h
===================================================================
--- linux-2.6.15.orig/include/linux/sched.h	2006-01-17 08:18:22.000000000 -0500
+++ linux-2.6.15/include/linux/sched.h	2006-01-17 08:37:03.000000000 -0500
@@ -732,8 +732,8 @@
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
@@ -877,6 +877,16 @@
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
@@ -1200,7 +1210,7 @@
 
 extern task_t * FASTCALL(next_thread(const task_t *p));
 
-#define thread_group_leader(p)	(p->pid == p->tgid)
+#define thread_group_leader(p)	(task_pid(p) == task_tgid(p))
 
 static inline int thread_group_empty(task_t *p)
 {

--

