Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263077AbTFYAvN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 20:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263131AbTFYAvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 20:51:13 -0400
Received: from holomorphy.com ([66.224.33.161]:11227 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263077AbTFYAvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 20:51:09 -0400
Date: Tue, 24 Jun 2003 18:05:13 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.73-wli-1
Message-ID: <20030625010513.GX20413@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available from:
ftp://ftp.kernel.org/pub/linux/kernel/people/wli/kernels/2.5.73/2.5.73-wli-1/2.5.73-wli-1.bz2

Gee, I've not quite been fast enough to get more than one out per point
release. No matter. The content is good enough (or bad enough?) anyway.
I changed the naming convention slightly and plopped down a tarball
with some train wreck resembling a split up version of the thing nearby.
Against 2.5.73 virgin.

I've lost the wherewithal to list out the changes completely so only
the new bits are mentioned here. I wanted to get more done (e.g.
rmap_chain RCU, mapping->page_lock RCU), but other things are bugging
me at the moment, for instance bugs in what I've got thus far, and
those two are actually turning out to be hard to do. It looks like some
pages are getting into a weird state where swapoff(8) trips over the
things. I've got a workaround for the -EEXIST case (which should never
happen) in move_from_swap_cache(), but no idea what's going wrong apart
from a vague suspicion it has something to do with the usual suspect
i.e. Morton pages, or otherwise some stupid hamhandedness of mine in
the anobjrmap forward port. A beer at OLS says it's Morton pages.

I need to drop some crap which is stupid and has no positive effect,
like the partial kmap function inlining. 99% of everything they're
called on is actually in highmem so the in-line check for lowmem pages
just bloats code. I also magnified some rename action in the anobjrmap
stuff that shoves an mm in page->mapping that I should back off on and
save some diffsize by so doing. Dropping crud like that and merging
something useful for resource scalability instead, like shpte and
pagetable reclamation and swapping, would be more worthwhile. Or maybe
even properly splitting off pieces, getting them individually benched
properly, and shipping 'em back to -mm.

The edge doth bleed. You were warned.

+ anobjrmap 1-6:
	Hugh Dickins' old 2.5.65 stuff, brute-force forward ported and
	relatively certainly screwed up by yours truly. All bugs in
	this are my fault. No, I'm not trying to pick on Hugh, this
	just happens to be useful like various of his other patches. =)
	I changed the anonmm stuff to just chain mm's against a fresh
	struct anon; I didn't like the mixing of head and element.
	pte_chains are wiped entirely off the map. Some equivalent
	exists for rare cases where they're needed, but is utterly
	invisible in slabinfo and the functions manipulating them are
	yet to register a single profile hit. Maybe I goofed and
	they're not being called. At any rate I like the low overhead.

+ inline rmap functions' fast paths
	Anobjrmap made them small enough to inline. Unsurprisingly, it
	made certain benchmarks slightly faster. They obviously
	vaporized from profiles, which should make various people cheer.
	Unfortunately, you can still find the test_and_set_bit() locking
	in instruction-level profiles, which is what I wanted RCU to
	kill off for me on these things.

+ spinline + inline atomic_dec_and_lock()
	Despite being ultra-stupid, the atomic_dec_and_lock() inlining
	was the source of a few bugs. It could probably be done more
	cleanly, too. I'm thinking of making spinline mandatory. I see
	zero benefit from the lock sections (i.e. no spinline degradation).

+ RCU mapping->i_shared_sem
	Convert it to RCU from a semaphore. Unsurprisingly faster
	on bigboxen. No idea why it was a semaphore to begin with,
	objrmap got down() pileups on the thing that blew major goats.
	down() vaporized from my profiles after crowbarring this in.
	This RCU stuff is easy. It worked the first time.

+ RCU anon->lock
	Well, the lock was introduced by the anobjrmap bits, but RCU it
	anyway. No tangible benefit or harm on the benchmarks I ran
	apart from giving me the warm fuzzies. I should probably bench
	something that does a large number of fork()'s without an exec()
	and then goes into page replacement on 8x+ SMP to get an idea
	of how worthwhile this is. I don't know of such a benchmark
	that isn't a contrived microbenchmark offhand (maybe the entire
	scenario is contrived?) but I think it's just the Right Thing
	To Do (TM) and it saves some atomic operations. ->i_shared_sem
	was so easy I got cocky and had to plop down 3 or 4 bugfix
	pieces in the split out patches after this one because I
	screwed this up mightily with various truly trivial bogons at
	first (actually mostly unrelated to RCU except for one). It
	should be fine in and of itself now, of course.


-- wli
