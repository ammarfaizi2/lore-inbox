Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbWGGAhx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbWGGAhx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGGAhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:37:05 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:59587 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751125AbWGGAeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:34:19 -0400
Message-Id: <200607070033.k670XXqc008662@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Tyler <tyler@agat.net>
Subject: [PATCH 1/19] UML - Clean up address space limits code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:31 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the code of the UML and more precisely at the functions
set_task_sizes_tt and set_task_sizes_skas. I noticed that these 2
functions take a paramater (arg) which is not used : the function is
always called with the value 0.

I suppose that this value might change in the future (or even can be
configured), so I added a constant in mem_user.h file.

Also, I rounded CONFIG_HOST_TASk_SIZE to a 4M.

Signed-off-by: Tyler <tyler@agat.net>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/skas/mem.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/skas/mem.c	2006-06-29 10:37:16.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/skas/mem.c	2006-06-29 10:41:54.000000000 -0400
@@ -9,14 +9,14 @@
 #include "mem_user.h"
 #include "skas.h"
 
-unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out, 
+unsigned long set_task_sizes_skas(unsigned long *host_size_out,
 				  unsigned long *task_size_out)
 {
 	/* Round up to the nearest 4M */
-	unsigned long top = ROUND_4M((unsigned long) &arg);
+	unsigned long top = ROUND_4M((unsigned long) &host_size_out);
 
 #ifdef CONFIG_HOST_TASK_SIZE
-	*host_size_out = CONFIG_HOST_TASK_SIZE;
+	*host_size_out = ROUND_4M(CONFIG_HOST_TASK_SIZE);
 	*task_size_out = CONFIG_HOST_TASK_SIZE;
 #else
 	*host_size_out = top;
@@ -24,16 +24,5 @@ unsigned long set_task_sizes_skas(int ar
 		*task_size_out = top;
 	else *task_size_out = CONFIG_STUB_START & PGDIR_MASK;
 #endif
-	return(((unsigned long) set_task_sizes_skas) & ~0xffffff);
+	return ((unsigned long) set_task_sizes_skas) & ~0xffffff;
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
Index: linux-2.6.17/arch/um/kernel/tt/mem.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/tt/mem.c	2006-06-29 10:37:16.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/tt/mem.c	2006-06-29 10:41:54.000000000 -0400
@@ -24,22 +24,11 @@ void before_mem_tt(unsigned long brk_sta
 #define SIZE ((CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS) * 0x20000000)
 #define START (CONFIG_TOP_ADDR - SIZE)
 
-unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out, 
+unsigned long set_task_sizes_tt(unsigned long *host_size_out,
 				unsigned long *task_size_out)
 {
 	/* Round up to the nearest 4M */
-	*host_size_out = ROUND_4M((unsigned long) &arg);
+	*host_size_out = ROUND_4M((unsigned long) &host_size_out);
 	*task_size_out = START;
-	return(START);
+	return START;
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
Index: linux-2.6.17/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/um_arch.c	2006-06-29 10:37:16.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/um_arch.c	2006-06-29 10:41:54.000000000 -0400
@@ -374,7 +374,7 @@ int linux_main(int argc, char **argv)
 
 	printf("UML running in %s mode\n", mode);
 
-	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
+	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas,
 				     &host_task_size, &task_size);
 
 	/*
Index: linux-2.6.17/arch/um/include/skas/mode_kern_skas.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/skas/mode_kern_skas.h	2006-06-29 10:37:16.000000000 -0400
+++ linux-2.6.17/arch/um/include/skas/mode_kern_skas.h	2006-06-29 10:41:54.000000000 -0400
@@ -29,7 +29,7 @@ extern void flush_tlb_mm_skas(struct mm_
 extern void force_flush_all_skas(void);
 extern long execute_syscall_skas(void *r);
 extern void before_mem_skas(unsigned long unused);
-extern unsigned long set_task_sizes_skas(int arg, unsigned long *host_size_out,
+extern unsigned long set_task_sizes_skas(unsigned long *host_size_out,
 					 unsigned long *task_size_out);
 extern int start_uml_skas(void);
 extern int external_pid_skas(struct task_struct *task);
Index: linux-2.6.17/arch/um/include/tt/mode_kern_tt.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/tt/mode_kern_tt.h	2006-06-29 10:37:16.000000000 -0400
+++ linux-2.6.17/arch/um/include/tt/mode_kern_tt.h	2006-06-29 10:41:54.000000000 -0400
@@ -30,7 +30,7 @@ extern void flush_tlb_mm_tt(struct mm_st
 extern void force_flush_all_tt(void);
 extern long execute_syscall_tt(void *r);
 extern void before_mem_tt(unsigned long brk_start);
-extern unsigned long set_task_sizes_tt(int arg, unsigned long *host_size_out,
+extern unsigned long set_task_sizes_tt(unsigned long *host_size_out,
 				       unsigned long *task_size_out);
 extern int start_uml_tt(void);
 extern int external_pid_tt(struct task_struct *task);

