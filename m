Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266262AbUAVNT5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 08:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266263AbUAVNT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 08:19:57 -0500
Received: from [211.167.76.68] ([211.167.76.68]:57042 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S266262AbUAVNTD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 08:19:03 -0500
Date: Thu, 22 Jan 2004 21:17:46 +0800
From: Hugang <hugang@soulinfo.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: ncunningham@users.sourceforge.net, ncunningham@clear.net.nz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       debian-powerpc@lists.debian.org
Subject: Re: Help port swsusp to ppc.
Message-Id: <20040122211746.3ec1018c@localhost>
In-Reply-To: <1074549790.10595.55.camel@gaston>
References: <20040119105237.62a43f65@localhost>
	<1074483354.10595.5.camel@gaston>
	<1074489645.2111.8.camel@laptop-linux>
	<1074490463.10595.16.camel@gaston>
	<1074534964.2505.6.camel@laptop-linux>
	<1074549790.10595.55.camel@gaston>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__22_Jan_2004_21_17_46_+0800_sQT2q/a.HiRxm4be"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Thu__22_Jan_2004_21_17_46_+0800_sQT2q/a.HiRxm4be
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2004 09:03:11 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Tue, 2004-01-20 at 04:56, Nigel Cunningham wrote:
> > Hi.
> > 
> > On Tue, 2004-01-20 at 00:39, Benjamin Herrenschmidt wrote:
> > > I see no reason why this would be needed on ppc, only the last
> > > step, that is the actual CPU state save, should matter.
> > 
> > Besides saving the CPU state, the code copies the original kernel
> > back. It sort of defeats the purpose to remove that code :>
> 

Attached file is current version of port swsusp to ppc, STILL can not
works, Benjamin, gave me some comments.

I has add one files swsusp2-asm.S. The save/restore processor state base
on pmac_sleep.S. The copybackup is copy from gcc generate assmeble.

Now the suspend has no problem, resume can not works, strange.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc

--Multipart=_Thu__22_Jan_2004_21_17_46_+0800_sQT2q/a.HiRxm4be
Content-Type: text/plain;
 name="arch_ppc.diff"
Content-Disposition: attachment;
 filename="arch_ppc.diff"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.1-suspend/arch/ppc/Kconfig
===================================================================
--- linux-2.6.1-suspend/arch/ppc/Kconfig	(revision 192)
+++ linux-2.6.1-suspend/arch/ppc/Kconfig	(working copy)
@@ -193,6 +193,8 @@
 
 	  If in doubt, say Y here.
 
+source kernel/power/Kconfig
+
 source arch/ppc/platforms/4xx/Kconfig
 
 config PPC64BRIDGE
@@ -681,6 +683,7 @@
 
 config NR_CPUS
 	int "Maximum number of CPUs (2-32)"
+	range 2 32
 	depends on SMP
 	default "4"
 
Index: linux-2.6.1-suspend/arch/ppc/kernel/swsusp2-asm.S
===================================================================
--- linux-2.6.1-suspend/arch/ppc/kernel/swsusp2-asm.S	(revision 0)
+++ linux-2.6.1-suspend/arch/ppc/kernel/swsusp2-asm.S	(revision 0)
@@ -0,0 +1,516 @@
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/cputable.h>
+#include <asm/cache.h>
+#include <asm/thread_info.h>
+#include <asm/offsets.h>
+
+/*
+ * Structure for storing CPU registers on the stack.
+ */
+#define SL_SP		0
+#define SL_PC		4
+#define SL_MSR		8
+#define SL_SDR1		0xc
+#define SL_SPRG0	0x10	/* 4 sprg's */
+#define SL_DBAT0	0x20
+#define SL_IBAT0	0x28
+#define SL_DBAT1	0x30
+#define SL_IBAT1	0x38
+#define SL_DBAT2	0x40
+#define SL_IBAT2	0x48
+#define SL_DBAT3	0x50
+#define SL_IBAT3	0x58
+#define SL_TB		0x60
+#define SL_R2		0x68
+#define SL_CR		0x6c
+#define SL_R12		0x70	/* r12 to r31 */
+#define SL_SIZE		(SL_R12 + 80)
+	
+	.section .text
+	.align 5
+_GLOBAL(do_swsusp_lowlevel)
+	cmpwi	0,r3,0
+	bc	4,2,.L3627
+	
+	mflr	r0	
+	stw	r0,4(r1)
+	stwu	r1,-SL_SIZE(r1)
+
+	mfcr	r0
+	stw	r0,SL_CR(r1)
+	stw	r2,SL_R2(r1)
+	stmw	r12,SL_R12(r1)
+	
+	bl	do_swsusp2_suspend_1
+		
+	stw	r0,SL_PC(r1)	/* saving r0 */
+
+	mfcr	r0			/* move from condition register to r0 */
+	stw	r0,SL_CR(r1)
+	stw	r2,SL_R2(r1)
+	stmw	r12,SL_R12(r1)
+
+	/* Save MSR & SDR1 */
+	mfmsr	r4
+	stw	r4,SL_MSR(r1)
+	mfsdr1	r4
+	stw	r4,SL_SDR1(r1)
+
+	/* Get a stable timebase and save it */
+1:	mftbu	r4
+	stw	r4,SL_TB(r1)
+	mftb	r5
+	stw	r5,SL_TB+4(r1)
+	mftbu	r3
+	cmpw	r3,r4
+	bne	1b
+
+	/* Save SPRGs */
+	mfsprg	r4,0
+	stw	r4,SL_SPRG0(r1)
+	mfsprg	r4,1
+	stw	r4,SL_SPRG0+4(r1)
+	mfsprg	r4,2
+	stw	r4,SL_SPRG0+8(r1)
+	mfsprg	r4,3
+	stw	r4,SL_SPRG0+12(r1)
+
+	/* Save BATs */
+	mfdbatu	r4,0
+	stw	r4,SL_DBAT0(r1)
+	mfdbatl	r4,0
+	stw	r4,SL_DBAT0+4(r1)
+	mfdbatu	r4,1
+	stw	r4,SL_DBAT1(r1)
+	mfdbatl	r4,1
+	stw	r4,SL_DBAT1+4(r1)
+	mfdbatu	r4,2
+	stw	r4,SL_DBAT2(r1)
+	mfdbatl	r4,2
+	stw	r4,SL_DBAT2+4(r1)
+	mfdbatu	r4,3
+	stw	r4,SL_DBAT3(r1)
+	mfdbatl	r4,3
+	stw	r4,SL_DBAT3+4(r1)
+	mfibatu	r4,0
+	stw	r4,SL_IBAT0(r1)
+	mfibatl	r4,0
+	stw	r4,SL_IBAT0+4(r1)
+	mfibatu	r4,1
+	stw	r4,SL_IBAT1(r1)
+	mfibatl	r4,1
+	stw	r4,SL_IBAT1+4(r1)
+	mfibatu	r4,2
+	stw	r4,SL_IBAT2(r1)
+	mfibatl	r4,2
+	stw	r4,SL_IBAT2+4(r1)
+	mfibatu	r4,3
+	stw	r4,SL_IBAT3(r1)
+	mfibatl	r4,3
+	stw	r4,SL_IBAT3+4(r1)
+
+	/* get r1 physical ptr */
+	tophys(r5,r1)
+	addi	r5,r5,SL_PC
+	
+	/* save storage ptr */	
+	lis	r3,pm_sleep_storage@ha
+	addi	r3,r3,pm_sleep_storage@l
+	stw	r5,0(r3)
+	
+	/* Backup various CPU configs stuffs */	
+	bl	__save_cpu_setup
+
+	bl	do_swsusp2_suspend_2
+
+	b	restore_stack
+		
+.L3627:
+	bl do_swsusp2_resume_1
+
+	lis r9,swsusp_action@ha
+	lwz r0,swsusp_action@l(r9)
+	lis r11,swsusp_debug_state@ha
+	lis r9,state1@ha
+	stw r0,state1@l(r9)
+	lwz r8,swsusp_debug_state@l(r11)
+	lis r10,console_printk@ha
+	lis r9,state2@ha
+	lis r11,pagedir_resume@ha
+	stw r8,state2@l(r9)
+	la r11,pagedir_resume@l(r11)
+	lwz r0,console_printk@l(r10)
+	lwz r5,12(r11)
+	lis r9,state3@ha
+	stw r0,state3@l(r9)
+	lwz r10,0(r5)
+	lwz r4,56(r11)
+	lis r9,origoffset@ha
+	stw r10,origoffset@l(r9)
+	lwz r0,0(r4)
+	lis r11,copyoffset@ha
+	stw r0,copyoffset@l(r11)
+	lwz r10,origoffset@l(r9)
+	lwz r8,copyoffset@l(r11)
+	slwi r9,r10,r2
+	slwi r11,r8,r2
+	add r9,r9,r10
+	add r11,r11,8
+	lis r0,0xcccc
+	ori r0,r0,52429
+	slwi r9,r9,r3
+	slwi r11,r11,r3
+	mullw r11,r11,r0
+	mullw r9,r9,r0
+	slwi r11,r11,r9
+	slwi r9,r9,r9
+	cmpwi r0,r5,r0
+	addis r9,r9,0xc000
+	addis r11,r11,0xc000
+	lis r7,origrange@ha
+	lis r6,copyrange@ha
+	lis r10,origpage@ha
+	lis r8,copypage@ha
+	lis r24,origrange@ha
+	lis r25,copyrange@ha
+	lis r12,origoffset@ha
+	lis r3,copyoffset@ha
+	stw r9,origpage@l(r10)
+	stw r11,copypage@l(r8)
+	stw r5,origrange@l(r7)
+	stw r4,copyrange@l(r6)
+	bc r12,r2,.L3646
+	lis r4,0xcccc
+	lis r28,loop@ha
+	lis r26,origoffset@ha
+	lis r29,origrange@ha
+	lis r30,origpage@ha
+	ori r4,r4,52429
+	lis r27,copyoffset@ha
+	lis r31,copypage@ha
+.L3632:
+	li r0,r0
+	stw r0,loop@l(r28)
+	lwz r9,loop@l(r28)
+	cmplwi r0,r9,1023
+	bc r12,r1,.L3637
+	lis r7,loop@ha
+	lis r5,origpage@ha
+	lis r6,copypage@ha
+.L3635:
+	lwz r8,loop@l(r7)
+	lwz r9,loop@l(r7)
+	lwz r11,copypage@l(r6)
+	slwi r9,r9,r2
+	lwzx r0,r9,r11
+	lwz r10,origpage@l(r5)
+	slwi r8,r8,r2
+	stwx r0,r8,r10
+	lwz r9,loop@l(r7)
+	addi r9,r9,r1
+	stw r9,loop@l(r7)
+	lwz r0,loop@l(r7)
+	cmplwi r0,r0,1023
+	bc r4,r1,.L3635
+.L3637:
+	lwz r11,origrange@l(r29)
+	lwz r9,origoffset@l(r26)
+	lwz r0,4(r11)
+	cmplw r0,r9,r0
+	bc r4,r0,.L3638
+	lwz r9,origoffset@l(r12)
+	lwz r11,origpage@l(r30)
+	addi r9,r9,r1
+	addi r11,r11,4096
+	stw r9,origoffset@l(r12)
+	stw r11,origpage@l(r30)
+	b .L3639
+.L3638:
+	lwz r9,8(r11)
+	cmpwi r0,r9,r0
+	stw r9,origrange@l(r24)
+	bc r12,r2,.L3639
+	lwz r9,0(r9)
+	stw r9,origoffset@l(r12)
+	lwz r0,origoffset@l(r12)
+	slwi r9,r0,r2
+	add r9,r9,r0
+	slwi r9,r9,r3
+	mullw r9,r9,r4
+	slwi r9,r9,r9
+	addis r9,r9,0xc000
+	stw r9,origpage@l(r30)
+.L3639:
+	lis r9,copyrange@ha
+	lwz r9,copyrange@l(r9)
+	lwz r11,copyoffset@l(r27)
+	lwz r0,4(r9)
+	cmplw r0,r11,r0
+	bc r4,r0,.L3642
+	lwz r9,copyoffset@l(r3)
+	lwz r11,copypage@l(r31)
+	addi r9,r9,r1
+	addi r11,r11,4096
+	stw r9,copyoffset@l(r3)
+	stw r11,copypage@l(r31)
+	b .L3630
+.L3642:
+	lwz r9,r8(r9)
+	cmpwi r0,r9,r0
+	stw r9,copyrange@l(r25)
+	bc r12,r2,.L3630
+	lwz r9,0(r9)
+	stw r9,copyoffset@l(r3)
+	lwz r0,copyoffset@l(r3)
+	slwi r9,r0,r2
+	add r9,r9,r0
+	slwi r9,r9,r3
+	mullw r9,r9,r4
+	slwi r9,r9,r9
+	addis r9,r9,0xc000
+	stw 9,copypage@l(r31)
+.L3630:
+	lwz r0,origrange@l(r29)
+	cmpwi r0,r0,r0
+	bc r4,r2,.L3632
+.L3646:
+	lis r9,state1@ha
+	lwz r7,state1@l(r9)
+	lis r11,state2@ha
+	lwz r8,state2@l(r11)
+	lis r9,state3@ha
+	lwz r0,state3@l(r9)
+	lis r11,swsusp_action@ha
+	lis r9,swsusp_debug_state@ha
+	lis r10,console_printk@ha
+	stw r7,swsusp_action@l(r11)
+	stw r8,swsusp_debug_state@l(r9)
+	stw r0,console_printk@l(r10)
+
+#if 0
+	bl	pm_turn_off_mmu
+//#else
+	mfmsr	r3
+	andi.	r0,r3,MSR_DR|MSR_IR		/* MMU enabled? */
+	beqlr
+	andc	r3,r3,r0
+	mtspr	SRR0,r4
+	mtspr	SRR1,r3
+	sync
+#endif
+
+#if 1
+	/* Turn off data relocation. */
+	mfmsr	r3		/* Save MSR in r7 */
+	rlwinm	r3,r3,0,28,26	/* Turn off DR bit */
+	sync
+	mtmsr	r3
+	isync
+
+	/* Make sure HID0 no longer contains any sleep bit */
+	mfspr	r3,HID0
+	rlwinm	r3,r3,0,11,7		/* clear SLEEP, NAP, DOZE bits */
+	mtspr	HID0,r3
+	sync
+	isync
+
+	/* Won't that cause problems on CPU that doesn't support it ? */
+	lis	r3, 0
+	mtspr	SPRN_MMCR0, r3
+
+	/* sanitize MSR */
+	mfmsr	r3
+	ori	r3,r3,MSR_EE|MSR_IP
+	xori	r3,r3,MSR_EE|MSR_IP
+	sync
+	isync
+	mtmsr	r3
+	sync
+	isync
+#endif	
+	/* Recover sleep storage */
+	lis	r3,pm_sleep_storage@ha
+	addi	r3,r3,pm_sleep_storage@l
+	tophys(r3,r3)
+	lwz	r1,0(r3)
+
+	/* Invalidate & enable L1 cache, we don't care about
+	 * whatever the ROM may have tried to write to memory
+	 */
+	bl	__inval_enable_L1
+
+	/* Restore the kernel's segment registers before
+	 * we do any r1 memory access as we are not sure they
+	 * are in a sane state above the first 256Mb region
+	 */
+	li	r0,16		/* load up segment register values */
+	mtctr	r0		/* for context 0 */
+	lis	r3,0x2000	/* Ku = 1, VSID = 0 */
+	li	r4,0
+3:	mtsrin	r3,r4
+	addi	r3,r3,0x111	/* increment VSID */
+	addis	r4,r4,0x1000	/* address of next segment */
+	bdnz	3b
+	sync
+	isync
+
+	subi	r1,r1,SL_PC
+	
+	/* Restore various CPU config stuffs */
+	bl	__restore_cpu_setup
+			
+	/* Restore the BATs, and SDR1.  Then we can turn on the MMU. */
+	lwz	r4,SL_SDR1(r1)
+	mtsdr1	r4
+	lwz	r4,SL_SPRG0(r1)
+	mtsprg	0,r4
+	lwz	r4,SL_SPRG0+4(r1)
+	mtsprg	1,r4
+	lwz	r4,SL_SPRG0+8(r1)
+	mtsprg	2,r4
+	lwz	r4,SL_SPRG0+12(r1)
+	mtsprg	3,r4
+
+	lwz	r4,SL_DBAT0(r1)
+	mtdbatu	0,r4
+	lwz	r4,SL_DBAT0+4(r1)
+	mtdbatl	0,r4
+	lwz	r4,SL_DBAT1(r1)
+	mtdbatu	1,r4
+	lwz	r4,SL_DBAT1+4(r1)
+	mtdbatl	1,r4
+	lwz	r4,SL_DBAT2(r1)
+	mtdbatu	2,r4
+	lwz	r4,SL_DBAT2+4(r1)
+	mtdbatl	2,r4
+	lwz	r4,SL_DBAT3(r1)
+	mtdbatu	3,r4
+	lwz	r4,SL_DBAT3+4(r1)
+	mtdbatl	3,r4
+	lwz	r4,SL_IBAT0(r1)
+	mtibatu	0,r4
+	lwz	r4,SL_IBAT0+4(r1)
+	mtibatl	0,r4
+	lwz	r4,SL_IBAT1(r1)
+	mtibatu	1,r4
+	lwz	r4,SL_IBAT1+4(r1)
+	mtibatl	1,r4
+	lwz	r4,SL_IBAT2(r1)
+	mtibatu	2,r4
+	lwz	r4,SL_IBAT2+4(r1)
+	mtibatl	2,r4
+	lwz	r4,SL_IBAT3(r1)
+	mtibatu	3,r4
+	lwz	r4,SL_IBAT3+4(r1)
+	mtibatl	3,r4
+
+BEGIN_FTR_SECTION
+	li	r4,0
+	mtspr	SPRN_DBAT4U,r4
+	mtspr	SPRN_DBAT4L,r4
+	mtspr	SPRN_DBAT5U,r4
+	mtspr	SPRN_DBAT5L,r4
+	mtspr	SPRN_DBAT6U,r4
+	mtspr	SPRN_DBAT6L,r4
+	mtspr	SPRN_DBAT7U,r4
+	mtspr	SPRN_DBAT7L,r4
+	mtspr	SPRN_IBAT4U,r4
+	mtspr	SPRN_IBAT4L,r4
+	mtspr	SPRN_IBAT5U,r4
+	mtspr	SPRN_IBAT5L,r4
+	mtspr	SPRN_IBAT6U,r4
+	mtspr	SPRN_IBAT6L,r4
+	mtspr	SPRN_IBAT7U,r4
+	mtspr	SPRN_IBAT7L,r4
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)
+
+	/* Flush all TLBs */
+	lis	r4,0x1000
+1:	addic.	r4,r4,-0x1000
+	tlbie	r4
+	blt	1b
+	sync
+
+	/* restore the MSR and turn on the MMU */
+	lwz	r3,SL_MSR(r1)
+	bl	pm_turn_on_mmu
+		
+	/* get back the stack pointer */
+	tovirt(r1,r1)	
+
+	/* Restore TB */
+	li	r3,0
+	mttbl	r3
+	lwz	r3,SL_TB(r1)
+	lwz	r4,SL_TB+4(r1)
+	mttbu	r3
+	mttbl	r4
+	
+	bl	do_swsusp2_resume_2
+	
+restore_stack:	
+	/* Restore the callee-saved registers and return */
+	lwz	r0,SL_CR(r1)
+	mtcr	r0
+	lwz	r2,SL_R2(r1)
+	lmw	r12,SL_R12(r1)
+	addi	r1,r1,SL_SIZE
+	lwz	r0,4(r1)
+	mtlr	r0
+	blr
+
+pm_turn_on_mmu:
+	mflr	r4
+	tovirt(r4,r4)
+	mtsrr0	r4
+	mtsrr1	r3
+	sync
+	isync
+	rfi
+
+pm_turn_off_mmu:	
+	mfmsr	r3
+	andi.	r0,r3,MSR_DR|MSR_IR		/* MMU enabled? */
+	beqlr
+	andc	r3,r3,r0
+	mtspr	SRR0,r4
+	mtspr	SRR1,r3
+	sync
+	rfi
+
+	.section	".data.nosave"
+origrange:
+	.long 0
+copyrange:
+	.long 0
+origoffset:
+	.long 0
+copyoffset:
+	.long 0
+origpage:
+	.long 0
+copypage:
+	.long 0
+loop:
+	.long 0
+state1:
+	.long 0
+state2:
+	.long 0
+state3:
+	.long 0
+c_loops_per_jiffy_ref:
+	.long 0
+cpu_khz_ref:
+	.long 0
+
+	.section .data
+	.balign L1_CACHE_LINE_SIZE
+pm_sleep_storage:
+	.long 0
+	.balign L1_CACHE_LINE_SIZE,0
+	
+	.text
Index: linux-2.6.1-suspend/arch/ppc/kernel/Makefile
===================================================================
--- linux-2.6.1-suspend/arch/ppc/kernel/Makefile	(revision 192)
+++ linux-2.6.1-suspend/arch/ppc/kernel/Makefile	(working copy)
@@ -34,3 +34,4 @@
 obj-$(CONFIG_8xx)		+= softemu8xx.o
 endif
 
+obj-$(CONFIG_SOFTWARE_SUSPEND2) += swsusp2-asm.o
Index: linux-2.6.1-suspend/arch/ppc/kernel/vmlinux.lds.S
===================================================================
--- linux-2.6.1-suspend/arch/ppc/kernel/vmlinux.lds.S	(revision 192)
+++ linux-2.6.1-suspend/arch/ppc/kernel/vmlinux.lds.S	(working copy)
@@ -72,6 +72,12 @@
     CONSTRUCTORS
   }
 
+  . = ALIGN(4096);
+  __nosave_begin = .;
+  .data_nosave : { *(.data.nosave) }
+  . = ALIGN(4096);
+  __nosave_end = .;
+
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }
 
Index: linux-2.6.1-suspend/arch/ppc/kernel/signal.c
===================================================================
--- linux-2.6.1-suspend/arch/ppc/kernel/signal.c	(revision 192)
+++ linux-2.6.1-suspend/arch/ppc/kernel/signal.c	(working copy)
@@ -28,6 +28,7 @@
 #include <linux/elf.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -552,6 +553,11 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(PF_FREEZE);
+		return 0;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
Index: linux-2.6.1-suspend/arch/ppc/kernel/swsusp2.c
===================================================================
--- linux-2.6.1-suspend/arch/ppc/kernel/swsusp2.c	(revision 0)
+++ linux-2.6.1-suspend/arch/ppc/kernel/swsusp2.c	(revision 0)
@@ -0,0 +1,161 @@
+ /*
+  * Copyright 2003 Nigel Cunningham.
+  *
+  * This is the code that the code in swsusp2-asm.S for
+  * copying back the original kernel is based upon. It
+  * was based upon code that is...
+  * Copyright 2001-2002 Pavel Machek <pavel@suse.cz>
+  * Based on code
+  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
+  * Copyright 2004 Hu Gang <hugang@soulinfo.com
+  *  port to PowerPC
+  */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/types.h>
+#include <linux/spinlock.h>
+#include <linux/poll.h>
+#include <linux/delay.h>
+#include <linux/sysrq.h>
+#include <linux/proc_fs.h>
+#include <linux/irq.h>
+#include <linux/pm.h>
+#include <linux/device.h>
+#include <linux/suspend.h>
+#include <linux/suspend-debug.h>
+#include <linux/suspend-common.h>
+#include <asm/uaccess.h>
+
+/* Local variables for do_swsusp2_suspend */
+volatile static int loop __nosavedata = 0;
+volatile static int state1 __nosavedata = 0;
+volatile static int state2 __nosavedata = 0;
+volatile static int state3 __nosavedata = 0;
+volatile static struct range *origrange __nosavedata;
+volatile static struct range *copyrange __nosavedata;
+volatile static int origoffset __nosavedata;
+volatile static int copyoffset __nosavedata;
+volatile static unsigned long * origpage __nosavedata;
+volatile static unsigned long * copypage __nosavedata;
+//volatile static int orig_min_free __nosavedata;
+#ifndef CONFIG_SMP
+//static unsigned long c_loops_per_jiffy_ref __nosavedata = 0;
+//static unsigned long cpu_khz_ref __nosavedata = 0;
+#endif
+
+extern void do_swsusp2_suspend_1(void);
+extern void do_swsusp2_suspend_2(void);
+extern void do_swsusp2_resume_1(void);
+extern void do_swsusp2_resume_2(void);
+extern struct pagedir __nosavedata pagedir_resume;
+
+/*
+ * FIXME: This function should really be written in assembly. Actually
+ * requirement is that it does not touch stack, because %esp will be
+ * wrong during resume before restore_processor_context(). Check
+ * assembly if you modify this.
+ */
+static inline void do_swsusp2_copyback(void)
+{
+#ifdef CONFIG_PREEMPT
+	/*
+	 * Preempt disabled in kernel we're about to restore.
+	 * Make sure we match state now.
+	 */
+	preempt_disable();
+	PRINTPREEMPTCOUNT("Prior to copying old kernel back.");
+#endif
+
+	state1 = swsusp_action;
+	state2 = swsusp_debug_state;
+	state3 = console_loglevel;
+
+#ifndef CONFIG_SMP
+	//c_loops_per_jiffy_ref = cpu_data->loops_per_jiffy;
+	//cpu_khz_ref = cpu_khz;
+#endif
+	
+	origrange = pagedir_resume.origranges.first;
+	copyrange = pagedir_resume.destranges.first;
+	origoffset = origrange->minimum;
+	copyoffset = copyrange->minimum;
+	origpage = (unsigned long *) (page_address(mem_map + origoffset));
+	copypage = (unsigned long *) (page_address(mem_map + copyoffset));
+	//orig_min_free = swsusp_min_free;
+
+	while (origrange) {
+		for (loop=0; loop < (PAGE_SIZE / sizeof(unsigned long)); loop++)
+			*(origpage + loop) = *(copypage + loop);
+		
+		if (origoffset < origrange->maximum) {
+			origoffset++;
+			origpage += (PAGE_SIZE / sizeof(unsigned long));
+		} else {
+			origrange = origrange->next;
+			if (origrange) {
+				origoffset = origrange->minimum;
+				origpage = (unsigned long *) (page_address(mem_map + origoffset));
+			}
+		}
+
+		if (copyoffset < copyrange->maximum) {
+			copyoffset++;
+			copypage += (PAGE_SIZE / sizeof(unsigned long));
+		} else {
+			copyrange = copyrange->next;
+			if (copyrange) {
+				copyoffset = copyrange->minimum;
+				copypage = (unsigned long *) (page_address(mem_map + copyoffset));
+			}
+		}
+	}
+	
+/* Ahah, we now run with our old stack, and with registers copied from
+   suspend time */
+
+#ifndef CONFIG_SMP
+	//cpu_data->loops_per_jiffy = c_loops_per_jiffy_ref;
+	//loops_per_jiffy = c_loops_per_jiffy_ref;
+	//cpu_khz = cpu_khz_ref;
+#endif
+	swsusp_action = state1;
+	swsusp_debug_state = state2;
+	console_loglevel = state3;
+	//swsusp_min_free = orig_min_free;
+}
+
+void do_swsusp_lowlevel(int resume)
+{
+	if (!resume) {
+		do_swsusp2_suspend_1();
+		/* call_processor_state() in x86 */
+		__asm__ __volatile__ (" bl save_processor_state");
+		/* saving stack */
+//		__asm__ __volatile__("sync");
+//		do_swsusp2_suspend_2();
+		return;
+	}
+
+	/* setup swapper_pg_dir in x86 */
+
+	do_swsusp2_resume_1();
+	do_swsusp2_copyback();
+	/* setup segment register */
+//	__asm__ __volatile__("sync");
+	restore_processor_state();
+	do_swsusp2_resume_2();
+}
+
+#if 0
+void flush_tlb_all(void)
+{
+	/* Flush all TLBs */
+	__asm__ __volatile__("lis 4, 0x1000");
+	__asm__ __volatile__("1: addic. 4,4,-0x1000");
+	__asm__ __volatile__("tlbie 4");
+	__asm__ __volatile__("blt 1b");
+	__asm__ __volatile__("sync");
+}
+#endif
Index: linux-2.6.1-suspend/include/asm-ppc/suspend.h
===================================================================
--- linux-2.6.1-suspend/include/asm-ppc/suspend.h	(revision 0)
+++ linux-2.6.1-suspend/include/asm-ppc/suspend.h	(revision 0)
@@ -0,0 +1,14 @@
+#ifndef _PPC_SUSPEND_H
+#define _PPC_SUSPEND_H
+
+static inline void flush_tlb_all(void)
+{
+	/* Flush all TLBs */
+	__asm__ __volatile__("lis 4, 0x1000");
+	__asm__ __volatile__("1: addic. 4,4,-0x1000");
+	__asm__ __volatile__("tlbie 4");
+	__asm__ __volatile__("blt 1b");
+	__asm__ __volatile__("sync");
+}
+
+#endif

--Multipart=_Thu__22_Jan_2004_21_17_46_+0800_sQT2q/a.HiRxm4be--
