Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWCVI7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWCVI7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 03:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWCVI7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 03:59:14 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33430 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751125AbWCVI7O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 03:59:14 -0500
Subject: Re: [RFC PATCH 34/35] Add the Xen virtual network device driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com,
       virtualization@lists.osdl.org, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060322063808.464342000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
	 <20060322063808.464342000@sorel.sous-sol.org>
Content-Type: text/plain
Date: Wed, 22 Mar 2006 09:59:09 +0100
Message-Id: <1143017949.2955.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> +#ifdef CONFIG_XEN_BALLOON
> +#include <xen/balloon.h>
> +#endif

such ifdefs are butt-ugly and should be inside the header at least

> +#ifndef __GFP_NOWARN
> +#define __GFP_NOWARN 0
> +#endif

eehhh why?


> +#define alloc_xen_skb(_l) __dev_alloc_skb((_l), GFP_ATOMIC|__GFP_NOWARN)

why does xen need it's own alloc_skb variant?

> +static unsigned long rx_pfn_array[NET_RX_RING_SIZE];
> +static struct multicall_entry rx_mcl[NET_RX_RING_SIZE+1];
> +static struct mmu_update rx_mmu[NET_RX_RING_SIZE];

does this mean you can only have 1 network interface? that sounds silly


> +
> +/* Access macros for acquiring freeing slots in {tx,rx}_skbs[]. */
> +#define ADD_ID_TO_FREELIST(_list, _id)			\
> +	(_list)[(_id)] = (_list)[0];			\
> +	(_list)[0]     = (void *)(unsigned long)(_id);
> +#define GET_ID_FROM_FREELIST(_list)				\
> +	({ unsigned long _id = (unsigned long)(_list)[0];	\
> +	   (_list)[0]  = (_list)[_id];				\
> +	   (unsigned short)_id; })

these should be inlines at leas

> +
> +/** Send a packet on a net device to encourage switches to learn the
> + * MAC. We send a fake ARP request.

why is this inside a driver?????

> +	if (unlikely((((unsigned long)skb->data & ~PAGE_MASK) + skb->len) >=
> +		     PAGE_SIZE)) {
> +		struct sk_buff *nskb;
> +		if (unlikely((nskb = alloc_xen_skb(skb->len)) == NULL))
> +			goto drop;
> +		skb_put(nskb, skb->len);
> +		memcpy(nskb->data, skb->data, skb->len);
> +		nskb->dev = skb->dev;
> +		dev_kfree_skb(skb);
> +		skb = nskb;
> +	}

hmm this smells fishy

> +
> +static int xennet_proc_read(


why is this device driver adding new own /proc crud ?


