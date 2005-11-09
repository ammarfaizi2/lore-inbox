Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751313AbVKIHyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751313AbVKIHyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 02:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVKIHyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 02:54:21 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:29073 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751313AbVKIHyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 02:54:19 -0500
Date: Tue, 8 Nov 2005 23:53:45 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: Mike Kravetz <kravetz@us.ibm.com>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       Lee Schermerhorn <lee.schermerhorn@hp.com>,
       Dave Hansen <haveblue@us.ibm.com>, Magnus Damm <magnus@valinux.co.jp>,
       Simon Derr <Simon.Derr@bull.net>, Christoph Lameter <clameter@sgi.com>,
       Paul Jackson <pj@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20051109075345.22845.57917.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] swap migration cpuset interface
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a boolean "memory_migrate" to each cpuset, represented by
a file containing "0" or "1" in each directory below /dev/cpuset.

It defaults to false (file contains "0").  It can be set true
by writing "1" to the file.

If true, then anytime that a task is attached to the cpuset so
marked, the pages of that task will be moved to that cpuset,
preserving, to the extent practical, the cpuset-relative
placement of the pages.

Also anytime that a cpuset so marked has its memory placement
changed (by writing to its "mems" file), the tasks in that cpuset
will have their pages moved to the cpusets new nodes, preserving,
to the extent practical, the cpuset-relative placement of the
moved pages.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

Andrew - this patch goes right after Christoph Lameter's
swap-migration-v5-* patch set in your *-mm stack.
This patch depends on these swap-migration-* patches
set and should enjoy the same fate as they do.  -pj

 Documentation/cpusets.txt |   25 +++++++++++++++++++++++++
 include/linux/mempolicy.h |    7 +++++++
 kernel/cpuset.c           |   38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 68 insertions(+), 2 deletions(-)

--- 2.6.14-mm1.orig/kernel/cpuset.c	2005-11-07 23:01:32.204589412 -0800
+++ 2.6.14-mm1/kernel/cpuset.c	2005-11-08 16:58:09.856103221 -0800
@@ -87,6 +87,7 @@ struct cpuset {
 typedef enum {
 	CS_CPU_EXCLUSIVE,
 	CS_MEM_EXCLUSIVE,
+	CS_MEMORY_MIGRATE,
 	CS_REMOVED,
 	CS_NOTIFY_ON_RELEASE
 } cpuset_flagbits_t;
@@ -112,6 +113,11 @@ static inline int notify_on_release(cons
 	return !!test_bit(CS_NOTIFY_ON_RELEASE, &cs->flags);
 }
 
+static inline int is_memory_migrate(const struct cpuset *cs)
+{
+	return !!test_bit(CS_MEMORY_MIGRATE, &cs->flags);
+}
+
 /*
  * Increment this atomic integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
@@ -602,16 +608,24 @@ static void refresh_mems(void)
 	if (current->cpuset_mems_generation != my_cpusets_mem_gen) {
 		struct cpuset *cs;
 		nodemask_t oldmem = current->mems_allowed;
+		int migrate;
 
 		down(&callback_sem);
 		task_lock(current);
 		cs = current->cpuset;
+		migrate = is_memory_migrate(cs);
 		guarantee_online_mems(cs, &current->mems_allowed);
 		current->cpuset_mems_generation = cs->mems_generation;
 		task_unlock(current);
 		up(&callback_sem);
-		if (!nodes_equal(oldmem, current->mems_allowed))
+		if (!nodes_equal(oldmem, current->mems_allowed)) {
 			numa_policy_rebind(&oldmem, &current->mems_allowed);
+			if (migrate) {
+				do_migrate_pages(current->mm, &oldmem,
+					&current->mems_allowed,
+					MPOL_MF_MOVE_ALL);
+			}
+		}
 	}
 }
 
@@ -795,7 +809,7 @@ static int update_nodemask(struct cpuset
 /*
  * update_flag - read a 0 or a 1 in a file and update associated flag
  * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
- *						CS_NOTIFY_ON_RELEASE)
+ *				CS_NOTIFY_ON_RELEASE, CS_MEMORY_MIGRATE)
  * cs:	the cpuset to update
  * buf:	the buffer where we read the 0 or 1
  *
@@ -848,6 +862,7 @@ static int attach_task(struct cpuset *cs
 	struct task_struct *tsk;
 	struct cpuset *oldcs;
 	cpumask_t cpus;
+	nodemask_t from, to;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
@@ -893,7 +908,12 @@ static int attach_task(struct cpuset *cs
 	guarantee_online_cpus(cs, &cpus);
 	set_cpus_allowed(tsk, cpus);
 
+	from = oldcs->mems_allowed;
+	to = cs->mems_allowed;
+
 	up(&callback_sem);
+	if (is_memory_migrate(cs))
+		do_migrate_pages(tsk->mm, &from, &to, MPOL_MF_MOVE_ALL);
 	put_task_struct(tsk);
 	if (atomic_dec_and_test(&oldcs->count))
 		check_for_release(oldcs, ppathbuf);
@@ -905,6 +925,7 @@ static int attach_task(struct cpuset *cs
 typedef enum {
 	FILE_ROOT,
 	FILE_DIR,
+	FILE_MEMORY_MIGRATE,
 	FILE_CPULIST,
 	FILE_MEMLIST,
 	FILE_CPU_EXCLUSIVE,
@@ -960,6 +981,9 @@ static ssize_t cpuset_common_file_write(
 	case FILE_NOTIFY_ON_RELEASE:
 		retval = update_flag(CS_NOTIFY_ON_RELEASE, cs, buffer);
 		break;
+	case FILE_MEMORY_MIGRATE:
+		retval = update_flag(CS_MEMORY_MIGRATE, cs, buffer);
+		break;
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
@@ -1060,6 +1084,9 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_NOTIFY_ON_RELEASE:
 		*s++ = notify_on_release(cs) ? '1' : '0';
 		break;
+	case FILE_MEMORY_MIGRATE:
+		*s++ = is_memory_migrate(cs) ? '1' : '0';
+		break;
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1408,6 +1435,11 @@ static struct cftype cft_notify_on_relea
 	.private = FILE_NOTIFY_ON_RELEASE,
 };
 
+static struct cftype cft_memory_migrate = {
+	.name = "memory_migrate",
+	.private = FILE_MEMORY_MIGRATE,
+};
+
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1422,6 +1454,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_memory_migrate)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
 	return 0;
--- 2.6.14-mm1.orig/include/linux/mempolicy.h	2005-11-07 23:02:54.723080671 -0800
+++ 2.6.14-mm1/include/linux/mempolicy.h	2005-11-07 23:02:55.039490349 -0800
@@ -237,6 +237,13 @@ static inline void numa_policy_rebind(co
 {
 }
 
+static inline int do_migrate_pages(struct mm_struct *mm,
+			const nodemask_t *from_nodes,
+			const nodemask_t *to_nodes, int flags)
+{
+	return 0;
+}
+
 #endif /* CONFIG_NUMA */
 #endif /* __KERNEL__ */
 
--- 2.6.14-mm1.orig/Documentation/cpusets.txt	2005-11-07 23:01:08.864487337 -0800
+++ 2.6.14-mm1/Documentation/cpusets.txt	2005-11-08 17:14:58.319147165 -0800
@@ -192,6 +192,7 @@ containing the following files describin
 
  - cpus: list of CPUs in that cpuset
  - mems: list of Memory Nodes in that cpuset
+ - memory_migrate flag: if set, move pages to cpusets nodes
  - cpu_exclusive flag: is cpu placement exclusive?
  - mem_exclusive flag: is memory placement exclusive?
  - tasks: list of tasks (by pid) attached to that cpuset
@@ -277,6 +278,30 @@ rewritten to the 'tasks' file of its cpu
 impacting the scheduler code in the kernel with a check for changes
 in a tasks processor placement.
 
+Normally, once a page is allocated (given a physical page
+of main memory) then that page stays on whatever node it
+was allocated, so long as it remains allocated, even if the
+cpusets memory placement policy 'mems' subsequently changes.
+If the cpuset flag file 'memory_migrate' is set true, then when
+tasks are attached to that cpuset, any pages that task had
+allocated to it on nodes in its previous cpuset are migrated
+to the tasks new cpuset.  Depending on the implementation,
+this migration may either be done by swapping the page out,
+so that the next time the page is referenced, it will be paged
+into the tasks new cpuset, usually on the node where it was
+referenced, or this migration may be done by directly copying
+the pages from the tasks previous cpuset to the new cpuset,
+where possible to the same node, relative to the new cpuset,
+as the node that held the page, relative to the old cpuset.
+Also if 'memory_migrate' is set true, then if that cpusets
+'mems' file is modified, pages allocated to tasks in that
+cpuset, that were on nodes in the previous setting of 'mems',
+will be moved to nodes in the new setting of 'mems.'  Again,
+depending on the implementation, this might be done by swapping,
+or by direct copying.  In either case, pages that were not in
+the tasks prior cpuset, or in the cpusets prior 'mems' setting,
+will not be moved.
+
 There is an exception to the above.  If hotplug functionality is used
 to remove all the CPUs that are currently assigned to a cpuset,
 then the kernel will automatically update the cpus_allowed of all

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
