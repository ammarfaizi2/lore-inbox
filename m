Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261931AbTC0PIE>; Thu, 27 Mar 2003 10:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262999AbTC0PIE>; Thu, 27 Mar 2003 10:08:04 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:41727 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S261931AbTC0PIC>; Thu, 27 Mar 2003 10:08:02 -0500
Date: Thu, 27 Mar 2003 15:21:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] swap 13/13 may_enter_fs?
In-Reply-To: <20030326163145.22c90521.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303271453010.2301-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Mar 2003, Andrew Morton wrote:
> Hugh Dickins <hugh@veritas.com> wrote:
> 
> But this is a much nicer patch.  Thanks for doing all this btw.  I was
> barfing at ?:, not your code ;)

Phew!  I'll make more use of the ;) operator in future then.

> > If we were looking for a correct solution, I don't think backing_dev_info
> > would be the right place: we're talking about GFP_ needed for writepage,
> > which should be specified in the struct address_space filled in by the
> > FS: I think it's more a limitation of the FS than its backing device.
> 
> Good point.

Well, I'm beginning to wonder.

> > +			bdi = mapping->backing_dev_info;
> > +			if (bdi->swap_backed)
> > +				gfp_needed_for_writepage = __GFP_IO;
> > +			else
> > +				gfp_needed_for_writepage = __GFP_FS;
> > +			if (!(gfp_mask & gfp_needed_for_writepage))
> 
> This is inaccurate?  shmem_writepage() performs no IO and could/should be
> called even for GFP_NOIO allocations.

Yes, you're right.  I was going to quibble that we might sometime
change shmem_writepage to call swap_writepage directly, instead of
giving the page another spin round the lru.  But that's not how it
is at present, and I think your GFP_NOIO shmem_writepage is better.

> It's probably not very important but if we're going to make a change it may
> as well be the right one.
> 
> Could you live with
> 
> 	if (bdi->has_special_writepage)
> 		gfp_needed_for_writepage = bfi->gfp_needed_for_writepage;
> 
> ?  So swap_backing_dev_info uses __GFP_IO and shmem_backing_dev_info() (which
> is competely atomic) uses zero?
> 
> Yeah, it's a bit awkward.  I'm OK with the special-casing.  Both swap and
> tmpfs _are_ special, and unique.  Recognising that fact in vmscan.c is
> reasonable.  ->gfp_needed_for_writepage should probably be in the superblock,
> but that's just too far away.

As you say, it's not very important, and I could live with it.
But I'm feeling we've not yet arrived at the right (even contingently
right) answer.  Let's hold off from making any such change for now.

Does a block device writepage need __GFP_FS?  Oh, looks like it uses
bufferheads, that's a sure sign it does, isn't it?

Did mempools make __GFP_IO redundant?  Perhaps for some devices and
not for others.  (mempool_alloc doesn't try the waiting allocation
if __GFP_FS is not set.)

I've a feeling both filesystem and backing device might like to
contribute to the mask.  And it's always worth considering where
loop might fit in with this too (I do have a bdi->over_loop in
one of my loop deadlock patches).

> > -	int memory_backed;	/* Cannot clean pages with writepage */
> > +	unsigned int
> > +		memory_backed:1,/* Do not count its dirty pages in nr_dirty */
> > +		swap_backed:1;	/* Its memory_backed writepage goes to swap */
> >  };
> 
> Hard call.  It is a tradeoff between icache misses and dcache misses. 
> Obviously that is trivia in this case.

Now you've lost me so completely, that I can't even tell if your
icache and dcache here are instruction and data or inode and dentry!

Hugh

