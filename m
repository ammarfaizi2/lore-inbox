Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281983AbRKUVkk>; Wed, 21 Nov 2001 16:40:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281985AbRKUVkV>; Wed, 21 Nov 2001 16:40:21 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:11538 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S281983AbRKUVkC>; Wed, 21 Nov 2001 16:40:02 -0500
Date: Wed, 21 Nov 2001 22:39:59 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <linux-kernel@vger.kernel.org>
Subject: [patch] config option to debug jiffies wraps
In-Reply-To: <Pine.LNX.4.30.0111212104070.24469-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.30.0111212225340.24704-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here goes the jiffy wrap debug option that I ripped out of my earlier
jiffie wrap patch. It moves forward the jiffies wrap on 32 bit from 497
days after boot to 5 min after boot.

While it is intended to create some gentle pressure to correctly account for
jiffie wraps, the config option is sufficiently marked to prevent
nonintentional use.

No debug option is offered on 64 bit platforms where jiffie wraps just
cannot happen.

The patch depends on my previous 64 bit jiffies patch.

Tim


--- linux-2.4.15-pre8-jiffies64-2/include/linux/timex.h	Wed Nov 21 20:10:19 2001
+++ linux-2.4.15-pre8-jiffies64/include/linux/timex.h	Wed Nov 21 18:23:18 2001
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

--- linux-2.4.15-pre8-jiffies64-2/kernel/timer.c	Wed Nov 21 20:05:36 2001
+++ linux-2.4.15-pre8-jiffies64/kernel/timer.c	Wed Nov 21 18:19:01 2001
@@ -65,7 +65,7 @@

 extern int do_setitimer(int, struct itimerval *, struct itimerval *);

-unsigned long volatile jiffies;
+unsigned long volatile jiffies = INITIAL_JIFFIES;

 unsigned int * prof_buffer;
 unsigned long prof_len;
@@ -118,10 +118,18 @@
 	for (i = 0; i < TVR_SIZE; i++)
 		INIT_LIST_HEAD(tv1.vec + i);

+#ifdef CONFIG_DEBUG_JIFFIESWRAP
+	tv1.index = INITIAL_JIFFIES & TVR_MASK;
+	tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
+	tv3.index = (INITIAL_JIFFIES >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
+	tv4.index = (INITIAL_JIFFIES >> (TVR_BITS + 2*TVN_BITS)) & TVN_MASK;
+	tv5.index = (INITIAL_JIFFIES >> (TVR_BITS + 3*TVN_BITS)) & TVN_MASK;
+#endif
+
 	init_jiffieswrap_timer();
 }

-static unsigned long timer_jiffies;
+static unsigned long timer_jiffies = INITIAL_JIFFIES;

 static inline void internal_add_timer(struct timer_list *timer)
 {
@@ -642,7 +650,7 @@
 }

 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;

 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca
@@ -694,7 +702,7 @@
 u64 get_jiffies64(void)
 {
 	static unsigned long jiffies_hi = 0;
-	static unsigned long jiffies_last;
+	static unsigned long jiffies_last = INITIAL_JIFFIES;
 	static spinlock_t jiffies64_lock = SPIN_LOCK_UNLOCKED;
 	unsigned long jiffies_tmp, flags;


--- linux-2.4.15-pre8-jiffies64-2/fs/proc/array.c	Wed Nov 21 20:05:36 2001
+++ linux-2.4.15-pre8-jiffies64/fs/proc/array.c	Wed Nov 21 18:19:01 2001
@@ -366,7 +366,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		(unsigned long long)(task->start_time),
+		(unsigned long long)(task->start_time) - INITIAL_JIFFIES,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.4.15-pre8-jiffies64-2/fs/proc/proc_misc.c	Wed Nov 21 20:05:36 2001
+++ linux-2.4.15-pre8-jiffies64/fs/proc/proc_misc.c	Wed Nov 21 18:37:56 2001
@@ -153,7 +153,7 @@
 	unsigned long uptime_remainder, idle_remainder;
 	int len;

-	uptime = get_jiffies64();
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
 	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 	idle = get_idle64();
 	idle_remainder = (unsigned long) do_div(idle, HZ);

--- linux-2.4.15-pre8-jiffies64-2/kernel/info.c	Wed Nov 21 20:05:36 2001
+++ linux-2.4.15-pre8-jiffies64/kernel/info.c	Wed Nov 21 18:19:01 2001
@@ -22,7 +22,7 @@
 	memset((char *)&val, 0, sizeof(struct sysinfo));

 	cli();
-	uptime = get_jiffies64();
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
 	do_div(uptime, HZ);
 	val.uptime = (unsigned long) uptime;


--- linux-2.4.15-pre8-jiffies64-2/Documentation/Configure.help	Wed Nov 21 17:49:03 2001
+++ linux-2.4.15-pre8-jiffies64/Documentation/Configure.help	Wed Nov 21 18:19:01 2001
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

--- linux-2.4.15-pre8-jiffies64-2/arch/arm/config.in	Wed Nov 21 17:49:03 2001
+++ linux-2.4.15-pre8-jiffies64/arch/arm/config.in	Wed Nov 21 18:19:01 2001
@@ -601,6 +601,7 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 dep_bool 'Disable pgtable cache' CONFIG_NO_PGT_CACHE $CONFIG_CPU_26
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 # These options are only for real kernel hackers who want to get their hands dirty.
 dep_bool 'Kernel low-level debugging functions' CONFIG_DEBUG_LL $CONFIG_EXPERIMENTAL
 dep_bool '  Kernel low-level debugging messages via footbridge serial port' CONFIG_DEBUG_DC21285_PORT $CONFIG_DEBUG_LL $CONFIG_FOOTBRIDGE

--- linux-2.4.15-pre8-jiffies64-2/arch/cris/config.in	Mon Oct 15 22:42:14 2001
+++ linux-2.4.15-pre8-jiffies64/arch/cris/config.in	Wed Nov 21 18:19:01 2001
@@ -250,4 +250,5 @@
 if [ "$CONFIG_PROFILE" = "y" ]; then
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.15-pre8-jiffies64-2/arch/i386/config.in	Wed Nov 21 17:49:03 2001
+++ linux-2.4.15-pre8-jiffies64/arch/i386/config.in	Wed Nov 21 18:19:01 2001
@@ -407,6 +407,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 fi

 endmenu

--- linux-2.4.15-pre8-jiffies64-2/arch/m68k/config.in	Tue Jun 12 04:15:27 2001
+++ linux-2.4.15-pre8-jiffies64/arch/m68k/config.in	Wed Nov 21 18:19:01 2001
@@ -545,4 +545,5 @@

 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.15-pre8-jiffies64-2/arch/mips/config.in	Mon Oct 15 22:41:34 2001
+++ linux-2.4.15-pre8-jiffies64/arch/mips/config.in	Wed Nov 21 18:19:01 2001
@@ -519,4 +519,5 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.15-pre8-jiffies64-2/arch/parisc/config.in	Wed Apr 18 02:19:25 2001
+++ linux-2.4.15-pre8-jiffies64/arch/parisc/config.in	Wed Nov 21 18:19:01 2001
@@ -206,5 +206,6 @@

 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu


--- linux-2.4.15-pre8-jiffies64-2/arch/ppc/config.in	Wed Nov 21 17:49:04 2001
+++ linux-2.4.15-pre8-jiffies64/arch/ppc/config.in	Wed Nov 21 18:19:01 2001
@@ -392,4 +392,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.15-pre8-jiffies64-2/arch/sh/config.in	Mon Oct 15 22:36:48 2001
+++ linux-2.4.15-pre8-jiffies64/arch/sh/config.in	Wed Nov 21 18:19:01 2001
@@ -385,4 +385,5 @@
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.15-pre8-jiffies64-2/arch/sparc/config.in	Tue Jun 12 04:15:27 2001
+++ linux-2.4.15-pre8-jiffies64/arch/sparc/config.in	Wed Nov 21 18:19:01 2001
@@ -265,4 +265,5 @@
 comment 'Kernel hacking'

 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

