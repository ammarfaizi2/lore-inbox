Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbVH2BhH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbVH2BhH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 21:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbVH2BhH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 21:37:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:59583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751166AbVH2BhG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 21:37:06 -0400
Date: Sun, 28 Aug 2005 18:35:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
 search
Message-Id: <20050828183531.0b4d6f2d.akpm@osdl.org>
In-Reply-To: <1125278389.5048.30.camel@mulgrave>
References: <1125159996.5159.8.camel@mulgrave>
	<20050827105355.360bd26a.akpm@osdl.org>
	<1125276312.5048.22.camel@mulgrave>
	<20050828175233.61cada23.akpm@osdl.org>
	<1125278389.5048.30.camel@mulgrave>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> wrote:
>
> On Sun, 2005-08-28 at 17:52 -0700, Andrew Morton wrote:
> > > +#if BITS_PER_LONG == 32
> > > +#define RADIX_TREE_MAP_SHIFT	5
> > > +#elif BITS_PER_LONG == 64
> > > ...
> > >  struct radix_tree_node {
> > > -	unsigned int	count;
> > >  	void		*slots[RADIX_TREE_MAP_SIZE];
> > > -	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
> > > +	unsigned long	tags[RADIX_TREE_TAGS];
> > >  };
> > 
> > I don't see why the above change was necessary?  Why not stick with the
> > current more flexible sizing option?
> > 
> > Note that the RADIX_TREE_MAP_FULL trick can still be used.  It just has to
> > be put inside a `for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++)' loop,
> > which will vanish if RADIX_TREE_TAG_LONGS==1.
> 
> Well ... It's my opinion (and purely unsubstantiated, I suppose) that
> it's more efficient on 32 bit platforms to do bit operations on 32 bit
> quantities, which is why I changed the radix tree map shift to 5 for
> that case.
> 
> It also makes much cleaner code than having to open code checks on
> variable sized bitmaps.
> 

It does make the tree higher and hence will incur some more cache missing
when descending the tree.

We changed the node size a few years back.  umm.... 
http://www.ussg.iu.edu/hypermail/linux/kernel/0206.2/0141.html

It would be a little bit sad to be unable to make such tuning adjustments
in the future.  Not a huge loss, but a loss.
