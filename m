Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWBDKdy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWBDKdy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 05:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWBDKdy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 05:33:54 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:56751 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751231AbWBDKdx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 05:33:53 -0500
Message-ID: <43E482A5.8020306@t-online.de>
Date: Sat, 04 Feb 2006 11:32:05 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: shemminger@osdl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: [BUG] sky2 broken for Yukon PCI-E Gigabit Ethernet Controller
 11ab:4362 (rev 19)
References: <E1F1UqC-0002XE-00@gondolin.me.apana.org.au> <43D9B8A6.5020200@t-online.de> <20060127122242.GA32128@gondor.apana.org.au>
In-Reply-To: <20060127122242.GA32128@gondor.apana.org.au>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: ZqF99YZDwewPvhi4i6TSUn1KvW-C72f-5aFEHnTZ6iP+84kJPJoU8B@t-dialin.net
X-TOI-MSGID: db46c20c-4ec6-4772-a6b7-c0a4012ab7fc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.16-rc2 still misses your patch. Was there a special reason not to 
send it
to Linus?

cu,
 Knut

>On Fri, Jan 27, 2006 at 07:07:34AM +0100, Knut Petersen wrote:
>  
>
>>Well, there are no problems if SuSEfirewall2 is disabled. But have a look
>>at the loaded modules:
>>
>>ipt_MASQUERADE          3968  1
>>pppoe                  15360  2
>>pppox                   4616  1 pppoe
>>    
>>
>
>OK, although we can't rule out sky2/netfilter from the enquiry, I've
>identified two bugs in ppp/pppoe that may be responsible for what you
>are seeing.  So please try the following patch and let us know if the
>problem still exists (or deteriorates/improves).
>
>[PPP]: Fixed hardware RX checksum handling
>
>When we pull the PPP protocol off the skb, we forgot to update the
>hardware RX checksum.  This may lead to messages such as
>
>	dsl0: hw csum failure.
>
>Similarly, we need to clear the hardware checksum flag when we use
>the existing packet to store the decompressed result.
>
>Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
>Cheers,
>  
>
>------------------------------------------------------------------------
>
>diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
>--- a/drivers/net/ppp_generic.c
>+++ b/drivers/net/ppp_generic.c
>@@ -1610,6 +1610,8 @@ ppp_receive_nonmp_frame(struct ppp *ppp,
> 		}
> 		else if (!pskb_may_pull(skb, skb->len))
> 			goto err;
>+		else
>+			skb->ip_summed = CHECKSUM_NONE;
> 
> 		len = slhc_uncompress(ppp->vj, skb->data + 2, skb->len - 2);
> 		if (len <= 0) {
>@@ -1690,6 +1692,7 @@ ppp_receive_nonmp_frame(struct ppp *ppp,
> 			kfree_skb(skb);
> 		} else {
> 			skb_pull(skb, 2);	/* chop off protocol */
>+			skb_postpull_rcsum(skb, skb->data - 2, 2);
> 			skb->dev = ppp->dev;
> 			skb->protocol = htons(npindex_to_ethertype[npi]);
> 			skb->mac.raw = skb->data;
>  
>

