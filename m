Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267520AbRHFI6u>; Mon, 6 Aug 2001 04:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267512AbRHFI6l>; Mon, 6 Aug 2001 04:58:41 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:19264 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S267534AbRHFI6f>; Mon, 6 Aug 2001 04:58:35 -0400
Date: Mon, 6 Aug 2001 10:59:04 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: David Luyer <david_luyer@pacific.net.au>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: /proc/<n>/maps growing...
Message-ID: <20010806105904.A28792@athlon.random>
In-Reply-To: <997080081.3938.28.camel@typhaon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <997080081.3938.28.camel@typhaon>; from david_luyer@pacific.net.au on Mon, Aug 06, 2001 at 04:41:21PM +1000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2001 at 04:41:21PM +1000, David Luyer wrote:
> crashes for no apparent reason every 6 hours or so.. unless that could
> be when
> it hits some 'limit' on the number of mappings allowed? 

there's no limit, this is _only_ a performance issue, functionality is
not compromised in any way [except possibly wasting some memory
resources that could lead to running out of memory earlier].

I personally like the clever merging to happen in the kernel at the
latest possible layer, like we do for blkdev in respect to the fs and
skbs with respect to the senders (as opposed to the scatter-gather based
apis where the user has to merge always in userspace to avoid wasting
metadata space).

But my strongest argument is probably that unless I'm missing something
the merge_segments could be implemented with zero cost (with a cost of
the order of a few cycles per mmap call, not with a full lookup of the
avl which is actually why Linus doesn't like it).  This because as far
as we were able to insert the new vma into the data structure in the
right place, we also known something about the 'prev' vma at some point
during insert_vma_struct, so we only need to get such a pointer out of
insert_vm_struct at nearly zero cost, instead of running find_vma_prev
again inside merge_segments and browse the whole tree for a second time.
Can somebody see a problem with this design?

In short I believe if we implement it right it is an obvious
and worthwhile optimization (however I certainly can see that in 2.[23]
the double vma lookup at every mmap wasn't very nice).

I guess I will implement the above proposal it if nobody else is
interested to do that (and while implementing it I will certainly notice
if I was missing something or not :).

Andrea
