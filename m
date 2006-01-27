Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932478AbWA0MXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932478AbWA0MXI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 07:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932479AbWA0MXH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 07:23:07 -0500
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:31244 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S932478AbWA0MXG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 07:23:06 -0500
Date: Fri, 27 Jan 2006 23:22:42 +1100
To: Knut Petersen <Knut_Petersen@t-online.de>
Cc: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller 11ab:4362 (rev 19)
Message-ID: <20060127122242.GA32128@gondor.apana.org.au>
References: <E1F1UqC-0002XE-00@gondolin.me.apana.org.au> <43D9B8A6.5020200@t-online.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <43D9B8A6.5020200@t-online.de>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 27, 2006 at 07:07:34AM +0100, Knut Petersen wrote:
>
> Well, there are no problems if SuSEfirewall2 is disabled. But have a look
> at the loaded modules:
> 
> ipt_MASQUERADE          3968  1
> pppoe                  15360  2
> pppox                   4616  1 pppoe

OK, although we can't rule out sky2/netfilter from the enquiry, I've
identified two bugs in ppp/pppoe that may be responsible for what you
are seeing.  So please try the following patch and let us know if the
problem still exists (or deteriorates/improves).

[PPP]: Fixed hardware RX checksum handling

When we pull the PPP protocol off the skb, we forgot to update the
hardware RX checksum.  This may lead to messages such as

	dsl0: hw csum failure.

Similarly, we need to clear the hardware checksum flag when we use
the existing packet to store the decompressed result.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ppp-rxcsum

diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -1610,6 +1610,8 @@ ppp_receive_nonmp_frame(struct ppp *ppp,
 		}
 		else if (!pskb_may_pull(skb, skb->len))
 			goto err;
+		else
+			skb->ip_summed = CHECKSUM_NONE;
 
 		len = slhc_uncompress(ppp->vj, skb->data + 2, skb->len - 2);
 		if (len <= 0) {
@@ -1690,6 +1692,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp,
 			kfree_skb(skb);
 		} else {
 			skb_pull(skb, 2);	/* chop off protocol */
+			skb_postpull_rcsum(skb, skb->data - 2, 2);
 			skb->dev = ppp->dev;
 			skb->protocol = htons(npindex_to_ethertype[npi]);
 			skb->mac.raw = skb->data;

--d6Gm4EdcadzBjdND--
