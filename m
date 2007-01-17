Return-Path: <linux-kernel-owner+w=401wt.eu-S1751796AbXAQIUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbXAQIUv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 03:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbXAQIUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 03:20:51 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:22291
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751796AbXAQIUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 03:20:50 -0500
Message-Id: <45ADEAD7.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 17 Jan 2007 08:22:31 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: adjustments to page table dump during oops (v2)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like this to replace the previously sent patch under the same title,
applied as i386-adjustments-to-page-table-dump-during-oops.patch in -mm.
If an incremental patch on top of the previous one is absolutely
required, I can certainly also generate that.

- make the page table contents printing PAE capable
- make sure the address stored in current->thread.cr2 is unmodified from
  what was read from CR2
- don't call oops_may_print() multiple times, when one time suffices
- print pte even in highpte case, as long as the pte page isn't in
  actually in high memory (which is specifically the case for all page
  tables covering kernel space)

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.20-rc5/arch/i386/mm/fault.c	2007-01-15 14:09:19.000000000 +0100
+++ 2.6.20-rc5-i386-page-fault-dump/arch/i386/mm/fault.c	2007-01-17 08:48:49.000000000 +0100
@@ -327,7 +327,6 @@ fastcall void __kprobes do_page_fault(st
 	struct mm_struct *mm;
 	struct vm_area_struct * vma;
 	unsigned long address;
-	unsigned long page;
 	int write, si_code;
 
 	/* get the address */
@@ -538,7 +537,16 @@ no_context:
 	bust_spinlocks(1);
 
 	if (oops_may_print()) {
-	#ifdef CONFIG_X86_PAE
+#ifndef CONFIG_X86_PAE
+		typedef unsigned long pgt_t;
+#define PRIpgt "08lx"
+#else
+		typedef unsigned long long pgt_t;
+#define PRIpgt "016Lx"
+#endif
+		pgt_t page;
+
+#ifdef CONFIG_X86_PAE
 		if (error_code & 16) {
 			pte_t *pte = lookup_address(address);
 
@@ -547,7 +555,7 @@ no_context:
 					"NX-protected page - exploit attempt? "
 					"(uid: %d)\n", current->uid);
 		}
-	#endif
+#endif
 		if (address < PAGE_SIZE)
 			printk(KERN_ALERT "BUG: unable to handle kernel NULL "
 					"pointer dereference");
@@ -557,25 +565,41 @@ no_context:
 		printk(" at virtual address %08lx\n",address);
 		printk(KERN_ALERT " printing eip:\n");
 		printk("%08lx\n", regs->eip);
-	}
-	page = read_cr3();
-	page = ((unsigned long *) __va(page))[address >> 22];
-	if (oops_may_print())
-		printk(KERN_ALERT "*pde = %08lx\n", page);
-	/*
-	 * We must not directly access the pte in the highpte
-	 * case, the page table might be allocated in highmem.
-	 * And lets rather not kmap-atomic the pte, just in case
-	 * it's allocated already.
-	 */
-#ifndef CONFIG_HIGHPTE
-	if ((page & 1) && oops_may_print()) {
-		page &= PAGE_MASK;
-		address &= 0x003ff000;
-		page = ((unsigned long *) __va(page))[address >> PAGE_SHIFT];
-		printk(KERN_ALERT "*pte = %08lx\n", page);
-	}
+
+		page = read_cr3();
+		page = ((pgt_t *) __va(page))[address >> PGDIR_SHIFT];
+#ifdef CONFIG_X86_PAE
+		printk(KERN_ALERT "*pdpt = %"PRIpgt"\n", page);
+		if (page & 1) {
+			page &= PAGE_MASK;
+			page = ((pgt_t *) __va(page))[(address >> PMD_SHIFT)
+			                              & (PTRS_PER_PMD - 1)];
+			printk(KERN_ALERT "*pde = %"PRIpgt"\n", page);
+			page &= ~_PAGE_NX;
+		}
+#else
+		printk(KERN_ALERT "*pde = %"PRIpgt"\n", page);
+#endif
+
+#ifdef CONFIG_HIGHPTE
+		/*
+		 * We must not directly access the pte in the highpte
+		 * case if the page table is located in highmem.
+		 * And lets rather not kmap-atomic the pte, just in case
+		 * it's allocated already.
+		 */
+		if ((page >> PAGE_SHIFT) >= highstart_pfn)
+			page = 0;
 #endif
+		if (page & 1) {
+			page &= PAGE_MASK;
+			page = ((pgt_t *) __va(page))[(address >> PAGE_SHIFT)
+			                              & (PTRS_PER_PTE - 1)];
+			printk(KERN_ALERT "*pte = %"PRIpgt"\n", page);
+		}
+#undef PRIpgt
+	}
+
 	tsk->thread.cr2 = address;
 	tsk->thread.trap_no = 14;
 	tsk->thread.error_code = error_code;


