Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262088AbVAJFT4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262088AbVAJFT4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJFTz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:19:55 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:15876
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262088AbVAJFOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:01 -0500
Message-Id: <200501100735.j0A7ZDPW005750@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 4/28] UML - Three-level page table support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:13 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the three-level page table support from the x86_64 patch.  It can
be enabled on x86, although it's not particularly needed at this point.
However, it can be used to implement very large physical memory (with
almost all of it in highmem) on UML.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/Kconfig
===================================================================
--- 2.6.10.orig/arch/um/Kconfig	2005-01-09 18:29:53.000000000 -0500
+++ 2.6.10/arch/um/Kconfig	2005-01-09 18:30:19.000000000 -0500
@@ -68,6 +68,8 @@
 	to CONFIG_MODE_TT).  Otherwise, it is safe to say Y.  Disabling this
 	option will shrink the UML binary slightly.
 
+source "arch/um/Kconfig_arch"
+
 config NET
 	bool "Networking support"
 	help
Index: 2.6.10/arch/um/Kconfig_i386
===================================================================
--- 2.6.10.orig/arch/um/Kconfig_i386	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/Kconfig_i386	2005-01-09 18:30:19.000000000 -0500
@@ -0,0 +1,8 @@
+config 3_LEVEL_PGTABLES
+	bool "Three-level pagetables"
+	default n
+	help
+	Three-level pagetables will let UML have more than 4G of physical
+	memory.  All the memory that can't be mapped directly will be treated
+	as high memory.
+
Index: 2.6.10/arch/um/Makefile
===================================================================
--- 2.6.10.orig/arch/um/Makefile	2005-01-09 18:25:43.000000000 -0500
+++ 2.6.10/arch/um/Makefile	2005-01-09 18:30:19.000000000 -0500
@@ -17,7 +17,7 @@
 
 # Have to precede the include because the included Makefiles reference them.
 SYMLINK_HEADERS = archparam.h system.h sigcontext.h processor.h ptrace.h \
-	arch-signal.h module.h
+	arch-signal.h module.h vm-flags.h
 SYMLINK_HEADERS := $(foreach header,$(SYMLINK_HEADERS),include/asm-um/$(header))
 
 ARCH_SYMLINKS = include/asm-um/arch $(ARCH_DIR)/include/sysdep $(ARCH_DIR)/os \
Index: 2.6.10/arch/um/defconfig
===================================================================
--- 2.6.10.orig/arch/um/defconfig	2005-01-09 18:29:53.000000000 -0500
+++ 2.6.10/arch/um/defconfig	2005-01-09 18:30:19.000000000 -0500
@@ -17,6 +17,7 @@
 #
 CONFIG_MODE_TT=y
 CONFIG_MODE_SKAS=y
+# CONFIG_3_LEVEL_PGTABLES is not set
 CONFIG_NET=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=m
Index: 2.6.10/arch/um/kernel/mem.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/mem.c	2005-01-09 18:30:07.000000000 -0500
+++ 2.6.10/arch/um/kernel/mem.c	2005-01-09 18:31:02.000000000 -0500
@@ -25,7 +25,7 @@
 /* Changed during early boot */
 unsigned long *empty_zero_page = NULL;
 unsigned long *empty_bad_page = NULL;
-pgd_t swapper_pg_dir[1024];
+pgd_t swapper_pg_dir[PTRS_PER_PGD];
 unsigned long highmem;
 int kmalloc_ok = 0;
 
@@ -242,6 +242,7 @@
 		}
 		addr += PAGE_SIZE;
 	}
+	
 	if(i == (1 << order)) return(page);
 	page = alloc_pages(mask, order);
 	goto again;
@@ -336,7 +337,7 @@
 {
 	struct page *pte;
    
-	pte = alloc_pages(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO, 0);
+	pte = alloc_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
 	return pte;
 }
 
Index: 2.6.10/arch/um/kernel/physmem.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/physmem.c	2005-01-09 18:29:53.000000000 -0500
+++ 2.6.10/arch/um/kernel/physmem.c	2005-01-09 18:30:19.000000000 -0500
@@ -309,7 +309,7 @@
 	return(&mem_map[__pa(virt) >> PAGE_SHIFT]);
 }
 
-unsigned long page_to_phys(struct page *page)
+phys_t page_to_phys(struct page *page)
 {
 	return((page - mem_map) << PAGE_SHIFT);
 }
@@ -318,8 +318,9 @@
 {
 	pte_t pte;
 
-	pte_val(pte) = page_to_phys(page) + pgprot_val(pgprot);
-	if(pte_present(pte)) pte_mknewprot(pte_mknewpage(pte));
+	pte_set_val(pte, page_to_phys(page), pgprot);
+	if(pte_present(pte)) 
+		pte_mknewprot(pte_mknewpage(pte));
 	return(pte);
 }
 
Index: 2.6.10/arch/um/kernel/skas/tlb.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/skas/tlb.c	2005-01-09 18:30:07.000000000 -0500
+++ 2.6.10/arch/um/kernel/skas/tlb.c	2005-01-09 18:30:19.000000000 -0500
@@ -1,5 +1,6 @@
 /* 
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
  * Licensed under the GPL
  */
 
@@ -18,54 +19,86 @@
 		      unsigned long end_addr, int force)
 {
 	pgd_t *npgd;
-	pmd_t *npud;
+	pud_t *npud;
 	pmd_t *npmd;
 	pte_t *npte;
-	unsigned long addr;
+	unsigned long addr,  end;
 	int r, w, x, err, fd;
 
 	if(mm == NULL) return;
 	fd = mm->context.skas.mm_fd;
 	for(addr = start_addr; addr < end_addr;){
 		npgd = pgd_offset(mm, addr);
-		npud = pud_offset(npgd, addr);
-		npmd = pmd_offset(npud, addr);
-		if(pmd_present(*npmd)){
-			npte = pte_offset_kernel(npmd, addr);
-			r = pte_read(*npte);
-			w = pte_write(*npte);
-			x = pte_exec(*npte);
-			if(!pte_dirty(*npte)) w = 0;
-			if(!pte_young(*npte)){
-				r = 0;
-				w = 0;
-			}
-			if(force || pte_newpage(*npte)){
-				err = unmap(fd, (void *) addr, PAGE_SIZE);
+		if(!pgd_present(*npgd)){
+			if(force || pgd_newpage(*npgd)){
+				end = addr + PGDIR_SIZE;
+				if(end > end_addr)
+					end = end_addr;
+				err = unmap(fd, (void *) addr, end - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
-				if(pte_present(*npte))
-					map(fd, addr, 
-					    pte_val(*npte) & PAGE_MASK,
-					    PAGE_SIZE, r, w, x);
+				pgd_mkuptodate(*npgd);
 			}
-			else if(pte_newprot(*npte)){
-				protect(fd, addr, PAGE_SIZE, r, w, x, 1);
+			addr += PGDIR_SIZE;
+			continue;
+		}
+
+		npud = pud_offset(npgd, addr);
+		if(!pud_present(*npud)){
+			if(force || pud_newpage(*npud)){
+				end = addr + PUD_SIZE;
+				if(end > end_addr)
+					end = end_addr;
+				err = unmap(fd, (void *) addr, end - addr);
+				if(err < 0)
+					panic("munmap failed, errno = %d\n",
+					      -err);
+				pud_mkuptodate(*npud);
 			}
-			*npte = pte_mkuptodate(*npte);
-			addr += PAGE_SIZE;
+			addr += PUD_SIZE;
+			continue;
 		}
-		else {
+
+		npmd = pmd_offset(npud, addr);
+		if(!pmd_present(*npmd)){
 			if(force || pmd_newpage(*npmd)){
-				err = unmap(fd, (void *) addr, PMD_SIZE);
+				end = addr + PMD_SIZE;
+				if(end > end_addr)
+					end = end_addr;
+				err = unmap(fd, (void *) addr, end - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
 				pmd_mkuptodate(*npmd);
 			}
 			addr += PMD_SIZE;
+			continue;
+		}
+
+		npte = pte_offset_kernel(npmd, addr);
+		r = pte_read(*npte);
+		w = pte_write(*npte);
+		x = pte_exec(*npte);
+		if(!pte_dirty(*npte))
+			w = 0;
+		if(!pte_young(*npte)){
+			r = 0;
+			w = 0;
+		}
+		if(force || pte_newpage(*npte)){
+			err = unmap(fd, (void *) addr, PAGE_SIZE);
+			if(err < 0)
+				panic("munmap failed, errno = %d\n", -err);
+			if(pte_present(*npte))
+				map(fd, addr, pte_val(*npte) & PAGE_MASK,
+				    PAGE_SIZE, r, w, x);
 		}
+		else if(pte_newprot(*npte))
+			protect(fd, addr, PAGE_SIZE, r, w, x, 1);
+
+		*npte = pte_mkuptodate(*npte);
+		addr += PAGE_SIZE;
 	}
 }
 
@@ -73,9 +106,10 @@
 {
 	struct mm_struct *mm;
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long addr;
+	unsigned long addr, last;
 	int updated = 0, err;
 
 	mm = &init_mm;
@@ -83,36 +117,71 @@
 		pgd = pgd_offset(mm, addr);
 		pud = pud_offset(pgd, addr);
 		pmd = pmd_offset(pud, addr);
-		if(pmd_present(*pmd)){
-			pte = pte_offset_kernel(pmd, addr);
-			if(!pte_present(*pte) || pte_newpage(*pte)){
+ 		if(!pgd_present(*pgd)){
+			if(pgd_newpage(*pgd)){
 				updated = 1;
+				last = addr + PGDIR_SIZE;
+				if(last > end)
+					last = end;
 				err = os_unmap_memory((void *) addr, 
-						      PAGE_SIZE);
+						      last - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
-				if(pte_present(*pte))
-					map_memory(addr, 
-						   pte_val(*pte) & PAGE_MASK,
-						   PAGE_SIZE, 1, 1, 1);
 			}
-			else if(pte_newprot(*pte)){
+			addr += PGDIR_SIZE;
+			continue;
+		}
+
+		pud = pud_offset(pgd, addr);
+		if(!pud_present(*pud)){
+			if(pud_newpage(*pud)){
 				updated = 1;
-				protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
+				last = addr + PUD_SIZE;
+				if(last > end)
+					last = end;
+				err = os_unmap_memory((void *) addr, 
+						      last - addr);
+				if(err < 0)
+					panic("munmap failed, errno = %d\n",
+					      -err);
 			}
-			addr += PAGE_SIZE;
+			addr += PUD_SIZE;
+			continue;
 		}
-		else {
+
+		pmd = pmd_offset(pud, addr);
+		if(!pmd_present(*pmd)){
 			if(pmd_newpage(*pmd)){
 				updated = 1;
-				err = os_unmap_memory((void *) addr, PMD_SIZE);
+				last = addr + PMD_SIZE;
+				if(last > end)
+					last = end;
+				err = os_unmap_memory((void *) addr, 
+						      last - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
 			}
 			addr += PMD_SIZE;
+			continue;
+		}
+
+		pte = pte_offset_kernel(pmd, addr);
+		if(!pte_present(*pte) || pte_newpage(*pte)){
+			updated = 1;
+			err = os_unmap_memory((void *) addr, PAGE_SIZE);
+			if(err < 0)
+				panic("munmap failed, errno = %d\n", -err);
+			if(pte_present(*pte))
+				map_memory(addr, pte_val(*pte) & PAGE_MASK,
+					   PAGE_SIZE, 1, 1, 1);
 		}
+		else if(pte_newprot(*pte)){
+			updated = 1;
+			protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
+  		}
+		addr += PAGE_SIZE;
 	}
 }
 
Index: 2.6.10/arch/um/kernel/trap_kern.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/trap_kern.c	2005-01-09 18:30:07.000000000 -0500
+++ 2.6.10/arch/um/kernel/trap_kern.c	2005-01-09 18:30:19.000000000 -0500
@@ -59,7 +59,7 @@
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
 	page = address & PAGE_MASK;
-	pgd = pgd_offset(mm);
+	pgd = pgd_offset(mm, page);
 	pud = pud_offset(pgd, page);
 	pmd = pmd_offset(pud, page);
 	do {
@@ -80,6 +80,9 @@
 		default:
 			BUG();
 		}
+		pgd = pgd_offset(mm, page);
+		pud = pud_offset(pgd, page);
+		pmd = pmd_offset(pud, page);
 		pte = pte_offset_kernel(pmd, page);
 	} while(!pte_present(*pte));
 	err = 0;
Index: 2.6.10/arch/um/kernel/tt/tlb.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/tlb.c	2005-01-09 18:30:07.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/tlb.c	2005-01-09 18:30:19.000000000 -0500
@@ -1,5 +1,6 @@
 /* 
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
  * Licensed under the GPL
  */
 
@@ -22,7 +23,7 @@
 	pud_t *npud;
 	pmd_t *npmd;
 	pte_t *npte;
-	unsigned long addr;
+	unsigned long addr, end;
 	int r, w, x, err;
 
 	if((current->thread.mode.tt.extern_pid != -1) && 
@@ -42,46 +43,81 @@
 			addr = STACK_TOP - ABOVE_KMEM;
 			continue;
 		}
+
 		npgd = pgd_offset(mm, addr);
+ 		if(!pgd_present(*npgd)){
+ 			if(force || pgd_newpage(*npgd)){
+ 				end = addr + PGDIR_SIZE;
+ 				if(end > end_addr)
+ 					end = end_addr;
+				err = os_unmap_memory((void *) addr, 
+ 						      end - addr);
+				if(err < 0)
+					panic("munmap failed, errno = %d\n",
+					      -err);
+				pgd_mkuptodate(*npgd);
+ 			}
+			addr += PGDIR_SIZE;
+			continue;
+ 		}
+
 		npud = pud_offset(npgd, addr);
-		npmd = pmd_offset(npud, addr);
-		if(pmd_present(*npmd)){
-			npte = pte_offset_kernel(npmd, addr);
-			r = pte_read(*npte);
-			w = pte_write(*npte);
-			x = pte_exec(*npte);
-			if(!pte_dirty(*npte)) w = 0;
-			if(!pte_young(*npte)){
-				r = 0;
-				w = 0;
-			}
-			if(force || pte_newpage(*npte)){
+		if(!pud_present(*npud)){
+			if(force || pud_newpage(*npud)){
+ 				end = addr + PUD_SIZE;
+ 				if(end > end_addr)
+ 					end = end_addr;
 				err = os_unmap_memory((void *) addr, 
-						      PAGE_SIZE);
+						      end - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
-				if(pte_present(*npte))
-					map_memory(addr, 
-						   pte_val(*npte) & PAGE_MASK,
-						   PAGE_SIZE, r, w, x);
-			}
-			else if(pte_newprot(*npte)){
-				protect_memory(addr, PAGE_SIZE, r, w, x, 1);
+				pud_mkuptodate(*npud);
 			}
-			*npte = pte_mkuptodate(*npte);
-			addr += PAGE_SIZE;
+			addr += PUD_SIZE;
+			continue;
 		}
-		else {
+
+		npmd = pmd_offset(npud, addr);
+		if(!pmd_present(*npmd)){
 			if(force || pmd_newpage(*npmd)){
-				err = os_unmap_memory((void *) addr, PMD_SIZE);
+ 				end = addr + PMD_SIZE;
+ 				if(end > end_addr)
+ 					end = end_addr;
+				err = os_unmap_memory((void *) addr, 
+						      end - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
 				pmd_mkuptodate(*npmd);
 			}
 			addr += PMD_SIZE;
+			continue;
 		}
+
+		npte = pte_offset_kernel(npmd, addr);
+		r = pte_read(*npte);
+		w = pte_write(*npte);
+		x = pte_exec(*npte);
+		if(!pte_dirty(*npte)) 
+			w = 0;
+		if(!pte_young(*npte)){
+			r = 0;
+			w = 0;
+		}
+		if(force || pte_newpage(*npte)){
+			err = os_unmap_memory((void *) addr, PAGE_SIZE);
+			if(err < 0)
+				panic("munmap failed, errno = %d\n", -err);
+			if(pte_present(*npte))
+				map_memory(addr, pte_val(*npte) & PAGE_MASK,
+					   PAGE_SIZE, r, w, x);
+		}
+		else if(pte_newprot(*npte))
+			protect_memory(addr, PAGE_SIZE, r, w, x, 1);
+		
+		*npte = pte_mkuptodate(*npte);
+		addr += PAGE_SIZE;
 	}
 }
 
@@ -92,47 +128,83 @@
 {
 	struct mm_struct *mm;
 	pgd_t *pgd;
-	pud_t *pmd;
+	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long addr;
+	unsigned long addr, last;
 	int updated = 0, err;
 
 	mm = &init_mm;
 	for(addr = start; addr < end;){
 		pgd = pgd_offset(mm, addr);
-		pud = pud_offset(pgd, addr);
-		pmd = pmd_offset(pud, addr);
-		if(pmd_present(*pmd)){
-			pte = pte_offset_kernel(pmd, addr);
-			if(!pte_present(*pte) || pte_newpage(*pte)){
+ 		if(!pgd_present(*pgd)){
+ 			if(pgd_newpage(*pgd)){
 				updated = 1;
+ 				last = addr + PGDIR_SIZE;
+ 				if(last > end)
+ 					last = end;
 				err = os_unmap_memory((void *) addr, 
-						      PAGE_SIZE);
+						      last - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
-				if(pte_present(*pte))
-					map_memory(addr, 
-						   pte_val(*pte) & PAGE_MASK,
-						   PAGE_SIZE, 1, 1, 1);
 			}
-			else if(pte_newprot(*pte)){
+			addr += PGDIR_SIZE;
+			continue;
+		}
+
+		pud = pud_offset(pgd, addr);
+		if(!pud_present(*pud)){
+			if(pud_newpage(*pud)){
 				updated = 1;
-				protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
+				last = addr + PUD_SIZE;
+				if(last > end)
+					last = end;
+				err = os_unmap_memory((void *) addr, 
+						      last - addr);
+				if(err < 0)
+					panic("munmap failed, errno = %d\n",
+					      -err);
 			}
-			addr += PAGE_SIZE;
+			addr += PUD_SIZE;
+			continue;
 		}
-		else {
+
+		pmd = pmd_offset(pud, addr);
+		if(!pmd_present(*pmd)){
 			if(pmd_newpage(*pmd)){
 				updated = 1;
-				err = os_unmap_memory((void *) addr, PMD_SIZE);
+				last = addr + PMD_SIZE;
+				if(last > end)
+					last = end;
+				err = os_unmap_memory((void *) addr, 
+						      last - addr);
 				if(err < 0)
 					panic("munmap failed, errno = %d\n",
 					      -err);
 			}
 			addr += PMD_SIZE;
+			continue;
+		}
+
+		pte = pte_offset_kernel(pmd, addr);
+		if(!pte_present(*pte) || pte_newpage(*pte)){
+			updated = 1;
+			err = os_unmap_memory((void *) addr, 
+					      PAGE_SIZE);
+			if(err < 0)
+				panic("munmap failed, errno = %d\n",
+				      -err);
+			if(pte_present(*pte))
+				map_memory(addr, 
+					   pte_val(*pte) & PAGE_MASK,
+					   PAGE_SIZE, 1, 1, 1);
+		}
+		else if(pte_newprot(*pte)){
+			updated = 1;
+			protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
 		}
+		addr += PAGE_SIZE;
 	}
 	if(updated && update_seq) atomic_inc(&vmchange_seq);
 }
Index: 2.6.10/include/asm-um/page.h
===================================================================
--- 2.6.10.orig/include/asm-um/page.h	2005-01-09 18:29:55.000000000 -0500
+++ 2.6.10/include/asm-um/page.h	2005-01-09 18:30:19.000000000 -0500
@@ -1,5 +1,6 @@
 /*
- *  Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Copyright 2003 PathScale, Inc.
  * Licensed under the GPL
  */
 
@@ -8,19 +9,83 @@
 
 struct page;
 
-#include "asm/arch/page.h"
+#include <linux/config.h>
+#include <asm/vm-flags.h>
+  
+/* PAGE_SHIFT determines the page size */
+#define PAGE_SHIFT	12
+#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#define PAGE_MASK	(~(PAGE_SIZE-1))
+
+/*
+ * These are used to make use of C type-checking..
+ */
+
+#define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
+#define copy_page(to,from)	memcpy((void *)(to), (void *)(from), PAGE_SIZE)
+
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
+
+#if defined(CONFIG_3_LEVEL_PGTABLES) && !defined(CONFIG_64_BIT)
+
+typedef struct { unsigned long pte_low, pte_high; } pte_t;
+typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct { unsigned long pgd; } pgd_t;
+#define pte_val(x) ((x).pte_low | ((unsigned long long) (x).pte_high << 32))
+
+#define pte_get_bits(pte, bits) ((pte).pte_low & (bits))
+#define pte_set_bits(pte, bits) ((pte).pte_low |= (bits))
+#define pte_clear_bits(pte, bits) ((pte).pte_low &= ~(bits))
+#define pte_copy(to, from) ({ (to).pte_high = (from).pte_high; \
+			      smp_wmb(); \
+			      (to).pte_low = (from).pte_low; })
+#define pte_is_zero(pte) (!((pte).pte_low & ~_PAGE_NEWPAGE) && !(pte).pte_high)
+#define pte_set_val(pte, phys, prot) \
+	({ (pte).pte_high = (phys) >> 32; \
+	   (pte).pte_low = (phys) | pgprot_val(prot); })
+
+typedef unsigned long long pfn_t;
+typedef unsigned long long phys_t;
+
+#else
+
+typedef struct { unsigned long pte; } pte_t;
+typedef struct { unsigned long pgd; } pgd_t;
+
+#ifdef CONFIG_3_LEVEL_PGTABLES
+typedef struct { unsigned long pmd; } pmd_t;
+#define pmd_val(x)	((x).pmd)
+#define __pmd(x) ((pmd_t) { (x) } )
+#endif
+
+#define pte_val(x)	((x).pte)
 
-#undef __pa
-#undef __va
-#undef pfn_to_page
-#undef page_to_pfn
-#undef virt_to_page
-#undef pfn_valid
-#undef virt_addr_valid
-#undef VALID_PAGE
-#undef PAGE_OFFSET
-#undef KERNELBASE
 
+#define pte_get_bits(p, bits) ((p).pte & (bits))
+#define pte_set_bits(p, bits) ((p).pte |= (bits))
+#define pte_clear_bits(p, bits) ((p).pte &= ~(bits))
+#define pte_copy(to, from) ((to).pte = (from).pte)
+#define pte_is_zero(p) (!((p).pte & ~_PAGE_NEWPAGE))
+#define pte_set_val(p, phys, prot) (p).pte = (phys | pgprot_val(prot))
+
+typedef unsigned long pfn_t;
+typedef unsigned long phys_t;
+
+#endif
+
+typedef struct { unsigned long pgprot; } pgprot_t;
+
+#define pgd_val(x)	((x).pgd)
+#define pgprot_val(x)	((x).pgprot)
+
+#define __pte(x) ((pte_t) { (x) } )
+#define __pgd(x) ((pgd_t) { (x) } )
+#define __pgprot(x)	((pgprot_t) { (x) } )
+
+/* to align the pointer to the (next) page boundary */
+#define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
+  
 extern unsigned long uml_physmem;
 
 #define PAGE_OFFSET (uml_physmem)
@@ -30,7 +95,6 @@
 
 extern unsigned long to_phys(void *virt);
 extern void *to_virt(unsigned long phys);
-
 #define __pa(virt) to_phys((void *) virt)
 #define __va(phys) to_virt((unsigned long) phys)
 
@@ -47,6 +111,20 @@
 #define HAVE_ARCH_VALIDATE
 #define devmem_is_allowed(x) 1
 
+/* Pure 2^n version of get_order */
+static __inline__ int get_order(unsigned long size)
+{
+	int order;
+
+	size = (size-1) >> (PAGE_SHIFT-1);
+	order = -1;
+	do {
+		size >>= 1;
+		order++;
+	} while (size);
+	return order;
+}
+
 extern void __arch_free_page(struct page *page, int order);
 #define arch_free_page(page, order) (__arch_free_page((page), (order)), 0)
 #define HAVE_ARCH_FREE_PAGE
Index: 2.6.10/include/asm-um/pgalloc.h
===================================================================
--- 2.6.10.orig/include/asm-um/pgalloc.h	2005-01-09 18:30:07.000000000 -0500
+++ 2.6.10/include/asm-um/pgalloc.h	2005-01-09 18:30:19.000000000 -0500
@@ -1,5 +1,6 @@
 /* 
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
  * Derived from include/asm-i386/pgalloc.h and include/asm-i386/pgtable.h
  * Licensed under the GPL
  */
@@ -7,11 +8,12 @@
 #ifndef __UM_PGALLOC_H
 #define __UM_PGALLOC_H
 
+#include "linux/config.h"
 #include "linux/mm.h"
 #include "asm/fixmap.h"
 
 #define pmd_populate_kernel(mm, pmd, pte) \
-		set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) __pa(pte)))
+	set_pmd(pmd, __pmd(_PAGE_TABLE + (unsigned long) __pa(pte)))
 
 #define pmd_populate(mm, pmd, pte) 				\
 	set_pmd(pmd, __pmd(_PAGE_TABLE +			\
@@ -39,15 +41,13 @@
 
 #define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
 
+#ifdef CONFIG_3_LEVEL_PGTABLES
 /*
- * allocating and freeing a pmd is trivial: the 1-entry pmd is
- * inside the pgd, so has no extra memory associated with it.
+ * In the 3-level case we free the pmds as part of the pgd.
  */
-
-#define pmd_alloc_one(mm, addr)		({ BUG(); ((pmd_t *)2); })
 #define pmd_free(x)			do { } while (0)
 #define __pmd_free_tlb(tlb,x)		do { } while (0)
-#define pud_populate(mm, pmd, pte)	BUG()
+#endif
 
 #define check_pgt_cache()	do { } while (0)
 
Index: 2.6.10/include/asm-um/pgtable-2level.h
===================================================================
--- 2.6.10.orig/include/asm-um/pgtable-2level.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/pgtable-2level.h	2005-01-09 18:30:19.000000000 -0500
@@ -0,0 +1,83 @@
+/* 
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
+ * Derived from include/asm-i386/pgtable.h
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_PGTABLE_2LEVEL_H
+#define __UM_PGTABLE_2LEVEL_H
+
+#include <asm-generic/pgtable-nopmd.h>
+
+/* PGDIR_SHIFT determines what a third-level page table entry can map */
+
+#define PGDIR_SHIFT	22
+#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+
+/*
+ * entries per page directory level: the i386 is two-level, so
+ * we don't really have any PMD directory physically.
+ */
+#define PTRS_PER_PTE	1024
+#define PTRS_PER_PMD	1
+#define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
+#define PTRS_PER_PGD	1024
+#define FIRST_USER_PGD_NR       0
+
+#define pte_ERROR(e) \
+        printk("%s:%d: bad pte %p(%08lx).\n", __FILE__, __LINE__, &(e), \
+	       pte_val(e))
+#define pgd_ERROR(e) \
+        printk("%s:%d: bad pgd %p(%08lx).\n", __FILE__, __LINE__, &(e), \
+	       pgd_val(e))
+
+static inline int pgd_newpage(pgd_t pgd)	{ return 0; }
+static inline void pgd_mkuptodate(pgd_t pgd)	{ }
+
+#define pte_present(x)	(pte_val(x) & (_PAGE_PRESENT | _PAGE_PROTNONE))
+
+static inline pte_t pte_mknewprot(pte_t pte)
+{
+ 	pte_val(pte) |= _PAGE_NEWPROT;
+	return(pte);
+}
+
+static inline pte_t pte_mknewpage(pte_t pte)
+{
+	pte_val(pte) |= _PAGE_NEWPAGE;
+	return(pte);
+}
+
+static inline void set_pte(pte_t *pteptr, pte_t pteval)
+{
+	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
+	 * fix_range knows to unmap it.  _PAGE_NEWPROT is specific to
+	 * mapped pages.
+	 */
+	*pteptr = pte_mknewpage(pteval);
+	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
+}
+
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+
+#define pte_page(x) pfn_to_page(pte_pfn(x))
+#define pte_none(x) !(pte_val(x) & ~_PAGE_NEWPAGE)
+#define pte_pfn(x) phys_to_pfn(pte_val(x))
+#define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
+#define pfn_pmd(pfn, prot) __pmd(pfn_to_phys(pfn) | pgprot_val(prot))
+
+#define pmd_page_kernel(pmd) \
+	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+
+/*
+ * Bits 0 through 3 are taken
+ */
+#define PTE_FILE_MAX_BITS	28
+
+#define pte_to_pgoff(pte) (pte_val(pte) >> 4)
+
+#define pgoff_to_pte(off) ((pte_t) { ((off) << 4) + _PAGE_FILE })
+
+#endif
Index: 2.6.10/include/asm-um/pgtable-3level.h
===================================================================
--- 2.6.10.orig/include/asm-um/pgtable-3level.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/pgtable-3level.h	2005-01-09 18:30:19.000000000 -0500
@@ -0,0 +1,172 @@
+/* 
+ * Copyright 2003 PathScale Inc
+ * Derived from include/asm-i386/pgtable.h 
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_PGTABLE_3LEVEL_H
+#define __UM_PGTABLE_3LEVEL_H
+
+#include <asm-generic/pgtable-nopud.h>
+
+/* PGDIR_SHIFT determines what a third-level page table entry can map */
+
+#define PGDIR_SHIFT	30
+#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
+#define PGDIR_MASK	(~(PGDIR_SIZE-1))
+
+/* PMD_SHIFT determines the size of the area a second-level page table can 
+ * map 
+ */
+
+#define PMD_SHIFT	21
+#define PMD_SIZE	(1UL << PMD_SHIFT)
+#define PMD_MASK	(~(PMD_SIZE-1))
+
+/*
+ * entries per page directory level
+ */
+
+#define PTRS_PER_PTE 512
+#define PTRS_PER_PMD 512
+#define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
+#define PTRS_PER_PGD 512
+#define FIRST_USER_PGD_NR       0
+
+#define pte_ERROR(e) \
+        printk("%s:%d: bad pte %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+	       pte_val(e))
+#define pmd_ERROR(e) \
+        printk("%s:%d: bad pmd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+	       pmd_val(e))
+#define pgd_ERROR(e) \
+        printk("%s:%d: bad pgd %p(%016lx).\n", __FILE__, __LINE__, &(e), \
+	       pgd_val(e))
+
+#define pud_none(x)	(!(pud_val(x) & ~_PAGE_NEWPAGE))
+#define	pud_bad(x)	((pud_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+#define pud_present(x)	(pud_val(x) & _PAGE_PRESENT)
+#define pud_populate(mm, pud, pmd) \
+	set_pud(pud, __pud(_PAGE_TABLE + __pa(pmd)))
+
+#define set_pud(pudptr, pudval) set_64bit((phys_t *) (pudptr), pud_val(pudval))
+static inline int pgd_newpage(pgd_t pgd)
+{
+	return(pgd_val(pgd) & _PAGE_NEWPAGE);
+}
+
+static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
+
+
+#define pte_present(x)	pte_get_bits(x, (_PAGE_PRESENT | _PAGE_PROTNONE))
+
+static inline pte_t pte_mknewprot(pte_t pte)
+{
+        pte_set_bits(pte, _PAGE_NEWPROT);
+	return(pte);
+}
+
+static inline pte_t pte_mknewpage(pte_t pte)
+{
+	pte_set_bits(pte, _PAGE_NEWPAGE);
+	return(pte);
+}
+
+static inline void set_pte(pte_t *pteptr, pte_t pteval)
+{
+	pte_copy(*pteptr, pteval);
+
+	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
+	 * fix_range knows to unmap it.  _PAGE_NEWPROT is specific to
+	 * mapped pages.
+	 */
+
+	*pteptr = pte_mknewpage(*pteptr);
+	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
+}
+
+#define set_pmd(pmdptr, pmdval) set_64bit((phys_t *) (pmdptr), pmd_val(pmdval))
+
+static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+        pmd_t *pmd = (pmd_t *) __get_free_page(GFP_KERNEL);
+
+        if(pmd)
+                memset(pmd, 0, PAGE_SIZE);
+
+        return pmd;
+}
+
+static inline void pmd_free(pmd_t *pmd){
+	free_page((unsigned long) pmd);
+}
+
+#define __pmd_free_tlb(tlb,x)   do { } while (0)
+
+static inline void pud_clear (pud_t * pud) { }
+
+#define pud_page(pud) \
+	((struct page *) __va(pud_val(pud) & PAGE_MASK))
+
+/* Find an entry in the second-level page table.. */
+#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
+			pmd_index(address))
+
+#define pte_page(x) pfn_to_page(pte_pfn(x))
+
+static inline int pte_none(pte_t pte)
+{
+	return pte_is_zero(pte);
+}
+
+static inline unsigned long pte_pfn(pte_t pte)
+{
+	return phys_to_pfn(pte_val(pte));
+}
+
+static inline pte_t pfn_pte(pfn_t page_nr, pgprot_t pgprot)
+{
+	pte_t pte;
+	phys_t phys = pfn_to_phys(page_nr);
+
+	pte_set_val(pte, phys, pgprot);
+	return pte;
+}
+
+static inline pmd_t pfn_pmd(pfn_t page_nr, pgprot_t pgprot)
+{
+	return __pmd((page_nr << PAGE_SHIFT) | pgprot_val(pgprot));
+}
+
+/*
+ * Bits 0 through 3 are taken in the low part of the pte,
+ * put the 32 bits of offset into the high part.
+ */
+#define PTE_FILE_MAX_BITS	32
+
+#ifdef CONFIG_64_BIT
+
+#define pte_to_pgoff(p) ((p).pte >> 32)
+
+#define pgoff_to_pte(off) ((pte_t) { ((off) < 32) | _PAGE_FILE })
+
+#else
+
+#define pte_to_pgoff(pte) ((pte).pte_high)
+
+#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+
+#endif
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/include/asm-um/pgtable.h
===================================================================
--- 2.6.10.orig/include/asm-um/pgtable.h	2005-01-09 18:30:07.000000000 -0500
+++ 2.6.10/include/asm-um/pgtable.h	2005-01-09 18:30:19.000000000 -0500
@@ -1,5 +1,6 @@
 /* 
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright 2003 PathScale, Inc.
  * Derived from include/asm-i386/pgtable.h
  * Licensed under the GPL
  */
@@ -12,6 +13,24 @@
 #include "asm/page.h"
 #include "asm/fixmap.h"
 
+#define _PAGE_PRESENT	0x001
+#define _PAGE_NEWPAGE	0x002
+#define _PAGE_NEWPROT   0x004
+#define _PAGE_FILE	0x008   /* set:pagecache unset:swap */
+#define _PAGE_PROTNONE	0x010	/* If not present */
+#define _PAGE_RW	0x020
+#define _PAGE_USER	0x040
+#define _PAGE_ACCESSED	0x080
+#define _PAGE_DIRTY	0x100
+
+#ifdef CONFIG_3_LEVEL_PGTABLES
+#include "asm/pgtable-3level.h"
+#else
+#include "asm/pgtable-2level.h"
+#endif
+
+extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
+
 extern void *um_virt_to_phys(struct task_struct *task, unsigned long virt,
 			     pte_t *pte_out);
 
@@ -20,33 +39,6 @@
 
 #define pgtable_cache_init() do ; while (0)
 
-/* PMD_SHIFT determines the size of the area a second-level page table can map */
-#define PMD_SIZE	(1UL << PMD_SHIFT)
-#define PMD_MASK	(~(PMD_SIZE-1))
-
-/* PGDIR_SHIFT determines what a third-level page table entry can map */
-#define PGDIR_SHIFT	22
-#define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
-#define PGDIR_MASK	(~(PGDIR_SIZE-1))
-
-/*
- * entries per page directory level: the i386 is two-level, so
- * we don't really have any PMD directory physically.
- */
-#define PTRS_PER_PTE	1024
-#define PTRS_PER_PMD	1
-#define PTRS_PER_PGD	1024
-#define FIRST_USER_PGD_NR       0
-
-#define pte_ERROR(e) \
-        printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
-#define pmd_ERROR(e) \
-        printk("%s:%d: bad pmd %08lx.\n", __FILE__, __LINE__, pmd_val(e))
-#define pgd_ERROR(e) \
-        printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
-
-extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
-
 /*
  * pgd entries used up by user/kernel:
  */
@@ -66,7 +58,7 @@
 extern unsigned long end_iomem;
 
 #define VMALLOC_OFFSET	(__va_space)
-#define VMALLOC_START	((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
+#define VMALLOC_START ((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
 
 #ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
@@ -74,18 +66,8 @@
 # define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
 #endif
 
-#define _PAGE_PRESENT	0x001
-#define _PAGE_NEWPAGE	0x002
-#define _PAGE_NEWPROT   0x004
-#define _PAGE_FILE	0x008   /* set:pagecache unset:swap */
-#define _PAGE_PROTNONE	0x010	/* If not present */
-#define _PAGE_RW	0x020
-#define _PAGE_USER	0x040
-#define _PAGE_ACCESSED	0x080
-#define _PAGE_DIRTY	0x100
-
-#define REGION_MASK	0xf0000000
-#define REGION_SHIFT	28
+#define REGION_SHIFT	(sizeof(pte_t) * 8 - 4)
+#define REGION_MASK	(((unsigned long) 0xf) << REGION_SHIFT)
 
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -153,16 +135,13 @@
 
 /* sizeof(void*)==1<<SIZEOF_PTR_LOG2 */
 /* 64-bit machines, beware!  SRB. */
-#define SIZEOF_PTR_LOG2			2
+#define SIZEOF_PTR_LOG2			3
 
 /* to find an entry in a page-table */
 #define PAGE_PTR(address) \
 ((unsigned long)(address)>>(PAGE_SHIFT-SIZEOF_PTR_LOG2)&PTR_MASK&~PAGE_MASK)
 
-#define pte_none(x)	!(pte_val(x) & ~_PAGE_NEWPAGE)
-#define pte_present(x)	(pte_val(x) & (_PAGE_PRESENT | _PAGE_PROTNONE))
-
-#define pte_clear(xp)	do { pte_val(*(xp)) = _PAGE_NEWPAGE; } while (0)
+#define pte_clear(xp) pte_set_val(*(xp), (phys_t) 0, __pgprot(_PAGE_NEWPAGE))
 
 #define pmd_none(x)	(!(pmd_val(x) & ~_PAGE_NEWPAGE))
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
@@ -181,93 +160,39 @@
 	BUG();
 }
 
-/*
- * The "pgd_xxx()" functions here are trivial for a folded two-level
- * setup: the pgd is never bad, and a pmd always exists (as it's folded
- * into the pgd entry)
- */
-static inline int pgd_none(pgd_t pgd)		{ return 0; }
-static inline int pgd_bad(pgd_t pgd)		{ return 0; }
-static inline int pgd_present(pgd_t pgd)	{ return 1; }
-static inline void pgd_clear(pgd_t * pgdp)	{ }
-
-
 #define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
 
-#define pte_page(pte) phys_to_page(pte_val(pte))
 #define pmd_page(pmd) phys_to_page(pmd_val(pmd) & PAGE_MASK)
 
-#define pte_pfn(x) phys_to_pfn(pte_val(x))
-#define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
-
-extern struct page *phys_to_page(const unsigned long phys);
-extern struct page *__virt_to_page(const unsigned long virt);
-#define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
-
-/*
- * Bits 0 through 3 are taken
- */
-#define PTE_FILE_MAX_BITS	28
-
-#define pte_to_pgoff(pte) ((pte).pte_low >> 4)
-
-#define pgoff_to_pte(off) \
-	((pte_t) { ((off) << 4) + _PAGE_FILE })
-
-static inline pte_t pte_mknewprot(pte_t pte)
-{
- 	pte_val(pte) |= _PAGE_NEWPROT;
-	return(pte);
-}
-
-static inline pte_t pte_mknewpage(pte_t pte)
-{
-	pte_val(pte) |= _PAGE_NEWPAGE;
-	return(pte);
-}
-
-static inline void set_pte(pte_t *pteptr, pte_t pteval)
-{
-	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE so
-	 * fix_range knows to unmap it.  _PAGE_NEWPROT is specific to
-	 * mapped pages.
-	 */
-	*pteptr = pte_mknewpage(pteval);
-	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
-}
-
-/*
- * (pmds are folded into pgds so this doesn't get actually called,
- * but the define is needed for a generic inline function.)
- */
-#define set_pmd(pmdptr, pmdval) (*(pmdptr) = pmdval)
-#define set_pgd(pgdptr, pgdval) (*(pgdptr) = pgdval)
-
+#define pte_address(x) (__va(pte_val(x) & PAGE_MASK))
+#define mk_phys(a, r) ((a) + (((unsigned long) r) << REGION_SHIFT))
+#define phys_addr(p) ((p) & ~REGION_MASK)
+  
 /*
  * The following only work if pte_present() is true.
  * Undefined behaviour if not..
  */
 static inline int pte_user(pte_t pte)
 {
-	return((pte_val(pte) & _PAGE_USER) &&
-	       !(pte_val(pte) & _PAGE_PROTNONE));
+	return((pte_get_bits(pte, _PAGE_USER)) && 
+	       !(pte_get_bits(pte, _PAGE_PROTNONE)));
 }
 
 static inline int pte_read(pte_t pte)
 { 
-	return((pte_val(pte) & _PAGE_USER) && 
-	       !(pte_val(pte) & _PAGE_PROTNONE));
+	return((pte_get_bits(pte, _PAGE_USER)) && 
+	       !(pte_get_bits(pte, _PAGE_PROTNONE)));
 }
 
 static inline int pte_exec(pte_t pte){
-	return((pte_val(pte) & _PAGE_USER) &&
-	       !(pte_val(pte) & _PAGE_PROTNONE));
+	return((pte_get_bits(pte, _PAGE_USER)) &&
+	       !(pte_get_bits(pte, _PAGE_PROTNONE)));
 }
 
 static inline int pte_write(pte_t pte)
 {
-	return((pte_val(pte) & _PAGE_RW) &&
-	       !(pte_val(pte) & _PAGE_PROTNONE));
+	return((pte_get_bits(pte, _PAGE_RW)) &&
+	       !(pte_get_bits(pte, _PAGE_PROTNONE)));
 }
 
 /*
@@ -275,85 +200,98 @@
  */
 static inline int pte_file(pte_t pte)
 {
-	return (pte).pte_low & _PAGE_FILE;
+	return pte_get_bits(pte, _PAGE_FILE);
+}
+
+static inline int pte_dirty(pte_t pte) 
+{
+	return pte_get_bits(pte, _PAGE_DIRTY);
+}
+
+static inline int pte_young(pte_t pte)
+{
+	return pte_get_bits(pte, _PAGE_ACCESSED);
+}
+
+static inline int pte_newpage(pte_t pte)
+{
+	return pte_get_bits(pte, _PAGE_NEWPAGE);
 }
 
-static inline int pte_dirty(pte_t pte)	{ return pte_val(pte) & _PAGE_DIRTY; }
-static inline int pte_young(pte_t pte)	{ return pte_val(pte) & _PAGE_ACCESSED; }
-static inline int pte_newpage(pte_t pte) { return pte_val(pte) & _PAGE_NEWPAGE; }
 static inline int pte_newprot(pte_t pte)
 { 
-	return(pte_present(pte) && (pte_val(pte) & _PAGE_NEWPROT)); 
+	return(pte_present(pte) && (pte_get_bits(pte, _PAGE_NEWPROT)));
 }
 
 static inline pte_t pte_rdprotect(pte_t pte)
 { 
-	pte_val(pte) &= ~_PAGE_USER; 
+	pte_clear_bits(pte, _PAGE_USER);
 	return(pte_mknewprot(pte));
 }
 
 static inline pte_t pte_exprotect(pte_t pte)
 { 
-	pte_val(pte) &= ~_PAGE_USER;
+	pte_clear_bits(pte, _PAGE_USER);
 	return(pte_mknewprot(pte));
 }
 
 static inline pte_t pte_mkclean(pte_t pte)
 {
-	pte_val(pte) &= ~_PAGE_DIRTY; 
+	pte_clear_bits(pte, _PAGE_DIRTY);
 	return(pte);
 }
 
 static inline pte_t pte_mkold(pte_t pte)	
 { 
-	pte_val(pte) &= ~_PAGE_ACCESSED; 
+	pte_clear_bits(pte, _PAGE_ACCESSED);
 	return(pte);
 }
 
 static inline pte_t pte_wrprotect(pte_t pte)
 { 
-	pte_val(pte) &= ~_PAGE_RW; 
+	pte_clear_bits(pte, _PAGE_RW);
 	return(pte_mknewprot(pte)); 
 }
 
 static inline pte_t pte_mkread(pte_t pte)
 { 
-	pte_val(pte) |= _PAGE_USER; 
+	pte_set_bits(pte, _PAGE_RW);
 	return(pte_mknewprot(pte)); 
 }
 
 static inline pte_t pte_mkexec(pte_t pte)
 { 
-	pte_val(pte) |= _PAGE_USER; 
+	pte_set_bits(pte, _PAGE_USER);
 	return(pte_mknewprot(pte)); 
 }
 
 static inline pte_t pte_mkdirty(pte_t pte)
 { 
-	pte_val(pte) |= _PAGE_DIRTY; 
+	pte_set_bits(pte, _PAGE_DIRTY);
 	return(pte);
 }
 
 static inline pte_t pte_mkyoung(pte_t pte)
 {
-	pte_val(pte) |= _PAGE_ACCESSED; 
+	pte_set_bits(pte, _PAGE_ACCESSED);
 	return(pte);
 }
 
 static inline pte_t pte_mkwrite(pte_t pte)	
 {
-	pte_val(pte) |= _PAGE_RW; 
+	pte_set_bits(pte, _PAGE_RW);
 	return(pte_mknewprot(pte)); 
 }
 
 static inline pte_t pte_mkuptodate(pte_t pte)	
 {
-	pte_val(pte) &= ~_PAGE_NEWPAGE;
-	if(pte_present(pte)) pte_val(pte) &= ~_PAGE_NEWPROT;
+	pte_clear_bits(pte, _PAGE_NEWPAGE);
+	if(pte_present(pte)) 
+		pte_clear_bits(pte, _PAGE_NEWPROT);
 	return(pte); 
 }
 
-extern unsigned long page_to_phys(struct page *page);
+extern phys_t page_to_phys(struct page *page);
 
 /*
  * Conversion functions: convert a page and protection to a page entry,
@@ -362,11 +300,9 @@
 
 extern pte_t mk_pte(struct page *page, pgprot_t pgprot);
 
-#define pte_set_val(p, phys, prot) pte_val(p) = (phys | pgprot_val(prot))
-
 static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
 {
-	pte_val(pte) = (pte_val(pte) & _PAGE_CHG_MASK) | pgprot_val(newprot);
+	pte_set_val(pte, (pte_val(pte) & _PAGE_CHG_MASK), newprot);
 	if(pte_present(pte)) pte = pte_mknewpage(pte_mknewprot(pte));
 	return pte; 
 }
@@ -401,8 +337,7 @@
  * this macro returns the index of the entry in the pmd page which would
  * control the given virtual address
  */
-#define pmd_index(address) \
-		(((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
+#define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
 /*
  * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
@@ -435,11 +370,15 @@
 
 #include <asm-generic/pgtable.h>
 
-#include <asm-um/pgtable-nopud.h>
+#include <asm-generic/pgtable-nopud.h>
 
 #endif
-
 #endif
+
+extern struct page *phys_to_page(const unsigned long phys);
+extern struct page *__virt_to_page(const unsigned long virt);
+#define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: 2.6.10/include/asm-um/vm-flags-i386.h
===================================================================
--- 2.6.10.orig/include/asm-um/vm-flags-i386.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/vm-flags-i386.h	2005-01-09 18:30:19.000000000 -0500
@@ -0,0 +1,14 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __VM_FLAGS_I386_H
+#define __VM_FLAGS_I386_H
+
+#define VM_DATA_DEFAULT_FLAGS \
+	(VM_READ | VM_WRITE | \
+	((current->personality & READ_IMPLIES_EXEC) ? VM_EXEC : 0 ) | \
+		 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+
+#endif
Index: 2.6.10/include/asm-um/vm-flags-x86_64.h
===================================================================
--- 2.6.10.orig/include/asm-um/vm-flags-x86_64.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/vm-flags-x86_64.h	2005-01-09 18:30:19.000000000 -0500
@@ -0,0 +1,27 @@
+/* 
+ * Copyright (C) 2004 Jeff Dike (jdike@addtoit.com)
+ * Copyright 2003 PathScale, Inc.
+ * Licensed under the GPL
+ */
+
+#ifndef __VM_FLAGS_X86_64_H
+#define __VM_FLAGS_X86_64_H
+
+#define __VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
+				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC)
+#define __VM_STACK_FLAGS 	(VM_GROWSDOWN | VM_READ | VM_WRITE | \
+				 VM_EXEC | VM_MAYREAD | VM_MAYWRITE | \
+				 VM_MAYEXEC)
+
+extern unsigned long vm_stack_flags, vm_stack_flags32;
+extern unsigned long vm_data_default_flags, vm_data_default_flags32;
+extern unsigned long vm_force_exec32;
+
+#define VM_DATA_DEFAULT_FLAGS \
+	(test_thread_flag(TIF_IA32) ? vm_data_default_flags32 : \
+	  vm_data_default_flags) 
+
+#define VM_STACK_DEFAULT_FLAGS \
+	(test_thread_flag(TIF_IA32) ? vm_stack_flags32 : vm_stack_flags) 
+
+#endif

