Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263048AbUKTCqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263048AbUKTCqE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 21:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263089AbUKTCpC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:45:02 -0500
Received: from mx1.redhat.com ([66.187.233.31]:46022 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263051AbUKTCLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:11:13 -0500
Date: Fri, 19 Nov 2004 21:11:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Ian Pratt <Ian.Pratt@cl.cam.ac.uk>
cc: linux-kernel@vger.kernel.org, <Steven.Hand@cl.cam.ac.uk>,
       <Christian.Limpach@cl.cam.ac.uk>, <Keir.Fraser@cl.cam.ac.uk>,
       <davem@redhat.com>
Subject: Re: [6/7] Xen VMM patch set : add alloc_skb_from_cache
In-Reply-To: <E1CVI7o-0004cT-00@mta1.cl.cam.ac.uk>
Message-ID: <Xine.LNX.4.44.0411192103150.12779-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Nov 2004, Ian Pratt wrote:

> +	/* Get the DATA. */
> +	size = SKB_DATA_ALIGN(size);
> +	data = kmem_cache_alloc(cp, gfp_mask);
> +	if (!data)
> +		goto nodata;
> +
> +	memset(skb, 0, offsetof(struct sk_buff, truesize));
> +	skb->truesize = size + sizeof(struct sk_buff);
> +	atomic_set(&skb->users, 1);
> +	skb->head = data;
> +	skb->data = data;
> +	skb->tail = data;
> +	skb->end  = data + size;
> +
> +	atomic_set(&(skb_shinfo(skb)->dataref), 1);
> +	skb_shinfo(skb)->nr_frags  = 0;
> +	skb_shinfo(skb)->tso_size = 0;
> +	skb_shinfo(skb)->tso_segs = 0;
> +	skb_shinfo(skb)->frag_list = NULL;
> +out:
> +	return skb;
> +nodata:
> +	kmem_cache_free(skbuff_head_cache, skb);
> +	skb = NULL;
> +	goto out;
> +}
> +

Most of this is duplicated code with alloc_skb(), perhaps make a function:

  __alloc_skb(size, gfp_mask, alloc_func)

Then alloc_skb() and alloc_skb_from_cache() can just be wrappers which
pass in different alloc_funcs.  I'm not sure what peformance impact this
might have though.

Thoughts?


- James
-- 
James Morris
<jmorris@redhat.com>


