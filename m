Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269372AbUJFQNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269372AbUJFQNy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 12:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269330AbUJFQNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 12:13:53 -0400
Received: from mail.aknet.ru ([217.67.122.194]:46343 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S269372AbUJFQM1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 12:12:27 -0400
Message-ID: <41641AD2.4080007@aknet.ru>
Date: Wed, 06 Oct 2004 20:18:26 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: ESP corruption bug - what CPUs are affected? (patch attempts)
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz> <41530326.2050900@aknet.ru> <20040923180607.GA20678@vana.vc.cvut.cz> <4154853F.6070105@aknet.ru> <20040924214330.GD8151@vana.vc.cvut.cz>
In-Reply-To: <20040924214330.GD8151@vana.vc.cvut.cz>
Content-Type: multipart/mixed;
 boundary="------------050406090608020405020105"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050406090608020405020105
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Petr Vandrovec wrote:
>> The reason is that the previous part of the macro
>> can jump to that part. So how can I divide those?
> Use real labels instead of numeric local labels.
OK, I am really sorry for asking such a crap :(

>> returning to the kernel if fails, should die()
>> anyway. Is this correct?
> If you'll first test result of lar, and then
> you'll do two independent RESTORE_REGS (second
> setup, instead of doing push + pop), you can reuse
> RESOTRE_REGS+add $4,%esp+iret return path, including
> its exception handling.
Yes, but I was wondering whether we really do
need an exception handler when returning to
kernel. There should be no fault there, and
if there is - it should be an Oops, I think.
Nevertheless, I did what you said. Perhaps
something like die_if_kernel() is somewhere
down the road anyway.

> Patch looks fine, though you could speedup it a bit as outlined above.
New patch is attached.

> Now you have to persuade others that this patch should include patch
> into the kernel.
Yes, if not for that anonymous guy, who kept posting
to me until he finally convinced me that the Ring-0
approach is not that difficult at all.
So I tried... It was much more difficult to code
up, but at the end it looks a little better
and localized to entry.S completely. OTOH it
touches the exception handlers, but not too much -
it adds only 5 insns on the fast path. And the
code is very fragile, but after I made all the
magic numbers a #define consts, it actually looks
not so bad.
I don't know which patch is really better, so
I am attaching both.
Any ideas on which one should I have to continue
working on and what improvements can be done to
either one?


--------------050406090608020405020105
Content-Type: text/x-patch;
 name="linux-2.6.8-stacks5.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8-stacks5.diff"

diff -urN linux-2.6.8-pcsp/arch/i386/kernel/entry.S linux-2.6.8-stacks/arch/i386/kernel/entry.S
--- linux-2.6.8-pcsp/arch/i386/kernel/entry.S	2004-06-10 13:28:35.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/entry.S	2004-10-05 15:12:16.771426456 +0400
@@ -70,15 +70,22 @@
 CF_MASK		= 0x00000001
 TF_MASK		= 0x00000100
 IF_MASK		= 0x00000200
-DF_MASK		= 0x00000400 
+DF_MASK		= 0x00000400
+IOPL1_MASK 	= 0x00001000
+IOPL2_MASK 	= 0x00002000
+IOPL_MASK 	= 0x00003000
 NT_MASK		= 0x00004000
+RF_MASK		= 0x00010000
 VM_MASK		= 0x00020000
+AC_MASK 	= 0x00040000
+VIF_MASK 	= 0x00080000
+VIP_MASK 	= 0x00100000
 
 #ifdef CONFIG_PREEMPT
 #define preempt_stop		cli
 #else
 #define preempt_stop
-#define resume_kernel		restore_all
+#define resume_kernel		restore_context
 #endif
 
 #define SAVE_ALL \
@@ -122,25 +129,6 @@
 .previous
 
 
-#define RESTORE_ALL	\
-	RESTORE_REGS	\
-	addl $4, %esp;	\
-1:	iret;		\
-.section .fixup,"ax";   \
-2:	sti;		\
-	movl $(__USER_DS), %edx; \
-	movl %edx, %ds; \
-	movl %edx, %es; \
-	pushl $11;	\
-	call do_exit;	\
-.previous;		\
-.section __ex_table,"a";\
-	.align 4;	\
-	.long 1b,2b;	\
-.previous
-
-
-
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call
 				# gates, which has to be cleaned up later..
@@ -174,6 +162,15 @@
 	jmp do_lcall
 
 
+ENTRY(espfix_trampoline)
+	popl %esp
+espfix_past_esp:
+1:	iret
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
+
 ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
@@ -196,8 +193,8 @@
 	GET_THREAD_INFO(%ebp)
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
-	jz resume_kernel		# returning to kernel or vm86-space
+	testl $(VM_MASK | 2), %eax
+	jz resume_kernel
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -211,7 +208,7 @@
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
-	jnz restore_all
+	jnz restore_context
 need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
@@ -293,8 +290,82 @@
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
+
 restore_all:
-	RESTORE_ALL
+	/* If returning to Ring-3, not to V86, and with
+	 * the small stack, try to fix the higher word of
+	 * ESP, as the CPU won't restore it from stack.
+	 * This is an "official" bug of all the x86-compatible
+	 * CPUs, which we can try to work around to make
+	 * dosemu happy. */
+	movl EFLAGS(%esp), %eax
+	movb CS(%esp), %al
+	andl $(VM_MASK | 2), %eax
+	/* returning to user-space and not to v86? */
+	cmpl $2, %eax
+	jne restore_context
+	larl OLDSS(%esp), %eax
+	/* returning to "small" stack? */
+	testl $0x00400000, %eax
+	jz 8f		# go fixing ESP instead of just to return :(
+restore_context:
+	RESTORE_REGS
+	addl $4, %esp
+1:	iret
+.section .fixup,"ax"
+iret_exc:
+	sti
+	movl $(__USER_DS), %edx
+	movl %edx, %ds
+	movl %edx, %es
+	pushl $11
+	call do_exit
+.previous
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
+	/* preparing the ESPfix here */
+#define NMI_STACK_RESERVE 0x800
+	/* reserve some space on stack for the NMI handler */
+8:	RESTORE_REGS
+	subl $(NMI_STACK_RESERVE-4), %esp
+	.rept 5
+	pushl NMI_STACK_RESERVE+16(%esp)
+	.endr
+	subl $24, %esp
+	pushl %eax
+	leal 24(%esp), %eax
+	pushl %ebp
+	preempt_stop
+	GET_THREAD_INFO(%ebp)
+	movl TI_cpu(%ebp), %ebp
+	shll $GDT_SIZE_SHIFT, %ebp
+	/* find GDT of the proper CPU */
+	addl $cpu_gdt_table, %ebp
+	/* patch the base of the ring-1 16bit stack */
+	movw %ax, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 2)(%ebp)
+	shrl $16, %eax
+	movb %al, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 4)(%ebp)
+	movb %ah, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 7)(%ebp)
+	popl %ebp
+	/* push the ESP value to preload on ring-1 */
+	movl 28+12(%esp), %eax
+	movw $4, %ax
+	movl %eax, 4+20(%esp)
+	/* push the iret frame for our ring-1 trampoline */
+	movl $__ESPFIX_SS, 4+16(%esp)
+	movl $0, 4+12(%esp)
+	/* push ring-3 flags only to get the IOPL right */
+	movl 28+8(%esp), %eax
+	andl $IOPL_MASK, %eax
+	/* we need at least IOPL1 to re-enable interrupts */
+	orl $IOPL1_MASK, %eax
+	movl %eax, 4+8(%esp)
+	popl %eax
+	movl $__ESPFIX_CS, 4(%esp)
+	movl $espfix_trampoline, (%esp)
+	iret
 
 	# perform work that needs to be done immediately before resumption
 	ALIGN
@@ -504,7 +575,12 @@
 ENTRY(nmi)
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
-	pushl %eax
+	cmpl $espfix_past_esp,(%esp)
+	jne 1f
+	/* restart the "popl %esp" */
+	decl (%esp)
+	subw $4, 12(%esp)
+1:	pushl %eax
 	movl %esp,%eax
 	/* Do not access memory above the end of our stack page,
 	 * it might not exist.
@@ -523,7 +599,7 @@
 	pushl %edx
 	call do_nmi
 	addl $8, %esp
-	RESTORE_ALL
+	jmp restore_all
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
diff -urN linux-2.6.8-pcsp/arch/i386/kernel/head.S linux-2.6.8-stacks/arch/i386/kernel/head.S
--- linux-2.6.8-pcsp/arch/i386/kernel/head.S	2004-08-10 11:02:36.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/head.S	2004-09-24 13:57:24.000000000 +0400
@@ -514,8 +514,8 @@
 	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
-	.quad 0x0000000000000000	/* 0xd0 - unused */
-	.quad 0x0000000000000000	/* 0xd8 - unused */
+	.quad 0x00cfba000000ffff	/* 0xd0 - ESPfix 32-bit CS */
+	.quad 0x0000b20000000017	/* 0xd8 - ESPfix 16-bit SS */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
 	.quad 0x0000000000000000	/* 0xf0 - unused */
diff -urN linux-2.6.8-pcsp/arch/i386/kernel/traps.c linux-2.6.8-stacks/arch/i386/kernel/traps.c
--- linux-2.6.8-pcsp/arch/i386/kernel/traps.c	2004-08-10 11:02:36.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/traps.c	2004-09-23 17:54:52.000000000 +0400
@@ -210,7 +210,7 @@
 
 	esp = (unsigned long) (&regs->esp);
 	ss = __KERNEL_DS;
-	if (regs->xcs & 3) {
+	if (regs->xcs & 2) {
 		in_kernel = 0;
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
@@ -264,7 +264,7 @@
 	char c;
 	unsigned long eip;
 
-	if (regs->xcs & 3)
+	if (regs->xcs & 2)
 		goto no_bug;		/* Not in kernel */
 
 	eip = regs->eip;
@@ -335,7 +335,7 @@
 
 static inline void die_if_kernel(const char * str, struct pt_regs * regs, long err)
 {
-	if (!(regs->eflags & VM_MASK) && !(3 & regs->xcs))
+	if (!(regs->eflags & VM_MASK) && !(2 & regs->xcs))
 		die(str, regs, err);
 }
 
@@ -357,7 +357,7 @@
 		goto trap_signal;
 	}
 
-	if (!(regs->xcs & 3))
+	if (!(regs->xcs & 2))
 		goto kernel_trap;
 
 	trap_signal: {
@@ -437,7 +437,7 @@
 	if (regs->eflags & VM_MASK)
 		goto gp_in_vm86;
 
-	if (!(regs->xcs & 3))
+	if (!(regs->xcs & 2))
 		goto gp_in_kernel;
 
 	current->thread.error_code = error_code;
@@ -614,7 +614,7 @@
 		 * allowing programs to debug themselves without the ptrace()
 		 * interface.
 		 */
-		if ((regs->xcs & 3) == 0)
+		if ((regs->xcs & 2) == 0)
 			goto clear_TF_reenable;
 		if ((tsk->ptrace & (PT_DTRACE|PT_PTRACED)) == PT_DTRACE)
 			goto clear_TF;
@@ -630,7 +630,7 @@
 	/* If this is a kernel mode trap, save the user PC on entry to 
 	 * the kernel, that's what the debugger can make sense of.
 	 */
-	info.si_addr = ((regs->xcs & 3) == 0) ? (void *)tsk->thread.eip : 
+	info.si_addr = ((regs->xcs & 3) != 3) ? (void *)tsk->thread.eip : 
 	                                        (void *)regs->eip;
 	force_sig_info(SIGTRAP, &info, tsk);
 
diff -urN linux-2.6.8-pcsp/arch/i386/mm/extable.c linux-2.6.8-stacks/arch/i386/mm/extable.c
--- linux-2.6.8-pcsp/arch/i386/mm/extable.c	2004-06-09 15:44:19.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/mm/extable.c	2004-09-23 17:54:52.000000000 +0400
@@ -26,6 +26,11 @@
 	}
 #endif
 
+	if (unlikely(regs->xcs == __ESPFIX_CS))
+	{
+		regs->xcs = __KERNEL_CS;
+	}
+
 	fixup = search_exception_tables(regs->eip);
 	if (fixup) {
 		regs->eip = fixup->fixup;
diff -urN linux-2.6.8-pcsp/arch/i386/mm/fault.c linux-2.6.8-stacks/arch/i386/mm/fault.c
--- linux-2.6.8-pcsp/arch/i386/mm/fault.c	2004-08-10 11:02:37.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/mm/fault.c	2004-09-23 17:54:52.000000000 +0400
@@ -77,7 +77,7 @@
 	u32 seg_ar, seg_limit, base, *desc;
 
 	/* The standard kernel/user address space limit. */
-	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
+	*eip_limit = (seg & 2) ? USER_DS.seg : KERNEL_DS.seg;
 
 	/* Unlikely, but must come before segment checks. */
 	if (unlikely((regs->eflags & VM_MASK) != 0))
diff -urN linux-2.6.8-pcsp/include/asm-i386/segment.h linux-2.6.8-stacks/include/asm-i386/segment.h
--- linux-2.6.8-pcsp/include/asm-i386/segment.h	2004-01-09 09:59:19.000000000 +0300
+++ linux-2.6.8-stacks/include/asm-i386/segment.h	2004-09-23 17:54:52.000000000 +0400
@@ -38,8 +38,8 @@
  *  24 - APM BIOS support
  *  25 - APM BIOS support 
  *
- *  26 - unused
- *  27 - unused
+ *  26 - ESPfix Ring-1 trampoline CS
+ *  27 - ESPfix Ring-1 small SS
  *  28 - unused
  *  29 - unused
  *  30 - unused
@@ -71,14 +71,21 @@
 #define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
+#define GDT_ENTRY_ESPFIX_CS		(GDT_ENTRY_KERNEL_BASE + 14)
+#define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 15)
+#define __ESPFIX_CS (GDT_ENTRY_ESPFIX_CS * 8 + 1)
+#define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8 + 1)
+
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
 /*
  * The GDT has 32 entries
  */
-#define GDT_ENTRIES 32
-
-#define GDT_SIZE (GDT_ENTRIES * 8)
+#define GDT_ENTRIES_SHIFT 5
+#define GDT_ENTRIES (1 << GDT_ENTRIES_SHIFT)
+#define GDT_ENTRY_SHIFT 3
+#define GDT_SIZE_SHIFT (GDT_ENTRIES_SHIFT + GDT_ENTRY_SHIFT)
+#define GDT_SIZE (1 << GDT_SIZE_SHIFT)
 
 /* Simple and small GDT entries for booting only */
 

--------------050406090608020405020105
Content-Type: text/x-patch;
 name="linux-2.6.8-stk0-2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8-stk0-2.diff"

diff -urN linux-2.6.8-pcsp/arch/i386/kernel/entry.S linux-2.6.8-stacks0/arch/i386/kernel/entry.S
--- linux-2.6.8-pcsp/arch/i386/kernel/entry.S	2004-06-10 13:28:35.000000000 +0400
+++ linux-2.6.8-stacks0/arch/i386/kernel/entry.S	2004-10-06 16:29:04.000000000 +0400
@@ -78,7 +78,7 @@
 #define preempt_stop		cli
 #else
 #define preempt_stop
-#define resume_kernel		restore_all
+#define resume_kernel		restore_context
 #endif
 
 #define SAVE_ALL \
@@ -122,25 +122,6 @@
 .previous
 
 
-#define RESTORE_ALL	\
-	RESTORE_REGS	\
-	addl $4, %esp;	\
-1:	iret;		\
-.section .fixup,"ax";   \
-2:	sti;		\
-	movl $(__USER_DS), %edx; \
-	movl %edx, %ds; \
-	movl %edx, %es; \
-	pushl $11;	\
-	call do_exit;	\
-.previous;		\
-.section __ex_table,"a";\
-	.align 4;	\
-	.long 1b,2b;	\
-.previous
-
-
-
 ENTRY(lcall7)
 	pushfl			# We get a different stack layout with call
 				# gates, which has to be cleaned up later..
@@ -197,7 +178,7 @@
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	testl $(VM_MASK | 3), %eax
-	jz resume_kernel		# returning to kernel or vm86-space
+	jz resume_kernel
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -211,7 +192,7 @@
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
-	jnz restore_all
+	jnz restore_context
 need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
@@ -293,8 +274,85 @@
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
+
 restore_all:
-	RESTORE_ALL
+	/* If returning to Ring-3, not to V86, and with
+	 * the small stack, try to fix the higher word of
+	 * ESP, as the CPU won't restore it from stack.
+	 * This is an "official" bug of all the x86-compatible
+	 * CPUs, which we can try to work around to make
+	 * dosemu happy. */
+	movl EFLAGS(%esp), %eax
+	movb CS(%esp), %al
+	andl $(VM_MASK | 3), %eax
+	/* returning to user-space and not to v86? */
+	cmpl $3, %eax
+	jne restore_context
+	larl OLDSS(%esp), %eax
+	/* returning to "small" stack? */
+	testl $0x00400000, %eax
+	jz 8f		# go fixing ESP instead of just to return :(
+restore_context:
+	RESTORE_REGS
+	addl $4, %esp
+1:	iret
+.section .fixup,"ax"
+iret_exc:
+	sti
+	movl $(__USER_DS), %edx
+	movl %edx, %ds
+	movl %edx, %es
+	pushl $11
+	call do_exit
+.previous
+.section __ex_table,"a"
+	.align 4
+	.long 1b,iret_exc
+.previous
+	/* preparing the ESPfix here */
+#define FRAME_SIZE_ESTIM 24
+#define ESPFIX_STACK_RESERVE (FRAME_SIZE_ESTIM * 3)
+#define SP_ESTIMATE (ESPFIX_STACK_RESERVE - FRAME_SIZE_ESTIM)
+#define ESPFIX_SWITCH16_OFFS 20
+#define ESPFIX_SWITCH32_OFFS 28
+#define ESPFIX_SWITCH16 (ESPFIX_STACK_RESERVE + ESPFIX_SWITCH16_OFFS)
+#define ESPFIX_SWITCH32 (ESPFIX_STACK_RESERVE + ESPFIX_SWITCH32_OFFS)
+8:	RESTORE_REGS
+	addl $4, %esp
+	.rept 5
+	pushl 16(%esp)
+	.endr
+	pushl %eax
+	pushl %ebp
+	movl $__ESPFIX_SS, ESPFIX_SWITCH16_OFFS+8+4(%esp)
+	movl 8+12(%esp), %eax
+	movw $ESPFIX_STACK_RESERVE, %ax
+	movl %eax, ESPFIX_SWITCH16_OFFS+8(%esp)
+	movl $__KERNEL_DS, ESPFIX_SWITCH32_OFFS+8+4(%esp)
+	leal -FRAME_SIZE_ESTIM+8(%esp), %eax
+	movl %eax, ESPFIX_SWITCH32_OFFS+8(%esp)
+	subl $(ESPFIX_STACK_RESERVE-FRAME_SIZE_ESTIM), %eax
+	cli
+	GET_THREAD_INFO(%ebp)
+	movl TI_cpu(%ebp), %ebp
+	shll $GDT_SIZE_SHIFT, %ebp
+	/* find GDT of the proper CPU */
+	addl $cpu_gdt_table, %ebp
+	/* patch the base of the 16bit stack */
+	movw %ax, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 2)(%ebp)
+	shrl $16, %eax
+	movb %al, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 4)(%ebp)
+	movb %ah, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 7)(%ebp)
+	popl %ebp
+	popl %eax
+espfix_before_lss:
+	lss ESPFIX_SWITCH16_OFFS(%esp), %esp
+espfix_after_lss:
+	iret
+.section __ex_table,"a"
+	.align 4
+	.long espfix_after_lss,iret_exc
+.previous
 
 	# perform work that needs to be done immediately before resumption
 	ALIGN
@@ -493,6 +551,36 @@
 	pushl $do_debug
 	jmp error_code
 
+/* Check if we are on 16bit stack. Can happen either on iret of ESPFIX,
+ * or in an exception handler after that iret... */
+#define CHECK_ESPFIX_STACK(label) \
+	pushl %eax; \
+	movl %ss, %eax; \
+	cmpl $__ESPFIX_SS, %eax; \
+	jne label;
+/* using %es here because NMI can change %ss */
+#define UNWIND_ESPFIX_STACK \
+	CHECK_ESPFIX_STACK(28f) \
+	pushl %es; \
+	movl %eax, %es; \
+	lss %es:ESPFIX_SWITCH32, %esp; \
+	popl %es; \
+28:	popl %eax;
+/* have to compensate the difference between real SP and estimated. */
+#define UNWIND_ESPFIX_STACK_NMI \
+	CHECK_ESPFIX_STACK(28f) \
+	movw $SP_ESTIMATE, %ax; \
+	subw %sp, %ax; \
+	movswl %ax, %eax; \
+	lss %ss:ESPFIX_SWITCH32, %esp; \
+	subl %eax, %esp; \
+	popl %eax; \
+	cmpl $espfix_after_lss, (%esp); \
+	jne nmi_stack_correct; \
+	movl $espfix_before_lss, (%esp); \
+	jmp nmi_stack_correct; \
+28:	popl %eax;
+
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
  * a debug fault, and the debug fault hasn't yet been able to
@@ -502,6 +590,7 @@
  * fault happened on the sysenter path.
  */
 ENTRY(nmi)
+	UNWIND_ESPFIX_STACK_NMI
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
 	pushl %eax
@@ -523,7 +612,7 @@
 	pushl %edx
 	call do_nmi
 	addl $8, %esp
-	RESTORE_ALL
+	jmp restore_all
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
@@ -569,14 +658,17 @@
 	jmp error_code
 
 ENTRY(segment_not_present)
+	UNWIND_ESPFIX_STACK
 	pushl $do_segment_not_present
 	jmp error_code
 
 ENTRY(stack_segment)
+	UNWIND_ESPFIX_STACK
 	pushl $do_stack_segment
 	jmp error_code
 
 ENTRY(general_protection)
+	UNWIND_ESPFIX_STACK
 	pushl $do_general_protection
 	jmp error_code
 
diff -urN linux-2.6.8-pcsp/arch/i386/kernel/head.S linux-2.6.8-stacks0/arch/i386/kernel/head.S
--- linux-2.6.8-pcsp/arch/i386/kernel/head.S	2004-08-10 11:02:36.000000000 +0400
+++ linux-2.6.8-stacks0/arch/i386/kernel/head.S	2004-10-05 17:53:46.000000000 +0400
@@ -514,7 +514,7 @@
 	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
-	.quad 0x0000000000000000	/* 0xd0 - unused */
+	.quad 0x000092000000ffff	/* 0xd0 - ESPfix 16-bit SS */
 	.quad 0x0000000000000000	/* 0xd8 - unused */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
diff -urN linux-2.6.8-pcsp/include/asm-i386/segment.h linux-2.6.8-stacks0/include/asm-i386/segment.h
--- linux-2.6.8-pcsp/include/asm-i386/segment.h	2004-01-09 09:59:19.000000000 +0300
+++ linux-2.6.8-stacks0/include/asm-i386/segment.h	2004-10-05 17:53:46.000000000 +0400
@@ -38,7 +38,7 @@
  *  24 - APM BIOS support
  *  25 - APM BIOS support 
  *
- *  26 - unused
+ *  26 - ESPfix small SS
  *  27 - unused
  *  28 - unused
  *  29 - unused
@@ -71,14 +71,19 @@
 #define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
+#define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
+#define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
+
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
 /*
  * The GDT has 32 entries
  */
-#define GDT_ENTRIES 32
-
-#define GDT_SIZE (GDT_ENTRIES * 8)
+#define GDT_ENTRIES_SHIFT 5
+#define GDT_ENTRIES (1 << GDT_ENTRIES_SHIFT)
+#define GDT_ENTRY_SHIFT 3
+#define GDT_SIZE_SHIFT (GDT_ENTRIES_SHIFT + GDT_ENTRY_SHIFT)
+#define GDT_SIZE (1 << GDT_SIZE_SHIFT)
 
 /* Simple and small GDT entries for booting only */
 

--------------050406090608020405020105--
