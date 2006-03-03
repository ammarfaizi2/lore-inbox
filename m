Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751599AbWCCVl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751599AbWCCVl5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 16:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751609AbWCCVl4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 16:41:56 -0500
Received: from [198.78.49.142] ([198.78.49.142]:53764 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751528AbWCCVk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 16:40:28 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 8/8] [I/OAT] TCP recv offload to I/OAT
Date: Fri, 03 Mar 2006 13:42:36 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060303214236.11908.98881.stgit@gitlost.site>
In-Reply-To: <20060303214036.11908.10499.stgit@gitlost.site>
References: <20060303214036.11908.10499.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Locks down user pages and sets up for DMA in tcp_recvmsg, then calls
dma_async_try_early_copy in tcp_v4_do_rcv

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 include/net/netdma.h |    1 
 net/ipv4/tcp.c       |  111 +++++++++++++++++++++++++++++++++++++++++++++-----
 net/ipv4/tcp_input.c |   78 ++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_ipv4.c  |   20 +++++++++
 net/ipv6/tcp_ipv6.c  |   12 +++++
 5 files changed, 201 insertions(+), 21 deletions(-)

diff --git a/include/net/netdma.h b/include/net/netdma.h
index 415d74c..2d829e1 100644
--- a/include/net/netdma.h
+++ b/include/net/netdma.h
@@ -37,5 +37,6 @@ static inline struct dma_chan *get_softn
 int dma_skb_copy_datagram_iovec(struct dma_chan* chan,
 		const struct sk_buff *skb, int offset, struct iovec *to,
 		size_t len, struct dma_locked_list *locked_list);
+int dma_async_try_early_copy(struct sock *sk, struct sk_buff *skb, int hlen);
 
 #endif /* NETDMA_H */
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 13abfa2..b792048 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -262,6 +262,9 @@
 #include <net/tcp.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
+#ifdef CONFIG_NET_DMA
+#include <net/netdma.h>
+#endif
 
 
 #include <asm/uaccess.h>
@@ -1109,6 +1112,7 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 	int target;		/* Read at least this many bytes */
 	long timeo;
 	struct task_struct *user_recv = NULL;
+	int copied_early = 0;
 
 	lock_sock(sk);
 
@@ -1132,6 +1136,12 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 
+#ifdef CONFIG_NET_DMA
+	tp->ucopy.dma_chan = NULL;
+	if ((len > sysctl_tcp_dma_copybreak) && !(flags & MSG_PEEK) && !sysctl_tcp_low_latency && __get_cpu_var(softnet_data.net_dma))
+		dma_lock_iovec_pages(msg->msg_iov, len, &tp->ucopy.locked_list);
+#endif
+
 	do {
 		struct sk_buff *skb;
 		u32 offset;
@@ -1273,6 +1283,10 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 		} else
 			sk_wait_data(sk, &timeo);
 
+#ifdef CONFIG_NET_DMA
+		tp->ucopy.wakeup = 0;
+#endif
+
 		if (user_recv) {
 			int chunk;
 
@@ -1328,13 +1342,39 @@ do_prequeue:
 		}
 
 		if (!(flags & MSG_TRUNC)) {
-			err = skb_copy_datagram_iovec(skb, offset,
-						      msg->msg_iov, used);
-			if (err) {
-				/* Exception. Bailout! */
-				if (!copied)
-					copied = -EFAULT;
-				break;
+#ifdef CONFIG_NET_DMA
+			if (!tp->ucopy.dma_chan && tp->ucopy.locked_list)
+				tp->ucopy.dma_chan = get_softnet_dma();
+
+			if (tp->ucopy.dma_chan) {
+				tp->ucopy.dma_cookie = dma_skb_copy_datagram_iovec(
+					tp->ucopy.dma_chan, skb, offset,
+					msg->msg_iov, used,
+					tp->ucopy.locked_list);
+
+				if (tp->ucopy.dma_cookie < 0) {
+
+					printk(KERN_ALERT "dma_cookie < 0\n");
+
+					/* Exception. Bailout! */
+					if (!copied)
+						copied = -EFAULT;
+					break;
+				}
+				if ((offset + used) == skb->len)
+					copied_early = 1;
+
+			} else
+#endif
+			{
+				err = skb_copy_datagram_iovec(skb, offset,
+						msg->msg_iov, used);
+				if (err) {
+					/* Exception. Bailout! */
+					if (!copied)
+						copied = -EFAULT;
+					break;
+				}
 			}
 		}
 
@@ -1354,15 +1394,33 @@ skip_copy:
 
 		if (skb->h.th->fin)
 			goto found_fin_ok;
-		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb);
+		if (!(flags & MSG_PEEK)) {
+			if (!copied_early)
+				sk_eat_skb(sk, skb);
+#ifdef CONFIG_NET_DMA
+			else {
+				__skb_unlink(skb, &sk->sk_receive_queue);
+				__skb_queue_tail(&sk->sk_async_wait_queue, skb);
+				copied_early = 0;
+			}
+#endif
+		}
 		continue;
 
 	found_fin_ok:
 		/* Process the FIN. */
 		++*seq;
-		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb);
+		if (!(flags & MSG_PEEK)) {
+			if (!copied_early)
+				sk_eat_skb(sk, skb);
+#ifdef CONFIG_NET_DMA
+			else {
+				__skb_unlink(skb, &sk->sk_receive_queue);
+				__skb_queue_tail(&sk->sk_async_wait_queue, skb);
+				copied_early = 0;
+			}
+#endif
+		}
 		break;
 	} while (len > 0);
 
@@ -1385,6 +1443,34 @@ skip_copy:
 		tp->ucopy.len = 0;
 	}
 
+#ifdef CONFIG_NET_DMA
+	if (tp->ucopy.dma_chan) {
+		struct sk_buff *skb;
+		dma_cookie_t done, used;
+
+		dma_async_memcpy_issue_pending(tp->ucopy.dma_chan);
+
+		while (dma_async_memcpy_complete(tp->ucopy.dma_chan,
+		                                 tp->ucopy.dma_cookie, &done,
+		                                 &used) == DMA_IN_PROGRESS) {
+			/* do partial cleanup of sk_async_wait_queue */
+			while ((skb = skb_peek(&sk->sk_async_wait_queue)) &&
+			       (dma_async_is_complete(skb->dma_cookie, done,
+			                              used) == DMA_SUCCESS)) {
+				__skb_dequeue(&sk->sk_async_wait_queue);
+				kfree_skb(skb);
+			}
+		}
+
+		/* Safe to free early-copied skbs now */
+		__skb_queue_purge(&sk->sk_async_wait_queue);
+		dma_unlock_iovec_pages(tp->ucopy.locked_list);
+		dma_chan_put(tp->ucopy.dma_chan);
+		tp->ucopy.dma_chan = NULL;
+		tp->ucopy.locked_list = NULL;
+	}
+#endif
+
 	/* According to UNIX98, msg_name/msg_namelen are ignored
 	 * on connected socket. I was just happy when found this 8) --ANK
 	 */
@@ -1652,6 +1738,9 @@ int tcp_disconnect(struct sock *sk, int 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	sk_stream_writequeue_purge(sk);
 	__skb_queue_purge(&tp->out_of_order_queue);
+#ifdef CONFIG_NET_DMA
+	__skb_queue_purge(&sk->sk_async_wait_queue);
+#endif
 
 	inet->dport = 0;
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 7625eaf..9b6290d 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -71,6 +71,9 @@
 #include <net/inet_common.h>
 #include <linux/ipsec.h>
 #include <asm/unaligned.h>
+#ifdef CONFIG_NET_DMA
+#include <net/netdma.h>
+#endif
 
 int sysctl_tcp_timestamps = 1;
 int sysctl_tcp_window_scaling = 1;
@@ -3901,14 +3904,23 @@ int tcp_rcv_established(struct sock *sk,
 			}
 		} else {
 			int eaten = 0;
+			int copied_early = 0;
 
-			if (tp->ucopy.task == current &&
-			    tp->copied_seq == tp->rcv_nxt &&
-			    len - tcp_header_len <= tp->ucopy.len &&
-			    sock_owned_by_user(sk)) {
-				__set_current_state(TASK_RUNNING);
+			if (tp->copied_seq == tp->rcv_nxt &&
+			    len - tcp_header_len <= tp->ucopy.len) {
+#ifdef CONFIG_NET_DMA
+				if (dma_async_try_early_copy(sk, skb, tcp_header_len)) {
+					copied_early = 1;
+					eaten = 1;
+				}
+#endif
+				if (tp->ucopy.task == current && sock_owned_by_user(sk) && !copied_early) {
+					__set_current_state(TASK_RUNNING);
 
-				if (!tcp_copy_to_iovec(sk, skb, tcp_header_len)) {
+					if (!tcp_copy_to_iovec(sk, skb, tcp_header_len))
+						eaten = 1;
+				}
+				if (eaten) {
 					/* Predicted packet is in window by definition.
 					 * seq == rcv_nxt and rcv_wup <= rcv_nxt.
 					 * Hence, check seq<=rcv_wup reduces to:
@@ -3924,8 +3936,9 @@ int tcp_rcv_established(struct sock *sk,
 					__skb_pull(skb, tcp_header_len);
 					tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
 					NET_INC_STATS_BH(LINUX_MIB_TCPHPHITSTOUSER);
-					eaten = 1;
 				}
+				if (copied_early)
+					tcp_cleanup_rbuf(sk, skb->len);
 			}
 			if (!eaten) {
 				if (tcp_checksum_complete_user(sk, skb))
@@ -3966,6 +3979,11 @@ int tcp_rcv_established(struct sock *sk,
 
 			__tcp_ack_snd_check(sk, 0);
 no_ack:
+#ifdef CONFIG_NET_DMA
+			if (copied_early)
+				__skb_queue_tail(&sk->sk_async_wait_queue, skb);
+			else
+#endif
 			if (eaten)
 				__kfree_skb(skb);
 			else
@@ -4049,6 +4067,52 @@ discard:
 	return 0;
 }
 
+#ifdef CONFIG_NET_DMA
+int dma_async_try_early_copy(struct sock *sk, struct sk_buff *skb, int hlen)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int chunk = skb->len - hlen;
+	int dma_cookie;
+	int copied_early = 0;
+
+	if (tp->ucopy.wakeup)
+          	goto out;
+
+	if (!tp->ucopy.dma_chan && tp->ucopy.locked_list)
+		tp->ucopy.dma_chan = get_softnet_dma();
+
+	if (tp->ucopy.dma_chan && skb->ip_summed == CHECKSUM_UNNECESSARY) {
+
+		dma_cookie = dma_skb_copy_datagram_iovec(tp->ucopy.dma_chan,
+			skb, hlen, tp->ucopy.iov, chunk, tp->ucopy.locked_list);
+
+		if (dma_cookie < 0)
+			goto out;
+
+		tp->ucopy.dma_cookie = dma_cookie;
+		copied_early = 1;
+
+		tp->ucopy.len -= chunk;
+		tp->copied_seq += chunk;
+		tcp_rcv_space_adjust(sk);
+
+		if ((tp->ucopy.len == 0) ||
+		    (tcp_flag_word(skb->h.th) & TCP_FLAG_PSH) ||
+		    (atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1))) {
+			tp->ucopy.wakeup = 1;
+			sk->sk_data_ready(sk, 0);
+		}
+	} else if (chunk > 0) {
+		tp->ucopy.wakeup = 1;
+		sk->sk_data_ready(sk, 0);
+	}
+out:
+	return copied_early;
+}
+
+EXPORT_SYMBOL(dma_async_try_early_copy);
+#endif /* CONFIG_NET_DMA */
+
 static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 					 struct tcphdr *th, unsigned len)
 {
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 4eb903d..fecc022 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -71,6 +71,9 @@
 #include <net/inet_common.h>
 #include <net/timewait_sock.h>
 #include <net/xfrm.h>
+#ifdef CONFIG_NET_DMA
+#include <net/netdma.h>
+#endif
 
 #include <linux/inet.h>
 #include <linux/ipv6.h>
@@ -1091,8 +1094,18 @@ process:
 	bh_lock_sock(sk);
 	ret = 0;
 	if (!sock_owned_by_user(sk)) {
-		if (!tcp_prequeue(sk, skb))
+#ifdef CONFIG_NET_DMA
+		struct tcp_sock *tp = tcp_sk(sk);
+		if (!tp->ucopy.dma_chan && tp->ucopy.locked_list)
+			tp->ucopy.dma_chan = get_softnet_dma();
+		if (tp->ucopy.dma_chan)
+			ret = tcp_v4_do_rcv(sk, skb);
+		else
+#endif
+		{
+			if (!tcp_prequeue(sk, skb))
 			ret = tcp_v4_do_rcv(sk, skb);
+		}
 	} else
 		sk_add_backlog(sk, skb);
 	bh_unlock_sock(sk);
@@ -1292,6 +1305,11 @@ int tcp_v4_destroy_sock(struct sock *sk)
 	/* Cleans up our, hopefully empty, out_of_order_queue. */
   	__skb_queue_purge(&tp->out_of_order_queue);
 
+#ifdef CONFIG_NET_DMA
+	/* Cleans up our sk_async_wait_queue */
+  	__skb_queue_purge(&sk->sk_async_wait_queue);
+#endif
+
 	/* Clean prequeue, it must be empty really */
 	__skb_queue_purge(&tp->ucopy.prequeue);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index af6a0c6..acf798c 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1218,8 +1218,16 @@ process:
 	bh_lock_sock(sk);
 	ret = 0;
 	if (!sock_owned_by_user(sk)) {
-		if (!tcp_prequeue(sk, skb))
-			ret = tcp_v6_do_rcv(sk, skb);
+#ifdef CONFIG_NET_DMA
+                struct tcp_sock *tp = tcp_sk(sk);
+                if (tp->ucopy.dma_chan)
+                        ret = tcp_v6_do_rcv(sk, skb);
+                else
+#endif
+		{
+			if (!tcp_prequeue(sk, skb))
+				ret = tcp_v6_do_rcv(sk, skb);
+		}
 	} else
 		sk_add_backlog(sk, skb);
 	bh_unlock_sock(sk);

