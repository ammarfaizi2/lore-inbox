Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751921AbWFWSo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751921AbWFWSo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 14:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751920AbWFWSmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 14:42:39 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:18895 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751922AbWFWSmB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 14:42:01 -0400
Message-Id: <20060623183912.179727000@linux-m68k.org>
References: <20060623183056.479024000@linux-m68k.org>
User-Agent: quilt/0.44-1
Date: Fri, 23 Jun 2006 20:31:05 +0200
From: zippel@linux-m68k.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 09/21] separate handler for auto and user vector interrupt
Content-Disposition: inline; filename=0015-M68K-separate-handler-for-auto-and-user-vector-interrupt.txt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use separate entry points for auto and user vector interrupts and
cleanup naming a little.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/m68k/atari/ataints.c |   12 +++---
 arch/m68k/kernel/entry.S  |   84 +++++++++++++++++++++++----------------------
 arch/m68k/kernel/ints.c   |   21 +++++------
 arch/m68k/kernel/traps.c  |   55 ++++-------------------------
 include/asm-m68k/traps.h  |    7 ++++
 5 files changed, 71 insertions(+), 108 deletions(-)

62d132c2030fdb80cb5dff1c65183e1b8d1bf3c5
diff --git a/arch/m68k/atari/ataints.c b/arch/m68k/atari/ataints.c
index 076f479..bb54741 100644
--- a/arch/m68k/atari/ataints.c
+++ b/arch/m68k/atari/ataints.c
@@ -314,7 +314,7 @@ __ALIGN_STR "\n\t"
 	"rte");
 
 /* Defined in entry.S; only increments 'num_spurious' */
-asmlinkage void bad_interrupt(void);
+asmlinkage void bad_inthandler(void);
 
 extern void atari_microwire_cmd( int cmd );
 
@@ -337,7 +337,7 @@ void __init atari_init_IRQ(void)
 
 	/* initialize the vector table */
 	for (i = 0; i < NUM_INT_SOURCES; ++i) {
-		vectors[IRQ_SOURCE_TO_VECTOR(i)] = bad_interrupt;
+		vectors[IRQ_SOURCE_TO_VECTOR(i)] = bad_inthandler;
 	}
 
 	/* Initialize the MFP(s) */
@@ -461,7 +461,7 @@ int atari_request_irq(unsigned int irq, 
 		return -EINVAL;
 	}
 
-	if (vectors[vector] == bad_interrupt) {
+	if (vectors[vector] == bad_inthandler) {
 		/* int has no handler yet */
 		irq_handler[irq].handler = handler;
 		irq_handler[irq].dev_id  = dev_id;
@@ -528,7 +528,7 @@ void atari_free_irq(unsigned int irq, vo
 	}
 
 	vector = IRQ_SOURCE_TO_VECTOR(irq);
-	if (vectors[vector] == bad_interrupt)
+	if (vectors[vector] == bad_inthandler)
 		goto not_found;
 
 	local_irq_save(flags);
@@ -542,7 +542,7 @@ void atari_free_irq(unsigned int irq, vo
 		irq_handler[irq].handler = NULL;
 		irq_handler[irq].dev_id  = NULL;
 		irq_param[irq].devname   = NULL;
-		vectors[vector] = bad_interrupt;
+		vectors[vector] = bad_inthandler;
 		/* If MFP int, also disable it */
 		atari_disable_irq(irq);
 		atari_turnoff_irq(irq);
@@ -617,7 +617,7 @@ int show_atari_interrupts(struct seq_fil
 	int i;
 
 	for (i = 0; i < NUM_INT_SOURCES; ++i) {
-		if (vectors[IRQ_SOURCE_TO_VECTOR(i)] == bad_interrupt)
+		if (vectors[IRQ_SOURCE_TO_VECTOR(i)] == bad_inthandler)
 			continue;
 		if (i < STMFP_SOURCE_BASE)
 			seq_printf(p, "auto %2d: %10u ",
diff --git a/arch/m68k/kernel/entry.S b/arch/m68k/kernel/entry.S
index 522079f..1fb88f3 100644
--- a/arch/m68k/kernel/entry.S
+++ b/arch/m68k/kernel/entry.S
@@ -45,7 +45,7 @@ #include <asm/unistd.h>
 #include <asm/asm-offsets.h>
 
 .globl system_call, buserr, trap, resume
-.globl inthandler, sys_call_table
+.globl sys_call_table
 .globl sys_fork, sys_clone, sys_vfork
 .globl ret_from_interrupt, bad_interrupt
 
@@ -191,44 +191,15 @@ do_delayed_trace:
 	jbra	resume_userspace
 
 
-#if 0
-#ifdef CONFIG_AMIGA
-ami_inthandler:
-	addql	#1,irq_stat+CPUSTAT_LOCAL_IRQ_COUNT
-	SAVE_ALL_INT
-	GET_CURRENT(%d0)
-
-	bfextu	%sp@(PT_VECTOR){#4,#12},%d0
-	movel	%d0,%a0
-	addql	#1,%a0@(kstat+STAT_IRQ-VECOFF(VEC_SPUR))
-	movel	%a0@(autoirq_list-VECOFF(VEC_SPUR)),%a0
-
-| amiga vector int handler get the req mask instead of irq vector
-	lea	CUSTOMBASE,%a1
-	movew	%a1@(C_INTREQR),%d0
-	andw	%a1@(C_INTENAR),%d0
-
-| prepare stack (push frame pointer, dev_id & req mask)
-	pea	%sp@
-	movel	%a0@(IRQ_DEVID),%sp@-
-	movel	%d0,%sp@-
-	pea	%pc@(ret_from_interrupt:w)
-	jbra	@(IRQ_HANDLER,%a0)@(0)
-
-ENTRY(nmi_handler)
-	rte
-#endif
-#endif
+/* This is the main interrupt handler for autovector interrupts */
 
-/*
-** This is the main interrupt handler, responsible for calling process_int()
-*/
-inthandler:
+ENTRY(auto_inthandler)
 	SAVE_ALL_INT
 	GET_CURRENT(%d0)
 	addqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
 					|  put exception # in d0
-	bfextu %sp@(PT_VECTOR){#4,#10},%d0
+	bfextu	%sp@(PT_VECTOR){#4,#10},%d0
+	subw	#VEC_SPUR,%d0
 
 	movel	%sp,%sp@-
 	movel	%d0,%sp@-		|  put vector # on stack
@@ -241,15 +212,16 @@ #if defined(MACH_Q40_ONLY) && defined(CO
 	jbra	3f
 1:
 #endif
-	jbsr	process_int		|  process the IRQ
+	jsr	m68k_handle_int		|  process the IRQ
 3:	addql	#8,%sp			|  pop parameters off stack
 
 ret_from_interrupt:
 	subqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
-	jeq	1f
-2:
-	RESTORE_ALL
-1:
+	jeq	ret_from_last_interrupt
+2:	RESTORE_ALL
+
+	ALIGN
+ret_from_last_interrupt:
 	moveq	#(~ALLOWINT>>8)&0xff,%d0
 	andb	%sp@(PT_SR),%d0
 	jne	2b
@@ -260,12 +232,40 @@ ret_from_interrupt:
 	pea	ret_from_exception
 	jra	do_softirq
 
+/* Handler for user defined interrupt vectors */
+
+ENTRY(mach_inthandler)
+	SAVE_ALL_INT
+	GET_CURRENT(%d0)
+	addqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
+					|  put exception # in d0
+	bfextu	%sp@(PT_VECTOR){#4,#10},%d0
+
+	movel	%sp,%sp@-
+	movel	%d0,%sp@-		|  put vector # on stack
+	movel	mach_process_int,%a0
+	jsr	%a0@			|  process the IRQ
+	addql	#8,%sp			|  pop parameters off stack
+
+	subqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
+	jeq	ret_from_last_interrupt
+	RESTORE_ALL
 
 /* Handler for uninitialized and spurious interrupts */
 
-bad_interrupt:
-	addql	#1,num_spurious
-	rte
+ENTRY(bad_inthandler)
+	SAVE_ALL_INT
+	GET_CURRENT(%d0)
+	addqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
+
+	movel	%sp,%sp@-
+	jsr	handle_badint
+	addql	#4,%sp
+
+	subqb	#1,%curptr@(TASK_INFO+TINFO_PREEMPT+1)
+	jeq	ret_from_last_interrupt
+	RESTORE_ALL
+
 
 ENTRY(sys_fork)
 	SAVE_SWITCH_STACK
diff --git a/arch/m68k/kernel/ints.c b/arch/m68k/kernel/ints.c
index 4b85514..895a56d 100644
--- a/arch/m68k/kernel/ints.c
+++ b/arch/m68k/kernel/ints.c
@@ -248,19 +248,16 @@ static void dummy_free_irq(unsigned int 
 	printk("calling uninitialized disable_irq()\n");
 }
 
-asmlinkage void process_int(unsigned long vec, struct pt_regs *fp)
+asmlinkage void m68k_handle_int(unsigned int irq, struct pt_regs *regs)
 {
-	if (vec >= VEC_INT1 && vec <= VEC_INT7 && !MACH_IS_BVME6000) {
-		vec -= VEC_SPUR;
-		kstat_cpu(0).irqs[vec]++;
-		irq_list[vec].handler(vec, irq_list[vec].dev_id, fp);
-	} else {
-		if (mach_process_int)
-			mach_process_int(vec, fp);
-		else
-			panic("Can't process interrupt vector %ld\n", vec);
-		return;
-	}
+	kstat_cpu(0).irqs[irq]++;
+	irq_list[irq].handler(irq, irq_list[irq].dev_id, regs);
+}
+
+asmlinkage void handle_badint(struct pt_regs *regs)
+{
+	kstat_cpu(0).irqs[0]++;
+	printk("unexpected interrupt from %u\n", regs->vector);
 }
 
 int show_interrupts(struct seq_file *p, void *v)
diff --git a/arch/m68k/kernel/traps.c b/arch/m68k/kernel/traps.c
index 9adf378..b19b951 100644
--- a/arch/m68k/kernel/traps.c
+++ b/arch/m68k/kernel/traps.c
@@ -45,7 +45,6 @@ #include <asm/siginfo.h>
 asmlinkage void system_call(void);
 asmlinkage void buserr(void);
 asmlinkage void trap(void);
-asmlinkage void inthandler(void);
 asmlinkage void nmihandler(void);
 #ifdef CONFIG_M68KFPU_EMU
 asmlinkage void fpu_emu(void);
@@ -53,51 +52,7 @@ #endif
 
 e_vector vectors[256] = {
 	[VEC_BUSERR]	= buserr,
-	[VEC_ADDRERR]	= trap,
-	[VEC_ILLEGAL]	= trap,
-	[VEC_ZERODIV]	= trap,
-	[VEC_CHK]	= trap,
-	[VEC_TRAP]	= trap,
-	[VEC_PRIV]	= trap,
-	[VEC_TRACE]	= trap,
-	[VEC_LINE10]	= trap,
-	[VEC_LINE11]	= trap,
-	[VEC_RESV12]	= trap,
-	[VEC_COPROC]	= trap,
-	[VEC_FORMAT]	= trap,
-	[VEC_UNINT]	= trap,
-	[VEC_RESV16]	= trap,
-	[VEC_RESV17]	= trap,
-	[VEC_RESV18]	= trap,
-	[VEC_RESV19]	= trap,
-	[VEC_RESV20]	= trap,
-	[VEC_RESV21]	= trap,
-	[VEC_RESV22]	= trap,
-	[VEC_RESV23]	= trap,
-	[VEC_SPUR]	= inthandler,
-	[VEC_INT1]	= inthandler,
-	[VEC_INT2]	= inthandler,
-	[VEC_INT3]	= inthandler,
-	[VEC_INT4]	= inthandler,
-	[VEC_INT5]	= inthandler,
-	[VEC_INT6]	= inthandler,
-	[VEC_INT7]	= inthandler,
 	[VEC_SYS]	= system_call,
-	[VEC_TRAP1]	= trap,
-	[VEC_TRAP2]	= trap,
-	[VEC_TRAP3]	= trap,
-	[VEC_TRAP4]	= trap,
-	[VEC_TRAP5]	= trap,
-	[VEC_TRAP6]	= trap,
-	[VEC_TRAP7]	= trap,
-	[VEC_TRAP8]	= trap,
-	[VEC_TRAP9]	= trap,
-	[VEC_TRAP10]	= trap,
-	[VEC_TRAP11]	= trap,
-	[VEC_TRAP12]	= trap,
-	[VEC_TRAP13]	= trap,
-	[VEC_TRAP14]	= trap,
-	[VEC_TRAP15]	= trap,
 };
 
 /* nmi handler for the Amiga */
@@ -132,12 +87,16 @@ void __init trap_init (void)
 {
 	int i;
 
-	for (i = 48; i < 64; i++)
+	vectors[VEC_SPUR] = bad_inthandler;
+	for (i = VEC_INT1; i <= VEC_INT7; i++)
+		vectors[i] = auto_inthandler;
+
+	for (i = 0; i < VEC_USER; i++)
 		if (!vectors[i])
 			vectors[i] = trap;
 
-	for (i = 64; i < 256; i++)
-		vectors[i] = inthandler;
+	for (i = VEC_USER; i < 256; i++)
+		vectors[i] = mach_inthandler;
 
 #ifdef CONFIG_M68KFPU_EMU
 	if (FPU_IS_EMU)
diff --git a/include/asm-m68k/traps.h b/include/asm-m68k/traps.h
index 4750561..7715194 100644
--- a/include/asm-m68k/traps.h
+++ b/include/asm-m68k/traps.h
@@ -13,8 +13,15 @@ #define _M68K_TRAPS_H
 
 #ifndef __ASSEMBLY__
 
+#include <linux/linkage.h>
+#include <asm/ptrace.h>
+
 typedef void (*e_vector)(void);
 
+asmlinkage void auto_inthandler(void);
+asmlinkage void mach_inthandler(void);
+asmlinkage void bad_inthandler(void);
+
 extern e_vector vectors[];
 
 #endif
-- 
1.3.3

--

