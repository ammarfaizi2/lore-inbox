Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966591AbWKYO7j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966591AbWKYO7j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 09:59:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966612AbWKYO7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 09:59:39 -0500
Received: from caramon.arm.linux.org.uk ([217.147.92.249]:65033 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S966591AbWKYO7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 09:59:38 -0500
Date: Sat, 25 Nov 2006 14:59:16 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, Mingming Cao <cmm@us.ibm.com>,
       Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: Boot failure with ext2 and initrds
Message-ID: <20061125145915.GB13089@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Mingming Cao <cmm@us.ibm.com>, Hugh Dickins <hugh@veritas.com>,
	Mel Gorman <mel@skynet.ie>, "Martin J. Bligh" <mbligh@mbligh.org>,
	linux-kernel@vger.kernel.org,
	"linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061114184919.GA16020@skynet.ie> <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com> <20061114113120.d4c22b02.akpm@osdl.org> <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com> <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com> <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com> <20061115232228.afaf42f2.akpm@osdl.org> <20061116123448.GA28311@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061116123448.GA28311@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2006 at 12:34:48PM +0000, Russell King wrote:
> On Wed, Nov 15, 2006 at 11:22:28PM -0800, Andrew Morton wrote:
> > On Wed, 15 Nov 2006 22:55:43 -0800
> > Mingming Cao <cmm@us.ibm.com> wrote:
> > 
> > > Hmm, maxblocks, in bitmap_search_next_usable_block(),  is the end block 
> > > number of the range  to search, not the lengh of the range. maxblocks 
> > > get passed to ext2_find_next_zero_bit(), where it expecting to take the 
> > > _size_ of the range to search instead...
> > > 
> > > Something like this: (this is not a patch)
> > >   @@ -524,7 +524,7 @@ bitmap_search_next_usable_block(ext2_grp
> > >    	ext2_grpblk_t next;
> > > 
> > >    -  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
> > >    +  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks-start + 1, start);
> > > 	if (next >= maxblocks)
> > >    		return -1;
> > >    	return next;
> > >    }
> > 
> > yes, the `size' arg to find_next_zero_bit() represents the number of bits
> > to scan at `offset'.
> 
> Are you sure?  That's not the way it's implemented in many architectures.
> find_next_*_bit() has always taken "address, maximum offset, starting offset"
> and always has returned "next offset".
> 
> Just look at arch/i386/lib/bitops.c:
> 
> int find_next_zero_bit(const unsigned long *addr, int size, int offset)
> {
>         unsigned long * p = ((unsigned long *) addr) + (offset >> 5);
>         int set = 0, bit = offset & 31, res;
> ...
>         /*
>          * No zero yet, search remaining full bytes for a zero
>          */
>         res = find_first_zero_bit (p, size - 32 * (p - (unsigned long *) addr));
>         return (offset + set + res);
> }
> 
> So for the case that "offset" is aligned to a "long" boundary, that gives us:
> 
> 	res = find_first_zero_bit(addr + (offset>>5),
> 			size - 32 * (addr + (offset>>5) - addr));
> 
> or:
> 
> 	res = find_first_zero_bit(addr + (offset>>5), size - (offset & ~31));
> 
> So, size _excludes_ offset.
> 
> Now, considering the return value, "res" above will be relative to
> "addr + (offset>>5)".  However, we add "offset" on to that, so it's
> relative to addr + (offset bits).

Andrew,

Please respond to the above.  If what you say is correct then all
architectures need their bitops fixing to fit ext2's requirements.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
