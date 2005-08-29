Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVH2BT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVH2BT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Aug 2005 21:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbVH2BT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Aug 2005 21:19:58 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:12687 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1751125AbVH2BT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Aug 2005 21:19:58 -0400
Subject: Re: [PATCH] make radix tree gang lookup faster by using a bitmap
	search
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050828175233.61cada23.akpm@osdl.org>
References: <1125159996.5159.8.camel@mulgrave>
	 <20050827105355.360bd26a.akpm@osdl.org> <1125276312.5048.22.camel@mulgrave>
	 <20050828175233.61cada23.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 28 Aug 2005 20:19:49 -0500
Message-Id: <1125278389.5048.30.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-08-28 at 17:52 -0700, Andrew Morton wrote:
> > +#if BITS_PER_LONG == 32
> > +#define RADIX_TREE_MAP_SHIFT	5
> > +#elif BITS_PER_LONG == 64
> > ...
> >  struct radix_tree_node {
> > -	unsigned int	count;
> >  	void		*slots[RADIX_TREE_MAP_SIZE];
> > -	unsigned long	tags[RADIX_TREE_TAGS][RADIX_TREE_TAG_LONGS];
> > +	unsigned long	tags[RADIX_TREE_TAGS];
> >  };
> 
> I don't see why the above change was necessary?  Why not stick with the
> current more flexible sizing option?
> 
> Note that the RADIX_TREE_MAP_FULL trick can still be used.  It just has to
> be put inside a `for (idx = 0; idx < RADIX_TREE_TAG_LONGS; idx++)' loop,
> which will vanish if RADIX_TREE_TAG_LONGS==1.

Well ... It's my opinion (and purely unsubstantiated, I suppose) that
it's more efficient on 32 bit platforms to do bit operations on 32 bit
quantities, which is why I changed the radix tree map shift to 5 for
that case.

It also makes much cleaner code than having to open code checks on
variable sized bitmaps.

James


