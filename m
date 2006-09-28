Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030302AbWI1Rez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030302AbWI1Rez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 13:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWI1Rey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 13:34:54 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:23005 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030302AbWI1Rex (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 13:34:53 -0400
Date: Thu, 28 Sep 2006 23:04:38 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org, Kirill Korotaev <dev@openvz.org>,
       Mike Galbraith <efault@gmx.de>, Balbir Singh <balbir@in.ibm.com>,
       sekharan@us.ibm.com, Andrew Morton <akpm@osdl.org>,
       nagar@watson.ibm.com, matthltc@us.ibm.com, dipankar@in.ibm.com,
       ckrm-tech@lists.sourceforge.net, pj@sgi.com
Subject: [RFC, PATCH 9/9] CPU Controller V2 - cpuset interface
Message-ID: <20060928173438.GJ8746@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060928172520.GA8746@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928172520.GA8746@in.ibm.com>
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
	  down the lane. 

===============================================================================

This patch makes some extension to cpusets as below:

	- Every cpuset directory has two new files:
			cpu_meter_enabled, cpu_meter_quota
	- Writing '1' into 'cpu_meter_enabled' marks the cpuset as "metered" i.e
  	  tasks in this cpuset and its child cpusets will have their CPU
 	  usage controlled by the controller as per the quota settings
	  mentioned in 'cpu_meter_quota'.
	- Writing a number between 0-100 into 'cpu_meter_quota' file of a 
	  metered cpuset assigns corresponding bandwidth for all tasks in the 
	  cpuset (task-group).
	- Only cpusets marked as "exclusive" can be metered.
	- cpusets that have child cpusets cannot be metered. 
	- (Temporary limitation:) cpusets which are "in-use" (i.e tasks are
	  attached to it) cannot be metered
	- Metered cpusets cannot have grand-children!

Metered cpusets was discussed elaborately at:

	http://lkml.org/lkml/2005/9/26/58

This patch was inspired from those discussions and is a subset of the features
provided in the earlier patch.

As an example, follow these steps to create metered cpusets:


	# alias echo="/bin/echo"

	# cd /dev
	# mkdir cpuset
	# mount -t cpuset cpuset cpuset

	# cd cpuset

	# echo 1 > cpu_exclusive

	# mkdir all
	# cd all

	# echo "0-N" > cpus	# Assign all CPUs to the cpuset. 
				# (replace N with number of cpus in system)
	# echo 0 > mems		# assign node 0
	# echo 1 > cpu_exclusive
	# echo 1 > cpu_meter_enabled	# "all" is now a "metered" cpuset

	# # Because parent is marked 'cpu_meter_enabled',
	# # mkdir below automatically copied 'cpus', 'mems' and
	# # 'cpu_meter_enabled' from the parent to the new child.

	# mkdir default
	# mkdir very_imp_grp
	# mkdir less_imp_grp

	# # Assign 10% bandwidth to default group
	# echo 10 > default/cpu_meter_quota

	# # Assign 70% bandwidth to very_imp_grp
	# echo 70 > very_imp_grp/cpu_meter_quota

	# # Assign 20% bandwidth to less_imp_grp
	# echo 20 > less_imp_grp/cpu_meter_quota


	# # Now transfer all existing tasks in system to default cpuset
	# sed -nu p < /dev/cpuset/tasks > /dev/cpuset/all/default/tasks

	# # After the above step, 'cat /dev/cpuset/tasks' should output
	# # nothing. Otherwise, repeat the sed command, until cat displays
	# # nothing.

	# echo $very_imp_task1_pid > very_imp_grp/tasks
	# echo $very_imp_task2_pid > very_imp_grp/tasks

	# echo $less_imp_task1_pid > less_imp_grp/tasks
	# echo $less_imp_task2_pid > less_imp_grp/tasks

	  
Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.18-root/include/linux/cpuset.h |    9 +
 linux-2.6.18-root/init/main.c            |    2 
 linux-2.6.18-root/kernel/cpuset.c        |  255 ++++++++++++++++++++++++++++++-
 linux-2.6.18-root/kernel/sched.c         |    9 -
 4 files changed, 271 insertions(+), 4 deletions(-)

diff -puN kernel/cpuset.c~cpuset_interface kernel/cpuset.c
--- linux-2.6.18/kernel/cpuset.c~cpuset_interface	2006-09-28 16:42:00.073786832 +0530
+++ linux-2.6.18-root/kernel/cpuset.c	2006-09-28 17:18:32.261523640 +0530
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
@@ -148,6 +154,180 @@ static inline int is_spread_slab(const s
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
+	int is_changed, is_exclusive_changed, rc = -EINVAL;
+	cpumask_t cur_mask, trial_mask;
+
+	get_cpu();	/* Disable CPU Hotplug for accessing cpu_online_map */
+
+	/* checks for change in meter flag */
+	is_changed = (is_metered(trial) != is_metered(cur));
+
+	is_exclusive_changed = (is_cpu_exclusive(trial) !=
+							 is_cpu_exclusive(cur));
+
+	/* Temporary limitation until we can get to tasks of a cpuset easily:
+	 *
+	 * 	can't change meter setting of cpuset which is already "in-use"
+	 * 	(it has tasks attached to it)
+	 */
+	if (is_changed && atomic_read(&cur->count) != 0) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	/* Cant change meter setting if a cpuset already has children */
+	if (is_changed && !list_empty(&cur->children)) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	/* Must meter child of metered parent */
+	if (parent && is_metered(parent) && !is_metered(trial))
+		goto out;
+
+	/* Turn on metering only if a cpuset is exclusive */
+	if (parent && !is_metered(parent) && is_metered(trial) &&
+		       					!is_cpu_exclusive(cur))
+		goto out;
+
+	/* Cant change exclusive setting if a cpuset is metered */
+	if (is_exclusive_changed && is_metered(cur))
+		goto out;
+
+
+	/* Cant change cpus_allowed of a metered cpuset */
+	cpus_and(trial_mask, trial->cpus_allowed, cpu_online_map);
+	cpus_and(cur_mask, cur->cpus_allowed, cpu_online_map);
+	if (is_metered(cur) && !cpus_equal(trial_mask, cur_mask)) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	rc = 0;
+
+out:
+	put_cpu();
+	return rc;
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
+	} else {
+		cpu_ctlr->dealloc_group(cs->cpu_ctlr_data);
+		/* Do we have any races here ? */
+		cs->cpu_ctlr_data = NULL;
+	}
+}
+
+static int update_quota(struct cpuset *cs, char *buf)
+{
+	int quota;
+
+	if (!buf || !is_metered(cs))
+		return -EINVAL;
+
+	/* Temporary limitation until we can get to tasks of a cpuset easily:
+	 *
+	 * 	can't change quota of cpuset which is already "in-use"
+	 * 	(it has tasks attached to it)
+	 */
+	if (atomic_read(&cs->count))
+		return -EBUSY;
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
+static int cpu_ctlr_pre_move_task(struct task_struct *tsk,
+	 unsigned long *flags, struct cpuset *oldcs, struct cpuset *newcs)
+{
+	int change_rq, rc = 0;
+
+	change_rq = is_metered(oldcs) || is_metered(newcs);
+
+	if (change_rq)
+		rc = cpu_ctlr->pre_move_task(tsk, flags, oldcs->cpu_ctlr_data,
+			       			  newcs->cpu_ctlr_data);
+
+	return rc;
+}
+
+static void cpu_ctlr_post_move_task(struct task_struct *tsk,
+				 unsigned long *flags, int rc)
+{
+	cpu_ctlr->post_move_task(tsk, flags, rc);
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
+static int cpu_ctlr_pre_move_task(struct task_struct *tsk,
+	 unsigned long *flags, struct cpuset *oldcs, struct cpuset *newcs)
+{
+	return 0;
+}
+
+static void cpu_ctlr_post_move_task(struct task_struct *tsk,
+				 unsigned long *flags, int rc)
+{
+	return;
+}
+#endif	/* CONFIG_CPUMETER */
+
 /*
  * Increment this integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
@@ -722,6 +902,10 @@ static int is_cpuset_subset(const struct
 static int validate_change(const struct cpuset *cur, const struct cpuset *trial)
 {
 	struct cpuset *c, *par;
+	int rc = 0;
+
+	if ((rc = validate_meters(cur, trial)))
+		return rc;
 
 	/* Each of our child cpusets must be a subset of us */
 	list_for_each_entry(c, &cur->children, sibling) {
@@ -1041,7 +1225,7 @@ static int update_flag(cpuset_flagbits_t
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err, cpu_exclusive_changed;
+	int err, cpu_exclusive_changed, meter_changed;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -1056,6 +1240,7 @@ static int update_flag(cpuset_flagbits_t
 		return err;
 	cpu_exclusive_changed =
 		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
+	meter_changed = (is_metered(cs) != is_metered(&trialcs));
 	mutex_lock(&callback_mutex);
 	if (turning_on)
 		set_bit(bit, &cs->flags);
@@ -1065,7 +1250,9 @@ static int update_flag(cpuset_flagbits_t
 
 	if (cpu_exclusive_changed)
                 update_cpu_domains(cs);
-	return 0;
+	if (meter_changed)
+		update_meter(cs);
+	return err;
 }
 
 /*
@@ -1184,6 +1371,7 @@ static int attach_task(struct cpuset *cs
 	nodemask_t from, to;
 	struct mm_struct *mm;
 	int retval;
+	unsigned long flags;
 
 	if (sscanf(pidbuf, "%d", &pid) != 1)
 		return -EIO;
@@ -1229,7 +1417,10 @@ static int attach_task(struct cpuset *cs
 		return -ESRCH;
 	}
 	atomic_inc(&cs->count);
+	retval = cpu_ctlr_pre_move_task(tsk, &flags, oldcs, cs);
 	rcu_assign_pointer(tsk->cpuset, cs);
+	if (retval)
+		cpu_ctlr_post_move_task(tsk, &flags, retval);
 	task_unlock(tsk);
 
 	guarantee_online_cpus(cs, &cpus);
@@ -1271,6 +1462,10 @@ typedef enum {
 	FILE_SPREAD_PAGE,
 	FILE_SPREAD_SLAB,
 	FILE_TASKLIST,
+#ifdef CONFIG_CPUMETER
+	FILE_CPU_METER_ENABLED,
+	FILE_CPU_METER_QUOTA,
+#endif
 } cpuset_filetype_t;
 
 static ssize_t cpuset_common_file_write(struct file *file, const char __user *userbuf,
@@ -1340,6 +1535,14 @@ static ssize_t cpuset_common_file_write(
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
+#ifdef CONFIG_CPUMETER
+	case FILE_CPU_METER_ENABLED:
+		retval = update_flag(CS_METER_FLAG, cs, buffer);
+		break;
+	case FILE_CPU_METER_QUOTA:
+		retval = update_quota(cs, buffer);
+		break;
+#endif
 	default:
 		retval = -EINVAL;
 		goto out2;
@@ -1452,6 +1655,14 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_SPREAD_SLAB:
 		*s++ = is_spread_slab(cs) ? '1' : '0';
 		break;
+#ifdef CONFIG_CPUMETER
+	case FILE_CPU_METER_ENABLED:
+		*s++ = is_metered(cs) ? '1' : '0';
+		break;
+	case FILE_CPU_METER_QUOTA:
+		s += cpuset_sprintf_quota(s, cs);
+		break;
+#endif
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1825,6 +2036,19 @@ static struct cftype cft_spread_slab = {
 	.private = FILE_SPREAD_SLAB,
 };
 
+#ifdef CONFIG_CPUMETER
+static struct cftype cft_meter_flag = {
+	.name = "cpu_meter_enabled",
+	.private = FILE_CPU_METER_ENABLED,
+};
+
+static struct cftype cft_meter_quota = {
+	.name = "cpu_meter_quota",
+	.private = FILE_CPU_METER_QUOTA,
+};
+
+#endif
+
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1849,6 +2073,12 @@ static int cpuset_populate_dir(struct de
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
 
@@ -1866,6 +2096,10 @@ static long cpuset_create(struct cpuset 
 	struct cpuset *cs;
 	int err;
 
+	/* metered cpusets cant have grand-children! */
+	if (parent->parent && is_metered(parent->parent))
+		return -EINVAL;
+
 	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
@@ -1898,6 +2132,13 @@ static long cpuset_create(struct cpuset 
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
@@ -1953,6 +2194,10 @@ static int cpuset_rmdir(struct inode *un
 		mutex_unlock(&manage_mutex);
 		return -EBUSY;
 	}
+	if (is_metered(cs)) {
+		clear_bit(CS_METER_FLAG, &cs->flags);
+		update_meter(cs);
+	}
 	if (is_cpu_exclusive(cs)) {
 		int retval = update_flag(CS_CPU_EXCLUSIVE, cs, "0");
 		if (retval < 0) {
@@ -2012,6 +2257,7 @@ int __init cpuset_init(void)
 	top_cpuset.mems_generation = cpuset_mems_generation++;
 
 	init_task.cpuset = &top_cpuset;
+	/* xxx: initialize init_task.cpu_ctlr_data */
 
 	err = register_filesystem(&cpuset_fs_type);
 	if (err < 0)
@@ -2166,9 +2412,14 @@ void cpuset_fork(struct task_struct *chi
 void cpuset_exit(struct task_struct *tsk)
 {
 	struct cpuset *cs;
+	int rc;
+	unsigned long flags;
 
 	cs = tsk->cpuset;
+	rc = cpu_ctlr_pre_move_task(tsk, &flags, cs, &top_cpuset);
 	tsk->cpuset = &top_cpuset;	/* the_top_cpuset_hack - see above */
+	if (rc)
+		cpu_ctlr_post_move_task(tsk, &flags, rc);
 
 	if (notify_on_release(cs)) {
 		char *pathbuf = NULL;
diff -puN include/linux/cpuset.h~cpuset_interface include/linux/cpuset.h
--- linux-2.6.18/include/linux/cpuset.h~cpuset_interface	2006-09-28 16:42:00.077786224 +0530
+++ linux-2.6.18-root/include/linux/cpuset.h	2006-09-28 16:42:00.110781208 +0530
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
diff -puN kernel/sched.c~cpuset_interface kernel/sched.c
--- linux-2.6.18/kernel/sched.c~cpuset_interface	2006-09-28 16:42:00.084785160 +0530
+++ linux-2.6.18-root/kernel/sched.c	2006-09-28 16:42:00.122779384 +0530
@@ -417,7 +417,12 @@ static inline void finish_lock_switch(st
 /* return the task-group to which a task belongs */
 static inline struct task_grp *task_grp(struct task_struct *p)
 {
-	return &init_task_grp;
+	struct task_grp *tg = cpu_ctlr_data(p->cpuset);
+
+	if (!tg)
+        	tg = &init_task_grp;
+
+	return tg;
 }
 
 /*
@@ -7419,6 +7424,8 @@ int sched_assign_quota(struct task_grp *
 	tg_root->left_over_pct -= (quota - old_quota);
 	recalc_dontcare(tg_root);
 
+	/* xxx: change tsk->load_weight of all tasks belonging to this group */
+
 	return 0;
 }
 
diff -puN init/main.c~cpuset_interface init/main.c
--- linux-2.6.18/init/main.c~cpuset_interface	2006-09-28 16:42:00.088784552 +0530
+++ linux-2.6.18-root/init/main.c	2006-09-28 16:42:00.124779080 +0530
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
_
-- 
Regards,
vatsa
