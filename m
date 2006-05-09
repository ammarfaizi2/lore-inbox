Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751700AbWEIIyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751700AbWEIIyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751599AbWEIIyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:54:18 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:37763 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751532AbWEIItX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:23 -0400
Message-Id: <20060509085151.047254000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:08 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 08/35] Add Xen-specific memory management definitions
Content-Disposition: inline; filename=i386-xen-mm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra memory management definitions used by Xen-specific
code. These allow conversion between 'pseudophysical' memory
addresses, which provide the illusion of a physically contiguous
memory map, and underlying real machine addresses. This conversion is
neceesary when interpreting and updating PTEs. Also support write
protection of page mappings, which is needed to allow successful
validation of page tables.

The current definitions are incomplete and only a stub implementation,
allowing us to re-use existing code (drivers) which references these
memory management code changes.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 include/asm-i386/hypervisor.h             |    3 
 include/asm-i386/mach-default/mach_page.h |    4 +
 include/asm-i386/mach-xen/mach_page.h     |   99 ++++++++++++++++++++++++++++++
 include/asm-i386/page.h                   |    2 
 4 files changed, 108 insertions(+)

--- linus-2.6.orig/include/asm-i386/hypervisor.h
+++ linus-2.6/include/asm-i386/hypervisor.h
@@ -67,4 +67,7 @@ u64 jiffies_to_st(unsigned long jiffies)
 
 #define xen_init()	(0)
 
+#include <xen/interface/version.h>
+#include <xen/features.h>
+
 #endif /* __HYPERVISOR_H__ */
--- linus-2.6.orig/include/asm-i386/page.h
+++ linus-2.6/include/asm-i386/page.h
@@ -82,6 +82,8 @@ typedef struct { unsigned long pgprot; }
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
+#include <mach_page.h>
+
 /*
  * This handles the memory map.. We could make this a config
  * option, but too many people screw it up, and too few need
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-default/mach_page.h
@@ -0,0 +1,4 @@
+#ifndef __ASM_MACH_PAGE_H
+#define __ASM_MACH_PAGE_H
+
+#endif /* __ASM_MACH_PAGE_H */
--- /dev/null
+++ linus-2.6/include/asm-i386/mach-xen/mach_page.h
@@ -0,0 +1,99 @@
+#ifndef __ASM_MACH_PAGE_H
+#define __ASM_MACH_PAGE_H
+
+#ifndef __ASSEMBLY__
+
+/**** MACHINE <-> PHYSICAL CONVERSION MACROS ****/
+#define INVALID_P2M_ENTRY	(~0UL)
+
+static inline unsigned long pfn_to_mfn(unsigned long pfn)
+{
+#ifndef CONFIG_XEN_SHADOW_MODE
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return pfn;
+	return phys_to_machine_mapping[(unsigned int)(pfn)] &
+		~FOREIGN_FRAME_BIT;
+#else
+	return pfn;
+#endif
+}
+
+static inline unsigned long mfn_to_pfn(unsigned long mfn)
+{
+#ifndef CONFIG_XEN_SHADOW_MODE
+	unsigned long pfn;
+
+	if (xen_feature(XENFEAT_auto_translated_physmap))
+		return mfn;
+
+	/*
+	 * The array access can fail (e.g., device space beyond end of RAM).
+	 * In such cases it doesn't matter what we return (we return garbage),
+	 * but we must handle the fault without crashing!
+	 */
+	asm (
+		"1:	movl %1,%0\n"
+		"2:\n"
+		".section __ex_table,\"a\"\n"
+		"	.align 4\n"
+		"	.long 1b,2b\n"
+		".previous"
+		: "=r" (pfn) : "m" (machine_to_phys_mapping[mfn]) );
+
+	return pfn;
+#else
+	return mfn;
+#endif
+}
+
+/* VIRT <-> MACHINE conversion */
+#define virt_to_machine(v)	(__pa(v))
+#define virt_to_mfn(v)		(pfn_to_mfn(__pa(v) >> PAGE_SHIFT))
+#define mfn_to_virt(m)		(__va(mfn_to_pfn(m) << PAGE_SHIFT))
+
+/* Definitions for machine and pseudophysical addresses. */
+#ifdef CONFIG_X86_PAE
+typedef unsigned long long paddr_t;
+typedef unsigned long long maddr_t;
+#else
+typedef unsigned long paddr_t;
+typedef unsigned long maddr_t;
+#endif
+
+#ifndef CONFIG_X86_PAE
+#define pte_mfn(_pte) ((_pte).pte_low >> PAGE_SHIFT)
+#else
+#define pte_mfn(_pte) (((_pte).pte_low >> PAGE_SHIFT) |\
+                       (((_pte).pte_high & 0xfff) << (32-PAGE_SHIFT)))
+#endif
+
+#define virt_to_ptep(__va)						\
+({									\
+	pgd_t *__pgd = pgd_offset_k((unsigned long)(__va));		\
+	pud_t *__pud = pud_offset(__pgd, (unsigned long)(__va));	\
+	pmd_t *__pmd = pmd_offset(__pud, (unsigned long)(__va));	\
+	pte_offset_kernel(__pmd, (unsigned long)(__va));		\
+})
+
+#define arbitrary_virt_to_machine(__va)					\
+({									\
+	maddr_t m = (maddr_t)pte_mfn(*virt_to_ptep(__va)) << PAGE_SHIFT;\
+	m | ((unsigned long)(__va) & (PAGE_SIZE-1));			\
+})
+
+#define make_lowmem_page_readonly(va, feature) do {		\
+	pte_t *pte;						\
+	int rc;							\
+								\
+	if (xen_feature(feature))				\
+		return;						\
+								\
+	pte = virt_to_ptep(va);					\
+	rc = HYPERVISOR_update_va_mapping(			\
+		(unsigned long)va, pte_wrprotect(*pte), 0);	\
+	BUG_ON(rc);						\
+} while (0)
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_MACH_PAGE_H */

--
