Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbUJ0O3d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbUJ0O3d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 10:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262464AbUJ0O3d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 10:29:33 -0400
Received: from mtagate2.de.ibm.com ([195.212.29.151]:6137 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S262460AbUJ0OVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 10:21:53 -0400
Date: Wed, 27 Oct 2004 16:21:40 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch] cputime: introduce cputime.
Message-ID: <20041027142139.GB3405@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,
after the three timer-header-cleanup patches have hit bitkeeper
it's time for the next step: the cputime_t patch. We've been using
this patch and the s/390 exploitation patch for micro-second based
cpu time accounting for some time now and it seems rock solid.
I didn't get a single bug report for it so far. Good for s/390,
but now the question is what does the patch do to all the other
architectures? 2.6.9 plus the cputime_t patch works fine on my
thinkpad. Could you add this to -mm for broader testing please?
The patch is cut against 2.6.10-rc1-mm1.

blue skies,
  Martin

----

[patch] cputime: introduce cputime.

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
 fs/binfmt_elf.c                    |   12 +-
 fs/proc/proc_misc.c                |   60 +++++++------
 include/asm-alpha/cputime.h        |    6 +
 include/asm-arm/cputime.h          |    6 +
 include/asm-arm26/cputime.h        |    6 +
 include/asm-cris/cputime.h         |    6 +
 include/asm-generic/cputime.h      |   64 ++++++++++++++
 include/asm-h8300/cputime.h        |    6 +
 include/asm-i386/cputime.h         |    6 +
 include/asm-ia64/cputime.h         |    6 +
 include/asm-m32r/cputime.h         |    6 +
 include/asm-m68k/cputime.h         |    6 +
 include/asm-m68knommu/cputime.h    |    6 +
 include/asm-mips/cputime.h         |    6 +
 include/asm-parisc/cputime.h       |    6 +
 include/asm-ppc/cputime.h          |    6 +
 include/asm-ppc64/cputime.h        |    6 +
 include/asm-s390/cputime.h         |    6 +
 include/asm-sh/cputime.h           |    6 +
 include/asm-sh64/cputime.h         |    6 +
 include/asm-sparc/cputime.h        |    6 +
 include/asm-sparc64/cputime.h      |    6 +
 include/asm-um/cputime.h           |    6 +
 include/asm-v850/cputime.h         |    6 +
 include/asm-x86_64/cputime.h       |    6 +
 include/linux/kernel_stat.h        |   20 ++--
 include/linux/sched.h              |   12 +-
 kernel/compat.c                    |   14 +--
 kernel/cpu.c                       |    4 
 kernel/exit.c                      |   18 ++--
 kernel/fork.c                      |    9 +-
 kernel/itimer.c                    |   55 ++++++------
 kernel/sched.c                     |  166 +++++++++++++++++++++++++++++++------
 kernel/signal.c                    |   14 +--
 kernel/sys.c                       |   34 +++----
 kernel/timer.c                     |   67 ++------------
 mm/oom_kill.c                      |    3 
 41 files changed, 506 insertions(+), 202 deletions(-)

diff -urN linux-2.6/arch/parisc/kernel/binfmt_elf32.c linux-2.6-cputime/arch/parisc/kernel/binfmt_elf32.c
--- linux-2.6/arch/parisc/kernel/binfmt_elf32.c	2004-10-18 23:53:51.000000000 +0200
+++ linux-2.6-cputime/arch/parisc/kernel/binfmt_elf32.c	2004-10-27 14:10:23.000000000 +0200
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
diff -urN linux-2.6/arch/ppc64/kernel/binfmt_elf32.c linux-2.6-cputime/arch/ppc64/kernel/binfmt_elf32.c
--- linux-2.6/arch/ppc64/kernel/binfmt_elf32.c	2004-10-18 23:54:38.000000000 +0200
+++ linux-2.6-cputime/arch/ppc64/kernel/binfmt_elf32.c	2004-10-27 14:10:23.000000000 +0200
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
diff -urN linux-2.6/arch/s390/kernel/binfmt_elf32.c linux-2.6-cputime/arch/s390/kernel/binfmt_elf32.c
--- linux-2.6/arch/s390/kernel/binfmt_elf32.c	2004-10-18 23:55:07.000000000 +0200
+++ linux-2.6-cputime/arch/s390/kernel/binfmt_elf32.c	2004-10-27 14:10:23.000000000 +0200
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
diff -urN linux-2.6/arch/sparc64/kernel/binfmt_elf32.c linux-2.6-cputime/arch/sparc64/kernel/binfmt_elf32.c
--- linux-2.6/arch/sparc64/kernel/binfmt_elf32.c	2004-10-18 23:55:06.000000000 +0200
+++ linux-2.6-cputime/arch/sparc64/kernel/binfmt_elf32.c	2004-10-27 14:10:23.000000000 +0200
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
diff -urN linux-2.6/fs/binfmt_elf.c linux-2.6-cputime/fs/binfmt_elf.c
--- linux-2.6/fs/binfmt_elf.c	2004-10-27 14:08:24.000000000 +0200
+++ linux-2.6-cputime/fs/binfmt_elf.c	2004-10-27 14:10:23.000000000 +0200
@@ -1192,16 +1192,16 @@
 		 * this and each other thread to finish dying after the
 		 * core dump synchronization phase.
 		 */
-		jiffies_to_timeval(p->utime + p->signal->utime,
+		cputime_to_timeval(cputime_add(p->utime, p->signal->utime),
 				   &prstatus->pr_utime);
-		jiffies_to_timeval(p->stime + p->signal->stime,
+		cputime_to_timeval(cputime_add(p->stime, p->signal->stime),
 				   &prstatus->pr_stime);
 	} else {
-		jiffies_to_timeval(p->utime, &prstatus->pr_utime);
-		jiffies_to_timeval(p->stime, &prstatus->pr_stime);
+		cputime_to_timeval(p->utime, &prstatus->pr_utime);
+		cputime_to_timeval(p->stime, &prstatus->pr_stime);
 	}
-	jiffies_to_timeval(p->signal->cutime, &prstatus->pr_cutime);
-	jiffies_to_timeval(p->signal->cstime, &prstatus->pr_cstime);
+	cputime_to_timeval(p->signal->cutime, &prstatus->pr_cutime);
+	cputime_to_timeval(p->signal->cstime, &prstatus->pr_cstime);
 }
 
 static void fill_psinfo(struct elf_prpsinfo *psinfo, struct task_struct *p,
diff -urN linux-2.6/fs/proc/proc_misc.c linux-2.6-cputime/fs/proc/proc_misc.c
--- linux-2.6/fs/proc/proc_misc.c	2004-10-27 14:09:03.000000000 +0200
+++ linux-2.6-cputime/fs/proc/proc_misc.c	2004-10-27 14:10:23.000000000 +0200
@@ -137,10 +137,10 @@
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
@@ -363,10 +363,12 @@
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
@@ -374,25 +376,27 @@
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
@@ -403,15 +407,17 @@
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
 
diff -urN linux-2.6/include/asm-alpha/cputime.h linux-2.6-cputime/include/asm-alpha/cputime.h
--- linux-2.6/include/asm-alpha/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-alpha/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __ALPHA_CPUTIME_H
+#define __ALPHA_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __ALPHA_CPUTIME_H */
diff -urN linux-2.6/include/asm-arm/cputime.h linux-2.6-cputime/include/asm-arm/cputime.h
--- linux-2.6/include/asm-arm/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-arm/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __ARM_CPUTIME_H
+#define __ARM_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __ARM_CPUTIME_H */
diff -urN linux-2.6/include/asm-arm26/cputime.h linux-2.6-cputime/include/asm-arm26/cputime.h
--- linux-2.6/include/asm-arm26/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-arm26/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __ARM26_CPUTIME_H
+#define __ARM26_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __ARM26_CPUTIME_H */
diff -urN linux-2.6/include/asm-cris/cputime.h linux-2.6-cputime/include/asm-cris/cputime.h
--- linux-2.6/include/asm-cris/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-cris/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __CRIS_CPUTIME_H
+#define __CRIS_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __CRIS_CPUTIME_H */
diff -urN linux-2.6/include/asm-generic/cputime.h linux-2.6-cputime/include/asm-generic/cputime.h
--- linux-2.6/include/asm-generic/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-generic/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,64 @@
+#ifndef _ASM_GENERIC_CPUTIME_H
+#define _ASM_GENERIC_CPUTIME_H
+
+#include <linux/time.h>
+#include <linux/jiffies.h>
+
+typedef unsigned long cputime_t;
+
+#define cputime_zero			(0UL)
+#define cputime_max			((~0UL >> 1) - 1)
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
diff -urN linux-2.6/include/asm-h8300/cputime.h linux-2.6-cputime/include/asm-h8300/cputime.h
--- linux-2.6/include/asm-h8300/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-h8300/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __H8300_CPUTIME_H
+#define __H8300_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __H8300_CPUTIME_H */
diff -urN linux-2.6/include/asm-i386/cputime.h linux-2.6-cputime/include/asm-i386/cputime.h
--- linux-2.6/include/asm-i386/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-i386/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __I386_CPUTIME_H
+#define __I386_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __I386_CPUTIME_H */
diff -urN linux-2.6/include/asm-ia64/cputime.h linux-2.6-cputime/include/asm-ia64/cputime.h
--- linux-2.6/include/asm-ia64/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-ia64/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __IA64_CPUTIME_H
+#define __IA64_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __IA64_CPUTIME_H */
diff -urN linux-2.6/include/asm-m32r/cputime.h linux-2.6-cputime/include/asm-m32r/cputime.h
--- linux-2.6/include/asm-m32r/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-m32r/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __M32R_CPUTIME_H
+#define __M32R_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __M32R_CPUTIME_H */
diff -urN linux-2.6/include/asm-m68k/cputime.h linux-2.6-cputime/include/asm-m68k/cputime.h
--- linux-2.6/include/asm-m68k/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-m68k/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __M68K_CPUTIME_H
+#define __M68K_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __M68K_CPUTIME_H */
diff -urN linux-2.6/include/asm-m68knommu/cputime.h linux-2.6-cputime/include/asm-m68knommu/cputime.h
--- linux-2.6/include/asm-m68knommu/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-m68knommu/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __M68KNOMMU_CPUTIME_H
+#define __M68KNOMMU_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __M68KNOMMU_CPUTIME_H */
diff -urN linux-2.6/include/asm-mips/cputime.h linux-2.6-cputime/include/asm-mips/cputime.h
--- linux-2.6/include/asm-mips/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-mips/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __MIPS_CPUTIME_H
+#define __MIPS_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __MIPS_CPUTIME_H */
diff -urN linux-2.6/include/asm-parisc/cputime.h linux-2.6-cputime/include/asm-parisc/cputime.h
--- linux-2.6/include/asm-parisc/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-parisc/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __PARISC_CPUTIME_H
+#define __PARISC_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __PARISC_CPUTIME_H */
diff -urN linux-2.6/include/asm-ppc/cputime.h linux-2.6-cputime/include/asm-ppc/cputime.h
--- linux-2.6/include/asm-ppc/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-ppc/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __PPC_CPUTIME_H
+#define __PPC_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __PPC_CPUTIME_H */
diff -urN linux-2.6/include/asm-ppc64/cputime.h linux-2.6-cputime/include/asm-ppc64/cputime.h
--- linux-2.6/include/asm-ppc64/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-ppc64/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __PPC_CPUTIME_H
+#define __PPC_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __PPC_CPUTIME_H */
diff -urN linux-2.6/include/asm-s390/cputime.h linux-2.6-cputime/include/asm-s390/cputime.h
--- linux-2.6/include/asm-s390/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-s390/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __S390_CPUTIME_H
+#define __S390_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __S390_CPUTIME_H */
diff -urN linux-2.6/include/asm-sh/cputime.h linux-2.6-cputime/include/asm-sh/cputime.h
--- linux-2.6/include/asm-sh/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-sh/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __SH_CPUTIME_H
+#define __SH_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __SH_CPUTIME_H */
diff -urN linux-2.6/include/asm-sh64/cputime.h linux-2.6-cputime/include/asm-sh64/cputime.h
--- linux-2.6/include/asm-sh64/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-sh64/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __SH64_CPUTIME_H
+#define __SH64_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __SH64_CPUTIME_H */
diff -urN linux-2.6/include/asm-sparc/cputime.h linux-2.6-cputime/include/asm-sparc/cputime.h
--- linux-2.6/include/asm-sparc/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-sparc/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __SPARC_CPUTIME_H
+#define __SPARC_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __SPARC_CPUTIME_H */
diff -urN linux-2.6/include/asm-sparc64/cputime.h linux-2.6-cputime/include/asm-sparc64/cputime.h
--- linux-2.6/include/asm-sparc64/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-sparc64/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __SPARC64_CPUTIME_H
+#define __SPARC64_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __SPARC64_CPUTIME_H */
diff -urN linux-2.6/include/asm-um/cputime.h linux-2.6-cputime/include/asm-um/cputime.h
--- linux-2.6/include/asm-um/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-um/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __UM_CPUTIME_H
+#define __UM_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __UM_CPUTIME_H */
diff -urN linux-2.6/include/asm-v850/cputime.h linux-2.6-cputime/include/asm-v850/cputime.h
--- linux-2.6/include/asm-v850/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-v850/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __V850_CPUTIME_H
+#define __V850_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __V850_CPUTIME_H */
diff -urN linux-2.6/include/asm-x86_64/cputime.h linux-2.6-cputime/include/asm-x86_64/cputime.h
--- linux-2.6/include/asm-x86_64/cputime.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6-cputime/include/asm-x86_64/cputime.h	2004-10-27 14:10:23.000000000 +0200
@@ -0,0 +1,6 @@
+#ifndef __X86_64_CPUTIME_H
+#define __X86_64_CPUTIME_H
+
+#include <asm-generic/cputime.h>
+
+#endif /* __X86_64_CPUTIME_H */
diff -urN linux-2.6/include/linux/kernel_stat.h linux-2.6-cputime/include/linux/kernel_stat.h
--- linux-2.6/include/linux/kernel_stat.h	2004-10-18 23:55:28.000000000 +0200
+++ linux-2.6-cputime/include/linux/kernel_stat.h	2004-10-27 14:10:23.000000000 +0200
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
@@ -50,4 +52,8 @@
 	return sum;
 }
 
+extern void account_user_time(struct task_struct *, cputime_t);
+extern void account_system_time(struct task_struct *, int, cputime_t);
+extern void account_steal_time(struct task_struct *, cputime_t);
+
 #endif /* _LINUX_KERNEL_STAT_H */
diff -urN linux-2.6/include/linux/sched.h linux-2.6-cputime/include/linux/sched.h
--- linux-2.6/include/linux/sched.h	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/include/linux/sched.h	2004-10-27 14:10:23.000000000 +0200
@@ -20,6 +20,7 @@
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/cputime.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -170,7 +171,7 @@
 extern void cpu_init (void);
 extern void trap_init(void);
 extern void update_process_times(int user);
-extern void scheduler_tick(int user_tick, int system);
+extern void scheduler_tick(void);
 extern unsigned long cache_decay_ticks;
 
 /* Attach to any functions which should be ignored in wchan output. */
@@ -310,7 +311,7 @@
 	 * Live threads maintain their own counters and add to these
 	 * in __exit_signal, except for the group leader.
 	 */
-	unsigned long utime, stime, cutime, cstime;
+	cputime_t utime, stime, cutime, cstime;
 	unsigned long nvcsw, nivcsw, cnvcsw, cnivcsw;
 	unsigned long min_flt, maj_flt, cmin_flt, cmaj_flt;
 
@@ -582,10 +583,11 @@
 	int __user *clear_child_tid;		/* CLONE_CHILD_CLEARTID */
 
 	unsigned long rt_priority;
-	unsigned long it_real_value, it_prof_value, it_virt_value;
-	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
+	unsigned long it_real_value, it_real_incr;
+	cputime_t it_virt_value, it_virt_incr;
+	cputime_t it_prof_value, it_prof_incr;
 	struct timer_list real_timer;
-	unsigned long utime, stime;
+	cputime_t utime, stime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	struct timespec start_time;
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
diff -urN linux-2.6/kernel/compat.c linux-2.6-cputime/kernel/compat.c
--- linux-2.6/kernel/compat.c	2004-10-18 23:54:08.000000000 +0200
+++ linux-2.6-cputime/kernel/compat.c	2004-10-27 14:10:23.000000000 +0200
@@ -162,15 +162,15 @@
 		struct compat_tms tmp;
 		struct task_struct *tsk = current;
 		struct task_struct *t;
-		unsigned long utime, stime, cutime, cstime;
+		cputime_t utime, stime, cutime, cstime;
 
 		read_lock(&tasklist_lock);
 		utime = tsk->signal->utime;
 		stime = tsk->signal->stime;
 		t = tsk;
 		do {
-			utime += t->utime;
-			stime += t->stime;
+			utime = cputime_add(utime, t->utime);
+			stime = cputime_add(stime, t->stime);
 			t = next_thread(t);
 		} while (t != tsk);
 
@@ -189,10 +189,10 @@
 		spin_unlock_irq(&tsk->sighand->siglock);
 		read_unlock(&tasklist_lock);
 
-		tmp.tms_utime = compat_jiffies_to_clock_t(utime);
-		tmp.tms_stime = compat_jiffies_to_clock_t(stime);
-		tmp.tms_cutime = compat_jiffies_to_clock_t(cutime);
-		tmp.tms_cstime = compat_jiffies_to_clock_t(cstime);
+		tmp.tms_utime = compat_jiffies_to_clock_t(cputime_to_jiffies(utime));
+		tmp.tms_stime = compat_jiffies_to_clock_t(cputime_to_jiffies(stime));
+		tmp.tms_cutime = compat_jiffies_to_clock_t(cputime_to_jiffies(cutime));
+		tmp.tms_cstime = compat_jiffies_to_clock_t(cputime_to_jiffies(cstime));
 		if (copy_to_user(tbuf, &tmp, sizeof(tmp)))
 			return -EFAULT;
 	}
diff -urN linux-2.6/kernel/cpu.c linux-2.6-cputime/kernel/cpu.c
--- linux-2.6/kernel/cpu.c	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/kernel/cpu.c	2004-10-27 14:10:23.000000000 +0200
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
diff -urN linux-2.6/kernel/exit.c linux-2.6-cputime/kernel/exit.c
--- linux-2.6/kernel/exit.c	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/kernel/exit.c	2004-10-27 14:10:23.000000000 +0200
@@ -763,8 +763,8 @@
 	 * Clear these here so that update_process_times() won't try to deliver
 	 * itimer, profile or rlimit signals to this task while it is in late exit.
 	 */
-	tsk->it_virt_value = 0;
-	tsk->it_prof_value = 0;
+	tsk->it_virt_value = cputime_zero;
+	tsk->it_prof_value = cputime_zero;
 
 	write_unlock_irq(&tasklist_lock);
 
@@ -1052,10 +1052,16 @@
 		 * here reaping other children at the same time.
 		 */
 		spin_lock_irq(&p->parent->sighand->siglock);
-		p->parent->signal->cutime +=
-			p->utime + p->signal->utime + p->signal->cutime;
-		p->parent->signal->cstime +=
-			p->stime + p->signal->stime + p->signal->cstime;
+		p->parent->signal->cutime =
+			cputime_add(p->parent->signal->cutime,
+			cputime_add(p->utime,
+			cputime_add(p->signal->utime,
+				    p->signal->cutime)));
+		p->parent->signal->cstime =
+			cputime_add(p->parent->signal->cstime,
+			cputime_add(p->stime,
+			cputime_add(p->signal->stime,
+				    p->signal->cstime)));
 		p->parent->signal->cmin_flt +=
 			p->min_flt + p->signal->min_flt + p->signal->cmin_flt;
 		p->parent->signal->cmaj_flt +=
diff -urN linux-2.6/kernel/fork.c linux-2.6-cputime/kernel/fork.c
--- linux-2.6/kernel/fork.c	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/kernel/fork.c	2004-10-27 14:10:23.000000000 +0200
@@ -748,7 +748,7 @@
 	sig->leader = 0;	/* session leadership doesn't inherit */
 	sig->tty_old_pgrp = 0;
 
-	sig->utime = sig->stime = sig->cutime = sig->cstime = 0;
+	sig->utime = sig->stime = sig->cutime = sig->cstime = cputime_zero;
 	sig->nvcsw = sig->nivcsw = sig->cnvcsw = sig->cnivcsw = 0;
 	sig->min_flt = sig->maj_flt = sig->cmin_flt = sig->cmaj_flt = 0;
 
@@ -869,12 +869,13 @@
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
+	p->utime = p->stime = cputime_zero;
 	p->lock_depth = -1;		/* -1 = no lock */
 	do_posix_clock_monotonic_gettime(&p->start_time);
 	p->security = NULL;
diff -urN linux-2.6/kernel/itimer.c linux-2.6-cputime/kernel/itimer.c
--- linux-2.6/kernel/itimer.c	2004-10-27 14:08:25.000000000 +0200
+++ linux-2.6-cputime/kernel/itimer.c	2004-10-27 14:10:23.000000000 +0200
@@ -16,11 +16,10 @@
 
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
@@ -32,20 +31,20 @@
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
 
@@ -81,37 +80,41 @@
 
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
diff -urN linux-2.6/kernel/sched.c linux-2.6-cputime/kernel/sched.c
--- linux-2.6/kernel/sched.c	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/kernel/sched.c	2004-10-27 14:10:23.000000000 +0200
@@ -1182,7 +1182,7 @@
 		 */
 		current->time_slice = 1;
 		preempt_disable();
-		scheduler_tick(0, 0);
+		scheduler_tick();
 		local_irq_enable();
 		preempt_enable();
 	} else
@@ -2247,48 +2247,166 @@
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
+	tmp = jiffies_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_cur);
+	if (unlikely(cputime_gt(total, tmp))) {
+		/* Send SIGXCPU every second. */
+		tmp = cputime_sub(total, cputime);
+		if (cputime_to_secs(tmp) < cputime_to_secs(total))
+			send_sig(SIGXCPU, p, 1);
+		/* and SIGKILL when we go over max.. */
+		tmp = jiffies_to_cputime(p->signal->rlim[RLIMIT_CPU].rlim_max);
+		if (cputime_gt(total, tmp))
+			send_sig(SIGKILL, p, 1);
+	}
+}
+
+/*
+ * Account user cpu time to a process.
+ * @p: the process that the cpu time gets accounted to
+ * @hardirq_offset: the offset to subtract from hardirq_count()
+ * @cputime: the cpu time spent in user space since the last update
+ */
+void account_user_time(struct task_struct *p, cputime_t cputime)
+{
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	cputime64_t tmp;
+
+	p->utime = cputime_add(p->utime, cputime);
+
+	/* Check for signals (SIGVTALRM, SIGPROF, SIGXCPU & SIGKILL). */
+	check_rlimit(p, cputime);
+	account_it_virt(p, cputime);
+	account_it_prof(p, cputime);
+
+	/* Add user time to cpustat. */
+	tmp = cputime_to_cputime64(cputime);
+	if (TASK_NICE(p) > 0)
+		cpustat->nice = cputime64_add(cpustat->nice, tmp);
+	else
+		cpustat->user = cputime64_add(cpustat->user, tmp);
+}
+
+/*
+ * Account system cpu time to a process.
+ * @p: the process that the cpu time gets accounted to
+ * @hardirq_offset: the offset to subtract from hardirq_count()
+ * @cputime: the cpu time spent in kernel space since the last update
+ */
+void account_system_time(struct task_struct *p, int hardirq_offset,
+			 cputime_t cputime)
+{
+	struct cpu_usage_stat *cpustat = &kstat_this_cpu.cpustat;
+	runqueue_t *rq = this_rq();
+	cputime64_t tmp;
+
+	p->stime = cputime_add(p->stime, cputime);
+
+	/* Check for signals (SIGPROF, SIGXCPU & SIGKILL). */
+	check_rlimit(p, cputime);
+	account_it_prof(p, cputime);
+
+	/* Add system time to cpustat. */
+	tmp = cputime_to_cputime64(cputime);
+	if (hardirq_count() - hardirq_offset)
+		cpustat->irq = cputime64_add(cpustat->irq, tmp);
+	else if (softirq_count())
+		cpustat->softirq = cputime64_add(cpustat->softirq, tmp);
+	else if (p != rq->idle)
+		cpustat->system = cputime64_add(cpustat->system, tmp);
+	else if (atomic_read(&rq->nr_iowait) > 0)
+		cpustat->iowait = cputime64_add(cpustat->iowait, tmp);
+	else
+		cpustat->idle = cputime64_add(cpustat->idle, tmp);
+}
+
+/*
+ * Account for involuntary wait time.
+ * @p: the process from which the cpu time has been stolen
+ * @steal: the cpu time spent in involuntary wait
+ */
+void account_steal_time(struct task_struct *p, cputime_t steal)
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
 		rebalance_tick(cpu, rq, SCHED_IDLE);
 		return;
 	}
-	if (TASK_NICE(p) > 0)
-		cpustat->nice += user_ticks;
-	else
-		cpustat->user += user_ticks;
-	cpustat->system += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
diff -urN linux-2.6/kernel/signal.c linux-2.6-cputime/kernel/signal.c
--- linux-2.6/kernel/signal.c	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/kernel/signal.c	2004-10-27 14:10:23.000000000 +0200
@@ -380,8 +380,8 @@
 		 * We won't ever get here for the group leader, since it
 		 * will have been the last reference on the signal_struct.
 		 */
-		sig->utime += tsk->utime;
-		sig->stime += tsk->stime;
+		sig->utime = cputime_add(sig->utime, tsk->utime);
+		sig->stime = cputime_add(sig->stime, tsk->stime);
 		sig->min_flt += tsk->min_flt;
 		sig->maj_flt += tsk->maj_flt;
 		sig->nvcsw += tsk->nvcsw;
@@ -1457,8 +1457,10 @@
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->utime + tsk->signal->utime;
-	info.si_stime = tsk->stime + tsk->signal->stime;
+	info.si_utime = cputime_to_jiffies(cputime_add(tsk->utime,
+						       tsk->signal->utime));
+	info.si_stime = cputime_to_jiffies(cputime_add(tsk->stime,
+						       tsk->signal->stime));
 
 	info.si_status = tsk->exit_code & 0x7f;
 	if (tsk->exit_code & 0x80)
@@ -1514,8 +1516,8 @@
 	info.si_uid = tsk->uid;
 
 	/* FIXME: find out whether or not this is supposed to be c*time. */
-	info.si_utime = tsk->utime;
-	info.si_stime = tsk->stime;
+	info.si_utime = cputime_to_jiffies(tsk->utime);
+	info.si_stime = cputime_to_jiffies(tsk->stime);
 
  	info.si_code = why;
  	switch (why) {
diff -urN linux-2.6/kernel/sys.c linux-2.6-cputime/kernel/sys.c
--- linux-2.6/kernel/sys.c	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/kernel/sys.c	2004-10-27 14:10:23.000000000 +0200
@@ -1000,15 +1000,15 @@
 		struct tms tmp;
 		struct task_struct *tsk = current;
 		struct task_struct *t;
-		unsigned long utime, stime, cutime, cstime;
+		cputime_t utime, stime, cutime, cstime;
 
 		read_lock(&tasklist_lock);
 		utime = tsk->signal->utime;
 		stime = tsk->signal->stime;
 		t = tsk;
 		do {
-			utime += t->utime;
-			stime += t->stime;
+			utime = cputime_add(utime, t->utime);
+			stime = cputime_add(stime, t->stime);
 			t = next_thread(t);
 		} while (t != tsk);
 
@@ -1027,10 +1027,10 @@
 		spin_unlock_irq(&tsk->sighand->siglock);
 		read_unlock(&tasklist_lock);
 
-		tmp.tms_utime = jiffies_to_clock_t(utime);
-		tmp.tms_stime = jiffies_to_clock_t(stime);
-		tmp.tms_cutime = jiffies_to_clock_t(cutime);
-		tmp.tms_cstime = jiffies_to_clock_t(cstime);
+		tmp.tms_utime = cputime_to_clock_t(utime);
+		tmp.tms_stime = cputime_to_clock_t(stime);
+		tmp.tms_cutime = cputime_to_clock_t(cutime);
+		tmp.tms_cstime = cputime_to_clock_t(cstime);
 		if (copy_to_user(tbuf, &tmp, sizeof(struct tms)))
 			return -EFAULT;
 	}
@@ -1633,7 +1633,7 @@
 {
 	struct task_struct *t;
 	unsigned long flags;
-	unsigned long utime, stime;
+	cputime_t utime, stime;
 
 	memset((char *) r, 0, sizeof *r);
 
@@ -1650,12 +1650,12 @@
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			jiffies_to_timeval(utime, &r->ru_utime);
-			jiffies_to_timeval(stime, &r->ru_stime);
+			cputime_to_timeval(utime, &r->ru_utime);
+			cputime_to_timeval(stime, &r->ru_stime);
 			break;
 		case RUSAGE_SELF:
 			spin_lock_irqsave(&p->sighand->siglock, flags);
-			utime = stime = 0;
+			utime = stime = cputime_zero;
 			goto sum_group;
 		case RUSAGE_BOTH:
 			spin_lock_irqsave(&p->sighand->siglock, flags);
@@ -1666,16 +1666,16 @@
 			r->ru_minflt = p->signal->cmin_flt;
 			r->ru_majflt = p->signal->cmaj_flt;
 		sum_group:
-			utime += p->signal->utime;
-			stime += p->signal->stime;
+			utime = cputime_add(utime, p->signal->utime);
+			stime = cputime_add(stime, p->signal->stime);
 			r->ru_nvcsw += p->signal->nvcsw;
 			r->ru_nivcsw += p->signal->nivcsw;
 			r->ru_minflt += p->signal->min_flt;
 			r->ru_majflt += p->signal->maj_flt;
 			t = p;
 			do {
-				utime += t->utime;
-				stime += t->stime;
+				utime = cputime_add(utime, t->utime);
+				stime = cputime_add(stime, t->stime);
 				r->ru_nvcsw += t->nvcsw;
 				r->ru_nivcsw += t->nivcsw;
 				r->ru_minflt += t->min_flt;
@@ -1683,8 +1683,8 @@
 				t = next_thread(t);
 			} while (t != p);
 			spin_unlock_irqrestore(&p->sighand->siglock, flags);
-			jiffies_to_timeval(utime, &r->ru_utime);
-			jiffies_to_timeval(stime, &r->ru_stime);
+			cputime_to_timeval(utime, &r->ru_utime);
+			cputime_to_timeval(stime, &r->ru_stime);
 			break;
 		default:
 			BUG();
diff -urN linux-2.6/kernel/timer.c linux-2.6-cputime/kernel/timer.c
--- linux-2.6/kernel/timer.c	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/kernel/timer.c	2004-10-27 14:24:45.000000000 +0200
@@ -805,60 +805,6 @@
 	} while (ticks);
 }
 
-static inline void do_process_times(struct task_struct *p,
-	unsigned long user, unsigned long system)
-{
-	unsigned long psecs;
-
-	psecs = (p->utime += user);
-	psecs += (p->stime += system);
-	if (p->signal && !unlikely(p->state & (EXIT_DEAD|EXIT_ZOMBIE)) &&
-	    psecs / HZ >= p->signal->rlim[RLIMIT_CPU].rlim_cur) {
-		/* Send SIGXCPU every second.. */
-		if (!(psecs % HZ))
-			send_sig(SIGXCPU, p, 1);
-		/* and SIGKILL when we go over max.. */
-		if (psecs / HZ >= p->signal->rlim[RLIMIT_CPU].rlim_max)
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
-	perfctr_sample_thread(&p->thread);
-}	
-
 /*
  * Called from the timer interrupt handler to charge one tick to the current 
  * process.  user_tick is 1 if the tick is user time, 0 for system.
@@ -866,11 +812,18 @@
 void update_process_times(int user_tick)
 {
 	struct task_struct *p = current;
-	int cpu = smp_processor_id(), system = user_tick ^ 1;
+	int cpu = smp_processor_id();
 
-	update_one_process(p, user_tick, system, cpu);
+	/* Note: this timer irq context must be accounted for as well. */
+	if (user_tick)
+		account_user_time(p, jiffies_to_cputime(1));
+	else
+		account_system_time(p, HARDIRQ_OFFSET, jiffies_to_cputime(1));
+	perfctr_sample_thread(&p->thread);
 	run_local_timers();
-	scheduler_tick(user_tick, system);
+	if (rcu_pending(cpu))
+		rcu_check_callbacks(cpu, user_tick);
+	scheduler_tick();
 }
 
 /*
diff -urN linux-2.6/mm/oom_kill.c linux-2.6-cputime/mm/oom_kill.c
--- linux-2.6/mm/oom_kill.c	2004-10-27 14:09:04.000000000 +0200
+++ linux-2.6-cputime/mm/oom_kill.c	2004-10-27 14:10:28.000000000 +0200
@@ -61,7 +61,8 @@
          * of seconds. There is no particular reason for this other than
          * that it turned out to work very well in practice.
 	 */
-	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
+	cpu_time = (cputime_to_jiffies(p->utime) + cputime_to_jiffies(p->stime))
+		>> (SHIFT_HZ + 3);
 
 	if (uptime >= p->start_time.tv_sec)
 		run_time = (uptime - p->start_time.tv_sec) >> 10;
