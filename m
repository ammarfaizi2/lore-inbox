Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbVCIXys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbVCIXys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 18:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262533AbVCIXwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 18:52:37 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:21774 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S262132AbVCIXqK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 18:46:10 -0500
Message-Id: <200503100216.j2A2GiDN015249@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: torvalds@osdl.org
cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/9] UML - Speed up tlb flushing
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Mar 2005 21:16:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch optimizes tlb flushing in a couple of ways to reduce the number
of system calls made to the host in order to update an address space.

Operations are collected, and adjacent ones which can be merged, are.  This
includes consecutive munmaps, mprotects with the same permissions, and mmaps
with the same backing file and permissions and linear in the file.

Second, the munmaps that always preceded mmaps are now done instead of mmap if
necessary.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/include/tlb.h
===================================================================
--- linux-2.6.11.orig/arch/um/include/tlb.h	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/include/tlb.h	2005-03-08 22:22:23.000000000 -0500
@@ -6,9 +6,48 @@
 #ifndef __TLB_H__
 #define __TLB_H__
 
+#include "um_mmu.h"
+
+struct host_vm_op {
+	enum { MMAP, MUNMAP, MPROTECT } type;
+	union {
+		struct {
+			unsigned long addr;
+			unsigned long len;
+			unsigned int r:1;
+			unsigned int w:1;
+			unsigned int x:1;
+			int fd;
+			__u64 offset;
+		} mmap;
+		struct {
+			unsigned long addr;
+			unsigned long len;
+		} munmap;
+		struct {
+			unsigned long addr;
+			unsigned long len;
+			unsigned int r:1;
+			unsigned int w:1;
+			unsigned int x:1;
+		} mprotect;
+	} u;
+};
+
 extern void mprotect_kernel_vm(int w);
 extern void force_flush_all(void);
 
+extern int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
+		    int r, int w, int x, struct host_vm_op *ops, int index, 
+		    int last_filled, int data, 
+		    void (*do_ops)(int, struct host_vm_op *, int));
+extern int add_munmap(unsigned long addr, unsigned long len, 
+		      struct host_vm_op *ops, int index, int last_filled, 
+		      int data, void (*do_ops)(int, struct host_vm_op *, int));
+extern int add_mprotect(unsigned long addr, unsigned long len, int r, int w, 
+			int x, struct host_vm_op *ops, int index, 
+			int last_filled, int data,
+			void (*do_ops)(int, struct host_vm_op *, int));
 #endif
 
 /*
Index: linux-2.6.11/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/include/skas.h	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/include/skas.h	2005-03-08 22:22:23.000000000 -0500
@@ -22,11 +22,11 @@
 extern void remove_sigstack(void);
 extern void new_thread_handler(int sig);
 extern void handle_syscall(union uml_pt_regs *regs);
-extern void map(int fd, unsigned long virt, unsigned long phys, 
-		unsigned long len, int r, int w, int x);
-extern int unmap(int fd, void *addr, int len);
+extern void map(int fd, unsigned long virt, unsigned long len, int r, int w, 
+		int x, int phys_fd, unsigned long long offset);
+extern int unmap(int fd, void *addr, unsigned long len);
 extern int protect(int fd, unsigned long addr, unsigned long len, 
-		   int r, int w, int x, int must_succeed);
+		   int r, int w, int x);
 extern void user_signal(int sig, union uml_pt_regs *regs);
 extern int new_mm(int from);
 extern void start_userspace(int cpu);
Index: linux-2.6.11/arch/um/kernel/skas/mem_user.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/mem_user.c	2005-03-08 21:56:38.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/mem_user.c	2005-03-08 22:22:23.000000000 -0500
@@ -11,16 +11,14 @@
 #include "os.h"
 #include "proc_mm.h"
 
-void map(int fd, unsigned long virt, unsigned long phys, unsigned long len, 
-	 int r, int w, int x)
+void map(int fd, unsigned long virt, unsigned long len, int r, int w, 
+	 int x, int phys_fd, unsigned long long offset)
 {
 	struct proc_mm_op map;
-	__u64 offset;
-	int prot, n, phys_fd;
+	int prot, n;
 
 	prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) | 
 		(x ? PROT_EXEC : 0);
-	phys_fd = phys_mapping(phys, &offset);
 
 	map = ((struct proc_mm_op) { .op 	= MM_MMAP,
 				     .u 	= 
@@ -38,7 +36,7 @@
 		printk("map : /proc/mm map failed, err = %d\n", -n);
 }
 
-int unmap(int fd, void *addr, int len)
+int unmap(int fd, void *addr, unsigned long len)
 {
 	struct proc_mm_op unmap;
 	int n;
Index: linux-2.6.11/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/skas/tlb.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/skas/tlb.c	2005-03-08 22:22:23.000000000 -0500
@@ -12,8 +12,39 @@
 #include "asm/mmu.h"
 #include "user_util.h"
 #include "mem_user.h"
+#include "mem.h"
 #include "skas.h"
 #include "os.h"
+#include "tlb.h"
+
+static void do_ops(int fd, struct host_vm_op *ops, int last)
+{
+	struct host_vm_op *op;
+	int i;
+
+	for(i = 0; i <= last; i++){
+		op = &ops[i];
+		switch(op->type){
+		case MMAP:
+			map(fd, op->u.mmap.addr, op->u.mmap.len, 
+			    op->u.mmap.r, op->u.mmap.w, op->u.mmap.x,
+			    op->u.mmap.fd, op->u.mmap.offset);
+			break;
+		case MUNMAP:
+			unmap(fd, (void *) op->u.munmap.addr, 
+			      op->u.munmap.len);
+			break;
+		case MPROTECT:
+			protect(fd, op->u.mprotect.addr, op->u.mprotect.len, 
+				op->u.mprotect.r, op->u.mprotect.w, 
+				op->u.mprotect.x);
+			break;
+		default:
+			printk("Unknown op type %d in do_ops\n", op->type);
+			break;
+		}
+	}
+}
 
 static void fix_range(struct mm_struct *mm, unsigned long start_addr,
 		      unsigned long end_addr, int force)
@@ -23,7 +54,9 @@
 	pmd_t *npmd;
 	pte_t *npte;
 	unsigned long addr,  end;
-	int r, w, x, err, fd;
+	int r, w, x, fd;
+	struct host_vm_op ops[16];
+	int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
 
 	if(mm == NULL) return;
 	fd = mm->context.skas.mm_fd;
@@ -34,10 +67,9 @@
 				end = addr + PGDIR_SIZE;
 				if(end > end_addr)
 					end = end_addr;
-				err = unmap(fd, (void *) addr, end - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				op_index = add_munmap(addr, end - addr, ops, 
+						      op_index, last_op, fd,
+						      do_ops);
 				pgd_mkuptodate(*npgd);
 			}
 			addr += PGDIR_SIZE;
@@ -50,10 +82,9 @@
 				end = addr + PUD_SIZE;
 				if(end > end_addr)
 					end = end_addr;
-				err = unmap(fd, (void *) addr, end - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				op_index = add_munmap(addr, end - addr, ops, 
+						      op_index, last_op, fd,
+						      do_ops);
 				pud_mkuptodate(*npud);
 			}
 			addr += PUD_SIZE;
@@ -66,10 +97,9 @@
 				end = addr + PMD_SIZE;
 				if(end > end_addr)
 					end = end_addr;
-				err = unmap(fd, (void *) addr, end - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				op_index = add_munmap(addr, end - addr, ops, 
+						      op_index, last_op, fd,
+						      do_ops);
 				pmd_mkuptodate(*npmd);
 			}
 			addr += PMD_SIZE;
@@ -87,19 +117,25 @@
 			w = 0;
 		}
 		if(force || pte_newpage(*npte)){
-			err = unmap(fd, (void *) addr, PAGE_SIZE);
-			if(err < 0)
-				panic("munmap failed, errno = %d\n", -err);
 			if(pte_present(*npte))
-				map(fd, addr, pte_val(*npte) & PAGE_MASK,
-				    PAGE_SIZE, r, w, x);
+				op_index = add_mmap(addr, 
+						    pte_val(*npte) & PAGE_MASK,
+						    PAGE_SIZE, r, w, x, ops, 
+						    op_index, last_op, fd,
+						    do_ops);
+			else op_index = add_munmap(addr, PAGE_SIZE, ops, 
+						   op_index, last_op, fd, 
+						   do_ops);
 		}
 		else if(pte_newprot(*npte))
-			protect(fd, addr, PAGE_SIZE, r, w, x, 1);
+			op_index = add_mprotect(addr, PAGE_SIZE, r, w, x, ops, 
+						op_index, last_op, fd,
+						do_ops);
 
 		*npte = pte_mkuptodate(*npte);
 		addr += PAGE_SIZE;
 	}
+	do_ops(fd, ops, op_index);
 }
 
 void flush_tlb_kernel_range_skas(unsigned long start, unsigned long end)
@@ -205,6 +241,12 @@
 
 void flush_tlb_mm_skas(struct mm_struct *mm)
 {
+	/* Don't bother flushing if this address space is about to be
+	 * destroyed.
+	 */
+	if(atomic_read(&mm->mm_users) == 0)
+		return;
+
 	flush_tlb_kernel_vm_skas();
 	fix_range(mm, 0, host_task_size, 0);
 }
Index: linux-2.6.11/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tlb.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tlb.c	2005-03-08 22:22:23.000000000 -0500
@@ -9,6 +9,8 @@
 #include "asm/tlbflush.h"
 #include "choose-mode.h"
 #include "mode_kern.h"
+#include "tlb.h"
+#include "mem.h"
 
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 {
@@ -83,6 +85,105 @@
 	return(pte_offset_map(pmd, addr));
 }
 
+int add_mmap(unsigned long virt, unsigned long phys, unsigned long len, 
+	     int r, int w, int x, struct host_vm_op *ops, int index, 
+	     int last_filled, int data,
+	     void (*do_ops)(int, struct host_vm_op *, int))
+{
+	__u64 offset;
+	struct host_vm_op *last;
+	int fd;
+
+	fd = phys_mapping(phys, &offset);
+	if(index != -1){
+		last = &ops[index];
+		if((last->type == MMAP) && 
+		   (last->u.mmap.addr + last->u.mmap.len == virt) && 
+		   (last->u.mmap.r == r) && (last->u.mmap.w == w) &&
+		   (last->u.mmap.x == x) && (last->u.mmap.fd == fd) && 
+		   (last->u.mmap.offset + last->u.mmap.len == offset)){
+			last->u.mmap.len += len;
+			return(index);
+		}
+	}
+
+	if(index == last_filled){
+		(*do_ops)(data, ops, last_filled);
+		index = -1;
+	}
+
+	ops[++index] = ((struct host_vm_op) { .type	= MMAP,
+					      .u = { .mmap = {
+						      .addr	= virt,
+						      .len	= len,
+						      .r	= r,
+						      .w	= w,
+						      .x	= x,
+						      .fd	= fd,
+						      .offset	= offset }
+					      } });
+	return(index);
+}
+
+int add_munmap(unsigned long addr, unsigned long len, struct host_vm_op *ops, 
+	       int index, int last_filled, int data, 
+	       void (*do_ops)(int, struct host_vm_op *, int))
+{
+	struct host_vm_op *last;
+
+	if(index != -1){
+		last = &ops[index];
+		if((last->type == MUNMAP) && 
+		   (last->u.munmap.addr + last->u.mmap.len == addr)){
+			last->u.munmap.len += len;
+			return(index);
+		}
+	}
+
+	if(index == last_filled){
+		(*do_ops)(data, ops, last_filled);
+		index = -1;
+	}
+
+	ops[++index] = ((struct host_vm_op) { .type	= MUNMAP,
+					      .u = { .munmap = {
+						      .addr	= addr,
+						      .len	= len } } });
+	return(index);
+}
+
+int add_mprotect(unsigned long addr, unsigned long len, int r, int w, int x, 
+		 struct host_vm_op *ops, int index, int last_filled, int data,
+		 void (*do_ops)(int, struct host_vm_op *, int))
+{
+	struct host_vm_op *last;
+
+	if(index != -1){
+		last = &ops[index];
+		if((last->type == MPROTECT) &&
+		   (last->u.mprotect.addr + last->u.mprotect.len == addr) && 
+		   (last->u.mprotect.r == r) && (last->u.mprotect.w == w) &&
+		   (last->u.mprotect.x == x)){
+			last->u.mprotect.len += len;
+			return(index);
+		}
+	}
+
+	if(index == last_filled){
+		(*do_ops)(data, ops, last_filled);
+		index = -1;
+	}
+
+	ops[++index] = ((struct host_vm_op) { .type	= MPROTECT,
+					      .u = { .mprotect = {
+						      .addr	= addr,
+						      .len	= len,
+						      .r	= r,
+						      .w	= w,
+						      .x	= x } } });
+	return(index);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.11/arch/um/kernel/tt/tlb.c
===================================================================
--- linux-2.6.11.orig/arch/um/kernel/tt/tlb.c	2005-03-08 20:17:35.000000000 -0500
+++ linux-2.6.11/arch/um/kernel/tt/tlb.c	2005-03-08 22:22:23.000000000 -0500
@@ -15,6 +15,37 @@
 #include "user_util.h"
 #include "mem_user.h"
 #include "os.h"
+#include "tlb.h"
+
+static void do_ops(int unused, struct host_vm_op *ops, int last)
+{
+	struct host_vm_op *op;
+	int i;
+
+	for(i = 0; i <= last; i++){
+		op = &ops[i];
+		switch(op->type){
+		case MMAP:
+                        os_map_memory((void *) op->u.mmap.addr, op->u.mmap.fd, 
+				      op->u.mmap.offset, op->u.mmap.len, 
+				      op->u.mmap.r, op->u.mmap.w, 
+				      op->u.mmap.x);
+			break;
+		case MUNMAP:
+			os_unmap_memory((void *) op->u.munmap.addr, 
+					op->u.munmap.len);
+			break;
+		case MPROTECT:
+			protect_memory(op->u.mprotect.addr, op->u.munmap.len,
+				       op->u.mprotect.r, op->u.mprotect.w,
+				       op->u.mprotect.x, 1);
+			break;
+		default:
+			printk("Unknown op type %d in do_ops\n", op->type);
+			break;
+		}
+	}
+}
 
 static void fix_range(struct mm_struct *mm, unsigned long start_addr, 
 		      unsigned long end_addr, int force)
@@ -24,7 +55,9 @@
 	pmd_t *npmd;
 	pte_t *npte;
 	unsigned long addr, end;
-	int r, w, x, err;
+	int r, w, x;
+	struct host_vm_op ops[16];
+	int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
 
 	if((current->thread.mode.tt.extern_pid != -1) && 
 	   (current->thread.mode.tt.extern_pid != os_getpid()))
@@ -50,11 +83,9 @@
  				end = addr + PGDIR_SIZE;
  				if(end > end_addr)
  					end = end_addr;
-				err = os_unmap_memory((void *) addr,
- 						      end - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				op_index = add_munmap(addr, end - addr, ops, 
+						      op_index, last_op, 0,
+						      do_ops);
 				pgd_mkuptodate(*npgd);
  			}
 			addr += PGDIR_SIZE;
@@ -67,11 +98,9 @@
  				end = addr + PUD_SIZE;
  				if(end > end_addr)
  					end = end_addr;
-				err = os_unmap_memory((void *) addr, 
-						      end - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				op_index = add_munmap(addr, end - addr, ops, 
+						      op_index, last_op, 0,
+						      do_ops);
 				pud_mkuptodate(*npud);
 			}
 			addr += PUD_SIZE;
@@ -84,11 +113,9 @@
  				end = addr + PMD_SIZE;
  				if(end > end_addr)
  					end = end_addr;
-				err = os_unmap_memory((void *) addr,
-						      end - addr);
-				if(err < 0)
-					panic("munmap failed, errno = %d\n",
-					      -err);
+				op_index = add_munmap(addr, end - addr, ops, 
+						      op_index, last_op, 0,
+						      do_ops);
 				pmd_mkuptodate(*npmd);
 			}
 			addr += PMD_SIZE;
@@ -106,19 +133,26 @@
 			w = 0;
 		}
 		if(force || pte_newpage(*npte)){
-			err = os_unmap_memory((void *) addr, PAGE_SIZE);
-			if(err < 0)
-				panic("munmap failed, errno = %d\n", -err);
 			if(pte_present(*npte))
-				map_memory(addr, pte_val(*npte) & PAGE_MASK,
-					   PAGE_SIZE, r, w, x);
+				op_index = add_mmap(addr, 
+						    pte_val(*npte) & PAGE_MASK,
+						    PAGE_SIZE, r, w, x, ops, 
+						    op_index, last_op, 0,
+						    do_ops);
+			else op_index = add_munmap(addr, PAGE_SIZE, ops, 
+						   op_index, last_op, 0, 
+						   do_ops);
 		}
 		else if(pte_newprot(*npte))
-			protect_memory(addr, PAGE_SIZE, r, w, x, 1);
+			op_index = add_mprotect(addr, PAGE_SIZE, r, w, x, ops, 
+						op_index, last_op, 0, 
+						do_ops);
+
 
 		*npte = pte_mkuptodate(*npte);
 		addr += PAGE_SIZE;
 	}
+	do_ops(0, ops, op_index);
 }
 
 atomic_t vmchange_seq = ATOMIC_INIT(1);

