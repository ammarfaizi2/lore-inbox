Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310224AbSBRIIE>; Mon, 18 Feb 2002 03:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310228AbSBRIHp>; Mon, 18 Feb 2002 03:07:45 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:50279 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S310224AbSBRIHk>; Mon, 18 Feb 2002 03:07:40 -0500
Date: Mon, 18 Feb 2002 08:09:10 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: Linus Torvalds <torvalds@transmeta.com>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, Rik van Riel <riel@conectiva.com.br>,
        mingo@redhat.co, Andrew Morton <akpm@zip.com.au>,
        manfred@colorfullife.com, wli@holomorphy.com
Subject: Re: [RFC] Page table sharing
In-Reply-To: <E16cciK-0000HW-00@starship.berlin>
Message-ID: <Pine.LNX.4.21.0202180657210.10514-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Daniel Phillips wrote:
> On February 17, 2002 11:16 pm, Hugh Dickins wrote:
> 
> > You need your "page_table_share_lock" (better, per-page-table spinlock)
> > much more than you seem to realize.  If mm1 and mm2 share a page table,
> > mm1->page_table_lock and mm2->page_table_lock give no protection against
> > each other.
> 
> Unless we decrement and find that the count was originally 1, that means
> we are the exclusive owner and are protected by the mm->page_table_lock
> we hold.  Only if that is not the case do we need the extra spinlock.

Correct (assuming it's coded correctly).

> > Consider copy_page_range from mm1 or __pte_alloc in mm1
> > while try_to_swap_out is acting on shared page table in mm2.  In fact,
> > I think even the read faults are vulnerable to races (mm1 and mm2
> > bringing page in at the same time so double-counting it), since your
> > __pte_alloc doesn't regard a read fault as reason to break the share.
> 
> This is exactly what I've been considering, intensively, for days.
> (Sleeping has been optional ;-)  Please re-evaluate this in light of the
> exclusive owner observation above.

I only see such page_count code under zap_page_range, and in __pte_alloc
for write-access case.  mm/vmscan.c isn't even in the patch (I'm looking
at the one you emailed on Saturday night), and there's no code of that
kind in the header files in the patch.

So how is the page_table_lock taken by swap_out effective when it's
dealing with a page table shared by another mm than the one it is
locking?  And when handling a read-fault, again no such code (but
when handling a write-fault, __pte_alloc has unshared in advance).

Since copy_page_range would not copy shared page tables, I'm wrong to
point there.  But __pte_alloc does copy shared page tables (to unshare
them), and needs them to be stable while it does so: so locking against
swap_out really is required.  It also needs locking against read faults,
and they against each other: but there I imagine it's just a matter of
dropping the write arg to __pte_alloc, going back to pte_alloc again.

Hugh

