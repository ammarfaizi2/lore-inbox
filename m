Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbTIHPZx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:25:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbTIHPZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:25:52 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:13712 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262600AbTIHPZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:25:48 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4.23-pre3] signed/unsigned mismatches in include/net/tcp.h
Date: Mon, 8 Sep 2003 17:26:48 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081726.48883@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the first one in tcp.h fixes a warning with gcc 3.3: we compare signed with
unsigned. rto is unsigned, so maybe we should cast the left side to u32.

Number 2 changes the type of mss from int to unsigned int. mss is only used to
compare with sbk->len, which is an unsigned. Both callers of this function
use unsigned variables at this point anyway (one is tcp_send_skb from #3).

Please review.

Eike

diff -Naur linux-2.4.23-pre3/include/net/tcp.h linux-2.4.23-pre3-caliban/include/net/tcp.h
--- linux-2.4.23-pre3/include/net/tcp.h	2003-09-05 15:04:50.000000000 +0200
+++ linux-2.4.23-pre3-caliban/include/net/tcp.h	2003-09-07 18:26:50.000000000 +0200
@@ -1123,7 +1123,7 @@
 		if (tp->packets_out > tp->snd_cwnd_used)
 			tp->snd_cwnd_used = tp->packets_out;
 
-		if ((s32)(tcp_time_stamp - tp->snd_cwnd_stamp) >= tp->rto)
+		if ((u32)(tcp_time_stamp - tp->snd_cwnd_stamp) >= tp->rto)
 			tcp_cwnd_application_limited(sk);
 	}
 }
@@ -1166,7 +1166,7 @@
 		!after(tp->snd_sml, tp->snd_nxt);
 }
 
-static __inline__ void tcp_minshall_update(struct tcp_opt *tp, int mss, struct sk_buff *skb)
+static __inline__ void tcp_minshall_update(struct tcp_opt *tp, unsigned int mss, struct sk_buff *skb)
 {
 	if (skb->len < mss)
 		tp->snd_sml = TCP_SKB_CB(skb)->end_seq;
diff -Naur linux-2.4.23-pre3/net/ipv4/tcp_output.c linux-2.4.23-pre3-caliban/net/ipv4/tcp_output.c
--- linux-2.4.23-pre3/net/ipv4/tcp_output.c	2003-09-05 15:04:52.000000000 +0200
+++ linux-2.4.23-pre3-caliban/net/ipv4/tcp_output.c	2003-09-07 18:17:04.000000000 +0200
@@ -302,7 +302,7 @@
  * NOTE: probe0 timer is not checked, do not forget tcp_push_pending_frames,
  * otherwise socket can stall.
  */
-void tcp_send_skb(struct sock *sk, struct sk_buff *skb, int force_queue, unsigned cur_mss)
+void tcp_send_skb(struct sock *sk, struct sk_buff *skb, int force_queue, unsigned int cur_mss)
 {
 	struct tcp_opt *tp = &(sk->tp_pinfo.af_tcp);
 
