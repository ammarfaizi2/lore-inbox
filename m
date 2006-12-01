Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031627AbWLAAKW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031627AbWLAAKW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 19:10:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031625AbWLAAKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 19:10:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:3766 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1031627AbWLAAKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 19:10:19 -0500
Date: Thu, 30 Nov 2006 16:10:08 -0800
From: Paul Jackson <pj@sgi.com>
To: "Komal Shah" <komal.shah802003@gmail.com>,
       Paul Mundt <lethal@linux-sh.org>, "M. R. Brown" <mrbrown@0xd6.org>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, lethal@linux-sh.org
Subject: Re: =?ISO-8859-1?B?Yml0bWFwrV9maW5kX2ZyZWVfcmVnaW9u?= and
 bitmap_full arg doubts
Message-Id: <20061130161008.5417c8b4.pj@sgi.com>
In-Reply-To: <3a5b1be00611300733y121ef089m66bf46852ec0866d@mail.gmail.com>
References: <3a5b1be00611300733y121ef089m66bf46852ec0866d@mail.gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  M. R. Brown and Paul Mundt -- take a look at the question at end of this post.

Komal wrote:
> 
> I have attached the test module code. I have confusion about the what
> to pass as second argument of bitmap_find_free_region for 2nd layer
> bitmap.
> 
> Do we have to pass "total size of the block...here 128MB" as the
> second argument or no. of bits in that block, which 32768 (128 >>
> PAGE_SHIFT) ?
> 
> This confusion arised as store queue implementation (sq.c) of sh arch,
> passes total size of the bitmap (64M) as the second argument instead
> of bits.
> 
> Same is the case with bitmap_full, where I have to pass total size of
> the block (here 128MB) instead of no. of bits, in-order it to make my
> test module work correctly.

A bitmap is essentially an array of bits.  The bitmap_* routines should
take a count of how many bits are in the bitmap array (or in your case,
how many bits are in the segment that you expect to be used in that call.)

So I'm guessing you will be passing L2_BM_BITS for that second argument.

The call to bitmap_find_free_region(), in arch/sh/kernel/cpu/sh4/sq.c
looks bogus:

        page = bitmap_find_free_region(sq_bitmap, 0x04000000,
                                       get_order(map->size));

It says the bitmap has 0x04000000 bits.  This would take 0x04000000 / 8
which is 8388608 (decimal) bytes to hold.  That's an insanely
huge bitmap - 8 million bytes worth of bits.

I can't make entire sense of the the code you attached.  I get confused 
over the various sizes of maps and what the maps represent, and of bits 
and bytes, and of the two levels.

When you do call bitmap_find_free_region(), you should pass the number
of bits that are in that segment of the L2 bitmap, which I would guess
is L2_BM_BITS (32 K).

When you kzalloc() the L2 bitmap for all 16 segments at once, you
should pass the number of -bytes-, not the number of longs. That is,
I guess you want to replace your line:

	bm_l2 = kzalloc(size * L1_BM_NUM_SEGS, GFP_KERNEL);

with the line:

	bm_l2 = kzalloc(size * L1_BM_NUM_SEGS * sizeof(long), GFP_KERNEL);

This is because, like most of the *alloc() routines, kzalloc() takes
a byte count, not a long count.  The related DECLARE_BITMAP() macro
computes the number of longs, not bytes, but that is because it is
declaring an array of longs, not allocating a number of bytes.

But I might be entirely confused about what this code is doing.

If this code is to become a kernel patch proposal, it will take some
work to make it easier to understand.

See also the code and comments in lib/bitmap.c for the routine
bitmap_find_free_region() to see what it is doing.

And, as I noted above, I suspect that the arch sh code using
these bitmap routines is seriously wrong, and will blow up if
ever asked to handle the harder, more full, cases.

M. R. Brown and Paul Mundt - looks like you two are listed as authors
for that sh arch code for "SH-4 integrated Store Queues".

Could you take a look at it, and see whether it is that code, or my
brain, that is on drugs?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
