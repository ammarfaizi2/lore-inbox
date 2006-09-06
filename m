Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964895AbWIFXBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWIFXBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbWIFXA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:00:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:58315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751802AbWIFXAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:00:52 -0400
Date: Wed, 6 Sep 2006 15:55:07 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Herbert Xu <herbert@gondor.apana.org.au>,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 03/37] Fix output framentation of paged-skbs
Message-ID: <20060906225507.GD15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-output-framentation-of-paged-skbs.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Herbert Xu <herbert@gondor.apana.org.au>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/linux/skbuff.h |   15 +++++++++++++++
 net/ipv4/ip_output.c   |    4 ++--
 net/ipv6/ip6_output.c  |    2 +-
 3 files changed, 18 insertions(+), 3 deletions(-)

--- linux-2.6.17.11.orig/include/linux/skbuff.h
+++ linux-2.6.17.11/include/linux/skbuff.h
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
--- linux-2.6.17.11.orig/net/ipv4/ip_output.c
+++ linux-2.6.17.11/net/ipv4/ip_output.c
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
--- linux-2.6.17.11.orig/net/ipv6/ip6_output.c
+++ linux-2.6.17.11/net/ipv6/ip6_output.c
@@ -1047,7 +1047,7 @@ alloc_new_skb:
 				skb_prev->csum = csum_sub(skb_prev->csum,
 							  skb->csum);
 				data += fraggap;
-				skb_trim(skb_prev, maxfraglen);
+				pskb_trim_unique(skb_prev, maxfraglen);
 			}
 			copy = datalen - transhdrlen - fraggap;
 			if (copy < 0) {

--
