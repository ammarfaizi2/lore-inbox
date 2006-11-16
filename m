Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424424AbWKPUPW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424424AbWKPUPW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 15:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424404AbWKPUPW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 15:15:22 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:14794 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1424396AbWKPUPV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 15:15:21 -0500
Subject: Re: Boot failure with ext2 and initrds
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <20061116011351.1401a00f.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 16 Nov 2006 12:15:16 -0800
Message-Id: <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-16 at 01:13 -0800, Andrew Morton wrote:
> On Thu, 16 Nov 2006 00:49:20 -0800
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> > On Wed, 2006-11-15 at 23:22 -0800, Andrew Morton wrote:
> > > On Wed, 15 Nov 2006 22:55:43 -0800
> > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > 
> > > > Hmm, maxblocks, in bitmap_search_next_usable_block(),  is the end block 
> > > > number of the range  to search, not the lengh of the range. maxblocks 
> > > > get passed to ext2_find_next_zero_bit(), where it expecting to take the 
> > > > _size_ of the range to search instead...
> > > > 
> > > > Something like this: (this is not a patch)
> > > >   @@ -524,7 +524,7 @@ bitmap_search_next_usable_block(ext2_grp
> > > >    	ext2_grpblk_t next;
> > > > 
> > > >    -  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
> > > >    +  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks-start + 1, start);
> > > > 	if (next >= maxblocks)
> > > >    		return -1;
> > > >    	return next;
> > > >    }
> > > 
> > > yes, the `size' arg to find_next_zero_bit() represents the number of bits
> > > to scan at `offset'.
> > > 
> > > So I think your change is correctish.  But we don't want the "+ 1", do we?
> > > 
> > I think we still need the "+1", maxblocks here is the ending block of
> > the reservation window, so the number of bits to scan =end-start+1.
> > 
> > > If we're right then this bug could cause the code to scan off the end of the
> > > bitmap.  But it won't explain Hugh's bug, because of the if (next >= maxblocks).
> > > 
> > 
> > Yeah.. at first I thought it might be related, then, thinked it over,
> > the bug only makes the bits to scan larger, so if find_next_zero_bit()
> > returns something off the end of bitmap, that is fine, it just
> > indicating that there is no free bit left in the rest of bitmap, which
> > is expected behavior. So bitmap_search_next_usable_block() fail is the
> > expected. It will move on to next block group and try to create a new
> > reservation window there.
> 
> I wonder why it's never oopsed.  Perhaps there's always a zero in there for
> some reason.
> 

Why you think it should oopsed?  Even if find_next_zero_bit() finds a
zero bit beyond of the end of bitmap, the check next > maxblocks will
catch this and make sure we are not taking a zero bit out of the bitmap
range, so it fails as expected.

> > That does not explain the repeated reservation window add and remove
> > behavior Huge has reported. 
> 
> I spent quite some time comparing with ext3.  I'm a bit stumped and I'm
> suspecting that the simplistic porting the code is now OK, but something's
> just wrong.
> 
> I assume that the while (1) loop in ext3_try_to_allocate_with_rsv() has
> gone infinite.  I don't see why, but more staring is needed.
> 

The loop should not go forever, it will stops when there is no window
with free bit to reserve in the given block group.

> What lock protects the fields in struct ext[234]_reserve_window from being
> concurrently modified by two CPUs?  None, it seems.  Ditto
> ext[234]_reserve_window_node.  i_mutex will cover it for write(), but not
> for pageout over a file hole.  If we end up with a zero- or negative-sized
> window then odd things might happen.
> 

Yes, trucate_mutex protect both struct ext[234]_reserve_window and ext
[234]_reserve_window_node, and struct ext[234]_block_alloc_info.
Actually I think truncate_mutex protects all data structures related to
block allocation/mapping structures.



Mingming

