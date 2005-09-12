Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750747AbVILLay@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750747AbVILLay (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 07:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbVILLay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 07:30:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:37084 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750747AbVILLax (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 07:30:53 -0400
Date: Mon, 12 Sep 2005 04:30:30 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Simon Derr <Simon.Derr@bull.net>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Nikita Danilov <nikita@clusterfs.com>
Message-Id: <20050912113030.15934.9433.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset semaphore depth check optimize
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize the deadlock avoidance check on the global cpuset
semaphore cpuset_sem.  Instead of adding a depth counter to the
task struct of each task, rather just two words are enough, one
to store the depth and the other the current cpuset_sem holder.

Thanks to Nikita Danilov for the idea.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: linux-2.6.13-mem_exclusive_oom/include/linux/sched.h
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/include/linux/sched.h
+++ linux-2.6.13-mem_exclusive_oom/include/linux/sched.h
@@ -765,7 +765,6 @@ struct task_struct {
 	short il_next;
 #endif
 #ifdef CONFIG_CPUSETS
-	short cpuset_sem_nest_depth;
 	struct cpuset *cpuset;
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
Index: linux-2.6.13-mem_exclusive_oom/kernel/cpuset.c
===================================================================
--- linux-2.6.13-mem_exclusive_oom.orig/kernel/cpuset.c
+++ linux-2.6.13-mem_exclusive_oom/kernel/cpuset.c
@@ -180,6 +180,8 @@ static struct super_block *cpuset_sb = N
  */
 
 static DECLARE_MUTEX(cpuset_sem);
+static struct task_struct *cpuset_sem_owner;
+static int cpuset_sem_depth;
 
 /*
  * The global cpuset semaphore cpuset_sem can be needed by the
@@ -200,16 +202,19 @@ static DECLARE_MUTEX(cpuset_sem);
 
 static inline void cpuset_down(struct semaphore *psem)
 {
-	if (current->cpuset_sem_nest_depth == 0)
+	if (cpuset_sem_owner != current) {
 		down(psem);
-	current->cpuset_sem_nest_depth++;
+		cpuset_sem_owner = current;
+	}
+	cpuset_sem_depth++;
 }
 
 static inline void cpuset_up(struct semaphore *psem)
 {
-	current->cpuset_sem_nest_depth--;
-	if (current->cpuset_sem_nest_depth == 0)
+	if (--cpuset_sem_depth == 0) {
+		cpuset_sem_owner = NULL;
 		up(psem);
+	}
 }
 
 /*

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
