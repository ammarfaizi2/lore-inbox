Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314674AbSEKKbV>; Sat, 11 May 2002 06:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314672AbSEKKbU>; Sat, 11 May 2002 06:31:20 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:22277 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S314674AbSEKKav>; Sat, 11 May 2002 06:30:51 -0400
Date: Sat, 11 May 2002 12:30:47 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH] 6/6: debug option for pre-wrap jiffies value
Message-ID: <Pine.LNX.4.33.0205111229490.26626-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a debug option to move 32 bit jiffies wrap to 5 min. after boot.
This should help catching the remaining bugs at wraparound (unsigned
compares of jiffies in drivers etc.).


--- linux-2.5.15-j64/include/linux/timex.h	Fri May 10 22:48:25 2002
+++ linux-2.5.15-j64-dbg/include/linux/timex.h	Sat May 11 10:13:05 2002
@@ -54,6 +54,13 @@
 #include <linux/time.h>
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

--- linux-2.5.15-j64/kernel/timer.c	Fri May 10 22:45:12 2002
+++ linux-2.5.15-j64-dbg/kernel/timer.c	Sat May 11 10:13:05 2002
@@ -67,9 +67,10 @@
 
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
-unsigned long volatile jiffies;
+unsigned long volatile jiffies = INITIAL_JIFFIES;
 #ifdef NEEDS_JIFFIES64
-static unsigned int volatile jiffies_msb_flips;
+static unsigned int volatile
+	jiffies_msb_flips = INITIAL_JIFFIES>>(BITS_PER_LONG-1);
 #endif
 
 unsigned int * prof_buffer;
@@ -123,10 +124,21 @@
 	for (i = 0; i < TVR_SIZE; i++)
 		INIT_LIST_HEAD(tv1.vec + i);
 
+#ifdef CONFIG_DEBUG_JIFFIESWRAP
+	tv1.index = INITIAL_JIFFIES & TVR_MASK;
+	tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
+	tv3.index = (INITIAL_JIFFIES >> (TVR_BITS + TVN_BITS)) & TVN_MASK;
+	tv4.index = (INITIAL_JIFFIES >> (TVR_BITS + 2*TVN_BITS)) & TVN_MASK;
+	tv5.index = (INITIAL_JIFFIES >> (TVR_BITS + 3*TVN_BITS)) & TVN_MASK;
+
+	printk(KERN_NOTICE "Set up jiffies counter to wrap in %ld seconds.\n",
+	       (-(long)jiffies)/HZ);
+#endif
+
 	init_jiffieswrap_timer();
 }
 
-static unsigned long timer_jiffies;
+static unsigned long timer_jiffies = INITIAL_JIFFIES;
 
 static inline void internal_add_timer(struct timer_list *timer)
 {
@@ -636,7 +648,7 @@
 }
 
 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;
 
 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca

--- linux-2.5.15-j64/fs/proc/array.c	Fri May 10 22:45:12 2002
+++ linux-2.5.15-j64-dbg/fs/proc/array.c	Sat May 11 10:13:05 2002
@@ -368,7 +368,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		(unsigned long long)(task->start_time),
+		(unsigned long long)(task->start_time) - INITIAL_JIFFIES,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.5.15-j64/fs/proc/proc_misc.c	Fri May 10 22:45:12 2002
+++ linux-2.5.15-j64-dbg/fs/proc/proc_misc.c	Sat May 11 10:42:40 2002
@@ -184,7 +184,7 @@
 	unsigned long uptime_remainder, idle_remainder;
 	int len;
 
-	uptime = get_jiffies64();
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
 	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 	idle = get_sidle64() + get_uidle64();
 	idle_remainder = (unsigned long) do_div(idle, HZ);
@@ -362,7 +362,8 @@
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned int sum = 0;
-	u64 jif = get_jiffies64(), user = 0, nice = 0, system = 0;
+	u64 jif = get_jiffies64() - INITIAL_JIFFIES;
+	u64 user = 0, nice = 0, system = 0;
 	int major, disk;
 
 	for (i = 0 ; i < smp_num_cpus; i++) {
@@ -435,7 +436,7 @@
 		"btime %lu\n"
 		"processes %lu\n",
 		nr_context_switches(),
-		xtime.tv_sec - (unsigned long) jif,
+		xtime.tv_sec - (unsigned long) jif + INITIAL_JIFFIES,
 		total_forks);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);

--- linux-2.5.15-j64/kernel/info.c	Fri May 10 22:45:12 2002
+++ linux-2.5.15-j64-dbg/kernel/info.c	Sat May 11 10:13:05 2002
@@ -22,7 +22,7 @@
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	cli();
-	uptime = get_jiffies64();
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
 	do_div(uptime, HZ);
 	val.uptime = (unsigned long) uptime;
 

--- linux-2.5.15-j64/arch/arm/Config.help	Sun May  5 08:29:48 2002
+++ linux-2.5.15-j64-dbg/arch/arm/Config.help	Sat May 11 10:29:57 2002
@@ -986,3 +986,10 @@
   address map changes required to support booting in this mode.
 
   You almost surely want to say N here.
+
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.

--- linux-2.5.15-j64/arch/arm/config.in	Thu May  9 17:47:13 2002
+++ linux-2.5.15-j64-dbg/arch/arm/config.in	Sat May 11 10:29:12 2002
@@ -671,6 +671,7 @@
 dep_bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ $CONFIG_DEBUG_KERNEL
 dep_bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK $CONFIG_DEBUG_KERNEL
 dep_bool '  Wait queue debugging' CONFIG_DEBUG_WAITQ $CONFIG_DEBUG_KERNEL
+dep_bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 dep_bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE $CONFIG_DEBUG_KERNEL
 dep_bool '  Verbose kernel error messages' CONFIG_DEBUG_ERRORS $CONFIG_DEBUG_KERNEL
 # These options are only for real kernel hackers who want to get their hands dirty. 

--- linux-2.5.15-j64/arch/cris/Config.help	Sun May  5 08:29:48 2002
+++ linux-2.5.15-j64-dbg/arch/cris/Config.help	Sat May 11 10:30:55 2002
@@ -415,3 +415,10 @@
   By enabling this you make sure that the watchdog does not bite while
   printing oopses. Recommended for development systems but not for
   production releases.
+
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.

--- linux-2.5.15-j64/arch/cris/config.in	Sun May  5 08:29:48 2002
+++ linux-2.5.15-j64-dbg/arch/cris/config.in	Sat May 11 10:30:55 2002
@@ -224,6 +224,7 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Kernel profiling support' CONFIG_PROFILE
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 if [ "$CONFIG_PROFILE" = "y" ]; then
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi

--- linux-2.5.15-j64/arch/i386/Config.help	Sun May  5 08:30:35 2002
+++ linux-2.5.15-j64-dbg/arch/i386/Config.help	Sat May 11 10:32:57 2002
@@ -932,6 +932,13 @@
   best used in conjunction with the NMI watchdog so that spinlock
   deadlocks are also debuggable.
 
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.
+
 CONFIG_DEBUG_BUGVERBOSE
   Say Y here to make BUG() panics output the file name and line number
   of the BUG call as well as the EIP and oops trace.  This aids

--- linux-2.5.15-j64/arch/i386/config.in	Thu May  9 17:47:13 2002
+++ linux-2.5.15-j64-dbg/arch/i386/config.in	Sat May 11 10:33:01 2002
@@ -403,6 +403,7 @@
    bool '  Memory mapped I/O debugging' CONFIG_DEBUG_IOVIRT
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
+   bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
    if [ "$CONFIG_HIGHMEM" = "y" ]; then
       bool '  Highmem debugging' CONFIG_DEBUG_HIGHMEM
    fi

--- linux-2.5.15-j64/arch/m68k/Config.help	Mon Mar 18 21:37:19 2002
+++ linux-2.5.15-j64-dbg/arch/m68k/Config.help	Sat May 11 10:34:23 2002
@@ -1689,3 +1689,10 @@
   boards from BVM Ltd.  Everyone using one of these boards should say
   Y here.
 
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.
+

--- linux-2.5.15-j64/arch/m68k/config.in	Fri May 10 19:42:11 2002
+++ linux-2.5.15-j64-dbg/arch/m68k/config.in	Sat May 11 10:33:21 2002
@@ -544,6 +544,7 @@
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
+   bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
    bool '  Verbose BUG() reporting' CONFIG_DEBUG_BUGVERBOSE
 fi
 

--- linux-2.5.15-j64/arch/mips/Config.help	Mon Mar 18 21:37:16 2002
+++ linux-2.5.15-j64-dbg/arch/mips/Config.help	Sat May 11 10:35:19 2002
@@ -876,3 +876,10 @@
   would like kernel messages to be formatted into GDB $O packets so
   that GDB prints them as program output, say 'Y'.
 
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.
+

--- linux-2.5.15-j64/arch/mips/config.in	Sun May  5 08:29:49 2002
+++ linux-2.5.15-j64-dbg/arch/mips/config.in	Sat May 11 10:16:48 2002
@@ -501,6 +501,7 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 
 source lib/Config.in

--- linux-2.5.15-j64/arch/parisc/Config.help	Mon Mar 18 21:37:12 2002
+++ linux-2.5.15-j64-dbg/arch/parisc/Config.help	Sat May 11 10:36:07 2002
@@ -526,3 +526,10 @@
   hardware integrated in the LASI-Controller (on the GSC Bus) for
   HP-PARISC workstations.
 
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.
+

--- linux-2.5.15-j64/arch/parisc/config.in	Mon Mar 18 21:37:15 2002
+++ linux-2.5.15-j64-dbg/arch/parisc/config.in	Sat May 11 10:16:48 2002
@@ -198,6 +198,7 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 
 source lib/Config.in

--- linux-2.5.15-j64/arch/ppc/Config.help	Fri May 10 19:42:12 2002
+++ linux-2.5.15-j64-dbg/arch/ppc/Config.help	Sat May 11 10:36:54 2002
@@ -1016,3 +1016,10 @@
   which has a small amount of memory.
 
   Say N here unless you know what you are doing.
+
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.

--- linux-2.5.15-j64/arch/ppc/config.in	Fri May 10 19:42:12 2002
+++ linux-2.5.15-j64-dbg/arch/ppc/config.in	Sat May 11 10:20:19 2002
@@ -598,6 +598,7 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 if [ "$CONFIG_KGDB" = "y" ]; then
    choice 'Serial Port'			\

--- linux-2.5.15-j64/arch/sh/config.in	Mon Mar 18 21:37:15 2002
+++ linux-2.5.15-j64-dbg/arch/sh/config.in	Sat May 11 10:16:48 2002
@@ -367,6 +367,7 @@
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 
 source lib/Config.in

--- linux-2.5.15-j64/arch/sparc/Config.help	Sun May  5 08:32:00 2002
+++ linux-2.5.15-j64-dbg/arch/sparc/Config.help	Sat May 11 10:38:07 2002
@@ -1114,3 +1114,10 @@
   <http://sourceforge.net/projects/linuxconsole/> for details on the
   latter.
 
+CONFIG_DEBUG_JIFFIESWRAP
+  Say Y here to initialize the jiffies counter to a value 5 minutes
+  before wraparound. This may make your system UNSTABLE and its
+  only use is to hunt down the causes of this instability.
+  If you don't know what the jiffies counter is or if you want
+  a stable system, say N.
+

--- linux-2.5.15-j64/arch/sparc/config.in	Sun May  5 08:32:00 2002
+++ linux-2.5.15-j64-dbg/arch/sparc/config.in	Sat May 11 10:16:48 2002
@@ -240,6 +240,7 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 
 source lib/Config.in

