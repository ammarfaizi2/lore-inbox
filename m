Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSJZQpO>; Sat, 26 Oct 2002 12:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbSJZQpN>; Sat, 26 Oct 2002 12:45:13 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:37528 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S261206AbSJZQpJ>; Sat, 26 Oct 2002 12:45:09 -0400
Date: Sat, 26 Oct 2002 18:51:25 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: Dave Jones <davej@suse.de>
Subject: [PATCH] use 64 bit jiffies for exported values
Message-ID: <Pine.LNX.4.33.0210261836120.8846-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have HZ=1000 even on 32bit platforms, we really should
use the 64 bit jiffies value for exported interfaces like uptime, process 
start time etc. Otherwise innocent users might get quite surprised
when ps output goes berzerk after 49.5 days.
Note that the appended patch does not change any of the exported 
interfaces, it just avoids internal overflows.

This patch has been in -dj (modulo the HZ=1000 change) since 2.5.20-dj3.
I just forward ported it from 2.5.39-dj1 to 2.5.44, and renamed
jiffies_64_to_clock_t() to jiffies_64_to_user_HZ().

A version that additionally bumps up kstat.per_cpu_... counters to 64 bit
can be found at
  http://www.physik3.uni-rostock.de/tim/kernel/2.5/jiffies64-27.patch.gz

I believe this counts as a bugfix (it fixes a regression from 2.4), but 
still I wanted to put it out before the feature freeze deadline.

Tim


--- linux-2.5.44/kernel/timer.c	Sat Oct 19 06:01:19 2002
+++ linux-2.5.44-j64/kernel/timer.c	Sat Oct 26 13:21:02 2002
@@ -24,8 +24,10 @@
 #include <linux/percpu.h>
 #include <linux/init.h>
 #include <linux/mm.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * per-CPU timer vector definitions:
@@ -1001,13 +1003,16 @@
 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	u64 uptime;
 	unsigned long mem_total, sav_total;
 	unsigned int mem_unit, bitcount;
 
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	read_lock_irq(&xtime_lock);
-	val.uptime = jiffies / HZ;
+	uptime = jiffies_64;
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;
 
 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);

--- linux-2.5.44/include/linux/jiffies.h	Sat Oct 19 06:01:08 2002
+++ linux-2.5.44-j64/include/linux/jiffies.h	Sat Oct 26 13:00:11 2002
@@ -2,14 +2,34 @@
 #define _LINUX_JIFFIES_H
 
 #include <linux/types.h>
+#include <linux/spinlock.h>
+#include <asm/system.h>
 #include <asm/param.h>			/* for HZ */
 
 /*
  * The 64-bit value is not volatile - you MUST NOT read it
- * without holding read_lock_irq(&xtime_lock)
+ * without holding read_lock_irq(&xtime_lock).
+ * get_jiffies_64() will do this for you as appropriate.
  */
 extern u64 jiffies_64;
 extern unsigned long volatile jiffies;
+
+static inline u64 get_jiffies_64(void)
+{
+#if BITS_PER_LONG < 64
+	extern rwlock_t xtime_lock;
+	unsigned long flags;
+	u64 tmp;
+
+	read_lock_irqsave(&xtime_lock, flags);
+	tmp = jiffies_64;
+	read_unlock_irqrestore(&xtime_lock, flags);
+	return tmp;
+#else
+	return (u64)jiffies;
+#endif
+}                                                                             
+
 
 /*
  *	These inlines deal with timer wrapping correctly. You are 

--- linux-2.5.44/fs/proc/array.c	Sat Oct 19 06:01:59 2002
+++ linux-2.5.44-j64/fs/proc/array.c	Sat Oct 26 13:00:11 2002
@@ -344,7 +344,7 @@
 	ppid = task->pid ? task->real_parent->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d %lu %lu\n",
 		task->pid,
 		task->comm,
@@ -367,7 +367,7 @@
 		nice,
 		0UL /* removed */,
 		jiffies_to_clock_t(task->it_real_value),
-		jiffies_to_clock_t(task->start_time),
+		(unsigned long long) jiffies_64_to_user_HZ(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.5.44/fs/proc/proc_misc.c	Sat Oct 19 06:01:14 2002
+++ linux-2.5.44-j64/fs/proc/proc_misc.c	Sat Oct 26 13:16:34 2002
@@ -39,12 +39,14 @@
 #include <linux/seq_file.h>
 #include <linux/times.h>
 #include <linux/profile.h>
+#include <linux/jiffies.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 #include <asm/tlb.h>
+#include <asm/div64.h>
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
@@ -97,34 +99,36 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
-	unsigned long idle;
+	u64 uptime;
+	unsigned long uptime_remainder;
 	int len;
 
-	uptime = jiffies;
-	idle = init_task.utime + init_task.stime;
+	uptime = get_jiffies_64();
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 
-	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
-	   that would overflow about every five days at HZ == 100.
-	   Therefore the identity a = (a / b) * b + a % b is used so that it is
-	   calculated as (((t / HZ) * 100) + ((t % HZ) * 100) / HZ) % 100.
-	   The part in front of the '+' always evaluates as 0 (mod 100). All divisions
-	   in the above formulas are truncating. For HZ being a power of 10, the
-	   calculations simplify to the version in the #else part (if the printf
-	   format is adapted to the same number of digits as zeroes in HZ.
-	 */
 #if HZ!=100
-	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		(((uptime % HZ) * 100) / HZ) % 100,
-		idle / HZ,
-		(((idle % HZ) * 100) / HZ) % 100);
+	{
+		u64 idle = init_task.utime + init_task.stime;
+		unsigned long idle_remainder;
+
+		idle_remainder = (unsigned long) do_div(idle, HZ);
+		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime,
+			(uptime_remainder * 100) / HZ,
+			(unsigned long) idle,
+			(idle_remainder * 100) / HZ);
+	}
 #else
-	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		uptime % HZ,
-		idle / HZ,
-		idle % HZ);
+	{
+		unsigned long idle = init_task.times.tms_utime
+		                     + init_task.times.tms_stime;
+
+		len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
+			(unsigned long) uptime,
+			uptime_remainder,
+			idle / HZ,
+			idle % HZ);
+	}
 #endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
@@ -320,6 +324,8 @@
 };
 #endif
 
+extern rwlock_t xtime_lock;
+
 extern struct seq_operations slabinfo_op;
 extern ssize_t slabinfo_write(struct file *, const char *, size_t, loff_t *);
 static int slabinfo_open(struct inode *inode, struct file *file)
@@ -339,8 +345,9 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
+	u64 jif = get_jiffies_64();
+	unsigned int sum = 0;
+	unsigned long user = 0, nice = 0, system = 0, idle = 0, iowait = 0;
 	int major, disk;
 
 	for (i = 0 ; i < NR_CPUS; i++) {
@@ -358,7 +365,7 @@
 #endif
 	}
 
-	len = sprintf(page, "cpu  %u %u %u %u %u\n",
+	len = sprintf(page, "cpu  %lu %lu %lu %lu %lu\n",
 		jiffies_to_clock_t(user),
 		jiffies_to_clock_t(nice),
 		jiffies_to_clock_t(system),
@@ -366,7 +373,7 @@
 		jiffies_to_clock_t(iowait));
 	for (i = 0 ; i < NR_CPUS; i++){
 		if (!cpu_online(i)) continue;
-		len += sprintf(page + len, "cpu%d %u %u %u %u %u\n",
+		len += sprintf(page + len, "cpu%d %lu %lu %lu %lu %lu\n",
 			i,
 			jiffies_to_clock_t(kstat.per_cpu_user[i]),
 			jiffies_to_clock_t(kstat.per_cpu_nice[i]),
@@ -401,12 +408,13 @@
 		}
 	}
 
+	do_div(jif, HZ);
 	len += sprintf(page + len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
 		"processes %lu\n",
 		nr_context_switches(),
-		xtime.tv_sec - jif / HZ,
+		xtime.tv_sec - (unsigned long) jif,
 		total_forks);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);

--- linux-2.5.44/include/linux/kernel_stat.h	Sat Oct 19 06:01:50 2002
+++ linux-2.5.44-j64/include/linux/kernel_stat.h	Sat Oct 26 13:19:09 2002
@@ -16,11 +16,11 @@
 #define DK_MAX_DISK 16
 
 struct kernel_stat {
-	unsigned int per_cpu_user[NR_CPUS],
-	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS],
-	             per_cpu_idle[NR_CPUS],
-	             per_cpu_iowait[NR_CPUS];
+	unsigned long per_cpu_user[NR_CPUS],
+	              per_cpu_nice[NR_CPUS],
+	              per_cpu_system[NR_CPUS],
+	              per_cpu_idle[NR_CPUS],
+	              per_cpu_iowait[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];

--- linux-2.5.44/include/linux/sched.h	Sat Oct 19 06:01:11 2002
+++ linux-2.5.44-j64/include/linux/sched.h	Sat Oct 26 13:00:11 2002
@@ -334,7 +334,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	unsigned long utime, stime, cutime, cstime;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;

--- linux-2.5.44/include/linux/times.h	Sat Oct 19 06:01:09 2002
+++ linux-2.5.44-j64/include/linux/times.h	Sat Oct 26 13:00:11 2002
@@ -2,7 +2,16 @@
 #define _LINUX_TIMES_H
 
 #ifdef __KERNEL__
+#include <asm/div64.h>
+#include <asm/types.h>
+
 # define jiffies_to_clock_t(x) ((x) / (HZ / USER_HZ))
+
+static inline u64 jiffies_64_to_user_HZ(u64 x)
+{
+	do_div(x, HZ / USER_HZ);
+	return x;
+}
 #endif
 
 struct tms {

--- linux-2.5.44/kernel/acct.c	Sat Oct 19 06:01:56 2002
+++ linux-2.5.44-j64/kernel/acct.c	Sat Oct 26 13:00:11 2002
@@ -49,7 +49,9 @@
 #include <linux/acct.h>
 #include <linux/file.h>
 #include <linux/tty.h>
+#include <linux/jiffies.h>
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * These constants control the amount of freespace that suspend and
@@ -304,6 +306,7 @@
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
+	u64 elapsed;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -321,9 +324,11 @@
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
-	ac.ac_btime = CT_TO_SECS(current->start_time) +
-		(xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
+	elapsed = get_jiffies_64() - current->start_time;
+	ac.ac_etime = encode_comp_t(elapsed < (unsigned long) -1l ?
+	                       (unsigned long) elapsed : (unsigned long) -1l);
+	do_div(elapsed, HZ);
+	ac.ac_btime = xtime.tv_sec - elapsed;
 	ac.ac_utime = encode_comp_t(current->utime);
 	ac.ac_stime = encode_comp_t(current->stime);
 	ac.ac_uid = current->uid;

--- linux-2.5.44/kernel/fork.c	Sat Oct 19 06:01:11 2002
+++ linux-2.5.44-j64/kernel/fork.c	Sat Oct 26 13:00:11 2002
@@ -26,6 +26,7 @@
 #include <linux/mman.h>
 #include <linux/fs.h>
 #include <linux/security.h>
+#include <linux/jiffies.h>
 #include <linux/futex.h>
 #include <linux/ptrace.h>
 
@@ -766,7 +767,7 @@
 #endif
 	p->array = NULL;
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies_64();
 	p->security = NULL;
 
 	INIT_LIST_HEAD(&p->local_pages);

--- linux-2.5.44/mm/oom_kill.c	Sat Oct 19 06:01:56 2002
+++ linux-2.5.44-j64/mm/oom_kill.c	Sat Oct 26 13:00:11 2002
@@ -19,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/swap.h>
 #include <linux/timex.h>
+#include <linux/jiffies.h>
 
 /* #define DEBUG */
 
@@ -68,11 +69,10 @@
 	/*
 	 * CPU time is in seconds and run time is in minutes. There is no
 	 * particular reason for this other than that it turned out to work
-	 * very well in practice. This is not safe against jiffie wraps
-	 * but we don't care _that_ much...
+	 * very well in practice.
 	 */
 	cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
-	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);
 
 	points /= int_sqrt(cpu_time);
 	points /= int_sqrt(int_sqrt(run_time));

