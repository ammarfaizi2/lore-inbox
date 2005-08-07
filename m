Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751763AbVHGMCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbVHGMCc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 08:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbVHGMCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 08:02:31 -0400
Received: from jay.exetel.com.au ([220.233.0.8]:29903 "EHLO jay.exetel.com.au")
	by vger.kernel.org with ESMTP id S1751762AbVHGMCb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 08:02:31 -0400
Date: Sun, 7 Aug 2005 22:02:08 +1000
To: John B?ckstrand <sandos@home.se>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, akpm@osdl.org
Subject: Re: assertion (cnt <= tp->packets_out) failed
Message-ID: <20050807120208.GA3739@gondor.apana.org.au>
References: <42F38B67.5040308@home.se> <20050805.093208.74729918.davem@davemloft.net> <20050806022435.GB12862@gondor.apana.org.au> <20050806075717.GA18104@gondor.apana.org.au> <42F4A7DD.70905@home.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <42F4A7DD.70905@home.se>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 06, 2005 at 02:06:53PM +0200, John B?ckstrand wrote:
> 
> Yes, I have no other patches in, so if it was not in -RC5, I was not 
> running it.

OK having looked at it briefly I have a hunch that it may be the
fackets_out issue (when the effective MSS is reduced tcp_tso_acked
may increase fackets_out) I referred to in another thread.

However, I'd like to be more certain as to whether this is the
cause before we do anything.  So please apply this patch and
attempt to reproduce the problem.  It should give us more info
which may help in pin-pointing the problem.

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1474,6 +1474,10 @@ static void tcp_mark_head_lost(struct so
 	int cnt = packets;
 
 	BUG_TRAP(cnt <= tp->packets_out);
+	if (unlikely(cnt <= tp->packets_out)) {
+		printk("packets_out = %d, fackets_out = %d, reordering = %d, sack_ok = 0x%x, mss_cache=%d\n", tp->packets_out, tp->fackets_out, tp->reordering, tp->rx_opt.sack_ok, tp->mss_cache);
+		dump_stack();
+	}
 
 	sk_stream_for_retrans_queue(skb, sk) {
 		cnt -= tcp_skb_pcount(skb);

--zhXaljGHf11kAtnf--
