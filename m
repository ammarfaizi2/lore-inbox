Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTLAHov (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 02:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261825AbTLAHov
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 02:44:51 -0500
Received: from holomorphy.com ([199.26.172.102]:41416 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261812AbTLAHor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 02:44:47 -0500
Date: Sun, 30 Nov 2003 23:44:45 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: pgcl-2.6.0-test5-bk3-17
Message-ID: <20031201074445.GH19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20031128041558.GW19856@holomorphy.com> <20031128072148.GY8039@holomorphy.com> <20031130164301.GK8039@holomorphy.com> <20031201073632.GQ8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201073632.GQ8039@holomorphy.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 30, 2003 at 11:36:32PM -0800, William Lee Irwin III wrote:
> Stack decoding fixes, shutting up some compiler warnings, and dumping
> PAGE_SIZE and MMUPAGE_SIZE into /proc/meminfo (for lack of a better place).
> The printk()'s down there should eventually get ripped out anyway for
> minimal impact and a quieter boot, but until then...

This fixes some bad address calculations in arch/i386/mm/boot_ioremap.c


-- wli


diff -prauN pgcl-2.6.0-test11-7/arch/i386/mm/boot_ioremap.c pgcl-2.6.0-test11-8/arch/i386/mm/boot_ioremap.c
--- pgcl-2.6.0-test11-7/arch/i386/mm/boot_ioremap.c	2003-11-26 12:46:12.000000000 -0800
+++ pgcl-2.6.0-test11-8/arch/i386/mm/boot_ioremap.c	2003-11-30 13:07:00.000000000 -0800
@@ -31,7 +31,7 @@
 
 #define BOOT_PTE_PTRS (PTRS_PER_PTE*2)
 #define boot_pte_index(address) \
-	     (((address) >> PAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
+	     (((address) >> MMUPAGE_SHIFT) & (BOOT_PTE_PTRS - 1))
 
 static inline boot_pte_t* boot_vaddr_to_pte(void *address)
 {
@@ -52,17 +52,17 @@ static void __boot_ioremap(unsigned long
 	char *vaddr = virtual_source;
 
 	pte = boot_vaddr_to_pte(virtual_source);
-	for (i=0; i < nrpages; i++, phys_addr += PAGE_SIZE, pte++) {
-		set_pte(pte, pfn_pte(phys_addr>>PAGE_SHIFT, PAGE_KERNEL));
-		__flush_tlb_one(&vaddr[i*PAGE_SIZE]);
+	for (i=0; i < nrpages; i++, phys_addr += MMUPAGE_SIZE, pte++) {
+		set_pte(pte, pfn_pte(phys_addr>>MMUPAGE_SHIFT, PAGE_KERNEL));
+		__flush_tlb_one(&vaddr[i*MMUPAGE_SIZE]);
 	}
 }
 
 /* the virtual space we're going to remap comes from this array */
 #define BOOT_IOREMAP_PAGES 4
-#define BOOT_IOREMAP_SIZE (BOOT_IOREMAP_PAGES*PAGE_SIZE)
+#define BOOT_IOREMAP_SIZE (BOOT_IOREMAP_PAGES*MMUPAGE_SIZE)
 __initdata char boot_ioremap_space[BOOT_IOREMAP_SIZE] 
-		__attribute__ ((aligned (PAGE_SIZE)));
+		__attribute__ ((aligned (MMUPAGE_SIZE)));
 
 /*
  * This only applies to things which need to ioremap before paging_init()
@@ -83,11 +83,11 @@ __init void* boot_ioremap(unsigned long 
 	last_addr = phys_addr + size - 1;
 
 	/* page align the requested address */
-	offset = phys_addr & ~PAGE_MASK;
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr) - phys_addr;
+	offset = phys_addr & ~MMUPAGE_MASK;
+	phys_addr &= MMUPAGE_MASK;
+	size = MMUPAGE_ALIGN(last_addr) - phys_addr;
 	
-	nrpages = size >> PAGE_SHIFT;
+	nrpages = size >> MMUPAGE_SHIFT;
 	if (nrpages > BOOT_IOREMAP_PAGES)
 		return NULL;
 	
