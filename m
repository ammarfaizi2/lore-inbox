Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUESEwu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUESEwu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 00:52:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263798AbUESEwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 00:52:50 -0400
Received: from ozlabs.org ([203.10.76.45]:9170 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S263795AbUESEwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 00:52:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16554.59404.787245.577454@cargo.ozlabs.ibm.com>
Date: Wed, 19 May 2004 14:52:28 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH][PPC32] Get full register set on bad kernel accesses
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At present on ppc32, if the kernel accesses a bad address and causes
an oops, or drops into the xmon debugger, we only have the contents of
the volatile registers available to print.  The reason is that we only
save the volatile registers on entry for a page fault.

This patch restructures the code a bit so that if do_page_fault()
determines that the page fault is caused by a bad kernel access, it
returns to the caller, which then saves the full register set into the
exception frame before calling bad_page_fault().  This way we get the
full set of registers printed in the oops message.

Please apply.

Thanks,
Paul.

diff -urN linux-2.5/arch/ppc/kernel/entry.S pmac-2.5/arch/ppc/kernel/entry.S
--- linux-2.5/arch/ppc/kernel/entry.S	2004-05-15 13:32:15.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/entry.S	2004-05-15 16:38:23.000000000 +1000
@@ -452,6 +452,29 @@
 	b	sys_swapcontext
 
 /*
+ * Top-level page fault handling.
+ * This is in assembler because if do_page_fault tells us that
+ * it is a bad kernel page fault, we want to save the non-volatile
+ * registers before calling bad_page_fault.
+ */
+	.globl	handle_page_fault
+handle_page_fault:
+	stw	r4,_DAR(r1)
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	do_page_fault
+	cmpwi	r3,0
+	beq+	ret_from_except
+	SAVE_NVGPRS(r1)
+	lwz	r0,TRAP(r1)
+	clrrwi	r0,r0,1
+	stw	r0,TRAP(r1)
+	mr	r5,r3
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	lwz	r4,_DAR(r1)
+	bl	bad_page_fault
+	b	ret_from_except_full
+
+/*
  * This routine switches between two different tasks.  The process
  * state of one is saved on its kernel stack.  Then the state
  * of the other is restored from its kernel stack.  The memory
diff -urN linux-2.5/arch/ppc/kernel/head.S pmac-2.5/arch/ppc/kernel/head.S
--- linux-2.5/arch/ppc/kernel/head.S	2004-05-06 09:37:13.000000000 +1000
+++ pmac-2.5/arch/ppc/kernel/head.S	2004-05-15 16:38:39.000000000 +1000
@@ -412,9 +412,7 @@
 1:	stw	r10,_DSISR(r11)
 	mr	r5,r10
 	mfspr	r4,DAR
-	stw	r4,_DAR(r11)
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE_LITE(0x300, do_page_fault)
+	EXC_XFER_EE_LITE(0x300, handle_page_fault)
 
 #ifdef CONFIG_PPC64BRIDGE
 /* SLB fault on data access. */
@@ -436,10 +434,9 @@
 	li	r3,0			/* into the hash table */
 	mr	r4,r12			/* SRR0 is fault address */
 	bl	hash_page
-1:	addi	r3,r1,STACK_FRAME_OVERHEAD
-	mr	r4,r12
+1:	mr	r4,r12
 	mr	r5,r9
-	EXC_XFER_EE_LITE(0x400, do_page_fault)
+	EXC_XFER_EE_LITE(0x400, handle_page_fault)
 
 #ifdef CONFIG_PPC64BRIDGE
 /* SLB fault on instruction access. */
diff -urN linux-2.5/arch/ppc/mm/fault.c pmac-2.5/arch/ppc/mm/fault.c
--- linux-2.5/arch/ppc/mm/fault.c	2004-05-15 13:32:15.000000000 +1000
+++ pmac-2.5/arch/ppc/mm/fault.c	2004-05-15 16:05:12.000000000 +1000
@@ -92,8 +92,8 @@
  * the error_code parameter is ESR for a data fault, 0 for an instruction
  * fault.
  */
-void do_page_fault(struct pt_regs *regs, unsigned long address,
-		   unsigned long error_code)
+int do_page_fault(struct pt_regs *regs, unsigned long address,
+		  unsigned long error_code)
 {
 	struct vm_area_struct * vma;
 	struct mm_struct *mm = current->mm;
@@ -119,21 +119,20 @@
 #if defined(CONFIG_XMON) || defined(CONFIG_KGDB)
 	if (debugger_fault_handler && TRAP(regs) == 0x300) {
 		debugger_fault_handler(regs);
-		return;
+		return 0;
 	}
 #if !defined(CONFIG_4xx)
 	if (error_code & 0x00400000) {
 		/* DABR match */
 		if (debugger_dabr_match(regs))
-			return;
+			return 0;
 	}
 #endif /* !CONFIG_4xx */
 #endif /* CONFIG_XMON || CONFIG_KGDB */
 
-	if (in_atomic() || mm == NULL) {
-		bad_page_fault(regs, address, SIGSEGV);
-		return;
-	}
+	if (in_atomic() || mm == NULL)
+		return SIGSEGV;
+
 	down_read(&mm->mmap_sem);
 	vma = find_vma(mm, address);
 	if (!vma)
@@ -229,7 +228,7 @@
 			_tlbie(address);
 			pte_unmap(ptep);
 			up_read(&mm->mmap_sem);
-			return;
+			return 0;
 		}
 		if (ptep != NULL)
 			pte_unmap(ptep);
@@ -271,7 +270,7 @@
 	 * -- Cort
 	 */
 	pte_misses++;
-	return;
+	return 0;
 
 bad_area:
 	up_read(&mm->mmap_sem);
@@ -284,11 +283,10 @@
 		info.si_code = code;
 		info.si_addr = (void *) address;
 		force_sig_info(SIGSEGV, &info, current);
-		return;
+		return 0;
 	}
 
-	bad_page_fault(regs, address, SIGSEGV);
-	return;
+	return SIGSEGV;
 
 /*
  * We ran out of memory, or some other thing happened to us that made
@@ -304,8 +302,7 @@
 	printk("VM: killing process %s\n", current->comm);
 	if (user_mode(regs))
 		do_exit(SIGKILL);
-	bad_page_fault(regs, address, SIGKILL);
-	return;
+	return SIGKILL;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
@@ -315,13 +312,14 @@
 	info.si_addr = (void *)address;
 	force_sig_info (SIGBUS, &info, current);
 	if (!user_mode(regs))
-		bad_page_fault(regs, address, SIGBUS);
+		return SIGBUS;
+	return 0;
 }
 
 /*
  * bad_page_fault is called when we have a bad access from the kernel.
- * It is called from do_page_fault above and from some of the procedures
- * in traps.c.
+ * It is called from the DSI and ISI handlers in head.S and from some
+ * of the procedures in traps.c.
  */
 void
 bad_page_fault(struct pt_regs *regs, unsigned long address, int sig)
diff -urN linux-2.5/include/asm-ppc/system.h pmac-2.5/include/asm-ppc/system.h
--- linux-2.5/include/asm-ppc/system.h	2004-05-15 13:32:16.000000000 +1000
+++ pmac-2.5/include/asm-ppc/system.h	2004-05-15 16:19:51.000000000 +1000
@@ -82,7 +82,7 @@
 extern int call_rtas(const char *, int, int, unsigned long *, ...);
 extern int abs(int);
 extern void cacheable_memzero(void *p, unsigned int nb);
-extern void do_page_fault(struct pt_regs *, unsigned long, unsigned long);
+extern int do_page_fault(struct pt_regs *, unsigned long, unsigned long);
 extern void bad_page_fault(struct pt_regs *, unsigned long, int);
 extern void die(const char *, struct pt_regs *, long);
 
