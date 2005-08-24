Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbVHXLSv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbVHXLSv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Aug 2005 07:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750883AbVHXLSv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Aug 2005 07:18:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:34065 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750870AbVHXLSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Aug 2005 07:18:50 -0400
Date: Wed, 24 Aug 2005 13:18:47 +0200
From: Adrian Bunk <bunk@stusta.de>
To: chris@zankel.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] remove include/asm-xtensa/page.h.n
Message-ID: <20050824111847.GO5603@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It file seems to be an accident.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 include/asm-xtensa/page.h.n |  135 ------------------------------------
 1 files changed, 135 deletions(-)

--- linux-2.6.13-rc6-mm1-modular/include/asm-xtensa/page.h.n	2005-08-19 15:08:16.000000000 +0200
+++ /dev/null	2005-04-28 03:52:17.000000000 +0200
@@ -1,135 +0,0 @@
-/*
- * linux/include/asm-xtensa/page.h
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version2 as
- * published by the Free Software Foundation.
- *
- * Copyright (C) 2001 - 2005 Tensilica Inc.
- */
-
-#ifndef _XTENSA_PAGE_H
-#define _XTENSA_PAGE_H
-
-#ifdef __KERNEL__
-
-#include <asm/processor.h>
-#include <linux/config.h>
-
-/*
- * PAGE_SHIFT determines the page size
- * PAGE_ALIGN(x) aligns the pointer to the (next) page boundary
- */
-#define PAGE_SHIFT		XCHAL_MMU_MIN_PTE_PAGE_SIZE
-#define PAGE_SIZE		(1 << PAGE_SHIFT)
-#define PAGE_MASK		(~(PAGE_SIZE-1))
-#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE - 1) & PAGE_MASK)
-
-#define DCACHE_WAY_SIZE		(XCHAL_DCACHE_SIZE / XCHAL_DCACHE_WAYS)
-#define PAGE_OFFSET		XCHAL_KSEG_CACHED_VADDR
-
-#ifdef __ASSEMBLY__
-
-#define __pgprot(x)	(x)
-
-#else
-
-
-/*
- * These are used to make use of C type-checking..
- */
-typedef struct { unsigned long pte; } pte_t;		/* page table entry */
-typedef struct { unsigned long pmd; } pmd_t;		/* PMD table entry */
-typedef struct { unsigned long pgd; } pgd_t;		/* PGD table entry */
-typedef struct { unsigned long pgprot; } pgprot_t;
-
-#define pte_val(x)	((x).pte)
-#define pmd_val(x)	((x).pmd)
-#define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
-
-#define __pte(x)	((pte_t) { (x) } )
-#define __pmd(x)	((pmd_t) { (x) } )
-#define __pgd(x)	((pgd_t) { (x) } )
-#define __pgprot(x)	((pgprot_t) { (x) } )
-
-/*
- * Pure 2^n version of get_order
- */
-extern __inline__ int get_order(unsigned long size)
-{
-	int order;
-#ifndef XCHAL_HAVE_NSU
-	unsigned long x1, x2, x4, x8, x16;
-
-	size = (size + PAGE_SIZE - 1) >> PAGE_SHIFT;
-	x1  = size & 0xAAAAAAAA;
-	x2  = size & 0xCCCCCCCC;
-	x4  = size & 0xF0F0F0F0;
-	x8  = size & 0xFF00FF00;
-	x16 = size & 0xFFFF0000;
-	order = x2 ? 2 : 0;
-	order += (x16 != 0) * 16;
-	order += (x8 != 0) * 8;
-	order += (x4 != 0) * 4;
-	order += (x1 != 0);
-
-	return order;
-#else
-	size = (size - 1) >> PAGE_SHIFT;
-	asm ("nsau %0, %1" : "=r" (order) : "r" (size));
-	return 32 - order;
-#endif
-}
-
-
-struct page;
-extern void clear_page(void *page);
-extern void copy_page(void *to, void *from);
-
-/*
- * If we have cache aliasing and writeback caches, we might have to do
- * some extra work
- */
-
-#if (DCACHE_WAY_SIZE > PAGE_SIZE) && XCHAL_DCACHE_IS_WRITEBACK
-void clear_user_page(void *addr, unsigned long vaddr, struct page* page);
-void copy_user_page(void *to, void* from, unsigned long vaddr, struct page* page);
-#else
-# define clear_user_page(page,vaddr,pg)		clear_page(page)
-# define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
-#endif
-
-
-/*
- * This handles the memory map.  We handle pages at
- * XCHAL_KSEG_CACHED_VADDR for kernels with 32 bit address space.
- * These macros are for conversion of kernel address, not user
- * addresses.
- */
-
-#define __pa(x)			((unsigned long) (x) - PAGE_OFFSET)
-#define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
-#define pfn_valid(pfn)		((unsigned long)pfn < max_mapnr)
-#ifndef CONFIG_DISCONTIGMEM
-# define pfn_to_page(pfn)	(mem_map + (pfn))
-# define page_to_pfn(page)	((unsigned long)((page) - mem_map))
-#else
-# error CONFIG_DISCONTIGMEM not supported
-#endif
-
-#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
-#define page_to_virt(page)	__va(page_to_pfn(page) << PAGE_SHIFT)
-#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr) >> PAGE_SHIFT)
-#define page_to_phys(page)	(page_to_pfn(page) << PAGE_SHIFT)
-
-#define WANT_PAGE_VIRTUAL
-
-
-#endif /* __ASSEMBLY__ */
-
-#define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
-				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
-
-#endif /* __KERNEL__ */
-#endif /* _XTENSA_PAGE_H */

