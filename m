Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129453AbQKRQy6>; Sat, 18 Nov 2000 11:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbQKRQys>; Sat, 18 Nov 2000 11:54:48 -0500
Received: from ha1.rdc2.mi.home.com ([24.2.68.68]:4228 "EHLO
	mail.rdc2.mi.home.com") by vger.kernel.org with ESMTP
	id <S129453AbQKRQyd>; Sat, 18 Nov 2000 11:54:33 -0500
Message-ID: <3A16ACD6.71BAF564@didntduck.org>
Date: Sat, 18 Nov 2000 11:22:46 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11-pre5-mm i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86 mm init cleanup
Content-Type: multipart/mixed;
 boundary="------------FAEF64C96ED89542039D7595"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------FAEF64C96ED89542039D7595
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Patch against test11.  This patch moves the setting of %cr4 out of the
loops and makes the code a bit more readable.  Tested with standard
pagetables, PSE, and PAE.

-- 

						Brian Gerst
--------------FAEF64C96ED89542039D7595
Content-Type: text/plain; charset=us-ascii;
 name="mminit.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mminit.diff"

diff -urN linux-2.4.0t11p5/arch/i386/mm/init.c linux/arch/i386/mm/init.c
--- linux-2.4.0t11p5/arch/i386/mm/init.c	Mon Oct 23 17:42:33 2000
+++ linux/arch/i386/mm/init.c	Thu Nov 16 20:55:20 2000
@@ -315,7 +315,7 @@
 
 static void __init pagetable_init (void)
 {
-	unsigned long vaddr, end;
+	unsigned long vaddr, end, __pe;
 	pgd_t *pgd, *pgd_base;
 	int i, j, k;
 	pmd_t *pmd;
@@ -334,11 +334,23 @@
 		__pgd_clear(pgd);
 	}
 #endif
-	i = __pgd_offset(PAGE_OFFSET);
+
+	__pe = _KERNPG_TABLE;
+	if (cpu_has_pse) {
+		set_in_cr4(X86_CR4_PSE);
+		__pe += _PAGE_PSE;
+		boot_cpu_data.wp_works_ok = 1;
+		if (cpu_has_pge) {
+			set_in_cr4(X86_CR4_PGE);
+			__pe += _PAGE_GLOBAL;
+		}
+	}
+
+	vaddr = PAGE_OFFSET;
+	i = __pgd_offset(vaddr);
 	pgd = pgd_base + i;
 
 	for (; i < PTRS_PER_PGD; pgd++, i++) {
-		vaddr = i*PGDIR_SIZE;
 		if (end && (vaddr >= end))
 			break;
 #if CONFIG_X86_PAE
@@ -350,35 +362,24 @@
 		if (pmd != pmd_offset(pgd, 0))
 			BUG();
 		for (j = 0; j < PTRS_PER_PMD; pmd++, j++) {
-			vaddr = i*PGDIR_SIZE + j*PMD_SIZE;
 			if (end && (vaddr >= end))
 				break;
 			if (cpu_has_pse) {
-				unsigned long __pe;
-
-				set_in_cr4(X86_CR4_PSE);
-				boot_cpu_data.wp_works_ok = 1;
-				__pe = _KERNPG_TABLE + _PAGE_PSE + __pa(vaddr);
-				/* Make it "global" too if supported */
-				if (cpu_has_pge) {
-					set_in_cr4(X86_CR4_PGE);
-					__pe += _PAGE_GLOBAL;
+				set_pmd(pmd, __pmd(__pe + __pa(vaddr)));
+				vaddr += PMD_SIZE;
+			} else {
+				pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+				set_pmd(pmd, __pmd(__pe + __pa(pte)));
+
+				if (pte != pte_offset(pmd, 0))
+					BUG();
+
+				for (k = 0; k < PTRS_PER_PTE; pte++, k++) {
+					if (end && (vaddr >= end))
+						break;
+					*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
+					vaddr += PAGE_SIZE;
 				}
-				set_pmd(pmd, __pmd(__pe));
-				continue;
-			}
-
-			pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-			set_pmd(pmd, __pmd(_KERNPG_TABLE + __pa(pte)));
-
-			if (pte != pte_offset(pmd, 0))
-				BUG();
-
-			for (k = 0; k < PTRS_PER_PTE; pte++, k++) {
-				vaddr = i*PGDIR_SIZE + j*PMD_SIZE + k*PAGE_SIZE;
-				if (end && (vaddr >= end))
-					break;
-				*pte = mk_pte_phys(__pa(vaddr), PAGE_KERNEL);
 			}
 		}
 	}

--------------FAEF64C96ED89542039D7595--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
