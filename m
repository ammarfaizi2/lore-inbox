Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751304AbWEHWQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbWEHWQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWEHWPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:15:44 -0400
Received: from [63.64.152.142] ([63.64.152.142]:22533 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751304AbWEHWNO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:13:14 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 5/9] [I/OAT] Structure changes for TCP recv offload to I/OAT
Date: Mon, 08 May 2006 15:17:42 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060508221741.15181.30220.stgit@gitlost.site>
In-Reply-To: <20060508221632.15181.50046.stgit@gitlost.site>
References: <20060508221632.15181.50046.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds an async_wait_queue and some additional fields to tcp_sock, and a
dma_cookie_t to sk_buff.

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 include/linux/skbuff.h |    4 ++++
 include/linux/tcp.h    |    8 ++++++++
 include/net/sock.h     |    2 ++
 include/net/tcp.h      |    7 +++++++
 net/core/sock.c        |    6 ++++++
 5 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f8f2347..23bad3b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -29,6 +29,7 @@
 #include <linux/net.h>
 #include <linux/textsearch.h>
 #include <net/checksum.h>
+#include <linux/dmaengine.h>
 
 #define HAVE_ALLOC_SKB		/* For the drivers to know */
 #define HAVE_ALIGNABLE_SKB	/* Ditto 8)		   */
@@ -285,6 +286,9 @@ struct sk_buff {
 	__u16			tc_verd;	/* traffic control verdict */
 #endif
 #endif
+#ifdef CONFIG_NET_DMA
+	dma_cookie_t		dma_cookie;
+#endif
 
 
 	/* These elements must be at the end, see alloc_skb() for details.  */
diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 542d395..c90daa5 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -18,6 +18,7 @@
 #define _LINUX_TCP_H
 
 #include <linux/types.h>
+#include <linux/dmaengine.h>
 #include <asm/byteorder.h>
 
 struct tcphdr {
@@ -233,6 +234,13 @@ struct tcp_sock {
 		struct iovec		*iov;
 		int			memory;
 		int			len;
+#ifdef CONFIG_NET_DMA
+		/* members for async copy */
+		struct dma_chan		*dma_chan;
+		int			wakeup;
+		struct dma_pinned_list	*pinned_list;
+		dma_cookie_t		dma_cookie;
+#endif
 	} ucopy;
 
 	__u32	snd_wl1;	/* Sequence for window update		*/
diff --git a/include/net/sock.h b/include/net/sock.h
index c9fad6f..90c65cb 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -132,6 +132,7 @@ struct sock_common {
   *	@sk_receive_queue: incoming packets
   *	@sk_wmem_alloc: transmit queue bytes committed
   *	@sk_write_queue: Packet sending queue
+  *	@sk_async_wait_queue: DMA copied packets
   *	@sk_omem_alloc: "o" is "option" or "other"
   *	@sk_wmem_queued: persistent queue size
   *	@sk_forward_alloc: space allocated forward
@@ -205,6 +206,7 @@ struct sock {
 	atomic_t		sk_omem_alloc;
 	struct sk_buff_head	sk_receive_queue;
 	struct sk_buff_head	sk_write_queue;
+	struct sk_buff_head	sk_async_wait_queue;
 	int			sk_wmem_queued;
 	int			sk_forward_alloc;
 	gfp_t			sk_allocation;
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 3c989db..d0c2c2f 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -28,6 +28,7 @@
 #include <linux/cache.h>
 #include <linux/percpu.h>
 #include <linux/skbuff.h>
+#include <linux/dmaengine.h>
 
 #include <net/inet_connection_sock.h>
 #include <net/inet_timewait_sock.h>
@@ -817,6 +818,12 @@ static inline void tcp_prequeue_init(str
 	tp->ucopy.len = 0;
 	tp->ucopy.memory = 0;
 	skb_queue_head_init(&tp->ucopy.prequeue);
+#ifdef CONFIG_NET_DMA
+	tp->ucopy.dma_chan = NULL;
+	tp->ucopy.wakeup = 0;
+	tp->ucopy.pinned_list = NULL;
+	tp->ucopy.dma_cookie = 0;
+#endif
 }
 
 /* Packet is added to VJ-style prequeue for processing in process
diff --git a/net/core/sock.c b/net/core/sock.c
index ed2afdb..5d820c3 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -832,6 +832,9 @@ struct sock *sk_clone(const struct sock 
 		atomic_set(&newsk->sk_omem_alloc, 0);
 		skb_queue_head_init(&newsk->sk_receive_queue);
 		skb_queue_head_init(&newsk->sk_write_queue);
+#ifdef CONFIG_NET_DMA
+		skb_queue_head_init(&newsk->sk_async_wait_queue);
+#endif
 
 		rwlock_init(&newsk->sk_dst_lock);
 		rwlock_init(&newsk->sk_callback_lock);
@@ -1383,6 +1386,9 @@ void sock_init_data(struct socket *sock,
 	skb_queue_head_init(&sk->sk_receive_queue);
 	skb_queue_head_init(&sk->sk_write_queue);
 	skb_queue_head_init(&sk->sk_error_queue);
+#ifdef CONFIG_NET_DMA
+	skb_queue_head_init(&sk->sk_async_wait_queue);
+#endif
 
 	sk->sk_send_head	=	NULL;
 

