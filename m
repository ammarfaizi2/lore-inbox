Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265711AbTAFC1D>; Sun, 5 Jan 2003 21:27:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAFC1D>; Sun, 5 Jan 2003 21:27:03 -0500
Received: from franka.aracnet.com ([216.99.193.44]:17100 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265711AbTAFC0y>; Sun, 5 Jan 2003 21:26:54 -0500
Date: Sun, 05 Jan 2003 18:35:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Timer interrupt cleanups [3/3] - normalise calls
Message-ID: <200490000.1041820522@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves x86_do_profile and update_process_times into
do_local_timer for all systems.

It also makes do_global_timer_interrupt call do_local_timer on systems
without the local apic timer (local apic timer simulation)

--------------------

Assuming we're SMP with a local apic timer all firing away:

global_timer_interrupt
	do_global_timer_interrupt
		{ack the interrupt}
		do_global_timer_interrupt_hook
			do_global_timer
				jiffies_64++;
				update_times
		{update CMOS clock}    (In the interrupt still ??!!)

local_apic_timer_interrupt
	do_local_apic_timer_interrupt
		{ack the interrupt}
		do_local_timer
			x86_do_profile
			update_process_times

--------------------

On UP with local apic timer:

global_timer_interrupt
	do_global_timer_interrupt
		{ack the interrupt}
		do_global_timer_interrupt_hook
			do_global_timer
				jiffies_64++;
				update_times
		{update CMOS clock}    (In the interrupt still ??!!)

local_apic_timer_interrupt
	do_local_apic_timer_interrupt
		{ack the interrupt}
		do_local_timer
			x86_do_profile
			update_process_times

--------------------

On a UP 386 with stale crusty breadcrumbs, and no local timer:
	
global_timer_interrupt
	do_global_timer_interrupt
		{ack the interrupt}
		do_global_timer_interrupt_hook
			do_global_timer
				jiffies_64++;
				update_times
			do_local_timer
				x86_do_profile
				update_process_times
		{update CMOS clock}    (In the interrupt still ??!!)

--------------------
diff -urpN -X /home/fletch/.diff.exclude 
02-rename_local_timer/arch/i386/kernel/apic.c 
03-normalise_placement/arch/i386/kernel/apic.c
--- 02-rename_local_timer/arch/i386/kernel/apic.c	Sun Jan  5 10:53:14 2003
+++ 03-normalise_placement/arch/i386/kernel/apic.c	Sun Jan  5 10:56:31 2003
@@ -1012,11 +1012,18 @@ inline void do_local_timer(struct pt_reg
 			prof_old_multiplier[cpu] = prof_counter[cpu];
 		}

+		/*
+		 * This is a bit of a mess ... not sure if we use multipliers
+		 * on SMP ... the old code didn't. Someone who understands
+		 * this better should clean up the #ifdef's below - mbligh
+		 */
 #ifdef CONFIG_SMP
 		update_process_times(user_mode(regs));
 #endif
 	}
-
+#ifndef CONFIG_SMP
+	update_process_times(user_mode(regs));
+#endif
 	/*
 	 * We take the 'long' return path, and there every subsystem
 	 * grabs the apropriate locks (kernel lock/ irq lock).
diff -urpN -X /home/fletch/.diff.exclude 
02-rename_local_timer/include/asm-i386/mach-default/do_timer.h 
03-normalise_placement/include/asm-i386/mach-default/do_timer.h
--- 02-rename_local_timer/include/asm-i386/mach-default/do_timer.h	Sun Jan 
5 10:51:02 2003
+++ 03-normalise_placement/include/asm-i386/mach-default/do_timer.h	Sun Jan 
5 10:56:31 2003
@@ -16,17 +16,9 @@
 static inline void do_global_timer_interrupt_hook(struct pt_regs *regs)
 {
 	do_global_timer(regs);
-/*
- * In the SMP case we use the local APIC timer interrupt to do the
- * profiling, except when we simulate SMP mode on a uniprocessor
- * system, in that case we have to call the local interrupt handler.
- */
-#ifndef CONFIG_X86_LOCAL_APIC
-	x86_do_profile(regs);
-#else
+
 	if (!using_apic_timer)
 		do_local_timer(regs);
-#endif
 }


diff -urpN -X /home/fletch/.diff.exclude 
02-rename_local_timer/include/asm-i386/mach-visws/do_timer.h 
03-normalise_placement/include/asm-i386/mach-visws/do_timer.h
--- 02-rename_local_timer/include/asm-i386/mach-visws/do_timer.h	Sun Jan  5 
10:51:02 2003
+++ 03-normalise_placement/include/asm-i386/mach-visws/do_timer.h	Sun Jan 
5 10:56:31 2003
@@ -9,17 +9,9 @@ static inline void do_global_timer_inter
 	co_cpu_write(CO_CPU_STAT,co_cpu_read(CO_CPU_STAT) & ~CO_STAT_TIMEINTR);

 	do_global_timer(regs);
-/*
- * In the SMP case we use the local APIC timer interrupt to do the
- * profiling, except when we simulate SMP mode on a uniprocessor
- * system, in that case we have to call the local interrupt handler.
- */
-#ifndef CONFIG_X86_LOCAL_APIC
-	x86_do_profile(regs);
-#else
+
 	if (!using_apic_timer)
 		do_local_timer(regs);
-#endif
 }

 static inline int do_timer_overflow(int count)
diff -urpN -X /home/fletch/.diff.exclude 
02-rename_local_timer/kernel/timer.c 03-normalise_placement/kernel/timer.c
--- 02-rename_local_timer/kernel/timer.c	Sat Jan  4 20:08:46 2003
+++ 03-normalise_placement/kernel/timer.c	Sun Jan  5 10:56:31 2003
@@ -806,11 +806,6 @@ static inline void update_times(void)
 void do_global_timer(struct pt_regs *regs)
 {
 	jiffies_64++;
-#ifndef CONFIG_SMP
-	/* SMP process accounting uses the local APIC timer */
-
-	update_process_times(user_mode(regs));
-#endif
 	update_times();
 }


