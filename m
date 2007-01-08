Return-Path: <linux-kernel-owner+w=401wt.eu-S1751535AbXAHN2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbXAHN2l (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 08:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751538AbXAHN2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 08:28:40 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25622
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751535AbXAHN2k (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 08:28:40 -0500
Message-Id: <45A2556B.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 08 Jan 2007 13:30:03 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: adjustments to page table dump during oops
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- make the page table contents printing PAE capable
- make sure the address stored in current->thread.cr2 is unmodified from
  what was read from CR2
- don't call oops_may_print() multiple times, when one time suffices

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.20-rc4/arch/i386/mm/fault.c	2007-01-08 09:57:20.000000000 +0100
+++ 2.6.20-rc4-x86-page-fault-dump/arch/i386/mm/fault.c	2007-01-05 13:38:28.000000000 +0100
@@ -327,7 +327,6 @@ fastcall void __kprobes do_page_fault(st
 	struct mm_struct *mm;
 	struct vm_area_struct * vma;
 	unsigned long address;
-	unsigned long page;
 	int write, si_code;
 
 	/* get the address */
@@ -538,7 +537,12 @@ no_context:
 	bust_spinlocks(1);
 
 	if (oops_may_print()) {
-	#ifdef CONFIG_X86_PAE
+		unsigned long page;
+#ifndef CONFIG_X86_PAE
+		typedef unsigned long pgt_t;
+#else
+		typedef unsigned long long pgt_t;
+
 		if (error_code & 16) {
 			pte_t *pte = lookup_address(address);
 
@@ -547,7 +551,7 @@ no_context:
 					"NX-protected page - exploit attempt? "
 					"(uid: %d)\n", current->uid);
 		}
-	#endif
+#endif
 		if (address < PAGE_SIZE)
 			printk(KERN_ALERT "BUG: unable to handle kernel NULL "
 					"pointer dereference");
@@ -557,25 +561,37 @@ no_context:
 		printk(" at virtual address %08lx\n",address);
 		printk(KERN_ALERT " printing eip:\n");
 		printk("%08lx\n", regs->eip);
-	}
-	page = read_cr3();
-	page = ((unsigned long *) __va(page))[address >> 22];
-	if (oops_may_print())
+
+		page = read_cr3();
+		page = ((pgt_t *) __va(page))[address >> PGDIR_SHIFT];
+#ifdef CONFIG_X86_PAE
+		printk(KERN_ALERT "*pdpt = %08lx\n", page);
+		if (page & 1) {
+			page &= PAGE_MASK;
+			page = ((pgt_t *) __va(page))[(address >> PMD_SHIFT)
+			                              & (PTRS_PER_PMD - 1)];
+			printk(KERN_ALERT "*pde = %08lx\n", page);
+		}
+#else
 		printk(KERN_ALERT "*pde = %08lx\n", page);
-	/*
-	 * We must not directly access the pte in the highpte
-	 * case, the page table might be allocated in highmem.
-	 * And lets rather not kmap-atomic the pte, just in case
-	 * it's allocated already.
-	 */
+#endif
+
+		/*
+		 * We must not directly access the pte in the highpte
+		 * case, the page table might be allocated in highmem.
+		 * And lets rather not kmap-atomic the pte, just in case
+		 * it's allocated already.
+		 */
 #ifndef CONFIG_HIGHPTE
-	if ((page & 1) && oops_may_print()) {
-		page &= PAGE_MASK;
-		address &= 0x003ff000;
-		page = ((unsigned long *) __va(page))[address >> PAGE_SHIFT];
-		printk(KERN_ALERT "*pte = %08lx\n", page);
-	}
+		if (page & 1) {
+			page &= PAGE_MASK;
+			page = ((pgt_t *) __va(page))[(address >> PAGE_SHIFT)
+			                              & (PTRS_PER_PTE - 1)];
+			printk(KERN_ALERT "*pte = %08lx\n", page);
+		}
 #endif
+	}
+
 	tsk->thread.cr2 = address;
 	tsk->thread.trap_no = 14;
 	tsk->thread.error_code = error_code;


