Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268404AbUHLDQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268404AbUHLDQw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 23:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268388AbUHLDO7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 23:14:59 -0400
Received: from [12.177.129.25] ([12.177.129.25]:3268 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S268380AbUHLDO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 23:14:28 -0400
Message-Id: <200408120415.i7C4FWJd010494@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] 2.6.8-rc4-mm1 - UML fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 12 Aug 2004 00:15:32 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch below fixes a few UML-specific bugs not related to the rest of the
kernel
	a bogus error return and some formatting in the fork code
	correct calculation of task.thread.kernel_stack
	remove a bogus panic
	a couple of fixes to allow UML to boot in the presence of exec-shield

				Jeff

Index: 2.6.8-rc4-mm1/arch/um/kernel/process.c
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/process.c	2004-08-11 22:44:42.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/process.c	2004-08-11 23:09:44.000000000 -0400
@@ -124,10 +124,14 @@
 
 	/* Start the process and wait for it to kill itself */
 	new_pid = clone(outer_tramp, (void *) sp, clone_flags, &arg);
-	if(new_pid < 0) return(-errno);
+	if(new_pid < 0) 
+		return(new_pid);
+
 	CATCH_EINTR(err = waitpid(new_pid, &status, 0));
-	if(err < 0) panic("Waiting for outer trampoline failed - errno = %d", 
-			  errno);
+	if(err < 0) 
+		panic("Waiting for outer trampoline failed - errno = %d", 
+		      errno);
+
 	if(!WIFSIGNALED(status) || (WTERMSIG(status) != SIGKILL))
 		panic("outer trampoline didn't exit with SIGKILL, "
 		      "status = %d", status);
Index: 2.6.8-rc4-mm1/arch/um/kernel/process_kern.c
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/process_kern.c	2004-08-11 23:03:14.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/process_kern.c	2004-08-11 23:09:44.000000000 -0400
@@ -167,7 +167,7 @@
 {
 	p->thread = (struct thread_struct) INIT_THREAD;
 	p->thread.kernel_stack = 
-		(unsigned long) p->thread_info + THREAD_SIZE;
+		(unsigned long) p->thread_info + 2 * PAGE_SIZE;
 	return(CHOOSE_MODE_PROC(copy_thread_tt, copy_thread_skas, nr, 
 				clone_flags, sp, stack_top, p, regs));
 }
Index: 2.6.8-rc4-mm1/arch/um/kernel/trap_kern.c
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/trap_kern.c	2004-08-11 22:44:42.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/trap_kern.c	2004-08-11 23:09:44.000000000 -0400
@@ -54,8 +54,6 @@
 	if(is_write && !(vma->vm_flags & VM_WRITE)) 
 		goto out;
 	page = address & PAGE_MASK;
-	if(address < (unsigned long) current_thread + 1024 && !is_user)
-		panic("Kernel stack overflow");
 	pgd = pgd_offset(mm, page);
 	pmd = pmd_offset(pgd, page);
 	do {
Index: 2.6.8-rc4-mm1/arch/um/kernel/tt/mem.c
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/tt/mem.c	2004-08-11 22:44:42.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/tt/mem.c	2004-08-11 23:09:44.000000000 -0400
@@ -18,7 +18,7 @@
 	if(!jail || debug)
 		remap_data(UML_ROUND_DOWN(&_stext), UML_ROUND_UP(&_etext), 1);
 	remap_data(UML_ROUND_DOWN(&_sdata), UML_ROUND_UP(&_edata), 1);
-	remap_data(UML_ROUND_DOWN(&__bss_start), UML_ROUND_UP(brk_start), 1);
+	remap_data(UML_ROUND_DOWN(&__bss_start), UML_ROUND_UP(&_end), 1);
 }
 
 #ifdef CONFIG_HOST_2G_2G
Index: 2.6.8-rc4-mm1/arch/um/kernel/tt/process_kern.c
===================================================================
--- 2.6.8-rc4-mm1.orig/arch/um/kernel/tt/process_kern.c	2004-08-11 22:44:42.000000000 -0400
+++ 2.6.8-rc4-mm1/arch/um/kernel/tt/process_kern.c	2004-08-11 23:09:44.000000000 -0400
@@ -412,7 +412,7 @@
 	protect_memory(start, end - start, 1, w, 1, 1);
 
 	start = (unsigned long) UML_ROUND_DOWN(&__bss_start);
-	end = (unsigned long) UML_ROUND_UP(brk_start);
+	end = (unsigned long) UML_ROUND_UP(&_end);
 	protect_memory(start, end - start, 1, w, 1, 1);
 
 	mprotect_kernel_vm(w);

