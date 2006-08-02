Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751216AbWHBIZ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbWHBIZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 04:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751359AbWHBIZ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 04:25:28 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:51587 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751216AbWHBIZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 04:25:27 -0400
Date: Wed, 2 Aug 2006 01:26:43 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, linux-kernel@vger.kernel.org,
       Christian.Limpach@cl.cam.ac.uk, clameter@sgi.com, ebiederm@xmission.com,
       kraxel@suse.de, hollisb@us.ibm.com, ian.pratt@xensource.com,
       zach@vmware.com
Subject: Re: [PATCH 7 of 13] Make __FIXADDR_TOP variable to allow it to make space for a hypervisor
Message-ID: <20060802082643.GO2654@sequoia.sous-sol.org>
References: <patchbomb.1154421371@ezr.goop.org> <b6c100bb5ca5e2839ac8.1154421378@ezr.goop.org> <20060801090330.GC2654@sequoia.sous-sol.org> <20060801073428.f543ba9f.akpm@osdl.org> <20060801213751.GA11244@sequoia.sous-sol.org> <1154483250.2570.17.camel@localhost.localdomain> <20060802070147.GM2654@sequoia.sous-sol.org> <1154503206.2570.65.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1154503206.2570.65.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Rusty Russell (rusty@rustcorp.com.au) wrote:
> On Wed, 2006-08-02 at 00:01 -0700, Chris Wright wrote:
> > Here's an updated patch.  Rather than use __FIXADDR_TOP to adjust for
> > MAXMEM, directly update __VMALLOC_RESERVE which is used to reserve the
> > space for vmalloc, iomap, and fixmap (as comments aptly point out).  I
> > tested this with a bunch of configurations, and booted a XenoLinux
> > kernel with this patch as well.
> 
> Just one minor point:
> 
> > +void set_fixaddr_top(unsigned long top)
> > +{
> > +	BUG_ON(fixmaps > 0);
> > +#ifdef CONFIG_COMPAT_VDSO
> > +	BUG_ON(top - PAGE_SIZE != __FIXADDR_TOP);
> > +#else
> > +	__FIXADDR_TOP = top - PAGE_SIZE;
> > +	__VMALLOC_RESERVE -= top;
> > +#endif
> >  }
> 
> This no longer seems to be an appropriate name.  How about
> set_address_top_reserve or something?

Sure how about reserve_top_address()?  Requires a respin of the next
patch as well.  I've done that, but it still needs to be updated to
early_param, so I won't repost that one.

thanks,
-chris
--

Subject: Make __FIXADDR_TOP variable to allow it to make space for a hypervisor.

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
