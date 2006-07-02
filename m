Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932278AbWGBKfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbWGBKfV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 06:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbWGBKfV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 06:35:21 -0400
Received: from alephnull.demon.nl ([83.160.184.112]:65499 "EHLO
	xi.wantstofly.org") by vger.kernel.org with ESMTP id S932278AbWGBKfU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 06:35:20 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=1148133259;
	d=wantstofly.org;
	h=date:from:to:cc:subject:message-id:mime-version:content-type:
	content-disposition:user-agent;
	b=EegQJl0Zj7u58lDbGYece2Q9O7yHbpc4C2aDbZH8yq8VAJ6KyhZ6bHbgLUB9p
	Vf2NetX6sT1Cbl68yFvF9qoqg==
Date: Sun, 2 Jul 2006 12:35:18 +0200
From: Lennert Buytenhek <buytenh@wantstofly.org>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Cc: rmk@arm.linux.org.uk
Subject: [PATCH,RFC] make valid_mmap_phys_addr_range() take a pfn
Message-ID: <20060702103518.GC30730@xi.wantstofly.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Newer ARMs have a 40 bit physical address space, but mapping physical
memory above 4G needs a special page table format which we (currently?)
do not use for userspace mappings, so what happens instead is that
mapping an address >= 4G will happily discard the upper bits and wrap.

There is a valid_mmap_phys_addr_range() arch hook where we could check
for >= 4G addresses and deny the mapping, but this hook takes an unsigned
long address:

	static inline int valid_mmap_phys_addr_range(unsigned long addr, size_t size);

And drivers/char/mem.c:mmap_mem() calls it like this:

	static int mmap_mem(struct file * file, struct vm_area_struct * vma)
	{
		size_t size = vma->vm_end - vma->vm_start;

		if (!valid_mmap_phys_addr_range(vma->vm_pgoff << PAGE_SHIFT, size))

So that's not much help either.

This patch makes the hook take a pfn instead of a phys address -- how
does that look?

Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Index: linux-2.6.17-git16/drivers/char/mem.c
===================================================================
--- linux-2.6.17-git16.orig/drivers/char/mem.c
+++ linux-2.6.17-git16/drivers/char/mem.c
@@ -96,7 +96,7 @@ static inline int valid_phys_addr_range(
 	return 1;
 }
 
-static inline int valid_mmap_phys_addr_range(unsigned long addr, size_t size)
+static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
 {
 	return 1;
 }
@@ -243,7 +243,7 @@ static int mmap_mem(struct file * file, 
 {
 	size_t size = vma->vm_end - vma->vm_start;
 
-	if (!valid_mmap_phys_addr_range(vma->vm_pgoff << PAGE_SHIFT, size))
+	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
 		return -EINVAL;
 
 	vma->vm_page_prot = phys_mem_access_prot(file, vma->vm_pgoff,
Index: linux-2.6.17-git16/arch/ia64/kernel/efi.c
===================================================================
--- linux-2.6.17-git16.orig/arch/ia64/kernel/efi.c
+++ linux-2.6.17-git16/arch/ia64/kernel/efi.c
@@ -760,7 +760,7 @@ valid_phys_addr_range (unsigned long phy
 }
 
 int
-valid_mmap_phys_addr_range (unsigned long phys_addr, unsigned long size)
+valid_mmap_phys_addr_range (unsigned long pfn, unsigned long size)
 {
 	/*
 	 * MMIO regions are often missing from the EFI memory map.
Index: linux-2.6.17-git16/arch/ia64/pci/pci.c
===================================================================
--- linux-2.6.17-git16.orig/arch/ia64/pci/pci.c
+++ linux-2.6.17-git16/arch/ia64/pci/pci.c
@@ -651,7 +651,7 @@ pci_mmap_legacy_page_range(struct pci_bu
 	 * Avoid attribute aliasing.  See Documentation/ia64/aliasing.txt
 	 * for more details.
 	 */
-	if (!valid_mmap_phys_addr_range(vma->vm_pgoff << PAGE_SHIFT, size))
+	if (!valid_mmap_phys_addr_range(vma->vm_pgoff, size))
 		return -EINVAL;
 	prot = phys_mem_access_prot(NULL, vma->vm_pgoff, size,
 				    vma->vm_page_prot);
Index: linux-2.6.17-git16/include/asm-ia64/io.h
===================================================================
--- linux-2.6.17-git16.orig/include/asm-ia64/io.h
+++ linux-2.6.17-git16/include/asm-ia64/io.h
@@ -90,7 +90,7 @@ phys_to_virt (unsigned long address)
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 extern u64 kern_mem_attribute (unsigned long phys_addr, unsigned long size);
 extern int valid_phys_addr_range (unsigned long addr, size_t count); /* efi.c */
-extern int valid_mmap_phys_addr_range (unsigned long addr, size_t count);
+extern int valid_mmap_phys_addr_range (unsigned long pfn, size_t count);
 
 /*
  * The following two macros are deprecated and scheduled for removal.
