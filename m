Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVH2AyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVH2AyK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 20:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbVH2AyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 20:54:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9914 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751044AbVH2AyI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 20:54:08 -0400
Date: Sun, 28 Aug 2005 17:52:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
Message-Id: <20050828175233.61cada23.akpm@osdl.org>
In-Reply-To: <1125276312.5048.22.camel@mulgrave>
References: <1125159996.5159.8.camel@mulgrave>
	<20050827105355.360bd26a.akpm@osdl.org>
	<1125276312.5048.22.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Sat, 2005-08-27 at 10:53 -0700, Andrew Morton wrote:
> > a) fix radix_tree_gang_lookup() to use find_next_bit()
> > 
> > b) remove radix_tree_node.count
> > 
> > c) Add a new tag field which simply means "present"
> > 
> > d) remove radix_tree_gang_lookup() and __lookup() altogether
> > 
> > e) Implement radix_tree_gang_lookup() via radix_tree_gang_lookup_tag()
> 
> OK, here it is: the combined version which treats the present bits as a
> private tag, combines __lookup and __lookup_tag and does a fast bitmap
> search for both.
>
> ...
>
> +#if BITS_PER_LONG == 32
> +#define RADIX_TREE_MAP_SHIFT	5
> +#elif BITS_PER_LONG == 64
> ...
>  struct radix_tree_node {
> -	unsigned int	count;
>  	void		*slots[RADIX_TREE_MAP_SIZE];
> -	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
> +	unsigned long	tags[RADIX_TREE_TAGS];
>  };

I don't see why the above change was necessary?  Why not stick with the
current more flexible sizing option?

Note that the RADIX_TREE_MAP_FULL trick can still be used.  It just has to
be put inside a `for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++)' loop,
which will vanish if RADIX_TREE_TAG_LONGS==1.

