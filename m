Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267708AbUJOL4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267708AbUJOL4u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 07:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUJOL4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 07:56:50 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:43354 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S267708AbUJOL4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 07:56:40 -0400
Date: Fri, 15 Oct 2004 12:56:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrea Arcangeli <andrea@novell.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
In-Reply-To: <20041014223730.GI17849@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2004, Andrea Arcangeli wrote:
> On Thu, Oct 14, 2004 at 10:49:28PM +0100, Hugh Dickins wrote:
> > Is "shared" generally expected to pair with rss?  Would it make
> 
> shared is expected to work like in linux 2.4 (and apparently solaris),
> which means _physical_ pages mapped in more than one task.

Well, it didn't quite mean that in 2.4: since any pagecache (including
swapcache) page mapped into a single task would have page_count 2 and
so be counted as shared.

I think 2.4 was already trying to come up with a plausible simulacrum
of numbers that made sense to gather in 2.2, but the numbers had lost
their point, and it only had page_count to play with.  Or maybe 2.2
was already trying to make up numbers to fit with 2.0...

> > Sounds horrid to me!  I'm not inclined to volunteer for that: plus this
> 
> what's horrid? would you add a O(log(N)) slowdown in the fast paths to
> provide the stat in O(1)? I much prefer an O(N) loop in the stats as far
> as it catches signals and reschedules as soon as need_resched is set.

Of course I prefer to keep significant slowdown out of the fast paths
("significant" inserted there because I don't mind the fastish path
incrementing just one count in an already dirty cacheline).

But I don't want to give myself unnecessary work, and I don't want to
give the cpu unnecessary work, particularly if the stats gathering is
in danger of dominating some profiled load.  Bill had good reason to
remove even the vma walk; but I accept you're being careful to propose
that we keep the overhead out of existing /proc/pid uses - right if
we have to go that way, but I just prefer to avoid the work myself.

> if you can suggest a not-horrid approach to avoid breaking binary
> compatibility to 2.4 you're welcome ;)

I hope that's what my patch would be sufficient to achieve.

It would be unfair to say 2.4's numbers were actually a bug, but
certainly peculiar: I'm about as interested in exactly reproducing
their oddities as in building a replica of some antique furniture.

> > One, support anon_rss as a subset of rss, "shared" being (rss - anon_rss).
> > Yes, that's a slight change in meaning of "shared" from in 2.4, but easy
> > to support and I think very reasonable.  On the one hand, yes, of course
> 
> that's certainly much better than what we have right now, it's much
> closer to the old semantics, but I'm not sure if it's enough to be
> compliant with the other OS (including 2.4). I will ask. 

Thanks, please do.

> I also guess the app will stop breaking since rss - shared will not wrap
> anymore.

Oh, if that's all we need, I can do a simpler patch ;)

> > we know an anon page may actually be shared between several mms of the
> > fork group, whereas it won't be counted in "shared" with this patch. But
> > the old definition of "shared" was considerably more stupid, wasn't it?
> > for example, a private page in pte and swap cache got counted as shared.
> 
> just checking mapcount > 1 would do it right in 2.6.

Interesting idea, and now (well, 2.6.9-mm heading to 2.6.10) we have
atomic_inc_return and atomic_dec_return supported on all architectures,
it should be possible to adjust an mm->shared_rss each time mapcount
goes up from 1 or down to 1, as well as adjusting nr_mapped count
as we do when it goes up from 0 or down to 0.

Though I think I prefer the anon_rss count in yesterday's patch,
which is at least well-defined.  And will usually give you numbers
much closer to 2.4's than shared_rss (since, as noted above, 2.4
counted a page shared between pagetable and pagecache as shared,
which mapcount 1 would not).

> > Would this new meaning of "shared" suit your purposes well enough?
> 
> It'd be fine for me, but I'm no the one how's having troubles.

Let's wait and see how (rss - anon_rss) works out for your customer.

> > shouldn't change that now, but add your statm_phys_shared; whatever,
> 
> the only reason to add statm_phys_shared was to keep ps xav fast, if you
> don't slowdown pa xav you can add another field at the end of statm.

We should ask Albert which he prefers: /proc/pid/statm "shared" field
revert to an rss-like count as in 2.4, subset of "resident", while size,
text and data fields remain extents; or leave that third field as in
earlier 2.6 and add a shared-rss field on the end?

Hugh

