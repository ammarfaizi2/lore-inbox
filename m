Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270201AbRH1D1l>; Mon, 27 Aug 2001 23:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270206AbRH1D1c>; Mon, 27 Aug 2001 23:27:32 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:52996 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S270201AbRH1D1X>; Mon, 27 Aug 2001 23:27:23 -0400
Date: Mon, 27 Aug 2001 22:59:45 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: patch-2.4.10-pre1
In-Reply-To: <Pine.LNX.4.21.0108271717110.7131-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0108272254470.7514-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 27 Aug 2001, Marcelo Tosatti wrote:

> 
> 
> On Mon, 27 Aug 2001, Linus Torvalds wrote:
> 
> > 
> > On Mon, 27 Aug 2001, Marcelo Tosatti wrote:
> > >
> > > There have been some reports of x-order allocation failures when you where
> > > in Finland. They can be triggered by high IO stress on highmem machines.
> > >
> > > The following patch avoids that by allowing tasks allocating bounce memory
> > > (lowmem) to block on low mem IO, thus applying more "IO pressure" to the
> > > lowmem zone. (the lowmem zone is our "IOable memory" anyway, so...)
> > 
> > I'd much rather set this up by splitting up __GFP_IO into two parts (ie
> > __GFP_IO and __GFP_IO_BOUNCE), and avoiding have "negative" bits in the
> > gfp_mask. That way the bits in gfp_mask always end up increasing things we
> > can do, not ever decreasing them.
> > 
> > Also, your test is really wrong:
> > 
> > 	page->zone != &pgdat_list->node_zones[ZONE_HIGHMEM]
> > 
> > is bogus and assumes MUCH too intimate knowledge of there being only one
> > particular zone that is "highmem" (think NUMA machines where each node may
> > have its own highmem setup). So it SHOULD be something along the lines of
> > 
> > 	#ifdef CONFIG_HIGHMEM
> > 		if (!(gfp_mask & __GFP_HIGHIO) && PageHighMem(page))
> > 			return;
> > 	#endif
> > 
> > inside the write case of sync_page_buffers() (we can, and probably should,
> > still _wait_ for highmem buffers - but whether we do it inside
> > sync_page_buffers() or inside try_to_free_buffers() is probably mostly a
> > matter of taste - I won't argue too much with your choice there).
> > 
> > Other than that, the basic approach looks sane, I would just prefer for
> > the testing and bits to be done more regularly.
> 
> Great. I really expected you to be grumpy about the implementation :)
> 
> Will implement the idea decently and send you the patch later.


Here it goes. 

I tested with two dd's writing 16GB of data total on a 4GB box. 

Note that it may be needed to change __alloc_pages() to call
try_to_free_pages() _even_ for PF_MEMALLOC tasks in case they are trying
to allocate bounce memory (think about a real big number of PF_MEMALLOC
tasks trying to allocate bounce memory at the same time).

However, I'm not sure if that is needed in practice.

diff -Nur linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Mon Aug 27 20:46:36 2001
+++ linux/fs/buffer.c	Mon Aug 27 21:43:35 2001
@@ -2448,6 +2448,10 @@
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
 	if (gfp_mask & __GFP_IO) {
+#ifdef CONFIG_HIGHMEM
+		if (!(gfp_mask & __GFP_HIGHIO) & PageHighMem(page))
+			return;
+#endif
 		sync_page_buffers(bh, gfp_mask);
 		/* We waited synchronously, so we can free the buffers. */
 		if (gfp_mask & __GFP_WAIT) {
diff -Nur linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Mon Aug 27 20:46:37 2001
+++ linux/include/linux/mm.h	Mon Aug 27 20:51:04 2001
@@ -536,17 +536,20 @@
 /* Action modifiers - doesn't change the zoning */
 #define __GFP_WAIT	0x10	/* Can wait and reschedule? */
 #define __GFP_HIGH	0x20	/* Should access emergency pools? */
-#define __GFP_IO	0x40	/* Can start physical IO? */
-#define __GFP_FS	0x80	/* Can call down to low-level FS? */
+#define __GFP_IO	0x40	/* Can start low memory physical IO? */
+#define __GFP_HIGHIO	0x80	/* Can start high mem physical IO? */
+#define __GFP_FS	0x100	/* Can call down to low-level FS? */
 
+#define GFP_NOHIGHIO	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
 #define GFP_NOIO	(__GFP_HIGH | __GFP_WAIT)
-#define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO)
+#define GFP_NOFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO)
 #define GFP_ATOMIC	(__GFP_HIGH)
-#define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_FS | __GFP_HIGHMEM)
-#define GFP_KERNEL	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_NFS		(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_FS)
-#define GFP_KSWAPD	(                          __GFP_IO | __GFP_FS)
+#define GFP_USER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHIO \
+	       	| __GFP_FS | __GFP_HIGHMEM)
+#define GFP_KERNEL	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_NFS	(__GFP_HIGH | __GFP_WAIT | __GFP_IO | __GFP_HIGHIO | __GFP_FS)
+#define GFP_KSWAPD	(                          __GFP_IO | __GFP_HIGHIO | __GFP_FS)
 
 /* Flag - indicates that the buffer will be suitable for DMA.  Ignored on some
    platforms, used as appropriate on others */
diff -Nur linux.orig/include/linux/slab.h linux/include/linux/slab.h
--- linux.orig/include/linux/slab.h	Mon Aug 27 20:46:37 2001
+++ linux/include/linux/slab.h	Mon Aug 27 21:33:16 2001
@@ -17,13 +17,14 @@
 /* flags for kmem_cache_alloc() */
 #define	SLAB_NOFS		GFP_NOFS
 #define	SLAB_NOIO		GFP_NOIO
+#define SLAB_NOHIGHIO		GFP_NOHIGHIO
 #define	SLAB_ATOMIC		GFP_ATOMIC
 #define	SLAB_USER		GFP_USER
 #define	SLAB_KERNEL		GFP_KERNEL
 #define	SLAB_NFS		GFP_NFS
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_FS)
+#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_HIGHIO|__GFP_FS)
 #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
 
 /* flags to pass to kmem_cache_create().
diff -Nur linux.orig/mm/highmem.c linux/mm/highmem.c
--- linux.orig/mm/highmem.c	Mon Aug 27 20:46:37 2001
+++ linux/mm/highmem.c	Mon Aug 27 21:33:23 2001
@@ -321,7 +321,7 @@
 	struct page *page;
 
 repeat_alloc:
-	page = alloc_page(GFP_NOIO);
+	page = alloc_page(GFP_NOHIGHIO);
 	if (page)
 		return page;
 	/*
@@ -359,7 +359,7 @@
 	struct buffer_head *bh;
 
 repeat_alloc:
-	bh = kmem_cache_alloc(bh_cachep, SLAB_NOIO);
+	bh = kmem_cache_alloc(bh_cachep, SLAB_NOHIGHIO);
 	if (bh)
 		return bh;
 	/*

