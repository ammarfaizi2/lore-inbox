Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261533AbSIZVPd>; Thu, 26 Sep 2002 17:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261531AbSIZVO1>; Thu, 26 Sep 2002 17:14:27 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:8342 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261529AbSIZVNq>;
	Thu, 26 Sep 2002 17:13:46 -0400
Message-ID: <3D9379C2.1080001@colorfullife.com>
Date: Thu, 26 Sep 2002 23:18:58 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/4.0 (compatible; MSIE 5.5; Windows NT 4.0)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: alloc_skb cannot be called with GFP_DMA
Content-Type: multipart/mixed;
 boundary="------------010908070304080801020709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010908070304080801020709
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[ok, I admit that this doesn't qualify as a timely reply]

Andrea wrote on Sun, 5 Aug 2001 17:53:34 +0200
  >
 > I think it's good idea to apply this patch to mainline:
 >
 > --- 2.4.8pre4aa1/mm/slab.c.~1~ Sun Aug 5 16:46:58 2001
 > +++ 2.4.8pre4aa1/mm/slab.c Sun Aug 5 17:44:09 2001
 > @@ -1172,7 +1172,6 @@
 >
 > static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
 > {
 > -#if DEBUG
 > if (flags & SLAB_DMA) {
 > if (!(cachep->gfpflags & GFP_DMA))
 > BUG();
 > @@ -1180,7 +1179,6 @@
 > if (cachep->gfpflags & GFP_DMA)
 > BUG();
 > }
 > -#endif
 > }
 >
 > static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
 >
 > This will trap anybody trying calling alloc_skb using GFP_DMA, that
 > usage is illegal, it would work by luck only if _everybody_ calling
 > alloc_skb would be passing GFP_DMA too (because the gfp_mask is passed
 > to the GFP in order to get right things like GFP_WAIT) which is
 > obviously not the case as the skb cache is shared by everybody.

If someone calls alloc_skb(GFP_DMA), then he wants the data buffer in
DMA space, noone does DMA to/from the skb structure fields. The right
approach is to mask the GFP_DMA bit before calling
kmem_cache_alloc(skbuff_head_cache), and to forward the bit to the
kmalloc of the skb data buffer. This is in 2.4.20-pre5, the right fix.

The check was indended to catch a feature that is present in the 2.2
slab allocator, but missing in 2.4: In 2.2, it was possible to create a
custom cachep with kmem_cache_create(), and then allocate some objects
with GFP_DMA set, some without GFP_DMA set. The allocator in 2.4/5
doesn't support that anymore.

But something else is wrong in kmem_cache_alloc_head - the common error,
GFP_WAIT allocation from interrupt, is not checked - neither in DEBUG
nor without DEBUG.

What about the attached patch?
- put the GFP_DMA test again under DEBUG: GFP_DMA errors are virtually
impossible by design.
- add an in_interrupt() check into alloc_head()

I've put the in_interrupt() check under DEBUG, too: It's icache
pollution, and the second test in kmem_cache_grow() will catch abusers
sooner or later.

--
	Manfred


--------------010908070304080801020709
Content-Type: text/plain;
 name="patch-slab-debug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-slab-debug"

--- 2.5/mm/slab.c	Sun Sep 22 06:25:17 2002
+++ build-2.5/mm/slab.c	Thu Sep 26 23:02:40 2002
@@ -1259,6 +1259,13 @@
 
 static inline void kmem_cache_alloc_head(kmem_cache_t *cachep, int flags)
 {
+#if DEBUG
+	/* check if someone calls us from interrupt with GFP_WAIT set
+	 * With debug disabled, this only happens in kmem_cache_grow,
+	 * to reduce the critical path length.
+	 */
+	if (in_interrupt() && (flags & __GFP_WAIT))
+		BUG();
 	if (flags & SLAB_DMA) {
 		if (!(cachep->gfpflags & GFP_DMA))
 			BUG();
@@ -1266,6 +1273,7 @@
 		if (cachep->gfpflags & GFP_DMA)
 			BUG();
 	}
+#endif
 }
 
 static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,

--------------010908070304080801020709--

