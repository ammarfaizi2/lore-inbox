Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbTAFC0K>; Sun, 5 Jan 2003 21:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbTAFC0K>; Sun, 5 Jan 2003 21:26:10 -0500
Received: from franka.aracnet.com ([216.99.193.44]:40395 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265787AbTAFCZx>; Sun, 5 Jan 2003 21:25:53 -0500
Date: Sun, 05 Jan 2003 18:34:16 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Timer interrupt cleanups [2/3] - local timer
Message-ID: <198230000.1041820456@titus>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch renames:

apic_timer_interrupt -> local_apic_timer_interrupt
smp_apic_timer_interrupt ->  do_local_apic_timer_interrupt
smp_local_timer_interrupt -> do_local_timer

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
				update_process_times
				update_times
		{update CMOS clock}    (In the interrupt still ??!!)

local_apic_timer_interrupt
	do_local_apic_timer_interrupt
		{ack the interrupt}
		do_local_timer
			x86_do_profile

--------------------

On a UP 386 with stale crusty breadcrumbs, and no local timer:
	
global_timer_interrupt
	do_global_timer_interrupt
		{ack the interrupt}
		do_global_timer_interrupt_hook
			do_global_timer
				jiffies_64++;
				update_process_times
				update_times
			x86_do_profile()
		{update CMOS clock}    (In the interrupt still ??!!)

--------------------

diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/arch/i386/kernel/apic.c 
02-rename_local_timer/arch/i386/kernel/apic.c
--- 01-rename_global_timer/arch/i386/kernel/apic.c	Thu Jan  2 22:04:58 2003
+++ 02-rename_local_timer/arch/i386/kernel/apic.c	Sun Jan  5 10:53:14 2003
@@ -40,14 +40,14 @@ void __init apic_intr_init(void)
 	smp_intr_init();
 #endif
 	/* self generated IPI for local APIC timer */
-	set_intr_gate(LOCAL_TIMER_VECTOR, apic_timer_interrupt);
+	set_intr_gate(LOCAL_TIMER_VECTOR, local_apic_timer_interrupt);

 	/* IPI vectors for APIC spurious and error interrupts */
 	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
 }

-/* Using APIC to generate smp_local_timer_interrupt? */
+/* Using local APIC interrupt to fire do_local_timer? */
 int using_apic_timer = 0;

 int prof_multiplier[NR_CPUS] = { 1, };
@@ -991,7 +991,7 @@ int setup_profiling_timer(unsigned int m
  * value into /proc/profile.
  */

-inline void smp_local_timer_interrupt(struct pt_regs * regs)
+inline void do_local_timer(struct pt_regs * regs)
 {
 	int cpu = smp_processor_id();

@@ -1038,7 +1038,7 @@ inline void smp_local_timer_interrupt(st
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */

-void smp_apic_timer_interrupt(struct pt_regs regs)
+void do_local_apic_timer_interrupt(struct pt_regs regs)
 {
 	int cpu = smp_processor_id();

@@ -1058,7 +1058,7 @@ void smp_apic_timer_interrupt(struct pt_
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
-	smp_local_timer_interrupt(&regs);
+	do_local_timer(&regs);
 	irq_exit();
 }

diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/arch/i386/kernel/entry.S 
02-rename_local_timer/arch/i386/kernel/entry.S
--- 01-rename_global_timer/arch/i386/kernel/entry.S	Thu Jan  2 22:04:58 2003
+++ 02-rename_local_timer/arch/i386/kernel/entry.S	Sun Jan  5 10:51:02 2003
@@ -397,12 +397,14 @@ common_interrupt:
 	call do_IRQ
 	jmp ret_from_intr

-#define BUILD_INTERRUPT(name, nr)	\
+#define __BUILD_INTERRUPT(name, callfn, nr)	\
 ENTRY(name)				\
 	pushl $nr-256;			\
 	SAVE_ALL			\
-	call smp_/**/name;	\
+	call callfn;	\
 	jmp ret_from_intr;
+
+#define BUILD_INTERRUPT(name, nr) __BUILD_INTERRUPT(name, smp_/**/name, nr)

 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/arch/i386/mach-voyager/voyager_smp.c 
02-rename_local_timer/arch/i386/mach-voyager/voyager_smp.c
--- 01-rename_global_timer/arch/i386/mach-voyager/voyager_smp.c	Thu Jan  2 
22:04:58 2003
+++ 02-rename_local_timer/arch/i386/mach-voyager/voyager_smp.c	Sun Jan  5 
10:55:56 2003
@@ -234,7 +234,7 @@ static int cpucount = 0;
  * space */
 static __u32 trampoline_base;

-/* The per cpu profile stuff - used in smp_local_timer_interrupt */
+/* The per cpu profile stuff - used in do_local_timer */
 static unsigned int prof_multiplier[NR_CPUS] __cacheline_aligned = { 1, };
 static unsigned int prof_old_multiplier[NR_CPUS] __cacheline_aligned = { 
1, };
 static unsigned int prof_counter[NR_CPUS] __cacheline_aligned = { 1, };
@@ -1150,7 +1150,7 @@ smp_call_function (void (*func) (void *i
  *
  * This function is currently a placeholder and is unused in the code */
 asmlinkage void
-smp_apic_timer_interrupt(struct pt_regs regs)
+do_local_apic_timer_interrupt(struct pt_regs regs)
 {
 	wrapper_smp_local_timer_interrupt(&regs);
 }
@@ -1286,14 +1286,14 @@ void
 smp_vic_timer_interrupt(struct pt_regs *regs)
 {
 	send_CPI_allbutself(VIC_TIMER_CPI);
-	smp_local_timer_interrupt(regs);
+	do_local_timer(regs);
 }

 static inline void
 wrapper_smp_local_timer_interrupt(struct pt_regs *regs)
 {
 	irq_enter();
-	smp_local_timer_interrupt(regs);
+	do_local_timer(regs);
 	irq_exit();
 }

@@ -1306,7 +1306,7 @@ wrapper_smp_local_timer_interrupt(struct
  * value into /proc/profile.
  */
 void
-smp_local_timer_interrupt(struct pt_regs * regs)
+do_local_timer(struct pt_regs * regs)
 {
 	int cpu = smp_processor_id();
 	long weight;
diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/include/asm-i386/apic.h 
02-rename_local_timer/include/asm-i386/apic.h
--- 01-rename_global_timer/include/asm-i386/apic.h	Sun Nov 17 20:29:57 2002
+++ 02-rename_local_timer/include/asm-i386/apic.h	Sun Jan  5 10:51:02 2003
@@ -75,7 +75,7 @@ extern void sync_Arb_IDs (void);
 extern void init_bsp_APIC (void);
 extern void setup_local_APIC (void);
 extern void init_apic_mappings (void);
-extern void smp_local_timer_interrupt (struct pt_regs * regs);
+extern void do_local_timer (struct pt_regs * regs);
 extern void setup_boot_APIC_clock (void);
 extern void setup_secondary_APIC_clock (void);
 extern void setup_apic_nmi_watchdog (void);
diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/include/asm-i386/hw_irq.h 
02-rename_local_timer/include/asm-i386/hw_irq.h
--- 01-rename_global_timer/include/asm-i386/hw_irq.h	Thu Jan  2 22:05:15 
2003
+++ 02-rename_local_timer/include/asm-i386/hw_irq.h	Sun Jan  5 10:51:02 2003
@@ -36,7 +36,7 @@ extern asmlinkage void call_function_int
 #endif

 #ifdef CONFIG_X86_LOCAL_APIC
-extern asmlinkage void apic_timer_interrupt(void);
+extern asmlinkage void local_apic_timer_interrupt(void);
 extern asmlinkage void error_interrupt(void);
 extern asmlinkage void spurious_interrupt(void);
 extern asmlinkage void thermal_interrupt(struct pt_regs);
diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/include/asm-i386/mach-default/do_timer.h 
02-rename_local_timer/include/asm-i386/mach-default/do_timer.h
--- 01-rename_global_timer/include/asm-i386/mach-default/do_timer.h	Sun Jan 
5 10:48:34 2003
+++ 02-rename_local_timer/include/asm-i386/mach-default/do_timer.h	Sun Jan 
5 10:51:02 2003
@@ -25,7 +25,7 @@ static inline void do_global_timer_inter
 	x86_do_profile(regs);
 #else
 	if (!using_apic_timer)
-		smp_local_timer_interrupt(regs);
+		do_local_timer(regs);
 #endif
 }

diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/include/asm-i386/mach-default/entry_arch.h 
02-rename_local_timer/include/asm-i386/mach-default/entry_arch.h
--- 01-rename_global_timer/include/asm-i386/mach-default/entry_arch.h	Mon 
Dec 23 23:01:56 2002
+++ 02-rename_local_timer/include/asm-i386/mach-default/entry_arch.h	Sun 
Jan  5 10:51:02 2003
@@ -23,7 +23,7 @@ BUILD_INTERRUPT(call_function_interrupt,
  * a much simpler SMP time architecture:
  */
 #ifdef CONFIG_X86_LOCAL_APIC
-BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+__BUILD_INTERRUPT(local_apic_timer_interrupt, 
do_local_apic_timer_interrupt, LOCAL_TIMER_VECTOR)
 BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
 BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)

diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/include/asm-i386/mach-visws/do_timer.h 
02-rename_local_timer/include/asm-i386/mach-visws/do_timer.h
--- 01-rename_global_timer/include/asm-i386/mach-visws/do_timer.h	Sun Jan 
5 10:48:57 2003
+++ 02-rename_local_timer/include/asm-i386/mach-visws/do_timer.h	Sun Jan  5 
10:51:02 2003
@@ -18,7 +18,7 @@ static inline void do_global_timer_inter
 	x86_do_profile(regs);
 #else
 	if (!using_apic_timer)
-		smp_local_timer_interrupt(regs);
+		do_local_timer(regs);
 #endif
 }

diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/include/asm-i386/mach-visws/entry_arch.h 
02-rename_local_timer/include/asm-i386/mach-visws/entry_arch.h
--- 01-rename_global_timer/include/asm-i386/mach-visws/entry_arch.h	Mon Dec 
23 23:01:56 2002
+++ 02-rename_local_timer/include/asm-i386/mach-visws/entry_arch.h	Sun Jan 
5 10:51:02 2003
@@ -17,7 +17,7 @@ BUILD_INTERRUPT(call_function_interrupt,
  * a much simpler SMP time architecture:
  */
 #ifdef CONFIG_X86_LOCAL_APIC
-BUILD_INTERRUPT(apic_timer_interrupt,LOCAL_TIMER_VECTOR)
+__BUILD_INTERRUPT(local_apic_timer_interrupt, 
do_local_apic_timer_interrupt, LOCAL_TIMER_VECTOR)
 BUILD_INTERRUPT(error_interrupt,ERROR_APIC_VECTOR)
 BUILD_INTERRUPT(spurious_interrupt,SPURIOUS_APIC_VECTOR)
 #endif
diff -urpN -X /home/fletch/.diff.exclude 
01-rename_global_timer/include/asm-i386/voyager.h 
02-rename_local_timer/include/asm-i386/voyager.h
--- 01-rename_global_timer/include/asm-i386/voyager.h	Thu Jan  2 22:05:15 
2003
+++ 02-rename_local_timer/include/asm-i386/voyager.h	Sun Jan  5 10:54:21 
2003
@@ -506,7 +506,7 @@ extern void voyager_smp_intr_init(void);
 extern __u8 voyager_extended_cmos_read(__u16 cmos_address);
 extern void voyager_smp_dump(void);
 extern void voyager_timer_interrupt(struct pt_regs *regs);
-extern void smp_local_timer_interrupt(struct pt_regs * regs);
+extern void do_local_timer(struct pt_regs * regs);
 extern void voyager_power_off(void);
 extern void smp_voyager_power_off(void *dummy);
 extern void voyager_restart(void);

