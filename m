Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262141AbSJJT0S>; Thu, 10 Oct 2002 15:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262143AbSJJT0S>; Thu, 10 Oct 2002 15:26:18 -0400
Received: from 12-231-242-11.client.attbi.com ([12.231.242.11]:5134 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262141AbSJJT0P>;
	Thu, 10 Oct 2002 15:26:15 -0400
Date: Thu, 10 Oct 2002 12:27:55 -0700
From: Greg KH <greg@kroah.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: [PATCH] minor i386 timer changes for 2.5.41
Message-ID: <20021010192754.GC25949@kroah.com>
References: <Pine.LNX.4.44.0210101132300.4124-100000@penguin.transmeta.com> <Pine.LNX.4.44.0210101137310.4124-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210101137310.4124-100000@penguin.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 11:38:29AM -0700, Linus Torvalds wrote:
> 
> I ended up just importing it from the patches I had pending anyway. 
> Including the Cyclone code, although I removed the Config.in entry to make 
> sure nobody even tries to enable it until the rest of the summit code is 
> there.

Thanks for doing this.

Here's a patch against your latest bk tree, that contains the cleanups I
did to John's patches.  It does the following:
	- removes a few compiler warnings from time.c
	- uses C99 initializers
	- makes the timer list static
	- adds better documentation to the timer function structure
	- makes the timer init function return 0 on success
	- NULL terminates the list of timers to make further patches
	  easier.

I can put this in a bk tree for you to pull, but I thought a simple
patch would be easier.

thanks,

greg k-h



diff -Naur -X ../dontdiff timer2-2.5/arch/i386/kernel/time.c timer-2.5/arch/i386/kernel/time.c
--- timer2-2.5/arch/i386/kernel/time.c	Thu Oct 10 12:06:27 2002
+++ timer-2.5/arch/i386/kernel/time.c	Thu Oct 10 08:59:22 2002
@@ -268,8 +268,6 @@
 #endif
 }
 
-static int use_tsc;
-
 /*
  * This is the same as the above, except we _also_ save the current
  * Time Stamp Counter value at the time of the timer interrupt, so that
@@ -277,8 +275,6 @@
  */
 void timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
-	int count;
-
 	/*
 	 * Here we are in the timer irq handler. We just have irqs locally
 	 * disabled but we don't know if the timer_bh is running on the other
diff -Naur -X ../dontdiff timer2-2.5/arch/i386/kernel/timers/timer.c timer-2.5/arch/i386/kernel/timers/timer.c
--- timer2-2.5/arch/i386/kernel/timers/timer.c	Thu Oct 10 12:06:28 2002
+++ timer-2.5/arch/i386/kernel/timers/timer.c	Thu Oct 10 08:59:23 2002
@@ -2,31 +2,34 @@
 #include <asm/timer.h>
 
 /* list of externed timers */
-#ifndef CONFIG_X86_TSC
 extern struct timer_opts timer_pit;
-#endif
 extern struct timer_opts timer_tsc;
 
-/* list of timers, ordered by preference */
-struct timer_opts* timers[] = {
-	&timer_tsc
+/* list of timers, ordered by preference, NULL terminated */
+static struct timer_opts* timers[] = {
+	&timer_tsc,
 #ifndef CONFIG_X86_TSC
-	,&timer_pit
+	&timer_pit,
 #endif
+	NULL,
 };
 
-#define NR_TIMERS (sizeof(timers)/sizeof(timers[0]))
 
 /* iterates through the list of timers, returning the first 
  * one that initializes successfully.
  */
 struct timer_opts* select_timer(void)
 {
-	int i;
+	int i = 0;
+	
 	/* find most preferred working timer */
-	for(i=0; i < NR_TIMERS; i++)
-		if(timers[i]->init())
-			return timers[i];
+	while (timers[i]) {
+		if (timers[i]->init)
+			if (timers[i]->init() == 0)
+				return timers[i];
+		++i;
+	}
+		
 	panic("select_timer: Cannot find a suitable timer\n");
-	return 0;
+	return NULL;
 }
diff -Naur -X ../dontdiff timer2-2.5/arch/i386/kernel/timers/timer_pit.c timer-2.5/arch/i386/kernel/timers/timer_pit.c
--- timer2-2.5/arch/i386/kernel/timers/timer_pit.c	Thu Oct 10 12:06:28 2002
+++ timer-2.5/arch/i386/kernel/timers/timer_pit.c	Thu Oct 10 08:59:23 2002
@@ -15,7 +15,7 @@
 
 static int init_pit(void)
 {
-	return 1;
+	return 0;
 }
 
 static void mark_offset_pit(void)
@@ -122,7 +122,7 @@
 
 /* tsc timer_opts struct */
 struct timer_opts timer_pit = {
-	init: init_pit, 
-	mark_offset: mark_offset_pit, 
-	get_offset: get_offset_pit
+	.init =		init_pit, 
+	.mark_offset =	mark_offset_pit, 
+	.get_offset =	get_offset_pit,
 };
diff -Naur -X ../dontdiff timer2-2.5/arch/i386/kernel/timers/timer_tsc.c timer-2.5/arch/i386/kernel/timers/timer_tsc.c
--- timer2-2.5/arch/i386/kernel/timers/timer_tsc.c	Thu Oct 10 12:06:28 2002
+++ timer-2.5/arch/i386/kernel/timers/timer_tsc.c	Thu Oct 10 08:59:23 2002
@@ -6,6 +6,7 @@
 #include <linux/spinlock.h>
 #include <linux/init.h>
 #include <linux/timex.h>
+#include <linux/errno.h>
 
 #include <asm/timer.h>
 #include <asm/io.h>
@@ -263,17 +264,17 @@
 #ifdef CONFIG_CPU_FREQ
 			cpufreq_register_notifier(&time_cpufreq_notifier_block, CPUFREQ_TRANSITION_NOTIFIER);
 #endif
-			return 1;
+			return 0;
 		}
 	}
-	return 0;
+	return -ENODEV;
 }
 
 /************************************************************/
 
 /* tsc timer_opts struct */
 struct timer_opts timer_tsc = {
-	init: init_tsc, 
-	mark_offset: mark_offset_tsc, 
-	get_offset: get_offset_tsc
+	.init =		init_tsc,
+	.mark_offset =	mark_offset_tsc, 
+	.get_offset =	get_offset_tsc,
 };
diff -Naur -X ../dontdiff timer2-2.5/include/asm-i386/timer.h timer-2.5/include/asm-i386/timer.h
--- timer2-2.5/include/asm-i386/timer.h	Thu Oct 10 12:07:43 2002
+++ timer-2.5/include/asm-i386/timer.h	Thu Oct 10 09:00:17 2002
@@ -1,14 +1,22 @@
 #ifndef _ASMi386_TIMER_H
 #define _ASMi386_TIMER_H
 
+/**
+ * struct timer_ops - used to define a timer source
+ *
+ * @init: Probes and initializes the timer.  Returns 0 on success, anything
+ *	else on failure.
+ * @mark_offset: called by the timer interrupt
+ * @get_offset: called by gettimeofday().  Returns the number of ms since the
+ *	last timer intruupt.
+ */
 struct timer_opts{
-	/* probes and initializes timer. returns 1 on sucess, 0 on failure */
 	int (*init)(void);
-	/* called by the timer interrupt */
 	void (*mark_offset)(void);
-	/* called by gettimeofday. returns # ms since the last timer interrupt */
 	unsigned long (*get_offset)(void);
 };
+
 #define TICK_SIZE (tick_nsec / 1000)
-struct timer_opts* select_timer(void);
+
+extern struct timer_opts* select_timer(void);
 #endif
