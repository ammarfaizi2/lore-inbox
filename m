Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUJGNqv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUJGNqv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 09:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269639AbUJGNqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 09:46:50 -0400
Received: from mail.aknet.ru ([217.67.122.194]:9224 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S266096AbUJGNpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 09:45:07 -0400
Message-ID: <416441AF.6050302@aknet.ru>
Date: Wed, 06 Oct 2004 23:04:15 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: ESP corruption bug - what CPUs are affected? (patch att
References: <59EA54D0987@vcnet.vc.cvut.cz>
In-Reply-To: <59EA54D0987@vcnet.vc.cvut.cz>
Content-Type: multipart/mixed;
 boundary="------------090807020803090504050901"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090807020803090504050901
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

Petr Vandrovec wrote:
> CPL0 solution is certainly more localized, but I have hard problems
> to convice myself that it is actually safe.
I spent 2 days convincing myself the same way:)
The most problematic part was to make sure that
the stack is properly unwinded even if NMI comes
before the exception handler managed to switch
out of 16bit. But I think this is now handled.

> I would appreciate if you could add comments what values are set
OK, I did. But in fact that makes the patch
only even more obfuscated:( It doesn't look
possible to explain all the magic pattern and
its constraints in a comments. But I tried:)
The patch is attached.

> by ESPFIX_SWITCH_16 + 8 + 4 and simillar moves, and what they actually
> do.
Fortunately there are no such moves.
In an attempt to make the patch a little
self-explanatory, I #define'd all the meaningfull
values. So if there is a move to
ESPFIX_SWITCH16_OFFS+some_value, it is safe to
assume that the move is intended to load the
ESPFIX_SWITCH16, and "some_value" is just the
correction constant. So besides the 2 magic
pointers, there are really no moves above the
iret frame.

> And convicing myself that ESPFIX_SWITCH_32 has just right value so
> pushl %eax
> pushl %es
> lss ESPFIX_SWITCH_32,%esp
> popl %es
> popl %eax
> actually works took almost an hour...
I realize that and thats really the big problem
of that patch. It is very obfuscated and difficult
to understand.
I guess if you see the first version of that
patch, which was before I found the way to use
the fixed offsets for locating the switches,
you might just get sick:)


--------------090807020803090504050901
Content-Type: text/x-patch;
 name="linux-2.6.8-stk0-2a.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.8-stk0-2a.diff"

diff -urN linux-2.6.8-pcsp/arch/i386/kernel/entry.S linux-2.6.8-stacks/arch/i386/kernel/entry.S
--- linux-2.6.8-pcsp/arch/i386/kernel/entry.S	2004-06-26 15:20:23.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/entry.S	2004-10-06 22:39:43.084860592 +0400
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
@@ -293,8 +274,102 @@
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
+/* FRAME_SIZE_ESTIM is the size of an exception stack frame + 8 bytes
+ * for 2 pushes - need to save 2 registers on stack */
+#define FRAME_SIZE_ESTIM 24
+/* ESPFIX_STACK_RESERVE is the value that goes into SP after switch to 16bit */
+#define ESPFIX_STACK_RESERVE (FRAME_SIZE_ESTIM * 3)
+#define SP_ESTIMATE (ESPFIX_STACK_RESERVE - FRAME_SIZE_ESTIM)
+/* iret frame takes 20 bytes.
+ * We hide 2 magic pointers above it, 8 bytes each (seg:off). */
+#define ESPFIX_SWITCH16_OFFS 20
+#define ESPFIX_SWITCH32_OFFS 28
+#define ESPFIX_SWITCH16 (ESPFIX_STACK_RESERVE + ESPFIX_SWITCH16_OFFS)
+#define ESPFIX_SWITCH32 (ESPFIX_STACK_RESERVE + ESPFIX_SWITCH32_OFFS)
+8:	RESTORE_REGS
+	addl $4, %esp
+	/* reserve the room for 2 magic pointers (16 bytes) and 4 bytes wasted. */
+	.rept 5
+	pushl 16(%esp)
+	.endr
+	/* Preserve some registers. That makes all the +8 offsets below. */
+	pushl %eax
+	pushl %ebp
+	/* Set up the SWITCH16 magic pointer. */
+	movl $__ESPFIX_SS, ESPFIX_SWITCH16_OFFS+8+4(%esp)
+	/* Get the "old" ESP */
+	movl 8+12(%esp), %eax
+	/* replace the lower word of "old" ESP with our magic value */
+	movw $ESPFIX_STACK_RESERVE, %ax
+	movl %eax, ESPFIX_SWITCH16_OFFS+8(%esp)
+	/* SWITCH16 ready */
+	/* Now set up the SWITCH32 magic pointer. */
+	movl $__KERNEL_DS, ESPFIX_SWITCH32_OFFS+8+4(%esp)
+	/* ESP must match the SP_ESTIMATE,
+	 * which is FRAME_SIZE_ESTIM below the iret frame */
+	leal -FRAME_SIZE_ESTIM+8(%esp), %eax
+	movl %eax, ESPFIX_SWITCH32_OFFS+8(%esp)
+	/* SWITCH32 ready */
+	/* %eax will make the base of __ESPFIX_SS.
+	 * It have to be ESPFIX_STACK_RESERVE bytes below the iret frame. */
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
@@ -493,6 +568,36 @@
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
@@ -502,6 +607,7 @@
  * fault happened on the sysenter path.
  */
 ENTRY(nmi)
+	UNWIND_ESPFIX_STACK_NMI
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
 	pushl %eax
@@ -523,7 +629,7 @@
 	pushl %edx
 	call do_nmi
 	addl $8, %esp
-	RESTORE_ALL
+	jmp restore_all
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
@@ -569,14 +675,17 @@
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
 
diff -urN linux-2.6.8-pcsp/arch/i386/kernel/head.S linux-2.6.8-stacks/arch/i386/kernel/head.S
--- linux-2.6.8-pcsp/arch/i386/kernel/head.S	2004-07-17 23:31:24.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/head.S	2004-10-06 21:58:04.873646424 +0400
@@ -514,7 +514,7 @@
 	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
-	.quad 0x0000000000000000	/* 0xd0 - unused */
+	.quad 0x000092000000ffff	/* 0xd0 - ESPfix 16-bit SS */
 	.quad 0x0000000000000000	/* 0xd8 - unused */
 	.quad 0x0000000000000000	/* 0xe0 - unused */
 	.quad 0x0000000000000000	/* 0xe8 - unused */
diff -urN linux-2.6.8-pcsp/include/asm-i386/segment.h linux-2.6.8-stacks/include/asm-i386/segment.h
--- linux-2.6.8-pcsp/include/asm-i386/segment.h	2004-01-09 09:59:19.000000000 +0300
+++ linux-2.6.8-stacks/include/asm-i386/segment.h	2004-10-06 21:58:04.000000000 +0400
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
 

--------------090807020803090504050901--
