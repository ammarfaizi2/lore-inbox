Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267094AbTBQNp7>; Mon, 17 Feb 2003 08:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267107AbTBQNp7>; Mon, 17 Feb 2003 08:45:59 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:22476 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S267094AbTBQNpn>; Mon, 17 Feb 2003 08:45:43 -0500
Date: Mon, 17 Feb 2003 14:55:05 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
Message-ID: <20030217135505.GF6282@wohnheim.fh-wedel.de>
References: <20030204092936.GA14495@wohnheim.fh-wedel.de> <Pine.LNX.4.33.0302041401010.1267-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.33.0302041401010.1267-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 February 2003 14:04:38 +0100, Tim Schmielau wrote:
> 
> A patch for 2.4.20-pre7 (and maybe later) is at
>   http://www.physik3.uni-rostock.de/tim/kernel/2.4/

Some of the architectures appear to be untested. This fixes arm and
beautifies m68k.
( At least, I hope so. I didn't test it either :)

Tim, is the inline patch fine with you?

Jörn

-- 
There's nothing better for promoting creativity in a medium than
making an audience feel "Hmm ­ I could do better than that!"
-- Douglas Adams in a slashdot interview

--- linux-2.4.20-pre7-j64/include/linux/timex.h	Thu Nov 22 20:46:18 2001
+++ linux-2.4.20-pre7-j64-dbg/include/linux/timex.h	Wed Sep 25 19:11:51 2002
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

--- linux-2.4.20-pre7-j64/kernel/timer.c	Wed Sep 25 18:38:36 2002
+++ linux-2.4.20-pre7-j64-dbg/kernel/timer.c	Wed Sep 25 19:11:51 2002
@@ -65,9 +65,10 @@
 
 extern int do_setitimer(int, struct itimerval *, struct itimerval *);
 
-unsigned long volatile jiffies;
+unsigned long volatile jiffies = INITIAL_JIFFIES;
 #ifdef NEEDS_JIFFIES_64
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
@@ -668,7 +680,7 @@
 }
 
 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;
 
 /*
  * This spinlock protect us from races in SMP while playing with xtime. -arca

--- linux-2.4.20-pre7-j64/fs/proc/array.c	Wed Sep 25 18:38:36 2002
+++ linux-2.4.20-pre7-j64-dbg/fs/proc/array.c	Wed Sep 25 19:11:51 2002
@@ -369,7 +369,7 @@
 		nice,
 		0UL /* removed */,
 		task->it_real_value,
-		(unsigned long long)(task->start_time),
+		(unsigned long long)(task->start_time) - INITIAL_JIFFIES,
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.4.20-pre7-j64/fs/proc/proc_misc.c	Wed Sep 25 18:53:38 2002
+++ linux-2.4.20-pre7-j64-dbg/fs/proc/proc_misc.c	Wed Sep 25 19:11:51 2002
@@ -208,7 +208,7 @@
 	unsigned long uptime_remainder, idle_remainder;
 	int len;
 
-	uptime = get_jiffies_64();
+	uptime = get_jiffies_64() - INITIAL_JIFFIES;
 	uptime_remainder = (unsigned long) do_div(uptime, HZ);
 	idle = get_sidle_64() + get_uidle_64();
 	idle_remainder = (unsigned long) do_div(idle, HZ);
@@ -386,7 +386,8 @@
 	int i, len = 0;
 	extern unsigned long total_forks;
 	unsigned int sum = 0;
-	u64 jif = get_jiffies_64(), user = 0, nice = 0, system = 0;
+	u64 jif = get_jiffies_64() - INITIAL_JIFFIES;
+	u64 user = 0, nice = 0, system = 0;
 	int major, disk;
 
 	for (i = 0 ; i < smp_num_cpus; i++) {

--- linux-2.4.20-pre7-j64/kernel/info.c	Wed Sep 25 18:38:36 2002
+++ linux-2.4.20-pre7-j64-dbg/kernel/info.c	Wed Sep 25 19:11:51 2002
@@ -22,7 +22,7 @@
 	memset((char *)&val, 0, sizeof(struct sysinfo));
 
 	cli();
-	uptime = get_jiffies_64();
+	uptime = get_jiffies_64() - INITIAL_JIFFIES;
 	do_div(uptime, HZ);
 	val.uptime = (unsigned long) uptime;
 

--- linux-2.4.20-pre7-j64/Documentation/Configure.help	Wed Sep 25 18:33:43 2002
+++ linux-2.4.20-pre7-j64-dbg/Documentation/Configure.help	Wed Sep 25 19:11:51 2002
@@ -25244,6 +25244,14 @@
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

--- linux-2.4.20-pre7-j64/arch/arm/config.in	Wed Sep 25 18:33:43 2002
+++ linux-2.4.20-pre7-j64-dbg/arch/arm/config.in	Wed Sep 25 19:11:51 2002
@@ -649,6 +649,7 @@
 dep_bool '  Morse code panics' CONFIG_PANIC_MORSE $CONFIG_DEBUG_KERNEL $CONFIG_PC_KEYB
 dep_bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK $CONFIG_DEBUG_KERNEL
 dep_bool '  Wait queue debugging' CONFIG_DEBUG_WAITQ $CONFIG_DEBUG_KERNEL
+dep_bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP $CONFIG_DEBUG_KERNEL
 dep_bool '  Verbose BUG() reporting (adds 70K)' CONFIG_DEBUG_BUGVERBOSE $CONFIG_DEBUG_KERNEL
 dep_bool '  Verbose kernel error messages' CONFIG_DEBUG_ERRORS $CONFIG_DEBUG_KERNEL
 # These options are only for real kernel hackers who want to get their hands dirty. 
--- linux-2.4.20-pre7-j64/arch/cris/config.in	Wed Sep 25 18:33:43 2002
+++ linux-2.4.20-pre7-j64-dbg/arch/cris/config.in	Wed Sep 25 19:11:51 2002
@@ -243,6 +243,7 @@
 if [ "$CONFIG_SOUND" != "n" ]; then
   source drivers/sound/Config.in
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 
 source drivers/usb/Config.in

--- linux-2.4.20-pre7-j64/arch/i386/config.in	Wed Sep 25 18:33:43 2002
+++ linux-2.4.20-pre7-j64-dbg/arch/i386/config.in	Wed Sep 25 19:11:51 2002
@@ -451,6 +451,7 @@
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Compile the kernel with frame pointers' CONFIG_FRAME_POINTER
+   bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 fi
 
 endmenu

--- linux-2.4.20-pre7-j64/arch/m68k/config.in	Wed Sep 25 18:33:43 2002
+++ linux-2.4.20-pre7-j64-dbg/arch/m68k/config.in	Wed Sep 25 19:11:51 2002
@@ -552,6 +552,7 @@
 if [ "$CONFIG_DEBUG_KERNEL" != "n" ]; then
    bool '  Magic SysRq key' CONFIG_MAGIC_SYSRQ
    bool '  Debug memory allocations' CONFIG_DEBUG_SLAB
+   bool '  Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
    bool '  Verbose BUG() reporting' CONFIG_DEBUG_BUGVERBOSE
 fi
 

--- linux-2.4.20-pre7/arch/mips/config-shared.in	Wed Sep 25 19:27:11 2002
+++ linux-2.4.20-pre7-j64/arch/mips/config-shared.in	Wed Sep 25 19:15:30 2002
@@ -798,6 +798,7 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+dep_bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP $CONFIG_MIPS32 
 endmenu
 
 source lib/Config.in

--- linux-2.4.20-pre7-j64/arch/parisc/config.in	Wed Sep 25 18:33:45 2002
+++ linux-2.4.20-pre7-j64-dbg/arch/parisc/config.in	Wed Sep 25 19:11:51 2002
@@ -194,6 +194,7 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 
 source lib/Config.in

--- linux-2.4.20-pre7-j64/arch/ppc/config.in	Wed Sep 25 18:33:45 2002
+++ linux-2.4.20-pre7-j64-dbg/arch/ppc/config.in	Wed Sep 25 19:17:13 2002
@@ -423,5 +423,6 @@
       string '    Additional compile arguments' CONFIG_COMPILE_OPTIONS "-g -ggdb"
     fi
   fi
+  bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 fi
 endmenu

--- linux-2.4.20-pre7-j64/arch/sh/config.in	Wed Sep 25 18:33:46 2002
+++ linux-2.4.20-pre7-j64-dbg/arch/sh/config.in	Wed Sep 25 19:11:51 2002
@@ -385,6 +385,7 @@
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 
 source lib/Config.in

--- linux-2.4.20-pre7-j64/arch/sparc/config.in	Wed Sep 25 18:33:47 2002
+++ linux-2.4.20-pre7-j64-dbg/arch/sparc/config.in	Wed Sep 25 19:11:51 2002
@@ -265,6 +265,7 @@
 comment 'Kernel hacking'
 
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+bool 'Debug jiffies counter wraparound (DANGEROUS)' CONFIG_DEBUG_JIFFIESWRAP
 endmenu
 
 source lib/Config.in
