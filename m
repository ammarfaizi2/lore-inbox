Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263383AbVBCXxe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263383AbVBCXxe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbVBCXw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:52:56 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:54534 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261766AbVBCXwA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:52:00 -0500
Date: Fri, 4 Feb 2005 10:50:44 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: anton@samba.org, okir@suse.de, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050203235044.GA8422@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au> <20050203142705.GA11318@krispykreme.ozlabs.ibm.com> <20050203203010.GA7081@gondor.apana.org.au> <20050203141901.5ce04c92.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <20050203141901.5ce04c92.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 03, 2005 at 02:19:01PM -0800, David S. Miller wrote:
> 
> They are for cases where you want strict ordering even for the
> non-return-value-giving atomic_t ops.

I see.  I got atomic_dec and atomic_dec_and_test mixed up.

So the problem isn't as big as I thought which is good.  sk_buff
is only in trouble because of the atomic_read optimisation which
really needs a memory barrier.

However, instead of adding a memory barrier which makes the optimisation
less useful, let's just get rid of the atomic_read.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks for the document, it's really helpful.

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== include/linux/skbuff.h 1.59 vs edited =====
--- 1.59/include/linux/skbuff.h	2005-01-11 07:23:55 +11:00
+++ edited/include/linux/skbuff.h	2005-02-04 10:44:17 +11:00
@@ -353,14 +353,14 @@
  */
 static inline void kfree_skb(struct sk_buff *skb)
 {
-	if (atomic_read(&skb->users) == 1 || atomic_dec_and_test(&skb->users))
+	if (atomic_dec_and_test(&skb->users))
 		__kfree_skb(skb);
 }
 
 /* Use this if you didn't touch the skb state [for fast switching] */
 static inline void kfree_skb_fast(struct sk_buff *skb)
 {
-	if (atomic_read(&skb->users) == 1 || atomic_dec_and_test(&skb->users))
+	if (atomic_dec_and_test(&skb->users))
 		kfree_skbmem(skb);
 }
 

--fUYQa+Pmc3FrFX/N--
