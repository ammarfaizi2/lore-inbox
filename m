Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261575AbTJMI5B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 04:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTJMI5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 04:57:01 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:53007 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261575AbTJMI47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 04:56:59 -0400
Date: Mon, 13 Oct 2003 09:56:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Patrick Gefre <pfg@sgi.com>
Cc: linux-kernel@vger.kernel.org, davidm@napali.hpl.hp.com, jbarnes@sgi.com
Subject: Re: [PATCH] Altix I/O code cleanup
Message-ID: <20031013095652.A25495@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Patrick Gefre <pfg@sgi.com>, linux-kernel@vger.kernel.org,
	davidm@napali.hpl.hp.com, jbarnes@sgi.com
References: <3F872984.7877D382@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F872984.7877D382@sgi.com>; from pfg@sgi.com on Fri, Oct 10, 2003 at 04:49:57PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 10, 2003 at 04:49:57PM -0500, Patrick Gefre wrote:
> This is my first patch for this - more to come ....

It would be nice to give those credits who submitted those patches.
And life would be a lot simpler if you wouldn't submit my individual
patches instead of putting them into a big one - this gives useful
entries in the revision history and allows for easier binary search
if something goes wrong.

p.s. the right list for this would probably be linux-ia64@vger.kernel.org

>  
>  void *
> -snia_kmem_zalloc(size_t size, int flag)
> +snia_kmem_zalloc(size_t size)
>  {
>          void *ptr = kmalloc(size, GFP_KERNEL);

passing a gfp_mask down here would make sense..

> - * the alloc/free_node routines do a simple kmalloc for now ..
> - */
> -void *
> -snia_kmem_alloc_node(register size_t size, register int flags, cnodeid_t node)
> -{
> -	/* someday will Allocate on node 'node' */
> -	return(kmalloc(size, GFP_KERNEL));
> -}
> -
> -void *
> -snia_kmem_zalloc_node(register size_t size, register int flags, cnodeid_t node)
> -{
> -	void *ptr = kmalloc(size, GFP_KERNEL);
> -	if ( ptr )
> -		BZERO(ptr, size);
> -        return(ptr);
> -}

Why do you remove the per-nod wrappers?  Unlike the other these actually
had some use as preparation for a node-aware kmalloc..

>  	int rc;
> -	extern void * snia_kmem_zalloc(size_t size, int flag);
> +	extern void * snia_kmem_zalloc(size_t size);

This is in a header, isn't it?

>  
> -	xvolinfo = snia_kmem_zalloc(sizeof(struct xswitch_vol_s), GFP_KERNEL);
> +	xvolinfo = snia_kmem_zalloc(sizeof(struct xswitch_vol_s));

You still need to handle a NULL return here.

>  
> -	intr_hdl = snia_kmem_alloc_node(sizeof(struct hub_intr_s), KM_NOSLEEP, cnode);
> +	intr_hdl = kmalloc(sizeof(struct hub_intr_s), GFP_KERNEL);
>  	ASSERT_ALWAYS(intr_hdl);

NULL return not handled again (and the assert is totally useless)

> -#define NEWAf(ptr,n,f)	(ptr = snia_kmem_zalloc((n)*sizeof (*(ptr)), (f&PCIIO_NOSLEEP)?KM_NOSLEEP:KM_SLEEP))
> -#define NEWA(ptr,n)	(ptr = snia_kmem_zalloc((n)*sizeof (*(ptr)), KM_SLEEP))
> +#define NEWAf(ptr,n,f)	(ptr = snia_kmem_zalloc((n)*sizeof (*(ptr))))
> +#define NEWA(ptr,n)	(ptr = snia_kmem_zalloc((n)*sizeof (*(ptr))))
>  #define DELA(ptr,n)	(kfree(ptr))

What about killing this stupid wrappers while you're at it?
 Also PCIIO_NOSLEEP is never set.

