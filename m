Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbWALJQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbWALJQh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 04:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964979AbWALJQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 04:16:37 -0500
Received: from omx3-ext.sgi.com ([192.48.171.26]:19870 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S964977AbWALJQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 04:16:36 -0500
Date: Thu, 12 Jan 2006 01:16:27 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: akpm@osdl.org
Cc: kurosawa@valinux.co.jp, simon.derr@bull.net, linux-kernel@vger.kernel.org,
       st@sw.ru, dev@sw.ru, den@sw.ru, Paul Jackson <pj@sgi.com>,
       djwong@us.ibm.com
Message-Id: <20060112091627.18409.49780.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset oom lock fix
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem, reported in:
  http://bugzilla.kernel.org/show_bug.cgi?id=5859
and by various other email messages and lkml posts
is that the cpuset hook in the oom (out of memory)
code can try to take a cpuset semaphore while holding
the tasklist_lock (a spinlock).

One must not sleep while holding a spinlock.

The fix seems easy enough - move the cpuset semaphore
region outside the tasklist_lock region.

This required a few lines of mechanism to implement.
The oom code where the locking needs to be changed
does not have access to the cpuset locks, which are
internal to kernel/cpuset.c only.  So I provided a
couple more cpuset interface routines, available to
the rest of the kernel, which simple take and drop
the lock needed here (cpusets callback_sem).

Signed-off-by: Paul Jackson

---

Andrew - this should be ready for *-mm now.
It's the same change I sent yesterday labeled [RFC].
It passed my testing fine.

This is a bug fix that I would recommend for 2.6.16
in a few days.

 include/linux/cpuset.h |    6 ++++++
 kernel/cpuset.c        |   33 ++++++++++++++++++++++++++++-----
 mm/oom_kill.c          |    3 +++
 3 files changed, 37 insertions(+), 5 deletions(-)

--- 2.6.15-mm2.orig/include/linux/cpuset.h	2006-01-10 16:00:21.190309415 -0800
+++ 2.6.15-mm2/include/linux/cpuset.h	2006-01-10 23:07:59.648091868 -0800
@@ -48,6 +48,9 @@ extern void __cpuset_memory_pressure_bum
 extern struct file_operations proc_cpuset_operations;
 extern char *cpuset_task_status_allowed(struct task_struct *task, char *buffer);
 
+extern void cpuset_lock(void);
+extern void cpuset_unlock(void);
+
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
@@ -93,6 +96,9 @@ static inline char *cpuset_task_status_a
 	return buffer;
 }
 
+static inline void cpuset_lock(void) {}
+static inline void cpuset_unlock(void) {}
+
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
--- 2.6.15-mm2.orig/kernel/cpuset.c	2006-01-10 18:26:40.408120365 -0800
+++ 2.6.15-mm2/kernel/cpuset.c	2006-01-10 23:14:28.355492590 -0800
@@ -2150,6 +2150,33 @@ int __cpuset_zone_allowed(struct zone *z
 }
 
 /**
+ * cpuset_lock - lock out any changes to cpuset structures
+ *
+ * The out of memory (oom) code needs to lock down cpusets
+ * from being changed while it scans the tasklist looking for a
+ * task in an overlapping cpuset.  Expose callback_sem via this
+ * cpuset_lock() routine, so the oom code can lock it, before
+ * locking the task list.  The tasklist_lock is a spinlock, so
+ * must be taken inside callback_sem.
+ */
+
+void cpuset_lock(void)
+{
+	down(&callback_sem);
+}
+
+/**
+ * cpuset_unlock - release lock on cpuset changes
+ *
+ * Undo the lock taken in a previous cpuset_lock() call.
+ */
+
+void cpuset_unlock(void)
+{
+	up(&callback_sem);
+}
+
+/**
  * cpuset_excl_nodes_overlap - Do we overlap @p's mem_exclusive ancestors?
  * @p: pointer to task_struct of some other task.
  *
@@ -2158,7 +2185,7 @@ int __cpuset_zone_allowed(struct zone *z
  * determine if task @p's memory usage might impact the memory
  * available to the current task.
  *
- * Acquires callback_sem - not suitable for calling from a fast path.
+ * Call while holding callback_sem.
  **/
 
 int cpuset_excl_nodes_overlap(const struct task_struct *p)
@@ -2166,8 +2193,6 @@ int cpuset_excl_nodes_overlap(const stru
 	const struct cpuset *cs1, *cs2;	/* my and p's cpuset ancestors */
 	int overlap = 0;		/* do cpusets overlap? */
 
-	down(&callback_sem);
-
 	task_lock(current);
 	if (current->flags & PF_EXITING) {
 		task_unlock(current);
@@ -2186,8 +2211,6 @@ int cpuset_excl_nodes_overlap(const stru
 
 	overlap = nodes_intersects(cs1->mems_allowed, cs2->mems_allowed);
 done:
-	up(&callback_sem);
-
 	return overlap;
 }
 
--- 2.6.15-mm2.orig/mm/oom_kill.c	2006-01-10 19:18:25.588685008 -0800
+++ 2.6.15-mm2/mm/oom_kill.c	2006-01-10 23:16:05.936643833 -0800
@@ -274,6 +274,7 @@ void out_of_memory(gfp_t gfp_mask, int o
 		show_mem();
 	}
 
+	cpuset_lock();
 	read_lock(&tasklist_lock);
 retry:
 	p = select_bad_process();
@@ -284,6 +285,7 @@ retry:
 	/* Found nothing?!?! Either we hang forever, or we panic. */
 	if (!p) {
 		read_unlock(&tasklist_lock);
+		cpuset_unlock();
 		panic("Out of memory and no killable processes...\n");
 	}
 
@@ -293,6 +295,7 @@ retry:
 
  out:
 	read_unlock(&tasklist_lock);
+	cpuset_unlock();
 	if (mm)
 		mmput(mm);
 

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
