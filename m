Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWJLNIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWJLNIU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 09:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbWJLNIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 09:08:19 -0400
Received: from amsfep17-int.chello.nl ([213.46.243.15]:23658 "EHLO
	amsfep13-int.chello.nl") by vger.kernel.org with ESMTP
	id S1751384AbWJLNIT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 09:08:19 -0400
Subject: [PATCH] rt-mutex: fixup rt-mutex debug code
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 12 Oct 2006 15:08:31 +0200
Message-Id: <1160658511.2006.120.camel@taijtu>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


BUG: warning at kernel/rtmutex-debug.c:125/rt_mutex_debug_task_free() (Not tainted)
 [<c04051e3>] show_trace_log_lvl+0x58/0x16a
 [<c04057f0>] show_trace+0xd/0x10
 [<c0405900>] dump_stack+0x19/0x1b
 [<c043f03d>] rt_mutex_debug_task_free+0x35/0x6a
 [<c04224c0>] free_task+0x15/0x24
 [<c042378c>] copy_process+0x12bd/0x1324
 [<c0423835>] do_fork+0x42/0x113
 [<c04021dd>] sys_fork+0x19/0x1b
 [<c0403fb7>] syscall_call+0x7/0xb

In copy_process(), dup_task_struct() also duplicates the ->pi_lock,
->pi_waiters and ->pi_blocked_on members. rt_mutex_debug_task_free() 
called from free_task() validates these members. However free_task()
can be invoked before these members are reset for the new task.

Move the initialization code before the first bail that can hit free_task().

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
---
 kernel/fork.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6/kernel/fork.c
===================================================================
--- linux-2.6.orig/kernel/fork.c
+++ linux-2.6/kernel/fork.c
@@ -984,6 +984,8 @@ static struct task_struct *copy_process(
 	if (!p)
 		goto fork_out;
 
+	rt_mutex_init_task(p);
+
 #ifdef CONFIG_TRACE_IRQFLAGS
 	DEBUG_LOCKS_WARN_ON(!p->hardirqs_enabled);
 	DEBUG_LOCKS_WARN_ON(!p->softirqs_enabled);
@@ -1088,8 +1090,6 @@ static struct task_struct *copy_process(
 	p->lockdep_recursion = 0;
 #endif
 
-	rt_mutex_init_task(p);
-
 #ifdef CONFIG_DEBUG_MUTEXES
 	p->blocked_on = NULL; /* not blocked yet */
 #endif


