Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbTIYRRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 13:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbTIYRRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 13:17:16 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:10462 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id S261290AbTIYRQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 13:16:02 -0400
Date: Thu, 25 Sep 2003 19:15:14 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390 (1/19): arch fixes.
Message-ID: <20030925171514.GB2951@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - Fix cflags for z990 compiles.
 - Rename resume to __switch_to to avoid name clash.
 - Fix show_trace and show_stack.
 - Add alignments to linker script.
 - Add atomic64_t and related funtions.
 - Add include/asm-s390/local.h
 - Fix 31 bit get_user for 8 byte values.
 - Fix show_regs oops.
 - Add a couple of might_sleep() calls.
 - Fix loading of modules with a BIG symbol table.
 - Fix inline asm constraint in __get_user_asm_1
 - Fix nested irq_enter bug on shutdown.
 - Add sched_clock function.

diffstat:
 arch/s390/Makefile             |    2 
 arch/s390/boot/Makefile        |    1 
 arch/s390/kernel/entry.S       |   16 +--
 arch/s390/kernel/entry64.S     |   14 +-
 arch/s390/kernel/module.c      |    7 -
 arch/s390/kernel/process.c     |    5 -
 arch/s390/kernel/smp.c         |   19 +++
 arch/s390/kernel/time.c        |   14 ++
 arch/s390/kernel/traps.c       |   12 +-
 arch/s390/kernel/vmlinux.lds.S |    2 
 include/asm-s390/atomic.h      |  198 +++++++++++++++++++++++------------------
 include/asm-s390/local.h       |   59 ++++++++++++
 include/asm-s390/pci.h         |    2 
 include/asm-s390/processor.h   |    3 
 include/asm-s390/sections.h    |    6 +
 include/asm-s390/spinlock.h    |   14 +-
 include/asm-s390/system.h      |    4 
 include/asm-s390/uaccess.h     |   29 ++++--
 18 files changed, 270 insertions(+), 137 deletions(-)

diff -urN linux-2.6/arch/s390/Makefile linux-2.6-s390/arch/s390/Makefile
--- linux-2.6/arch/s390/Makefile	Thu Sep 25 18:33:02 2003
+++ linux-2.6-s390/arch/s390/Makefile	Thu Sep 25 18:33:21 2003
@@ -30,7 +30,7 @@
 
 cflags-$(CONFIG_MARCH_G5)   += $(call check_gcc,-march=g5,)
 cflags-$(CONFIG_MARCH_Z900) += $(call check_gcc,-march=z900,)
-cflags-$(CONFIG_MARCH_Z990) += $(call check_gcc,-march=trex,)
+cflags-$(CONFIG_MARCH_Z990) += $(call check_gcc,-march=z990,)
 
 CFLAGS		+= $(cflags-y)
 CFLAGS		+= $(call check_gcc,-finline-limit=10000,)
diff -urN linux-2.6/arch/s390/boot/Makefile linux-2.6-s390/arch/s390/boot/Makefile
--- linux-2.6/arch/s390/boot/Makefile	Mon Sep  8 21:50:58 2003
+++ linux-2.6-s390/arch/s390/boot/Makefile	Thu Sep 25 18:33:21 2003
@@ -7,7 +7,6 @@
 			tr -c '[0-9A-Za-z]' '_'`_t
 
 EXTRA_CFLAGS  := -DCOMPILE_VERSION=$(COMPILE_VERSION) -gstabs -I .
-EXTRA_AFLAGS  := -traditional
 
 targets := image
 
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Mon Sep  8 21:49:54 2003
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Thu Sep 25 18:33:21 2003
@@ -123,18 +123,18 @@
  * Returns:
  *  gpr2 = prev
  */
-        .globl  resume
-resume:
+        .globl  __switch_to
+__switch_to:
         basr    %r1,0
-resume_base:
+__switch_to_base:
 	tm	__THREAD_per(%r3),0xe8		# new process is using per ?
-	bz	resume_noper-resume_base(%r1)	# if not we're fine
+	bz	__switch_to_noper-__switch_to_base(%r1)	# if not we're fine
         stctl   %c9,%c11,24(%r15)		# We are using per stuff
         clc     __THREAD_per(12,%r3),24(%r15)
-        be      resume_noper-resume_base(%r1)	# we got away w/o bashing TLB's
+        be      __switch_to_noper-__switch_to_base(%r1)	# we got away w/o bashing TLB's
         lctl    %c9,%c11,__THREAD_per(%r3)	# Nope we didn't
-resume_noper:
-        stm     %r6,%r15,24(%r15)       # store resume registers of prev task
+__switch_to_noper:
+        stm     %r6,%r15,24(%r15)       # store __switch_to registers of prev task
 	st	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	l	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
 	stam    %a2,%a2,__THREAD_ar2(%r2)	# store kernel access reg. 2
@@ -199,6 +199,8 @@
 
 sysc_return:
 	stnsm   24(%r15),0xfc     # disable I/O and ext. interrupts
+	tm	SP_PSW+1(%r15),0x01	# returning to user ?
+	bno	BASED(sysc_leave)
 	tm	__TI_flags+3(%r9),_TIF_WORK_SVC
 	bnz	BASED(sysc_work)  # there is work to do (signals etc.)
 sysc_leave:
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Mon Sep  8 21:49:54 2003
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Thu Sep 25 18:33:21 2003
@@ -111,16 +111,16 @@
  * Returns:
  *  gpr2 = prev
  */
-        .globl  resume
-resume:
+        .globl  __switch_to
+__switch_to:
 	tm	__THREAD_per+4(%r3),0xe8 # is the new process using per ?
-	jz	resume_noper		# if not we're fine
+	jz	__switch_to_noper		# if not we're fine
         stctg   %c9,%c11,48(%r15)       # We are using per stuff
         clc     __THREAD_per(24,%r3),48(%r15)
-        je      resume_noper            # we got away without bashing TLB's
+        je      __switch_to_noper            # we got away without bashing TLB's
         lctlg   %c9,%c11,__THREAD_per(%r3)	# Nope we didn't
-resume_noper:
-        stmg    %r6,%r15,48(%r15)       # store resume registers of prev task
+__switch_to_noper:
+        stmg    %r6,%r15,48(%r15)       # store __switch_to registers of prev task
 	stg	%r15,__THREAD_ksp(%r2)	# store kernel stack to prev->tss.ksp
 	lg	%r15,__THREAD_ksp(%r3)	# load kernel stack from next->tss.ksp
         stam    %a2,%a2,__THREAD_ar2(%r2)	# store kernel access reg. 2
@@ -187,6 +187,8 @@
 
 sysc_return:
 	stnsm   48(%r15),0xfc     # disable I/O and ext. interrupts
+        tm      SP_PSW+1(%r15),0x01    # returning to user ?
+        jno     sysc_leave
 	tm	__TI_flags+7(%r9),_TIF_WORK_SVC
 	jnz	sysc_work         # there is work to do (signals etc.)
 sysc_leave:
diff -urN linux-2.6/arch/s390/kernel/module.c linux-2.6-s390/arch/s390/kernel/module.c
--- linux-2.6/arch/s390/kernel/module.c	Mon Sep  8 21:50:23 2003
+++ linux-2.6-s390/arch/s390/kernel/module.c	Thu Sep 25 18:33:21 2003
@@ -133,9 +133,8 @@
 
 	/* Allocate one syminfo structure per symbol. */
 	me->arch.nsyms = symtab->sh_size / sizeof(Elf_Sym);
-	me->arch.syminfo = kmalloc(me->arch.nsyms *
-				   sizeof(struct mod_arch_syminfo),
-				   GFP_KERNEL);
+	me->arch.syminfo = vmalloc(me->arch.nsyms *
+				   sizeof(struct mod_arch_syminfo));
 	if (!me->arch.syminfo)
 		return -ENOMEM;
 	symbols = (void *) hdr + symtab->sh_offset;
@@ -397,7 +396,7 @@
 		    struct module *me)
 {
 	if (me->arch.syminfo)
-		kfree(me->arch.syminfo);
+		vfree(me->arch.syminfo);
 	return 0;
 }
 
diff -urN linux-2.6/arch/s390/kernel/process.c linux-2.6-s390/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	Mon Sep  8 21:50:21 2003
+++ linux-2.6-s390/arch/s390/kernel/process.c	Thu Sep 25 18:33:21 2003
@@ -118,9 +118,6 @@
 	return 0;
 }
 
-extern void show_registers(struct pt_regs *regs);
-extern void show_trace(unsigned long *sp);
-
 void show_regs(struct pt_regs *regs)
 {
 	struct task_struct *tsk = current;
@@ -133,7 +130,7 @@
 	show_registers(regs);
 	/* Show stack backtrace if pt_regs is from kernel mode */
 	if (!(regs->psw.mask & PSW_MASK_PSTATE))
-		show_trace((unsigned long *) regs->gprs[15]);
+		show_trace(0,(unsigned long *) regs->gprs[15]);
 }
 
 extern void kernel_thread_starter(void);
diff -urN linux-2.6/arch/s390/kernel/smp.c linux-2.6-s390/arch/s390/kernel/smp.c
--- linux-2.6/arch/s390/kernel/smp.c	Mon Sep  8 21:49:51 2003
+++ linux-2.6-s390/arch/s390/kernel/smp.c	Thu Sep 25 18:33:21 2003
@@ -231,6 +231,18 @@
         on_each_cpu(do_machine_restart, NULL, 0, 0);
 }
 
+static void do_wait_for_stop(void)
+{
+	unsigned long cr[16];
+
+	__ctl_store(cr, 0, 15);
+	cr[0] &= ~0xffff;
+	cr[6] = 0;
+	__ctl_load(cr, 0, 15);
+	for (;;)
+		enabled_wait();
+}
+
 static void do_machine_halt(void * __unused)
 {
 	if (smp_processor_id() == 0) {
@@ -240,8 +252,7 @@
 		signal_processor(smp_processor_id(),
 				 sigp_stop_and_store_status);
 	}
-	for (;;)
-		enabled_wait();
+	do_wait_for_stop();
 }
 
 void machine_halt_smp(void)
@@ -258,8 +269,7 @@
 		signal_processor(smp_processor_id(),
 				 sigp_stop_and_store_status);
 	}
-	for (;;)
-		enabled_wait();
+	do_wait_for_stop();
 }
 
 void machine_power_off_smp(void)
@@ -577,6 +587,7 @@
         return 0;
 }
 
+EXPORT_SYMBOL(cpu_possible_map);
 EXPORT_SYMBOL(lowcore_ptr);
 EXPORT_SYMBOL(smp_ctl_set_bit);
 EXPORT_SYMBOL(smp_ctl_clear_bit);
diff -urN linux-2.6/arch/s390/kernel/time.c linux-2.6-s390/arch/s390/kernel/time.c
--- linux-2.6/arch/s390/kernel/time.c	Mon Sep  8 21:49:51 2003
+++ linux-2.6-s390/arch/s390/kernel/time.c	Thu Sep 25 18:33:21 2003
@@ -55,6 +55,14 @@
 
 extern unsigned long wall_jiffies;
 
+/*
+ * Scheduler clock - returns current time in nanosec units.
+ */
+unsigned long long sched_clock(void)
+{
+	return (get_clock() - jiffies_timer_cc) >> 2;
+}
+
 void tod_to_timeval(__u64 todval, struct timespec *xtime)
 {
 	unsigned long long sec;
@@ -70,8 +78,7 @@
 {
 	__u64 now;
 
-	asm volatile ("STCK 0(%0)" : : "a" (&now) : "memory", "cc");
-        now = (now - jiffies_timer_cc) >> 12;
+        now = (get_clock() - jiffies_timer_cc) >> 12;
 	/* We require the offset from the latest update of xtime */
 	now -= (__u64) wall_jiffies*USECS_PER_JIFFY;
 	return (unsigned long) now;
@@ -165,8 +172,7 @@
 	__u32 ticks;
 
 	/* Calculate how many ticks have passed. */
-	asm volatile ("STCK 0(%0)" : : "a" (&tmp) : "memory", "cc");
-	tmp = tmp - S390_lowcore.jiffy_timer;
+	tmp = get_clock() - S390_lowcore.jiffy_timer;
 	if (tmp >= 2*CLK_TICKS_PER_JIFFY) {  /* more than one tick ? */
 		ticks = __calculate_ticks(tmp);
 		S390_lowcore.jiffy_timer +=
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Mon Sep  8 21:50:01 2003
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Thu Sep 25 18:33:21 2003
@@ -83,7 +83,7 @@
 	unsigned long backchain, low_addr, high_addr, ret_addr;
 
 	if (!stack)
-		stack = *stack_pointer;
+		stack = (task == NULL) ? *stack_pointer : &(task->thread.ksp);
 
 	printk("Call Trace:\n");
 	low_addr = ((unsigned long) stack) & PSW_ADDR_INSN;
@@ -120,8 +120,12 @@
 	// debugging aid: "show_stack(NULL);" prints the
 	// back trace for this cpu.
 
-	if(sp == NULL)
-		sp = *stack_pointer;
+	if (!sp) {
+		if (task)
+			sp = (unsigned long *) task->thread.ksp;
+		else
+			sp = *stack_pointer;
+	}
 
 	stack = sp;
 	for (i = 0; i < kstack_depth_to_print; i++) {
@@ -140,7 +144,7 @@
  */
 void dump_stack(void)
 {
-	show_stack(current, 0);
+	show_stack(0, 0);
 }
 
 void show_registers(struct pt_regs *regs)
diff -urN linux-2.6/arch/s390/kernel/vmlinux.lds.S linux-2.6-s390/arch/s390/kernel/vmlinux.lds.S
--- linux-2.6/arch/s390/kernel/vmlinux.lds.S	Mon Sep  8 21:50:01 2003
+++ linux-2.6-s390/arch/s390/kernel/vmlinux.lds.S	Thu Sep 25 18:33:21 2003
@@ -98,6 +98,7 @@
   . = ALIGN(256);
   __initramfs_start = .;
   .init.ramfs : { *(.init.initramfs) }
+  . = ALIGN(2);
   __initramfs_end = .;
   . = ALIGN(256);
   __per_cpu_start = .;
@@ -109,6 +110,7 @@
 
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
+  . = ALIGN(2);
   __bss_stop = .;
 
   _end = . ;
diff -urN linux-2.6/include/asm-s390/atomic.h linux-2.6-s390/include/asm-s390/atomic.h
--- linux-2.6/include/asm-s390/atomic.h	Mon Sep  8 21:49:52 2003
+++ linux-2.6-s390/include/asm-s390/atomic.h	Thu Sep 25 18:33:21 2003
@@ -1,13 +1,15 @@
 #ifndef __ARCH_S390_ATOMIC__
 #define __ARCH_S390_ATOMIC__
 
+#ifdef __KERNEL__
 /*
  *  include/asm-s390/atomic.h
  *
  *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
+ *    Copyright (C) 1999-2003 IBM Deutschland Entwicklung GmbH, IBM Corporation
  *    Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com),
- *               Denis Joseph Barrow
+ *               Denis Joseph Barrow,
+ *		 Arnd Bergmann (arndb@de.ibm.com)
  *
  *  Derived from "include/asm-i386/bitops.h"
  *    Copyright (C) 1992, Linus Torvalds
@@ -20,12 +22,13 @@
  * S390 uses 'Compare And Swap' for atomicity in SMP enviroment
  */
 
-typedef struct { volatile int counter; } __attribute__ ((aligned (4))) atomic_t;
+typedef struct {
+	volatile int counter;
+} __attribute__ ((aligned (4))) atomic_t;
 #define ATOMIC_INIT(i)  { (i) }
 
-#define atomic_eieio()          __asm__ __volatile__ ("BCR 15,0")
-
-#define __CS_LOOP(old_val, new_val, ptr, op_val, op_string)		\
+#define __CS_LOOP(ptr, op_val, op_string) ({				\
+	typeof(ptr->counter) old_val, new_val;				\
         __asm__ __volatile__("   l     %0,0(%3)\n"			\
                              "0: lr    %1,%0\n"				\
                              op_string "  %1,%4\n"			\
@@ -33,92 +36,140 @@
                              "   jl    0b"				\
                              : "=&d" (old_val), "=&d" (new_val),	\
 			       "+m" (((atomic_t *)(ptr))->counter)	\
-			     : "a" (ptr), "d" (op_val) : "cc" );
-
+			     : "a" (ptr), "d" (op_val) : "cc" );	\
+	new_val;							\
+})
 #define atomic_read(v)          ((v)->counter)
 #define atomic_set(v,i)         (((v)->counter) = (i))
 
-static __inline__ void atomic_add(int i, atomic_t *v)
+static __inline__ void atomic_add(int i, atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, i, "ar");
+	       __CS_LOOP(v, i, "ar");
 }
-
-static __inline__ int atomic_add_return (int i, atomic_t *v)
+static __inline__ int atomic_add_return(int i, atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, i, "ar");
-	return new_val;
+	return __CS_LOOP(v, i, "ar");
 }
-
-static __inline__ int atomic_add_negative(int i, atomic_t *v)
+static __inline__ int atomic_add_negative(int i, atomic_t * v)
 {
-	int old_val, new_val;
-        __CS_LOOP(old_val, new_val, v, i, "ar");
-        return new_val < 0;
+	return __CS_LOOP(v, i, "ar") < 0;
 }
-
-static __inline__ void atomic_sub(int i, atomic_t *v)
+static __inline__ void atomic_sub(int i, atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, i, "sr");
+	       __CS_LOOP(v, i, "sr");
 }
-
-static __inline__ void atomic_inc(volatile atomic_t *v)
+static __inline__ void atomic_inc(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "ar");
+	       __CS_LOOP(v, 1, "ar");
 }
-
-static __inline__ int atomic_inc_return(volatile atomic_t *v)
+static __inline__ int atomic_inc_return(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "ar");
-        return new_val;
+	return __CS_LOOP(v, 1, "ar");
 }
-
-static __inline__ int atomic_inc_and_test(volatile atomic_t *v)
+static __inline__ int atomic_inc_and_test(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "ar");
-	return new_val != 0;
+	return __CS_LOOP(v, 1, "ar") != 0;
 }
-
-static __inline__ void atomic_dec(volatile atomic_t *v)
+static __inline__ void atomic_dec(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "sr");
+	       __CS_LOOP(v, 1, "sr");
 }
-
-static __inline__ int atomic_dec_return(volatile atomic_t *v)
+static __inline__ int atomic_dec_return(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "sr");
-        return new_val;
+	return __CS_LOOP(v, 1, "sr");
 }
-
-static __inline__ int atomic_dec_and_test(volatile atomic_t *v)
+static __inline__ int atomic_dec_and_test(volatile atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, 1, "sr");
-        return new_val == 0;
+	return __CS_LOOP(v, 1, "sr") == 0;
 }
-
-static __inline__ void atomic_clear_mask(unsigned long mask, atomic_t *v)
+static __inline__ void atomic_clear_mask(unsigned long mask, atomic_t * v)
+{
+	       __CS_LOOP(v, ~mask, "nr");
+}
+static __inline__ void atomic_set_mask(unsigned long mask, atomic_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, ~mask, "nr");
+	       __CS_LOOP(v, mask, "or");
 }
+#undef __CS_LOOP
 
-static __inline__ void atomic_set_mask(unsigned long mask, atomic_t *v)
+#ifdef __s390x__
+typedef struct {
+	volatile long long counter;
+} __attribute__ ((aligned (8))) atomic64_t;
+#define ATOMIC64_INIT(i)  { (i) }
+
+#define __CSG_LOOP(ptr, op_val, op_string) ({				\
+	typeof(ptr->counter) old_val, new_val;				\
+        __asm__ __volatile__("   lg    %0,0(%3)\n"			\
+                             "0: lgr   %1,%0\n"				\
+                             op_string "  %1,%4\n"			\
+                             "   csg   %0,%1,0(%3)\n"			\
+                             "   jl    0b"				\
+                             : "=&d" (old_val), "=&d" (new_val),	\
+			       "+m" (((atomic_t *)(ptr))->counter)	\
+			     : "a" (ptr), "d" (op_val) : "cc" );	\
+	new_val;							\
+})
+#define atomic64_read(v)          ((v)->counter)
+#define atomic64_set(v,i)         (((v)->counter) = (i))
+
+static __inline__ void atomic64_add(int i, atomic64_t * v)
+{
+	       __CSG_LOOP(v, i, "agr");
+}
+static __inline__ long long atomic64_add_return(int i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "agr");
+}
+static __inline__ long long atomic64_add_negative(int i, atomic64_t * v)
+{
+	return __CSG_LOOP(v, i, "agr") < 0;
+}
+static __inline__ void atomic64_sub(int i, atomic64_t * v)
+{
+	       __CSG_LOOP(v, i, "sgr");
+}
+static __inline__ void atomic64_inc(volatile atomic64_t * v)
+{
+	       __CSG_LOOP(v, 1, "agr");
+}
+static __inline__ long long atomic64_inc_return(volatile atomic64_t * v)
+{
+	return __CSG_LOOP(v, 1, "agr");
+}
+static __inline__ long long atomic64_inc_and_test(volatile atomic64_t * v)
+{
+	return __CSG_LOOP(v, 1, "agr") != 0;
+}
+static __inline__ void atomic64_dec(volatile atomic64_t * v)
 {
-	int old_val, new_val;
-	__CS_LOOP(old_val, new_val, v, mask, "or");
+	       __CSG_LOOP(v, 1, "sgr");
 }
+static __inline__ long long atomic64_dec_return(volatile atomic64_t * v)
+{
+	return __CSG_LOOP(v, 1, "sgr");
+}
+static __inline__ long long atomic64_dec_and_test(volatile atomic64_t * v)
+{
+	return __CSG_LOOP(v, 1, "sgr") == 0;
+}
+static __inline__ void atomic64_clear_mask(unsigned long mask, atomic64_t * v)
+{
+	       __CSG_LOOP(v, ~mask, "ngr");
+}
+static __inline__ void atomic64_set_mask(unsigned long mask, atomic64_t * v)
+{
+	       __CSG_LOOP(v, mask, "ogr");
+}
+
+#undef __CSG_LOOP
+#endif
 
 /*
   returns 0  if expected_oldval==value in *v ( swap was successful )
   returns 1  if unsuccessful.
+
+  This is non-portable, use bitops or spinlocks instead!
 */
 static __inline__ int
 atomic_compare_and_swap(int expected_oldval,int new_val,atomic_t *v)
@@ -137,33 +188,10 @@
         return retval;
 }
 
-/*
-  Spin till *v = expected_oldval then swap with newval.
- */
-static __inline__ void
-atomic_compare_and_swap_spin(int expected_oldval,int new_val,atomic_t *v)
-{
-	unsigned long tmp;
-        __asm__ __volatile__(
-                "0: lr  %1,%3\n"
-                "   cs  %1,%4,0(%2)\n"
-                "   jl  0b\n"
-                : "+m" (v->counter), "=&d" (tmp)
-		: "a" (v), "d" (expected_oldval) , "d" (new_val)
-                : "cc" );
-}
-
-#define atomic_compare_and_swap_debug(where,from,to) \
-if (atomic_compare_and_swap ((from), (to), (where))) {\
-	printk (KERN_WARNING"%s/%d atomic counter:%s couldn't be changed from %d(%s) to %d(%s), was %d\n",\
-		__FILE__,__LINE__,#where,(from),#from,(to),#to,atomic_read (where));\
-        atomic_set(where,(to));\
-}
-
 #define smp_mb__before_atomic_dec()	smp_mb()
 #define smp_mb__after_atomic_dec()	smp_mb()
 #define smp_mb__before_atomic_inc()	smp_mb()
 #define smp_mb__after_atomic_inc()	smp_mb()
 
-#endif                                 /* __ARCH_S390_ATOMIC __            */
-
+#endif /* __KERNEL__ */
+#endif /* __ARCH_S390_ATOMIC__  */
diff -urN linux-2.6/include/asm-s390/local.h linux-2.6-s390/include/asm-s390/local.h
--- linux-2.6/include/asm-s390/local.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/include/asm-s390/local.h	Thu Sep 25 18:33:21 2003
@@ -0,0 +1,59 @@
+#ifndef _ASM_LOCAL_H
+#define _ASM_LOCAL_H
+
+#include <linux/config.h>
+#include <linux/percpu.h>
+#include <asm/atomic.h>
+
+#ifndef __s390x__
+
+typedef atomic_t local_t;
+
+#define LOCAL_INIT(i)	ATOMIC_INIT(i)
+#define local_read(v)	atomic_read(v)
+#define local_set(v,i)	atomic_set(v,i)
+
+#define local_inc(v)	atomic_inc(v)
+#define local_dec(v)	atomic_dec(v)
+#define local_add(i, v)	atomic_add(i, v)
+#define local_sub(i, v)	atomic_sub(i, v)
+
+#else
+
+typedef atomic64_t local_t;
+
+#define LOCAL_INIT(i)	ATOMIC64_INIT(i)
+#define local_read(v)	atomic64_read(v)
+#define local_set(v,i)	atomic64_set(v,i)
+
+#define local_inc(v)	atomic64_inc(v)
+#define local_dec(v)	atomic64_dec(v)
+#define local_add(i, v)	atomic64_add(i, v)
+#define local_sub(i, v)	atomic64_sub(i, v)
+
+#endif
+
+#define __local_inc(v)		((v)->counter++)
+#define __local_dec(v)		((v)->counter--)
+#define __local_add(i,v)	((v)->counter+=(i))
+#define __local_sub(i,v)	((v)->counter-=(i))
+
+/*
+ * Use these for per-cpu local_t variables: on some archs they are
+ * much more efficient than these naive implementations.  Note they take
+ * a variable, not an address.
+ */
+#define cpu_local_read(v)	local_read(&__get_cpu_var(v))
+#define cpu_local_set(v, i)	local_set(&__get_cpu_var(v), (i))
+
+#define cpu_local_inc(v)	local_inc(&__get_cpu_var(v))
+#define cpu_local_dec(v)	local_dec(&__get_cpu_var(v))
+#define cpu_local_add(i, v)	local_add((i), &__get_cpu_var(v))
+#define cpu_local_sub(i, v)	local_sub((i), &__get_cpu_var(v))
+
+#define __cpu_local_inc(v)	__local_inc(&__get_cpu_var(v))
+#define __cpu_local_dec(v)	__local_dec(&__get_cpu_var(v))
+#define __cpu_local_add(i, v)	__local_add((i), &__get_cpu_var(v))
+#define __cpu_local_sub(i, v)	__local_sub((i), &__get_cpu_var(v))
+
+#endif /* _ASM_LOCAL_H */
diff -urN linux-2.6/include/asm-s390/pci.h linux-2.6-s390/include/asm-s390/pci.h
--- linux-2.6/include/asm-s390/pci.h	Mon Sep  8 21:50:08 2003
+++ linux-2.6-s390/include/asm-s390/pci.h	Thu Sep 25 18:33:21 2003
@@ -4,7 +4,7 @@
 /* S/390 systems don't have a PCI bus. This file is just here because some stupid .c code
  * includes it even if CONFIG_PCI is not set.
  */
-#define PCI_DMA_BUS_IS_PHYS (1)
+#define PCI_DMA_BUS_IS_PHYS (0)
 
 #endif /* __ASM_S390_PCI_H */
 
diff -urN linux-2.6/include/asm-s390/processor.h linux-2.6-s390/include/asm-s390/processor.h
--- linux-2.6/include/asm-s390/processor.h	Mon Sep  8 21:50:03 2003
+++ linux-2.6-s390/include/asm-s390/processor.h	Thu Sep 25 18:33:21 2003
@@ -162,6 +162,9 @@
  */
 extern char *task_show_regs(struct task_struct *task, char *buffer);
 
+extern void show_registers(struct pt_regs *regs);
+extern void show_trace(struct task_struct *task, unsigned long *sp);
+
 unsigned long get_wchan(struct task_struct *p);
 #define __KSTK_PTREGS(tsk) ((struct pt_regs *) \
         (((unsigned long) tsk->thread_info + THREAD_SIZE - sizeof(struct pt_regs)) & -8L))
diff -urN linux-2.6/include/asm-s390/sections.h linux-2.6-s390/include/asm-s390/sections.h
--- linux-2.6/include/asm-s390/sections.h	Thu Jan  1 01:00:00 1970
+++ linux-2.6-s390/include/asm-s390/sections.h	Thu Sep 25 18:33:21 2003
@@ -0,0 +1,6 @@
+#ifndef _S390_SECTIONS_H
+#define _S390_SECTIONS_H
+
+#include <asm-generic/sections.h>
+
+#endif
diff -urN linux-2.6/include/asm-s390/spinlock.h linux-2.6-s390/include/asm-s390/spinlock.h
--- linux-2.6/include/asm-s390/spinlock.h	Mon Sep  8 21:50:59 2003
+++ linux-2.6-s390/include/asm-s390/spinlock.h	Thu Sep 25 18:33:21 2003
@@ -221,18 +221,18 @@
 	
 	__asm__ __volatile__(
 #ifndef __s390x__
-			     "   lhi  %0,1\n"
-			     "   sll  %0,31\n"
-			     "   basr %1,0\n"
-			     "0: cs   %0,%1,0(%3)\n"
+			     "   slr  %0,%0\n"
+			     "   lhi  %1,1\n"
+			     "   sll  %1,31\n"
+			     "   cs   %0,%1,0(%3)"
 #else /* __s390x__ */
-			     "   llihh %0,0x8000\n"
-			     "   basr  %1,0\n"
+			     "   slgr  %0,%0\n"
+			     "   llihh %1,0x8000\n"
 			     "0: csg %0,%1,0(%3)\n"
 #endif /* __s390x__ */
 			     : "=&d" (result), "=&d" (reg), "+m" (rw->lock)
 			     : "a" (&rw->lock) : "cc" );
-	return !result;
+	return result == 0;
 }
 
 #endif /* __ASM_SPINLOCK_H */
diff -urN linux-2.6/include/asm-s390/system.h linux-2.6-s390/include/asm-s390/system.h
--- linux-2.6/include/asm-s390/system.h	Mon Sep  8 21:50:43 2003
+++ linux-2.6-s390/include/asm-s390/system.h	Thu Sep 25 18:33:21 2003
@@ -21,7 +21,7 @@
 
 struct task_struct;
 
-extern struct task_struct *resume(void *, void *);
+extern struct task_struct *__switch_to(void *, void *);
 
 #ifdef __s390x__
 #define __FLAG_SHIFT 56
@@ -88,7 +88,7 @@
 		break;							     \
 	save_fp_regs(&prev->thread.fp_regs);				     \
 	restore_fp_regs(&next->thread.fp_regs);				     \
-	prev = resume(prev,next);					     \
+	prev = __switch_to(prev,next);					     \
 } while (0)
 
 #define nop() __asm__ __volatile__ ("nop")
diff -urN linux-2.6/include/asm-s390/uaccess.h linux-2.6-s390/include/asm-s390/uaccess.h
--- linux-2.6/include/asm-s390/uaccess.h	Mon Sep  8 21:49:56 2003
+++ linux-2.6-s390/include/asm-s390/uaccess.h	Thu Sep 25 18:33:21 2003
@@ -216,7 +216,12 @@
 	__pu_err;						\
 })
 
-#define put_user(x, ptr) __put_user(x, ptr)
+#define put_user(x, ptr)					\
+({								\
+	might_sleep();						\
+	__put_user(x, ptr);					\
+})
+
 
 extern int __put_user_bad(void);
 
@@ -224,18 +229,18 @@
 
 #define __get_user_asm_8(x, ptr, err) \
 ({								\
-	register __typeof__(*(ptr)) const * __from asm("2");	\
-	register __typeof__(x) * __to asm("4");			\
+	register __typeof__(*(ptr)) const * __from asm("4");	\
+	register __typeof__(x) * __to asm("2");			\
 	__from = (ptr);						\
 	__to = &(x);						\
 	__asm__ __volatile__ (					\
 		"   sacf  512\n"				\
-		"0: mvc	  0(8,%1),0(%2)\n"			\
+		"0: mvc	  0(8,%2),0(%4)\n"			\
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
 		: "=&d" (err), "=m" (x)				\
-		: "a" (__to),"a" (__from),"K" (-EFAULT),"0" (0)	\
+		: "a" (__to),"K" (-EFAULT),"a" (__from),"0" (0)	\
 		: "cc" );					\
 })
 
@@ -300,7 +305,7 @@
 		"   sacf  0\n"					\
 		"1:\n"						\
 		__uaccess_fixup					\
-		: "=&d" (err), "=d" (x)				\
+		: "=&d" (err), "=&d" (x)			\
 		: "a" (__ptr), "K" (-EFAULT), "0" (0)		\
 		: "cc" );					\
 })
@@ -331,7 +336,11 @@
 	__gu_err;						\
 })
 
-#define get_user(x, ptr) __get_user(x, ptr)
+#define get_user(x, ptr)					\
+({								\
+	might_sleep();						\
+	__get_user(x, ptr);					\
+})
 
 extern int __get_user_bad(void);
 
@@ -351,6 +360,7 @@
 ({                                                              \
         long err = 0;                                           \
         __typeof__(n) __n = (n);                                \
+        might_sleep();						\
         if (__access_ok(to,__n)) {                              \
                 err = __copy_to_user_asm(from, __n, to);        \
         }                                                       \
@@ -370,6 +380,7 @@
 ({                                                              \
         long err = 0;                                           \
         __typeof__(n) __n = (n);                                \
+        might_sleep();						\
         if (__access_ok(from,__n)) {                            \
                 err = __copy_from_user_asm(to, __n, from);      \
         }                                                       \
@@ -461,6 +472,7 @@
 strncpy_from_user(char *dst, const char *src, long count)
 {
         long res = -EFAULT;
+        might_sleep();
         if (access_ok(VERIFY_READ, src, 1))
                 res = __strncpy_from_user(dst, src, count);
         return res;
@@ -477,6 +489,7 @@
 static inline unsigned long
 strnlen_user(const char * src, unsigned long n)
 {
+	might_sleep();
 	__asm__ __volatile__ (
 		"   alr   %0,%1\n"
 		"   slr   0,0\n"
@@ -510,6 +523,7 @@
 static inline unsigned long
 strnlen_user(const char * src, unsigned long n)
 {
+	might_sleep();
 #if 0
 	__asm__ __volatile__ (
 		"   algr  %0,%1\n"
@@ -574,6 +588,7 @@
 static inline unsigned long
 clear_user(void *to, unsigned long n)
 {
+	might_sleep();
 	if (access_ok(VERIFY_WRITE, to, n))
 		n = __clear_user(to, n);
 	return n;
