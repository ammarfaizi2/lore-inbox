Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267863AbUHESVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267863AbUHESVw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 14:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267862AbUHESVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 14:21:51 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:12009 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S267850AbUHESFM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 14:05:12 -0400
Date: Thu, 5 Aug 2004 20:05:04 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, linux-390@vm.marist.edu
Cc: arjanv@redhat.com, tim.bird@am.sony.com, mulix@mulix.org, alan@redhat.com,
       crisw@osdl.org, jan.glauber@de.ibm.com
Subject: [PATCH] cputime (4/6): introduce cputime.
Message-ID: <20040805180504.GE9240@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] cputime (4/6): introduce cputime.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

This patch introduces the concept of (virtual) cputime. Each architecture
can define its method to measure cputime. The main idea is to define a
cputime_t type and a set of operations on it (see asm-generic/cputime.h).
Then use the type for utime, stime, cutime, cstime, it_virt_value,
it_virt_incr, it_prof_value and it_prof_incr and use the cputime operations
for each access to these variables. The default implementation is jiffies
based and the effect of this patch for architectures which use the default
implementation should be neglectible.

There is a second type cputime64_t which is necessary for the kernel_stat
cpu statistics. The default cputime_t is 32 bit and based on HZ, this will
overflow after 49.7 days. This is not enough for kernel_stat (ihmo not
enough for a processes too), so it is necessary to have a 64 bit type.

The third thing that gets introduced by this patch is an additional field
for the /proc/stat interface: cpu steal time. An architecture can account
cpu steal time by calls to the account_stealtime function. The cpu
which backs a virtual processor doesn't spent all of its time for the
virtual cpu. To get meaningful cpu usage numbers this involuntary wait
time needs to be accounted and exported to user space.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/parisc/kernel/binfmt_elf32.c  |    6 -
 arch/ppc64/kernel/binfmt_elf32.c   |    6 -
 arch/s390/kernel/binfmt_elf32.c    |    6 -
 arch/sparc64/kernel/binfmt_elf32.c |    6 -
 fs/binfmt_elf.c                    |    8 -
 fs/proc/array.c                    |    8 -
 fs/proc/proc_misc.c                |   60 ++++++++------
 include/asm-alpha/cputime.h        |    6 +
 include/asm-arm/cputime.h          |    6 +
 include/asm-arm26/cputime.h        |    6 +
 include/asm-cris/cputime.h         |    6 +
 include/asm-generic/cputime.h      |   63 +++++++++++++++
 include/asm-h8300/cputime.h        |    6 +
 include/asm-i386/cputime.h         |    6 +
 include/asm-ia64/cputime.h         |    6 +
 include/asm-m68k/cputime.h         |    6 +
 include/asm-m68knommu/cputime.h    |    6 +
 include/asm-mips/cputime.h         |    6 +
 include/asm-parisc/cputime.h       |    6 +
 include/asm-ppc/cputime.h          |    6 +
 include/asm-ppc64/cputime.h        |    6 +
 include/asm-s390/cputime.h         |    6 +
 include/asm-sh/cputime.h           |    6 +
 include/asm-sparc/cputime.h        |    6 +
 include/asm-sparc64/cputime.h      |    6 +
 include/asm-um/cputime.h           |    6 +
 include/asm-v850/cputime.h         |    6 +
 include/asm-x86_64/cputime.h       |    6 +
 include/linux/kernel_stat.h        |   19 ++--
 include/linux/sched.h              |   10 +-
 kernel/compat.c                    |    8 -
 kernel/cpu.c                       |    4 
 kernel/exit.c                      |   10 +-
 kernel/fork.c                      |    9 +-
 kernel/itimer.c                    |   55 +++++++------
 kernel/sched.c                     |  152 +++++++++++++++++++++++++++++++------
 kernel/signal.c                    |    8 -
 kernel/sys.c                       |   22 ++---
 kernel/timer.c                     |   63 +--------------
 mm/oom_kill.c                      |    3 
 40 files changed, 459 insertions(+), 187 deletions(-)

diff -urN linux-2.6.8-rc3/arch/parisc/kernel/binfmt_elf32.c linux-2.6.8-s390/arch/parisc/kernel/binfmt_elf32.c
--- linux-2.6.8-rc3/arch/parisc/kernel/binfmt_elf32.c	Wed Jun 16 07:19:13 2004
+++ linux-2.6.8-s390/arch/parisc/kernel/binfmt_elf32.c	Thu Aug  5 18:40:24 2004
@@ -92,10 +92,12 @@
 	current->thread.map_base = DEFAULT_MAP_BASE32; \
 	current->thread.task_size = DEFAULT_TASK_SIZE32 \
 
-#define jiffies_to_timeval jiffies_to_compat_timeval 
+#undef cputime_to_timeval
+#define cputime_to_timeval cputime_to_compat_timeval 
 static __inline__ void
-jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
+cputime_to_compat_timeval(const cputime_t cputime, struct compat_timeval *value)
 {
+	unsigned long jiffies = cputime_to_jiffies(cputime);
 	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
 	value->tv_sec = jiffies / HZ;
 }
diff -urN linux-2.6.8-rc3/arch/ppc64/kernel/binfmt_elf32.c linux-2.6.8-s390/arch/ppc64/kernel/binfmt_elf32.c
--- linux-2.6.8-rc3/arch/ppc64/kernel/binfmt_elf32.c	Wed Jun 16 07:19:37 2004
+++ linux-2.6.8-s390/arch/ppc64/kernel/binfmt_elf32.c	Thu Aug  5 18:40:24 2004
@@ -60,10 +60,12 @@
 
 #include <linux/time.h>
 
-#define jiffies_to_timeval jiffies_to_compat_timeval
+#undef cputime_to_timeval
+#define cputime_to_timeval cputime_to_compat_timeval
 static __inline__ void
-jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
+cputime_to_compat_timeval(const cputime_t cputime, struct compat_timeval *value)
 {
+	unsigned long jiffies = cputime_to_jiffies(cputime);
 	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
 	value->tv_sec = jiffies / HZ;
 }
diff -urN linux-2.6.8-rc3/arch/s390/kernel/binfmt_elf32.c linux-2.6.8-s390/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6.8-rc3/arch/s390/kernel/binfmt_elf32.c	Wed Jun 16 07:20:03 2004
+++ linux-2.6.8-s390/arch/s390/kernel/binfmt_elf32.c	Thu Aug  5 18:40:24 2004
@@ -173,10 +173,12 @@
 #undef MODULE_DESCRIPTION
 #undef MODULE_AUTHOR
 
-#define jiffies_to_timeval jiffies_to_compat_timeval
+#undef cputime_to_timeval
+#define cputime_to_timeval cputime_to_compat_timeval
 static __inline__ void
-jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
+cputime_to_compat_timeval(const cputime_t cputime, struct compat_timeval *value)
 {
+	unsigned long jiffies = cputime_to_jiffies(cputime);
 	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
 	value->tv_sec = jiffies / HZ;
 }
diff -urN linux-2.6.8-rc3/arch/sparc64/kernel/binfmt_elf32.c linux-2.6.8-s390/arch/sparc64/kernel/binfmt_elf32.c
--- linux-2.6.8-rc3/arch/sparc64/kernel/binfmt_elf32.c	Wed Jun 16 07:19:52 2004
+++ linux-2.6.8-s390/arch/sparc64/kernel/binfmt_elf32.c	Thu Aug  5 18:40:24 2004
@@ -132,10 +132,12 @@
 
 #include <linux/time.h>
 
-#define jiffies_to_timeval jiffies_to_compat_timeval
+#undef cputime_to_timeval
+#define cputime_to_timeval cputime_to_compat_timeval
 static __inline__ void
-jiffies_to_compat_timeval(unsigned long jiffies, struct compat_timeval *value)
+cputime_to_compat_timeval(const cputime_t cputime, struct compat_timeval *value)
 {
+	unsigned long jiffies = cputime_to_jiffies(cputime);
 	value->tv_usec = (jiffies % HZ) * (1000000L / HZ);
 	value->tv_sec = jiffies / HZ;
 }
diff -urN linux-2.6.8-rc3/fs/binfmt_elf.c linux-2.6.8-s390/fs/binfmt_elf.c
--- linux-2.6.8-rc3/fs/binfmt_elf.c	Thu Aug  5 18:39:59 2004
+++ linux-2.6.8-s390/fs/binfmt_elf.c	Thu Aug  5 18:40:24 2004
@@ -1176,10 +1176,10 @@
 	prstatus->pr_ppid = p->parent->pid;
 	prstatus->pr_pgrp = process_group(p);
 	prstatus->pr_sid = p->signal->session;
-	jiffies_to_timeval(p->utime, &prstatus->pr_utime);
-	jiffies_to_timeval(p->stime, &prstatus->pr_stime);
-	jiffies_to_timeval(p->cutime, &prstatus->pr_cutime);
-	jiffies_to_timeval(p->cstime, &prstatus->pr_cstime);
+	cputime_to_timeval(p->utime, &prstatus->pr_utime);
+	cputime_to_timeval(p->stime, &prstatus->pr_stime);
+	cputime_to_timeval(p->cutime, &prstatus->pr_cutime);
+	cputime_to_timeval(p->cstime, &prstatus->pr_cstime);
 }
 
 static void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
diff -urN linux-2.6.8-rc3/fs/proc/array.c linux-2.6.8-s390/fs/proc/array.c
--- linux-2.6.8-rc3/fs/proc/array.c	Thu Aug  5 18:40:24 2004
+++ linux-2.6.8-s390/fs/proc/array.c	Thu Aug  5 18:40:24 2004
@@ -372,10 +372,10 @@
 		task->cmin_flt,
 		task->maj_flt,
 		task->cmaj_flt,
-		jiffies_to_clock_t(task->utime),
-		jiffies_to_clock_t(task->stime),
-		jiffies_to_clock_t(task->cutime),
-		jiffies_to_clock_t(task->cstime),
+		cputime_to_clock_t(task->utime),
+		cputime_to_clock_t(task->stime),
+		cputime_to_clock_t(task->cutime),
+		cputime_to_clock_t(task->cstime),
 		priority,
 		nice,
 		num_threads,
diff -urN linux-2.6.8-rc3/fs/proc/proc_misc.c linux-2.6.8-s390/fs/proc/proc_misc.c
--- linux-2.6.8-rc3/fs/proc/proc_misc.c	Thu Aug  5 18:40:24 2004
+++ linux-2.6.8-s390/fs/proc/proc_misc.c	Thu Aug  5 18:40:24 2004
@@ -135,10 +135,10 @@
 	struct timespec uptime;
 	struct timespec idle;
 	int len;
-	u64 idle_jiffies = init_task.utime + init_task.stime;
+	cputime_t idletime = cputime_add(init_task.utime, init_task.stime);
 
 	do_posix_clock_monotonic_gettime(&uptime);
-	jiffies_to_timespec(idle_jiffies, &idle);
+	cputime_to_timespec(idletime, &idle);
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
 			(unsigned long) uptime.tv_sec,
 			(uptime.tv_nsec / (NSEC_PER_SEC / 100)),
@@ -355,10 +355,12 @@
 {
 	int i;
 	extern unsigned long total_forks;
+	cputime64_t user, nice, system, idle, iowait, irq, softirq, steal;
+	u64 sum = 0;
 	unsigned long jif;
-	u64	sum = 0, user = 0, nice = 0, system = 0,
-		idle = 0, iowait = 0, irq = 0, softirq = 0;
 
+	user = nice = system = idle = iowait =
+		irq = softirq = steal = cputime64_zero;
 	jif = - wall_to_monotonic.tv_sec;
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
@@ -366,25 +368,27 @@
 	for_each_cpu(i) {
 		int j;
 
-		user += kstat_cpu(i).cpustat.user;
-		nice += kstat_cpu(i).cpustat.nice;
-		system += kstat_cpu(i).cpustat.system;
-		idle += kstat_cpu(i).cpustat.idle;
-		iowait += kstat_cpu(i).cpustat.iowait;
-		irq += kstat_cpu(i).cpustat.irq;
-		softirq += kstat_cpu(i).cpustat.softirq;
+		user = cputime64_add(user, kstat_cpu(i).cpustat.user);
+		nice = cputime64_add(nice, kstat_cpu(i).cpustat.nice);
+		system = cputime64_add(system, kstat_cpu(i).cpustat.system);
+		idle = cputime64_add(idle, kstat_cpu(i).cpustat.idle);
+		iowait = cputime64_add(iowait, kstat_cpu(i).cpustat.iowait);
+		irq = cputime64_add(irq, kstat_cpu(i).cpustat.irq);
+		softirq = cputime64_add(softirq, kstat_cpu(i).cpustat.softirq);
+		steal = cputime64_add(steal, kstat_cpu(i).cpustat.steal);
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat_cpu(i).irqs[j];
 	}
 
-	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu\n",
-		(unsigned long long)jiffies_64_to_clock_t(user),
-		(unsigned long long)jiffies_64_to_clock_t(nice),
-		(unsigned long long)jiffies_64_to_clock_t(system),
-		(unsigned long long)jiffies_64_to_clock_t(idle),
-		(unsigned long long)jiffies_64_to_clock_t(iowait),
-		(unsigned long long)jiffies_64_to_clock_t(irq),
-		(unsigned long long)jiffies_64_to_clock_t(softirq));
+	seq_printf(p, "cpu  %llu %llu %llu %llu %llu %llu %llu %llu\n",
+		(unsigned long long)cputime64_to_clock_t(user),
+		(unsigned long long)cputime64_to_clock_t(nice),
+		(unsigned long long)cputime64_to_clock_t(system),
+		(unsigned long long)cputime64_to_clock_t(idle),
+		(unsigned long long)cputime64_to_clock_t(iowait),
+		(unsigned long long)cputime64_to_clock_t(irq),
+		(unsigned long long)cputime64_to_clock_t(softirq),
+		(unsigned long long)cputime64_to_clock_t(steal));
 	for_each_online_cpu(i) {
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
@@ -395,15 +399,17 @@
 		iowait = kstat_cpu(i).cpustat.iowait;
 		irq = kstat_cpu(i).cpustat.irq;
 		softirq = kstat_cpu(i).cpustat.softirq;
-		seq_printf(p, "cpu%d %llu %llu %llu %llu %llu %llu %llu\n",
+		steal = kstat_cpu(i).cpustat.steal;
+		seq_printf(p, "cpu%d %llu %llu %llu %llu %llu %llu %llu %llu\n",
 			i,
-			(unsigned long long)jiffies_64_to_clock_t(user),
-			(unsigned long long)jiffies_64_to_clock_t(nice),
-			(unsigned long long)jiffies_64_to_clock_t(system),
-			(unsigned long long)jiffies_64_to_clock_t(idle),
-			(unsigned long long)jiffies_64_to_clock_t(iowait),
-			(unsigned long long)jiffies_64_to_clock_t(irq),
-			(unsigned long long)jiffies_64_to_clock_t(softirq));
+			(unsigned long long)cputime64_to_clock_t(user),
+			(unsigned long long)cputime64_to_clock_t(nice),
+			(unsigned long long)cputime64_to_clock_t(system),
+			(unsigned long long)cputime64_to_clock_t(idle),
+			(unsigned long long)cputime64_to_clock_t(iowait),
+			(unsigned long long)cputime64_to_clock_t(irq),
+			(unsigned long long)cputime64_to_clock_t(softirq),
+			(unsigned long long)cputime64_to_clock_t(steal));
 	}
 	seq_printf(p, "intr %llu", (unsigned long long)sum);
 
diff -urN linux-2.6.8-rc3/include/asm-alpha/cputime.h linux-2.6.8-s390/include/asm-alpha/cputime.h
--- linux-2.6.8-rc3/include/asm-alpha/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-alpha/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __ALPHA_CPUTIME_H
+#define __ALPHA_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __ALPHA_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-arm/cputime.h linux-2.6.8-s390/include/asm-arm/cputime.h
--- linux-2.6.8-rc3/include/asm-arm/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-arm/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __ARM_CPUTIME_H
+#define __ARM_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __ARM_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-arm26/cputime.h linux-2.6.8-s390/include/asm-arm26/cputime.h
--- linux-2.6.8-rc3/include/asm-arm26/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-arm26/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __ARM26_CPUTIME_H
+#define __ARM26_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __ARM26_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-cris/cputime.h linux-2.6.8-s390/include/asm-cris/cputime.h
--- linux-2.6.8-rc3/include/asm-cris/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-cris/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __CRIS_CPUTIME_H
+#define __CRIS_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __CRIS_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-generic/cputime.h linux-2.6.8-s390/include/asm-generic/cputime.h
--- linux-2.6.8-rc3/include/asm-generic/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-generic/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,63 @@
+#ifndef _ASM_GENERIC_CPUTIME_H
+#define _ASM_GENERIC_CPUTIME_H
+
+#include <linux/time.h>
+#include <linux/jiffies.h>
+
+typedef unsigned long cputime_t;
+
+#define cputime_zero (0UL)
+#define cputime_add(__a, __b)		((__a) +  (__b))
+#define cputime_sub(__a, __b)		((__a) -  (__b))
+#define cputime_eq(__a, __b)		((__a) == (__b))
+#define cputime_gt(__a, __b)		((__a) >  (__b))
+#define cputime_ge(__a, __b)		((__a) >= (__b))
+#define cputime_lt(__a, __b)		((__a) <  (__b))
+#define cputime_le(__a, __b)		((__a) <= (__b))
+#define cputime_to_jiffies(__ct)	(__ct)
+#define jiffies_to_cputime(__hz)	(__hz)
+
+typedef u64 cputime64_t;
+
+#define cputime64_zero (0ULL)
+#define cputime64_add(__a, __b)		((__a) + (__b))
+#define cputime64_to_jiffies64(__ct)	(__ct)
+#define cputime_to_cputime64(__ct)	((u64) __ct)
+
+
+/*
+ * Convert cputime to milliseconds and back.
+ */
+#define cputime_to_msecs(__ct)		jiffies_to_msecs(__ct)
+#define msecs_to_cputime(__msecs)	msecs_to_jiffies(__msecs)
+
+/*
+ * Convert cputime to seconds and back.
+ */
+#define cputime_to_secs(__ct)		(jiffies_to_msecs(__ct) / HZ)
+#define secs_to_cputime(__secs)		(msecs_to_jiffies(__secs * HZ))
+
+/*
+ * Convert cputime to timespec and back.
+ */
+#define timespec_to_cputime(__val)	timespec_to_jiffies(__val)
+#define cputime_to_timespec(__ct,__val)	jiffies_to_timespec(__ct,__val)
+
+/*
+ * Convert cputime to timeval and back.
+ */
+#define timeval_to_cputime(__val)	timeval_to_jiffies(__val)
+#define cputime_to_timeval(__ct,__val)	jiffies_to_timeval(__ct,__val)
+
+/*
+ * Convert cputime to clock and back.
+ */
+#define cputime_to_clock_t(__ct)	jiffies_to_clock_t(__ct)
+#define clock_t_to_cputime(__x)		clock_t_to_jiffies(__x)
+
+/*
+ * Convert cputime64 to clock.
+ */
+#define cputime64_to_clock_t(__ct)	jiffies_64_to_clock_t(__ct)
+
+#endif
diff -urN linux-2.6.8-rc3/include/asm-h8300/cputime.h linux-2.6.8-s390/include/asm-h8300/cputime.h
--- linux-2.6.8-rc3/include/asm-h8300/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-h8300/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __H8300_CPUTIME_H
+#define __H8300_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __H8300_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-i386/cputime.h linux-2.6.8-s390/include/asm-i386/cputime.h
--- linux-2.6.8-rc3/include/asm-i386/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-i386/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __I386_CPUTIME_H
+#define __I386_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __I386_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-ia64/cputime.h linux-2.6.8-s390/include/asm-ia64/cputime.h
--- linux-2.6.8-rc3/include/asm-ia64/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-ia64/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __IA64_CPUTIME_H
+#define __IA64_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __IA64_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-m68k/cputime.h linux-2.6.8-s390/include/asm-m68k/cputime.h
--- linux-2.6.8-rc3/include/asm-m68k/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-m68k/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __M68K_CPUTIME_H
+#define __M68K_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __M68K_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-m68knommu/cputime.h linux-2.6.8-s390/include/asm-m68knommu/cputime.h
--- linux-2.6.8-rc3/include/asm-m68knommu/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-m68knommu/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __M68KNOMMU_CPUTIME_H
+#define __M68KNOMMU_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __M68KNOMMU_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-mips/cputime.h linux-2.6.8-s390/include/asm-mips/cputime.h
--- linux-2.6.8-rc3/include/asm-mips/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-mips/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __MIPS_CPUTIME_H
+#define __MIPS_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __MIPS_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-parisc/cputime.h linux-2.6.8-s390/include/asm-parisc/cputime.h
--- linux-2.6.8-rc3/include/asm-parisc/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-parisc/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __PARISC_CPUTIME_H
+#define __PARISC_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __PARISC_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-ppc/cputime.h linux-2.6.8-s390/include/asm-ppc/cputime.h
--- linux-2.6.8-rc3/include/asm-ppc/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-ppc/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __PPC_CPUTIME_H
+#define __PPC_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __PPC_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-ppc64/cputime.h linux-2.6.8-s390/include/asm-ppc64/cputime.h
--- linux-2.6.8-rc3/include/asm-ppc64/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-ppc64/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __PPC_CPUTIME_H
+#define __PPC_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __PPC_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-s390/cputime.h linux-2.6.8-s390/include/asm-s390/cputime.h
--- linux-2.6.8-rc3/include/asm-s390/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-s390/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __S390_CPUTIME_H
+#define __S390_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __S390_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-sh/cputime.h linux-2.6.8-s390/include/asm-sh/cputime.h
--- linux-2.6.8-rc3/include/asm-sh/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-sh/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __SH_CPUTIME_H
+#define __SH_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __SH_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-sparc/cputime.h linux-2.6.8-s390/include/asm-sparc/cputime.h
--- linux-2.6.8-rc3/include/asm-sparc/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-sparc/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __SPARC_CPUTIME_H
+#define __SPARC_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __SPARC_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-sparc64/cputime.h linux-2.6.8-s390/include/asm-sparc64/cputime.h
--- linux-2.6.8-rc3/include/asm-sparc64/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-sparc64/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __SPARC64_CPUTIME_H
+#define __SPARC64_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __SPARC64_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-um/cputime.h linux-2.6.8-s390/include/asm-um/cputime.h
--- linux-2.6.8-rc3/include/asm-um/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-um/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __UM_CPUTIME_H
+#define __UM_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __UM_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-v850/cputime.h linux-2.6.8-s390/include/asm-v850/cputime.h
--- linux-2.6.8-rc3/include/asm-v850/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-v850/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __V850_CPUTIME_H
+#define __V850_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __V850_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/asm-x86_64/cputime.h linux-2.6.8-s390/include/asm-x86_64/cputime.h
--- linux-2.6.8-rc3/include/asm-x86_64/cputime.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6.8-s390/include/asm-x86_64/cputime.h	Thu Aug  5 18:40:24 2004
@@ -0,0 +1,6 @@
+#ifndef __X86_64_CPUTIME_H
+#define __X86_64_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __X86_64_CPUTIME_H */
diff -urN linux-2.6.8-rc3/include/linux/kernel_stat.h linux-2.6.8-s390/include/linux/kernel_stat.h
--- linux-2.6.8-rc3/include/linux/kernel_stat.h	Wed Jun 16 07:20:04 2004
+++ linux-2.6.8-s390/include/linux/kernel_stat.h	Thu Aug  5 18:40:24 2004
@@ -6,6 +6,7 @@
 #include <linux/smp.h>
 #include <linux/threads.h>
 #include <linux/percpu.h>
+#include <asm/cputime.h>
 
 /*
  * 'kernel_stat.h' contains the definitions needed for doing
@@ -14,13 +15,14 @@
  */
 
 struct cpu_usage_stat {
-	u64 user;
-	u64 nice;
-	u64 system;
-	u64 softirq;
-	u64 irq;
-	u64 idle;
-	u64 iowait;
+	cputime64_t user;
+	cputime64_t nice;
+	cputime64_t system;
+	cputime64_t softirq;
+	cputime64_t irq;
+	cputime64_t idle;
+	cputime64_t iowait;
+	cputime64_t steal;
 };
 
 struct kernel_stat {
@@ -50,4 +52,7 @@
 	return sum;
 }
 
+extern void account_cputime(struct task_struct *, int, cputime_t, cputime_t);
+extern void account_stealtime(struct task_struct *, cputime_t);
+
 #endif /* _LINUX_KERNEL_STAT_H */
diff -urN linux-2.6.8-rc3/include/linux/sched.h linux-2.6.8-s390/include/linux/sched.h
--- linux-2.6.8-rc3/include/linux/sched.h	Thu Aug  5 18:40:07 2004
+++ linux-2.6.8-s390/include/linux/sched.h	Thu Aug  5 18:40:24 2004
@@ -19,6 +19,7 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/cputime.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -168,7 +169,7 @@
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
-extern void scheduler_tick(int user_tick, int system);
+extern void scheduler_tick(void);
 extern unsigned long cache_decay_ticks;
 
 /* Attach to any functions which should be ignored in wchan output. */
@@ -452,10 +453,11 @@
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
 	unsigned long rt_priority;
-	unsigned long it_real_value, it_prof_value, it_virt_value;
-	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
+	unsigned long it_real_value, it_real_incr;
+	cputime_t it_virt_value, it_virt_incr;
+	cputime_t it_prof_value, it_prof_incr;
 	struct timer_list real_timer;
-	unsigned long utime, stime, cutime, cstime;
+	cputime_t utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw; /* context switch counts */
 	u64 start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
diff -urN linux-2.6.8-rc3/kernel/compat.c linux-2.6.8-s390/kernel/compat.c
--- linux-2.6.8-rc3/kernel/compat.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/compat.c	Thu Aug  5 18:40:24 2004
@@ -160,10 +160,10 @@
 	 */
 	if (tbuf) {
 		struct compat_tms tmp;
-		tmp.tms_utime = compat_jiffies_to_clock_t(current->utime);
-		tmp.tms_stime = compat_jiffies_to_clock_t(current->stime);
-		tmp.tms_cutime = compat_jiffies_to_clock_t(current->cutime);
-		tmp.tms_cstime = compat_jiffies_to_clock_t(current->cstime);
+		tmp.tms_utime = compat_jiffies_to_clock_t(cputime_to_jiffies(current->utime));
+		tmp.tms_stime = compat_jiffies_to_clock_t(cputime_to_jiffies(current->stime));
+		tmp.tms_cutime = compat_jiffies_to_clock_t(cputime_to_jiffies(current->cutime));
+		tmp.tms_cstime = compat_jiffies_to_clock_t(cputime_to_jiffies(current->cstime));
 		if (copy_to_user(tbuf, &tmp, sizeof(tmp)))
 			return -EFAULT;
 	}
diff -urN linux-2.6.8-rc3/kernel/cpu.c linux-2.6.8-s390/kernel/cpu.c
--- linux-2.6.8-rc3/kernel/cpu.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/cpu.c	Thu Aug  5 18:40:24 2004
@@ -49,7 +49,9 @@
 
 	write_lock_irq(&tasklist_lock);
 	for_each_process(p) {
-		if (task_cpu(p) == cpu && (p->utime != 0 || p->stime != 0))
+		if (task_cpu(p) == cpu &&
+		    (!cputime_eq(p->utime, cputime_zero) ||
+		     !cputime_eq(p->stime, cputime_zero)))
 			printk(KERN_WARNING "Task %s (pid = %d) is on cpu %d\
 				(state = %ld, flags = %lx) \n",
 				 p->comm, p->pid, cpu, p->state, p->flags);
diff -urN linux-2.6.8-rc3/kernel/exit.c linux-2.6.8-s390/kernel/exit.c
--- linux-2.6.8-rc3/kernel/exit.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/exit.c	Thu Aug  5 18:40:24 2004
@@ -90,8 +90,10 @@
 		zap_leader = (leader->exit_signal == -1);
 	}
 
-	p->parent->cutime += p->utime + p->cutime;
-	p->parent->cstime += p->stime + p->cstime;
+	p->parent->cutime = cputime_add(p->parent->cutime, p->utime);
+	p->parent->cutime = cputime_add(p->parent->cutime, p->cutime);
+	p->parent->cstime = cputime_add(p->parent->cstime, p->stime);
+	p->parent->cstime = cputime_add(p->parent->cstime, p->cstime);
 	p->parent->cmin_flt += p->min_flt + p->cmin_flt;
 	p->parent->cmaj_flt += p->maj_flt + p->cmaj_flt;
 	p->parent->cnvcsw += p->nvcsw + p->cnvcsw;
@@ -762,8 +764,8 @@
 	 * Clear these here so that update_process_times() won't try to deliver
 	 * itimer, profile or rlimit signals to this task while it is in late exit.
 	 */
-	tsk->it_virt_value = 0;
-	tsk->it_prof_value = 0;
+	tsk->it_virt_value = cputime_zero;
+	tsk->it_prof_value = cputime_zero;
 	tsk->rlim[RLIMIT_CPU].rlim_cur = RLIM_INFINITY;
 
 	/*
diff -urN linux-2.6.8-rc3/kernel/fork.c linux-2.6.8-s390/kernel/fork.c
--- linux-2.6.8-rc3/kernel/fork.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/fork.c	Thu Aug  5 18:40:24 2004
@@ -953,13 +953,14 @@
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
 
-	p->it_real_value = p->it_virt_value = p->it_prof_value = 0;
-	p->it_real_incr = p->it_virt_incr = p->it_prof_incr = 0;
+	p->it_real_value = p->it_real_incr = 0;
+	p->it_virt_value = p->it_virt_incr = cputime_zero;
+	p->it_prof_value = p->it_prof_incr = cputime_zero;
 	init_timer(&p->real_timer);
 	p->real_timer.data = (unsigned long) p;
 
-	p->utime = p->stime = 0;
-	p->cutime = p->cstime = 0;
+	p->utime = p->stime = cputime_zero;
+	p->cutime = p->cstime = cputime_zero;
 	p->lock_depth = -1;		/* -1 = no lock */
 	p->start_time = get_jiffies_64();
 	p->security = NULL;
diff -urN linux-2.6.8-rc3/kernel/itimer.c linux-2.6.8-s390/kernel/itimer.c
--- linux-2.6.8-rc3/kernel/itimer.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/itimer.c	Thu Aug  5 18:40:24 2004
@@ -15,11 +15,10 @@
 
 int do_getitimer(int which, struct itimerval *value)
 {
-	register unsigned long val, interval;
+	register unsigned long val;
 
 	switch (which) {
 	case ITIMER_REAL:
-		interval = current->it_real_incr;
 		val = 0;
 		/* 
 		 * FIXME! This needs to be atomic, in case the kernel timer happens!
@@ -31,20 +30,20 @@
 			if ((long) val <= 0)
 				val = 1;
 		}
+		jiffies_to_timeval(val, &value->it_value);
+		jiffies_to_timeval(current->it_real_incr, &value->it_interval);
 		break;
 	case ITIMER_VIRTUAL:
-		val = current->it_virt_value;
-		interval = current->it_virt_incr;
+		cputime_to_timeval(current->it_virt_value, &value->it_value);
+		cputime_to_timeval(current->it_virt_incr, &value->it_interval);
 		break;
 	case ITIMER_PROF:
-		val = current->it_prof_value;
-		interval = current->it_prof_incr;
+		cputime_to_timeval(current->it_prof_value, &value->it_value);
+		cputime_to_timeval(current->it_prof_incr, &value->it_interval);
 		break;
 	default:
 		return(-EINVAL);
 	}
-	jiffies_to_timeval(val, &value->it_value);
-	jiffies_to_timeval(interval, &value->it_interval);
 	return 0;
 }
 
@@ -80,37 +79,41 @@
 
 int do_setitimer(int which, struct itimerval *value, struct itimerval *ovalue)
 {
-	register unsigned long i, j;
+	unsigned long expire;
+	cputime_t cputime;
 	int k;
 
-	i = timeval_to_jiffies(&value->it_interval);
-	j = timeval_to_jiffies(&value->it_value);
 	if (ovalue && (k = do_getitimer(which, ovalue)) < 0)
 		return k;
 	switch (which) {
 		case ITIMER_REAL:
 			del_timer_sync(&current->real_timer);
-			current->it_real_value = j;
-			current->it_real_incr = i;
-			if (!j)
+			expire = timeval_to_jiffies(&value->it_value);
+			current->it_real_value = expire;
+			current->it_real_incr =
+				timeval_to_jiffies(&value->it_interval);
+			if (!expire)
 				break;
-			if (j > (unsigned long) LONG_MAX)
-				j = LONG_MAX;
-			i = j + jiffies;
-			current->real_timer.expires = i;
+			if (expire > (unsigned long) LONG_MAX)
+				expire = LONG_MAX;
+			current->real_timer.expires = jiffies + expire;
 			add_timer(&current->real_timer);
 			break;
 		case ITIMER_VIRTUAL:
-			if (j)
-				j++;
-			current->it_virt_value = j;
-			current->it_virt_incr = i;
+			cputime = timeval_to_cputime(&value->it_value);
+			if (cputime_eq(cputime, cputime_zero))
+				cputime = jiffies_to_cputime(1);
+			current->it_virt_value = cputime;
+			cputime = timeval_to_cputime(&value->it_interval);
+			current->it_virt_incr = cputime;
 			break;
 		case ITIMER_PROF:
-			if (j)
-				j++;
-			current->it_prof_value = j;
-			current->it_prof_incr = i;
+			cputime = timeval_to_cputime(&value->it_value);
+			if (cputime_eq(cputime, cputime_zero))
+				cputime = jiffies_to_cputime(1);
+			current->it_prof_value = cputime;
+			cputime = timeval_to_cputime(&value->it_interval);
+			current->it_prof_incr = cputime;
 			break;
 		default:
 			return -EINVAL;
diff -urN linux-2.6.8-rc3/kernel/sched.c linux-2.6.8-s390/kernel/sched.c
--- linux-2.6.8-rc3/kernel/sched.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/sched.c	Thu Aug  5 18:40:24 2004
@@ -912,7 +912,7 @@
 		 */
 		current->time_slice = 1;
 		preempt_disable();
-		scheduler_tick(0, 0);
+		scheduler_tick();
 		local_irq_enable();
 		preempt_enable();
 	} else
@@ -1972,48 +1972,152 @@
 			((rq)->curr->static_prio > (rq)->best_expired_prio))
 
 /*
+ * Do the virtual cpu time signal calculations.
+ * @p: the process that the cpu time gets accounted to
+ * @cputime: the cpu time spent in user space since the last update
+ */
+static inline void account_it_virt(struct task_struct * p, cputime_t cputime)
+{
+	cputime_t it_virt = p->it_virt_value;
+
+	if (cputime_gt(it_virt, cputime_zero) &&
+	    cputime_gt(cputime, cputime_zero)) {
+		if (cputime_ge(cputime, it_virt)) {
+			it_virt = cputime_add(it_virt, p->it_virt_incr);
+			send_sig(SIGVTALRM, p, 1);
+		}
+		it_virt = cputime_sub(it_virt, cputime);
+		p->it_virt_value = it_virt;
+	}
+}
+
+/*
+ * Do the virtual profiling signal calculations.
+ * @p: the process that the cpu time gets accounted to
+ * @cputime: the cpu time spent in user and kernel space since the last update
+ */
+static inline void account_it_prof(struct task_struct *p, cputime_t cputime)
+{
+	cputime_t it_prof = p->it_prof_value;
+
+	if (cputime_gt(it_prof, cputime_zero) &&
+	    cputime_gt(cputime, cputime_zero)) {
+		if (cputime_ge(cputime, it_prof)) {
+			it_prof = cputime_add(it_prof, p->it_prof_incr);
+			send_sig(SIGPROF, p, 1);
+		}
+		it_prof = cputime_sub(it_prof, cputime);
+		p->it_prof_value = it_prof;
+	}
+}
+
+/*
+ * Check if the process went over its cputime resource limit after
+ * some cpu time got added to utime/stime.
+ * @p: the process that the cpu time gets accounted to
+ * @cputime: the cpu time spent in user and kernel space since the last update
+ */
+static inline void check_rlimit(struct task_struct *p, cputime_t cputime)
+{
+	cputime_t total, tmp;
+		
+	total = cputime_add(p->utime, p->stime);
+	tmp = jiffies_to_cputime(p->rlim[RLIMIT_CPU].rlim_cur);
+	if (unlikely(cputime_gt(total, tmp))) {
+		/* Send SIGXCPU every second. */
+		tmp = cputime_sub(total, cputime);
+		if (cputime_to_secs(tmp) < cputime_to_secs(total))
+			send_sig(SIGXCPU, p, 1);
+		/* and SIGKILL when we go over max.. */
+		tmp = jiffies_to_cputime(p->rlim[RLIMIT_CPU].rlim_max);
+		if (cputime_gt(total, tmp))
+			send_sig(SIGKILL, p, 1);
+	}
+}
+
+/*
+ * Account user & system cpu time to a process.
+ * @p: the process that the cpu time gets accounted to
+ * @hardirq_offset: the offset to subtract from hardirq_count()
+ * @user: the cpu time spent in user space since the last update
+ * @system: the cpu time spent in kernel space since the last update
+ */
+void account_cputime(struct task_struct *p, int hardirq_offset,
+		     cputime_t user, cputime_t system)
+{
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	runqueue_t *rq = this_rq();
+	cputime64_t tmp64;
+	cputime_t tmp;
+
+	p->utime = cputime_add(p->utime, user);
+	p->stime = cputime_add(p->stime, system);
+
+	/* Check for signals (SIGVTALRM, SIGPROF, SIGXCPU & SIGKILL). */
+	tmp = cputime_add(user, system);
+	check_rlimit(p, tmp);
+	account_it_virt(p, user);
+	account_it_prof(p, tmp);
+
+	/* Add user time to cpustat. */
+	tmp64 = cputime_to_cputime64(user);
+	if (TASK_NICE(p) > 0)
+		cpustat->nice = cputime64_add(cpustat->nice, tmp64);
+	else
+		cpustat->user = cputime64_add(cpustat->user, tmp64);
+
+	/* Add system time to cpustat. */
+	tmp64 = cputime_to_cputime64(system);
+	if (hardirq_count() - hardirq_offset)
+		cpustat->irq = cputime64_add(cpustat->irq, tmp64);
+	else if (softirq_count())
+		cpustat->softirq = cputime64_add(cpustat->softirq, tmp64);
+	else if (p != rq->idle)
+		cpustat->system = cputime64_add(cpustat->system, tmp64);
+	else if (atomic_read(&rq->nr_iowait) > 0)
+		cpustat->iowait = cputime64_add(cpustat->iowait, tmp64);
+	else
+		cpustat->idle = cputime64_add(cpustat->idle, tmp64);
+}
+
+/*
+ * Account for involuntary wait time.
+ * @p: the process from which the cpu time has been stolen
+ * @steal: the cpu time spent in involuntary wait
+ */
+void account_stealtime(struct task_struct *p, cputime_t steal)
+{
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	cputime64_t steal64 = cputime_to_cputime64(steal);
+	runqueue_t *rq = this_rq();
+
+	if (p == rq->idle)
+		cpustat->system = cputime64_add(cpustat->system, steal64);
+	else
+		cpustat->steal = cputime64_add(cpustat->steal, steal64);
+}
+
+/*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  *
  * It also gets called by the fork code, when changing the parent's
  * timeslices.
  */
-void scheduler_tick(int user_ticks, int sys_ticks)
+void scheduler_tick(void)
 {
 	int cpu = smp_processor_id();
-	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
 	rq->timestamp_last_tick = sched_clock();
 
-	if (rcu_pending(cpu))
-		rcu_check_callbacks(cpu, user_ticks);
-
-	/* note: this timer irq context must be accounted for as well */
-	if (hardirq_count() - HARDIRQ_OFFSET) {
-		cpustat->irq += sys_ticks;
-		sys_ticks = 0;
-	} else if (softirq_count()) {
-		cpustat->softirq += sys_ticks;
-		sys_ticks = 0;
-	}
-
 	if (p == rq->idle) {
-		if (atomic_read(&rq->nr_iowait) > 0)
-			cpustat->iowait += sys_ticks;
-		else
-			cpustat->idle += sys_ticks;
 		if (wake_priority_sleeper(rq))
 			goto out;
 		rebalance_tick(cpu, rq, IDLE);
 		return;
 	}
-	if (TASK_NICE(p) > 0)
-		cpustat->nice += user_ticks;
-	else
-		cpustat->user += user_ticks;
-	cpustat->system += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
diff -urN linux-2.6.8-rc3/kernel/signal.c linux-2.6.8-s390/kernel/signal.c
--- linux-2.6.8-rc3/kernel/signal.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/kernel/signal.c	Thu Aug  5 18:40:24 2004
@@ -1445,8 +1445,8 @@
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->utime;
-	info.si_stime = tsk->stime;
+	info.si_utime = cputime_to_jiffies(tsk->utime);
+	info.si_stime = cputime_to_jiffies(tsk->stime);
 
 	status = tsk->exit_code & 0x7f;
 	why = SI_KERNEL;	/* shouldn't happen */
@@ -1534,8 +1534,8 @@
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->utime;
-	info.si_stime = tsk->stime;
+	info.si_utime = cputime_to_jiffies(tsk->utime);
+	info.si_stime = cputime_to_jiffies(tsk->stime);
 
 	info.si_status = tsk->exit_code & 0x7f;
 	info.si_code = CLD_STOPPED;
diff -urN linux-2.6.8-rc3/kernel/sys.c linux-2.6.8-s390/kernel/sys.c
--- linux-2.6.8-rc3/kernel/sys.c	Thu Aug  5 18:40:24 2004
+++ linux-2.6.8-s390/kernel/sys.c	Thu Aug  5 18:40:24 2004
@@ -947,10 +947,10 @@
 	 */
 	if (tbuf) {
 		struct tms tmp;
-		tmp.tms_utime = jiffies_to_clock_t(current->utime);
-		tmp.tms_stime = jiffies_to_clock_t(current->stime);
-		tmp.tms_cutime = jiffies_to_clock_t(current->cutime);
-		tmp.tms_cstime = jiffies_to_clock_t(current->cstime);
+		tmp.tms_utime = cputime_to_clock_t(current->utime);
+		tmp.tms_stime = cputime_to_clock_t(current->stime);
+		tmp.tms_cutime = cputime_to_clock_t(current->cutime);
+		tmp.tms_cstime = cputime_to_clock_t(current->cstime);
 		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
 			return -EFAULT;
 	}
@@ -1547,24 +1547,26 @@
 	memset((char *) &r, 0, sizeof(r));
 	switch (who) {
 		case RUSAGE_SELF:
-			jiffies_to_timeval(p->utime, &r.ru_utime);
-			jiffies_to_timeval(p->stime, &r.ru_stime);
+			cputime_to_timeval(p->utime, &r.ru_utime);
+			cputime_to_timeval(p->stime, &r.ru_stime);
 			r.ru_nvcsw = p->nvcsw;
 			r.ru_nivcsw = p->nivcsw;
 			r.ru_minflt = p->min_flt;
 			r.ru_majflt = p->maj_flt;
 			break;
 		case RUSAGE_CHILDREN:
-			jiffies_to_timeval(p->cutime, &r.ru_utime);
-			jiffies_to_timeval(p->cstime, &r.ru_stime);
+			cputime_to_timeval(p->cutime, &r.ru_utime);
+			cputime_to_timeval(p->cstime, &r.ru_stime);
 			r.ru_nvcsw = p->cnvcsw;
 			r.ru_nivcsw = p->cnivcsw;
 			r.ru_minflt = p->cmin_flt;
 			r.ru_majflt = p->cmaj_flt;
 			break;
 		default:
-			jiffies_to_timeval(p->utime + p->cutime, &r.ru_utime);
-			jiffies_to_timeval(p->stime + p->cstime, &r.ru_stime);
+			cputime_to_timeval(cputime_add(p->utime, p->cutime),
+					    &r.ru_utime);
+			cputime_to_timeval(cputime_add(p->stime, p->cstime),
+					    &r.ru_stime);
 			r.ru_nvcsw = p->nvcsw + p->cnvcsw;
 			r.ru_nivcsw = p->nivcsw + p->cnivcsw;
 			r.ru_minflt = p->min_flt + p->cmin_flt;
diff -urN linux-2.6.8-rc3/kernel/timer.c linux-2.6.8-s390/kernel/timer.c
--- linux-2.6.8-rc3/kernel/timer.c	Thu Aug  5 18:40:22 2004
+++ linux-2.6.8-s390/kernel/timer.c	Thu Aug  5 18:40:24 2004
@@ -785,58 +785,6 @@
 	}
 }
 
-static inline void do_process_times(struct task_struct *p,
-	unsigned long user, unsigned long system)
-{
-	unsigned long psecs;
-
-	psecs = (p->utime += user);
-	psecs += (p->stime += system);
-	if (psecs / HZ >= p->rlim[RLIMIT_CPU].rlim_cur) {
-		/* Send SIGXCPU every second.. */
-		if (!(psecs % HZ))
-			send_sig(SIGXCPU, p, 1);
-		/* and SIGKILL when we go over max.. */
-		if (psecs / HZ >= p->rlim[RLIMIT_CPU].rlim_max)
-			send_sig(SIGKILL, p, 1);
-	}
-}
-
-static inline void do_it_virt(struct task_struct * p, unsigned long ticks)
-{
-	unsigned long it_virt = p->it_virt_value;
-
-	if (it_virt) {
-		it_virt -= ticks;
-		if (!it_virt) {
-			it_virt = p->it_virt_incr;
-			send_sig(SIGVTALRM, p, 1);
-		}
-		p->it_virt_value = it_virt;
-	}
-}
-
-static inline void do_it_prof(struct task_struct *p)
-{
-	unsigned long it_prof = p->it_prof_value;
-
-	if (it_prof) {
-		if (--it_prof == 0) {
-			it_prof = p->it_prof_incr;
-			send_sig(SIGPROF, p, 1);
-		}
-		p->it_prof_value = it_prof;
-	}
-}
-
-static void update_one_process(struct task_struct *p, unsigned long user,
-			unsigned long system, int cpu)
-{
-	do_process_times(p, user, system);
-	do_it_virt(p, user);
-	do_it_prof(p);
-}	
-
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
  * process.  user_tick is 1 if the tick is user time, 0 for system.
@@ -844,11 +792,16 @@
 void update_process_times(int user_tick)
 {
 	struct task_struct *p = current;
-	int cpu = smp_processor_id(), system = user_tick ^ 1;
+	int cpu = smp_processor_id();
+	cputime_t user = jiffies_to_cputime(user_tick);
+	cputime_t system = jiffies_to_cputime(user_tick ^ 1);
 
-	update_one_process(p, user_tick, system, cpu);
+	/* Note: this timer irq context must be accounted for as well. */
+	account_cputime(p, HARDIRQ_OFFSET, user, system);
 	run_local_timers();
-	scheduler_tick(user_tick, system);
+	if (rcu_pending(cpu))
+		rcu_check_callbacks(cpu, user_tick);
+	scheduler_tick();
 }
 
 /*
diff -urN linux-2.6.8-rc3/mm/oom_kill.c linux-2.6.8-s390/mm/oom_kill.c
--- linux-2.6.8-rc3/mm/oom_kill.c	Thu Aug  5 18:40:08 2004
+++ linux-2.6.8-s390/mm/oom_kill.c	Thu Aug  5 18:40:24 2004
@@ -60,7 +60,8 @@
 	 * particular reason for this other than that it turned out to work
 	 * very well in practice.
 	 */
-	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
+	cpu_time = (cputime_to_jiffies(p->utime) + cputime_to_jiffies(p->stime))
+		>> (SHIFT_HZ + 3);
 	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
 
 	s = int_sqrt(cpu_time);
