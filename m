Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264503AbUHYJRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264503AbUHYJRz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 05:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbUHYJRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 05:17:44 -0400
Received: from [212.209.10.220] ([212.209.10.220]:35805 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264503AbUHYJNz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 05:13:55 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.6 [PATCH 5/6] CRIS architecture update
Date: Wed, 25 Aug 2004 11:13:51 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C66818F516@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains changes related to core kernel functions.

 * Improved performance in TLB refills.
 * Improved performance for multiple interrupts.

diff -urNP --exclude='*.cvsignore'
../linux/arch/cris/arch-v10/kernel/entry.S
lx25/arch/cris/arch-v10/kernel/entry.S
--- ../linux/arch/cris/arch-v10/kernel/entry.S	Sat Aug 14 07:36:56 2004
+++ lx25/arch/cris/arch-v10/kernel/entry.S	Mon Jun 21 12:29:55 2004
@@ -1,4 +1,4 @@
-/* $Id: entry.S,v 1.18 2004/05/11 12:28:25 starvik Exp $
+/* $Id: entry.S,v 1.22 2004/06/21 10:29:55 starvik Exp $
  *
  *  linux/arch/cris/entry.S
  *
@@ -7,6 +7,20 @@
  *  Authors:	Bjorn Wesen (bjornw@axis.com)
  *
  *  $Log: entry.S,v $
+ *  Revision 1.22  2004/06/21 10:29:55  starvik
+ *  Merge of Linux 2.6.7
+ *
+ *  Revision 1.21  2004/06/09 05:30:27  starvik
+ *  Clean up multiple interrupt handling.
+ *    Prevent interrupts from interrupting each other.
+ *    Handle all active interrupts.
+ *
+ *  Revision 1.20  2004/06/08 08:55:32  starvik
+ *  Removed unused code
+ *
+ *  Revision 1.19  2004/06/04 11:56:15  starvik
+ *  Implemented page table lookup for refills in assembler for improved
performance.
+ *
  *  Revision 1.18  2004/05/11 12:28:25  starvik
  *  Merge of Linux 2.6.6
  *
@@ -238,7 +252,9 @@
 #include <asm/errno.h>
 #include <asm/thread_info.h>
 #include <asm/arch/offset.h>
-		
+#include <asm/page.h>
+#include <asm/pgtable.h>
+			
 	;; functions exported from this file
 	
 	.globl system_call
@@ -539,11 +555,63 @@
 	;; It needs to stack the CPU status and overall is different
 	;; from the other interrupt handlers.
 
-mmu_bus_fault:	
-	sbfs	[$sp=$sp-16]	; push the internal CPU status
+mmu_bus_fault:
+	;; For refills we try to do a quick page table lookup. If it is
+	;; a real fault we let the mm subsystem handle it.
+	
 	;; the first longword in the sbfs frame was the interrupted PC
 	;; which fits nicely with the "IRP" slot in pt_regs normally used to
-	;; contain the return address. used by Oops to print kernel errors..
+	;; contain the return address. used by Oops to print kernel errors.
+	sbfs	[$sp=$sp-16]	; push the internal CPU status
+	push	$dccr
+	di
+	subq	2*4, $sp
+	movem	$r1, [$sp]
+	move.d  [R_MMU_CAUSE], $r1
+	;; ETRAX 100LX TR89 bugfix: if the second half of an unaligned   
+	;; write causes a MMU-fault, it will not be restarted correctly.
+	;; This could happen if a write crosses a page-boundary and the
+	;; second page is not yet COW'ed or even loaded. The workaround
+	;; is to clear the unaligned bit in the CPU status record, so
+	;; that the CPU will rerun both the first and second halves of
+	;; the instruction. This will not have any sideeffects unless
+	;; the first half goes to any device or memory that can't be
+	;; written twice, and which is mapped through the MMU.
+	;; 
+	;; We only need to do this for writes.
+	btstq	8, $r1		   ; Write access?
+	bpl	1f
+	nop
+	move.d	[$sp+16], $r0	   ; Clear unaligned bit in csrinstr 
+	and.d	~(1<<5), $r0
+	move.d	$r0, [$sp+16]
+1:	btstq	12, $r1		   ; Refill?
+	bpl	2f
+	lsrq	PMD_SHIFT, $r1     ; Get PMD index into PGD (bit 24-31)
+	move.d  [current_pgd], $r0 ; PGD for the current process
+	move.d	[$r0+$r1.d], $r0   ; Get PMD
+	beq	2f
+	nop
+	and.w	PAGE_MASK, $r0	   ; Remove PMD flags
+	move.d  [R_MMU_CAUSE], $r1
+	lsrq	PAGE_SHIFT, $r1
+	and.d	0x7ff, $r1         ; Get PTE index into PMD (bit 13-24)
+	move.d	[$r0+$r1.d], $r1   ; Get PTE
+	beq	2f
+	nop
+	;; Store in TLB
+	move.d  $r1, [R_TLB_LO]
+	;; Return
+	movem	[$sp+], $r1
+	pop	$dccr
+	rbf	[$sp+]		; return by popping the CPU status
+	
+2:	; PMD or PTE missing, let the mm subsystem fix it up.
+	movem	[$sp+], $r1
+	pop	$dccr
+
+	; Ok, not that easy, pass it on to the mm subsystem
+	; The MMU status record is now on the stack 
 	push	$srp		; make a stackframe similar to pt_regs
 	push	$dccr
 	push	$mof
@@ -556,7 +624,7 @@
 
 	move.d	$sp, $r10	; pt_regs argument to handle_mmu_bus_fault
 		
-	jsr	handle_mmu_bus_fault  ; in arch/cris/mm/fault.c
+	jsr	handle_mmu_bus_fault  ; in arch/cris/arch-v10/mm/fault.c
 
 	;; now we need to return through the normal path, we cannot just
 	;; do the RBFexit since we might have killed off the running
@@ -566,51 +634,23 @@
 	moveq	0, $r9		; busfault is equivalent to an irq
 		
 	ba	ret_from_intr
-	nop
+	nop	
 		
 	;; special handlers for breakpoint and NMI
-#if 0			
 hwbreakpoint:
 	push	$dccr
-	di
-	push	$r10
-	push	$r11
-	push	$r12
-	push	$r13
-	clearf	b
-	move	$brp,$r11
-	move.d	[hw_bp_msg],$r10
-	jsr	printk
-	setf	b
-	pop	$r13
-	pop	$r12
-	pop	$r11
-	pop	$r10
-	pop	$dccr
-	retb
-	nop
-#else
-hwbreakpoint:
-	push	$dccr
-	di
-#if 1
+	di	
 	push	$r10
 	push	$r11
 	move.d	[hw_bp_trig_ptr],$r10
-	move.d	[$r10],$r11
-	cmp.d	42,$r11
-	beq	1f
-	nop
 	move	$brp,$r11
 	move.d	$r11,[$r10+]
 	move.d	$r10,[hw_bp_trig_ptr]
 1:	pop	$r11
 	pop	$r10
-#endif
 	pop	$dccr
 	retb
 	nop
-#endif
 	
 IRQ1_interrupt:
 
@@ -719,29 +759,23 @@
 	push	$r10		; push orig_r10
 	clear.d [$sp=$sp-4]	; frametype == 0, normal frame
 	
-	move.d	irq_shortcuts + 8, $r1
 	moveq	2, $r2		; first bit we care about is the timer0 irq
 	move.d	[R_VECT_MASK_RD], $r0; read the irq bits that triggered the
multiple irq
+	move.d	$r0, [R_VECT_MASK_CLR] ; Block all active IRQs
 1:	
 	btst	$r2, $r0	; check for the irq given by bit r2
-	bmi	_do_shortcut	; actually do the shortcut
-	nop
+	bpl	2f
+	move.d  $r2, $r10	; First argument to do_IRQ
+	move.d  $sp, $r11	; second argument to do_IRQ
+	jsr	do_IRQ
+2:		
 	addq	1, $r2		; next vector bit
-	addq	4, $r1		; next vector
 	cmp.b	32, $r2
 	bne	1b	; process all irq's up to and including number 31
-	nop
+	moveq	0, $r9  ; make ret_from_intr realise we came from an ir
 	
-	;; strange, we didn't get any set vector bits.. oh well, just return
-	
-	ba	_Rexit
-	nop
-
-_do_shortcut:
-	test.d	[$r1]
-	beq	_Rexit
-	nop
-	jump	[$r1]		; jump to the irq handlers shortcut
+	move.d	$r0, [R_VECT_MASK_SET] ;  Unblock all the IRQs
+	jump    ret_from_intr
 
 do_sigtrap:
 	;; 
@@ -1079,7 +1113,8 @@
 	.long sys_mq_timedreceive	/* 280 */
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
-		
+	.long sys_ni_syscall		/* reserved for kexec */
+			
         /*
          * NOTE!! This doesn't have to be exact - we just have
          * to make sure we have _enough_ of the "sys_ni_syscall"
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/arch-v10/kernel/head.S
lx25/arch/cris/arch-v10/kernel/head.S
--- ../linux/arch/cris/arch-v10/kernel/head.S	Sat Aug 14 07:37:58 2004
+++ lx25/arch/cris/arch-v10/kernel/head.S	Fri May 14 09:58:01 2004
@@ -336,14 +336,14 @@
 #endif
 
 	;; Set up waitstates etc according to kernel configuration.
-#ifndef CONFIG_SVINTO_SIM
+#ifndef CONFIG_SVINTO_SIM	
 	move.d   CONFIG_ETRAX_DEF_R_WAITSTATES, $r0
 	move.d   $r0, [R_WAITSTATES]
 
 	move.d   CONFIG_ETRAX_DEF_R_BUS_CONFIG, $r0
 	move.d   $r0, [R_BUS_CONFIG]
 #endif
-
+	
 	;; We need to initialze DRAM registers before we start using the
DRAM
 
 	cmp.d	RAM_INIT_MAGIC, $r8	; Already initialized?
@@ -652,7 +652,7 @@
 #if defined(CONFIG_ETRAX_DEF_R_PORT_G24_DIR_OUT)
        or.d      IO_STATE (R_GEN_CONFIG, g24dir, out),$r0
 #endif
-
+	
 	move.d	$r0,[genconfig_shadow] ; init a shadow register of
R_GEN_CONFIG
 
 #ifndef CONFIG_SVINTO_SIM
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/arch-v10/kernel/irq.c
lx25/arch/cris/arch-v10/kernel/irq.c
--- ../linux/arch/cris/arch-v10/kernel/irq.c	Sat Aug 14 07:36:58 2004
+++ lx25/arch/cris/arch-v10/kernel/irq.c	Wed Jun  9 07:30:27 2004
@@ -1,4 +1,4 @@
-/* $Id: irq.c,v 1.1 2002/12/11 15:42:02 starvik Exp $
+/* $Id: irq.c,v 1.2 2004/06/09 05:30:27 starvik Exp $
  *
  *	linux/arch/cris/kernel/irq.c
  *
@@ -23,12 +23,8 @@
  */
 
 void
-set_int_vector(int n, irqvectptr addr, irqvectptr saddr)
+set_int_vector(int n, irqvectptr addr)
 {
-	/* remember the shortcut entry point, after the prologue */
-
-	irq_shortcuts[n] = saddr;
-
 	etrax_irv->v[n + 0x20] = (irqvectptr)addr;
 }
 
@@ -106,17 +102,6 @@
 	IRQ31_interrupt
 };
 
-static void (*sinterrupt[NR_IRQS])(void) = {
-	NULL, NULL, sIRQ2_interrupt, sIRQ3_interrupt,
-	sIRQ4_interrupt, sIRQ5_interrupt, sIRQ6_interrupt, sIRQ7_interrupt,
-	sIRQ8_interrupt, sIRQ9_interrupt, sIRQ10_interrupt,
sIRQ11_interrupt,
-	sIRQ12_interrupt, sIRQ13_interrupt, NULL, NULL,	
-	sIRQ16_interrupt, sIRQ17_interrupt, sIRQ18_interrupt,
sIRQ19_interrupt,	
-	sIRQ20_interrupt, sIRQ21_interrupt, sIRQ22_interrupt,
sIRQ23_interrupt,	
-	sIRQ24_interrupt, sIRQ25_interrupt, NULL, NULL, NULL, NULL, NULL,
-	sIRQ31_interrupt
-};
-
 static void (*bad_interrupt[NR_IRQS])(void) = {
         NULL, NULL,
 	NULL, bad_IRQ3_interrupt,
@@ -137,12 +122,12 @@
 
 void arch_setup_irq(int irq)
 {
-  set_int_vector(irq, interrupt[irq], sinterrupt[irq]);
+  set_int_vector(irq, interrupt[irq]);
 }
 
 void arch_free_irq(int irq)
 {
-  set_int_vector(irq, bad_interrupt[irq], 0);
+  set_int_vector(irq, bad_interrupt[irq]);
 }
 
 void weird_irq(void);
@@ -187,20 +172,20 @@
         
 	/* set all etrax irq's to the bad handlers */
 	for (i = 2; i < NR_IRQS; i++)
-		set_int_vector(i, bad_interrupt[i], 0);
+		set_int_vector(i, bad_interrupt[i]);
         
 	/* except IRQ 15 which is the multiple-IRQ handler on Etrax100 */
 
-	set_int_vector(15, multiple_interrupt, 0);
+	set_int_vector(15, multiple_interrupt);
 	
 	/* 0 and 1 which are special breakpoint/NMI traps */
 
-	set_int_vector(0, hwbreakpoint, 0);
-	set_int_vector(1, IRQ1_interrupt, 0);
+	set_int_vector(0, hwbreakpoint);
+	set_int_vector(1, IRQ1_interrupt);
 
 	/* and irq 14 which is the mmu bus fault handler */
 
-	set_int_vector(14, mmu_bus_fault, 0);
+	set_int_vector(14, mmu_bus_fault);
 
 	/* setup the system-call trap, which is reached by BREAK 13 */
 
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/arch-v10/mm/fault.c
lx25/arch/cris/arch-v10/mm/fault.c
--- ../linux/arch/cris/arch-v10/mm/fault.c	Sat Aug 14 07:38:04 2004
+++ lx25/arch/cris/arch-v10/mm/fault.c	Mon Jun 21 12:29:56 2004
@@ -40,23 +40,23 @@
 handle_mmu_bus_fault(struct pt_regs *regs)
 {
 	int cause;
-#ifdef DEBUG
 	int select;
+#ifdef DEBUG
 	int index;
 	int page_id;
 	int acc, inv;
 #endif
-	int miss, we, writeac;
-	pmd_t *pmd;
+        pmd_t *pmd;
 	pte_t pte;
+	int miss, we, writeac;
 	unsigned long address;
 
 	cause = *R_MMU_CAUSE;
 
 	address = cause & PAGE_MASK; /* get faulting address */
+	select = *R_TLB_SELECT;
 
 #ifdef DEBUG
-	select = *R_TLB_SELECT;
 	page_id = IO_EXTRACT(R_MMU_CAUSE,  page_id,   cause);
 	acc     = IO_EXTRACT(R_MMU_CAUSE,  acc_excp,  cause);
 	inv     = IO_EXTRACT(R_MMU_CAUSE,  inv_excp,  cause);  
@@ -66,85 +66,28 @@
 	we      = IO_EXTRACT(R_MMU_CAUSE,  we_excp,   cause);
 	writeac = IO_EXTRACT(R_MMU_CAUSE,  wr_rd,     cause);
 
-	/* ETRAX 100LX TR89 bugfix: if the second half of an unaligned
-	 * write causes a MMU-fault, it will not be restarted correctly.
-	 * This could happen if a write crosses a page-boundary and the
-	 * second page is not yet COW'ed or even loaded. The workaround
-	 * is to clear the unaligned bit in the CPU status record, so 
-	 * that the CPU will rerun both the first and second halves of
-	 * the instruction. This will not have any sideeffects unless
-	 * the first half goes to any device or memory that can't be
-	 * written twice, and which is mapped through the MMU.
-	 *
-	 * We only need to do this for writes.
-	 */
-
-	if(writeac)
-		regs->csrinstr &= ~(1 << 5);
-	
 	D(printk("bus_fault from IRP 0x%lx: addr 0x%lx, miss %d, inv %d, we
%d, acc %d, dx %d pid %d\n",
 		 regs->irp, address, miss, inv, we, acc, index, page_id));
 
-	/* for a miss, we need to reload the TLB entry */
-
-	if (miss) {
-		/* see if the pte exists at all
-		 * refer through current_pgd, dont use mm->pgd
-		 */
-
-		pmd = (pmd_t *)(current_pgd + pgd_index(address));
-		if (pmd_none(*pmd)) {
-			do_page_fault(address, regs, 0, writeac);
-			return;
-		}
-		if (pmd_bad(*pmd)) {
-			printk("bad pgdir entry 0x%lx at 0x%p\n", *(unsigned
long*)pmd, pmd);
-			pmd_clear(pmd);
-			return;
-		}
-		pte = *pte_offset_kernel(pmd, address);
-		if (!pte_present(pte)) {
-			do_page_fault(address, regs, 0, writeac);
-			return;
-		}
-
-#ifdef DEBUG
-		printk(" found pte %lx pg %p ", pte_val(pte),
pte_page(pte));
-		if (pte_val(pte) & _PAGE_SILENT_WRITE)
-			printk("Silent-W ");
-		if (pte_val(pte) & _PAGE_KERNEL)
-			printk("Kernel ");
-		if (pte_val(pte) & _PAGE_SILENT_READ)
-			printk("Silent-R ");
-		if (pte_val(pte) & _PAGE_GLOBAL)
-			printk("Global ");
-		if (pte_val(pte) & _PAGE_PRESENT)
-			printk("Present ");
-		if (pte_val(pte) & _PAGE_ACCESSED)
-			printk("Accessed ");
-		if (pte_val(pte) & _PAGE_MODIFIED)
-			printk("Modified ");
-		if (pte_val(pte) & _PAGE_READ)
-			printk("Readable ");
-		if (pte_val(pte) & _PAGE_WRITE)
-			printk("Writeable ");
-		printk("\n");
-#endif
-
-		/* load up the chosen TLB entry
-		 * this assumes the pte format is the same as the TLB_LO
layout.
-		 *
-		 * the write to R_TLB_LO also writes the vpn and page_id
fields from
-		 * R_MMU_CAUSE, which we in this case obviously want to keep
-		 */
-
-		*R_TLB_LO = pte_val(pte);
-
-		return;
-	}
-
 	/* leave it to the MM system fault handler */
-	do_page_fault(address, regs, 1, we);
+	if (miss) 
+		do_page_fault(address, regs, 0, writeac);
+        else	
+		do_page_fault(address, regs, 1, we);
+
+        /* Reload TLB with new entry to avoid an extra miss exception. 
+	 * do_page_fault may have flushed the TLB so we have to restore
+	 * the MMU registers.
+	 */
+	pmd = (pmd_t *)(current_pgd + pgd_index(address));
+	if (pmd_none(*pmd))
+		return;
+	pte = *pte_offset_kernel(pmd, address);          
+	if (!pte_present(pte))
+		return;
+	*R_TLB_SELECT = select;
+	*R_TLB_HI = cause;
+	*R_TLB_LO = pte_val(pte);
 }
 
 /* Called from arch/cris/mm/fault.c to find fixup code. */
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/arch-v10/mm/tlb.c
lx25/arch/cris/arch-v10/mm/tlb.c
--- ../linux/arch/cris/arch-v10/mm/tlb.c	Sat Aug 14 07:38:09 2004
+++ lx25/arch/cris/arch-v10/mm/tlb.c	Thu Jun 24 12:38:41 2004
@@ -65,7 +65,7 @@
 flush_tlb_mm(struct mm_struct *mm)
 {
 	int i;
-	int page_id = mm->context;
+	int page_id = mm->context.page_id;
 	unsigned long flags;
 
 	D(printk("tlb: flush mm context %d (%p)\n", page_id, mm));
@@ -103,7 +103,7 @@
 	       unsigned long addr)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	int page_id = mm->context;
+	int page_id = mm->context.page_id;
 	int i;
 	unsigned long flags;
 
@@ -147,7 +147,7 @@
 		unsigned long end)
 {
 	struct mm_struct *mm = vma->vm_mm;
-	int page_id = mm->context;
+	int page_id = mm->context.page_id;
 	int i;
 	unsigned long flags;
 
@@ -208,6 +208,18 @@
 }
 #endif
 
+/*
+ * Initialize the context related info for a new mm_struct
+ * instance.
+ */
+
+int
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)
+{
+	mm->context.page_id = NO_CONTEXT;
+	return 0;
+}
+
 /* called in schedule() just before actually doing the switch_to */
 
 void 
@@ -231,6 +243,6 @@
 	
 	D(printk("switching mmu_context to %d (%p)\n", next->context,
next));
 
-	*R_MMU_CONTEXT = IO_FIELD(R_MMU_CONTEXT, page_id, next->context);
+	*R_MMU_CONTEXT = IO_FIELD(R_MMU_CONTEXT, page_id,
next->context.page_id);
 }
 

