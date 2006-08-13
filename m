Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWHMNAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWHMNAF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 09:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751178AbWHMNAB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 09:00:01 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:41738 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1751172AbWHMNAA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 09:00:00 -0400
Date: Sun, 13 Aug 2006 22:59:11 +1000
To: "David S. Miller" <davem@davemloft.net>, Greg KH <greg@kroah.com>,
       Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>,
       netdev@vger.kernel.org
Subject: Re: [2.6.17.8] NFS stall / BUG in UDP fragment processing / SKB trimming
Message-ID: <20060813125910.GA18463@gondor.apana.org.au>
References: <87zme9fy94.fsf@hades.wkstn.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zme9fy94.fsf@hades.wkstn.nix>
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2006 at 09:19:19PM +0000, Nix wrote:
> 
> The kernel log showed a heap of BUGs from somewhere inside the skb
> management layer, somewhere in UDP fragment processing while
> handling NFS requests. It starts like this:
> 
> Aug 12 21:31:08 hades warning: kernel: BUG: warning at include/linux/skbuff.h:975/__skb_trim()
> Aug 12 21:31:08 hades warning: kernel: <c030ed39> ip_append_data+0x5b3/0x951  <c030fc18> ip_generic_getfrag+0x0/0x96

Oops, I missed this code path when I disallowed skb_trim from operating
on a paged skb.  This patch should fix the problem.

Greg, we need this for 2.6.17 stable as well if Dave is OK with it.

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

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 19c96d4..7f99995 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1040,6 +1040,21 @@ static inline int pskb_trim(struct sk_bu
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
index 9bf307a..4c20f55 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -947,7 +947,7 @@ alloc_new_skb:
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 
 			copy = datalen - transhdrlen - fraggap;
@@ -1142,7 +1142,7 @@ ssize_t	ip_append_page(struct sock *sk, 
 					data, fraggap, 0);
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 
 			/*
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 69451af..4fb47a2 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -1095,7 +1095,7 @@ alloc_new_skb:
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 			copy = datalen - transhdrlen - fraggap;
 			if (copy < 0) {
