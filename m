Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262805AbVHEA6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262805AbVHEA6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 20:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262803AbVHEA6g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 20:58:36 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:28813 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S262800AbVHEA62 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 20:58:28 -0400
Date: Fri, 5 Aug 2005 10:57:41 +1000
To: Andrew Morton <akpm@osdl.org>
Cc: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>,
       davem@davemloft.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: [TCP]: Fix TSO cwnd caching bug
Message-ID: <20050805005741.GA17960@gondor.apana.org.au>
References: <42EDDE50.6050800@winch-hebergement.net> <20050804033329.GA14501@gondor.apana.org.au> <20050804103523.GA11381@gondor.apana.org.au> <42F25352.8050805@winch-hebergement.net> <20050804165842.4d673f97.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <20050804165842.4d673f97.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2005 at 04:58:42PM -0700, Andrew Morton wrote:
> 
> Thanks, Guillaume.  Herbert, David is travelling and not able to do a lot
> of patchmonkeying.  Could you please prepare and submit a final patch?

OK, here is the final version.  It depends on the patch that David
posted earlier on in this thread.  Please let me know if you need a
copy of that.

[TCP]: Fix TSO cwnd caching bug

tcp_write_xmit caches the cwnd value indirectly in cwnd_quota.
When tcp_transmit_skb reduces the cwnd because of tcp_enter_cwr,
the cached value becomes invalid.

This patch ensures that the cwnd value is always reread after
each tcp_transmit_skb call.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=tso-1

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -972,19 +972,18 @@ static int tcp_write_xmit(struct sock *s
 	if (unlikely(sk->sk_state == TCP_CLOSE))
 		return 0;
 
-	skb = sk->sk_send_head;
-	if (unlikely(!skb))
-		return 0;
-
-	tso_segs = tcp_init_tso_segs(sk, skb, mss_now);
-	cwnd_quota = tcp_cwnd_test(tp, skb);
-	if (unlikely(!cwnd_quota))
-		goto out;
-
 	sent_pkts = 0;
-	while (likely(tcp_snd_wnd_test(tp, skb, mss_now))) {
+	while ((skb = sk->sk_send_head)) {
+		tso_segs = tcp_init_tso_segs(sk, skb, mss_now);
 		BUG_ON(!tso_segs);
 
+		cwnd_quota = tcp_cwnd_test(tp, skb);
+		if (!cwnd_quota)
+			break;
+
+		if (unlikely(!tcp_snd_wnd_test(tp, skb, mss_now)))
+			break;
+
 		if (tso_segs == 1) {
 			if (unlikely(!tcp_nagle_test(tp, skb, mss_now,
 						     (tcp_skb_is_last(sk, skb) ?
@@ -1026,27 +1025,12 @@ static int tcp_write_xmit(struct sock *s
 
 		tcp_minshall_update(tp, mss_now, skb);
 		sent_pkts++;
-
-		/* Do not optimize this to use tso_segs. If we chopped up
-		 * the packet above, tso_segs will no longer be valid.
-		 */
-		cwnd_quota -= tcp_skb_pcount(skb);
-
-		BUG_ON(cwnd_quota < 0);
-		if (!cwnd_quota)
-			break;
-
-		skb = sk->sk_send_head;
-		if (!skb)
-			break;
-		tso_segs = tcp_init_tso_segs(sk, skb, mss_now);
 	}
 
 	if (likely(sent_pkts)) {
 		tcp_cwnd_validate(sk, tp);
 		return 0;
 	}
-out:
 	return !tp->packets_out && sk->sk_send_head;
 }
 

--5vNYLRcllDrimb99--
