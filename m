Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbUC3FlC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 00:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263205AbUC3FlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 00:41:02 -0500
Received: from gate.crashing.org ([63.228.1.57]:54677 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263136AbUC3Fjh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 00:39:37 -0500
Subject: [PATCH] ppc32: context switch  fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1080625167.1213.8.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 30 Mar 2004 15:39:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

This patch fixes a few issues with context switch on ppc32:

 - Makes sure we properly flush out all stores to the coherency domain
when switching out, since the same thread could be switched back in
on another CPU right away, those stores must be visible to all other
CPUs.

 - Remove dssall in the assembly calls and do it now once in
switch_mm (stop vmx streams). Assume the G5 doesn't need a sync
after dssall.

 - Remove bogus isync in the loop setting the userland segment registers

 - Do not switch the userland segments when the mm stays the same

Please apply,
Ben.


diff -urN linux-2.5/arch/ppc/kernel/entry.S linuxppc-2.5-benh/arch/ppc/kernel/entry.S
--- linux-2.5/arch/ppc/kernel/entry.S	2004-03-29 12:54:12.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc/kernel/entry.S	2004-03-30 14:55:41.000000000 +1000
@@ -469,10 +469,19 @@
 	stw	r10,_CCR(r1)
 	stw	r1,KSP(r3)	/* Set old stack pointer */
 
+#ifdef CONFIG_SMP
+	/* We need a sync somewhere here to make sure that if the
+	 * previous task gets rescheduled on another CPU, it sees all
+	 * stores it has performed on this one.
+	 */
+	sync
+#endif /* CONFIG_SMP */
+
 	tophys(r0,r4)
 	CLR_TOP32(r0)
 	mtspr	SPRG3,r0	/* Update current THREAD phys addr */
 	lwz	r1,KSP(r4)	/* Load new stack pointer */
+
 	/* save the old current 'last' for return value */
 	mr	r3,r2
 	addi	r2,r4,-THREAD	/* Update current */
diff -urN linux-2.5/arch/ppc/kernel/head.S linuxppc-2.5-benh/arch/ppc/kernel/head.S
--- linux-2.5/arch/ppc/kernel/head.S	2004-03-30 08:55:49.000000000 +1000
+++ linuxppc-2.5-benh/arch/ppc/kernel/head.S	2004-03-30 14:55:41.000000000 +1000
@@ -1436,11 +1436,8 @@
 	stw	r4, 0x4(r5)
 #endif
 	li	r4,0
-BEGIN_FTR_SECTION
-	dssall
-	sync
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-3:	isync
+	isync
+3:
 #ifdef CONFIG_PPC64BRIDGE
 	slbie	r4
 #endif /* CONFIG_PPC64BRIDGE */
diff -urN linux-2.5/include/asm-ppc/cputable.h linuxppc-2.5-benh/include/asm-ppc/cputable.h
--- linux-2.5/include/asm-ppc/cputable.h	2004-03-01 18:13:05.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-ppc/cputable.h	2004-03-30 14:58:43.000000000 +1000
@@ -90,11 +90,25 @@
 	.long 99b;				\
 	.previous
 
-#define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
-#define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
+#else
+
+#define BEGIN_FTR_SECTION		"98:\n"
+#define END_FTR_SECTION(msk, val)		\
+"99:\n"						\
+"	.section __ftr_fixup,\"a\";\n"		\
+"	.align 2;\n"				\
+"	.long "#msk";\n"			\
+"	.long "#val";\n"			\
+"	.long 98b;\n"			        \
+"	.long 99b;\n"	 		        \
+"	.previous\n"
+
 
 #endif /* __ASSEMBLY__ */
 
+#define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
+#define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
+
 #endif /* __ASM_PPC_CPUTABLE_H */
 #endif /* __KERNEL__ */
 
diff -urN linux-2.5/include/asm-ppc/mmu_context.h linuxppc-2.5-benh/include/asm-ppc/mmu_context.h
--- linux-2.5/include/asm-ppc/mmu_context.h	2004-03-01 18:13:06.000000000 +1100
+++ linuxppc-2.5-benh/include/asm-ppc/mmu_context.h	2004-03-30 14:58:44.000000000 +1000
@@ -6,6 +6,7 @@
 #include <asm/atomic.h>
 #include <asm/bitops.h>
 #include <asm/mmu.h>
+#include <asm/cputable.h>
 
 /*
  * On 32-bit PowerPC 6xx/7xx/7xxx CPUs, we use a set of 16 VSIDs
@@ -155,7 +156,24 @@
 static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
+#ifdef CONFIG_ALTIVEC
+	asm volatile (
+ BEGIN_FTR_SECTION
+	"dssall;\n"
+#ifndef CONFIG_POWER4
+	 "sync;\n" /* G4 needs a sync here, G5 apparently not */
+#endif
+ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
+	 : : );
+#endif /* CONFIG_ALTIVEC */
+
 	tsk->thread.pgdir = next->pgd;
+
+	/* No need to flush userspace segments if the mm doesnt change */
+	if (prev == next)
+		return;
+
+	/* Setup new userspace context */
 	get_mmu_context(next);
 	set_context(next->context, next->pgd);
 }
@@ -166,12 +184,7 @@
  * After we have set current->mm to a new value, this activates
  * the context for the new mm so we see the new mappings.
  */
-static inline void activate_mm(struct mm_struct *active_mm, struct mm_struct *mm)
-{
-	current->thread.pgdir = mm->pgd;
-	get_mmu_context(mm);
-	set_context(mm->context, mm->pgd);
-}
+#define activate_mm(active_mm, mm)   switch_mm(active_mm, mm, current)
 
 extern void mmu_context_init(void);
 


