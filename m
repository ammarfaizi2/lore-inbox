Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWHTRtZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWHTRtZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 13:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWHTRtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 13:49:25 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:60299 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751086AbWHTRtW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 13:49:22 -0400
Date: Sun, 20 Aug 2006 23:18:39 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       matthltc@us.ibm.com, dipankar@in.ibm.com
Subject: [PATCH 7/7] CPU controller V1 - (temporary) cpuset interface
Message-ID: <20060820174839.GH13917@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060820174015.GA13917@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060820174015.GA13917@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A controller cannot live in isolation. *Somebody* needs to tell it about
events like new-task-group creation, destruction of existing group,
assignment of bandwidth and finally movement of tasks between task-groups.

We also need *some* interface for grouping tasks and assigning bandwidth
to the task-groups.

cpusets is chosen as this interface for now.

===============================================================================

DISCLAIMER:

	- This by no means is any recommendation for cpuset to be chosen as
	  resource management interface!

	- CPUset interface is chosen for now, because it represents a
	  task-grouping mechanism which is already in mainline and hence
	  makes the review of rest of scheduler changes easy.

	- The CPU controller can be easily hooked to some other interface
	  like Resource Groups or User-bean-counter, should that be decided
	  down the line. 

===============================================================================

This patch makes some extension to cpusets as below:

	- Every cpuset directory has two new files - meter_cpu, cpu_quota
	- Writing '1' into 'meter_cpu' marks the cpuset as "metered" i.e
  	  tasks in this cpuset and its child cpusets will have their CPU
 	  usage controlled by the controller as per the quota settings
	  mentioned in 'cpu_quota'.
	- Writing a number between 0-100 into 'cpu_quota' file of a metered
	  cpuset assigns corresponding bandwidth for all tasks in the 
	  cpuset (task-group).
	- Only cpusets marked as "exclusive" and not having any child cpusets
	  can be metered. 
	- Metered cpusets cannot have grand-children!

Metered cpusets was discussed elaborately at:

	http://lkml.org/lkml/2005/9/26/58

This patch was inspired from those discussions and is a subset of the features
provided in the earlier patch.

As an example, follow these steps to create metered cpusets:


	# cd /dev
	# mkdir cpuset
	# mount -t cpuset cpuset cpuset
	# cd cpuset
	# mkdir grp_a
	# cd grp_a
	# /bin/echo "6-7" > cpus	# assign CPUs 6,7 for this cpuset
	# /bin/echo 0 > mems		# assign node 0 for this cpuset
	# /bin/echo 1 > cpu_exclusive
	# /bin/echo 1 > meter_cpu

	# mkdir very_imp_grp
	# Assign 80% bandwidth to this group
	# /bin/echo 80 > very_imp_grp/cpu_quota

	# echo $apache_webserver_pid > very_imp_grp/tasks

	# mkdir less_imp_grp
	# Assign 5% bandwidth to this group
	# /bin/echo 5 > less_imp_grp/cpu_quota

	# echo $mozilla_browser_pid > less_imp_grp/tasks

	  

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>




 include/linux/cpuset.h |    9 ++
 init/main.c            |    2 
 kernel/cpuset.c        |  214 ++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/sched.c         |    7 +
 4 files changed, 228 insertions(+), 4 deletions(-)

diff -puN kernel/cpuset.c~cpuset_interface kernel/cpuset.c
--- linux-2.6.18-rc3/kernel/cpuset.c~cpuset_interface	2006-08-20 22:22:25.000000000 +0530
+++ linux-2.6.18-rc3-root/kernel/cpuset.c	2006-08-20 22:22:25.000000000 +0530
@@ -99,6 +99,9 @@ struct cpuset {
 	int mems_generation;
 
 	struct fmeter fmeter;		/* memory_pressure filter */
+#ifdef CONFIG_CPUMETER
+	void *cpu_ctlr_data;
+#endif
 };
 
 /* bits in struct cpuset flags field */
@@ -110,6 +113,9 @@ typedef enum {
 	CS_NOTIFY_ON_RELEASE,
 	CS_SPREAD_PAGE,
 	CS_SPREAD_SLAB,
+#ifdef CONFIG_CPUMETER
+	CS_METER_FLAG,
+#endif
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -148,6 +154,139 @@ static inline int is_spread_slab(const s
 	return test_bit(CS_SPREAD_SLAB, &cs->flags);
 }
 
+#ifdef CONFIG_CPUMETER
+static inline int is_metered(const struct cpuset *cs)
+{
+	return test_bit(CS_METER_FLAG, &cs->flags);
+}
+
+/* does the new combination of meter and exclusive flags makes sense? */
+static int validate_meters(const struct cpuset *cur, const struct cpuset *trial)
+{
+	struct cpuset *parent = cur->parent;
+	int is_changed;
+
+	/* checks for change in meter flag */
+	is_changed = (is_metered(trial) != is_metered(cur));
+
+	/* Cant change meter setting if a cpuset already has children */
+	if (is_changed && !list_empty(&cur->children))
+		return -EINVAL;
+
+	/* Cant change meter setting if parent is metered */
+	if (is_changed && parent && is_metered(parent))
+		return -EINVAL;
+
+	/* Turn on metering only if a cpuset is exclusive */
+	if (is_metered(trial) && !is_cpu_exclusive(cur))
+		return -EINVAL;
+
+	/* Cant change exclusive setting if a cpuset is metered */
+	if (!is_cpu_exclusive(trial) && is_metered(cur))
+		return -EINVAL;
+
+	/* Cant change exclusive setting if parent is metered */
+	if (parent && is_metered(parent) && is_cpu_exclusive(trial))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void update_meter(struct cpuset *cs)
+{
+	if (is_metered(cs)) {
+		void *parent_data = NULL;
+
+		if (cs->parent)
+			parent_data = cs->parent->cpu_ctlr_data;
+		cs->cpu_ctlr_data = cpu_ctlr->alloc_group(parent_data);
+	} else
+		cpu_ctlr->dealloc_group(cs->cpu_ctlr_data);
+}
+
+static int update_quota(struct cpuset *cs, char *buf)
+{
+	int quota;
+
+	if (!buf || !is_metered(cs))
+		return -EINVAL;
+
+	quota = simple_strtoul(buf, NULL, 10);
+	cpu_ctlr->assign_quota(cs->cpu_ctlr_data, quota);
+
+	return 0;
+}
+
+static int cpuset_sprintf_quota(char *page, struct cpuset *cs)
+{
+	int quota = 0;
+	char *c = page;
+
+	if (is_metered(cs))
+		quota = cpu_ctlr->get_quota(cs->cpu_ctlr_data);
+	c += sprintf (c, "%d", quota);
+
+	return c - page;
+}
+
+void *cpu_ctlr_data(struct cpuset *cs)
+{
+	return cs->cpu_ctlr_data;
+}
+
+static int cpu_ctlr_pre_move_task(struct task_struct *tsk, struct cpuset *oldcs,
+							   struct cpuset *newcs)
+{
+	int change_rq, rc = 0;
+
+	change_rq = is_metered(oldcs) || is_metered(newcs);
+
+	if (change_rq)
+		rc = cpu_ctlr->pre_move_task(tsk, oldcs->cpu_ctlr_data,
+			       			  newcs->cpu_ctlr_data);
+
+	return rc;
+}
+
+static void cpu_ctlr_post_move_task(struct task_struct *tsk)
+{
+	cpu_ctlr->post_move_task(tsk);
+}
+
+#else
+
+static inline int is_metered(const struct cpuset *cs)
+{
+	return 0;
+}
+
+static int validate_meters(const struct cpuset *cur, const struct cpuset *trial)
+{
+	return 0;
+}
+
+static void update_meter(struct cpuset *cs)
+{
+	return 0;
+}
+
+static int update_quota(struct cpuset *cs, char *buf)
+{
+	return 0;
+}
+
+static int cpu_ctlr_pre_move_task(struct task_struct *tsk, struct cpuset *oldcs,
+							   struct cpuset *newcs)
+{
+	return 0;
+}
+
+static void cpu_ctlr_post_move_task(struct task_struct *tsk)
+{
+	return;
+}
+#endif	/* CONFIG_CPUMETER */
+
 /*
  * Increment this integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
@@ -723,6 +862,9 @@ static int validate_change(const struct 
 {
 	struct cpuset *c, *par;
 
+	if (validate_meters(cur, trial))
+		return -EINVAL;
+
 	/* Each of our child cpusets must be a subset of us */
 	list_for_each_entry(c, &cur->children, sibling) {
 		if (!is_cpuset_subset(c, trial))
@@ -1037,7 +1179,7 @@ static int update_flag(cpuset_flagbits_t
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err, cpu_exclusive_changed;
+	int err, cpu_exclusive_changed, meter_changed;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -1052,6 +1194,7 @@ static int update_flag(cpuset_flagbits_t
 		return err;
 	cpu_exclusive_changed =
 		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
+	meter_changed = (is_metered(cs) != is_metered(&trialcs));
 	mutex_lock(&callback_mutex);
 	if (turning_on)
 		set_bit(bit, &cs->flags);
@@ -1061,7 +1204,9 @@ static int update_flag(cpuset_flagbits_t
 
 	if (cpu_exclusive_changed)
                 update_cpu_domains(cs);
-	return 0;
+	if (meter_changed)
+		update_meter(cs);
+	return err;
 }
 
 /*
@@ -1180,6 +1325,7 @@ static int attach_task(struct cpuset *cs
 	nodemask_t from, to;
 	struct mm_struct *mm;
 	int retval;
+	int callback = 0;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
@@ -1225,7 +1371,10 @@ static int attach_task(struct cpuset *cs
 		return -ESRCH;
 	}
 	atomic_inc(&cs->count);
+	retval = cpu_ctlr_pre_move_task(tsk, oldcs, cs);
 	rcu_assign_pointer(tsk->cpuset, cs);
+	if (retval)
+		cpu_ctlr_post_move_task(tsk);
 	task_unlock(tsk);
 
 	guarantee_online_cpus(cs, &cpus);
@@ -1267,6 +1416,10 @@ typedef enum {
 	FILE_SPREAD_PAGE,
 	FILE_SPREAD_SLAB,
 	FILE_TASKLIST,
+#ifdef CONFIG_CPUMETER
+	FILE_METER_FLAG,
+	FILE_METER_QUOTA,
+#endif
 } cpuset_filetype_t;
 
 static ssize_t cpuset_common_file_write(struct file *file, const char __user *userbuf,
@@ -1336,6 +1489,14 @@ static ssize_t cpuset_common_file_write(
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
+#ifdef CONFIG_CPUMETER
+	case FILE_METER_FLAG:
+		retval = update_flag(CS_METER_FLAG, cs, buffer);
+		break;
+	case FILE_METER_QUOTA:
+		retval = update_quota(cs, buffer);
+		break;
+#endif
 	default:
 		retval = -EINVAL;
 		goto out2;
@@ -1448,6 +1609,14 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_SPREAD_SLAB:
 		*s++ = is_spread_slab(cs) ? '1' : '0';
 		break;
+#ifdef CONFIG_CPUMETER
+	case FILE_METER_FLAG:
+		*s++ = is_metered(cs) ? '1' : '0';
+		break;
+	case FILE_METER_QUOTA:
+		s += cpuset_sprintf_quota(s, cs);
+		break;
+#endif
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1821,6 +1990,18 @@ static struct cftype cft_spread_slab = {
 	.private = FILE_SPREAD_SLAB,
 };
 
+#ifdef CONFIG_CPUMETER
+static struct cftype cft_meter_flag = {
+	.name = "meter_cpu",
+	.private = FILE_METER_FLAG,
+};
+
+static struct cftype cft_meter_quota = {
+	.name = "cpu_quota",
+	.private = FILE_METER_QUOTA,
+};
+#endif
+
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1845,6 +2026,12 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
+#ifdef CONFIG_CPUMETER
+	if ((err = cpuset_add_file(cs_dentry, &cft_meter_flag)) < 0)
+		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_meter_quota)) < 0)
+		return err;
+#endif
 	return 0;
 }
 
@@ -1862,6 +2049,10 @@ static long cpuset_create(struct cpuset 
 	struct cpuset *cs;
 	int err;
 
+	/* metered cpusets cant have grand-children! */
+	if (parent->parent && is_metered(parent->parent))
+		return -EINVAL;
+
 	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
@@ -1894,6 +2085,13 @@ static long cpuset_create(struct cpuset 
 	if (err < 0)
 		goto err;
 
+	if (is_metered(parent)) {
+		cs->cpus_allowed = parent->cpus_allowed;
+		cs->mems_allowed = parent->mems_allowed;
+		set_bit(CS_METER_FLAG, &cs->flags);
+		update_meter(cs);
+	}
+
 	/*
 	 * Release manage_mutex before cpuset_populate_dir() because it
 	 * will down() this new directory's i_mutex and if we race with
@@ -1956,6 +2154,13 @@ static int cpuset_rmdir(struct inode *un
 			return retval;
 		}
 	}
+	if (is_metered(cs)) {
+		int retval = update_flag(CS_METER_FLAG, cs, "0");
+		if (retval < 0) {
+			mutex_unlock(&manage_mutex);
+			return retval;
+		}
+	}
 	parent = cs->parent;
 	mutex_lock(&callback_mutex);
 	set_bit(CS_REMOVED, &cs->flags);
@@ -2008,6 +2213,7 @@ int __init cpuset_init(void)
 	top_cpuset.mems_generation = cpuset_mems_generation++;
 
 	init_task.cpuset = &top_cpuset;
+	/* xxx: initialize init_task.cpu_ctlr_data */
 
 	err = register_filesystem(&cpuset_fs_type);
 	if (err < 0)
@@ -2133,9 +2339,13 @@ void cpuset_fork(struct task_struct *chi
 void cpuset_exit(struct task_struct *tsk)
 {
 	struct cpuset *cs;
+	int rc;
 
 	cs = tsk->cpuset;
+	rc = cpu_ctlr_pre_move_task(tsk, cs, &top_cpuset);
 	tsk->cpuset = &top_cpuset;	/* the_top_cpuset_hack - see above */
+	if (rc)
+		cpu_ctlr_post_move_task(tsk);
 
 	if (notify_on_release(cs)) {
 		char *pathbuf = NULL;
diff -puN include/linux/cpuset.h~cpuset_interface include/linux/cpuset.h
--- linux-2.6.18-rc3/include/linux/cpuset.h~cpuset_interface	2006-08-20 22:22:25.000000000 +0530
+++ linux-2.6.18-rc3-root/include/linux/cpuset.h	2006-08-20 22:22:25.000000000 +0530
@@ -63,6 +63,15 @@ static inline int cpuset_do_slab_mem_spr
 	return current->flags & PF_SPREAD_SLAB;
 }
 
+#ifdef CONFIG_CPUMETER
+void *cpu_ctlr_data(struct cpuset *cs);
+#else
+static inline void *cpu_ctlr_data(struct cpuset *cs)
+{
+	return NULL;
+}
+#endif
+
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
diff -puN init/main.c~cpuset_interface init/main.c
--- linux-2.6.18-rc3/init/main.c~cpuset_interface	2006-08-20 22:22:25.000000000 +0530
+++ linux-2.6.18-rc3-root/init/main.c	2006-08-20 22:22:25.000000000 +0530
@@ -482,6 +482,7 @@ asmlinkage void __init start_kernel(void
 	setup_arch(&command_line);
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
+	cpuset_init_early();
 
 	/*
 	 * Set up the scheduler prior starting any interrupts (such as the
@@ -545,7 +546,6 @@ asmlinkage void __init start_kernel(void
 	}
 #endif
 	vfs_caches_init_early();
-	cpuset_init_early();
 	mem_init();
 	kmem_cache_init();
 	setup_per_cpu_pageset();
diff -puN kernel/sched.c~cpuset_interface kernel/sched.c
--- linux-2.6.18-rc3/kernel/sched.c~cpuset_interface	2006-08-20 22:22:25.000000000 +0530
+++ linux-2.6.18-rc3-root/kernel/sched.c	2006-08-20 22:22:25.000000000 +0530
@@ -737,7 +737,12 @@ static void enqueue_task_grp(struct task
 /* return the task-group to which a task belongs */
 static inline struct task_grp *task_grp(struct task_struct *p)
 {
-	return &init_task_grp;
+	struct task_grp *tg = cpu_ctlr_data(p->cpuset);
+
+	if (!tg)
+		tg = &init_task_grp;
+
+	return tg;
 }
 
 static inline void update_task_grp_prio(struct task_grp_rq *tgrq, struct rq *rq,

_
-- 
Regards,
vatsa
