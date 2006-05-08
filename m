Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751316AbWEHWPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbWEHWPQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 18:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWEHWNt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 18:13:49 -0400
Received: from [63.64.152.142] ([63.64.152.142]:25605 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1751308AbWEHWNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 18:13:19 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 9/9] [I/OAT] TCP recv offload to I/OAT
Date: Mon, 08 May 2006 15:17:47 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060508221747.15181.71059.stgit@gitlost.site>
In-Reply-To: <20060508221632.15181.50046.stgit@gitlost.site>
References: <20060508221632.15181.50046.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Locks down user pages and sets up for DMA in tcp_recvmsg, then calls
dma_async_try_early_copy in tcp_v4_do_rcv

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 net/ipv4/tcp.c       |  103 ++++++++++++++++++++++++++++++++++++++++++++------
 net/ipv4/tcp_input.c |   74 +++++++++++++++++++++++++++++++++---
 net/ipv4/tcp_ipv4.c  |   18 ++++++++-
 net/ipv6/tcp_ipv6.c  |   12 +++++-
 4 files changed, 185 insertions(+), 22 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4e067d2..ff6ccda 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -263,7 +263,7 @@
 #include <net/tcp.h>
 #include <net/xfrm.h>
 #include <net/ip.h>
-
+#include <net/netdma.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -1110,6 +1110,7 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 	int target;		/* Read at least this many bytes */
 	long timeo;
 	struct task_struct *user_recv = NULL;
+	int copied_early = 0;
 
 	lock_sock(sk);
 
@@ -1133,6 +1134,17 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 
+#ifdef CONFIG_NET_DMA
+	tp->ucopy.dma_chan = NULL;
+	preempt_disable();
+	if ((len > sysctl_tcp_dma_copybreak) && !(flags & MSG_PEEK) &&
+	    !sysctl_tcp_low_latency && __get_cpu_var(softnet_data.net_dma)) {
+		preempt_enable_no_resched();
+		tp->ucopy.pinned_list = dma_pin_iovec_pages(msg->msg_iov, len);
+	} else
+		preempt_enable_no_resched();
+#endif
+
 	do {
 		struct sk_buff *skb;
 		u32 offset;
@@ -1274,6 +1286,10 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 		} else
 			sk_wait_data(sk, &timeo);
 
+#ifdef CONFIG_NET_DMA
+		tp->ucopy.wakeup = 0;
+#endif
+
 		if (user_recv) {
 			int chunk;
 
@@ -1329,13 +1345,39 @@ do_prequeue:
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
+			if (!tp->ucopy.dma_chan && tp->ucopy.pinned_list)
+				tp->ucopy.dma_chan = get_softnet_dma();
+
+			if (tp->ucopy.dma_chan) {
+				tp->ucopy.dma_cookie = dma_skb_copy_datagram_iovec(
+					tp->ucopy.dma_chan, skb, offset,
+					msg->msg_iov, used,
+					tp->ucopy.pinned_list);
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
 
@@ -1355,15 +1397,19 @@ skip_copy:
 
 		if (skb->h.th->fin)
 			goto found_fin_ok;
-		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb, 0);
+		if (!(flags & MSG_PEEK)) {
+			sk_eat_skb(sk, skb, copied_early);
+			copied_early = 0;
+		}
 		continue;
 
 	found_fin_ok:
 		/* Process the FIN. */
 		++*seq;
-		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb, 0);
+		if (!(flags & MSG_PEEK)) {
+			sk_eat_skb(sk, skb, copied_early);
+			copied_early = 0;
+		}
 		break;
 	} while (len > 0);
 
@@ -1386,6 +1432,36 @@ skip_copy:
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
+		dma_chan_put(tp->ucopy.dma_chan);
+		tp->ucopy.dma_chan = NULL;
+	}
+	if (tp->ucopy.pinned_list) {
+		dma_unpin_iovec_pages(tp->ucopy.pinned_list);
+		tp->ucopy.pinned_list = NULL;
+	}
+#endif
+
 	/* According to UNIX98, msg_name/msg_namelen are ignored
 	 * on connected socket. I was just happy when found this 8) --ANK
 	 */
@@ -1658,6 +1734,9 @@ int tcp_disconnect(struct sock *sk, int 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	sk_stream_writequeue_purge(sk);
 	__skb_queue_purge(&tp->out_of_order_queue);
+#ifdef CONFIG_NET_DMA
+	__skb_queue_purge(&sk->sk_async_wait_queue);
+#endif
 
 	inet->dport = 0;
 
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 9f0cca4..05c4c15 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -71,6 +71,7 @@
 #include <net/inet_common.h>
 #include <linux/ipsec.h>
 #include <asm/unaligned.h>
+#include <net/netdma.h>
 
 int sysctl_tcp_timestamps = 1;
 int sysctl_tcp_window_scaling = 1;
@@ -3785,6 +3786,50 @@ static inline int tcp_checksum_complete_
 		__tcp_checksum_complete_user(sk, skb);
 }
 
+#ifdef CONFIG_NET_DMA
+static int tcp_dma_try_early_copy(struct sock *sk, struct sk_buff *skb, int hlen)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int chunk = skb->len - hlen;
+	int dma_cookie;
+	int copied_early = 0;
+
+	if (tp->ucopy.wakeup)
+          	return 0;
+
+	if (!tp->ucopy.dma_chan && tp->ucopy.pinned_list)
+		tp->ucopy.dma_chan = get_softnet_dma();
+
+	if (tp->ucopy.dma_chan && skb->ip_summed == CHECKSUM_UNNECESSARY) {
+
+		dma_cookie = dma_skb_copy_datagram_iovec(tp->ucopy.dma_chan,
+			skb, hlen, tp->ucopy.iov, chunk, tp->ucopy.pinned_list);
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
+#endif /* CONFIG_NET_DMA */
+
 /*
  *	TCP receive function for the ESTABLISHED state. 
  *
@@ -3901,14 +3946,23 @@ int tcp_rcv_established(struct sock *sk,
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
+				if (tcp_dma_try_early_copy(sk, skb, tcp_header_len)) {
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
@@ -3924,8 +3978,9 @@ int tcp_rcv_established(struct sock *sk,
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
@@ -3966,6 +4021,11 @@ int tcp_rcv_established(struct sock *sk,
 
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
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 672950e..25ecc6e 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -71,6 +71,7 @@
 #include <net/inet_common.h>
 #include <net/timewait_sock.h>
 #include <net/xfrm.h>
+#include <net/netdma.h>
 
 #include <linux/inet.h>
 #include <linux/ipv6.h>
@@ -1091,8 +1092,18 @@ process:
 	bh_lock_sock(sk);
 	ret = 0;
 	if (!sock_owned_by_user(sk)) {
-		if (!tcp_prequeue(sk, skb))
+#ifdef CONFIG_NET_DMA
+		struct tcp_sock *tp = tcp_sk(sk);
+		if (!tp->ucopy.dma_chan && tp->ucopy.pinned_list)
+			tp->ucopy.dma_chan = get_softnet_dma();
+		if (tp->ucopy.dma_chan)
 			ret = tcp_v4_do_rcv(sk, skb);
+		else
+#endif
+		{
+			if (!tcp_prequeue(sk, skb))
+			ret = tcp_v4_do_rcv(sk, skb);
+		}
 	} else
 		sk_add_backlog(sk, skb);
 	bh_unlock_sock(sk);
@@ -1296,6 +1307,11 @@ int tcp_v4_destroy_sock(struct sock *sk)
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
index 301eee7..a50eb30 100644
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

