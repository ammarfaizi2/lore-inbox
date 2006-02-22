Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932202AbWBVLGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWBVLGE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 06:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWBVLF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 06:05:57 -0500
Received: from lyle.provo.novell.com ([137.65.81.174]:30404 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S932075AbWBVLFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 06:05:43 -0500
From: Jan Beulich <jbeulich@novell.com>
To: akpm@osdl.org
Subject: [PATCH] i386: actively synchronize vmalloc area when registering certain callbacks
Date: Wed, 22 Feb 2006 12:03:23 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602221203.23561.jbeulich@novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Registering a callback handler through register_die_notifier() is
obviously primarily intended for use by modules. However, the way these
currently get called it is basically impossible for them to actually be
used by modules, as there is, on non-PAE configurationes, a good chance
(the larger the module, the better) for the system to crash as a
result. This is because the callback gets invoked
(a) in the page fault path before the top level page table propagation
gets carried out (hence a fault to propagate the top level page table
entry/entries mapping to module's code/data would nest infinitly) and
(b) in the NMI path, where nested faults must absolutely not happen,
since otherwise the IRET from the nested fault re-enables NMIs,
potentially resulting in nested NMI occurences.
Besides the modular aspect, similar problems would even arise for in-
kernel consumers of the API if they touched ioremap()ed or vmalloc()ed
memory inside their handlers.

Signed-Off-By: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/traps.c 2.6.16-rc4-i386-vmalloc-sync/arch/i386/kernel/traps.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/kernel/traps.c	2006-02-20 09:12:32.000000000 +0100
+++ 2.6.16-rc4-i386-vmalloc-sync/arch/i386/kernel/traps.c	2006-01-26 17:24:15.000000000 +0100
@@ -99,6 +99,8 @@ int register_die_notifier(struct notifie
 {
 	int err = 0;
 	unsigned long flags;
+
+	vmalloc_sync_all();
 	spin_lock_irqsave(&die_notifier_lock, flags);
 	err = notifier_chain_register(&i386die_chain, nb);
 	spin_unlock_irqrestore(&die_notifier_lock, flags);
@@ -694,6 +696,7 @@ fastcall void do_nmi(struct pt_regs * re
 
 void set_nmi_callback(nmi_callback_t callback)
 {
+	vmalloc_sync_all();
 	rcu_assign_pointer(nmi_callback, callback);
 }
 EXPORT_SYMBOL_GPL(set_nmi_callback);
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/mm/fault.c 2.6.16-rc4-i386-vmalloc-sync/arch/i386/mm/fault.c
--- /home/jbeulich/tmp/linux-2.6.16-rc4/arch/i386/mm/fault.c	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc4-i386-vmalloc-sync/arch/i386/mm/fault.c	2006-01-25 13:48:45.000000000 +0100
@@ -214,6 +214,68 @@ static noinline void force_sig_info_faul
 
 fastcall void do_invalid_op(struct pt_regs *, unsigned long);
 
+static inline pmd_t *vmalloc_sync_one(pgd_t *pgd, unsigned long address)
+{
+	unsigned index = pgd_index(address);
+	pgd_t *pgd_k;
+	pud_t *pud, *pud_k;
+	pmd_t *pmd, *pmd_k;
+
+	pgd += index;
+	pgd_k = init_mm.pgd + index;
+
+	if (!pgd_present(*pgd_k))
+		return NULL;
+
+	/*
+	 * set_pgd(pgd, *pgd_k); here would be useless on PAE
+	 * and redundant with the set_pmd() on non-PAE. As would
+	 * set_pud.
+	 */
+
+	pud = pud_offset(pgd, address);
+	pud_k = pud_offset(pgd_k, address);
+	if (!pud_present(*pud_k))
+		return NULL;
+	
+	pmd = pmd_offset(pud, address);
+	pmd_k = pmd_offset(pud_k, address);
+	if (!pmd_present(*pmd_k))
+		return NULL;
+	if (!pmd_present(*pmd))
+		set_pmd(pmd, *pmd_k);
+	else
+		BUG_ON(pmd_page(*pmd) != pmd_page(*pmd_k));
+	return pmd_k;
+}
+
+/*
+ * Handle a fault on the vmalloc or module mapping area
+ *
+ * This assumes no large pages in there.
+ */
+static inline int vmalloc_fault(unsigned long address)
+{
+	unsigned long pgd_paddr;
+	pmd_t *pmd_k;
+	pte_t *pte_k;
+	/*
+	 * Synchronize this task's top level page-table
+	 * with the 'reference' page table.
+	 *
+	 * Do _not_ use "current" here. We might be inside
+	 * an interrupt in the middle of a task switch..
+	 */
+	pgd_paddr = read_cr3();
+	pmd_k = vmalloc_sync_one(__va(pgd_paddr), address);
+	if (!pmd_k)
+		return -1;
+	pte_k = pte_offset_kernel(pmd_k, address);
+	if (!pte_present(*pte_k))
+		return -1;
+	return 0;
+}
+
 /*
  * This routine handles page faults.  It determines the address,
  * and the problem, and then passes it off to one of the appropriate
@@ -223,6 +285,8 @@ fastcall void do_invalid_op(struct pt_re
  *	bit 0 == 0 means no page found, 1 means protection fault
  *	bit 1 == 0 means read, 1 means write
  *	bit 2 == 0 means kernel, 1 means user-mode
+ *	bit 3 == 1 means use of reserved bit detected
+ *	bit 4 == 1 means fault was an instruction fetch
  */
 fastcall void __kprobes do_page_fault(struct pt_regs *regs,
 				      unsigned long error_code)
@@ -237,13 +301,6 @@ fastcall void __kprobes do_page_fault(st
 	/* get the address */
         address = read_cr2();
 
-	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
-					SIGSEGV) == NOTIFY_STOP)
-		return;
-	/* It's safe to allow irq's after cr2 has been saved */
-	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
-		local_irq_enable();
-
 	tsk = current;
 
 	si_code = SEGV_MAPERR;
@@ -259,17 +316,29 @@ fastcall void __kprobes do_page_fault(st
 	 *
 	 * This verifies that the fault happens in kernel space
 	 * (error_code & 4) == 0, and that the fault was not a
-	 * protection error (error_code & 1) == 0.
+	 * protection error (error_code & 9) == 0.
 	 */
-	if (unlikely(address >= TASK_SIZE)) { 
-		if (!(error_code & 5))
-			goto vmalloc_fault;
-		/* 
+	if (unlikely(address >= TASK_SIZE)) {
+		if (!(error_code & 0x0000000d) && vmalloc_fault(address) >= 0)
+			return;
+		if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+						SIGSEGV) == NOTIFY_STOP)
+			return;
+		/*
 		 * Don't take the mm semaphore here. If we fixup a prefetch
 		 * fault we could otherwise deadlock.
 		 */
 		goto bad_area_nosemaphore;
-	} 
+	}
+
+	if (notify_die(DIE_PAGE_FAULT, "page fault", regs, error_code, 14,
+					SIGSEGV) == NOTIFY_STOP)
+		return;
+
+	/* It's safe to allow irq's after cr2 has been saved and the vmalloc
+	   fault has been handled. */
+	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
+		local_irq_enable();
 
 	mm = tsk->mm;
 
@@ -510,51 +579,37 @@ do_sigbus:
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = 14;
 	force_sig_info_fault(SIGBUS, BUS_ADRERR, address, tsk);
-	return;
-
-vmalloc_fault:
-	{
-		/*
-		 * Synchronize this task's top level page-table
-		 * with the 'reference' page table.
-		 *
-		 * Do _not_ use "tsk" here. We might be inside
-		 * an interrupt in the middle of a task switch..
-		 */
-		int index = pgd_index(address);
-		unsigned long pgd_paddr;
-		pgd_t *pgd, *pgd_k;
-		pud_t *pud, *pud_k;
-		pmd_t *pmd, *pmd_k;
-		pte_t *pte_k;
-
-		pgd_paddr = read_cr3();
-		pgd = index + (pgd_t *)__va(pgd_paddr);
-		pgd_k = init_mm.pgd + index;
-
-		if (!pgd_present(*pgd_k))
-			goto no_context;
-
-		/*
-		 * set_pgd(pgd, *pgd_k); here would be useless on PAE
-		 * and redundant with the set_pmd() on non-PAE. As would
-		 * set_pud.
-		 */
-
-		pud = pud_offset(pgd, address);
-		pud_k = pud_offset(pgd_k, address);
-		if (!pud_present(*pud_k))
-			goto no_context;
-		
-		pmd = pmd_offset(pud, address);
-		pmd_k = pmd_offset(pud_k, address);
-		if (!pmd_present(*pmd_k))
-			goto no_context;
-		set_pmd(pmd, *pmd_k);
+}
 
-		pte_k = pte_offset_kernel(pmd_k, address);
-		if (!pte_present(*pte_k))
-			goto no_context;
-		return;
+#ifndef CONFIG_X86_PAE
+void vmalloc_sync_all(void)
+{
+	/* Note that races in the updates of insync and start aren't problematic:
+	   insync can only get set bits added, and updates to start are only
+	   improving performance (without affecting correctness if undone). */
+	static DECLARE_BITMAP(insync, PTRS_PER_PGD);
+	static unsigned long start = TASK_SIZE;
+	unsigned long address;
+#define COMPILE_ASSERT(e) ((void)sizeof(char[1 - 2 * !(e)]))
+	COMPILE_ASSERT(!(TASK_SIZE & ~PGDIR_MASK));
+#undef COMPILE_ASSERT
+	for (address = start; address >= TASK_SIZE; address += PGDIR_SIZE) {
+		if (!test_bit(pgd_index(address), insync)) {
+			unsigned long flags;
+			struct page *page;
+
+			spin_lock_irqsave(&pgd_lock, flags);
+			for (page = pgd_list; page; page = (struct page *)page->index)
+				if(!vmalloc_sync_one(page_address(page), address)) {
+					BUG_ON(page != pgd_list);
+					break;
+				}
+			spin_unlock_irqrestore(&pgd_lock, flags);
+			if(!page)
+				set_bit(pgd_index(address), insync);
+		}
+		if (address == start && test_bit(pgd_index(address), insync))
+			start = address + PGDIR_SIZE;
 	}
 }
+#endif
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/pgtable-2level.h 2.6.16-rc4-i386-vmalloc-sync/include/asm-i386/pgtable-2level.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/pgtable-2level.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc4-i386-vmalloc-sync/include/asm-i386/pgtable-2level.h	2006-01-25 10:41:49.000000000 +0100
@@ -61,4 +61,6 @@ static inline int pte_exec_kernel(pte_t 
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { (pte).pte_low })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
+void vmalloc_sync_all(void);
+
 #endif /* _I386_PGTABLE_2LEVEL_H */
diff -Npru /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/pgtable-3level.h 2.6.16-rc4-i386-vmalloc-sync/include/asm-i386/pgtable-3level.h
--- /home/jbeulich/tmp/linux-2.6.16-rc4/include/asm-i386/pgtable-3level.h	2006-01-03 04:21:10.000000000 +0100
+++ 2.6.16-rc4-i386-vmalloc-sync/include/asm-i386/pgtable-3level.h	2006-01-25 10:41:49.000000000 +0100
@@ -152,4 +152,6 @@ static inline pmd_t pfn_pmd(unsigned lon
 
 #define __pmd_free_tlb(tlb, x)		do { } while (0)
 
+#define vmalloc_sync_all() ((void)0)
+
 #endif /* _I386_PGTABLE_3LEVEL_H */

