Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVBCLZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVBCLZn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 06:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262872AbVBCLZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 06:25:17 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:49156 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262357AbVBCLNb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 06:13:31 -0500
Date: Thu, 3 Feb 2005 22:12:24 +1100
To: "David S. Miller" <davem@davemloft.net>
Cc: okir@suse.de, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arp_queue: serializing unlink + kfree_skb
Message-ID: <20050203111224.GA3267@gondor.apana.org.au>
References: <20050131102920.GC4170@suse.de> <E1CvZo6-0001Bz-00@gondolin.me.apana.org.au> <20050202162023.075015d4.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <20050202162023.075015d4.davem@davemloft.net>
User-Agent: Mutt/1.5.6+20040722i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 02, 2005 at 04:20:23PM -0800, David S. Miller wrote:
> 
> > 	if (atomic_read(&skb->users) != 1) {
> > 		smp_mb__before_atomic_dec();
> > 		if (!atomic_dec_and_test(&skb->users))
> > 			return;
> > 	}
> > 	__kfree_skb(skb);
> 
> This looks good.  Olaf can you possibly ask the reproducer if
> this patch makes the ARP problem go away?

Not so hasty Dave :)

That was only meant to be an example of what we might do to
insert a write barrier in kfree_skb().

It doesn't solve Olaf's problem because a write barrier is
usually not sufficient by itself.  In most cases you'll need
a read barrier as well.

So if we're going for a solution that only involves kfree_skb()
then we'll need the following patch.

I got rid of the atomic_read optimisation since it would've needed
an additional smp_rmb() to be safe.

I thought about preserving that optimisation through something
like skb->cloned.  However, it turns out that most skb's will be
shared at least once so it doesn't buy us much.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

What I hoped to do though was to bring your collective attention
to the problem in general.  kfree_skb() is certainly not the only
place where we free an object after the counter hits zero.

This paradigm is repeated throughout the kernel.  I bet the
same race can be found in a lot of those places.  So we really
need to sit down and audit them one by one or else come up with
a magical solution apart from disabling SMP :) 

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

===== include/linux/skbuff.h 1.59 vs edited =====
--- 1.59/include/linux/skbuff.h	2005-01-11 07:23:55 +11:00
+++ edited/include/linux/skbuff.h	2005-02-03 21:57:26 +11:00
@@ -353,15 +353,21 @@
  */
 static inline void kfree_skb(struct sk_buff *skb)
 {
-	if (atomic_read(&skb->users) == 1 || atomic_dec_and_test(&skb->users))
-		__kfree_skb(skb);
+	smp_mb__before_atomic_dec();
+	if (!atomic_dec_and_test(&skb->users))
+		return;
+	smp_mb__after_atomic_dec();
+	__kfree_skb(skb);
 }
 
 /* Use this if you didn't touch the skb state [for fast switching] */
 static inline void kfree_skb_fast(struct sk_buff *skb)
 {
-	if (atomic_read(&skb->users) == 1 || atomic_dec_and_test(&skb->users))
-		kfree_skbmem(skb);
+	smp_mb__before_atomic_dec();
+	if (!atomic_dec_and_test(&skb->users))
+		return;
+	smp_mb__after_atomic_dec();
+	kfree_skbmem(skb);
 }
 
 /**

--fdj2RfSjLxBAspz7--
