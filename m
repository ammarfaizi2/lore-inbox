Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264245AbTLaKuQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 05:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTLaKuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 05:50:15 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:65439 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264245AbTLaKuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 05:50:09 -0500
Date: Wed, 31 Dec 2003 11:49:48 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "David S. Miller" <davem@redhat.com>
Subject: Re: 2.6.0-rc1-mm1
Message-ID: <20031231104947.GC16860@louise.pinerecords.com>
References: <20031231004725.535a89e4.akpm@osdl.org> <20031231101907.GB16860@louise.pinerecords.com> <20031231024855.0aca5e52.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031231024855.0aca5e52.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-31 2003, Wed, 02:48 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Tomas Szepe <szepe@pinerecords.com> wrote:
> >
> > In file included from include/linux/netfilter_bridge/ebtables.h:16,
> >                  from net/bridge/netfilter/ebtables.c:25:
> > include/linux/netfilter_bridge.h: In function `nf_bridge_maybe_copy_header':
> > include/linux/netfilter_bridge.h:74: error: `ETH_P_8021Q' undeclared (first use in this function)
> 
> This problem also exists in 2.6.1-rc1.

Andrew, are you quite sure this is the correct fix?

What I did was:

--- b/include/linux/netfilter_bridge.h	2003-12-31 11:47:06.000000000 +0100
+++ linux-2.6.0/include/linux/netfilter_bridge.h	2003-12-31 11:46:08.000000000 +0100
@@ -71,10 +71,12 @@
 void nf_bridge_maybe_copy_header(struct sk_buff *skb)
 {
 	if (skb->nf_bridge) {
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 		if (skb->protocol == __constant_htons(ETH_P_8021Q)) {
 			memcpy(skb->data - 18, skb->nf_bridge->hh, 18);
 			skb_push(skb, 4);
 		} else
+#endif
 			memcpy(skb->data - 16, skb->nf_bridge->hh, 16);
 	}
 }
@@ -84,8 +86,10 @@
 {
         int header_size = 16;
 
+#if defined(CONFIG_VLAN_8021Q) || defined(CONFIG_VLAN_8021Q_MODULE)
 	if (skb->protocol == __constant_htons(ETH_P_8021Q))
 		header_size = 18;
+#endif
 
 	memcpy(skb->nf_bridge->hh, skb->data - header_size, header_size);
 }
