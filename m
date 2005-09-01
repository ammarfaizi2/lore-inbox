Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030482AbVIAW3G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030482AbVIAW3G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbVIAW3G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:29:06 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:32784 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030303AbVIAW3B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:29:01 -0400
Message-Id: <200509012217.j81MHHj6011562@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 9/12] UML - skas0 stubs now check system call return values
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:17:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Change syscall-stub's data to include a "expected retval".
Stub now checks syscalls retval and aborts execution of
syscall list, if retval != expected retval.
run_syscall_stub prints the data of the failed syscall,
using the data pointer and retval written by the stub
to the beginning of the stack.
one_syscall_stub is removed, to simplify code, because
only some instructions are saved by one_syscall_stub, no
host-syscall.
Using the stub with additional data (modify_ldt via stub)
is prepared also.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/include/tlb.h
===================================================================
--- test.orig/arch/um/include/tlb.h	2005-09-01 16:32:51.000000000 -0400
+++ test/arch/um/include/tlb.h	2005-09-01 16:33:07.000000000 -0400
@@ -38,9 +38,9 @@
 extern void force_flush_all(void);
 extern void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
                              unsigned long end_addr, int force,
-			     void *(*do_ops)(union mm_context *,
-					     struct host_vm_op *, int, int,
-					     void *));
+			     int (*do_ops)(union mm_context *, 
+					   struct host_vm_op *, int, int,
+					   void **));
 extern int flush_tlb_kernel_range_common(unsigned long start,
 					 unsigned long end);
 
Index: test/arch/um/kernel/skas/include/skas.h
===================================================================
--- test.orig/arch/um/kernel/skas/include/skas.h	2005-09-01 16:33:07.000000000 -0400
+++ test/arch/um/kernel/skas/include/skas.h	2005-09-01 16:33:07.000000000 -0400
@@ -24,14 +24,14 @@
 extern void remove_sigstack(void);
 extern void new_thread_handler(int sig);
 extern void handle_syscall(union uml_pt_regs *regs);
-extern void *map(struct mm_id * mm_idp, unsigned long virt,
-		 unsigned long len, int r, int w, int x, int phys_fd,
-		 unsigned long long offset, int done, void *data);
-extern void *unmap(struct mm_id * mm_idp, void *addr,
-		   unsigned long len, int done, void *data);
-extern void *protect(struct mm_id * mm_idp, unsigned long addr,
-		     unsigned long len, int r, int w, int x, int done,
-		     void *data);
+extern int map(struct mm_id * mm_idp, unsigned long virt,
+	       unsigned long len, int r, int w, int x, int phys_fd, 
+	       unsigned long long offset, int done, void **data);
+extern int unmap(struct mm_id * mm_idp, void *addr, unsigned long len,
+		 int done, void **data);
+extern int protect(struct mm_id * mm_idp, unsigned long addr,
+		   unsigned long len, int r, int w, int x, int done, 
+		   void **data);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 extern int new_mm(int from, unsigned long stack);
 extern int start_userspace(unsigned long stub_stack);
@@ -39,16 +39,11 @@
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
+extern long run_syscall_stub(struct mm_id * mm_idp,
+                             int syscall, unsigned long *args, long expected,
+                             void **addr, int done);
+extern long syscall_stub_data(struct mm_id * mm_idp,
+                              unsigned long *data, int data_count,
+                              void **addr, void **stub_addr);
 
 #endif
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
Index: test/arch/um/kernel/skas/mem_user.c
===================================================================
--- test.orig/arch/um/kernel/skas/mem_user.c	2005-09-01 16:32:51.000000000 -0400
+++ test/arch/um/kernel/skas/mem_user.c	2005-09-01 16:43:18.000000000 -0400
@@ -5,13 +5,14 @@
 
 #include <signal.h>
 #include <errno.h>
+#include <string.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
 #include <asm/page.h>
 #include <asm/unistd.h>
 #include "mem_user.h"
 #include "mem.h"
-#include "mm_id.h"
+#include "skas.h"
 #include "user.h"
 #include "os.h"
 #include "proc_mm.h"
@@ -23,56 +24,99 @@
 #include "uml-config.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/stub.h"
-#include "skas.h"
 
-extern unsigned long syscall_stub, batch_syscall_stub, __syscall_stub_start;
+extern unsigned long batch_syscall_stub, __syscall_stub_start;
 
 extern void wait_stub_done(int pid, int sig, char * fname);
 
-int single_count = 0;
+static inline unsigned long *check_init_stack(struct mm_id * mm_idp,
+					      unsigned long *stack)
+{
+	if(stack == NULL){
+		stack = (unsigned long *) mm_idp->stack + 2;
+		*stack = 0;
+	}
+	return stack;
+}
+
+extern int proc_mm;
 
-static long one_syscall_stub(struct mm_id * mm_idp, int syscall,
-			     unsigned long *args)
+int single_count = 0;
+int multi_count = 0;
+int multi_op_count = 0;
+  
+static long do_syscall_stub(struct mm_id *mm_idp, void **addr)
 {
+	unsigned long regs[MAX_REG_NR];
+	unsigned long *data;
+	unsigned long *syscall;
+	long ret, offset;
         int n, pid = mm_idp->u.pid;
-        unsigned long regs[MAX_REG_NR];
 
+	if(proc_mm)
+#warning Need to look up userspace_pid by cpu
+		pid = userspace_pid[0];
+
+	multi_count++;
+  
         get_safe_registers(regs);
         regs[REGS_IP_INDEX] = UML_CONFIG_STUB_CODE +
-                ((unsigned long) &syscall_stub -
+		((unsigned long) &batch_syscall_stub - 
                  (unsigned long) &__syscall_stub_start);
-        /* XXX Don't have a define for starting a syscall */
-        regs[REGS_SYSCALL_NR] = syscall;
-        regs[REGS_SYSCALL_ARG1] = args[0];
-        regs[REGS_SYSCALL_ARG2] = args[1];
-        regs[REGS_SYSCALL_ARG3] = args[2];
-        regs[REGS_SYSCALL_ARG4] = args[3];
-        regs[REGS_SYSCALL_ARG5] = args[4];
-        regs[REGS_SYSCALL_ARG6] = args[5];
-        n = ptrace_setregs(pid, regs);
-        if(n < 0){
-		printk("one_syscall_stub : PTRACE_SETREGS failed, "
-		       "errno = %d\n", n);
-		return(n);
+	n = ptrace_setregs(pid, regs);
+	if(n < 0)
+		panic("do_syscall_stub : PTRACE_SETREGS failed, errno = %d\n",
+		      n);
+
+	wait_stub_done(pid, 0, "do_syscall_stub");
+
+	/* When the stub stops, we find the following values on the
+	 * beginning of the stack:
+	 * (long )return_value
+	 * (long )offset to failed sycall-data (0, if no error)
+	 */
+	ret = *((unsigned long *) mm_idp->stack);
+	offset = *((unsigned long *) mm_idp->stack + 1);
+	if (offset) {
+		data = (unsigned long *)(mm_idp->stack +
+					 offset - UML_CONFIG_STUB_DATA);
+		syscall = (unsigned long *)((unsigned long)data + data[0]);
+		printk("do_syscall_stub: syscall %ld failed, return value = "
+		       "0x%lx, expected return value = 0x%lx\n",
+		       syscall[0], ret, syscall[7]);
+		printk("    syscall parameters: "
+		       "0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
+		       syscall[1], syscall[2], syscall[3],
+		       syscall[4], syscall[5], syscall[6]);
+		for(n = 1; n < data[0]/sizeof(long); n++) {
+			if(n == 1)
+				printk("    additional syscall data:");
+			if(n % 4 == 1)
+				printk("\n      ");
+			printk("  0x%lx", data[n]);
+		}
+		if(n > 1)
+			printk("\n");
 	}
+	else ret = 0;
 
-	wait_stub_done(pid, 0, "one_syscall_stub");
-
-	return(*((unsigned long *) mm_idp->stack));
+	*addr = check_init_stack(mm_idp, NULL);
+ 
+	return ret;
 }
 
-int multi_count = 0;
-int multi_op_count = 0;
-
-static long many_syscall_stub(struct mm_id * mm_idp, int syscall,
-			      unsigned long *args, int done, void **addr_out)
+long run_syscall_stub(struct mm_id * mm_idp, int syscall, 
+		      unsigned long *args, long expected, void **addr, 
+ 		      int done)
 {
-        unsigned long regs[MAX_REG_NR], *stack;
-        int n, pid = mm_idp->u.pid;
+ 	unsigned long *stack = check_init_stack(mm_idp, *addr);
+
+	if(done && *addr == NULL)
+		single_count++;
+
+ 	*stack += sizeof(long);
+	stack += *stack / sizeof(long);
 
-        stack = *addr_out;
-        if(stack == NULL)
-                stack = (unsigned long *) current_stub_stack();
         *stack++ = syscall;
         *stack++ = args[0];
         *stack++ = args[1];
@@ -80,53 +124,55 @@
         *stack++ = args[3];
         *stack++ = args[4];
         *stack++ = args[5];
+	*stack++ = expected;
         *stack = 0;
         multi_op_count++;
 
         if(!done && ((((unsigned long) stack) & ~PAGE_MASK) <
-                     PAGE_SIZE - 8 * sizeof(long))){
-                *addr_out = stack;
+		     PAGE_SIZE - 10 * sizeof(long))){
+		*addr = stack;
                 return 0;
         }
 
-        multi_count++;
-        get_safe_registers(regs);
-        regs[REGS_IP_INDEX] = UML_CONFIG_STUB_CODE +
-                ((unsigned long) &batch_syscall_stub -
-                 (unsigned long) &__syscall_stub_start);
-        regs[REGS_SP_INDEX] = UML_CONFIG_STUB_DATA;
+	return do_syscall_stub(mm_idp, addr);
+}
+ 
+long syscall_stub_data(struct mm_id * mm_idp,
+		       unsigned long *data, int data_count,
+		       void **addr, void **stub_addr)
+{
+	unsigned long *stack;
+	int ret = 0;
 
-        n = ptrace_setregs(pid, regs);
-        if(n < 0){
-                printk("many_syscall_stub : PTRACE_SETREGS failed, "
-                       "errno = %d\n", n);
-                return(n);
-        }
+	/* If *addr still is uninitialized, it *must* contain NULL.
+	 * Thus in this case do_syscall_stub correctly won't be called.
+	 */
+	if((((unsigned long) *addr) & ~PAGE_MASK) >=
+	   PAGE_SIZE - (10 + data_count) * sizeof(long)) {
+		ret = do_syscall_stub(mm_idp, addr);
+ 		/* in case of error, don't overwrite data on stack */
+		if(ret)
+			return ret;
+	}
 
-        wait_stub_done(pid, 0, "many_syscall_stub");
-        stack = (unsigned long *) mm_idp->stack;
+	stack = check_init_stack(mm_idp, *addr);
+	*addr = stack;
 
-        *addr_out = stack;
-        return(*stack);
-}
+	*stack = data_count * sizeof(long);
 
-static long run_syscall_stub(struct mm_id * mm_idp, int syscall,
-                             unsigned long *args, void **addr, int done)
-{
-        long res;
+	memcpy(stack + 1, data, data_count * sizeof(long));
 
-        if((*addr == NULL) && done)
-                res = one_syscall_stub(mm_idp, syscall, args);
-        else res = many_syscall_stub(mm_idp, syscall, args, done, addr);
+	*stub_addr = (void *)(((unsigned long)(stack + 1) & ~PAGE_MASK) +
+			      UML_CONFIG_STUB_DATA);
 
-        return res;
+	return 0;
 }
-
-void *map(struct mm_id * mm_idp, unsigned long virt, unsigned long len,
-          int r, int w, int x, int phys_fd, unsigned long long offset,
-          int done, void *data)
+ 
+int map(struct mm_id * mm_idp, unsigned long virt, unsigned long len,
+	int r, int w, int x, int phys_fd, unsigned long long offset, 
+	int done, void **data)
 {
-        int prot, n;
+        int prot, ret;
 
         prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) |
                 (x ? PROT_EXEC : 0);
@@ -146,29 +192,27 @@
                                                  .fd	= phys_fd,
                                                  .offset= offset
                                                } } } );
-                n = os_write_file(fd, &map, sizeof(map));
-                if(n != sizeof(map))
-                        printk("map : /proc/mm map failed, err = %d\n", -n);
+		ret = os_write_file(fd, &map, sizeof(map));
+		if(ret != sizeof(map)) 
+			printk("map : /proc/mm map failed, err = %d\n", -ret);
+		else ret = 0;
         }
         else {
-                long res;
                 unsigned long args[] = { virt, len, prot,
                                          MAP_SHARED | MAP_FIXED, phys_fd,
                                          MMAP_OFFSET(offset) };
 
-		res = run_syscall_stub(mm_idp, STUB_MMAP_NR, args,
-				       &data, done);
-                if((void *) res == MAP_FAILED)
-                        printk("mmap stub failed, errno = %d\n", res);
+		ret = run_syscall_stub(mm_idp, STUB_MMAP_NR, args, virt,
+				       data, done);
         }
 
-	return data;
+	return ret;
 }
 
-void *unmap(struct mm_id * mm_idp, void *addr, unsigned long len, int done,
-            void *data)
+int unmap(struct mm_id * mm_idp, void *addr, unsigned long len, int done,
+	  void **data)
 {
-        int n;
+        int ret;
 
         if(proc_mm){
                 struct proc_mm_op unmap;
@@ -180,29 +224,29 @@
                                                  { .addr	=
                                                    (unsigned long) addr,
                                                    .len		= len } } } );
-                n = os_write_file(fd, &unmap, sizeof(unmap));
-		if(n != sizeof(unmap))
-		  printk("unmap - proc_mm write returned %d\n", n);
+		ret = os_write_file(fd, &unmap, sizeof(unmap));
+		if(ret != sizeof(unmap))
+			printk("unmap - proc_mm write returned %d\n", ret);
+		else ret = 0;
         }
         else {
-                int res;
                 unsigned long args[] = { (unsigned long) addr, len, 0, 0, 0,
                                          0 };
 
-		res = run_syscall_stub(mm_idp, __NR_munmap, args,
-				       &data, done);
-                if(res < 0)
-                        printk("munmap stub failed, errno = %d\n", res);
+		ret = run_syscall_stub(mm_idp, __NR_munmap, args, 0,
+				       data, done);
+                if(ret < 0)
+                        printk("munmap stub failed, errno = %d\n", ret);
         }
 
-        return data;
+        return ret;
 }
 
-void *protect(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
-              int r, int w, int x, int done, void *data)
+int protect(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
+	    int r, int w, int x, int done, void **data)
 {
         struct proc_mm_op protect;
-        int prot, n;
+        int prot, ret;
 
         prot = (r ? PROT_READ : 0) | (w ? PROT_WRITE : 0) |
                 (x ? PROT_EXEC : 0);
@@ -217,21 +261,19 @@
                                                      .len	= len,
                                                      .prot	= prot } } } );
 
-                n = os_write_file(fd, &protect, sizeof(protect));
-                if(n != sizeof(protect))
-                        panic("protect failed, err = %d", -n);
+                ret = os_write_file(fd, &protect, sizeof(protect));
+                if(ret != sizeof(protect))
+                        printk("protect failed, err = %d", -ret);
+                else ret = 0;
         }
         else {
-                int res;
                 unsigned long args[] = { addr, len, prot, 0, 0, 0 };
 
-                res = run_syscall_stub(mm_idp, __NR_mprotect, args,
-                                       &data, done);
-                if(res < 0)
-                        panic("mprotect stub failed, errno = %d\n", res);
+                ret = run_syscall_stub(mm_idp, __NR_mprotect, args, 0,
+                                       data, done);
         }
 
-        return data;
+        return ret;
 }
 
 void before_mem_skas(unsigned long unused)
Index: test/arch/um/kernel/skas/tlb.c
===================================================================
--- test.orig/arch/um/kernel/skas/tlb.c	2005-09-01 16:32:51.000000000 -0400
+++ test/arch/um/kernel/skas/tlb.c	2005-09-01 16:33:07.000000000 -0400
@@ -18,30 +18,31 @@
 #include "os.h"
 #include "tlb.h"
 
-static void *do_ops(union mm_context *mmu, struct host_vm_op *ops, int last,
-		    int finished, void *flush)
+static int do_ops(union mm_context *mmu, struct host_vm_op *ops, int last,
+		  int finished, void **flush)
 {
 	struct host_vm_op *op;
-	int i;
+        int i, ret = 0;
 
-	for(i = 0; i <= last; i++){
+        for(i = 0; i <= last && !ret; i++){
 		op = &ops[i];
 		switch(op->type){
 		case MMAP:
-			flush = map(&mmu->skas.id, op->u.mmap.addr,
-				    op->u.mmap.len, op->u.mmap.r, op->u.mmap.w,
-				    op->u.mmap.x, op->u.mmap.fd,
-				    op->u.mmap.offset, finished, flush);
+			ret = map(&mmu->skas.id, op->u.mmap.addr, 
+				  op->u.mmap.len, op->u.mmap.r, op->u.mmap.w,
+				  op->u.mmap.x, op->u.mmap.fd,
+				  op->u.mmap.offset, finished, flush);
 			break;
 		case MUNMAP:
-			flush = unmap(&mmu->skas.id, (void *) op->u.munmap.addr,
-				      op->u.munmap.len, finished, flush);
+			ret = unmap(&mmu->skas.id, 
+				    (void *) op->u.munmap.addr,
+				    op->u.munmap.len, finished, flush);
 			break;
 		case MPROTECT:
-			flush = protect(&mmu->skas.id, op->u.mprotect.addr,
-					op->u.mprotect.len, op->u.mprotect.r,
-					op->u.mprotect.w, op->u.mprotect.x,
-					finished, flush);
+			ret = protect(&mmu->skas.id, op->u.mprotect.addr,
+				      op->u.mprotect.len, op->u.mprotect.r, 
+				      op->u.mprotect.w, op->u.mprotect.x, 
+				      finished, flush);
 			break;
 		default:
 			printk("Unknown op type %d in do_ops\n", op->type);
@@ -49,7 +50,7 @@
 		}
 	}
 
-	return flush;
+	return ret;
 }
 
 extern int proc_mm;
Index: test/arch/um/kernel/tlb.c
===================================================================
--- test.orig/arch/um/kernel/tlb.c	2005-09-01 16:32:51.000000000 -0400
+++ test/arch/um/kernel/tlb.c	2005-09-01 16:33:07.000000000 -0400
@@ -16,115 +16,117 @@
 #include "os.h"
 
 static int add_mmap(unsigned long virt, unsigned long phys, unsigned long len,
-		    int r, int w, int x, struct host_vm_op *ops, int index,
+ 		    int r, int w, int x, struct host_vm_op *ops, int *index, 
 		    int last_filled, union mm_context *mmu, void **flush,
-		    void *(*do_ops)(union mm_context *, struct host_vm_op *,
-				    int, int, void *))
+		    int (*do_ops)(union mm_context *, struct host_vm_op *, 
+				  int, int, void **))
 {
         __u64 offset;
 	struct host_vm_op *last;
-	int fd;
+	int fd, ret = 0;
 
 	fd = phys_mapping(phys, &offset);
-	if(index != -1){
-		last = &ops[index];
+	if(*index != -1){
+		last = &ops[*index];
 		if((last->type == MMAP) &&
 		   (last->u.mmap.addr + last->u.mmap.len == virt) &&
 		   (last->u.mmap.r == r) && (last->u.mmap.w == w) &&
 		   (last->u.mmap.x == x) && (last->u.mmap.fd == fd) &&
 		   (last->u.mmap.offset + last->u.mmap.len == offset)){
 			last->u.mmap.len += len;
-			return index;
+			return 0;
 		}
 	}
 
-	if(index == last_filled){
-		*flush = (*do_ops)(mmu, ops, last_filled, 0, *flush);
-		index = -1;
+	if(*index == last_filled){
+		ret = (*do_ops)(mmu, ops, last_filled, 0, flush);
+		*index = -1;
 	}
 
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
-	return index;
+	ops[++*index] = ((struct host_vm_op) { .type	= MMAP,
+			     			.u = { .mmap = {
+						       .addr	= virt,
+						       .len	= len,
+						       .r	= r,
+						       .w	= w,
+						       .x	= x,
+						       .fd	= fd,
+						       .offset	= offset }
+			   } });
+	return ret;
 }
 
 static int add_munmap(unsigned long addr, unsigned long len,
-		      struct host_vm_op *ops, int index, int last_filled,
+		      struct host_vm_op *ops, int *index, int last_filled,
 		      union mm_context *mmu, void **flush,
-		      void *(*do_ops)(union mm_context *, struct host_vm_op *,
-				      int, int, void *))
+		      int (*do_ops)(union mm_context *, struct host_vm_op *, 
+				    int, int, void **))
 {
 	struct host_vm_op *last;
-
-	if(index != -1){
-		last = &ops[index];
+	int ret = 0;
+  
+	if(*index != -1){
+		last = &ops[*index];
 		if((last->type == MUNMAP) &&
 		   (last->u.munmap.addr + last->u.mmap.len == addr)){
 			last->u.munmap.len += len;
-			return index;
+			return 0;
 		}
 	}
 
-	if(index == last_filled){
-		*flush = (*do_ops)(mmu, ops, last_filled, 0, *flush);
-		index = -1;
+	if(*index == last_filled){
+		ret = (*do_ops)(mmu, ops, last_filled, 0, flush);
+		*index = -1;
 	}
 
-	ops[++index] = ((struct host_vm_op) { .type	= MUNMAP,
-					      .u = { .munmap = {
-						      .addr	= addr,
-						      .len	= len } } });
-	return index;
+	ops[++*index] = ((struct host_vm_op) { .type	= MUNMAP,
+			     		       .u = { .munmap = {
+						        .addr	= addr,
+							.len	= len } } });
+	return ret;
 }
 
 static int add_mprotect(unsigned long addr, unsigned long len, int r, int w,
-			int x, struct host_vm_op *ops, int index,
+			int x, struct host_vm_op *ops, int *index, 
 			int last_filled, union mm_context *mmu, void **flush,
-			void *(*do_ops)(union mm_context *,
-				       struct host_vm_op *, int, int, void *))
+ 			int (*do_ops)(union mm_context *, struct host_vm_op *,
+				      int, int, void **))
 {
 	struct host_vm_op *last;
+	int ret = 0;
 
-	if(index != -1){
-		last = &ops[index];
+	if(*index != -1){
+		last = &ops[*index];
 		if((last->type == MPROTECT) &&
 		   (last->u.mprotect.addr + last->u.mprotect.len == addr) &&
 		   (last->u.mprotect.r == r) && (last->u.mprotect.w == w) &&
 		   (last->u.mprotect.x == x)){
 			last->u.mprotect.len += len;
-			return index;
+			return 0;
 		}
 	}
 
-	if(index == last_filled){
-		*flush = (*do_ops)(mmu, ops, last_filled, 0, *flush);
-		index = -1;
+	if(*index == last_filled){
+		ret = (*do_ops)(mmu, ops, last_filled, 0, flush);
+		*index = -1;
 	}
 
-	ops[++index] = ((struct host_vm_op) { .type	= MPROTECT,
-					      .u = { .mprotect = {
-						      .addr	= addr,
-						      .len	= len,
-						      .r	= r,
-						      .w	= w,
-						      .x	= x } } });
-	return index;
+	ops[++*index] = ((struct host_vm_op) { .type	= MPROTECT,
+			     		       .u = { .mprotect = {
+						       .addr	= addr,
+						       .len	= len,
+						       .r	= r,
+						       .w	= w,
+						       .x	= x } } });
+	return ret;
 }
 
 #define ADD_ROUND(n, inc) (((n) + (inc)) & ~((inc) - 1))
 
 void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
                       unsigned long end_addr, int force,
-		      void *(*do_ops)(union mm_context *, struct host_vm_op *,
-				      int, int, void *))
+		      int (*do_ops)(union mm_context *, struct host_vm_op *, 
+				    int, int, void **))
 {
         pgd_t *npgd;
         pud_t *npud;
@@ -136,20 +138,21 @@
         struct host_vm_op ops[1];
         void *flush = NULL;
         int op_index = -1, last_op = sizeof(ops) / sizeof(ops[0]) - 1;
+        int ret = 0;
 
         if(mm == NULL) return;
 
         ops[0].type = NONE;
-        for(addr = start_addr; addr < end_addr;){
+        for(addr = start_addr; addr < end_addr && !ret;){
                 npgd = pgd_offset(mm, addr);
                 if(!pgd_present(*npgd)){
                         end = ADD_ROUND(addr, PGDIR_SIZE);
                         if(end > end_addr)
                                 end = end_addr;
                         if(force || pgd_newpage(*npgd)){
-                                op_index = add_munmap(addr, end - addr, ops,
-                                                      op_index, last_op, mmu,
-                                                      &flush, do_ops);
+                                ret = add_munmap(addr, end - addr, ops, 
+                                                 &op_index, last_op, mmu,
+                                                 &flush, do_ops);
                                 pgd_mkuptodate(*npgd);
                         }
                         addr = end;
@@ -162,9 +165,9 @@
                         if(end > end_addr)
                                 end = end_addr;
                         if(force || pud_newpage(*npud)){
-                                op_index = add_munmap(addr, end - addr, ops,
-                                                      op_index, last_op, mmu,
-                                                      &flush, do_ops);
+                                ret = add_munmap(addr, end - addr, ops, 
+                                                 &op_index, last_op, mmu,
+                                                 &flush, do_ops);
                                 pud_mkuptodate(*npud);
                         }
                         addr = end;
@@ -177,9 +180,9 @@
                         if(end > end_addr)
                                 end = end_addr;
                         if(force || pmd_newpage(*npmd)){
-                                op_index = add_munmap(addr, end - addr, ops,
-                                                      op_index, last_op, mmu,
-                                                      &flush, do_ops);
+                                ret = add_munmap(addr, end - addr, ops, 
+                                                 &op_index, last_op, mmu,
+                                                 &flush, do_ops);
                                 pmd_mkuptodate(*npmd);
                         }
                         addr = end;
@@ -198,24 +201,32 @@
                 }
                 if(force || pte_newpage(*npte)){
                         if(pte_present(*npte))
-                                op_index = add_mmap(addr,
-                                                    pte_val(*npte) & PAGE_MASK,
-                                                    PAGE_SIZE, r, w, x, ops,
-                                                    op_index, last_op, mmu,
-                                                    &flush, do_ops);
-                        else op_index = add_munmap(addr, PAGE_SIZE, ops,
-                                                   op_index, last_op, mmu,
-                                                   &flush, do_ops);
+			  ret = add_mmap(addr, 
+					 pte_val(*npte) & PAGE_MASK,
+					 PAGE_SIZE, r, w, x, ops, 
+					 &op_index, last_op, mmu,
+					 &flush, do_ops);
+			else ret = add_munmap(addr, PAGE_SIZE, ops, 
+					      &op_index, last_op, mmu, 
+					      &flush, do_ops);
                 }
                 else if(pte_newprot(*npte))
-                        op_index = add_mprotect(addr, PAGE_SIZE, r, w, x, ops,
-                                                op_index, last_op, mmu,
-                                                &flush, do_ops);
+			ret = add_mprotect(addr, PAGE_SIZE, r, w, x, ops, 
+					   &op_index, last_op, mmu,
+					   &flush, do_ops);
 
                 *npte = pte_mkuptodate(*npte);
                 addr += PAGE_SIZE;
         }
-	flush = (*do_ops)(mmu, ops, op_index, 1, flush);
+ 
+	if(!ret)
+		ret = (*do_ops)(mmu, ops, op_index, 1, &flush);
+
+	/* This is not an else because ret is modified above */
+	if(ret) {
+		printk("fix_range_common: failed, killing current process\n");
+		force_sig(SIGKILL, current);
+	}
 }
 
 int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
Index: test/arch/um/kernel/tt/tlb.c
===================================================================
--- test.orig/arch/um/kernel/tt/tlb.c	2005-09-01 16:32:51.000000000 -0400
+++ test/arch/um/kernel/tt/tlb.c	2005-09-01 16:33:07.000000000 -0400
@@ -17,26 +17,31 @@
 #include "os.h"
 #include "tlb.h"
 
-static void *do_ops(union mm_context *mmu, struct host_vm_op *ops, int last,
-		    int finished, void *flush)
+static int do_ops(union mm_context *mmu, struct host_vm_op *ops, int last,
+		    int finished, void **flush)
 {
 	struct host_vm_op *op;
-	int i;
+        int i, ret=0;
 
-	for(i = 0; i <= last; i++){
+        for(i = 0; i <= last && !ret; i++){
 		op = &ops[i];
 		switch(op->type){
 		case MMAP:
-                        os_map_memory((void *) op->u.mmap.addr, op->u.mmap.fd,
-				      op->u.mmap.offset, op->u.mmap.len,
-				      op->u.mmap.r, op->u.mmap.w,
-				      op->u.mmap.x);
+                        ret = os_map_memory((void *) op->u.mmap.addr,
+                                            op->u.mmap.fd, op->u.mmap.offset,
+                                            op->u.mmap.len, op->u.mmap.r,
+                                            op->u.mmap.w, op->u.mmap.x);
 			break;
 		case MUNMAP:
-			os_unmap_memory((void *) op->u.munmap.addr,
-					op->u.munmap.len);
+                        ret = os_unmap_memory((void *) op->u.munmap.addr, 
+                                              op->u.munmap.len);
 			break;
 		case MPROTECT:
+                        ret = protect_memory(op->u.mprotect.addr,
+                                             op->u.munmap.len, 
+                                             op->u.mprotect.r,
+                                             op->u.mprotect.w, 
+                                             op->u.mprotect.x, 1);
 			protect_memory(op->u.mprotect.addr, op->u.munmap.len,
 				       op->u.mprotect.r, op->u.mprotect.w,
 				       op->u.mprotect.x, 1);
@@ -47,7 +52,7 @@
 		}
 	}
 
-	return NULL;
+	return ret;
 }
 
 static void fix_range(struct mm_struct *mm, unsigned long start_addr, 
Index: test/arch/um/sys-i386/stub.S
===================================================================
--- test.orig/arch/um/sys-i386/stub.S	2005-09-01 16:32:51.000000000 -0400
+++ test/arch/um/sys-i386/stub.S	2005-09-01 16:33:07.000000000 -0400
@@ -2,24 +2,50 @@
 
 	.globl syscall_stub
 .section .__syscall_stub, "x"
-syscall_stub:
-	int 	$0x80
-	mov	%eax, UML_CONFIG_STUB_DATA
-	int3
 
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	mov	$UML_CONFIG_STUB_DATA, %esp
-again:	pop	%eax
+	/* load pointer to first operation */
+	mov	$(UML_CONFIG_STUB_DATA+8), %esp
+
+again:
+	/* load length of additional data */
+	mov	0x0(%esp), %eax
+
+	/* if(length == 0) : end of list */
+	/* write possible 0 to header */
+	mov	%eax, UML_CONFIG_STUB_DATA+4
 	cmpl	$0, %eax
 	jz	done
+
+	/* save current pointer */
+	mov	%esp, UML_CONFIG_STUB_DATA+4
+
+	/* skip additional data */
+	add	%eax, %esp
+
+	/* load syscall-# */
+	pop	%eax
+
+	/* load syscall params */
 	pop	%ebx
 	pop	%ecx
 	pop	%edx
 	pop	%esi
  	pop	%edi
 	pop	%ebp
+
+	/* execute syscall */
 	int	$0x80
+
+	/* check return value */
+	pop	%ebx
+	cmp	%ebx, %eax
+	je	again
+
+done:
+	/* save return value */
 	mov	%eax, UML_CONFIG_STUB_DATA
-	jmp	again
-done:	int3
+
+	/* stop */
+	int3
Index: test/arch/um/sys-x86_64/stub.S
===================================================================
--- test.orig/arch/um/sys-x86_64/stub.S	2005-09-01 16:32:51.000000000 -0400
+++ test/arch/um/sys-x86_64/stub.S	2005-09-01 16:33:07.000000000 -0400
@@ -16,21 +16,51 @@
 
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	movq	$(UML_CONFIG_STUB_DATA >> 32), %rbx
-	salq	$32, %rbx
-	movq	$(UML_CONFIG_STUB_DATA & 0xffffffff), %rcx
-	or	%rcx, %rbx
-	movq	%rbx, %rsp
-again:	pop	%rax
-	cmpq	$0, %rax
-jz	done
+	mov	$(UML_CONFIG_STUB_DATA >> 32), %rbx
+	sal	$32, %rbx
+	mov	$(UML_CONFIG_STUB_DATA & 0xffffffff), %rax
+	or	%rax, %rbx
+	/* load pointer to first operation */
+	mov	%rbx, %rsp
+	add	$0x10, %rsp
+again:
+	/* load length of additional data */
+	mov	0x0(%rsp), %rax
+	
+	/* if(length == 0) : end of list */
+	/* write possible 0 to header */
+	mov	%rax, 8(%rbx)
+	cmp	$0, %rax
+	jz	done
+
+	/* save current pointer */
+	mov	%rsp, 8(%rbx)
+
+	/* skip additional data */
+	add	%rax, %rsp
+
+	/* load syscall-# */
+	pop	%rax
+
+	/* load syscall params */
 	pop	%rdi
 	pop	%rsi
 	pop	%rdx
 	pop	%r10
  	pop	%r8
 	pop	%r9
+
+	/* execute syscall */
 	syscall
+
+	/* check return value */
+	pop	%rcx
+	cmp	%rcx, %rax
+	je	again
+
+done:
+	/* save return value */
 	mov	%rax, (%rbx)
-	jmp	again
-done:	int3
+
+	/* stop */
+	int3

