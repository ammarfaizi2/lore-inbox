Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTDJXxR (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 19:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264091AbTDJXxQ (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 19:53:16 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:6136 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S263990AbTDJXxM (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 19:53:12 -0400
Message-ID: <3E9606A1.8090603@quark.didntduck.org>
Date: Thu, 10 Apr 2003 20:04:49 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: kmalloc() fix^2
References: <16021.59194.847626.480618@napali.hpl.hp.com>
In-Reply-To: <16021.59194.847626.480618@napali.hpl.hp.com>
Content-Type: multipart/mixed;
 boundary="------------020609080202050205030701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020609080202050205030701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David Mosberger wrote:
> It's all very embarassing, but my previous patch was horribly broken:
> it added the NULL terminator to the wrong array...  Of course, adding
> it to the correct array uncovered another bug... ;-(
> 
> Patch below fixes both problems.  Reall, I mean it.
> 
> Andrew, you may want to double-check---I didn't look through all of
> slab.c whether there might be problems (there was no other mention of
> ARRAY_SIZE(malloc_sizes) though.
> 
> Thanks,
> 
> 	--david
> 

My fault, I got a bit overzealous while cleaning that code up.  Here's a 
better patch that gets rid of ARRAY_SIZE since the null is readded.

--
				Brian Gerst


--------------020609080202050205030701
Content-Type: text/plain;
 name="kmalloc_sizes-3"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kmalloc_sizes-3"

--- linux-2.5.67-bk/mm/slab.c	2003-04-10 08:36:50.000000000 -0400
+++ linux/mm/slab.c	2003-04-10 19:18:08.000000000 -0400
@@ -383,11 +383,12 @@
 } malloc_sizes[] = {
 #define CACHE(x) { .cs_size = (x) },
 #include <linux/kmalloc_sizes.h>
+	{ 0, }
 #undef CACHE
 };
 
 /* Must match cache_sizes above. Out of line to keep cache footprint low. */
-static struct {
+static struct cache_names {
 	char *name;
 	char *name_dma;
 } cache_names[] = {
@@ -596,7 +597,9 @@
  */
 void __init kmem_cache_sizes_init(void)
 {
-	int i;
+	struct cache_sizes *sizes = malloc_sizes;
+	struct cache_names *names = cache_names;
+
 	/*
 	 * Fragmentation resistance on low memory - only use bigger
 	 * page orders on machines with more than 32MB of memory.
@@ -604,15 +607,14 @@
 	if (num_physpages > (32 << 20) >> PAGE_SHIFT)
 		slab_break_gfp_order = BREAK_GFP_ORDER_HI;
 
-	for (i = 0; i < ARRAY_SIZE(malloc_sizes); i++) {
-		struct cache_sizes *sizes = malloc_sizes + i;
+	while (sizes->cs_size) {
 		/* For performance, all the general caches are L1 aligned.
 		 * This should be particularly beneficial on SMP boxes, as it
 		 * eliminates "false sharing".
 		 * Note for systems short on memory removing the alignment will
 		 * allow tighter packing of the smaller caches. */
 		sizes->cs_cachep = kmem_cache_create(
-			cache_names[i].name, sizes->cs_size,
+			names->name, sizes->cs_size,
 			0, SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!sizes->cs_cachep)
 			BUG();
@@ -624,10 +626,13 @@
 		}
 
 		sizes->cs_dmacachep = kmem_cache_create(
-			cache_names[i].name_dma, sizes->cs_size,
+			names->name_dma, sizes->cs_size,
 			0, SLAB_CACHE_DMA|SLAB_HWCACHE_ALIGN, NULL, NULL);
 		if (!sizes->cs_dmacachep)
 			BUG();
+
+		sizes++;
+		names++;
 	}
 	/*
 	 * The generic caches are running - time to kick out the

--------------020609080202050205030701--

