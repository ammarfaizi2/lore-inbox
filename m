Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129346AbREFBPx>; Sat, 5 May 2001 21:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130485AbREFBPo>; Sat, 5 May 2001 21:15:44 -0400
Received: from femail18.sdc1.sfba.home.com ([24.0.95.145]:56748 "EHLO
	femail18.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S129346AbREFBPa>; Sat, 5 May 2001 21:15:30 -0400
Message-ID: <3AF4A857.DDA3599A@didntduck.org>
Date: Sat, 05 May 2001 21:26:47 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: torvalds@transmeta.com, alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] x86 page fault handler not interrupt safe
Content-Type: multipart/mixed;
 boundary="------------C6899EB6318781022F6013F9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C6899EB6318781022F6013F9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Currently the page fault handler on the x86 can get a clobbered value
for %cr2 if an interrupt occurs and causes another page fault (interrupt
handler touches a vmalloced area for example) before %cr2 is read.  This
patch changes the page fault and alignment check (currently unused)
handlers to interrupt gates so that %cr2 can be read before an interrupt
can occur.  I'm not certain how much of a problem this really is, but I
suspect it could cause random seg faults to user space under heavy
interrupt load.  Comments are welcome.
--------------C6899EB6318781022F6013F9
Content-Type: text/plain; charset=us-ascii;
 name="diff-pagefault"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-pagefault"

diff -urN linux-2.4.5-pre1/arch/i386/kernel/entry.S linux/arch/i386/kernel/entry.S
--- linux-2.4.5-pre1/arch/i386/kernel/entry.S	Wed Nov  8 20:09:50 2000
+++ linux/arch/i386/kernel/entry.S	Sat May  5 16:32:42 2001
@@ -296,20 +296,21 @@
 	pushl %ds
 	pushl %eax
 	xorl %eax,%eax
+error_code_cr2:
 	pushl %ebp
 	pushl %edi
 	pushl %esi
 	pushl %edx
-	decl %eax			# eax = -1
 	pushl %ecx
 	pushl %ebx
 	cld
 	movl %es,%ecx
 	movl ORIG_EAX(%esp), %esi	# get the error code
 	movl ES(%esp), %edi		# get the function address
-	movl %eax, ORIG_EAX(%esp)
+	movl $-1, ORIG_EAX(%esp)
 	movl %ecx, ES(%esp)
 	movl %esp,%edx
+	pushl %eax			# push address (cr2)
 	pushl %esi			# push the error code
 	pushl %edx			# push the pt_regs pointer
 	movl $(__KERNEL_DS),%edx
@@ -317,7 +318,7 @@
 	movl %edx,%es
 	GET_CURRENT(%ebx)
 	call *%edi
-	addl $8,%esp
+	addl $12,%esp
 	jmp ret_from_exception
 
 ENTRY(coprocessor_error)
@@ -405,11 +406,18 @@
 
 ENTRY(alignment_check)
 	pushl $ SYMBOL_NAME(do_alignment_check)
-	jmp error_code
+	jmp get_cr2
 
 ENTRY(page_fault)
 	pushl $ SYMBOL_NAME(do_page_fault)
-	jmp error_code
+get_cr2:
+	pushl %ds
+	pushl %eax
+	movl %cr2,%eax
+	testl $IF_MASK,EFLAGS-EAX(%esp)
+	jz error_code_cr2
+	sti
+	jmp error_code_cr2
 
 ENTRY(machine_check)
 	pushl $0
diff -urN linux-2.4.5-pre1/arch/i386/kernel/traps.c linux/arch/i386/kernel/traps.c
--- linux-2.4.5-pre1/arch/i386/kernel/traps.c	Mon Mar 19 21:23:40 2001
+++ linux/arch/i386/kernel/traps.c	Sat May  5 16:03:22 2001
@@ -225,15 +225,6 @@
 		die(str, regs, err);
 }
 
-static inline unsigned long get_cr2(void)
-{
-	unsigned long address;
-
-	/* get the address */
-	__asm__("movl %%cr2,%0":"=r" (address));
-	return address;
-}
-
 static void inline do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
@@ -270,13 +261,13 @@
 }
 
 #define DO_ERROR(trapnr, signr, str, name) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
+asmlinkage void do_##name(struct pt_regs * regs, long error_code, unsigned long address) \
 { \
 	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
 }
 
 #define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
+asmlinkage void do_##name(struct pt_regs * regs, long error_code, unsigned long address) \
 { \
 	siginfo_t info; \
 	info.si_signo = signr; \
@@ -287,13 +278,13 @@
 }
 
 #define DO_VM86_ERROR(trapnr, signr, str, name) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
+asmlinkage void do_##name(struct pt_regs * regs, long error_code, unsigned long address) \
 { \
 	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
 }
 
 #define DO_VM86_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
+asmlinkage void do_##name(struct pt_regs * regs, long error_code, unsigned long address) \
 { \
 	siginfo_t info; \
 	info.si_signo = signr; \
@@ -314,7 +305,7 @@
 DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
 DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
-DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, get_cr2())
+DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, address)
 
 asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
 {
@@ -973,10 +964,10 @@
 	set_trap_gate(11,&segment_not_present);
 	set_trap_gate(12,&stack_segment);
 	set_trap_gate(13,&general_protection);
-	set_trap_gate(14,&page_fault);
+	set_intr_gate(14,&page_fault);
 	set_trap_gate(15,&spurious_interrupt_bug);
 	set_trap_gate(16,&coprocessor_error);
-	set_trap_gate(17,&alignment_check);
+	set_intr_gate(17,&alignment_check);
 	set_trap_gate(18,&machine_check);
 	set_trap_gate(19,&simd_coprocessor_error);
 
diff -urN linux-2.4.5-pre1/arch/i386/mm/fault.c linux/arch/i386/mm/fault.c
--- linux-2.4.5-pre1/arch/i386/mm/fault.c	Wed May  2 09:24:09 2001
+++ linux/arch/i386/mm/fault.c	Sat May  5 17:34:41 2001
@@ -103,19 +103,15 @@
  *	bit 1 == 0 means read, 1 means write
  *	bit 2 == 0 means kernel, 1 means user-mode
  */
-asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code)
+asmlinkage void do_page_fault(struct pt_regs *regs, unsigned long error_code, unsigned long address)
 {
 	struct task_struct *tsk;
 	struct mm_struct *mm;
 	struct vm_area_struct * vma;
-	unsigned long address;
 	unsigned long page;
 	unsigned long fixup;
 	int write;
 	siginfo_t info;
-
-	/* get the address */
-	__asm__("movl %%cr2,%0":"=r" (address));
 
 	tsk = current;
 

--------------C6899EB6318781022F6013F9--

