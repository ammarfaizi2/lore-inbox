Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbVLUFSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbVLUFSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbVLUFSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:18:06 -0500
Received: from fmr19.intel.com ([134.134.136.18]:29655 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751120AbVLUFRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:17:51 -0500
Subject: [RFC][PATCH 5/5] I/OAT DMA support and TCP acceleration
From: Chris Leech <christopher.leech@intel.com>
To: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 21:17:46 -0800
Message-Id: <1135142266.13781.22.camel@cleech-mobl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
X-OriginalArrivalTime: 21 Dec 2005 05:17:49.0528 (UTC) FILETIME=[E2B10D80:01C605ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

TCP recv offload to I/OAT

Locks down user pages and sets up for the DMA in tcp_recvmsg, then calls
dma_async_try_early_copy in tcp_v4_do_rcv

---
 tcp.c       |  166 +++++++++++++++++++++++++++++++++++++++++++++---------------
 tcp_input.c |   63 +++++++++++++++++++++-
 tcp_ipv4.c  |   16 +++++
 3 files changed, 202 insertions(+), 43 deletions(-)

diff -rup a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c	2005-12-21 12:10:49.000000000 -0800
+++ b/net/ipv4/tcp.c	2005-12-21 12:14:42.000000000 -0800
@@ -257,6 +257,7 @@
 #include <linux/fs.h>
 #include <linux/random.h>
 #include <linux/bootmem.h>
+#include <linux/dmaengine.h>
 
 #include <net/icmp.h>
 #include <net/tcp.h>
@@ -941,7 +942,7 @@ void tcp_cleanup_rbuf(struct sock *sk, i
 	struct tcp_sock *tp = tcp_sk(sk);
 	int time_to_ack = 0;
 
-#if TCP_DEBUG
+#if TCP_DEBUG && !defined(CONFIG_NET_DMA)
 	struct sk_buff *skb = skb_peek(&sk->sk_receive_queue);
 
 	BUG_TRAP(!skb || before(tp->copied_seq, TCP_SKB_CB(skb)->end_seq));
@@ -1132,6 +1133,21 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 
 	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 
+#ifdef CONFIG_NET_DMA
+	if ((len > 1024) && !(flags & MSG_PEEK) && !sysctl_tcp_low_latency) {
+		preempt_disable();
+		tp->ucopy.dma_chan = __get_cpu_var(net_dma);
+		preempt_enable();
+	} else {
+		tp->ucopy.dma_chan = NULL;
+	}
+
+	if (tp->ucopy.dma_chan)
+		if (dma_lock_iovec_pages(msg->msg_iov, len,
+		                         &tp->ucopy.locked_list))
+			tp->ucopy.dma_chan = NULL;
+#endif
+
 	do {
 		struct sk_buff *skb;
 		u32 offset;
@@ -1161,7 +1177,12 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 				       "seq %X\n", *seq, TCP_SKB_CB(skb)->seq);
 				break;
 			}
-			offset = *seq - TCP_SKB_CB(skb)->seq;
+
+			if (!skb->copied_early)
+				offset = *seq - TCP_SKB_CB(skb)->seq;
+			else
+				offset = 0;
+
 			if (skb->h.th->syn)
 				offset--;
 			if (offset < skb->len)
@@ -1273,6 +1294,8 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 		} else
 			sk_wait_data(sk, &timeo);
 
+		tp->ucopy.wakeup = 0;
+
 		if (user_recv) {
 			int chunk;
 
@@ -1304,45 +1327,69 @@ do_prequeue:
 		}
 		continue;
 
-	found_ok_skb:
+found_ok_skb:
 		/* Ok so how much can we use? */
-		used = skb->len - offset;
-		if (len < used)
-			used = len;
-
-		/* Do we have urgent data here? */
-		if (tp->urg_data) {
-			u32 urg_offset = tp->urg_seq - *seq;
-			if (urg_offset < used) {
-				if (!urg_offset) {
-					if (!sock_flag(sk, SOCK_URGINLINE)) {
-						++*seq;
-						offset++;
-						used--;
-						if (!used)
-							goto skip_copy;
-					}
-				} else
-					used = urg_offset;
+		if (!skb->copied_early) {
+			used = skb->len - offset;
+			if (len < used)
+				used = len;
+
+			/* Do we have urgent data here? */
+			if (tp->urg_data) {
+				u32 urg_offset = tp->urg_seq - *seq;
+				if (urg_offset < used) {
+					if (!urg_offset) {
+						if (!sock_flag(sk, SOCK_URGINLINE)) {
+							++*seq;
+							offset++;
+							used--;
+							if (!used)
+								goto skip_copy;
+						}
+					} else
+						used = urg_offset;
+				}
 			}
-		}
 
-		if (!(flags & MSG_TRUNC)) {
-			err = skb_copy_datagram_iovec(skb, offset,
-						      msg->msg_iov, used);
-			if (err) {
-				/* Exception. Bailout! */
-				if (!copied)
-					copied = -EFAULT;
-				break;
+			if (!(flags & MSG_TRUNC)) {
+				if (tp->ucopy.dma_chan) {
+					tp->ucopy.dma_cookie = dma_skb_copy_datagram_iovec(
+						tp->ucopy.dma_chan, skb, offset,
+						msg->msg_iov, used,
+						tp->ucopy.locked_list);
+
+					if (tp->ucopy.dma_cookie < 0) {
+
+						printk(KERN_ALERT "dma_cookie < 0\n");
+
+						/* Exception. Bailout! */
+						if (!copied)
+							copied = -EFAULT;
+						break;
+					}
+					if ((offset + used) == skb->len)
+						skb->copied_early = 1;
+
+				} else {
+					err = skb_copy_datagram_iovec(skb, offset,
+							msg->msg_iov, used);
+					if (err) {
+						/* Exception. Bailout! */
+						if (!copied)
+							copied = -EFAULT;
+						break;
+					}
+				}
 			}
-		}
 
-		*seq += used;
-		copied += used;
-		len -= used;
+			*seq += used;
+			copied += used;
+			len -= used;
 
-		tcp_rcv_space_adjust(sk);
+			tcp_rcv_space_adjust(sk);
+		} else {
+			used = skb->len;
+		}
 
 skip_copy:
 		if (tp->urg_data && after(tp->copied_seq, tp->urg_seq)) {
@@ -1354,15 +1401,27 @@ skip_copy:
 
 		if (skb->h.th->fin)
 			goto found_fin_ok;
-		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb);
+		if (!(flags & MSG_PEEK)) {
+			if (!skb->copied_early)
+				sk_eat_skb(sk, skb);
+			else {
+				__skb_unlink(skb, &sk->sk_receive_queue);
+				__skb_queue_tail(&tp->async_wait_queue, skb);
+			}
+		}
 		continue;
 
 	found_fin_ok:
 		/* Process the FIN. */
 		++*seq;
-		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb);
+		if (!(flags & MSG_PEEK)) {
+			if (!skb->copied_early)
+				sk_eat_skb(sk, skb);
+			else {
+				__skb_unlink(skb, &sk->sk_receive_queue);
+				__skb_queue_tail(&tp->async_wait_queue, skb);
+			}
+		}
 		break;
 	} while (len > 0);
 
@@ -1383,8 +1442,37 @@ skip_copy:
 
 		tp->ucopy.task = NULL;
 		tp->ucopy.len = 0;
+		tp->ucopy.bytes_early_copied = 0;
 	}
 
+
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
+			/* do partial cleanup of async_wait_queue */
+			while ((skb = skb_peek(&tp->async_wait_queue)) &&
+			       (dma_async_is_complete(TCP_SKB_CB(skb)->dma_cookie,
+			                       done, used) == DMA_SUCCESS)) {
+				__skb_dequeue(&tp->async_wait_queue);
+				kfree_skb(skb);
+			}
+		}
+
+		/* Safe to free early-copied skbs now */
+		__skb_queue_purge(&tp->async_wait_queue);
+		dma_unlock_iovec_pages(tp->ucopy.locked_list);
+		tp->ucopy.dma_chan = NULL;
+		tp->ucopy.locked_list = NULL;
+	}
+#endif
+
 	/* According to UNIX98, msg_name/msg_namelen are ignored
 	 * on connected socket. I was just happy when found this 8) --ANK
 	 */
diff -rup a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
--- a/net/ipv4/tcp_input.c	2005-12-21 12:05:00.000000000 -0800
+++ b/net/ipv4/tcp_input.c	2005-12-21 12:14:42.000000000 -0800
@@ -70,6 +70,7 @@
 #include <net/tcp.h>
 #include <net/inet_common.h>
 #include <linux/ipsec.h>
+#include <linux/dmaengine.h>
 #include <asm/unaligned.h>
 
 int sysctl_tcp_timestamps = 1;
@@ -3623,10 +3624,12 @@ tcp_checksum_complete_user(struct sock *
  *	the rest is checked inline. Fast processing is turned on in 
  *	tcp_data_queue when everything is OK.
  */
+
 int tcp_rcv_established(struct sock *sk, struct sk_buff *skb,
 			struct tcphdr *th, unsigned len)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	int eaten = 0;
 
 	/*
 	 *	Header prediction.
@@ -3715,12 +3718,11 @@ int tcp_rcv_established(struct sock *sk,
 				goto discard;
 			}
 		} else {
-			int eaten = 0;
-
 			if (tp->ucopy.task == current &&
 			    tp->copied_seq == tp->rcv_nxt &&
 			    len - tcp_header_len <= tp->ucopy.len &&
-			    sock_owned_by_user(sk)) {
+			    sock_owned_by_user(sk) &&
+			    !skb->copied_early) {
 				__set_current_state(TASK_RUNNING);
 
 				if (!tcp_copy_to_iovec(sk, skb, tcp_header_len)) {
@@ -3767,6 +3769,9 @@ int tcp_rcv_established(struct sock *sk,
 				__skb_queue_tail(&sk->sk_receive_queue, skb);
 				sk_stream_set_owner_r(skb, sk);
 				tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
+
+				if (skb->copied_early)
+					tcp_cleanup_rbuf(sk, skb->len);
 			}
 
 			tcp_event_data_recv(sk, tp, skb);
@@ -3781,6 +3786,9 @@ int tcp_rcv_established(struct sock *sk,
 
 			__tcp_ack_snd_check(sk, 0);
 no_ack:
+			if (skb->copied_early)
+				return 0;
+
 			if (eaten)
 				__kfree_skb(skb);
 			else
@@ -3864,6 +3872,55 @@ discard:
 	return 0;
 }
 
+#ifdef CONFIG_NET_DMA
+void dma_async_try_early_copy(struct sock *sk, struct sk_buff *skb)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	int dma_cookie;
+	int chunk = skb->len - tp->tcp_header_len;
+	struct tcphdr *th = skb->h.th;
+
+	if ((tp->ucopy.task == NULL) || (tp->ucopy.dma_chan == NULL) || tp->ucopy.wakeup)
+          	return;
+
+	if ((tcp_flag_word(th) & TCP_HP_BITS) != tp->pred_flags ||
+		TCP_SKB_CB(skb)->seq != tp->rcv_nxt)
+		return;
+
+	if (tp->ucopy.dma_chan &&
+	    chunk > 0 &&
+	    chunk <= (tp->ucopy.len) &&
+	    tp->copied_seq == tp->rcv_nxt &&
+	    skb->ip_summed == CHECKSUM_UNNECESSARY) {
+
+		dma_cookie = dma_skb_copy_datagram_iovec(tp->ucopy.dma_chan,
+			skb, tp->tcp_header_len,
+			tp->ucopy.iov, chunk, tp->ucopy.locked_list);
+
+		if (dma_cookie < 0)
+			return;
+
+		tp->ucopy.dma_cookie = dma_cookie;
+		skb->copied_early = 1;
+
+		tp->ucopy.bytes_early_copied += chunk;
+		tp->copied_seq += chunk;
+		tp->ucopy.len -= chunk;
+		tcp_rcv_space_adjust(sk);
+
+		if (tp->ucopy.len == 0) {
+			tp->ucopy.wakeup = 1;
+			wake_up_interruptible(sk->sk_sleep);
+		}
+	} else if (chunk > 0) {
+		tp->ucopy.wakeup = 1;
+		wake_up_interruptible(sk->sk_sleep);
+	}
+}
+
+EXPORT_SYMBOL(dma_async_try_early_copy);
+#endif /* CONFIG_NET_DMA */
+
 static int tcp_rcv_synsent_state_process(struct sock *sk, struct sk_buff *skb,
 					 struct tcphdr *th, unsigned len)
 {
diff -rup a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c	2005-12-21 12:10:49.000000000 -0800
+++ b/net/ipv4/tcp_ipv4.c	2005-12-21 12:14:42.000000000 -0800
@@ -1148,6 +1148,11 @@ int tcp_v4_do_rcv(struct sock *sk, struc
 {
 	if (sk->sk_state == TCP_ESTABLISHED) { /* Fast path */
 		TCP_CHECK_TIMER(sk);
+
+#ifdef CONFIG_NET_DMA
+		dma_async_try_early_copy(sk, skb);
+#endif
+
 		if (tcp_rcv_established(sk, skb, skb->h.th, skb->len))
 			goto reset;
 		TCP_CHECK_TIMER(sk);
@@ -1256,10 +1261,19 @@ process:
 	bh_lock_sock(sk);
 	ret = 0;
 	if (!sock_owned_by_user(sk)) {
-		if (!tcp_prequeue(sk, skb))
+#ifdef CONFIG_NET_DMA
+		struct tcp_sock *tp = tcp_sk(sk);
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
+
 	bh_unlock_sock(sk);
 
 	sock_put(sk);

