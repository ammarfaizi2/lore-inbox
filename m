Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280964AbRKORrt>; Thu, 15 Nov 2001 12:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280931AbRKORrZ>; Thu, 15 Nov 2001 12:47:25 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43833 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S280961AbRKORp5>; Thu, 15 Nov 2001 12:45:57 -0500
Date: Thu, 15 Nov 2001 17:47:44 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Gerd Knorr <kraxel@bytesex.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrea Arcangeli <andrea@suse.de>,
        Kernel List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: kiobuf / vm bug
In-Reply-To: <20011115175531.A7068@bytesex.org>
Message-ID: <Pine.LNX.4.21.0111151733120.1339-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Nov 2001, Gerd Knorr wrote:
> 
> I think I have found a kiobuf-related bug in the VM of recent linux
> kernels.  2.4.13 is fine, 2.4.14-pre1 doesn't boot my machine,
> 2.4.14-pre2 + newer kernels are broken.
> 
> /me runs a kernel with a few v4l-related patches and my current 0.8.x
> bttv version (available from http://bytesex.org/patches/ +
> http://bytesex.org/bttv/).
> 
> With this kernel I can trigger the following BUG():
> ksymoops 2.4.3 on i686 2.4.15-pre4.  Options used
> kernel BUG at page_alloc.c:84!
> >>EIP; c0129e5a <__free_pages_ok+aa/29c>   <=====
> Trace; c012a6f2 <__free_pages+1a/1c>
> Trace; c0121120 <unmap_kiobuf+34/48>
> 
> The Oops seems to be triggered by the following actions:
> 
> (1) the application maps /dev/video0.  bttv 0.8.x simply returns some
>     shared anonymous memory to as mapping.
> (2) the application asks the driver to capture a frame.  bttv will lock
>     down the anonymous memory using kiobufs for I/O and prepare
>     everything for DMA xfer.
> (3) The applications exits for some reason, i.e. the anonymous memory
>     will be unmapped while the DMA transfer is active and the pages are
>     locked down for I/O.
> (4) The DMA xfer is done and bttv's irq handler cleans up everything.
>     This includes calling unlock_kiovec+unmap_kiobuf for the locked
>     pages.  The unmap_kiobuf call at this point triggeres the Oops
>     listed above ...
> 
> Anyone has a idea what is going wrong here?

Yes, page_alloc.c line 84 is the "if (PageLRU(page)) BUG();" check.

I think I know what's going on here, it passed right through my mind
(and out the other side) when Linus made the changes for anon pages
on LRU.  map_user_kiobuf and unmap_kiobuf are not using the standard
get/release primitives used elsewhere in memory.c, so they've slipped
through the net of what needed to be fixed up for anon pages on LRU.

Please try patch below and let us all know if it solves your problem
(and doesn't introduce others).  The first hunk is irrelevant, just
satisfies my preference for using complementarily-named operations.

Hugh

--- 2.4.15-pre4/mm/memory.c	Sun Nov  4 17:29:14 2001
+++ linux/mm/memory.c	Thu Nov 15 17:30:36 2001
@@ -520,7 +520,7 @@
 		map = get_page_map(map);
 		if (map) {
 			flush_dcache_page(map);
-			atomic_inc(&map->count);
+			page_cache_get(map);
 		} else
 			printk (KERN_INFO "Mapped page missing [%d]\n", i);
 		spin_unlock(&mm->page_table_lock);
@@ -588,7 +588,7 @@
 		if (map) {
 			if (iobuf->locked)
 				UnlockPage(map);
-			__free_page(map);
+			page_cache_release(map);
 		}
 	}
 	

