Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279860AbRKBA27>; Thu, 1 Nov 2001 19:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279873AbRKBA2v>; Thu, 1 Nov 2001 19:28:51 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:7428 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S279860AbRKBA2b>; Thu, 1 Nov 2001 19:28:31 -0500
Date: Fri, 2 Nov 2001 01:28:29 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <linux-kernel@vger.kernel.org>
cc: Andreas Dilger <adilger@turbolabs.com>, J Sloan <jjs@lexus.com>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        george anzinger <george@mvista.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <Pine.LNX.4.30.0111011224440.1053-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.30.0111020059170.5092-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Tim Schmielau wrote:

> On Thu, 1 Nov 2001, george anzinger wrote:
>
[...]
> > Doesn't this need to be protected on SMP machines?  What if two cpus
> > call get_jiffies64() at the same time...  Seems like jiffies_hi could
> > get bumped twice instead of once.
> >
> > George
> >
>
> Yes, it does, my race protection is bogus. Petr Vandrovec also pointed out
> that. So we do need either to
>  a) stuff jiffies_hi and jiffies_last into one atomic type
>     (16 bits is enough for each) or
>  b) use locking.
> My next patch will use b), but I won't do it until I have resolved the
> most annoying stability issues. I won't have time to do this before the
> weekend, and don't want to bother the list too much either.
>
> Maybe the lockups are just due to my setting of INITIAL_JIFFIES instead of
> waiting 471 days. The time adjustment routines are good candidates for
> this kind of mistakes. Any ideas anyone where else I might have forgotten
> to introduce INITIAL_JIFFIES ?
>


Well, I did the next patch without waiting for progress on the stability
front (fsck still in heavy use here). As an excercise I added proper
locking to get_jiffies64().

Actually, it is not decided yet whether jiffies_hi should be incremented
in get_jiffies64() or in do_timer(), and whether jiffies and jiffies_hi
should be glued together to form a 64 bit value, so the innards of
get_jiffies64() might change again.

However, no objections have been raised on the interface, so I started to
add some uses of it. I bumped up the start_time field of struct task_struct
to 64 bits, so that ps output will still be ok after the 32 bit
wraparound. This change might break userland applications that expect the
/proc/#/stat fields to fit in 32 bit variables. Yet this is not a
regression as the kernel was broken for these cases until now.

As a side effect, the problem of the current get_jiffies64()
implementation loosing jiffie wraparounds is weakened further.
With the current patch wraparounds can only be lost if no processes are
started or finished for 497 days, a condition that I can only imagine to
be met by embedded devices.

Tim


--- linux-2.4.14-pre6/fs/proc/proc_misc.c	Thu Oct 11 19:46:57 2001
+++ linux-2.4.14-pre6-jiffies64/fs/proc/proc_misc.c	Wed Oct 31 22:53:55 2001
@@ -39,6 +39,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>


 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -103,15 +104,19 @@
 static int uptime_read_proc(char *page, char **start, off_t off,
 				 int count, int *eof, void *data)
 {
-	unsigned long uptime;
+	u64 uptime;
+	unsigned long remainder;
 	unsigned long idle;
 	int len;

-	uptime = jiffies;
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
+	remainder = (unsigned long) do_div(uptime, HZ);
+
 	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;

-	/* The formula for the fraction parts really is ((t * 100) / HZ) % 100, but
-	   that would overflow about every five days at HZ == 100.
+	/* The formula for the fraction part of the idle time really is
+	   ((t * 100) / HZ) % 100, but that would overflow about
+	    every five days at HZ == 100.
 	   Therefore the identity a = (a / b) * b + a % b is used so that it is
 	   calculated as (((t / HZ) * 100) + ((t % HZ) * 100) / HZ) % 100.
 	   The part in front of the '+' always evaluates as 0 (mod 100). All divisions
@@ -121,14 +126,14 @@
 	 */
 #if HZ!=100
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		(((uptime % HZ) * 100) / HZ) % 100,
+		(unsigned long) uptime,
+		(remainder * 100) / HZ,
 		idle / HZ,
 		(((idle % HZ) * 100) / HZ) % 100);
 #else
 	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
-		uptime / HZ,
-		uptime % HZ,
+		(unsigned long) uptime,
+		remainder,
 		idle / HZ,
 		idle % HZ);
 #endif
--- linux-2.4.14-pre6/kernel/timer.c	Mon Oct  8 19:41:41 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/timer.c	Thu Nov  1 23:05:38 2001
@@ -65,7 +65,7 @@

 extern int do_setitimer(int, struct itimerval *, struct itimerval *);

-unsigned long volatile jiffies;
+unsigned long volatile jiffies = INITIAL_JIFFIES;

 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -117,7 +117,7 @@
 		INIT_LIST_HEAD(tv1.vec + i);
 }

-static unsigned long timer_jiffies;
+static unsigned long timer_jiffies = INITIAL_JIFFIES;

 static inline void internal_add_timer(struct timer_list *timer)
 {
@@ -638,7 +638,7 @@
 }

 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;

 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca
@@ -683,6 +683,37 @@
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
+
+
+#if BITS_PER_LONG < 48
+
+u64 get_jiffies64(void)
+{
+	static unsigned long jiffies_hi = 0;
+	static unsigned long jiffies_last = INITIAL_JIFFIES;
+	static spinlock_t jiffies64_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long jiffies_tmp;
+
+	spin_lock(&jiffies64_lock);
+	jiffies_tmp = jiffies;   /* avoid races */
+	if (jiffies_tmp < jiffies_last)   /* We have a wrap */
+		jiffies_hi++;
+	jiffies_last = jiffies_tmp;
+	spin_unlock(&jiffies64_lock);
+
+	return (jiffies_tmp | ((u64)jiffies_hi) << BITS_PER_LONG);
+}
+
+#else
+ /* jiffies is wide enough to not wrap for 8716 years at HZ==1024 */
+
+static inline u64 get_jiffies64(void)
+{
+	return (u64)jiffies;
+}
+
+#endif /* BITS_PER_LONG < 48 */
+

 #if !defined(__alpha__) && !defined(__ia64__)

--- linux-2.4.14-pre6/kernel/info.c	Sat Apr 21 01:15:40 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/info.c	Wed Oct 31 23:15:26 2001
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
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
+	do_div(uptime, HZ);
+	val.uptime = (unsigned long) uptime;

 	val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
 	val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
--- linux-2.4.14-pre6/include/linux/sched.h	Wed Oct 31 23:06:23 2001
+++ linux-2.4.14-pre6-jiffies64/include/linux/sched.h	Fri Nov  2 00:46:39 2001
@@ -351,7 +351,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	struct tms times;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
@@ -543,7 +543,10 @@

 #include <asm/current.h>

+#define INITIAL_JIFFIES ((unsigned long)(-120*HZ))
 extern unsigned long volatile jiffies;
+extern u64 get_jiffies64(void);
+
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern struct timeval xtime;
--- linux-2.4.14-pre6/kernel/fork.c	Wed Oct 24 02:44:15 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/fork.c	Thu Nov  1 22:57:20 2001
@@ -647,7 +647,7 @@
 	}
 #endif
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies64();

 	INIT_LIST_HEAD(&p->local_pages);

--- linux-2.4.14-pre6/kernel/acct.c	Mon Mar 19 21:35:08 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/acct.c	Fri Nov  2 00:13:37 2001
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
+		/* Overflow. Return largest representable number instead */
+		return (1 << (MANTSIZE + EXPSIZE)) - 1;
+	} else {
+		exp <<= MANTSIZE;	/* Shift the exponent into place */
+		exp += value;		/* and add on the mantissa. */
+		return exp;
+	}
 }

 /*
@@ -277,6 +287,7 @@
 	struct acct ac;
 	mm_segment_t fs;
 	unsigned long vsize;
+	u64 elapsed;

 	/*
 	 * First check to see if there is enough free_space to continue
@@ -294,8 +305,10 @@
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
--- linux-2.4.14-pre6/fs/proc/array.c	Thu Oct 11 18:00:01 2001
+++ linux-2.4.14-pre6-jiffies64/fs/proc/array.c	Thu Nov  1 23:04:02 2001
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
+		(unsigned long long)(task->start_time - INITIAL_JIFFIES),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

