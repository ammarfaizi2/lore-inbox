Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262061AbULQN21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262061AbULQN21 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Dec 2004 08:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbULQN1r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Dec 2004 08:27:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33200 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262061AbULQN1d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Dec 2004 08:27:33 -0500
From: David Howells <dhowells@redhat.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] FRV pagetable handling fixes
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.3
Date: Fri, 17 Dec 2004 13:27:21 +0000
Message-ID: <2219.1103290041@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch makes the following fixes to the frv arch:

 (1) pte_offset() should no longer be around; the fault handler should use
     pte_offset_kernel() instead when fixing up vmalloc misses.

 (2) The PGEs/PMEs do not hold PTEs. They have greater address resolution and
     fewer control bits.

 (3) The data access error pattern in ESR15.EC should be 10000 not 10100.

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat frv-pagetable-fixes-2610rc3mm1.diff 
 arch/frv/mm/fault.c        |    2 +-
 arch/frv/mm/pgalloc.c      |    2 +-
 include/asm-frv/pgtable.h  |    3 +--
 include/asm-frv/spr-regs.h |    2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff -uNrp linux-2.6.10-rc3-mm1-asmoffsets/arch/frv/mm/fault.c linux-2.6.10-rc3-mm1-debug/arch/frv/mm/fault.c
--- linux-2.6.10-rc3-mm1-asmoffsets/arch/frv/mm/fault.c	2004-12-13 17:33:50.000000000 +0000
+++ linux-2.6.10-rc3-mm1-debug/arch/frv/mm/fault.c	2004-12-17 12:25:20.000000000 +0000
@@ -315,7 +315,7 @@ asmlinkage void do_page_fault(int datamm
 			goto no_context;
 		set_pmd(pmd, *pmd_k);
 
-		pte_k = pte_offset(pmd_k, ear0);
+		pte_k = pte_offset_kernel(pmd_k, ear0);
 		if (!pte_present(*pte_k))
 			goto no_context;
 		return;
diff -uNrp linux-2.6.10-rc3-mm1-asmoffsets/arch/frv/mm/pgalloc.c linux-2.6.10-rc3-mm1-debug/arch/frv/mm/pgalloc.c
--- linux-2.6.10-rc3-mm1-asmoffsets/arch/frv/mm/pgalloc.c	2004-12-13 17:33:50.000000000 +0000
+++ linux-2.6.10-rc3-mm1-debug/arch/frv/mm/pgalloc.c	2004-12-17 11:40:57.000000000 +0000
@@ -52,7 +52,7 @@ void __set_pmd(pmd_t *pmdptr, unsigned l
 		memset(__ste_p, 0, PME_SIZE);
 	}
 	else {
-		BUG_ON(pmd & xAMPRx_SS);
+		BUG_ON(pmd & (0x3f00 | xAMPRx_SS | 0xe));
 
 		for (loop = PME_SIZE; loop > 0; loop -= 4) {
 			*__ste_p++ = pmd;
diff -uNrp linux-2.6.10-rc3-mm1-asmoffsets/include/asm-frv/pgtable.h linux-2.6.10-rc3-mm1-debug/include/asm-frv/pgtable.h
--- linux-2.6.10-rc3-mm1-asmoffsets/include/asm-frv/pgtable.h	2004-12-13 17:34:20.000000000 +0000
+++ linux-2.6.10-rc3-mm1-debug/include/asm-frv/pgtable.h	2004-12-17 12:25:46.976552819 +0000
@@ -255,7 +255,7 @@ static inline pmd_t *pmd_offset(pgd_t *d
 #define PAGE_KERNEL_RO		MAKE_GLOBAL(__PAGE_KERNEL_RO)
 #define PAGE_KERNEL_NOCACHE	MAKE_GLOBAL(__PAGE_KERNEL_NOCACHE)
 
-#define _PAGE_TABLE		(_PAGE_PRESENT | xAMPRx_SS_16Kb | xAMPRx_D | _PAGE_ACCESSED)
+#define _PAGE_TABLE		(_PAGE_PRESENT | xAMPRx_SS_16Kb)
 
 #ifndef __ASSEMBLY__
 
@@ -385,7 +385,6 @@ static inline pte_t pte_modify(pte_t pte
 
 /* Find an entry in the third-level page table.. */
 #define __pte_index(address) ((address >> PAGE_SHIFT) & (PTRS_PER_PTE - 1))
-#define pte_offset(dir, address) ((pte_t *) pmd_page(*(dir)) + __pte_index(address))
 
 /*
  * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
diff -uNrp linux-2.6.10-rc3-mm1-asmoffsets/include/asm-frv/spr-regs.h linux-2.6.10-rc3-mm1-debug/include/asm-frv/spr-regs.h
--- linux-2.6.10-rc3-mm1-asmoffsets/include/asm-frv/spr-regs.h	2004-12-13 17:34:21.000000000 +0000
+++ linux-2.6.10-rc3-mm1-debug/include/asm-frv/spr-regs.h	2004-12-17 13:10:24.651384378 +0000
@@ -204,7 +204,7 @@
 #define ESRx_EC_PRIV_INSN	0x00000008	/* - privileged_instruction */
 #define ESRx_EC_ILL_INSN	0x0000000a	/* - illegal_instruction */
 #define ESRx_EC_MP_EXCEP	0x0000001c	/* - mp_exception */
-#define ESRx_EC_DATA_ACCESS	0x00000024	/* - data_access_error */
+#define ESRx_EC_DATA_ACCESS	0x00000020	/* - data_access_error */
 #define ESRx_EC_DIVISION	0x00000026	/* - division_exception */
 #define ESRx_EC_ITLB_MISS	0x00000034	/* - instruction_access_TLB_miss */
 #define ESRx_EC_DTLB_MISS	0x00000036	/* - data_access_TLB_miss */
