Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268117AbUJOQHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268117AbUJOQHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268107AbUJOQHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:07:53 -0400
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:7398 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S268117AbUJOQEc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:04:32 -0400
Date: Fri, 15 Oct 2004 18:04:24 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Albert Cahalan <albert@users.sourceforge.net>
Subject: Re: per-process shared information
Message-ID: <20041015160424.GA17849@dualathlon.random>
References: <20041014223730.GI17849@dualathlon.random> <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410151207140.5682-100000@localhost.localdomain>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 12:56:22PM +0100, Hugh Dickins wrote:
> Well, it didn't quite mean that in 2.4: since any pagecache (including
> swapcache) page mapped into a single task would have page_count 2 and
> so be counted as shared.

Well, doing page_mapcount + !PageAnon should do the trick. My point is
that the confusion of an anon page going in swapcache (the one you
mentioned) is easily fixable.

> I think 2.4 was already trying to come up with a plausible simulacrum
> of numbers that made sense to gather in 2.2, but the numbers had lost
> their point, and it only had page_count to play with.  Or maybe 2.2
> was already trying to make up numbers to fit with 2.0...

;)

> [..] and I don't want to
> give the cpu unnecessary work, [..]

this doesn't make much sense to me, then you should as well forbid
the user to run main () { for(;;) }.

Of course doing a sort of for(;;) in each pid of ps xav is overkill, but
on demand easily killable and reschedule friendly would be no different
than allowing an user to execute main () { for(;;) }. All you can do is
to renice it or use CKRM to lower its cpu availability from the
scheduler, or kill -9.

> remove even the vma walk; but I accept you're being careful to propose
> that we keep the overhead out of existing /proc/pid uses - right if
> we have to go that way, but I just prefer to avoid the work myself.

correct. I'd also prefer to avoid this work myself.

> I hope that's what my patch would be sufficient to achieve.

I hope too.

> It would be unfair to say 2.4's numbers were actually a bug, but
> certainly peculiar: I'm about as interested in exactly reproducing
> their oddities as in building a replica of some antique furniture.

sure the swapcache bit would need fixing ;)

> Oh, if that's all we need, I can do a simpler patch ;)

yep ;) though such simpler patch would return no-sensical results, it
would provide no-information at all in some case.

> Interesting idea, and now (well, 2.6.9-mm heading to 2.6.10) we have
> atomic_inc_return and atomic_dec_return supported on all architectures,
> it should be possible to adjust an mm->shared_rss each time mapcount
> goes up from 1 or down to 1, as well as adjusting nr_mapped count
> as we do when it goes up from 0 or down to 0.

I believe your approach will work fine, and it's much closer to the 2.4
physical-driven semantics. It looks like "shared" really means
not-anonymous memory, but accounted on a physical basis.

However I wouldn't mind if you want to add a new field and to provide
both the "virtual" shared like 2.6 right now, along the "physical"
shared miming the semantics of 2.4 (they could be both in statm since
they're O(1) to collect).
