Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310335AbSBRJg7>; Mon, 18 Feb 2002 04:36:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310334AbSBRJgs>; Mon, 18 Feb 2002 04:36:48 -0500
Received: from dsl-213-023-043-245.arcor-ip.net ([213.23.43.245]:21132 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S310333AbSBRJgb>;
	Mon, 18 Feb 2002 04:36:31 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [RFC] Page table sharing
Date: Mon, 18 Feb 2002 10:41:04 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, dmccr@us.ibm.com,
        Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Robert Love <rml@tech9.net>, Rik van Riel <riel@conectiva.com.br>,
        mingo@redhat.co, Andrew Morton <akpm@zip.com.au>,
        manfred@colorfullife.com, wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.21.0202180657210.10514-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.21.0202180657210.10514-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16ckIC-0000KV-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In short, you were entirely right about the spinlocks.  Linus and I were 
tilting at windmills.  This gradually became clear as I coded it and 
hopefully what I have now is pretty tight.  In fact, I just booted it and it 
works a lot better, UML boots up now whereas before it bombed with some weird 
having to do with process ids.

On February 18, 2002 09:09 am, Hugh Dickins wrote:
> On Mon, 18 Feb 2002, Daniel Phillips wrote:
> > On February 17, 2002 11:16 pm, Hugh Dickins wrote:
> > > Consider copy_page_range from mm1 or __pte_alloc in mm1
> > > while try_to_swap_out is acting on shared page table in mm2.  In fact,
> > > I think even the read faults are vulnerable to races (mm1 and mm2
> > > bringing page in at the same time so double-counting it), since your
> > > __pte_alloc doesn't regard a read fault as reason to break the share.
> > 
> > This is exactly what I've been considering, intensively, for days.
> > (Sleeping has been optional ;-)  Please re-evaluate this in light of the
> > exclusive owner observation above.
> 
> I only see such page_count code under zap_page_range, and in __pte_alloc
> for write-access case.  mm/vmscan.c isn't even in the patch (I'm looking
> at the one you emailed on Saturday night), and there's no code of that
> kind in the header files in the patch.

I don't have to exclude against vmscan.c, which is just unmapping pages, as 
opposed to page tables.

> So how is the page_table_lock taken by swap_out effective when it's
> dealing with a page table shared by another mm than the one it is
> locking?  And when handling a read-fault, again no such code (but
> when handling a write-fault, __pte_alloc has unshared in advance).
>
> Since copy_page_range would not copy shared page tables, I'm wrong to
> point there.  But __pte_alloc does copy shared page tables (to unshare
> them), and needs them to be stable while it does so: so locking against
> swap_out really is required.  It also needs locking against read faults,
> and they against each other: but there I imagine it's just a matter of
> dropping the write arg to __pte_alloc, going back to pte_alloc again.

You're right about the read faults, wrong about swap_out.  In general you've 
been more right than wrong, so thanks.  I'll post a new patch pretty soon and 
I'd appreciate your comments.

After messing around a lot with braindamaged locking strategies involving 
dec-and-test-zero I finally realized it's never going to work if everybody is 
dec'ing at the same time, as you obviously knew right away.  I switched to a 
boring but effective spin lock strategy and was rewarded with an immediate
improvement in stability under smp.  It might even be right now, though it 
needs considerably more auditing.

I'll right up a detailed rationale of what I ended up doing, it really
needs it.  I'm not finished debugging.  There's a memory leak, it's pretty 
gross and it should be easy to track down.  Here are the latest timings:

1000 forks from parent with 100 pages of mapped memory...
Old total fork time: 0.325903 seconds in 1000 iterations (325 usec/fork)
New total fork time: 0.351586 seconds in 1000 iterations (351 usec/fork)

1000 forks from parent with 500 pages of mapped memory...
Old total fork time: 0.471532 seconds in 1000 iterations (471 usec/fork)
New total fork time: 0.533865 seconds in 1000 iterations (533 usec/fork)

1000 forks from parent with 1000 pages of mapped memory...
Old total fork time: 0.671050 seconds in 1000 iterations (671 usec/fork)
New total fork time: 0.637614 seconds in 1000 iterations (637 usec/fork)

100 forks from parent with 10000 pages of mapped memory...
Old total fork time: 0.490882 seconds in 100 iterations (4908 usec/fork)
New total fork time: 0.213267 seconds in 100 iterations (2132 usec/fork)

100 forks from parent with 50000 pages of mapped memory...
Old total fork time: 2.187904 seconds in 100 iterations (21879 usec/fork)
New total fork time: 0.954625 seconds in 100 iterations (9546 usec/fork)

100 forks from parent with 100000 pages of mapped memory...
Old total fork time: 4.277711 seconds in 100 iterations (42777 usec/fork)
New total fork time: 1.940009 seconds in 100 iterations (19400 usec/fork)

100 forks from parent with 200000 pages of mapped memory...
Old total fork time: 15.873854 seconds in 100 iterations (158738 usec/fork)
New total fork time: 2.651530 seconds in 100 iterations (26515 usec/fork)

100 forks from parent with 200000 pages of mapped memory...
Old total fork time: 19.209013 seconds in 100 iterations (192090 usec/fork)
New total fork time: 3.684045 seconds in 100 iterations (36840 usec/fork)

(Look at the last one, the nonshared fork forces the system into swap.  I ran 
it twice to verify, the second time from a clean reboot.  This is another 
reason why shared page tables are good.)

-- 
Daniel
