Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbVJASUT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVJASUT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 14:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVJASUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 14:20:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:19332 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750723AbVJASUS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 14:20:18 -0400
Date: Sat, 1 Oct 2005 11:20:56 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, dipankar@in.ibm.com, vatsa@in.ibm.com, rusty@au1.ibm.com,
       mingo@elte.hu, manfred@colorfullife.com
Subject: [PATCH] RCU torture testing
Message-ID: <20051001182056.GA1613@us.ibm.com>
Reply-To: paulmck@us.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

The attached patch adds CONFIG_RCU_TORTURE_TEST, which enables a /proc-based
intense torture test of the RCU infrastructure.  This is needed due to the
continued changes to RCU infrastructure to accommodate dynamic ticks, CPU
hotplug, and so on.  Most of the code is in a separate file that is compiled
only if the CONFIG variable is set.  Documentation on how to run the test
and interpret the output is also included.

This code has been tested on i386 and ppc64, and an earlier version of the
code has seen extensive testing on a number of architectures as part of the
PREEMPT_RT patchset.

Signed-off-by: <paulmck@us.ibm.com>

---

 Documentation/RCU/proc.txt |  104 ++++++++++++++
 fs/proc/proc_misc.c        |   37 +++++
 include/linux/rcupdate.h   |    6 
 kernel/Kconfig.preempt     |    9 +
 kernel/Makefile            |    1 
 kernel/rcupdate.c          |   10 +
 kernel/rcutorture.c        |  320 +++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 487 insertions(+)

diff -urpNa -X dontdiff linux-2.6.14-rc2/Documentation/RCU/proc.txt linux-2.6.14-rc2-RCUtorture/Documentation/RCU/proc.txt
--- linux-2.6.14-rc2/Documentation/RCU/proc.txt	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-rc2-RCUtorture/Documentation/RCU/proc.txt	2005-09-30 21:59:49.000000000 -0700
@@ -0,0 +1,104 @@
+/proc Filesystem Entries for RCU
+
+
+CONFIG_RCU_TORTURE_TEST
+
+The CONFIG_RCU_TORTURE_TEST config option is available for all RCU
+implementations.  It makes three /proc entries available, namely: rcutw,
+rcutr, and rcuts.
+
+
+/proc/rcutw
+
+Reading this entry starts a new torture test, or ends an earlier one
+if one is already in progress (in other words, there can be only one
+writer at a time).  This sleeps uninterruptibly, so be sure to run
+it in the background.  One could argue that it would be good to have
+multiple writers, but Linux uses RCU heavily enough that you will get
+write-side contention whether you want it or not.  If you want additional
+write-side contention, repeatedly create and destroy several large file
+trees in parallel.  Or use some other RCU-protected update.
+
+
+/proc/rcutr
+
+Reading this entry starts a new torture reader, which runs until sent
+a signal (e.g., control-C).  If testing an RCU implementation with
+preemptible read-side critical sections, make sure to spawn at least
+two /proc/rcutr instances for each CPU.
+
+
+/proc/rcuts
+
+Displays the current state of the torture test:
+
+	ggp = 20961
+	rtc: c04496f4 ver: 8734 tfle: 0 rta: 8734 rtaf: 0 rtf: 8715
+	Reader Pipe:  88024120 63914 0 0 0 0 0 0 0 0 0
+	Reader Batch:  88024097 63937 0 0 0 0 0 0 0 0
+	Free-Block Circulation:  8733 8731 8729 8727 8725 8723 8721 8719 8717 8715 0
+
+The entries are as follows:
+
+o	"ggp": The number of counter flips (or batches) since boot.
+
+o	"rtc": The hexadecimal address of the structure currently visible
+	to readers.
+
+o	"ver": The number of times since boot that the rcutw writer task
+	has changed the structure visible to readers.
+
+o	"tfle": If non-zero, indicates that the "torture freelist"
+	containing structure to be placed into the "rtc" area is empty.
+	This condition is important, since it can fool you into thinking
+	that RCU is working when it is not.  :-/
+
+o	"rta": Number of structures allocated from the torture freelist.
+
+o	"rtaf": Number of allocations from the torture freelist that have
+	failed due to the list being empty.
+
+o	"rtf": Number of frees into the torture freelist.
+
+o	"Reader Pipe": Histogram of "ages" of structures seen by readers.
+	If any entries past the first two are non-zero, RCU is broken.
+	And /proc/rcuts prints "!!!" to make sure you notice.  The age
+	of a newly allocated structure is zero, it becomes one when
+	removed from reader visibility, and is incremented once per
+	grace period subsequently -- and is freed after passing through
+	(RCU_TORTURE_PIPE_LEN-2) grace periods.
+
+	The output displayed above was taken from a correctly working
+	RCU.  If you want to see what it looks like when broken, break
+	it yourself.  ;-)
+
+o	"Reader Batch": Another histogram of "ages" of structures seen
+	by readers, but in terms of counter flips (or batches) rather
+	than in terms of grace periods.  The legal number of non-zero
+	entries is again two.  The reason for this separate view is
+	that it is easier to get the third entry to show up in the
+	"Reader Batch" list than in the "Reader Pipe" list.
+
+o	"Free-Block Circulation": Shows the number of torture structures
+	that have reached a given point in the pipeline.  The first element
+	should closely correspond to the number of structures allocated,
+	the second to the number that have been removed from reader view,
+	and all but the last remaining to the corresponding number of
+	passes through a grace period.  The last entry should be zero,
+	as it is only incremented if a torture structure's counter
+	somehow gets incremented farther than it should.
+
+
+Usage
+
+The following script may be used to torture RCU:
+
+	#!/bin/sh
+
+	cat /proc/rcutw&
+	cat /proc/rcutr& cat /proc/rcutr& cat /proc/rcutr& cat /proc/rcutr&
+	while :
+	do
+		cat /proc/rcuts
+		sleep 10
+	done
diff -urpNa -X dontdiff linux-2.6.14-rc2/fs/proc/proc_misc.c linux-2.6.14-rc2-RCUtorture/fs/proc/proc_misc.c
--- linux-2.6.14-rc2/fs/proc/proc_misc.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.14-rc2-RCUtorture/fs/proc/proc_misc.c	2005-09-30 17:57:30.000000000 -0700
@@ -563,6 +563,38 @@ void create_seq_entry(char *name, mode_t
 		entry->proc_fops = f;
 }
 
+#ifdef CONFIG_RCU_TORTURE_TEST
+int rcu_read_proc_torture_writer(char *page, char **start, off_t off,
+			         int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_torture_writer_data(char *page);
+
+	len = rcu_read_proc_torture_writer_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+int rcu_read_proc_torture_reader(char *page, char **start, off_t off,
+			         int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_torture_reader_data(char *page);
+
+	len = rcu_read_proc_torture_reader_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+
+int rcu_read_proc_torture_stats(char *page, char **start, off_t off,
+			        int count, int *eof, void *data)
+{
+	int len;
+	extern int rcu_read_proc_torture_stats_data(char *page);
+
+	len = rcu_read_proc_torture_stats_data(page);
+	return proc_calc_metrics(page, start, off, count, eof, len);
+}
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
+
 void __init proc_misc_init(void)
 {
 	struct proc_dir_entry *entry;
@@ -585,6 +617,11 @@ void __init proc_misc_init(void)
 		{"cmdline",	cmdline_read_proc},
 		{"locks",	locks_read_proc},
 		{"execdomains",	execdomains_read_proc},
+#ifdef CONFIG_RCU_TORTURE_TEST
+		{"rcutw",	rcu_read_proc_torture_writer},
+		{"rcutr",	rcu_read_proc_torture_reader},
+		{"rcuts",	rcu_read_proc_torture_stats},
+#endif /* #ifdef CONFIG_RCU_TORTURE_TEST */
 		{NULL,}
 	};
 	for (p = simple_ones; p->name; p++)
diff -urpNa -X dontdiff linux-2.6.14-rc2/include/linux/rcupdate.h linux-2.6.14-rc2-RCUtorture/include/linux/rcupdate.h
--- linux-2.6.14-rc2/include/linux/rcupdate.h	2005-09-29 13:54:22.000000000 -0700
+++ linux-2.6.14-rc2-RCUtorture/include/linux/rcupdate.h	2005-09-30 18:10:16.000000000 -0700
@@ -274,6 +274,12 @@ static inline int rcu_pending(int cpu)
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
 extern void rcu_restart_cpu(int cpu);
+extern long rcu_batches_completed(void);
+#ifdef CONFIG_RCU_TORTURE_TEST
+extern void rcu_torture_init(void);
+#else
+static inline void rcu_torture_init(void) { }
+#endif
 
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
diff -urpNa -X dontdiff linux-2.6.14-rc2/kernel/Kconfig.preempt linux-2.6.14-rc2-RCUtorture/kernel/Kconfig.preempt
--- linux-2.6.14-rc2/kernel/Kconfig.preempt	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.14-rc2-RCUtorture/kernel/Kconfig.preempt	2005-09-30 18:02:25.000000000 -0700
@@ -63,3 +63,12 @@ config PREEMPT_BKL
 	  Say Y here if you are building a kernel for a desktop system.
 	  Say N if you are unsure.
 
+config RCU_TORTURE_TEST
+	bool "/proc torture tests for RCU"
+	default n
+	help
+	  This option provides /proc files that run torture tests on the
+	  RCU infrastructure.
+
+	  Say Y here if you want to be able to run RCU torture tests.
+	  Say N if you are unsure.
diff -urpNa -X dontdiff linux-2.6.14-rc2/kernel/Makefile linux-2.6.14-rc2-RCUtorture/kernel/Makefile
--- linux-2.6.14-rc2/kernel/Makefile	2005-09-29 13:54:23.000000000 -0700
+++ linux-2.6.14-rc2-RCUtorture/kernel/Makefile	2005-09-30 17:38:16.000000000 -0700
@@ -32,6 +32,7 @@ obj-$(CONFIG_DETECT_SOFTLOCKUP) += softl
 obj-$(CONFIG_GENERIC_HARDIRQS) += irq/
 obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_SECCOMP) += seccomp.o
+obj-$(CONFIG_RCU_TORTURE_TEST) += rcutorture.o
 
 ifneq ($(CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER),y)
 # According to Alan Modra <alan@linuxcare.com.au>, the -fno-omit-frame-pointer is
diff -urpNa -X dontdiff linux-2.6.14-rc2/kernel/rcupdate.c linux-2.6.14-rc2-RCUtorture/kernel/rcupdate.c
--- linux-2.6.14-rc2/kernel/rcupdate.c	2005-09-29 13:54:23.000000000 -0700
+++ linux-2.6.14-rc2-RCUtorture/kernel/rcupdate.c	2005-09-30 20:50:18.000000000 -0700
@@ -144,6 +144,15 @@ void fastcall call_rcu_bh(struct rcu_hea
 }
 
 /*
+ * Return the number of RCU batches processed thus far.  Useful
+ * for debug and statistics.
+ */
+long rcu_batches_completed(void)
+{
+	return rcu_ctrlblk.completed;
+}
+
+/*
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
  */
@@ -437,6 +446,7 @@ static struct notifier_block __devinitda
  */
 void __init rcu_init(void)
 {
+	rcu_torture_init();
 	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
 			(void *)(long)smp_processor_id());
 	/* Register notifier for non-boot CPUs */
diff -urpNa -X dontdiff linux-2.6.14-rc2/kernel/rcutorture.c linux-2.6.14-rc2-RCUtorture/kernel/rcutorture.c
--- linux-2.6.14-rc2/kernel/rcutorture.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6.14-rc2-RCUtorture/kernel/rcutorture.c	2005-10-01 10:55:19.000000000 -0700
@@ -0,0 +1,320 @@
+/*
+ * Read-Copy Update /proc-based torture test facility
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ * Copyright (C) IBM Corporation, 2005
+ *
+ * Authors: Paul E. McKenney <paulmck@us.ibm.com>
+ *
+ * See also:  Documentation/RCU/proc.txt
+ */
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/spinlock.h>
+#include <linux/smp.h>
+#include <linux/rcupdate.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <asm/atomic.h>
+#include <linux/bitops.h>
+#include <linux/module.h>
+#include <linux/completion.h>
+#include <linux/moduleparam.h>
+#include <linux/percpu.h>
+#include <linux/notifier.h>
+#include <linux/rcupdate.h>
+#include <linux/rcuref.h>
+#include <linux/cpu.h>
+#include <linux/random.h>
+#include <linux/delay.h>
+#include <linux/byteorder/swabb.h>
+
+#define RCU_TORTURE_PIPE_LEN 10
+
+struct rcu_torture {
+	struct rcu_head rtort_rcu;
+	int rtort_pipe_count;
+	struct list_head rtort_free;
+};
+
+static LIST_HEAD(rcu_torture_freelist);
+static struct rcu_torture *rcu_torture_current = NULL;
+static long rcu_torture_current_version = 0;
+static struct rcu_torture rcu_tortures[10 * RCU_TORTURE_PIPE_LEN];
+static DEFINE_SPINLOCK(rcu_torture_lock);
+static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_count) =
+	{ 0 };
+static DEFINE_PER_CPU(long [RCU_TORTURE_PIPE_LEN + 1], rcu_torture_batch) =
+	{ 0 };
+static atomic_t rcu_torture_wcount[RCU_TORTURE_PIPE_LEN + 1] =
+	{ ATOMIC_INIT(0) };
+#define RCU_TORTURE_NOWRITER		0
+#define RCU_TORTURE_WRITERACTIVE	1
+#define RCU_TORTURE_STOPWRITER		2
+static int rcu_torture_wstatus = RCU_TORTURE_NOWRITER;
+atomic_t n_rcu_torture_alloc = ATOMIC_INIT(0);
+atomic_t n_rcu_torture_alloc_fail = ATOMIC_INIT(0);
+atomic_t n_rcu_torture_free = ATOMIC_INIT(0);
+
+/*
+ * Allocate an element from the rcu_tortures pool.
+ */
+struct rcu_torture *
+rcu_torture_alloc(void)
+{
+	struct list_head *p;
+
+	spin_lock(&rcu_torture_lock);
+	if (list_empty(&rcu_torture_freelist)) {
+		atomic_inc(&n_rcu_torture_alloc_fail);
+		spin_unlock(&rcu_torture_lock);
+		return (NULL);
+	}
+	atomic_inc(&n_rcu_torture_alloc);
+	p = rcu_torture_freelist.next;
+	list_del_init(p);
+	spin_unlock(&rcu_torture_lock);
+	return (container_of(p, struct rcu_torture, rtort_free));
+}
+
+/*
+ * Free an element to the rcu_tortures pool.
+ */
+void
+rcu_torture_free(struct rcu_torture *p)
+{
+	atomic_inc(&n_rcu_torture_free);
+	spin_lock(&rcu_torture_lock);
+	list_add_tail(&p->rtort_free, &rcu_torture_freelist);
+	spin_unlock(&rcu_torture_lock);
+}
+
+void
+rcu_torture_cb(struct rcu_head *p)
+{
+	int i;
+	struct rcu_torture *rp = container_of(p, struct rcu_torture, rtort_rcu);
+
+	i = rp->rtort_pipe_count;
+	if (i > RCU_TORTURE_PIPE_LEN) {
+		i = RCU_TORTURE_PIPE_LEN;
+	}
+	atomic_inc(&rcu_torture_wcount[i]);
+	if (++rp->rtort_pipe_count >= RCU_TORTURE_PIPE_LEN) {
+		rcu_torture_free(rp);
+	} else {
+		call_rcu(p, rcu_torture_cb);
+	}
+}
+
+struct rcu_random_state {
+	unsigned long rrs_state;
+	unsigned long rrs_count;
+};
+
+#define RCU_RANDOM_MULT 39916801  /* prime */
+#define RCU_RANDOM_ADD	479001701 /* prime */
+#define RCU_RANDOM_REFRESH 10000
+
+#define DEFINE_RCU_RANDOM(name) struct rcu_random_state name = { 0, 0 }
+
+/*
+ * Crude but fast random-number generator.  Uses a linear congruential
+ * generator, with occasional help from get_random_bytes().
+ */
+static long
+rcu_random(struct rcu_random_state *rrsp)
+{
+	long refresh;
+
+	if (--rrsp->rrs_count < 0) {
+		get_random_bytes(&refresh, sizeof(refresh));
+		rrsp->rrs_state += refresh;
+		rrsp->rrs_count = RCU_RANDOM_REFRESH;
+	}
+	rrsp->rrs_state = rrsp->rrs_state * RCU_RANDOM_MULT + RCU_RANDOM_ADD;
+	return (swahw32(rrsp->rrs_state));
+}
+
+/*
+ * Handles /proc/rcutw.  Unusual in that the user must cat /proc/rcutw
+ * a second time to allow the first read of /proc/rcutw to complete.
+ * Only one writer may be in existence at a time.
+ */
+int
+rcu_read_proc_torture_writer_data(char *page)
+{
+	int i;
+	long oldbatch = rcu_batches_completed();
+	struct rcu_torture *rp;
+	struct rcu_torture *old_rp;
+	static DEFINE_RCU_RANDOM(rand);
+
+	spin_lock(&rcu_torture_lock);
+	if (rcu_torture_wstatus == RCU_TORTURE_WRITERACTIVE) {
+		rcu_torture_wstatus = RCU_TORTURE_STOPWRITER;
+		spin_unlock(&rcu_torture_lock);
+		return sprintf(page, "Terminating prior /proc/rcutw test.\n");
+	} else if (rcu_torture_wstatus == RCU_TORTURE_STOPWRITER) {
+		spin_unlock(&rcu_torture_lock);
+		return sprintf(page, "Wait for prior /proc/rcutw test.\n");
+	} else if (rcu_torture_wstatus != RCU_TORTURE_NOWRITER) {
+		return sprintf(page, "Unexpected rcu_torture_wstatus = %d",
+			       rcu_torture_wstatus);
+	}
+	rcu_torture_wstatus = RCU_TORTURE_WRITERACTIVE;
+	spin_unlock(&rcu_torture_lock);
+	while (rcu_torture_wstatus == RCU_TORTURE_WRITERACTIVE) {
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		schedule_timeout(1);
+		if (rcu_batches_completed() == oldbatch) {
+			continue;
+		}
+		if ((rp = rcu_torture_alloc()) == NULL) {
+			continue;
+		}
+		rp->rtort_pipe_count = 0;
+		udelay(rcu_random(&rand) & 0x3ff);
+		old_rp = rcu_torture_current;
+		rcu_assign_pointer(rcu_torture_current, rp);
+		smp_wmb();
+		if (old_rp != NULL) {
+			i = old_rp->rtort_pipe_count;
+			if (i > RCU_TORTURE_PIPE_LEN) {
+				i = RCU_TORTURE_PIPE_LEN;
+			}
+			atomic_inc(&rcu_torture_wcount[i]);
+			old_rp->rtort_pipe_count++;
+			call_rcu(&old_rp->rtort_rcu, rcu_torture_cb);
+		}
+		rcu_torture_current_version++;
+		oldbatch = rcu_batches_completed();
+	}
+
+	spin_lock(&rcu_torture_lock);
+	rcu_torture_wstatus = RCU_TORTURE_NOWRITER;
+	spin_unlock(&rcu_torture_lock);
+
+	return sprintf(page, "End of /proc/rcutw\n");
+}
+
+/*
+ * Handles /proc/rcutr.  Unusual in that the user must send a signal
+ * to the process to allow the read to complete.  Multiple readers
+ * may run in parallel, but each must be sent a separate signal to
+ * stop.
+ */
+int
+rcu_read_proc_torture_reader_data(char *page)
+{
+	int completed;
+	DEFINE_RCU_RANDOM(rand);
+	struct rcu_torture *p;
+	int pipe_count;
+
+	while (!signal_pending(current)) {
+		rcu_read_lock();
+		completed = rcu_batches_completed();
+		p = rcu_torture_current;
+		if (p == NULL) {
+			rcu_read_unlock();
+			return sprintf(page, "Need to do /proc/rcutw!\n");
+		}
+		udelay(rcu_random(&rand) & 0x7f);
+		preempt_disable();
+		pipe_count = p->rtort_pipe_count;
+		if (pipe_count > RCU_TORTURE_PIPE_LEN) {
+			/* Should not happen, but... */
+			pipe_count = RCU_TORTURE_PIPE_LEN;
+		}
+		++__get_cpu_var(rcu_torture_count)[pipe_count];
+		completed = rcu_batches_completed() - completed;
+		if (completed > RCU_TORTURE_PIPE_LEN) {
+			/* Should not happen, but... */
+			completed = RCU_TORTURE_PIPE_LEN;
+		}
+		++__get_cpu_var(rcu_torture_batch)[completed];
+		preempt_enable();
+		rcu_read_unlock();
+		schedule();
+	}
+	return sprintf(page, "End of /proc/rcutr\n");
+}
+
+/*
+ * Handles /proc/rcuts, printing out counts of how long readers were
+ * allowed to look at RCU-protected data structures.
+ */
+int
+rcu_read_proc_torture_stats_data(char *page)
+{
+	int cnt = 0;
+	int cpu;
+	int i;
+	long pipesummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+	long batchsummary[RCU_TORTURE_PIPE_LEN + 1] = { 0 };
+
+	for_each_cpu(cpu) {
+		for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+			pipesummary[i] += per_cpu(rcu_torture_count, cpu)[i];
+			batchsummary[i] += per_cpu(rcu_torture_batch, cpu)[i];
+		}
+	}
+	for (i = RCU_TORTURE_PIPE_LEN - 1; i >= 0; i--) {
+		if (pipesummary[i] != 0) {
+			break;
+		}
+	}
+	cnt += sprintf(&page[cnt],
+		       "rtc: %p ver: %ld tfle: %d rta: %d rtaf: %d rtf: %d\n",
+		       rcu_torture_current,
+		       rcu_torture_current_version,
+		       list_empty(&rcu_torture_freelist),
+		       atomic_read(&n_rcu_torture_alloc),
+		       atomic_read(&n_rcu_torture_alloc_fail),
+		       atomic_read(&n_rcu_torture_free));
+	if (i > 1) {
+		cnt += sprintf(&page[cnt], "!!! ");
+	}
+	cnt += sprintf(&page[cnt], "Reader Pipe: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+		cnt += sprintf(&page[cnt], " %ld", pipesummary[i]);
+	}
+	cnt += sprintf(&page[cnt], "\nReader Batch: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN; i++) {
+		cnt += sprintf(&page[cnt], " %ld", batchsummary[i]);
+	}
+	cnt += sprintf(&page[cnt], "\nFree-Block Circulation: ");
+	for (i = 0; i < RCU_TORTURE_PIPE_LEN + 1; i++) {
+		cnt += sprintf(&page[cnt], " %d",
+			       atomic_read(&rcu_torture_wcount[i]));
+	}
+	cnt += sprintf(&page[cnt], "\n");
+	return (cnt);
+
+}
+
+void
+rcu_torture_init(void)
+{
+	int i;
+
+	for (i = 0; i < sizeof(rcu_tortures) / sizeof(rcu_tortures[0]); i++) {
+		list_add_tail(&rcu_tortures[i].rtort_free,
+			      &rcu_torture_freelist);
+	}
+}
