Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266996AbTBLHlF>; Wed, 12 Feb 2003 02:41:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266998AbTBLHlF>; Wed, 12 Feb 2003 02:41:05 -0500
Received: from ns.suse.de ([213.95.15.193]:40978 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266996AbTBLHlA>;
	Wed, 12 Feb 2003 02:41:00 -0500
Date: Wed, 12 Feb 2003 08:50:48 +0100
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       "Martin J. Bligh" <mbligh@aracnet.com>, ak@suse.de,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Message-ID: <20030212075048.GA9049@wotan.suse.de>
References: <629040000.1045013743@flay> <20030212025902.GA14092@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212025902.GA14092@codemonkey.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 02:59:02AM +0000, Dave Jones wrote:
> On Tue, Feb 11, 2003 at 05:35:43PM -0800, Martin J. Bligh wrote:
> 
>  > The reason it rewrites SYSENTER_CS is non obviously vm86 which
>  > doesn't guarantee the MSR stays constant (sigh). I think this would 
>  > be better handled by having a global flag or process flag when any process
>  > uses vm86 and not do it when this flag is not set (as in 99% of all 
>  > normal use cases)
> 
> I feel I'm missing something obvious here, but is this part the
> low-hanging fruit that it seems ?

Yes I implemented a similar patch now too last night. It also fixes a few other
fast path bugs in __switch_to

- Fix false sharing in the GDT and replace an imul with a shift.
Really pad the GDT to cache lines now.

- Don't use LOCK prefixes in bit operations when accessing the 
thread_info flags of the switched threads. LOCK is very slow on P4
and it isn't necessary here.

Really we should have __set_bit/__test_bit without memory barrier
and atomic stuff on each arch and use that for thread_info.h,
but for now do it this way.

[this is a port from x86-64]

- Inline FPU switch - it is only a few lines.

But I must say I don't know vm86() semantics enough to know if this is 
good enough, especially when the clear the TIF_VM86 flag. Could someone
more familiar with it review it?

BTW vm86.c at the first look doesn't look very preempt safe to me.

comments?

-Andi


diff -burpN -X ../KDIFX linux-2.5.60/arch/i386/kernel/cpu/common.c linux-2.5.60-work/arch/i386/kernel/cpu/common.c
--- linux-2.5.60/arch/i386/kernel/cpu/common.c	2003-02-10 19:37:57.000000000 +0100
+++ linux-2.5.60-work/arch/i386/kernel/cpu/common.c	2003-02-12 01:42:01.000000000 +0100
@@ -484,7 +484,7 @@ void __init cpu_init (void)
 		BUG();
 	enter_lazy_tlb(&init_mm, current, cpu);
 
-	load_esp0(t, thread->esp0);
+	load_esp0(current, t, thread->esp0);
 	set_tss_desc(cpu,t);
 	cpu_gdt_table[cpu][GDT_ENTRY_TSS].b &= 0xfffffdff;
 	load_TR_desc();
diff -burpN -X ../KDIFX linux-2.5.60/arch/i386/kernel/i387.c linux-2.5.60-work/arch/i386/kernel/i387.c
--- linux-2.5.60/arch/i386/kernel/i387.c	2003-02-10 19:39:17.000000000 +0100
+++ linux-2.5.60-work/arch/i386/kernel/i387.c	2003-02-11 23:51:58.000000000 +0100
@@ -52,24 +52,6 @@ void init_fpu(struct task_struct *tsk)
  * FPU lazy state save handling.
  */
 
-static inline void __save_init_fpu( struct task_struct *tsk )
-{
-	if ( cpu_has_fxsr ) {
-		asm volatile( "fxsave %0 ; fnclex"
-			      : "=m" (tsk->thread.i387.fxsave) );
-	} else {
-		asm volatile( "fnsave %0 ; fwait"
-			      : "=m" (tsk->thread.i387.fsave) );
-	}
-	clear_tsk_thread_flag(tsk, TIF_USEDFPU);
-}
-
-void save_init_fpu( struct task_struct *tsk )
-{
-	__save_init_fpu(tsk);
-	stts();
-}
-
 void kernel_fpu_begin(void)
 {
 	preempt_disable();
diff -burpN -X ../KDIFX linux-2.5.60/arch/i386/kernel/process.c linux-2.5.60-work/arch/i386/kernel/process.c
--- linux-2.5.60/arch/i386/kernel/process.c	2003-02-10 19:37:54.000000000 +0100
+++ linux-2.5.60-work/arch/i386/kernel/process.c	2003-02-12 01:40:02.000000000 +0100
@@ -437,7 +437,7 @@ void __switch_to(struct task_struct *pre
 	/*
 	 * Reload esp0, LDT and the page table pointer:
 	 */
-	load_esp0(tss, next->esp0);
+	load_esp0(prev_p, tss, next->esp0);
 
 	/*
 	 * Load the per-thread Thread-Local Storage descriptor.
diff -burpN -X ../KDIFX linux-2.5.60/arch/i386/kernel/vm86.c linux-2.5.60-work/arch/i386/kernel/vm86.c
--- linux-2.5.60/arch/i386/kernel/vm86.c	2003-02-10 19:37:58.000000000 +0100
+++ linux-2.5.60-work/arch/i386/kernel/vm86.c	2003-02-12 01:46:51.000000000 +0100
@@ -114,7 +117,7 @@ struct pt_regs * save_v86_state(struct k
 	}
 	tss = init_tss + smp_processor_id();
 	current->thread.esp0 = current->thread.saved_esp0;
-	load_esp0(tss, current->thread.esp0);
+	load_esp0(current, tss, current->thread.esp0);
 	current->thread.saved_esp0 = 0;
 	loadsegment(fs, current->thread.saved_fs);
 	loadsegment(gs, current->thread.saved_gs);
@@ -309,6 +313,10 @@ static inline void return_to_32bit(struc
 {
 	struct pt_regs * regs32;
 
+	/* FIXME should disable preemption here but how can we reenable it? */
+
+	enable_sysenter();
+
 	regs32 = save_v86_state(regs16);
 	regs32->eax = retval;
 	__asm__ __volatile__("movl %0,%%esp\n\t"
diff -burpN -X ../KDIFX linux-2.5.60/arch/x86_64/kernel/process.c linux-2.5.60-work/arch/x86_64/kernel/process.c
--- linux-2.5.60/arch/x86_64/kernel/process.c	2003-02-10 19:37:56.000000000 +0100
+++ linux-2.5.60-work/arch/x86_64/kernel/process.c	2003-02-12 01:51:00.000000000 +0100
@@ -41,6 +41,7 @@
 #include <linux/init.h>
 #include <linux/ctype.h>
 #include <linux/slab.h>
+#include <linux/thread_info.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
diff -burpN -X ../KDIFX linux-2.5.60/include/asm-i386/i387.h linux-2.5.60-work/include/asm-i386/i387.h
--- linux-2.5.60/include/asm-i386/i387.h	2003-02-10 19:38:49.000000000 +0100
+++ linux-2.5.60-work/include/asm-i386/i387.h	2003-02-12 01:21:13.000000000 +0100
@@ -21,23 +21,41 @@ extern void init_fpu(struct task_struct 
 /*
  * FPU lazy state save handling...
  */
-extern void save_init_fpu( struct task_struct *tsk );
 extern void restore_fpu( struct task_struct *tsk );
 
 extern void kernel_fpu_begin(void);
 #define kernel_fpu_end() do { stts(); preempt_enable(); } while(0)
 
 
+static inline void __save_init_fpu( struct task_struct *tsk )
+{
+	if ( cpu_has_fxsr ) {
+		asm volatile( "fxsave %0 ; fnclex"
+			      : "=m" (tsk->thread.i387.fxsave) );
+	} else {
+		asm volatile( "fnsave %0 ; fwait"
+			      : "=m" (tsk->thread.i387.fsave) );
+	}
+	tsk->thread_info->flags &= ~TIF_USEDFPU;
+}
+
+static inline void save_init_fpu( struct task_struct *tsk )
+{
+	__save_init_fpu(tsk);
+	stts();
+}
+
+
 #define unlazy_fpu( tsk ) do { \
-	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) \
+	if ((tsk)->thread_info->flags & _TIF_USEDFPU) \
 		save_init_fpu( tsk ); \
 } while (0)
 
 #define clear_fpu( tsk )					\
 do {								\
-	if (test_tsk_thread_flag(tsk, TIF_USEDFPU)) {		\
+	if ((tsk)->thread_info->flags & _TIF_USEDFPU) {		\
 		asm volatile("fwait");				\
-		clear_tsk_thread_flag(tsk, TIF_USEDFPU);	\
+		(tsk)->thread_info->flags &= ~_TIF_USEDFPU;	\
 		stts();						\
 	}							\
 } while (0)
diff -burpN -X ../KDIFX linux-2.5.60/include/asm-i386/processor.h linux-2.5.60-work/include/asm-i386/processor.h
--- linux-2.5.60/include/asm-i386/processor.h	2003-02-10 19:37:57.000000000 +0100
+++ linux-2.5.60-work/include/asm-i386/processor.h	2003-02-12 01:52:28.000000000 +0100
@@ -408,20 +408,30 @@ struct thread_struct {
 	.io_bitmap	= { [ 0 ... IO_BITMAP_SIZE ] = ~0 },		\
 }
 
-static inline void load_esp0(struct tss_struct *tss, unsigned long esp0)
-{
-	tss->esp0 = esp0;
-	if (cpu_has_sep) {
-		wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);
-		wrmsr(MSR_IA32_SYSENTER_ESP, esp0, 0);
-	}
-}
-
-static inline void disable_sysenter(void)
-{
-	if (cpu_has_sep)  
-		wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);
-}
+#define load_esp0(prev, tss, _esp0) do { \
+	(tss)->esp0 = _esp0;						\
+	if (cpu_has_sep) {						\
+		if (unlikely((prev)->thread_info->flags & _TIF_VM86))	\
+			wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);	\
+		wrmsr(MSR_IA32_SYSENTER_ESP, (_esp0), 0);		\
+	}								\
+} while(0)
+
+/* The caller of the next two functions should have disabled preemption. */
+
+#define disable_sysenter() do { \
+	if (cpu_has_sep) {				\
+		set_thread_flag(TIF_VM86);		\
+		wrmsr(MSR_IA32_SYSENTER_CS, 0, 0);	\
+	}	\
+} while(0)
+
+#define enable_sysenter() do { \
+	if (cpu_has_sep) {					\
+		clear_thread_flag(TIF_VM86);			\
+		wrmsr(MSR_IA32_SYSENTER_CS, __KERNEL_CS, 0);	\
+	}							\
+} while(0)
 
 #define start_thread(regs, new_eip, new_esp) do {		\
 	__asm__("movl %0,%%fs ; movl %0,%%gs": :"r" (0));	\
diff -burpN -X ../KDIFX linux-2.5.60/include/asm-i386/segment.h linux-2.5.60-work/include/asm-i386/segment.h
--- linux-2.5.60/include/asm-i386/segment.h	2003-02-10 19:38:06.000000000 +0100
+++ linux-2.5.60-work/include/asm-i386/segment.h	2003-02-11 23:56:37.000000000 +0100
@@ -67,7 +67,7 @@
 /*
  * The GDT has 25 entries but we pad it to cacheline boundary:
  */
-#define GDT_ENTRIES 28
+#define GDT_ENTRIES 32
 
 #define GDT_SIZE (GDT_ENTRIES * 8)
 
diff -burpN -X ../KDIFX linux-2.5.60/include/asm-i386/thread_info.h linux-2.5.60-work/include/asm-i386/thread_info.h
--- linux-2.5.60/include/asm-i386/thread_info.h	2003-02-10 19:37:59.000000000 +0100
+++ linux-2.5.60-work/include/asm-i386/thread_info.h	2003-02-12 01:51:26.000000000 +0100
@@ -111,15 +111,18 @@ static inline struct thread_info *curren
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
+#define TIF_VM86		6	/* may use vm86 */ 
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
+
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
+#define _TIF_VM86		(1<<TIF_VM86)
 #define _TIF_USEDFPU		(1<<TIF_USEDFPU)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
 

