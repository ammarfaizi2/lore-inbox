Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261721AbULGKso@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261721AbULGKso (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 05:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261769AbULGKso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 05:48:44 -0500
Received: from gate.corvil.net ([213.94.219.177]:13321 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261721AbULGKsV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 05:48:21 -0500
Message-ID: <41B58A58.8010007@draigBrady.com>
Date: Tue, 07 Dec 2004 10:47:52 +0000
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Karsten Desler <kdesler@soohrt.org>
CC: "David S. Miller" <davem@davemloft.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: _High_ CPU usage while routing (mostly) small UDP packets
References: <20041206205305.GA11970@soohrt.org> <20041206134849.498bfc93.davem@davemloft.net> <20041206224107.GA8529@soohrt.org>
In-Reply-To: <20041206224107.GA8529@soohrt.org>
Content-Type: multipart/mixed;
 boundary="------------000001040401020404000706"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000001040401020404000706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Karsten Desler wrote:
> * David S. Miller wrote:
> 
>>It's spending nearly half of it's time in iptables.
>>Try to consolidate your rules if possible.  This is the
>>part of netfilter that really doesn't scale well at all.
>>
> 
> Removing the iptables rules helps reducing the load a little, but the
> majority of time is still spent somewhere else.

Well with NAPI it can be hard to tell CPU usage.
You may need to use something like cyclesoak to get
a true idea of CPU left.

Also have a look at http://www.hipac.org/ as netfilter
has silly scalability properties.

I also notice that a lot of time is spent allocating
and freeing the packet buffers (and possible hidden
time due to cache misses due to allocating on one
CPU and freeing on another?).
How many [RT]xDescriptors do you have configured by the way?

Anyway attached is a small patch that I used to make the e1000
"own" the packet buffers, and hence it does not alloc/free
per packet at all. Now this has only been tested in one
configuration where I was just sniffing the packets, so
definitely YMMV.

-- 
Pádraig Brady - http://www.pixelbeat.org
--

--------------000001040401020404000706
Content-Type: application/x-texinfo;
 name="linux-2.4.20-5.2.52-realloc.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.20-5.2.52-realloc.diff"

diff -Naur linux-2.4.20-5.2.52/drivers/net/e1000/e1000_main.c linux-2.4.20-pb/drivers/net/e1000/e1000_main.c
--- linux-2.4.20-5.2.52/drivers/net/e1000/e1000_main.c	2004-05-17 22:59:53.000000000 +0000
+++ linux-2.4.20-pb/drivers/net/e1000/e1000_main.c	2004-12-07 10:16:16.000000000 +0000
@@ -2319,9 +2323,9 @@
 			E1000_DBG("%s: Receive packet consumed multiple buffers\n",
 				netdev->name);
 
-			dev_kfree_skb_irq(skb);
+			//dev_kfree_skb_irq(skb); //PB
 			rx_desc->status = 0;
-			buffer_info->skb = NULL;
+			//buffer_info->skb = NULL; //PB
 
 			if(++i == rx_ring->count) i = 0;
 
@@ -2347,9 +2351,9 @@
 				length--;
 			} else {
 
-				dev_kfree_skb_irq(skb);
+				//dev_kfree_skb_irq(skb); //PB
 				rx_desc->status = 0;
-				buffer_info->skb = NULL;
+				//buffer_info->skb = NULL; //PB
 
 				if(++i == rx_ring->count) i = 0;
 
@@ -2393,7 +2398,7 @@
 		netdev->last_rx = jiffies;
 
 		rx_desc->status = 0;
-		buffer_info->skb = NULL;
+		//buffer_info->skb = NULL; //PB: E1000 doesn't reallocate packets
 
 		if(++i == rx_ring->count) i = 0;
 
@@ -2421,20 +2426,37 @@
 	struct e1000_rx_desc *rx_desc;
 	struct e1000_buffer *buffer_info;
 	struct sk_buff *skb;
-	int reserve_len = 2;
+	int reserve_len = 18;
 	unsigned int i;
 
 	i = rx_ring->next_to_use;
-	buffer_info = &rx_ring->buffer_info[i];
 
-	while(!buffer_info->skb) {
+	while(1) {
+		buffer_info = &rx_ring->buffer_info[i];
+		if (!buffer_info->skb) {
+			; /* try to allocate new buf */
+		} else {
+			if (!skb_shared(buffer_info->skb)) {
+				; /* try to reallocate unused buf */
+			} else {
+				break; /* Better luck next round */
+			}
+		}
+
 		rx_desc = E1000_RX_DESC(*rx_ring, i);
 
-		skb = dev_alloc_skb(adapter->rx_buffer_len + reserve_len);
+		if (!buffer_info->skb) {
+			/* TODO: optimize this alloc size */
+			skb = alloc_skb(adapter->rx_buffer_len + reserve_len, GFP_ATOMIC);
+		} else {
+			skb = realloc_skb(buffer_info->skb, adapter->rx_buffer_len + reserve_len, GFP_ATOMIC);
+		}
 
 		if(!skb) {
-			/* Better luck next round */
-			break;
+			break; /* Better luck next round */
+		} else {
+			skb->dev = netdev;
+			skb_get(skb); /* It's ours. Don't let others deallocate */
 		}
 
 		/* Make buffer alignment 2 beyond a 16 byte boundary
@@ -2443,8 +2465,6 @@
 		 */
 		skb_reserve(skb, reserve_len);
 
-		skb->dev = netdev;
-
 		buffer_info->skb = skb;
 		buffer_info->length = adapter->rx_buffer_len;
 		buffer_info->dma =
@@ -2466,7 +2486,6 @@
 		}
 
 		if(++i == rx_ring->count) i = 0;
-		buffer_info = &rx_ring->buffer_info[i];
 	}
 
 	rx_ring->next_to_use = i;
diff -Naur linux-2.4.20-5.2.52/include/linux/skbuff.h linux-2.4.20-pb/include/linux/skbuff.h
--- linux-2.4.20-5.2.52/include/linux/skbuff.h	2002-08-03 00:39:46.000000000 +0000
+++ linux-2.4.20-pb/include/linux/skbuff.h	2004-12-07 10:16:16.000000000 +0000
@@ -230,6 +230,7 @@
 
 extern void			__kfree_skb(struct sk_buff *skb);
 extern struct sk_buff *		alloc_skb(unsigned int size, int priority);
+extern struct sk_buff *		realloc_skb(struct sk_buff *skb, unsigned int size, int priority);
 extern void			kfree_skbmem(struct sk_buff *skb);
 extern struct sk_buff *		skb_clone(struct sk_buff *skb, int priority);
 extern struct sk_buff *		skb_copy(const struct sk_buff *skb, int priority);
@@ -240,6 +241,7 @@
 						int newheadroom,
 						int newtailroom,
 						int priority);
+extern struct sk_buff *         skb_pad(struct sk_buff *skb, int pad);
 #define dev_kfree_skb(a)	kfree_skb(a)
 extern void	skb_over_panic(struct sk_buff *skb, int len, void *here);
 extern void	skb_under_panic(struct sk_buff *skb, int len, void *here);
@@ -1082,6 +1084,26 @@
 }
 
 /**
+ *      skb_padto       - pad an skbuff up to a minimal size
+ *      @skb: buffer to pad
+ *      @len: minimal length
+ *
+ *      Pads up a buffer to ensure the trailing bytes exist and are
+ *      blanked. If the buffer already contains sufficient data it
+ *      is untouched. Returns the buffer, which may be a replacement
+ *      for the original, or NULL for out of memory - in which case
+ *      the original buffer is still freed.
+ */
+
+static inline struct sk_buff *skb_padto(struct sk_buff *skb, unsigned int len)
+{
+        unsigned int size = skb->len;
+        if(likely(size >= len))
+                return skb;
+        return skb_pad(skb, len-size);
+}
+
+/**
  *	skb_linearize - convert paged skb to linear one
  *	@skb: buffer to linarize
  *	@gfp: allocation mode
diff -Naur linux-2.4.20-5.2.52/net/core/skbuff.c linux-2.4.20-pb/net/core/skbuff.c
--- linux-2.4.20-5.2.52/net/core/skbuff.c	2002-08-03 00:39:46.000000000 +0000
+++ linux-2.4.20-pb/net/core/skbuff.c	2004-12-07 10:16:16.000000000 +0000
@@ -216,7 +216,6 @@
 	return NULL;
 }
 
-
 /*
  *	Slab constructor for a skb head. 
  */ 
@@ -251,6 +250,59 @@
 #endif
 }
 
+/**
+ *	realloc_skb	-	reset skb for new packet.
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
+
+struct sk_buff *realloc_skb(struct sk_buff* skb, unsigned int size, int gfp_mask)
+{
+	int truesize=skb->truesize;
+	u8 *data=skb->head;
+
+	skb_headerinit(skb, (kmem_cache_t *)NULL, 0);
+
+	/* Get the DATA. Size must match skb_add_mtu(). */
+	size = SKB_DATA_ALIGN(size);
+	if ((size+sizeof(struct sk_buff)) > truesize) {
+	        skb_release_data(skb);
+		data = kmalloc(size + sizeof(struct skb_shared_info), gfp_mask);
+		if (data == NULL)
+			goto nodata;
+	}
+
+	/* XXX: does not include slab overhead */
+	skb->truesize = size + sizeof(struct sk_buff);
+
+	/* Load the data pointers. */
+	skb->head = data;
+	skb->data = data;
+	skb->tail = data;
+	skb->end = data + size;
+
+	/* Set up other state */
+	skb->len = 0;
+	skb->cloned = 0;
+	skb->data_len = 0;
+
+	atomic_set(&skb->users, 1);
+	atomic_set(&(skb_shinfo(skb)->dataref), 1);
+	skb_shinfo(skb)->nr_frags = 0;
+	skb_shinfo(skb)->frag_list = NULL;
+	return skb;
+
+nodata:
+	return NULL;
+}
+
 static void skb_drop_fraglist(struct sk_buff *skb)
 {
 	struct sk_buff *list = skb_shinfo(skb)->frag_list;
@@ -731,6 +783,36 @@
 	return n;
 }
 
+/**
+ *      skb_pad                 -       zero pad the tail of an skb
+ *      @skb: buffer to pad
+ *      @pad: space to pad
+ *
+ *      Ensure that a buffer is followed by a padding area that is zero
+ *      filled. Used by network drivers which may DMA or transfer data
+ *      beyond the buffer end onto the wire.
+ *
+ *      May return NULL in out of memory cases.
+ */
+
+struct sk_buff *skb_pad(struct sk_buff *skb, int pad)
+{
+        struct sk_buff *nskb;
+
+        /* If the skbuff is non linear tailroom is always zero.. */
+        if(skb_tailroom(skb) >= pad)
+        {
+                memset(skb->data+skb->len, 0, pad);
+                return skb;
+        }
+
+        nskb = skb_copy_expand(skb, skb_headroom(skb), skb_tailroom(skb) + pad, GFP_ATOMIC);
+        kfree_skb(skb);
+        if(nskb)
+                memset(nskb->data+nskb->len, 0, pad);
+        return nskb;
+}
+
 /* Trims skb to length len. It can change skb pointers, if "realloc" is 1.
  * If realloc==0 and trimming is impossible without change of data,
  * it is BUG().

--------------000001040401020404000706--
