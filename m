Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbVKEIiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbVKEIiY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 03:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVKEIiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 03:38:24 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:16862 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751252AbVKEIiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 03:38:23 -0500
Date: Sat, 5 Nov 2005 00:38:14 -0800 (PST)
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Simon Derr <Simon.Derr@bull.net>, Andi Kleen <ak@suse.de>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org,
       Christoph Lameter <clameter@sgi.com>
Message-Id: <20051105083814.25512.66381.sendpatchset@jackhammer.engr.sgi.com>
Subject: [PATCH] cpuset: memory pressure meter
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a simple per-cpuset metric of memory pressure, tracking the
-rate- that the tasks in a cpuset call try_to_free_pages(), the
synchronous (direct) memory reclaim code.

This enables batch managers monitoring jobs running in dedicated
cpusets to efficiently detect what level of memory pressure that job
is causing.

This is useful both on tightly managed systems running a wide mix of
submitted jobs, which may choose to terminate or reprioritize jobs that
are trying to use more memory than allowed on the nodes assigned them,
and with tightly coupled, long running, massively parallel scientific
computing jobs that will dramatically fail to meet required performance
goals if they start to use more memory than allowed to them.

This patch just provides a very economical way for the batch manager
to monitor a cpuset for signs of memory pressure.  It's up to the
batch manager or other user code to decide what to do about it and
take action.

==> Unless this feature is enabled by writing "1" to the special file
    /dev/cpuset/memory_pressure_enabled, the hook in the rebalance
    code of __alloc_pages() for this metric reduces to simply noticing
    that the cpuset_memory_pressure_enabled flag is zero.  So only
    systems that enable this feature will compute the metric.

Why a per-cpuset, running average:

    Because this meter is per-cpuset, rather than per-task or mm,
    the system load imposed by a batch scheduler monitoring this
    metric is sharply reduced on large systems, because a scan of
    the tasklist can be avoided on each set of queries.

    Because this meter is a running average, instead of an accumulating
    counter, a batch scheduler can detect memory pressure with a
    single read, instead of having to read and accumulate results
    for a period of time.

    Because this meter is per-cpuset rather than per-task or mm,
    the batch scheduler can obtain the key information, memory
    pressure in a cpuset, with a single read, rather than having to
    query and accumulate results over all the (dynamically changing)
    set of tasks in the cpuset.

A per-cpuset simple digital filter (requires a spinlock and 3 words
of data per-cpuset) is kept, and updated by any task attached to that
cpuset, if it enters the synchronous (direct) page reclaim code.

A per-cpuset file provides an integer number representing the recent
(half-life of 10 seconds) rate of direct page reclaims caused by
the tasks in the cpuset, in units of reclaims attempted per second,
times 1000.

Signed-off-by: Paul Jackson <pj@sgi.com>

---

==> This 'cpuset: memory pressure meter' patch replaces
        [PATCH 5/5] cpuset: memory reclaim rate meter
    sent a couple days ago.

The name of the patch and the names of key variables are
changed to variations of 'memory_pressure', since that is a
better description of what is being metered.

For instance, renamed 'memory_reclaim_rate' to 'memory_pressure',
and similar renames.  The users of this mechanism don't care
that it reports direct reclaim invocation rate.  They care that
it provides a measure of the memory pressure on a cpuset.

 include/linux/cpuset.h |   11 ++
 kernel/cpuset.c        |  194 ++++++++++++++++++++++++++++++++++++++++++++++++-
 mm/page_alloc.c        |    1 
 3 files changed, 205 insertions(+), 1 deletion(-)

--- 2.6.14-rc5-mm1-cpuset-patches.orig/include/linux/cpuset.h	2005-11-04 23:36:24.478947088 -0800
+++ 2.6.14-rc5-mm1-cpuset-patches/include/linux/cpuset.h	2005-11-04 23:49:17.146703303 -0800
@@ -26,6 +26,15 @@ void cpuset_update_current_mems_allowed(
 int cpuset_zonelist_valid_mems_allowed(struct zonelist *zl);
 extern int cpuset_zone_allowed(struct zone *z, gfp_t gfp_mask);
 extern int cpuset_excl_nodes_overlap(const struct task_struct *p);
+
+#define cpuset_memory_pressure_bump() 			\
+	do {						\
+		if (cpuset_memory_pressure_enabled)	\
+			__cpuset_memory_pressure_bump();	\
+	} while (0)
+extern int cpuset_memory_pressure_enabled;
+extern void __cpuset_memory_pressure_bump(void);
+
 extern struct file_operations proc_cpuset_operations;
 extern char *cpuset_task_status_allowed(struct task_struct *task, char *buffer);
 
@@ -60,6 +69,8 @@ static inline int cpuset_excl_nodes_over
 	return 1;
 }
 
+static inline void cpuset_memory_pressure_bump(void) {}
+
 static inline char *cpuset_task_status_allowed(struct task_struct *task,
 							char *buffer)
 {
--- 2.6.14-rc5-mm1-cpuset-patches.orig/kernel/cpuset.c	2005-11-04 23:36:24.478947088 -0800
+++ 2.6.14-rc5-mm1-cpuset-patches/kernel/cpuset.c	2005-11-04 23:49:17.150609596 -0800
@@ -56,6 +56,15 @@
 
 #define CPUSET_SUPER_MAGIC 		0x27e0eb
 
+/* See "Frequency meter" comments, below. */
+
+struct fmeter {
+	int cnt;		/* unprocessed events count */
+	int val;		/* most recent output value */
+	time_t time;		/* clock (secs) when val computed */
+	spinlock_t lock;	/* guards read or write of above */
+};
+
 struct cpuset {
 	unsigned long flags;		/* "unsigned long" so bitops work */
 	cpumask_t cpus_allowed;		/* CPUs allowed to tasks in cpuset */
@@ -81,7 +90,9 @@ struct cpuset {
 	 * Copy of global cpuset_mems_generation as of the most
 	 * recent time this cpuset changed its mems_allowed.
 	 */
-	 int mems_generation;
+	int mems_generation;
+
+	struct fmeter fmeter;		/* memory_pressure filter */
 };
 
 /* bits in struct cpuset flags field */
@@ -174,6 +185,9 @@ static struct cpuset top_cpuset = {
 	.cpus_allowed = CPU_MASK_ALL,
 	.mems_allowed = NODE_MASK_ALL,
 	.marker_pid = 0,
+	.fmeter.cnt = 0,
+	.fmeter.val = 0,
+	.fmeter.time = 0,
 	.count = ATOMIC_INIT(0),
 	.sibling = LIST_HEAD_INIT(top_cpuset.sibling),
 	.children = LIST_HEAD_INIT(top_cpuset.children),
@@ -846,6 +860,19 @@ static int update_marker_pid(struct cpus
 }
 
 /*
+ * Call with manage_sem held.
+ */
+
+static int update_memory_pressure_enabled(struct cpuset *cs, char *buf)
+{
+	if (simple_strtoul(buf, NULL, 10) != 0)
+		cpuset_memory_pressure_enabled = 1;
+	else
+		cpuset_memory_pressure_enabled = 0;
+	return 0;
+}
+
+/*
  * update_flag - read a 0 or a 1 in a file and update associated flag
  * bit:	the bit to update (CS_CPU_EXCLUSIVE, CS_MEM_EXCLUSIVE,
  *						CS_NOTIFY_ON_RELEASE)
@@ -887,6 +914,104 @@ static int update_flag(cpuset_flagbits_t
 }
 
 /*
+ * Frequency meter - How fast is some event occuring?
+ *
+ * These routines manage a digitally filtered, constant time based,
+ * event frequency meter.  There are four routines:
+ *   fmeter_init() - initialize a frequency meter.
+ *   fmeter_markevent() - called each time the event happens.
+ *   fmeter_getrate() - returns the recent rate of such events.
+ *   fmeter_update() - internal routine used to update fmeter.
+ *
+ * A common data structure is passed to each of these routines,
+ * which is used to keep track of the state required to manage the
+ * frequency meter and its digital filter.
+ *
+ * The filter works on the number of events marked per unit time.
+ * The filter is single-pole low-pass recursive (IIR).  The time unit
+ * is 1 second.  Arithmetic is done using 32-bit integers scaled to
+ * simulate 3 decimal digits of precision (multiplied by 1000).
+ *
+ * With an FM_COEF of 933, and a time base of 1 second, the filter
+ * has a half-life of 10 seconds, meaning that if the events quit
+ * happening, then the rate returned from the fmeter_getrate()
+ * will be cut in half each 10 seconds, until it converges to zero.
+ *
+ * It is not worth doing a real infinitely recursive filter.  If more
+ * than FM_MAXTICKS ticks have elapsed since the last filter event,
+ * just compute FM_MAXTICKS ticks worth, by which point the level
+ * will be stable.
+ *
+ * Limit the count of unprocessed events to FM_MAXCNT, so as to avoid
+ * arithmetic overflow in the fmeter_update() routine.
+ *
+ * Given the simple 32 bit integer arithmetic used, this meter works
+ * best for reporting rates between one per millisecond (msec) and
+ * one per 32 (approx) seconds.  At constant rates faster than one
+ * per msec it maxes out at values just under 1,000,000.  At constant
+ * rates between one per msec, and one per second it will stabilize
+ * to a value N*1000, where N is the rate of events per second.
+ * At constant rates between one per second and one per 32 seconds,
+ * it will be choppy, moving up on the seconds that have an event,
+ * and then decaying until the next event.  At rates slower than
+ * about one in 32 seconds, it decays all the way back to zero between
+ * each event.
+ */
+
+#define FM_COEF 933		/* coefficient for half-life of 10 secs */
+#define FM_MAXTICKS ((time_t)99) /* useless computing more ticks than this */
+#define FM_MAXCNT 1000000	/* limit cnt to avoid overflow */
+#define FM_SCALE 1000		/* faux fixed point scale */
+
+/* Initialize a frequency meter */
+static void fmeter_init(struct fmeter *fmp)
+{
+	fmp->cnt = 0;
+	fmp->val = 0;
+	fmp->time = 0;
+	spin_lock_init(&fmp->lock);
+}
+
+/* Internal meter update - process cnt events and update value */
+static void fmeter_update(struct fmeter *fmp)
+{
+	time_t now = get_seconds();
+	time_t ticks = now - fmp->time;
+
+	if (ticks == 0)
+		return;
+
+	ticks = min(FM_MAXTICKS, ticks);
+	while (ticks-- > 0)
+		fmp->val = (FM_COEF * fmp->val) / FM_SCALE;
+	fmp->time = now;
+
+	fmp->val += ((FM_SCALE - FM_COEF) * fmp->cnt) / FM_SCALE;
+	fmp->cnt = 0;
+}
+
+/* Process any previous ticks, then bump cnt by one (times scale). */
+static void fmeter_markevent(struct fmeter *fmp)
+{
+	spin_lock(&fmp->lock);
+	fmeter_update(fmp);
+	fmp->cnt = min(FM_MAXCNT, fmp->cnt + FM_SCALE);
+	spin_unlock(&fmp->lock);
+}
+
+/* Process any previous ticks, then return current value. */
+static int fmeter_getrate(struct fmeter *fmp)
+{
+	int val;
+
+	spin_lock(&fmp->lock);
+	fmeter_update(fmp);
+	val = fmp->val;
+	spin_unlock(&fmp->lock);
+	return val;
+}
+
+/*
  * Attack task specified by pid in 'pidbuf' to cpuset 'cs', possibly
  * writing the path of the old cpuset in 'ppathbuf' if it needs to be
  * notified on release.
@@ -964,6 +1089,8 @@ typedef enum {
 	FILE_MEM_EXCLUSIVE,
 	FILE_NOTIFY_ON_RELEASE,
 	FILE_MARKER_PID,
+	FILE_MEMORY_PRESSURE_ENABLED,
+	FILE_MEMORY_PRESSURE,
 	FILE_TASKLIST,
 } cpuset_filetype_t;
 
@@ -1021,6 +1148,12 @@ static ssize_t cpuset_common_file_write(
 	case FILE_MARKER_PID:
 		retval = update_marker_pid(cs, buffer);
 		break;
+	case FILE_MEMORY_PRESSURE_ENABLED:
+		retval = update_memory_pressure_enabled(cs, buffer);
+		break;
+	case FILE_MEMORY_PRESSURE:
+		retval = -EACCES;
+		break;
 	case FILE_TASKLIST:
 		retval = attach_task(cs, buffer, &pathbuf);
 		break;
@@ -1127,6 +1260,12 @@ static ssize_t cpuset_common_file_read(s
 	case FILE_MARKER_PID:
 		s += sprintf(s, "%d", cs->marker_pid);
 		break;
+	case FILE_MEMORY_PRESSURE_ENABLED:
+		*s++ = cpuset_memory_pressure_enabled ? '1' : '0';
+		break;
+	case FILE_MEMORY_PRESSURE:
+		s += sprintf(s, "%d", fmeter_getrate(&cs->fmeter));
+		break;
 	default:
 		retval = -EINVAL;
 		goto out;
@@ -1480,6 +1619,16 @@ static struct cftype cft_marker_pid = {
 	.private = FILE_MARKER_PID,
 };
 
+static struct cftype cft_memory_pressure_enabled = {
+	.name = "memory_pressure_enabled",
+	.private = FILE_MEMORY_PRESSURE_ENABLED,
+};
+
+static struct cftype cft_memory_pressure = {
+	.name = "memory_pressure",
+	.private = FILE_MEMORY_PRESSURE,
+};
+
 static int cpuset_populate_dir(struct dentry *cs_dentry)
 {
 	int err;
@@ -1496,6 +1645,8 @@ static int cpuset_populate_dir(struct de
 		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_marker_pid)) < 0)
 		return err;
+	if ((err = cpuset_add_file(cs_dentry, &cft_memory_pressure)) < 0)
+		return err;
 	if ((err = cpuset_add_file(cs_dentry, &cft_tasks)) < 0)
 		return err;
 	return 0;
@@ -1531,6 +1682,7 @@ static long cpuset_create(struct cpuset 
 	INIT_LIST_HEAD(&cs->children);
 	atomic_inc(&cpuset_mems_generation);
 	cs->mems_generation = atomic_read(&cpuset_mems_generation);
+	fmeter_init(&cs->fmeter);
 
 	cs->parent = parent;
 
@@ -1620,6 +1772,7 @@ int __init cpuset_init(void)
 	top_cpuset.cpus_allowed = CPU_MASK_ALL;
 	top_cpuset.mems_allowed = NODE_MASK_ALL;
 
+	fmeter_init(&top_cpuset.fmeter);
 	atomic_inc(&cpuset_mems_generation);
 	top_cpuset.mems_generation = atomic_read(&cpuset_mems_generation);
 
@@ -1641,6 +1794,9 @@ int __init cpuset_init(void)
 	top_cpuset.dentry = root;
 	root->d_inode->i_op = &cpuset_dir_inode_operations;
 	err = cpuset_populate_dir(root);
+	/* memory_pressure_enabled is in root cpuset only */
+	if (err == 0)
+		err = cpuset_add_file(root, &cft_memory_pressure_enabled);
 out:
 	return err;
 }
@@ -1930,6 +2086,42 @@ done:
 }
 
 /*
+ * Collection of memory_pressure is suppressed unless
+ * this flag is enabled by writing "1" to the special
+ * cpuset file 'memory_pressure_enabled' in the root cpuset.
+ */
+
+int cpuset_memory_pressure_enabled;
+
+/**
+ * cpuset_memory_pressure_bump - keep stats of per-cpuset reclaims.
+ *
+ * Keep a running average of the rate of synchronous (direct)
+ * page reclaim efforts initiated by tasks in each cpuset.
+ *
+ * This represents the rate at which some task in the cpuset
+ * ran low on memory on all nodes it was allowed to use, and
+ * had to enter the kernels page reclaim code in an effort to
+ * create more free memory by tossing clean pages or swapping
+ * or writing dirty pages.
+ *
+ * Display to user space in the per-cpuset read-only file
+ * "memory_pressure".  Value displayed is an integer
+ * representing the recent rate of entry into the synchronous
+ * (direct) page reclaim by any task attached to the cpuset.
+ **/
+
+void __cpuset_memory_pressure_bump(void)
+{
+	struct cpuset *cs;
+
+	task_lock(current);
+	cs = current->cpuset;
+	fmeter_markevent(&cs->fmeter);
+	task_unlock(current);
+}
+
+/*
  * proc_cpuset_show()
  *  - Print tasks cpuset path into seq_file.
  *  - Used for /proc/<pid>/cpuset.
--- 2.6.14-rc5-mm1-cpuset-patches.orig/mm/page_alloc.c	2005-11-04 23:36:24.505314568 -0800
+++ 2.6.14-rc5-mm1-cpuset-patches/mm/page_alloc.c	2005-11-04 23:49:17.155492463 -0800
@@ -976,6 +976,7 @@ rebalance:
 	cond_resched();
 
 	/* We now go into synchronous reclaim */
+	cpuset_memory_pressure_bump();
 	p->flags |= PF_MEMALLOC;
 	reclaim_state.reclaimed_slab = 0;
 	p->reclaim_state = &reclaim_state;

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
