Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUGXFBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUGXFBX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jul 2004 01:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268284AbUGXFBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jul 2004 01:01:23 -0400
Received: from ozlabs.org ([203.10.76.45]:1982 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268282AbUGXFBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jul 2004 01:01:13 -0400
Date: Sat, 24 Jul 2004 14:47:20 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Fix ppc64 max_pfn issue
Message-ID: <20040724044720.GF4556@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I noticed excessive time in the pid hash functions on a ppc64 box. It
turns out the pid hash is being sized way too small, eg on a 16GB box:

PID hash table entries: 16 (order 4: 256 bytes)

The reason is that the pid hash init function uses max_pfn before it was
setup on ppc64. With the following patch things are good again:

PID hash table entries: 4096 (order 12: 65536 bytes)

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/mm/init.c~fix_max_pfn arch/ppc64/mm/init.c
--- gr_work/arch/ppc64/mm/init.c~fix_max_pfn	2004-07-23 23:13:18.501206270 -0500
+++ gr_work-anton/arch/ppc64/mm/init.c	2004-07-23 23:22:05.691934376 -0500
@@ -555,6 +555,8 @@ void __init do_init_bootmem(void)
 	unsigned long total_pages = lmb_end_of_DRAM() >> PAGE_SHIFT;
 	int boot_mapsize;
 
+        max_pfn = max_low_pfn;
+
 	/*
 	 * Find an area to use for the bootmem bitmap.  Calculate the size of
 	 * bitmap required as (Total Memory) / PAGE_SIZE / BITS_PER_BYTE.
@@ -651,7 +653,6 @@ void __init mem_init(void)
 
 	num_physpages = max_low_pfn;	/* RAM is assumed contiguous */
 	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE);
-	max_pfn = max_low_pfn;
 
 #ifdef CONFIG_DISCONTIGMEM
 {
diff -puN arch/ppc64/mm/numa.c~fix_max_pfn arch/ppc64/mm/numa.c
--- gr_work/arch/ppc64/mm/numa.c~fix_max_pfn	2004-07-23 23:16:29.491011782 -0500
+++ gr_work-anton/arch/ppc64/mm/numa.c	2004-07-23 23:20:47.684429879 -0500
@@ -429,6 +429,7 @@ void __init do_init_bootmem(void)
 
 	min_low_pfn = 0;
 	max_low_pfn = lmb_end_of_DRAM() >> PAGE_SHIFT;
+	max_pfn = max_low_pfn;
 
 	if (parse_numa_properties())
 		setup_nonnuma();

_
