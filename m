Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269317AbRHEPx2>; Sun, 5 Aug 2001 11:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269969AbRHEPxS>; Sun, 5 Aug 2001 11:53:18 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:46188 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269317AbRHEPxN>; Sun, 5 Aug 2001 11:53:13 -0400
Date: Sun, 5 Aug 2001 17:53:34 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: alloc_skb cannot be called with GFP_DMA
Message-ID: <20010805175334.E21840@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think it's good idea to apply this patch to mainline:

--- 2.4.8pre4aa1/mm/slab.c.~1~	Sun Aug  5 16:46:58 2001
+++ 2.4.8pre4aa1/mm/slab.c	Sun Aug  5 17:44:09 2001
@@ -1172,7 +1172,6 @@
 
 static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
 {
-#if DEBUG
 	if (flags & SLAB_DMA) {
 		if (!(cachep->gfpflags & GFP_DMA))
 			BUG();
@@ -1180,7 +1179,6 @@
 		if (cachep->gfpflags & GFP_DMA)
 			BUG();
 	}
-#endif
 }
 
 static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,


This will trap anybody trying calling alloc_skb using GFP_DMA, that
usage is illegal, it would work by luck only if _everybody_ calling
alloc_skb would be passing GFP_DMA too (because the gfp_mask is passed
to the GFP in order to get right things like GFP_WAIT) which is
obviously not the case as the skb cache is shared by everybody.

Actually such bugcheck is been triggered by an IKD user because IKD
#defines DEBUG, but I think we should enable such bugcheck it in
mainline too because it's too easy to forget about such requirement of
the slab cache.

In order to fix those bugs correctly and avoid memory corruption a new
skbuff_head_cache_isadma skb cache will be needed.

A fast grep revealed a few buggy network drivers already (of course the
bug is going to affect only ISA drivers so it's not a showstopper).

Andrea
