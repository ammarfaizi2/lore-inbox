Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262506AbVCVGP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVCVGP2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 01:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262512AbVCVGLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 01:11:43 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:59917 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262286AbVCVGJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 01:09:28 -0500
Date: Tue, 22 Mar 2005 06:08:38 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, tony.luck@intel.com, akpm@osdl.org,
       benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] freepgt: free_pgtables use vma list
In-Reply-To: <20050321212955.6a0f2b61.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0503220548250.5484@goblin.wat.veritas.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F03210DD4@scsmsx401.amr.corp.intel.com> 
    <20050321150205.4af39064.davem@davemloft.net> 
    <1111464894.5125.34.camel@npiggin-nld.site> 
    <20050321212955.6a0f2b61.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005, David S. Miller wrote:
> On Tue, 22 Mar 2005 15:14:54 +1100
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> > Question, Dave: flush_tlb_pgtables after Hugh's patch is also
> > possibly not being called with enough range to cover all page
> > tables that have been freed.

Good question from Nick.

> > For example, you may have a single page (start,end) address range
> > to free, but if this is enclosed by a large enough (floor,ceiling)
> > then it may free an entire pgd entry.
> > 
> > I assume the intention of the API would be to provide the full
> > pgd width in that case?
> 
> It just wants the range of page tables liberated.  I guess
> essentially PMD_SIZE is the granularity.

I _think_ that answer means that my current code is fine in this respect.
But I'm not entirely convinced.  Since sparc64 is the only architecture
which implements a flush_tlb_pgtables which actually uses start,end,
we do need to suit your needs there - informed reassurance welcome!

> Anyways, for the record I made it only call flush_tlb_pgtables()
> when end > start,

Fine.  The patch I just sent, moving the tests, is how I'd like it to
be fixed finally, but what you've done in the interim should do fine.

> but instead of that BUG() I now get the BUG()
> on mm->nr_ptes being non-zero at the end of exit_mmap().

And no way would your change be causing this.  Oh dear.

> Something is up with the floor/ceiling stuff methinks.

Seems so.  I did have an off-by-one originally,
but that version never leaked out.

> It's funny since this code aparently works fine on ia64 which
> is fully 3-level too.  Hmm...

Yes, odd.  I'll have to have another think later on.

Hugh
