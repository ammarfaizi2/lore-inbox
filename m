Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130073AbRA3MhY>; Tue, 30 Jan 2001 07:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130164AbRA3MhO>; Tue, 30 Jan 2001 07:37:14 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:53468 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130073AbRA3Mg6>; Tue, 30 Jan 2001 07:36:58 -0500
Message-ID: <3A76B72D.2DD3E640@uow.edu.au>
Date: Tue, 30 Jan 2001 23:44:29 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A728475.34CF841@uow.edu.au>,
		<3A726087.764CC02E@uow.edu.au>
		<20010126222003.A11994@vitelus.com>
		<3A728475.34CF841@uow.edu.au> <14966.22671.446439.838872@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
> The "more expensive" write/send in zerocopy is a known cost of paged
> SKBs.  This cost may be decreased a bit with some fine tuning, but not
> eliminated entirely.

Can you say what causes the difference?  I had a brief poke
around - generic_copy_from_user() dominates in both cases
of course, but nothing really stood out when comparing the
zerocopy kernel's profile with non-zc.

Varying the value of MAXPGS (all the way down to 1) and also
the amount of data which is sent with send() does change the
throughput, but not the ratio wrt non-zc.

> What do we get for this cost?
> 
> Basically, the big win is not that the card checksums the packet.
> We could get that for free while copying the data from userspace
> into the kernel pages during the sendmsg(), using the combined
> "copy+checksum" hand-coded assembly routines we already have.
> 
> It is in fact the better use of memory.  Firstly, we use page
> allocations, only single ones.  With linear buffers SLAB could
> use multiple pages which strain the memory subsystem quite a bit at
> times.  Secondly, we fill pages with socket data precisely whereas
> SLAB can only get as tight packing as any general purpose memory
> allocator can.
> 
> This, I feel, outweighs the slight performance decrease.  And I would
> wager a bet that the better usage of memory will result in better
> all around performance.

ie: inappropriate test coverage.  Not surprising.  What
additional scenarios need to be tested?  Zillions of
connections?

If anyone really needs that 10% they can use the `hw_checksums=0'
module parm, but SG+xsum is enabled by default - we need the testing.

> The problem with microscopic tests is that you do not see the world
> around the thing being focused on.  I feel Andrew/Jamal's test are
> very valuable, but lets keep things in perspective when doing cost
> analysis.
> 
> Finally, please do some tests on loopback.  It is usually a great
> way to get "pure software overhead" measurements of our TCP stack.

Will do.

BTW: can you suggest why I'm not observing any change in NFS client
efficiency?

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
