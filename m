Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbULABmz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbULABmz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 20:42:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbULABl1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 20:41:27 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:16335 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261218AbULABh4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 20:37:56 -0500
Subject: Re: 2.6.10-rc2-mm4
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20041130095045.090de5ea.akpm@osdl.org>
References: <20041130095045.090de5ea.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1101865072.20437.4.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 30 Nov 2004 17:37:53 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-11-30 at 09:50, Andrew Morton wrote:
> +x86_64-experimental-4gb-dma-zone.patch
> 
>  Add a fourth memory zone on x86_64: ZONE_DMA32

Andi,
	I think you made a small mistake in this patch.  There should be no
need to modify ZONES_SHIFT or MAX_ZONES_SHIFT for the change you wish to
make, since 4 zones (0..3) still fit into 2 bits.

Also, while building a kernel, I hit an error due to this patch: 
arch/i386/kernel/srat.c:line #142.

The function looks ok to my untrained eyes, but I'm not sure.  I'm
building a test kernel with the attached patch applied and I'll let you
know if it barfs.

-Matt


diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc2-mm4/arch/i386/kernel/srat.c linux-2.6.10-rc2-mm4-MAX_NR_ZONES-fixlet/arch/i386/kernel/srat.c
--- linux-2.6.10-rc2-mm4/arch/i386/kernel/srat.c	2004-11-30 15:04:38.000000000 -0800
+++ linux-2.6.10-rc2-mm4-MAX_NR_ZONES-fixlet/arch/i386/kernel/srat.c	2004-11-30 17:23:56.000000000 -0800
@@ -139,7 +139,7 @@ static void __init parse_memory_affinity
 }
 
 #if MAX_NR_ZONES != 3
-#error "MAX_NR_ZONES != 3, chunk_to_zone requires review"
+#warning "MAX_NR_ZONES != 3, chunk_to_zone requires review"
 #endif
 /* Take a chunk of pages from page frame cstart to cend and count the number
  * of pages in each zone, returned via zones[].
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.10-rc2-mm4/include/linux/mmzone.h linux-2.6.10-rc2-mm4-MAX_NR_ZONES-fixlet/include/linux/mmzone.h
--- linux-2.6.10-rc2-mm4/include/linux/mmzone.h	2004-11-30 15:05:21.000000000 -0800
+++ linux-2.6.10-rc2-mm4-MAX_NR_ZONES-fixlet/include/linux/mmzone.h	2004-11-30 17:23:36.000000000 -0800
@@ -68,7 +68,7 @@ struct per_cpu_pageset {
 #define ZONE_HIGHMEM		3
 
 #define MAX_NR_ZONES		4	/* Sync this with ZONES_SHIFT */
-#define ZONES_SHIFT		3	/* ceil(log2(MAX_NR_ZONES)) */
+#define ZONES_SHIFT		2	/* ceil(log2(MAX_NR_ZONES)) */
 
 
 /*
@@ -101,7 +101,7 @@ struct per_cpu_pageset {
 
 /*
  * On machines where it is needed (eg PCs) we divide physical memory
- * into multiple physical zones. On a PC we have 3 zones:
+ * into multiple physical zones. On a PC we have 4 zones:
  *
  * ZONE_DMA	  < 16 MB	ISA DMA capable memory
  * ZONE_DMA32	     0 MB 	Empty
@@ -393,7 +393,7 @@ extern struct pglist_data contig_page_da
 #if BITS_PER_LONG == 32 || defined(ARCH_HAS_ATOMIC_UNSIGNED)
 /*
  * with 32 bit page->flags field, we reserve 8 bits for node/zone info.
- * there are 3 zones (2 bits) and this leaves 8-2=6 bits for nodes.
+ * there are 4 zones (2 bits) and this leaves 8-2=6 bits for nodes.
  */
 #define MAX_NODES_SHIFT		6
 #elif BITS_PER_LONG == 64
@@ -409,8 +409,8 @@ extern struct pglist_data contig_page_da
 #error NODES_SHIFT > MAX_NODES_SHIFT
 #endif
 
-/* There are currently 3 zones: DMA, Normal & Highmem, thus we need 2 bits */
-#define MAX_ZONES_SHIFT		3
+/* There are currently 4 zones: DMA, DMA32, Normal & Highmem, thus we need 2 bits */
+#define MAX_ZONES_SHIFT		2
 
 #if ZONES_SHIFT > MAX_ZONES_SHIFT
 #error ZONES_SHIFT > MAX_ZONES_SHIFT


