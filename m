Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261308AbUJ3UWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbUJ3UWZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 16:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbUJ3UWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 16:22:25 -0400
Received: from mail.aknet.ru ([217.67.122.194]:18194 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261308AbUJ3UTe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 16:19:34 -0400
Message-ID: <418406AD.9040206@aknet.ru>
Date: Sun, 31 Oct 2004 01:25:01 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux kernel <linux-kernel@vger.kernel.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: [patch] i386: restore ESP value on return to userspace
Content-Type: multipart/mixed;
 boundary="------------070600050108010809000401"
X-AV-Checked: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070600050108010809000401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew.

There is a bug in Intel CPUs, which is described here:
http://www.intel.com/design/intarch/specupdt/27287402.PDF
"ISSUE: When a 32-bit IRET is used to return to another privilege level,
and the old level uses a 4G stack (D/B bit in the segment register = 1),
while the new level uses a 64k stack (D/B bit = 0), then only the 
lower word of ESP is updated."

This CPU bug hurts the projects like dosemu
and wine, and it can be worked around only
in kernel. Also, as suggested by Pavel Machek,
exporting the high word of kernel's stack
pointer to userspace is an "information leak".
The complete discussion can be found here:
http://groups.google.com/groups?hl=ru&lr=&frame=right&th=f5709268cf83e2da&seekm=2F8IB-7P0-31%40gated-at.bofh.it#link1

Attached patch checks if the userspace
process uses the "small" stack, and if it
does, then kernel switches to the "small"
stack itself and preloads the user's value
into a high word of %esp.
Additional care is taken to switch back to
32bit stack in case of an exception or NMI
while on a 16bit stack in kernel.

Acked-by: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Signed-off-by: Stas Sergeev <stsp@aknet.ru>

< End of description >

Andrew, can this please be applied?

Actually, there are two diffs attached.
I was confused by reading this:
http://www.zip.com.au/~akpm/linux/patches/stuff/tpp.txt
3.b says that I should *not* specify the
kernel version against which the patch is
made, while 4.c implies that this info is
actually needed, because the patch can be
done against the Linus tree and/or -mm tree.
Also 4.c encourages to make the patches
against the Linus tree (which I find strange)
even if there are rejects with -mm, because
you say you'll work out the rejects yourself.
But my patch is slightly different for Linus
and -mm trees, so resolving the rejects may
not work.
To work around all that confusion, I attached
patches for both trees and hardcoded the kernel
versions into diff file names. Hope this will
do the trick.


--------------070600050108010809000401
Content-Type: text/x-patch;
 name="linux-2.6.10-rc1-mm2-stk0-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.10-rc1-mm2-stk0-1.diff"

diff -urN linux-2.6.8-pcsp/arch/i386/kernel/entry.S linux-2.6.8-stacks/arch/i386/kernel/entry.S
--- linux-2.6.8-pcsp/arch/i386/kernel/entry.S	2004-06-26 15:20:23.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/entry.S	2004-10-09 20:55:36.772613096 +0400
@@ -90,7 +90,7 @@
 #define preempt_stop		cli
 #else
 #define preempt_stop
-#define resume_kernel		restore_all
+#define resume_kernel		resume_kernelX
 #endif
 
 #define SAVE_ALL \
@@ -135,24 +135,6 @@
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
 ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
@@ -176,7 +158,7 @@
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	testl $(VM_MASK | 3), %eax
-	jz resume_kernel		# returning to kernel or vm86-space
+	jz resume_kernel
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -190,7 +172,7 @@
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
-	jnz restore_all
+	jnz resume_kernelX
 need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
@@ -273,20 +255,105 @@
 	testw $_TIF_ALLWORK_MASK, %cx	# current->work
 	jne syscall_exit_work
 restore_all:
-#ifdef CONFIG_TRAP_BAD_SYSCALL_EXITS
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
-	jz resume_kernelX		# returning to kernel or vm86-space
+	andl $(VM_MASK | 3), %eax
+	cmpl $3, %eax
+	jne resume_kernelX		# returning to kernel or vm86-space
 
+#ifdef CONFIG_TRAP_BAD_SYSCALL_EXITS
 	cmpl $0,TI_preempt_count(%ebp)  # non-zero preempt_count ?
-	jz resume_kernelX
-
+	jz 47f
         int $3
+47:
+#endif
 
+	/* If returning to Ring-3, not to V86, and with
+	 * the small stack, try to fix the higher word of
+	 * ESP, as the CPU won't restore it from stack.
+	 * This is an "official" bug of all the x86-compatible
+	 * CPUs, which we can try to work around to make
+	 * dosemu happy. */
+	larl OLDSS(%esp), %eax
+	testl $0x00400000, %eax		# returning to "small" stack?
+	jz 8f				# go fixing ESP instead of just to return :(
 resume_kernelX:
-#endif
-	RESTORE_ALL
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
+/* FRAME_SIZE_ESTIM is the size of an exception stack frame + 40 bytes
+ * for 10 pushes */
+#define FRAME_SIZE_ESTIM (16 + 10 * 4)
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
+	/* Now set up the SWITCH32 magic pointer. */
+	movl $__KERNEL_DS, ESPFIX_SWITCH32_OFFS+8+4(%esp)
+	/* ESP must match the SP_ESTIMATE,
+	 * which is FRAME_SIZE_ESTIM bytes below the iret frame */
+	leal -FRAME_SIZE_ESTIM+8(%esp), %eax
+	movl %eax, ESPFIX_SWITCH32_OFFS+8(%esp)
+	/* %eax will make the base of __ESPFIX_SS.
+	 * It have to be ESPFIX_STACK_RESERVE bytes below the iret frame. */
+	subl $(ESPFIX_STACK_RESERVE-FRAME_SIZE_ESTIM), %eax
+	cli
+	GET_THREAD_INFO(%ebp)
+	/* find GDT of the proper CPU */
+	movl TI_cpu(%ebp), %ebp
+	shll $2, %ebp
+	movl __per_cpu_offset(%ebp), %ebp
+	addl $per_cpu__cpu_gdt_table, %ebp
+	/* patch the base of the 16bit stack */
+	movw %ax, GDT_ENTRY_ESPFIX_SS*8+2(%ebp)
+	shrl $16, %eax
+	movb %al, GDT_ENTRY_ESPFIX_SS*8+4(%ebp)
+	movb %ah, GDT_ENTRY_ESPFIX_SS*8+7(%ebp)
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
@@ -388,6 +455,34 @@
 	call do_IRQ
 	jmp ret_from_intr
 
+/* Check if we are on 16bit stack. Can happen either on iret of ESPFIX,
+ * or in an exception handler after that iret... */
+#define CHECK_ESPFIX_STACK(label) \
+	pushl %eax; \
+	movl %ss, %eax; \
+	cmpw $__ESPFIX_SS, %ax; \
+	jne label;
+/* using %es here because NMI can change %ss */
+#define UNWIND_ESPFIX_STACK \
+	CHECK_ESPFIX_STACK(28f) \
+	movl %eax, %es; \
+	lss %es:ESPFIX_SWITCH32, %esp; \
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
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
 	pushl $nr-256;			\
@@ -425,6 +520,7 @@
 	pushl %ebx
 	cld
 	movl %es, %ecx
+	UNWIND_ESPFIX_STACK		# this corrupts %es
 	movl ORIG_EAX(%esp), %esi	# get the error code
 	movl ES(%esp), %edi		# get the function address
 	movl %eax, ORIG_EAX(%esp)
@@ -511,6 +607,7 @@
  * fault happened on the sysenter path.
  */
 ENTRY(nmi)
+	UNWIND_ESPFIX_STACK_NMI
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
 	pushl %eax
@@ -532,7 +629,7 @@
 	pushl %edx
 	call do_nmi
 	addl $8, %esp
-	RESTORE_ALL
+	jmp restore_all
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
diff -urN linux-2.6.8-pcsp/arch/i386/kernel/head.S linux-2.6.8-stacks/arch/i386/kernel/head.S
--- linux-2.6.8-pcsp/arch/i386/kernel/head.S	2004-07-17 23:31:24.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/head.S	2004-10-06 21:58:04.000000000 +0400
@@ -514,7 +514,7 @@
 	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
-	.quad 0x0000000000000000	/* 0xd0 - unused */
+	.quad 0x000092000000ffff	/* 0xd0 - ESPFIX 16-bit SS */
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
+ *  26 - ESPFIX small SS
  *  27 - unused
  *  28 - unused
  *  29 - unused
@@ -71,6 +71,9 @@
 #define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
+#define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
+#define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
+
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
 /*

--------------070600050108010809000401
Content-Type: text/x-patch;
 name="linux-2.6.10-rc1-stk0-1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6.10-rc1-stk0-1.diff"

diff -urN linux-2.6.8-pcsp/arch/i386/kernel/entry.S linux-2.6.8-stacks/arch/i386/kernel/entry.S
--- linux-2.6.8-pcsp/arch/i386/kernel/entry.S	2004-06-26 15:20:23.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/entry.S	2004-10-09 20:55:36.772613096 +0400
@@ -78,7 +78,7 @@
 #define preempt_stop		cli
 #else
 #define preempt_stop
-#define resume_kernel		restore_all
+#define resume_kernel		restore_context
 #endif
 
 #define SAVE_ALL \
@@ -122,24 +122,6 @@
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
 ENTRY(ret_from_fork)
 	pushl %eax
 	call schedule_tail
@@ -163,7 +145,7 @@
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
 	testl $(VM_MASK | 3), %eax
-	jz resume_kernel		# returning to kernel or vm86-space
+	jz resume_kernel
 ENTRY(resume_userspace)
  	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -177,7 +159,7 @@
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
-	jnz restore_all
+	jnz restore_context
 need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
@@ -259,8 +241,101 @@
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
+/* FRAME_SIZE_ESTIM is the size of an exception stack frame + 40 bytes
+ * for 10 pushes */
+#define FRAME_SIZE_ESTIM (16 + 10 * 4)
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
+	/* Now set up the SWITCH32 magic pointer. */
+	movl $__KERNEL_DS, ESPFIX_SWITCH32_OFFS+8+4(%esp)
+	/* ESP must match the SP_ESTIMATE,
+	 * which is FRAME_SIZE_ESTIM bytes below the iret frame */
+	leal -FRAME_SIZE_ESTIM+8(%esp), %eax
+	movl %eax, ESPFIX_SWITCH32_OFFS+8(%esp)
+	/* %eax will make the base of __ESPFIX_SS.
+	 * It have to be ESPFIX_STACK_RESERVE bytes below the iret frame. */
+	subl $(ESPFIX_STACK_RESERVE-FRAME_SIZE_ESTIM), %eax
+	cli
+	GET_THREAD_INFO(%ebp)
+	/* find GDT of the proper CPU */
+	movl TI_cpu(%ebp), %ebp
+	shll $2, %ebp
+	movl __per_cpu_offset(%ebp), %ebp
+	addl $per_cpu__cpu_gdt_table, %ebp
+	/* patch the base of the 16bit stack */
+	movw %ax, GDT_ENTRY_ESPFIX_SS*8+2(%ebp)
+	shrl $16, %eax
+	movb %al, GDT_ENTRY_ESPFIX_SS*8+4(%ebp)
+	movb %ah, GDT_ENTRY_ESPFIX_SS*8+7(%ebp)
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
@@ -362,6 +437,34 @@
 	call do_IRQ
 	jmp ret_from_intr
 
+/* Check if we are on 16bit stack. Can happen either on iret of ESPFIX,
+ * or in an exception handler after that iret... */
+#define CHECK_ESPFIX_STACK(label) \
+	pushl %eax; \
+	movl %ss, %eax; \
+	cmpw $__ESPFIX_SS, %ax; \
+	jne label;
+/* using %es here because NMI can change %ss */
+#define UNWIND_ESPFIX_STACK \
+	CHECK_ESPFIX_STACK(28f) \
+	movl %eax, %es; \
+	lss %es:ESPFIX_SWITCH32, %esp; \
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
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
 	pushl $nr-256;			\
@@ -389,6 +492,7 @@
 	pushl %ebx
 	cld
 	movl %es, %ecx
+	UNWIND_ESPFIX_STACK		# this corrupts %es
 	movl ORIG_EAX(%esp), %esi	# get the error code
 	movl ES(%esp), %edi		# get the function address
 	movl %eax, ORIG_EAX(%esp)
@@ -475,6 +579,7 @@
  * fault happened on the sysenter path.
  */
 ENTRY(nmi)
+	UNWIND_ESPFIX_STACK_NMI
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
 	pushl %eax
@@ -496,7 +601,7 @@
 	pushl %edx
 	call do_nmi
 	addl $8, %esp
-	RESTORE_ALL
+	jmp restore_all
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
diff -urN linux-2.6.8-pcsp/arch/i386/kernel/head.S linux-2.6.8-stacks/arch/i386/kernel/head.S
--- linux-2.6.8-pcsp/arch/i386/kernel/head.S	2004-07-17 23:31:24.000000000 +0400
+++ linux-2.6.8-stacks/arch/i386/kernel/head.S	2004-10-06 21:58:04.000000000 +0400
@@ -514,7 +514,7 @@
 	.quad 0x00009a0000000000	/* 0xc0 APM CS 16 code (16 bit) */
 	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
 
-	.quad 0x0000000000000000	/* 0xd0 - unused */
+	.quad 0x000092000000ffff	/* 0xd0 - ESPFIX 16-bit SS */
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
+ *  26 - ESPFIX small SS
  *  27 - unused
  *  28 - unused
  *  29 - unused
@@ -71,6 +71,9 @@
 #define GDT_ENTRY_PNPBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 6)
 #define GDT_ENTRY_APMBIOS_BASE		(GDT_ENTRY_KERNEL_BASE + 11)
 
+#define GDT_ENTRY_ESPFIX_SS		(GDT_ENTRY_KERNEL_BASE + 14)
+#define __ESPFIX_SS (GDT_ENTRY_ESPFIX_SS * 8)
+
 #define GDT_ENTRY_DOUBLEFAULT_TSS	31
 
 /*

--------------070600050108010809000401--
