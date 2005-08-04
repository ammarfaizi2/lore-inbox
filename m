Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262468AbVHDKfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262468AbVHDKfi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 06:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262469AbVHDKfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 06:35:38 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:46749 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S262459AbVHDKff (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 06:35:35 -0400
Date: Thu, 4 Aug 2005 20:35:23 +1000
To: Guillaume Pelat <guillaume.pelat@winch-hebergement.net>
Cc: davem@davemloft.net, akpm@osdl.org, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc4 - kernel panic - BUG at net/ipv4/tcp_output.c:918
Message-ID: <20050804103523.GA11381@gondor.apana.org.au>
References: <42EDDE50.6050800@winch-hebergement.net> <20050804033329.GA14501@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20050804033329.GA14501@gondor.apana.org.au>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 04, 2005 at 01:33:29PM +1000, herbert wrote:
> 
> So I suppose we should reset cwnd_quota after tcp_transmit_skb?

Please try this patch to see if this is really the problem or not.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -1027,19 +1027,14 @@ static int tcp_write_xmit(struct sock *s
 		tcp_minshall_update(tp, mss_now, skb);
 		sent_pkts++;
 
-		/* Do not optimize this to use tso_segs. If we chopped up
-		 * the packet above, tso_segs will no longer be valid.
-		 */
-		cwnd_quota -= tcp_skb_pcount(skb);
-
-		BUG_ON(cwnd_quota < 0);
-		if (!cwnd_quota)
-			break;
-
 		skb = sk->sk_send_head;
 		if (!skb)
 			break;
+
 		tso_segs = tcp_init_tso_segs(sk, skb, mss_now);
+		cwnd_quota = tcp_cwnd_test(tp, skb);
+		if (!cwnd_quota)
+			break;
 	}
 
 	if (likely(sent_pkts)) {

--huq684BweRXVnRxX--
