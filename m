Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130032AbRCAVIM>; Thu, 1 Mar 2001 16:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130043AbRCAVIF>; Thu, 1 Mar 2001 16:08:05 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:35480 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S130032AbRCAVHe>;
	Thu, 1 Mar 2001 16:07:34 -0500
Date: Thu, 1 Mar 2001 16:07:32 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Roman Zippel <zippel@fh-brandenburg.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, gator@cs.tu-berlin.de,
        linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] Re: fat problem in 2.4.2
In-Reply-To: <Pine.GSO.4.10.10103012147490.19829-100000@zeus.fh-brandenburg.de>
Message-ID: <Pine.GSO.4.21.0103011600540.11577-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 1 Mar 2001, Roman Zippel wrote:

> Hi,
> 
> On Thu, 1 Mar 2001, Alexander Viro wrote:
> 
> > +static int generic_vm_expand(struct address_space *mapping, loff_t size)
> > +{
> > +	struct page *page;
> > +	unsigned long index, offset;
> > +	int err;
> > +
> > +	if (!mapping->a_ops->prepare_write || !mapping->a_ops->commit_write)
> > +		return -ENOSYS;
> > +
> > +	offset = (size & (PAGE_CACHE_SIZE-1)); /* Within page */
> > +	index = size >> PAGE_CACHE_SHIFT;
> 
> For affs I did basically the same with a small difference:
> 
> 	offset = ((size-1) & (PAGE_CACHE_SIZE-1)) + 1;
> 	index = (size-1) >> PAGE_CACHE_SHIFT;
> 
> That works fine here and allocates a page in the cache more likely to be
> used.

	The only difference is in the case when size is a multiple of
PAGE_CACHE_SHIFT, so most of the time it's the same, but yeah, this
variant is probably nicer.

	The problem with putting it into ->truncate() is obvious -
handling errors. And doing the thing before vmtruncate() (in
foo_notify_change(), whatever) is also PITA - you need to
reproduce the rlimit handling. Not nice...

	IOW, if it's worth doing at all it probably should be
on expanding path in vmtruncate() - limit checks are already
done, but old i_size is still not lost...
							Cheers,
								Al

