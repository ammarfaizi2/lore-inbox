Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUEYVq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUEYVq4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 17:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265115AbUEYVpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 17:45:51 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:13000
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265106AbUEYVo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 17:44:57 -0400
Date: Tue, 25 May 2004 23:44:50 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525214450.GH29378@dualathlon.random>
References: <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org> <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525212720.GG29378@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525212720.GG29378@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

in the previous email I attached a slightly older version of the patch
that didn't optimize the spurious tlb flush away from do_wp_page yet,
this is the latest version I tested:

Index: linux-2.5/include/asm-alpha/pgtable.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/asm-alpha/pgtable.h,v
retrieving revision 1.22
diff -u -p -r1.22 pgtable.h
--- linux-2.5/include/asm-alpha/pgtable.h	23 May 2004 05:02:25 -0000	1.22
+++ linux-2.5/include/asm-alpha/pgtable.h	25 May 2004 20:34:11 -0000
@@ -267,6 +267,28 @@ extern inline pte_t pte_mkexec(pte_t pte
 extern inline pte_t pte_mkdirty(pte_t pte)	{ pte_val(pte) |= __DIRTY_BITS; return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ pte_val(pte) |= __ACCESS_BITS; return pte; }
 
+static inline void ptep_handle_young_page_fault(pte_t *ptep)
+{
+	/*
+	 * WARNING: this is safe only because the dirty bit
+	 * cannot change trasparently in hardware in the pte.
+	 * If the dirty bit in the pte would be set trasparently
+	 * by the CPU this should be implemented with set_bit()
+	 * or with a new set_mask64() implementing an atomic "or".
+	 */
+	set_pte(ptep, pte_mkyoung(*ptep));
+}
+
+static inline void ptep_handle_dirty_page_fault(pte_t *ptep)
+{
+	/*
+	 * This can run without atomic instructions even if
+	 * the young bit is set in hardware by the architecture.
+	 * Losing the young bit is not important.
+	 */
+	set_pte(ptep, pte_mkdirty(*ptep));
+}
+
 #define PAGE_DIR_OFFSET(tsk,address) pgd_offset((tsk),(address))
 
 /* to find an entry in a kernel page-table-directory */
Index: linux-2.5/include/asm-generic/pgtable.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/asm-generic/pgtable.h,v
retrieving revision 1.4
diff -u -p -r1.4 pgtable.h
--- linux-2.5/include/asm-generic/pgtable.h	19 Jan 2004 18:43:03 -0000	1.4
+++ linux-2.5/include/asm-generic/pgtable.h	25 May 2004 20:38:39 -0000
@@ -12,6 +12,7 @@
  */
 #define ptep_establish(__vma, __address, __ptep, __entry)		\
 do {									\
+	BUG_ON(!pte_dirty(__entry));					\
 	set_pte(__ptep, __entry);					\
 	flush_tlb_page(__vma, __address);				\
 } while (0)
Index: linux-2.5/include/asm-i386/pgtable.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/asm-i386/pgtable.h,v
retrieving revision 1.42
diff -u -p -r1.42 pgtable.h
--- linux-2.5/include/asm-i386/pgtable.h	23 May 2004 05:02:25 -0000	1.42
+++ linux-2.5/include/asm-i386/pgtable.h	25 May 2004 20:27:00 -0000
@@ -220,7 +220,19 @@ static inline pte_t pte_mkdirty(pte_t pt
 static inline pte_t pte_mkyoung(pte_t pte)	{ (pte).pte_low |= _PAGE_ACCESSED; return pte; }
 static inline pte_t pte_mkwrite(pte_t pte)	{ (pte).pte_low |= _PAGE_RW; return pte; }
 
+/*
+ * This is used only to set the dirty bit during a "dirty" page fault.
+ * Nothing to do on x86 since it's set by the hardware transparently
+ * and it cannot generate page faults.
+ */
+#define ptep_handle_dirty_page_fault(ptep) do { } while (0)
 static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
+/*
+ * This is used only to set the young bit during a "young" page fault.
+ * Nothing to do on x86 since it's set by the hardware transparently
+ * and it cannot generate page faults.
+ */
+#define ptep_handle_young_page_fault(ptep) do { } while (0)
 static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, &ptep->pte_low); }
 static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, &ptep->pte_low); }
 static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, &ptep->pte_low); }
Index: linux-2.5/include/asm-x86_64/pgtable.h
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/include/asm-x86_64/pgtable.h,v
retrieving revision 1.27
diff -u -p -r1.27 pgtable.h
--- linux-2.5/include/asm-x86_64/pgtable.h	23 May 2004 05:02:25 -0000	1.27
+++ linux-2.5/include/asm-x86_64/pgtable.h	25 May 2004 20:27:28 -0000
@@ -262,7 +262,19 @@ extern inline pte_t pte_mkexec(pte_t pte
 extern inline pte_t pte_mkdirty(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_DIRTY)); return pte; }
 extern inline pte_t pte_mkyoung(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_ACCESSED)); return pte; }
 extern inline pte_t pte_mkwrite(pte_t pte)	{ set_pte(&pte, __pte(pte_val(pte) | _PAGE_RW)); return pte; }
+/*
+ * This is used only to set the dirty bit during a "dirty" page fault.
+ * Nothing to do on x86-64 since it's set by the hardware transparently
+ * and it cannot generate page faults.
+ */
+#define ptep_handle_dirty_page_fault(ptep) do { } while (0)
 static inline  int ptep_test_and_clear_dirty(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_DIRTY, ptep); }
+/*
+ * This is used only to set the young bit during a "young" page fault.
+ * Nothing to do on x86-64 since it's set by the hardware transparently
+ * and it cannot generate page faults.
+ */
+#define ptep_handle_young_page_fault(ptep) do { } while(0)
 static inline  int ptep_test_and_clear_young(pte_t *ptep)	{ return test_and_clear_bit(_PAGE_BIT_ACCESSED, ptep); }
 static inline void ptep_set_wrprotect(pte_t *ptep)		{ clear_bit(_PAGE_BIT_RW, ptep); }
 static inline void ptep_mkdirty(pte_t *ptep)			{ set_bit(_PAGE_BIT_DIRTY, ptep); }
Index: linux-2.5/mm/memory.c
===================================================================
RCS file: /home/andrea/crypto/cvs/linux-2.5/mm/memory.c,v
retrieving revision 1.169
diff -u -p -r1.169 memory.c
--- linux-2.5/mm/memory.c	23 May 2004 05:10:11 -0000	1.169
+++ linux-2.5/mm/memory.c	25 May 2004 21:20:11 -0000
@@ -1056,7 +1056,7 @@ static int do_wp_page(struct mm_struct *
 			flush_cache_page(vma, address);
 			entry = maybe_mkwrite(pte_mkyoung(pte_mkdirty(pte)),
 					      vma);
-			ptep_establish(vma, address, page_table, entry);
+			set_pte(page_table, entry);
 			update_mmu_cache(vma, address, entry);
 			pte_unmap(page_table);
 			spin_unlock(&mm->page_table_lock);
@@ -1643,10 +1643,9 @@ static inline int handle_pte_fault(struc
 		if (!pte_write(entry))
 			return do_wp_page(mm, vma, address, pte, pmd, entry);
 
-		entry = pte_mkdirty(entry);
+		ptep_handle_dirty_page_fault(pte);
 	}
-	entry = pte_mkyoung(entry);
-	ptep_establish(vma, address, pte, entry);
+	ptep_handle_young_page_fault(pte);
 	update_mmu_cache(vma, address, entry);
 	pte_unmap(pte);
 	spin_unlock(&mm->page_table_lock);
Signed-off-by: Andrea Arcangeli <andrea@suse.de>
