Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262568AbUKRFVB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262568AbUKRFVB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 00:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262572AbUKRFVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 00:21:00 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:43688 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262568AbUKRFUx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 00:20:53 -0500
Date: Thu, 18 Nov 2004 06:05:04 +0100
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: hugh@veritas.com, ak@suse.de, 76306.1226@compuserve.com, andrea@novell.com,
       linux-kernel@vger.kernel.org
Subject: Re: Dropped patch: mm/mempolicy.c:sp_lookup()
Message-ID: <20041118050504.GA1478@wotan.suse.de>
References: <20041117111336.608409ef.akpm@osdl.org> <Pine.LNX.4.44.0411171938210.1809-100000@localhost.localdomain> <20041117122123.6162fa70.akpm@osdl.org> <20041117122916.5965f2d5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117122916.5965f2d5.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some optimizations in mempolicy.c (like to avoid rebalancing the tree while
> destroying it and by breaking loops early and not checking for invariant
> conditions in the replace operation).

[...]
> 
> diff -puN mm/mempolicy.c~mempolicy-optimization mm/mempolicy.c
> --- 25/mm/mempolicy.c~mempolicy-optimization	2004-11-17 12:26:40.149947024 -0800
> +++ 25-akpm/mm/mempolicy.c	2004-11-17 12:26:40.153946416 -0800
> @@ -1211,12 +1211,10 @@ restart:
>  						return -ENOMEM;
>  					goto restart;
>  				}
> -				n->end = end;
> +				n->end = start;
>  				sp_insert(sp, new2);
> -				new2 = NULL;
> -			}
> -			/* Old crossing beginning, but not end (easy) */
> -			if (n->start < start && n->end > start)
> +				break;
> +			} else
>  				n->end = start;
>  		}
>  		if (!next)

I'm not quite sure about this one.

> @@ -1270,11 +1268,11 @@ void mpol_free_shared_policy(struct shar
>  	while (next) {
>  		n = rb_entry(next, struct sp_node, nd);
>  		next = rb_next(&n->nd);
> -		rb_erase(&n->nd, &p->root);
>  		mpol_free(n->policy);
>  		kmem_cache_free(sn_cache, n);
>  	}
>  	spin_unlock(&p->lock);
> +	p->root = RB_ROOT;
>  }

This hunk is fine.

-Andi
