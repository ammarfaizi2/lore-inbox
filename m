Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932761AbWBURUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbWBURUn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 12:20:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932759AbWBURUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 12:20:42 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:9921 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932504AbWBURUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 12:20:40 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Li, Shaohua" <shaohua.li@intel.com>
Subject: Re: [PATCH 1/1] EFI iounpam fix for acpi_os_unmap_memory take two
Date: Tue, 21 Feb 2006 10:20:34 -0700
User-Agent: KMail/1.8.3
Cc: "Edgar Hucek" <hostmaster@ed-soft.at>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <59D45D057E9702469E5775CBB56411F101AE95F6@pdsmsx406>
In-Reply-To: <59D45D057E9702469E5775CBB56411F101AE95F6@pdsmsx406>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602211020.34205.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 February 2006 18:26, Li, Shaohua wrote:
> >When EFI is enabled acpi_os_unmap_memory trys to unmap memory
> >which was not mapped by acpi_os_map_memory.
> Yes, this could solve you problem at hand, but I wonder why we should
> always use ioremap in acpi_os_map_memory. It's ACPI tables or pci memory
> bar, ioremap should be safe to me.

I agree (I think).  

I recently made the ia64 ioremap() smart enough so acpi_os_map_memory()
could just always use it:
    http://lkml.org/lkml/2006/1/19/272
I think we should do the same for i386, and that's basically what
Shaohua's first patch to Edgar did.

It sounds like everybody expects that ioremap() to work, but Edgar
reported that it crashed his kernel.  I don't know anything about i386,
but I haven't seen any debug of it, so here's a dumb patch to try to
make forward progress.  Wanna try it, Edgar?

Index: work-mm4/arch/i386/mm/ioremap.c
===================================================================
--- work-mm4.orig/arch/i386/mm/ioremap.c	2006-01-02 20:21:10.000000000 -0700
+++ work-mm4/arch/i386/mm/ioremap.c	2006-02-21 10:06:31.000000000 -0700
@@ -110,6 +110,7 @@
  * have to convert them into an offset in a page-aligned mapping, but the
  * caller shouldn't need to know that small detail.
  */
+extern int bhdebug;
 void __iomem * __ioremap(unsigned long phys_addr, unsigned long size, unsigned long flags)
 {
 	void __iomem * addr;
@@ -118,18 +119,24 @@
 
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
-	if (!size || last_addr < phys_addr)
+	if (bhdebug) printk("%s: phys 0x%lx size 0x%lx last 0x%lx flags 0x%lx\n", __FUNCTION__, phys_addr, size, last_addr, flags);
+	if (!size || last_addr < phys_addr) {
+		if (bhdebug) printk("%s: illegal \n", __FUNCTION__);
 		return NULL;
+	}
 
 	/*
 	 * Don't remap the low PCI/ISA area, it's always mapped..
 	 */
-	if (phys_addr >= ISA_START_ADDRESS && last_addr < ISA_END_ADDRESS)
+	if (phys_addr >= ISA_START_ADDRESS && last_addr < ISA_END_ADDRESS) {
+		if (bhdebug) printk("%s: not remapping ISA\n", __FUNCTION__);
 		return (void __iomem *) phys_to_virt(phys_addr);
+	}
 
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
+	if (bhdebug) printk("%s: high_mem 0x%lx\n", __FUNCTION__, virt_to_phys(high_memory));
 	if (phys_addr <= virt_to_phys(high_memory - 1)) {
 		char *t_addr, *t_end;
 		struct page *page;
@@ -138,8 +145,10 @@
 		t_end = t_addr + (size - 1);
 	   
 		for(page = virt_to_page(t_addr); page <= virt_to_page(t_end); page++)
-			if(!PageReserved(page))
+			if(!PageReserved(page)) {
+				if (bhdebug) printk("%s: pfn 0x%lx reserved\n", __FUNCTION__, page_to_pfn(page));
 				return NULL;
+			}
 	}
 
 	/*
@@ -153,6 +162,7 @@
 	 * Ok, go for it..
 	 */
 	area = get_vm_area(size, VM_IOREMAP | (flags << 20));
+	if (bhdebug) printk("%s: vm_area 0x%lx\n", __FUNCTION__, area);
 	if (!area)
 		return NULL;
 	area->phys_addr = phys_addr;
@@ -160,8 +170,10 @@
 	if (ioremap_page_range((unsigned long) addr,
 			(unsigned long) addr + size, phys_addr, flags)) {
 		vunmap((void __force *) addr);
+		if (bhdebug) printk("%s: ioremap_page_range failed\n", __FUNCTION__);
 		return NULL;
 	}
+	if (bhdebug) printk("%s: return 0x%lx\n", __FUNCTION__, (offset + (char __iomem *)addr);
 	return (void __iomem *) (offset + (char __iomem *)addr);
 }
 EXPORT_SYMBOL(__ioremap);
Index: work-mm4/init/main.c
===================================================================
--- work-mm4.orig/init/main.c	2006-02-01 16:24:47.000000000 -0700
+++ work-mm4/init/main.c	2006-02-21 10:10:33.000000000 -0700
@@ -659,6 +659,7 @@
 #endif
 }
 
+int bhdebug;
 static int init(void * unused)
 {
 	lock_kernel();
@@ -708,6 +709,17 @@
 		prepare_namespace();
 	}
 
+	{
+	    unsigned long phys = 0x1fefd000;
+	    void *addr;
+
+	    bhdebug=1;
+	    printk("\n\nTesting ioremap\n");
+	    addr = ioremap(phys, 0x1000);
+	    printk("ioremap(0x%lx, 0x1000) = 0x%p\n\n", phys, addr);
+	    bhdebug=0;
+	}
+
 	/*
 	 * Ok, we have completed the initial bootup, and
 	 * we're essentially up and running. Get rid of the
