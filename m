Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265384AbTLHNEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 08:04:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265387AbTLHNEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 08:04:39 -0500
Received: from intra.cyclades.com ([64.186.161.6]:20111 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265384AbTLHNEc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 08:04:32 -0500
Date: Mon, 8 Dec 2003 10:47:42 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Mikael Johansson <mpjohans@pcu.helsinki.fi>
Cc: linux-raid@vger.kernel.org, <linux-kernel@vger.kernel.org>,
       <riel@redhat.com>, <knobi@knobisoft.de>, Jens Axboe <axboe@suse.de>,
       <mason@suse.com>
In-Reply-To: <Pine.OSF.4.58.0311212139530.519259@soul.helsinki.fi>
Message-ID: <Pine.LNX.4.44.0312080949520.889-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Subject: Re: RAID-0 read perf. decrease after 2.4.20
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 21 Nov 2003, Mikael Johansson wrote:

> 
> Hello Marcelo and All!

Hi Mikael,

> 
> On Fri, 21 Nov 2003, Marcelo Tosatti wrote:
> 
> > There have been no significant changes in the RAID driver in 2.4.21, so I
> > suspect the cause for the slowdowns might the changes to the IO scheduler
> > (ll_rw_blk.c) or VM changes.
> >
> > Isolating the -pre which the slowdown starts helps a lot.
> 
> I tested a few kernels to pin point the where tha changes occured. It
> turned out that both 2.4.20 and 2.4.21-pre1 have bad read performance. The
> 2.4.20-ac's show good read speed. I tested it on two machines (different
> from yesterday). I also checked the VIA chipset drivers version; that's
> not the reason for the differences.
> 
> Athlon XP 2400+, 2.09 GHz, 1.5 GB RAM, 2*160 GB Maxtor Maxtor 6Y080L0
> 		VIA	write	read
> 2.4.19		none	10,000	  9,000 K/sec (chipset not supported)
> 2.4.20		3.35	73,000	 88,000
> 2.4.20-ac1	3.35-ac	70,000	135,000
> 2.4.20-ac2	3.35-ac	71,000	140,000
> 2.4.21-pre1	3.35-ac 71,000	 79,000
> 2.4.21-pre3	3.35-ac 71,000   79,000
> 
> Athlon 1.4 GHz, 1.5 GB RAM, 2*80 GB IC35L040AVER07-0 (IBM, I think)
> 2.4.13-ac8	?	49,000	 44,000 K/sec
> 2.4.19		3.34	53,000	 41,000
> 2.4.20-ac2	3.35-ac	50,000	 69,000
> 2.4.21-pre1	3.35-ac	53,000	 46,000
> 
> So there was apparently something very right with the 2.4.20-ac's. It
> would be nice to get it back :-)

2.4.20-aa included rmap and some VM modifications most notably
"drop_behind()" logic which I believe should be the reason for the huge
read speedups. Can you please try it? Against 2.4.23.

--- mm/filemap.c	2003-12-08 10:26:58.000000000 -0200
+++ mm/filemap.c.orig	2003-12-08 10:24:57.000000000 -0200
@@ -1055,56 +1055,6 @@
 	return page;	
 }
 
-
- /* We combine this with read-ahead to deactivate pages when we
- * think there's sequential IO going on. Note that this is
- * harmless since we don't actually evict the pages from memory
- * but just move them to the inactive list.
- *
- * TODO:
- * - make the readahead code smarter
- * - move readahead to the VMA level so we can do the same
- *   trick with mmap()
- *
- * Rik van Riel, 2000
- */
-static void drop_behind(struct file * file, unsigned long index)
-{
-       struct inode *inode = file->f_dentry->d_inode;
-       struct address_space *mapping = inode->i_mapping;
-       struct page *page;
-       unsigned long start;
-
-       /* Nothing to drop-behind if we're on the first page. */
-       if (!index)
-               return;
-
-       if (index > file->f_rawin)
-               start = index - file->f_rawin;
-       else
-               start = 0;
-
-       /*
-        * Go backwards from index-1 and drop all pages in the
-        * readahead window. Since the readahead window may have
-        * been increased since the last time we were called, we
-        * stop when the page isn't there.
-        */
-       spin_lock(&pagemap_lru_lock);
-       while (--index >= start) {
-               struct page **hash = page_hash(mapping, index);
-               spin_lock(&pagecache_lock);
-               page = __find_page_nolock(mapping, index, *hash);
-               spin_unlock(&pagecache_lock);
-               if (!page || !PageActive(page))
-                       break;
-               drop_page(page);
-       }
-       spin_unlock(&pagemap_lru_lock);
-}
-
-
-
 /*
  * Same as grab_cache_page, but do not wait if the page is unavailable.
  * This is intended for speculative data generators, where the data can
@@ -1376,12 +1326,6 @@
 		if (filp->f_ramax > max_readahead)
 			filp->f_ramax = max_readahead;
 
-               /*
-                * Move the pages that have already been passed
-                * to the inactive list.
-                */
-               drop_behind(filp, index);
-
 #ifdef PROFILE_READAHEAD
 		profile_readahead((reada_ok == 2), filp);
 #endif




