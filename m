Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317981AbSHDQeH>; Sun, 4 Aug 2002 12:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317984AbSHDQeH>; Sun, 4 Aug 2002 12:34:07 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:57251 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S317981AbSHDQeF>; Sun, 4 Aug 2002 12:34:05 -0400
Message-ID: <3D4D5726.4040904@quark.didntduck.org>
Date: Sun, 04 Aug 2002 12:32:38 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 boot pagetables cleanup part 2
Content-Type: multipart/mixed;
 boundary="------------070708010204080401030108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070708010204080401030108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Reorganize i386/kernel/head.S to eliminate the .org directives.
- boot_pgtables move to .data.init so they can be reclaimed after the 
final pagetables are set up.
- empty_zero_page and swapper_pg_dir move to .data.page_aligned
- the IDT and GDT descriptors are moved to .data

The end effect is that we can now fully use the first page of head.S 
saving about half a page of memory.

--
				Brian Gerst

--------------070708010204080401030108
Content-Type: text/plain;
 name="boot_pte2-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="boot_pte2-1"

diff -urN linux-bg1/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-bg1/arch/i386/kernel/head.S	Sun Aug  4 11:01:52 2002
+++ linux/arch/i386/kernel/head.S	Sun Aug  4 11:58:40 2002
@@ -339,6 +339,19 @@
 	iret
 
 /*
+ * Real beginning of normal "text" segment
+ */
+ENTRY(stext)
+ENTRY(_stext)
+
+/*
+ * This starts the data section. Note that the above is all
+ * in the text section because it has alignment requirements
+ * that we cannot fulfill any other way.
+ */
+.data
+
+/*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
  * only used by the lidt and lgdt instructions. They are not
  * like usual segment descriptors - they consist of a 16-bit
@@ -362,53 +375,6 @@
 
 	.fill NR_CPUS-1,6,0		# space for the other GDT descriptors
 
-/*
- * This is initialized to create an identity-mapping at 0-8M (for bootup
- * purposes) and another mapping of the 0-8M area at virtual address
- * PAGE_OFFSET.
- */
-.org 0x1000
-ENTRY(swapper_pg_dir)
-	.long 0x0007 + __PA(boot_pgtables)
-	.long 0x1007 + __PA(boot_pgtables)
-	/* default: 766 entries */
-	.fill BOOT_USER_PGD_PTRS-2,4,0
-	.long 0x0007 + __PA(boot_pgtables)
-	.long 0x1007 + __PA(boot_pgtables)
-	/* default: 254 entries */
-	.fill BOOT_KERNEL_PGD_PTRS-2,4,0
-
-/*
- * The page tables are initialized to only 8MB here - the final page
- * tables are set up later depending on memory size.
- */
-.org 0x2000
-boot_pgtables:
-
-/*
- * empty_zero_page must immediately follow the page tables ! (The
- * initialization loop counts until empty_zero_page)
- */
-
-.org 0x4000
-boot_pgtables_end:
-ENTRY(empty_zero_page)
-
-.org 0x5000
-
-/*
- * Real beginning of normal "text" segment
- */
-ENTRY(stext)
-ENTRY(_stext)
-
-/*
- * This starts the data section. Note that the above is all
- * in the text section because it has alignment requirements
- * that we cannot fulfill any other way.
- */
-.data
-
 ALIGN
 /*
  * The Global Descriptor Table contains 20 quadwords, per-CPU.
@@ -444,3 +410,26 @@
 	.fill (NR_CPUS-1)*GDT_ENTRIES,8,0 /* other CPU's GDT */
 #endif
 
+.section .data.page_aligned, "aw"
+ENTRY(empty_zero_page)
+	.fill 4096,1,0
+
+/*
+ * This is initialized to create an identity-mapping at 0-8M (for bootup
+ * purposes) and another mapping of the 0-8M area at virtual address
+ * PAGE_OFFSET.
+ */
+ENTRY(swapper_pg_dir)
+	.long 0x0007 + __PA(boot_pgtables)
+	.long 0x1007 + __PA(boot_pgtables)
+	/* default: 766 entries */
+	.fill BOOT_USER_PGD_PTRS-2,4,0
+	.long 0x0007 + __PA(boot_pgtables)
+	.long 0x1007 + __PA(boot_pgtables)
+	/* default: 254 entries */
+	.fill BOOT_KERNEL_PGD_PTRS-2,4,0
+
+.section .data.boot_pgtable, "aw"
+boot_pgtables:
+	.fill 2*4096,1,0
+boot_pgtables_end:
diff -urN linux-bg1/arch/i386/vmlinux.lds linux/arch/i386/vmlinux.lds
--- linux-bg1/arch/i386/vmlinux.lds	Tue Jul 23 19:19:44 2002
+++ linux/arch/i386/vmlinux.lds	Sun Aug  4 11:59:19 2002
@@ -63,6 +63,7 @@
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
   . = ALIGN(4096);
+  .data.boot_pgtable : { *(.data.boot_pgtable) }
   __init_end = .;
 
   . = ALIGN(4096);
@@ -72,7 +73,7 @@
   __nosave_end = .;
 
   . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
+  .data.page_aligned : { *(.data.page_aligned) *(.data.idt) }
 
   . = ALIGN(32);
   .data.cacheline_aligned : { *(.data.cacheline_aligned) }

--------------070708010204080401030108--

