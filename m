Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUEBLv1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUEBLv1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 07:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUEBLv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 07:51:27 -0400
Received: from aun.it.uu.se ([130.238.12.36]:51405 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262114AbUEBLvW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 07:51:22 -0400
Date: Sun, 2 May 2004 13:51:16 +0200 (MEST)
Message-Id: <200405021151.i42BpGvS007785@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de
Subject: [PATCH] gcc-3.4.0 fixes for 2.6.6-rc3 x86_64 kernel
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some patches to fix compilation warnings from
gcc-3.4.0 in the 2.6.6-rc3 x86_64 kernel.

- puts() type conflict in boot/compressed/misc.c:
  rename to putstr(), just like i386 did
- cast-as-lvalue in ia32_copy_siginfo_from_user():
  use temporary
- code before declaration in io_apic.c:
  move decl up
- code before declaration in ioremap.c:
  move existing #ifndef up
- cast-as-lvalue (tons of them) from UP version of per_cpu():
  merged asm-generic's version

Tested on UP and SMP (with the ARCH_MIN_TASKALIGN fix).

/Mikael

--- linux-2.6.6-rc3/arch/x86_64/boot/compressed/misc.c.~1~	2003-09-28 12:19:38.000000000 +0200
+++ linux-2.6.6-rc3/arch/x86_64/boot/compressed/misc.c	2004-04-30 13:43:28.000000000 +0200
@@ -92,7 +92,7 @@
 static void *malloc(int size);
 static void free(void *where);
  
-static void puts(const char *);
+static void putstr(const char *);
   
 extern int end;
 static long free_mem_ptr = (long)&end;
@@ -153,7 +153,7 @@
 		vidmem[i] = ' ';
 }
 
-static void puts(const char *s)
+static void putstr(const char *s)
 {
 	int x,y,pos;
 	char c;
@@ -270,9 +270,9 @@
 
 static void error(char *x)
 {
-	puts("\n\n");
-	puts(x);
-	puts("\n\n -- System halted");
+	putstr("\n\n");
+	putstr(x);
+	putstr("\n\n -- System halted");
 
 	while(1);
 }
@@ -346,9 +346,9 @@
 	else setup_output_buffer_if_we_run_high(mv);
 
 	makecrc();
-	puts(".\nDecompressing Linux...");
+	putstr(".\nDecompressing Linux...");
 	gunzip();
-	puts("done.\nBooting the kernel.\n");
+	putstr("done.\nBooting the kernel.\n");
 	if (high_loaded) close_output_buffer_if_we_run_high(mv);
 	return high_loaded;
 }
--- linux-2.6.6-rc3/arch/x86_64/ia32/ia32_signal.c.~1~	2004-04-30 13:19:26.000000000 +0200
+++ linux-2.6.6-rc3/arch/x86_64/ia32/ia32_signal.c	2004-04-30 13:59:06.000000000 +0200
@@ -98,6 +98,7 @@
 int ia32_copy_siginfo_from_user(siginfo_t *to, siginfo_t32 __user *from)
 {
 	int err;
+	u32 ptr32;
 	if (!access_ok (VERIFY_READ, from, sizeof(siginfo_t32)))
 		return -EFAULT;
 
@@ -107,7 +108,8 @@
 
 	err |= __get_user(to->si_pid, &from->si_pid);
 	err |= __get_user(to->si_uid, &from->si_uid);
-	err |= __get_user((u32)(u64)to->si_ptr, &from->si_ptr);
+	err |= __get_user(ptr32, &from->si_ptr);
+	to->si_ptr = (void*)(u64)ptr32;
 
 	return err;
 }
--- linux-2.6.6-rc3/arch/x86_64/kernel/io_apic.c.~1~	2004-04-30 13:19:26.000000000 +0200
+++ linux-2.6.6-rc3/arch/x86_64/kernel/io_apic.c	2004-04-30 13:45:56.000000000 +0200
@@ -237,6 +237,7 @@
 			for (func = 0; func < 8; func++) { 
 				u32 class;
 				u32 vendor;
+				u8 type;
 				class = read_pci_config(num,slot,func,
 							PCI_CLASS_REVISION);
 				if (class == 0xffffffff)
@@ -270,8 +271,8 @@
 				} 
 
 				/* No multi-function device? */
-				u8 type = read_pci_config_byte(num,slot,func,
-							       PCI_HEADER_TYPE);
+				type = read_pci_config_byte(num,slot,func,
+							    PCI_HEADER_TYPE);
 				if (!(type & 0x80))
 					break;
 			} 
--- linux-2.6.6-rc3/arch/x86_64/mm/ioremap.c.~1~	2003-10-09 00:24:52.000000000 +0200
+++ linux-2.6.6-rc3/arch/x86_64/mm/ioremap.c	2004-04-30 13:48:24.000000000 +0200
@@ -132,13 +132,13 @@
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
 	if (phys_addr < virt_to_phys(high_memory)) {
+#ifndef CONFIG_DISCONTIGMEM
 		char *t_addr, *t_end;
+ 		struct page *page;
 
 		t_addr = __va(phys_addr);
 		t_end = t_addr + (size - 1);
 	   
-#ifndef CONFIG_DISCONTIGMEM	 
- 		struct page *page;
 		for(page = virt_to_page(t_addr); page <= virt_to_page(t_end); page++)
 			if(!PageReserved(page))
 				return NULL;
--- linux-2.6.6-rc3/include/asm-x86_64/percpu.h.~1~	2003-09-09 14:22:30.000000000 +0200
+++ linux-2.6.6-rc3/include/asm-x86_64/percpu.h	2004-04-30 13:37:18.000000000 +0200
@@ -39,7 +39,7 @@
 #define DEFINE_PER_CPU(type, name) \
     __typeof__(type) per_cpu__##name
 
-#define per_cpu(var, cpu)			((void)cpu, per_cpu__##var)
+#define per_cpu(var, cpu)			(*((void)cpu, &per_cpu__##var))
 #define __get_cpu_var(var)			per_cpu__##var
 
 #endif	/* SMP */
