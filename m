Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262608AbVDGVWf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262608AbVDGVWf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 17:22:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbVDGVWf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 17:22:35 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:53990 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S262608AbVDGVVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 17:21:34 -0400
Date: Thu, 7 Apr 2005 16:21:23 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
X-X-Sender: galak@blarg.somerset.sps.mot.com
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ppc32: Support 36-bit physical addressing on e500 (fwd)
Message-ID: <Pine.LNX.4.61.0504071620510.5510@blarg.somerset.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, forget to CC the lists on this one.

- kumar

---------- Forwarded message ----------
Date: Thu, 7 Apr 2005 16:20:43 -0500 (CDT)
From: Kumar Gala <galak@freescale.com>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] ppc32: Support 36-bit physical addressing on e500

Andrew,

To add support for 36-bit physical addressing on e500 the following 
changes have been made.  The changes are generalized to support any 
physical address size larger than 32-bits:

* Allow FSL Book-E parts to use a 64-bit PTE, it is 44-bits of pfn, 
20-bits of flags.

* Introduced new CPU feature (CPU_FTR_BIG_PHYS) to allow runtime 
handling of updating hardware register (SPRN_MAS7) which holds the upper 
32-bits of physical address that will be written into the TLB. This is 
useful since not all e500 cores support 36-bit physical addressing.

* Currently have a pass through implementation of fixup_bigphys_addr

* Moved _PAGE_DIRTY in the 64-bit PTE case to free room for three 
additional storage attributes that may exist in future FSL Book-E cores 
and updated fault handler to copy these bits into the hardware TLBs.

Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

---

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	2005-04-07 16:19:41 -05:00
+++ b/arch/ppc/Kconfig	2005-04-07 16:19:41 -05:00
@@ -98,13 +98,19 @@
 
 config PTE_64BIT
 	bool
-	depends on 44x
-	default y
+	depends on 44x || E500
+	default y if 44x
+	default y if E500 && PHYS_64BIT
 
 config PHYS_64BIT
-	bool
-	depends on 44x
-	default y
+	bool 'Large physical address support' if E500
+	depends on 44x || E500
+	default y if 44x
+	---help---
+	  This option enables kernel support for larger than 32-bit physical
+	  addresses.  This features is not be available on all e500 cores.
+	  
+	  If in doubt, say N here.
 
 config ALTIVEC
 	bool "AltiVec Support"
diff -Nru a/arch/ppc/kernel/head_fsl_booke.S b/arch/ppc/kernel/head_fsl_booke.S
--- a/arch/ppc/kernel/head_fsl_booke.S	2005-04-07 16:19:41 -05:00
+++ b/arch/ppc/kernel/head_fsl_booke.S	2005-04-07 16:19:41 -05:00
@@ -347,6 +347,38 @@
 	mtspr	SPRN_SRR1,r3
 	rfi			/* change context and jump to start_kernel */
 
+/* Macros to hide the PTE size differences 
+ *
+ * FIND_PTE -- walks the page tables given EA & pgdir pointer
+ *   r10 -- EA of fault
+ *   r11 -- PGDIR pointer 
+ *   r12 -- free
+ *   label 2: is the bailout case
+ *
+ * if we find the pte (fall through):
+ *   r11 is low pte word
+ *   r12 is pointer to the pte
+ */
+#ifdef CONFIG_PTE_64BIT
+#define PTE_FLAGS_OFFSET	4
+#define FIND_PTE	\
+	rlwinm 	r12, r10, 13, 19, 29;	/* Compute pgdir/pmd offset */	\
+	lwzx	r11, r12, r11;		/* Get pgd/pmd entry */		\
+	rlwinm.	r12, r11, 0, 0, 20;	/* Extract pt base address */	\
+	beq	2f;			/* Bail if no table */		\
+	rlwimi	r12, r10, 23, 20, 28;	/* Compute pte address */	\
+	lwz	r11, 4(r12);		/* Get pte entry */
+#else
+#define PTE_FLAGS_OFFSET	0
+#define FIND_PTE	\
+	rlwimi	r11, r10, 12, 20, 29;	/* Create L1 (pgdir/pmd) address */	\
+	lwz	r11, 0(r11);		/* Get L1 entry */			\
+	rlwinm.	r12, r11, 0, 0, 19;	/* Extract L2 (pte) base address */	\
+	beq	2f;			/* Bail if no table */			\
+	rlwimi	r12, r10, 22, 20, 29;	/* Compute PTE address */		\
+	lwz	r11, 0(r12);		/* Get Linux PTE */
+#endif
+
 /*
  * Interrupt vector entry code
  *
@@ -405,13 +437,7 @@
 	mfspr	r11,SPRN_SPRG3
 	lwz	r11,PGDIR(r11)
 4:
-	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
-	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
-	beq	2f			/* Bail if no table */
-
-	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
-	lwz	r11, 0(r12)		/* Get Linux PTE */
+	FIND_PTE
 
 	/* Are _PAGE_USER & _PAGE_RW set & _PAGE_HWWRITE not? */
 	andi.	r13, r11, _PAGE_RW|_PAGE_USER|_PAGE_HWWRITE
@@ -420,14 +446,12 @@
 
 	/* Update 'changed'. */
 	ori	r11, r11, _PAGE_DIRTY|_PAGE_ACCESSED|_PAGE_HWWRITE
-	stw	r11, 0(r12)		/* Update Linux page table */
+	stw	r11, PTE_FLAGS_OFFSET(r12) /* Update Linux page table */
 
 	/* MAS2 not updated as the entry does exist in the tlb, this
 	   fault taken to detect state transition (eg: COW -> DIRTY)
 	 */
-	lis	r12, MAS3_RPN@h
-	ori	r12, r12, _PAGE_HWEXEC | MAS3_RPN@l
-	and	r11, r11, r12
+	andi.	r11, r11, _PAGE_HWEXEC
 	rlwimi	r11, r11, 31, 27, 27	/* SX <- _PAGE_HWEXEC */
 	ori     r11, r11, (MAS3_UW|MAS3_SW|MAS3_UR|MAS3_SR)@l /* set static perms */
 
@@ -439,7 +463,10 @@
 	/* find the TLB index that caused the fault.  It has to be here. */
 	tlbsx	0, r10
 
-	mtspr	SPRN_MAS3,r11
+	/* only update the perm bits, assume the RPN is fine */
+	mfspr	r12, SPRN_MAS3
+	rlwimi	r12, r11, 0, 20, 31
+	mtspr	SPRN_MAS3,r12
 	tlbwe
 
 	/* Done...restore registers and get out of here.  */
@@ -530,18 +557,15 @@
 	lwz	r11,PGDIR(r11)
 
 4:
-	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
-	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
-	beq	2f			/* Bail if no table */
-
-	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
-	lwz	r11, 0(r12)		/* Get Linux PTE */
-	andi.	r13, r11, _PAGE_PRESENT
-	beq	2f
-
+	FIND_PTE
+	andi.	r13, r11, _PAGE_PRESENT	/* Is the page present? */
+	beq	2f			/* Bail if not present */
+
+#ifdef CONFIG_PTE_64BIT
+	lwz	r13, 0(r12)
+#endif
 	ori	r11, r11, _PAGE_ACCESSED
-	stw	r11, 0(r12)
+	stw	r11, PTE_FLAGS_OFFSET(r12)
 
 	 /* Jump to common tlb load */
 	b	finish_tlb_load
@@ -594,18 +618,15 @@
 	lwz	r11,PGDIR(r11)
 
 4:
-	rlwimi	r11, r10, 12, 20, 29	/* Create L1 (pgdir/pmd) address */
-	lwz	r11, 0(r11)		/* Get L1 entry */
-	rlwinm.	r12, r11, 0, 0, 19	/* Extract L2 (pte) base address */
-	beq	2f			/* Bail if no table */
-
-	rlwimi	r12, r10, 22, 20, 29	/* Compute PTE address */
-	lwz	r11, 0(r12)		/* Get Linux PTE */
-	andi.	r13, r11, _PAGE_PRESENT
-	beq	2f
-
+	FIND_PTE
+	andi.	r13, r11, _PAGE_PRESENT	/* Is the page present? */
+	beq	2f			/* Bail if not present */
+
+#ifdef CONFIG_PTE_64BIT
+	lwz	r13, 0(r12)
+#endif
 	ori	r11, r11, _PAGE_ACCESSED
-	stw	r11, 0(r12)
+	stw	r11, PTE_FLAGS_OFFSET(r12)
 
 	/* Jump to common TLB load point */
 	b	finish_tlb_load
@@ -690,27 +711,39 @@
 	 */
 
 	mfspr	r12, SPRN_MAS2
+#ifdef CONFIG_PTE_64BIT
+	rlwimi	r12, r11, 26, 24, 31	/* extract ...WIMGE from pte */
+#else
 	rlwimi	r12, r11, 26, 27, 31	/* extract WIMGE from pte */
+#endif
 	mtspr	SPRN_MAS2, r12
 
 	bge	5, 1f
 
-	/* addr > TASK_SIZE */
-	li	r10, (MAS3_UX | MAS3_UW | MAS3_UR)
-	andi.	r13, r11, (_PAGE_USER | _PAGE_HWWRITE | _PAGE_HWEXEC)
-	andi.	r12, r11, _PAGE_USER	/* Test for _PAGE_USER */
-	iseleq	r12, 0, r10
-	and	r10, r12, r13
-	srwi	r12, r10, 1
+	/* is user addr */
+	andi.	r12, r11, (_PAGE_USER | _PAGE_HWWRITE | _PAGE_HWEXEC)
+	andi.	r10, r11, _PAGE_USER	/* Test for _PAGE_USER */
+	srwi	r10, r12, 1
 	or	r12, r12, r10	/* Copy user perms into supervisor */
+	iseleq	r12, 0, r12
 	b	2f
 
-	/* addr <= TASK_SIZE */
+	/* is kernel addr */
 1:	rlwinm	r12, r11, 31, 29, 29	/* Extract _PAGE_HWWRITE into SW */
 	ori	r12, r12, (MAS3_SX | MAS3_SR)
 
+#ifdef CONFIG_PTE_64BIT
+2:	rlwimi	r12, r13, 24, 0, 7	/* grab RPN[32:39] */
+	rlwimi	r12, r11, 24, 8, 19	/* grab RPN[40:51] */
+	mtspr	SPRN_MAS3, r12
+BEGIN_FTR_SECTION
+	srwi	r10, r13, 8		/* grab RPN[8:31] */
+	mtspr	SPRN_MAS7, r10
+END_FTR_SECTION_IFSET(CPU_FTR_BIG_PHYS)
+#else
 2:	rlwimi	r11, r12, 0, 20, 31	/* Extract RPN from PTE and merge with perms */
 	mtspr	SPRN_MAS3, r11
+#endif
 	tlbwe
 
 	/* Done...restore registers and get out of here.  */
diff -Nru a/arch/ppc/syslib/ppc85xx_common.c b/arch/ppc/syslib/ppc85xx_common.c
--- a/arch/ppc/syslib/ppc85xx_common.c	2005-04-07 16:19:41 -05:00
+++ b/arch/ppc/syslib/ppc85xx_common.c	2005-04-07 16:19:41 -05:00
@@ -31,3 +31,11 @@
 }
 
 EXPORT_SYMBOL(get_ccsrbar);
+
+/* For now this is a pass through */
+phys_addr_t fixup_bigphys_addr(phys_addr_t addr, phys_addr_t size)
+{
+	return addr;
+};
+EXPORT_SYMBOL(fixup_bigphys_addr);
+
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	2005-04-07 16:19:41 -05:00
+++ b/include/asm-ppc/cputable.h	2005-04-07 16:19:41 -05:00
@@ -86,8 +86,9 @@
 #define CPU_FTR_DUAL_PLL_750FX		0x00004000
 #define CPU_FTR_NO_DPM			0x00008000
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
-#define CPU_FTR_NEED_COHERENT           0x00020000
+#define CPU_FTR_NEED_COHERENT		0x00020000
 #define CPU_FTR_NO_BTIC			0x00040000
+#define CPU_FTR_BIG_PHYS		0x00080000
 
 #ifdef __ASSEMBLY__
 
diff -Nru a/include/asm-ppc/pgtable.h b/include/asm-ppc/pgtable.h
--- a/include/asm-ppc/pgtable.h	2005-04-07 16:19:41 -05:00
+++ b/include/asm-ppc/pgtable.h	2005-04-07 16:19:41 -05:00
@@ -225,8 +225,7 @@
 /* ERPN in a PTE never gets cleared, ignore it */
 #define _PTE_NONE_MASK	0xffffffff00000000ULL
 
-#elif defined(CONFIG_E500)
-
+#elif defined(CONFIG_FSL_BOOKE)
 /*
    MMU Assist Register 3:
 
@@ -240,21 +239,29 @@
      entries use the top 29 bits.
 */
 
-/* Definitions for e500 core */
-#define _PAGE_PRESENT	0x001	/* S: PTE contains a translation */
-#define _PAGE_USER	0x002	/* S: User page (maps to UR) */
-#define _PAGE_FILE	0x002	/* S: when !present: nonlinear file mapping */
-#define _PAGE_ACCESSED	0x004	/* S: Page referenced */
-#define _PAGE_HWWRITE	0x008	/* H: Dirty & RW, set in exception */
-#define _PAGE_RW	0x010	/* S: Write permission */
-#define _PAGE_HWEXEC	0x020	/* H: UX permission */
-
-#define _PAGE_ENDIAN	0x040	/* H: E bit */
-#define _PAGE_GUARDED	0x080	/* H: G bit */
-#define _PAGE_COHERENT	0x100	/* H: M bit */
-#define _PAGE_NO_CACHE	0x200	/* H: I bit */
-#define _PAGE_WRITETHRU	0x400	/* H: W bit */
-#define _PAGE_DIRTY	0x800	/* S: Page dirty */
+/* Definitions for FSL Book-E Cores */
+#define _PAGE_PRESENT	0x00001	/* S: PTE contains a translation */
+#define _PAGE_USER	0x00002	/* S: User page (maps to UR) */
+#define _PAGE_FILE	0x00002	/* S: when !present: nonlinear file mapping */
+#define _PAGE_ACCESSED	0x00004	/* S: Page referenced */
+#define _PAGE_HWWRITE	0x00008	/* H: Dirty & RW, set in exception */
+#define _PAGE_RW	0x00010	/* S: Write permission */
+#define _PAGE_HWEXEC	0x00020	/* H: UX permission */
+
+#define _PAGE_ENDIAN	0x00040	/* H: E bit */
+#define _PAGE_GUARDED	0x00080	/* H: G bit */
+#define _PAGE_COHERENT	0x00100	/* H: M bit */
+#define _PAGE_NO_CACHE	0x00200	/* H: I bit */
+#define _PAGE_WRITETHRU	0x00400	/* H: W bit */
+
+#ifdef CONFIG_PTE_64BIT
+#define _PAGE_DIRTY	0x08000	/* S: Page dirty */
+
+/* ERPN in a PTE never gets cleared, ignore it */
+#define _PTE_NONE_MASK	0xffffffffffff0000ULL
+#else
+#define _PAGE_DIRTY	0x00800	/* S: Page dirty */
+#endif
 
 #define _PMD_PRESENT	0
 #define _PMD_PRESENT_MASK (PAGE_MASK)
@@ -433,7 +440,11 @@
 
 /* in some case we want to additionaly adjust where the pfn is in the pte to
  * allow room for more flags */
+#if defined(CONFIG_FSL_BOOKE) && defined(CONFIG_PTE_64BIT)
+#define PFN_SHIFT_OFFSET	(PAGE_SHIFT + 8)
+#else
 #define PFN_SHIFT_OFFSET	(PAGE_SHIFT)
+#endif
 
 #define pte_pfn(x)		(pte_val(x) >> PFN_SHIFT_OFFSET)
 #define pte_page(x)		pfn_to_page(pte_pfn(x))
diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h	2005-04-07 16:19:41 -05:00
+++ b/include/asm-ppc/reg_booke.h	2005-04-07 16:19:41 -05:00
@@ -172,6 +172,7 @@
 #define SPRN_MAS4	0x274	/* MMU Assist Register 4 */
 #define SPRN_MAS5	0x275	/* MMU Assist Register 5 */
 #define SPRN_MAS6	0x276	/* MMU Assist Register 6 */
+#define SPRN_MAS7	0x3b0	/* MMU Assist Register 7 */
 #define SPRN_PID1	0x279	/* Process ID Register 1 */
 #define SPRN_PID2	0x27A	/* Process ID Register 2 */
 #define SPRN_TLB0CFG	0x2B0	/* TLB 0 Config Register */

