Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbUDOKVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 06:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbUDOKVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 06:21:39 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:61664 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261239AbUDOKVg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 06:21:36 -0400
Date: Thu, 15 Apr 2004 11:21:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@suse.de>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Benchmarking objrmap under memory pressure
In-Reply-To: <20040414233931.GU2150@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0404151050370.6938-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Apr 2004, Andrea Arcangeli wrote:
> On Wed, Apr 14, 2004 at 06:48:40PM +0100, Hugh Dickins wrote:
> > This is just your guess at present, isn't it, Andrea?  Any evidence?
> 
> the evidence is pretty obvious, the single fact it's painful to remove
> the page_table_lock with anonmm around the vma manipulations, and the
> little benefit that the vma->page_table_lock provides with anonmm is
> quite a tangible measurements, I'm talking about the 256 ways here, any
> UP measurements is pretty useless.

Quite possibly.  Quite possibly not (anonmm can perfectly well use a
different lock than the page_table_lock to make find_vma safe against
try_to_unmap, if page_table_lock too contended, or split into vmas).

A good hypothesis for you to base your design on.  But the evidence
is yet to come.  My own bet is that it will make very little difference
to 256-way performance, whether anonmm or anon_vma: that their issues
will be with the file-based.

> Last but not the least, you cannot know if any important app is going to
> be hurted with mremap doing copies and invalidating important
> optimizations for any application doing similar things that kde is doing
> to save memory and speedup startup times (we don't even know yet if kde
> itself is going to be hurted), you can take these risks with mainline, I
> cannot risk with -aa, and anon-vma provides other minor benefits too
> that we already discussed plus the IMHO important scalability point above.

You're on shakier ground there.

The worst that will happen with anonmm's mremap move, is that some
app might go slower and need more swap.  Unlikely, but agreed possible.

In your case, some app may actually break (I was going to say
mysteriously, but that's unfair, ptrace should quickly identify it):
because of your limitations on anon vma merging, and the way mremap
is only allowed on a single vma.  Again, unlikely, but possible.

I'm sure the right answer to that is to fix mremap to work across vmas:
it's unique and wrong to be letting the kernel implementation detail of
vma percolate up to userspace semantics.  But, on the other hand,
I'm glad of any excuse not to have to go in there and fix it!

(Of course, your file vma merging will make some mremaps
possible which were ruled out before: that's nice.)

> So I don't see why should mainline go with an inferior solution when
> I've already sorted out a better one.

That's your opinion, fine, but we've not yet seen the evidence.

(I was, of course, quite mistaken to say "mainline in a day or two":
2.6.6-rc1 does now have some of the preparatory work, e.g. PageAnon
and swp_entry_t in private, applicable to either of our solutions.
But the real changes are going into -mm, and whether and when and
which proceed from there to mainline is up to Linus and Andrew.)

Hugh

