Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVCJAfP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVCJAfP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262573AbVCJAec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:34:32 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:53262 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262578AbVCJARK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:17:10 -0500
Message-Id: <200503100216.j2A2GnDN015254@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 8/9] UML - Consolidate tlb flushing code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Mar 2005 21:16:49 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch merges now-identical page table walking and flushing code that
had been duplicated in skas and tt modes.  The differences had been the
low-level address space updating operations, which are now abstracted away
in the respective do_ops functions.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/include/tlb.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/tlb.h	2005-03-08 22:25:56.000000000 -0500
+++ linux-2.6.11/arch/um/include/tlb.h	2005-03-09 17:21:33.000000000 -0500
@@ -36,6 +36,11 @@
 
 extern void mprotect_kernel_vm(int w);
 extern void force_flush_all(void);
+extern void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
+			     unsigned long end_addr, int force, int data,
+			     void (*do_ops)(int, struct host_vm_op *, int));
+extern int flush_tlb_kernel_range_common(unsigned long start, 
+					 unsigned long end);
 
 extern int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
 		    int r, int w, int x, struct host_vm_op *ops, int index, 
Index: linux-2.6.11/arch/um/include/um_mmu.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/um_mmu.h	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/include/um_mmu.h	2005-03-09 09:19:18.000000000 -0500
@@ -6,22 +6,22 @@
 #ifndef __ARCH_UM_MMU_H
 #define __ARCH_UM_MMU_H
 
-#include "linux/config.h"
+#include "uml-config.h"
 #include "choose-mode.h"
 
-#ifdef CONFIG_MODE_TT
+#ifdef UML_CONFIG_MODE_TT
 #include "mmu-tt.h"
 #endif
 
-#ifdef CONFIG_MODE_SKAS
+#ifdef UML_CONFIG_MODE_SKAS
 #include "mmu-skas.h"
 #endif
 
-typedef union {
-#ifdef CONFIG_MODE_TT
+typedef union mm_context {
+#ifdef UML_CONFIG_MODE_TT
 	struct mmu_context_tt tt;
 #endif
-#ifdef CONFIG_MODE_SKAS
+#ifdef UML_CONFIG_MODE_SKAS
 	struct mmu_context_skas skas;
 #endif
 } mm_context_t;
Index: linux-2.6.11/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/tlb.c	2005-03-08 22:25:56.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/tlb.c	2005-03-09 17:21:33.000000000 -0500
@@ -49,220 +49,37 @@
 static void fix_range(struct mm_struct *mm, unsigned long start_addr,
 		      unsigned long end_addr, int force)
 {
-	pgd_t *npgd;
-	pud_t *npud;
-	pmd_t *npmd;
-	pte_t *npte;
-	unsigned long addr,  end;
-	int r, w, x, fd;
-	struct host_vm_op ops[16];
-	int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
-
-	if(mm == NULL) return;
-	fd = mm->context.skas.mm_fd;
-	for(addr = start_addr; addr < end_addr;){
-		npgd = pgd_offset(mm, addr);
-		if(!pgd_present(*npgd)){
-			if(force || pgd_newpage(*npgd)){
-				end = addr + PGDIR_SIZE;
-				if(end > end_addr)
-					end = end_addr;
-				op_index = add_munmap(addr, end - addr, ops, 
-						      op_index, last_op, fd,
-						      do_ops);
-				pgd_mkuptodate(*npgd);
-			}
-			addr += PGDIR_SIZE;
-			continue;
-		}
-
-		npud = pud_offset(npgd, addr);
-		if(!pud_present(*npud)){
-			if(force || pud_newpage(*npud)){
-				end = addr + PUD_SIZE;
-				if(end > end_addr)
-					end = end_addr;
-				op_index = add_munmap(addr, end - addr, ops, 
-						      op_index, last_op, fd,
-						      do_ops);
-				pud_mkuptodate(*npud);
-			}
-			addr += PUD_SIZE;
-			continue;
-		}
-
-		npmd = pmd_offset(npud, addr);
-		if(!pmd_present(*npmd)){
-			if(force || pmd_newpage(*npmd)){
-				end = addr + PMD_SIZE;
-				if(end > end_addr)
-					end = end_addr;
-				op_index = add_munmap(addr, end - addr, ops, 
-						      op_index, last_op, fd,
-						      do_ops);
-				pmd_mkuptodate(*npmd);
-			}
-			addr += PMD_SIZE;
-			continue;
-		}
-
-		npte = pte_offset_kernel(npmd, addr);
-		r = pte_read(*npte);
-		w = pte_write(*npte);
-		x = pte_exec(*npte);
-		if(!pte_dirty(*npte))
-			w = 0;
-		if(!pte_young(*npte)){
-			r = 0;
-			w = 0;
-		}
-		if(force || pte_newpage(*npte)){
-			if(pte_present(*npte))
-				op_index = add_mmap(addr, 
-						    pte_val(*npte) & PAGE_MASK,
-						    PAGE_SIZE, r, w, x, ops, 
-						    op_index, last_op, fd,
-						    do_ops);
-			else op_index = add_munmap(addr, PAGE_SIZE, ops, 
-						   op_index, last_op, fd, 
-						   do_ops);
-		}
-		else if(pte_newprot(*npte))
-			op_index = add_mprotect(addr, PAGE_SIZE, r, w, x, ops, 
-						op_index, last_op, fd,
-						do_ops);
-
-		*npte = pte_mkuptodate(*npte);
-		addr += PAGE_SIZE;
-	}
-	do_ops(fd, ops, op_index);
-}
-
-void flush_tlb_kernel_range_skas(unsigned long start, unsigned long end)
-{
-	struct mm_struct *mm;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long addr, last;
-	int updated = 0, err;
-
-	mm = &init_mm;
-	for(addr = start; addr < end;){
-		pgd = pgd_offset(mm, addr);
-		pud = pud_offset(pgd, addr);
-		pmd = pmd_offset(pud, addr);
- 		if(!pgd_present(*pgd)){
-			if(pgd_newpage(*pgd)){
-				updated = 1;
-				last = addr + PGDIR_SIZE;
-				if(last > end)
-					last = end;
-				err = os_unmap_memory((void *) addr, 
-						      last - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr += PGDIR_SIZE;
-			continue;
-		}
-
-		pud = pud_offset(pgd, addr);
-		if(!pud_present(*pud)){
-			if(pud_newpage(*pud)){
-				updated = 1;
-				last = addr + PUD_SIZE;
-				if(last > end)
-					last = end;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr += PUD_SIZE;
-			continue;
-		}
-
-		pmd = pmd_offset(pud, addr);
-		if(!pmd_present(*pmd)){
-			if(pmd_newpage(*pmd)){
-				updated = 1;
-				last = addr + PMD_SIZE;
-				if(last > end)
-					last = end;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr += PMD_SIZE;
-			continue;
-		}
-
-		pte = pte_offset_kernel(pmd, addr);
-		if(!pte_present(*pte) || pte_newpage(*pte)){
-			updated = 1;
-			err = os_unmap_memory((void *) addr, PAGE_SIZE);
-			if(err < 0)
-				panic("munmap failed, errno = %d\n", -err);
-			if(pte_present(*pte))
-				map_memory(addr, pte_val(*pte) & PAGE_MASK,
-					   PAGE_SIZE, 1, 1, 1);
-		}
-		else if(pte_newprot(*pte)){
-			updated = 1;
-			protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
-  		}
-		addr += PAGE_SIZE;
-	}
-}
+        int fd = mm->context.skas.mm_fd;
 
-void flush_tlb_kernel_vm_skas(void)
-{
-	flush_tlb_kernel_range_skas(start_vm, end_vm);
+        fix_range_common(mm, start_addr, end_addr, force, fd, do_ops);
 }
 
 void __flush_tlb_one_skas(unsigned long addr)
 {
-	flush_tlb_kernel_range_skas(addr, addr + PAGE_SIZE);
+        flush_tlb_kernel_range_common(addr, addr + PAGE_SIZE);
 }
 
 void flush_tlb_range_skas(struct vm_area_struct *vma, unsigned long start, 
 		     unsigned long end)
 {
-	if(vma->vm_mm == NULL)
-		flush_tlb_kernel_range_skas(start, end);
-	else fix_range(vma->vm_mm, start, end, 0);
+        if(vma->vm_mm == NULL)
+                flush_tlb_kernel_range_common(start, end);
+        else fix_range(vma->vm_mm, start, end, 0);
 }
 
 void flush_tlb_mm_skas(struct mm_struct *mm)
 {
 	/* Don't bother flushing if this address space is about to be
-	 * destroyed.
-	 */
-	if(atomic_read(&mm->mm_users) == 0)
-		return;
+         * destroyed.
+         */
+        if(atomic_read(&mm->mm_users) == 0)
+                return;
 
-	flush_tlb_kernel_vm_skas();
-	fix_range(mm, 0, host_task_size, 0);
+        fix_range(mm, 0, host_task_size, 0);
+        flush_tlb_kernel_range_common(start_vm, end_vm);
 }
 
 void force_flush_all_skas(void)
 {
-	fix_range(current->mm, 0, host_task_size, 1);
+        fix_range(current->mm, 0, host_task_size, 1);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.11/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tlb.c	2005-03-08 23:07:08.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tlb.c	2005-03-09 17:21:33.000000000 -0500
@@ -9,88 +9,270 @@
 #include "asm/tlbflush.h"
 #include "choose-mode.h"
 #include "mode_kern.h"
+#include "user_util.h"
 #include "tlb.h"
 #include "mem.h"
+#include "mem_user.h"
+#include "os.h"
+
+void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
+                      unsigned long end_addr, int force, int data,
+                      void (*do_ops)(int, struct host_vm_op *, int))
+{
+        pgd_t *npgd;
+        pud_t *npud;
+        pmd_t *npmd;
+        pte_t *npte;
+        unsigned long addr, end;
+        int r, w, x;
+        struct host_vm_op ops[16];
+        int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
+
+        if(mm == NULL) return;
+
+        for(addr = start_addr; addr < end_addr;){
+                npgd = pgd_offset(mm, addr);
+                if(!pgd_present(*npgd)){
+                        if(force || pgd_newpage(*npgd)){
+                                end = addr + PGDIR_SIZE;
+                                if(end > end_addr)
+                                        end = end_addr;
+                                op_index = add_munmap(addr, end - addr, ops, 
+                                                      op_index, last_op, data,
+                                                      do_ops);
+                                pgd_mkuptodate(*npgd);
+                        }
+                        addr += PGDIR_SIZE;
+                        continue;
+                }
+
+                npud = pud_offset(npgd, addr);
+                if(!pud_present(*npud)){
+                        if(force || pud_newpage(*npud)){
+                                end = addr + PUD_SIZE;
+                                if(end > end_addr)
+                                        end = end_addr;
+                                op_index = add_munmap(addr, end - addr, ops, 
+                                                      op_index, last_op, data,
+                                                      do_ops);
+                                pud_mkuptodate(*npud);
+                        }
+                        addr += PUD_SIZE;
+                        continue;
+                }
+
+                npmd = pmd_offset(npud, addr);
+                if(!pmd_present(*npmd)){
+                        if(force || pmd_newpage(*npmd)){
+                                end = addr + PMD_SIZE;
+                                if(end > end_addr)
+                                        end = end_addr;
+                                op_index = add_munmap(addr, end - addr, ops, 
+                                                      op_index, last_op, data,
+                                                      do_ops);
+                                pmd_mkuptodate(*npmd);
+                        }
+                        addr += PMD_SIZE;
+                        continue;
+                }
+
+                npte = pte_offset_kernel(npmd, addr);
+                r = pte_read(*npte);
+                w = pte_write(*npte);
+                x = pte_exec(*npte);
+                if(!pte_dirty(*npte))
+                        w = 0;
+                if(!pte_young(*npte)){
+                        r = 0;
+                        w = 0;
+                }
+                if(force || pte_newpage(*npte)){
+                        if(pte_present(*npte))
+                                op_index = add_mmap(addr, 
+                                                    pte_val(*npte) & PAGE_MASK,
+                                                    PAGE_SIZE, r, w, x, ops, 
+                                                    op_index, last_op, data,
+                                                    do_ops);
+                        else op_index = add_munmap(addr, PAGE_SIZE, ops, 
+                                                   op_index, last_op, data, 
+                                                   do_ops);
+                }
+                else if(pte_newprot(*npte))
+                        op_index = add_mprotect(addr, PAGE_SIZE, r, w, x, ops, 
+                                                op_index, last_op, data,
+                                                do_ops);
+
+                *npte = pte_mkuptodate(*npte);
+                addr += PAGE_SIZE;
+        }
+        (*do_ops)(data, ops, op_index);
+}
+
+int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
+{
+        struct mm_struct *mm;
+        pgd_t *pgd;
+        pud_t *pud;
+        pmd_t *pmd;
+        pte_t *pte;
+        unsigned long addr, last;
+        int updated = 0, err;
+
+        mm = &init_mm;
+        for(addr = start; addr < end;){
+                pgd = pgd_offset(mm, addr);
+                if(!pgd_present(*pgd)){
+                        if(pgd_newpage(*pgd)){
+                                updated = 1;
+                                last = addr + PGDIR_SIZE;
+                                if(last > end)
+                                        last = end;
+                                err = os_unmap_memory((void *) addr, 
+                                                      last - addr);
+                                if(err < 0)
+                                        panic("munmap failed, errno = %d\n",
+                                              -err);
+                        }
+                        addr += PGDIR_SIZE;
+                        continue;
+                }
+
+                pud = pud_offset(pgd, addr);
+                if(!pud_present(*pud)){
+                        if(pud_newpage(*pud)){
+                                updated = 1;
+                                last = addr + PUD_SIZE;
+                                if(last > end)
+                                        last = end;
+                                err = os_unmap_memory((void *) addr,
+                                                      last - addr);
+                                if(err < 0)
+                                        panic("munmap failed, errno = %d\n",
+                                              -err);
+                        }
+                        addr += PUD_SIZE;
+                        continue;
+                }
+
+                pmd = pmd_offset(pud, addr);
+                if(!pmd_present(*pmd)){
+                        if(pmd_newpage(*pmd)){
+                                updated = 1;
+                                last = addr + PMD_SIZE;
+                                if(last > end)
+                                        last = end;
+                                err = os_unmap_memory((void *) addr,
+                                                      last - addr);
+                                if(err < 0)
+                                        panic("munmap failed, errno = %d\n",
+                                              -err);
+                        }
+                        addr += PMD_SIZE;
+                        continue;
+                }
+
+                pte = pte_offset_kernel(pmd, addr);
+                if(!pte_present(*pte) || pte_newpage(*pte)){
+                        updated = 1;
+                        err = os_unmap_memory((void *) addr,
+                                              PAGE_SIZE);
+                        if(err < 0)
+                                panic("munmap failed, errno = %d\n",
+                                      -err);
+                        if(pte_present(*pte))
+                                map_memory(addr,
+                                           pte_val(*pte) & PAGE_MASK,
+                                           PAGE_SIZE, 1, 1, 1);
+                }
+                else if(pte_newprot(*pte)){
+                        updated = 1;
+                        protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
+                }
+                addr += PAGE_SIZE;
+        }
+        return(updated);
+}
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 {
-	address &= PAGE_MASK;
-	flush_tlb_range(vma, address, address + PAGE_SIZE);
+        address &= PAGE_MASK;
+        flush_tlb_range(vma, address, address + PAGE_SIZE);
 }
 
 void flush_tlb_all(void)
 {
-	flush_tlb_mm(current->mm);
+        flush_tlb_mm(current->mm);
 }
   
 void flush_tlb_kernel_range(unsigned long start, unsigned long end)
 {
-	CHOOSE_MODE_PROC(flush_tlb_kernel_range_tt, 
-			 flush_tlb_kernel_range_skas, start, end);
+        CHOOSE_MODE_PROC(flush_tlb_kernel_range_tt, 
+                         flush_tlb_kernel_range_common, start, end);
 }
 
 void flush_tlb_kernel_vm(void)
 {
-	CHOOSE_MODE(flush_tlb_kernel_vm_tt(), flush_tlb_kernel_vm_skas());
+        CHOOSE_MODE(flush_tlb_kernel_vm_tt(), 
+                    flush_tlb_kernel_range_common(start_vm, end_vm));
 }
 
 void __flush_tlb_one(unsigned long addr)
 {
-	CHOOSE_MODE_PROC(__flush_tlb_one_tt, __flush_tlb_one_skas, addr);
+        CHOOSE_MODE_PROC(__flush_tlb_one_tt, __flush_tlb_one_skas, addr);
 }
 
 void flush_tlb_range(struct vm_area_struct *vma, unsigned long start, 
-		     unsigned long end)
+     unsigned long end)
 {
-	CHOOSE_MODE_PROC(flush_tlb_range_tt, flush_tlb_range_skas, vma, start, 
-			 end);
+        CHOOSE_MODE_PROC(flush_tlb_range_tt, flush_tlb_range_skas, vma, start, 
+                         end);
 }
 
 void flush_tlb_mm(struct mm_struct *mm)
 {
-	CHOOSE_MODE_PROC(flush_tlb_mm_tt, flush_tlb_mm_skas, mm);
+        CHOOSE_MODE_PROC(flush_tlb_mm_tt, flush_tlb_mm_skas, mm);
 }
 
 void force_flush_all(void)
 {
-	CHOOSE_MODE(force_flush_all_tt(), force_flush_all_skas());
+        CHOOSE_MODE(force_flush_all_tt(), force_flush_all_skas());
 }
 
 pgd_t *pgd_offset_proc(struct mm_struct *mm, unsigned long address)
 {
-	return(pgd_offset(mm, address));
+        return(pgd_offset(mm, address));
 }
 
 pud_t *pud_offset_proc(pgd_t *pgd, unsigned long address)
 {
-	return(pud_offset(pgd, address));
+        return(pud_offset(pgd, address));
 }
 
 pmd_t *pmd_offset_proc(pud_t *pud, unsigned long address)
 {
-	return(pmd_offset(pud, address));
+        return(pmd_offset(pud, address));
 }
 
 pte_t *pte_offset_proc(pmd_t *pmd, unsigned long address)
 {
-	return(pte_offset_kernel(pmd, address));
+        return(pte_offset_kernel(pmd, address));
 }
 
 pte_t *addr_pte(struct task_struct *task, unsigned long addr)
 {
-	pgd_t *pgd = pgd_offset(task->mm, addr);
-	pud_t *pud = pud_offset(pgd, addr);
-	pmd_t *pmd = pmd_offset(pud, addr);
+        pgd_t *pgd = pgd_offset(task->mm, addr);
+        pud_t *pud = pud_offset(pgd, addr);
+        pmd_t *pmd = pmd_offset(pud, addr);
 
-	return(pte_offset_map(pmd, addr));
+        return(pte_offset_map(pmd, addr));
 }
 
 int add_mmap(unsigned long virt, unsigned long phys, unsigned long len, 
-	     int r, int w, int x, struct host_vm_op *ops, int index, 
-	     int last_filled, int data,
-	     void (*do_ops)(int, struct host_vm_op *, int))
+     int r, int w, int x, struct host_vm_op *ops, int index, 
+     int last_filled, int data,
+     void (*do_ops)(int, struct host_vm_op *, int))
 {
-	__u64 offset;
+        __u64 offset;
 	struct host_vm_op *last;
 	int fd;
 
@@ -183,14 +365,3 @@
 						      .x	= x } } });
 	return(index);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.11/arch/um/kernel/tt/mem.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/mem.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/mem.c	2005-03-08 22:41:46.000000000 -0500
@@ -15,7 +15,7 @@
 
 void before_mem_tt(unsigned long brk_start)
 {
-	if(!jail || debug)
+	if(debug)
 		remap_data(UML_ROUND_DOWN(&_stext), UML_ROUND_UP(&_etext), 1);
 	remap_data(UML_ROUND_DOWN(&_sdata), UML_ROUND_UP(&_edata), 1);
 	remap_data(UML_ROUND_DOWN(&__bss_start), UML_ROUND_UP(&_end), 1);
Index: linux-2.6.11/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/process_kern.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/process_kern.c	2005-03-09 17:21:32.000000000 -0500
@@ -85,24 +85,6 @@
 	   (prev_sched->exit_state == EXIT_DEAD))
 		os_kill_process(prev_sched->thread.mode.tt.extern_pid, 1);
 
-	/* This works around a nasty race with 'jail'.  If we are switching
-	 * between two threads of a threaded app and the incoming process 
-	 * runs before the outgoing process reaches the read, and it makes
-	 * it all the way out to userspace, then it will have write-protected 
-	 * the outgoing process stack.  Then, when the outgoing process 
-	 * returns from the write, it will segfault because it can no longer
-	 * write its own stack.  So, in order to avoid that, the incoming 
-	 * thread sits in a loop yielding until 'reading' is set.  This 
-	 * isn't entirely safe, since there may be a reschedule from a timer
-	 * happening between setting 'reading' and sleeping in read.  But,
-	 * it should get a whole quantum in which to reach the read and sleep,
-	 * which should be enough.
-	 */
-
-	if(jail){
-		while(!reading) sched_yield();
-	}
-
 	change_sig(SIGVTALRM, vtalrm);
 	change_sig(SIGALRM, alrm);
 	change_sig(SIGPROF, prof);
@@ -394,84 +376,6 @@
 	default_idle();
 }
 
-/* Changed by jail_setup, which is a setup */
-int jail = 0;
-
-int __init jail_setup(char *line, int *add)
-{
-	int ok = 1;
-
-	if(jail) return(0);
-#ifdef CONFIG_SMP
-	printf("'jail' may not used used in a kernel with CONFIG_SMP "
-	       "enabled\n");
-	ok = 0;
-#endif
-#ifdef CONFIG_HOSTFS
-	printf("'jail' may not used used in a kernel with CONFIG_HOSTFS "
-	       "enabled\n");
-	ok = 0;
-#endif
-#ifdef CONFIG_MODULES
-	printf("'jail' may not used used in a kernel with CONFIG_MODULES "
-	       "enabled\n");
-	ok = 0;
-#endif	
-	if(!ok) exit(1);
-
-	/* CAP_SYS_RAWIO controls the ability to open /dev/mem and /dev/kmem.
-	 * Removing it from the bounding set eliminates the ability of anything
-	 * to acquire it, and thus read or write kernel memory.
-	 */
-	cap_lower(cap_bset, CAP_SYS_RAWIO);
-	jail = 1;
-	return(0);
-}
-
-__uml_setup("jail", jail_setup,
-"jail\n"
-"    Enables the protection of kernel memory from processes.\n\n"
-);
-
-static void mprotect_kernel_mem(int w)
-{
-	unsigned long start, end;
-	int pages;
-
-	if(!jail || (current == &init_task)) return;
-
-	pages = (1 << CONFIG_KERNEL_STACK_ORDER);
-
-	start = (unsigned long) current_thread + PAGE_SIZE;
-	end = (unsigned long) current_thread + PAGE_SIZE * pages;
-	protect_memory(uml_reserved, start - uml_reserved, 1, w, 1, 1);
-	protect_memory(end, high_physmem - end, 1, w, 1, 1);
-
-	start = (unsigned long) UML_ROUND_DOWN(&_stext);
-	end = (unsigned long) UML_ROUND_UP(&_etext);
-	protect_memory(start, end - start, 1, w, 1, 1);
-
-	start = (unsigned long) UML_ROUND_DOWN(&_unprotected_end);
-	end = (unsigned long) UML_ROUND_UP(&_edata);
-	protect_memory(start, end - start, 1, w, 1, 1);
-
-	start = (unsigned long) UML_ROUND_DOWN(&__bss_start);
-	end = (unsigned long) UML_ROUND_UP(brk_start);
-	protect_memory(start, end - start, 1, w, 1, 1);
-
-	mprotect_kernel_vm(w);
-}
-
-void unprotect_kernel_mem(void)
-{
-	mprotect_kernel_mem(1);
-}
-
-void protect_kernel_mem(void)
-{
-	mprotect_kernel_mem(0);
-}
-
 extern void start_kernel(void);
 
 static int start_kernel_proc(void *unused)
Index: linux-2.6.11/arch/um/kernel/tt/tlb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/tlb.c	2005-03-08 22:25:56.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/tlb.c	2005-03-09 17:21:33.000000000 -0500
@@ -50,202 +50,20 @@
 static void fix_range(struct mm_struct *mm, unsigned long start_addr, 
 		      unsigned long end_addr, int force)
 {
-	pgd_t *npgd;
-	pud_t *npud;
-	pmd_t *npmd;
-	pte_t *npte;
-	unsigned long addr, end;
-	int r, w, x;
-	struct host_vm_op ops[16];
-	int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
-
-	if((current->thread.mode.tt.extern_pid != -1) && 
-	   (current->thread.mode.tt.extern_pid != os_getpid()))
-		panic("fix_range fixing wrong address space, current = 0x%p",
-		      current);
-	if(mm == NULL) return;
-	for(addr=start_addr;addr<end_addr;){
-		if(addr == TASK_SIZE){
-			/* Skip over kernel text, kernel data, and physical
-			 * memory, which don't have ptes, plus kernel virtual
-			 * memory, which is flushed separately, and remap
-			 * the process stack.  The only way to get here is
-			 * if (end_addr == STACK_TOP) > TASK_SIZE, which is
-			 * only true in the honeypot case.
-			 */
-			addr = STACK_TOP - ABOVE_KMEM;
-			continue;
-		}
-
-		npgd = pgd_offset(mm, addr);
- 		if(!pgd_present(*npgd)){
- 			if(force || pgd_newpage(*npgd)){
- 				end = addr + PGDIR_SIZE;
- 				if(end > end_addr)
- 					end = end_addr;
-				op_index = add_munmap(addr, end - addr, ops, 
-						      op_index, last_op, 0,
-						      do_ops);
-				pgd_mkuptodate(*npgd);
- 			}
-			addr += PGDIR_SIZE;
-			continue;
- 		}
-
-		npud = pud_offset(npgd, addr);
-		if(!pud_present(*npud)){
-			if(force || pud_newpage(*npud)){
- 				end = addr + PUD_SIZE;
- 				if(end > end_addr)
- 					end = end_addr;
-				op_index = add_munmap(addr, end - addr, ops, 
-						      op_index, last_op, 0,
-						      do_ops);
-				pud_mkuptodate(*npud);
-			}
-			addr += PUD_SIZE;
-			continue;
-		}
-
-		npmd = pmd_offset(npud, addr);
-		if(!pmd_present(*npmd)){
-			if(force || pmd_newpage(*npmd)){
- 				end = addr + PMD_SIZE;
- 				if(end > end_addr)
- 					end = end_addr;
-				op_index = add_munmap(addr, end - addr, ops, 
-						      op_index, last_op, 0,
-						      do_ops);
-				pmd_mkuptodate(*npmd);
-			}
-			addr += PMD_SIZE;
-			continue;
-		}
-
-		npte = pte_offset_kernel(npmd, addr);
-		r = pte_read(*npte);
-		w = pte_write(*npte);
-		x = pte_exec(*npte);
-		if(!pte_dirty(*npte))
-			w = 0;
-		if(!pte_young(*npte)){
-			r = 0;
-			w = 0;
-		}
-		if(force || pte_newpage(*npte)){
-			if(pte_present(*npte))
-				op_index = add_mmap(addr, 
-						    pte_val(*npte) & PAGE_MASK,
-						    PAGE_SIZE, r, w, x, ops, 
-						    op_index, last_op, 0,
-						    do_ops);
-			else op_index = add_munmap(addr, PAGE_SIZE, ops, 
-						   op_index, last_op, 0, 
-						   do_ops);
-		}
-		else if(pte_newprot(*npte))
-			op_index = add_mprotect(addr, PAGE_SIZE, r, w, x, ops, 
-						op_index, last_op, 0, 
-						do_ops);
-
+        if((current->thread.mode.tt.extern_pid != -1) && 
+           (current->thread.mode.tt.extern_pid != os_getpid()))
+                panic("fix_range fixing wrong address space, current = 0x%p",
+                      current);
 
-		*npte = pte_mkuptodate(*npte);
-		addr += PAGE_SIZE;
-	}
-	do_ops(0, ops, op_index);
+        fix_range_common(mm, start_addr, end_addr, force, 0, do_ops);
 }
 
 atomic_t vmchange_seq = ATOMIC_INIT(1);
 
-static void flush_kernel_vm_range(unsigned long start, unsigned long end, 
-				  int update_seq)
-{
-	struct mm_struct *mm;
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	unsigned long addr, last;
-	int updated = 0, err;
-
-	mm = &init_mm;
-	for(addr = start; addr < end;){
-		pgd = pgd_offset(mm, addr);
- 		if(!pgd_present(*pgd)){
- 			if(pgd_newpage(*pgd)){
-				updated = 1;
- 				last = addr + PGDIR_SIZE;
- 				if(last > end)
- 					last = end;
-				err = os_unmap_memory((void *) addr, 
-						      last - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr += PGDIR_SIZE;
-			continue;
-		}
-
-		pud = pud_offset(pgd, addr);
-		if(!pud_present(*pud)){
-			if(pud_newpage(*pud)){
-				updated = 1;
-				last = addr + PUD_SIZE;
-				if(last > end)
-					last = end;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr += PUD_SIZE;
-			continue;
-		}
-
-		pmd = pmd_offset(pud, addr);
-		if(!pmd_present(*pmd)){
-			if(pmd_newpage(*pmd)){
-				updated = 1;
-				last = addr + PMD_SIZE;
-				if(last > end)
-					last = end;
-				err = os_unmap_memory((void *) addr,
-						      last - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
-			}
-			addr += PMD_SIZE;
-			continue;
-		}
-
-		pte = pte_offset_kernel(pmd, addr);
-		if(!pte_present(*pte) || pte_newpage(*pte)){
-			updated = 1;
-			err = os_unmap_memory((void *) addr,
-					      PAGE_SIZE);
-			if(err < 0)
-				panic("munmap failed, errno = %d\n",
-				      -err);
-			if(pte_present(*pte))
-				map_memory(addr,
-					   pte_val(*pte) & PAGE_MASK,
-					   PAGE_SIZE, 1, 1, 1);
-		}
-		else if(pte_newprot(*pte)){
-			updated = 1;
-			protect_memory(addr, PAGE_SIZE, 1, 1, 1, 1);
-		}
-		addr += PAGE_SIZE;
-	}
-	if(updated && update_seq) atomic_inc(&vmchange_seq);
-}
-
 void flush_tlb_kernel_range_tt(unsigned long start, unsigned long end)
 {
-        flush_kernel_vm_range(start, end, 1);
+        if(flush_tlb_kernel_range_common(start, end))
+                atomic_inc(&vmchange_seq);
 }
 
 static void protect_vm_page(unsigned long addr, int w, int must_succeed)
@@ -302,8 +120,10 @@
 	/* Assumes that the range start ... end is entirely within
 	 * either process memory or kernel vm
 	 */
-	if((start >= start_vm) && (start < end_vm)) 
-		flush_kernel_vm_range(start, end, 1);
+	if((start >= start_vm) && (start < end_vm)){
+		if(flush_tlb_kernel_range_common(start, end))
+			atomic_inc(&vmchange_seq);
+	}
 	else fix_range(vma->vm_mm, start, end, 0);
 }
 
@@ -316,24 +136,14 @@
 	fix_range(mm, 0, STACK_TOP, 0);
 
 	seq = atomic_read(&vmchange_seq);
-	if(current->thread.mode.tt.vm_seq == seq) return;
+	if(current->thread.mode.tt.vm_seq == seq)
+		return;
 	current->thread.mode.tt.vm_seq = seq;
-	flush_kernel_vm_range(start_vm, end_vm, 0);
+	flush_tlb_kernel_range_common(start_vm, end_vm);
 }
 
 void force_flush_all_tt(void)
 {
 	fix_range(current->mm, 0, STACK_TOP, 1);
-	flush_kernel_vm_range(start_vm, end_vm, 0);
+	flush_tlb_kernel_range_common(start_vm, end_vm);
 }
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.11/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/tracer.c	2005-03-08 22:25:56.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/tracer.c	2005-03-09 17:21:33.000000000 -0500
@@ -468,19 +468,6 @@
 "    the debug switch.\n\n"
 );
 
-static int __init uml_honeypot_setup(char *line, int *add)
-{
-	jail_setup("", add);
-	honeypot = 1;
-	return 0;
-}
-__uml_setup("honeypot", uml_honeypot_setup, 
-"honeypot\n"
-"    This makes UML put process stacks in the same location as they are\n"
-"    on the host, allowing expoits such as stack smashes to work against\n"
-"    UML.  This implies 'jail'.\n\n"
-);
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.11/arch/um/kernel/tt/trap_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/trap_user.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/trap_user.c	2005-03-09 17:21:33.000000000 -0500
@@ -20,8 +20,6 @@
 	struct signal_info *info;
 	int save_errno = errno, is_user;
 
-	unprotect_kernel_mem();
-
 	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
 	 * handler.  This can happen in copy_user, and if SEGV is disabled,
 	 * the process will die.
@@ -48,7 +46,6 @@
 	}
 	*r = save_regs;
 	errno = save_errno;
-	if(is_user) protect_kernel_mem();
 }
 
 /*

