Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVHAO22@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVHAO22 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 10:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261878AbVHAO20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 10:28:26 -0400
Received: from [62.206.217.67] ([62.206.217.67]:45803 "EHLO kaber.coreworks.de")
	by vger.kernel.org with ESMTP id S261842AbVHAO1u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 10:27:50 -0400
Message-ID: <42EE3169.6070604@trash.net>
Date: Mon, 01 Aug 2005 16:27:53 +0200
From: Patrick McHardy <kaber@trash.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.8) Gecko/20050514 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mattia Dongili <malattia@gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       "David S. Miller" <davem@davemloft.net>
Subject: Re: BUG: atomic counter underflow at ip_conntrack_event_cache_init+0x91/0xb0
 (with patch)
References: <20050801141327.GA3909@inferi.kami.home>
In-Reply-To: <20050801141327.GA3909@inferi.kami.home>
Content-Type: multipart/mixed;
 boundary="------------070607080204070300000801"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070607080204070300000801
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Mattia Dongili wrote:
> Hello,
> 
> got this one while trying out 2.6.13-rc4-mm1 (not there in -r2-mm1),
> from a quick look it seems to me that ip_conntrack_{get,put} are not
> simmetric in updating the use count, thus simply adding this line might
> help (it does actually, but I'm not aware if there could be any drawback):
> 
> --- include/linux/netfilter_ipv4/ip_conntrack.h.clean	2005-08-01 15:09:49.000000000 +0200
> +++ include/linux/netfilter_ipv4/ip_conntrack.h	2005-08-01 15:08:52.000000000 +0200
> @@ -298,6 +298,7 @@ static inline struct ip_conntrack *
>  ip_conntrack_get(const struct sk_buff *skb, enum ip_conntrack_info *ctinfo)
>  {
>  	*ctinfo = skb->nfctinfo;
> +	nf_conntrack_get(skb->nfct);
>  	return (struct ip_conntrack *)skb->nfct;
>  }

This creates lots of refcnt leaks, which is probably why it makes the
underflow go away :) Please try this patch instead.


--------------070607080204070300000801
Content-Type: text/plain;
 name="x"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="x"

[NETFILTER]: Fix refcnt underflow in ip_conntrack_event_cache_init

Signed-off-by: Patrick McHardy <kaber@trash.net>

---
commit 5d55b8c6bfba6e6e2ffe26c2a2e2561e278428b7
tree d43366a793d2fa3058c15a752010ef0fd22894cc
parent df2e0392536ecdd6385f4319f746045fd6fae38f
author Patrick McHardy <kaber@trash.net> Mon, 01 Aug 2005 16:25:53 +0200
committer Patrick McHardy <kaber@trash.net> Mon, 01 Aug 2005 16:25:53 +0200

 net/ipv4/netfilter/ip_conntrack_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/ipv4/netfilter/ip_conntrack_core.c b/net/ipv4/netfilter/ip_conntrack_core.c
--- a/net/ipv4/netfilter/ip_conntrack_core.c
+++ b/net/ipv4/netfilter/ip_conntrack_core.c
@@ -146,6 +146,7 @@ void ip_conntrack_event_cache_init(const
 
 		/* initialize for this conntrack/packet */
 		ecache->ct = ip_conntrack_get(skb, &ctinfo);
+		nf_conntrack_get(&ecache->ct->ct_general);
 		/* ecache->events cleared by __deliver_cached_devents() */
 	} else {
 		DEBUGP("ecache: re-entered for conntrack %p.\n", ct);

--------------070607080204070300000801--
