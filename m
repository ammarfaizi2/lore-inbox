Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313713AbSEEWCZ>; Sun, 5 May 2002 18:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313717AbSEEWCY>; Sun, 5 May 2002 18:02:24 -0400
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:61447 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S313713AbSEEWCU>; Sun, 5 May 2002 18:02:20 -0400
Date: Mon, 6 May 2002 00:02:20 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: <linux-kernel@vger.kernel.org>
cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Andreas Dilger <adilger@turbolabs.com>
Subject: [patch] enable uptime display > 497 days on 32 bit (2/2)
In-Reply-To: <Pine.LNX.4.33.0205052331330.19370-100000@gans.physik3.uni-rostock.de>
Message-ID: <Pine.LNX.4.33.0205060000230.19370-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A config option to move the jiffies wrap forward to 5 minutes after boot.
Should be applied on top of the 64 bit jiffies patch.

Tim


--- linux-2.4.19-pre8-j64/include/linux/timex.h	Sun May  5 19:11:11 2002
+++ linux-2.4.19-pre8-j64-dbg/include/linux/timex.h	Sun May  5 20:34:14 2002
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

--- linux-2.4.19-pre8-j64/kernel/timer.c	Sun May  5 19:28:22 2002
+++ linux-2.4.19-pre8-j64-dbg/kernel/timer.c	Sun May  5 20:35:28 2002
@@ -65,9 +65,10 @@
 
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
@@ -661,7 +673,7 @@
 }
 
 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;
 
 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca

--- linux-2.4.19-pre8-j64/fs/proc/array.c	Sat May  4 20:50:04 2002
+++ linux-2.4.19-pre8-j64-dbg/fs/proc/array.c	Sun May  5 20:34:14 2002
@@ -366,7 +366,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		(unsigned long long)(task->start_time),
+		(unsigned long long)(task->start_time) - INITIAL_JIFFIES,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.4.19-pre8-j64/fs/proc/proc_misc.c	Sun May  5 19:32:17 2002
+++ linux-2.4.19-pre8-j64-dbg/fs/proc/proc_misc.c	Sun May  5 20:37:45 2002
@@ -189,7 +189,7 @@
 	unsigned long uptime_remainder, idle_remainder;
 	int len;
 
-	uptime = get_jiffies64();
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
 	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 	idle = get_sidle64() + get_uidle64();
 	idle_remainder = (unsigned long) do_div(idle, HZ);
@@ -341,7 +341,8 @@
 	int i, len;
 	extern unsigned long total_forks;
 	unsigned int sum = 0;
-	u64 jif = get_jiffies64(), user = 0, nice = 0, system = 0;
+	u64 jif = get_jiffies64() - INITIAL_JIFFIES;
+	u64 user = 0, nice = 0, system = 0;
 	int major, disk;
 
 	for (i = 0 ; i < smp_num_cpus; i++) {

--- linux-2.4.19-pre8-j64/kernel/info.c	Sat May  4 20:50:04 2002
+++ linux-2.4.19-pre8-j64-dbg/kernel/info.c	Sun May  5 20:34:14 2002
@@ -22,7 +22,7 @@
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	cli();
-	uptime = get_jiffies64();
+	uptime = get_jiffies64() - INITIAL_JIFFIES;
 	do_div(uptime, HZ);
 	val.uptime = (unsigned long) uptime;
 

--- linux-2.4.19-pre8-j64/Documentation/Configure.help	Sat May  4 19:32:30 2002
+++ linux-2.4.19-pre8-j64-dbg/Documentation/Configure.help	Sun May  5 20:34:14 2002
@@ -24599,6 +24599,14 @@
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

--- linux-2.4.19-pre8-j64/arch/arm/config.in	Sat May  4 19:32:05 2002
+++ linux-2.4.19-pre8-j64-dbg/arch/arm/config.in	Sun May  5 20:40:28 2002
@@ -648,7 +648,7 @@
 dep_bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ $CONFIG_DEBUG_KERNEL
 dep_bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK $CONFIG_DEBUG_KERNEL
 dep_bool '  Wait queue debugging' CONFIG_DEBUG_WAITQ $CONFIG_DEBUG_KERNEL
-dep_bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE $CONFIG_DEBUG_KERNEL
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAPdep_bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE $CONFIG_DEBUG_KERNEL
 dep_bool '  Verbose kernel error messages' CONFIG_DEBUG_ERRORS $CONFIG_DEBUG_KERNEL
 # These options are only for real kernel hackers who want to get their hands dirty. 
 dep_bool '  Kernel low-level debugging functions' CONFIG_DEBUG_LL $CONFIG_DEBUG_KERNEL

--- linux-2.4.19-pre8-j64/arch/cris/config.in	Sun Feb 24 19:20:36 2002
+++ linux-2.4.19-pre8-j64-dbg/arch/cris/config.in	Sun May  5 20:34:14 2002
@@ -253,4 +253,5 @@
 if [ "$CONFIG_PROFILE" = "y" ]; then
   int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
diff -r -u --exclude-from dontdiff linux-2.4.19-pre8-j64/arch/i386/config.in linux-2.4.19-pre8-j64-dbg/arch/i386/config.in
--- linux-2.4.19-pre8-j64/arch/i386/config.in	Sat May  4 19:32:31 2002
+++ linux-2.4.19-pre8-j64-dbg/arch/i386/config.in	Sun May  5 20:41:49 2002
@@ -423,6 +423,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Compile the kernel with frame pointers' CONFIG_FRAME_POINTER
+   bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 fi
 
 endmenu

--- linux-2.4.19-pre8-j64/arch/m68k/config.in	Sat May  4 19:32:31 2002
+++ linux-2.4.19-pre8-j64-dbg/arch/m68k/config.in	Sun May  5 20:42:45 2002
@@ -561,6 +561,7 @@
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
+   bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
    bool '  Verbose BUG() reporting' CONFIG_DEBUG_BUGVERBOSE
 fi
 

--- linux-2.4.19-pre8-j64/arch/mips/config.in	Sat Mar 30 19:12:27 2002
+++ linux-2.4.19-pre8-j64-dbg/arch/mips/config.in	Sun May  5 20:34:14 2002
@@ -643,4 +643,5 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.19-pre8-j64/arch/parisc/config.in	Wed Apr 18 02:19:25 2001
+++ linux-2.4.19-pre8-j64-dbg/arch/parisc/config.in	Sun May  5 20:34:14 2002
@@ -206,5 +206,6 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 

--- linux-2.4.19-pre8-j64/arch/ppc/config.in	Sat May  4 19:32:05 2002
+++ linux-2.4.19-pre8-j64-dbg/arch/ppc/config.in	Sun May  5 20:34:14 2002
@@ -401,4 +401,5 @@
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Include kgdb kernel debugger' CONFIG_KGDB
 bool 'Include xmon kernel debugger' CONFIG_XMON
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.19-pre8-j64/arch/sh/config.in	Sun Feb 24 19:20:37 2002
+++ linux-2.4.19-pre8-j64-dbg/arch/sh/config.in	Sun May  5 20:34:14 2002
@@ -385,4 +385,5 @@
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu

--- linux-2.4.19-pre8-j64/arch/sparc/config.in	Sat May  4 19:32:31 2002
+++ linux-2.4.19-pre8-j64-dbg/arch/sparc/config.in	Sun May  5 20:34:14 2002
@@ -270,4 +270,5 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu


