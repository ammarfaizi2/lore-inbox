Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWHZBTd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWHZBTd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 21:19:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422909AbWHZBTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 21:19:33 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:14863 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751378AbWHZBTc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 21:19:32 -0400
Date: Sat, 26 Aug 2006 11:18:39 +1000
To: Greg KH <greg@kroah.com>
Cc: stable@kernel.org, "David S. Miller" <davem@davemloft.net>,
       Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org,
       Neil Brown <neilb@suse.de>, netdev@vger.kernel.org
Subject: Re: [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB trimming
Message-ID: <20060826011839.GA14010@gondor.apana.org.au>
References: <87zme9fy94.fsf@hades.wkstn.nix> <20060813125910.GA18463@gondor.apana.org.au> <20060825230316.GA3254@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060825230316.GA3254@kroah.com>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 04:03:16PM -0700, Greg KH wrote:
> 
> This patch doesn't apply at all to the latest 2.6.17-stable kernel tree.
> Care to rediff it?

Hmm, I just rebased and it actually applied as is to 2.6.17.11 :)
Anyway, here is the result:

[INET]: Use pskb_trim_unique when trimming paged unique skbs

The IPv4/IPv6 datagram output path was using skb_trim to trim paged
packets because they know that the packet has not been cloned yet
(since the packet hasn't been given to anything else in the system).

This broke because skb_trim no longer allows paged packets to be
trimmed.  Paged packets must be given to one of the pskb_trim functions
instead.

This patch adds a new pskb_trim_unique function to cover the IPv4/IPv6
datagram output path scenario and replaces the corresponding skb_trim
calls with it.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: David S. Miller <davem@davemloft.net>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2c31bb0..a1ce843 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1009,6 +1009,21 @@ static inline int pskb_trim(struct sk_bu
 }
 
 /**
+ *	pskb_trim_unique - remove end from a paged unique (not cloned) buffer
+ *	@skb: buffer to alter
+ *	@len: new length
+ *
+ *	This is identical to pskb_trim except that the caller knows that
+ *	the skb is not cloned so we should never get an error due to out-
+ *	of-memory.
+ */
+static inline void pskb_trim_unique(struct sk_buff *skb, unsigned int len)
+{
+	int err = pskb_trim(skb, len);
+	BUG_ON(err);
+}
+
+/**
  *	skb_orphan - orphan a buffer
  *	@skb: buffer to orphan
  *
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index cff9c3a..d987a27 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -946,7 +946,7 @@ alloc_new_skb:
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 
 			copy = datalen - transhdrlen - fraggap;
@@ -1139,7 +1139,7 @@ ssize_t	ip_append_page(struct sock *sk, 
 					data, fraggap, 0);
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 
 			/*
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index e460489..56eddb3 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1047,7 +1047,7 @@ alloc_new_skb:
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 			copy = datalen - transhdrlen - fraggap;
 			if (copy < 0) {
