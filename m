Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUBAHJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 02:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265227AbUBAHJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 02:09:39 -0500
Received: from [211.167.76.68] ([211.167.76.68]:56195 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S265225AbUBAHJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 02:09:18 -0500
Date: Sun, 1 Feb 2004 15:08:27 +0800
From: Hugang <hugang@soulinfo.com>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software Suspend 2.0
Message-Id: <20040201150827.2858bf9b@localhost>
In-Reply-To: <1075436665.2086.3.camel@laptop-linux>
References: <1075436665.2086.3.camel@laptop-linux>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sun__1_Feb_2004_15_08_27_+0800_1nluQLLSbvmwM=QX"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Sun__1_Feb_2004_15_08_27_+0800_1nluQLLSbvmwM=QX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Jan 2004 17:24:25 +1300
Nigel Cunningham <ncunningham@clear.net.nz> wrote:

> Software Suspend 2.0 for Linux 2.4 and 2.6 kernels is now available
> from http://swsusp.sf.net. The 2.0 release is a major advance over
> previous versions and includes the following features:

Here is the ppc swsusp2 update patch for 2.6.1 + rc6 + 2.0, please
apply.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/HuGang.asc

--Multipart=_Sun__1_Feb_2004_15_08_27_+0800_1nluQLLSbvmwM=QX
Content-Type: text/plain;
 name="ppc_up.diff"
Content-Disposition: attachment;
 filename="ppc_up.diff"
Content-Transfer-Encoding: 7bit

M  arch/ppc/kernel/signal.c
M  kernel/power/swsusp2.c
M  arch/ppc/power/cpu.c
M  arch/ppc/power/cpu_reg.S
M  arch/ppc/power/swsusp2-asm.S
M  arch/ppc/power/swsusp2-copyback.S
M  arch/ppc/power/swsusp2.c

* modified files

--- orig/arch/ppc/kernel/signal.c
+++ mod/arch/ppc/kernel/signal.c
@@ -555,7 +555,10 @@
 
 	if (current->flags & PF_FREEZE) {
 		refrigerator(PF_FREEZE);
-		return 0;
+		signr = 0;
+		ret = regs->gpr[3];
+		if (!signal_pending(current))
+			goto no_signal;
 	}
 
 	if (!oldset)
@@ -582,6 +585,7 @@
 			regs->gpr[3] = EINTR;
 			/* note that the cr0.SO bit is already set */
 		} else {
+no_signal:
 			regs->nip -= 4;	/* Back up & retry system call */
 			regs->result = 0;
 			regs->trap = 0;


--- orig/arch/ppc/power/cpu.c
+++ mod/arch/ppc/power/cpu.c
@@ -15,57 +15,59 @@
 #include <linux/irq.h>
 #include <linux/root_dev.h>
 #include <linux/suspend.h>
-#include <linux/delay.h>
 
 #include <asm/mmu_context.h>
 
+#define DEBUG
+
+#ifdef DEBUG
+#define dprintk(fmt, arg...) printk(fmt, ## arg)
+#else
+#define dprintk(fmt, arg...)
+#endif
+
 extern void enable_kernel_altivec(void);
 
+/* pmu power manager part */
 static inline void do_pmu_suspend(void)
 {
-	printk("suspend pmu\n");	
+	dprintk(KERN_DEBUG "suspend pmu\n");	
 	pmu_suspend();
-	printk(".\n");
+	dprintk(KERN_DEBUG ".\n");
 }
 
 static inline void do_pmu_resume(void)
 {
-	struct adb_request req;
-	printk("resume pmu\n");	
-	pmu_request(&req, NULL, 2, PMU_SYSTEM_READY, 2);
-	pmu_wait_complete(&req);
-	
-	/* Resume PMU event interrupts */
+	dprintk(KERN_DEBUG "resume pmu\n");	
 	pmu_resume();	
-	printk(".\n");
+	dprintk(KERN_DEBUG ".\n");
 }
 
 void save_processor_state(void)
 {
-	printk("save processor state\n");
+	dprintk(KERN_DEBUG "save processor state\n");
+#ifdef CONFIG_PREEMPT
+	preempt_disable();
+#endif
 	pmu_suspend();
-	printk(".\n");
-	printk("current is 0x%x\n", current);
-	mdelay(1000);
+	dprintk(KERN_DEBUG ".\n");
 }
 
 void restore_processor_state(void)
 {
-	printk("current is 0x%x\n", current);
-	mdelay(1000);
-	printk("seting context\n");
+	dprintk(KERN_DEBUG "seting context\n");
 	/* Restore userland MMU context */
 	set_context(current->active_mm->context, current->active_mm->pgd);
 
-	printk("do pmu resume\n");
+	printk(KERN_DEBUG "do pmu resume\n");
 	do_pmu_resume();
 #ifdef CONFIG_ALTIVEC
 	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_ALTIVEC)
 		enable_kernel_altivec();
 #endif
-	printk("enable kernel fp\n");
+	dprintk(KERN_DEBUG "enable kernel fp\n");
 	enable_kernel_fp();
-	printk(".\n");
+	dprintk(KERN_DEBUG ".\n");
 }
 
 EXPORT_SYMBOL(save_processor_state);


--- orig/arch/ppc/power/cpu_reg.S
+++ mod/arch/ppc/power/cpu_reg.S
@@ -38,232 +38,168 @@
 #define CPU_REG_MEM_DEFINE \
 	.section .data					  ; \
 	.align	5					  ; \
-\
+							  ; \
 _GLOBAL(cpu_reg_save_area)				  ; \
 	.space	SL_SIZE	
 	
 #define CPU_REG_MEM_SAVE \
-	lis	r11,cpu_reg_save_area@h;\
-	ori	r11,r11,cpu_reg_save_area@l;\
-;\
+	lis	r11,cpu_reg_save_area@h			  ; \
+	ori	r11,r11,cpu_reg_save_area@l		  ; \
+	;; \
 	mflr	r0					  ; \
-	stw	r0,SL_LR(r11);\
-	mfcr	r0;\
-	stw	r0,SL_CR(r11);\
-	stw	r1,SL_SP(r11);\
-	stw	r2,SL_R2(r11);\
-	stmw	r12,SL_R12(r11);\
-;\
-	/* Save MSR & SDR1 */;\
-	mfmsr	r4;\
-	stw	r4,SL_MSR(r11);\
-	mfsdr1	r4;\
-	stw	r4,SL_SDR1(r11);\
-;\
-	/* Get a stable timebase and save it */;\
-1:	mftbu	r4;\
-	stw	r4,SL_TB(r11);\
-	mftb	r5;\
-	stw	r5,SL_TB+4(r11);\
-	mftbu	r3;\
-	cmpw	r3,r4;\
-	bne	1b;\
-;\
-	/* Save SPRGs */;\
-	mfsprg	r4,0;\
-	stw	r4,SL_SPRG0(r11);\
-	mfsprg	r4,1;\
-	stw	r4,SL_SPRG0+4(r11);\
-	mfsprg	r4,2;\
-	stw	r4,SL_SPRG0+8(r11);\
-	mfsprg	r4,3;\
-	stw	r4,SL_SPRG0+12(r11);\
-;\
-	/* Save BATs */;\
-	mfdbatu	r4,0;\
-	stw	r4,SL_DBAT0(r11);\
-	mfdbatl	r4,0;\
-	stw	r4,SL_DBAT0+4(r11);\
-	mfdbatu	r4,1;\
-	stw	r4,SL_DBAT1(r11);\
-	mfdbatl	r4,1;\
-	stw	r4,SL_DBAT1+4(r11);\
-	mfdbatu	r4,2;\
-	stw	r4,SL_DBAT2(r11);\
-	mfdbatl	r4,2;\
-	stw	r4,SL_DBAT2+4(r11);\
-	mfdbatu	r4,3;\
-	stw	r4,SL_DBAT3(r11);\
-	mfdbatl	r4,3;\
-	stw	r4,SL_DBAT3+4(r11);\
-	mfibatu	r4,0;\
-	stw	r4,SL_IBAT0(r11);\
-	mfibatl	r4,0;\
-	stw	r4,SL_IBAT0+4(r11);\
-	mfibatu	r4,1;\
-	stw	r4,SL_IBAT1(r11);\
-	mfibatl	r4,1;\
-	stw	r4,SL_IBAT1+4(r11);\
-	mfibatu	r4,2;\
-	stw	r4,SL_IBAT2(r11);\
-	mfibatl	r4,2;\
-	stw	r4,SL_IBAT2+4(r11);\
-	mfibatu	r4,3;\
-	stw	r4,SL_IBAT3(r11);\
-	mfibatl	r4,3;\
-	stw	r4,SL_IBAT3+4(r11);\
-	/* Backup various CPU config stuffs */;\
-	/* bl	__save_cpu_setup; */
+	stw	r0,SL_LR(r11)				  ; \
+	mfcr	r0					  ; \
+	stw	r0,SL_CR(r11)				  ; \
+	stw	r1,SL_SP(r11)				  ; \
+	stw	r2,SL_R2(r11)				  ; \
+	stmw	r12,SL_R12(r11)				  ; \
+	;; \
+	/* Save MSR & SDR1 */				  ; \
+	mfmsr	r4					  ; \
+	stw	r4,SL_MSR(r11)				  ; \
+	mfsdr1	r4					  ; \
+	stw	r4,SL_SDR1(r11)				  ; \
+	;; \
+	/* Get a stable timebase and save it */		  ; \
+1:	mftbu	r4					  ; \
+	stw	r4,SL_TB(r11)				  ; \
+	mftb	r5					  ; \
+	stw	r5,SL_TB+4(r11)				  ; \
+	mftbu	r3					  ; \
+	cmpw	r3,r4					  ; \
+	bne	1b					  ; \
+	;; \
+	/* Save SPRGs */				  ; \
+	mfsprg	r4,0					  ; \
+	stw	r4,SL_SPRG0(r11)			  ; \
+	mfsprg	r4,1					  ; \
+	stw	r4,SL_SPRG0+4(r11)			  ; \
+	mfsprg	r4,2					  ; \
+	stw	r4,SL_SPRG0+8(r11)			  ; \
+	mfsprg	r4,3					  ; \
+	stw	r4,SL_SPRG0+12(r11)			  ; \
+	/* Backup various CPU config stuffs */		  ; \
+	/* bl	__save_cpu_setup */
+
 
+/* Disable MSR:DR to make sure we don't take a TLB or	  
+ * hash miss during the copy, as our hash table will	  
+ * for a while be unuseable. For .text, we assume we are  
+ * covered by a BAT. This works only for non-G5 at this	  
+ * point. G5 will need a better approach, possibly using  
+ * a small temporary hash table filled with large mappings,
+ * disabling the MMU completely isn't a good option for	 
+ * performance reasons.					 
+ * (Note that 750's may have the same performance issue as
+ * the G5 in this case, we should investigate using moving
+ * BATs for these CPUs)					  
+ */							  
 #define CPU_REG_MEM_DISABLE_MMU \
-	/* Disable MSR:DR to make sure we don't take a TLB or	;\
-	 * hash miss during the copy, as our hash table will	;\
-	 * for a while be unuseable. For .text, we assume we are;\
-	 * covered by a BAT. This works only for non-G5 at this	;\
-	 * point. G5 will need a better approach, possibly using;\
-	 * a small temporary hash table filled with large mappings,;\
-	 * disabling the MMU completely isn't a good option for	;\
-	 * performance reasons.	;\
-	 * (Note that 750's may have the same performance issue as;\
-	 * the G5 in this case, we should investigate using moving;\
-	 * BATs for these CPUs);\
-	 */;\
-	mfmsr	r0	;\
-	sync	;\
-	rlwinm	r0,r0,0,28,26		/* clear MSR_DR */ ;\
-	mtmsr	r0 ;\
-	sync ;\
+	mfmsr	r0					  ; \
+	sync						  ; \
+	rlwinm	r0,r0,0,28,26		/* clear MSR_DR */ ; \
+	mtmsr	r0					  ; \
+	sync						  ; \
 	isync
 
+
+/* Do a very simple cache flush/inval of the L1 to ensure 
+ * coherency of the icache 
+ */ 
 #define CPU_REG_MEM_FLUSH_CACHE \
-	/* Do a very simple cache flush/inval of the L1 to ensure \
-	 * coherency of the icache \
-	 */ \
-	lis	r3,0x0002 ;\
-	mtctr	r3 ;\
-	li	r3, 0 ;\
-1: ;\
-	lwz	r0,0(r3) ;\
-	addi	r3,r3,0x0020 ;\
-	bdnz	1b ;\
-	isync ;\
-	sync ;\
-;\
-	/* Now flush those cache lines */ ;\
-	lis	r3,0x0002 ;\
-	mtctr	r3 ;\
-	li	r3, 0 ;\
-1:;\
-	dcbf	0,r3 ;\
-	addi	r3,r3,0x0020 ;\
+	lis	r3,0x0002				  ; \
+	mtctr	r3					  ; \
+	li	r3, 0					  ; \
+1:							  ; \
+	lwz	r0,0(r3)				  ; \
+	addi	r3,r3,0x0020				  ; \
+	bdnz	1b					  ; \
+	isync						  ; \
+	sync						  ; \
+	;; \
+	/* Now flush those cache lines */		  ; \
+	lis	r3,0x0002				  ; \
+	mtctr	r3					  ; \
+	li	r3, 0					  ; \
+1:							  ; \
+	dcbf	0,r3					  ; \
+	addi	r3,r3,0x0020				  ; \
 	bdnz	1b
 
+
+/* Ok, we are now running with the kernel data of the old 
+ * kernel fully restored. We can get to the save area	  
+ * easily now. As for the rest of the code, it assumes the
+ * loader kernel and the booted one are exactly identical 
+ */
 #define CPU_REG_MEM_RESTORE \
-/* Ok, we are now running with the kernel data of the old;\
-	 * kernel fully restored. We can get to the save area;\
-	 * easily now. As for the rest of the code, it assumes the;\
-	 * loader kernel and the booted one are exactly identical;\
-	 */;\
-	lis	r11,cpu_reg_save_area@h;\
-	ori	r11,r11,cpu_reg_save_area@l;\
-	tophys(r11,r11);\
-	/* Restore various CPU config stuffs */;\
-	/* bl	__restore_cpu_setup; */\
-	/* Restore the BATs, and SDR1.  Then we can turn on the MMU. ;\
-	 * This is a bit hairy as we are running out of those BATs,;\
-	 * but first, our code is probably in the icache, and we are;\
-	 * writing the same value to the BAT, so that should be fine,;\
-	 * though a better solution will have to be found long-term;\
-	 */;\
-	lwz	r4,SL_SDR1(r11);\
-	mtsdr1	r4;\
-	lwz	r4,SL_SPRG0(r11);\
-	mtsprg	0,r4;\
-	lwz	r4,SL_SPRG0+4(r11);\
-	mtsprg	1,r4;\
-	lwz	r4,SL_SPRG0+8(r11);\
-	mtsprg	2,r4;\
-	lwz	r4,SL_SPRG0+12(r11);\
-	mtsprg	3,r4;\
-;\
-/*	lwz	r4,SL_DBAT0(r11);\
-	mtdbatu	0,r4;\
-	lwz	r4,SL_DBAT0+4(r11);\
-	mtdbatl	0,r4;\
-	lwz	r4,SL_DBAT1(r11);\
-	mtdbatu	1,r4;\
-	lwz	r4,SL_DBAT1+4(r11);\
-	mtdbatl	1,r4;\
-	lwz	r4,SL_DBAT2(r11);\
-	mtdbatu	2,r4;\
-	lwz	r4,SL_DBAT2+4(r11);\
-	mtdbatl	2,r4;\
-	lwz	r4,SL_DBAT3(r11);\
-	mtdbatu	3,r4;\
-	lwz	r4,SL_DBAT3+4(r11);\
-	mtdbatl	3,r4;\
-	lwz	r4,SL_IBAT0(r11);\
-	mtibatu	0,r4;\
-	lwz	r4,SL_IBAT0+4(r11);\
-	mtibatl	0,r4;\
-	lwz	r4,SL_IBAT1(r11);\
-	mtibatu	1,r4;\
-	lwz	r4,SL_IBAT1+4(r11);\
-	mtibatl	1,r4;\
-	lwz	r4,SL_IBAT2(r11);\
-	mtibatu	2,r4;\
-	lwz	r4,SL_IBAT2+4(r11);\
-	mtibatl	2,r4;\
-	lwz	r4,SL_IBAT3(r11);\
-	mtibatu	3,r4;\
-	lwz	r4,SL_IBAT3+4(r11);\
-	mtibatl	3,r4;\
-; */ \
-BEGIN_FTR_SECTION;\
-	li	r4,0;\
-	mtspr	SPRN_DBAT4U,r4;\
-	mtspr	SPRN_DBAT4L,r4;\
-	mtspr	SPRN_DBAT5U,r4;\
-	mtspr	SPRN_DBAT5L,r4;\
-	mtspr	SPRN_DBAT6U,r4;\
-	mtspr	SPRN_DBAT6L,r4;\
-	mtspr	SPRN_DBAT7U,r4;\
-	mtspr	SPRN_DBAT7L,r4;\
-	mtspr	SPRN_IBAT4U,r4;\
-	mtspr	SPRN_IBAT4L,r4;\
-	mtspr	SPRN_IBAT5U,r4;\
-	mtspr	SPRN_IBAT5L,r4;\
-	mtspr	SPRN_IBAT6U,r4;\
-	mtspr	SPRN_IBAT6L,r4;\
-	mtspr	SPRN_IBAT7U,r4;\
-	mtspr	SPRN_IBAT7L,r4;\
-END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS);\
-;\
-	/* Flush all TLBs */;\
-	lis	r4,0x1000;\
-1:	addic.	r4,r4,-0x1000;\
-	tlbie	r4;\
-	blt	1b;\
-	sync;\
-;\
-	/* restore the MSR and turn on the MMU */;\
-	lwz	r3,SL_MSR(r11);\
-	bl	turn_on_mmu;\
-	tovirt(r11,r11);\
-;\
-	/* Restore TB */;\
-	li	r3,0;\
-	mttbl	r3;\
-	lwz	r3,SL_TB(r11);\
-	lwz	r4,SL_TB+4(r11);\
-	mttbu	r3;\
-	mttbl	r4;\
-; \
-	lwz	r0,SL_CR(r11);\
-	mtcr	r0;\
-	lwz	r2,SL_R2(r11);\
-	lmw	r12,SL_R12(r11);\
-	lwz	r1,SL_SP(r11);\
+	lis	r11,cpu_reg_save_area@h			  ; \
+	ori	r11,r11,cpu_reg_save_area@l		  ; \
+	tophys(r11,r11)					  ; \
+	/* Restore various CPU config stuffs */		  ; \
+	/* bl	__restore_cpu_setup */			  ; \
+	/* Restore the BATs, and SDR1.  Then we can turn on the MMU. ; \
+	 * This is a bit hairy as we are running out of those BATs, ; \
+	 * but first, our code is probably in the icache, and we are ; \
+	 * writing the same value to the BAT, so that should be fine, ; \
+	 * though a better solution will have to be found long-term ; \
+	 */						  ; \
+	lwz	r4,SL_SDR1(r11)				  ; \
+	mtsdr1	r4					  ; \
+	lwz	r4,SL_SPRG0(r11)			  ; \
+	mtsprg	0,r4					  ; \
+	lwz	r4,SL_SPRG0+4(r11)			  ; \
+	mtsprg	1,r4					  ; \
+	lwz	r4,SL_SPRG0+8(r11)			  ; \
+	mtsprg	2,r4					  ; \
+	lwz	r4,SL_SPRG0+12(r11)			  ; \
+	mtsprg	3,r4					  ; \
+	;; \
+BEGIN_FTR_SECTION  \
+	li	r4,0					  ; \
+	mtspr	SPRN_DBAT4U,r4				  ; \
+	mtspr	SPRN_DBAT4L,r4				  ; \
+	mtspr	SPRN_DBAT5U,r4				  ; \
+	mtspr	SPRN_DBAT5L,r4				  ; \
+	mtspr	SPRN_DBAT6U,r4				  ; \
+	mtspr	SPRN_DBAT6L,r4				  ; \
+	mtspr	SPRN_DBAT7U,r4				  ; \
+	mtspr	SPRN_DBAT7L,r4				  ; \
+	mtspr	SPRN_IBAT4U,r4				  ; \
+	mtspr	SPRN_IBAT4L,r4				  ; \
+	mtspr	SPRN_IBAT5U,r4				  ; \
+	mtspr	SPRN_IBAT5L,r4				  ; \
+	mtspr	SPRN_IBAT6U,r4				  ; \
+	mtspr	SPRN_IBAT6L,r4				  ; \
+	mtspr	SPRN_IBAT7U,r4				  ; \
+	mtspr	SPRN_IBAT7L,r4				  ; \
+END_FTR_SECTION_IFSET(CPU_FTR_HAS_HIGH_BATS)		  ; \
+	;; \
+	/* Flush all TLBs */				  ; \
+	lis	r4,0x1000				  ; \
+1:	addic.	r4,r4,-0x1000				  ; \
+	tlbie	r4					  ; \
+	blt	1b					  ; \
+	sync						  ; \
+	;; \
+	/* restore the MSR and turn on the MMU */	  ; \
+	lwz	r3,SL_MSR(r11)				  ; \
+	bl	turn_on_mmu				  ; \
+	tovirt(r11,r11)					  ; \
+	;; \
+	/* Restore TB */				  ; \
+	li	r3,0					  ; \
+	mttbl	r3					  ; \
+	lwz	r3,SL_TB(r11)				  ; \
+	lwz	r4,SL_TB+4(r11)				  ; \
+	mttbu	r3					  ; \
+	mttbl	r4					  ; \
+	;; \
+	lwz	r0,SL_CR(r11)				  ; \
+	mtcr	r0					  ; \
+	lwz	r2,SL_R2(r11)				  ; \
+	lmw	r12,SL_R12(r11)				  ; \
+	lwz	r1,SL_SP(r11)				  ; \
 	lwz	r4,SL_LR(r11)
 
 #define CPU_REG_MEM_RESTORE_END \
@@ -271,16 +207,17 @@
 	lis	r11,cpu_reg_save_area@h			  ; \
 	ori	r11,r11,cpu_reg_save_area@l		  ; \
 	lwz	r0,SL_CR(r11)				  ; \
-	mtcr r0					  ; \
+	mtcr r0						  ; \
 	lwz	r2,SL_R2(r11)				  ; \
 	lmw	r12,SL_R12(r11)				  ; \
 	lwz	r1,SL_SP(r11)
 
+
+/* FIXME:This construct is actually not useful since we don't shut 
+ * down the instruction MMU, we could just flip back MSR-DR on.	
+ */							  
 #define CPU_REG_TURN_ON_MMU \
-/* FIXME:This construct is actually not useful since we don't shut ; \
- * down the instruction MMU, we could just flip back MSR-DR on.	; \
- */							  ; \
-turn_on_mmu:						  ; \
+	turn_on_mmu:					  ; \
 	mflr	r4					  ; \
 	mtsrr0	r4					  ; \
 	mtsrr1	r3					  ; \


--- orig/arch/ppc/power/swsusp2-asm.S
+++ mod/arch/ppc/power/swsusp2-asm.S
@@ -25,6 +25,7 @@
 	bl	do_swsusp2_suspend_1
 	CPU_REG_MEM_SAVE
 	bl	do_swsusp2_suspend_2
+	bl	restore_processor_state
 	CPU_REG_MEM_RESTORE_END
 	CPU_REG_STACK_RESTORE
 	
@@ -43,8 +44,8 @@
 	CPU_REG_MEM_FLUSH_CACHE
 	
 	CPU_REG_MEM_RESTORE
-	bl	do_swsusp2_resume_2
-	bl	restore_processor_state
+	bl do_swsusp2_resume_2
+	bl restore_processor_state
 	CPU_REG_MEM_RESTORE_END
 	CPU_REG_STACK_RESTORE
 


--- orig/arch/ppc/power/swsusp2-copyback.S
+++ mod/arch/ppc/power/swsusp2-copyback.S
@@ -10,14 +10,11 @@
 
 	.section ".text"
 swsusp2_copyback:
-	lis r20,pagedir_resume@ha	/* can't ture this is right FIXME */
+	lis r20,pagedir_resume@ha
 	addi r20,r20,pagedir_resume@l
 	tophys(r20,r20)
-#if 0
-	lwz	r4,4(r20)
-	twi	31,r0,0	/* triger trap */
-#endif	
-	lis r4,0xcccc /* FIXME */
+
+	lis r4,0xcccc 
 	ori r4,r4,52429
 
 	lwz r6,12(r20)		/* r6 is origranges.first */
@@ -42,7 +39,7 @@
 
 	bdnz swsusp2_copy_data
 
-	lwz r0,4(r6)					  /* r0 is maximum */
+	lwz r0,4(r6)	      /* r0 is maximum */
 	cmplw r8,r0
 	bge- next_orig
 	addi r8,r8,1


--- orig/arch/ppc/power/swsusp2.c
+++ mod/arch/ppc/power/swsusp2.c
@@ -27,25 +27,6 @@
 #include <linux/suspend-debug.h>
 #include <linux/suspend-common.h>
 #include <asm/uaccess.h>
-#if 0
-/* Local variables for do_swsusp2_suspend */
-volatile static int state1 __nosavedata = 0;
-volatile static int state2 __nosavedata = 0;
-volatile static int state3 __nosavedata = 0;
-volatile static int loop __nosavedata = 0;
-volatile static struct range *origrange __nosavedata;
-volatile static struct range *copyrange __nosavedata;
-volatile static int origoffset __nosavedata;
-volatile static int copyoffset __nosavedata;
-volatile static unsigned long * origpage __nosavedata;
-volatile static unsigned long * copypage __nosavedata;
-#endif
-
-//volatile static int orig_min_free __nosavedata;
-#ifndef CONFIG_SMP
-//static unsigned long c_loops_per_jiffy_ref __nosavedata = 0;
-//static unsigned long cpu_khz_ref __nosavedata = 0;
-#endif
 
 extern void do_swsusp2_suspend_1(void);
 extern void do_swsusp2_suspend_2(void);
@@ -53,67 +34,20 @@
 extern void do_swsusp2_resume_2(void);
 extern struct pagedir __nosavedata pagedir_resume;
 
-/*
- * FIXME: This function should really be written in assembly. Actually
- * requirement is that it does not touch stack, because %esp will be
- * wrong during resume before restore_processor_context(). Check
- * assembly if you modify this.
- */
-#if 0
-static inline void pre_copyback(void)
-{
-#ifdef CONFIG_PREEMPT
-	/*
-	 * Preempt disabled in kernel we're about to restore.
-	 * Make sure we match state now.
-	 */
-	preempt_disable();
-	PRINTPREEMPTCOUNT("Prior to copying old kernel back.");
-#endif
-
-	state1 = swsusp_action;
-	state2 = swsusp_debug_state;
-	state3 = console_loglevel;
-
-#ifndef CONFIG_SMP
-	//c_loops_per_jiffy_ref = cpu_data->loops_per_jiffy;
-	//cpu_khz_ref = cpu_khz;
-#endif
-}
-static inline void post_copyback(void)
-{
-#ifndef CONFIG_SMP
-	//cpu_data->loops_per_jiffy = c_loops_per_jiffy_ref;
-	//loops_per_jiffy = c_loops_per_jiffy_ref;
-	//cpu_khz = cpu_khz_ref;
-#endif
-	swsusp_action = state1;
-	swsusp_debug_state = state2;
-	console_loglevel = state3;
-	//swsusp_min_free = orig_min_free;
-
-}
-#endif
 static inline void do_swsusp2_copyback(void)
 {
 	/* PowerPC has a lots register, use local register is possible */
 	register int origoffset, copyoffset;
 	register unsigned long * origpage, * copypage;
 	register struct range *origrange, *copyrange;
-//	register int pagesize;
-
-//	pre_copyback();
 
 	origrange = pagedir_resume.origranges.first;
-//	pagesize = pagedir_resume.pageset_size;
-//	printk("%d\n", pagesize);
 	origoffset = origrange->minimum;
 	origpage = (unsigned long *) (page_address(mem_map + origoffset));
 	
 	copyrange = pagedir_resume.destranges.first;
 	copyoffset = copyrange->minimum;
 	copypage = (unsigned long *) (page_address(mem_map + copyoffset));
-	//orig_min_free = swsusp_min_free;
 
 	while (origrange) {
 		register int loop;
@@ -145,8 +79,6 @@
 	
 /* Ahah, we now run with our old stack, and with registers copied from
    suspend time */
-
-//	post_copyback();
 }
 
 void do_swsusp_lowlevel(int resume)




--Multipart=_Sun__1_Feb_2004_15_08_27_+0800_1nluQLLSbvmwM=QX--
