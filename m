Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUHWPRD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUHWPRD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 11:17:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264960AbUHWPRC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 11:17:02 -0400
Received: from [212.209.10.220] ([212.209.10.220]:52388 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S264991AbUHWPCL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 11:02:11 -0400
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/6] CRIS architecture update
Date: Mon, 23 Aug 2004 17:02:08 +0200
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668640E20@exmail1.se.axis.com>
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

This patch contains changes in core kernel functions.

  * Performance improvement for refill MMU exceptions.
  * Performance improvement for multiple interrupts.

diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/kernel/entry.S
linux/arch/cris/kernel/entry.S
--- ../linux/arch/cris/kernel/entry.S	Mon Aug 25 13:44:39 2003
+++ linux/arch/cris/kernel/entry.S	Wed Jun  9 07:04:57 2004
@@ -1,4 +1,4 @@
-/* $Id: entry.S,v 1.42 2003/07/07 09:00:50 johana Exp $
+/* $Id: entry.S,v 1.46 2004/06/09 05:04:57 starvik Exp $
  *
  *  linux/arch/cris/entry.S
  *
@@ -7,6 +7,20 @@
  *  Authors:	Bjorn Wesen (bjornw@axis.com)
  *
  *  $Log: entry.S,v $
+ *  Revision 1.46  2004/06/09 05:04:57  starvik
+ *  Clean up multiple interrupt handling.
+ *    Prevents interrupts from interrupting each other.
+ *    Handles all active interrupts.
+ *
+ *  Revision 1.45  2004/06/08 09:02:15  starvik
+ *  Oops. The multiple IRQs changes are not mature yet
+ *
+ *  Revision 1.44  2004/06/08 08:55:14  starvik
+ *  Removed unused code
+ *
+ *  Revision 1.43  2004/06/04 11:36:38  starvik
+ *  Implemented page table lookup for refills in assembler for improved
performance.
+ *
  *  Revision 1.42  2003/07/07 09:00:50  johana
  *  Added CONFIG_ETRAX_DEBUG_INTERRUPT support.
  *
@@ -199,7 +213,9 @@
 #include <asm/unistd.h>
 #include <asm/sv_addr_ag.h>
 #include <asm/errno.h>
-	
+#include <asm/page.h>
+#include <asm/pgtable.h>
+		
 	;; functions exported from this file
 	
 	.globl system_call
@@ -210,7 +226,6 @@
 	.globl hwbreakpoint
 	.globl IRQ1_interrupt
 	.globl timer_interrupt
-	.globl timer_shortcut
 	.globl spurious_interrupt
 	.globl hw_bp_trigs
 	.globl mmu_bus_fault
@@ -502,11 +517,63 @@
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
@@ -532,48 +599,20 @@
 	nop
 		
 	;; special handlers for breakpoint and NMI
-#if 0			
 hwbreakpoint:
 	push	$dccr
 	di
 	push	$r10
 	push	$r11
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
-	push	$r10
-	push	$r11
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
 
@@ -680,29 +719,23 @@
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
-	
-	;; strange, we didn't get any set vector bits.. oh well, just return
+	moveq	0, $r9  ; make ret_from_intr realise we came from an irq
 	
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
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/kernel/head.S
linux/arch/cris/kernel/head.S
--- ../linux/arch/cris/kernel/head.S	Mon Aug 25 13:44:39 2003
+++ linux/arch/cris/kernel/head.S	Mon Mar 29 09:31:02 2004
@@ -1,4 +1,4 @@
-/* $Id: head.S,v 1.47 2003/07/08 09:53:35 starvik Exp $
+/* $Id: head.S,v 1.49 2004/03/29 07:31:02 starvik Exp $
  * 
  * Head of the kernel - alter with care
  *
@@ -7,6 +7,13 @@
  * Authors:	Bjorn Wesen (bjornw@axis.com)
  * 
  * $Log: head.S,v $
+ * Revision 1.49  2004/03/29 07:31:02  starvik
+ * Always setup waitstates and busconfig
+ *
+ * Revision 1.48  2004/02/24 09:18:14  anderstj
+ * Removed Bluetooth G-port settings, replaced with more general
configuration
+ * of G port direction.
+ *
  * Revision 1.47  2003/07/08 09:53:35  starvik
  * Corrected last CVS log entry
  *
@@ -327,6 +334,15 @@
 	move.d START_ETHERNET_CLOCK, $r0
 	move.d $r0, [R_NETWORK_GEN_CONFIG]
 #endif
+
+	;; Set up waitstates etc according to kernel configuration.
+#ifndef CONFIG_SVINTO_SIM	
+	move.d   CONFIG_ETRAX_DEF_R_WAITSTATES, $r0
+	move.d   $r0, [R_WAITSTATES]
+
+	move.d   CONFIG_ETRAX_DEF_R_BUS_CONFIG, $r0
+	move.d   $r0, [R_BUS_CONFIG]
+#endif
 		
 	;; We need to initialze DRAM registers before we start using the
DRAM
 
@@ -640,10 +656,23 @@
 		| IO_STATE (R_GEN_CONFIG, dma4, extdma0),$r0
 #endif
 
-#if defined(CONFIG_BLUETOOTH) && (defined(CONFIG_BLUETOOTH_RESET_G10) ||
defined(CONFIG_BLUETOOTH_RESET_G11))
-	or.d	  IO_STATE (R_GEN_CONFIG, g8_15dir, out),$r0
+#if defined(CONFIG_ETRAX_DEF_R_PORT_G0_DIR_OUT)
+        or.d      IO_STATE (R_GEN_CONFIG, g0dir, out),$r0
+#endif
+
+#if defined(CONFIG_ETRAX_DEF_R_PORT_G8_15_DIR_OUT)
+        or.d      IO_STATE (R_GEN_CONFIG, g8_15dir, out),$r0
+#endif
+
+#if defined(CONFIG_ETRAX_DEF_R_PORT_G16_23_DIR_OUT)
+	or.d      IO_STATE (R_GEN_CONFIG, g16_23dir, out),$r0
 #endif
 
+#if defined(CONFIG_ETRAX_DEF_R_PORT_G24_DIR_OUT)
+	or.d      IO_STATE (R_GEN_CONFIG, g24dir, out),$r0
+#endif
+
+
 	move.d	$r0,[genconfig_shadow] ; init a shadow register of
R_GEN_CONFIG
 
 #ifndef CONFIG_SVINTO_SIM
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/kernel/irq.c
linux/arch/cris/kernel/irq.c
--- ../linux/arch/cris/kernel/irq.c	Mon Aug 25 13:44:39 2003
+++ linux/arch/cris/kernel/irq.c	Wed Jun  9 07:05:33 2004
@@ -88,20 +88,13 @@
 	return 0;
 }
 
-/* vector of shortcut jumps after the irq prologue */
-irqvectptr irq_shortcuts[NR_IRQS];
-
 /* don't use set_int_vector, it bypasses the linux interrupt handlers. it
is
  * global just so that the kernel gdb can use it.
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
 
@@ -180,17 +173,6 @@
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
@@ -326,7 +308,7 @@
 		/* if the irq wasn't registred before, enter it into the
vector
 		 * table and unmask it physically
 		 */
-		set_int_vector(irq, interrupt[irq], sinterrupt[irq]);
+		set_int_vector(irq, interrupt[irq]);
 		unmask_irq(irq);
 	}
 
@@ -402,7 +384,7 @@
 		*p = action->next;
 		if (!irq_action[irq]) {
 			mask_irq(irq);
-			set_int_vector(irq, bad_interrupt[irq], 0);
+			set_int_vector(irq, bad_interrupt[irq]);
 		}
 		restore_flags(flags);
 		kfree(action);
@@ -441,11 +423,6 @@
 
 	*R_VECT_MASK_CLR = 0xffffffff;
 
-	/* clear the shortcut entry points */
-
-	for(i = 0; i < NR_IRQS; i++)
-		irq_shortcuts[i] = NULL;
-
 	for (i = 0; i < 256; i++)
 		etrax_irv->v[i] = weird_irq;
 
@@ -460,20 +437,20 @@
 
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
 
diff -urNP --exclude='*.cvsignore' ../linux/arch/cris/mm/fault.c
linux/arch/cris/mm/fault.c
--- ../linux/arch/cris/mm/fault.c	Wed Feb 18 14:36:30 2004
+++ linux/arch/cris/mm/fault.c	Wed Jun  9 07:20:37 2004
@@ -6,6 +6,12 @@
  *  Authors:  Bjorn Wesen 
  * 
  *  $Log: fault.c,v $
+ *  Revision 1.25  2004/06/09 05:20:37  starvik
+ *  Update TLB after do_page_fault to avoid unnecessary page faults.
+ *
+ *  Revision 1.24  2004/06/04 11:35:20  starvik
+ *  Moved handling of refills to entry.S for improved performance
+ *
  *  Revision 1.23  2003/10/16 05:32:32  starvik
  *  Only read TLB_SELECT if DEBUG
  *
@@ -123,16 +129,15 @@
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
 	pmd_t *pmd;
 	pte_t pte;
-	int errcode;
+	int miss, we, writeac;
 	unsigned long address;
 
 #ifdef CONFIG_ETRAX_DEBUG_INTERRUPT /* The di is actually in entry.S */
@@ -141,9 +146,9 @@
 	cause = *R_MMU_CAUSE;
 
 	address = cause & PAGE_MASK; /* get faulting address */
+	select = *R_TLB_SELECT;
 
 #ifdef DEBUG
-	select = *R_TLB_SELECT;
 	page_id = IO_EXTRACT(R_MMU_CAUSE,  page_id,   cause);
 	acc     = IO_EXTRACT(R_MMU_CAUSE,  acc_excp,  cause);
 	inv     = IO_EXTRACT(R_MMU_CAUSE,  inv_excp,  cause);  
@@ -153,91 +158,27 @@
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
-	/* Set errcode's R/W flag according to the mode which caused the
-	 * fault
-	 */
-
-	errcode = writeac << 1;
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
-		if (pmd_none(*pmd))
-			goto dofault;
-		if (pmd_bad(*pmd)) {
-			printk("bad pgdir entry 0x%lx at 0x%p\n", *(unsigned
long*)pmd, pmd);
-			pmd_clear(pmd);
-			return;
-		}
-		pte = *pte_offset(pmd, address);
-		if (!pte_present(pte))
-			goto dofault;
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
+	if(miss)	
+		do_page_fault(address, regs, writeac << 1);
+        else
+		do_page_fault(address, regs, 1 | (we << 1));
+
+	/* Reload TLB with new entry to avoid an extra miss exception. 
+	 * do_page_fault may have flushed the TLB so we have to restore
+	 * the MMU registers.
+	 */
+	pmd = (pmd_t *)(current_pgd + pgd_index(address));
+	if (pmd_none(*pmd))
 		return;
-	} 
-
-	errcode = 1 | (we << 1);
-
- dofault:
-	/* leave it to the MM system fault handler below */
-	D(printk("do_page_fault %lx errcode %d\n", address, errcode));
-	do_page_fault(address, regs, errcode);
+	pte = *pte_offset(pmd, address);          
+	if (!pte_present(pte))
+		return;
+	*R_TLB_SELECT = select;
+	*R_TLB_HI = cause;
+	*R_TLB_LO = pte_val(pte);
 }
 
 /*
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/irq.h
linux/include/asm-cris/irq.h
--- ../linux/include/asm-cris/irq.h	Mon Aug 25 13:44:43 2003
+++ linux/include/asm-cris/irq.h	Wed Jun  9 07:08:26 2004
@@ -89,7 +89,7 @@
 };
 
 extern struct etrax_interrupt_vector *etrax_irv;
-void set_int_vector(int n, irqvectptr addr, irqvectptr saddr);
+void set_int_vector(int n, irqvectptr addr);
 void set_break_vector(int n, irqvectptr addr);
 
 #define __STR(x) #x
@@ -139,7 +139,6 @@
           ".text\n\t" \
           "IRQ" #nr "_interrupt:\n\t" \
 	  SAVE_ALL \
-	  "sIRQ" #nr "_interrupt:\n\t" /* shortcut for the multiple irq
handler */ \
 	  BLOCK_IRQ(mask,nr) /* this must be done to prevent irq loops when
we ei later */ \
 	  "moveq "#nr",$r10\n\t" \
 	  "move.d $sp,$r11\n\t" \
@@ -178,7 +177,6 @@
           ".text\n\t" \
           "IRQ" #nr "_interrupt:\n\t" \
 	  SAVE_ALL \
-	  "sIRQ" #nr "_interrupt:\n\t" /* shortcut for the multiple irq
handler */ \
 	  "moveq "#nr",$r10\n\t" \
 	  "move.d $sp,$r11\n\t" \
 	  "jsr do_IRQ\n\t" /* irq.c, r10 and r11 are arguments */ \
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/page.h
linux/include/asm-cris/page.h
--- ../linux/include/asm-cris/page.h	Wed Feb 18 14:36:32 2004
+++ linux/include/asm-cris/page.h	Tue Jun  8 14:53:24 2004
@@ -1,12 +1,18 @@
 #ifndef _CRIS_PAGE_H
 #define _CRIS_PAGE_H
 
+#ifndef __ASSEMBLY__
 #include <linux/config.h>
 #include <asm/mmu.h>
+#endif
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	13
+#ifndef __ASSEMBLY__
 #define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#else
+#define PAGE_SIZE	(1 << PAGE_SHIFT)
+#endif
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
 #ifdef __KERNEL__
@@ -23,10 +29,12 @@
 /*
  * These are used to make use of C type-checking..
  */
+#ifndef __ASSEMBLY__
 typedef struct { unsigned long pte; } pte_t;
 typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 typedef struct { unsigned long pgprot; } pgprot_t;
+#endif
 
 #define pte_val(x)	((x).pte)
 #define pmd_val(x)	((x).pmd)
@@ -124,7 +132,9 @@
 
 /* from linker script */
 
+#ifndef __ASSEMBLY__
 extern unsigned long dram_start, dram_end;
+#endif
 
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/pgtable.h
linux/include/asm-cris/pgtable.h
--- ../linux/include/asm-cris/pgtable.h	Fri Jun 13 16:51:38 2003
+++ linux/include/asm-cris/pgtable.h	Tue Jun  8 14:53:24 2004
@@ -3,6 +3,9 @@
  * HISTORY:
  *
  * $Log: pgtable.h,v $
+ * Revision 1.18  2004/06/08 12:53:24  starvik
+ * Make page.h and pgtable.h includable from assembler
+ *
  * Revision 1.17  2002/12/02 08:14:08  starvik
  * Merge of Linux 2.4.20
  *
@@ -106,8 +109,10 @@
 #ifndef _CRIS_PGTABLE_H
 #define _CRIS_PGTABLE_H
 
+#ifndef __ASSEMBLY__
 #include <linux/config.h>
 #include <asm/mmu.h>
+#endif
 
 /*
  * The Linux memory management assumes a three-level page table setup. On
@@ -120,8 +125,9 @@
  * This file contains the functions and defines necessary to modify and use
  * the CRIS page table tree.
  */
-
+#ifndef __ASSEMBLY__
 extern void paging_init(void);
+#endif
 
 /* The cache doesn't need to be flushed when TLB entries change because 
  * the cache is mapped to physical memory, not virtual memory
@@ -147,6 +153,7 @@
  *
  */
 
+#ifndef __ASSEMBLY__
 extern void flush_tlb_all(void);
 extern void flush_tlb_mm(struct mm_struct *mm);
 extern void flush_tlb_page(struct vm_area_struct *vma, 
@@ -166,6 +173,7 @@
 {
 	flush_tlb_mm(current->mm);
 }
+#endif
 
 /* Certain architectures need to do special things when pte's
  * within a page table are directly modified.  Thus, the following
@@ -274,8 +282,10 @@
 #define __S111	PAGE_SHARED
 
 /* zero page used for uninitialized stuff */
+#ifndef __ASSEMBLY__
 extern unsigned long empty_zero_page;
 #define ZERO_PAGE(vaddr) (virt_to_page(empty_zero_page))
+#endif
 
 /* number of bits that fit into a memory pointer */
 #define BITS_PER_PTR			(8*sizeof(unsigned long))
@@ -306,6 +316,7 @@
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { pmd_val(*(xp)) = 0; } while (0)
 
+#ifndef __ASSEMBLY__
 /*
  * The "pgd_xxx()" functions here are trivial for a folded two-level
  * setup: the pgd is never bad, and a pmd always exists (as it's folded
@@ -528,4 +539,5 @@
  */
 #define pgtable_cache_init()   do { } while (0)
 
+#endif /* __ASSEMBLY__ */
 #endif /* _CRIS_PGTABLE_H */
diff -urNP --exclude='*.cvsignore'
../linux/include/asm-cris/semaphore-helper.h
linux/include/asm-cris/semaphore-helper.h
--- ../linux/include/asm-cris/semaphore-helper.h	Mon Aug 25 13:44:43
2003
+++ linux/include/asm-cris/semaphore-helper.h	Fri Apr  2 07:59:48 2004
@@ -48,7 +48,7 @@
 		dec(&sem->waking);
 		ret = 1;
 	} else if (signal_pending(tsk)) {
-		count_inc(&sem->count);
+		inc(&sem->count);
 		ret = -EINTR;
 	}
 	restore_flags(flags);
@@ -62,7 +62,7 @@
 
 	save_and_cli(flags);
 	if (read(&sem->waking) <= 0)
-		count_inc(&sem->count);
+		inc(&sem->count);
 	else {
 		dec(&sem->waking);
 		ret = 0;
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/semaphore.h
linux/include/asm-cris/semaphore.h
--- ../linux/include/asm-cris/semaphore.h	Mon Aug 25 13:44:43 2003
+++ linux/include/asm-cris/semaphore.h	Fri Apr  2 07:59:48 2004
@@ -19,7 +19,7 @@
 int printk(const char *fmt, ...);
 
 struct semaphore {
-	int count; /* not atomic_t since we do the atomicity here already */
+	atomic_t count; 
 	atomic_t waking;
 	wait_queue_head_t wait;
 #if WAITQUEUE_DEBUG
@@ -34,7 +34,7 @@
 #endif
 
 #define __SEMAPHORE_INITIALIZER(name,count)             \
-        { count, ATOMIC_INIT(0),          \
+        { ATOMIC_INIT(count), ATOMIC_INIT(0),           \
           __WAIT_QUEUE_HEAD_INITIALIZER((name).wait)    \
           __SEM_DEBUG_INIT(name) }
 
@@ -81,7 +81,7 @@
 	/* atomically decrement the semaphores count, and if its negative,
we wait */
 	save_flags(flags);
 	cli();
-	failed = --(sem->count) < 0;
+	failed = --(sem->count.counter) < 0;
 	restore_flags(flags);
 	if(failed) {
 		__down(sem);
@@ -106,7 +106,7 @@
 	/* atomically decrement the semaphores count, and if its negative,
we wait */
 	save_flags(flags);
 	cli();
-	failed = --(sem->count) < 0;
+	failed = --(sem->count.counter) < 0;
 	restore_flags(flags);
 	if(failed)
 		failed = __down_interruptible(sem);
@@ -124,7 +124,7 @@
 
 	save_flags(flags);
 	cli();
-	failed = --(sem->count) < 0;
+	failed = --(sem->count.counter) < 0;
 	restore_flags(flags);
 	if(failed)
 		failed = __down_trylock(sem);
@@ -149,7 +149,7 @@
 	/* atomically increment the semaphores count, and if it was
negative, we wake people */
 	save_flags(flags);
 	cli();
-	wakeup = ++(sem->count) <= 0;
+	wakeup = ++(sem->count.counter) <= 0;
 	restore_flags(flags);
 	if(wakeup) {
 		__up(sem);
@@ -158,7 +158,7 @@
 
 static inline int sem_getcount(struct semaphore *sem)
 {
-	return sem->count;
+	return sem->count.counter;
 }
 
 #endif
diff -urNP --exclude='*.cvsignore' ../linux/include/asm-cris/types.h
linux/include/asm-cris/types.h
--- ../linux/include/asm-cris/types.h	Fri Feb  9 01:32:44 2001
+++ linux/include/asm-cris/types.h	Thu Apr  1 11:05:38 2004
@@ -44,6 +44,7 @@
 /* Dma addresses are 32-bits wide, just like our other addresses.  */
  
 typedef u32 dma_addr_t;
+typedef u32 dma64_addr_t;
 
 #endif /* __KERNEL__ */
 

