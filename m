Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751121AbWGGAeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751121AbWGGAeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 20:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWGGAdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 20:33:47 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:48579 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751112AbWGGAdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 20:33:43 -0400
Message-Id: <200607070033.k670Xadd008667@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 2/19] UML - Fix static binary segfault
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Jul 2006 20:33:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When UML is built as a static binary, it segfaults when run.  The
reason is that a memory hole that is present in dynamic binaries isn't
there in static binaries, and it contains essential stuff.

This fix removes the code which maps some anonymous memory into that
hole and cleans up some related code.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/include/skas/mode_kern_skas.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/skas/mode_kern_skas.h	2006-06-21 18:03:49.000000000 -0400
+++ linux-2.6.16/arch/um/include/skas/mode_kern_skas.h	2006-06-21 18:04:51.000000000 -0400
@@ -29,8 +29,7 @@ extern void flush_tlb_mm_skas(struct mm_
 extern void force_flush_all_skas(void);
 extern long execute_syscall_skas(void *r);
 extern void before_mem_skas(unsigned long unused);
-extern unsigned long set_task_sizes_skas(unsigned long *host_size_out,
-					 unsigned long *task_size_out);
+extern unsigned long set_task_sizes_skas(unsigned long *task_size_out);
 extern int start_uml_skas(void);
 extern int external_pid_skas(struct task_struct *task);
 extern int thread_pid_skas(struct task_struct *task);
Index: linux-2.6.16/arch/um/include/tt/mode_kern_tt.h
===================================================================
--- linux-2.6.16.orig/arch/um/include/tt/mode_kern_tt.h	2006-06-21 18:03:49.000000000 -0400
+++ linux-2.6.16/arch/um/include/tt/mode_kern_tt.h	2006-06-21 18:05:35.000000000 -0400
@@ -30,8 +30,7 @@ extern void flush_tlb_mm_tt(struct mm_st
 extern void force_flush_all_tt(void);
 extern long execute_syscall_tt(void *r);
 extern void before_mem_tt(unsigned long brk_start);
-extern unsigned long set_task_sizes_tt(unsigned long *host_size_out,
-				       unsigned long *task_size_out);
+extern unsigned long set_task_sizes_tt(unsigned long *task_size_out);
 extern int start_uml_tt(void);
 extern int external_pid_tt(struct task_struct *task);
 extern int thread_pid_tt(struct task_struct *task);
Index: linux-2.6.16/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/mem.c	2006-06-21 18:03:21.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/mem.c	2006-06-21 18:04:05.000000000 -0400
@@ -24,8 +24,6 @@
 #include "init.h"
 #include "kern_constants.h"
 
-extern char __binary_start;
-
 /* Changed during early boot */
 unsigned long *empty_zero_page = NULL;
 unsigned long *empty_bad_page = NULL;
@@ -65,8 +63,6 @@ static void setup_highmem(unsigned long 
 
 void mem_init(void)
 {
-	unsigned long start;
-
 	max_low_pfn = (high_physmem - uml_physmem) >> PAGE_SHIFT;
 
         /* clear the zero-page */
@@ -81,13 +77,6 @@ void mem_init(void)
 	free_bootmem(__pa(brk_end), uml_reserved - brk_end);
 	uml_reserved = brk_end;
 
-	/* Fill in any hole at the start of the binary */
-	start = (unsigned long) &__binary_start & PAGE_MASK;
-	if(uml_physmem != start){
-		map_memory(uml_physmem, __pa(uml_physmem), start - uml_physmem,
-			   1, 1, 0);
-	}
-
 	/* this will put all low memory onto the freelists */
 	totalram_pages = free_all_bootmem();
 	totalhigh_pages = highmem >> PAGE_SHIFT;
Index: linux-2.6.16/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/physmem.c	2006-06-21 18:03:21.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/physmem.c	2006-06-21 18:04:05.000000000 -0400
@@ -317,7 +317,7 @@ void map_memory(unsigned long virt, unsi
 	}
 }
 
-extern int __syscall_stub_start, __binary_start;
+extern int __syscall_stub_start;
 
 void setup_physmem(unsigned long start, unsigned long reserve_end,
 		   unsigned long len, unsigned long long highmem)
Index: linux-2.6.16/arch/um/kernel/skas/mem.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/skas/mem.c	2006-06-21 18:03:49.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/skas/mem.c	2006-06-21 18:15:35.000000000 -0400
@@ -9,20 +9,19 @@
 #include "mem_user.h"
 #include "skas.h"
 
-unsigned long set_task_sizes_skas(unsigned long *host_size_out,
-				  unsigned long *task_size_out)
+unsigned long set_task_sizes_skas(unsigned long *task_size_out)
 {
 	/* Round up to the nearest 4M */
-	unsigned long top = ROUND_4M((unsigned long) &host_size_out);
+	unsigned long host_task_size = ROUND_4M((unsigned long)
+						&host_task_size);
 
 #ifdef CONFIG_HOST_TASK_SIZE
 	*host_size_out = ROUND_4M(CONFIG_HOST_TASK_SIZE);
 	*task_size_out = CONFIG_HOST_TASK_SIZE;
 #else
-	*host_size_out = top;
 	if (!skas_needs_stub)
-		*task_size_out = top;
+		*task_size_out = host_task_size;
 	else *task_size_out = CONFIG_STUB_START & PGDIR_MASK;
 #endif
-	return ((unsigned long) set_task_sizes_skas) & ~0xffffff;
+	return host_task_size;
 }
Index: linux-2.6.16/arch/um/kernel/tt/mem.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/tt/mem.c	2006-06-21 18:03:49.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/tt/mem.c	2006-06-21 18:17:04.000000000 -0400
@@ -24,11 +24,13 @@ void before_mem_tt(unsigned long brk_sta
 #define SIZE ((CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS) * 0x20000000)
 #define START (CONFIG_TOP_ADDR - SIZE)
 
-unsigned long set_task_sizes_tt(unsigned long *host_size_out,
-				unsigned long *task_size_out)
+unsigned long set_task_sizes_tt(unsigned long *task_size_out)
 {
+	unsigned long host_task_size;
+
 	/* Round up to the nearest 4M */
-	*host_size_out = ROUND_4M((unsigned long) &host_size_out);
+	host_task_size = ROUND_4M((unsigned long) &host_task_size);
 	*task_size_out = START;
-	return START;
+
+	return host_task_size;
 }
Index: linux-2.6.16/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/um_arch.c	2006-06-21 18:03:49.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/um_arch.c	2006-06-23 11:51:06.000000000 -0400
@@ -330,6 +330,8 @@ EXPORT_SYMBOL(end_iomem);
 
 #define MIN_VMALLOC (32 * 1024 * 1024)
 
+extern char __binary_start;
+
 int linux_main(int argc, char **argv)
 {
 	unsigned long avail, diff;
@@ -374,8 +376,9 @@ int linux_main(int argc, char **argv)
 
 	printf("UML running in %s mode\n", mode);
 
-	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas,
-				     &host_task_size, &task_size);
+	uml_start = (unsigned long) &__binary_start;
+	host_task_size = CHOOSE_MODE_PROC(set_task_sizes_tt,
+					  set_task_sizes_skas, &task_size);
 
 	/*
  	 * Setting up handlers to 'sig_info' struct
@@ -395,7 +398,7 @@ int linux_main(int argc, char **argv)
 		physmem_size += UML_ROUND_UP(brk_start) - UML_ROUND_UP(&_end);
 	}
 
-	uml_physmem = uml_start;
+	uml_physmem = uml_start & PAGE_MASK;
 
 	/* Reserve up to 4M after the current brk */
 	uml_reserved = ROUND_4M(brk_start) + (1 << 22);
Index: linux-2.6.16/arch/um/kernel/uml.lds.S
===================================================================
--- linux-2.6.16.orig/arch/um/kernel/uml.lds.S	2006-06-21 18:03:21.000000000 -0400
+++ linux-2.6.16/arch/um/kernel/uml.lds.S	2006-06-21 18:09:16.000000000 -0400
@@ -7,13 +7,16 @@ jiffies = jiffies_64;
 
 SECTIONS
 {
-  /*This must contain the right address - not quite the default ELF one.*/
+  /* This must contain the right address - not quite the default ELF one.*/
   PROVIDE (__executable_start = START);
-  . = START + SIZEOF_HEADERS;
+  /* Static binaries stick stuff here, like the sigreturn trampoline,
+   * invisibly to objdump.  So, just make __binary_start equal to the very
+   * beginning of the executable, and if there are unmapped pages after this,
+   * they are forever unusable.
+   */
+  __binary_start = START;
 
-  /* Used in arch/um/kernel/mem.c. Any memory between START and __binary_start
-   * is remapped.*/
-  __binary_start = .;
+  . = START + SIZEOF_HEADERS;
 
 #ifdef MODE_TT
   .remap_data : { UNMAP_PATH (.data .bss) }

