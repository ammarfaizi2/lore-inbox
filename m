Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318152AbSGWQbu>; Tue, 23 Jul 2002 12:31:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSGWQbt>; Tue, 23 Jul 2002 12:31:49 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:46064 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S318152AbSGWQbU>; Tue, 23 Jul 2002 12:31:20 -0400
Subject: Re: [PATCH] RML pre-emptive 2.4.19-ac2 with O(1)
From: Robert Love <rml@tech9.net>
To: anton wilson <anton.wilson@camotion.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200207231556.LAA15086@test-area.com>
References: <Pine.LNX.4.44.0207231048180.2980-100000@localhost.localdomain>
	 <200207231556.LAA15086@test-area.com>
Content-Type: multipart/mixed; boundary="=-5r5YzDK6IBYpCXqPJYAO"
X-Mailer: Ximian Evolution 1.0.8 
Date: 23 Jul 2002 09:34:13 -0700
Message-Id: <1027442053.932.97.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5r5YzDK6IBYpCXqPJYAO
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2002-07-23 at 08:55, anton wilson wrote:

> Strangely enough I'm getting processes exiting with preemption count of 1 
> when I use my patch.
> What causes such a problem?

It probably means you are off-by-1 somewhere in your scheduler locking
that is keeping the preempt_count at 1 instead of at 0 in normal
situations.

This also means you are not preempting.

A good check to see if your patch is right would be to diff, for
example, kernel/sched.c in 2.4-ac against yours... apply my patch to a
recent 2.4-ac and see the differences.

I have also attached a preempt-kernel patch for O(1) scheduler on 2.4.18
- if this applies cleanly then everything should be fine.  The patch is
not entirely up-to-date but may be of use.

	Robert Love

--=-5r5YzDK6IBYpCXqPJYAO
Content-Disposition: attachment; filename=preempt-kernel-O1-rml-2.4.18-2.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=preempt-kernel-O1-rml-2.4.18-2.patch;
	charset=ISO-8859-1

diff -urN linux-2.4.18-O1-affinity/CREDITS linux/CREDITS
--- linux-2.4.18-O1-affinity/CREDITS	Mon May 20 09:53:06 2002
+++ linux/CREDITS	Mon May 20 09:55:15 2002
@@ -981,8 +981,8 @@
=20
 N: Nigel Gamble
 E: nigel@nrg.org
-E: nigel@sgi.com
 D: Interrupt-driven printer driver
+D: Preemptible kernel
 S: 120 Alley Way
 S: Mountain View, California 94040
 S: USA
diff -urN linux-2.4.18-O1-affinity/Documentation/Configure.help linux/Docum=
entation/Configure.help
--- linux-2.4.18-O1-affinity/Documentation/Configure.help	Mon May 20 09:54:=
05 2002
+++ linux/Documentation/Configure.help	Mon May 20 09:55:15 2002
@@ -266,6 +266,17 @@
   If you have a system with several CPUs, you do not need to say Y
   here: the local APIC will be used automatically.
=20
+Preemptible Kernel
+CONFIG_PREEMPT
+  This option reduces the latency of the kernel when reacting to
+  real-time or interactive events by allowing a low priority process to
+  be preempted even if it is in kernel mode executing a system call.
+  This allows applications to run more reliably even when the system is
+  under load.
+
+  Say Y here if you are building a kernel for a desktop, embedded
+  real-time system.  Say N if you are unsure.
+
 Kernel math emulation
 CONFIG_MATH_EMULATION
   Linux can emulate a math coprocessor (used for floating point
diff -urN linux-2.4.18-O1-affinity/Documentation/preempt-locking.txt linux/=
Documentation/preempt-locking.txt
--- linux-2.4.18-O1-affinity/Documentation/preempt-locking.txt	Wed Dec 31 1=
6:00:00 1969
+++ linux/Documentation/preempt-locking.txt	Mon May 20 09:55:15 2002
@@ -0,0 +1,104 @@
+		  Proper Locking Under a Preemptible Kernel:
+		       Keeping Kernel Code Preempt-Safe
+			  Robert Love <rml@tech9.net>
+			   Last Updated: 22 Jan 2002
+
+
+INTRODUCTION
+
+
+A preemptible kernel creates new locking issues.  The issues are the same =
as
+those under SMP: concurrency and reentrancy.  Thankfully, the Linux preemp=
tible
+kernel model leverages existing SMP locking mechanisms.  Thus, the kernel
+requires explicit additional locking for very few additional situations.
+
+This document is for all kernel hackers.  Developing code in the kernel
+requires protecting these situations.
+=20
+
+RULE #1: Per-CPU data structures need explicit protection
+
+
+Two similar problems arise. An example code snippet:
+
+	struct this_needs_locking tux[NR_CPUS];
+	tux[smp_processor_id()] =3D some_value;
+	/* task is preempted here... */
+	something =3D tux[smp_processor_id()];
+
+First, since the data is per-CPU, it may not have explicit SMP locking, bu=
t
+require it otherwise.  Second, when a preempted task is finally reschedule=
d,
+the previous value of smp_processor_id may not equal the current.  You mus=
t
+protect these situations by disabling preemption around them.
+
+
+RULE #2: CPU state must be protected.
+
+
+Under preemption, the state of the CPU must be protected.  This is arch-
+dependent, but includes CPU structures and state not preserved over a cont=
ext
+switch.  For example, on x86, entering and exiting FPU mode is now a criti=
cal
+section that must occur while preemption is disabled.  Think what would ha=
ppen
+if the kernel is executing a floating-point instruction and is then preemp=
ted.
+Remember, the kernel does not save FPU state except for user tasks.  There=
fore,
+upon preemption, the FPU registers will be sold to the lowest bidder.  Thu=
s,
+preemption must be disabled around such regions.
+
+Note, some FPU functions are already explicitly preempt safe.  For example=
,
+kernel_fpu_begin and kernel_fpu_end will disable and enable preemption.
+However, math_state_restore must be called with preemption disabled.
+
+
+RULE #3: Lock acquire and release must be performed by same task
+
+
+A lock acquired in one task must be released by the same task.  This
+means you can't do oddball things like acquire a lock and go off to
+play while another task releases it.  If you want to do something
+like this, acquire and release the task in the same code path and
+have the caller wait on an event by the other task.
+
+
+SOLUTION
+
+
+Data protection under preemption is achieved by disabling preemption for t=
he
+duration of the critical region.
+
+preempt_enable()		decrement the preempt counter
+preempt_disable()		increment the preempt counter
+preempt_enable_no_resched()	decrement, but do not immediately preempt
+preempt_get_count()		return the preempt counter
+
+The functions are nestable.  In other words, you can call preempt_disable
+n-times in a code path, and preemption will not be reenabled until the n-t=
h
+call to preempt_enable.  The preempt statements define to nothing if
+preemption is not enabled.
+
+Note that you do not need to explicitly prevent preemption if you are hold=
ing
+any locks or interrupts are disabled, since preemption is implicitly disab=
led
+in those cases.
+
+Example:
+
+	cpucache_t *cc; /* this is per-CPU */
+	preempt_disable();
+	cc =3D cc_data(searchp);
+	if (cc && cc->avail) {
+		__free_block(searchp, cc_entry(cc), cc->avail);
+		cc->avail =3D 0;
+	}
+	preempt_enable();
+	return 0;
+
+Notice how the preemption statements must encompass every reference of the
+critical variables.  Another example:
+
+	int buf[NR_CPUS];
+	set_cpu_val(buf);
+	if (buf[smp_processor_id()] =3D=3D -1) printf(KERN_INFO "wee!\n");
+	spin_lock(&buf_lock);
+	/* ... */
+
+This code is not preempt-safe, but see how easily we can fix it by simply
+moving the spin_lock up two lines.
diff -urN linux-2.4.18-O1-affinity/MAINTAINERS linux/MAINTAINERS
--- linux-2.4.18-O1-affinity/MAINTAINERS	Mon May 20 09:53:19 2002
+++ linux/MAINTAINERS	Mon May 20 09:55:15 2002
@@ -1248,6 +1248,14 @@
 M:	mostrows@styx.uwaterloo.ca
 S:	Maintained
=20
+PREEMPTIBLE KERNEL
+P:	Robert M. Love
+M:	rml@tech9.net
+L:	linux-kernel@vger.kernel.org
+L:	kpreempt-tech@lists.sourceforge.net
+W:	http://tech9.net/rml/linux
+S:	Supported
+
 PROMISE DC4030 CACHING DISK CONTROLLER DRIVER
 P:	Peter Denison
 M:	promise@pnd-pc.demon.co.uk
diff -urN linux-2.4.18-O1-affinity/arch/arm/config.in linux/arch/arm/config=
.in
--- linux-2.4.18-O1-affinity/arch/arm/config.in	Mon May 20 09:53:58 2002
+++ linux/arch/arm/config.in	Mon May 20 09:55:15 2002
@@ -510,6 +510,7 @@
 if [ "$CONFIG_ISDN" !=3D "n" ]; then
    source drivers/isdn/Config.in
 fi
+dep_bool 'Preemptible Kernel' CONFIG_PREEMPT $CONFIG_CPU_32
 endmenu
=20
 #
diff -urN linux-2.4.18-O1-affinity/arch/arm/kernel/entry-armv.S linux/arch/=
arm/kernel/entry-armv.S
--- linux-2.4.18-O1-affinity/arch/arm/kernel/entry-armv.S	Mon May 20 09:53:=
58 2002
+++ linux/arch/arm/kernel/entry-armv.S	Mon May 20 09:55:15 2002
@@ -672,6 +672,12 @@
 		add	r4, sp, #S_SP
 		mov	r6, lr
 		stmia	r4, {r5, r6, r7, r8, r9}	@ save sp_SVC, lr_SVC, pc, cpsr, old_ro
+#ifdef CONFIG_PREEMPT
+		get_current_task r9
+		ldr	r8, [r9, #TSK_PREEMPT]
+		add	r8, r8, #1
+		str	r8, [r9, #TSK_PREEMPT]
+#endif
 1:		get_irqnr_and_base r0, r6, r5, lr
 		movne	r1, sp
 		@
@@ -679,6 +685,25 @@
 		@
 		adrsvc	ne, lr, 1b
 		bne	do_IRQ
+#ifdef CONFIG_PREEMPT
+2:		ldr	r8, [r9, #TSK_PREEMPT]
+		subs	r8, r8, #1
+		bne	3f
+		ldr	r7, [r9, #TSK_NEED_RESCHED]
+		teq	r7, #0
+		beq	3f
+		ldr	r6, .LCirqstat
+		ldr	r0, [r6, #IRQSTAT_BH_COUNT]
+		teq	r0, #0
+		bne	3f
+		mov	r0, #MODE_SVC
+		msr	cpsr_c, r0		@ enable interrupts
+		bl	SYMBOL_NAME(preempt_schedule)
+		mov	r0, #I_BIT | MODE_SVC
+		msr	cpsr_c, r0              @ disable interrupts
+		b	2b
+3:		str	r8, [r9, #TSK_PREEMPT]
+#endif
 		ldr	r0, [sp, #S_PSR]		@ irqs are already disabled
 		msr	spsr, r0
 		ldmia	sp, {r0 - pc}^			@ load r0 - pc, cpsr
@@ -736,6 +761,9 @@
 .LCprocfns:	.word	SYMBOL_NAME(processor)
 #endif
 .LCfp:		.word	SYMBOL_NAME(fp_enter)
+#ifdef CONFIG_PREEMPT
+.LCirqstat:	.word	SYMBOL_NAME(irq_stat)
+#endif
=20
 		irq_prio_table
=20
@@ -775,6 +803,12 @@
 		stmdb	r8, {sp, lr}^
 		alignment_trap r4, r7, __temp_irq
 		zero_fp
+		get_current_task tsk
+#ifdef CONFIG_PREEMPT
+		ldr	r0, [tsk, #TSK_PREEMPT]
+		add	r0, r0, #1
+		str	r0, [tsk, #TSK_PREEMPT]
+#endif
 1:		get_irqnr_and_base r0, r6, r5, lr
 		movne	r1, sp
 		adrsvc	ne, lr, 1b
@@ -782,8 +816,12 @@
 		@ routine called with r0 =3D irq number, r1 =3D struct pt_regs *
 		@
 		bne	do_IRQ
+#ifdef CONFIG_PREEMPT
+		ldr	r0, [tsk, #TSK_PREEMPT]
+		sub	r0, r0, #1
+		str	r0, [tsk, #TSK_PREEMPT]
+#endif
 		mov	why, #0
-		get_current_task tsk
 		b	ret_to_user
=20
 		.align	5
diff -urN linux-2.4.18-O1-affinity/arch/arm/tools/getconstants.c linux/arch=
/arm/tools/getconstants.c
--- linux-2.4.18-O1-affinity/arch/arm/tools/getconstants.c	Mon May 20 09:53=
:59 2002
+++ linux/arch/arm/tools/getconstants.c	Mon May 20 09:55:15 2002
@@ -13,6 +13,7 @@
=20
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
+#include <asm/hardirq.h>
=20
 /*
  * Make sure that the compiler and target are compatible.
@@ -39,6 +40,11 @@
 DEFN("TSS_SAVE",		OFF_TSK(thread.save));
 DEFN("TSS_FPESAVE",		OFF_TSK(thread.fpstate.soft.save));
=20
+#ifdef CONFIG_PREEMPT
+DEFN("TSK_PREEMPT",		OFF_TSK(preempt_count));
+DEFN("IRQSTAT_BH_COUNT",	(unsigned long)&(((irq_cpustat_t *)0)->__local_bh=
_count));
+#endif
+
 #ifdef CONFIG_CPU_32
 DEFN("TSS_DOMAIN",		OFF_TSK(thread.domain));
=20
diff -urN linux-2.4.18-O1-affinity/arch/i386/config.in linux/arch/i386/conf=
ig.in
--- linux-2.4.18-O1-affinity/arch/i386/config.in	Mon May 20 09:53:49 2002
+++ linux/arch/i386/config.in	Mon May 20 09:55:15 2002
@@ -185,6 +185,7 @@
 bool 'Math emulation' CONFIG_MATH_EMULATION
 bool 'MTRR (Memory Type Range Register) support' CONFIG_MTRR
 bool 'Symmetric multi-processing support' CONFIG_SMP
+bool 'Preemptible Kernel' CONFIG_PREEMPT
 if [ "$CONFIG_SMP" !=3D "y" ]; then
    bool 'Local APIC support on uniprocessors' CONFIG_X86_UP_APIC
    dep_bool 'IO-APIC support on uniprocessors' CONFIG_X86_UP_IOAPIC $CONFI=
G_X86_UP_APIC
@@ -198,9 +199,12 @@
    bool 'Multiquad NUMA system' CONFIG_MULTIQUAD
 fi
=20
-if [ "$CONFIG_SMP" =3D "y" -a "$CONFIG_X86_CMPXCHG" =3D "y" ]; then
-   define_bool CONFIG_HAVE_DEC_LOCK y
+if [ "$CONFIG_SMP" =3D "y" -o "$CONFIG_PREEMPT" =3D "y" ]; then
+   if [ "$CONFIG_X86_CMPXCHG" =3D "y" ]; then
+      define_bool CONFIG_HAVE_DEC_LOCK y
+   fi
 fi
+
 endmenu
=20
 mainmenu_option next_comment
diff -urN linux-2.4.18-O1-affinity/arch/i386/kernel/entry.S linux/arch/i386=
/kernel/entry.S
--- linux-2.4.18-O1-affinity/arch/i386/kernel/entry.S	Mon May 20 09:53:50 2=
002
+++ linux/arch/i386/kernel/entry.S	Mon May 20 09:55:15 2002
@@ -71,7 +71,7 @@
  * these are offsets into the task-struct.
  */
 state		=3D  0
-flags		=3D  4
+preempt_count	=3D  4
 sigpending	=3D  8
 addr_limit	=3D 12
 exec_domain	=3D 16
@@ -79,8 +79,28 @@
 tsk_ptrace	=3D 24
 cpu		=3D 32
=20
+/* These are offsets into the irq_stat structure
+ * There is one per cpu and it is aligned to 32
+ * byte boundry (we put that here as a shift count)
+ */
+irq_array_shift                 =3D CONFIG_X86_L1_CACHE_SHIFT
+
+irq_stat_local_irq_count        =3D 4
+irq_stat_local_bh_count         =3D 8
+
 ENOSYS =3D 38
=20
+#ifdef CONFIG_SMP
+#define GET_CPU_INDX	movl cpu(%ebx),%eax;  \
+                        shll $irq_array_shift,%eax
+#define GET_CURRENT_CPU_INDX GET_CURRENT(%ebx); \
+                             GET_CPU_INDX
+#define CPU_INDX (,%eax)
+#else
+#define GET_CPU_INDX
+#define GET_CURRENT_CPU_INDX GET_CURRENT(%ebx)
+#define CPU_INDX
+#endif
=20
 #define SAVE_ALL \
 	cld; \
@@ -176,7 +196,7 @@
=20
=20
 ENTRY(ret_from_fork)
-#if CONFIG_SMP
+#if CONFIG_SMP || CONFIG_PREEMPT
 	pushl %ebx
 	call SYMBOL_NAME(schedule_tail)
 	addl $4, %esp
@@ -249,12 +269,30 @@
 	ALIGN
 ENTRY(ret_from_intr)
 	GET_CURRENT(%ebx)
+#ifdef CONFIG_PREEMPT
+	cli
+	decl preempt_count(%ebx)
+#endif
 ret_from_exception:
 	movl EFLAGS(%esp),%eax		# mix EFLAGS and CS
 	movb CS(%esp),%al
 	testl $(VM_MASK | 3),%eax	# return to VM86 mode or non-supervisor?
 	jne ret_from_sys_call
+#ifdef CONFIG_PREEMPT
+	cmpl $0,preempt_count(%ebx)
+	jnz restore_all
+	cmpl $0,need_resched(%ebx)
+	jz restore_all
+	movl SYMBOL_NAME(irq_stat)+irq_stat_local_bh_count CPU_INDX,%ecx
+	addl SYMBOL_NAME(irq_stat)+irq_stat_local_irq_count CPU_INDX,%ecx
+	jnz restore_all
+	incl preempt_count(%ebx)
+	sti
+	call SYMBOL_NAME(preempt_schedule)
+	jmp ret_from_intr
+#else
 	jmp restore_all
+#endif
=20
 	ALIGN
 reschedule:
@@ -291,6 +329,9 @@
 	GET_CURRENT(%ebx)
 	call *%edi
 	addl $8,%esp
+#ifdef CONFIG_PREEMPT
+	cli
+#endif
 	jmp ret_from_exception
=20
 ENTRY(coprocessor_error)
@@ -310,12 +351,18 @@
 	movl %cr0,%eax
 	testl $0x4,%eax			# EM (math emulation bit)
 	jne device_not_available_emulate
+#ifdef CONFIG_PREEMPT
+	cli
+#endif
 	call SYMBOL_NAME(math_state_restore)
 	jmp ret_from_exception
 device_not_available_emulate:
 	pushl $0		# temporary storage for ORIG_EIP
 	call  SYMBOL_NAME(math_emulate)
 	addl $4,%esp
+#ifdef CONFIG_PREEMPT
+	cli
+#endif
 	jmp ret_from_exception
=20
 ENTRY(debug)
diff -urN linux-2.4.18-O1-affinity/arch/i386/kernel/i387.c linux/arch/i386/=
kernel/i387.c
--- linux-2.4.18-O1-affinity/arch/i386/kernel/i387.c	Mon May 20 09:53:50 20=
02
+++ linux/arch/i386/kernel/i387.c	Mon May 20 09:55:15 2002
@@ -10,6 +10,7 @@
=20
 #include <linux/config.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/i387.h>
 #include <asm/math_emu.h>
@@ -65,6 +66,8 @@
 {
 	struct task_struct *tsk =3D current;
=20
+	preempt_disable();
+=09
 	if (tsk->flags & PF_USEDFPU) {
 		__save_init_fpu(tsk);
 		return;
diff -urN linux-2.4.18-O1-affinity/arch/i386/kernel/smp.c linux/arch/i386/k=
ernel/smp.c
--- linux-2.4.18-O1-affinity/arch/i386/kernel/smp.c	Mon May 20 09:53:50 200=
2
+++ linux/arch/i386/kernel/smp.c	Mon May 20 10:35:03 2002
@@ -354,10 +354,14 @@
=20
 asmlinkage void smp_invalidate_interrupt (void)
 {
-	unsigned long cpu =3D smp_processor_id();
+	unsigned long cpu;;
+
+	preempt_disable();
+
+	cpu =3D smp_processor_id();
=20
 	if (!test_bit(cpu, &flush_cpumask))
-		return;
+		goto out;
 		/*=20
 		 * This was a BUG() but until someone can quote me the
 		 * line from the intel manual that guarantees an IPI to
@@ -378,6 +382,8 @@
 	}
 	ack_APIC_irq();
 	clear_bit(cpu, &flush_cpumask);
+out:
+	preempt_enable();
 }
=20
 static void flush_tlb_others (unsigned long cpumask, struct mm_struct *mm,
@@ -427,16 +433,22 @@
 void flush_tlb_current_task(void)
 {
 	struct mm_struct *mm =3D current->mm;
-	unsigned long cpu_mask =3D mm->cpu_vm_mask & ~(1 << smp_processor_id());
-
+	unsigned long cpu_mask;
+=09
+	preempt_disable();
+	cpu_mask =3D mm->cpu_vm_mask & ~(1 << smp_processor_id());
 	local_flush_tlb();
 	if (cpu_mask)
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
+	preempt_enable();
 }
=20
 void flush_tlb_mm (struct mm_struct * mm)
 {
-	unsigned long cpu_mask =3D mm->cpu_vm_mask & ~(1 << smp_processor_id());
+	unsigned long cpu_mask;
+=09
+	preempt_disable();
+	cpu_mask =3D mm->cpu_vm_mask & ~(1 << smp_processor_id());
=20
 	if (current->active_mm =3D=3D mm) {
 		if (current->mm)
@@ -446,12 +458,17 @@
 	}
 	if (cpu_mask)
 		flush_tlb_others(cpu_mask, mm, FLUSH_ALL);
+
+	preempt_enable();
 }
=20
 void flush_tlb_page(struct vm_area_struct * vma, unsigned long va)
 {
 	struct mm_struct *mm =3D vma->vm_mm;
-	unsigned long cpu_mask =3D mm->cpu_vm_mask & ~(1 << smp_processor_id());
+	unsigned long cpu_mask;
+=09
+	preempt_disable();
+	cpu_mask =3D mm->cpu_vm_mask & ~(1 << smp_processor_id());
=20
 	if (current->active_mm =3D=3D mm) {
 		if(current->mm)
@@ -462,6 +479,8 @@
=20
 	if (cpu_mask)
 		flush_tlb_others(cpu_mask, mm, va);
+
+	preempt_enable();
 }
=20
 static inline void do_flush_tlb_all_local(void)
diff -urN linux-2.4.18-O1-affinity/arch/i386/kernel/traps.c linux/arch/i386=
/kernel/traps.c
--- linux-2.4.18-O1-affinity/arch/i386/kernel/traps.c	Mon May 20 09:53:50 2=
002
+++ linux/arch/i386/kernel/traps.c	Mon May 20 09:55:15 2002
@@ -694,6 +694,8 @@
  *
  * Careful.. There are problems with IBM-designed IRQ13 behaviour.
  * Don't touch unless you *really* know how it works.
+ *
+ * Must be called with kernel preemption disabled.
  */
 asmlinkage void math_state_restore(struct pt_regs regs)
 {
diff -urN linux-2.4.18-O1-affinity/arch/i386/lib/dec_and_lock.c linux/arch/=
i386/lib/dec_and_lock.c
--- linux-2.4.18-O1-affinity/arch/i386/lib/dec_and_lock.c	Mon May 20 09:53:=
50 2002
+++ linux/arch/i386/lib/dec_and_lock.c	Mon May 20 09:55:15 2002
@@ -8,6 +8,7 @@
  */
=20
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 #include <asm/atomic.h>
=20
 int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
diff -urN linux-2.4.18-O1-affinity/arch/mips/config.in linux/arch/mips/conf=
ig.in
--- linux-2.4.18-O1-affinity/arch/mips/config.in	Mon May 20 09:53:50 2002
+++ linux/arch/mips/config.in	Mon May 20 10:35:31 2002
@@ -330,6 +330,7 @@
 #	bool ' Access.Bus support' CONFIG_ACCESSBUS
 #    fi
 fi
+dep_bool 'Preemptible Kernel' CONFIG_PREEMPT $CONFIG_NEW_IRQ
 endmenu
=20
 if [ "$CONFIG_ISA" =3D "y" ]; then
diff -urN linux-2.4.18-O1-affinity/arch/mips/kernel/i8259.c linux/arch/mips=
/kernel/i8259.c
--- linux-2.4.18-O1-affinity/arch/mips/kernel/i8259.c	Mon May 20 09:53:51 2=
002
+++ linux/arch/mips/kernel/i8259.c	Mon May 20 10:35:31 2002
@@ -8,6 +8,7 @@
  * Copyright (C) 1992 Linus Torvalds
  * Copyright (C) 1994 - 2000 Ralf Baechle
  */
+#include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/ioport.h>
diff -urN linux-2.4.18-O1-affinity/arch/mips/kernel/irq.c linux/arch/mips/k=
ernel/irq.c
--- linux-2.4.18-O1-affinity/arch/mips/kernel/irq.c	Mon May 20 09:53:51 200=
2
+++ linux/arch/mips/kernel/irq.c	Mon May 20 10:36:16 2002
@@ -17,8 +17,11 @@
 #include <linux/mm.h>
 #include <linux/random.h>
 #include <linux/sched.h>
+#include <linux/spinlock.h>
+#include <linux/ptrace.h>
=20
 #include <asm/system.h>
+#include <asm/debug.h>
=20
 /*
  * Controller mappings for all interrupt sources:
@@ -244,6 +247,8 @@
 	struct irqaction * action;
 	unsigned int status;
=20
+	preempt_disable();
+
 	kstat.irqs[cpu][irq]++;
 	spin_lock(&desc->lock);
 	desc->handler->ack(irq);
@@ -305,6 +310,27 @@
=20
 	if (softirq_pending(cpu))
 		do_softirq();
+
+#if defined(CONFIG_PREEMPT)
+	while (--current->preempt_count =3D=3D 0) {
+		db_assert(intr_off());
+		db_assert(!in_interrupt());
+
+		if (current->need_resched =3D=3D 0) {
+			break;
+		}
+
+		current->preempt_count ++;
+		sti();
+		if (user_mode(regs)) {
+			schedule();
+		} else {
+			preempt_schedule();
+		}
+		cli();
+	}
+#endif
+
 	return 1;
 }
=20
diff -urN linux-2.4.18-O1-affinity/arch/mips/mm/extable.c linux/arch/mips/m=
m/extable.c
--- linux-2.4.18-O1-affinity/arch/mips/mm/extable.c	Mon May 20 09:53:51 200=
2
+++ linux/arch/mips/mm/extable.c	Mon May 20 10:35:31 2002
@@ -3,6 +3,7 @@
  */
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/sched.h>
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
=20
diff -urN linux-2.4.18-O1-affinity/arch/sh/config.in linux/arch/sh/config.i=
n
--- linux-2.4.18-O1-affinity/arch/sh/config.in	Mon May 20 09:53:59 2002
+++ linux/arch/sh/config.in	Mon May 20 09:55:16 2002
@@ -124,6 +124,7 @@
    hex 'Physical memory start address' CONFIG_MEMORY_START 08000000
    hex 'Physical memory size' CONFIG_MEMORY_SIZE 00400000
 fi
+bool 'Preemptible Kernel' CONFIG_PREEMPT
 endmenu
=20
 if [ "$CONFIG_SH_HP690" =3D "y" ]; then
diff -urN linux-2.4.18-O1-affinity/arch/sh/kernel/entry.S linux/arch/sh/ker=
nel/entry.S
--- linux-2.4.18-O1-affinity/arch/sh/kernel/entry.S	Mon May 20 09:53:59 200=
2
+++ linux/arch/sh/kernel/entry.S	Mon May 20 09:55:16 2002
@@ -60,10 +60,18 @@
 /*
  * These are offsets into the task-struct.
  */
-flags		=3D  4
+preempt_count	=3D  4
 sigpending	=3D  8
 need_resched	=3D 20
 tsk_ptrace	=3D 24
+flags		=3D 84
+
+/*
+ * These offsets are into irq_stat.
+ * (Find irq_cpustat_t in asm-sh/hardirq.h)
+ */
+local_irq_count =3D  8
+local_bh_count  =3D 12
=20
 PT_TRACESYS  =3D 0x00000002
 PF_USEDFPU   =3D 0x00100000
@@ -143,7 +151,7 @@
 	mov.l	__INV_IMASK, r11;	\
 	stc	sr, r10;		\
 	and	r11, r10;		\
-	stc	k_g_imask, r11;	\
+	stc	k_g_imask, r11;		\
 	or	r11, r10;		\
 	ldc	r10, sr
=20
@@ -304,8 +312,8 @@
 	mov.l	@(tsk_ptrace,r0), r0	! Is current PTRACE_SYSCALL'd?
 	mov	#PT_TRACESYS, r1
 	tst	r1, r0
-	bt	ret_from_syscall
-	bra	syscall_ret_trace
+	bf	syscall_ret_trace
+	bra	ret_from_syscall
 	 nop	=20
=20
 	.align	2
@@ -505,8 +513,6 @@
 	.long	syscall_ret_trace
 __syscall_ret:
 	.long	syscall_ret
-__INV_IMASK:
-	.long	0xffffff0f	! ~(IMASK)
=20
=20
 	.align	2
@@ -518,7 +524,84 @@
 	.align	2
 1:	.long	SYMBOL_NAME(schedule)
=20
+#ifdef CONFIG_PREEMPT=09
+	!
+	! Returning from interrupt during kernel mode: check if
+	! preempt_schedule should be called. If need_resched flag
+	! is set, preempt_count is zero, and we're not currently
+	! in an interrupt handler (local irq or bottom half) then
+	! call preempt_schedule.=20
+	!
+	! Increment preempt_count to prevent a nested interrupt
+	! from reentering preempt_schedule, then decrement after
+	! and drop through to regular interrupt return which will
+	! jump back and check again in case such an interrupt did
+	! come in (and didn't preempt due to preempt_count).
+	!
+	! NOTE:	because we just checked that preempt_count was
+	! zero before getting to the call, can't we use immediate
+	! values (1 and 0) rather than inc/dec? Also, rather than
+	! drop through to ret_from_irq, we already know this thread
+	! is kernel mode, can't we go direct to ret_from_kirq? In
+	! fact, with proper interrupt nesting and so forth could
+	! the loop simply be on the need_resched w/o checking the
+	! other stuff again? Optimize later...
+	!
+	.align	2
+ret_from_kirq:
+	! Nonzero preempt_count prevents scheduling
+	stc	k_current, r1
+	mov.l	@(preempt_count,r1), r0
+	cmp/eq	#0, r0
+	bf	restore_all
+	! Zero need_resched prevents scheduling
+	mov.l	@(need_resched,r1), r0
+	cmp/eq	#0, r0
+	bt	restore_all
+	! If in_interrupt(), don't schedule
+	mov.l	__irq_stat, r1
+	mov.l	@(local_irq_count,r1), r0
+	mov.l	@(local_bh_count,r1), r1
+	or	r1, r0
+	cmp/eq	#0, r0
+	bf	restore_all
+	! Allow scheduling using preempt_schedule
+	! Adjust preempt_count and SR as needed.
+	stc	k_current, r1
+	mov.l	@(preempt_count,r1), r0	! Could replace this ...
+	add	#1, r0			! ... and this w/mov #1?
+	mov.l	r0, @(preempt_count,r1)
+	STI()
+	mov.l	__preempt_schedule, r0
+	jsr	@r0
+	 nop=09
+	/* CLI */
+	stc	sr, r0
+	or	#0xf0, r0
+	ldc	r0, sr
+	!
+	stc	k_current, r1
+	mov.l	@(preempt_count,r1), r0	! Could replace this ...
+	add	#-1, r0			! ... and this w/mov #0?
+	mov.l	r0, @(preempt_count,r1)
+	! Maybe should bra ret_from_kirq, or loop over need_resched?
+	! For now, fall through to ret_from_irq again...
+#endif /* CONFIG_PREEMPT */
+=09
 ret_from_irq:
+	mov	#OFF_SR, r0
+	mov.l	@(r0,r15), r0	! get status register
+	shll	r0
+	shll	r0		! kernel space?
+#ifndef CONFIG_PREEMPT
+	bt	restore_all	! Yes, it's from kernel, go back soon
+#else /* CONFIG_PREEMPT */
+	bt	ret_from_kirq	! From kernel: maybe preempt_schedule
+#endif /* CONFIG_PREEMPT */
+	!
+	bra	ret_from_syscall
+	 nop
+
 ret_from_exception:
 	mov	#OFF_SR, r0
 	mov.l	@(r0,r15), r0	! get status register
@@ -564,6 +647,13 @@
 	.long	SYMBOL_NAME(do_signal)
 __irq_stat:
 	.long	SYMBOL_NAME(irq_stat)
+#ifdef CONFIG_PREEMPT
+__preempt_schedule:
+	.long	SYMBOL_NAME(preempt_schedule)
+#endif /* CONFIG_PREEMPT */=09
+__INV_IMASK:
+	.long	0xffffff0f	! ~(IMASK)
+
=20
 	.align 2
 restore_all:
@@ -679,7 +769,7 @@
 __fpu_prepare_fd:
 	.long	SYMBOL_NAME(fpu_prepare_fd)
 __init_task_flags:
-	.long	SYMBOL_NAME(init_task_union)+4
+	.long	SYMBOL_NAME(init_task_union)+flags
 __PF_USEDFPU:
 	.long	PF_USEDFPU
 #endif
diff -urN linux-2.4.18-O1-affinity/arch/sh/kernel/irq.c linux/arch/sh/kerne=
l/irq.c
--- linux-2.4.18-O1-affinity/arch/sh/kernel/irq.c	Mon May 20 09:53:59 2002
+++ linux/arch/sh/kernel/irq.c	Mon May 20 09:55:16 2002
@@ -229,6 +229,14 @@
 	struct irqaction * action;
 	unsigned int status;
=20
+	/*
+	 * At this point we're now about to actually call handlers,
+	 * and interrupts might get reenabled during them... bump
+	 * preempt_count to prevent any preemption while the handler
+ 	 * called here is pending...
+ 	 */
+ 	preempt_disable();
+
 	/* Get IRQ number */
 	asm volatile("stc	r2_bank, %0\n\t"
 		     "shlr2	%0\n\t"
@@ -298,8 +306,17 @@
 	desc->handler->end(irq);
 	spin_unlock(&desc->lock);
=20
+
 	if (softirq_pending(cpu))
 		do_softirq();
+
+	/*
+	 * We're done with the handlers, interrupts should be
+	 * currently disabled; decrement preempt_count now so
+	 * as we return preemption may be allowed...
+	 */
+	preempt_enable_no_resched();
+
 	return 1;
 }
=20
diff -urN linux-2.4.18-O1-affinity/drivers/ieee1394/csr.c linux/drivers/iee=
e1394/csr.c
--- linux-2.4.18-O1-affinity/drivers/ieee1394/csr.c	Mon May 20 09:53:43 200=
2
+++ linux/drivers/ieee1394/csr.c	Mon May 20 09:55:16 2002
@@ -10,6 +10,7 @@
  */
=20
 #include <linux/string.h>
+#include <linux/sched.h>
=20
 #include "ieee1394_types.h"
 #include "hosts.h"
diff -urN linux-2.4.18-O1-affinity/drivers/sound/sound_core.c linux/drivers=
/sound/sound_core.c
--- linux-2.4.18-O1-affinity/drivers/sound/sound_core.c	Mon May 20 09:53:34=
 2002
+++ linux/drivers/sound/sound_core.c	Mon May 20 09:55:16 2002
@@ -37,6 +37,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/kernel.h>
diff -urN linux-2.4.18-O1-affinity/fs/adfs/map.c linux/fs/adfs/map.c
--- linux-2.4.18-O1-affinity/fs/adfs/map.c	Mon May 20 09:53:04 2002
+++ linux/fs/adfs/map.c	Mon May 20 09:55:16 2002
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/adfs_fs.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
=20
 #include "adfs.h"
=20
diff -urN linux-2.4.18-O1-affinity/fs/exec.c linux/fs/exec.c
--- linux-2.4.18-O1-affinity/fs/exec.c	Mon May 20 09:53:02 2002
+++ linux/fs/exec.c	Mon May 20 09:55:16 2002
@@ -420,8 +420,8 @@
 		active_mm =3D current->active_mm;
 		current->mm =3D mm;
 		current->active_mm =3D mm;
-		task_unlock(current);
 		activate_mm(active_mm, mm);
+		task_unlock(current);
 		mm_release();
 		if (old_mm) {
 			if (active_mm !=3D old_mm) BUG();
diff -urN linux-2.4.18-O1-affinity/fs/fat/cache.c linux/fs/fat/cache.c
--- linux-2.4.18-O1-affinity/fs/fat/cache.c	Mon May 20 09:53:03 2002
+++ linux/fs/fat/cache.c	Mon May 20 09:55:16 2002
@@ -14,6 +14,7 @@
 #include <linux/string.h>
 #include <linux/stat.h>
 #include <linux/fat_cvf.h>
+#include <linux/sched.h>
=20
 #if 0
 #  define PRINTK(x) printk x
diff -urN linux-2.4.18-O1-affinity/fs/nls/nls_base.c linux/fs/nls/nls_base.=
c
--- linux-2.4.18-O1-affinity/fs/nls/nls_base.c	Mon May 20 09:53:04 2002
+++ linux/fs/nls/nls_base.c	Mon May 20 09:55:16 2002
@@ -18,6 +18,7 @@
 #ifdef CONFIG_KMOD
 #include <linux/kmod.h>
 #endif
+#include <linux/sched.h>
 #include <linux/spinlock.h>
=20
 static struct nls_table *tables;
diff -urN linux-2.4.18-O1-affinity/include/asm-arm/dma.h linux/include/asm-=
arm/dma.h
--- linux-2.4.18-O1-affinity/include/asm-arm/dma.h	Mon May 20 09:53:12 2002
+++ linux/include/asm-arm/dma.h	Mon May 20 09:55:16 2002
@@ -5,6 +5,7 @@
=20
 #include <linux/config.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 #include <asm/system.h>
 #include <asm/memory.h>
 #include <asm/scatterlist.h>
diff -urN linux-2.4.18-O1-affinity/include/asm-arm/hardirq.h linux/include/=
asm-arm/hardirq.h
--- linux-2.4.18-O1-affinity/include/asm-arm/hardirq.h	Mon May 20 09:53:12 =
2002
+++ linux/include/asm-arm/hardirq.h	Mon May 20 09:55:16 2002
@@ -34,6 +34,7 @@
 #define irq_exit(cpu,irq)	(local_irq_count(cpu)--)
=20
 #define synchronize_irq()	do { } while (0)
+#define release_irqlock(cpu)	do { } while (0)
=20
 #else
 #error SMP not supported
diff -urN linux-2.4.18-O1-affinity/include/asm-arm/pgalloc.h linux/include/=
asm-arm/pgalloc.h
--- linux-2.4.18-O1-affinity/include/asm-arm/pgalloc.h	Mon May 20 09:53:13 =
2002
+++ linux/include/asm-arm/pgalloc.h	Mon May 20 09:55:16 2002
@@ -57,40 +57,48 @@
 {
 	unsigned long *ret;
=20
+	preempt_disable();
 	if ((ret =3D pgd_quicklist) !=3D NULL) {
 		pgd_quicklist =3D (unsigned long *)__pgd_next(ret);
 		ret[1] =3D ret[2];
 		clean_dcache_entry(ret + 1);
 		pgtable_cache_size--;
 	}
+	preempt_enable();
 	return (pgd_t *)ret;
 }
=20
 static inline void free_pgd_fast(pgd_t *pgd)
 {
+	preempt_disable();
 	__pgd_next(pgd) =3D (unsigned long) pgd_quicklist;
 	pgd_quicklist =3D (unsigned long *) pgd;
 	pgtable_cache_size++;
+	preempt_enable();
 }
=20
 static inline pte_t *pte_alloc_one_fast(struct mm_struct *mm, unsigned lon=
g address)
 {
 	unsigned long *ret;
=20
+	preempt_disable();
 	if((ret =3D pte_quicklist) !=3D NULL) {
 		pte_quicklist =3D (unsigned long *)__pte_next(ret);
 		ret[0] =3D 0;
 		clean_dcache_entry(ret);
 		pgtable_cache_size--;
 	}
+	preempt_enable();
 	return (pte_t *)ret;
 }
=20
 static inline void free_pte_fast(pte_t *pte)
 {
+	preempt_disable();
 	__pte_next(pte) =3D (unsigned long) pte_quicklist;
 	pte_quicklist =3D (unsigned long *) pte;
 	pgtable_cache_size++;
+	preempt_enable();
 }
=20
 #else	/* CONFIG_NO_PGT_CACHE */
diff -urN linux-2.4.18-O1-affinity/include/asm-arm/smplock.h linux/include/=
asm-arm/smplock.h
--- linux-2.4.18-O1-affinity/include/asm-arm/smplock.h	Mon May 20 09:53:12 =
2002
+++ linux/include/asm-arm/smplock.h	Mon May 20 09:55:16 2002
@@ -3,12 +3,17 @@
  *
  * Default SMP lock implementation
  */
+#include <linux/config.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
=20
 extern spinlock_t kernel_flag;
=20
+#ifdef CONFIG_PREEMPT
+#define kernel_locked()		preempt_get_count()
+#else
 #define kernel_locked()		spin_is_locked(&kernel_flag)
+#endif
=20
 /*
  * Release global kernel lock and global interrupt lock
@@ -40,8 +45,14 @@
  */
 static inline void lock_kernel(void)
 {
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth =3D=3D -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
+#else
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
+#endif
 }
=20
 static inline void unlock_kernel(void)
diff -urN linux-2.4.18-O1-affinity/include/asm-arm/softirq.h linux/include/=
asm-arm/softirq.h
--- linux-2.4.18-O1-affinity/include/asm-arm/softirq.h	Mon May 20 09:53:12 =
2002
+++ linux/include/asm-arm/softirq.h	Mon May 20 09:55:16 2002
@@ -5,20 +5,22 @@
 #include <asm/hardirq.h>
=20
 #define __cpu_bh_enable(cpu) \
-		do { barrier(); local_bh_count(cpu)--; } while (0)
+		do { barrier(); local_bh_count(cpu)--; preempt_enable(); } while (0)
 #define cpu_bh_disable(cpu) \
-		do { local_bh_count(cpu)++; barrier(); } while (0)
+		do { preempt_disable(); local_bh_count(cpu)++; barrier(); } while (0)
=20
 #define local_bh_disable()	cpu_bh_disable(smp_processor_id())
 #define __local_bh_enable()	__cpu_bh_enable(smp_processor_id())
=20
 #define in_softirq()		(local_bh_count(smp_processor_id()) !=3D 0)
=20
-#define local_bh_enable()						\
+#define _local_bh_enable()						\
 do {									\
 	unsigned int *ptr =3D &local_bh_count(smp_processor_id());	\
 	if (!--*ptr && ptr[-2])						\
 		__asm__("bl%? __do_softirq": : : "lr");/* out of line */\
 } while (0)
=20
+#define local_bh_enable() do { _local_bh_enable(); preempt_enable(); } whi=
le (0)
+
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN linux-2.4.18-O1-affinity/include/asm-i386/hardirq.h linux/include=
/asm-i386/hardirq.h
--- linux-2.4.18-O1-affinity/include/asm-i386/hardirq.h	Mon May 20 09:53:09=
 2002
+++ linux/include/asm-i386/hardirq.h	Mon May 20 10:42:34 2002
@@ -36,6 +36,8 @@
=20
 #define synchronize_irq()	barrier()
=20
+#define release_irqlock(cpu)	do { } while (0)
+
 #else
=20
 #include <asm/atomic.h>
diff -urN linux-2.4.18-O1-affinity/include/asm-i386/highmem.h linux/include=
/asm-i386/highmem.h
--- linux-2.4.18-O1-affinity/include/asm-i386/highmem.h	Mon May 20 09:53:09=
 2002
+++ linux/include/asm-i386/highmem.h	Mon May 20 10:42:45 2002
@@ -88,6 +88,7 @@
 	enum fixed_addresses idx;
 	unsigned long vaddr;
=20
+	preempt_disable();
 	if (page < highmem_start_page)
 		return page_address(page);
=20
@@ -109,8 +110,10 @@
 	unsigned long vaddr =3D (unsigned long) kvaddr;
 	enum fixed_addresses idx =3D type + KM_TYPE_NR*smp_processor_id();
=20
-	if (vaddr < FIXADDR_START) // FIXME
+	if (vaddr < FIXADDR_START) { // FIXME
+		preempt_enable();
 		return;
+	}
=20
 	if (vaddr !=3D __fix_to_virt(FIX_KMAP_BEGIN+idx))
 		BUG();
@@ -122,6 +125,8 @@
 	pte_clear(kmap_pte-idx);
 	__flush_tlb_one(vaddr);
 #endif
+
+	preempt_enable();
 }
=20
 #endif /* __KERNEL__ */
diff -urN linux-2.4.18-O1-affinity/include/asm-i386/hw_irq.h linux/include/=
asm-i386/hw_irq.h
--- linux-2.4.18-O1-affinity/include/asm-i386/hw_irq.h	Mon May 20 09:53:09 =
2002
+++ linux/include/asm-i386/hw_irq.h	Mon May 20 10:42:34 2002
@@ -95,6 +95,18 @@
 #define __STR(x) #x
 #define STR(x) __STR(x)
=20
+#define GET_CURRENT \
+	"movl %esp, %ebx\n\t" \
+	"andl $-8192, %ebx\n\t"
+
+#ifdef CONFIG_PREEMPT
+#define BUMP_LOCK_COUNT \
+	GET_CURRENT \
+	"incl 4(%ebx)\n\t"
+#else
+#define BUMP_LOCK_COUNT
+#endif
+
 #define SAVE_ALL \
 	"cld\n\t" \
 	"pushl %es\n\t" \
@@ -108,15 +120,12 @@
 	"pushl %ebx\n\t" \
 	"movl $" STR(__KERNEL_DS) ",%edx\n\t" \
 	"movl %edx,%ds\n\t" \
-	"movl %edx,%es\n\t"
+	"movl %edx,%es\n\t" \
+	BUMP_LOCK_COUNT
=20
 #define IRQ_NAME2(nr) nr##_interrupt(void)
 #define IRQ_NAME(nr) IRQ_NAME2(IRQ##nr)
=20
-#define GET_CURRENT \
-	"movl %esp, %ebx\n\t" \
-	"andl $-8192, %ebx\n\t"
-
 /*
  *	SMP has a few special interrupts for IPI messages
  */
diff -urN linux-2.4.18-O1-affinity/include/asm-i386/i387.h linux/include/as=
m-i386/i387.h
--- linux-2.4.18-O1-affinity/include/asm-i386/i387.h	Mon May 20 09:53:09 20=
02
+++ linux/include/asm-i386/i387.h	Mon May 20 10:47:56 2002
@@ -12,6 +12,7 @@
 #define __ASM_I386_I387_H
=20
 #include <linux/sched.h>
+#include <linux/spinlock.h>
 #include <asm/processor.h>
 #include <asm/sigcontext.h>
 #include <asm/user.h>
@@ -24,7 +25,7 @@
 extern void restore_fpu( struct task_struct *tsk );
=20
 extern void kernel_fpu_begin(void);
-#define kernel_fpu_end() stts()
+#define kernel_fpu_end() do { stts(); preempt_enable(); } while(0)
=20
=20
 #define unlazy_fpu( tsk ) do { \
diff -urN linux-2.4.18-O1-affinity/include/asm-i386/pgalloc.h linux/include=
/asm-i386/pgalloc.h
--- linux-2.4.18-O1-affinity/include/asm-i386/pgalloc.h	Mon May 20 09:53:09=
 2002
+++ linux/include/asm-i386/pgalloc.h	Mon May 20 10:42:34 2002
@@ -75,20 +75,26 @@
 {
 	unsigned long *ret;
=20
+	preempt_disable();
 	if ((ret =3D pgd_quicklist) !=3D NULL) {
 		pgd_quicklist =3D (unsigned long *)(*ret);
 		ret[0] =3D 0;
 		pgtable_cache_size--;
-	} else
+		preempt_enable();
+	} else {
+		preempt_enable();
 		ret =3D (unsigned long *)get_pgd_slow();
+	}
 	return (pgd_t *)ret;
 }
=20
 static inline void free_pgd_fast(pgd_t *pgd)
 {
+	preempt_disable();
 	*(unsigned long *)pgd =3D (unsigned long) pgd_quicklist;
 	pgd_quicklist =3D (unsigned long *) pgd;
 	pgtable_cache_size++;
+	preempt_enable();
 }
=20
 static inline void free_pgd_slow(pgd_t *pgd)
@@ -119,19 +125,23 @@
 {
 	unsigned long *ret;
=20
+	preempt_disable();
 	if ((ret =3D (unsigned long *)pte_quicklist) !=3D NULL) {
 		pte_quicklist =3D (unsigned long *)(*ret);
 		ret[0] =3D ret[1];
 		pgtable_cache_size--;
 	}
+	preempt_enable();
 	return (pte_t *)ret;
 }
=20
 static inline void pte_free_fast(pte_t *pte)
 {
+	preempt_disable();
 	*(unsigned long *)pte =3D (unsigned long) pte_quicklist;
 	pte_quicklist =3D (unsigned long *) pte;
 	pgtable_cache_size++;
+	preempt_enable();
 }
=20
 static __inline__ void pte_free_slow(pte_t *pte)
diff -urN linux-2.4.18-O1-affinity/include/asm-i386/smplock.h linux/include=
/asm-i386/smplock.h
--- linux-2.4.18-O1-affinity/include/asm-i386/smplock.h	Mon May 20 09:53:09=
 2002
+++ linux/include/asm-i386/smplock.h	Mon May 20 10:42:34 2002
@@ -10,7 +10,15 @@
=20
 extern spinlock_t kernel_flag;
=20
+#ifdef CONFIG_SMP
 #define kernel_locked()		spin_is_locked(&kernel_flag)
+#else
+#ifdef CONFIG_PREEMPT
+#define kernel_locked()		preempt_get_count()
+#else
+#define kernel_locked()		1
+#endif
+#endif
=20
 /*
  * Release global kernel lock and global interrupt lock
@@ -42,6 +50,11 @@
  */
 static __inline__ void lock_kernel(void)
 {
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth =3D=3D -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
+#else
 #if 1
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
@@ -54,6 +67,7 @@
 		:"=3Dm" (__dummy_lock(&kernel_flag)),
 		 "=3Dm" (current->lock_depth));
 #endif
+#endif
 }
=20
 static __inline__ void unlock_kernel(void)
diff -urN linux-2.4.18-O1-affinity/include/asm-i386/softirq.h linux/include=
/asm-i386/softirq.h
--- linux-2.4.18-O1-affinity/include/asm-i386/softirq.h	Mon May 20 09:53:09=
 2002
+++ linux/include/asm-i386/softirq.h	Mon May 20 10:42:34 2002
@@ -6,9 +6,9 @@
 #include <linux/stringify.h>
=20
 #define __cpu_bh_enable(cpu) \
-		do { barrier(); local_bh_count(cpu)--; } while (0)
+		do { barrier(); local_bh_count(cpu)--; preempt_enable(); } while (0)
 #define cpu_bh_disable(cpu) \
-		do { local_bh_count(cpu)++; barrier(); } while (0)
+		do { preempt_disable(); local_bh_count(cpu)++; barrier(); } while (0)
=20
 #define local_bh_disable()	cpu_bh_disable(smp_processor_id())
 #define __local_bh_enable()	__cpu_bh_enable(smp_processor_id())
@@ -23,7 +23,7 @@
  * If you change the offsets in irq_stat then you have to
  * update this code as well.
  */
-#define local_bh_enable()						\
+#define _local_bh_enable()						\
 do {									\
 	unsigned int *ptr =3D &local_bh_count(smp_processor_id());	\
 									\
@@ -49,4 +49,6 @@
 		/* no registers clobbered */ );				\
 } while (0)
=20
+#define local_bh_enable() do { _local_bh_enable(); preempt_enable(); } whi=
le (0)
+
 #endif	/* __ASM_SOFTIRQ_H */
diff -urN linux-2.4.18-O1-affinity/include/asm-i386/spinlock.h linux/includ=
e/asm-i386/spinlock.h
--- linux-2.4.18-O1-affinity/include/asm-i386/spinlock.h	Mon May 20 09:53:0=
9 2002
+++ linux/include/asm-i386/spinlock.h	Mon May 20 10:42:33 2002
@@ -81,7 +81,7 @@
 		:"=3Dm" (lock->lock) : : "memory"
=20
=20
-static inline void spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 #if SPINLOCK_DEBUG
 	if (lock->magic !=3D SPINLOCK_MAGIC)
@@ -101,7 +101,7 @@
 		:"=3Dq" (oldval), "=3Dm" (lock->lock) \
 		:"0" (oldval) : "memory"
=20
-static inline void spin_unlock(spinlock_t *lock)
+static inline void _raw_spin_unlock(spinlock_t *lock)
 {
 	char oldval =3D 1;
 #if SPINLOCK_DEBUG
@@ -117,7 +117,7 @@
=20
 #endif
=20
-static inline int spin_trylock(spinlock_t *lock)
+static inline int _raw_spin_trylock(spinlock_t *lock)
 {
 	char oldval;
 	__asm__ __volatile__(
@@ -127,7 +127,7 @@
 	return oldval > 0;
 }
=20
-static inline void spin_lock(spinlock_t *lock)
+static inline void _raw_spin_lock(spinlock_t *lock)
 {
 #if SPINLOCK_DEBUG
 	__label__ here;
@@ -183,7 +183,7 @@
  */
 /* the spinlock helpers are in arch/i386/kernel/semaphore.c */
=20
-static inline void read_lock(rwlock_t *rw)
+static inline void _raw_read_lock(rwlock_t *rw)
 {
 #if SPINLOCK_DEBUG
 	if (rw->magic !=3D RWLOCK_MAGIC)
@@ -192,7 +192,7 @@
 	__build_read_lock(rw, "__read_lock_failed");
 }
=20
-static inline void write_lock(rwlock_t *rw)
+static inline void _raw_write_lock(rwlock_t *rw)
 {
 #if SPINLOCK_DEBUG
 	if (rw->magic !=3D RWLOCK_MAGIC)
@@ -201,10 +201,10 @@
 	__build_write_lock(rw, "__write_lock_failed");
 }
=20
-#define read_unlock(rw)		asm volatile("lock ; incl %0" :"=3Dm" ((rw)->lock=
) : : "memory")
-#define write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ",%=
0":"=3Dm" ((rw)->lock) : : "memory")
+#define _raw_read_unlock(rw)		asm volatile("lock ; incl %0" :"=3Dm" ((rw)-=
>lock) : : "memory")
+#define _raw_write_unlock(rw)	asm volatile("lock ; addl $" RW_LOCK_BIAS_ST=
R ",%0":"=3Dm" ((rw)->lock) : : "memory")
=20
-static inline int write_trylock(rwlock_t *lock)
+static inline int _raw_write_trylock(rwlock_t *lock)
 {
 	atomic_t *count =3D (atomic_t *)lock;
 	if (atomic_sub_and_test(RW_LOCK_BIAS, count))
diff -urN linux-2.4.18-O1-affinity/include/asm-mips/smplock.h linux/include=
/asm-mips/smplock.h
--- linux-2.4.18-O1-affinity/include/asm-mips/smplock.h	Mon May 20 09:53:10=
 2002
+++ linux/include/asm-mips/smplock.h	Mon May 20 10:35:32 2002
@@ -6,12 +6,21 @@
  *
  * Default SMP lock implementation
  */
+#include <linux/config.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
=20
 extern spinlock_t kernel_flag;
=20
+#ifdef CONFIG_SMP
 #define kernel_locked()		spin_is_locked(&kernel_flag)
+#else
+#ifdef CONFIG_PREEMPT
+#define kernel_locked()         preempt_get_count()
+#else
+#define kernel_locked()         1
+#endif
+#endif
=20
 /*
  * Release global kernel lock and global interrupt lock
@@ -43,8 +52,14 @@
  */
 extern __inline__ void lock_kernel(void)
 {
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth =3D=3D -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
+#else
 	if (!++current->lock_depth)
 		spin_lock(&kernel_flag);
+#endif
 }
=20
 extern __inline__ void unlock_kernel(void)
diff -urN linux-2.4.18-O1-affinity/include/asm-mips/softirq.h linux/include=
/asm-mips/softirq.h
--- linux-2.4.18-O1-affinity/include/asm-mips/softirq.h	Mon May 20 09:53:10=
 2002
+++ linux/include/asm-mips/softirq.h	Mon May 20 10:35:32 2002
@@ -15,6 +15,7 @@
=20
 extern inline void cpu_bh_disable(int cpu)
 {
+	preempt_disable();
 	local_bh_count(cpu)++;
 	barrier();
 }
@@ -23,6 +24,7 @@
 {
 	barrier();
 	local_bh_count(cpu)--;
+	preempt_enable();
 }
=20
=20
@@ -36,6 +38,7 @@
 	cpu =3D smp_processor_id();				\
 	if (!--local_bh_count(cpu) && softirq_pending(cpu))	\
 		do_softirq();					\
+	preempt_enable();                                       \
 } while (0)
=20
 #define in_softirq() (local_bh_count(smp_processor_id()) !=3D 0)
diff -urN linux-2.4.18-O1-affinity/include/asm-mips/system.h linux/include/=
asm-mips/system.h
--- linux-2.4.18-O1-affinity/include/asm-mips/system.h	Mon May 20 09:53:09 =
2002
+++ linux/include/asm-mips/system.h	Mon May 20 10:35:32 2002
@@ -261,4 +261,16 @@
 #define die_if_kernel(msg, regs)					\
 	__die_if_kernel(msg, regs, __FILE__ ":"__FUNCTION__, __LINE__)
=20
+extern __inline__ int intr_on(void)
+{
+	unsigned long flags;
+	save_flags(flags);
+	return flags & 1;
+}
+
+extern __inline__ int intr_off(void)
+{
+	return ! intr_on();
+}
+
 #endif /* _ASM_SYSTEM_H */
diff -urN linux-2.4.18-O1-affinity/include/asm-sh/hardirq.h linux/include/a=
sm-sh/hardirq.h
--- linux-2.4.18-O1-affinity/include/asm-sh/hardirq.h	Mon May 20 09:53:13 2=
002
+++ linux/include/asm-sh/hardirq.h	Mon May 20 09:55:16 2002
@@ -34,6 +34,8 @@
=20
 #define synchronize_irq()	barrier()
=20
+#define release_irqlock(cpu)	do { } while (0)
+
 #else
=20
 #error Super-H SMP is not available
diff -urN linux-2.4.18-O1-affinity/include/asm-sh/smplock.h linux/include/a=
sm-sh/smplock.h
--- linux-2.4.18-O1-affinity/include/asm-sh/smplock.h	Mon May 20 09:53:13 2=
002
+++ linux/include/asm-sh/smplock.h	Mon May 20 09:55:16 2002
@@ -9,15 +9,88 @@
=20
 #include <linux/config.h>
=20
-#ifndef CONFIG_SMP
-
+#if !defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT)
+/*
+ * Should never happen, since linux/smp_lock.h catches this case;
+ * but in case this file is included directly with neither SMP nor
+ * PREEMPT configuration, provide same dummys as linux/smp_lock.h
+ */
 #define lock_kernel()				do { } while(0)
 #define unlock_kernel()				do { } while(0)
-#define release_kernel_lock(task, cpu, depth)	((depth) =3D 1)
-#define reacquire_kernel_lock(task, cpu, depth)	do { } while(0)
+#define release_kernel_lock(task, cpu)		do { } while(0)
+#define reacquire_kernel_lock(task)		do { } while(0)
+#define kernel_locked()		1
+
+#else /* CONFIG_SMP || CONFIG_PREEMPT */
+
+#if CONFIG_SMP
+#error "We do not support SMP on SH yet"
+#endif
+/*
+ * Default SMP lock implementation (i.e. the i386 version)
+ */
+
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+extern spinlock_t kernel_flag;
+#define lock_bkl() spin_lock(&kernel_flag)
+#define unlock_bkl() spin_unlock(&kernel_flag)
=20
+#ifdef CONFIG_SMP
+#define kernel_locked()		spin_is_locked(&kernel_flag)
+#elif  CONFIG_PREEMPT
+#define kernel_locked()		preempt_get_count()
+#else  /* neither */
+#define kernel_locked()		1
+#endif
+
+/*
+ * Release global kernel lock and global interrupt lock
+ */
+#define release_kernel_lock(task, cpu) \
+do { \
+	if (task->lock_depth >=3D 0) \
+		spin_unlock(&kernel_flag); \
+	release_irqlock(cpu); \
+	__sti(); \
+} while (0)
+
+/*
+ * Re-acquire the kernel lock
+ */
+#define reacquire_kernel_lock(task) \
+do { \
+	if (task->lock_depth >=3D 0) \
+		spin_lock(&kernel_flag); \
+} while (0)
+
+/*
+ * Getting the big kernel lock.
+ *
+ * This cannot happen asynchronously,
+ * so we only need to worry about other
+ * CPU's.
+ */
+static __inline__ void lock_kernel(void)
+{
+#ifdef CONFIG_PREEMPT
+	if (current->lock_depth =3D=3D -1)
+		spin_lock(&kernel_flag);
+	++current->lock_depth;
 #else
-#error "We do not support SMP on SH"
-#endif /* CONFIG_SMP */
+	if (!++current->lock_depth)
+		spin_lock(&kernel_flag);
+#endif
+}
+
+static __inline__ void unlock_kernel(void)
+{
+	if (current->lock_depth < 0)
+		BUG();
+	if (--current->lock_depth < 0)
+		spin_unlock(&kernel_flag);
+}
+#endif /* CONFIG_SMP || CONFIG_PREEMPT */
=20
 #endif /* __ASM_SH_SMPLOCK_H */
diff -urN linux-2.4.18-O1-affinity/include/asm-sh/softirq.h linux/include/a=
sm-sh/softirq.h
--- linux-2.4.18-O1-affinity/include/asm-sh/softirq.h	Mon May 20 09:53:13 2=
002
+++ linux/include/asm-sh/softirq.h	Mon May 20 09:55:16 2002
@@ -6,6 +6,7 @@
=20
 #define local_bh_disable()			\
 do {						\
+	preempt_disable();			\
 	local_bh_count(smp_processor_id())++;	\
 	barrier();				\
 } while (0)
@@ -14,6 +15,7 @@
 do {						\
 	barrier();				\
 	local_bh_count(smp_processor_id())--;	\
+	preempt_enable();			\
 } while (0)
=20
 #define local_bh_enable()				\
@@ -23,6 +25,7 @@
 	    && softirq_pending(smp_processor_id())) {	\
 		do_softirq();				\
 	}						\
+	preempt_enable();				\
 } while (0)
=20
 #define in_softirq() (local_bh_count(smp_processor_id()) !=3D 0)
diff -urN linux-2.4.18-O1-affinity/include/linux/brlock.h linux/include/lin=
ux/brlock.h
--- linux-2.4.18-O1-affinity/include/linux/brlock.h	Mon May 20 09:53:08 200=
2
+++ linux/include/linux/brlock.h	Mon May 20 10:46:20 2002
@@ -171,11 +171,11 @@
 }
=20
 #else
-# define br_read_lock(idx)	((void)(idx))
-# define br_read_unlock(idx)	((void)(idx))
-# define br_write_lock(idx)	((void)(idx))
-# define br_write_unlock(idx)	((void)(idx))
-#endif
+# define br_read_lock(idx)	({ (void)(idx); preempt_disable(); })
+# define br_read_unlock(idx)	({ (void)(idx); preempt_enable(); })
+# define br_write_lock(idx)	({ (void)(idx); preempt_disable(); })
+# define br_write_unlock(idx)	({ (void)(idx); preempt_enable(); })
+#endif	/* CONFIG_SMP */
=20
 /*
  * Now enumerate all of the possible sw/hw IRQ protected
diff -urN linux-2.4.18-O1-affinity/include/linux/dcache.h linux/include/lin=
ux/dcache.h
--- linux-2.4.18-O1-affinity/include/linux/dcache.h	Mon May 20 09:53:07 200=
2
+++ linux/include/linux/dcache.h	Mon May 20 10:42:33 2002
@@ -126,31 +126,6 @@
=20
 extern spinlock_t dcache_lock;
=20
-/**
- * d_drop - drop a dentry
- * @dentry: dentry to drop
- *
- * d_drop() unhashes the entry from the parent
- * dentry hashes, so that it won't be found through
- * a VFS lookup any more. Note that this is different
- * from deleting the dentry - d_delete will try to
- * mark the dentry negative if possible, giving a
- * successful _negative_ lookup, while d_drop will
- * just make the cache lookup fail.
- *
- * d_drop() is used mainly for stuff that wants
- * to invalidate a dentry for some reason (NFS
- * timeouts or autofs deletes).
- */
-
-static __inline__ void d_drop(struct dentry * dentry)
-{
-	spin_lock(&dcache_lock);
-	list_del(&dentry->d_hash);
-	INIT_LIST_HEAD(&dentry->d_hash);
-	spin_unlock(&dcache_lock);
-}
-
 static __inline__ int dname_external(struct dentry *d)
 {
 	return d->d_name.name !=3D d->d_iname;=20
@@ -275,3 +250,34 @@
 #endif /* __KERNEL__ */
=20
 #endif	/* __LINUX_DCACHE_H */
+
+#if !defined(__LINUX_DCACHE_H_INLINES) && defined(_TASK_STRUCT_DEFINED)
+#define __LINUX_DCACHE_H_INLINES
+
+#ifdef __KERNEL__
+/**
+ * d_drop - drop a dentry
+ * @dentry: dentry to drop
+ *
+ * d_drop() unhashes the entry from the parent
+ * dentry hashes, so that it won't be found through
+ * a VFS lookup any more. Note that this is different
+ * from deleting the dentry - d_delete will try to
+ * mark the dentry negative if possible, giving a
+ * successful _negative_ lookup, while d_drop will
+ * just make the cache lookup fail.
+ *
+ * d_drop() is used mainly for stuff that wants
+ * to invalidate a dentry for some reason (NFS
+ * timeouts or autofs deletes).
+ */
+
+static __inline__ void d_drop(struct dentry * dentry)
+{
+	spin_lock(&dcache_lock);
+	list_del(&dentry->d_hash);
+	INIT_LIST_HEAD(&dentry->d_hash);
+	spin_unlock(&dcache_lock);
+}
+#endif
+#endif
diff -urN linux-2.4.18-O1-affinity/include/linux/fs_struct.h linux/include/=
linux/fs_struct.h
--- linux-2.4.18-O1-affinity/include/linux/fs_struct.h	Mon May 20 09:53:08 =
2002
+++ linux/include/linux/fs_struct.h	Mon May 20 09:55:16 2002
@@ -20,6 +20,15 @@
 extern void exit_fs(struct task_struct *);
 extern void set_fs_altroot(void);
=20
+struct fs_struct *copy_fs_struct(struct fs_struct *old);
+void put_fs_struct(struct fs_struct *fs);
+
+#endif
+#endif
+
+#if !defined(_LINUX_FS_STRUCT_H_INLINES) && defined(_TASK_STRUCT_DEFINED)
+#define _LINUX_FS_STRUCT_H_INLINES
+#ifdef __KERNEL__
 /*
  * Replace the fs->{rootmnt,root} with {mnt,dentry}. Put the old values.
  * It can block. Requires the big lock held.
@@ -65,9 +74,5 @@
 		mntput(old_pwdmnt);
 	}
 }
-
-struct fs_struct *copy_fs_struct(struct fs_struct *old);
-void put_fs_struct(struct fs_struct *fs);
-
 #endif
 #endif
diff -urN linux-2.4.18-O1-affinity/include/linux/sched.h linux/include/linu=
x/sched.h
--- linux-2.4.18-O1-affinity/include/linux/sched.h	Mon May 20 09:53:06 2002
+++ linux/include/linux/sched.h	Mon May 20 10:42:34 2002
@@ -91,6 +91,7 @@
 #define TASK_UNINTERRUPTIBLE	2
 #define TASK_ZOMBIE		4
 #define TASK_STOPPED		8
+#define PREEMPT_ACTIVE		0x4000000
=20
 #define __set_task_state(tsk, state_value)		\
 	do { (tsk)->state =3D (state_value); } while (0)
@@ -155,6 +156,9 @@
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
+#ifdef CONFIG_PREEMPT
+asmlinkage void preempt_schedule(void);
+#endif
=20
 extern int schedule_task(struct tq_struct *task);
 extern void flush_scheduled_tasks(void);
@@ -332,7 +336,7 @@
 	 * offsets of these are hardcoded elsewhere - touch with care
 	 */
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
-	unsigned long flags;	/* per process flags, defined below */
+	int preempt_count;	/* 0 =3D> preemptable, <0 =3D> BUG */
 	int sigpending;
 	mm_segment_t addr_limit;	/* thread address space:
 					 	0-0xBFFFFFFF for user-thead
@@ -358,6 +362,7 @@
 	unsigned long policy;
 	unsigned long cpus_allowed;
 	unsigned int time_slice;
+	unsigned long flags;
=20
 	task_t *next_task, *prev_task;
=20
@@ -976,6 +981,11 @@
 	return unlikely(current->need_resched);
 }
=20
+#define _TASK_STRUCT_DEFINED
+#include <linux/dcache.h>
+#include <linux/tqueue.h>
+#include <linux/fs_struct.h>
+
 #endif /* __KERNEL__ */
=20
 #endif
diff -urN linux-2.4.18-O1-affinity/include/linux/smp.h linux/include/linux/=
smp.h
--- linux-2.4.18-O1-affinity/include/linux/smp.h	Mon May 20 09:53:08 2002
+++ linux/include/linux/smp.h	Mon May 20 10:42:34 2002
@@ -81,7 +81,9 @@
 #define smp_processor_id()			0
 #define hard_smp_processor_id()			0
 #define smp_threads_ready			1
+#ifndef CONFIG_PREEMPT
 #define kernel_lock()
+#endif
 #define cpu_logical_map(cpu)			0
 #define cpu_number_map(cpu)			0
 #define smp_call_function(func,info,retry,wait)	({ 0; })
diff -urN linux-2.4.18-O1-affinity/include/linux/smp_lock.h linux/include/l=
inux/smp_lock.h
--- linux-2.4.18-O1-affinity/include/linux/smp_lock.h	Mon May 20 09:53:07 2=
002
+++ linux/include/linux/smp_lock.h	Mon May 20 10:42:34 2002
@@ -3,7 +3,7 @@
=20
 #include <linux/config.h>
=20
-#ifndef CONFIG_SMP
+#if !defined(CONFIG_SMP) && !defined(CONFIG_PREEMPT)
=20
 #define lock_kernel()				do { } while(0)
 #define unlock_kernel()				do { } while(0)
diff -urN linux-2.4.18-O1-affinity/include/linux/spinlock.h linux/include/l=
inux/spinlock.h
--- linux-2.4.18-O1-affinity/include/linux/spinlock.h	Mon May 20 09:53:08 2=
002
+++ linux/include/linux/spinlock.h	Mon May 20 12:21:55 2002
@@ -2,6 +2,7 @@
 #define __LINUX_SPINLOCK_H
=20
 #include <linux/config.h>
+#include <linux/compiler.h>
=20
 /*
  * These are the generic versions of the spinlocks and read-write
@@ -45,8 +46,10 @@
=20
 #if (DEBUG_SPINLOCKS < 1)
=20
+#ifndef CONFIG_PREEMPT
 #define atomic_dec_and_lock(atomic,lock) atomic_dec_and_test(atomic)
 #define ATOMIC_DEC_AND_LOCK
+#endif
=20
 /*
  * Your basic spinlocks, allowing only a single CPU anywhere
@@ -62,11 +65,11 @@
 #endif
=20
 #define spin_lock_init(lock)	do { } while(0)
-#define spin_lock(lock)		(void)(lock) /* Not "unused variable". */
+#define _raw_spin_lock(lock)	(void)(lock) /* Not "unused variable". */
 #define spin_is_locked(lock)	(0)
-#define spin_trylock(lock)	({1; })
+#define _raw_spin_trylock(lock)	({1; })
 #define spin_unlock_wait(lock)	do { } while(0)
-#define spin_unlock(lock)	do { } while(0)
+#define _raw_spin_unlock(lock)	do { } while(0)
=20
 #elif (DEBUG_SPINLOCKS < 2)
=20
@@ -125,13 +128,84 @@
 #endif
=20
 #define rwlock_init(lock)	do { } while(0)
-#define read_lock(lock)		(void)(lock) /* Not "unused variable". */
-#define read_unlock(lock)	do { } while(0)
-#define write_lock(lock)	(void)(lock) /* Not "unused variable". */
-#define write_unlock(lock)	do { } while(0)
+#define _raw_read_lock(lock)	(void)(lock) /* Not "unused variable". */
+#define _raw_read_unlock(lock)	do { } while(0)
+#define _raw_write_lock(lock)	(void)(lock) /* Not "unused variable". */
+#define _raw_write_unlock(lock)	do { } while(0)
=20
 #endif /* !SMP */
=20
+#ifdef CONFIG_PREEMPT
+
+#define preempt_get_count() (current->preempt_count)
+
+#define preempt_disable() \
+do { \
+	++current->preempt_count; \
+	barrier(); \
+} while (0)
+
+#define preempt_enable_no_resched() \
+do { \
+	--current->preempt_count; \
+	barrier(); \
+} while (0)
+
+#define preempt_enable() \
+do { \
+	--current->preempt_count; \
+	barrier(); \
+	if (unlikely(current->preempt_count < current->need_resched)) \
+		preempt_schedule(); \
+} while (0)
+
+#define spin_lock(lock)	\
+do { \
+	preempt_disable(); \
+	_raw_spin_lock(lock); \
+} while(0)
+
+#define spin_trylock(lock)	({preempt_disable(); _raw_spin_trylock(lock) ? =
\
+				1 : ({preempt_enable(); 0;});})
+#define spin_unlock(lock) \
+do { \
+	_raw_spin_unlock(lock); \
+	preempt_enable(); \
+} while (0)
+
+#define read_lock(lock)		({preempt_disable(); _raw_read_lock(lock);})
+#define read_unlock(lock)	({_raw_read_unlock(lock); preempt_enable();})
+#define write_lock(lock)	({preempt_disable(); _raw_write_lock(lock);})
+#define write_unlock(lock)	({_raw_write_unlock(lock); preempt_enable();})
+#define write_trylock(lock)	({preempt_disable();_raw_write_trylock(lock) ?=
 \
+				1 : ({preempt_enable(); 0;});})
+
+#else
+
+#define preempt_get_count()	(0)
+#define preempt_disable()	do { } while (0)
+#define preempt_enable_no_resched()	do {} while(0)
+#define preempt_enable()	do { } while (0)
+
+/*
+ * Only define these if there actually are _raw_* functions
+ * defined.  This is a temporary measure as some architectures
+ * do not yet support kernel preemption.
+ */
+#ifdef _raw_read_unlock
+#define spin_lock(lock)		_raw_spin_lock(lock)
+#define spin_trylock(lock)	_raw_spin_trylock(lock)
+#define spin_unlock(lock)	_raw_spin_unlock(lock)
+
+#define read_lock(lock)		_raw_read_lock(lock)
+#define read_unlock(lock)	_raw_read_unlock(lock)
+#define write_lock(lock)	_raw_write_lock(lock)
+#define write_unlock(lock)	_raw_write_unlock(lock)
+#define write_trylock(lock)	_raw_write_trylock(lock)
+#endif
+
+#endif
+
 /* "lock on reference count zero" */
 #ifndef ATOMIC_DEC_AND_LOCK
 #include <asm/atomic.h>
diff -urN linux-2.4.18-O1-affinity/include/linux/tqueue.h linux/include/lin=
ux/tqueue.h
--- linux-2.4.18-O1-affinity/include/linux/tqueue.h	Mon May 20 09:53:06 200=
2
+++ linux/include/linux/tqueue.h	Mon May 20 10:42:34 2002
@@ -94,6 +94,22 @@
 extern spinlock_t tqueue_lock;
=20
 /*
+ * Call all "bottom halfs" on a given list.
+ */
+
+extern void __run_task_queue(task_queue *list);
+
+static inline void run_task_queue(task_queue *list)
+{
+	if (TQ_ACTIVE(*list))
+		__run_task_queue(list);
+}
+
+#endif /* _LINUX_TQUEUE_H */
+
+#if !defined(_LINUX_TQUEUE_H_INLINES) && defined(_TASK_STRUCT_DEFINED)
+#define _LINUX_TQUEUE_H_INLINES
+/*
  * Queue a task on a tq.  Return non-zero if it was successfully
  * added.
  */
@@ -109,17 +125,4 @@
 	}
 	return ret;
 }
-
-/*
- * Call all "bottom halfs" on a given list.
- */
-
-extern void __run_task_queue(task_queue *list);
-
-static inline void run_task_queue(task_queue *list)
-{
-	if (TQ_ACTIVE(*list))
-		__run_task_queue(list);
-}
-
-#endif /* _LINUX_TQUEUE_H */
+#endif
diff -urN linux-2.4.18-O1-affinity/kernel/exit.c linux/kernel/exit.c
--- linux-2.4.18-O1-affinity/kernel/exit.c	Mon May 20 09:53:06 2002
+++ linux/kernel/exit.c	Mon May 20 10:03:04 2002
@@ -366,8 +366,8 @@
 		/* more a memory barrier than a real lock */
 		task_lock(tsk);
 		tsk->mm =3D NULL;
-		task_unlock(tsk);
 		enter_lazy_tlb(mm, current, smp_processor_id());
+		task_unlock(tsk);
 		mmput(mm);
 	}
 }
@@ -488,6 +488,11 @@
 	tsk->flags |=3D PF_EXITING;
 	del_timer_sync(&tsk->real_timer);
=20
+	if (unlikely(preempt_get_count()))
+		printk(KERN_WARNING "%s[%d] exited with preempt_count %d\n",
+				current->comm, current->pid,
+				preempt_get_count());
+
 fake_volatile:
 #ifdef CONFIG_BSD_PROCESS_ACCT
 	acct_process(code);
diff -urN linux-2.4.18-O1-affinity/kernel/fork.c linux/kernel/fork.c
--- linux-2.4.18-O1-affinity/kernel/fork.c	Mon May 20 09:53:06 2002
+++ linux/kernel/fork.c	Mon May 20 09:55:16 2002
@@ -616,6 +616,13 @@
 	if (p->binfmt && p->binfmt->module)
 		__MOD_INC_USE_COUNT(p->binfmt->module);
=20
+#ifdef CONFIG_PREEMPT
+	/*
+	 * schedule_tail drops this_rq()->lock so compensate with a count
+	 * of 1.  Also, we want to start with kernel preemption disabled.
+	 */
+	p->preempt_count =3D 1;
+#endif
 	p->did_exec =3D 0;
 	p->swappable =3D 0;
 	p->state =3D TASK_UNINTERRUPTIBLE;
diff -urN linux-2.4.18-O1-affinity/kernel/ksyms.c linux/kernel/ksyms.c
--- linux-2.4.18-O1-affinity/kernel/ksyms.c	Mon May 20 09:53:06 2002
+++ linux/kernel/ksyms.c	Mon May 20 09:55:16 2002
@@ -436,6 +436,9 @@
 EXPORT_SYMBOL(interruptible_sleep_on);
 EXPORT_SYMBOL(interruptible_sleep_on_timeout);
 EXPORT_SYMBOL(schedule);
+#ifdef CONFIG_PREEMPT
+EXPORT_SYMBOL(preempt_schedule);
+#endif
 EXPORT_SYMBOL(schedule_timeout);
 EXPORT_SYMBOL(sys_sched_yield);
 EXPORT_SYMBOL(set_user_nice);
diff -urN linux-2.4.18-O1-affinity/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.18-O1-affinity/kernel/sched.c	Mon May 20 10:55:35 2002
+++ linux/kernel/sched.c	Mon May 20 10:54:43 2002
@@ -155,10 +155,12 @@
 	struct runqueue *rq;
=20
 repeat_lock_task:
+	preempt_disable();
 	rq =3D task_rq(p);
 	spin_lock_irqsave(&rq->lock, *flags);
 	if (unlikely(rq !=3D task_rq(p))) {
 		spin_unlock_irqrestore(&rq->lock, *flags);
+		preempt_enable();
 		goto repeat_lock_task;
 	}
 	return rq;
@@ -167,6 +169,7 @@
 static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 {
 	spin_unlock_irqrestore(&rq->lock, *flags);
+	preempt_enable();
 }
=20
 /*
@@ -247,11 +250,13 @@
 {
 	int need_resched;
=20
+	preempt_disable();
 	need_resched =3D p->need_resched;
 	wmb();
 	set_tsk_need_resched(p);
 	if (!need_resched && (p->cpu !=3D smp_processor_id()))
 		smp_send_reschedule(p->cpu);
+	preempt_enable();
 }
=20
 #ifdef CONFIG_SMP
@@ -266,6 +271,7 @@
 	runqueue_t *rq;
=20
 repeat:
+	preempt_disable();
 	rq =3D task_rq(p);
 	while (unlikely(rq->curr =3D=3D p)) {
 		cpu_relax();
@@ -274,9 +280,11 @@
 	rq =3D task_rq_lock(p, &flags);
 	if (unlikely(rq->curr =3D=3D p)) {
 		task_rq_unlock(rq, &flags);
+		preempt_enable();
 		goto repeat;
 	}
 	task_rq_unlock(rq, &flags);
+	preempt_enable();
 }
=20
 /*
@@ -330,6 +338,7 @@
 {
 	runqueue_t *rq;
=20
+	preempt_disable();
 	rq =3D this_rq();
 	spin_lock_irq(&rq->lock);
=20
@@ -347,6 +356,7 @@
 	p->cpu =3D smp_processor_id();
 	activate_task(p, rq);
 	spin_unlock_irq(&rq->lock);
+	preempt_enable();
 }
=20
 /*
@@ -374,7 +384,7 @@
 			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
=20
-#if CONFIG_SMP
+#if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
 	spin_unlock_irq(&this_rq()->frozen);
@@ -730,6 +740,7 @@
 		BUG();
=20
 need_resched:
+	preempt_disable();
 	prev =3D current;
 	rq =3D this_rq();
=20
@@ -737,6 +748,13 @@
 	prev->sleep_timestamp =3D jiffies;
 	spin_lock_irq(&rq->lock);
=20
+	/*
+	 * if entering from preempt_schedule, off a kernel preemption,
+	 * go straight to picking the next task.
+	 */
+	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
+		goto pick_next_task;
+
 	switch (prev->state) {
 	case TASK_INTERRUPTIBLE:
 		if (unlikely(signal_pending(prev))) {
@@ -748,9 +766,8 @@
 	case TASK_RUNNING:
 		;
 	}
-#if CONFIG_SMP
+
 pick_next_task:
-#endif
 	if (unlikely(!rq->nr_running)) {
 #if CONFIG_SMP
 		load_balance(rq, 1);
@@ -802,11 +819,30 @@
 	}
=20
 	reacquire_kernel_lock(current);
+	preempt_enable_no_resched();
 	if (need_resched())
 		goto need_resched;
 	return;
 }
=20
+#ifdef CONFIG_PREEMPT
+/*
+ * this is is the entry point to schedule() from in-kernel preemption.
+ */
+asmlinkage void preempt_schedule(void)
+{
+need_resched:
+	current->preempt_count +=3D PREEMPT_ACTIVE;
+	schedule();
+	current->preempt_count -=3D PREEMPT_ACTIVE;
+
+	/* we can miss a preemption between schedule() and now */
+	barrier();
+	if (unlikely(need_resched()))
+		goto need_resched;
+}
+#endif /* CONFIG_PREEMPT */
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive =3D=3D 0=
) just
  * wake everything up.  If it's an exclusive wakeup (nr_exclusive =3D=3D s=
mall +ve
@@ -1276,6 +1312,7 @@
 	runqueue_t *rq;
 	prio_array_t *array;
=20
+	preempt_disable();
 	rq =3D this_rq();
=20
 	/*
@@ -1304,6 +1341,7 @@
 		__set_bit(current->prio, array->bitmap);
 	}
 	spin_unlock(&rq->lock);
+	preempt_enable_no_resched();
=20
 	schedule();
=20
@@ -1508,6 +1546,9 @@
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	__restore_flags(flags);
+
+	/* Set the preempt count _outside_ the spinlocks! */
+	idle->preempt_count =3D (idle->lock_depth >=3D 0);
 }
=20
 extern void init_timervecs(void);
@@ -1604,6 +1645,7 @@
 	if (!new_mask)
 		BUG();
=20
+	preempt_disable();
 	rq =3D task_rq_lock(p, &flags);
 	p->cpus_allowed =3D new_mask;
 	/*
@@ -1612,7 +1654,7 @@
 	 */
 	if (new_mask & (1UL << p->cpu)) {
 		task_rq_unlock(rq, &flags);
-		return;
+		goto out;
 	}
=20
 	/*
@@ -1622,7 +1664,7 @@
 	if (!p->array) {
 		p->cpu =3D __ffs(p->cpus_allowed);
 		task_rq_unlock(rq, &flags);
-		return;
+		goto out;
 	}
=20
 	init_MUTEX_LOCKED(&req.sem);
@@ -1632,6 +1674,8 @@
 	wake_up_process(rq->migration_thread);
=20
 	down(&req.sem);
+out:
+	preempt_enable();
 }
=20
 static int migration_thread(void * bind_cpu)
diff -urN linux-2.4.18-O1-affinity/lib/dec_and_lock.c linux/lib/dec_and_loc=
k.c
--- linux-2.4.18-O1-affinity/lib/dec_and_lock.c	Mon May 20 09:53:06 2002
+++ linux/lib/dec_and_lock.c	Mon May 20 09:55:16 2002
@@ -1,5 +1,6 @@
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/sched.h>
 #include <asm/atomic.h>
=20
 /*
diff -urN linux-2.4.18-O1-affinity/mm/slab.c linux/mm/slab.c
--- linux-2.4.18-O1-affinity/mm/slab.c	Mon May 20 09:53:06 2002
+++ linux/mm/slab.c	Mon May 20 09:55:16 2002
@@ -49,7 +49,8 @@
  *  constructors and destructors are called without any locking.
  *  Several members in kmem_cache_t and slab_t never change, they
  *	are accessed without any locking.
- *  The per-cpu arrays are never accessed from the wrong cpu, no locking.
+ *  The per-cpu arrays are never accessed from the wrong cpu, no locking,
+ *  	and local interrupts are disabled so slab code is preempt-safe.
  *  The non-constant members are protected with a per-cache irq spinlock.
  *
  * Further notes from the original documentation:
diff -urN linux-2.4.18-O1-affinity/net/core/dev.c linux/net/core/dev.c
--- linux-2.4.18-O1-affinity/net/core/dev.c	Mon May 20 09:53:17 2002
+++ linux/net/core/dev.c	Mon May 20 09:59:40 2002
@@ -1033,9 +1033,11 @@
 		int cpu =3D smp_processor_id();
=20
 		if (dev->xmit_lock_owner !=3D cpu) {
+			preempt_disable();
 			spin_unlock(&dev->queue_lock);
 			spin_lock(&dev->xmit_lock);
 			dev->xmit_lock_owner =3D cpu;
+			preempt_enable();
=20
 			if (!netif_queue_stopped(dev)) {
 				if (netdev_nit)
diff -urN linux-2.4.18-O1-affinity/net/core/skbuff.c linux/net/core/skbuff.=
c
--- linux-2.4.18-O1-affinity/net/core/skbuff.c	Mon May 20 09:53:17 2002
+++ linux/net/core/skbuff.c	Mon May 20 10:02:16 2002
@@ -111,33 +111,37 @@
=20
 static __inline__ struct sk_buff *skb_head_from_pool(void)
 {
-	struct sk_buff_head *list =3D &skb_head_pool[smp_processor_id()].list;
+	struct sk_buff_head *list;
+	struct sk_buff *skb =3D NULL;
+	unsigned long flags;
=20
-	if (skb_queue_len(list)) {
-		struct sk_buff *skb;
-		unsigned long flags;
+	local_irq_save(flags);
=20
-		local_irq_save(flags);
+	list =3D &skb_head_pool[smp_processor_id()].list;
+
+	if (skb_queue_len(list))
 		skb =3D __skb_dequeue(list);
-		local_irq_restore(flags);
-		return skb;
-	}
-	return NULL;
+
+	local_irq_restore(flags);
+	return skb;
 }
=20
 static __inline__ void skb_head_to_pool(struct sk_buff *skb)
 {
-	struct sk_buff_head *list =3D &skb_head_pool[smp_processor_id()].list;
+	struct sk_buff_head *list;
+	unsigned long flags;
=20
-	if (skb_queue_len(list) < sysctl_hot_list_len) {
-		unsigned long flags;
+	local_irq_save(flags);
+
+	list =3D &skb_head_pool[smp_processor_id()].list;
=20
-		local_irq_save(flags);
+	if (skb_queue_len(list) < sysctl_hot_list_len) {
 		__skb_queue_head(list, skb);
 		local_irq_restore(flags);
=20
 		return;
 	}
+	local_irq_restore(flags);
 	kmem_cache_free(skbuff_head_cache, skb);
 }
=20
diff -urN linux-2.4.18-O1-affinity/net/socket.c linux/net/socket.c
--- linux-2.4.18-O1-affinity/net/socket.c	Mon May 20 09:53:16 2002
+++ linux/net/socket.c	Mon May 20 09:55:16 2002
@@ -133,7 +133,7 @@
=20
 static struct net_proto_family *net_families[NPROTO];
=20
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 static atomic_t net_family_lockct =3D ATOMIC_INIT(0);
 static spinlock_t net_family_lock =3D SPIN_LOCK_UNLOCKED;
=20
diff -urN linux-2.4.18-O1-affinity/net/sunrpc/pmap_clnt.c linux/net/sunrpc/=
pmap_clnt.c
--- linux-2.4.18-O1-affinity/net/sunrpc/pmap_clnt.c	Mon May 20 09:53:18 200=
2
+++ linux/net/sunrpc/pmap_clnt.c	Mon May 20 09:55:16 2002
@@ -12,6 +12,7 @@
 #include <linux/config.h>
 #include <linux/types.h>
 #include <linux/socket.h>
+#include <linux/sched.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/uio.h>

--=-5r5YzDK6IBYpCXqPJYAO--

