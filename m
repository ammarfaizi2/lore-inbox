Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUGAJQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUGAJQo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 05:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264382AbUGAJQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 05:16:44 -0400
Received: from mx2.elte.hu ([157.181.151.9]:35465 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S264377AbUGAJQg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 05:16:36 -0400
Date: Thu, 1 Jul 2004 11:09:52 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch] enable SMP Opterons boot an NX-enabled x86 kernel, 2.6.7-bk13
Message-ID: <20040701090952.GA19008@elte.hu>
References: <20040701081805.GA11214@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+pHx0qQiF2pBVqBT"
Content-Disposition: inline
In-Reply-To: <20040701081805.GA11214@elte.hu>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached replacement patch fixes compilation warnings that pop up
when compiling !PAE. I've test-booted it on !PAE && !SMP.

	Ingo

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nx-fix-smpboot-2.6.7-A6"


- add infrastructure to enable/disable executability of kernel pages

- make the SMP trampoline page executable.

Signed-off-by: Ingo Molnar <mingo@elte.hu>

--- linux/arch/i386/kernel/smpboot.c.orig	
+++ linux/arch/i386/kernel/smpboot.c	
@@ -82,6 +82,7 @@ int smp_threads_ready;
 extern unsigned char trampoline_data [];
 extern unsigned char trampoline_end  [];
 static unsigned char *trampoline_base;
+static int trampoline_exec;
 
 /*
  * Currently trivial. Write the real->protected mode
@@ -108,6 +109,10 @@ void __init smp_alloc_memory(void)
 	 */
 	if (__pa(trampoline_base) >= 0x9F000)
 		BUG();
+	/*
+	 * Make the SMP trampoline executable:
+	 */
+	trampoline_exec = set_kernel_exec((unsigned long)trampoline_base, 1);
 }
 
 /*
@@ -1375,6 +1380,10 @@ void __init smp_cpus_done(unsigned int m
 	setup_ioapic_dest();
 #endif
 	zap_low_mappings();
+	/*
+	 * Disable executability of the SMP trampoline:
+	 */
+	set_kernel_exec((unsigned long)trampoline_base, trampoline_exec);
 }
 
 void __init smp_intr_init(void)
--- linux/arch/i386/mm/init.c.orig	
+++ linux/arch/i386/mm/init.c	
@@ -455,6 +455,33 @@ static void __init set_nx(void)
 	}
 }
 
+/*
+ * Enables/disables executability of a given kernel page and
+ * returns the previous setting.
+ */
+int __init set_kernel_exec(unsigned long vaddr, int enable)
+{
+	pte_t *pte;
+	int ret = 1;
+
+	if (!nx_enabled)
+		goto out;
+
+	pte = lookup_address(vaddr);
+	BUG_ON(!pte);
+
+	if (pte_val(*pte) & _PAGE_NX)
+		ret = 0;
+
+	if (enable)
+		pte->pte_high &= ~(1 << (_PAGE_BIT_NX - 32));
+	else
+		pte->pte_high |= 1 << (_PAGE_BIT_NX - 32);
+	__flush_tlb_all();
+out:
+	return ret;
+}
+
 #endif
 
 /*
--- linux/arch/i386/mm/pageattr.c.orig	
+++ linux/arch/i386/mm/pageattr.c	
@@ -17,7 +17,7 @@ static spinlock_t cpa_lock = SPIN_LOCK_U
 static struct list_head df_list = LIST_HEAD_INIT(df_list);
 
 
-static inline pte_t *lookup_address(unsigned long address) 
+pte_t *lookup_address(unsigned long address) 
 { 
 	pgd_t *pgd = pgd_offset_k(address); 
 	pmd_t *pmd;
--- linux/include/asm-i386/pgtable.h.orig	
+++ linux/include/asm-i386/pgtable.h	
@@ -285,7 +285,7 @@ static inline pte_t pte_modify(pte_t pte
 	 * Chop off the NX bit (if present), and add the NX portion of
 	 * the newprot (if present):
 	 */
-	pte.pte_high &= -1 ^ (1 << (_PAGE_BIT_NX - 32));
+	pte.pte_high &= ~(1 << (_PAGE_BIT_NX - 32));
 	pte.pte_high |= (pgprot_val(newprot) >> 32) & \
 					(__supported_pte_mask >> 32);
 #endif
@@ -344,6 +344,26 @@ static inline pte_t pte_modify(pte_t pte
 #define pte_offset_kernel(dir, address) \
 	((pte_t *) pmd_page_kernel(*(dir)) +  pte_index(address))
 
+/*
+ * Helper function that returns the kernel pagetable entry controlling
+ * the virtual address 'address'. NULL means no pagetable entry present.
+ * NOTE: the return type is pte_t but if the pmd is PSE then we return it
+ * as a pte too.
+ */
+extern pte_t *lookup_address(unsigned long address);
+
+/*
+ * Make a given kernel text page executable/non-executable.
+ * Returns the previous executability setting of that page (which
+ * is used to restore the previous state). Used by the SMP bootup code.
+ * NOTE: this is an __init function for security reasons.
+ */
+#ifdef CONFIG_X86_PAE
+ extern int set_kernel_exec(unsigned long vaddr, int enable);
+#else
+ static inline int set_kernel_exec(unsigned long vaddr, int enable) { return 0;}
+#endif
+
 #if defined(CONFIG_HIGHPTE)
 #define pte_offset_map(dir, address) \
 	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))

--+pHx0qQiF2pBVqBT--
