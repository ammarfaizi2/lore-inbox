Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293333AbSBQTfF>; Sun, 17 Feb 2002 14:35:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293340AbSBQTe4>; Sun, 17 Feb 2002 14:34:56 -0500
Received: from dsl-213-023-043-245.arcor-ip.net ([213.23.43.245]:3205 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S293333AbSBQTem>;
	Sun, 17 Feb 2002 14:34:42 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] Page table sharing
Date: Sun, 17 Feb 2002 20:39:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <dmccr@us.ibm.com>, Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Robert Love <rml@tech9.net>,
        Rik van Riel <riel@conectiva.com.br>, mingo@redhat.co,
        Andrew Morton <akpm@zip.com.au>, manfred@colorfullife.com,
        wli@holomorphy.com
In-Reply-To: <Pine.LNX.4.33.0202162219230.8326-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0202162219230.8326-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16cX9a-0000D9-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(lots of cc's added because vger is down)

On February 17, 2002 07:23 am, Linus Torvalds wrote:
> On Sat, 16 Feb 2002, Daniel Phillips wrote:
> > >
> > > 	if (put_page_testzero(pmd_page)) {
> > > 		.. free the actual page table entries ..
> > > 		__free_pages_ok(pmd_page, 0);
> > > 	}
> > >
> > > instead of using the free_page() logic. Maybe you do that already, I
> > > didn't go through the patches _that_ closely.
> >
> > I do something similar in clear_page_tables->free_one_pmd, after the entries
> > are all gone.  I have to do something different in zap_page_range - it wants
> > to free the pmd only if the count is *greater* than one, and can't tolerate
> > two mms thinking that at the same time.  I think I'd better lock the pmd page
> > there.
> 
> But that's ok.

You're right, I gave up trying to find the minimal solution too soon.  Now,
the solution I'm looking for is even more minimal than what you had in mind,
which would involve some reorganization of zap_*.  Please bear with me as I
circle around this problem a little more...

> If you have the logic that
> 
> 	if (put_page_testzero(pmd_page)) {
> 		... do the lower-level free ...
> 		__free_pages_ok(pmd_page, 0);
> 	}
> 
> then you automatically have exactly the behaviour you want, with no
> locking at all (except for the "local" locking inherent in the atomic
> decrement-and-test).

This is headed in the right direction.  The key thing we learn when we
hit zero there is that this mm is the exclusive owner, so we can safely
set the use count back to one and continue with the normal zap, because
anybody who wants to share this pmd will need this mm's page_table_lock,
which we hold.  (Note that I have to fix copy_page_range a little to
enforce this exclusion.)

Hey, that lets me keep using tlb_put_page as well, which I want to do
because it's carefully tuned to be optimal for arches with special tlb
purging requirements, and because otherwise I have to fight with the
UP/SMP difference in the tlb parameter (in the first case it's an mm, in
the second case it's a fancier thing that points at an mm, I don't want
to have to add an #ifdef SMP if I can avoid it).  Once again, what I
have to do here is re-increment the use count, to set the proper initial
conditions for tlb_put_page, and that's where the exclusion goes:

	zap_pte_range:

	... ensure the page table exists ...

 	if (!put_page_testzero(page_table_page)) {
		spin_lock(page_table_share_lock);
		if (page_count(page_table_page)) {
			get_page(page_table_page);
			tlb_remove_page(...pmd...);
			spin_unlock(page_table_share_lock);
			return 0; // no ptes cleared here
		}
		spin_unlock(page_table_share_lock);
	}
	get_page(page_table_page); // count was one, we own it

	... continue with normal zap ...

Nice huh?  I hope it's right :-)

OK, there's another hairy aspect of this that you may have missed in
your quick read-through: we have to worry about the difference between
partial and full zapping of the pmd, because in the first case, it's a
BUG if the pmd is shared.  So we have to unshare the partial pmd's
before zapping them.  Which I'm doing, and then I can rely on count = 1
to tell me that what's happening is a full zap of the pmd.  Once we get
to count = 1, out mm->page_table_lock keeps it there.  I think that
approach is ok, if a little terse.

The last loose end to take care of is the 'page_table_share_lock' (which
doesn't really have to be global as I've shown it, it just simplifies
the discussion a little and anyway it won't be heavily contended). This
lock will protect zap from being surprised by an unshare in __pte_alloc.
I think it goes something like this:

	... we have a newly allocated page table for the unshare ...
 	if (put_page_testzero(page_table_page))
		goto unshared_while_sleeping;

	spin_lock(page_table_share_lock);
	if (!page_count(page_table_page))
		goto unshared_while_locking;

	... plug in the new page table ...
	... copy in the ptes ...
	spin_unlock(page_table_share_lock);
out:
	return pte_offset(pmd, address);

unshared_while_locking:
	spin_unlock(page_table_share_lock);
unshared_while_sleeping:
	get_page(page_table_page)
	... give back the newly allocate page table ...
	goto out;

This gets subtle: any time put_page_testzero(page_table_page) hits zero we
know that it's exclusively owned by the mm->page_table_lock we hold, and
thus protected from all other decrementers.  (Is it really as subtle as I
think it is, or is this normal?)

Note that we have to hold the page_table_share_lock until we're finished
copying in the ptes, otherwise the source could go away.  This can turn
into a lock on the page table itself eventually, so whatever contention
there might be will be eliminated.

Fixing up copy_page_range to bring the pmd populate inside the 
mm->page_table_lock is trivial, I won't go into it here.  With that plus
changes as above, I think it's tight.  Though I would not bet my life on
it ;-)

-- 
Daniel
