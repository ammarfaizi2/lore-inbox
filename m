Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315192AbSFOAAX>; Fri, 14 Jun 2002 20:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315198AbSFOAAX>; Fri, 14 Jun 2002 20:00:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13066 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315192AbSFOAAW>;
	Fri, 14 Jun 2002 20:00:22 -0400
Message-ID: <3D0A833E.3C396756@zip.com.au>
Date: Fri, 14 Jun 2002 16:58:54 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO 
 simplification
In-Reply-To: <200206142339.QAA27000@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
> Andrew Morton <akpm@zip.com.au> wrote:
> >I have not yet seen a BIO allocation failure in testing.  This
> >would indicate that either the BIO pool is too large, or I'm
> >running the wrong tests.  Either way, I don't think we have
> >demonstrated any otherwise-unsolvable problems with BIO allocation.
> 
>         You need to prove that this can never happen once the
> device is initialized, not just that no 2.5 user has reported it
> yet.

BIOs for reads are allocated with GFP_KERNEL - both mpage_readpages
and mpage_readpage.

They used to be allocated GFP_NOIO.  This is a subtle but significant
improvement which came in when we stopped using submit_bh for bulk reads.
It means that the only time we threaten the memory reserves is when
allocating BIOs for writes.  And those BIOs free more memory than they
consume.  This, plus the PF_MEMALLOC reserves which the radix-tree
allocator leaves behind makes us pretty robust.

A poorly-written gigE driver could zoom in and steal the remaining
few megabytes from interrupt context.  But even then, the BIO mempools
would have to be exhausted at the time.  And I don't see a way in which
they can be exhausted without us having write BIOs in flight.

No, I can't prove it.  But I can't think of a contrary scenario
either.

> >What bugs me about your approach is this:  I have been gradually
> >nudging the kernel's IO paths away from enormously-long per-page
> >call paths and per-page locking into the direction of a sequence
> >of short little loops, each of which does the same stuff against
> >a bunch of pages.
> 
>         You need to reread the last paragraph of my previous post.
> I have added some capitalization to help:
> 
> >>      I think I would be happy enough with your approach, but, just
> >>to eliminate possibilities of memory allocation failure, I think I
> >>want to still have some kind of bio_chain, perhaps without the merge
> >>hinting, BUT WITH A PARAMETER TO ALLOW FOR ALLOCATING A BIO UP TO THE
> >>SIZE OF OLDBIO, like so:
> >>
> >>struct bio *bio_chain(struct bio *oldbio, int gfp_mask,
> >>                     int nvecs /* <= oldbio->bi_max */);
> 
>         This would not interfere with your plans try to do things
> in n page chunks.

OK, the caps helped ;)

-
