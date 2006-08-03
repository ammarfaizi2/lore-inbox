Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750934AbWHCA17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750934AbWHCA17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 20:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750867AbWHCA1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 20:27:54 -0400
Received: from 207.47.60.101.static.nextweb.net ([207.47.60.101]:51417 "EHLO
	mail.goop.org") by vger.kernel.org with ESMTP id S1750934AbWHCAZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 20:25:52 -0400
Message-Id: <20060803002518.495141386@xensource.com>
References: <20060803002510.634721860@xensource.com>
User-Agent: quilt/0.45-1
Date: Wed, 02 Aug 2006 17:25:16 -0700
From: Jeremy Fitzhardinge <jeremy@xensource.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Chris Wright <chrisw@sous-sol.org>, Gerd Hoffmann <kraxel@suse.de>
Subject: [patch 6/8] Make __FIXADDR_TOP variable to allow it to make space for a hypervisor.
Content-Disposition: inline; filename=unfix-fixmap.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make __FIXADDR_TOP a variable, so that it can be set to not get in the
way of address space a hypervisor may want to reserve.

Original patch by Gerd Hoffmann <kraxel@suse.de>

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Cc: Gerd Hoffmann <kraxel@suse.de>

---
 arch/i386/Kconfig         |    1 +
 arch/i386/mm/init.c       |   42 ++++++++++++++++++++++++++++++++++++++++++
 arch/i386/mm/pgtable.c    |   26 ++++++++++++++++++++++++++
 include/asm-i386/fixmap.h |    7 ++++++-
 4 files changed, 75 insertions(+), 1 deletion(-)

===================================================================
--- a/arch/i386/Kconfig
+++ b/arch/i386/Kconfig
@@ -792,6 +792,7 @@ config COMPAT_VDSO
 config COMPAT_VDSO
 	bool "Compat VDSO support"
 	default y
+	depends on !PARAVIRT
 	help
 	  Map the VDSO to the predictable old-style address too.
 	---help---
===================================================================
--- a/arch/i386/mm/init.c
+++ b/arch/i386/mm/init.c
@@ -629,6 +629,48 @@ void __init mem_init(void)
 		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10))
 	       );
 
+#if 1 /* double-sanity-check paranoia */
+	printk("virtual kernel memory layout:\n"
+	       "    fixmap  : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+#ifdef CONFIG_HIGHMEM
+	       "    pkmap   : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+#endif
+	       "    vmalloc : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+	       "    lowmem  : 0x%08lx - 0x%08lx   (%4ld MB)\n"
+	       "      .init : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+	       "      .data : 0x%08lx - 0x%08lx   (%4ld kB)\n"
+	       "      .text : 0x%08lx - 0x%08lx   (%4ld kB)\n",
+	       FIXADDR_START, FIXADDR_TOP,
+	       (FIXADDR_TOP - FIXADDR_START) >> 10,
+
+#ifdef CONFIG_HIGHMEM
+	       PKMAP_BASE, PKMAP_BASE+LAST_PKMAP*PAGE_SIZE,
+	       (LAST_PKMAP*PAGE_SIZE) >> 10,
+#endif
+
+	       VMALLOC_START, VMALLOC_END,
+	       (VMALLOC_END - VMALLOC_START) >> 20,
+
+	       (unsigned long)__va(0), (unsigned long)high_memory,
+	       ((unsigned long)high_memory - (unsigned long)__va(0)) >> 20,
+
+	       (unsigned long)&__init_begin, (unsigned long)&__init_end,
+	       ((unsigned long)&__init_end - (unsigned long)&__init_begin) >> 10,
+
+	       (unsigned long)&_etext, (unsigned long)&_edata,
+	       ((unsigned long)&_edata - (unsigned long)&_etext) >> 10,
+
+	       (unsigned long)&_text, (unsigned long)&_etext,
+	       ((unsigned long)&_etext - (unsigned long)&_text) >> 10);
+
+#ifdef CONFIG_HIGHMEM
+	BUG_ON(PKMAP_BASE+LAST_PKMAP*PAGE_SIZE > FIXADDR_START);
+	BUG_ON(VMALLOC_END                     > PKMAP_BASE);
+#endif
+	BUG_ON(VMALLOC_START                   > VMALLOC_END);
+	BUG_ON((unsigned long)high_memory      > VMALLOC_START);
+#endif /* double-sanity-check paranoia */
+
 #ifdef CONFIG_X86_PAE
 	if (!cpu_has_pae)
 		panic("cannot execute a PAE-enabled kernel on a PAE-less CPU!");
===================================================================
--- a/arch/i386/mm/pgtable.c
+++ b/arch/i386/mm/pgtable.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
+#include <linux/module.h>
 
 #include <asm/system.h>
 #include <asm/pgtable.h>
@@ -137,6 +138,12 @@ void set_pmd_pfn(unsigned long vaddr, un
 	__flush_tlb_one(vaddr);
 }
 
+static int fixmaps;
+#ifndef CONFIG_COMPAT_VDSO
+unsigned long __FIXADDR_TOP = 0xfffff000;
+EXPORT_SYMBOL(__FIXADDR_TOP);
+#endif
+
 void __set_fixmap (enum fixed_addresses idx, unsigned long phys, pgprot_t flags)
 {
 	unsigned long address = __fix_to_virt(idx);
@@ -146,6 +153,25 @@ void __set_fixmap (enum fixed_addresses 
 		return;
 	}
 	set_pte_pfn(address, phys >> PAGE_SHIFT, flags);
+	fixmaps++;
+}
+
+/**
+ * reserve_top_address - reserves a hole in the top of kernel address space
+ * @reserve - size of hole to reserve
+ *
+ * Can be used to relocate the fixmap area and poke a hole in the top
+ * of kernel address space to make room for a hypervisor.
+ */
+void reserve_top_address(unsigned long reserve)
+{
+	BUG_ON(fixmaps > 0);
+#ifdef CONFIG_COMPAT_VDSO
+	BUG_ON(reserve != 0);
+#else
+	__FIXADDR_TOP = -reserve - PAGE_SIZE;
+	__VMALLOC_RESERVE += reserve;
+#endif
 }
 
 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
===================================================================
--- a/include/asm-i386/fixmap.h
+++ b/include/asm-i386/fixmap.h
@@ -19,7 +19,11 @@
  * Leave one empty page between vmalloc'ed areas and
  * the start of the fixmap.
  */
-#define __FIXADDR_TOP	0xfffff000
+#ifndef CONFIG_COMPAT_VDSO
+extern unsigned long __FIXADDR_TOP;
+#else
+#define __FIXADDR_TOP  0xfffff000
+#endif
 
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
@@ -93,6 +97,7 @@ enum fixed_addresses {
 
 extern void __set_fixmap (enum fixed_addresses idx,
 					unsigned long phys, pgprot_t flags);
+extern void reserve_top_address(unsigned long reserve);
 
 #define set_fixmap(idx, phys) \
 		__set_fixmap(idx, phys, PAGE_KERNEL)

--

