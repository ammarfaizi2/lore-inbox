Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759294AbWLAJyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759294AbWLAJyI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759297AbWLAJyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:54:08 -0500
Received: from wx-out-0506.google.com ([66.249.82.235]:54727 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1759294AbWLAJyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:54:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lv0YQjLyOY5cZPlfippjaaxCswvrrVqsGkBuD3/PgvyYfw93d4ZurFkwAN3w8bqj02tFq56JOc8a4syNhvt7goRXNLVLSeMXaXANQxOQJX+RUEhDhzBfgGlgu0zZhI5OQGl2bl9DFfAwjQSlnozigei3Dl5VpXtwayJ7V8oH6g0=
Message-ID: <3a5b1be00612010154x60f46757n2af8094d3821c0b3@mail.gmail.com>
Date: Fri, 1 Dec 2006 11:54:05 +0200
From: "Komal Shah" <komal.shah802003@gmail.com>
To: "Paul Jackson" <pj@sgi.com>
Subject: =?ISO-8859-1?Q?Re:_bitmap=AD=5Ffind=5Ffree=5Fregio?= =?ISO-8859-1?Q?n_and_bitmap=5Ffull_arg_doubts?=
Cc: "Paul Mundt" <lethal@linux-sh.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20061130161008.5417c8b4.pj@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <3a5b1be00611300733y121ef089m66bf46852ec0866d@mail.gmail.com>
	 <20061130161008.5417c8b4.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/06, Paul Jackson <pj@sgi.com> wrote:
>
>   M. R. Brown and Paul Mundt -- take a look at the question at end of this post.
>
> Komal wrote:
> >
> > I have attached the test module code. I have confusion about the what
> > to pass as second argument of bitmap_find_free_region for 2nd layer
> > bitmap.
> >
> > Do we have to pass "total size of the block...here 128MB" as the
> > second argument or no. of bits in that block, which 32768 (128 >>
> > PAGE_SHIFT) ?
> >
> > This confusion arised as store queue implementation (sq.c) of sh arch,
> > passes total size of the bitmap (64M) as the second argument instead
> > of bits.
> >
> > Same is the case with bitmap_full, where I have to pass total size of
> > the block (here 128MB) instead of no. of bits, in-order it to make my
> > test module work correctly.
>
> A bitmap is essentially an array of bits.  The bitmap_* routines should
> take a count of how many bits are in the bitmap array (or in your case,
> how many bits are in the segment that you expect to be used in that call.)
>
> So I'm guessing you will be passing L2_BM_BITS for that second argument.
>
> The call to bitmap_find_free_region(), in arch/sh/kernel/cpu/sh4/sq.c
> looks bogus:
>
>         page = bitmap_find_free_region(sq_bitmap, 0x04000000,
>                                        get_order(map->size));
>
> It says the bitmap has 0x04000000 bits.  This would take 0x04000000 / 8
> which is 8388608 (decimal) bytes to hold.  That's an insanely
> huge bitmap - 8 million bytes worth of bits.
>
> I can't make entire sense of the the code you attached.  I get confused
> over the various sizes of maps and what the maps represent, and of bits
> and bytes, and of the two levels.
>
> When you do call bitmap_find_free_region(), you should pass the number
> of bits that are in that segment of the L2 bitmap, which I would guess
> is L2_BM_BITS (32 K).
>
> When you kzalloc() the L2 bitmap for all 16 segments at once, you
> should pass the number of -bytes-, not the number of longs. That is,
> I guess you want to replace your line:
>
>         bm_l2 = kzalloc(size * L1_BM_NUM_SEGS, GFP_KERNEL);
>
> with the line:
>
>         bm_l2 = kzalloc(size * L1_BM_NUM_SEGS * sizeof(long), GFP_KERNEL);
>
> This is because, like most of the *alloc() routines, kzalloc() takes
> a byte count, not a long count.  The related DECLARE_BITMAP() macro
> computes the number of longs, not bytes, but that is because it is
> declaring an array of longs, not allocating a number of bytes.
>
> But I might be entirely confused about what this code is doing.

Oops, forgot to reply on this. This code is just a test module
in-order to go for layered bitmaps and in-turn understand bitmap_*
apis. As I said, requirement was to manage 2GB of virtual space of the
co-processor I have attached with ARM11. Now, as we can't allocate
single bitmap for 2GB, Paul Mundt suggested to have a layered bitmaps,
where 1st bitmap segmenting the virtual space into 128MB blocks and
have 2nd layer 128MB size bitmap for each segment in layer 1 bitmap.
Hope this clarifies the motivation behind it.

-- 
---Komal Shah
http://komalshah.blogspot.com
