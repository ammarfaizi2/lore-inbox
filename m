Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUIOO71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUIOO71 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 10:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266349AbUIOO71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 10:59:27 -0400
Received: from cantor.suse.de ([195.135.220.2]:60638 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266291AbUIOO64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 10:58:56 -0400
Date: Wed, 15 Sep 2004 16:58:45 +0200
From: Karsten Keil <kkeil@suse.de>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] tune vmalloc size
Message-ID: <20040915145845.GA26509@pingi3.kke.suse.de>
Mail-Followup-To: Andi Kleen <ak@muc.de>,
	Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
References: <2EHyq-5or-39@gated-at.bofh.it> <m34qlzbqy6.fsf@averell.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m34qlzbqy6.fsf@averell.firstfloor.org>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.5-7.95-default i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 03:29:53PM +0200, Andi Kleen wrote:
> Ingo Molnar <mingo@elte.hu> writes:
> 
> > there are a few devices that use lots of ioremap space. vmalloc space is
> > a showstopper problem for them.
> >
> > this patch adds the vmalloc=<size> boot parameter to override
> > __VMALLOC_RESERVE. The default is 128mb right now - e.g. vmalloc=256m
> > doubles the size.
> 
> Ah, Karsten Keil did a similar patch some months ago. There is 
> clearly a need.
> 
> But I think this should be self tuning instead. For a machine with 
> less than 900MB of memory the vmalloc area can be automagically increased,
> growing into otherwise unused address space. 
> 
> This way many users wouldn't need to specify weird options.  So far
> most machines still don't have more than 512MB.
> 

Yes my patch has this autotune already in.

Hmm, I though I did sent it on LKML begin on this year, but after looking
through the archives, it didn't happend.

Here is my version.

diff -urN linux-2.6.9-rc2-bk2.org/arch/i386/boot/setup.S linux-2.6.9-rc2-bk2/arch/i386/boot/setup.S
--- linux-2.6.9-rc2-bk2.org/arch/i386/boot/setup.S	2004-06-18 23:36:57.000000000 +0200
+++ linux-2.6.9-rc2-bk2/arch/i386/boot/setup.S	2004-09-15 16:50:53.760287653 +0200
@@ -156,7 +156,7 @@
 					# can be located anywhere in
 					# low memory 0x10000 or higher.
 
-ramdisk_max:	.long (MAXMEM-1) & 0x7fffffff
+ramdisk_max:	.long (__MAXMEM-1) & 0x7fffffff
 					# (Header version 0x0203 or later)
 					# The highest safe address for
 					# the contents of an initrd
diff -urN linux-2.6.9-rc2-bk2.org/arch/i386/kernel/setup.c linux-2.6.9-rc2-bk2/arch/i386/kernel/setup.c
--- linux-2.6.9-rc2-bk2.org/arch/i386/kernel/setup.c	2004-09-15 16:45:31.488885339 +0200
+++ linux-2.6.9-rc2-bk2/arch/i386/kernel/setup.c	2004-09-15 16:50:53.779285142 +0200
@@ -97,6 +97,11 @@
 /* For PCI or other memory-mapped resources */
 unsigned long pci_mem_start = 0x10000000;
 
+/* reserved mapping space for vmalloc and ioremap */
+unsigned long vmalloc_reserve = __VMALLOC_RESERVE_DEFAULT;
+EXPORT_SYMBOL(vmalloc_reserve);
+static unsigned long vm_reserve __initdata = -1;
+
 /* user-defined highmem size */
 static unsigned int highmem_pages = -1;
 
@@ -814,7 +819,16 @@
 		 */
 		if (c == ' ' && !memcmp(from, "highmem=", 8))
 			highmem_pages = memparse(from+8, &from) >> PAGE_SHIFT;
-	
+
+		/*
+		 * vm_reserve=size forces to reserve 'size' bytes for vmalloc and
+		 * ioremap areas minimum is 32 MB maximum is 800 MB
+		 * the default without vm_reserve depends on the total amount of
+		 * memory the minimum default is 128 MB
+		 */
+		if (c == ' ' && !memcmp(from, "vm_reserve=", 11))
+			vm_reserve = memparse(from+11, &from);
+
 		c = *(from++);
 		if (!c)
 			break;
@@ -1019,7 +1033,28 @@
 	start_pfn = PFN_UP(init_pg_tables_end);
 
 	find_max_pfn();
+	
+	/* 
+	 * calculate the default size of vmalloc/ioremap area
+	 * overwrite with the value of the vm_reserve= option
+	 * if set
+	 */
 
+	if (max_pfn >= PFN_UP(KERNEL_MAXMEM - __VMALLOC_RESERVE_DEFAULT))
+		vmalloc_reserve = __VMALLOC_RESERVE_DEFAULT;
+	else
+		vmalloc_reserve = KERNEL_MAXMEM - PFN_PHYS(max_pfn);
+	if (vm_reserve != -1) {
+		if (vm_reserve < __VMALLOC_RESERVE_MIN)
+			vm_reserve = __VMALLOC_RESERVE_MIN;
+		if (vm_reserve > __VMALLOC_RESERVE_MAX)
+			vm_reserve = __VMALLOC_RESERVE_MAX;
+		vmalloc_reserve = vm_reserve;
+	}
+	
+        printk(KERN_NOTICE "%ldMB vmalloc/ioremap area available.\n",
+                        vmalloc_reserve>>20);
+                        	
 	max_low_pfn = find_max_low_pfn();
 
 #ifdef CONFIG_HIGHMEM
diff -urN linux-2.6.9-rc2-bk2.org/arch/i386/mm/discontig.c linux-2.6.9-rc2-bk2/arch/i386/mm/discontig.c
--- linux-2.6.9-rc2-bk2.org/arch/i386/mm/discontig.c	2004-09-15 16:45:31.865835529 +0200
+++ linux-2.6.9-rc2-bk2/arch/i386/mm/discontig.c	2004-09-15 16:50:53.788283952 +0200
@@ -266,6 +266,19 @@
 	system_start_pfn = min_low_pfn = PFN_UP(init_pg_tables_end);
 
 	find_max_pfn();
+
+	/* Added 2004-03-02, <garloff@suse.de>, copied from i386/setup.c
+	 * but leave out automatic vmalloc size increase ... */
+	if (vm_reserve != -1) {
+		if (vm_reserve < __VMALLOC_RESERVE_MIN)
+			vm_reserve = __VMALLOC_RESERVE_MIN;
+		if (vm_reserve > __VMALLOC_RESERVE_MAX)
+			vm_reserve = __VMALLOC_RESERVE_MAX;
+		vmalloc_reserve = vm_reserve;
+	}
+	printk(KERN_NOTICE "%ldMB vmalloc/ioremap area available.\n",
+		vmalloc_reserve>>20);
+
 	system_max_low_pfn = max_low_pfn = find_max_low_pfn() - reserve_pages;
 	printk("reserve_pages = %ld find_max_low_pfn() ~ %ld\n",
 			reserve_pages, max_low_pfn + reserve_pages);
diff -urN linux-2.6.9-rc2-bk2.org/Documentation/kernel-parameters.txt linux-2.6.9-rc2-bk2/Documentation/kernel-parameters.txt
--- linux-2.6.9-rc2-bk2.org/Documentation/kernel-parameters.txt	2004-09-15 16:45:29.162192787 +0200
+++ linux-2.6.9-rc2-bk2/Documentation/kernel-parameters.txt	2004-09-15 16:50:53.799282498 +0200
@@ -1280,6 +1280,11 @@
 			This is actually a boot loader parameter; the value is
 			passed to the kernel using a special protocol.
 
+	vm_reserve=nn[KM]
+			[KNL,BOOT,IA-32] force use of a specific amount of
+			virtual memory for vmalloc and ioremap allocations
+			minimum 32 MB maximum 800 MB
+
 	vmhalt=		[KNL,S390]
 
 	vmpoff=		[KNL,S390] 
diff -urN linux-2.6.9-rc2-bk2.org/include/asm-i386/page.h linux-2.6.9-rc2-bk2/include/asm-i386/page.h
--- linux-2.6.9-rc2-bk2.org/include/asm-i386/page.h	2004-09-15 16:46:01.094973092 +0200
+++ linux-2.6.9-rc2-bk2/include/asm-i386/page.h	2004-09-15 16:50:53.809281176 +0200
@@ -98,10 +98,15 @@
  * This much address space is reserved for vmalloc() and iomap()
  * as well as fixmap mappings.
  */
-#define __VMALLOC_RESERVE	(128 << 20)
+#define __VMALLOC_RESERVE_MIN		(32 << 20)
+#define __VMALLOC_RESERVE_DEFAULT	(128 << 20)
+#define __VMALLOC_RESERVE_MAX		(800 << 20)
+#define __RESERVED_AREA			(10 << 20)
 
 #ifndef __ASSEMBLY__
 
+extern unsigned long vmalloc_reserve;
+
 /* Pure 2^n version of get_order */
 static __inline__ int get_order(unsigned long size)
 {
@@ -128,11 +133,14 @@
 
 
 #define PAGE_OFFSET		((unsigned long)__PAGE_OFFSET)
-#define VMALLOC_RESERVE		((unsigned long)__VMALLOC_RESERVE)
-#define MAXMEM			(-__PAGE_OFFSET-__VMALLOC_RESERVE)
+#define KERNEL_MEMORY		((unsigned long)(FIXADDR_START - __PAGE_OFFSET))
+#define RESERVED_AREA		((unsigned long)__RESERVED_AREA) 
+#define KERNEL_MAXMEM		((unsigned long)(KERNEL_MEMORY - RESERVED_AREA))
+#define __MAXMEM		(-__PAGE_OFFSET-__VMALLOC_RESERVE_MAX)
+#define MAXMEM			((unsigned long)(-PAGE_OFFSET-vmalloc_reserve))
 #define __pa(x)			((unsigned long)(x)-PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long)(x)+PAGE_OFFSET))
-#define pfn_to_kaddr(pfn)      __va((pfn) << PAGE_SHIFT)
+#define pfn_to_kaddr(pfn)	__va((pfn) << PAGE_SHIFT)
 #ifndef CONFIG_DISCONTIGMEM
 #define pfn_to_page(pfn)	(mem_map + (pfn))
 #define page_to_pfn(page)	((unsigned long)((page) - mem_map))


-- 
Karsten Keil
SuSE Labs
ISDN development
