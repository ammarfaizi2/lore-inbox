Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267135AbTA0Hf2>; Mon, 27 Jan 2003 02:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267137AbTA0Hf2>; Mon, 27 Jan 2003 02:35:28 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:23031 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267135AbTA0HfY>; Mon, 27 Jan 2003 02:35:24 -0500
Message-ID: <3E34E335.1000600@us.ibm.com>
Date: Sun, 26 Jan 2003 23:43:49 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Larson <plars@us.ibm.com>, "Martin J. Bligh" <mbligh@aracnet.com>
Subject: 4k stacks and BUILD_INTERRUPT
Content-Type: multipart/mixed;
 boundary="------------030903030708090705010007"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030903030708090705010007
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I was getting some pretty repeatable oopses while large numbers of
processes were exiting on my 16-way PIII while irqstacks, and 4k stacks
were turned on.  It is hard to trigger, and only happens when you're
using 4k stacks, not just irqstacks.

I traced it down to when smp_* interrupts were running.  It seems that
they use an interrupt entry path that doesn't include do_IRQ or
common_interrupt.  They use a BUILD_INTERRUPT macro, instead.  They were
blowing their 4k stacks when running softirqs.

So, what I did, was put the irqstack operations in a macro and call it
from common_interrupt, and the BUILD_INTERRUPT macros.  I also had to
change the calling conventions of the newly-affected handlers.

Ben, was there a reason that you didn't include these functions in your
original irqstack patches?  I always (wrongly) assumed that they were
really quick interrupts, and didn't use the stack heavily enough to be
worth modifying.

The a diff for the -mjb tree is attached.  I'll cook up another set of
vanilla ones tomorrow.

Does anybody want to see irqstacks as a config option?  These macros
would make it easier.
-- 
Dave Hansen
haveblue@us.ibm.com

--------------030903030708090705010007
Content-Type: text/plain;
 name="newirqstack-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newirqstack-0.patch"

diff -ur linux-2.5.59-mjb1/arch/i386/kernel/apic.c linux-2.5.59-numaq-mjb1/arch/i386/kernel/apic.c
--- linux-2.5.59-mjb1/arch/i386/kernel/apic.c	Sun Jan 26 23:14:51 2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/kernel/apic.c	Sun Jan 26 14:23:22 2003
@@ -1038,7 +1038,8 @@
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
 
-void smp_apic_timer_interrupt(struct pt_regs regs)
+struct pt_regs * smp_apic_timer_interrupt(struct pt_regs* regs) __attribute__((regparm(1)));
+struct pt_regs * smp_apic_timer_interrupt(struct pt_regs* regs)
 {
 	int cpu = smp_processor_id();
 
@@ -1058,14 +1059,16 @@
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
-	smp_local_timer_interrupt(&regs);
+	smp_local_timer_interrupt(regs);
 	irq_exit();
+	return regs;
 }
 
 /*
  * This interrupt should _never_ happen with our APIC/SMP architecture
  */
-asmlinkage void smp_spurious_interrupt(void)
+struct pt_regs * smp_spurious_interrupt(struct pt_regs* regs) __attribute__((regparm(1)));
+struct pt_regs * smp_spurious_interrupt(struct pt_regs* regs)
 {
 	unsigned long v;
 
@@ -1083,13 +1086,15 @@
 	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never happen.\n",
 			smp_processor_id());
 	irq_exit();
+	return regs;
 }
 
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
 
-asmlinkage void smp_error_interrupt(void)
+struct pt_regs * smp_error_interrupt(struct pt_regs* regs) __attribute__((regparm(1)));
+struct pt_regs * smp_error_interrupt(struct pt_regs* regs)
 {
 	unsigned long v, v1;
 
@@ -1114,6 +1119,7 @@
 	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	return regs;
 }
 
 /*
diff -ur linux-2.5.59-mjb1/arch/i386/kernel/entry.S linux-2.5.59-numaq-mjb1/arch/i386/kernel/entry.S
--- linux-2.5.59-mjb1/arch/i386/kernel/entry.S	Sun Jan 26 23:16:19 2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/kernel/entry.S	Sun Jan 26 23:13:23 2003
@@ -138,7 +138,42 @@
 	.long 1b,2b;	\
 .previous
 
-
+#define SWITCH_TO_IRQSTACK 		\
+	GET_THREAD_INFO(%ebx);		\
+	movl TI_IRQ_STACK(%ebx),%ecx;	\
+	movl TI_TASK(%ebx),%edx;	\
+	movl %esp,%eax;			\
+	leal (THREAD_SIZE-4)(%ecx),%esi;# %ecx+THREAD_SIZE is next stack\
+	                                # -4 keeps us in the right one	\
+	testl %ecx,%ecx;		# is there a valid irq_stack?	\
+					\
+	# switch to the irq stack	\
+#ifdef CONFIG_X86_HAVE_CMOV		
+	cmovnz %esi,%esp;		\
+#else					\
+	jz 1f;				\
+	mov %esi,%esp;			\
+1:					\
+#endif
+					\
+	# update the task pointer in the irq stack	\
+	GET_THREAD_INFO(%esi);				\
+	movl %edx,TI_TASK(%esi);			\
+							\
+	# update the preempt count in the irq stack	\
+	movl TI_PRE_COUNT(%ebx),%ecx;			\
+	movl %ecx,TI_PRE_COUNT(%esi);
+
+#define RESTORE_FROM_IRQSTACK \
+	movl %eax,%esp;	# potentially restore non-irq stack			\
+										\
+	# copy flags from the irq stack back into the tasks thread_info		\
+	# esi is saved over the do_IRQ call and contains the irq stack		\
+	# thread_info pointer							\
+	# ebx contains the original thread_info pointer				\
+	movl TI_FLAGS(%esi),%eax;						\
+	movl $0,TI_FLAGS(%esi);							\
+	LOCK orl %eax,TI_FLAGS(%ebx);
 
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call
@@ -391,52 +426,16 @@
 	ALIGN
 common_interrupt:
 	SAVE_ALL
-
-
-	GET_THREAD_INFO(%ebx)
-	movl TI_IRQ_STACK(%ebx),%ecx
-	movl TI_TASK(%ebx),%edx
-	movl %esp,%eax
-	leal (THREAD_SIZE-4)(%ecx),%esi # %ecx+THREAD_SIZE is next stack
-	                                # -4 keeps us in the right one
-	testl %ecx,%ecx                 # is there a valid irq_stack?
-
-	# switch to the irq stack
-#ifdef CONFIG_X86_HAVE_CMOV
-	cmovnz %esi,%esp
-#else
-	jz 1f
-	mov %esi,%esp
-1:
-#endif
-	
-	# update the task pointer in the irq stack
-	GET_THREAD_INFO(%esi)
-	movl %edx,TI_TASK(%esi)
-
-	# update the preempt count in the irq stack
-	movl TI_PRE_COUNT(%ebx),%ecx
-	movl %ecx,TI_PRE_COUNT(%esi)
-		
+	SWITCH_TO_IRQSTACK
 	call do_IRQ
-
-	movl %eax,%esp                  # potentially restore non-irq stack
-	
-	# copy flags from the irq stack back into the task's thread_info
-	# %esi is saved over the do_IRQ call and contains the irq stack
-	# thread_info pointer
-	# %ebx contains the original thread_info pointer
-	movl TI_FLAGS(%esi),%eax
-	movl $0,TI_FLAGS(%esi)
-	LOCK orl %eax,TI_FLAGS(%ebx)
-
+	RESTORE_FROM_IRQSTACK
 	jmp ret_from_intr
 
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
-	pushl $nr-256;			\
-	SAVE_ALL			\
-	call smp_/**/name;	\
+	SWITCH_TO_IRQSTACK		\
+	call smp_/**/name;		\
+	RESTORE_FROM_IRQSTACK		\
 	jmp ret_from_intr;
 
 /* The include is where all of the SMP etc. interrupts come from */
diff -ur linux-2.5.59-mjb1/arch/i386/kernel/smp.c linux-2.5.59-numaq-mjb1/arch/i386/kernel/smp.c
--- linux-2.5.59-mjb1/arch/i386/kernel/smp.c	Sun Jan 26 23:16:19 2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/kernel/smp.c	Sun Jan 26 14:37:09 2003
@@ -305,7 +305,8 @@
  * 2) Leave the mm if we are in the lazy tlb mode.
  */
 
-asmlinkage void smp_invalidate_interrupt (void)
+struct pt_regs *smp_invalidate_interrupt(struct pt_regs *regs) __attribute__((regparm(1)));
+struct pt_regs *smp_invalidate_interrupt(struct pt_regs *regs)
 {
 	unsigned long cpu;
 
@@ -336,6 +337,7 @@
 
 out:
 	put_cpu_no_resched();
+	return regs;
 }
 
 static void flush_tlb_others (unsigned long cpumask, struct mm_struct *mm,
@@ -598,12 +600,17 @@
  * all the work is done automatically when
  * we return from the interrupt.
  */
-asmlinkage void smp_reschedule_interrupt(void)
+
+asmlinkage struct pt_regs * smp_reschedule_interrupt(struct pt_regs *regs) __attribute__((regparm(1)));
+struct pt_regs * smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+	return regs;
 }
 
-asmlinkage void smp_call_function_interrupt(struct pt_regs regs)
+
+asmlinkage struct pt_regs * smp_call_function_interrupt(struct pt_regs *regs) __attribute__((regparm(1)));
+struct pt_regs * smp_call_function_interrupt(struct pt_regs *regs)
 {
 	void (*func) (void *info, struct pt_regs *) = (void (*)(void *, struct pt_regs*))call_data->func;
 	void *info = call_data->info;
@@ -620,12 +627,13 @@
 	 * At this point the info structure may be out of scope unless wait==1
 	 */
 	irq_enter();
-	(*func)(info, &regs);
+	(*func)(info, regs);
 	irq_exit();
 
 	if (wait) {
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	return regs;
 }
 

--------------030903030708090705010007--

