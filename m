Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161457AbWJKVQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161457AbWJKVQG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 17:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161449AbWJKVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 17:09:39 -0400
Received: from mail.kroah.org ([69.55.234.183]:26531 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1161444AbWJKVJM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 17:09:12 -0400
Date: Wed, 11 Oct 2006 14:08:31 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, John Heffner <jheffner@psc.edu>,
       Stephen Hemminger <shemminger@osdl.org>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 57/67] TCP: Fix and simplify microsecond rtt sampling
Message-ID: <20061011210831.GF16627@kroah.com>
References: <20061011204756.642936754@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="tcp-fix-and-simplify-microsecond-rtt-sampling.patch"
In-Reply-To: <20061011210310.GA16627@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David Miller <davem@davemloft.net>

This changes the microsecond RTT sampling so that samples are taken in
the same way that RTT samples are taken for the RTO calculator: on the
last segment acknowledged, and only when the segment hasn't been
retransmitted.

Signed-off-by: John Heffner <jheffner@psc.edu>
Acked-by: Stephen Hemminger <shemminger@osdl.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/ipv4/tcp_input.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- linux-2.6.18.orig/net/ipv4/tcp_input.c
+++ linux-2.6.18/net/ipv4/tcp_input.c
@@ -2237,13 +2237,12 @@ static int tcp_tso_acked(struct sock *sk
 	return acked;
 }
 
-static u32 tcp_usrtt(const struct sk_buff *skb)
+static u32 tcp_usrtt(struct timeval *tv)
 {
-	struct timeval tv, now;
+	struct timeval now;
 
 	do_gettimeofday(&now);
-	skb_get_timestamp(skb, &tv);
-	return (now.tv_sec - tv.tv_sec) * 1000000 + (now.tv_usec - tv.tv_usec);
+	return (now.tv_sec - tv->tv_sec) * 1000000 + (now.tv_usec - tv->tv_usec);
 }
 
 /* Remove acknowledged frames from the retransmission queue. */
@@ -2258,6 +2257,7 @@ static int tcp_clean_rtx_queue(struct so
 	u32 pkts_acked = 0;
 	void (*rtt_sample)(struct sock *sk, u32 usrtt)
 		= icsk->icsk_ca_ops->rtt_sample;
+	struct timeval tv;
 
 	while ((skb = skb_peek(&sk->sk_write_queue)) &&
 	       skb != sk->sk_send_head) {
@@ -2306,8 +2306,7 @@ static int tcp_clean_rtx_queue(struct so
 				seq_rtt = -1;
 			} else if (seq_rtt < 0) {
 				seq_rtt = now - scb->when;
-				if (rtt_sample)
-					(*rtt_sample)(sk, tcp_usrtt(skb));
+				skb_get_timestamp(skb, &tv);
 			}
 			if (sacked & TCPCB_SACKED_ACKED)
 				tp->sacked_out -= tcp_skb_pcount(skb);
@@ -2320,8 +2319,7 @@ static int tcp_clean_rtx_queue(struct so
 			}
 		} else if (seq_rtt < 0) {
 			seq_rtt = now - scb->when;
-			if (rtt_sample)
-				(*rtt_sample)(sk, tcp_usrtt(skb));
+			skb_get_timestamp(skb, &tv);
 		}
 		tcp_dec_pcount_approx(&tp->fackets_out, skb);
 		tcp_packets_out_dec(tp, skb);
@@ -2333,6 +2331,8 @@ static int tcp_clean_rtx_queue(struct so
 	if (acked&FLAG_ACKED) {
 		tcp_ack_update_rtt(sk, acked, seq_rtt);
 		tcp_ack_packets_out(sk, tp);
+		if (rtt_sample && !(acked & FLAG_RETRANS_DATA_ACKED))
+			(*rtt_sample)(sk, tcp_usrtt(&tv));
 
 		if (icsk->icsk_ca_ops->pkts_acked)
 			icsk->icsk_ca_ops->pkts_acked(sk, pkts_acked);

--
