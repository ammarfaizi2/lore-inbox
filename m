Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311223AbSCLPDp>; Tue, 12 Mar 2002 10:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311226AbSCLPDg>; Tue, 12 Mar 2002 10:03:36 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33100 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S311223AbSCLPDc>; Tue, 12 Mar 2002 10:03:32 -0500
Date: Tue, 12 Mar 2002 16:04:30 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: wli@holomorphy.com, wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312160430.W25226@dualathlon.random>
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020312141439.C14628@holomorphy.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 02:14:39PM +0000, wli@holomorphy.com wrote:
> The assumption here is then that the input distribution is uniform.

Yes.

> On Tue, Mar 12, 2002 at 11:29:00AM +0000, wli@holomorphy.com wrote:
> >> I will either sort out the results I have on the waitqueues or rerun
> >> tests at my leisure.
> 
> On Tue, Mar 12, 2002 at 01:56:05PM +0100, Andrea Arcangeli wrote:
> > I'm waiting for it, if you've monitor patches I can run something too.
> > I'd like to count the number of collisions over time in particular.
> 
> This is a fairly crude statistic but one that I'm collecting. The
> hashtable profiling is something I've been treating as a userspace
> issue with the state dumps done by mmapping /dev/kmem, and in fact,

I'm not sure if the collisions will be frequent enough to show up in
kmem. I think collisions in this hash should never happen except in very
unlikely cases (one collision every few seconds would be ok for
example). So I guess we'd better use a synchronous method to count the
number of collisions with proper kernel code for that. 

> I did not write that myself, that is due to Anton Blanchard and Rusty
> Russell, who initiated this area of study, and have made the more
> important contributions to it. In this instance, you can see as well
> as I that the references date to the 50's and 60's, and that accurate
> measurement is the truly difficult aspect of the problem. Formulae to
> grind statistics into single numbers are nothing but following
> directions, and these have been precisely the portions of the effort
> for which I've been responsible, aside from perhaps some of the sieving
> routines, with which I had assistance from Krystof and Fare from OPN,
> and these are not especially significant in terms of effort either.
> Anton and Rusty have been the ones with the insight to identify the
> problematic areas and also to find methods of collecting data.
> 
> 
> On Tue, Mar 12, 2002 at 11:29:00AM +0000, wli@holomorphy.com wrote:
> >> Note I am only trying to help you avoid shooting yourself in the foot.
> 
> On Tue, Mar 12, 2002 at 01:56:05PM +0100, Andrea Arcangeli wrote:
> > If I've rescheduling problems you're likely to have them too, I'm quite
> > sure, if something the fact I keep the hashtable large enough will make
> > me less bitten by the collisions. The only certain way to avoid riskying
> > regressions would be to backout the wait_table part that was merged in
> > mainline 19pre2. the page_zone thing cannot generate any regression for
> > instance (same is true for page_address), the wait_table part is gray
> > area instead, it's just an heuristic like all the hashes and you can
> > always have a corner case bitten hard, it's just that the probabiliy for
> > such a corner case to happen has to be small enough for it to be
> > acceptable, but you can always be unlucky, no matter if you mul or not,
> > you cannot predict the future of what's the next pages that the people
> > will wait on from userspace.
> 
> I have some small reservations about these assertions.
> (1) the scheduling storms are direct results of collisions in the hash
> 	tables, which are direct consequences of the hash function quality.

you mean in _the_ hash table (wait_table hash table). Collisions in all
other hash tables in the kernel doesn't lead to scheduling storms of
course.

> 	OTOH increasing table size is one method of collision reduction,
> 	albeit one I would like extremely strict control over, and one
> 	that should not truly be considered until the load is high
> 	(.e.g. 0.75 or thereabouts)

yes, however strict control over 52k on a 256G machine when spending
some more minor ram would reduce a lot the probability of collisions
looked a bit excessive. I'm all for spending ram _if_ it pays off
singificantly.

> (2) page_address() has been seen to cause small regressions on
> 	architectures where the additional memory reference in comparison

That's a minor global regression, but linear without corner cases, 
and the additional ram available to userspace may make more difference
as well depending on the workload and the size of the ram.

> 	to a __va((page - mem_map) << PAGE_SHIFT) implementation is
> 	measurable. In my mind, several generic variants are required for
> 	optimality and I will either personally implement them or endorse
> 	any suitably clean implementations of them (clean is the hard part).
> (3) Hashing is not mere heuristics. A hash function is a sufficiently
> 	small portion of an implementation of a table lookup scheme
> 	that the search may be guided by statistical measurements of
> 	both the effectiveness of the hash function in distributing
> 	keys across buckets and net profiling results. The fact I
> 	restricted the space I searched to Fibonacci hashing is
> 	irrelevant; it was merely a tractable search subspace.
> (4) The notion that a hashing scheme may be defeated by a sufficiently
> 	unlucky input distribution is irrelevant. This has been known
> 	(and I suppose feared) since its invention in the early 1950's.
> 	Hash tables are nondeterministic data structures by design, and
> 	their metrics of performance are either expected or amortized
> 	running time, not worst case, which always equal to linear search.
> (5) Last, but not least, the /dev/random argument is bogus. Mass
> 	readings of pseudorandom number generators do not make for	
> 	necessarily uniformly distributed trials or samples. By and
> 	large the methods by which pseudorandom number generators are
> 	judged (and rightly so) are various kinds of statistical relations
> 	between some (fixed for the duration of the trial) number of
> 	successively generated numbers. For instance, groups of N (where
> 	N is small and fixed for the duration of the trial) consecutively
> 	generated numbers should not lie within the same hyperplane for
> 	some applications. These have no relation to the properties
> 	which would cause a distribution of a set of numbers which is
> 	measured as a snapshot in time to pass a test for uniformity.

/dev/random is not a pseudorandom number generator. /dev/urandom is.

> 
> 
> Otherwise we appear to be largely in agreement.

Yes.

Andrea
