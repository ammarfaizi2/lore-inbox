Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265916AbRGERHz>; Thu, 5 Jul 2001 13:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265928AbRGERHp>; Thu, 5 Jul 2001 13:07:45 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:44079 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S265916AbRGERHb>; Thu, 5 Jul 2001 13:07:31 -0400
Date: Thu, 5 Jul 2001 19:07:39 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: GFP_NOFS broken
Message-ID: <20010705190739.A704@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While I was travelling disconnected from the internet the last week (I
will buy a GPRS phone soon ;) I also spotted and fixed the __GFP_BUFFER
deadlock that I was triggering on my 128m laptop while browsing large
email folders on top of crypto loop:

--- 2.4.6pre6aa1/include/linux/mm.h.~1~	Sat Jun 30 00:49:54 2001
+++ 2.4.6pre6aa1/include/linux/mm.h	Sat Jun 30 02:20:57 2001
@@ -538,9 +538,8 @@
 #define __GFP_WAIT	0x10
 #define __GFP_HIGH	0x20
 #define __GFP_IO	0x40
-#define __GFP_BUFFER	0x80
 
-#define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT | __GFP_BUFFER)
+#define GFP_BUFFER	(__GFP_HIGH | __GFP_WAIT)
 #define GFP_ATOMIC	(__GFP_HIGH)
 #define GFP_USER	(             __GFP_WAIT | __GFP_IO)
 #define GFP_HIGHUSER	(             __GFP_WAIT | __GFP_IO | __GFP_HIGHMEM)
--- 2.4.6pre6aa1/include/linux/slab.h.~1~	Sat Jun 30 00:49:56 2001
+++ 2.4.6pre6aa1/include/linux/slab.h	Sat Jun 30 02:21:09 2001
@@ -22,7 +22,7 @@
 #define	SLAB_NFS		GFP_NFS
 #define	SLAB_DMA		GFP_DMA
 
-#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO|__GFP_BUFFER)
+#define SLAB_LEVEL_MASK		(__GFP_WAIT|__GFP_HIGH|__GFP_IO)
 #define	SLAB_NO_GROW		0x00001000UL	/* don't grow a cache */
 
 /* flags to pass to kmem_cache_create().
--- 2.4.6pre6aa1/mm/vmscan.c.~1~	Sat Jun 30 00:44:36 2001
+++ 2.4.6pre6aa1/mm/vmscan.c	Sat Jun 30 02:21:25 2001
@@ -425,7 +425,6 @@
  */
 #define MAX_LAUNDER 		(4 * (1 << page_cluster))
 #define CAN_DO_IO		(gfp_mask & __GFP_IO)
-#define CAN_DO_BUFFERS		(gfp_mask & __GFP_BUFFER)
 int page_launder(int gfp_mask, int sync)
 {
 	int launder_loop, maxscan, cleaned_pages, maxlaunder;
@@ -613,7 +612,7 @@
 	 * loads, flush out the dirty pages before we have to wait on
 	 * IO.
 	 */
-	if ((CAN_DO_IO || CAN_DO_BUFFERS) && !launder_loop && free_shortage()) {
+	if (CAN_DO_IO && !launder_loop && free_shortage()) {
 		launder_loop = 1;
 		/* If we cleaned pages, never do synchronous IO. */
 		if (cleaned_pages)


However the more finegrined fix that I found in 2.4.7pre2 and 2.4.6
seems broken unlike my above one.

getblk called from the fs calls grow_buffers with GFP_NOFS which doesn't
inhibit shrink_dcache_memory to re-enter the fs in prune_dcache because
__GFP_IO is set. And it will deadlock as usual when shrink_dcache reenter
the fs that way.

This should cure the deadlock (against 2.4.7pre2) but beware it's
untested.

--- 2.4.7pre2aa1/fs/dcache.c.~1~	Thu Jul  5 17:13:50 2001
+++ 2.4.7pre2aa1/fs/dcache.c	Thu Jul  5 18:52:03 2001
@@ -566,7 +566,7 @@
 	 * We should make sure we don't hold the superblock lock over
 	 * block allocations, but for now:
 	 */
-	if (!(gfp_mask & __GFP_IO))
+	if (!(gfp_mask & __GFP_FS))
 		return;
 
 	if (priority)
--- 2.4.7pre2aa1/fs/inode.c.~1~	Thu Jul  5 17:13:48 2001
+++ 2.4.7pre2aa1/fs/inode.c	Thu Jul  5 18:52:08 2001
@@ -696,7 +696,7 @@
 	 * want to recurse into the FS that called us
 	 * in clear_inode() and friends..
 	 */
-	if (!(gfp_mask & __GFP_IO))
+	if (!(gfp_mask & __GFP_FS))
 		return;
 
 	if (priority)


Secondly this cleanups a bit in page_launder. If we are allowed to enter
the FS we can certainly also do I/O.

--- 2.4.7pre2aa1/mm/vmscan.c.~1~	Thu Jul  5 17:13:48 2001
+++ 2.4.7pre2aa1/mm/vmscan.c	Thu Jul  5 18:59:33 2001
@@ -612,7 +612,7 @@
 	 * loads, flush out the dirty pages before we have to wait on
 	 * IO.
 	 */
-	if ((CAN_DO_IO || CAN_DO_FS) && !launder_loop && free_shortage()) {
+	if (CAN_DO_IO && !launder_loop && free_shortage()) {
 		launder_loop = 1;
 		/* If we cleaned pages, never do synchronous IO. */
 		if (cleaned_pages)

I will include them in my next tree as it is at least certainly better
than the previous code.

Andrea
