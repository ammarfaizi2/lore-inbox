Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266561AbUIWRDS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUIWRDS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 13:03:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUIWRCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 13:02:55 -0400
Received: from mail.aknet.ru ([217.67.122.194]:22023 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S268019AbUIWQ6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 12:58:46 -0400
Message-ID: <41530326.2050900@aknet.ru>
Date: Thu, 23 Sep 2004 21:08:54 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ESP corruption bug - what CPUs are affected?
References: <3BFF2F87096@vcnet.vc.cvut.cz> <414C662D.5090607@aknet.ru> <20040918165932.GA15570@vana.vc.cvut.cz> <414C8924.1070701@aknet.ru> <20040918203529.GA4447@vana.vc.cvut.cz> <4151C949.1080807@aknet.ru> <20040922200228.GB11017@vana.vc.cvut.cz>
In-Reply-To: <20040922200228.GB11017@vana.vc.cvut.cz>
Content-Type: multipart/mixed;
 boundary="------------070208080104030806070301"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070208080104030806070301
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

I'll reply to that mail again because my previous
reply was done in a big hurry.
The new patch is attached. I applied most of the
optimizations you suggested and reverted the things
you said were unnecessary/wrong - thanks.
Does this one look better?

Petr Vandrovec wrote:
>> 1. I am not allocating the ring1 stack separately,
>> I am allocating it on a ring0 stack. Much simpler
>> code, although non-reentrant/preempt-unsafe.
> I think that it is problem.  And do not forget that NMI can occur at any
> place, so I'm not quite sure how your code works.
I assume this was a misunderstanding. Now I use
"preempt_stop" instead of "cli" to make it more
obvious what am I doing. So I assume that part is
preempt-unsafe, but not NMI-unsafe.

>> +#define NMI_STACK_RESERVE 0x400
>> +#define MAKE_ESPFIX \
>> +	cli; \
>> +	subl $NMI_STACK_RESERVE, %esp; \
> This is ugly.  What if NMI handler uses more than 1KB?
In that new patch I set the const to 0xe00, which
is 3,5K. Is it still the limitation? I can probably
raise it ever higher, but I am not sure if there is
some sensible data below the stack that I may overwrite
ocasionally?

> And ESP is not
> multiple of 4 here - it may slow down processor a bit.
Fixed with "pushl/movw".

> I'm not sure about lea speed.  And fast path should NOT jump,
> forward jumps are initialy predicted as not taken... Maybe:
Done. Looks much better now!

> And then you can move MAKE_ESPFIX out of macro.
He-he, but RESTORE_ALL is a macro itself, so... :)

> Maybe you want to introduce some per-thread flag,
What kind of flag do you have in mind? Flag the
modify_ldt() calls that set some segment to 16bit?
But is it really worth the 8 insns I use? Checking
the per-thread flag will cost you ~5 insns anyway,
and a headache...

> or leave syscall path
> to corrupt ESP (dosemu apps should not call Linux INT syscall, yes?).
I wanted to do that, but then recalled the comment
of Pavel Machek, who thinks exporting the %esp
value to user-space is an "informational leak".
I personally don't see the security threat here,
but it looks safe to assume that Pavel is right.
In which case I think we have to root out the
bug from every path, including the syscall. So I
left that place as is for now.

>> -	if (regs->xcs & 3)
>> +	if (regs->xcs & 2)
>>  		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
> I think you should leave this as is, regs->xss/regs->esp should be valid
> for CPL1 exceptions.
OK, everything you mentioned, is reverted.

> Rest looks fine, but I'm not completely sure that SMP and NMIs are
> handled in the best possible way.
Well, even though my patch can be improved, I don't
feel quite comfortable with its complexity.
Now I really want to re-assure myself that this all
is not possible to do on ring0, in which case this
will simply be the trivial thing.
Anonymous LKML reader (whom I have to thank for the
hints) proposed 2 things:
1. Try lss followed by iret. In that case the interrupt
will not kill us because after lss the interrupts are
not accepted until the next insn is executed, AFAIK.
But he was not sure, and I don't know either, if it is
true even for NMI. So if it is - we could just do
lss/iret, and the problem is solved. So is this true
for NMI? Is this documented anywhere?
2. Set task gate for NMI. AFAICS, the task-gate is
now used only for the doublefault exception, but not
for NMI. If I understand the idea correctly, this
will guarantee that the NMI will be executing on a
separate stack, which may be a good idea in any case,
and will allow us to use the small stack at ring-0,
if only we disable the interrupts. Are there any
chances to use the task-gate for NMI? I may even try to
implement that myself, but I guess there are *reasons*
why it is not yet? (of course this applies only if 1.
fails)

Or maybe somehow to modify the NMI handler itself,
so that it will check if it is on a "small" stack,
and switch to the "big" stack before anything else?
Well, doing the whole trick at ring-0 sounds really
plausible to me...


--------------070208080104030806070301
Content-Type: text/x-patch;
 name="linux-2.6.8-stacks3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8-stacks3.diff"

diff -urN linux-2.6.8-pcsp/arch/i386/kernel/entry.S linux-2.6.8-stacks/arch/i386/kernel/entry.S
--- linux-2.6.8-pcsp/arch/i386/kernel/entry.S	2004-06-10 13:28:35.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/entry.S	2004-09-23 16:14:55.209520160 +0400
@@ -70,9 +70,16 @@
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
@@ -122,8 +129,23 @@
 .previous
 
 
+#define NMI_STACK_RESERVE 0xe00
+/* If returning to Ring-3, not to V86, and with
+ * the small stack, try to fix the higher word of
+ * ESP, as the CPU won't restore it from stack.
+ * This is an "official" bug of all the x86-compatible
+ * CPUs, which we can try to work around to make
+ * dosemu happy. */
 #define RESTORE_ALL	\
-	RESTORE_REGS	\
+	movl EFLAGS(%esp), %eax; \
+	movb CS(%esp), %al; \
+	andl $(VM_MASK | 2), %eax; \
+	cmpl $2, %eax;  \
+	jne 3f;         \
+	larl OLDSS(%esp), %eax; \
+	testl $0x00400000, %eax; \
+3:	RESTORE_REGS	\
+	jz 8f;          \
 	addl $4, %esp;	\
 1:	iret;		\
 .section .fixup,"ax";   \
@@ -137,8 +159,43 @@
 .section __ex_table,"a";\
 	.align 4;	\
 	.long 1b,2b;	\
-.previous
-
+.previous; \
+	/* preparing the ESPfix here */ \
+	/* reserve some space on stack for the NMI handler */ \
+8:	subl $(NMI_STACK_RESERVE-4), %esp; \
+	.rept 5; \
+	pushl NMI_STACK_RESERVE+16(%esp); \
+	.endr; \
+	pushl %eax; \
+	movl %esp, %eax; \
+	pushl %ebp; \
+	preempt_stop; \
+	GET_THREAD_INFO(%ebp); \
+	movl TI_cpu(%ebp), %ebp; \
+	shll $GDT_SIZE_SHIFT, %ebp; \
+	/* find GDT of the proper CPU */ \
+	addl $cpu_gdt_table, %ebp; \
+	/* patch the base of the ring-1 16bit stack */ \
+	movw %ax, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 2)(%ebp); \
+	shrl $16, %eax; \
+	movb %al, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 4)(%ebp); \
+	movb %ah, ((GDT_ENTRY_ESPFIX_SS << GDT_ENTRY_SHIFT) + 7)(%ebp); \
+	popl %ebp; \
+	popl %eax; \
+	/* push the ESP value to preload on ring-1 */ \
+	pushl 12(%esp); \
+	movw $4, (%esp); \
+	/* push the iret frame for our ring-1 trampoline */ \
+	pushl $__ESPFIX_SS; \
+	pushl $0; \
+	/* push ring-3 flags only to get the IOPL right */ \
+	pushl 20(%esp); \
+	andl $~(IF_MASK | TF_MASK | RF_MASK | NT_MASK | AC_MASK), (%esp); \
+	/* we need at least IOPL1 to re-enable interrupts */ \
+	orl $IOPL1_MASK, (%esp); \
+	pushl $__ESPFIX_CS; \
+	pushl $espfix_trampoline; \
+	iret;
 
 
 ENTRY(lcall7)
@@ -174,6 +231,23 @@
 	jmp do_lcall
 
 
+ENTRY(espfix_trampoline)
+	popl %esp
+espfix_past_esp:
+1:	iret
+.section .fixup,"ax"
+2:	sti
+	movl $(__USER_DS), %edx
+	movl %edx, %ds
+	movl %edx, %es
+	pushl $11
+	call do_exit
+.previous
+.section __ex_table,"a"
+	.align 4
+	.long 1b,2b
+.previous
+
 ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
@@ -196,7 +270,7 @@
 	GET_THREAD_INFO(%ebp)
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
+	testl $(VM_MASK | 2), %eax
 	jz resume_kernel		# returning to kernel or vm86-space
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
@@ -504,7 +578,12 @@
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
diff -urN linux-2.6.8-pcsp/arch/i386/kernel/head.S linux-2.6.8-stacks/arch/i386/kernel/head.S
--- linux-2.6.8-pcsp/arch/i386/kernel/head.S	2004-08-10 11:02:36.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/head.S	2004-09-21 14:58:16.000000000 +0400
@@ -514,8 +514,8 @@
 	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
-	.quad 0x0000000000000000	/* 0xd0 - unused */
-	.quad 0x0000000000000000	/* 0xd8 - unused */
+	.quad 0x00cfba000000ffff	/* 0xd0 - ESPfix CS */
+	.quad 0x0000b2000000ffff	/* 0xd8 - ESPfix SS */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
 	.quad 0x0000000000000000	/* 0xf0 - unused */
diff -urN linux-2.6.8-pcsp/arch/i386/kernel/traps.c linux-2.6.8-stacks/arch/i386/kernel/traps.c
--- linux-2.6.8-pcsp/arch/i386/kernel/traps.c	2004-08-10 11:02:36.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/traps.c	2004-09-23 10:39:53.000000000 +0400
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
+++ linux-2.6.8-stacks/arch/i386/mm/extable.c	2004-09-21 17:17:05.000000000 +0400
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
+++ linux-2.6.8-stacks/arch/i386/mm/fault.c	2004-09-21 16:03:28.000000000 +0400
@@ -77,7 +77,7 @@
 	u32 seg_ar, seg_limit, base, *desc;
 
 	/* The standard kernel/user address space limit. */
-	*eip_limit = (seg & 3) ? USER_DS.seg : KERNEL_DS.seg;
+	*eip_limit = (seg & 2) ? USER_DS.seg : KERNEL_DS.seg;
 
 	/* Unlikely, but must come before segment checks. */
 	if (unlikely((regs->eflags & VM_MASK) != 0))
diff -urN linux-2.6.8-pcsp/include/asm-i386/segment.h linux-2.6.8-stacks/include/asm-i386/segment.h
--- linux-2.6.8-pcsp/include/asm-i386/segment.h	2004-01-09 09:59:19.000000000 +0300
+++ linux-2.6.8-stacks/include/asm-i386/segment.h	2004-09-21 14:57:44.000000000 +0400
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
 

--------------070208080104030806070301--
