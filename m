Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266006AbSLCDdI>; Mon, 2 Dec 2002 22:33:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266010AbSLCDdI>; Mon, 2 Dec 2002 22:33:08 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:16025 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S266006AbSLCDdF>;
	Mon, 2 Dec 2002 22:33:05 -0500
Message-ID: <3DEC273F.5020202@us.ibm.com>
Date: Mon, 02 Dec 2002 19:38:39 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: "Martin J. Bligh" <mbligh@aracnet.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: PAGE_OFFSET config on 2.5 not working 
Content-Type: multipart/mixed;
 boundary="------------010500020408050203090202"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010500020408050203090202
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I've been playing with PAGE_OFFSET as a config option for a while, but 
it appears that it broke in 2.5 around 2.5.40, when I'm not using a 
normal 3:1 split.  I've attached my current patch.

This oops shows it dying at include/asm/apic.h:36, but I've also seen 
it die at include/asm/smp.h:108 too.

Both of these do things casting APIC_BASE and dereferencing it:
((volatile unsigned long *)(APIC_BASE+reg));
GET_APIC_LOGICAL_ID(*(unsigned long *)(APIC_BASE+APIC_LDR));

Any ideas?

Unable to handle kernel paging request at virtual address ffffe020
803987c9
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0060:[<803987c9>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010002
eax: 00000001   ebx: 00000003   ecx: 802f1d38   edx: 000000c0
esi: 00000000   edi: 00000000   ebp: 00000000   esp: bff8bfbc
ds: 0068   es: 0068   ss: 0068
Stack: 00000003 8039889a 00000e7a ffffffff 00000246 fffff186 8011ba3e
        00000e4d 00000000 803f10ea 00000246 8011b975 80375800 00000b6f
        10624dd3 00000000 8011380e

 >>EIP; 803987c9 <smp_callin+19/e0>   <=====

 >>ecx; 802f1d38 <cpu_gdt_table+138/1800>

Trace; 8011ba3e <release_console_sem+4e/b0>
Trace; 8011b975 <printk+135/170>
Trace; 8011380e <smp_tune_scheduling+de/110>

Code;  803987c9 <smp_callin+19/e0>
00000000 <_EIP>:
Code;  803987c9 <smp_callin+19/e0>   <=====
    0:   8b 15 20 e0 ff ff         mov    0xffffe020,%edx   <=====
Code;  803987cf <smp_callin+1f/e0>
    6:   b8 00 e0 ff ff            mov    $0xffffe000,%eax
Code;  803987d4 <smp_callin+24/e0>
    b:   21 e0                     and    %esp,%eax
Code;  803987d6 <smp_callin+26/e0>
    d:   8b 58 0c                  mov    0xc(%eax),%ebx
Code;  803987d9 <smp_callin+29/e0>
   10:   c1 ea 18                  shr    $0x18,%edx
Code;  803987dc <smp_callin+2c/e0>
   13:   83 00 00                  addl   $0x0,(%eax)

-- 
Dave Hansen
haveblue@us.ibm.com

--------------010500020408050203090202
Content-Type: text/plain;
 name="page_offset-config-2.5.50-0.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="page_offset-config-2.5.50-0.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.968   -> 1.970  
#	include/asm-i386/processor.h	1.32    -> 1.33   
#	   arch/i386/Kconfig	1.12    -> 1.13   
#	include/asm-i386/page.h	1.19    -> 1.20   
#	arch/i386/vmlinux.lds.S	1.20    -> 1.21   
#	  arch/i386/Makefile	1.30    -> 1.31   
#	         mm/memory.c	1.99    -> 1.100  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/12/02	haveblue@elm3b96.(none)	1.969
# memory.c, processor.h, page.h, vmlinux.lds.S, Makefile:
#   Import patch page_offset-config-2.5.41-0.patch
# --------------------------------------------
# 02/12/02	haveblue@elm3b96.(none)	1.970
# update for new config system
# --------------------------------------------
#
diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	Mon Dec  2 19:19:59 2002
+++ b/arch/i386/Kconfig	Mon Dec  2 19:19:59 2002
@@ -701,6 +701,44 @@
 
 endchoice
 
+choice
+	help
+	  On i386, a process can only virtually address 4GB of memory.  This
+	  lets you select how much of that virtual space you would like to 
+	  devoted to userspace, and how much to the kernel.
+
+	  Some userspace programs would like to address as much as possible and 
+	  have few demands of the kernel other than it get out of the way.  These
+	  users may opt to use the 3.5GB option to give their userspace program 
+	  as much room as possible.  Due to alignment issues imposed by PAE, 
+	  the "3.5GB" option is unavailable if "64GB" high memory support is 
+	  enabled.
+
+	  Other users (especially those who use PAE) may be running out of
+	  ZONE_NORMAL memory.  Those users may benefit from increasing the
+	  kernel's virtual address space size by taking it away from userspace, 
+	  which may not need all of its space.  An indicator that this is 
+	  happening is when /proc/Meminfo's "LowFree:" is a small percentage of
+	  "LowTotal:" while "HighFree:" is very large.
+
+	  If unsure, say "3GB"
+	prompt "User address space size"
+        default 1GB
+	
+config	05GB
+	bool "3.5 GB"
+	depends on !HIGHMEM64G
+	
+config	1GB
+	bool "3 GB"
+	
+config	2GB
+	bool "2 GB"
+	
+config	3GB
+	bool "1 GB"
+endchoice
+
 config HIGHMEM
 	bool
 	depends on HIGHMEM64G || HIGHMEM4G
diff -Nru a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	Mon Dec  2 19:19:59 2002
+++ b/arch/i386/Makefile	Mon Dec  2 19:19:59 2002
@@ -66,6 +66,8 @@
 CFLAGS += -Iarch/i386/$(MACHINE)
 AFLAGS += -Iarch/i386/$(MACHINE)
 
+AFLAGS_vmlinux.lds.o += -imacros $(TOPDIR)/include/asm-i386/page.h 
+
 makeboot = $(call descend,arch/i386/boot,$(1))
 
 .PHONY: zImage bzImage compressed zlilo bzlilo zdisk bzdisk install \
@@ -94,3 +96,4 @@
 	@$(MAKE) -f scripts/Makefile.clean obj=arch/i386/boot
 
 archmrproper:
+	rm -f arch/i386/vmlinux.lds
diff -Nru a/arch/i386/vmlinux.lds.S b/arch/i386/vmlinux.lds.S
--- a/arch/i386/vmlinux.lds.S	Mon Dec  2 19:19:59 2002
+++ b/arch/i386/vmlinux.lds.S	Mon Dec  2 19:19:59 2002
@@ -7,7 +7,7 @@
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  . = __PAGE_OFFSET + 0x100000;
   /* read-only */
   _text = .;			/* Text and read-only data */
   .text : {
diff -Nru a/include/asm-i386/page.h b/include/asm-i386/page.h
--- a/include/asm-i386/page.h	Mon Dec  2 19:19:59 2002
+++ b/include/asm-i386/page.h	Mon Dec  2 19:19:59 2002
@@ -89,7 +89,16 @@
  * and CONFIG_HIGHMEM64G options in the kernel configuration.
  */
 
-#define __PAGE_OFFSET		(0xC0000000)
+#include <linux/config.h>
+#ifdef CONFIG_05GB
+#define __PAGE_OFFSET          (0xE0000000)
+#elif defined(CONFIG_1GB)
+#define __PAGE_OFFSET          (0xC0000000)
+#elif defined(CONFIG_2GB)
+#define __PAGE_OFFSET          (0x80000000)
+#elif defined(CONFIG_3GB)
+#define __PAGE_OFFSET          (0x40000000)
+#endif
 
 /*
  * This much address space is reserved for vmalloc() and iomap()
diff -Nru a/include/asm-i386/processor.h b/include/asm-i386/processor.h
--- a/include/asm-i386/processor.h	Mon Dec  2 19:19:59 2002
+++ b/include/asm-i386/processor.h	Mon Dec  2 19:19:59 2002
@@ -274,7 +274,11 @@
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
+#ifdef CONFIG_05GB
+#define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 16))
+#else
 #define TASK_UNMAPPED_BASE	(PAGE_ALIGN(TASK_SIZE / 3))
+#endif
 
 /*
  * Size of io_bitmap in longwords: 32 is ports 0-0x3ff.
diff -Nru a/mm/memory.c b/mm/memory.c
--- a/mm/memory.c	Mon Dec  2 19:19:59 2002
+++ b/mm/memory.c	Mon Dec  2 19:19:59 2002
@@ -100,8 +100,7 @@
 
 static inline void free_one_pgd(mmu_gather_t *tlb, pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t * pmd, * md, * emd;
 
 	if (pgd_none(*dir))
 		return;
@@ -112,9 +111,23 @@
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++) {
-		prefetchw(pmd+j+(PREFETCH_STRIDE/16));
-		free_one_pmd(tlb, pmd+j);
+
+	/*
+ 	 * Beware if changing the loop below.  It once used int j,
+	 *	for (j = 0; j < PTRS_PER_PMD; j++)
+	 *		free_one_pmd(pmd+j);
+	 * but some older i386 compilers (e.g. egcs-2.91.66, gcc-2.95.3)
+	 * terminated the loop with a _signed_ address comparison
+	 * using "jle", when configured for HIGHMEM64GB (X86_PAE).
+	 * If also configured for 3GB of kernel virtual address space,
+	 * if page at physical 0x3ffff000 virtual 0x7ffff000 is used as
+	 * a pmd, when that mm exits the loop goes on to free "entries"
+	 * found at 0x80000000 onwards.  The loop below compiles instead
+	 * to be terminated by unsigned address comparison using "jb".
+	 */
+	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) {
+		prefetchw(md+(PREFETCH_STRIDE/16));
+		free_one_pmd(tlb,md);
 	}
 	pmd_free_tlb(tlb, pmd);
 }

--------------010500020408050203090202--

