Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263811AbTLEDGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 22:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263824AbTLEDGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 22:06:07 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:36423 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S263811AbTLEDGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 22:06:00 -0500
Date: Fri, 5 Dec 2003 14:00:19 +1100
From: Nathan Scott <nathans@sgi.com>
To: Linus Torvalds <torvalds@osdl.org>, Neil Brown <neilb@cse.unsw.edu.au>
Cc: pinotj@club-internet.fr, manfred@colorfullife.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
Message-ID: <20031205030018.GA1693@frodo>
References: <mnet1.1070562461.26292.pinotj@club-internet.fr> <Pine.LNX.4.58.0312041035530.6638@home.osdl.org> <Pine.LNX.4.58.0312041050050.6638@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312041050050.6638@home.osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 04, 2003 at 11:09:29AM -0800, Linus Torvalds wrote:
> ...
> So the oops it found was apparently triggered by the debugging changes,
> not necessarily by a real bug.
> 
> Ugh, that XFS code is _broken_. Instead of keeping track of how it got the
> memory, it totally forgets where the memory came from, and then it later
> asks "oh, btw, how the hell did I allocate this?".
> 

This patch removes that code, fixes a small memory leak that was
lurking in there too, and adds the missing-bio_put-on-error case
that Neil found in pagebuf.

Neil, with this & Linus' 2 patches (and CONFIG_SLAB_DEBUG off ;)
I now have what looks like a 100% reproducible test case for the
handle_stripe already-freed-bio panic.  This doesn't tickle the
raid5.c BUG_ON you sent me but its exactly the same spot as last
time (i.e. handle_stripe+0xda6), every time.

# raidstart /dev/md0
# mkfs.xfs -f /dev/md0
# mount /dev/md0
# umount /dev/md0
# mount /dev/md0

On my (quad p3) test machine, this second mount panics every time.

cheers.

-- 
Nathan


--- fs/xfs/pagebuf/page_buf.h.orig	2003-12-05 13:47:12.275589232 +1100
+++ fs/xfs/pagebuf/page_buf.h	2003-12-05 13:43:30.898243704 +1100
@@ -123,12 +123,13 @@
 	_PBF_PRIVATE_BH = (1 << 17), /* do not use public buffer heads	   */
 	_PBF_ALL_PAGES_MAPPED = (1 << 18), /* all pages in range mapped	   */
 	_PBF_ADDR_ALLOCATED = (1 << 19), /* pb_addr space was allocated	   */
-	_PBF_MEM_ALLOCATED = (1 << 20), /* pb_mem+underlying pages alloc'd */
+	_PBF_MEM_ALLOCATED = (1 << 20), /* underlying pages are allocated  */
+	_PBF_MEM_SLAB = (1 << 21), /* underlying pages are slab allocated  */
 
-	PBF_FORCEIO = (1 << 21),
-	PBF_FLUSH = (1 << 22),	/* flush disk write cache		   */
-	PBF_READ_AHEAD = (1 << 23),
-	PBF_RUN_QUEUES = (1 << 24), /* run block device task queue	   */
+	PBF_FORCEIO = (1 << 22),
+	PBF_FLUSH = (1 << 23),	/* flush disk write cache		   */
+	PBF_READ_AHEAD = (1 << 24),
+	PBF_RUN_QUEUES = (1 << 25), /* run block device task queue	   */
 
 } page_buf_flags_t;
 
--- fs/xfs/pagebuf/page_buf.c.orig	2003-12-05 13:47:06.888408208 +1100
+++ fs/xfs/pagebuf/page_buf.c	2003-12-05 13:43:30.888245224 +1100
@@ -343,9 +343,6 @@
 			page_cache_release(page);
 		}
 	}
-
-	if (pb->pb_pages != pb->pb_page_array)
-		kfree(pb->pb_pages);
 }
 
 /*
@@ -384,20 +381,17 @@
 		if (pb->pb_flags & _PBF_MEM_ALLOCATED) {
 			if (pb->pb_pages) {
 				/* release the pages in the address list */
-				if (pb->pb_pages[0] &&
-				    PageSlab(pb->pb_pages[0])) {
-					/*
-					 * This came from the slab
-					 * allocator free it as such
-					 */
+				if ((pb->pb_pages[0]) &&
+				    (pb->pb_flags & _PBF_MEM_SLAB)) {
 					kfree(pb->pb_addr);
 				} else {
 					_pagebuf_freepages(pb);
 				}
-
+				if (pb->pb_pages != pb->pb_page_array)
+					kfree(pb->pb_pages);
 				pb->pb_pages = NULL;
 			}
-			pb->pb_flags &= ~_PBF_MEM_ALLOCATED;
+			pb->pb_flags &= ~(_PBF_MEM_ALLOCATED | _PBF_MEM_SLAB);
 		}
 	}
 
@@ -944,7 +938,7 @@
 		return NULL;
 	}
 	/* otherwise pagebuf_free just ignores it */
-	pb->pb_flags |= _PBF_MEM_ALLOCATED;
+	pb->pb_flags |= (_PBF_MEM_ALLOCATED | _PBF_MEM_SLAB);
 	PB_CLEAR_OWNER(pb);
 	up(&pb->pb_sema);	/* Return unlocked pagebuf */
 
@@ -1412,6 +1406,7 @@
 		if (size)
 			goto next_chunk;
 	} else {
+		bio_put(bio);
 		pagebuf_ioerror(pb, EIO);
 	}
 
