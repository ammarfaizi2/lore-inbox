Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264879AbUFADrj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUFADrj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 23:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbUFADrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 23:47:37 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:49062 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264884AbUFADrK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 23:47:10 -0400
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: [patch 2.6.7-rc2] Add const to some scheduling functions
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 01 Jun 2004 13:46:56 +1000
Message-ID: <6525.1086061616@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Several scheduler macros only read from the task struct, mark them
const.  It can generate better code.

Index: 2.6.7-rc2/include/linux/sched.h
===================================================================
--- 2.6.7-rc2.orig/include/linux/sched.h	Mon May 31 09:52:55 2004
+++ 2.6.7-rc2/include/linux/sched.h	Tue Jun  1 13:40:51 2004
@@ -681,9 +681,9 @@ extern void sched_balance_exec(void);
 
 extern void sched_idle_next(void);
 extern void set_user_nice(task_t *p, long nice);
-extern int task_prio(task_t *p);
-extern int task_nice(task_t *p);
-extern int task_curr(task_t *p);
+extern int task_prio(const task_t *p);
+extern int task_nice(const task_t *p);
+extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
 
 void yield(void);
@@ -905,7 +905,7 @@ extern void wait_task_inactive(task_t * 
 #define while_each_thread(g, t) \
 	while ((t = next_thread(t)) != g)
 
-extern task_t * FASTCALL(next_thread(task_t *p));
+extern task_t * FASTCALL(next_thread(const task_t *p));
 
 #define thread_group_leader(p)	(p->pid == p->tgid)
 
@@ -1044,7 +1044,7 @@ extern void signal_wake_up(struct task_s
  */
 #ifdef CONFIG_SMP
 
-static inline unsigned int task_cpu(struct task_struct *p)
+static inline unsigned int task_cpu(const struct task_struct *p)
 {
 	return p->thread_info->cpu;
 }
Index: 2.6.7-rc2/kernel/exit.c
===================================================================
--- 2.6.7-rc2.orig/kernel/exit.c	Mon May 31 09:52:57 2004
+++ 2.6.7-rc2/kernel/exit.c	Tue Jun  1 13:40:51 2004
@@ -826,10 +826,10 @@ asmlinkage long sys_exit(int error_code)
 	do_exit((error_code&0xff)<<8);
 }
 
-task_t fastcall *next_thread(task_t *p)
+task_t fastcall *next_thread(const task_t *p)
 {
-	struct pid_link *link = p->pids + PIDTYPE_TGID;
-	struct list_head *tmp, *head = &link->pidptr->task_list;
+	const struct pid_link *link = p->pids + PIDTYPE_TGID;
+	const struct list_head *tmp, *head = &link->pidptr->task_list;
 
 #ifdef CONFIG_SMP
 	if (!p->sighand)
Index: 2.6.7-rc2/kernel/sched.c
===================================================================
--- 2.6.7-rc2.orig/kernel/sched.c	Mon May 31 09:52:57 2004
+++ 2.6.7-rc2/kernel/sched.c	Tue Jun  1 13:40:51 2004
@@ -546,7 +546,7 @@ static inline void resched_task(task_t *
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
  */
-inline int task_curr(task_t *p)
+inline int task_curr(const task_t *p)
 {
 	return cpu_curr(task_cpu(p)) == p;
 }
@@ -2640,7 +2640,7 @@ asmlinkage long sys_nice(int increment)
  * RT tasks are offset by -200. Normal tasks are centered
  * around 0, value goes from -16 to +15.
  */
-int task_prio(task_t *p)
+int task_prio(const task_t *p)
 {
 	return p->prio - MAX_RT_PRIO;
 }
@@ -2649,7 +2649,7 @@ int task_prio(task_t *p)
  * task_nice - return the nice value of a given task.
  * @p: the task in question.
  */
-int task_nice(task_t *p)
+int task_nice(const task_t *p)
 {
 	return TASK_NICE(p);
 }

