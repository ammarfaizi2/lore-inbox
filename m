Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269987AbRHESiG>; Sun, 5 Aug 2001 14:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269986AbRHESh5>; Sun, 5 Aug 2001 14:37:57 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:33142 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S269987AbRHEShl>; Sun, 5 Aug 2001 14:37:41 -0400
Date: Sun, 5 Aug 2001 20:38:10 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: kuznet@ms2.inr.ac.ru
Cc: Dave Miller <davem@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: alloc_skb cannot be called with GFP_DMA
Message-ID: <20010805203810.K21840@athlon.random>
In-Reply-To: <20010805181606.F21840@athlon.random> <200108051718.VAA17521@ms2.inr.ac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200108051718.VAA17521@ms2.inr.ac.ru>; from kuznet@ms2.inr.ac.ru on Sun, Aug 05, 2001 at 09:18:11PM +0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 05, 2001 at 09:18:11PM +0400, kuznet@ms2.inr.ac.ru wrote:
> Hello!
> 
> > alloc_isa_skb will avoid to slowdown alloc_skb so I prefer it compared
> > to hiding the logic inside alloc_skb.
> 
> Stop! This is redundant. GFP_DMA is for skb data, not head!
> 
> So that, it is enough and right to clear GFP_DMA inside
> alloc_skb when allocating skb head.

ah it's all metadata, so this should fix it (the bugcheck will still
trap any skb_clone caller that uses GFP_DMA because it doesn't make
sense to call skb_clone with GFP_DMA):

--- 2.4.8pre4aa1/net/core/skbuff.c.~1~	Sat Jul 21 00:04:34 2001
+++ 2.4.8pre4aa1/net/core/skbuff.c	Sun Aug  5 20:30:00 2001
@@ -180,7 +180,7 @@
 	/* Get the HEAD */
 	skb = skb_head_from_pool();
 	if (skb == NULL) {
-		skb = kmem_cache_alloc(skbuff_head_cache, gfp_mask);
+		skb = kmem_cache_alloc(skbuff_head_cache, gfp_mask & ~__GFP_DMA);
 		if (skb == NULL)
 			goto nohead;
 	}

Andrea
