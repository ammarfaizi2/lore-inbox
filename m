Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932244AbWJIFxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbWJIFxJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 01:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932249AbWJIFxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 01:53:09 -0400
Received: from mga03.intel.com ([143.182.124.21]:32561 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S932244AbWJIFxI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 01:53:08 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,278,1157353200"; 
   d="scan'208"; a="128546530:sNHT18637640"
Message-ID: <4529E2BE.1060506@intel.com>
Date: Mon, 09 Oct 2006 13:48:46 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] IA32 move PG0 page table within kernel data segment
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  On i386 kernel image can compile and run at any physical address,kernel
will dynamically establish initial page table at PG0. Currently PG0 address
is adjacent to _end, that is to say PG0 page table is out of kernel data segment.
 Some bootloader put initrd image next kernel data segment so that initial
page table will overwrite initrd imagte. This patch modify this and put PG0
table at BSS segment and free this space later.
  This patch limited kernel image size within 64M, it is possible to modify
ld script to remove this limit, but I am not familiar with ld script.

 Any comments is welcome.

 Signed-off-by: bibo, mao <bibo.mao@intel.com>

Thanks
bibo,mao 


diff -Nrup -X 2.6.18-mm3.org/Documentation/dontdiff 2.6.18-mm3.org/arch/i386/kernel/head.S 2.6.18-mm3/arch/i386/kernel/head.S
--- 2.6.18-mm3.org/arch/i386/kernel/head.S	2006-10-08 16:10:31.000000000 +0800
+++ 2.6.18-mm3/arch/i386/kernel/head.S	2006-10-09 09:14:57.000000000 +0800
@@ -43,8 +43,6 @@
  *
  * This should be a multiple of a page.
  */
-#define INIT_MAP_BEYOND_END	(128*1024)
-
 
 /*
  * 32-bit kernel entrypoint; only used by the boot CPU.  On entry,
@@ -105,10 +103,10 @@ ENTRY(startup_32)
 
 /*
  * Initialize page tables.  This creates a PDE and a set of page
- * tables, which are located immediately beyond _end.  The variable
+ * tables, which are located at pg0.  The variable
  * init_pg_tables_end is set up to point to the first "safe" location.
  * Mappings are created both at virtual address 0 (identity mapping)
- * and PAGE_OFFSET for up to _end+sizeof(page tables)+INIT_MAP_BEYOND_END.
+ * and PAGE_OFFSET for up to _end.
  *
  * Warning: don't use %esi or the stack in this code.  However, %esp
  * can be used as a GPR if you really need it...
@@ -117,6 +115,7 @@ page_pde_offset = (__PAGE_OFFSET >> 20);
 
 	movl $(pg0 - __PAGE_OFFSET), %edi
 	movl $(swapper_pg_dir - __PAGE_OFFSET), %edx
+	movl $(_end - __PAGE_OFFSET),%ebx 
 	movl $0x007, %eax			/* 0x007 = PRESENT+RW+USER */
 10:
 	leal 0x007(%edi),%ecx			/* Create PDE entry */
@@ -128,12 +127,10 @@ page_pde_offset = (__PAGE_OFFSET >> 20);
 	stosl
 	addl $0x1000,%eax
 	loop 11b
-	/* End condition: we must map up to and including INIT_MAP_BEYOND_END */
-	/* bytes beyond the end of our own page tables; the +0x007 is the attribute bits */
-	leal (INIT_MAP_BEYOND_END+0x007)(%edi),%ebp
-	cmpl %ebp,%eax
+	/* End condition: we must map up to _end address */
+	cmpl %ebx ,%edi
 	jb 10b
-	movl %edi,(init_pg_tables_end - __PAGE_OFFSET)
+	movl %ebx, (init_pg_tables_end - __PAGE_OFFSET)
 
 #ifdef CONFIG_SMP
 	xorl %ebx,%ebx				/* This is the boot CPU (BSP) */
diff -Nrup -X 2.6.18-mm3.org/Documentation/dontdiff 2.6.18-mm3.org/arch/i386/kernel/vmlinux.lds.S 2.6.18-mm3/arch/i386/kernel/vmlinux.lds.S
--- 2.6.18-mm3.org/arch/i386/kernel/vmlinux.lds.S	2006-10-08 16:10:31.000000000 +0800
+++ 2.6.18-mm3/arch/i386/kernel/vmlinux.lds.S	2006-10-09 13:10:52.000000000 +0800
@@ -180,11 +180,15 @@ SECTIONS
   . = ALIGN(4);
   __bss_stop = .; 
 
-  _end = . ;
-
   /* This is where the kernel creates the early boot page tables */
   . = ALIGN(4096);
   pg0 = .;
+  .bss.pg : AT(ADDR(.bss.pg) - LOAD_OFFSET) {
+	. += (phys_startup_32 >> 10) + 0x10000;
+	. = ALIGN(4096);
+  }
+  pg_end = .;
+  _end = . ;
 
   /* Sections to be discarded */
   /DISCARD/ : {
diff -Nrup -X 2.6.18-mm3.org/Documentation/dontdiff 2.6.18-mm3.org/arch/i386/mm/init.c 2.6.18-mm3/arch/i386/mm/init.c
--- 2.6.18-mm3.org/arch/i386/mm/init.c	2006-10-08 16:10:31.000000000 +0800
+++ 2.6.18-mm3/arch/i386/mm/init.c	2006-10-08 15:52:12.000000000 +0800
@@ -793,6 +793,9 @@ void free_initmem(void)
 	free_init_pages("unused kernel memory",
 			(unsigned long)(&__init_begin),
 			(unsigned long)(&__init_end));
+	free_init_pages("initial page table",
+			(unsigned long)(&pg0),
+			(unsigned long)(&pg_end));
 }
 
 #ifdef CONFIG_BLK_DEV_INITRD
diff -Nrup -X 2.6.18-mm3.org/Documentation/dontdiff 2.6.18-mm3.org/include/asm-i386/pgtable.h 2.6.18-mm3/include/asm-i386/pgtable.h
--- 2.6.18-mm3.org/include/asm-i386/pgtable.h	2006-10-08 16:10:34.000000000 +0800
+++ 2.6.18-mm3/include/asm-i386/pgtable.h	2006-10-08 15:45:14.000000000 +0800
@@ -201,6 +201,7 @@ extern unsigned long long __PAGE_KERNEL,
 
 /* The boot page tables (all created as a single array) */
 extern unsigned long pg0[];
+extern unsigned long pg_end[];
 
 #define pte_present(x)	((x).pte_low & (_PAGE_PRESENT | _PAGE_PROTNONE))
 
