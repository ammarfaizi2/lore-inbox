Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261832AbUDCQCs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Apr 2004 11:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbUDCQCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Apr 2004 11:02:47 -0500
Received: from waste.org ([209.173.204.2]:14504 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261832AbUDCQCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Apr 2004 11:02:42 -0500
Date: Sat, 3 Apr 2004 10:02:26 -0600
From: Matt Mackall <mpm@selenic.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: [PATCH] more i386 head.S cleanups
Message-ID: <20040403160226.GY6248@waste.org>
References: <406ECAE7.1020407@quark.didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <406ECAE7.1020407@quark.didntduck.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 03, 2004 at 09:32:07AM -0500, Brian Gerst wrote:
> - Move empty_zero_page and swapper_pg_dir to BSS.  This requires that 
> BSS is cleared earlier, but reclaims over 3k that was lost due to page 
> alignment.
> - Move stack_start, ready, and int_msg, boot_gdt_descr, idt_descr, and 
> cpu_gdt_descr to .data.  They were interfering with disassembly while in 
> .text.

Nice. Do you mean 3k here or 0x3000? 

On a related note, I've been sitting on this patch which reorders the
bootstrap code so we can free most of it once we're up:


drop i386 bootstrap text

From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: [PATCH][2.6-tiny] free i386 bootstrap text

Shuffle the idt/gdt descriptors around so that we get a full page and then
free it.

Index: linux-2.6.1-rc1-tiny2/arch/i386/kernel/head.S
===================================================================
RCS file: /home/cvsroot/linux-2.6.1-rc1-tiny2/arch/i386/kernel/head.S,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 head.S


 tiny-mpm/arch/i386/kernel/head.S |   40 +++++++++++++++++++--------------------
 tiny-mpm/arch/i386/mm/init.c     |    8 +++++++
 2 files changed, 28 insertions(+), 20 deletions(-)

diff -puN arch/i386/kernel/head.S~bootstrap-free arch/i386/kernel/head.S
--- tiny/arch/i386/kernel/head.S~bootstrap-free	2004-03-20 12:14:33.000000000 -0600
+++ tiny-mpm/arch/i386/kernel/head.S	2004-03-20 12:14:33.000000000 -0600
@@ -386,6 +386,26 @@ ignore_int:
 	iret
 
 /*
+ * swapper_pg_dir is the main page directory, address 0x00101000
+ *
+ * This is initialized to create an identity-mapping at 0 (for bootup
+ * purposes) and another mapping at virtual address PAGE_OFFSET.  The
+ * values put here should be all invalid (zero); the valid
+ * entries are created dynamically at boot time.
+ *
+ * The code creates enough page tables to map 0-_end, the page tables
+ * themselves, plus INIT_MAP_BEYOND_END bytes; see comment at beginning.
+ */
+.org 0x1000
+ENTRY(swapper_pg_dir)
+	.fill 1024,4,0
+
+.org 0x2000
+ENTRY(empty_zero_page)
+	.fill 4096,1,0
+
+.org 0x3000
+/*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
  * only used by the lidt and lgdt instructions. They are not
  * like usual segment descriptors - they consist of a 16-bit
@@ -417,26 +437,6 @@ cpu_gdt_descr:
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
  * Real beginning of normal "text" segment
  */
 ENTRY(stext)
diff -puN arch/i386/mm/init.c~bootstrap-free arch/i386/mm/init.c
--- tiny/arch/i386/mm/init.c~bootstrap-free	2004-03-20 12:14:33.000000000 -0600
+++ tiny-mpm/arch/i386/mm/init.c	2004-03-20 12:14:33.000000000 -0600
@@ -586,6 +586,14 @@ void free_initmem(void)
 		free_page(addr);
 		totalram_pages++;
 	}
+
+	/* free early bootstrap code in head.S */
+	addr = (unsigned long)&_text;
+	ClearPageReserved(virt_to_page(addr));
+	set_page_count(virt_to_page(addr), 1);
+	free_page(addr);
+	totalram_pages++;
+
 	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);
 }
 

_



-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
