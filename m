Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261931AbUK3Ccf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261931AbUK3Ccf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 21:32:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261957AbUK3CZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 21:25:26 -0500
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:3545 "EHLO mta1.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S261952AbUK3CQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 21:16:52 -0500
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, Steven.Hand@cl.cam.ac.uk,
       Christian.Limpach@cl.cam.ac.uk, Keir.Fraser@cl.cam.ac.uk, akpm@osdl.org,
       Ian.Pratt@cl.cam.ac.uk
Subject: [6/7] Xen VMM #3: alloc_skb_from_cache	
In-reply-to: Your message of "Tue, 30 Nov 2004 02:03:45 GMT."
             <E1CYxMo-0005GB-00@mta1.cl.cam.ac.uk> 
Date: Tue, 30 Nov 2004 02:16:43 +0000
From: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
Message-Id: <E1CYxZL-0005P6-00@mta1.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[NB: This patch has already been accepted by Dave Miller. I'm
only resending it such that the set is complete.]

This patch adds a new alloc_skb_from_cache function. This serves two
purposes: firstly, we like to allocate skb's with page-sized data
fragements as this means we can do zero-copy transfer of network
buffers between guest operating systems. Secondly, it enables us to
have a cache of pages that have been used for network buffers that we
can be more lax about scrubbing when they change VM ownership (since
they could be sniffed on the wire).

Signed-off-by: ian.pratt@cl.cam.ac.uk

---
diff -Nurp pristine-linux-2.6.10-rc2/net/core/skbuff.c tmp-linux-2.6.10-rc2-xen.patch/net/core/skbuff.c
--- pristine-linux-2.6.10-rc2/net/core/skbuff.c	2004-11-30 01:20:26.000000000 +0000
+++ tmp-linux-2.6.10-rc2-xen.patch/net/core/skbuff.c	2004-11-30 00:41:24.000000000 +0000
@@ -163,6 +163,59 @@ nodata:
 	goto out;
 }
 
+/**
+ *	alloc_skb_from_cache	-	allocate a network buffer
+ *	@cp: kmem_cache from which to allocate the data area
+ *	     (object size must be big enough for @size bytes + skb overheads)
+ *	@size: size to allocate
+ *	@gfp_mask: allocation mask
+ *
+ *	Allocate a new &sk_buff. The returned buffer has no headroom and a
+ *	tail room of size bytes. The object has a reference count of one.
+ *	The return is the buffer. On a failure the return is %NULL.
+ *
+ *	Buffers may only be allocated from interrupts using a @gfp_mask of
+ *	%GFP_ATOMIC.
+ */
+struct sk_buff *alloc_skb_from_cache(kmem_cache_t *cp,
+				     unsigned int size, int gfp_mask)
+{
+	struct sk_buff *skb;
+	u8 *data;
+
+	/* Get the HEAD */
+	skb = kmem_cache_alloc(skbuff_head_cache,
+			       gfp_mask & ~__GFP_DMA);
+	if (!skb)
+		goto out;
+
+	/* Get the DATA. */
+	size = SKB_DATA_ALIGN(size);
+	data = kmem_cache_alloc(cp, gfp_mask);
+	if (!data)
+		goto nodata;
+
+	memset(skb, 0, offsetof(struct sk_buff, truesize));
+	skb->truesize = size + sizeof(struct sk_buff);
+	atomic_set(&skb->users, 1);
+	skb->head = data;
+	skb->data = data;
+	skb->tail = data;
+	skb->end  = data + size;
+
+	atomic_set(&(skb_shinfo(skb)->dataref), 1);
+	skb_shinfo(skb)->nr_frags  = 0;
+	skb_shinfo(skb)->tso_size = 0;
+	skb_shinfo(skb)->tso_segs = 0;
+	skb_shinfo(skb)->frag_list = NULL;
+out:
+	return skb;
+nodata:
+	kmem_cache_free(skbuff_head_cache, skb);
+	skb = NULL;
+	goto out;
+}
+
 
 static void skb_drop_fraglist(struct sk_buff *skb)
 {
diff -Nurp pristine-linux-2.6.10-rc2/include/linux/skbuff.h tmp-linux-2.6.10-rc2-xen.patch/include/linux/skbuff.h
--- pristine-linux-2.6.10-rc2/include/linux/skbuff.h	2004-10-18 22:55:36.000000000 +0100
+++ tmp-linux-2.6.10-rc2-xen.patch/include/linux/skbuff.h	2004-11-30 00:41:24.000000000 +0000
@@ -292,6 +292,8 @@ struct sk_buff {
 
 extern void	       __kfree_skb(struct sk_buff *skb);
 extern struct sk_buff *alloc_skb(unsigned int size, int priority);
+extern struct sk_buff *alloc_skb_from_cache(kmem_cache_t *cp,
+					    unsigned int size, int priority);
 extern void	       kfree_skbmem(struct sk_buff *skb);
 extern struct sk_buff *skb_clone(struct sk_buff *skb, int priority);
 extern struct sk_buff *skb_copy(const struct sk_buff *skb, int priority);
@@ -935,6 +937,7 @@ static inline void __skb_queue_purge(str
  *
  *	%NULL is returned in there is no free memory.
  */
+#ifndef CONFIG_HAVE_ARCH_DEV_ALLOC_SKB
 static inline struct sk_buff *__dev_alloc_skb(unsigned int length,
 					      int gfp_mask)
 {
@@ -943,6 +946,9 @@ static inline struct sk_buff *__dev_allo
 		skb_reserve(skb, 16);
 	return skb;
 }
+#else
+extern struct sk_buff *__dev_alloc_skb(unsigned int length, int gfp_mask);
+#endif
 
 /**
  *	dev_alloc_skb - allocate an skbuff for sending
