Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264182AbTDJVjP (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264188AbTDJVjP (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 17:39:15 -0400
Received: from palrel13.hp.com ([156.153.255.238]:37836 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S264182AbTDJVjN (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 17:39:13 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16021.59194.847626.480618@napali.hpl.hp.com>
Date: Thu, 10 Apr 2003 14:50:50 -0700
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: kmalloc() fix^2
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's all very embarassing, but my previous patch was horribly broken:
it added the NULL terminator to the wrong array...  Of course, adding
it to the correct array uncovered another bug... ;-(

Patch below fixes both problems.  Reall, I mean it.

Andrew, you may want to double-check---I didn't look through all of
slab.c whether there might be problems (there was no other mention of
ARRAY_SIZE(malloc_sizes) though.

Thanks,

	--david

===== mm/slab.c 1.74 vs edited =====
--- 1.74/mm/slab.c	Wed Apr  9 13:28:18 2003
+++ edited/mm/slab.c	Thu Apr 10 14:43:44 2003
@@ -383,6 +383,7 @@
 } malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
 #include <linux/kmalloc_sizes.h>
+	{0, }
 #undef CACHE
 };
 
@@ -393,7 +394,6 @@
 } cache_names[] = {
 #define CACHE(x) { .name = "size-" #x, .name_dma = "size-" #x "(DMA)" },
 #include <linux/kmalloc_sizes.h>
-	{ 0, }
 #undef CACHE
 };
 
@@ -604,7 +604,7 @@
 	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
 		slab_break_gfp_order = BREAK_GFP_ORDER_HI;
 
-	for (i = 0; i < ARRAY_SIZE(malloc_sizes); i++) {
+	for (i = 0; i < ARRAY_SIZE(malloc_sizes) - 1; i++) {
 		struct cache_sizes *sizes = malloc_sizes + i;
 		/* For performance, all the general caches are L1 aligned.
 		 * This should be particularly beneficial on SMP boxes, as it
