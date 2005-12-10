Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbVLJIV6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbVLJIV6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 03:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVLJITc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 03:19:32 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:10457 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964967AbVLJITN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 03:19:13 -0500
Date: Sat, 10 Dec 2005 00:19:05 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Message-Id: <20051210081905.12303.25009.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
References: <20051210081843.12303.13344.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 04/10] Cpuset: fork hook fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix obscure, never seen in real life, cpuset fork race.
The cpuset_fork() call in fork.c was setting up the correct
task->cpuset pointer after the tasklist_lock was dropped,
which briefly exposed the newly forked process with an unsafe
(copied from parent without locks or usage counter increment)
cpuset pointer.

In theory, that exposed cpuset pointer could have been pointing
at a cpuset that was already freed and removed, and in theory
another task that had been sitting on the tasklist_lock waiting
to scan the task list could have raced down the entire tasklist,
found our new child at the far end, and dereferenced that bogus
cpuset pointer.

To fix, setup up the correct cpuset pointer in the new child
by calling cpuset_fork() before the new task is linked into the
tasklist, and with that, add a fork failure case, to dereference
that cpuset, if the fork fails along the way, after cpuset_fork()
was called.

Had to remove a BUG_ON() from cpuset_exit(), because it was
no longer valid - the call to cpuset_exit() from a failed fork
would not have PF_EXITING set.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

 kernel/cpuset.c |    4 +---
 kernel/fork.c   |    6 ++++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- 2.6.15-rc3-mm1.orig/kernel/cpuset.c	2005-12-08 02:05:37.457685051 -0800
+++ 2.6.15-rc3-mm1/kernel/cpuset.c	2005-12-08 15:19:04.600207271 -0800
@@ -1821,15 +1821,13 @@ void cpuset_fork(struct task_struct *chi
  *
  * We don't need to task_lock() this reference to tsk->cpuset,
  * because tsk is already marked PF_EXITING, so attach_task() won't
- * mess with it.
+ * mess with it, or task is a failed fork, never visible to attach_task.
  **/
 
 void cpuset_exit(struct task_struct *tsk)
 {
 	struct cpuset *cs;
 
-	BUG_ON(!(tsk->flags & PF_EXITING));
-
 	cs = tsk->cpuset;
 	tsk->cpuset = NULL;
 
--- 2.6.15-rc3-mm1.orig/kernel/fork.c	2005-12-08 02:05:34.885390778 -0800
+++ 2.6.15-rc3-mm1/kernel/fork.c	2005-12-08 15:19:50.203259819 -0800
@@ -971,12 +971,13 @@ static task_t *copy_process(unsigned lon
 	p->io_context = NULL;
 	p->io_wait = NULL;
 	p->audit_context = NULL;
+	cpuset_fork(p);
 #ifdef CONFIG_NUMA
  	p->mempolicy = mpol_copy(p->mempolicy);
  	if (IS_ERR(p->mempolicy)) {
  		retval = PTR_ERR(p->mempolicy);
  		p->mempolicy = NULL;
- 		goto bad_fork_cleanup;
+ 		goto bad_fork_cleanup_cpuset;
  	}
 #endif
 
@@ -1147,7 +1148,6 @@ static task_t *copy_process(unsigned lon
 	total_forks++;
 	write_unlock_irq(&tasklist_lock);
 	proc_fork_connector(p);
-	cpuset_fork(p);
 	retval = 0;
 
 fork_out:
@@ -1179,7 +1179,9 @@ bad_fork_cleanup_security:
 bad_fork_cleanup_policy:
 #ifdef CONFIG_NUMA
 	mpol_free(p->mempolicy);
+bad_fork_cleanup_cpuset:
 #endif
+	cpuset_exit(p);
 bad_fork_cleanup:
 	if (p->binfmt)
 		module_put(p->binfmt->module);

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
