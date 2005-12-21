Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751120AbVLUFSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbVLUFSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbVLUFSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:18:09 -0500
Received: from fmr19.intel.com ([134.134.136.18]:28631 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751116AbVLUFRs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:17:48 -0500
Subject: [RFC][PATCH 4/5] I/OAT DMA support and TCP acceleration
From: Chris Leech <christopher.leech@intel.com>
To: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 21:17:43 -0800
Message-Id: <1135142263.13781.21.camel@cleech-mobl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
X-OriginalArrivalTime: 21 Dec 2005 05:17:47.0288 (UTC) FILETIME=[E15B4180:01C605ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Structure changes for TCP recv offload to I/OAT

Adds an async_wait_queue and some additional fields to tcp_sock, a
copied_early flag to sb_buff and a dma_cookie_t to tcp_skb_cb

Renames cleanup_rbuf to tcp_cleanup_rbuf and makes it non-static so we
can call it from tcp_input.c 

--- 
 include/linux/skbuff.h   |    5 +++--
 include/linux/tcp.h      |    9 +++++++++
 include/net/tcp.h        |   10 ++++++++++
 net/core/skbuff.c        |    1 +
 net/ipv4/tcp.c           |   11 ++++++-----
 net/ipv4/tcp_ipv4.c      |    4 ++++
 net/ipv4/tcp_minisocks.c |    1 +
 net/ipv6/tcp_ipv6.c      |    1 +
 8 files changed, 35 insertions(+), 7 deletions(-)
diff -urp a/include/linux/skbuff.h b/include/linux/skbuff.h
--- a/include/linux/skbuff.h	2005-12-21 12:05:09.000000000 -0800
+++ b/include/linux/skbuff.h	2005-12-21 12:10:14.000000000 -0800
@@ -248,7 +248,7 @@ struct sk_buff {
 	 * want to keep them across layers you have to do a skb_clone()
 	 * first. This is owned by whoever has the skb queued ATM.
 	 */
-	char			cb[40];
+	char			cb[44];
 
 	unsigned int		len,
 				data_len,
@@ -261,7 +261,8 @@ struct sk_buff {
 				nohdr:1,
 				nfctinfo:3;
 	__u8			pkt_type:3,
-				fclone:2;
+				fclone:2,
+				copied_early:1;
 	__be16			protocol;
 
 	void			(*destructor)(struct sk_buff *skb);
diff -urp a/include/linux/tcp.h b/include/linux/tcp.h
--- a/include/linux/tcp.h	2005-12-21 12:05:09.000000000 -0800
+++ b/include/linux/tcp.h	2005-12-21 12:10:14.000000000 -0800
@@ -18,6 +18,7 @@
 #define _LINUX_TCP_H
 
 #include <linux/types.h>
+#include <linux/dmaengine.h>
 #include <asm/byteorder.h>
 
 struct tcphdr {
@@ -249,6 +250,13 @@ struct tcp_sock {
 		struct iovec		*iov;
 		int			memory;
 		int			len;
+
+		/* members for async copy */
+		int			wakeup;
+		struct dma_chan		*dma_chan;
+		int			bytes_early_copied;
+		struct dma_locked_list	*locked_list;
+		dma_cookie_t		dma_cookie;
 	} ucopy;
 
 	__u32	snd_wl1;	/* Sequence for window update		*/
@@ -294,6 +302,7 @@ struct tcp_sock {
 	__u32	snd_cwnd_stamp;
 
 	struct sk_buff_head	out_of_order_queue; /* Out of order segments go here */
+	struct sk_buff_head	async_wait_queue; /* DMA unfinished segments go here */
 
 	struct tcp_func		*af_specific;	/* Operations which are AF_INET{4,6} specific	*/
 
diff -urp a/include/net/tcp.h b/include/net/tcp.h
--- a/include/net/tcp.h	2005-12-21 12:05:09.000000000 -0800
+++ b/include/net/tcp.h	2005-12-21 12:10:14.000000000 -0800
@@ -563,6 +563,9 @@ extern u32	__tcp_select_window(struct so
  * 40 bytes on 64-bit machines, if this grows please adjust
  * skbuff.h:skbuff->cb[xxx] size appropriately.
  */
+
+#include <linux/dmaengine.h>
+
 struct tcp_skb_cb {
 	union {
 		struct inet_skb_parm	h4;
@@ -602,6 +605,7 @@ struct tcp_skb_cb {
 
 	__u16		urg_ptr;	/* Valid w/URG flags is set.	*/
 	__u32		ack_seq;	/* Sequence number ACK'd	*/
+	dma_cookie_t	dma_cookie;	/* async copy token		*/
 };
 
 #define TCP_SKB_CB(__skb)	((struct tcp_skb_cb *)&((__skb)->cb[0]))
@@ -867,8 +871,14 @@ static __inline__ void tcp_prequeue_init
 {
 	tp->ucopy.task = NULL;
 	tp->ucopy.len = 0;
+	tp->ucopy.wakeup = 0;
 	tp->ucopy.memory = 0;
 	skb_queue_head_init(&tp->ucopy.prequeue);
+
+	tp->ucopy.dma_chan = NULL;
+	tp->ucopy.bytes_early_copied = 0;
+	tp->ucopy.locked_list = NULL;
+	tp->ucopy.dma_cookie = 0;
 }
 
 /* Packet is added to VJ-style prequeue for processing in process
diff -urp a/net/core/skbuff.c b/net/core/skbuff.c
--- a/net/core/skbuff.c	2005-12-21 12:05:09.000000000 -0800
+++ b/net/core/skbuff.c	2005-12-21 12:10:14.000000000 -0800
@@ -400,6 +400,7 @@ struct sk_buff *skb_clone(struct sk_buff
 	C(local_df);
 	n->cloned = 1;
 	n->nohdr = 0;
+	C(copied_early);
 	C(pkt_type);
 	C(ip_summed);
 	C(priority);
diff -urp a/net/ipv4/tcp.c b/net/ipv4/tcp.c
--- a/net/ipv4/tcp.c	2005-12-21 12:05:09.000000000 -0800
+++ b/net/ipv4/tcp.c	2005-12-21 12:10:27.000000000 -0800
@@ -936,7 +936,7 @@ static int tcp_recv_urg(struct sock *sk,
  * calculation of whether or not we must ACK for the sake of
  * a window update.
  */
-static void cleanup_rbuf(struct sock *sk, int copied)
+void tcp_cleanup_rbuf(struct sock *sk, int copied)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
 	int time_to_ack = 0;
@@ -1085,7 +1085,7 @@ int tcp_read_sock(struct sock *sk, read_
 
 	/* Clean up data we have read: This will do ACK frames. */
 	if (copied)
-		cleanup_rbuf(sk, copied);
+		tcp_cleanup_rbuf(sk, copied);
 	return copied;
 }
 
@@ -1219,7 +1219,7 @@ int tcp_recvmsg(struct kiocb *iocb, stru
 			}
 		}
 
-		cleanup_rbuf(sk, copied);
+		tcp_cleanup_rbuf(sk, copied);
 
 		if (!sysctl_tcp_low_latency && tp->ucopy.task == user_recv) {
 			/* Install new reader */
@@ -1390,7 +1390,7 @@ skip_copy:
 	 */
 
 	/* Clean up data we have read: This will do ACK frames. */
-	cleanup_rbuf(sk, copied);
+	tcp_cleanup_rbuf(sk, copied);
 
 	TCP_CHECK_TIMER(sk);
 	release_sock(sk);
@@ -1652,6 +1652,7 @@ int tcp_disconnect(struct sock *sk, int 
 	__skb_queue_purge(&sk->sk_receive_queue);
 	sk_stream_writequeue_purge(sk);
 	__skb_queue_purge(&tp->out_of_order_queue);
+	__skb_queue_purge(&tp->async_wait_queue);
 
 	inet->dport = 0;
 
@@ -1855,7 +1856,7 @@ int tcp_setsockopt(struct sock *sk, int 
 			    (TCPF_ESTABLISHED | TCPF_CLOSE_WAIT) &&
 			    inet_csk_ack_scheduled(sk)) {
 				icsk->icsk_ack.pending |= ICSK_ACK_PUSHED;
-				cleanup_rbuf(sk, 1);
+				tcp_cleanup_rbuf(sk, 1);
 				if (!(val & 1))
 					icsk->icsk_ack.pingpong = 1;
 			}
diff -urp a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
--- a/net/ipv4/tcp_ipv4.c	2005-12-14 15:50:41.000000000 -0800
+++ b/net/ipv4/tcp_ipv4.c	2005-12-21 12:10:27.000000000 -0800
@@ -1414,6 +1414,7 @@ static int tcp_v4_init_sock(struct sock 
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	skb_queue_head_init(&tp->out_of_order_queue);
+	skb_queue_head_init(&tp->async_wait_queue);
 	tcp_init_xmit_timers(sk);
 	tcp_prequeue_init(tp);
 
@@ -1466,6 +1467,9 @@ int tcp_v4_destroy_sock(struct sock *sk)
 	/* Cleans up our, hopefully empty, out_of_order_queue. */
   	__skb_queue_purge(&tp->out_of_order_queue);
 
+	/* Cleans up our async_wait_queue */
+  	__skb_queue_purge(&tp->async_wait_queue);
+
 	/* Clean prequeue, it must be empty really */
 	__skb_queue_purge(&tp->ucopy.prequeue);
 
diff -urp a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
--- a/net/ipv4/tcp_minisocks.c	2005-12-14 15:50:41.000000000 -0800
+++ b/net/ipv4/tcp_minisocks.c	2005-12-21 12:10:27.000000000 -0800
@@ -389,6 +389,7 @@ struct sock *tcp_create_openreq_child(st
 		tcp_set_ca_state(newsk, TCP_CA_Open);
 		tcp_init_xmit_timers(newsk);
 		skb_queue_head_init(&newtp->out_of_order_queue);
+		skb_queue_head_init(&newtp->async_wait_queue);
 		newtp->rcv_wup = treq->rcv_isn + 1;
 		newtp->write_seq = treq->snt_isn + 1;
 		newtp->pushed_seq = newtp->write_seq;
diff -urp a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
--- a/net/ipv6/tcp_ipv6.c	2005-12-14 15:50:41.000000000 -0800
+++ b/net/ipv6/tcp_ipv6.c	2005-12-21 12:10:27.000000000 -0800
@@ -1863,6 +1863,7 @@ static int tcp_v6_init_sock(struct sock 
 	struct tcp_sock *tp = tcp_sk(sk);
 
 	skb_queue_head_init(&tp->out_of_order_queue);
+	skb_queue_head_init(&tp->async_wait_queue);
 	tcp_init_xmit_timers(sk);
 	tcp_prequeue_init(tp);
 

