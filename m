Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUDCOcX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 09:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbUDCOcX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 09:32:23 -0500
Received: from pxy7allmi.all.mi.charter.com ([24.247.15.58]:41137 "EHLO
	proxy7-grandhaven.chartermi.net") by vger.kernel.org with ESMTP
	id S261763AbUDCOcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 09:32:07 -0500
Message-ID: <406ECAE7.1020407@quark.didntduck.org>
Date: Sat, 03 Apr 2004 09:32:07 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] more i386 head.S cleanups
Content-Type: multipart/mixed;
 boundary="------------090208040207050903020200"
X-Charter-MailScanner-Information: 
X-Charter-MailScanner: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090208040207050903020200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

- Move empty_zero_page and swapper_pg_dir to BSS.  This requires that 
BSS is cleared earlier, but reclaims over 3k that was lost due to page 
alignment.
- Move stack_start, ready, and int_msg, boot_gdt_descr, idt_descr, and 
cpu_gdt_descr to .data.  They were interfering with disassembly while in 
.text.

--
				Brian Gerst

--------------090208040207050903020200
Content-Type: text/plain;
 name="head-sections-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="head-sections-1"

diff -urN linux-bk/arch/i386/kernel/head.S linux/arch/i386/kernel/head.S
--- linux-bk/arch/i386/kernel/head.S	2004-04-01 10:17:01.000000000 -0500
+++ linux/arch/i386/kernel/head.S	2004-04-03 09:08:28.053518856 -0500
@@ -69,9 +69,22 @@
 	movl %eax,%gs
 
 /*
+ * Clear BSS first so that there are no surprises...
+ * No need to cld as DF is already clear from cld above...
+ */
+	xorl %eax,%eax
+	movl $__bss_start - __PAGE_OFFSET,%edi
+	movl $__bss_stop - __PAGE_OFFSET,%ecx
+	subl %edi,%ecx
+	shrl $2,%ecx
+	rep ; stosl
+
+/*
  * Initialize page tables.  This creates a PDE and a set of page
  * tables, which are located immediately beyond _end.  The variable
  * init_pg_tables_end is set up to point to the first "safe" location.
+ * Mappings are created both at virtual address 0 (identity mapping)
+ * and PAGE_OFFSET for up to _end+sizeof(page tables)+INIT_MAP_BEYOND_END.
  *
  * Warning: don't use %esi or the stack in this code.  However, %esp
  * can be used as a GPR if you really need it...
@@ -173,17 +186,6 @@
 #endif /* CONFIG_SMP */
 
 /*
- * Clear BSS first so that there are no surprises...
- * No need to cld as DF is already clear from cld above...
- */
-	xorl %eax,%eax
-	movl $__bss_start,%edi
-	movl $__bss_stop,%ecx
-	subl %edi,%ecx
-	shrl $2,%ecx
-	rep ; stosl
-
-/*
  * start system 32-bit setup. We need to re-do some of the things done
  * in 16-bit mode for the "real" operations.
  */
@@ -304,8 +306,6 @@
 	jmp L6			# main should never return here, but
 				# just in case, we know what happens.
 
-ready:	.byte 0
-
 /*
  * We depend on ET to be correct. This checks for 287/387.
  */
@@ -353,13 +353,7 @@
 	jne rp_sidt
 	ret
 
-ENTRY(stack_start)
-	.long init_thread_union+THREAD_SIZE
-	.long __BOOT_DS
-
 /* This is the default interrupt "handler" :-) */
-int_msg:
-	.asciz "Unknown interrupt or fault at EIP %p %p %p\n"
 	ALIGN
 ignore_int:
 	cld
@@ -386,6 +380,35 @@
 	iret
 
 /*
+ * Real beginning of normal "text" segment
+ */
+ENTRY(stext)
+ENTRY(_stext)
+
+/*
+ * BSS section
+ */
+.section ".bss.page_aligned","w"
+ENTRY(swapper_pg_dir)
+	.fill 1024,4,0
+ENTRY(empty_zero_page)
+	.fill 4096,1,0
+
+/*
+ * This starts the data section.
+ */
+.data
+
+ENTRY(stack_start)
+	.long init_thread_union+THREAD_SIZE
+	.long __BOOT_DS
+
+ready:	.byte 0
+
+int_msg:
+	.asciz "Unknown interrupt or fault at EIP %p %p %p\n"
+
+/*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
  * only used by the lidt and lgdt instructions. They are not
  * like usual segment descriptors - they consist of a 16-bit
@@ -417,39 +440,6 @@
 	.fill NR_CPUS-1,8,0		# space for the other GDT descriptors
 
 /*
- * swapper_pg_dir is the main page directory, address 0x00101000
- *
- * This is initialized to create an identity-mapping at 0 (for bootup
- * purposes) and another mapping at virtual address PAGE_OFFSET.  The
- * values put here should be all invalid (zero); the valid
- * entries are created dynamically at boot time.
- *
- * The code creates enough page tables to map 0-_end, the page tables
- * themselves, plus INIT_MAP_BEYOND_END bytes; see comment at beginning.
- */
-.org 0x1000
-ENTRY(swapper_pg_dir)
-	.fill 1024,4,0
-
-.org 0x2000
-ENTRY(empty_zero_page)
-	.fill 4096,1,0
-
-.org 0x3000
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
-/*
  * The boot_gdt_table must mirror the equivalent in setup.S and is
  * used only for booting.
  */
diff -urN linux-bk/arch/i386/kernel/vmlinux.lds.S linux/arch/i386/kernel/vmlinux.lds.S
--- linux-bk/arch/i386/kernel/vmlinux.lds.S	2004-04-01 10:17:01.000000000 -0500
+++ linux/arch/i386/kernel/vmlinux.lds.S	2004-04-02 09:25:14.000000000 -0500
@@ -105,7 +105,10 @@
   /* freed after init ends here */
 	
   __bss_start = .;		/* BSS */
-  .bss : { *(.bss) }
+  .bss : {
+	*(.bss.page_aligned)
+	*(.bss)
+  }
   . = ALIGN(4);
   __bss_stop = .; 
 

--------------090208040207050903020200--
