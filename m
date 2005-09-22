Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030293AbVIVMyq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030293AbVIVMyq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVIVMyq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:54:46 -0400
Received: from ns2.suse.de ([195.135.220.15]:56041 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030289AbVIVMyp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:54:45 -0400
From: Andi Kleen <ak@suse.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Date: Thu, 22 Sep 2005 14:54:22 +0200
User-Agent: KMail/1.8
Cc: Eric Dumazet <dada1@cosmosbay.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
References: <43308324.70403@cosmosbay.com> <43329F6E.3030706@cosmosbay.com> <20050922124941.GA26936@infradead.org>
In-Reply-To: <20050922124941.GA26936@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509221454.22923.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 22 September 2005 14:49, Christoph Hellwig wrote:
> On Thu, Sep 22, 2005 at 02:11:26PM +0200, Eric Dumazet wrote:
> > +#ifdef CONFIG_NUMA
> > +/**
> > + * vmalloc_node - allocate virtually contiguous memory
> > + *
> > + *	@size:		allocation size
> > + *	@node:		preferred node
> > + *
> > + * This vmalloc variant try to allocate memory from a preferred node.
> > + */
> > +void *vmalloc_node(unsigned long size, int node)
> > +{
> > +	void *result;
> > +	struct mempolicy *oldpol = current->mempolicy;
> > +	mm_segment_t oldfs = get_fs();
> > +	DECLARE_BITMAP(prefnode, MAX_NUMNODES);
> > +
> > +	mpol_get(oldpol);
> > +	bitmap_zero(prefnode, MAX_NUMNODES);
> > +	set_bit(node, prefnode);
> > +
> > +	set_fs(KERNEL_DS);
> > +	sys_set_mempolicy(MPOL_PREFERRED, prefnode, MAX_NUMNODES);
> > +	set_fs(oldfs);
> > +
> > +	result = vmalloc(size);
> > +
> > +	mpol_free(current->mempolicy);
> > +	current->mempolicy = oldpol;
> > +	return result;
> > +}
>
> No way, sorry.  If you want a vmalloc node do it right.

The implementation looks fine to me, so I think it's already right.

-Andi
