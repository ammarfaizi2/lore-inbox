Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262180AbVCHX1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262180AbVCHX1V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 18:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVCHXXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 18:23:36 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:34029 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261602AbVCHXT1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 18:19:27 -0500
Date: Tue, 8 Mar 2005 17:13:26 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Anton Blanchard <anton@samba.org>, paulus@samba.org
Subject: [PATCH 2/2] No-exec support for ppc64
Message-Id: <20050308171326.3d72363a.moilanen@austin.ibm.com>
In-Reply-To: <20050308165904.0ce07112.moilanen@austin.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No-exec support for the kernel on PPC64.

This will mark all non-text kernel pages as no-execute.  

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---

 linux-2.6-bk-moilanen/arch/ppc64/kernel/iSeries_setup.c |    7 +++
 linux-2.6-bk-moilanen/arch/ppc64/kernel/module.c        |    3 +
 linux-2.6-bk-moilanen/arch/ppc64/mm/fault.c             |   25 ++++++++++++
 linux-2.6-bk-moilanen/arch/ppc64/mm/hash_utils.c        |   31 ++++++++++++----
 linux-2.6-bk-moilanen/include/asm-ppc64/pgtable.h       |    1 
 5 files changed, 59 insertions(+), 8 deletions(-)

diff -puN arch/ppc64/kernel/iSeries_setup.c~nx-kernel-ppc64 arch/ppc64/kernel/iSeries_setup.c
--- linux-2.6-bk/arch/ppc64/kernel/iSeries_setup.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/iSeries_setup.c	2005-03-08 16:08:57 -06:00
@@ -624,6 +624,7 @@ static void __init iSeries_bolt_kernel(u
 {
 	unsigned long pa;
 	unsigned long mode_rw = _PAGE_ACCESSED | _PAGE_COHERENT | PP_RWXX;
+	unsigned long tmp_mode;
 	HPTE hpte;
 
 	for (pa = saddr; pa < eaddr ;pa += PAGE_SIZE) {
@@ -632,6 +633,12 @@ static void __init iSeries_bolt_kernel(u
 		unsigned long va = (vsid << 28) | (pa & 0xfffffff);
 		unsigned long vpn = va >> PAGE_SHIFT;
 		unsigned long slot = HvCallHpt_findValid(&hpte, vpn);
+
+		tmp_mode = mode_rw;
+
+		/* Make non-kernel text non-executable */
+		if (!is_kernel_text(ea))
+			tmp_mode = mode_rw | HW_NO_EXEC;
 
 		if (hpte.dw0.dw0.v) {
 			/* HPTE exists, so just bolt it */
diff -puN arch/ppc64/kernel/module.c~nx-kernel-ppc64 arch/ppc64/kernel/module.c
--- linux-2.6-bk/arch/ppc64/kernel/module.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/kernel/module.c	2005-03-08 16:08:57 -06:00
@@ -102,7 +102,8 @@ void *module_alloc(unsigned long size)
 {
 	if (size == 0)
 		return NULL;
-	return vmalloc(size);
+
+	return vmalloc_exec(size);
 }
 
 /* Free memory returned from module_alloc */
diff -puN arch/ppc64/mm/fault.c~nx-kernel-ppc64 arch/ppc64/mm/fault.c
--- linux-2.6-bk/arch/ppc64/mm/fault.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/mm/fault.c	2005-03-08 16:08:57 -06:00
@@ -76,6 +76,21 @@ static int store_updates_sp(struct pt_re
 	return 0;
 }
 
+pte_t *lookup_address(unsigned long address) 
+{ 
+	pgd_t *pgd = pgd_offset_k(address); 
+	pmd_t *pmd;
+
+	if (pgd_none(*pgd))
+		return NULL;
+
+	pmd = pmd_offset(pgd, address); 	       
+	if (pmd_none(*pmd))
+		return NULL;
+
+        return pte_offset_kernel(pmd, address);
+} 
+
 /*
  * The error_code parameter is
  *  - DSISR for a non-SLB data access fault,
@@ -94,6 +109,7 @@ int do_page_fault(struct pt_regs *regs, 
 	unsigned long is_write = error_code & 0x02000000;
 	unsigned long trap = TRAP(regs);
  	unsigned long is_exec = trap == 0x400;	
+	pte_t *ptep;
 
 	BUG_ON((trap == 0x380) || (trap == 0x480));
 
@@ -253,6 +269,15 @@ bad_area_nosemaphore:
 		info.si_addr = (void __user *) address;
 		force_sig_info(SIGSEGV, &info, current);
 		return 0;
+	} 
+
+	ptep = lookup_address(address);
+
+	if (ptep && pte_present(*ptep) && !pte_exec(*ptep)) {
+		if (printk_ratelimit())
+			printk(KERN_CRIT "kernel tried to execute NX-protected page - exploit attempt? (uid: %d)\n", current->uid);
+		show_stack(current, (unsigned long *)__get_SP());
+		do_exit(SIGKILL);
 	}
 
 	return SIGSEGV;
diff -puN arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64 arch/ppc64/mm/hash_utils.c
--- linux-2.6-bk/arch/ppc64/mm/hash_utils.c~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
+++ linux-2.6-bk-moilanen/arch/ppc64/mm/hash_utils.c	2005-03-08 16:08:57 -06:00
@@ -51,6 +51,7 @@
 #include <asm/cacheflush.h>
 #include <asm/cputable.h>
 #include <asm/abs_addr.h>
+#include <asm/sections.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -89,12 +90,23 @@ static inline void loop_forever(void)
 		;
 }
 
+int is_kernel_text(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext && addr < (unsigned long)__init_end)
+		return 1;
+
+	return 0;
+}
+
+
+
 #ifdef CONFIG_PPC_MULTIPLATFORM
 static inline void create_pte_mapping(unsigned long start, unsigned long end,
 				      unsigned long mode, int large)
 {
 	unsigned long addr;
 	unsigned int step;
+	unsigned long tmp_mode;
 
 	if (large)
 		step = 16*MB;
@@ -112,6 +124,13 @@ static inline void create_pte_mapping(un
 		else
 			vpn = va >> PAGE_SHIFT;
 
+
+		tmp_mode = mode;
+		
+		/* Make non-kernel text non-executable */
+		if (!is_kernel_text(addr))
+			tmp_mode = mode | HW_NO_EXEC;
+
 		hash = hpt_hash(vpn, large);
 
 		hpteg = ((hash & htab_hash_mask) * HPTES_PER_GROUP);
@@ -120,12 +139,12 @@ static inline void create_pte_mapping(un
 		if (systemcfg->platform & PLATFORM_LPAR)
 			ret = pSeries_lpar_hpte_insert(hpteg, va,
 				virt_to_abs(addr) >> PAGE_SHIFT,
-				0, mode, 1, large);
+				0, tmp_mode, 1, large);
 		else
 #endif /* CONFIG_PPC_PSERIES */
 			ret = native_hpte_insert(hpteg, va,
 				virt_to_abs(addr) >> PAGE_SHIFT,
-				0, mode, 1, large);
+				0, tmp_mode, 1, large);
 
 		if (ret == -1) {
 			ppc64_terminate_msg(0x20, "create_pte_mapping");
@@ -238,8 +257,6 @@ unsigned int hash_page_do_lazy_icache(un
 {
 	struct page *page;
 
-#define PPC64_HWNOEXEC (1 << 2)
-
 	if (!pfn_valid(pte_pfn(pte)))
 		return pp;
 
@@ -250,8 +267,8 @@ unsigned int hash_page_do_lazy_icache(un
 		if (trap == 0x400) {
 			__flush_dcache_icache(page_address(page));
 			set_bit(PG_arch_1, &page->flags);
-		} else
-			pp |= PPC64_HWNOEXEC;
+		} else 
+			pp |= HW_NO_EXEC;
 	}
 	return pp;
 }
@@ -271,7 +288,7 @@ int hash_page(unsigned long ea, unsigned
 	int user_region = 0;
 	int local = 0;
 	cpumask_t tmp;
-
+	
  	switch (REGION_ID(ea)) {
 	case USER_REGION_ID:
 		user_region = 1;
diff -puN include/asm-ppc64/pgtable.h~nx-kernel-ppc64 include/asm-ppc64/pgtable.h
--- linux-2.6-bk/include/asm-ppc64/pgtable.h~nx-kernel-ppc64	2005-03-08 16:08:57 -06:00
+++ linux-2.6-bk-moilanen/include/asm-ppc64/pgtable.h	2005-03-08 16:08:57 -06:00
@@ -116,6 +116,7 @@
 #define PAGE_READONLY	__pgprot(_PAGE_BASE | _PAGE_USER)
 #define PAGE_READONLY_X	__pgprot(_PAGE_BASE | _PAGE_USER | _PAGE_EXEC)
 #define PAGE_KERNEL	__pgprot(_PAGE_BASE | _PAGE_WRENABLE)
+#define PAGE_KERNEL_EXEC __pgprot(_PAGE_BASE | _PAGE_WRENABLE | _PAGE_EXEC)
 
 #define HW_NO_EXEC	_PAGE_EXEC /* This is used when the bit is
 				    * inverted, even though it's the

_
