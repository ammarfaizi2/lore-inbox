Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWEXARB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWEXARB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:17:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWEXARA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:17:00 -0400
Received: from [63.64.152.142] ([63.64.152.142]:6662 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S932504AbWEXAPV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:15:21 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 7/9] [I/OAT] make sk_eat_skb I/OAT aware
Date: Tue, 23 May 2006 17:20:20 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060524002020.19403.80312.stgit@gitlost.site>
In-Reply-To: <20060524001653.19403.31396.stgit@gitlost.site>
References: <20060524001653.19403.31396.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add an extra argument to sk_eat_skb, and make it move early copied packets
to the async_wait_queue instead of freeing them.
Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 include/net/sock.h |   13 ++++++++++++-
 net/dccp/proto.c   |    4 ++--
 net/ipv4/tcp.c     |    8 ++++----
 net/llc/af_llc.c   |    2 +-
 4 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 90c65cb..75b0e97 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1273,11 +1273,22 @@ sock_recv_timestamp(struct msghdr *msg, 
  * This routine must be called with interrupts disabled or with the socket
  * locked so that the sk_buff queue operation is ok.
 */
-static inline void sk_eat_skb(struct sock *sk, struct sk_buff *skb)
+#ifdef CONFIG_NET_DMA
+static inline void sk_eat_skb(struct sock *sk, struct sk_buff *skb, int copied_early)
+{
+	__skb_unlink(skb, &sk->sk_receive_queue);
+	if (!copied_early)
+		__kfree_skb(skb);
+	else
+		__skb_queue_tail(&sk->sk_async_wait_queue, skb);
+}
+#else
+static inline void sk_eat_skb(struct sock *sk, struct sk_buff *skb, int copied_early)
 {
 	__skb_unlink(skb, &sk->sk_receive_queue);
 	__kfree_skb(skb);
 }
+#endif
 
 extern void sock_enable_timestamp(struct sock *sk);
 extern int sock_get_timestamp(struct sock *, struct timeval __user *);
diff --git a/net/dccp/proto.c b/net/dccp/proto.c
index 2e0ee83..5317fd3 100644
--- a/net/dccp/proto.c
+++ b/net/dccp/proto.c
@@ -719,7 +719,7 @@ int dccp_recvmsg(struct kiocb *iocb, str
 		}
 		dccp_pr_debug("packet_type=%s\n",
 			      dccp_packet_name(dh->dccph_type));
-		sk_eat_skb(sk, skb);
+		sk_eat_skb(sk, skb, 0);
 verify_sock_status:
 		if (sock_flag(sk, SOCK_DONE)) {
 			len = 0;
@@ -773,7 +773,7 @@ verify_sock_status:
 		}
 	found_fin_ok:
 		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb);
+			sk_eat_skb(sk, skb, 0);
 		break;
 	} while (1);
 out:
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 1c0cfd7..4e067d2 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1072,11 +1072,11 @@ int tcp_read_sock(struct sock *sk, read_
 				break;
 		}
 		if (skb->h.th->fin) {
-			sk_eat_skb(sk, skb);
+			sk_eat_skb(sk, skb, 0);
 			++seq;
 			break;
 		}
-		sk_eat_skb(sk, skb);
+		sk_eat_skb(sk, skb, 0);
 		if (!desc->count)
 			break;
 	}
@@ -1356,14 +1356,14 @@ skip_copy:
 		if (skb->h.th->fin)
 			goto found_fin_ok;
 		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb);
+			sk_eat_skb(sk, skb, 0);
 		continue;
 
 	found_fin_ok:
 		/* Process the FIN. */
 		++*seq;
 		if (!(flags & MSG_PEEK))
-			sk_eat_skb(sk, skb);
+			sk_eat_skb(sk, skb, 0);
 		break;
 	} while (len > 0);
 
diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
index 5a04db7..7465170 100644
--- a/net/llc/af_llc.c
+++ b/net/llc/af_llc.c
@@ -789,7 +789,7 @@ static int llc_ui_recvmsg(struct kiocb *
 			continue;
 
 		if (!(flags & MSG_PEEK)) {
-			sk_eat_skb(sk, skb);
+			sk_eat_skb(sk, skb, 0);
 			*seq = 0;
 		}
 	} while (len > 0);

