Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751563AbVH2UPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563AbVH2UPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbVH2UOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:14:05 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:36366 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751541AbVH2UOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:14:01 -0400
Message-Id: <200508292007.j7TK7Dcf029943@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/9] UML - TLB operation batching
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Aug 2005 16:07:13 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds VM op batching to skas0.  Rather than having a context switch to
and from the userspace stub for each address space change, we write a number
of operations to the stub data page and invoke a different stub which loops
over them and executes them all in one go.
The operations are stored as [ system call number, arg1, arg2, ... ] tuples.
The set is terminated by a system call number of 0.
Single operations, i.e. page faults, are handled in the old way, since that
is slightly more efficient.
For a kernel build, a minority (~1/4) of the operations are part of a set.
These sets averaged ~100 in length, so for this quarter, the context 
switching overhead is greatly reduced.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12/arch/um/include/tlb.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/tlb.h	2005-07-18 17:24:16.000000000 -0400
+++ linux-2.6.12/arch/um/include/tlb.h	2005-07-18 17:30:18.000000000 -0400
@@ -9,7 +9,7 @@
 #include "um_mmu.h"
 
 struct host_vm_op {
-	enum { MMAP, MUNMAP, MPROTECT } type;
+	enum { NONE, MMAP, MUNMAP, MPROTECT } type;
 	union {
 		struct {
 			unsigned long addr;
@@ -38,24 +38,10 @@
 extern void force_flush_all(void);
 extern void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
                              unsigned long end_addr, int force,
-                             void (*do_ops)(union mm_context *,
-                                            struct host_vm_op *, int));
+			     void *(*do_ops)(union mm_context *, 
+					     struct host_vm_op *, int, int,
+					     void *));
 extern int flush_tlb_kernel_range_common(unsigned long start,
 					 unsigned long end);
 
-extern int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
-		    int r, int w, int x, struct host_vm_op *ops, int index,
-                    int last_filled, union mm_context *mmu,
-                    void (*do_ops)(union mm_context *, struct host_vm_op *,
-                                   int));
-extern int add_munmap(unsigned long addr, unsigned long len,
-		      struct host_vm_op *ops, int index, int last_filled,
-                      union mm_context *mmu,
-                      void (*do_ops)(union mm_context *, struct host_vm_op *,
-                                     int));
-extern int add_mprotect(unsigned long addr, unsigned long len, int r, int w,
-			int x, struct host_vm_op *ops, int index,
-                        int last_filled, union mm_context *mmu,
-                        void (*do_ops)(union mm_context *, struct host_vm_op *,
-                                       int));
 #endif
Index: linux-2.6.12/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/include/skas.h	2005-07-18 17:24:16.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/include/skas.h	2005-07-18 20:05:40.000000000 -0400
@@ -24,11 +24,14 @@
 extern void remove_sigstack(void);
 extern void new_thread_handler(int sig);
 extern void handle_syscall(union uml_pt_regs *regs);
-extern int map(struct mm_id * mm_idp, unsigned long virt, unsigned long len,
-               int r, int w, int x, int phys_fd, unsigned long long offset);
-extern int unmap(struct mm_id * mm_idp, void *addr, unsigned long len);
-extern int protect(struct mm_id * mm_idp, unsigned long addr,
-		   unsigned long len, int r, int w, int x);
+extern void *map(struct mm_id * mm_idp, unsigned long virt, 
+		 unsigned long len, int r, int w, int x, int phys_fd, 
+		 unsigned long long offset, int done, void *data);
+extern void *unmap(struct mm_id * mm_idp, void *addr, 
+		   unsigned long len, int done, void *data);
+extern void *protect(struct mm_id * mm_idp, unsigned long addr, 
+		     unsigned long len, int r, int w, int x, int done, 
+		     void *data);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 extern int new_mm(int from);
 extern int start_userspace(unsigned long stub_stack);
Index: linux-2.6.12/arch/um/kernel/skas/mem_user.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/mem_user.c	2005-07-18 17:24:16.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/mem_user.c	2005-07-18 17:30:18.000000000 -0400
@@ -25,12 +25,14 @@
 #include "sysdep/stub.h"
 #include "skas.h"
 
-extern unsigned long syscall_stub, __syscall_stub_start;
+extern unsigned long syscall_stub, batch_syscall_stub, __syscall_stub_start;
 
 extern void wait_stub_done(int pid, int sig, char * fname);
 
-static long run_syscall_stub(struct mm_id * mm_idp, int syscall,
-                             unsigned long *args)
+int single_count = 0;
+
+static long one_syscall_stub(struct mm_id * mm_idp, int syscall,
+			     unsigned long *args)
 {
         int n, pid = mm_idp->u.pid;
         unsigned long regs[MAX_REG_NR];
@@ -49,18 +51,80 @@
         regs[REGS_SYSCALL_ARG6] = args[5];
         n = ptrace_setregs(pid, regs);
         if(n < 0){
-                printk("run_syscall_stub : PTRACE_SETREGS failed, "
+		printk("one_syscall_stub : PTRACE_SETREGS failed, "
+		       "errno = %d\n", n);
+		return(n);
+	}
+
+	wait_stub_done(pid, 0, "one_syscall_stub");
+
+	return(*((unsigned long *) mm_idp->stack));
+}
+
+int multi_count = 0;
+int multi_op_count = 0;
+
+static long many_syscall_stub(struct mm_id * mm_idp, int syscall,
+			      unsigned long *args, int done, void **addr_out)
+{
+        unsigned long regs[MAX_REG_NR], *stack;
+        int n, pid = mm_idp->u.pid;
+
+        stack = *addr_out;
+        if(stack == NULL)
+                stack = (unsigned long *) current_stub_stack();
+        *stack++ = syscall;
+        *stack++ = args[0];
+        *stack++ = args[1];
+        *stack++ = args[2];
+        *stack++ = args[3];
+        *stack++ = args[4];
+        *stack++ = args[5];
+        *stack = 0;
+        multi_op_count++;
+
+        if(!done && ((((unsigned long) stack) & ~PAGE_MASK) < 
+                     PAGE_SIZE - 8 * sizeof(long))){
+                *addr_out = stack;
+                return 0;
+        }
+
+        multi_count++;
+        get_safe_registers(regs);
+        regs[REGS_IP_INDEX] = UML_CONFIG_STUB_CODE +
+                ((unsigned long) &batch_syscall_stub - 
+                 (unsigned long) &__syscall_stub_start);
+        regs[REGS_SP_INDEX] = UML_CONFIG_STUB_DATA;
+
+        n = ptrace_setregs(pid, regs);
+        if(n < 0){
+                printk("many_syscall_stub : PTRACE_SETREGS failed, "
                        "errno = %d\n", n);
                 return(n);
         }
 
-        wait_stub_done(pid, 0, "run_syscall_stub");
+        wait_stub_done(pid, 0, "many_syscall_stub");
+        stack = (unsigned long *) mm_idp->stack;
+
+        *addr_out = stack;
+        return(*stack);
+}
+  
+static long run_syscall_stub(struct mm_id * mm_idp, int syscall,
+                             unsigned long *args, void **addr, int done)
+{
+        long res;
 
-        return(*((unsigned long *) mm_idp->stack));
+        if((*addr == NULL) && done)
+                res = one_syscall_stub(mm_idp, syscall, args);
+        else res = many_syscall_stub(mm_idp, syscall, args, done, addr);
+
+        return res;
 }
 
-int map(struct mm_id *mm_idp, unsigned long virt, unsigned long len,
-        int r, int w, int x, int phys_fd, unsigned long long offset)
+void *map(struct mm_id * mm_idp, unsigned long virt, unsigned long len,
+          int r, int w, int x, int phys_fd, unsigned long long offset, 
+          int done, void *data)
 {
         int prot, n;
 
@@ -70,6 +134,7 @@
         if(proc_mm){
                 struct proc_mm_op map;
                 int fd = mm_idp->u.mm_fd;
+
                 map = ((struct proc_mm_op) { .op	= MM_MMAP,
                                              .u		=
                                              { .mmap	=
@@ -91,21 +156,24 @@
                                          MAP_SHARED | MAP_FIXED, phys_fd,
                                          MMAP_OFFSET(offset) };
 
-                res = run_syscall_stub(mm_idp, STUB_MMAP_NR, args);
+		res = run_syscall_stub(mm_idp, STUB_MMAP_NR, args,
+				       &data, done);
                 if((void *) res == MAP_FAILED)
                         printk("mmap stub failed, errno = %d\n", res);
         }
 
-        return 0;
+	return data;
 }
 
-int unmap(struct mm_id *mm_idp, void *addr, unsigned long len)
+void *unmap(struct mm_id * mm_idp, void *addr, unsigned long len, int done,
+            void *data)
 {
         int n;
 
         if(proc_mm){
                 struct proc_mm_op unmap;
                 int fd = mm_idp->u.mm_fd;
+
                 unmap = ((struct proc_mm_op) { .op	= MM_MUNMAP,
                                                .u	=
                                                { .munmap	=
@@ -113,28 +181,25 @@
                                                    (unsigned long) addr,
                                                    .len		= len } } } );
                 n = os_write_file(fd, &unmap, sizeof(unmap));
-                if(n != sizeof(unmap)) {
-                        if(n < 0)
-                                return(n);
-                        else if(n > 0)
-                                return(-EIO);
-                }
+		if(n != sizeof(unmap))
+		  printk("unmap - proc_mm write returned %d\n", n);
         }
         else {
                 int res;
                 unsigned long args[] = { (unsigned long) addr, len, 0, 0, 0,
                                          0 };
 
-                res = run_syscall_stub(mm_idp, __NR_munmap, args);
+		res = run_syscall_stub(mm_idp, __NR_munmap, args,
+				       &data, done);
                 if(res < 0)
                         printk("munmap stub failed, errno = %d\n", res);
         }
 
-        return(0);
+        return data;
 }
 
-int protect(struct mm_id *mm_idp, unsigned long addr, unsigned long len,
-	    int r, int w, int x)
+void *protect(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
+              int r, int w, int x, int done, void *data)
 {
         struct proc_mm_op protect;
         int prot, n;
@@ -160,12 +225,13 @@
                 int res;
                 unsigned long args[] = { addr, len, prot, 0, 0, 0 };
 
-                res = run_syscall_stub(mm_idp, __NR_mprotect, args);
+                res = run_syscall_stub(mm_idp, __NR_mprotect, args,
+                                       &data, done);
                 if(res < 0)
                         panic("mprotect stub failed, errno = %d\n", res);
         }
 
-        return(0);
+        return data;
 }
 
 void before_mem_skas(unsigned long unused)
Index: linux-2.6.12/arch/um/kernel/skas/tlb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/tlb.c	2005-07-18 17:24:16.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/tlb.c	2005-07-18 17:30:18.000000000 -0400
@@ -18,7 +18,8 @@
 #include "os.h"
 #include "tlb.h"
 
-static void do_ops(union mm_context *mmu, struct host_vm_op *ops, int last)
+static void *do_ops(union mm_context *mmu, struct host_vm_op *ops, int last,
+		    int finished, void *flush)
 {
 	struct host_vm_op *op;
 	int i;
@@ -27,24 +28,28 @@
 		op = &ops[i];
 		switch(op->type){
 		case MMAP:
-                        map(&mmu->skas.id, op->u.mmap.addr, op->u.mmap.len,
-			    op->u.mmap.r, op->u.mmap.w, op->u.mmap.x,
-			    op->u.mmap.fd, op->u.mmap.offset);
+			flush = map(&mmu->skas.id, op->u.mmap.addr, 
+				    op->u.mmap.len, op->u.mmap.r, op->u.mmap.w,
+				    op->u.mmap.x, op->u.mmap.fd,
+				    op->u.mmap.offset, finished, flush);
 			break;
 		case MUNMAP:
-                        unmap(&mmu->skas.id, (void *) op->u.munmap.addr,
-			      op->u.munmap.len);
+			flush = unmap(&mmu->skas.id, (void *) op->u.munmap.addr,
+				      op->u.munmap.len, finished, flush);
 			break;
 		case MPROTECT:
-                        protect(&mmu->skas.id, op->u.mprotect.addr,
-                                op->u.mprotect.len, op->u.mprotect.r,
-                                op->u.mprotect.w, op->u.mprotect.x);
+			flush = protect(&mmu->skas.id, op->u.mprotect.addr,
+					op->u.mprotect.len, op->u.mprotect.r, 
+					op->u.mprotect.w, op->u.mprotect.x, 
+					finished, flush);
 			break;
 		default:
 			printk("Unknown op type %d in do_ops\n", op->type);
 			break;
 		}
 	}
+
+	return flush;
 }
 
 extern int proc_mm;
Index: linux-2.6.12/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tlb.c	2005-07-18 17:24:17.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tlb.c	2005-07-18 20:05:57.000000000 -0400
@@ -15,12 +15,116 @@
 #include "mem_user.h"
 #include "os.h"
 
+static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
+		    int r, int w, int x, struct host_vm_op *ops, int index,
+		    int last_filled, union mm_context *mmu, void **flush,
+		    void *(*do_ops)(union mm_context *, struct host_vm_op *, 
+				    int, int, void *))
+{
+        __u64 offset;
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
+			return index;
+		}
+	}
+
+	if(index == last_filled){
+		*flush = (*do_ops)(mmu, ops, last_filled, 0, *flush);
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
+	return index;
+}
+
+static int add_munmap(unsigned long addr, unsigned long len, 
+		      struct host_vm_op *ops, int index, int last_filled, 
+		      union mm_context *mmu, void **flush,
+		      void *(*do_ops)(union mm_context *, struct host_vm_op *, 
+				      int, int, void *))
+{
+	struct host_vm_op *last;
+
+	if(index != -1){
+		last = &ops[index];
+		if((last->type == MUNMAP) &&
+		   (last->u.munmap.addr + last->u.mmap.len == addr)){
+			last->u.munmap.len += len;
+			return index;
+		}
+	}
+
+	if(index == last_filled){
+		*flush = (*do_ops)(mmu, ops, last_filled, 0, *flush);
+		index = -1;
+	}
+
+	ops[++index] = ((struct host_vm_op) { .type	= MUNMAP,
+					      .u = { .munmap = {
+						      .addr	= addr,
+						      .len	= len } } });
+	return index;
+}
+
+static int add_mprotect(unsigned long addr, unsigned long len, int r, int w, 
+			int x, struct host_vm_op *ops, int index, 
+			int last_filled, union mm_context *mmu, void **flush,
+			void *(*do_ops)(union mm_context *, 
+				       struct host_vm_op *, int, int, void *))
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
+			return index;
+		}
+	}
+
+	if(index == last_filled){
+		*flush = (*do_ops)(mmu, ops, last_filled, 0, *flush);
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
+	return index;
+}
+
 #define ADD_ROUND(n, inc) (((n) + (inc)) & ~((inc) - 1))
 
 void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
                       unsigned long end_addr, int force,
-                      void (*do_ops)(union mm_context *, struct host_vm_op *,
-                                     int))
+		      void *(*do_ops)(union mm_context *, struct host_vm_op *, 
+				      int, int, void *))
 {
         pgd_t *npgd;
         pud_t *npud;
@@ -29,11 +133,13 @@
         union mm_context *mmu = &mm->context;
         unsigned long addr, end;
         int r, w, x;
-        struct host_vm_op ops[16];
+        struct host_vm_op ops[1];
+        void *flush = NULL;
         int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
 
         if(mm == NULL) return;
 
+        ops[0].type = NONE;
         for(addr = start_addr; addr < end_addr;){
                 npgd = pgd_offset(mm, addr);
                 if(!pgd_present(*npgd)){
@@ -43,7 +149,7 @@
                         if(force || pgd_newpage(*npgd)){
                                 op_index = add_munmap(addr, end - addr, ops,
                                                       op_index, last_op, mmu,
-                                                      do_ops);
+                                                      &flush, do_ops);
                                 pgd_mkuptodate(*npgd);
                         }
                         addr = end;
@@ -58,7 +164,7 @@
                         if(force || pud_newpage(*npud)){
                                 op_index = add_munmap(addr, end - addr, ops,
                                                       op_index, last_op, mmu,
-                                                      do_ops);
+                                                      &flush, do_ops);
                                 pud_mkuptodate(*npud);
                         }
                         addr = end;
@@ -73,7 +179,7 @@
                         if(force || pmd_newpage(*npmd)){
                                 op_index = add_munmap(addr, end - addr, ops,
                                                       op_index, last_op, mmu,
-                                                      do_ops);
+                                                      &flush, do_ops);
                                 pmd_mkuptodate(*npmd);
                         }
                         addr = end;
@@ -96,20 +202,20 @@
                                                     pte_val(*npte) & PAGE_MASK,
                                                     PAGE_SIZE, r, w, x, ops,
                                                     op_index, last_op, mmu,
-                                                    do_ops);
+                                                    &flush, do_ops);
                         else op_index = add_munmap(addr, PAGE_SIZE, ops,
                                                    op_index, last_op, mmu,
-                                                   do_ops);
+                                                   &flush, do_ops);
                 }
                 else if(pte_newprot(*npte))
                         op_index = add_mprotect(addr, PAGE_SIZE, r, w, x, ops,
                                                 op_index, last_op, mmu,
-                                                do_ops);
+                                                &flush, do_ops);
 
                 *npte = pte_mkuptodate(*npte);
                 addr += PAGE_SIZE;
         }
-        (*do_ops)(mmu, ops, op_index);
+	flush = (*do_ops)(mmu, ops, op_index, 1, flush);
 }
 
 int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
@@ -226,106 +332,6 @@
         return(pte_offset_map(pmd, addr));
 }
 
-int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
-             int r, int w, int x, struct host_vm_op *ops, int index,
-             int last_filled, union mm_context *mmu,
-             void (*do_ops)(union mm_context *, struct host_vm_op *, int))
-{
-        __u64 offset;
-	struct host_vm_op *last;
-	int fd;
-
-	fd = phys_mapping(phys, &offset);
-	if(index != -1){
-		last = &ops[index];
-		if((last->type == MMAP) &&
-		   (last->u.mmap.addr + last->u.mmap.len == virt) &&
-		   (last->u.mmap.r == r) && (last->u.mmap.w == w) &&
-		   (last->u.mmap.x == x) && (last->u.mmap.fd == fd) &&
-		   (last->u.mmap.offset + last->u.mmap.len == offset)){
-			last->u.mmap.len += len;
-			return(index);
-		}
-	}
-
-	if(index == last_filled){
-		(*do_ops)(mmu, ops, last_filled);
-		index = -1;
-	}
-
-	ops[++index] = ((struct host_vm_op) { .type	= MMAP,
-					      .u = { .mmap = {
-						      .addr	= virt,
-						      .len	= len,
-						      .r	= r,
-						      .w	= w,
-						      .x	= x,
-						      .fd	= fd,
-						      .offset	= offset }
-					      } });
-	return(index);
-}
-
-int add_munmap(unsigned long addr, unsigned long len, struct host_vm_op *ops,
-	       int index, int last_filled, union mm_context *mmu,
-	       void (*do_ops)(union mm_context *, struct host_vm_op *, int))
-{
-	struct host_vm_op *last;
-
-	if(index != -1){
-		last = &ops[index];
-		if((last->type == MUNMAP) &&
-		   (last->u.munmap.addr + last->u.mmap.len == addr)){
-			last->u.munmap.len += len;
-			return(index);
-		}
-	}
-
-	if(index == last_filled){
-		(*do_ops)(mmu, ops, last_filled);
-		index = -1;
-	}
-
-	ops[++index] = ((struct host_vm_op) { .type	= MUNMAP,
-					      .u = { .munmap = {
-						      .addr	= addr,
-						      .len	= len } } });
-	return(index);
-}
-
-int add_mprotect(unsigned long addr, unsigned long len, int r, int w, int x,
-                 struct host_vm_op *ops, int index, int last_filled,
-                 union mm_context *mmu,
-                 void (*do_ops)(union mm_context *, struct host_vm_op *, int))
-{
-	struct host_vm_op *last;
-
-	if(index != -1){
-		last = &ops[index];
-		if((last->type == MPROTECT) &&
-		   (last->u.mprotect.addr + last->u.mprotect.len == addr) &&
-		   (last->u.mprotect.r == r) && (last->u.mprotect.w == w) &&
-		   (last->u.mprotect.x == x)){
-			last->u.mprotect.len += len;
-			return(index);
-		}
-	}
-
-	if(index == last_filled){
-		(*do_ops)(mmu, ops, last_filled);
-		index = -1;
-	}
-
-	ops[++index] = ((struct host_vm_op) { .type	= MPROTECT,
-					      .u = { .mprotect = {
-						      .addr	= addr,
-						      .len	= len,
-						      .r	= r,
-						      .w	= w,
-						      .x	= x } } });
-	return(index);
-}
-
 void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 {
         address &= PAGE_MASK;
Index: linux-2.6.12/arch/um/kernel/tt/tlb.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/tt/tlb.c	2005-07-18 17:24:16.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/tt/tlb.c	2005-07-18 17:30:18.000000000 -0400
@@ -17,7 +17,8 @@
 #include "os.h"
 #include "tlb.h"
 
-static void do_ops(union mm_context *mmu, struct host_vm_op *ops, int last)
+static void *do_ops(union mm_context *mmu, struct host_vm_op *ops, int last,
+		    int finished, void *flush)
 {
 	struct host_vm_op *op;
 	int i;
@@ -45,6 +46,8 @@
 			break;
 		}
 	}
+
+	return NULL;
 }
 
 static void fix_range(struct mm_struct *mm, unsigned long start_addr, 
Index: linux-2.6.12/arch/um/sys-i386/stub.S
===================================================================
--- linux-2.6.12.orig/arch/um/sys-i386/stub.S	2005-07-18 17:24:16.000000000 -0400
+++ linux-2.6.12/arch/um/sys-i386/stub.S	2005-07-18 17:30:18.000000000 -0400
@@ -6,3 +6,20 @@
 	int 	$0x80
 	mov	%eax, UML_CONFIG_STUB_DATA
 	int3
+
+	.globl batch_syscall_stub
+batch_syscall_stub:
+	mov	$UML_CONFIG_STUB_DATA, %esp
+again:	pop	%eax
+	cmpl	$0, %eax
+	jz	done
+	pop	%ebx
+	pop	%ecx
+	pop	%edx
+	pop	%esi
+ 	pop	%edi
+	pop	%ebp
+	int	$0x80
+	mov	%eax, UML_CONFIG_STUB_DATA
+	jmp	again
+done:	int3
Index: linux-2.6.12/arch/um/sys-x86_64/stub.S
===================================================================
--- linux-2.6.12.orig/arch/um/sys-x86_64/stub.S	2005-07-18 17:24:16.000000000 -0400
+++ linux-2.6.12/arch/um/sys-x86_64/stub.S	2005-07-18 17:30:18.000000000 -0400
@@ -13,3 +13,24 @@
 	or	%rcx, %rbx
 	movq	%rax, (%rbx)
 	int3
+
+	.globl batch_syscall_stub
+batch_syscall_stub:
+	movq	$(UML_CONFIG_STUB_DATA >> 32), %rbx
+	salq	$32, %rbx
+	movq	$(UML_CONFIG_STUB_DATA & 0xffffffff), %rcx
+	or	%rcx, %rbx
+	movq	%rbx, %rsp
+again:	pop	%rax
+	cmpq	$0, %rax
+jz	done
+	pop	%rdi
+	pop	%rsi
+	pop	%rdx
+	pop	%r10
+ 	pop	%r8
+	pop	%r9
+	syscall
+	mov	%rax, (%rbx)
+	jmp	again
+done:	int3

