Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422639AbVKZEwW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422639AbVKZEwW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 23:52:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422640AbVKZEwW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 23:52:22 -0500
Received: from zeus1.kernel.org ([204.152.191.4]:3712 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1422639AbVKZEwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 23:52:21 -0500
Date: Fri, 25 Nov 2005 20:51:54 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Simon Derr <Simon.Derr@bull.net>, guillaume.thouvenin@bull.net,
       Paul Jackson <pj@sgi.com>, matthltc@us.ibm.com
Message-Id: <20051126045154.28188.49905.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset fork locking fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move the cpuset_fork() call below the write_unlock_irq call
in kernel/fork.c copy_process().

Since the cpuset-dual-semaphore-locking-overhaul.patch, the
cpuset_fork() routine acquires task_lock(), so cannot be called
while holding the tasklist_lock for write.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/fork.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

--- 2.6.15-rc2-mm1.orig/kernel/fork.c	2005-11-25 17:22:23.853126623 -0800
+++ 2.6.15-rc2-mm1/kernel/fork.c	2005-11-25 17:26:44.713419159 -0800
@@ -1131,8 +1131,6 @@ static task_t *copy_process(unsigned lon
 	if (unlikely(p->ptrace & PT_PTRACED))
 		__ptrace_link(p, current->parent);
 
-	cpuset_fork(p);
-
 	attach_pid(p, PIDTYPE_PID, p->pid);
 	attach_pid(p, PIDTYPE_TGID, p->tgid);
 	if (thread_group_leader(p)) {
@@ -1149,6 +1147,7 @@ static task_t *copy_process(unsigned lon
 	nr_threads++;
 	total_forks++;
 	write_unlock_irq(&tasklist_lock);
+	cpuset_fork(p);
 	retval = 0;
 
 fork_out:

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
