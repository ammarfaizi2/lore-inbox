Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWGRJWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWGRJWt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 05:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932138AbWGRJVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 05:21:45 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:26754 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S932136AbWGRJVK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 05:21:10 -0400
Message-Id: <20060718091951.253493000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 18 Jul 2006 00:00:11 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Zachary Amsden <zach@vmware.com>, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 11/33] Add Xen-specific memory management definitions
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
 arch/i386/mach-xen/Makefile               |    2 
 arch/i386/mach-xen/memory.c               |   31 +++++++++++
 include/asm-i386/mach-default/mach_page.h |    4 +
 include/asm-i386/mach-xen/mach_page.h     |   75 +++++++++++++++++++++++++++++
 include/asm-i386/page.h                   |    2 
 5 files changed, 113 insertions(+), 1 deletion(-)


diff -r 1495c1bc43a1 arch/i386/mach-xen/Makefile
--- a/arch/i386/mach-xen/Makefile	Fri Jun 16 15:45:49 2006 -0700
+++ b/arch/i386/mach-xen/Makefile	Fri Jun 16 15:47:42 2006 -0700
@@ -2,6 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-obj-y				:= setup.o setup-xen.o
+obj-y				:= setup.o setup-xen.o memory.o
 
 setup-y				:= ../mach-default/setup.o
diff -r 1495c1bc43a1 include/asm-i386/page.h
--- a/include/asm-i386/page.h	Fri Jun 16 15:45:49 2006 -0700
+++ b/include/asm-i386/page.h	Fri Jun 16 15:47:42 2006 -0700
@@ -82,6 +82,8 @@ typedef struct { unsigned long pgprot; }
 /* to align the pointer to the (next) page boundary */
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
+#include <mach_page.h>
+
 /*
  * This handles the memory map.. We could make this a config
  * option, but too many people screw it up, and too few need
diff -r 1495c1bc43a1 arch/i386/mach-xen/memory.c
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/arch/i386/mach-xen/memory.c	Fri Jun 16 15:47:42 2006 -0700
@@ -0,0 +1,31 @@
+
+#include <linux/stddef.h>
+#include <asm/desc.h>
+#include <asm/hypervisor.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+
+maddr_t arbitrary_virt_to_machine(unsigned long address)
+{
+	pte_t *pte = lookup_address(address);
+	maddr_t m;
+
+	BUG_ON(pte == NULL);
+
+	m = (maddr_t)pte_mfn(*pte) << PAGE_SHIFT;
+	return m | (address & (PAGE_SIZE - 1));
+}
+
+void make_lowmem_page_readonly(unsigned long address, unsigned int feature)
+{
+	pte_t *pte;
+	int rc;
+
+	if (xen_feature(feature))
+		return;
+
+	pte = lookup_address(address);
+	BUG_ON(pte == NULL);
+	rc = HYPERVISOR_update_va_mapping(address, pte_wrprotect(*pte), 0);
+	BUG_ON(rc);
+}
diff -r 1495c1bc43a1 include/asm-i386/mach-default/mach_page.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-default/mach_page.h	Fri Jun 16 15:47:42 2006 -0700
@@ -0,0 +1,4 @@
+#ifndef __ASM_MACH_PAGE_H
+#define __ASM_MACH_PAGE_H
+
+#endif /* __ASM_MACH_PAGE_H */
diff -r 1495c1bc43a1 include/asm-i386/mach-xen/mach_page.h
--- /dev/null	Thu Jan 01 00:00:00 1970 +0000
+++ b/include/asm-i386/mach-xen/mach_page.h	Fri Jun 16 15:47:42 2006 -0700
@@ -0,0 +1,75 @@
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
+maddr_t arbitrary_virt_to_machine(unsigned long address);
+void make_lowmem_page_readonly(unsigned long address, unsigned int feature);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_MACH_PAGE_H */

--
