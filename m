Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267200AbTBDIup>; Tue, 4 Feb 2003 03:50:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267199AbTBDIup>; Tue, 4 Feb 2003 03:50:45 -0500
Received: from franka.aracnet.com ([216.99.193.44]:30444 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S267183AbTBDIuY>; Tue, 4 Feb 2003 03:50:24 -0500
Date: Tue, 04 Feb 2003 00:59:42 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Mark Haverkamp <markh@osdl.org>, haveblue@us.ibm.com
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.59-mjb3 (scalability / NUMA patchset)
Message-ID: <169790000.1044349175@[10.10.2.4]>
In-Reply-To: <1044298502.29532.8.camel@markh1.pdx.osdl.net>
References: <19270000.1038270642@flay><134580000.1039414279@titus>
 <32230000.1039502522@titus><568990000.1040112629@titus>
 <21380000.1040717475@titus> <821470000.1041579423@titus>
 <214500000.1041821919@titus> <676880000.1042101078@titus>
 <922170000.1042183282@titus> <437220000.1042531505@titus>
 <190030000.1042787514@titus> <19610000.1043137151@titus>
 <20200000.1043806571@flay>  <125620000.1044238081@[10.10.2.4]>
 <1044297228.29537.5.camel@markh1.pdx.osdl.net>  <315150000.1044297722@flay>
 <1044298502.29532.8.camel@markh1.pdx.osdl.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1851542778=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1851542778==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

>> > I tried 2.5.59-mjb3 today on our 16 processor numaq and got a boot
>> > hang.  I had been running 2.5.59-mjb2 previously.  I have included the
>> > console output and my config file.   
>> 
>> What gcc are you using? I'm betting 3.2 ... 2.95 seems to work fine.
> 
> You are right, I am using:
> 
> gcc (GCC) 3.2 20020903 (Red Hat Linux 8.0 3.2-7)
>
>> (still might be an issue with the patch, just trying to track it down)

OK, it's the attatched patch's fault. Can you patch -R it, and confirm that
fixes it? (does for me).

Dave, can you take a look at why this breaks with gcc 3.2?

Thanks,

M.

--==========1851542778==========
Content-Type: text/plain; charset=iso-8859-1;
 name="B1-irqstackfix-2.5.59-mjb1-0.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="B1-irqstackfix-2.5.59-mjb1-0.txt";
 size=8289

diff -ur linux-2.5.59-mjb1/arch/i386/Kconfig =
linux-2.5.59-numaq-mjb1/arch/i386/Kconfig
--- linux-2.5.59-mjb1/arch/i386/Kconfig	Sun Jan 26 23:16:19 2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/Kconfig	Mon Jan 27 10:59:46 2003
@@ -363,6 +363,11 @@
 	depends on MK8 || MPENTIUM4
 	default y
=20
+config X86_CMOV
+	bool
+	depends on M686 || MPENTIUMII || MPENTIUMIII || MPENTIUM4 || MK8 || =
MCRUSOE
+	default y
+
 config HUGETLB_PAGE
 	bool "Huge TLB Page Support"
 	help
diff -ur linux-2.5.59-mjb1/arch/i386/kernel/apic.c =
linux-2.5.59-numaq-mjb1/arch/i386/kernel/apic.c
--- linux-2.5.59-mjb1/arch/i386/kernel/apic.c	Sun Jan 26 23:14:51 2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/kernel/apic.c	Sun Jan 26 14:23:22 =
2003
@@ -1038,7 +1038,8 @@
  *   interrupt as well. Thus we cannot inline the local irq ... ]
  */
=20
-void smp_apic_timer_interrupt(struct pt_regs regs)
+struct pt_regs * smp_apic_timer_interrupt(struct pt_regs* regs) =
__attribute__((regparm(1)));
+struct pt_regs * smp_apic_timer_interrupt(struct pt_regs* regs)
 {
 	int cpu =3D smp_processor_id();
=20
@@ -1058,14 +1059,16 @@
 	 * interrupt lock, which is the WrongThing (tm) to do.
 	 */
 	irq_enter();
-	smp_local_timer_interrupt(&regs);
+	smp_local_timer_interrupt(regs);
 	irq_exit();
+	return regs;
 }
=20
 /*
  * This interrupt should _never_ happen with our APIC/SMP architecture
  */
-asmlinkage void smp_spurious_interrupt(void)
+struct pt_regs * smp_spurious_interrupt(struct pt_regs* regs) =
__attribute__((regparm(1)));
+struct pt_regs * smp_spurious_interrupt(struct pt_regs* regs)
 {
 	unsigned long v;
=20
@@ -1083,13 +1086,15 @@
 	printk(KERN_INFO "spurious APIC interrupt on CPU#%d, should never =
happen.\n",
 			smp_processor_id());
 	irq_exit();
+	return regs;
 }
=20
 /*
  * This interrupt should never happen with our APIC/SMP architecture
  */
=20
-asmlinkage void smp_error_interrupt(void)
+struct pt_regs * smp_error_interrupt(struct pt_regs* regs) =
__attribute__((regparm(1)));
+struct pt_regs * smp_error_interrupt(struct pt_regs* regs)
 {
 	unsigned long v, v1;
=20
@@ -1114,6 +1119,7 @@
 	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
 	        smp_processor_id(), v , v1);
 	irq_exit();
+	return regs;
 }
=20
 /*
diff -ur linux-2.5.59-mjb1/arch/i386/kernel/cpu/mcheck/p4.c =
linux-2.5.59-numaq-mjb1/arch/i386/kernel/cpu/mcheck/p4.c
--- linux-2.5.59-mjb1/arch/i386/kernel/cpu/mcheck/p4.c	Sun Jan 26 23:14:51 =
2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/kernel/cpu/mcheck/p4.c	Sun Jan 26 =
23:23:08 2003
@@ -61,7 +61,8 @@
 /* Thermal interrupt handler for this CPU setup */
 static void (*vendor_thermal_interrupt)(struct pt_regs *regs) =3D =
unexpected_thermal_interrupt;
=20
-asmlinkage void smp_thermal_interrupt(struct pt_regs regs)
+asmlinkage struct pt_regs * smp_thermal_interrupt(struct pt_regs *regs) =
__attribute__((regparm(1)));
+struct pt_regs* smp_thermal_interrupt(struct pt_regs* regs)=20
 {
 	irq_enter();
 	vendor_thermal_interrupt(&regs);
diff -ur linux-2.5.59-mjb1/arch/i386/kernel/entry.S =
linux-2.5.59-numaq-mjb1/arch/i386/kernel/entry.S
--- linux-2.5.59-mjb1/arch/i386/kernel/entry.S	Sun Jan 26 23:16:19 2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/kernel/entry.S	Mon Jan 27 11:14:08 =
2003
@@ -138,8 +138,6 @@
 	.long 1b,2b;	\
 .previous
=20
-
-
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call
 				# gates, which has to be cleaned up later..
@@ -388,55 +386,76 @@
 vector=3Dvector+1
 .endr
=20
-	ALIGN
-common_interrupt:
-	SAVE_ALL
-
=20
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
+# lets play optimizing compiler...
+#ifdef CONFIG_X86_CMOV
+#define COND_MOVE	cmovnz %esi,%esp;
 #else
-	jz 1f
-	mov %esi,%esp
+#define COND_MOVE	\
+	jz 1f;		\
+	mov %esi,%esp;	\
 1:
 #endif
-	
-	# update the task pointer in the irq stack
-	GET_THREAD_INFO(%esi)
-	movl %edx,TI_TASK(%esi)
-
-	# update the preempt count in the irq stack
-	movl TI_PRE_COUNT(%ebx),%ecx
-	movl %ecx,TI_PRE_COUNT(%esi)
-		
-	call do_IRQ
=20
-	movl %eax,%esp                  # potentially restore non-irq stack
-	
-	# copy flags from the irq stack back into the task's thread_info
-	# %esi is saved over the do_IRQ call and contains the irq stack
-	# thread_info pointer
-	# %ebx contains the original thread_info pointer
-	movl TI_FLAGS(%esi),%eax
-	movl $0,TI_FLAGS(%esi)
-	LOCK orl %eax,TI_FLAGS(%ebx)
+# These macros will switch you to, and from a per-cpu interrupt stack
+# They take the pt_regs arg and move it from the normal place on the=20
+# stack to %eax.  Any handler function can retrieve it using regparm(1).=20
+# The handlers are expected to return the stack to switch back to in=20
+# the same register.=20
+#
+# This means that the irq handlers need to return their arg
+#
+# SWITCH_TO_IRQSTACK clobbers %ebx, %ecx, %edx, %esi
+# old stack in %eax
+
+#define SWITCH_TO_IRQSTACK 							\
+	GET_THREAD_INFO(%ebx);							\
+	movl TI_IRQ_STACK(%ebx),%ecx;						\
+	movl TI_TASK(%ebx),%edx;						\
+	movl %esp,%eax;								\
+										\
+	/* %ecx+THREAD_SIZE is next stack -4 keeps us in the right one */	\
+	leal (THREAD_SIZE-4)(%ecx),%esi; 					\
+										\
+	/* is there a valid irq_stack? */					\
+	testl %ecx,%ecx;							\
+	COND_MOVE;								\
+										\
+	/* update the task pointer in the irq stack */ 				\
+	GET_THREAD_INFO(%esi);							\
+	movl %edx,TI_TASK(%esi);						\
+										\
+	/* update the preempt count in the irq stack */ 			\
+	movl TI_PRE_COUNT(%ebx),%ecx;						\
+	movl %ecx,TI_PRE_COUNT(%esi);
+
+# copy flags from the irq stack back into the task's thread_info
+# %esi is saved over the irq handler call and contains the irq stack
+#      thread_info pointer
+# %eax was returned from the handler, as described above
+# %ebx contains the original thread_info pointer
+			
+#define RESTORE_FROM_IRQSTACK 		\
+	movl %eax,%esp;			\
+	movl TI_FLAGS(%esi),%eax;	\
+	movl $0,TI_FLAGS(%esi);		\
+	LOCK orl %eax,TI_FLAGS(%ebx);
=20
+	ALIGN
+common_interrupt:
+	SAVE_ALL
+	SWITCH_TO_IRQSTACK
+	call do_IRQ
+	RESTORE_FROM_IRQSTACK
 	jmp ret_from_intr
=20
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
-	pushl $nr-256;			\
+	pushl $nr-256;                  \
 	SAVE_ALL			\
-	call smp_/**/name;	\
+	SWITCH_TO_IRQSTACK		\
+	call smp_/**/name;		\
+	RESTORE_FROM_IRQSTACK		\
 	jmp ret_from_intr;
=20
 /* The include is where all of the SMP etc. interrupts come from */
diff -ur linux-2.5.59-mjb1/arch/i386/kernel/smp.c =
linux-2.5.59-numaq-mjb1/arch/i386/kernel/smp.c
--- linux-2.5.59-mjb1/arch/i386/kernel/smp.c	Sun Jan 26 23:16:19 2003
+++ linux-2.5.59-numaq-mjb1/arch/i386/kernel/smp.c	Sun Jan 26 14:37:09 2003
@@ -305,7 +305,8 @@
  * 2) Leave the mm if we are in the lazy tlb mode.
  */
=20
-asmlinkage void smp_invalidate_interrupt (void)
+struct pt_regs *smp_invalidate_interrupt(struct pt_regs *regs) =
__attribute__((regparm(1)));
+struct pt_regs *smp_invalidate_interrupt(struct pt_regs *regs)
 {
 	unsigned long cpu;
=20
@@ -336,6 +337,7 @@
=20
 out:
 	put_cpu_no_resched();
+	return regs;
 }
=20
 static void flush_tlb_others (unsigned long cpumask, struct mm_struct *mm,
@@ -598,12 +600,17 @@
  * all the work is done automatically when
  * we return from the interrupt.
  */
-asmlinkage void smp_reschedule_interrupt(void)
+
+asmlinkage struct pt_regs * smp_reschedule_interrupt(struct pt_regs *regs) =
__attribute__((regparm(1)));
+struct pt_regs * smp_reschedule_interrupt(struct pt_regs *regs)
 {
 	ack_APIC_irq();
+	return regs;
 }
=20
-asmlinkage void smp_call_function_interrupt(struct pt_regs regs)
+
+asmlinkage struct pt_regs * smp_call_function_interrupt(struct pt_regs =
*regs) __attribute__((regparm(1)));
+struct pt_regs * smp_call_function_interrupt(struct pt_regs *regs)
 {
 	void (*func) (void *info, struct pt_regs *) =3D (void (*)(void *, struct =
pt_regs*))call_data->func;
 	void *info =3D call_data->info;
@@ -620,12 +627,13 @@
 	 * At this point the info structure may be out of scope unless =
wait=3D=3D1
 	 */
 	irq_enter();
-	(*func)(info, &regs);
+	(*func)(info, regs);
 	irq_exit();
=20
 	if (wait) {
 		mb();
 		atomic_inc(&call_data->finished);
 	}
+	return regs;
 }
=20

--==========1851542778==========--

