Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030294AbVIVM64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030294AbVIVM64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030292AbVIVM64
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:58:56 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:32147 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030294AbVIVM6z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:58:55 -0400
Date: Thu, 22 Sep 2005 13:58:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andi Kleen <ak@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, Eric Dumazet <dada1@cosmosbay.com>,
       Christoph Lameter <clameter@engr.sgi.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050922125849.GA27413@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andi Kleen <ak@suse.de>, Eric Dumazet <dada1@cosmosbay.com>,
	Christoph Lameter <clameter@engr.sgi.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
	netdev@vger.kernel.org
References: <43308324.70403@cosmosbay.com> <43329F6E.3030706@cosmosbay.com> <20050922124941.GA26936@infradead.org> <200509221454.22923.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509221454.22923.ak@suse.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 02:54:22PM +0200, Andi Kleen wrote:
> > > +void *vmalloc_node(unsigned long size, int node)
> > > +{
> > > +	void *result;
> > > +	struct mempolicy *oldpol = current->mempolicy;
> > > +	mm_segment_t oldfs = get_fs();
> > > +	DECLARE_BITMAP(prefnode, MAX_NUMNODES);
> > > +
> > > +	mpol_get(oldpol);
> > > +	bitmap_zero(prefnode, MAX_NUMNODES);
> > > +	set_bit(node, prefnode);
> > > +
> > > +	set_fs(KERNEL_DS);
> > > +	sys_set_mempolicy(MPOL_PREFERRED, prefnode, MAX_NUMNODES);
> > > +	set_fs(oldfs);
> > > +
> > > +	result = vmalloc(size);
> > > +
> > > +	mpol_free(current->mempolicy);
> > > +	current->mempolicy = oldpol;
> > > +	return result;
> > > +}
> >
> > No way, sorry.  If you want a vmalloc node do it right.
> 
> The implementation looks fine to me, so I think it's already right.

Umm, no - adding set_fs/get_fs mess for things like that is not right.
If we want to go down the mempolicy-based route we need to add a proper
kernel entry point for setting a mempolicy
