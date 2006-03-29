Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750789AbWC2JLr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750789AbWC2JLr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 04:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWC2JLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 04:11:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:47813 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750789AbWC2JL0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 04:11:26 -0500
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon.Derr@bull.net, Paul Jackson <pj@sgi.com>,
       linux-kernel@vger.kernel.org, clameter@sgi.com
Date: Wed, 29 Mar 2006 01:11:19 -0800
Message-Id: <20060329091119.14612.93857.sendpatchset@jackhammer.engr.sgi.com>
In-Reply-To: <20060329091108.14612.84403.sendpatchset@jackhammer.engr.sgi.com>
References: <20060329091108.14612.84403.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH 03/03] Cpuset: memory migration interaction fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Jackson <pj@sgi.com>

Fix memory migration so that it works regardless of what cpuset
the invoking task is in.

If a task invoked a memory migration, by doing one of:
       1) writing a different nodemask to a cpuset 'mems' file, or
       2) writing a tasks pid to a different cpuset's 'tasks' file,
    where the cpuset had its 'memory_migrate' option turned on,
then the allocation of the new pages for the migrated task(s)
    was constrained by the invoking tasks cpuset.

If this task wasn't in a cpuset that allowed the requested
memory nodes, the memory migration would happen to some other
nodes that were in that invoking tasks cpuset.  This was usually
surprising and puzzling behaviour:  Why didn't the pages move?
Why did the pages move -there-?

To fix this, temporarilly change the invoking tasks
'mems_allowed' task_struct field to the nodes the migrating
tasks is moving to, so that new pages can be allocated there.

Signed-off-by: Paul Jackson <pj@sgi.com>
Acked-by: Christoph Lameter <clameter@sgi.com>

---

Finally a fix for this interaction of cpusets with memory migration.
I am hoping that this will be suitable for 2.6.17, as memory migration
fails in unexpected ways without this fix.		-pj

 kernel/cpuset.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 5 deletions(-)

--- 2.6.16-mm1.orig/kernel/cpuset.c	2006-03-27 08:44:47.894113580 -0800
+++ 2.6.16-mm1/kernel/cpuset.c	2006-03-27 08:47:46.400307814 -0800
@@ -834,6 +834,55 @@ static int update_cpumask(struct cpuset 
 }
 
 /*
+ * cpuset_migrate_mm
+ *
+ *    Migrate memory region from one set of nodes to another.
+ *
+ *    Temporarilly set tasks mems_allowed to target nodes of migration,
+ *    so that the migration code can allocate pages on these nodes.
+ *
+ *    Call holding manage_mutex, so our current->cpuset won't change
+ *    during this call, as manage_mutex holds off any attach_task()
+ *    calls.  Therefore we don't need to take task_lock around the
+ *    call to guarantee_online_mems(), as we know no one is changing
+ *    our tasks cpuset.
+ *
+ *    Hold callback_mutex around the two modifications of our tasks
+ *    mems_allowed to synchronize with cpuset_mems_allowed().
+ *
+ *    While the mm_struct we are migrating is typically from some
+ *    other task, the task_struct mems_allowed that we are hacking
+ *    is for our current task, which must allocate new pages for that
+ *    migrating memory region.
+ *
+ *    We call cpuset_update_task_memory_state() before hacking
+ *    our tasks mems_allowed, so that we are assured of being in
+ *    sync with our tasks cpuset, and in particular, callbacks to
+ *    cpuset_update_task_memory_state() from nested page allocations
+ *    won't see any mismatch of our cpuset and task mems_generation
+ *    values, so won't overwrite our hacked tasks mems_allowed
+ *    nodemask.
+ */
+
+static void cpuset_migrate_mm(struct mm_struct *mm, const nodemask_t *from,
+							const nodemask_t *to)
+{
+	struct task_struct *tsk = current;
+
+	cpuset_update_task_memory_state();
+
+	mutex_lock(&callback_mutex);
+	tsk->mems_allowed = *to;
+	mutex_unlock(&callback_mutex);
+
+	do_migrate_pages(mm, from, to, MPOL_MF_MOVE_ALL);
+
+	mutex_lock(&callback_mutex);
+	guarantee_online_mems(tsk->cpuset, &tsk->mems_allowed);
+	mutex_unlock(&callback_mutex);
+}
+
+/*
  * Handle user request to change the 'mems' memory placement
  * of a cpuset.  Needs to validate the request, update the
  * cpusets mems_allowed and mems_generation, and for each
@@ -945,10 +994,8 @@ static int update_nodemask(struct cpuset
 		struct mm_struct *mm = mmarray[i];
 
 		mpol_rebind_mm(mm, &cs->mems_allowed);
-		if (migrate) {
-			do_migrate_pages(mm, &oldmem, &cs->mems_allowed,
-							MPOL_MF_MOVE_ALL);
-		}
+		if (migrate)
+			cpuset_migrate_mm(mm, &oldmem, &cs->mems_allowed);
 		mmput(mm);
 	}
 
@@ -1184,7 +1231,7 @@ static int attach_task(struct cpuset *cs
 	if (mm) {
 		mpol_rebind_mm(mm, &to);
 		if (is_memory_migrate(cs))
-			do_migrate_pages(mm, &from, &to, MPOL_MF_MOVE_ALL);
+			cpuset_migrate_mm(mm, &from, &to);
 		mmput(mm);
 	}
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
