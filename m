Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751205AbWA0P23@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751205AbWA0P23 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 10:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWA0P22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 10:28:28 -0500
Received: from stinky.trash.net ([213.144.137.162]:1457 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1751205AbWA0P22 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 10:28:28 -0500
Message-ID: <43DA3C19.2040002@trash.net>
Date: Fri, 27 Jan 2006 16:28:25 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>, KdF <dkiba@yandex.ru>
CC: Knut Petersen <Knut_Petersen@t-online.de>, shemminger@osdl.org,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>,
       netfilter-devel@lists.netfilter.org
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
References: <E1F1UqC-0002XE-00@gondolin.me.apana.org.au> <43D9B8A6.5020200@t-online.de> <20060127122242.GA32128@gondor.apana.org.au>
In-Reply-To: <20060127122242.GA32128@gondor.apana.org.au>
X-Enigmail-Version: 0.93.0.0
Content-Type: multipart/mixed;
 boundary="------------040801050207010802010808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040801050207010802010808
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Herbert Xu wrote:
> On Fri, Jan 27, 2006 at 07:07:34AM +0100, Knut Petersen wrote:
> 
>>Well, there are no problems if SuSEfirewall2 is disabled. But have a look
>>at the loaded modules:
>>
>>ipt_MASQUERADE          3968  1
>>pppoe                  15360  2
>>pppox                   4616  1 pppoe
> 
> 
> OK, although we can't rule out sky2/netfilter from the enquiry, I've
> identified two bugs in ppp/pppoe that may be responsible for what you
> are seeing.  So please try the following patch and let us know if the
> problem still exists (or deteriorates/improves).
> 
> [PPP]: Fixed hardware RX checksum handling
> 
> When we pull the PPP protocol off the skb, we forgot to update the
> hardware RX checksum.  This may lead to messages such as
> 
> 	dsl0: hw csum failure.
> 
> Similarly, we need to clear the hardware checksum flag when we use
> the existing packet to store the decompressed result.

We had a couple of reports of incorrect hardware checksums with
PPPoE. KdF, can you test Herbert's patch (attached again to this
mail) please?

--------------040801050207010802010808
Content-Type: text/plain;
 name="ppp-rxcsum"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppp-rxcsum"

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

--------------040801050207010802010808--
