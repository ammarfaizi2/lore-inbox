Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161976AbWKPIt2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161976AbWKPIt2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 03:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161974AbWKPIt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 03:49:28 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:39846 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161382AbWKPIt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 03:49:27 -0500
Subject: Re: Boot failure with ext2 and initrds
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>
Cc: Hugh Dickins <hugh@veritas.com>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <20061115232228.afaf42f2.akpm@osdl.org>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Thu, 16 Nov 2006 00:49:20 -0800
Message-Id: <1163666960.4310.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 23:22 -0800, Andrew Morton wrote:
> On Wed, 15 Nov 2006 22:55:43 -0800
> Mingming Cao <cmm@us.ibm.com> wrote:
> 
> > Hmm, maxblocks, in bitmap_search_next_usable_block(),  is the end block 
> > number of the range  to search, not the lengh of the range. maxblocks 
> > get passed to ext2_find_next_zero_bit(), where it expecting to take the 
> > _size_ of the range to search instead...
> > 
> > Something like this: (this is not a patch)
> >   @@ -524,7 +524,7 @@ bitmap_search_next_usable_block(ext2_grp
> >    	ext2_grpblk_t next;
> > 
> >    -  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks, start);
> >    +  	next = ext2_find_next_zero_bit(bh->b_data, maxblocks-start + 1, start);
> > 	if (next >= maxblocks)
> >    		return -1;
> >    	return next;
> >    }
> 
> yes, the `size' arg to find_next_zero_bit() represents the number of bits
> to scan at `offset'.
> 
> So I think your change is correctish.  But we don't want the "+ 1", do we?
> 
I think we still need the "+1", maxblocks here is the ending block of
the reservation window, so the number of bits to scan =end-start+1.

> If we're right then this bug could cause the code to scan off the end of the
> bitmap.  But it won't explain Hugh's bug, because of the if (next >= maxblocks).
> 

Yeah.. at first I thought it might be related, then, thinked it over,
the bug only makes the bits to scan larger, so if find_next_zero_bit()
returns something off the end of bitmap, that is fine, it just
indicating that there is no free bit left in the rest of bitmap, which
is expected behavior. So bitmap_search_next_usable_block() fail is the
expected. It will move on to next block group and try to create a new
reservation window there.

That does not explain the repeated reservation window add and remove
behavior Huge has reported. 

> btw, how come try_to_extend_reservation() uses spin_trylock?

Since locks are all allocated from reservation window, when ext3
multiple blocks allocation was added, we added try_to_extend_reservation
() to ext3, which trying to extend the reservation window size to at
least match the number of blocks to allocate. So we have better chance
to allocating multiple blocks from the window at a time.

Since all the multiple block allocation is based on best effort basis,
the same applied to try_to_extend_reservation(). It seems no need to
wait for the reservation tree lock if it's not avaible at that moment.

Mingming

