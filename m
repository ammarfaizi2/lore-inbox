Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268940AbRH0VFL>; Mon, 27 Aug 2001 17:05:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268954AbRH0VFB>; Mon, 27 Aug 2001 17:05:01 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:27154 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S268940AbRH0VEp>; Mon, 27 Aug 2001 17:04:45 -0400
Date: Mon, 27 Aug 2001 16:36:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.4.10-pre1
In-Reply-To: <Pine.LNX.4.33.0108271323290.5985-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0108271633140.7059-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Aug 2001, Linus Torvalds wrote:

> 
> Ok, I'm back from Finland, and there's a 2.4.10-pre1 update on kernel.org.
> Changelog appended..

There have been some reports of x-order allocation failures when you where
in Finland. They can be triggered by high IO stress on highmem machines.

The following patch avoids that by allowing tasks allocating bounce memory
(lowmem) to block on low mem IO, thus applying more "IO pressure" to the
lowmem zone. (the lowmem zone is our "IOable memory" anyway, so...)

This sounded the theorically correct approach to me, and it fixed the
problems in practice.

Here goes the patch against 2.4.10pre1.

diff -Nur linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Mon Aug 27 17:52:25 2001
+++ linux/fs/buffer.c	Mon Aug 27 17:52:47 2001
@@ -2447,7 +2447,8 @@
 	spin_unlock(&free_list[index].lock);
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
-	if (gfp_mask & __GFP_IO) {
+	if (gfp_mask & __GFP_IO || (gfp_mask & __GFP_NOBOUNCE) &&
+			page->zone != &pgdat_list->node_zones[ZONE_HIGHMEM]) {
 		sync_page_buffers(bh, gfp_mask);
 		/* We waited synchronously, so we can free the buffers. */
 		if (gfp_mask & __GFP_WAIT) {
diff -Nur linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Mon Aug 27 17:51:52 2001
+++ linux/include/linux/mm.h	Mon Aug 27 17:52:47 2001
@@ -538,6 +538,8 @@
 #define __GFP_HIGH	0x20	/* Should access emergency pools? */
 #define __GFP_IO	0x40	/* Can start physical IO? */
 #define __GFP_FS	0x80	/* Can call down to low-level FS? */
+#define __GFP_NOBOUNCE	0x100	/* Do not try IO operations which may
+				   result in bounce buffering */
 
 #define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
 #define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
diff -Nur linux.orig/include/linux/slab.h linux/include/linux/slab.h
--- linux.orig/include/linux/slab.h	Mon Aug 27 17:51:50 2001
+++ linux/include/linux/slab.h	Mon Aug 27 17:52:47 2001
@@ -23,7 +23,7 @@
 #define	SLAB_NFS		GFP_NFS
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS)
+#define SLAB_LEVEL_MASK		(__GFP_NOBOUNCE|__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS)
 #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
 
 /* flags to pass to kmem_cache_create().
diff -Nur linux.orig/mm/highmem.c linux/mm/highmem.c
--- linux.orig/mm/highmem.c	Mon Aug 27 17:51:57 2001
+++ linux/mm/highmem.c	Mon Aug 27 17:53:48 2001
@@ -321,7 +321,7 @@
 	struct page *page;
 
 repeat_alloc:
-	page = alloc_page(GFP_NOIO);
+	page = alloc_page(GFP_NOIO|__GFP_NOBOUNCE);
 	if (page)
 		return page;
 	/*
@@ -359,7 +359,7 @@
 	struct buffer_head *bh;
 
 repeat_alloc:
-	bh = kmem_cache_alloc(bh_cachep, SLAB_NOIO);
+	bh = kmem_cache_alloc(bh_cachep, SLAB_NOIO|__GFP_NOBOUNCE);
 	if (bh)
 		return bh;
 	/*

