Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261217AbRE0Ia5>; Sun, 27 May 2001 04:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261228AbRE0Iar>; Sun, 27 May 2001 04:30:47 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:55048 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S261217AbRE0Iaf>; Sun, 27 May 2001 04:30:35 -0400
Date: Sun, 27 May 2001 03:53:52 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
        Ben LaHaise <bcrl@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.4.5
In-Reply-To: <Pine.LNX.4.21.0105261847000.1533-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105270318490.4096-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 26 May 2001, Marcelo Tosatti wrote:

> > You're trying to fix the symptoms, by attacking the final end. And what
> > I've been trying to say is that this problem likely has a higher-level
> > _cause_, and I want that _cause_ fixed. Not the symptoms.
> 
> You are not going to fix the problem by _only_ doing this bh allocation
> change.
> 
> Even if some bh allocators _can_ block on IO, there is no guarantee that
> they are going to free low memory --- they may start more IO on highmem
> pages.
> 
> We cannot treat highmem as "yet another zone" zone. All highmem data goes
> through the lowmem before reaching the disk, so its clear for me that we
> should not try to write out highmem pages in case we have a lowmem
> shortage.
> 
> Well, IMO.

I've just tried something similar to the attached patch, which is a "more
aggressive" version of your suggestion to use SLAB_KERNEL for bh
allocations when possible. This one makes all bh allocators block on IO. 

I've tested multiple "dd if=/dev/zero of=bigfile..." calls. (8GB machine,
different amounts of data being written)

The patch makes the kernel handle heavier loads much better than .5 and
.5aa, but it does not fix the problem for this specific test.


(this one is not against 2.4.5, but what I tested under .5 is basically
the same patch) 

diff -Nur linux.orig/mm/vmscan.c linux/mm/vmscan.c
--- linux.orig/mm/vmscan.c	Mon Apr  2 23:41:08 2001
+++ linux/mm/vmscan.c	Tue Apr  3 01:53:13 2001
@@ -422,7 +422,7 @@
 int page_launder(int gfp_mask, int sync)
 {
 	int launder_loop, maxscan, cleaned_pages, maxlaunder;
-	int can_get_io_locks;
+	int can_get_io_locks, can_queue_buffers;
 	struct list_head * page_lru;
 	struct page * page;
 
@@ -431,6 +431,7 @@
 	 * buffers to disk) if __GFP_IO is set.
 	 */
 	can_get_io_locks = gfp_mask & __GFP_IO;
+	can_queue_buffers = gfp_mask & __GFP_PAGE_IO;
 
 	launder_loop = 0;
 	maxlaunder = 0;
@@ -482,7 +483,7 @@
 				goto page_active;
 
 			/* First time through? Move it to the back of the list */
-			if (!launder_loop) {
+			if (!launder_loop || can_queue_buffers) {
 				list_del(page_lru);
 				list_add(page_lru, &inactive_dirty_list);
 				UnlockPage(page);
@@ -612,7 +613,8 @@
 	 * loads, flush out the dirty pages before we have to wait on
 	 * IO.
 	 */
-	if (can_get_io_locks && !launder_loop && free_shortage()) {
+	if ((can_queue_buffers || can_get_io_locks) && !launder_loop 
+			&& free_shortage()) {
 		launder_loop = 1;
 		/* If we cleaned pages, never do synchronous IO. */
 		if (cleaned_pages)
diff -Nur linux.orig/fs/buffer.c linux/fs/buffer.c
--- linux.orig/fs/buffer.c	Mon Apr  2 23:40:59 2001
+++ linux/fs/buffer.c	Tue Apr  3 01:54:26 2001
@@ -1231,7 +1231,7 @@
 	 * more buffer heads, because the swap-out may need
 	 * more buffer-heads itself.  Thus SLAB_BUFFER.
 	 */
-	if((bh = kmem_cache_alloc(bh_cachep, SLAB_BUFFER)) != NULL) {
+	if((bh = kmem_cache_alloc(bh_cachep, SLAB_PAGE_IO)) != NULL) {
 		memset(bh, 0, sizeof(*bh));
 		init_waitqueue_head(&bh->b_wait);
 		return bh;
@@ -2261,7 +2261,7 @@
 		return 0;
 	}
 
-	page = alloc_page(GFP_BUFFER);
+	page = alloc_page(GFP_PAGE_IO);
 	if (!page)
 		goto out;
 	LockPage(page);
diff -Nur linux.orig/include/linux/mm.h linux/include/linux/mm.h
--- linux.orig/include/linux/mm.h	Mon Apr  2 23:41:09 2001
+++ linux/include/linux/mm.h	Tue Apr  3 01:49:29 2001
@@ -480,8 +480,9 @@
 #define __GFP_HIGHMEM	0x0 /* noop */
 #endif
 #define __GFP_VM	0x20
+#define __GFP_PAGE_IO	0x40
 
-
+#define GFP_PAGE_IO	(__GFP_HIGH | __GFP_WAIT | __GFP_PAGE_IO)
 #define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT)
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_USER	(             __GFP_WAIT | __GFP_IO)
diff -Nur linux.orig/include/linux/slab.h linux/include/linux/slab.h
--- linux.orig/include/linux/slab.h	Mon Apr  2 23:41:11 2001
+++ linux/include/linux/slab.h	Tue Apr  3 01:50:01 2001
@@ -15,6 +15,7 @@
 #include	<linux/cache.h>
 
 /* flags for kmem_cache_alloc() */
+#define SLAB_PAGE_IO		GFP_PAGE_IO
 #define	SLAB_BUFFER		GFP_BUFFER
 #define	SLAB_ATOMIC		GFP_ATOMIC
 #define	SLAB_USER		GFP_USER
@@ -22,7 +23,7 @@
 #define	SLAB_NFS		GFP_NFS
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO)
+#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_PAGE_IO)
 #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
 
 /* flags to pass to kmem_cache_create().





