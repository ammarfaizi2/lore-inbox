Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310327AbSCADBz>; Thu, 28 Feb 2002 22:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310347AbSCADAE>; Thu, 28 Feb 2002 22:00:04 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:64270 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S310360AbSCACz0>; Thu, 28 Feb 2002 21:55:26 -0500
Date: Fri, 1 Mar 2002 03:55:25 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <linux-kernel@vger.kernel.org>
Subject: [patch] enable uptime display > 497 days on 32 bit (1/2)
Message-ID: <Pine.LNX.4.33.0203010339240.3946-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rediffed to 2.4.19-pre2 and three micro-optimizations:

  move jiffies_hi etc. to same cacheline as jiffies
    (suggested by George Anzinger)
  avoid turning off interrupts (suggested by Andreas Dilger)
  use unlikely() (suggested by Andreas Dilger)

As no other comments turned up, this will go to Marcelo RSN.
(wondered why noone vetoed this as overkill...)

Tim



--- linux-2.4.19-pre2/include/linux/sched.h	Thu Feb 28 23:52:25 2002
+++ linux-2.4.19-pre2-j64/include/linux/sched.h	Fri Mar  1 02:39:09 2002
@@ -361,7 +361,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	struct tms times;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
@@ -573,6 +573,18 @@
 #include <asm/current.h>
 
 extern unsigned long volatile jiffies;
+#if BITS_PER_LONG < 48
+#	define NEEDS_JIFFIES64
+	extern u64 get_jiffies64(void);
+#else
+	/* jiffies is wide enough to not wrap for 8716 years at HZ==1024 */
+	static inline u64 get_jiffies64(void)
+	{
+		return (u64)jiffies;
+	}
+#endif
+
+
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern struct timeval xtime;

--- linux-2.4.19-pre2/kernel/timer.c	Mon Oct  8 19:41:41 2001
+++ linux-2.4.19-pre2-j64/kernel/timer.c	Fri Mar  1 00:45:04 2002
@@ -66,6 +66,10 @@
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
 unsigned long volatile jiffies;
+#ifdef NEEDS_JIFFIES64
+	static unsigned long jiffies_hi, jiffies_last;
+	static spinlock_t jiffies64_lock = SPIN_LOCK_UNLOCKED;
+#endif
 
 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -103,6 +107,8 @@
 
 #define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))
 
+static inline void init_jiffieswrap_timer(void);
+
 void init_timervecs (void)
 {
 	int i;
@@ -115,6 +121,8 @@
 	}
 	for (i = 0; i < TVR_SIZE; i++)
 		INIT_LIST_HEAD(tv1.vec + i);
+
+	init_jiffieswrap_timer();
 }
 
 static unsigned long timer_jiffies;
@@ -683,6 +691,61 @@
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
+
+
+#ifdef NEEDS_JIFFIES64
+
+u64 get_jiffies64(void)
+{
+	unsigned long jiffies_tmp, jiffies_hi_tmp;
+
+	spin_lock(&jiffies64_lock);
+	jiffies_tmp = jiffies;   /* avoid races */
+	jiffies_hi_tmp = jiffies_hi;
+	if (unlikely(jiffies_tmp < jiffies_last))   /* We have a wrap */
+		jiffies_hi++;
+	jiffies_last = jiffies_tmp;
+	spin_unlock(&jiffies64_lock);
+
+	return (jiffies_tmp | ((u64)jiffies_hi_tmp) << BITS_PER_LONG);
+}
+
+/* use a timer to periodically check for jiffies overflow */
+
+static struct timer_list jiffieswrap_timer;
+#define CHECK_JIFFIESWRAP_INTERVAL (1ul << (BITS_PER_LONG-2))
+
+static void check_jiffieswrap(unsigned long data)
+{
+	unsigned long jiffies_tmp;
+	mod_timer(&jiffieswrap_timer, jiffies + CHECK_JIFFIESWRAP_INTERVAL);
+
+	if (spin_trylock(&jiffies64_lock)) {
+		/* If we don't get the lock, we can just give up.
+		   The current holder of the lock will check for wraps */
+		jiffies_tmp = jiffies;   /* avoid races */
+		if (jiffies_tmp < jiffies_last)   /* We have a wrap */
+			jiffies_hi++;
+		jiffies_last = jiffies_tmp;
+		spin_unlock(&jiffies64_lock);
+	}                                                                       }
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
+#endif /* NEEDS_JIFFIES64 */
+
 
 #if !defined(__alpha__) && !defined(__ia64__)
 

--- linux-2.4.19-pre2/kernel/fork.c	Sun Feb 24 19:20:43 2002
+++ linux-2.4.19-pre2-j64/kernel/fork.c	Fri Mar  1 00:05:24 2002
@@ -657,7 +657,7 @@
 	}
 #endif
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies64();
 
 	INIT_LIST_HEAD(&p->local_pages);
 

--- linux-2.4.19-pre2/kernel/info.c	Sat Apr 21 01:15:40 2001
+++ linux-2.4.19-pre2-j64/kernel/info.c	Fri Mar  1 00:05:24 2002
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
+	uptime = get_jiffies64();
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;
 
 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);

--- linux-2.4.19-pre2/fs/proc/array.c	Thu Oct 11 18:00:01 2001
+++ linux-2.4.19-pre2-j64/fs/proc/array.c	Fri Mar  1 00:05:24 2002
@@ -343,7 +343,7 @@
 	ppid = task->pid ? task->p_opptr->pid : 0;
 	read_unlock(&tasklist_lock);
 	res = sprintf(buffer,"%d (%s) %c %d %d %d %d %d %lu %lu \
-%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %lu %lu %ld %lu %lu %lu %lu %lu \
+%lu %lu %lu %lu %lu %ld %ld %ld %ld %ld %ld %llu %lu %ld %lu %lu %lu %lu %lu \
 %lu %lu %lu %lu %lu %lu %lu %lu %d %d\n",
 		task->pid,
 		task->comm,
@@ -366,7 +366,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		task->start_time,
+		(unsigned long long)(task->start_time),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.4.19-pre2/fs/proc/proc_misc.c	Wed Nov 21 06:29:09 2001
+++ linux-2.4.19-pre2-j64/fs/proc/proc_misc.c	Fri Mar  1 01:32:28 2002
@@ -40,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>
 
 
 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -93,37 +94,93 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
+#if BITS_PER_LONG < 48
+static unsigned long idle_hi, idle_last;
+static spinlock_t idle64_lock = SPIN_LOCK_UNLOCKED;
+ 
+u64 get_idle64(void)
+{
+	unsigned long idle, idle_hi_tmp;
+ 
+	spin_lock(&idle64_lock);
+	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
+	if (unlikely(idle < idle_last))   /* We have a wrap */
+		idle_hi++;
+	idle_last = idle;
+	idle_hi_tmp = idle_hi;
+	spin_unlock(&idle64_lock);
+ 
+	return (idle | ((u64)idle_hi_tmp) << BITS_PER_LONG);
+}
+ 
+/* use a timer to periodically check for idle time overflow */
+
+static struct timer_list idlewrap_timer;
+#define CHECK_IDLEWRAP_INTERVAL (1ul << (BITS_PER_LONG-2))
+
+static void check_idlewrap(unsigned long data)
+{
+	unsigned long idle;
+
+	mod_timer(&idlewrap_timer, jiffies + CHECK_IDLEWRAP_INTERVAL);
+	if (spin_trylock(&idle64_lock)) {
+		/* If we don't get the lock, we can just give up.
+		   The current holder of the lock will check for wraps */
+		idle = init_tasks[0]->times.tms_utime
+		       + init_tasks[0]->times.tms_stime;
+		if (idle < idle_last)   /* We have a wrap */
+			idle_hi++;
+		idle_last = idle;
+		spin_unlock(&idle64_lock);
+	}                                                                       }
+
+static inline void init_idlewrap_timer(void)
+{
+	init_timer(&idlewrap_timer);
+	idlewrap_timer.expires = jiffies + CHECK_IDLEWRAP_INTERVAL;
+	idlewrap_timer.function = check_idlewrap;
+	add_timer(&idlewrap_timer);
+}
+
+#else
+ /* Idle time won't overflow for 8716 years at HZ==1024 */
+ 
+static inline u64 get_idle64(void)
+{
+	return (u64)(init_tasks[0]->times.tms_utime
+	             + init_tasks[0]->times.tms_stime);
+}
+ 
+static inline void init_idlewrap_timer(void)
+{
+}
+
+#endif /* BITS_PER_LONG < 48 */
+
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
+	uptime = get_jiffies64();
+	uptime_remainder = (unsigned long) do_div(uptime, HZ);
+	idle = get_idle64();
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
@@ -240,7 +297,7 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	unsigned long jif = jiffies;
+	u64 jif = get_jiffies64();
 	unsigned int sum = 0, user = 0, nice = 0, system = 0;
 	int major, disk;
 
@@ -256,17 +313,19 @@
 #endif
 	}
 
-	len = sprintf(page, "cpu  %u %u %u %lu\n", user, nice, system,
-		      jif * smp_num_cpus - (user + nice + system));
+	len = sprintf(page, "cpu  %u %u %u %llu\n", user, nice, system,
+	              (unsigned long long) jif * smp_num_cpus
+	                                    - user - nice - system);
 	for (i = 0 ; i < smp_num_cpus; i++)
-		len += sprintf(page + len, "cpu%d %u %u %u %lu\n",
+		len += sprintf(page + len, "cpu%d %u %u %u %llu\n",
 			i,
 			kstat.per_cpu_user[cpu_logical_map(i)],
 			kstat.per_cpu_nice[cpu_logical_map(i)],
 			kstat.per_cpu_system[cpu_logical_map(i)],
-			jif - (  kstat.per_cpu_user[cpu_logical_map(i)] \
-				   + kstat.per_cpu_nice[cpu_logical_map(i)] \
-				   + kstat.per_cpu_system[cpu_logical_map(i)]));
+			(unsigned long long) jif
+			    - kstat.per_cpu_user[cpu_logical_map(i)]
+			    - kstat.per_cpu_nice[cpu_logical_map(i)]
+			    - kstat.per_cpu_system[cpu_logical_map(i)]);
 	len += sprintf(page + len,
 		"page %u %u\n"
 		"swap %u %u\n"
@@ -302,12 +361,13 @@
 		}
 	}
 
+	do_div(jif, HZ);
 	len += sprintf(page + len,
 		"\nctxt %u\n"
 		"btime %lu\n"
 		"processes %lu\n",
 		kstat.context_swtch,
-		xtime.tv_sec - jif / HZ,
+		xtime.tv_sec - (unsigned long) jif,
 		total_forks);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
@@ -565,4 +625,6 @@
 				       slabinfo_read_proc, NULL);
 	if (entry)
 		entry->write_proc = slabinfo_write_proc;
+
+	init_idlewrap_timer();
 }

--- linux-2.4.19-pre2/mm/oom_kill.c	Sun Nov  4 02:05:25 2001
+++ linux-2.4.19-pre2-j64/mm/oom_kill.c	Fri Mar  1 00:05:24 2002
@@ -69,11 +69,10 @@
 	/*
 	 * CPU time is in seconds and run time is in minutes. There is no
 	 * particular reason for this other than that it turned out to work
-	 * very well in practice. This is not safe against jiffie wraps
-	 * but we don't care _that_ much...
+	 * very well in practice.
 	 */
 	cpu_time = (p->times.tms_utime + p->times.tms_stime) >> (SHIFT_HZ + 3);
-	run_time = (jiffies - p->start_time) >> (SHIFT_HZ + 10);
+	run_time = (get_jiffies64() - p->start_time) >> (SHIFT_HZ + 10);
 
 	points /= int_sqrt(cpu_time);
 	points /= int_sqrt(int_sqrt(run_time));

--- linux-2.4.19-pre2/kernel/acct.c	Thu Feb 28 23:52:26 2002
+++ linux-2.4.19-pre2-j64/kernel/acct.c	Fri Mar  1 00:06:51 2002
@@ -56,6 +56,7 @@
 #include <linux/tty.h>
 
 #include <asm/uaccess.h>
+#include <asm/div64.h>
 
 /*
  * These constants control the amount of freespace that suspend and
@@ -227,20 +228,24 @@
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
 
@@ -248,16 +253,21 @@
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
@@ -278,6 +288,7 @@
 	mm_segment_t fs;
 	unsigned long vsize;
 	unsigned long flim;
+	u64 elapsed;
 
 	/*
 	 * First check to see if there is enough free_space to continue
@@ -295,8 +306,10 @@
 	strncpy(ac.ac_comm, current->comm, ACCT_COMM);
 	ac.ac_comm[ACCT_COMM - 1] = '\0';
 
-	ac.ac_btime = CT_TO_SECS(current->start_time) + (xtime.tv_sec - (jiffies / HZ));
-	ac.ac_etime = encode_comp_t(jiffies - current->start_time);
+	elapsed = get_jiffies64() - current->start_time;
+	ac.ac_etime = encode_comp_t(elapsed);
+	do_div(elapsed, HZ);
+	ac.ac_btime = xtime.tv_sec - elapsed;
 	ac.ac_utime = encode_comp_t(current->times.tms_utime);
 	ac.ac_stime = encode_comp_t(current->times.tms_stime);
 	ac.ac_uid = current->uid;

