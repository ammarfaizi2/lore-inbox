Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbUKBNsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUKBNsS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 08:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbUKBNsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 08:48:17 -0500
Received: from [212.209.10.221] ([212.209.10.221]:41940 "EHLO
	krynn.se.axis.com") by vger.kernel.org with ESMTP id S262937AbUKBNFG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 08:05:06 -0500
From: "Mikael Starvik" <mikael.starvik@axis.com>
To: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>
Subject: [PATCH 6/10] CRIS architecture update - Core kernel
Date: Tue, 2 Nov 2004 14:04:45 +0100
Message-ID: <BFECAF9E178F144FAEF2BF4CE739C668014C748A@exmail1.se.axis.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_01DA_01C4C0E4.E88FEF40"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.6626
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_01DA_01C4C0E4.E88FEF40
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Updates for core kernel functionality.
  * Optimized MMU refill handling.
  * Improved multiple IRQ handling.
  * Added profiler.
  * Updated for 2.6.9.

Signed-Off-By: starvik@axis.com

/Mikael

------=_NextPart_000_01DA_01C4C0E4.E88FEF40
Content-Type: application/octet-stream;
	name="cris269_6.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="cris269_6.patch"

diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/entry.S =
lx25/arch/cris/arch-v10/kernel/entry.S=0A=
--- ../linux/arch/cris/arch-v10/kernel/entry.S	Mon Oct 18 23:53:51 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/entry.S	Tue Oct 19 15:07:37 2004=0A=
@@ -1,4 +1,4 @@=0A=
-/* $Id: entry.S,v 1.18 2004/05/11 12:28:25 starvik Exp $=0A=
+/* $Id: entry.S,v 1.23 2004/10/19 13:07:37 starvik Exp $=0A=
  *=0A=
  *  linux/arch/cris/entry.S=0A=
  *=0A=
@@ -7,6 +7,23 @@=0A=
  *  Authors:	Bjorn Wesen (bjornw@axis.com)=0A=
  *=0A=
  *  $Log: entry.S,v $=0A=
+ *  Revision 1.23  2004/10/19 13:07:37  starvik=0A=
+ *  Merge of Linux 2.6.9=0A=
+ *=0A=
+ *  Revision 1.22  2004/06/21 10:29:55  starvik=0A=
+ *  Merge of Linux 2.6.7=0A=
+ *=0A=
+ *  Revision 1.21  2004/06/09 05:30:27  starvik=0A=
+ *  Clean up multiple interrupt handling.=0A=
+ *    Prevent interrupts from interrupting each other.=0A=
+ *    Handle all active interrupts.=0A=
+ *=0A=
+ *  Revision 1.20  2004/06/08 08:55:32  starvik=0A=
+ *  Removed unused code=0A=
+ *=0A=
+ *  Revision 1.19  2004/06/04 11:56:15  starvik=0A=
+ *  Implemented page table lookup for refills in assembler for improved =
performance.=0A=
+ *=0A=
  *  Revision 1.18  2004/05/11 12:28:25  starvik=0A=
  *  Merge of Linux 2.6.6=0A=
  *=0A=
@@ -238,7 +255,9 @@=0A=
 #include <asm/errno.h>=0A=
 #include <asm/thread_info.h>=0A=
 #include <asm/arch/offset.h>=0A=
-		=0A=
+#include <asm/page.h>=0A=
+#include <asm/pgtable.h>=0A=
+			=0A=
 	;; functions exported from this file=0A=
 	=0A=
 	.globl system_call=0A=
@@ -539,11 +558,63 @@=0A=
 	;; It needs to stack the CPU status and overall is different=0A=
 	;; from the other interrupt handlers.=0A=
 =0A=
-mmu_bus_fault:	=0A=
-	sbfs	[$sp=3D$sp-16]	; push the internal CPU status=0A=
+mmu_bus_fault:=0A=
+	;; For refills we try to do a quick page table lookup. If it is=0A=
+	;; a real fault we let the mm subsystem handle it.=0A=
+	=0A=
 	;; the first longword in the sbfs frame was the interrupted PC=0A=
 	;; which fits nicely with the "IRP" slot in pt_regs normally used to=0A=
-	;; contain the return address. used by Oops to print kernel errors..=0A=
+	;; contain the return address. used by Oops to print kernel errors.=0A=
+	sbfs	[$sp=3D$sp-16]	; push the internal CPU status=0A=
+	push	$dccr=0A=
+	di=0A=
+	subq	2*4, $sp=0A=
+	movem	$r1, [$sp]=0A=
+	move.d  [R_MMU_CAUSE], $r1=0A=
+	;; ETRAX 100LX TR89 bugfix: if the second half of an unaligned   =0A=
+	;; write causes a MMU-fault, it will not be restarted correctly.=0A=
+	;; This could happen if a write crosses a page-boundary and the=0A=
+	;; second page is not yet COW'ed or even loaded. The workaround=0A=
+	;; is to clear the unaligned bit in the CPU status record, so=0A=
+	;; that the CPU will rerun both the first and second halves of=0A=
+	;; the instruction. This will not have any sideeffects unless=0A=
+	;; the first half goes to any device or memory that can't be=0A=
+	;; written twice, and which is mapped through the MMU.=0A=
+	;; =0A=
+	;; We only need to do this for writes.=0A=
+	btstq	8, $r1		   ; Write access?=0A=
+	bpl	1f=0A=
+	nop=0A=
+	move.d	[$sp+16], $r0	   ; Clear unaligned bit in csrinstr =0A=
+	and.d	~(1<<5), $r0=0A=
+	move.d	$r0, [$sp+16]=0A=
+1:	btstq	12, $r1		   ; Refill?=0A=
+	bpl	2f=0A=
+	lsrq	PMD_SHIFT, $r1     ; Get PMD index into PGD (bit 24-31)=0A=
+	move.d  [current_pgd], $r0 ; PGD for the current process=0A=
+	move.d	[$r0+$r1.d], $r0   ; Get PMD=0A=
+	beq	2f=0A=
+	nop=0A=
+	and.w	PAGE_MASK, $r0	   ; Remove PMD flags=0A=
+	move.d  [R_MMU_CAUSE], $r1=0A=
+	lsrq	PAGE_SHIFT, $r1=0A=
+	and.d	0x7ff, $r1         ; Get PTE index into PMD (bit 13-24)=0A=
+	move.d	[$r0+$r1.d], $r1   ; Get PTE=0A=
+	beq	2f=0A=
+	nop=0A=
+	;; Store in TLB=0A=
+	move.d  $r1, [R_TLB_LO]=0A=
+	;; Return=0A=
+	movem	[$sp+], $r1=0A=
+	pop	$dccr=0A=
+	rbf	[$sp+]		; return by popping the CPU status=0A=
+	=0A=
+2:	; PMD or PTE missing, let the mm subsystem fix it up.=0A=
+	movem	[$sp+], $r1=0A=
+	pop	$dccr=0A=
+=0A=
+	; Ok, not that easy, pass it on to the mm subsystem=0A=
+	; The MMU status record is now on the stack =0A=
 	push	$srp		; make a stackframe similar to pt_regs=0A=
 	push	$dccr=0A=
 	push	$mof=0A=
@@ -556,7 +627,7 @@=0A=
 =0A=
 	move.d	$sp, $r10	; pt_regs argument to handle_mmu_bus_fault=0A=
 		=0A=
-	jsr	handle_mmu_bus_fault  ; in arch/cris/mm/fault.c=0A=
+	jsr	handle_mmu_bus_fault  ; in arch/cris/arch-v10/mm/fault.c=0A=
 =0A=
 	;; now we need to return through the normal path, we cannot just=0A=
 	;; do the RBFexit since we might have killed off the running=0A=
@@ -566,51 +637,23 @@=0A=
 	moveq	0, $r9		; busfault is equivalent to an irq=0A=
 		=0A=
 	ba	ret_from_intr=0A=
-	nop=0A=
+	nop	=0A=
 		=0A=
 	;; special handlers for breakpoint and NMI=0A=
-#if 0			=0A=
 hwbreakpoint:=0A=
 	push	$dccr=0A=
-	di=0A=
-	push	$r10=0A=
-	push	$r11=0A=
-	push	$r12=0A=
-	push	$r13=0A=
-	clearf	b=0A=
-	move	$brp,$r11=0A=
-	move.d	[hw_bp_msg],$r10=0A=
-	jsr	printk=0A=
-	setf	b=0A=
-	pop	$r13=0A=
-	pop	$r12=0A=
-	pop	$r11=0A=
-	pop	$r10=0A=
-	pop	$dccr=0A=
-	retb=0A=
-	nop=0A=
-#else=0A=
-hwbreakpoint:=0A=
-	push	$dccr=0A=
-	di=0A=
-#if 1=0A=
+	di	=0A=
 	push	$r10=0A=
 	push	$r11=0A=
 	move.d	[hw_bp_trig_ptr],$r10=0A=
-	move.d	[$r10],$r11=0A=
-	cmp.d	42,$r11=0A=
-	beq	1f=0A=
-	nop=0A=
 	move	$brp,$r11=0A=
 	move.d	$r11,[$r10+]=0A=
 	move.d	$r10,[hw_bp_trig_ptr]=0A=
 1:	pop	$r11=0A=
 	pop	$r10=0A=
-#endif=0A=
 	pop	$dccr=0A=
 	retb=0A=
 	nop=0A=
-#endif=0A=
 	=0A=
 IRQ1_interrupt:=0A=
 =0A=
@@ -719,29 +762,23 @@=0A=
 	push	$r10		; push orig_r10=0A=
 	clear.d [$sp=3D$sp-4]	; frametype =3D=3D 0, normal frame=0A=
 	=0A=
-	move.d	irq_shortcuts + 8, $r1=0A=
 	moveq	2, $r2		; first bit we care about is the timer0 irq=0A=
 	move.d	[R_VECT_MASK_RD], $r0; read the irq bits that triggered the =
multiple irq=0A=
+	move.d	$r0, [R_VECT_MASK_CLR] ; Block all active IRQs=0A=
 1:	=0A=
 	btst	$r2, $r0	; check for the irq given by bit r2=0A=
-	bmi	_do_shortcut	; actually do the shortcut=0A=
-	nop=0A=
+	bpl	2f=0A=
+	move.d  $r2, $r10	; First argument to do_IRQ=0A=
+	move.d  $sp, $r11	; second argument to do_IRQ=0A=
+	jsr	do_IRQ=0A=
+2:		=0A=
 	addq	1, $r2		; next vector bit=0A=
-	addq	4, $r1		; next vector=0A=
 	cmp.b	32, $r2=0A=
 	bne	1b	; process all irq's up to and including number 31=0A=
-	nop=0A=
+	moveq	0, $r9  ; make ret_from_intr realise we came from an ir=0A=
 	=0A=
-	;; strange, we didn't get any set vector bits.. oh well, just return=0A=
-	=0A=
-	ba	_Rexit=0A=
-	nop=0A=
-=0A=
-_do_shortcut:=0A=
-	test.d	[$r1]=0A=
-	beq	_Rexit=0A=
-	nop=0A=
-	jump	[$r1]		; jump to the irq handlers shortcut=0A=
+	move.d	$r0, [R_VECT_MASK_SET] ;  Unblock all the IRQs=0A=
+	jump    ret_from_intr=0A=
 =0A=
 do_sigtrap:=0A=
 	;; =0A=
@@ -1079,7 +1116,9 @@=0A=
 	.long sys_mq_timedreceive	/* 280 */=0A=
 	.long sys_mq_notify=0A=
 	.long sys_mq_getsetattr=0A=
-		=0A=
+	.long sys_ni_syscall		/* reserved for kexec */=0A=
+	.long sys_waitid=0A=
+	=0A=
         /*=0A=
          * NOTE!! This doesn't have to be exact - we just have=0A=
          * to make sure we have _enough_ of the "sys_ni_syscall"=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/head.S =
lx25/arch/cris/arch-v10/kernel/head.S=0A=
--- ../linux/arch/cris/arch-v10/kernel/head.S	Mon Oct 18 23:55:21 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/head.S	Fri May 14 09:58:01 2004=0A=
@@ -336,14 +336,14 @@=0A=
 #endif=0A=
 =0A=
 	;; Set up waitstates etc according to kernel configuration.=0A=
-#ifndef CONFIG_SVINTO_SIM=0A=
+#ifndef CONFIG_SVINTO_SIM	=0A=
 	move.d   CONFIG_ETRAX_DEF_R_WAITSTATES, $r0=0A=
 	move.d   $r0, [R_WAITSTATES]=0A=
 =0A=
 	move.d   CONFIG_ETRAX_DEF_R_BUS_CONFIG, $r0=0A=
 	move.d   $r0, [R_BUS_CONFIG]=0A=
 #endif=0A=
-=0A=
+	=0A=
 	;; We need to initialze DRAM registers before we start using the DRAM=0A=
 =0A=
 	cmp.d	RAM_INIT_MAGIC, $r8	; Already initialized?=0A=
@@ -652,7 +652,7 @@=0A=
 #if defined(CONFIG_ETRAX_DEF_R_PORT_G24_DIR_OUT)=0A=
        or.d      IO_STATE (R_GEN_CONFIG, g24dir, out),$r0=0A=
 #endif=0A=
-=0A=
+	=0A=
 	move.d	$r0,[genconfig_shadow] ; init a shadow register of R_GEN_CONFIG=0A=
 =0A=
 #ifndef CONFIG_SVINTO_SIM=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/irq.c =
lx25/arch/cris/arch-v10/kernel/irq.c=0A=
--- ../linux/arch/cris/arch-v10/kernel/irq.c	Mon Oct 18 23:54:08 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/irq.c	Wed Jun  9 07:30:27 2004=0A=
@@ -1,4 +1,4 @@=0A=
-/* $Id: irq.c,v 1.1 2002/12/11 15:42:02 starvik Exp $=0A=
+/* $Id: irq.c,v 1.2 2004/06/09 05:30:27 starvik Exp $=0A=
  *=0A=
  *	linux/arch/cris/kernel/irq.c=0A=
  *=0A=
@@ -23,12 +23,8 @@=0A=
  */=0A=
 =0A=
 void=0A=
-set_int_vector(int n, irqvectptr addr, irqvectptr saddr)=0A=
+set_int_vector(int n, irqvectptr addr)=0A=
 {=0A=
-	/* remember the shortcut entry point, after the prologue */=0A=
-=0A=
-	irq_shortcuts[n] =3D saddr;=0A=
-=0A=
 	etrax_irv->v[n + 0x20] =3D (irqvectptr)addr;=0A=
 }=0A=
 =0A=
@@ -106,17 +102,6 @@=0A=
 	IRQ31_interrupt=0A=
 };=0A=
 =0A=
-static void (*sinterrupt[NR_IRQS])(void) =3D {=0A=
-	NULL, NULL, sIRQ2_interrupt, sIRQ3_interrupt,=0A=
-	sIRQ4_interrupt, sIRQ5_interrupt, sIRQ6_interrupt, sIRQ7_interrupt,=0A=
-	sIRQ8_interrupt, sIRQ9_interrupt, sIRQ10_interrupt, sIRQ11_interrupt,=0A=
-	sIRQ12_interrupt, sIRQ13_interrupt, NULL, NULL,	=0A=
-	sIRQ16_interrupt, sIRQ17_interrupt, sIRQ18_interrupt, =
sIRQ19_interrupt,	=0A=
-	sIRQ20_interrupt, sIRQ21_interrupt, sIRQ22_interrupt, =
sIRQ23_interrupt,	=0A=
-	sIRQ24_interrupt, sIRQ25_interrupt, NULL, NULL, NULL, NULL, NULL,=0A=
-	sIRQ31_interrupt=0A=
-};=0A=
-=0A=
 static void (*bad_interrupt[NR_IRQS])(void) =3D {=0A=
         NULL, NULL,=0A=
 	NULL, bad_IRQ3_interrupt,=0A=
@@ -137,12 +122,12 @@=0A=
 =0A=
 void arch_setup_irq(int irq)=0A=
 {=0A=
-  set_int_vector(irq, interrupt[irq], sinterrupt[irq]);=0A=
+  set_int_vector(irq, interrupt[irq]);=0A=
 }=0A=
 =0A=
 void arch_free_irq(int irq)=0A=
 {=0A=
-  set_int_vector(irq, bad_interrupt[irq], 0);=0A=
+  set_int_vector(irq, bad_interrupt[irq]);=0A=
 }=0A=
 =0A=
 void weird_irq(void);=0A=
@@ -187,20 +172,20 @@=0A=
         =0A=
 	/* set all etrax irq's to the bad handlers */=0A=
 	for (i =3D 2; i < NR_IRQS; i++)=0A=
-		set_int_vector(i, bad_interrupt[i], 0);=0A=
+		set_int_vector(i, bad_interrupt[i]);=0A=
         =0A=
 	/* except IRQ 15 which is the multiple-IRQ handler on Etrax100 */=0A=
 =0A=
-	set_int_vector(15, multiple_interrupt, 0);=0A=
+	set_int_vector(15, multiple_interrupt);=0A=
 	=0A=
 	/* 0 and 1 which are special breakpoint/NMI traps */=0A=
 =0A=
-	set_int_vector(0, hwbreakpoint, 0);=0A=
-	set_int_vector(1, IRQ1_interrupt, 0);=0A=
+	set_int_vector(0, hwbreakpoint);=0A=
+	set_int_vector(1, IRQ1_interrupt);=0A=
 =0A=
 	/* and irq 14 which is the mmu bus fault handler */=0A=
 =0A=
-	set_int_vector(14, mmu_bus_fault, 0);=0A=
+	set_int_vector(14, mmu_bus_fault);=0A=
 =0A=
 	/* setup the system-call trap, which is reached by BREAK 13 */=0A=
 =0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/ptrace.c =
lx25/arch/cris/arch-v10/kernel/ptrace.c=0A=
--- ../linux/arch/cris/arch-v10/kernel/ptrace.c	Mon Oct 18 23:55:28 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/ptrace.c	Tue Oct 19 15:07:37 2004=0A=
@@ -23,8 +23,37 @@=0A=
  */=0A=
 #define DCCR_MASK 0x0000001f     /* XNZVC */=0A=
 =0A=
-extern inline long get_reg(struct task_struct *, unsigned int);=0A=
-extern inline long put_reg(struct task_struct *, unsigned int, unsigned =
long);=0A=
+/*=0A=
+ * Get contents of register REGNO in task TASK.=0A=
+ */=0A=
+inline long get_reg(struct task_struct *task, unsigned int regno)=0A=
+{=0A=
+	/* USP is a special case, it's not in the pt_regs struct but=0A=
+	 * in the tasks thread struct=0A=
+	 */=0A=
+=0A=
+	if (regno =3D=3D PT_USP)=0A=
+		return task->thread.usp;=0A=
+	else if (regno < PT_MAX)=0A=
+		return ((unsigned long *)user_regs(task->thread_info))[regno];=0A=
+	else=0A=
+		return 0;=0A=
+}=0A=
+=0A=
+/*=0A=
+ * Write contents of register REGNO in task TASK.=0A=
+ */=0A=
+inline int put_reg(struct task_struct *task, unsigned int regno,=0A=
+			  unsigned long data)=0A=
+{=0A=
+	if (regno =3D=3D PT_USP)=0A=
+		task->thread.usp =3D data;=0A=
+	else if (regno < PT_MAX)=0A=
+		((unsigned long *)user_regs(task->thread_info))[regno] =3D data;=0A=
+	else=0A=
+		return -1;=0A=
+	return 0;=0A=
+}=0A=
 =0A=
 /*=0A=
  * Called by kernel/ptrace.c when detaching.=0A=
@@ -50,6 +79,7 @@=0A=
 {=0A=
 	struct task_struct *child;=0A=
 	int ret;=0A=
+	unsigned long __user *datap =3D (unsigned long __user *)data;=0A=
 =0A=
 	lock_kernel();=0A=
 	ret =3D -EPERM;=0A=
@@ -102,7 +132,7 @@=0A=
 			if (copied !=3D sizeof(tmp))=0A=
 				break;=0A=
 			=0A=
-			ret =3D put_user(tmp,(unsigned long *) data);=0A=
+			ret =3D put_user(tmp,datap);=0A=
 			break;=0A=
 		}=0A=
 =0A=
@@ -115,7 +145,7 @@=0A=
 				break;=0A=
 =0A=
 			tmp =3D get_reg(child, addr >> 2);=0A=
-			ret =3D put_user(tmp, (unsigned long *)data);=0A=
+			ret =3D put_user(tmp, datap);=0A=
 			break;=0A=
 		}=0A=
 		=0A=
@@ -213,7 +243,7 @@=0A=
 			for (i =3D 0; i <=3D PT_MAX; i++) {=0A=
 				tmp =3D get_reg(child, i);=0A=
 				=0A=
-				if (put_user(tmp, (unsigned long *) data)) {=0A=
+				if (put_user(tmp, datap)) {=0A=
 					ret =3D -EFAULT;=0A=
 					goto out_tsk;=0A=
 				}=0A=
@@ -231,7 +261,7 @@=0A=
 			unsigned long tmp;=0A=
 			=0A=
 			for (i =3D 0; i <=3D PT_MAX; i++) {=0A=
-				if (get_user(tmp, (unsigned long *) data)) {=0A=
+				if (get_user(tmp, datap)) {=0A=
 					ret =3D -EFAULT;=0A=
 					goto out_tsk;=0A=
 				}=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/setup.c =
lx25/arch/cris/arch-v10/kernel/setup.c=0A=
--- ../linux/arch/cris/arch-v10/kernel/setup.c	Mon Oct 18 23:54:55 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/setup.c	Fri May 14 09:58:01 2004=0A=
@@ -1,4 +1,4 @@=0A=
-/*=0A=
+/*  =0A=
  *=0A=
  *  linux/arch/cris/arch-v10/kernel/setup.c=0A=
  *=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/signal.c =
lx25/arch/cris/arch-v10/kernel/signal.c=0A=
--- ../linux/arch/cris/arch-v10/kernel/signal.c	Mon Oct 18 23:53:08 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/signal.c	Tue Oct 19 15:07:37 2004=0A=
@@ -264,7 +264,6 @@=0A=
 {=0A=
 	struct rt_sigframe __user *frame =3D (struct rt_sigframe *)rdusp();=0A=
 	sigset_t set;=0A=
-	stack_t st;=0A=
 =0A=
         /*=0A=
          * Since we stacked the signal on a dword boundary,=0A=
@@ -288,11 +287,8 @@=0A=
 	if (restore_sigcontext(regs, &frame->uc.uc_mcontext))=0A=
 		goto badframe;=0A=
 =0A=
-	if (__copy_from_user(&st, &frame->uc.uc_stack, sizeof(st)))=0A=
+	if (do_sigaltstack(&frame->uc.uc_stack, NULL, rdusp()) =3D=3D -EFAULT)=0A=
 		goto badframe;=0A=
-	/* It is more difficult to avoid calling this function than to=0A=
-	   call it and ignore errors.  */=0A=
-	do_sigaltstack(&st, NULL, rdusp());=0A=
 =0A=
 	return regs->r10;=0A=
 =0A=
@@ -388,9 +384,9 @@=0A=
 		/* trampoline - the desired return ip is the retcode itself */=0A=
 		return_ip =3D (unsigned long)&frame->retcode;=0A=
 		/* This is movu.w __NR_sigreturn, r9; break 13; */=0A=
-		err |=3D __put_user(0x9c5f,         (short *)(frame->retcode+0));=0A=
-		err |=3D __put_user(__NR_sigreturn, (short *)(frame->retcode+2));=0A=
-		err |=3D __put_user(0xe93d,         (short *)(frame->retcode+4));=0A=
+		err |=3D __put_user(0x9c5f,         (short =
__user*)(frame->retcode+0));=0A=
+		err |=3D __put_user(__NR_sigreturn, (short =
__user*)(frame->retcode+2));=0A=
+		err |=3D __put_user(0xe93d,         (short =
__user*)(frame->retcode+4));=0A=
 	}=0A=
 =0A=
 	if (err)=0A=
@@ -448,9 +444,9 @@=0A=
 		/* trampoline - the desired return ip is the retcode itself */=0A=
 		return_ip =3D (unsigned long)&frame->retcode;=0A=
 		/* This is movu.w __NR_rt_sigreturn, r9; break 13; */=0A=
-		err |=3D __put_user(0x9c5f,            (short *)(frame->retcode+0));=0A=
-		err |=3D __put_user(__NR_rt_sigreturn, (short *)(frame->retcode+2));=0A=
-		err |=3D __put_user(0xe93d,            (short *)(frame->retcode+4));=0A=
+		err |=3D __put_user(0x9c5f,            (short =
__user*)(frame->retcode+0));=0A=
+		err |=3D __put_user(__NR_rt_sigreturn, (short =
__user*)(frame->retcode+2));=0A=
+		err |=3D __put_user(0xe93d,            (short =
__user*)(frame->retcode+4));=0A=
 	}=0A=
 =0A=
 	if (err)=0A=
@@ -482,10 +478,9 @@=0A=
 =0A=
 extern inline void=0A=
 handle_signal(int canrestart, unsigned long sig,=0A=
-	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs)=0A=
+	      siginfo_t *info, struct k_sigaction *ka, =0A=
+              sigset_t *oldset, struct pt_regs * regs)=0A=
 {=0A=
-	struct k_sigaction *ka =3D &current->sighand->action[sig-1];=0A=
-=0A=
 	/* Are we from a system call? */=0A=
 	if (canrestart) {=0A=
 		/* If so, check system call restarting.. */=0A=
@@ -547,6 +542,7 @@=0A=
 {=0A=
 	siginfo_t info;=0A=
 	int signr;=0A=
+        struct k_sigaction ka;=0A=
 =0A=
 	/*=0A=
 	 * We want the common case to go fast, which=0A=
@@ -560,10 +556,10 @@=0A=
 	if (!oldset)=0A=
 		oldset =3D &current->blocked;=0A=
 =0A=
-	signr =3D get_signal_to_deliver(&info, regs, NULL);=0A=
+	signr =3D get_signal_to_deliver(&info, &ka, regs, NULL);=0A=
 	if (signr > 0) {=0A=
 		/* Whee!  Actually deliver the signal.  */=0A=
-		handle_signal(canrestart, signr, &info, oldset, regs);=0A=
+		handle_signal(canrestart, signr, &info, &ka, oldset, regs);=0A=
 		return 1;=0A=
 	}=0A=
 =0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/time.c =
lx25/arch/cris/arch-v10/kernel/time.c=0A=
--- ../linux/arch/cris/arch-v10/kernel/time.c	Mon Oct 18 23:54:39 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/time.c	Wed Sep 29 08:12:46 2004=0A=
@@ -1,4 +1,4 @@=0A=
-/* $Id: time.c,v 1.3 2004/06/01 05:38:42 starvik Exp $=0A=
+/* $Id: time.c,v 1.5 2004/09/29 06:12:46 starvik Exp $=0A=
  *=0A=
  *  linux/arch/cris/arch-v10/kernel/time.c=0A=
  *=0A=
@@ -200,6 +200,8 @@=0A=
 =0A=
 //static unsigned short myjiff; /* used by our debug routine =
print_timestamp */=0A=
 =0A=
+extern void cris_do_profile(struct pt_regs *regs);=0A=
+=0A=
 static inline irqreturn_t=0A=
 timer_interrupt(int irq, void *dev_id, struct pt_regs *regs)=0A=
 {=0A=
@@ -228,6 +230,8 @@=0A=
 =0A=
 	do_timer(regs);=0A=
 	=0A=
+        cris_do_profile(regs); /* Save profiling information */=0A=
+        =0A=
 	/*=0A=
 	 * If we have an externally synchronized Linux clock, then update=0A=
 	 * CMOS clock accordingly every ~11 minutes. Set_rtc_mmss() has to be=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/mm/fault.c lx25/arch/cris/arch-v10/mm/fault.c=0A=
--- ../linux/arch/cris/arch-v10/mm/fault.c	Mon Oct 18 23:55:28 2004=0A=
+++ lx25/arch/cris/arch-v10/mm/fault.c	Mon Sep  6 08:36:14 2004=0A=
@@ -40,23 +40,25 @@=0A=
 handle_mmu_bus_fault(struct pt_regs *regs)=0A=
 {=0A=
 	int cause;=0A=
-#ifdef DEBUG=0A=
 	int select;=0A=
+#ifdef DEBUG=0A=
 	int index;=0A=
 	int page_id;=0A=
 	int acc, inv;=0A=
 #endif=0A=
-	int miss, we, writeac;=0A=
+	pgd_t* pgd =3D (pgd_t*)current_pgd;=0A=
 	pmd_t *pmd;=0A=
 	pte_t pte;=0A=
+	int miss, we, writeac;=0A=
 	unsigned long address;=0A=
+	unsigned long flags;=0A=
 =0A=
 	cause =3D *R_MMU_CAUSE;=0A=
 =0A=
 	address =3D cause & PAGE_MASK; /* get faulting address */=0A=
+	select =3D *R_TLB_SELECT;=0A=
 =0A=
 #ifdef DEBUG=0A=
-	select =3D *R_TLB_SELECT;=0A=
 	page_id =3D IO_EXTRACT(R_MMU_CAUSE,  page_id,   cause);=0A=
 	acc     =3D IO_EXTRACT(R_MMU_CAUSE,  acc_excp,  cause);=0A=
 	inv     =3D IO_EXTRACT(R_MMU_CAUSE,  inv_excp,  cause);  =0A=
@@ -66,85 +68,31 @@=0A=
 	we      =3D IO_EXTRACT(R_MMU_CAUSE,  we_excp,   cause);=0A=
 	writeac =3D IO_EXTRACT(R_MMU_CAUSE,  wr_rd,     cause);=0A=
 =0A=
-	/* ETRAX 100LX TR89 bugfix: if the second half of an unaligned=0A=
-	 * write causes a MMU-fault, it will not be restarted correctly.=0A=
-	 * This could happen if a write crosses a page-boundary and the=0A=
-	 * second page is not yet COW'ed or even loaded. The workaround=0A=
-	 * is to clear the unaligned bit in the CPU status record, so =0A=
-	 * that the CPU will rerun both the first and second halves of=0A=
-	 * the instruction. This will not have any sideeffects unless=0A=
-	 * the first half goes to any device or memory that can't be=0A=
-	 * written twice, and which is mapped through the MMU.=0A=
-	 *=0A=
-	 * We only need to do this for writes.=0A=
-	 */=0A=
-=0A=
-	if(writeac)=0A=
-		regs->csrinstr &=3D ~(1 << 5);=0A=
-	=0A=
 	D(printk("bus_fault from IRP 0x%lx: addr 0x%lx, miss %d, inv %d, we =
%d, acc %d, dx %d pid %d\n",=0A=
 		 regs->irp, address, miss, inv, we, acc, index, page_id));=0A=
 =0A=
-	/* for a miss, we need to reload the TLB entry */=0A=
-=0A=
-	if (miss) {=0A=
-		/* see if the pte exists at all=0A=
-		 * refer through current_pgd, dont use mm->pgd=0A=
-		 */=0A=
-=0A=
-		pmd =3D (pmd_t *)(current_pgd + pgd_index(address));=0A=
-		if (pmd_none(*pmd)) {=0A=
-			do_page_fault(address, regs, 0, writeac);=0A=
-			return;=0A=
-		}=0A=
-		if (pmd_bad(*pmd)) {=0A=
-			printk("bad pgdir entry 0x%lx at 0x%p\n", *(unsigned long*)pmd, pmd);=0A=
-			pmd_clear(pmd);=0A=
-			return;=0A=
-		}=0A=
-		pte =3D *pte_offset_kernel(pmd, address);=0A=
-		if (!pte_present(pte)) {=0A=
-			do_page_fault(address, regs, 0, writeac);=0A=
-			return;=0A=
-		}=0A=
-=0A=
-#ifdef DEBUG=0A=
-		printk(" found pte %lx pg %p ", pte_val(pte), pte_page(pte));=0A=
-		if (pte_val(pte) & _PAGE_SILENT_WRITE)=0A=
-			printk("Silent-W ");=0A=
-		if (pte_val(pte) & _PAGE_KERNEL)=0A=
-			printk("Kernel ");=0A=
-		if (pte_val(pte) & _PAGE_SILENT_READ)=0A=
-			printk("Silent-R ");=0A=
-		if (pte_val(pte) & _PAGE_GLOBAL)=0A=
-			printk("Global ");=0A=
-		if (pte_val(pte) & _PAGE_PRESENT)=0A=
-			printk("Present ");=0A=
-		if (pte_val(pte) & _PAGE_ACCESSED)=0A=
-			printk("Accessed ");=0A=
-		if (pte_val(pte) & _PAGE_MODIFIED)=0A=
-			printk("Modified ");=0A=
-		if (pte_val(pte) & _PAGE_READ)=0A=
-			printk("Readable ");=0A=
-		if (pte_val(pte) & _PAGE_WRITE)=0A=
-			printk("Writeable ");=0A=
-		printk("\n");=0A=
-#endif=0A=
-=0A=
-		/* load up the chosen TLB entry=0A=
-		 * this assumes the pte format is the same as the TLB_LO layout.=0A=
-		 *=0A=
-		 * the write to R_TLB_LO also writes the vpn and page_id fields from=0A=
-		 * R_MMU_CAUSE, which we in this case obviously want to keep=0A=
-		 */=0A=
-=0A=
-		*R_TLB_LO =3D pte_val(pte);=0A=
-=0A=
-		return;=0A=
-	}=0A=
-=0A=
 	/* leave it to the MM system fault handler */=0A=
-	do_page_fault(address, regs, 1, we);=0A=
+	if (miss) =0A=
+		do_page_fault(address, regs, 0, writeac);=0A=
+        else	=0A=
+		do_page_fault(address, regs, 1, we);=0A=
+=0A=
+        /* Reload TLB with new entry to avoid an extra miss exception. =0A=
+	 * do_page_fault may have flushed the TLB so we have to restore=0A=
+	 * the MMU registers.=0A=
+	 */=0A=
+	local_save_flags(flags);=0A=
+	local_irq_disable();=0A=
+	pmd =3D (pmd_t *)(pgd + pgd_index(address));=0A=
+	if (pmd_none(*pmd))=0A=
+		return;=0A=
+	pte =3D *pte_offset_kernel(pmd, address);          =0A=
+	if (!pte_present(pte))=0A=
+		return;=0A=
+	*R_TLB_SELECT =3D select;=0A=
+	*R_TLB_HI =3D cause;=0A=
+	*R_TLB_LO =3D pte_val(pte);=0A=
+	local_irq_restore(flags);=0A=
 }=0A=
 =0A=
 /* Called from arch/cris/mm/fault.c to find fixup code. */=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/mm/tlb.c lx25/arch/cris/arch-v10/mm/tlb.c=0A=
--- ../linux/arch/cris/arch-v10/mm/tlb.c	Mon Oct 18 23:55:29 2004=0A=
+++ lx25/arch/cris/arch-v10/mm/tlb.c	Thu Jun 24 12:38:41 2004=0A=
@@ -65,7 +65,7 @@=0A=
 flush_tlb_mm(struct mm_struct *mm)=0A=
 {=0A=
 	int i;=0A=
-	int page_id =3D mm->context;=0A=
+	int page_id =3D mm->context.page_id;=0A=
 	unsigned long flags;=0A=
 =0A=
 	D(printk("tlb: flush mm context %d (%p)\n", page_id, mm));=0A=
@@ -103,7 +103,7 @@=0A=
 	       unsigned long addr)=0A=
 {=0A=
 	struct mm_struct *mm =3D vma->vm_mm;=0A=
-	int page_id =3D mm->context;=0A=
+	int page_id =3D mm->context.page_id;=0A=
 	int i;=0A=
 	unsigned long flags;=0A=
 =0A=
@@ -147,7 +147,7 @@=0A=
 		unsigned long end)=0A=
 {=0A=
 	struct mm_struct *mm =3D vma->vm_mm;=0A=
-	int page_id =3D mm->context;=0A=
+	int page_id =3D mm->context.page_id;=0A=
 	int i;=0A=
 	unsigned long flags;=0A=
 =0A=
@@ -208,6 +208,18 @@=0A=
 }=0A=
 #endif=0A=
 =0A=
+/*=0A=
+ * Initialize the context related info for a new mm_struct=0A=
+ * instance.=0A=
+ */=0A=
+=0A=
+int=0A=
+init_new_context(struct task_struct *tsk, struct mm_struct *mm)=0A=
+{=0A=
+	mm->context.page_id =3D NO_CONTEXT;=0A=
+	return 0;=0A=
+}=0A=
+=0A=
 /* called in schedule() just before actually doing the switch_to */=0A=
 =0A=
 void =0A=
@@ -231,6 +243,6 @@=0A=
 	=0A=
 	D(printk("switching mmu_context to %d (%p)\n", next->context, next));=0A=
 =0A=
-	*R_MMU_CONTEXT =3D IO_FIELD(R_MMU_CONTEXT, page_id, next->context);=0A=
+	*R_MMU_CONTEXT =3D IO_FIELD(R_MMU_CONTEXT, page_id, =
next->context.page_id);=0A=
 }=0A=
 =0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/kgdb.c =
lx25/arch/cris/arch-v10/kernel/kgdb.c=0A=
--- ../linux/arch/cris/arch-v10/kernel/kgdb.c	Mon Oct 18 23:55:17 2004=0A=
+++ lx25/arch/cris/arch-v10/kernel/kgdb.c	Thu Oct  7 15:59:08 2004=0A=
@@ -18,6 +18,9 @@=0A=
 *! Jul 21 1999  Bjorn Wesen     eLinux port=0A=
 *!=0A=
 *! $Log: kgdb.c,v $=0A=
+*! Revision 1.5  2004/10/07 13:59:08  starvik=0A=
+*! Corrected call to set_int_vector=0A=
+*!=0A=
 *! Revision 1.4  2003/04/09 05:20:44  starvik=0A=
 *! Merge of Linux 2.5.67=0A=
 *!=0A=
@@ -68,7 +71,7 @@=0A=
 *!=0A=
 =
*!-----------------------------------------------------------------------=
----=0A=
 *!=0A=
-*! $Id: kgdb.c,v 1.4 2003/04/09 05:20:44 starvik Exp $=0A=
+*! $Id: kgdb.c,v 1.5 2004/10/07 13:59:08 starvik Exp $=0A=
 *!=0A=
 *! (C) Copyright 1999, Axis Communications AB, LUND, SWEDEN=0A=
 *!=0A=
@@ -1557,7 +1560,7 @@=0A=
 	/* could initialize debug port as well but it's done in head.S =
already... */=0A=
 =0A=
         /* breakpoint handler is now set in irq.c */=0A=
-	set_int_vector(8, kgdb_handle_serial, 0);=0A=
+	set_int_vector(8, kgdb_handle_serial);=0A=
 	=0A=
 	enableDebugIRQ();=0A=
 }=0A=
diff -urNP --exclude=3D'*.cvsignore' =
../linux/arch/cris/arch-v10/kernel/crisksyms.c =
lx25/arch/cris/arch-v10/kernel/crisksyms.c=0A=
--- ../linux/arch/cris/arch-v10/kernel/crisksyms.c	Thu Jan  1 01:00:00 =
1970=0A=
+++ lx25/arch/cris/arch-v10/kernel/crisksyms.c	Wed Jun  2 10:24:38 2004=0A=
@@ -0,0 +1,17 @@=0A=
+#include <linux/config.h>=0A=
+#include <linux/module.h>=0A=
+#include <asm/io.h>=0A=
+#include <asm/arch/svinto.h>=0A=
+=0A=
+/* Export shadow registers for the CPU I/O pins */=0A=
+EXPORT_SYMBOL(genconfig_shadow);=0A=
+EXPORT_SYMBOL(port_pa_data_shadow);=0A=
+EXPORT_SYMBOL(port_pa_dir_shadow);=0A=
+EXPORT_SYMBOL(port_pb_data_shadow);=0A=
+EXPORT_SYMBOL(port_pb_dir_shadow);=0A=
+EXPORT_SYMBOL(port_pb_config_shadow);=0A=
+EXPORT_SYMBOL(port_g_data_shadow);=0A=
+=0A=
+/* Cache flush functions */=0A=
+EXPORT_SYMBOL(flush_etrax_cache);=0A=
+EXPORT_SYMBOL(prepare_rx_descriptor);=0A=

------=_NextPart_000_01DA_01C4C0E4.E88FEF40--

