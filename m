Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030513AbVIAWzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030513AbVIAWzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030502AbVIAWxZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:53:25 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:38160 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030501AbVIAWxX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:53:23 -0400
Message-Id: <200509012217.j81MHEgb011557@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: [PATCH 8/12] UML - Increase granularity of host capability checking
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:17:14 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This change enables SKAS0/SKAS3 to work with all combinations
of /proc/mm and PTRACE_FAULTINFO being available or not.

Also it changes the initialization of proc_mm and
ptrace_faultinfo slightly, to ease forcing SKAS0 on a patched
host. Forcing UML to run without /proc/mm or PTRACE_FAULTINFO
by cmdline parameter can be implemented with a setup resetting
the related variable.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/kernel/skas/include/skas.h
===================================================================
--- test.orig/arch/um/kernel/skas/include/skas.h	2005-09-01 16:03:16.000000000 -0400
+++ test/arch/um/kernel/skas/include/skas.h	2005-09-01 16:21:00.000000000 -0400
@@ -33,7 +33,7 @@
 		     unsigned long len, int r, int w, int x, int done,
 		     void *data);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
-extern int new_mm(int from);
+extern int new_mm(int from, unsigned long stack);
 extern int start_userspace(unsigned long stub_stack);
 extern int copy_context_skas0(unsigned long stack, int pid);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
Index: test/arch/um/kernel/skas/mmu.c
===================================================================
--- test.orig/arch/um/kernel/skas/mmu.c	2005-09-01 16:03:16.000000000 -0400
+++ test/arch/um/kernel/skas/mmu.c	2005-09-01 16:21:00.000000000 -0400
@@ -77,23 +77,14 @@
 	struct mm_struct *cur_mm = current->mm;
 	struct mm_id *cur_mm_id = &cur_mm->context.skas.id;
 	struct mm_id *mm_id = &mm->context.skas.id;
-	unsigned long stack;
-	int from, ret;
+	unsigned long stack = 0;
+	int from, ret = -ENOMEM;
 
-	if(proc_mm){
-		if((cur_mm != NULL) && (cur_mm != &init_mm))
-			from = cur_mm->context.skas.id.u.mm_fd;
-		else from = -1;
-
-		ret = new_mm(from);
-		if(ret < 0){
-			printk("init_new_context_skas - new_mm failed, "
-			       "errno = %d\n", ret);
-			return ret;
-		}
-		mm_id->u.mm_fd = ret;
-	}
-	else {
+	if(!proc_mm || !ptrace_faultinfo){
+		stack = get_zeroed_page(GFP_KERNEL);
+		if(stack == 0)
+			goto out;
+  
 		/* This zeros the entry that pgd_alloc didn't, needed since
 		 * we are about to reinitialize it, and want mm.nr_ptes to
 		 * be accurate.
@@ -103,20 +94,30 @@
 		ret = init_stub_pte(mm, CONFIG_STUB_CODE,
 				    (unsigned long) &__syscall_stub_start);
 		if(ret)
-			goto out;
-
-		ret = -ENOMEM;
-		stack = get_zeroed_page(GFP_KERNEL);
-		if(stack == 0)
-			goto out;
-		mm_id->stack = stack;
+			goto out_free;
 
 		ret = init_stub_pte(mm, CONFIG_STUB_DATA, stack);
 		if(ret)
 			goto out_free;
 
 		dec_mm_counter(mm, nr_ptes);
+	}
+	mm_id->stack = stack;
 
+	if(proc_mm){
+		if((cur_mm != NULL) && (cur_mm != &init_mm))
+			from = cur_mm_id->u.mm_fd;
+		else from = -1;
+
+		ret = new_mm(from, stack);
+		if(ret < 0){
+			printk("init_new_context_skas - new_mm failed, "
+			       "errno = %d\n", ret);
+			goto out_free;
+		}
+		mm_id->u.mm_fd = ret;
+	}
+	else {
 		if((cur_mm != NULL) && (cur_mm != &init_mm))
 			mm_id->u.pid = copy_context_skas0(stack,
 							  cur_mm_id->u.pid);
@@ -126,7 +127,8 @@
 	return 0;
 
  out_free:
-	free_page(mm_id->stack);
+	if(mm_id->stack != 0)
+		free_page(mm_id->stack);
  out:
 	return ret;
 }
@@ -137,8 +139,10 @@
 
 	if(proc_mm)
 		os_close_file(mmu->id.u.mm_fd);
-	else {
+	else
 		os_kill_ptraced_process(mmu->id.u.pid, 1);
+
+	if(!proc_mm || !ptrace_faultinfo){
 		free_page(mmu->id.stack);
 		free_page(mmu->last_page_table);
 	}
Index: test/arch/um/kernel/skas/process.c
===================================================================
--- test.orig/arch/um/kernel/skas/process.c	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/kernel/skas/process.c	2005-09-01 16:21:00.000000000 -0400
@@ -138,6 +138,8 @@
 }
 
 extern int __syscall_stub_start;
+int stub_code_fd = -1;
+__u64 stub_code_offset;
 
 static int userspace_tramp(void *stack)
 {
@@ -152,31 +154,31 @@
 		/* This has a pte, but it can't be mapped in with the usual
 		 * tlb_flush mechanism because this is part of that mechanism
 		 */
-		int fd;
-		__u64 offset;
-
-		fd = phys_mapping(to_phys(&__syscall_stub_start), &offset);
 		addr = mmap64((void *) UML_CONFIG_STUB_CODE, page_size(),
-			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
+			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE,
+			      stub_code_fd, stub_code_offset);
 		if(addr == MAP_FAILED){
-			printk("mapping mmap stub failed, errno = %d\n",
+			printk("mapping stub code failed, errno = %d\n", 
 			       errno);
 			exit(1);
 		}
 
 		if(stack != NULL){
+			int fd;
+			__u64 offset;
+
 			fd = phys_mapping(to_phys(stack), &offset);
 			addr = mmap((void *) UML_CONFIG_STUB_DATA, page_size(),
 				    PROT_READ | PROT_WRITE,
 				    MAP_FIXED | MAP_SHARED, fd, offset);
 			if(addr == MAP_FAILED){
-				printk("mapping segfault stack failed, "
+				printk("mapping stub stack failed, "
 				       "errno = %d\n", errno);
 				exit(1);
 			}
 		}
 	}
-	if(!ptrace_faultinfo && (stack != NULL)){
+	if(!ptrace_faultinfo){
 		unsigned long v = UML_CONFIG_STUB_CODE +
 				  (unsigned long) stub_segv_handler -
 				  (unsigned long) &__syscall_stub_start;
@@ -202,6 +204,10 @@
 	unsigned long sp;
 	int pid, status, n, flags;
 
+	if ( stub_code_fd == -1 )
+		stub_code_fd = phys_mapping(to_phys(&__syscall_stub_start),
+					    &stub_code_offset);
+
 	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
 	if(stack == MAP_FAILED)
@@ -363,6 +369,53 @@
 	return pid;
 }
 
+/*
+ * This is used only, if proc_mm is available, while PTRACE_FAULTINFO
+ * isn't. Opening /proc/mm creates a new mm_context, which lacks the stub-pages
+ * Thus, we map them using /proc/mm-fd
+ */
+void map_stub_pages(int fd, unsigned long code,
+		    unsigned long data, unsigned long stack)
+{
+	struct proc_mm_op mmop;
+	int n;
+
+	mmop = ((struct proc_mm_op) { .op        = MM_MMAP,
+				      .u         =
+				      { .mmap    =
+					{ .addr    = code,
+					  .len     = PAGE_SIZE,
+					  .prot    = PROT_EXEC,
+					  .flags   = MAP_FIXED | MAP_PRIVATE,
+					  .fd      = stub_code_fd,
+					  .offset  = stub_code_offset
+	} } });
+	n = os_write_file(fd, &mmop, sizeof(mmop));
+	if(n != sizeof(mmop))
+		panic("map_stub_pages : /proc/mm map for code failed, "
+		      "err = %d\n", -n);
+
+	if ( stack ) {
+		__u64 map_offset;
+		int map_fd = phys_mapping(to_phys((void *)stack), &map_offset);
+		mmop = ((struct proc_mm_op)
+				{ .op        = MM_MMAP,
+				  .u         =
+				  { .mmap    =
+				    { .addr    = data,
+				      .len     = PAGE_SIZE,
+				      .prot    = PROT_READ | PROT_WRITE,
+				      .flags   = MAP_FIXED | MAP_SHARED,
+				      .fd      = map_fd,
+				      .offset  = map_offset
+		} } });
+		n = os_write_file(fd, &mmop, sizeof(mmop));
+		if(n != sizeof(mmop))
+			panic("map_stub_pages : /proc/mm map for data failed, "
+			      "err = %d\n", -n);
+	}
+}
+
 void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
 		void (*handler)(int))
 {
Index: test/arch/um/kernel/skas/process_kern.c
===================================================================
--- test.orig/arch/um/kernel/skas/process_kern.c	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/kernel/skas/process_kern.c	2005-09-01 16:21:00.000000000 -0400
@@ -129,7 +129,9 @@
 	return(0);
 }
 
-int new_mm(int from)
+extern void map_stub_pages(int fd, unsigned long code,
+			   unsigned long data, unsigned long stack);
+int new_mm(int from, unsigned long stack)
 {
 	struct proc_mm_op copy;
 	int n, fd;
@@ -148,6 +150,9 @@
 			       "err = %d\n", -n);
 	}
 
+	if(!ptrace_faultinfo)
+		map_stub_pages(fd, CONFIG_STUB_CODE, CONFIG_STUB_DATA, stack);
+
 	return(fd);
 }
 

