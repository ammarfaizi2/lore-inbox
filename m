Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUAUXUr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 18:20:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUAUXUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 18:20:47 -0500
Received: from ozlabs.org ([203.10.76.45]:29139 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266153AbUAUXUb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 18:20:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16399.2355.817325.605721@cargo.ozlabs.ibm.com>
Date: Thu, 22 Jan 2004 10:20:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fixes for 2.6.1-rc2-mm1 on PPC
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch is needed to get 2.6.1-rc2-mm1 to compile and work on PPC.
It looks like Ingo (or someone) made changes to the discontiguous file
mapping stuff for x86 and didn't make the corresponding changes for
other archs, so this patch makes the changes for PPC.  I'll do PPC64
as well shortly.  The second part fixes up an update_mmu_cache call
which was incorrect.

Regards,
Paul.

diff -urN linux-2.6.1-rc2-mm1/include/asm-ppc/mman.h test-mm/linux-2.6.1-rc2-mm1/include/asm-ppc/mman.h
--- linux-2.6.1-rc2-mm1/include/asm-ppc/mman.h	2004-01-21 22:25:10.000000000 +1100
+++ test-mm/linux-2.6.1-rc2-mm1/include/asm-ppc/mman.h	2004-01-22 09:42:21.879803984 +1100
@@ -23,6 +23,7 @@
 #define MAP_EXECUTABLE	0x1000		/* mark it as an executable */
 #define MAP_POPULATE	0x8000		/* populate (prefault) pagetables */
 #define MAP_NONBLOCK	0x10000		/* do not block on IO */
+#define MAP_INHERIT	0x20000		/* inherit prot of underlying vma */
 
 #define MS_ASYNC	1		/* sync memory asynchronously */
 #define MS_INVALIDATE	2		/* invalidate the caches */
diff -urN linux-2.6.1-rc2-mm1/include/asm-ppc/pgtable.h test-mm/linux-2.6.1-rc2-mm1/include/asm-ppc/pgtable.h
--- linux-2.6.1-rc2-mm1/include/asm-ppc/pgtable.h	2004-01-21 22:23:20.000000000 +1100
+++ test-mm/linux-2.6.1-rc2-mm1/include/asm-ppc/pgtable.h	2004-01-22 09:41:32.526306856 +1100
@@ -264,8 +264,8 @@
 /* Definitions for 60x, 740/750, etc. */
 #define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
 #define _PAGE_HASHPTE	0x002	/* hash_page has made an HPTE for this pte */
-#define _PAGE_FILE	0x004	/* when !present: nonlinear file mapping */
 #define _PAGE_USER	0x004	/* usermode access allowed */
+#define _PAGE_FILE	0x008	/* when !present: nonlinear file mapping */
 #define _PAGE_GUARDED	0x008	/* G: prohibit speculative access */
 #define _PAGE_COHERENT	0x010	/* M: enforce memory coherence (SMP systems) */
 #define _PAGE_NO_CACHE	0x020	/* I: cache inhibit */
@@ -616,9 +616,16 @@
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
 /* Encode and decode a nonlinear file mapping entry */
-#define PTE_FILE_MAX_BITS	29
-#define pte_to_pgoff(pte)	(pte_val(pte) >> 3)
-#define pgoff_to_pte(off)	((pte_t) { ((off) << 3) | _PAGE_FILE })
+#define PTE_FILE_MAX_BITS	27
+#define pte_to_pgoff(pte)	(((pte_val(pte) & ~0x7ff) >> 5)		\
+				 | ((pte_val(pte) & 0x3f0) >> 4))
+#define pte_to_pgprot(pte)	\
+__pgprot((pte_val(pte) & (_PAGE_USER|_PAGE_RW|_PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot)					\
+	((pte_t) { (((off) << 5) & ~0x7ff) | (((off) << 4) & 0x3f0)	\
+		   | (pgprot_val(prot) & (_PAGE_USER|_PAGE_RW))		\
+		   | _PAGE_FILE })
 
 /* CONFIG_APUS */
 /* For virtual address to physical address conversion */
diff -urN linux-2.6.1-rc2-mm1/mm/filemap.c test-mm/linux-2.6.1-rc2-mm1/mm/filemap.c
--- linux-2.6.1-rc2-mm1/mm/filemap.c	2004-01-21 22:25:46.000000000 +1100
+++ test-mm/linux-2.6.1-rc2-mm1/mm/filemap.c	2004-01-22 10:15:36.735539816 +1100
@@ -40,6 +40,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/mman.h>
+#include <asm/tlbflush.h>
 
 /*
  * Shared mappings implemented 30.11.1994. It's not fully working yet,
@@ -1483,7 +1484,7 @@
 				flush_icache_page(vma, *tmp);
 				set_pte(pte, mk_pte(*tmp, prot));
 				pte_chain = page_add_rmap(*tmp, pte, pte_chain);
-				update_mmu_cache(vma, addr, *pte_val);
+				update_mmu_cache(vma, addr, *pte);
 
 				tmp++;
 				nr_pages--;
