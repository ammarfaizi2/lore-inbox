Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUIJI6w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUIJI6w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 04:58:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267303AbUIJI5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 04:57:47 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:12972 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S267310AbUIJIwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 04:52:53 -0400
Date: Fri, 10 Sep 2004 10:52:38 +0200 (CEST)
From: Simon Derr <simon.derr@bull.net>
X-X-Sender: derr@daphne.frec.bull.fr
To: simon.derr@bull.net, pj@sgi.com
cc: linux-kernel@vger.kernel.org
Subject: [rfc][patch] 2/2 Additional cpuset features
Message-ID: <Pine.LNX.4.58.0409101038440.2891@daphne.frec.bull.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This second patch adds a "virtualization" layer to the CPU numbering
inside cpusets.

A new per-cpuset flag, `virtualize', appears. When set, the behaviour of
sys_sched_setaffinity() is changed : masks passed as arguments for this
syscall are interpreted "inside" the cpuset a task belongs to.

For instance, task A belongs to cpuset B. B has the flag `virtualize' set,
and uses CPUs 2, 3 and 5.

If A calls sys_sched_setaffinity() with a mask of 0x1, it will be bound on
the first CPU of cpuset B, i.e CPU 2. With a mask of 0x2, it would have
been CPU 3. With 0x4, CPU 5.

A new `cpus_virt_allowed' mask has been added in task_t. This mask
contains the information about where the application should be running
inside its cpuset. If the cpuset is modified, task->cpus_virt_allowed and
cpuset->cpus_allowed are mixed together to update task->cpus_allowed.

I got several reluctant opinions about this "renumbering" of the CPUs, and
most people will reject it at once. However, this feature can be very
useful when running several high performance computing applications on a
big system.


Against 2.6.9-rc1-mm4 + previous patch.


Signed-Off-By: Simon Derr <simon.derr@bull.net>
Index: mm4/include/linux/init_task.h
===================================================================
--- mm4.orig/include/linux/init_task.h	2004-09-07 11:36:18.000000000 +0200
+++ mm4/include/linux/init_task.h	2004-09-08 11:37:16.000000000 +0200
@@ -75,6 +75,7 @@
 	.static_prio	= MAX_PRIO-29,					\
 	.policy		= SCHED_NORMAL,					\
 	.cpus_allowed	= CPU_MASK_ALL,					\
+	.cpus_virt_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
Index: mm4/include/linux/sched.h
===================================================================
--- mm4.orig/include/linux/sched.h	2004-09-07 11:36:18.000000000 +0200
+++ mm4/include/linux/sched.h	2004-09-08 11:37:16.000000000 +0200
@@ -596,6 +596,7 @@
   	short il_next;		/* could be shared with used_math */
 #endif
 #ifdef CONFIG_CPUSETS
+	cpumask_t cpus_virt_allowed;
 	struct cpuset *cpuset;
 	nodemask_t mems_allowed;
 	int cpuset_mems_generation;
Index: mm4/kernel/cpuset.c
===================================================================
--- mm4.orig/kernel/cpuset.c	2004-09-08 10:13:30.000000000 +0200
+++ mm4/kernel/cpuset.c	2004-09-10 10:11:22.159415855 +0200
@@ -82,6 +82,7 @@
 typedef enum {
 	CS_CPU_EXCLUSIVE,
 	CS_MEM_EXCLUSIVE,
+	CS_VIRTUALIZED,
 	CS_REMOVED,
 	CS_NOTIFY_ON_RELEASE
 } cpuset_flagbits_t;
@@ -97,6 +98,10 @@
 	return !!test_bit(CS_MEM_EXCLUSIVE, &cs->flags);
 }

+static inline int is_virtualized(const struct cpuset *cs)
+{
+	return !!test_bit(CS_VIRTUALIZED, &cs->flags);
+}
 static inline int is_removed(const struct cpuset *cs)
 {
 	return !!test_bit(CS_REMOVED, &cs->flags);
@@ -470,6 +475,103 @@
 		is_mem_exclusive(p) <= is_mem_exclusive(q);
 }

+#define cyclic_next_cpu(index, mask)	__cyclic_next_cpu(index, &mask)
+static inline int __cyclic_next_cpu(int index, const cpumask_t * mask)
+{
+	int i;
+	i = next_cpu(index, *mask);
+	if (i >= NR_CPUS) {
+		if (cpu_isset(0, *mask))
+			return 0;
+		i = next_cpu(0, *mask);
+	}
+	return i;
+}
+
+/**
+ *	cpuset_combine_mask - translate a user cpu mask to a physical one.
+ *	@virt_allowed:	the mask given by the user to sched_setaffinity()
+ *	@cs_allowed:	the mask of the current cpuset.
+ *
+ *	Returns combined mask in *mask.
+ */
+static int combine_mask(cpumask_t *mask, const cpumask_t virt_allowed, const cpumask_t cs_allowed)
+{
+	int i;
+
+	/* start with current cpu out of the mask
+	 * so the first call to next_cpu will take the first cpu
+	 * even if it is cpu zero
+	 */
+	int cpu = NR_CPUS;
+	cpus_clear(*mask);
+
+	if (cpus_empty(virt_allowed)) return 0;
+	if (cpus_empty(cs_allowed)) return 0;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		cpu = cyclic_next_cpu(cpu, cs_allowed);
+		if (cpu_isset(i, virt_allowed))
+			cpu_set(cpu, *mask);
+	}
+	return 0;
+}
+
+/**
+ *	set_cpus_virt_allowed - updated cpus_virt_allowed AND cpus_allowed masks
+ *	@virt_allowed:        the mask given by the user to sched_setaffinity()
+ *	@p:		the task
+ *
+ *	This function does not mess with scheduler internals. Here we rely
+ *	on set_cpus_allowed(), that should, for instance, migrate the task
+ *	if necessary.
+ */
+static int set_cpus_virt_allowed(task_t *p, cpumask_t mask)
+{
+	cpumask_t new_mask;
+	int retval;
+
+	p->cpus_virt_allowed = mask;
+	combine_mask(&new_mask, p->cpus_virt_allowed, p->cpuset->cpus_allowed);
+	retval = set_cpus_allowed(p, new_mask);
+	return retval;
+}
+
+/**
+ *	This is the exported entry point that will be called
+ *	by sched_setaffinity().
+ */
+int cpuset_set_cpus_affinity(task_t *p, cpumask_t mask)
+{
+	int retval;
+
+	down(&cpuset_sem);
+	if (is_virtualized(p->cpuset))
+		retval = set_cpus_virt_allowed(p, mask);
+	else {
+		cpumask_t cpus_allowed;
+		cpus_allowed = p->cpuset->cpus_allowed;
+		cpus_and(mask, mask, cpus_allowed);
+		retval = set_cpus_allowed(p, mask);
+	}
+	up(&cpuset_sem);
+	return retval;
+}
+
+/**
+ *	This is the exported entry point that will be called
+ *	by sched_getaffinity().
+ */
+int cpuset_get_cpus_virt_affinity(task_t *p, cpumask_t *mask)
+{
+	if (is_virtualized(p->cpuset)) {
+		*mask = p->cpus_virt_allowed;
+		return 0;
+	}
+	return -1;
+}
+
+
 /*
  * validate_change() - Used to validate that any proposed cpuset change
  *		       follows the structural rules for cpusets.
@@ -509,6 +611,11 @@
 			return -ENOSPC;
 	}

+	/* virtualization can only be turned on/off on empty cpusets  */
+	if ((atomic_read(&cur->count) > 0) || (!list_empty(&cur->children)))
+		if (is_virtualized(cur) != is_virtualized(trial))
+			return -EBUSY;
+
 	/* We must be a subset of our parent cpuset */
 	if (!is_cpuset_subset(trial, par))
 		return -EACCES;
@@ -561,7 +668,7 @@
 	int nb = 0;
 	int sz;

-retry:
+again:
 	/* at most cs->count - 1 processes to migrate */
 	/* keep some room in case some processes fork() during kmalloc() */
 	sz = atomic_read(&cs->count) + 10;
@@ -578,7 +685,7 @@
 				printk("migrate_cpuset_processes: array full !\n");
 				read_unlock(&tasklist_lock);
 				kfree(array);
-				goto retry;
+				goto again;
 			}
 			get_task_struct(p);
 			array[nb++] = p;
@@ -588,16 +695,20 @@

 	while(nb) {
 		struct task_struct * p = array[--nb];
-		cpumask_t cpus;
-		/*
-		 * If the tasks current CPU placement overlaps with its new cpuset,
-		 * then let it run in that overlap.  Otherwise fallback to simply
-		 * letting it have the run of the CPUs in the new cpuset.
-		 */
-		cpus_and(cpus, p->cpus_allowed, cs->cpus_allowed);
-		if (cpus_empty(cpus))
-			cpus = cs->cpus_allowed;
-		set_cpus_allowed(p, cpus);
+		if (is_virtualized(cs))
+			set_cpus_virt_allowed(p, p->cpus_virt_allowed);
+		else {
+			cpumask_t cpus;
+			/*
+			 * If the tasks current CPU placement overlaps with its new cpuset,
+			 * then let it run in that overlap.  Otherwise fallback to simply
+			 * letting it have the run of the CPUs in the new cpuset.
+			 */
+			cpus_and(cpus, p->cpus_allowed, cs->cpus_allowed);
+			if (cpus_empty(cpus))
+				cpus = cs->cpus_allowed;
+			set_cpus_allowed(p, cpus);
+		}
 		put_task_struct(p);
 	}
 	kfree(array);
@@ -608,7 +719,7 @@
 	 * by the first pass */
 	if (first) {
 		first = 0;
-		goto retry;
+		goto again;
 	}
 }

@@ -724,19 +835,37 @@
 		return -ESRCH;
 	}
 	atomic_inc(&cs->count);
+
+	/* depending on current and future cpuset for this task,
+	 * affinity masks may be meaningful or not
+	 */
+	cpumask_t virt_allowed, allowed;
+	if (is_virtualized(cs) == is_virtualized(tsk->cpuset)) {
+		virt_allowed = tsk->cpus_virt_allowed;
+		allowed = tsk->cpus_allowed;
+	} else {
+		virt_allowed = CPU_MASK_ALL;
+		allowed = CPU_MASK_ALL;
+	}
+
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
+
+	if (is_virtualized(cs))
+		set_cpus_virt_allowed(tsk, virt_allowed);
+	else {
+		/*
+		 * If the tasks current CPU placement overlaps with its new cpuset,
+		 * then let it run in that overlap.  Otherwise fallback to simply
+		 * letting it have the run of the CPUs in the new cpuset.
+		 */
+		if (cpus_intersects(allowed, cs->cpus_allowed))
+			cpus_and(cpus, allowed, cs->cpus_allowed);
+		else
+			cpus = cs->cpus_allowed;
+		set_cpus_allowed(tsk, cpus);
+	}

 	put_task_struct(tsk);
 	if (atomic_dec_and_test(&oldcs->count))
@@ -753,6 +882,7 @@
 	FILE_MEMLIST,
 	FILE_CPU_EXCLUSIVE,
 	FILE_MEM_EXCLUSIVE,
+	FILE_VIRTUALIZE,
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_TASKLIST,
 } cpuset_filetype_t;
@@ -800,6 +930,9 @@
 	case FILE_MEM_EXCLUSIVE:
 		retval = update_flag(CS_MEM_EXCLUSIVE, cs, buffer);
 		break;
+	case FILE_VIRTUALIZE:
+		retval = update_flag(CS_VIRTUALIZED, cs, buffer);
+		break;
 	case FILE_NOTIFY_ON_RELEASE:
 		retval = update_flag(CS_NOTIFY_ON_RELEASE, cs, buffer);
 		break;
@@ -901,6 +1034,9 @@
 	case FILE_MEM_EXCLUSIVE:
 		*s++ = is_mem_exclusive(cs) ? '1' : '0';
 		break;
+	case FILE_VIRTUALIZE:
+		*s++ = is_virtualized(cs) ? '1' : '0';
+		break;
 	case FILE_NOTIFY_ON_RELEASE:
 		*s++ = notify_on_release(cs) ? '1' : '0';
 		break;
@@ -1246,6 +1382,11 @@
 	.private = FILE_MEM_EXCLUSIVE,
 };

+static struct cftype cft_virtualize = {
+	.name = "virtualize",
+	.private = FILE_VIRTUALIZE,
+};
+
 static struct cftype cft_notify_on_release = {
 	.name = "notify_on_release",
 	.private = FILE_NOTIFY_ON_RELEASE,
@@ -1264,6 +1405,8 @@
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_mem_exclusive)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_virtualize)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_notify_on_release)) < 0)
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
Index: mm4/kernel/sched.c
===================================================================
--- mm4.orig/kernel/sched.c	2004-09-07 11:36:18.000000000 +0200
+++ mm4/kernel/sched.c	2004-09-10 10:11:48.408438971 +0200
@@ -3196,6 +3196,11 @@
 	return copy_from_user(new_mask, user_mask_ptr, len) ? -EFAULT : 0;
 }

+#ifdef CONFIG_CPUSETS
+int cpuset_set_cpus_affinity(task_t *p, cpumask_t mask);
+int cpuset_get_cpus_virt_affinity(task_t *p, cpumask_t *mask);
+#endif
+
 /**
  * sys_sched_setaffinity - set the cpu affinity of a process
  * @pid: pid of the process
@@ -3205,7 +3210,7 @@
 asmlinkage long sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long __user *user_mask_ptr)
 {
-	cpumask_t new_mask, cpus_allowed;
+	cpumask_t new_mask;
 	int retval;
 	task_t *p;

@@ -3236,9 +3241,11 @@
 			!capable(CAP_SYS_NICE))
 		goto out_unlock;

-	cpus_allowed = cpuset_cpus_allowed(p);
-	cpus_and(new_mask, new_mask, cpus_allowed);
+#ifdef CONFIG_CPUSETS
+	retval = cpuset_set_cpus_affinity(p, new_mask);
+#else
 	retval = set_cpus_allowed(p, new_mask);
+#endif

 out_unlock:
 	put_task_struct(p);
@@ -3288,7 +3295,12 @@
 		goto out_unlock;

 	retval = 0;
+#ifdef CONFIG_CPUSETS
+	if (cpuset_get_cpus_virt_affinity(p, &mask) < 0)
+		cpus_and(mask, p->cpus_allowed, cpu_possible_map);
+#else
 	cpus_and(mask, p->cpus_allowed, cpu_possible_map);
+#endif

 out_unlock:
 	read_unlock(&tasklist_lock);
