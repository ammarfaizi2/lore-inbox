Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280740AbRKBRS3>; Fri, 2 Nov 2001 12:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280741AbRKBRSU>; Fri, 2 Nov 2001 12:18:20 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:63751 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S280740AbRKBRSF>; Fri, 2 Nov 2001 12:18:05 -0500
Date: Fri, 2 Nov 2001 18:18:00 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andreas Dilger <adilger@turbolabs.com>
cc: <linux-kernel@vger.kernel.org>, J Sloan <jjs@lexus.com>,
        Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        george anzinger <george@mvista.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Benjamin LaHaise <bcrl@redhat.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
In-Reply-To: <20011101182334.P16554@lynx.no>
Message-ID: <Pine.LNX.4.30.0111021744500.7256-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Nov 2001, Andreas Dilger wrote:

> On Nov 02, 2001  01:28 +0100, Tim Schmielau wrote:
> > Well, I did the next patch without waiting for progress on the stability
> > front (fsck still in heavy use here). As an excercise I added proper
> > locking to get_jiffies64().
>
> Looks good.
>
> >  	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
> > [snip]
> >  	 */
> >  #if HZ!=100
> >  	len = sprintf(page,"%lu.%02lu %lu.%02lu\n",
> > -		uptime / HZ,
> > -		(((uptime % HZ) * 100) / HZ) % 100,
> > +		(unsigned long) uptime,
> > +		(remainder * 100) / HZ,
> >  		idle / HZ,
> >  		(((idle % HZ) * 100) / HZ) % 100);
>
> Probably need to make idle a 64-bit value as well, even if the individual
> items are not, just to avoid potential overflow...  Calling do_div(idle,HZ)
> may end up being just as fast as the hoops we jump through above to calculate
> the fractions (2 divides, 2 modulus, and one multiply).
>
> Cheers, Andreas


I made up another patch as an RFC where this overflow is dealt with in the
same way as the jiffies wraparound. This will prevent wrong display of
idle time if /proc/uptime is read at least every 497 days.
The CPU time of the idle task will still overflow as it will for every
other process getting more than 497.1 days of CPU time, but I don't want
to blow up every time variable. I believe this to be acceptable behavior.

I think I have to give up on my stability problem. I see hard lockups on
SMP as well as UP at random times after the jiffies wrap.
Another problem surprises me: Sometimes I get quite an unresponsive system
even before jiffie wrap, sometimes not. Seems as some important timing
parameter sometimes gets detected wrong at boot time if INITIAL_JIFFIES is
large. The bogomips value, however, is always correct.

As suggested elsewhere, I made the pre-wrap INITIAL_JIFFIES value a config
option, so anybody might decide by himself to hunt down these problems
or not.
I kindly ask people to turn this on and help getting the issues sorted
out, as I don't want to imply a false feeling of safety with this patch
by hiding the jiffies wraparound from the user.


I will let this patch float around for some days to get feedback, and then
suggest it for inclusion into the mainline kernel.
I believe the ongoing discussion of a "real" 64 bit jiffie counter not to
interfere with this goal, since this can also be done at any later time
with the get_jiffies64() interface remaining unchanged.

Thanks all for your comments.

Tim


--- linux-2.4.14-pre6/fs/proc/proc_misc.c	Thu Oct 11 19:46:57 2001
+++ linux-2.4.14-pre6-jiffies64/fs/proc/proc_misc.c	Fri Nov  2 17:05:19 2001
@@ -39,6 +39,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>


 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -100,37 +101,59 @@
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }

+#if BITS_PER_LONG < 48
+
+u64 get_idle64(void)
+{
+	static unsigned long idle_hi, idle_last;
+	static spinlock_t idle64_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long idle;
+
+	spin_lock(&idle64_lock);
+	idle = init_tasks[0]->times.tms_utime + init_tasks[0]->times.tms_stime;
+	if (idle < idle_last)   /* We have a wrap */
+		idle_hi++;
+	idle_last = idle;
+	spin_unlock(&idle64_lock);
+
+	return (idle | ((u64)idle_hi) << BITS_PER_LONG);
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
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
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
--- linux-2.4.14-pre6/kernel/timer.c	Mon Oct  8 19:41:41 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/timer.c	Fri Nov  2 13:52:55 2001
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
+++ linux-2.4.14-pre6-jiffies64/kernel/info.c	Fri Nov  2 13:52:55 2001
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
+++ linux-2.4.14-pre6-jiffies64/include/linux/sched.h	Fri Nov  2 17:10:08 2001
@@ -351,7 +351,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	struct tms times;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
@@ -543,7 +543,14 @@

 #include <asm/current.h>

+#ifdef CONFIG_DEBUG_JIFFIEWRAP
+# define INITIAL_JIFFIES ((unsigned long)(-300*HZ))
+#else
+# define INITIAL_JIFFIES 0
+#endif
 extern unsigned long volatile jiffies;
+extern u64 get_jiffies64(void);
+
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern struct timeval xtime;
--- linux-2.4.14-pre6/kernel/fork.c	Wed Oct 24 02:44:15 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/fork.c	Fri Nov  2 13:52:55 2001
@@ -647,7 +647,7 @@
 	}
 #endif
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies64();

 	INIT_LIST_HEAD(&p->local_pages);

--- linux-2.4.14-pre6/kernel/acct.c	Mon Mar 19 21:35:08 2001
+++ linux-2.4.14-pre6-jiffies64/kernel/acct.c	Fri Nov  2 13:52:55 2001
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
+++ linux-2.4.14-pre6-jiffies64/fs/proc/array.c	Fri Nov  2 13:52:55 2001
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
--- linux-2.4.14-pre6/Documentation/Configure.help	Wed Oct 31 23:06:18 2001
+++ linux-2.4.14-pre6-jiffies64/Documentation/Configure.help	Fri Nov  2 16:38:34 2001
@@ -18530,6 +18530,14 @@
   Say Y here if you want the low-level print routines to direct their
   output to the serial port in the DC21285 (Footbridge).

+Debug jiffie counter wraparound (DANGEROUS)
+CONFIG_DEBUG_JIFFIEWRAP
+  Say Y here to initialize the jiffie counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffie counter is or if you want
+  a stable system, say N.
+
 Split initialisation functions into discardable section
 CONFIG_TEXT_SECTIONS
   If you say Y here, kernel code that is only used during
--- linux-2.4.14-pre6/arch/i386/config.in	Sun Oct 21 04:17:19 2001
+++ linux-2.4.14-pre6-jiffies64/arch/i386/config.in	Fri Nov  2 15:51:47 2001
@@ -404,6 +404,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   bool '  Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 fi

 endmenu
--- linux-2.4.14-pre6/arch/m68k/config.in	Tue Jun 12 04:15:27 2001
+++ linux-2.4.14-pre6-jiffies64/arch/m68k/config.in	Fri Nov  2 16:20:30 2001
@@ -545,4 +545,5 @@

 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 endmenu
--- linux-2.4.14-pre6/arch/mips/config.in	Mon Oct 15 22:41:34 2001
+++ linux-2.4.14-pre6-jiffies64/arch/mips/config.in	Fri Nov  2 16:21:40 2001
@@ -519,4 +519,5 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+bool 'Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 endmenu
--- linux-2.4.14-pre6/arch/parisc/config.in	Wed Apr 18 02:19:25 2001
+++ linux-2.4.14-pre6-jiffies64/arch/parisc/config.in	Fri Nov  2 16:22:33 2001
@@ -206,5 +206,6 @@

 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 endmenu

--- linux-2.4.14-pre6/arch/ppc/config.in	Tue Aug 28 16:11:33 2001
+++ linux-2.4.14-pre6-jiffies64/arch/ppc/config.in	Fri Nov  2 16:23:22 2001
@@ -388,4 +388,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
+bool 'Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 endmenu
--- linux-2.4.14-pre6/arch/sparc/config.in	Tue Jun 12 04:15:27 2001
+++ linux-2.4.14-pre6-jiffies64/arch/sparc/config.in	Fri Nov  2 16:23:51 2001
@@ -265,4 +265,5 @@
 comment 'Kernel hacking'

 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 endmenu
--- linux-2.4.14-pre6/arch/sh/config.in	Mon Oct 15 22:36:48 2001
+++ linux-2.4.14-pre6-jiffies64/arch/sh/config.in	Fri Nov  2 16:24:33 2001
@@ -385,4 +385,5 @@
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+bool 'Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 endmenu
--- linux-2.4.14-pre6/arch/arm/config.in	Wed Oct 31 23:06:18 2001
+++ linux-2.4.14-pre6-jiffies64/arch/arm/config.in	Fri Nov  2 16:26:10 2001
@@ -578,6 +578,7 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 dep_bool 'Disable pgtable cache' CONFIG_NO_PGT_CACHE $CONFIG_CPU_26
+bool 'Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 # These options are only for real kernel hackers who want to get their hands dirty.
 dep_bool 'Kernel low-level debugging functions' CONFIG_DEBUG_LL $CONFIG_EXPERIMENTAL
 dep_bool '  Kernel low-level debugging messages via footbridge serial port' CONFIG_DEBUG_DC21285_PORT $CONFIG_DEBUG_LL $CONFIG_FOOTBRIDGE
--- linux-2.4.14-pre6/arch/cris/config.in	Mon Oct 15 22:42:14 2001
+++ linux-2.4.14-pre6-jiffies64/arch/cris/config.in	Fri Nov  2 16:26:36 2001
@@ -250,4 +250,5 @@
 if [ "$CONFIG_PROFILE" = "y" ]; then
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
+bool 'Debug jiffie counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIEWRAP
 endmenu


