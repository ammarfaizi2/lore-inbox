Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267920AbUIKIag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267920AbUIKIag (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 04:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267904AbUIKI3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 04:29:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:22700 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267796AbUIKI2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 04:28:55 -0400
Date: Sat, 11 Sep 2004 01:28:20 -0700 (PDT)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org
Message-Id: <20040911082822.10372.73487.44927@sam.engr.sgi.com>
In-Reply-To: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
Subject: [Patch 2/4] cpusets simplify cpus_allowed setting in attach
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When reattaching a task to a different cpuset, I had
code that attempted to preserve the cpuset relative
placement of the task (such as might have been done
using sched_setaffinity, mbind or set_mempolicy) by
rebinding the task to the intersection of its old
and new placement, if not empty.

This resulted in strange and puzzling behaviour, such
as having a tasks cpus_allowed not change if the task
was reattached to the root cpuset.

Simplify the code - when attaching a task to a cpuset,
simply set its cpus_allowed to that of the cpuset.
This is much less surprising in practice.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: 2.6.9-rc1-mm4/kernel/cpuset.c
===================================================================
--- 2.6.9-rc1-mm4.orig/kernel/cpuset.c	2004-09-08 15:22:59.000000000 -0700
+++ 2.6.9-rc1-mm4/kernel/cpuset.c	2004-09-08 18:44:33.000000000 -0700
@@ -605,7 +605,6 @@ static int attach_task(struct cpuset *cs
 	pid_t pid;
 	struct task_struct *tsk;
 	struct cpuset *oldcs;
-	cpumask_t cpus;
 
 	if (sscanf(buf, "%d", &pid) != 1)
 		return -EIO;
@@ -645,16 +644,7 @@ static int attach_task(struct cpuset *cs
 	tsk->cpuset = cs;
 	task_unlock(tsk);
 
-	/*
-	 * If the tasks current CPU placement overlaps with its new cpuset,
-	 * then let it run in that overlap.  Otherwise fallback to simply
-	 * letting it have the run of the CPUs in the new cpuset.
-	 */
-	if (cpus_intersects(tsk->cpus_allowed, cs->cpus_allowed))
-		cpus_and(cpus, tsk->cpus_allowed, cs->cpus_allowed);
-	else
-		cpus = cs->cpus_allowed;
-	set_cpus_allowed(tsk, cpus);
+	set_cpus_allowed(tsk, cs->cpus_allowed);
 
 	put_task_struct(tsk);
 	if (atomic_dec_and_test(&oldcs->count))

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
