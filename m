Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281490AbRKRWrw>; Sun, 18 Nov 2001 17:47:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281523AbRKRWrp>; Sun, 18 Nov 2001 17:47:45 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:29195 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S281490AbRKRWrd>; Sun, 18 Nov 2001 17:47:33 -0500
Date: Sun, 18 Nov 2001 23:47:28 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Jurriaan on Alpha <thunder7@xs4all.nl>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
        J Sloan <jjs@lexus.com>, Petr Vandrovec <VANDROVE@vc.cvut.cz>,
        george anzinger <george@mvista.com>,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        Benjamin LaHaise <bcrl@redhat.com>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: Re: [Patch] enable uptime display > 497 days
In-Reply-To: <20011118201020.A7240@alpha.of.nowhere>
Message-ID: <Pine.LNX.4.30.0111182338190.8195-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, Jurriaan on Alpha wrote:

> On Sun, Nov 18, 2001 at 12:57:01PM +0100, Tim Schmielau wrote:
> > [new patch further down]
> >
> > I extended the patch to use a counter for periodically checking for
> > jiffies overflows, so none can go undetected anymore. Still the CPU time
> > overhead is minimal as timer are implemented rather efficiently
> >
> I tried it, but it wouldn't apply cleanly (something in arch/arm
> clashed). That didn't look too worrying, but compilation also failed:
>
[...]
> kernel/kernel.o: In function `do_fork':
> kernel/kernel.o(.text+0x3168): undefined reference to `get_jiffies64'
> kernel/kernel.o(.text+0x316c): undefined reference to `get_jiffies64'
> kernel/kernel.o: In function `sys_sysinfo':
> kernel/kernel.o(.text+0x9c7c): undefined reference to `get_jiffies64'
> kernel/kernel.o(.text+0x9c80): undefined reference to `get_jiffies64'
> mm/mm.o: In function `badness':
> mm/mm.o(.text+0x148b8): undefined reference to `get_jiffies64'
> mm/mm.o(.text+0x148bc): more undefined references to `get_jiffies64' follow
> make: *** [vmlinux] Error 1
> alpha:/usr/src/linux#
>
> This is on an Alpha, .config below.

Ack.
I thought it was a clever idea to delay the decision whether or not
to inline get_jiffies64 from the header file to the actual code, when
actually it was not.

Thank you for testing and spotting this even if the patch is of no use on
alpha.

New patch appended.

Tim


diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/Documentation/Configure.help linux-2.4.15-pre6-jiffies64/Documentation/Configure.help
--- linux-2.4.15-pre6/Documentation/Configure.help	Sun Nov 18 10:41:30 2001
+++ linux-2.4.15-pre6-jiffies64/Documentation/Configure.help	Sun Nov 18 10:42:12 2001
@@ -23579,6 +23579,14 @@
   of the BUG call as well as the EIP and oops trace.  This aids
   debugging but costs about 70-100K of memory.

+Debug jiffies counter wraparound (DANGEROUS)
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.
+
 Include kgdb kernel debugger
 CONFIG_KGDB
   Include in-kernel hooks for kgdb, the Linux kernel source level
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/arm/config.in linux-2.4.15-pre6-jiffies64/arch/arm/config.in
--- linux-2.4.15-pre6/arch/arm/config.in	Sun Nov 18 10:41:30 2001
+++ linux-2.4.15-pre6-jiffies64/arch/arm/config.in	Sun Nov 18 10:42:12 2001
@@ -601,6 +601,7 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 dep_bool 'Disable pgtable cache' CONFIG_NO_PGT_CACHE $CONFIG_CPU_26
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 # These options are only for real kernel hackers who want to get their hands dirty.
 dep_bool 'Kernel low-level debugging functions' CONFIG_DEBUG_LL $CONFIG_EXPERIMENTAL
 dep_bool '  Kernel low-level debugging messages via footbridge serial port' CONFIG_DEBUG_DC21285_PORT $CONFIG_DEBUG_LL $CONFIG_FOOTBRIDGE
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/cris/config.in linux-2.4.15-pre6-jiffies64/arch/cris/config.in
--- linux-2.4.15-pre6/arch/cris/config.in	Mon Oct 15 22:42:14 2001
+++ linux-2.4.15-pre6-jiffies64/arch/cris/config.in	Sun Nov 18 10:42:12 2001
@@ -250,4 +250,5 @@
 if [ "$CONFIG_PROFILE" = "y" ]; then
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/i386/config.in linux-2.4.15-pre6-jiffies64/arch/i386/config.in
--- linux-2.4.15-pre6/arch/i386/config.in	Sun Nov 18 10:41:30 2001
+++ linux-2.4.15-pre6-jiffies64/arch/i386/config.in	Sun Nov 18 10:42:12 2001
@@ -407,6 +407,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 fi

 endmenu
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/m68k/config.in linux-2.4.15-pre6-jiffies64/arch/m68k/config.in
--- linux-2.4.15-pre6/arch/m68k/config.in	Tue Jun 12 04:15:27 2001
+++ linux-2.4.15-pre6-jiffies64/arch/m68k/config.in	Sun Nov 18 10:42:12 2001
@@ -545,4 +545,5 @@

 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/mips/config.in linux-2.4.15-pre6-jiffies64/arch/mips/config.in
--- linux-2.4.15-pre6/arch/mips/config.in	Mon Oct 15 22:41:34 2001
+++ linux-2.4.15-pre6-jiffies64/arch/mips/config.in	Sun Nov 18 10:42:12 2001
@@ -519,4 +519,5 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/parisc/config.in linux-2.4.15-pre6-jiffies64/arch/parisc/config.in
--- linux-2.4.15-pre6/arch/parisc/config.in	Wed Apr 18 02:19:25 2001
+++ linux-2.4.15-pre6-jiffies64/arch/parisc/config.in	Sun Nov 18 10:42:12 2001
@@ -206,5 +206,6 @@

 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/ppc/config.in linux-2.4.15-pre6-jiffies64/arch/ppc/config.in
--- linux-2.4.15-pre6/arch/ppc/config.in	Sun Nov 18 10:41:30 2001
+++ linux-2.4.15-pre6-jiffies64/arch/ppc/config.in	Sun Nov 18 10:42:12 2001
@@ -392,4 +392,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/sh/config.in linux-2.4.15-pre6-jiffies64/arch/sh/config.in
--- linux-2.4.15-pre6/arch/sh/config.in	Mon Oct 15 22:36:48 2001
+++ linux-2.4.15-pre6-jiffies64/arch/sh/config.in	Sun Nov 18 10:42:12 2001
@@ -385,4 +385,5 @@
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/arch/sparc/config.in linux-2.4.15-pre6-jiffies64/arch/sparc/config.in
--- linux-2.4.15-pre6/arch/sparc/config.in	Tue Jun 12 04:15:27 2001
+++ linux-2.4.15-pre6-jiffies64/arch/sparc/config.in	Sun Nov 18 10:42:12 2001
@@ -265,4 +265,5 @@
 comment 'Kernel hacking'

 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/fs/proc/array.c linux-2.4.15-pre6-jiffies64/fs/proc/array.c
--- linux-2.4.15-pre6/fs/proc/array.c	Thu Oct 11 18:00:01 2001
+++ linux-2.4.15-pre6-jiffies64/fs/proc/array.c	Sun Nov 18 10:42:12 2001
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
+		(unsigned long long)(task->start_time) - INITIAL_JIFFIES,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/fs/proc/proc_misc.c linux-2.4.15-pre6-jiffies64/fs/proc/proc_misc.c
--- linux-2.4.15-pre6/fs/proc/proc_misc.c	Sun Nov 18 10:41:35 2001
+++ linux-2.4.15-pre6-jiffies64/fs/proc/proc_misc.c	Sun Nov 18 10:42:12 2001
@@ -40,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
+#include <asm/div64.h>


 #define LOAD_INT(x) ((x) >> FSHIFT)
@@ -98,37 +99,59 @@
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
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/include/linux/sched.h linux-2.4.15-pre6-jiffies64/include/linux/sched.h
--- linux-2.4.15-pre6/include/linux/sched.h	Sun Nov 18 10:41:37 2001
+++ linux-2.4.15-pre6-jiffies64/include/linux/sched.h	Sun Nov 18 23:08:34 2001
@@ -352,7 +352,7 @@
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
 	struct timer_list real_timer;
 	struct tms times;
-	unsigned long start_time;
+	u64 start_time;
 	long per_cpu_utime[NR_CPUS], per_cpu_stime[NR_CPUS];
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt, nswap, cmin_flt, cmaj_flt, cnswap;
@@ -549,6 +549,18 @@
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
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/include/linux/timex.h linux-2.4.15-pre6-jiffies64/include/linux/timex.h
--- linux-2.4.15-pre6/include/linux/timex.h	Mon Nov  5 21:42:13 2001
+++ linux-2.4.15-pre6-jiffies64/include/linux/timex.h	Sun Nov 18 23:08:34 2001
@@ -53,6 +53,13 @@

 #include <asm/param.h>

+#ifdef CONFIG_DEBUG_JIFFIESWRAP
+  /* Make the jiffies counter wrap around sooner. */
+# define INITIAL_JIFFIES ((unsigned long)(-300*HZ))
+#else
+# define INITIAL_JIFFIES 0
+#endif
+
 /*
  * The following defines establish the engineering parameters of the PLL
  * model. The HZ variable establishes the timer interrupt frequency, 100 Hz
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/kernel/acct.c linux-2.4.15-pre6-jiffies64/kernel/acct.c
--- linux-2.4.15-pre6/kernel/acct.c	Mon Mar 19 21:35:08 2001
+++ linux-2.4.15-pre6-jiffies64/kernel/acct.c	Sun Nov 18 10:42:12 2001
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
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/kernel/fork.c linux-2.4.15-pre6-jiffies64/kernel/fork.c
--- linux-2.4.15-pre6/kernel/fork.c	Wed Oct 24 02:44:15 2001
+++ linux-2.4.15-pre6-jiffies64/kernel/fork.c	Sun Nov 18 10:42:12 2001
@@ -647,7 +647,7 @@
 	}
 #endif
 	p->lock_depth = -1;		/* -1 = no lock */
-	p->start_time = jiffies;
+	p->start_time = get_jiffies64();

 	INIT_LIST_HEAD(&p->local_pages);

diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/kernel/info.c linux-2.4.15-pre6-jiffies64/kernel/info.c
--- linux-2.4.15-pre6/kernel/info.c	Sat Apr 21 01:15:40 2001
+++ linux-2.4.15-pre6-jiffies64/kernel/info.c	Sun Nov 18 10:42:12 2001
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
diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/kernel/timer.c linux-2.4.15-pre6-jiffies64/kernel/timer.c
--- linux-2.4.15-pre6/kernel/timer.c	Mon Oct  8 19:41:41 2001
+++ linux-2.4.15-pre6-jiffies64/kernel/timer.c	Sun Nov 18 23:05:12 2001
@@ -65,7 +65,7 @@

 extern int do_setitimer(int, struct itimerval *, struct itimerval *);

-unsigned long volatile jiffies;
+unsigned long volatile jiffies = INITIAL_JIFFIES;

 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -103,6 +103,8 @@

 #define NOOF_TVECS (sizeof(tvecs) / sizeof(tvecs[0]))

+static inline void init_jiffieswrap_timer(void);
+
 void init_timervecs (void)
 {
 	int i;
@@ -115,9 +117,19 @@
 	}
 	for (i = 0; i < TVR_SIZE; i++)
 		INIT_LIST_HEAD(tv1.vec + i);
+
+#ifdef CONFIG_DEBUG_JIFFIESWRAP
+	tv1.index = INITIAL_JIFFIES & TVR_MASK;
+	tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
+	tv3.index = (INITIAL_JIFFIES >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
+	tv4.index = (INITIAL_JIFFIES >> (TVR_BITS + 2*TVN_BITS)) & TVN_MASK;
+	tv5.index = (INITIAL_JIFFIES >> (TVR_BITS + 3*TVN_BITS)) & TVN_MASK;
+#endif
+
+	init_jiffieswrap_timer();
 }

-static unsigned long timer_jiffies;
+static unsigned long timer_jiffies = INITIAL_JIFFIES;

 static inline void internal_add_timer(struct timer_list *timer)
 {
@@ -638,7 +650,7 @@
 }

 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;

 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca
@@ -683,6 +695,54 @@
 	if (TQ_ACTIVE(tq_timer))
 		mark_bh(TQUEUE_BH);
 }
+
+
+#ifdef NEEDS_JIFFIES64
+
+u64 get_jiffies64(void)
+{
+	static unsigned long jiffies_hi = 0;
+	static unsigned long jiffies_last = INITIAL_JIFFIES;
+	static spinlock_t jiffies64_lock = SPIN_LOCK_UNLOCKED;
+	unsigned long jiffies_tmp, flags;
+
+	spin_lock_irqsave(&jiffies64_lock, flags);
+	jiffies_tmp = jiffies;   /* avoid races */
+	if (jiffies_tmp < jiffies_last)   /* We have a wrap */
+		jiffies_hi++;
+	jiffies_last = jiffies_tmp;
+	spin_unlock_irqrestore(&jiffies64_lock, flags);
+
+	return (jiffies_tmp | ((u64)jiffies_hi) << BITS_PER_LONG);
+}
+
+/* use a timer to periodically check for jiffies overflows */
+
+static struct timer_list jiffieswrap_timer;
+#define CHECK_JIFFIESWRAP_INTERVAL (1ul << (BITS_PER_LONG-2))
+
+static void check_jiffieswrap(unsigned long data)
+{
+	mod_timer(&jiffieswrap_timer, jiffies + CHECK_JIFFIESWRAP_INTERVAL);
+	get_jiffies64();
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
+#endif /* NEEDS_JIFFIES64 */
+

 #if !defined(__alpha__) && !defined(__ia64__)

diff -u -r --exclude-from dontdiff linux-2.4.15-pre6/mm/oom_kill.c linux-2.4.15-pre6-jiffies64/mm/oom_kill.c
--- linux-2.4.15-pre6/mm/oom_kill.c	Sun Nov  4 02:05:25 2001
+++ linux-2.4.15-pre6-jiffies64/mm/oom_kill.c	Sun Nov 18 10:42:12 2001
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



