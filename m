Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSCLXbl>; Tue, 12 Mar 2002 18:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSCLXbb>; Tue, 12 Mar 2002 18:31:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2312 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289272AbSCLXbT>;
	Tue, 12 Mar 2002 18:31:19 -0500
Date: Tue, 12 Mar 2002 23:31:17 +0000
From: wli@holomorphy.com
To: Andrea Arcangeli <andrea@suse.de>
Cc: wli@parcelfarce.linux.theplanet.co.uk,
        "Richard B. Johnson" <root@chaos.analogic.com>,
        linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020312233117.E14628@holomorphy.com>
Mail-Followup-To: wli@holomorphy.com, Andrea Arcangeli <andrea@suse.de>,
	wli@parcelfarce.linux.theplanet.co.uk,
	"Richard B. Johnson" <root@chaos.analogic.com>,
	linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
	phillips@bonn-fries.net
In-Reply-To: <20020312041958.C687@holomorphy.com> <20020312070645.X10413@dualathlon.random> <20020312112900.A14628@holomorphy.com> <20020312135605.P25226@dualathlon.random> <20020312141439.C14628@holomorphy.com> <20020312160430.W25226@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020312160430.W25226@dualathlon.random>; from andrea@suse.de on Tue, Mar 12, 2002 at 04:04:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 02:14:39PM +0000, wli@holomorphy.com wrote:
>> The assumption here is then that the input distribution is uniform.

On Tue, Mar 12, 2002 at 04:04:30PM +0100, Andrea Arcangeli wrote:
> Yes.

This is a much stronger assertion than random. Random variables
may have distributions concentrated on low-dimensional surfaces
(or even singleton points!) which is a case that should be excluded.
Various other distributions are probably not what you want either.

To be clear, I am not operating under the assumption that the input
distribution is uniform (or anything in particular).


At some point in the past, I wrote:
>> This is a fairly crude statistic but one that I'm collecting. The
>> hashtable profiling is something I've been treating as a userspace
>> issue with the state dumps done by mmapping /dev/kmem, and in fact,

On Tue, Mar 12, 2002 at 04:04:30PM +0100, Andrea Arcangeli wrote:
> I'm not sure if the collisions will be frequent enough to show up in
> kmem. I think collisions in this hash should never happen except in very
> unlikely cases (one collision every few seconds would be ok for
> example). So I guess we'd better use a synchronous method to count the
> number of collisions with proper kernel code for that. 

That is pretty easy to do.


At some point in the past, I wrote:
>> I have some small reservations about these assertions.
>> (1) the scheduling storms are direct results of collisions in the hash
>> 	tables, which are direct consequences of the hash function quality.

On Tue, Mar 12, 2002 at 04:04:30PM +0100, Andrea Arcangeli wrote:
> you mean in _the_ hash table (wait_table hash table). Collisions in all
> other hash tables in the kernel doesn't lead to scheduling storms of
> course.

There is more than one wait_table, one per node or per zone.


At some point in the past, I wrote:
>> 	OTOH increasing table size is one method of collision reduction,
>> 	albeit one I would like extremely strict control over, and one
>> 	that should not truly be considered until the load is high
>> 	(.e.g. 0.75 or thereabouts)

On Tue, Mar 12, 2002 at 04:04:30PM +0100, Andrea Arcangeli wrote:
> yes, however strict control over 52k on a 256G machine when spending
> some more minor ram would reduce a lot the probability of collisions
> looked a bit excessive. I'm all for spending ram _if_ it pays off
> singificantly.

Also, there are already too many boot-time allocations proportional to
memory. At the very least consider setting a hard constant upper bound
with some small constant of proportionality to PID_MAX.

If I may wander (further?) off-topic and stand on the soapbox for a moment:
I personally believe this is serious enough various actions should be
taken so that we don't die a death by a thousand "every mickey mouse
hash table in the kernel allocating 0.5% of RAM at boot time" cuts.
Note that we are already in such dire straits that sufficiently large
physical memory sizes on 36-bit physically-addressed 32-bit machines
alone will experience consumption of the entire kernel virtual address
space by various boot-time allocations. This is a bug.

The lower bound of 256 looks intriguing; if it's needed then it should
be done, but if it is needed it begins to raise the question of whether
this fragment of physical memory is worthwhile or should be ignored. On
i386 this would be a fragment of size 1MB or smaller packaged into a
pgdat or zone. There is also an open question as to how much overhead
introducing nodes with tiny amounts of memory like this creates. I
think there may be a reason why they're commonly ignored. I suspect the
real issue here may be that contention for memory doesn't decrease with
the shrinking size of a region of physical memory either.


At some point in the past, I wrote:
>> (2) page_address() has been seen to cause small regressions on
>> 	architectures where the additional memory reference in comparison

On Tue, Mar 12, 2002 at 04:04:30PM +0100, Andrea Arcangeli wrote:
> That's a minor global regression, but linear without corner cases, 
> and the additional ram available to userspace may make more difference
> as well depending on the workload and the size of the ram.

True, and (aside from how I would phrase it) this is my rationale for
not taking immediate action. For architectures where the interaction of
the address calculation arithmetic, arithmetic feature sets, and
numerical properties of structure sizes and so on are particularly
unfortunate around this code (I believe SPARC is one example and there
may be others), something will have to be done whether it's using a
different computation or just using the memory.


At some point in the past, I wrote:
>> (5) Last, but not least, the /dev/random argument is bogus. Mass
>> 	readings of pseudorandom number generators do not make for	
>> 	necessarily uniformly distributed trials or samples. By and
>> 	large the methods by which pseudorandom number generators are
>> 	judged (and rightly so) are various kinds of statistical relations
>> 	between some (fixed for the duration of the trial) number of
>> 	successively generated numbers. For instance, groups of N (where
>> 	N is small and fixed for the duration of the trial) consecutively
>> 	generated numbers should not lie within the same hyperplane for
>> 	some applications. These have no relation to the properties
>> 	which would cause a distribution of a set of numbers which is
>> 	measured as a snapshot in time to pass a test for uniformity.

On Tue, Mar 12, 2002 at 04:04:30PM +0100, Andrea Arcangeli wrote:
> /dev/random is not a pseudorandom number generator. /dev/urandom is.

Right right. Random number generation is a different problem regardless.


At some point in the past, I wrote:
>> Otherwise we appear to be largely in agreement.

On Tue, Mar 12, 2002 at 04:04:30PM +0100, Andrea Arcangeli wrote:
> Yes.

We're getting down to details too minor to bother with.

Enough for now? Shall we meet with benchmarks next time?


Cheers,
Bill

P.S.:	Note that I do maintain my code. If you do have demonstrable
	improvements or even cleanups I will review them and endorse
	them if they pass my review. These changes did not. Also,
	these changes to the hashing scheme were not separated out
	from the rest of the VM patch, so the usual "break this up
	into a separate patch please" applies.
