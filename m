Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292485AbSBZR7c>; Tue, 26 Feb 2002 12:59:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292478AbSBZR5r>; Tue, 26 Feb 2002 12:57:47 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:59912 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S292503AbSBZR5F>; Tue, 26 Feb 2002 12:57:05 -0500
Date: Tue, 26 Feb 2002 18:57:04 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <linux-kernel@vger.kernel.org>
cc: george anzinger <george@mvista.com>
Subject: Re: [patch][rfc] enable uptime display > 497 days on 32 bit
In-Reply-To: <Pine.LNX.4.33.0202261754030.14645-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0202261849580.14645-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a config option on 32 bit platforms to set the 
jiffies counter to a values 5 minutes before wraparound. It depends on my 
previous patch to "enable uptime display > 497 days on 32 bit". 

This should help to find any remaining problems at jiffies wraparound.
As many fixes went into 2.4.18, this shouldn't be that dangerous anymore,
and I'd like as many people as possible to try this out.
Still, you have to feel OK in case your box does indeed struggle, so the 
warning is left in.

Tim


--- linux-2.4.19-pre1-j64/include/linux/timex.h	Thu Nov 22 20:46:18 2001
+++ linux-2.4.19-pre1-j64-dbg/include/linux/timex.h	Tue Feb 26 16:44:08 2002
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

--- linux-2.4.19-pre1-j64/kernel/timer.c	Tue Feb 26 16:13:35 2002
+++ linux-2.4.19-pre1-j64-dbg/kernel/timer.c	Tue Feb 26 16:39:02 2002
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
@@ -693,7 +701,7 @@
 
 u64 get_jiffies64(void)
 {
-	static unsigned long jiffies_hi, jiffies_last;
+	static unsigned long jiffies_hi, jiffies_last = INITIAL_JIFFIES;
 	static spinlock_t jiffies64_lock = SPIN_LOCK_UNLOCKED;
 	unsigned long jiffies_tmp, flags;
 

--- linux-2.4.19-pre1-j64/fs/proc/array.c	Tue Feb 26 16:13:35 2002
+++ linux-2.4.19-pre1-j64-dbg/fs/proc/array.c	Tue Feb 26 16:39:02 2002
@@ -366,7 +366,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		(unsigned long long)(task->start_time),
+		(unsigned long long)(task->start_time) - INITIAL_JIFFIES,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.4.19-pre1-j64/fs/proc/proc_misc.c	Tue Feb 26 16:50:45 2002
+++ linux-2.4.19-pre1-j64-dbg/fs/proc/proc_misc.c	Tue Feb 26 16:50:28 2002
@@ -153,7 +153,7 @@
 	unsigned long uptime_remainder, idle_remainder;
 	int len;
 
-	uptime = get_jiffies64();
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
 	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 	idle = get_idle64();
 	idle_remainder = (unsigned long) do_div(idle, HZ);
@@ -286,7 +286,7 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	u64 jif = get_jiffies64();
+	u64 jif = get_jiffies64() - INITIAL_JIFFIES;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0;
 	int major, disk;
 

--- linux-2.4.19-pre1-j64/kernel/info.c	Tue Feb 26 16:13:35 2002
+++ linux-2.4.19-pre1-j64-dbg/kernel/info.c	Tue Feb 26 16:39:02 2002
@@ -22,7 +22,7 @@
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	cli();
-	uptime = get_jiffies64();
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
 	do_div(uptime, HZ);
 	val.uptime = (unsigned long) uptime;
 

--- linux-2.4.19-pre1-j64/Documentation/Configure.help	Tue Feb 26 16:12:18 2002
+++ linux-2.4.19-pre1-j64-dbg/Documentation/Configure.help	Tue Feb 26 16:39:02 2002
@@ -24034,6 +24034,14 @@
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

--- linux-2.4.19-pre1-j64/arch/arm/config.in	Fri Nov  9 22:58:02 2001
+++ linux-2.4.19-pre1-j64-dbg/arch/arm/config.in	Tue Feb 26 16:39:02 2002
@@ -601,6 +601,7 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Spinlock debugging' CONFIG_DEBUG_SPINLOCK
 dep_bool 'Disable pgtable cache' CONFIG_NO_PGT_CACHE $CONFIG_CPU_26
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 # These options are only for real kernel hackers who want to get their hands dirty. 
 dep_bool 'Kernel low-level debugging functions' CONFIG_DEBUG_LL $CONFIG_EXPERIMENTAL
 dep_bool '  Kernel low-level debugging messages via footbridge serial port' CONFIG_DEBUG_DC21285_PORT $CONFIG_DEBUG_LL $CONFIG_FOOTBRIDGE

--- linux-2.4.19-pre1-j64/arch/cris/config.in	Sun Feb 24 19:20:36 2002
+++ linux-2.4.19-pre1-j64-dbg/arch/cris/config.in	Tue Feb 26 16:39:02 2002
@@ -253,4 +253,5 @@
 if [ "$CONFIG_PROFILE" = "y" ]; then
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.19-pre1-j64/arch/i386/config.in	Sun Feb 24 19:20:36 2002
+++ linux-2.4.19-pre1-j64-dbg/arch/i386/config.in	Tue Feb 26 16:39:02 2002
@@ -422,6 +422,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE
+   bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 fi
 
 endmenu

--- linux-2.4.19-pre1-j64/arch/m68k/config.in	Tue Jun 12 04:15:27 2001
+++ linux-2.4.19-pre1-j64-dbg/arch/m68k/config.in	Tue Feb 26 16:39:02 2002
@@ -545,4 +545,5 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.19-pre1-j64/arch/mips/config.in	Mon Oct 15 22:41:34 2001
+++ linux-2.4.19-pre1-j64-dbg/arch/mips/config.in	Tue Feb 26 16:39:02 2002
@@ -519,4 +519,5 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.19-pre1-j64/arch/parisc/config.in	Wed Apr 18 02:19:25 2001
+++ linux-2.4.19-pre1-j64-dbg/arch/parisc/config.in	Tue Feb 26 16:39:02 2002
@@ -206,5 +206,6 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 

--- linux-2.4.19-pre1-j64/arch/ppc/config.in	Sun Feb 24 19:20:36 2002
+++ linux-2.4.19-pre1-j64-dbg/arch/ppc/config.in	Tue Feb 26 16:39:02 2002
@@ -399,4 +399,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.19-pre1-j64/arch/sh/config.in	Sun Feb 24 19:20:37 2002
+++ linux-2.4.19-pre1-j64-dbg/arch/sh/config.in	Tue Feb 26 16:39:02 2002
@@ -385,4 +385,5 @@
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.19-pre1-j64/arch/sparc/config.in	Tue Jun 12 04:15:27 2001
+++ linux-2.4.19-pre1-j64-dbg/arch/sparc/config.in	Tue Feb 26 16:39:02 2002
@@ -265,4 +265,5 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

