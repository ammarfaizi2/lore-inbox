Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030485AbVI3Wjr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030485AbVI3Wjr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 18:39:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030487AbVI3Wjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 18:39:47 -0400
Received: from 22.107.233.220.exetel.com.au ([220.233.107.22]:20243 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030485AbVI3Wjq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 18:39:46 -0400
Date: Sat, 1 Oct 2005 08:39:15 +1000
To: Hendrik Visage <hvjunk@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, ionut@badula.org,
       Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org
Subject: Re: Starfire (Adaptec) kernel 2.6.13+ panics on AMD64 NFS server
Message-ID: <20050930223915.GA17562@gondor.apana.org.au>
References: <d93f04c70509292036x269df799y7b51c5be9c3356d6@mail.gmail.com> <20050929211649.69eaddee.akpm@osdl.org> <d93f04c70509300901s3836b8afw4792d16c589b4fc4@mail.gmail.com> <20050930104046.4685e975.akpm@osdl.org> <d93f04c70509301310y4bde1189wbcaef40124af6766@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <d93f04c70509301310y4bde1189wbcaef40124af6766@mail.gmail.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Sep 30, 2005 at 08:10:59PM +0000, Hendrik Visage wrote:
>
> Anycase, here is a non-PREEMPT traceback. What makes this one
> interesting, is that
> in the preempt case, I had to push the NFS output to get the panic, but the
> non-preempt case attached, sorta just happened, ie. when the clients
> just checked on the server's status :(

You must never call skb_checksum_help unless the packet is meant to
be checksummed by the hardware.  So starfire is the guilty party here.

This patch makes it do the check and also check for errors from
skb_checksum_help.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

diff --git a/drivers/net/starfire.c b/drivers/net/starfire.c
--- a/drivers/net/starfire.c
+++ b/drivers/net/starfire.c
@@ -1333,7 +1333,7 @@ static int start_tx(struct sk_buff *skb,
 	}
 
 #if defined(ZEROCOPY) && defined(HAS_BROKEN_FIRMWARE)
-	{
+	if (skb->ip_summed == CHECKSUM_HW) {
 		int has_bad_length = 0;
 
 		if (skb_first_frag_len(skb) == 1)
@@ -1346,8 +1346,10 @@ static int start_tx(struct sk_buff *skb,
 				}
 		}
 
-		if (has_bad_length)
-			skb_checksum_help(skb, 0);
+		if (has_bad_length && unlikely(skb_checksum_help(skb, 0))) {
+			dev_kfree_skb(skb);
+			return NETDEV_TX_OK;
+		}
 	}
 #endif /* ZEROCOPY && HAS_BROKEN_FIRMWARE */
 

--fdj2RfSjLxBAspz7--
