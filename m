Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261850AbUDSU5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261850AbUDSU5Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbUDSU5Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:57:16 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:50667 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S261850AbUDSU5F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:57:05 -0400
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (ia64)
From: Alex Williamson <alex.williamson@hp.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, davidm@hpl.hp.com,
       linux-ia64@linuxia64.org
In-Reply-To: <E1BFYi5-00055v-NZ@dyn-67.arm.linux.org.uk>
References: <20040418231720.C12222@flint.arm.linux.org.uk>
	 <20040418232314.A2045@flint.arm.linux.org.uk>
	 <E1BFYi5-00055v-NZ@dyn-67.arm.linux.org.uk>
Content-Type: text/plain
Organization: LOSL
Message-Id: <1082408216.4660.132.camel@tdi>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 14:56:56 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-04-19 at 07:21, Russell King wrote:
> This patch cleans up needless includes of asm/pgalloc.h from the
> arch/ia64/ subtree.  This has not been compile tested, so
> needs the architecture maintainers (or willing volunteers) to
> test.
> 
> Please ensure that at least the first two patches have already
> been applied to your tree; they can be found at:
> 
> 	http://lkml.org/lkml/2004/4/18/86
> 	http://lkml.org/lkml/2004/4/18/87
> 
> This patch is part of a larger patch aiming towards getting the
> include of asm/pgtable.h out of linux/mm.h, so that asm/pgtable.h
> can sanely get at things like mm_struct and friends.
> 
> In the event that any of these files fails to build, chances are
> you need to include some other header file rather than pgalloc.h.
> Normally this is either asm/pgtable.h (unlikely), asm/cacheflush.h
> or asm/tlbflush.h.

Russell,

   On ia64, the show_mem sysrq wants to print pgtable_cache_size. 
asm-ia64/tlb.h including asm/pgalloc.h was hiding this for the
discontig, NUMA build, but the contig memory build was blowing up. 
Unless someone is desperately attached to printing out the number of
pages in page table cache, I think we can just drop it.  The patch below
replaces your patches for arch/ia64/contig.c, discontig.c and adds a
chunk for asm-ia64/tlb.h to get rid of the pgalloc.h include there. 
Built and booted NUMA and non-NUMA configs.  Thanks,

	Alex

===== arch/ia64/mm/discontig.c 1.13 vs edited =====
--- 1.13/arch/ia64/mm/discontig.c	Thu Mar 11 23:15:26 2004
+++ edited/arch/ia64/mm/discontig.c	Mon Apr 19 14:36:36 2004
@@ -16,7 +16,6 @@
 #include <linux/bootmem.h>
 #include <linux/acpi.h>
 #include <linux/efi.h>
-#include <asm/pgalloc.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
 #include <asm/numa.h>
@@ -513,7 +512,6 @@
 		printk("\t%d pages shared\n", shared);
 		printk("\t%d pages swap cached\n", cached);
 	}
-	printk("Total of %ld pages in page table cache\n", pgtable_cache_size);
 	printk("%d free buffer pages\n", nr_free_buffer_pages());
 }
 
===== arch/ia64/mm/contig.c 1.4 vs edited =====
--- 1.4/arch/ia64/mm/contig.c	Thu Mar 11 22:59:24 2004
+++ edited/arch/ia64/mm/contig.c	Mon Apr 19 14:28:51 2004
@@ -21,7 +21,6 @@
 #include <linux/swap.h>
 
 #include <asm/meminit.h>
-#include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/sections.h>
 
@@ -60,7 +59,6 @@
 	printk("%d reserved pages\n", reserved);
 	printk("%d pages shared\n", shared);
 	printk("%d pages swap cached\n", cached);
-	printk("%ld pages in page table cache\n", pgtable_cache_size);
 }
 
 /* physical address where the bootmem map is located */
===== include/asm-ia64/tlb.h 1.19 vs edited =====
--- 1.19/include/asm-ia64/tlb.h	Mon Feb 23 13:02:43 2004
+++ edited/include/asm-ia64/tlb.h	Mon Apr 19 14:27:13 2004
@@ -41,9 +41,10 @@
 #include <linux/mm.h>
 #include <linux/swap.h>
 
-#include <asm/pgalloc.h>
 #include <asm/processor.h>
 #include <asm/tlbflush.h>
+
+extern void check_pgt_cache(void);
 
 #ifdef CONFIG_SMP
 # define FREE_PTE_NR		2048


