Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311209AbSCLOO5>; Tue, 12 Mar 2002 09:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311210AbSCLOOt>; Tue, 12 Mar 2002 09:14:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5641 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S311209AbSCLOOk>;
	Tue, 12 Mar 2002 09:14:40 -0500
Date: Tue, 12 Mar 2002 14:14:39 +0000
From: wli@holomorphy.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312141439.C14628@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, Andrea Arcangeli <andrea@suse.de>,
	wli@parcelfarce.linux.theplanet.co.uk,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
	phillips@bonn-fries.net
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Description: brief message
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020312135605.P25226@dualathlon.random>; from andrea@suse.de on Tue, Mar 12, 2002 at 01:56:05PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 11:29:00AM +0000, wli@holomorphy.com wrote:
>> For specific reasons why multiplication by a magic constant (related to
>> the golden ratio) should have particularly interesting scattering
>> properties, Knuth cites Vera Turán Sós, Acta Math. Acad. Sci. Hung. 8

On Tue, Mar 12, 2002 at 01:56:05PM +0100, Andrea Arcangeli wrote:
> I know about the scattering properties of some number (that is been
> measured empirically if I remeber well what I read). I was asking for
> something else, I was asking if this magical number can scatter better a
> random input as well or not. My answer is no. And I believe the nearest
> you are to random input to the hashfn the less the mul can scatter
> better than the input itself and it will just lose cache locality for
> consecutive pages. So the nearest you are, the better if you avoid the
> mul and you take full advantage of the randomness of the input, rather
> than keeping assuming the input has pattenrs.
> I mean, start reading from /dev/random and see how the distribution goes
> with and without mul, it will be the same I think.

The assumption here is then that the input distribution is uniform.
This is, in fact the input distribution Fibonacci hashing is
designed for (i.e. uniform distribution on the natural numbers, which
arises quite naturally from considering all of \mathbb{N} as input).


On Tue, Mar 12, 2002 at 11:29:00AM +0000, wli@holomorphy.com wrote:
>> I will either sort out the results I have on the waitqueues or rerun
>> tests at my leisure.

On Tue, Mar 12, 2002 at 01:56:05PM +0100, Andrea Arcangeli wrote:
> I'm waiting for it, if you've monitor patches I can run something too.
> I'd like to count the number of collisions over time in particular.

This is a fairly crude statistic but one that I'm collecting. The
hashtable profiling is something I've been treating as a userspace
issue with the state dumps done by mmapping /dev/kmem, and in fact,
I did not write that myself, that is due to Anton Blanchard and Rusty
Russell, who initiated this area of study, and have made the more
important contributions to it. In this instance, you can see as well
as I that the references date to the 50's and 60's, and that accurate
measurement is the truly difficult aspect of the problem. Formulae to
grind statistics into single numbers are nothing but following
directions, and these have been precisely the portions of the effort
for which I've been responsible, aside from perhaps some of the sieving
routines, with which I had assistance from Krystof and Fare from OPN,
and these are not especially significant in terms of effort either.
Anton and Rusty have been the ones with the insight to identify the
problematic areas and also to find methods of collecting data.


On Tue, Mar 12, 2002 at 11:29:00AM +0000, wli@holomorphy.com wrote:
>> Note I am only trying to help you avoid shooting yourself in the foot.

On Tue, Mar 12, 2002 at 01:56:05PM +0100, Andrea Arcangeli wrote:
> If I've rescheduling problems you're likely to have them too, I'm quite
> sure, if something the fact I keep the hashtable large enough will make
> me less bitten by the collisions. The only certain way to avoid riskying
> regressions would be to backout the wait_table part that was merged in
> mainline 19pre2. the page_zone thing cannot generate any regression for
> instance (same is true for page_address), the wait_table part is gray
> area instead, it's just an heuristic like all the hashes and you can
> always have a corner case bitten hard, it's just that the probabiliy for
> such a corner case to happen has to be small enough for it to be
> acceptable, but you can always be unlucky, no matter if you mul or not,
> you cannot predict the future of what's the next pages that the people
> will wait on from userspace.

I have some small reservations about these assertions.
(1) the scheduling storms are direct results of collisions in the hash
	tables, which are direct consequences of the hash function quality.
	OTOH increasing table size is one method of collision reduction,
	albeit one I would like extremely strict control over, and one
	that should not truly be considered until the load is high
	(.e.g. 0.75 or thereabouts)
(2) page_address() has been seen to cause small regressions on
	architectures where the additional memory reference in comparison
	to a __va((page - mem_map) << PAGE_SHIFT) implementation is
	measurable. In my mind, several generic variants are required for
	optimality and I will either personally implement them or endorse
	any suitably clean implementations of them (clean is the hard part).
(3) Hashing is not mere heuristics. A hash function is a sufficiently
	small portion of an implementation of a table lookup scheme
	that the search may be guided by statistical measurements of
	both the effectiveness of the hash function in distributing
	keys across buckets and net profiling results. The fact I
	restricted the space I searched to Fibonacci hashing is
	irrelevant; it was merely a tractable search subspace.
(4) The notion that a hashing scheme may be defeated by a sufficiently
	unlucky input distribution is irrelevant. This has been known
	(and I suppose feared) since its invention in the early 1950's.
	Hash tables are nondeterministic data structures by design, and
	their metrics of performance are either expected or amortized
	running time, not worst case, which always equal to linear search.
(5) Last, but not least, the /dev/random argument is bogus. Mass
	readings of pseudorandom number generators do not make for	
	necessarily uniformly distributed trials or samples. By and
	large the methods by which pseudorandom number generators are
	judged (and rightly so) are various kinds of statistical relations
	between some (fixed for the duration of the trial) number of
	successively generated numbers. For instance, groups of N (where
	N is small and fixed for the duration of the trial) consecutively
	generated numbers should not lie within the same hyperplane for
	some applications. These have no relation to the properties
	which would cause a distribution of a set of numbers which is
	measured as a snapshot in time to pass a test for uniformity.


Otherwise we appear to be largely in agreement.


Cheers,
Bill
