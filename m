Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261180AbTHaLRR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 07:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbTHaLQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 07:16:51 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:7341 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261180AbTHaLQK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 07:16:10 -0400
Date: Sun, 31 Aug 2003 13:16:04 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 64 bit jiffies for 2.4.23-pre2
Message-ID: <Pine.LNX.4.33.0308311241300.19402-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

this patch makes the jiffies wrap after 497 days transparent to the user.
While it allows uptimes of more than 497 days to be displayed, it's main
use is to keep 'ps aux' output correct after the wrap. Without this patch,
ps output will look very messy then with processes being reported as
having started in the future.

For minimal intrusiveness it does not touch jiffies itself but introduces
a (2.6 compatible) get_jiffies_64() function that keeps a private counter
of the upper 31 bits, updated by a timer. user, nice, system, and idle
times are handled similarely if the /proc filesystem is present.
Process start time is extended to 64 bits.
The patch should collapse to a no-op on 64 bit systems except for
extending the per_cpu_user, per_cpu_nice, and per_cpu_system variables in
struct kernel_stat to 64 bits (needed even there for correct display after
497 days).

The patch has been around for almost two years, discussed extensivly on
lkml, tested with simulated uptime, and recently got its first real life
success report (thanks Willy!).
I think it's the most appropriate solution for 2.4. But you need to decide
whether you take this, whether someone should backport the (intrusive and
architecture-dependent) 2.6 fix, or whether you drop it completly and let
people just upgrade to 2.6.

Tim


P.S.: Sorry for nameing the tree 2.4.23-rc2 by mistake, its of cause based
      on 2.4.23-pre2


--- linux-2.4.23-rc2/include/linux/sched.h	Sat May  3 14:46:48 2003
+++ linux-2.4.23-rc2-j64/include/linux/sched.h	Sat May  3 14:48:52 2003
@@ -362,7 +362,7 @@ struct task_struct {
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	struct tms times;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
@@ -579,6 +579,18 @@ extern void free_uid(struct user_struct
 #include <asm/current.h>

 extern unsigned long volatile jiffies;
+#if BITS_PER_LONG < 48
+#define NEEDS_JIFFIES_64
+	extern u64 get_jiffies_64(void);
+#else
+	/* jiffies is wide enough to not wrap for 8716 years at HZ==1024 */
+	static inline u64 get_jiffies_64(void)
+	{
+		return (u64)jiffies;
+	}
+#endif
+
+
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern struct timeval xtime;

--- linux-2.4.23-rc2/kernel/timer.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.23-rc2-j64/kernel/timer.c	Sat May  3 14:48:52 2003
@@ -66,6 +66,9 @@ unsigned long event;
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);

 unsigned long volatile jiffies;
+#ifdef NEEDS_JIFFIES_64
+static unsigned int volatile jiffies_msb_flips;
+#endif

 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -105,6 +108,8 @@ static struct list_head * run_timer_list

 #define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))

+static inline void init_jiffieswrap_timer(void);
+
 void init_timervecs (void)
 {
 	int i;
@@ -117,6 +122,8 @@ void init_timervecs (void)
 	}
 	for (i = 0; i < TVR_SIZE; i++)
 		INIT_LIST_HEAD(tv1.vec + i);
+
+	init_jiffieswrap_timer();
 }

 static unsigned long timer_jiffies;
@@ -708,6 +715,60 @@ void do_timer(struct pt_regs *regs)
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
+
+
+#ifdef NEEDS_JIFFIES_64
+
+u64 get_jiffies_64(void)
+{
+	unsigned long j;
+	unsigned int  f;
+
+	f = jiffies_msb_flips; /* avoid races */
+	rmb();
+	j = jiffies;
+
+	/* account for not yet detected flips */
+	f += (f ^ (j>>(BITS_PER_LONG-1))) & 1;
+	return ((u64) f << (BITS_PER_LONG-1)) | j;
+}
+
+/*
+ * Use a timer to periodically check for jiffies wraparounds.
+ * Instead of overflows we count flips of the highest bit so
+ * that we can easily check whether the latest flip is already
+ * accounted for.
+ * Not racy as invocations are several days apart in time and
+ * jiffies_flips is not modified elsewhere.
+ */
+
+static struct timer_list jiffieswrap_timer;
+#define CHECK_JIFFIESWRAP_INTERVAL (1ul << (BITS_PER_LONG-2))
+
+static void check_jiffieswrap(unsigned long data)
+{
+	mod_timer(&jiffieswrap_timer, jiffies + CHECK_JIFFIESWRAP_INTERVAL);
+
+	jiffies_msb_flips += 1 & (jiffies_msb_flips
+	                           ^ (jiffies>>(BITS_PER_LONG-1)));
+}
+
+static inline void init_jiffieswrap_timer(void)
+{
+	init_timer(&jiffieswrap_timer);
+	jiffieswrap_timer.expires = jiffies + CHECK_JIFFIESWRAP_INTERVAL;
+	jiffieswrap_timer.function = check_jiffieswrap;
+	add_timer(&jiffieswrap_timer);
+}
+
+#else
+
+static inline void init_jiffieswrap_timer(void)
+{
+}
+
+#endif /* NEEDS_JIFFIES_64 */
+

 #if !defined(__alpha__) && !defined(__ia64__)


--- linux-2.4.23-rc2/kernel/fork.c	Sat May  3 14:46:49 2003
+++ linux-2.4.23-rc2-j64/kernel/fork.c	Sat May  3 14:48:52 2003
@@ -733,7 +733,7 @@ int do_fork(unsigned long clone_flags, u
 	}
 #endif
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies_64();

 	INIT_LIST_HEAD(&p->local_pages);


--- linux-2.4.23-rc2/kernel/info.c	Sat Apr 21 01:15:40 2001
+++ linux-2.4.23-rc2-j64/kernel/info.c	Sat May  3 14:48:52 2003
@@ -12,15 +12,19 @@
 #include <linux/smp_lock.h>

 #include <asm/uaccess.h>
+#include <asm/div64.h>

 asmlinkage long sys_sysinfo(struct sysinfo *info)
 {
 	struct sysinfo val;
+	u64 uptime;

 	memset((char *)&val, 0, sizeof(struct sysinfo));

 	cli();
-	val.uptime = jiffies / HZ;
+	uptime = get_jiffies_64();
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;

 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);

--- linux-2.4.23-rc2/include/linux/kernel_stat.h	Sat May  3 14:46:47 2003
+++ linux-2.4.23-rc2-j64/include/linux/kernel_stat.h	Sat May  3 14:48:52 2003
@@ -16,9 +16,9 @@
 #define DK_MAX_DISK 16

 struct kernel_stat {
-	unsigned int per_cpu_user[NR_CPUS],
-	             per_cpu_nice[NR_CPUS],
-	             per_cpu_system[NR_CPUS];
+	unsigned long per_cpu_user[NR_CPUS],
+	              per_cpu_nice[NR_CPUS],
+	              per_cpu_system[NR_CPUS];
 	unsigned int dk_drive[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_rio[DK_MAX_MAJOR][DK_MAX_DISK];
 	unsigned int dk_drive_wio[DK_MAX_MAJOR][DK_MAX_DISK];

--- linux-2.4.23-rc2/fs/proc/array.c	Sat Aug  3 02:39:45 2002
+++ linux-2.4.23-rc2-j64/fs/proc/array.c	Sat May  3 14:48:52 2003
@@ -346,7 +346,7 @@ int proc_pid_stat(struct task_struct *ta
 	ppid = task->pid ? task->p_opptr->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
 		task->pid,
 		task->comm,
@@ -369,7 +369,7 @@ int proc_pid_stat(struct task_struct *ta
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		task->start_time,
+		(unsigned long long)(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.4.23-rc2/fs/proc/proc_misc.c	Sat May  3 14:46:39 2003
+++ linux-2.4.23-rc2-j64/fs/proc/proc_misc.c	Sat May  3 14:53:05 2003
@@ -41,6 +41,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>

 #define LOAD_INT(x) ((x) >> FSHIFT)
 #define LOAD_FRAC(x) LOAD_INT(((x) & (FIXED_1-1)) * 100)
@@ -87,6 +88,92 @@ void proc_sprintf(char *page, off_t *off
 	*lenp = len;
 }

+#if BITS_PER_LONG < 48
+static unsigned int uidle_msb_flips, sidle_msb_flips;
+static unsigned int per_cpu_user_flips[NR_CPUS],
+	            per_cpu_nice_flips[NR_CPUS],
+	            per_cpu_system_flips[NR_CPUS];
+
+static u64 get_64bits(unsigned long *val, unsigned int *flips)
+{
+	unsigned long v;
+	unsigned int f;
+
+	f = *flips; /* avoid races */
+	rmb();
+	v = *val;
+
+	/* account for not yet detected MSB flips */
+	f += (f ^ (v>>(BITS_PER_LONG-1))) & 1;
+	return ((u64) f << (BITS_PER_LONG-1)) | v;
+}
+
+#define get_uidle_64()     get_64bits(&(init_tasks[0]->times.tms_utime),\
+                                      &uidle_msb_flips)
+#define get_sidle_64()     get_64bits(&(init_tasks[0]->times.tms_stime),\
+                                      &sidle_msb_flips)
+#define get_user_64(cpu)   get_64bits(&(kstat.per_cpu_user[cpu]),\
+                                      &(per_cpu_user_flips[cpu]))
+#define get_nice_64(cpu)   get_64bits(&(kstat.per_cpu_nice[cpu]),\
+                                      &(per_cpu_nice_flips[cpu]))
+#define get_system_64(cpu) get_64bits(&(kstat.per_cpu_system[cpu]),\
+                                      &(per_cpu_system_flips[cpu]))
+
+/*
+ * Use a timer to periodically check for overflows.
+ * Instead of overflows we count flips of the highest bit so
+ * that we can easily check whether the latest flip is already
+ * accounted for.
+ * Not racy as invocations are several days apart in time and
+ * *_flips is not modified elsewhere.
+ */
+
+static struct timer_list check_wraps_timer;
+#define CHECK_WRAPS_INTERVAL (1ul << (BITS_PER_LONG-2))
+
+static inline void check_one(unsigned long val, unsigned int *flips)
+{
+	*flips += 1 & (*flips ^ (val>>(BITS_PER_LONG-1)));
+}
+
+static void check_wraps(unsigned long data)
+{
+	int i;
+
+	mod_timer(&check_wraps_timer, jiffies + CHECK_WRAPS_INTERVAL);
+
+	check_one(init_tasks[0]->times.tms_utime, &uidle_msb_flips);
+	check_one(init_tasks[0]->times.tms_stime, &sidle_msb_flips);
+	for(i=0; i<NR_CPUS; i++) {
+		check_one(kstat.per_cpu_user[i], &(per_cpu_user_flips[i]));
+		check_one(kstat.per_cpu_nice[i], &(per_cpu_nice_flips[i]));
+		check_one(kstat.per_cpu_system[i], &(per_cpu_system_flips[i]));
+	}
+}
+
+static inline void init_check_wraps_timer(void)
+{
+	init_timer(&check_wraps_timer);
+	check_wraps_timer.expires = jiffies + CHECK_WRAPS_INTERVAL;
+	check_wraps_timer.function = check_wraps;
+	add_timer(&check_wraps_timer);
+}
+
+#else
+ /* Times won't overflow for 8716 years at HZ==1024 */
+
+#define get_uidle_64()     (init_tasks[0]->times.tms_utime)
+#define get_sidle_64()     (init_tasks[0]->times.tms_stime)
+#define get_user_64(cpu)   (kstat.per_cpu_user[cpu])
+#define get_nice_64(cpu)   (kstat.per_cpu_nice[cpu])
+#define get_system_64(cpu) (kstat.per_cpu_system[cpu])
+
+static inline void init_check_wraps_timer(void)
+{
+}
+
+#endif /* BITS_PER_LONG < 48 */
+
 static int proc_calc_metrics(char *page, char **start, off_t off,
 				 int count, int *eof, int len)
 {
@@ -118,34 +205,27 @@ static int loadavg_read_proc(char *page,
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
-	unsigned long idle;
+	u64 uptime, idle;
+	unsigned long uptime_remainder, idle_remainder;
 	int len;

-	uptime = jiffies;
-	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
+	uptime = get_jiffies_64();
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
+	idle = get_sidle_64() + get_uidle_64();
+	idle_remainder = (unsigned long) do_div(idle, HZ);

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
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		(((uptime % HZ) * 100) / HZ) % 100,
-		idle / HZ,
-		(((idle % HZ) * 100) / HZ) % 100);
+		(unsigned long) uptime,
+		(uptime_remainder * 100) / HZ,
+		(unsigned long) idle,
+		(idle_remainder * 100) / HZ);
 #else
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		uptime % HZ,
-		idle / HZ,
-		idle % HZ);
+		(unsigned long) uptime,
+		uptime_remainder,
+		(unsigned long) idle,
+		idle_remainder);
 #endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
@@ -306,16 +386,16 @@ static int kstat_read_proc(char *page, c
 {
 	int i, len = 0;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
-	unsigned int sum = 0, user = 0, nice = 0, system = 0;
+	unsigned int sum = 0;
+	u64 jif = get_jiffies_64(), user = 0, nice = 0, system = 0;
 	int major, disk;

 	for (i = 0 ; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i), j;

-		user += kstat.per_cpu_user[cpu];
-		nice += kstat.per_cpu_nice[cpu];
-		system += kstat.per_cpu_system[cpu];
+		user += get_user_64(cpu);
+		nice += get_nice_64(cpu);
+		system += get_system_64(cpu);
 #if !defined(CONFIG_ARCH_S390)
 		for (j = 0 ; j < NR_IRQS ; j++)
 			sum += kstat.irqs[cpu][j];
@@ -323,18 +403,24 @@ static int kstat_read_proc(char *page, c
 	}

 	proc_sprintf(page, &off, &len,
-		      "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
-	for (i = 0 ; i < smp_num_cpus; i++)
+			"cpu  %llu %llu %llu %llu\n",
+			(unsigned long long) user,
+			(unsigned long long) nice,
+			(unsigned long long) system,
+			(unsigned long long) jif * smp_num_cpus
+			                      - user - nice - system);
+	for (i = 0 ; i < smp_num_cpus; i++) {
+		user = get_user_64(cpu_logical_map(i));
+		nice = get_nice_64(cpu_logical_map(i));
+		system = get_system_64(cpu_logical_map(i));
 		proc_sprintf(page, &off, &len,
-			"cpu%d %u %u %u %lu\n",
+			"cpu%d %llu %llu %llu %llu\n",
 			i,
-			kstat.per_cpu_user[cpu_logical_map(i)],
-			kstat.per_cpu_nice[cpu_logical_map(i)],
-			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+			(unsigned long long) user,
+			(unsigned long long) nice,
+			(unsigned long long) system,
+			(unsigned long long) jif - user - nice - system);
+	}
 	proc_sprintf(page, &off, &len,
 		"page %u %u\n"
 		"swap %u %u\n"
@@ -371,12 +457,13 @@ static int kstat_read_proc(char *page, c
 		}
 	}

+	do_div(jif, HZ);
 	proc_sprintf(page, &off, &len,
 		"\nctxt %u\n"
 		"btime %lu\n"
 		"processes %lu\n",
 		kstat.context_swtch,
-		xtime.tv_sec - jif / HZ,
+		xtime.tv_sec - (unsigned long) jif,
 		total_forks);

 	return proc_calc_metrics(page, start, off, count, eof, len);
@@ -645,4 +732,5 @@ void __init proc_misc_init(void)
 			entry->proc_fops = &ppc_htab_operations;
 	}
 #endif
+	init_check_wraps_timer();
 }

--- linux-2.4.23-rc2/mm/oom_kill.c	Fri Nov 29 00:53:15 2002
+++ linux-2.4.23-rc2-j64/mm/oom_kill.c	Sat May  3 14:48:52 2003
@@ -73,11 +73,10 @@ static int badness(struct task_struct *p
 	/*
 	 * CPU time is in seconds and run time is in minutes. There is no
 	 * particular reason for this other than that it turned out to work
-	 * very well in practice. This is not safe against jiffie wraps
-	 * but we don't care _that_ much...
+	 * very well in practice.
 	 */
 	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
-	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+	run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);

 	points /= int_sqrt(cpu_time);
 	points /= int_sqrt(int_sqrt(run_time));

--- linux-2.4.23-rc2/kernel/acct.c	Sat Aug  3 02:39:46 2002
+++ linux-2.4.23-rc2-j64/kernel/acct.c	Sat May  3 14:48:52 2003
@@ -56,6 +56,7 @@
 #include <linux/tty.h>

 #include <asm/uaccess.h>
+#include <asm/div64.h>

 /*
  * These constants control the amount of freespace that suspend and
@@ -227,20 +228,24 @@ void acct_auto_close(kdev_t dev)
  *  This routine has been adopted from the encode_comp_t() function in
  *  the kern_acct.c file of the FreeBSD operating system. The encoding
  *  is a 13-bit fraction with a 3-bit (base 8) exponent.
+ *
+ *  Bumped up to encode 64 bit values. Unfortunately the result may
+ *  overflow now.
  */

 #define	MANTSIZE	13			/* 13 bit mantissa. */
-#define	EXPSIZE		3			/* Base 8 (3 bit) exponent. */
+#define	EXPSIZE		3			/* 3 bit exponent. */
+#define	EXPBASE		3			/* Base 8 (3 bit) exponent. */
 #define	MAXFRACT	((1 << MANTSIZE) - 1)	/* Maximum fractional value. */

-static comp_t encode_comp_t(unsigned long value)
+static comp_t encode_comp_t(u64 value)
 {
 	int exp, rnd;

 	exp = rnd = 0;
 	while (value > MAXFRACT) {
-		rnd = value & (1 << (EXPSIZE - 1));	/* Round up? */
-		value >>= EXPSIZE;	/* Base 8 exponent == 3 bit shift. */
+		rnd = value & (1 << (EXPBASE - 1));	/* Round up? */
+		value >>= EXPBASE;	/* Base 8 exponent == 3 bit shift. */
 		exp++;
 	}

@@ -248,16 +253,21 @@ static comp_t encode_comp_t(unsigned lon
          * If we need to round up, do it (and handle overflow correctly).
          */
 	if (rnd && (++value > MAXFRACT)) {
-		value >>= EXPSIZE;
+		value >>= EXPBASE;
 		exp++;
 	}

 	/*
          * Clean it up and polish it off.
          */
-	exp <<= MANTSIZE;		/* Shift the exponent into place */
-	exp += value;			/* and add on the mantissa. */
-	return exp;
+	if (exp >= (1 << EXPSIZE)) {
+		/* Overflow. Return largest representable number instead. */
+		return (1ul << (MANTSIZE + EXPSIZE)) - 1;
+	} else {
+		exp <<= MANTSIZE;	/* Shift the exponent into place */
+		exp += value;		/* and add on the mantissa. */
+		return exp;
+	}
 }

 /*
@@ -278,6 +288,7 @@ static void do_acct_process(long exitcod
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
+	u64 elapsed;

 	/*
 	 * First check to see if there is enough free_space to continue
@@ -295,8 +306,10 @@ static void do_acct_process(long exitcod
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';

-	ac.ac_btime = CT_TO_SECS(current->start_time) + (xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
+	elapsed = get_jiffies_64() - current->start_time;
+	ac.ac_etime = encode_comp_t(elapsed);
+	do_div(elapsed, HZ);
+	ac.ac_btime = xtime.tv_sec - elapsed;
 	ac.ac_utime = encode_comp_t(current->times.tms_utime);
 	ac.ac_stime = encode_comp_t(current->times.tms_stime);
 	ac.ac_uid = current->uid;

