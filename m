Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264001AbSKDAU7>; Sun, 3 Nov 2002 19:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263991AbSKDAU6>; Sun, 3 Nov 2002 19:20:58 -0500
Received: from hera.cwi.nl ([192.16.191.8]:31983 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S263986AbSKDAU5>;
	Sun, 3 Nov 2002 19:20:57 -0500
From: Andries.Brouwer@cwi.nl
Date: Mon, 4 Nov 2002 01:27:26 +0100 (MET)
Message-Id: <UTC200211040027.gA40RQ103595.aeb@smtp.cwi.nl>
To: davem@redhat.com
Subject: [PATCH] tcp hang solved
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Recent 2.5 kernels were unusable since rlogin sessions would
inexplicably hang for many seconds. tcpdump reveals that
the remote host sends packets A,B,C, the local host acks A,
remote host sends D, local host acks A, sacks C, D, and,
for example 47 seconds later, the remote host retransmits B.

Until 2.5.34 the scenario would be the same, but the retransmission
would occur after less than a second.

If I am not mistaken, the cause of this change in behaviour is
the removal of tcp_store_ts_recent() one place, and addition
three other places. At first sight the three new places seem to
cover the old call, but inspection shows that the conditions
changed. So, the following patch should be appropriate.

Andries


--- linux-2.5.45/linux/net/ipv4/tcp_input.c	Thu Oct 31 14:14:51 2002
+++ linux-2.5.45a/linux/net/ipv4/tcp_input.c	Mon Nov  4 01:10:27 2002
@@ -3433,6 +3433,7 @@
 				    (sizeof(struct tcphdr) + TCPOLEN_TSTAMP_ALIGNED) &&
 				    tp->rcv_nxt == tp->rcv_wup)
 					tcp_store_ts_recent(tp);
+
 				/* We know that such packets are checksummed
 				 * on entry.
 				 */
@@ -3454,10 +3455,6 @@
 				__set_current_state(TASK_RUNNING);
 
 				if (!tcp_copy_to_iovec(sk, skb, tcp_header_len)) {
-					__skb_pull(skb, tcp_header_len);
-					tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
-					NET_INC_STATS_BH(TCPHPHitsToUser);
-					eaten = 1;
 					/* Predicted packet is in window by definition.
 					 * seq == rcv_nxt and rcv_wup <= rcv_nxt.
 					 * Hence, check seq<=rcv_wup reduces to:
@@ -3467,6 +3464,11 @@
 					     TCPOLEN_TSTAMP_ALIGNED) &&
 					    tp->rcv_nxt == tp->rcv_wup)
 						tcp_store_ts_recent(tp);
+
+					__skb_pull(skb, tcp_header_len);
+					tp->rcv_nxt = TCP_SKB_CB(skb)->end_seq;
+					NET_INC_STATS_BH(TCPHPHitsToUser);
+					eaten = 1;
 				}
 			}
 			if (!eaten) {

[now that this code+comment occurs three times, an inline function
is perhaps nicer]
