Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267915AbTAMGYM>; Mon, 13 Jan 2003 01:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267925AbTAMGYM>; Mon, 13 Jan 2003 01:24:12 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:9125 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S267915AbTAMGYI>; Mon, 13 Jan 2003 01:24:08 -0500
Message-ID: <3E225DA5.1050404@quark.didntduck.org>
Date: Mon, 13 Jan 2003 01:33:09 -0500
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Cleanup vm86 fault handling
Content-Type: multipart/mixed;
 boundary="------------070307060305080205080201"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070307060305080205080201
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

This patch makes handle_vm86_trap() accept or reject traps, instead of 
handling it in do_trap().  This enables some extra cleanups with the 
general protection fault and cache flush fault.

--
				Brian Gerst

--------------070307060305080205080201
Content-Type: text/plain;
 name="traps-b1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="traps-b1"

diff -urN linux-a1/arch/i386/kernel/traps.c linux-b1/arch/i386/kernel/traps.c
--- linux-a1/arch/i386/kernel/traps.c	Sat Jan 11 03:29:47 2003
+++ linux-b1/arch/i386/kernel/traps.c	Sat Jan 11 03:30:22 2003
@@ -258,12 +258,6 @@
 	do_exit(SIGSEGV);
 }
 
-static inline void die_if_kernel(const char * str, struct pt_regs * regs, long err)
-{
-	if (!(regs->eflags & VM_MASK) && !(3 & regs->xcs))
-		die(str, regs, err);
-}
-
 static inline unsigned long get_cr2(void)
 {
 	unsigned long address;
@@ -273,14 +267,11 @@
 	return address;
 }
 
-static inline void do_trap(int trapnr, int signr, char *str, int vm86,
+static inline void do_trap(int trapnr, int signr, char *str,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
-	if (regs->eflags & VM_MASK) {
-		if (vm86)
-			goto vm86_trap;
-		goto trap_signal;
-	}
+	if (regs->eflags & VM_MASK)
+		goto vm86_trap;
 
 	if (!(regs->xcs & 3))
 		goto kernel_trap;
@@ -303,8 +294,8 @@
 	}
 
 	vm86_trap: {
-		int ret = handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr);
-		if (ret) goto trap_signal;
+		if (handle_vm86_trap((struct kernel_vm86_regs *) regs, error_code, trapnr))
+			goto trap_signal;
 		return;
 	}
 }
@@ -312,7 +303,7 @@
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
-	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
+	do_trap(trapnr, signr, str, regs, error_code, NULL); \
 }
 
 #define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
@@ -323,61 +314,23 @@
 	info.si_errno = 0; \
 	info.si_code = sicode; \
 	info.si_addr = (void *)siaddr; \
-	do_trap(trapnr, signr, str, 0, regs, error_code, &info); \
-}
-
-#define DO_VM86_ERROR(trapnr, signr, str, name) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
-{ \
-	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
+	do_trap(trapnr, signr, str, regs, error_code, &info); \
 }
 
-#define DO_VM86_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
-asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
-{ \
-	siginfo_t info; \
-	info.si_signo = signr; \
-	info.si_errno = 0; \
-	info.si_code = sicode; \
-	info.si_addr = (void *)siaddr; \
-	do_trap(trapnr, signr, str, 1, regs, error_code, &info); \
-}
-
-DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
-DO_VM86_ERROR( 3, SIGTRAP, "int3", int3)
-DO_VM86_ERROR( 4, SIGSEGV, "overflow", overflow)
-DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
+DO_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
+DO_ERROR( 3, SIGTRAP, "int3", int3)
+DO_ERROR( 4, SIGSEGV, "overflow", overflow)
+DO_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid operand", invalid_op, ILL_ILLOPN, regs->eip)
-DO_VM86_ERROR( 7, SIGSEGV, "device not available", device_not_available)
+DO_ERROR( 7, SIGSEGV, "device not available", device_not_available)
 DO_ERROR( 8, SIGSEGV, "double fault", double_fault)
 DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)
 DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
 DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
+DO_ERROR(13, SIGSEGV, "general protection fault", general_protection)
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, get_cr2())
 
-asmlinkage void do_general_protection(struct pt_regs * regs, long error_code)
-{
-	if (regs->eflags & VM_MASK)
-		goto gp_in_vm86;
-
-	if (!(regs->xcs & 3))
-		goto gp_in_kernel;
-
-	current->thread.error_code = error_code;
-	current->thread.trap_no = 13;
-	force_sig(SIGSEGV, current);
-	return;
-
-gp_in_vm86:
-	handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
-	return;
-
-gp_in_kernel:
-	if (!fixup_exception(regs))
-		die("general protection fault", regs, error_code);
-}
-
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
 {
 	printk("Uhhuh. NMI received. Dazed and confused, but trying to continue\n");
@@ -703,15 +656,7 @@
 		 * Handle strange cache flush from user space exception
 		 * in all other cases.  This is undocumented behaviour.
 		 */
-		if (regs->eflags & VM_MASK) {
-			handle_vm86_fault((struct kernel_vm86_regs *)regs,
-					  error_code);
-			return;
-		}
-		die_if_kernel("cache flush denied", regs, error_code);
-		current->thread.trap_no = 19;
-		current->thread.error_code = error_code;
-		force_sig(SIGSEGV, current);
+		do_trap(19, SIGSEGV, "cache flush denied", regs, error_code, NULL);
 	}
 }
 
diff -urN linux-a1/arch/i386/kernel/vm86.c linux-b1/arch/i386/kernel/vm86.c
--- linux-a1/arch/i386/kernel/vm86.c	Sat Jan 11 03:25:01 2003
+++ linux-b1/arch/i386/kernel/vm86.c	Sat Jan 11 03:30:22 2003
@@ -502,6 +502,21 @@
 
 int handle_vm86_trap(struct kernel_vm86_regs * regs, long error_code, int trapno)
 {
+	switch(trapno) {
+	case 13:
+	case 19:
+		handle_vm86_fault(regs, error_code);
+		return 0;
+	case 0:
+	case 1:
+	case 3:
+	case 4:
+	case 7:
+		break;
+	default:
+		return 1;
+	};
+
 	if (VMPI.is_vm86pus) {
 		if ( (trapno==3) || (trapno==1) )
 			return_to_32bit(regs, VM86_TRAP + (trapno << 8));

--------------070307060305080205080201--

