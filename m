Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRA3GCZ>; Tue, 30 Jan 2001 01:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129175AbRA3GCP>; Tue, 30 Jan 2001 01:02:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8832 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129143AbRA3GB4>;
	Tue, 30 Jan 2001 01:01:56 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14966.22671.446439.838872@pizda.ninka.net>
Date: Mon, 29 Jan 2001 22:00:47 -0800 (PST)
To: Andrew Morton <andrewm@uow.edu.au>
Cc: lkml <linux-kernel@vger.kernel.org>,
        "netdev@oss.sgi.com" <netdev@oss.sgi.com>
Subject: Re: sendfile+zerocopy: fairly sexy (nothing to do with ECN)
In-Reply-To: <3A728475.34CF841@uow.edu.au>
In-Reply-To: <3A726087.764CC02E@uow.edu.au>
	<20010126222003.A11994@vitelus.com>
	<3A728475.34CF841@uow.edu.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The "more expensive" write/send in zerocopy is a known cost of paged
SKBs.  This cost may be decreased a bit with some fine tuning, but not
eliminated entirely.

What do we get for this cost?

Basically, the big win is not that the card checksums the packet.
We could get that for free while copying the data from userspace
into the kernel pages during the sendmsg(), using the combined
"copy+checksum" hand-coded assembly routines we already have.

It is in fact the better use of memory.  Firstly, we use page
allocations, only single ones.  With linear buffers SLAB could
use multiple pages which strain the memory subsystem quite a bit at
times.  Secondly, we fill pages with socket data precisely whereas
SLAB can only get as tight packing as any general purpose memory
allocator can.

This, I feel, outweighs the slight performance decrease.  And I would
wager a bet that the better usage of memory will result in better
all around performance.

The problem with microscopic tests is that you do not see the world
around the thing being focused on.  I feel Andrew/Jamal's test are
very valuable, but lets keep things in perspective when doing cost
analysis.

Finally, please do some tests on loopback.  It is usually a great
way to get "pure software overhead" measurements of our TCP stack.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
