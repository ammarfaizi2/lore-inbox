Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbTBPB2E>; Sat, 15 Feb 2003 20:28:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTBPB2E>; Sat, 15 Feb 2003 20:28:04 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:53994 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S265140AbTBPB17>; Sat, 15 Feb 2003 20:27:59 -0500
Date: Sun, 16 Feb 2003 02:37:54 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: lkml <linux-kernel@vger.kernel.org>
cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: [PATCH] make jiffies wrap 5 min after boot
In-Reply-To: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> | There is a better solution to ensure correct jiffy wrap handling in
> | *ALL* kernel code: make jiffy wrap in first five minutes of uptime.
> | Tim has a patch for such config option. This is almost right.
> | This MUST NOT be a config option, it MUST be mandatory in every
> | kernel. Driver writers would be bitten by their own bugs and will
> | fix it themself. Tim, what do you think?
>
> I like it too.  We should take advantage of easy-to-force/find/fix
> problems like this.


Ok, I've forward-ported the patch to 2.5. Since 2.5 isn't supposed to be
stable anyways, I made it unconditional.
Note that it is completely transparent to the user.

Tim


--- linux-2.5.61/include/linux/time.h	Sat Feb 15 11:53:48 2003
+++ linux-2.5.61-jdbg/include/linux/time.h	Sun Feb 16 01:42:26 2003
@@ -28,6 +28,12 @@
 #include <linux/seqlock.h>

 /*
+ * Have the 32 bit jiffies value wrap 5 minutes after boot
+ * so jiffies wrap bugs show up earlier.
+ */
+#define INITIAL_JIFFIES (0xffffffffUL & (unsigned long)(-300*HZ))
+
+/*
  * Change timeval to jiffies, trying to avoid the
  * most obvious overflows..
  *

--- linux-2.5.61/kernel/timer.c	Sat Feb 15 11:53:49 2003
+++ linux-2.5.61-jdbg/kernel/timer.c	Sun Feb 16 02:05:38 2003
@@ -755,7 +755,7 @@
 }

 /* jiffies at the most recent update of wall time */
-unsigned long wall_jiffies;
+unsigned long wall_jiffies = INITIAL_JIFFIES;

 /*
  * This read-write spinlock protects us from races in SMP while
@@ -1098,7 +1098,7 @@
 	do {
 		seq = read_seqbegin(&xtime_lock);

-		uptime = jiffies_64;
+		uptime = jiffies_64 - INITIAL_JIFFIES;
 		do_div(uptime, HZ);
 		val.uptime = (unsigned long) uptime;

@@ -1174,6 +1174,13 @@
 	}
 	for (j = 0; j < TVR_SIZE; j++)
 		INIT_LIST_HEAD(base->tv1.vec + j);
+
+	base->timer_jiffies = INITIAL_JIFFIES;
+	base->tv1.index = INITIAL_JIFFIES & TVR_MASK;
+	base->tv2.index = (INITIAL_JIFFIES >> TVR_BITS) & TVN_MASK;
+	base->tv3.index = (INITIAL_JIFFIES >> (TVR_BITS+TVN_BITS)) & TVN_MASK;
+	base->tv4.index = (INITIAL_JIFFIES >> (TVR_BITS+2*TVN_BITS)) & TVN_MASK;
+	base->tv5.index = (INITIAL_JIFFIES >> (TVR_BITS+3*TVN_BITS)) & TVN_MASK;
 }

 static int __devinit timer_cpu_notify(struct notifier_block *self,

--- linux-2.5.61/fs/proc/array.c	Sat Feb 15 11:54:54 2003
+++ linux-2.5.61-jdbg/fs/proc/array.c	Sun Feb 16 01:58:26 2003
@@ -327,7 +327,8 @@
 		nice,
 		0UL /* removed */,
 		jiffies_to_clock_t(task->it_real_value),
-		(unsigned long long) jiffies_64_to_clock_t(task->start_time),
+		(unsigned long long)
+		    jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES),
 		vsize,
 		mm ? mm->rss : 0, /* you might want to shift this left 3 */
 		task->rlim[RLIMIT_RSS].rlim_cur,

--- linux-2.5.61/fs/proc/proc_misc.c	Sat Feb 15 11:53:47 2003
+++ linux-2.5.61-jdbg/fs/proc/proc_misc.c	Sun Feb 16 02:01:17 2003
@@ -104,7 +104,7 @@
 	unsigned long uptime_remainder;
 	int len;

-	uptime = get_jiffies_64();
+	uptime = get_jiffies_64() - INITIAL_JIFFIES;
 	uptime_remainder = (unsigned long) do_div(uptime, HZ);

 #if HZ!=100
@@ -320,7 +320,7 @@
 {
 	int i, len;
 	extern unsigned long total_forks;
-	u64 jif = get_jiffies_64();
+	u64 jif = get_jiffies_64() - INITIAL_JIFFIES;
 	unsigned int sum = 0, user = 0, nice = 0, system = 0, idle = 0, iowait = 0;

 	for (i = 0 ; i < NR_CPUS; i++) {

--- linux-2.5.61/arch/alpha/kernel/time.c	Sat Feb 15 11:53:34 2003
+++ linux-2.5.61-jdbg/arch/alpha/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -50,7 +50,7 @@
 #include "proto.h"
 #include "irq_impl.h"

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 extern unsigned long wall_jiffies;	/* kernel/timer.c */


--- linux-2.5.61/arch/arm/kernel/time.c	Sat Feb 15 11:53:34 2003
+++ linux-2.5.61-jdbg/arch/arm/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -32,7 +32,7 @@
 #include <asm/irq.h>
 #include <asm/leds.h>

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 extern unsigned long wall_jiffies;


--- linux-2.5.61/arch/cris/kernel/time.c	Fri Jan 17 03:22:16 2003
+++ linux-2.5.61-jdbg/arch/cris/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -45,7 +45,7 @@

 #include <asm/svinto.h>

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 static int have_rtc;  /* used to remember if we have an RTC or not */


--- linux-2.5.61/arch/i386/kernel/time.c	Sat Feb 15 11:53:34 2003
+++ linux-2.5.61-jdbg/arch/i386/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -66,7 +66,7 @@

 #include "do_timer.h"

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 unsigned long cpu_khz;	/* Detected as we calibrate the TSC */


--- linux-2.5.61/arch/ia64/kernel/time.c	Sat Feb 15 11:53:35 2003
+++ linux-2.5.61-jdbg/arch/ia64/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -27,7 +27,7 @@
 extern unsigned long wall_jiffies;
 extern unsigned long last_time_offset;

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 #ifdef CONFIG_IA64_DEBUG_IRQ


--- linux-2.5.61/arch/m68k/kernel/time.c	Sat Feb 15 11:53:35 2003
+++ linux-2.5.61-jdbg/arch/m68k/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -26,7 +26,7 @@
 #include <linux/timex.h>
 #include <linux/profile.h>

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 static inline int set_rtc_mmss(unsigned long nowtime)
 {

--- linux-2.5.61/arch/m68knommu/kernel/time.c	Sat Feb 15 11:53:35 2003
+++ linux-2.5.61-jdbg/arch/m68knommu/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -26,7 +26,7 @@

 #define	TICK_SIZE (tick_nsec / 1000)

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 static inline int set_rtc_mmss(unsigned long nowtime)
 {

--- linux-2.5.61/arch/mips/kernel/time.c	Sat Feb 15 11:53:35 2003
+++ linux-2.5.61-jdbg/arch/mips/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -32,7 +32,7 @@
 #define USECS_PER_JIFFY (1000000/HZ)
 #define USECS_PER_JIFFY_FRAC ((1000000ULL << 32) / HZ & 0xffffffff)

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 /*
  * forward reference

--- linux-2.5.61/arch/parisc/kernel/time.c	Sat Feb 15 11:53:35 2003
+++ linux-2.5.61-jdbg/arch/parisc/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -32,7 +32,7 @@

 #include <linux/timex.h>

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 /* xtime and wall_jiffies keep wall-clock time */
 extern unsigned long wall_jiffies;

--- linux-2.5.61/arch/ppc/kernel/time.c	Sat Feb 15 11:53:35 2003
+++ linux-2.5.61-jdbg/arch/ppc/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -68,7 +68,7 @@
 #include <asm/time.h>

 /* XXX false sharing with below? */
-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 unsigned long disarm_decr[NR_CPUS];


--- linux-2.5.61/arch/ppc64/kernel/time.c	Sat Feb 15 11:53:36 2003
+++ linux-2.5.61-jdbg/arch/ppc64/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -65,7 +65,7 @@

 void smp_local_timer_interrupt(struct pt_regs *);

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 /* keep track of when we need to update the rtc */
 time_t last_rtc_update;

--- linux-2.5.61/arch/s390/kernel/time.c	Sat Feb 15 11:53:36 2003
+++ linux-2.5.61-jdbg/arch/s390/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -46,7 +46,7 @@

 #define TICK_SIZE tick

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 static ext_int_info_t ext_int_info_timer;
 static uint64_t xtime_cc;

--- linux-2.5.61/arch/s390x/kernel/time.c	Sat Feb 15 11:53:36 2003
+++ linux-2.5.61-jdbg/arch/s390x/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -45,7 +45,7 @@

 #define TICK_SIZE tick

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 static ext_int_info_t ext_int_info_timer;
 static uint64_t xtime_cc;

--- linux-2.5.61/arch/sh/kernel/time.c	Sat Feb 15 11:53:36 2003
+++ linux-2.5.61-jdbg/arch/sh/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -70,7 +70,7 @@
 #endif /* CONFIG_CPU_SUBTYPE_ST40STB1 */
 #endif /* __sh3__ or __SH4__ */

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 extern unsigned long wall_jiffies;
 #define TICK_SIZE tick

--- linux-2.5.61/arch/sparc/kernel/time.c	Sat Feb 15 11:53:36 2003
+++ linux-2.5.61-jdbg/arch/sparc/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -45,7 +45,7 @@

 extern unsigned long wall_jiffies;

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 enum sparc_clock_type sp_clock_typ;
 spinlock_t mostek_lock = SPIN_LOCK_UNLOCKED;

--- linux-2.5.61/arch/sparc64/kernel/time.c	Sat Feb 15 11:53:36 2003
+++ linux-2.5.61-jdbg/arch/sparc64/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -47,7 +47,7 @@

 extern unsigned long wall_jiffies;

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 static unsigned long mstk48t08_regs = 0UL;
 static unsigned long mstk48t59_regs = 0UL;

--- linux-2.5.61/arch/v850/kernel/time.c	Sat Feb 15 11:53:37 2003
+++ linux-2.5.61-jdbg/arch/v850/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -25,7 +25,7 @@

 #include "mach.h"

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 #define TICK_SIZE	(tick_nsec / 1000)


--- linux-2.5.61/arch/x86_64/kernel/time.c	Sat Feb 15 11:54:51 2003
+++ linux-2.5.61-jdbg/arch/x86_64/kernel/time.c	Sun Feb 16 01:42:26 2003
@@ -30,7 +30,7 @@
 #include <asm/apic.h>
 #endif

-u64 jiffies_64;
+u64 jiffies_64 = INITIAL_JIFFIES;

 extern int using_apic_timer;



