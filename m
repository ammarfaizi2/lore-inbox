Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751310AbVJaDrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751310AbVJaDrN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:47:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVJaDrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:47:12 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:32006 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751310AbVJaDqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:46:49 -0500
Message-Id: <200510310439.j9V4dgqP000878@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 9/10] UML - Big memory fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Oct 2005 23:39:42 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of fixes to improve behavior when large physical memory sizes
are specified:
    libc files need -D_FILE_OFFSET_BITS=64 because there are unavoidable
uses of non-64 interfaces in libc
    some %d need to be %u

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.14/arch/um/Makefile
===================================================================
--- linux-2.6.14.orig/arch/um/Makefile	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/Makefile	2005-10-30 19:29:03.000000000 -0500
@@ -60,7 +60,7 @@ AFLAGS += $(ARCH_INCLUDE)
 
 USER_CFLAGS := $(patsubst -I%,,$(CFLAGS))
 USER_CFLAGS := $(patsubst -D__KERNEL__,,$(USER_CFLAGS)) $(ARCH_INCLUDE) \
-	$(MODE_INCLUDE)
+	$(MODE_INCLUDE) -D_FILE_OFFSET_BITS=64
 
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
Index: linux-2.6.14/arch/um/include/mem_user.h
===================================================================
--- linux-2.6.14.orig/arch/um/include/mem_user.h	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/include/mem_user.h	2005-10-30 19:29:04.000000000 -0500
@@ -57,7 +57,7 @@ extern int init_maps(unsigned long physm
 		     unsigned long highmem);
 extern unsigned long get_vm(unsigned long len);
 extern void setup_physmem(unsigned long start, unsigned long usable,
-			  unsigned long len, unsigned long highmem);
+			  unsigned long len, unsigned long long highmem);
 extern void add_iomem(char *name, int fd, unsigned long size);
 extern unsigned long phys_offset(unsigned long phys);
 extern void unmap_physmem(void);
Index: linux-2.6.14/arch/um/include/os.h
===================================================================
--- linux-2.6.14.orig/arch/um/include/os.h	2005-10-30 19:27:49.000000000 -0500
+++ linux-2.6.14/arch/um/include/os.h	2005-10-30 19:29:04.000000000 -0500
@@ -167,7 +167,7 @@ extern int can_do_skas(void);
 #endif
 
 /* mem.c */
-extern int create_mem_file(unsigned long len);
+extern int create_mem_file(unsigned long long len);
 
 /* process.c */
 extern unsigned long os_process_pc(int pid);
Index: linux-2.6.14/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/mem.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/kernel/mem.c	2005-10-30 19:29:04.000000000 -0500
@@ -235,7 +235,7 @@ void paging_init(void)
 	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
 		zones_size[i] = 0;
 	zones_size[0] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
-	zones_size[2] = highmem >> PAGE_SHIFT;
+	zones_size[3] = highmem >> PAGE_SHIFT;
 	free_area_init(zones_size);
 
 	/*
Index: linux-2.6.14/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/physmem.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/kernel/physmem.c	2005-10-30 19:29:04.000000000 -0500
@@ -246,7 +246,7 @@ int is_remapped(void *virt)
 /* Changed during early boot */
 unsigned long high_physmem;
 
-extern unsigned long physmem_size;
+extern unsigned long long physmem_size;
 
 int init_maps(unsigned long physmem, unsigned long iomem, unsigned long highmem)
 {
@@ -321,7 +321,7 @@ void map_memory(unsigned long virt, unsi
 extern int __syscall_stub_start, __binary_start;
 
 void setup_physmem(unsigned long start, unsigned long reserve_end,
-		   unsigned long len, unsigned long highmem)
+		   unsigned long len, unsigned long long highmem)
 {
 	unsigned long reserve = reserve_end - start;
 	int pfn = PFN_UP(__pa(reserve_end));
Index: linux-2.6.14/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.14.orig/arch/um/kernel/um_arch.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/kernel/um_arch.c	2005-10-30 19:29:04.000000000 -0500
@@ -137,7 +137,7 @@ static char *argv1_end = NULL;
 
 /* Set in early boot */
 static int have_root __initdata = 0;
-long physmem_size = 32 * 1024 * 1024;
+long long physmem_size = 32 * 1024 * 1024;
 
 void set_cmdline(char *cmd)
 {
@@ -402,7 +402,7 @@ int linux_main(int argc, char **argv)
 #ifndef CONFIG_HIGHMEM
 		highmem = 0;
 		printf("CONFIG_HIGHMEM not enabled - physical memory shrunk "
-		       "to %ld bytes\n", physmem_size);
+		       "to %lu bytes\n", physmem_size);
 #endif
 	}
 
@@ -414,8 +414,8 @@ int linux_main(int argc, char **argv)
 
 	setup_physmem(uml_physmem, uml_reserved, physmem_size, highmem);
 	if(init_maps(physmem_size, iomem_size, highmem)){
-		printf("Failed to allocate mem_map for %ld bytes of physical "
-		       "memory and %ld bytes of highmem\n", physmem_size,
+		printf("Failed to allocate mem_map for %lu bytes of physical "
+		       "memory and %lu bytes of highmem\n", physmem_size,
 		       highmem);
 		exit(1);
 	}
@@ -426,7 +426,7 @@ int linux_main(int argc, char **argv)
 	end_vm = start_vm + virtmem_size;
 
 	if(virtmem_size < physmem_size)
-		printf("Kernel virtual memory size shrunk to %ld bytes\n",
+		printf("Kernel virtual memory size shrunk to %lu bytes\n",
 		       virtmem_size);
 
   	uml_postsetup();
Index: linux-2.6.14/arch/um/os-Linux/mem.c
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/mem.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/os-Linux/mem.c	2005-10-30 19:29:05.000000000 -0500
@@ -88,7 +88,7 @@ int make_tempfile(const char *template, 
  * This proc is used in start_up.c
  * So it isn't 'static'.
  */
-int create_tmp_file(unsigned long len)
+int create_tmp_file(unsigned long long len)
 {
 	int fd, err;
 	char zero;
@@ -121,7 +121,7 @@ int create_tmp_file(unsigned long len)
 	return(fd);
 }
 
-static int create_anon_file(unsigned long len)
+static int create_anon_file(unsigned long long len)
 {
 	void *addr;
 	int fd;
@@ -144,7 +144,7 @@ static int create_anon_file(unsigned lon
 
 extern int have_devanon;
 
-int create_mem_file(unsigned long len)
+int create_mem_file(unsigned long long len)
 {
 	int err, fd;
 
Index: linux-2.6.14/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.14.orig/arch/um/os-Linux/start_up.c	2005-10-30 19:28:48.000000000 -0500
+++ linux-2.6.14/arch/um/os-Linux/start_up.c	2005-10-30 19:29:05.000000000 -0500
@@ -296,7 +296,7 @@ static void __init check_ptrace(void)
 	check_sysemu();
 }
 
-extern int create_tmp_file(unsigned long len);
+extern int create_tmp_file(unsigned long long len);
 
 static void check_tmpexec(void)
 {

