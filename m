Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275105AbTHGGb7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 02:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275110AbTHGGb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 02:31:59 -0400
Received: from holomorphy.com ([66.224.33.161]:39569 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S275105AbTHGGb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 02:31:56 -0400
Date: Wed, 6 Aug 2003 23:33:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-ID: <20030807063311.GX32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030806223716.26af3255.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030806223716.26af3255.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 10:37:16PM -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test2/2.6.0-test2-mm5/
> Lots of different things.  Mainly trying to get this tree stabilised again;
> there has been some breakage lately.

Looks like this got backed out when vmlinux.lds.S moved:


--- linux-old/arch/i386/kernel/vmlinux.lds.S	2003-08-06 23:23:53.000000000 -0700
+++ linux-new/arch/i386/kernel/vmlinux.lds.S	2003-08-04 15:02:26.000000000 -0700
@@ -3,6 +3,9 @@
  */
 
 #include <asm-generic/vmlinux.lds.h>
+#include <linux/config.h>
+#include <asm/page.h>
+#include <asm/asm_offsets.h>
 	
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
@@ -10,7 +13,7 @@
 jiffies = jiffies_64;
 SECTIONS
 {
-  . = 0xC0000000 + 0x100000;
+  . = __PAGE_OFFSET + 0x100000;
   /* read-only */
   _text = .;			/* Text and read-only data */
   .text : {
@@ -19,6 +22,18 @@
 	*(.gnu.warning)
 	} = 0x9090
 
+#ifdef CONFIG_X86_4G
+  . = ALIGN(PAGE_SIZE_asm);
+  __entry_tramp_start = .;
+  . = FIX_ENTRY_TRAMPOLINE_0_addr;
+  __start___entry_text = .;
+  .entry.text : AT (__entry_tramp_start) { *(.entry.text) }
+  __entry_tramp_end = __entry_tramp_start + SIZEOF(.entry.text);
+  . = __entry_tramp_start + 2*PAGE_SIZE_asm;
+#else
+  .entry.text : { *(.entry.text) }
+#endif
+
   _etext = .;			/* End of text section */
 
   . = ALIGN(16);		/* Exception table */
@@ -34,13 +49,13 @@
 	CONSTRUCTORS
 	}
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE_asm);
   __nosave_begin = .;
   .data_nosave : { *(.data.nosave) }
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE_asm);
   __nosave_end = .;
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE_asm);
   .data.page_aligned : { *(.data.idt) }
 
   . = ALIGN(32);
@@ -52,7 +67,7 @@
   .data.init_task : { *(.data.init_task) }
 
   /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
+  . = ALIGN(PAGE_SIZE_asm);		/* Init code and data */
   __init_begin = .;
   .init.text : { 
 	_sinittext = .;
@@ -91,7 +106,7 @@
      from .altinstructions and .eh_frame */
   .exit.text : { *(.exit.text) }
   .exit.data : { *(.exit.data) }
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE_asm);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
@@ -99,10 +114,22 @@
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE_asm);
   __init_end = .;
   /* freed after init ends here */
-	
+
+  . = ALIGN(PAGE_SIZE_asm);
+  .data.page_aligned_tss : { *(.data.tss) }
+
+  . = ALIGN(PAGE_SIZE_asm);
+  .data.page_aligned_default_ldt : { *(.data.default_ldt) }
+
+  . = ALIGN(PAGE_SIZE_asm);
+  .data.page_aligned_idt : { *(.data.idt) }
+
+  . = ALIGN(PAGE_SIZE_asm);
+  .data.page_aligned_gdt : { *(.data.gdt) }
+
   __bss_start = .;		/* BSS */
   .bss : { *(.bss) }
   __bss_stop = .; 
@@ -122,4 +149,6 @@
   .stab.index 0 : { *(.stab.index) }
   .stab.indexstr 0 : { *(.stab.indexstr) }
   .comment 0 : { *(.comment) }
+
+
 }
