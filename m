Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288969AbSBRXoR>; Mon, 18 Feb 2002 18:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289004AbSBRXoJ>; Mon, 18 Feb 2002 18:44:09 -0500
Received: from dsl-213-023-040-169.arcor-ip.net ([213.23.40.169]:65168 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288969AbSBRXnu>;
	Mon, 18 Feb 2002 18:43:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC] Page table sharing
Date: Tue, 19 Feb 2002 00:48:24 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, Rik van Riel <riel@conectiva.com.br>,
        mingo@redhat.co, Andrew Morton <akpm@zip.com.au>,
        manfred@colorfullife.com, wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.21.0202181759100.1248-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0202181759100.1248-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cxWD-0000xQ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On February 18, 2002 08:04 pm, Hugh Dickins wrote:
> On Mon, 18 Feb 2002, Daniel Phillips wrote:
> > On February 18, 2002 09:09 am, Hugh Dickins wrote:
> > > So how is the page_table_lock taken by swap_out effective when it's
> > > dealing with a page table shared by another mm than the one it is
> > > locking?  And when handling a read-fault, again no such code (but
> > > when handling a write-fault, __pte_alloc has unshared in advance).
> > >
> > > Since copy_page_range would not copy shared page tables, I'm wrong to
> > > point there.  But __pte_alloc does copy shared page tables (to unshare
> > > them), and needs them to be stable while it does so: so locking against
> > > swap_out really is required.  It also needs locking against read faults,
> > > and they against each other: but there I imagine it's just a matter of
> > > dropping the write arg to __pte_alloc, going back to pte_alloc again.
> > 
> > You're right about the read faults, wrong about swap_out.  In general you've 
> > been more right than wrong, so thanks.  I'll post a new patch pretty soon and 
> > I'd appreciate your comments.
> 
> On the read faults: I see no change there in the patch you then posted,
> handle_mm_fault still calls __pte_alloc with write_access argument, so
> concurrent read faults on the same pte can still slot the page into the
> shared page table at the same time, doubly counting it.

Right.  Oops.  Let me contemplate for a moment.

> - no problem if
> it's the Reserved empty_zero_page, and I think no problem at present
> if it's a SwapCache page, since that is PageLocked in the current tree
> (but not in -aa, and in due course we should go Andrea's way there);
> but if it's a file page the double count will leave it unfreeable.
> 
> On swap_out versus __pte_alloc: I was misreading it and you're almost
> right there: but you do need to change that "pte_t pte = *src_ptb;"
> to something atomic - hmm, do we have any primitive for doing that?

I guess we need one now.

> neither set_pte nor ptep_get_and_clear is right.  Otherwise, on PAE
> HIGHMEM64G systems the two halves of "pte" could be assigned before
> and after try_to_swap_out's ptep_get_and_clear.  But once you've got
> "pte", yes, you're basing all your decisions on your one local copy,
> that gives all the stability you need.

Thanks a lot, let me digest this and I'm close that hole shortly, or
feel free to suggest a fix.  You just explained the memory leak I'm
seeing.

-- 
Daniel
