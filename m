Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265952AbUA1MdA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 07:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUA1Mcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 07:32:50 -0500
Received: from [211.167.76.68] ([211.167.76.68]:32997 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265944AbUA1McT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 07:32:19 -0500
Date: Wed, 28 Jan 2004 20:22:17 +0800
From: Hugang <hugang@soulinfo.com>
To: ncunningham@users.sourceforge.net
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@ucw.cz>, Patrick Mochel <mochel@digitalimplant.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmdisk working on ppc (WAS: Help port swsusp to ppc)
Message-Id: <20040128202217.0a1f8222@localhost>
In-Reply-To: <1075156310.2072.1.camel@laptop-linux>
References: <20040119105237.62a43f65@localhost>
	<1074483354.10595.5.camel@gaston>
	<1074489645.2111.8.camel@laptop-linux>
	<1074490463.10595.16.camel@gaston>
	<1074534964.2505.6.camel@laptop-linux>
	<1074549790.10595.55.camel@gaston>
	<20040122211746.3ec1018c@localhost>
	<1074841973.974.217.camel@gaston>
	<20040123183030.02fd16d6@localhost>
	<1074912854.834.61.camel@gaston>
	<20040126181004.GB315@elf.ucw.cz>
	<1075154452.6191.91.camel@gaston>
	<1075156310.2072.1.camel@laptop-linux>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__28_Jan_2004_20_22_17_+0800_NF7ac/El17gTiSZB"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__28_Jan_2004_20_22_17_+0800_NF7ac/El17gTiSZB
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2004 11:31:50 +1300
Nigel Cunningham <ncunningham@users.sourceforge.net> wrote:

> Yes. That's why suspend2 doesn't free any memory at all by default,
> but gives the user the option of setting a maximum image size.

HaHa, Here is swsusp2 patch for ppc. Now it WORKS fine.

The code base for testing, any comments and testing are welcome.

-: Howto let it work.
 1: download clean 2.6.1 kernel.
 2: apply swusp2 2.6.1 patch.
 3: apply swsusp2 core patch.
 4: apply ppc_swsusp2_1.diff
 5: do make menuconfig
CONFIG_SOFTWARE_SUSPEND2=y
CONFIG_SOFTWARE_SUSPEND_DEBUG=y
CONFIG_SOFTWARE_SUSPEND_GZIP_COMPRESSION=y
CONFIG_SOFTWARE_SUSPEND_LZF_COMPRESSION=y
CONFIG_SOFTWARE_SUSPEND_SWAPWRITER=y
 6:add "resume2=swap:/dev/hda10" into yaboot.conf.
  "/dev/hda10" is your swap partition.
 7:do suspend.
  I using a sciprt to do it. or use suspend script from swsusp2.sf.net .
 8:you system will backed.

-: Plans. 
   I has created arch/ppc/power directory like i386 arch, and put power
    manger code in it.
 1: clean code.
 2: merge pmac sleep into.

thanks.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc

--Multipart=_Wed__28_Jan_2004_20_22_17_+0800_NF7ac/El17gTiSZB
Content-Type: text/plain;
 name="ppc_swsusp2_1.diff"
Content-Disposition: attachment;
 filename="ppc_swsusp2_1.diff"
Content-Transfer-Encoding: 7bit

Index: linux-2.6.1-suspend/kernel/power/swsusp2.c
===================================================================
--- linux-2.6.1-suspend/kernel/power/swsusp2.c	(revision 192)
+++ linux-2.6.1-suspend/kernel/power/swsusp2.c	(working copy)
@@ -54,7 +54,9 @@
 
 #include <linux/suspend-common.h>
 #include <linux/suspend-version-specific.h>
+#ifdef  CONFIG_X86
 #include <asm/i387.h> /* for kernel_fpu_end */
+#endif
 #ifdef	CONFIG_KDB
 #include <linux/kdb.h>
 #endif	/* CONFIG_KDB */
@@ -327,7 +329,9 @@
 	preempt_enable();
 #endif
 
+#ifdef CONFIG_X86
 	kernel_fpu_end();
+#endif
 
 	PRINTPREEMPTCOUNT("Prior to resuming drivers.");
 
@@ -486,10 +490,10 @@
 #endif
 
 	PRINTPREEMPTCOUNT("In resume_2 after copy back.");
-
+#ifdef CONFIG_X86
 	kernel_fpu_end();
-
 	PRINTPREEMPTCOUNT("In resume_2 after fpu end.");
+#endif
 	
 #ifdef CONFIG_PREEMPT
 	preempt_enable();
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
Index: linux-2.6.1-suspend/arch/ppc/power/swsusp2-copyback.S
===================================================================
--- linux-2.6.1-suspend/arch/ppc/power/swsusp2-copyback.S	(revision 0)
+++ linux-2.6.1-suspend/arch/ppc/power/swsusp2-copyback.S	(revision 0)
@@ -0,0 +1,73 @@
+#define PAGE_TO_POINTER(in, out, p)	\
+	lwz out,0(in)					  ; \
+	slwi r9,out,2					  ; \
+	add r9,r9,out					  ; \
+	slwi r9,r9,3					  ; \
+	mullw r9,r9,r4					  ; \
+	slwi r9,r9,9					  ; \
+	addis p,r9,0xc000				  ; \
+	tophys(p,p)
+
+	.section ".text"
+swsusp2_copyback:
+	lis r20,pagedir_resume@ha	/* can't ture this is right FIXME */
+	addi r20,r20,pagedir_resume@l
+	tophys(r20,r20)
+#if 0
+	lwz	r4,4(r20)
+	twi	31,r0,0	/* triger trap */
+#endif	
+	lis r4,0xcccc /* FIXME */
+	ori r4,r4,52429
+
+	lwz r6,12(r20)		/* r6 is origranges.first */
+	cmpwi r6,0
+	beq- swsusp2_end_copyback
+		
+	tophys(r6,r6)
+	PAGE_TO_POINTER(r6,r8,r10)				  
+
+	lwz r5,56(r20)		/* r5 is copyranges.first */
+	tophys(r5,r5)
+	PAGE_TO_POINTER(r5,r7,r11) 
+	
+swsusp2_copy_one_page:
+	li r0,1024		/* r9 is loop */
+	mtctr r0		/* prepare for branch */
+	li r9,0
+swsusp2_copy_data:
+	lwzx r0,r9,r11
+	stwx r0,r9,r10
+	addi r9,r9,4
+
+	bdnz swsusp2_copy_data
+
+	lwz r0,4(r6)					  /* r0 is maximum */
+	cmplw r8,r0
+	bge- next_orig
+	addi r8,r8,1
+	addi r10,r10,4096
+	b end_orig
+next_orig:
+	lwz r6,8(r6)	/* r6 origrange */
+	cmpwi r6,0
+	beq- end_orig
+	tophys(r6,r6)
+	PAGE_TO_POINTER(r6,r8,r10)
+end_orig:
+	lwz r0,4(r5)					  /* r0 is maximum */
+	cmplw r7,r0
+	bge- next_copy
+	addi r7,r7,1
+	addi r11,r11,4096
+	b end_copy
+next_copy:
+	lwz r5,8(r5)	/* r5 is copypage */
+	cmpwi r5,0
+	beq- end_copy
+	tophys(r5,r5)
+	PAGE_TO_POINTER(r5,r7,r11)
+end_copy:
+	cmpwi 0,r6,0
+	bc r4,r2,swsusp2_copy_one_page
+swsusp2_end_copyback:
Index: linux-2.6.1-suspend/arch/ppc/power/swsusp2-asm.S
===================================================================
--- linux-2.6.1-suspend/arch/ppc/power/swsusp2-asm.S	(revision 0)
+++ linux-2.6.1-suspend/arch/ppc/power/swsusp2-asm.S	(revision 0)
@@ -0,0 +1,51 @@
+/*
+ * This code base on pmdisk.S by Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * changed for swsusp2 by Hu Gang <hugang@soulinfo.com>
+ */
+#include <linux/config.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/ppc_asm.h>
+#include <asm/cputable.h>
+#include <asm/cache.h>
+#include <asm/thread_info.h>
+#include <asm/offsets.h>
+#include "cpu_reg.S"
+
+	CPU_REG_MEM_DEFINE
+
+	.section .text
+	.align 5
+_GLOBAL(do_swsusp_lowlevel)
+	CPU_REG_STACK_SAVE
+	cmpwi	0,r3,0
+	bne	do_resume
+	bl	save_processor_state
+	bl	do_swsusp2_suspend_1
+	CPU_REG_MEM_SAVE
+	bl	do_swsusp2_suspend_2
+	CPU_REG_MEM_RESTORE_END
+	CPU_REG_STACK_RESTORE
+	
+do_resume:
+	bl save_processor_state
+	bl do_swsusp2_resume_1
+
+	/* Stop pending alitvec streams and memory accesses */
+BEGIN_FTR_SECTION
+	DSSALL
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+ 	sync
+
+	CPU_REG_MEM_DISABLE_MMU 
+#include "swsusp2-copyback.S"
+	CPU_REG_MEM_FLUSH_CACHE
+	
+	CPU_REG_MEM_RESTORE
+	bl	do_swsusp2_resume_2
+	bl	restore_processor_state
+	CPU_REG_MEM_RESTORE_END
+	CPU_REG_STACK_RESTORE
+
+	CPU_REG_TURN_ON_MMU
\ No newline at end of file
Index: linux-2.6.1-suspend/arch/ppc/power/cpu_reg.S
===================================================================
--- linux-2.6.1-suspend/arch/ppc/power/cpu_reg.S	(revision 0)
+++ linux-2.6.1-suspend/arch/ppc/power/cpu_reg.S	(revision 0)
@@ -0,0 +1,325 @@
+/*
+ * This code base on pmdisk.S by Benjamin Herrenschmidt <benh@kernel.crashing.org>
+ *
+ * changed for swsusp2 by Hu Gang <hugang@soulinfo.com>
+ */
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/offsets.h>
+
+/*
+ * Structure for storing CPU registers on the save area.
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
+#define SL_LR		0x70
+#define SL_R12		0x74	/* r12 to r31 */
+#define SL_SIZE		(SL_R12 + 80)
+
+#define CPU_REG_MEM_DEFINE \
+	.section .data					  ; \
+	.align	5					  ; \
+\
+_GLOBAL(cpu_reg_save_area)				  ; \
+	.space	SL_SIZE	
+	
+#define CPU_REG_MEM_SAVE \
+	lis	r11,cpu_reg_save_area@h;\
+	ori	r11,r11,cpu_reg_save_area@l;\
+;\
+	mflr	r0					  ; \
+	stw	r0,SL_LR(r11);\
+	mfcr	r0;\
+	stw	r0,SL_CR(r11);\
+	stw	r1,SL_SP(r11);\
+	stw	r2,SL_R2(r11);\
+	stmw	r12,SL_R12(r11);\
+;\
+	/* Save MSR & SDR1 */;\
+	mfmsr	r4;\
+	stw	r4,SL_MSR(r11);\
+	mfsdr1	r4;\
+	stw	r4,SL_SDR1(r11);\
+;\
+	/* Get a stable timebase and save it */;\
+1:	mftbu	r4;\
+	stw	r4,SL_TB(r11);\
+	mftb	r5;\
+	stw	r5,SL_TB+4(r11);\
+	mftbu	r3;\
+	cmpw	r3,r4;\
+	bne	1b;\
+;\
+	/* Save SPRGs */;\
+	mfsprg	r4,0;\
+	stw	r4,SL_SPRG0(r11);\
+	mfsprg	r4,1;\
+	stw	r4,SL_SPRG0+4(r11);\
+	mfsprg	r4,2;\
+	stw	r4,SL_SPRG0+8(r11);\
+	mfsprg	r4,3;\
+	stw	r4,SL_SPRG0+12(r11);\
+;\
+	/* Save BATs */;\
+	mfdbatu	r4,0;\
+	stw	r4,SL_DBAT0(r11);\
+	mfdbatl	r4,0;\
+	stw	r4,SL_DBAT0+4(r11);\
+	mfdbatu	r4,1;\
+	stw	r4,SL_DBAT1(r11);\
+	mfdbatl	r4,1;\
+	stw	r4,SL_DBAT1+4(r11);\
+	mfdbatu	r4,2;\
+	stw	r4,SL_DBAT2(r11);\
+	mfdbatl	r4,2;\
+	stw	r4,SL_DBAT2+4(r11);\
+	mfdbatu	r4,3;\
+	stw	r4,SL_DBAT3(r11);\
+	mfdbatl	r4,3;\
+	stw	r4,SL_DBAT3+4(r11);\
+	mfibatu	r4,0;\
+	stw	r4,SL_IBAT0(r11);\
+	mfibatl	r4,0;\
+	stw	r4,SL_IBAT0+4(r11);\
+	mfibatu	r4,1;\
+	stw	r4,SL_IBAT1(r11);\
+	mfibatl	r4,1;\
+	stw	r4,SL_IBAT1+4(r11);\
+	mfibatu	r4,2;\
+	stw	r4,SL_IBAT2(r11);\
+	mfibatl	r4,2;\
+	stw	r4,SL_IBAT2+4(r11);\
+	mfibatu	r4,3;\
+	stw	r4,SL_IBAT3(r11);\
+	mfibatl	r4,3;\
+	stw	r4,SL_IBAT3+4(r11);\
+	/* Backup various CPU config stuffs */;\
+	/* bl	__save_cpu_setup; */
+
+#define CPU_REG_MEM_DISABLE_MMU \
+	/* Disable MSR:DR to make sure we don't take a TLB or	;\
+	 * hash miss during the copy, as our hash table will	;\
+	 * for a while be unuseable. For .text, we assume we are;\
+	 * covered by a BAT. This works only for non-G5 at this	;\
+	 * point. G5 will need a better approach, possibly using;\
+	 * a small temporary hash table filled with large mappings,;\
+	 * disabling the MMU completely isn't a good option for	;\
+	 * performance reasons.	;\
+	 * (Note that 750's may have the same performance issue as;\
+	 * the G5 in this case, we should investigate using moving;\
+	 * BATs for these CPUs);\
+	 */;\
+	mfmsr	r0	;\
+	sync	;\
+	rlwinm	r0,r0,0,28,26		/* clear MSR_DR */ ;\
+	mtmsr	r0 ;\
+	sync ;\
+	isync
+
+#define CPU_REG_MEM_FLUSH_CACHE \
+	/* Do a very simple cache flush/inval of the L1 to ensure \
+	 * coherency of the icache \
+	 */ \
+	lis	r3,0x0002 ;\
+	mtctr	r3 ;\
+	li	r3, 0 ;\
+1: ;\
+	lwz	r0,0(r3) ;\
+	addi	r3,r3,0x0020 ;\
+	bdnz	1b ;\
+	isync ;\
+	sync ;\
+;\
+	/* Now flush those cache lines */ ;\
+	lis	r3,0x0002 ;\
+	mtctr	r3 ;\
+	li	r3, 0 ;\
+1:;\
+	dcbf	0,r3 ;\
+	addi	r3,r3,0x0020 ;\
+	bdnz	1b
+
+#define CPU_REG_MEM_RESTORE \
+/* Ok, we are now running with the kernel data of the old;\
+	 * kernel fully restored. We can get to the save area;\
+	 * easily now. As for the rest of the code, it assumes the;\
+	 * loader kernel and the booted one are exactly identical;\
+	 */;\
+	lis	r11,cpu_reg_save_area@h;\
+	ori	r11,r11,cpu_reg_save_area@l;\
+	tophys(r11,r11);\
+	/* Restore various CPU config stuffs */;\
+	/* bl	__restore_cpu_setup; */\
+	/* Restore the BATs, and SDR1.  Then we can turn on the MMU. ;\
+	 * This is a bit hairy as we are running out of those BATs,;\
+	 * but first, our code is probably in the icache, and we are;\
+	 * writing the same value to the BAT, so that should be fine,;\
+	 * though a better solution will have to be found long-term;\
+	 */;\
+	lwz	r4,SL_SDR1(r11);\
+	mtsdr1	r4;\
+	lwz	r4,SL_SPRG0(r11);\
+	mtsprg	0,r4;\
+	lwz	r4,SL_SPRG0+4(r11);\
+	mtsprg	1,r4;\
+	lwz	r4,SL_SPRG0+8(r11);\
+	mtsprg	2,r4;\
+	lwz	r4,SL_SPRG0+12(r11);\
+	mtsprg	3,r4;\
+;\
+/*	lwz	r4,SL_DBAT0(r11);\
+	mtdbatu	0,r4;\
+	lwz	r4,SL_DBAT0+4(r11);\
+	mtdbatl	0,r4;\
+	lwz	r4,SL_DBAT1(r11);\
+	mtdbatu	1,r4;\
+	lwz	r4,SL_DBAT1+4(r11);\
+	mtdbatl	1,r4;\
+	lwz	r4,SL_DBAT2(r11);\
+	mtdbatu	2,r4;\
+	lwz	r4,SL_DBAT2+4(r11);\
+	mtdbatl	2,r4;\
+	lwz	r4,SL_DBAT3(r11);\
+	mtdbatu	3,r4;\
+	lwz	r4,SL_DBAT3+4(r11);\
+	mtdbatl	3,r4;\
+	lwz	r4,SL_IBAT0(r11);\
+	mtibatu	0,r4;\
+	lwz	r4,SL_IBAT0+4(r11);\
+	mtibatl	0,r4;\
+	lwz	r4,SL_IBAT1(r11);\
+	mtibatu	1,r4;\
+	lwz	r4,SL_IBAT1+4(r11);\
+	mtibatl	1,r4;\
+	lwz	r4,SL_IBAT2(r11);\
+	mtibatu	2,r4;\
+	lwz	r4,SL_IBAT2+4(r11);\
+	mtibatl	2,r4;\
+	lwz	r4,SL_IBAT3(r11);\
+	mtibatu	3,r4;\
+	lwz	r4,SL_IBAT3+4(r11);\
+	mtibatl	3,r4;\
+; */ \
+BEGIN_FTR_SECTION;\
+	li	r4,0;\
+	mtspr	SPRN_DBAT4U,r4;\
+	mtspr	SPRN_DBAT4L,r4;\
+	mtspr	SPRN_DBAT5U,r4;\
+	mtspr	SPRN_DBAT5L,r4;\
+	mtspr	SPRN_DBAT6U,r4;\
+	mtspr	SPRN_DBAT6L,r4;\
+	mtspr	SPRN_DBAT7U,r4;\
+	mtspr	SPRN_DBAT7L,r4;\
+	mtspr	SPRN_IBAT4U,r4;\
+	mtspr	SPRN_IBAT4L,r4;\
+	mtspr	SPRN_IBAT5U,r4;\
+	mtspr	SPRN_IBAT5L,r4;\
+	mtspr	SPRN_IBAT6U,r4;\
+	mtspr	SPRN_IBAT6L,r4;\
+	mtspr	SPRN_IBAT7U,r4;\
+	mtspr	SPRN_IBAT7L,r4;\
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS);\
+;\
+	/* Flush all TLBs */;\
+	lis	r4,0x1000;\
+1:	addic.	r4,r4,-0x1000;\
+	tlbie	r4;\
+	blt	1b;\
+	sync;\
+;\
+	/* restore the MSR and turn on the MMU */;\
+	lwz	r3,SL_MSR(r11);\
+	bl	turn_on_mmu;\
+	tovirt(r11,r11);\
+;\
+	/* Restore TB */;\
+	li	r3,0;\
+	mttbl	r3;\
+	lwz	r3,SL_TB(r11);\
+	lwz	r4,SL_TB+4(r11);\
+	mttbu	r3;\
+	mttbl	r4;\
+; \
+	lwz	r0,SL_CR(r11);\
+	mtcr	r0;\
+	lwz	r2,SL_R2(r11);\
+	lmw	r12,SL_R12(r11);\
+	lwz	r1,SL_SP(r11);\
+	lwz	r4,SL_LR(r11)
+
+#define CPU_REG_MEM_RESTORE_END \
+	/* Restore LR from the save area */		  ; \
+	lis	r11,cpu_reg_save_area@h			  ; \
+	ori	r11,r11,cpu_reg_save_area@l		  ; \
+	lwz	r0,SL_CR(r11)				  ; \
+	mtcr r0					  ; \
+	lwz	r2,SL_R2(r11)				  ; \
+	lmw	r12,SL_R12(r11)				  ; \
+	lwz	r1,SL_SP(r11)
+
+#define CPU_REG_TURN_ON_MMU \
+/* FIXME:This construct is actually not useful since we don't shut ; \
+ * down the instruction MMU, we could just flip back MSR-DR on.	; \
+ */							  ; \
+turn_on_mmu:						  ; \
+	mflr	r4					  ; \
+	mtsrr0	r4					  ; \
+	mtsrr1	r3					  ; \
+	sync						  ; \
+	isync						  ; \
+	rfi
+
+#define CPU_REG_STACK_SAVE \
+	mflr	r0					  ; \
+	stw	r0,4(r1)				  ; \
+	stwu	r1,-SL_SIZE(r1)				  ; \
+	mfcr	r0					  ; \
+	stw	r0,SL_CR(r1)				  ; \
+	stw	r2,SL_R2(r1)				  ; \
+	stmw	r12,SL_R12(r1)				  ; \
+	/* Save SPRGs */				  ; \
+	mfsprg	r4,0					  ; \
+	stw	r4,SL_SPRG0(r1)				  ; \
+	mfsprg	r4,1					  ; \
+	stw	r4,SL_SPRG0+4(r1)			  ; \
+	mfsprg	r4,2					  ; \
+	stw	r4,SL_SPRG0+8(r1)			  ; \
+	mfsprg	r4,3					  ; \
+	stw	r4,SL_SPRG0+12(r1)	
+
+#define CPU_REG_STACK_RESTORE \
+	lwz	r4,SL_SPRG0(r1)				  ; \
+	mtsprg	0,r4					  ; \
+	lwz	r4,SL_SPRG0+4(r1)			  ; \
+	mtsprg	1,r4					  ; \
+	lwz	r4,SL_SPRG0+8(r1)			  ; \
+	mtsprg	2,r4					  ; \
+	lwz	r4,SL_SPRG0+12(r1)			  ; \
+	mtsprg	3,r4					  ; \
+	lwz	r0,SL_CR(r1)				  ; \
+	mtcr	r0					  ; \
+	lwz	r2,SL_R2(r1)				  ; \
+	lmw	r12,SL_R12(r1)				  ; \
+	addi	r1,r1,SL_SIZE				  ; \
+	lwz	r0,4(r1)				  ; \
+	mtlr	r0					  ; \
+	blr
Index: linux-2.6.1-suspend/arch/ppc/power/swsusp2.c
===================================================================
--- linux-2.6.1-suspend/arch/ppc/power/swsusp2.c	(revision 0)
+++ linux-2.6.1-suspend/arch/ppc/power/swsusp2.c	(revision 0)
@@ -0,0 +1,170 @@
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
+#if 0
+/* Local variables for do_swsusp2_suspend */
+volatile static int state1 __nosavedata = 0;
+volatile static int state2 __nosavedata = 0;
+volatile static int state3 __nosavedata = 0;
+volatile static int loop __nosavedata = 0;
+volatile static struct range *origrange __nosavedata;
+volatile static struct range *copyrange __nosavedata;
+volatile static int origoffset __nosavedata;
+volatile static int copyoffset __nosavedata;
+volatile static unsigned long * origpage __nosavedata;
+volatile static unsigned long * copypage __nosavedata;
+#endif
+
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
+#if 0
+static inline void pre_copyback(void)
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
+}
+static inline void post_copyback(void)
+{
+#ifndef CONFIG_SMP
+	//cpu_data->loops_per_jiffy = c_loops_per_jiffy_ref;
+	//loops_per_jiffy = c_loops_per_jiffy_ref;
+	//cpu_khz = cpu_khz_ref;
+#endif
+	swsusp_action = state1;
+	swsusp_debug_state = state2;
+	console_loglevel = state3;
+	//swsusp_min_free = orig_min_free;
+
+}
+#endif
+static inline void do_swsusp2_copyback(void)
+{
+	/* PowerPC has a lots register, use local register is possible */
+	register int origoffset, copyoffset;
+	register unsigned long * origpage, * copypage;
+	register struct range *origrange, *copyrange;
+//	register int pagesize;
+
+//	pre_copyback();
+
+	origrange = pagedir_resume.origranges.first;
+//	pagesize = pagedir_resume.pageset_size;
+//	printk("%d\n", pagesize);
+	origoffset = origrange->minimum;
+	origpage = (unsigned long *) (page_address(mem_map + origoffset));
+	
+	copyrange = pagedir_resume.destranges.first;
+	copyoffset = copyrange->minimum;
+	copypage = (unsigned long *) (page_address(mem_map + copyoffset));
+	//orig_min_free = swsusp_min_free;
+
+	while (origrange) {
+		register int loop;
+		for (loop = 0; loop < (PAGE_SIZE / sizeof(unsigned long)); loop++)
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
+//	post_copyback();
+}
+
+void do_swsusp_lowlevel(int resume)
+{
+	if (!resume) {
+		do_swsusp2_suspend_1();
+		save_processor_state();
+		/* saving stack */
+		
+		do_swsusp2_suspend_2();
+		return;
+	}
+
+	/* setup swapper_pg_dir in x86 */
+
+	do_swsusp2_resume_1();
+	do_swsusp2_copyback();
+	/* setup segment register */
+	restore_processor_state();
+	do_swsusp2_resume_2();
+}
Index: linux-2.6.1-suspend/arch/ppc/power/cpu.c
===================================================================
--- linux-2.6.1-suspend/arch/ppc/power/cpu.c	(revision 0)
+++ linux-2.6.1-suspend/arch/ppc/power/cpu.c	(revision 0)
@@ -0,0 +1,72 @@
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/tty.h>
+#include <linux/string.h>
+#include <linux/pci.h>
+#include <linux/adb.h>
+#include <linux/cuda.h>
+#include <linux/pmu.h>
+#include <linux/irq.h>
+#include <linux/root_dev.h>
+#include <linux/suspend.h>
+#include <linux/delay.h>
+
+#include <asm/mmu_context.h>
+
+extern void enable_kernel_altivec(void);
+
+static inline void do_pmu_suspend(void)
+{
+	printk("suspend pmu\n");	
+	pmu_suspend();
+	printk(".\n");
+}
+
+static inline void do_pmu_resume(void)
+{
+	struct adb_request req;
+	printk("resume pmu\n");	
+	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
+	pmu_wait_complete(&req);
+	
+	/* Resume PMU event interrupts */
+	pmu_resume();	
+	printk(".\n");
+}
+
+void save_processor_state(void)
+{
+	printk("save processor state\n");
+	pmu_suspend();
+	printk(".\n");
+	printk("current is 0x%x\n", current);
+	mdelay(1000);
+}
+
+void restore_processor_state(void)
+{
+	printk("current is 0x%x\n", current);
+	mdelay(1000);
+	printk("seting context\n");
+	/* Restore userland MMU context */
+	set_context(current->active_mm->context, current->active_mm->pgd);
+
+	printk("do pmu resume\n");
+	do_pmu_resume();
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+		enable_kernel_altivec();
+#endif
+	printk("enable kernel fp\n");
+	enable_kernel_fp();
+	printk(".\n");
+}
+
+EXPORT_SYMBOL(save_processor_state);
+EXPORT_SYMBOL(restore_processor_state);
Index: linux-2.6.1-suspend/arch/ppc/power/Makefile
===================================================================
--- linux-2.6.1-suspend/arch/ppc/power/Makefile	(revision 0)
+++ linux-2.6.1-suspend/arch/ppc/power/Makefile	(revision 0)
@@ -0,0 +1,2 @@
+obj-$(CONFIG_PM) += cpu.o
+obj-$(CONFIG_SOFTWARE_SUSPEND2) += swsusp2-asm.o

--Multipart=_Wed__28_Jan_2004_20_22_17_+0800_NF7ac/El17gTiSZB
Content-Type: application/octet-stream;
 name="suspend"
Content-Disposition: attachment;
 filename="suspend"
Content-Transfer-Encoding: base64

IyEvYmluL3NoCgpjaHZ0IDEKc3dhcG9uIC1hCnN5bmMKc3luYwojaHdjbG9jayAtLXN5c3RvaGMK
L2V0Yy9pbml0LmQvY2ZzZCBzdG9wCi9ldGMvaW5pdC5kL2F1bWl4IHN0b3AKL2V0Yy9pbml0LmQv
bmV0d29ya2luZyBzdG9wCgpmb3IgaSBpbiBgbHNtb2QgfCBhd2sgJ3twcmludCAkMX0nYApkbwoJ
cm1tb2QgJGkKZG9uZQpmb3IgaSBpbiBgbHNtb2QgfCBhd2sgJ3twcmludCAkMX0nYApkbwoJcm1t
b2QgJGkKZG9uZQoKbW91bnQgLXQgcHJvYyBub25lIC9wcm9jCm1vdW50IC9zeXMKCmVjaG8gLW4g
ImRpc2siID4gL3N5cy9wb3dlci9zdGF0ZQplY2hvIC1uICI2IiA+IC9wcm9jL3N3c3VzcC9kZWZh
dWx0X2NvbnNvbGVfbGV2ZWwKZWNobyAtbiAiMSIgPiAvcHJvYy9zd3N1c3Avc2xvdwplY2hvIC1u
ICIxIiA+IC9wcm9jL3N3c3VzcC9yZWJvb3QKZWNobyAtbiAiMSIgPiAvcHJvYy9zd3N1c3AvZGVi
dWdfc2VjdGlvbnMKZWNobyAtbiAiMSIgPiAvcHJvYy9zd3N1c3AvYWN0aXZhdGUKCmZvciBpIGlu
IGBncmVwIC12IF4jIC9ldGMvbW9kdWxlc2AKZG8KCW1vZHByb2JlICRpCmRvbmUKCi9ldGMvaW5p
dC5kL25ldHdvcmtpbmcgc3RhcnQKL2V0Yy9pbml0LmQvY2ZzZCBzdGFydAovZXRjL2luaXQuZC9h
dW1peCBzdGFydAojaHdjbG9jayAtLWhjdG9zeXMK

--Multipart=_Wed__28_Jan_2004_20_22_17_+0800_NF7ac/El17gTiSZB--
