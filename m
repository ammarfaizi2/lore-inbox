Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285287AbRLSNnG>; Wed, 19 Dec 2001 08:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285290AbRLSNm5>; Wed, 19 Dec 2001 08:42:57 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:44878 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S285288AbRLSNml>; Wed, 19 Dec 2001 08:42:41 -0500
Date: Wed, 19 Dec 2001 14:42:13 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Momchil Velikov <velco@fadata.bg>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Copying to loop device hangs up everything
Message-ID: <20011219144213.A1395@athlon.random>
In-Reply-To: <87bsgwi6zz.fsf@fadata.bg> <Pine.LNX.4.21.0112181757460.4821-100000@freak.distro.conectiva> <3C1FC254.525B9108@zip.com.au> <3C1FCB96.83E49ECB@zip.com.au> <3C204C4F.C989AD71@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <3C204C4F.C989AD71@zip.com.au>; from akpm@zip.com.au on Wed, Dec 19, 2001 at 12:14:07AM -0800
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 12:14:07AM -0800, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > Andrew Morton wrote:
> > >
> > >  I want to know how the loop thread ever hit sync_page_buffers.
> > 
> >   __block_prepare_write
> >   ->get_unused_buffer_head
> >     ->kmem_cache_alloc(SLAB_NOFS)
> > 
> > Shouldn't we be using the address space's GFP flags for bufferhead
> > allocation, rather than cooking up a new one?
> > 
> 
> Um.  That won't work. There are in fact many ways in which loopback
> can deadlock, and propagating gfp flags through all the fs code
> paths won't cut it.
> 
> Here's one such deadlock:
> 
> __wait_on_buffer 
> sync_page_buffers 
> try_to_free_buffers 
> try_to_release_page 
> shrink_cache 
> shrink_caches 
> try_to_free_pages 
> balance_classzone 
> __alloc_pages 
> _alloc_pages 
> find_or_create_page 
> grow_dev_page 
> grow_buffers 
> getblk 
> bread 
> ext2_get_branch 
> ext2_get_block 
> __block_prepare_write 
> block_prepare_write 
> ext2_prepare_write 
> lo_send 
> do_bh_filebacked 
> loop_thread 
> kernel_thread 
> 
> I was able to get a multithread deadlock where the loop thread was waiting
> on an ext2 buffer which was sitting in the loop thread's input queue,
> waiting to be written by the loop thread.  Ugly.
> 
> The thing I don't like about the Andrea+Momchil approach is that it
> exposes the risk of flooding the machine with dirty data.  A scheme

it doesn't, balance_dirty() has to work only  at the highlevel.
sync_page_buffers also is no problem, we'll try again later in those
GFP_NOIO allocations.

furthmore you don't even address the writepage from loop thread on the
loop queue.

The final fix should be in rc2aa1 that I will release in a jiffy. It
takes care now of both the VM and balance_dirty().

this is the incremental fix against rc1aa1:

diff -urN loop-ref/fs/buffer.c loop/fs/buffer.c
--- loop-ref/fs/buffer.c	Wed Dec 19 04:17:30 2001
+++ loop/fs/buffer.c	Wed Dec 19 03:43:24 2001
@@ -2547,6 +2547,7 @@
 	/* Uhhuh, start writeback so that we don't end up with all dirty pages */
 	write_unlock(&hash_table_lock);
 	spin_unlock(&lru_list_lock);
+	gfp_mask = pf_gfp_mask(gfp_mask);
 	if (gfp_mask & __GFP_IO && !(current->flags & PF_ATOMICALLOC)) {
 		if ((gfp_mask & __GFP_HIGHIO) || !PageHighMem(page)) {
 			if (sync_page_buffers(bh)) {
diff -urN loop-ref/include/linux/mm.h loop/include/linux/mm.h
--- loop-ref/include/linux/mm.h	Wed Dec 19 04:17:30 2001
+++ loop/include/linux/mm.h	Wed Dec 19 04:15:52 2001
@@ -562,6 +562,15 @@
 
 #define GFP_DMA		__GFP_DMA
 
+static inline unsigned int pf_gfp_mask(unsigned int gfp_mask)
+{
+	/* avoid all memory balancing I/O methods if this task cannot block on I/O */
+	if (current->flags & PF_NOIO)
+		gfp_mask &= ~(__GFP_IO | __GFP_HIGHIO | __GFP_FS);
+
+	return gfp_mask;
+}
+
 extern int heap_stack_gap;
 
 /*
diff -urN loop-ref/mm/vmscan.c loop/mm/vmscan.c
--- loop-ref/mm/vmscan.c	Wed Dec 19 04:17:30 2001
+++ loop/mm/vmscan.c	Wed Dec 19 03:43:24 2001
@@ -611,6 +611,8 @@
 
 int try_to_free_pages(zone_t *classzone, unsigned int gfp_mask, unsigned int order)
 {
+	gfp_mask = pf_gfp_mask(gfp_mask);
+
 	for (;;) {
 		int tries = vm_scan_ratio << 2;
 		int failed_swapout = !(gfp_mask & __GFP_IO);


try_to_free_pages needs an explicit wrapping because it can be called
not only from the VM.

Andrea
