Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317878AbSHDPuE>; Sun, 4 Aug 2002 11:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317887AbSHDPuE>; Sun, 4 Aug 2002 11:50:04 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:57832 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S317878AbSHDPuD>; Sun, 4 Aug 2002 11:50:03 -0400
Message-ID: <3D4D4CD2.4060105@quark.didntduck.org>
Date: Sun, 04 Aug 2002 11:48:34 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 boot pagetables cleanup part 1
Content-Type: multipart/mixed;
 boundary="------------030101090500070301040809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030101090500070301040809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- New __PA() macro for physical address.
- Rename pg0 to more descriptive boot_pgtables.  Remove unused pg1.  Add 
boot_pgtables_end instead of relying on empty_zero_page.
- Don't hardcode pte entries in swapper_pg_dir.  Let the linker do its job.

This is in preparation to move empty_zero_page, swapper_pg_dir, and 
boot_pgtables to other data sections.

--
				Brian Gerst

--------------030101090500070301040809
Content-Type: text/plain;
 name="boot_pte1-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot_pte1-1"

diff -urN linux-bk/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-bk/arch/i386/kernel/head.S	Tue Jul 30 10:27:05 2002
+++ linux/arch/i386/kernel/head.S	Sun Aug  4 11:01:52 2002
@@ -36,6 +36,8 @@
 #define X86_CAPABILITY	CPU_PARAMS+12
 #define X86_VENDOR_ID	CPU_PARAMS+28
 
+#define __PA(x) (x-__PAGE_OFFSET)
+
 /*
  * swapper_pg_dir is the main page directory, address 0x00101000
  *
@@ -69,11 +71,10 @@
  *	NOTE! We have to correct for the fact that we're
  *	not yet offset PAGE_OFFSET..
  */
-#define cr4_bits mmu_cr4_features-__PAGE_OFFSET
-	cmpl $0,cr4_bits
+	cmpl $0,__PA(mmu_cr4_features)
 	je 3f
 	movl %cr4,%eax		# Turn on paging options (PSE,PAE,..)
-	orl cr4_bits,%eax
+	orl __PA(mmu_cr4_features),%eax
 	movl %eax,%cr4
 	jmp 3f
 1:
@@ -81,19 +82,19 @@
 /*
  * Initialize page tables
  */
-	movl $pg0-__PAGE_OFFSET,%edi /* initialize page tables */
+	movl $__PA(boot_pgtables),%edi /* initialize page tables */
 	movl $007,%eax		/* "007" doesn't mean with right to kill, but
 				   PRESENT+RW+USER */
 2:	stosl
 	add $0x1000,%eax
-	cmp $empty_zero_page-__PAGE_OFFSET,%edi
+	cmp $__PA(boot_pgtables_end),%edi
 	jne 2b
 
 /*
  * Enable paging
  */
 3:
-	movl $swapper_pg_dir-__PAGE_OFFSET,%eax
+	movl $__PA(swapper_pg_dir),%eax
 	movl %eax,%cr3		/* set the page table pointer.. */
 	movl %cr0,%eax
 	orl $0x80000000,%eax
@@ -368,12 +369,12 @@
  */
 .org 0x1000
 ENTRY(swapper_pg_dir)
-	.long 0x00102007
-	.long 0x00103007
-	.fill BOOT_USER_PGD_PTRS-2,4,0
+	.long 0x0007 + __PA(boot_pgtables)
+	.long 0x1007 + __PA(boot_pgtables)
 	/* default: 766 entries */
-	.long 0x00102007
-	.long 0x00103007
+	.fill BOOT_USER_PGD_PTRS-2,4,0
+	.long 0x0007 + __PA(boot_pgtables)
+	.long 0x1007 + __PA(boot_pgtables)
 	/* default: 254 entries */
 	.fill BOOT_KERNEL_PGD_PTRS-2,4,0
 
@@ -382,10 +383,7 @@
  * tables are set up later depending on memory size.
  */
 .org 0x2000
-ENTRY(pg0)
-
-.org 0x3000
-ENTRY(pg1)
+boot_pgtables:
 
 /*
  * empty_zero_page must immediately follow the page tables ! (The
@@ -393,6 +391,7 @@
  */
 
 .org 0x4000
+boot_pgtables_end:
 ENTRY(empty_zero_page)
 
 .org 0x5000

--------------030101090500070301040809--

