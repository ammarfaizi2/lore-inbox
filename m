Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVCOBMx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVCOBMx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 20:12:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVCOBMx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 20:12:53 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:31398 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262152AbVCOBI3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 20:08:29 -0500
Date: Tue, 15 Mar 2005 02:07:01 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, rjw@sisk.pl,
       hugang@soulinfo.com
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: [swsusp/ppc] Re: What's going on here ?
Message-ID: <20050315010700.GA1357@elf.ucw.cz>
References: <1110847432.5863.57.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1110847432.5863.57.camel@gaston>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Hi just see that the whole stack of pmac SWSUSP patches went in, without
> any notice nor CC nor anything from any of the PPC maintainers ! That is
> a bit annoying don't you think ?
> 
> Paulus and I wrote most of those patches, granted, and they've been
> hanging around for some time, but I had good reasons not to submit them
> in their current state.
> 
> And regardless, I'm pretty pissed off by the fact that such invasive
> changes to the architecture and the platform support were submitted and
> merged without any notice nor ack from any of the arch or platform
> maintainers (basically paulus and me).

Sorry, that's probably my fault.

rjw and hugang did (pretty neccessary) changes to base swsusp (pagedir
table -> pagedir linklist), that unfortunately needed update to all
the assembly parts. It was series 1/3 update core, i386 and x86-64,
2/3 update ppc, 3/3 introduce initramfs.

This is the offending patch I believe (but the version that was merged
was From: me, without code changes).

I realized that patch does more than changing from table to linklist,
but it looked mostly okay, so I forwarded it. Sorry.

So, what to do now?

a) just revert it

or

b) revert pmac_setup.c and via-pmu parts and Kconfig part

or

c) just disable Kconfig part and fix it up with incremental patches

?
								Pavel


From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@zip.com.au>
Subject: [PATCH][3/3] swsusp: use non-contiguous memory
Cc: Hu Gang <hugang@soulinfo.com>,
	LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
Lines: 686

From: Hu Gang <hugang@soulinfo.com>

Subject: swsusp: use non-contiguous memory on resume - ppc support

This patch contains the architecture-dependent changes for ppc
required for using a linklist instead of an array of page backup entries
during resume.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

diff -Nru linux-2.6.11-a/arch/ppc/Kconfig linux-2.6.11-b/arch/ppc/Kconfig
--- linux-2.6.11-a/arch/ppc/Kconfig	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11-b/arch/ppc/Kconfig	2005-03-04 18:42:16.000000000 +0100
@@ -1046,6 +1046,8 @@
 
 source "drivers/zorro/Kconfig"
 
+source kernel/power/Kconfig
+
 endmenu
 
 menu "Bus options"
diff -Nru linux-2.6.11-a/arch/ppc/kernel/asm-offsets.c linux-2.6.11-b/arch/ppc/kernel/asm-offsets.c
--- linux-2.6.11-a/arch/ppc/kernel/asm-offsets.c	2005-03-02 08:38:09.000000000 +0100
+++ linux-2.6.11-b/arch/ppc/kernel/asm-offsets.c	2005-03-04 18:42:16.000000000 +0100
@@ -16,6 +16,7 @@
 #include <linux/string.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
+#include <linux/suspend.h>
 #include <linux/mman.h>
 #include <linux/mm.h>
 #include <asm/io.h>
@@ -136,6 +137,10 @@
 	DEFINE(TI_CPU, offsetof(struct thread_info, cpu));
 	DEFINE(TI_PREEMPT, offsetof(struct thread_info, preempt_count));
 
+	DEFINE(pbe_address, offsetof(struct pbe, address));
+	DEFINE(pbe_orig_address, offsetof(struct pbe, orig_address));
+	DEFINE(pbe_next, offsetof(struct pbe, next));
+
 	DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28);
 	return 0;
 }
diff -Nru linux-2.6.11-a/arch/ppc/kernel/Makefile linux-2.6.11-b/arch/ppc/kernel/Makefile
--- linux-2.6.11-a/arch/ppc/kernel/Makefile	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11-b/arch/ppc/kernel/Makefile	2005-03-04 18:42:16.000000000 +0100
@@ -16,6 +16,7 @@
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o perfmon.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
diff -Nru linux-2.6.11-a/arch/ppc/kernel/signal.c linux-2.6.11-b/arch/ppc/kernel/signal.c
--- linux-2.6.11-a/arch/ppc/kernel/signal.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6.11-b/arch/ppc/kernel/signal.c	2005-03-04 18:42:16.000000000 +0100
@@ -28,6 +28,7 @@
 #include <linux/elf.h>
 #include <linux/tty.h>
 #include <linux/binfmts.h>
+#include <linux/suspend.h>
 #include <asm/ucontext.h>
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>
@@ -704,6 +705,14 @@
 	unsigned long frame, newsp;
 	int signr, ret;
 
+	if (current->flags & PF_FREEZE) {
+		refrigerator(PF_FREEZE);
+		signr = 0;
+		ret = regs->gpr[3];
+		if (!signal_pending(current))
+			goto no_signal;
+	}
+
 	if (!oldset)
 		oldset = &current->blocked;
 
@@ -726,6 +735,7 @@
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
 		} else {
+no_signal:
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
 			regs->trap = 0;
diff -Nru linux-2.6.11-a/arch/ppc/kernel/swsusp.S linux-2.6.11-b/arch/ppc/kernel/swsusp.S
--- linux-2.6.11-a/arch/ppc/kernel/swsusp.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-b/arch/ppc/kernel/swsusp.S	2005-03-04 18:42:16.000000000 +0100
@@ -0,0 +1,349 @@
+#include <linux/config.h>
+#include <linux/threads.h>
+#include <asm/processor.h>
+#include <asm/page.h>
+#include <asm/cputable.h>
+#include <asm/thread_info.h>
+#include <asm/ppc_asm.h>
+#include <asm/offsets.h>
+
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
+	.section .data
+	.align	5
+
+_GLOBAL(swsusp_save_area)
+	.space	SL_SIZE
+
+
+	.section .text
+	.align	5
+
+_GLOBAL(swsusp_arch_suspend)
+
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
+
+	mflr	r0
+	stw	r0,SL_LR(r11)
+	mfcr	r0
+	stw	r0,SL_CR(r11)
+	stw	r1,SL_SP(r11)
+	stw	r2,SL_R2(r11)
+	stmw	r12,SL_R12(r11)
+
+	/* Save MSR & SDR1 */
+	mfmsr	r4
+	stw	r4,SL_MSR(r11)
+	mfsdr1	r4
+	stw	r4,SL_SDR1(r11)
+
+	/* Get a stable timebase and save it */
+1:	mftbu	r4
+	stw	r4,SL_TB(r11)
+	mftb	r5
+	stw	r5,SL_TB+4(r11)
+	mftbu	r3
+	cmpw	r3,r4
+	bne	1b
+
+	/* Save SPRGs */
+	mfsprg	r4,0
+	stw	r4,SL_SPRG0(r11)
+	mfsprg	r4,1
+	stw	r4,SL_SPRG0+4(r11)
+	mfsprg	r4,2
+	stw	r4,SL_SPRG0+8(r11)
+	mfsprg	r4,3
+	stw	r4,SL_SPRG0+12(r11)
+
+	/* Save BATs */
+	mfdbatu	r4,0
+	stw	r4,SL_DBAT0(r11)
+	mfdbatl	r4,0
+	stw	r4,SL_DBAT0+4(r11)
+	mfdbatu	r4,1
+	stw	r4,SL_DBAT1(r11)
+	mfdbatl	r4,1
+	stw	r4,SL_DBAT1+4(r11)
+	mfdbatu	r4,2
+	stw	r4,SL_DBAT2(r11)
+	mfdbatl	r4,2
+	stw	r4,SL_DBAT2+4(r11)
+	mfdbatu	r4,3
+	stw	r4,SL_DBAT3(r11)
+	mfdbatl	r4,3
+	stw	r4,SL_DBAT3+4(r11)
+	mfibatu	r4,0
+	stw	r4,SL_IBAT0(r11)
+	mfibatl	r4,0
+	stw	r4,SL_IBAT0+4(r11)
+	mfibatu	r4,1
+	stw	r4,SL_IBAT1(r11)
+	mfibatl	r4,1
+	stw	r4,SL_IBAT1+4(r11)
+	mfibatu	r4,2
+	stw	r4,SL_IBAT2(r11)
+	mfibatl	r4,2
+	stw	r4,SL_IBAT2+4(r11)
+	mfibatu	r4,3
+	stw	r4,SL_IBAT3(r11)
+	mfibatl	r4,3
+	stw	r4,SL_IBAT3+4(r11)
+
+#if  0
+	/* Backup various CPU config stuffs */
+	bl	__save_cpu_setup
+#endif
+	/* Call the low level suspend stuff (we should probably have made
+	 * a stackframe...
+	 */
+	bl	swsusp_save
+
+	/* Restore LR from the save area */
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
+	lwz	r0,SL_LR(r11)
+	mtlr	r0
+
+	blr
+
+
+/* Resume code */
+_GLOBAL(swsusp_arch_resume)
+
+	/* Stop pending alitvec streams and memory accesses */
+BEGIN_FTR_SECTION
+	DSSALL
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+ 	sync
+
+	/* Disable MSR:DR to make sure we don't take a TLB or
+	 * hash miss during the copy, as our hash table will
+	 * for a while be unuseable. For .text, we assume we are
+	 * covered by a BAT. This works only for non-G5 at this
+	 * point. G5 will need a better approach, possibly using
+	 * a small temporary hash table filled with large mappings,
+	 * disabling the MMU completely isn't a good option for
+	 * performance reasons.
+	 * (Note that 750's may have the same performance issue as
+	 * the G5 in this case, we should investigate using moving
+	 * BATs for these CPUs)
+	 */
+	mfmsr	r0
+	sync
+	rlwinm	r0,r0,0,28,26		/* clear MSR_DR */
+	mtmsr	r0
+	sync
+	isync
+
+	/* Load ptr the list of pages to copy in r3 */
+	lis	r11,(pagedir_nosave - KERNELBASE)@h
+	ori	r11,r11,pagedir_nosave@l
+	lwz	r10,0(r11)
+
+	/* Copy the pages. This is a very basic implementation, to
+	 * be replaced by something more cache efficient */
+1:
+	tophys(r3,r10)
+	li	r0,256
+	mtctr	r0
+	lwz	r11,pbe_address(r3)	/* source */
+	tophys(r5,r11)
+	lwz	r10,pbe_orig_address(r3)	/* destination */
+	tophys(r6,r10)
+2:
+	lwz	r8,0(r5)
+	lwz	r9,4(r5)
+	lwz	r10,8(r5)
+	lwz	r11,12(r5)
+	addi	r5,r5,16
+	stw	r8,0(r6)
+	stw	r9,4(r6)
+	stw	r10,8(r6)
+	stw	r11,12(r6)
+	addi	r6,r6,16
+	bdnz	2b
+	lwz		r10,pbe_next(r3)
+	cmpwi	0,r10,0
+	bne	1b
+
+	/* Do a very simple cache flush/inval of the L1 to ensure
+	 * coherency of the icache
+	 */
+	lis	r3,0x0002
+	mtctr	r3
+	li	r3, 0
+1:
+	lwz	r0,0(r3)
+	addi	r3,r3,0x0020
+	bdnz	1b
+	isync
+	sync
+
+	/* Now flush those cache lines */
+	lis	r3,0x0002
+	mtctr	r3
+	li	r3, 0
+1:
+	dcbf	0,r3
+	addi	r3,r3,0x0020
+	bdnz	1b
+	sync
+
+	/* Ok, we are now running with the kernel data of the old
+	 * kernel fully restored. We can get to the save area
+	 * easily now. As for the rest of the code, it assumes the
+	 * loader kernel and the booted one are exactly identical
+	 */
+	lis	r11,swsusp_save_area@h
+	ori	r11,r11,swsusp_save_area@l
+	tophys(r11,r11)
+
+#if 0
+	/* Restore various CPU config stuffs */
+	bl	__restore_cpu_setup
+#endif
+	/* Restore the BATs, and SDR1.  Then we can turn on the MMU.
+	 * This is a bit hairy as we are running out of those BATs,
+	 * but first, our code is probably in the icache, and we are
+	 * writing the same value to the BAT, so that should be fine,
+	 * though a better solution will have to be found long-term
+	 */
+	lwz	r4,SL_SDR1(r11)
+	mtsdr1	r4
+	lwz	r4,SL_SPRG0(r11)
+	mtsprg	0,r4
+	lwz	r4,SL_SPRG0+4(r11)
+	mtsprg	1,r4
+	lwz	r4,SL_SPRG0+8(r11)
+	mtsprg	2,r4
+	lwz	r4,SL_SPRG0+12(r11)
+	mtsprg	3,r4
+
+#if 0
+	lwz	r4,SL_DBAT0(r11)
+	mtdbatu	0,r4
+	lwz	r4,SL_DBAT0+4(r11)
+	mtdbatl	0,r4
+	lwz	r4,SL_DBAT1(r11)
+	mtdbatu	1,r4
+	lwz	r4,SL_DBAT1+4(r11)
+	mtdbatl	1,r4
+	lwz	r4,SL_DBAT2(r11)
+	mtdbatu	2,r4
+	lwz	r4,SL_DBAT2+4(r11)
+	mtdbatl	2,r4
+	lwz	r4,SL_DBAT3(r11)
+	mtdbatu	3,r4
+	lwz	r4,SL_DBAT3+4(r11)
+	mtdbatl	3,r4
+	lwz	r4,SL_IBAT0(r11)
+	mtibatu	0,r4
+	lwz	r4,SL_IBAT0+4(r11)
+	mtibatl	0,r4
+	lwz	r4,SL_IBAT1(r11)
+	mtibatu	1,r4
+	lwz	r4,SL_IBAT1+4(r11)
+	mtibatl	1,r4
+	lwz	r4,SL_IBAT2(r11)
+	mtibatu	2,r4
+	lwz	r4,SL_IBAT2+4(r11)
+	mtibatl	2,r4
+	lwz	r4,SL_IBAT3(r11)
+	mtibatu	3,r4
+	lwz	r4,SL_IBAT3+4(r11)
+	mtibatl	3,r4
+#endif
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
+	lwz	r3,SL_MSR(r11)
+	bl	turn_on_mmu
+	tovirt(r11,r11)
+
+	/* Restore TB */
+	li	r3,0
+	mttbl	r3
+	lwz	r3,SL_TB(r11)
+	lwz	r4,SL_TB+4(r11)
+	mttbu	r3
+	mttbl	r4
+
+	/* Kick decrementer */
+	li	r0,1
+	mtdec	r0
+
+	/* Restore the callee-saved registers and return */
+	lwz	r0,SL_CR(r11)
+	mtcr	r0
+	lwz	r2,SL_R2(r11)
+	lmw	r12,SL_R12(r11)
+	lwz	r1,SL_SP(r11)
+	lwz	r0,SL_LR(r11)
+	mtlr	r0
+
+	// XXX Note: we don't really need to call swsusp_resume
+
+	li	r3,0
+	blr
+
+/* FIXME:This construct is actually not useful since we don't shut
+ * down the instruction MMU, we could just flip back MSR-DR on.
+ */
+turn_on_mmu:
+	mflr	r4
+	mtsrr0	r4
+	mtsrr1	r3
+	sync
+	isync
+	rfi
+
diff -Nru linux-2.6.11-a/arch/ppc/kernel/vmlinux.lds.S linux-2.6.11-b/arch/ppc/kernel/vmlinux.lds.S
--- linux-2.6.11-a/arch/ppc/kernel/vmlinux.lds.S	2005-03-02 08:38:34.000000000 +0100
+++ linux-2.6.11-b/arch/ppc/kernel/vmlinux.lds.S	2005-03-04 18:42:16.000000000 +0100
@@ -74,6 +74,12 @@
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
 
diff -Nru linux-2.6.11-a/arch/ppc/platforms/pmac_setup.c linux-2.6.11-b/arch/ppc/platforms/pmac_setup.c
--- linux-2.6.11-a/arch/ppc/platforms/pmac_setup.c	2005-03-02 08:38:13.000000000 +0100
+++ linux-2.6.11-b/arch/ppc/platforms/pmac_setup.c	2005-03-04 18:42:16.000000000 +0100
@@ -52,6 +52,7 @@
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
 #include <linux/bitops.h>
+#include <linux/suspend.h>
 
 #include <asm/reg.h>
 #include <asm/sections.h>
@@ -70,6 +71,8 @@
 #include <asm/pmac_feature.h>
 #include <asm/time.h>
 #include <asm/of_device.h>
+#include <asm/mmu_context.h>
+
 #include "pmac_pic.h"
 #include "mem_pieces.h"
 
@@ -421,10 +424,62 @@
 }
 
 static int initializing = 1;
+/* TODO: Merge the suspend-to-ram with the common code !!!
+ * currently, this is a stub implementation for suspend-to-disk
+ * only
+ */
+
+#ifdef CONFIG_SOFTWARE_SUSPEND
+
+static int pmac_pm_prepare(suspend_state_t state)
+{
+	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
+
+	return 0;
+}
+
+static int pmac_pm_enter(suspend_state_t state)
+{
+	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
+
+	/* Giveup the lazy FPU & vec so we don't have to back them
+	 * up from the low level code
+	 */
+	enable_kernel_fp();
+
+#ifdef CONFIG_ALTIVEC
+	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
+		enable_kernel_altivec();
+#endif /* CONFIG_ALTIVEC */
+
+	return 0;
+}
+
+static int pmac_pm_finish(suspend_state_t state)
+{
+	printk(KERN_DEBUG "%s(%d)\n", __FUNCTION__, state);
+
+	/* Restore userland MMU context */
+	set_context(current->active_mm->context, current->active_mm->pgd);
+
+	return 0;
+}
+
+static struct pm_ops pmac_pm_ops = {
+	.pm_disk_mode	= PM_DISK_SHUTDOWN,
+	.prepare	= pmac_pm_prepare,
+	.enter		= pmac_pm_enter,
+	.finish		= pmac_pm_finish,
+};
+
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 
 static int pmac_late_init(void)
 {
 	initializing = 0;
+#ifdef CONFIG_SOFTWARE_SUSPEND
+	pm_set_ops(&pmac_pm_ops);
+#endif /* CONFIG_SOFTWARE_SUSPEND */
 	return 0;
 }
 
diff -Nru linux-2.6.11-a/drivers/macintosh/via-pmu.c linux-2.6.11-b/drivers/macintosh/via-pmu.c
--- linux-2.6.11-a/drivers/macintosh/via-pmu.c	2005-03-02 08:38:25.000000000 +0100
+++ linux-2.6.11-b/drivers/macintosh/via-pmu.c	2005-03-04 18:42:16.000000000 +0100
@@ -43,6 +43,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
+#include <linux/sysdev.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/cpu.h>
@@ -2326,7 +2327,7 @@
 	/* Sync the disks. */
 	/* XXX It would be nice to have some way to ensure that
 	 * nobody is dirtying any new buffers while we wait. That
-	 * could be acheived using the refrigerator for processes
+	 * could be achieved using the refrigerator for processes
 	 * that swsusp uses
 	 */
 	sys_sync();
@@ -2379,7 +2380,6 @@
 
 	/* Wait for completion of async backlight requests */
 	while (!bright_req_1.complete || !bright_req_2.complete ||
-
 			!batt_req.complete)
 		pmu_poll();
 
@@ -3040,6 +3040,88 @@
 }
 #endif /* DEBUG_SLEEP */
 
+
+/* FIXME: This is a temporary set of callbacks to enable us
+ * to do suspend-to-disk.
+ */
+
+#ifdef CONFIG_PM
+
+static int pmu_sys_suspended = 0;
+
+static int pmu_sys_suspend(struct sys_device *sysdev, u32 state)
+{
+	if (state != PM_SUSPEND_DISK || pmu_sys_suspended)
+		return 0;
+
+	/* Suspend PMU event interrupts */
+	pmu_suspend();
+
+	pmu_sys_suspended = 1;
+	return 0;
+}
+
+static int pmu_sys_resume(struct sys_device *sysdev)
+{
+	struct adb_request req;
+
+	if (!pmu_sys_suspended)
+		return 0;
+
+	/* Tell PMU we are ready */
+	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
+	pmu_wait_complete(&req);
+
+	/* Resume PMU event interrupts */
+	pmu_resume();
+
+	pmu_sys_suspended = 0;
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
+static struct sysdev_class pmu_sysclass = {
+	set_kset_name("pmu"),
+};
+
+static struct sys_device device_pmu = {
+	.id		= 0,
+	.cls		= &pmu_sysclass,
+};
+
+static struct sysdev_driver driver_pmu = {
+#ifdef CONFIG_PM
+	.suspend	= &pmu_sys_suspend,
+	.resume		= &pmu_sys_resume,
+#endif /* CONFIG_PM */
+};
+
+static int __init init_pmu_sysfs(void)
+{
+	int rc;
+
+	rc = sysdev_class_register(&pmu_sysclass);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys class\n");
+		return -ENODEV;
+	}
+	rc = sysdev_register(&device_pmu);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys device\n");
+		return -ENODEV;
+	}
+	rc = sysdev_driver_register(&pmu_sysclass, &driver_pmu);
+	if (rc) {
+		printk(KERN_ERR "Failed registering PMU sys driver\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+subsys_initcall(init_pmu_sysfs);
+
 EXPORT_SYMBOL(pmu_request);
 EXPORT_SYMBOL(pmu_poll);
 EXPORT_SYMBOL(pmu_poll_adb);
diff -Nru linux-2.6.11-a/include/asm-ppc/suspend.h linux-2.6.11-b/include/asm-ppc/suspend.h
--- linux-2.6.11-a/include/asm-ppc/suspend.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-b/include/asm-ppc/suspend.h	2005-03-04 18:42:16.000000000 +0100
@@ -0,0 +1,12 @@
+static inline int arch_prepare_suspend(void)
+{
+	return 0;
+}
+
+static inline void save_processor_state(void)
+{
+}
+
+static inline void restore_processor_state(void)
+{
+}
diff -Nru linux-2.6.11-a/include/linux/suspend.h linux-2.6.11-b/include/linux/suspend.h
--- linux-2.6.11-a/include/linux/suspend.h	2005-03-02 08:37:50.000000000 +0100
+++ linux-2.6.11-b/include/linux/suspend.h	2005-03-04 18:42:16.000000000 +0100
@@ -1,7 +1,7 @@
 #ifndef _LINUX_SWSUSP_H
 #define _LINUX_SWSUSP_H
 
-#if defined(CONFIG_X86) || defined(CONFIG_FRV)
+#if defined(CONFIG_X86) || defined(CONFIG_FRV) || defined(CONFIG_PPC32)
 #include <asm/suspend.h>
 #endif
 #include <linux/swap.h>



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
