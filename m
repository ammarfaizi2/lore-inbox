Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030288AbVIVMtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030288AbVIVMtt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 08:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbVIVMts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 08:49:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8107 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030285AbVIVMts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 08:49:48 -0400
Date: Thu, 22 Sep 2005 13:49:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Christoph Lameter <clameter@engr.sgi.com>,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       netfilter-devel@lists.netfilter.org, netdev@vger.kernel.org, ak@suse.de
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
Message-ID: <20050922124941.GA26936@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Eric Dumazet <dada1@cosmosbay.com>,
	Christoph Lameter <clameter@engr.sgi.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
	netdev@vger.kernel.org, ak@suse.de
References: <43308324.70403@cosmosbay.com> <4331CFA7.50104@cosmosbay.com> <Pine.LNX.4.62.0509211542210.13045@schroedinger.engr.sgi.com> <20050921.173408.122945960.davem@davemloft.net> <Pine.LNX.4.62.0509211843530.13764@schroedinger.engr.sgi.com> <43329F6E.3030706@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43329F6E.3030706@cosmosbay.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 02:11:26PM +0200, Eric Dumazet wrote:
> +#ifdef CONFIG_NUMA
> +/**
> + * vmalloc_node - allocate virtually contiguous memory
> + *
> + *	@size:		allocation size
> + *	@node:		preferred node
> + *
> + * This vmalloc variant try to allocate memory from a preferred node.
> + */
> +void *vmalloc_node(unsigned long size, int node)
> +{
> +	void *result;
> +	struct mempolicy *oldpol = current->mempolicy;
> +	mm_segment_t oldfs = get_fs();
> +	DECLARE_BITMAP(prefnode, MAX_NUMNODES);
> +
> +	mpol_get(oldpol);
> +	bitmap_zero(prefnode, MAX_NUMNODES);
> +	set_bit(node, prefnode);
> +
> +	set_fs(KERNEL_DS);
> +	sys_set_mempolicy(MPOL_PREFERRED, prefnode, MAX_NUMNODES);
> +	set_fs(oldfs);
> +
> +	result = vmalloc(size);
> +
> +	mpol_free(current->mempolicy);
> +	current->mempolicy = oldpol;
> +	return result;
> +}

No way, sorry.  If you want a vmalloc node do it right.

