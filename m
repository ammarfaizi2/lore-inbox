Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031603AbWLAQyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031603AbWLAQyL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 11:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031615AbWLAQyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 11:54:11 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:54506 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1031603AbWLAQyJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 11:54:09 -0500
Date: Fri, 1 Dec 2006 22:23:22 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: menage@google.com
Cc: akpm@osdl.org, pj@sgi.com, sekharan@us.ibm.com, dev@sw.ru, xemul@sw.ru,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       mbligh@google.com, winget@google.com, rohitseth@google.com,
       devel@openvz.org, Ingo Molnar <mingo@elte.hu>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Dipankar <dipankar@in.ibm.com>,
       Balbir Singh <balbir@in.ibm.com>
Subject: [Patch 3/3] cpuset interface
Message-ID: <20061201165322.GC26550@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20061123120848.051048000@menage.corp.google.com> <20061123123414.641150000@menage.corp.google.com> <20061201164632.GA26550@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061201164632.GA26550@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patchs extends cpusets to support creation of metered cpusets. Changes 
made to cpusets are:

	- Every cpuset directory has two new files:
			cpu_meter_enabled, cpu_meter_limit
	- Writing '1' into 'cpu_meter_enabled' marks the cpuset as "metered" i.e
  	  tasks in this cpuset and its child cpusets will have their CPU
 	  usage controlled by the CPU controller as per the limit settings
	  mentioned in 'cpu_meter_limit'.
	- Writing a number between 0-100 into 'cpu_meter_limit' file of a 
	  metered cpuset assigns corresponding bandwidth for all tasks in the 
	  cpuset (task-group).
	- Only cpusets marked as "exclusive" can be metered.
	- cpusets that have child cpusets cannot be metered. 
	- Metered cpusets cannot have grand-children!

Metered cpusets was discussed elaborately at:

	http://lkml.org/lkml/2005/9/26/58

This patch was inspired from those discussions and is a subset of the features
provided in the earlier patch.

To use this feature, apply the following patches in order (on top of
2.6.19-rc6):

	http://lkml.org/lkml/2006/11/23/97
	http://lkml.org/lkml/2006/11/23/99
	http://lkml.org/lkml/2006/11/23/101
	Patch 1/3 (in this series)
	Patch 2/3 (in this series)
	Patch 3/3 (this patch)

Enable CONFIG_CPUSETS and CONFIG_CPUMETER.

As an example, follow these steps to create metered cpusets:


	# alias echo="/bin/echo"

	# cd /dev
	# mkdir container
	# mount -t container container container

	# cd container

	# echo 1 > cpu_exclusive

	# mkdir test
	# cd test

	# echo 1 > cpus		# Assign CPU3 to the cpuset. 
	# echo 0 > mems		# assign node 0
	# echo 1 > cpu_exclusive
	# echo 1 > cpu_meter_enabled	# "test" is now a "metered" cpuset

	# # Because parent is marked 'cpu_meter_enabled',
	# # mkdir below automatically copied 'cpus', 'mems' and
	# # 'cpu_meter_enabled' from the parent to the new child.

	# mkdir very_imp_grp
	# mkdir less_imp_grp

	# # Assign 70% bandwidth to very_imp_grp
	# echo 70 > very_imp_grp/cpu_meter_limit

	# # Assign 20% bandwidth to less_imp_grp
	# echo 20 > less_imp_grp/cpu_meter_limit

	# echo $very_imp_task1_pid > very_imp_grp/tasks
	# echo $very_imp_task2_pid > very_imp_grp/tasks

	# echo $less_imp_task1_pid > less_imp_grp/tasks
	# echo $less_imp_task2_pid > less_imp_grp/tasks

	  
Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>

---

 linux-2.6.19-rc6-vatsa/include/linux/cpuset.h |   13 +
 linux-2.6.19-rc6-vatsa/include/linux/sched.h  |   15 +
 linux-2.6.19-rc6-vatsa/init/Kconfig           |    8 
 linux-2.6.19-rc6-vatsa/init/main.c            |    4 
 linux-2.6.19-rc6-vatsa/kernel/cpuset.c        |  222 +++++++++++++++++++++++++-
 linux-2.6.19-rc6-vatsa/kernel/sched.c         |   86 +++++++++-
 6 files changed, 343 insertions(+), 5 deletions(-)

diff -puN include/linux/cpuset.h~cpuset_interface include/linux/cpuset.h
--- linux-2.6.19-rc6/include/linux/cpuset.h~cpuset_interface	2006-12-01 20:45:14.000000000 +0530
+++ linux-2.6.19-rc6-vatsa/include/linux/cpuset.h	2006-12-01 20:45:14.000000000 +0530
@@ -62,6 +62,15 @@ extern void cpuset_track_online_nodes(vo
 
 extern int current_cpuset_is_being_rebound(void);
 
+#ifdef CONFIG_CPUMETER
+void *cpu_ctlr_data(struct task_struct *p);
+#else
+static inline void *cpu_ctlr_data(struct task_struct *p)
+{
+	return NULL;
+}
+#endif
+
 #else /* !CONFIG_CPUSETS */
 
 static inline int cpuset_init_early(void) { return 0; }
@@ -127,6 +136,10 @@ static inline int current_cpuset_is_bein
 	return 0;
 }
 
+static inline void *cpu_ctlr_data(struct task_struct *p)
+{
+	return NULL;
+}
 #endif /* !CONFIG_CPUSETS */
 
 #endif /* _LINUX_CPUSET_H */
diff -puN init/main.c~cpuset_interface init/main.c
--- linux-2.6.19-rc6/init/main.c~cpuset_interface	2006-12-01 20:45:14.000000000 +0530
+++ linux-2.6.19-rc6-vatsa/init/main.c	2006-12-01 20:45:14.000000000 +0530
@@ -507,6 +507,8 @@ asmlinkage void __init start_kernel(void
 	unwind_setup();
 	setup_per_cpu_areas();
 	smp_prepare_boot_cpu();	/* arch-specific boot-cpu hooks */
+	container_init_early();
+	cpuset_init_early();
 
 	/*
 	 * Set up the scheduler prior starting any interrupts (such as the
@@ -569,8 +571,6 @@ asmlinkage void __init start_kernel(void
 	}
 #endif
 	vfs_caches_init_early();
-	container_init_early();
-	cpuset_init_early();
 	mem_init();
 	kmem_cache_init();
 	setup_per_cpu_pageset();
diff -puN kernel/cpuset.c~cpuset_interface kernel/cpuset.c
--- linux-2.6.19-rc6/kernel/cpuset.c~cpuset_interface	2006-12-01 20:45:14.000000000 +0530
+++ linux-2.6.19-rc6-vatsa/kernel/cpuset.c	2006-12-01 20:46:08.000000000 +0530
@@ -92,6 +92,9 @@ struct cpuset {
 	int mems_generation;
 
 	struct fmeter fmeter;		/* memory_pressure filter */
+#ifdef CONFIG_CPUMETER
+	void *cpu_ctlr_data;
+#endif
 };
 
 /* Update the cpuset for a container */
@@ -129,6 +132,9 @@ typedef enum {
 	CS_MEMORY_MIGRATE,
 	CS_SPREAD_PAGE,
 	CS_SPREAD_SLAB,
+#ifdef CONFIG_CPUMETER
+	CS_METER_FLAG,
+#endif
 } cpuset_flagbits_t;
 
 /* convenient tests for these bits */
@@ -157,6 +163,140 @@ static inline int is_spread_slab(const s
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
+	/* checks for change in meter flag */
+	is_changed = (is_metered(trial) != is_metered(cur));
+
+	is_exclusive_changed = (is_cpu_exclusive(trial) !=
+							 is_cpu_exclusive(cur));
+
+	/* Cant change meter setting if a cpuset already has children */
+	if (is_changed && !list_empty(&cur->css.container->children)) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	/* Can't change meter setting for children of metered cpusets */
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
+	/* Cant change cpus_allowed of a metered cpuset */
+	cpus_and(trial_mask, trial->cpus_allowed, cpu_possible_map);
+	cpus_and(cur_mask, cur->cpus_allowed, cpu_possible_map);
+	if (is_metered(cur) && !cpus_equal(trial_mask, cur_mask)) {
+		rc = -EBUSY;
+		goto out;
+	}
+
+	rc = 0;
+
+out:
+	return rc;
+}
+
+static void update_meter(struct cpuset *cs)
+{
+	if (is_metered(cs))
+		cs->cpu_ctlr_data = cpu_ctlr->create_group();
+	else {
+		cpu_ctlr->destroy_group(cs->cpu_ctlr_data);
+		/* Do we have any races here ? */
+		cs->cpu_ctlr_data = NULL;
+	}
+}
+
+static int update_limit(struct cpuset *cs, char *buf)
+{
+	unsigned long limit;
+
+	if (!buf || !is_metered(cs))
+		return -EINVAL;
+
+	limit = simple_strtoul(buf, NULL, 10);
+	cpu_ctlr->set_limit(cs->cpu_ctlr_data, limit);
+
+	return 0;
+}
+
+static int cpuset_sprintf_limit(char *page, struct cpuset *cs)
+{
+	unsigned long limit = 0;
+	char *c = page;
+
+	if (is_metered(cs))
+		limit = cpu_ctlr->get_limit(cs->cpu_ctlr_data);
+	c += sprintf (c, "%lu", limit);
+
+	return c - page;
+}
+
+void *cpu_ctlr_data(struct task_struct *p)
+{
+	struct cpuset *cs = task_cs(p);
+
+	return cs->cpu_ctlr_data;
+}
+
+void cpu_ctlr_move_task(struct task_struct *p, struct cpuset *old,
+						 struct cpuset *new)
+{
+	cpu_ctlr->move_task(p, old->cpu_ctlr_data, new->cpu_ctlr_data);
+}
+
+#define init_cpu_ctlr_data(cs)	(cs->cpu_ctlr_data = NULL)
+
+#else
+
+#define init_cpu_ctlr_data(cs)
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
+static int update_limit(struct cpuset *cs, char *buf)
+{
+	return 0;
+}
+
+static void cpu_ctlr_move_task(struct task_struct *p, struct cpuset *old,
+						 struct cpuset *new)
+{
+}
+
+#endif	/* CONFIG_CPUMETER */
+
 /*
  * Increment this integer everytime any cpuset changes its
  * mems_allowed value.  Users of cpusets can track this generation
@@ -374,6 +514,10 @@ static int validate_change(const struct 
 {
 	struct container *cont;
 	struct cpuset *c, *par;
+	int rc = 0;
+
+	if ((rc = validate_meters(cur, trial)))
+		return rc;
 
 	/* Each of our child cpusets must be a subset of us */
 	list_for_each_entry(cont, &cur->css.container->children, sibling) {
@@ -710,7 +854,7 @@ static int __update_flag(cpuset_flagbits
 {
 	int turning_on;
 	struct cpuset trialcs;
-	int err, cpu_exclusive_changed;
+	int err, cpu_exclusive_changed, meter_changed;
 
 	turning_on = (simple_strtoul(buf, NULL, 10) != 0);
 
@@ -725,6 +869,7 @@ static int __update_flag(cpuset_flagbits
 		return err;
 	cpu_exclusive_changed =
 		(is_cpu_exclusive(cs) != is_cpu_exclusive(&trialcs));
+	meter_changed = (is_metered(cs) != is_metered(&trialcs));
 	if (turning_on)
 		set_bit(bit, &cs->flags);
 	else
@@ -732,7 +877,9 @@ static int __update_flag(cpuset_flagbits
 
 	if (cpu_exclusive_changed)
 		update_cpu_domains(cs);
-	return 0;
+	if (meter_changed)
+		update_meter(cs);
+	return err;
 }
 
 static int update_flag(cpuset_flagbits_t bit, struct cpuset *cs, char *buf)
@@ -860,6 +1007,7 @@ void cpuset_attach(struct container_subs
 {
 	cpumask_t cpus;
 	guarantee_online_cpus(container_cs(cont), &cpus);
+	cpu_ctlr_move_task(tsk, container_cs(old_cont), container_cs(cont));
 	set_cpus_allowed(tsk, cpus);
 }
 
@@ -897,6 +1045,10 @@ typedef enum {
 	FILE_MEMORY_PRESSURE,
 	FILE_SPREAD_PAGE,
 	FILE_SPREAD_SLAB,
+#ifdef CONFIG_CPUMETER
+	FILE_CPU_METER_ENABLED,
+	FILE_CPU_METER_LIMIT,
+#endif
 } cpuset_filetype_t;
 
 static ssize_t cpuset_common_file_write(struct container *cont,
@@ -961,6 +1113,14 @@ static ssize_t cpuset_common_file_write(
 		retval = update_flag(CS_SPREAD_SLAB, cs, buffer);
 		cs->mems_generation = cpuset_mems_generation++;
 		break;
+#ifdef CONFIG_CPUMETER
+	case FILE_CPU_METER_ENABLED:
+		retval = update_flag(CS_METER_FLAG, cs, buffer);
+		break;
+	case FILE_CPU_METER_LIMIT:
+		retval = update_limit(cs, buffer);
+		break;
+#endif
 	default:
 		retval = -EINVAL;
 		goto out2;
@@ -1054,6 +1214,14 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_SPREAD_SLAB:
 		*s++ = is_spread_slab(cs) ? '1' : '0';
 		break;
+#ifdef CONFIG_CPUMETER
+	case FILE_CPU_METER_ENABLED:
+		*s++ = is_metered(cs) ? '1' : '0';
+		break;
+	case FILE_CPU_METER_LIMIT:
+		s += cpuset_sprintf_limit(s, cs);
+		break;
+#endif
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1134,6 +1302,23 @@ static struct cftype cft_spread_slab = {
 	.private = FILE_SPREAD_SLAB,
 };
 
+#ifdef CONFIG_CPUMETER
+static struct cftype cft_meter_flag = {
+	.name = "cpu_meter_enabled",
+	.read = cpuset_common_file_read,
+	.write = cpuset_common_file_write,
+	.private = FILE_CPU_METER_ENABLED,
+};
+
+static struct cftype cft_meter_limit = {
+	.name = "cpu_meter_limit",
+	.read = cpuset_common_file_read,
+	.write = cpuset_common_file_write,
+	.private = FILE_CPU_METER_LIMIT,
+};
+
+#endif
+
 int cpuset_populate(struct container_subsys *ss, struct container *cont)
 {
 	int err;
@@ -1157,6 +1342,12 @@ int cpuset_populate(struct container_sub
 	/* memory_pressure_enabled is in root cpuset only */
 	if (err == 0 && !cont->parent)
 		err = container_add_file(cont, &cft_memory_pressure_enabled);
+#ifdef CONFIG_CPUMETER
+	if ((err = container_add_file(cont, &cft_meter_flag)) < 0)
+		return err;
+	if ((err = container_add_file(cont, &cft_meter_limit)) < 0)
+		return err;
+#endif
 	return 0;
 }
 
@@ -1183,12 +1374,18 @@ int cpuset_create(struct container_subsy
 	}
 	parent = container_cs(cont->parent);
 	set_container_cs(cont, NULL);
+
+	/* metered cpusets cant have grand-children! */
+	if (parent->parent && is_metered(parent->parent))
+		return -EINVAL;
+
 	cs = kmalloc(sizeof(*cs), GFP_KERNEL);
 	if (!cs)
 		return -ENOMEM;
 
 	cpuset_update_task_memory_state();
 	cs->flags = 0;
+	init_cpu_ctlr_data(cs);
 	if (is_spread_page(parent))
 		set_bit(CS_SPREAD_PAGE, &cs->flags);
 	if (is_spread_slab(parent))
@@ -1202,6 +1399,13 @@ int cpuset_create(struct container_subsy
 	set_container_cs(cont, cs);
 	cs->css.container = cont;
 	number_of_cpusets++;
+	if (is_metered(parent)) {
+		cs->cpus_allowed = parent->cpus_allowed;
+		cs->mems_allowed = parent->mems_allowed;
+		set_bit(CS_METER_FLAG, &cs->flags);
+		update_meter(cs);
+	}
+
 	return 0;
 }
 
@@ -1224,6 +1428,10 @@ void cpuset_destroy(struct container_sub
 		return;
 
 	cpuset_update_task_memory_state();
+	if (is_metered(cs)) {
+		clear_bit(CS_METER_FLAG, &cs->flags);
+		update_meter(cs);
+	}
 	if (is_cpu_exclusive(cs)) {
 		int retval = __update_flag(CS_CPU_EXCLUSIVE, cs, "0");
 		BUG_ON(retval);
@@ -1232,6 +1440,13 @@ void cpuset_destroy(struct container_sub
 	kfree(cs);
 }
 
+#ifdef CONFIG_CPUMETER
+static void cpuset_exit(struct container_subsys *ss, struct task_struct *tsk)
+{
+	cpu_ctlr_move_task(tsk, task_cs(tsk), &top_cpuset);
+}
+#endif
+
 static struct container_subsys cpuset_subsys = {
 	.name = "cpuset",
 	.create = cpuset_create,
@@ -1240,6 +1455,9 @@ static struct container_subsys cpuset_su
 	.attach = cpuset_attach,
 	.post_attach = cpuset_post_attach,
 	.populate = cpuset_populate,
+#ifdef CONFIG_CPUMETER
+	.exit = cpuset_exit,
+#endif
 	.subsys_id = -1,
 };
 
diff -puN kernel/sched.c~cpuset_interface kernel/sched.c
--- linux-2.6.19-rc6/kernel/sched.c~cpuset_interface	2006-12-01 20:45:14.000000000 +0530
+++ linux-2.6.19-rc6-vatsa/kernel/sched.c	2006-12-01 20:53:10.000000000 +0530
@@ -726,7 +726,7 @@ enqueue_task_head(struct task_struct *p,
 
 static inline struct task_grp *task_grp(struct task_struct *p)
 {
-	return NULL;
+	return cpu_ctlr_data(p);
 }
 
 /* Mark a task starving - either we shortcircuited its timeslice or we didnt
@@ -835,6 +835,90 @@ static inline void rq_set_recheck(struct
 	rq->need_recheck = check;
 }
 
+/* Allocate cpu_usage structure for the new task-group */
+static void *sched_create_group(void)
+{
+	struct task_grp *tg;
+	int i;
+
+	tg = kmalloc(sizeof(*tg), GFP_KERNEL);
+	if (!tg)
+		return NULL;
+
+	tg->cpu_usage = alloc_percpu(struct cpu_usage);
+	if (!tg->cpu_usage) {
+		kfree(tg);
+		return NULL;
+	}
+
+	tg->limit = 0;	/* No limit */
+
+	for_each_possible_cpu(i) {
+		struct cpu_usage *grp;
+
+		grp = per_cpu_ptr(tg->cpu_usage, i);
+		grp->tokens = 0;
+		grp->last_update = cpu_rq(i)->last_update;
+		grp->starve_count = 0;
+	}
+
+	return tg;
+}
+
+/* Deallocate cpu_usage structure */
+static void sched_destroy_group(struct task_grp *tg)
+{
+	free_percpu(tg->cpu_usage);
+	kfree(tg);
+}
+
+/* Assign quota to this group */
+static int sched_set_limit(struct task_grp *tg, unsigned long limit)
+{
+	int i;
+
+	tg->limit = limit;
+	for_each_possible_cpu(i) {
+		struct cpu_usage *grp;
+
+		grp = per_cpu_ptr(tg->cpu_usage, i);
+		grp->tokens = limit * HZ / 100;
+		grp->last_update = jiffies;
+	}
+	return 0;
+}
+
+/* Return assigned quota for this group */
+static unsigned long sched_get_limit(struct task_grp *tg)
+{
+	if (!tg)
+		return 0;
+
+	return tg->limit;
+}
+
+static void sched_move_task(struct task_struct *p, struct task_grp *old,
+							struct task_grp *new)
+{
+	unsigned long flags;
+	struct rq *rq;
+
+	rq = task_rq_lock(p, &flags);
+	if (p->array && old)
+		clear_tsk_starving(p, old);
+	task_rq_unlock(rq, &flags);
+}
+
+static struct task_grp_ops sched_grp_ops = {
+	.create_group = sched_create_group,
+	.destroy_group = sched_destroy_group,
+	.set_limit = sched_set_limit,
+	.get_limit = sched_get_limit,
+	.move_task = sched_move_task,
+};
+
+struct task_grp_ops *cpu_ctlr = &sched_grp_ops;
+
 #else
 
 #define task_starving(p)	0
diff -puN include/linux/sched.h~cpuset_interface include/linux/sched.h
--- linux-2.6.19-rc6/include/linux/sched.h~cpuset_interface	2006-12-01 20:45:14.000000000 +0530
+++ linux-2.6.19-rc6-vatsa/include/linux/sched.h	2006-12-01 20:45:14.000000000 +0530
@@ -1695,6 +1695,21 @@ static inline void thaw_processes(void) 
 static inline int try_to_freeze(void) { return 0; }
 
 #endif /* CONFIG_PM */
+
+#ifdef CONFIG_CPUMETER
+struct task_grp;
+struct task_grp_ops {
+	void *(*create_group)(void);
+	void (*destroy_group)(struct task_grp *grp);
+	int (*set_limit)(struct task_grp *grp, unsigned long limit);
+	unsigned long (*get_limit)(struct task_grp *grp);
+	void (*move_task)(struct task_struct *p, struct task_grp *old,
+						struct task_grp *new);
+};
+
+extern struct task_grp_ops *cpu_ctlr;
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif
diff -puN init/Kconfig~cpuset_interface init/Kconfig
--- linux-2.6.19-rc6/init/Kconfig~cpuset_interface	2006-12-01 20:45:14.000000000 +0530
+++ linux-2.6.19-rc6-vatsa/init/Kconfig	2006-12-01 20:45:14.000000000 +0530
@@ -265,6 +265,14 @@ config CPUSETS
 
 	  Say N if unsure.
 
+config CPUMETER
+	bool "CPU resource control"
+	depends on CPUSETS && EXPERIMENTAL
+	help
+	  This options lets you create cpu resource partitions within
+	  cpusets. Each resource partition can be given a different quota
+	  of CPU usage.
+
 config PROC_PID_CPUSET
 	bool "Include legacy /proc/<pid>/cpuset file"
 	depends on CPUSETS
_

-- 
Regards,
vatsa
