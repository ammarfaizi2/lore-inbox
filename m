Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264559AbTL0U3r (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 15:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbTL0U3r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 15:29:47 -0500
Received: from a0.complang.tuwien.ac.at ([128.130.173.25]:59402 "EHLO
	a0.complang.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S264559AbTL0U3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 15:29:42 -0500
X-mailer: xrn 9.03-beta-14
To: linux-kernel@vger.kernel.org
X-Newsgroups: linux.kernel
In-reply-to: <179IS-1VD-13@gated-at.bofh.it>
From: anton@mips.complang.tuwien.ac.at (Anton Ertl)
Subject: Re: Page Colouring (was: 2.6.0 Huge pages not working as expected)
Date: Sat, 27 Dec 2003 20:21:03 GMT
Message-ID: <2003Dec27.212103@a0.complang.tuwien.ac.at>
References: <179fV-1iK-23@gated-at.bofh.it> <179IS-1VD-13@gated-at.bofh.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:
>
>
>On Fri, 26 Dec 2003, Anton Ertl wrote:
>>							  You
>> can get the same worst-case behaviour as with page colouring, since
>> you can get the same mapping.  It's just unlikely.
>
>"pathological worst-case" is something that is repeatable.

And you probably mean "repeatable every time".  Ok, then a random
scheme has, by your definition, no pathological worst case.  I am not
sure that this is a consolation when I happen upon one of its
unpredictable and unrepeatable worst cases.

>> Well, even if, on average, it has no performance impact,
>> reproducibility is a good reason to like it.  Is it good enough to
>> implement it?  I'll leave that to you.
>
>Well, since random (or, more accurately in this case, "pseudo-random") has 
>a number of things going for it, and is a lot faster and cheaper to 
>implement, I don't see the point of cache coloring.

The points are:

- repeatability
- predictability
- better average performance (you dispute that).

>Hey, the discussion in this case showed how it _deproves_ performance (at 
>least if my theory was correct - and it should be easily testable and I 
>bet it is).

I don't think that discussing this special case answers the question
about "on average" performance, but here we go:

For the Coppermine results I see that the performance of the malloc()
case is only better with span 2048 and 4096, and not by much.  For the
Williamette 16MB results I see very little difference, except for the
span=4096 case, by a lot.  For the Williamette 4MB case I see slightly
better performance for hugetlbfs for spans 256,512, and 1024, and a
little worse performance for spans 2048 and 4096.

Yes, mapping policy could be part of the explanation for these
results: With the smaller spans, you get no cache hits with either
mapping policy.  With larger spans, random mapping might return to
some of the lines before evicting them.

However, this is probably not the whole picture, because with that
explanation we would expect that the times for larger spans with
random mapping should be better than for smaller spans, but they are
not.  There is something else at work that makes the times larger with
larger spans (maybe DRAM row switching?).

I see no easy way to test your theory (at least until I can measure
cache *and* TLB misses again on a machine I have access to).

Anyway, back to the performance effects of page colouring: Yes, there
are cases where it is not beneficial, and the huge-2^n-stride cases in
examples like the one above are one of them, but I don't think that
this is the kind of "real life" application that you mention
elsewhere, or is it?

>Also, the work has been done to test things, and cache coloring definitely
>makes performance _worse_. It does so exactly because it artifically
>limits your page choices, causing problems at multiple levels (not just at
>the cache, like this example, but also in page allocators and freeing).

Sorry, I am not aware of the work you are referring to.  Where can I
read more about it?  Are you sure that these are fundamental problems
and not just artifacts of particular implementations?

>So basically, cache coloring results in:
> - some nice benchmarks (mainly the kind that walk memory very 
>   predictably, notably FP kernels)

Predictable accesses are not important, spatial locality is.

> - mostly worse performance in "real life"

Like the code above?-)

Hmm, maybe the pathological large-2^n-stride stuff is more frequent
than I would expect.  But I think it's possible to have a repeatable
and mostly understandable/predictable mapping policy that does not
have this pathological worst case (of course, being repeatable, it
will have a different one:-), and can provide better average
performance than random mapping by exploiting spatial locality.

> - much worse memory pressure

That sounds like an implementation artifact.

>My strong opinion is that it is worthless except possibly as a performance
>tuning tool, but even there the repeatability is a false advantage: if you
>do performance tuning using cache coloring, there is nothing that
>guarantees that your tuning was _correct_ for the real world case.

How does _correct_ness come into play?

As for performance, I guess there are three cases:

- Changes that have little to do with the memory hierarchy.  These are
probably easier to evaluate in a repeatable environment, and any
performance improvements should transfer nicely into a random-mapping
environment.

- Changes that address the pathological case for the repeatable
environment, e.g., (in the context of page colouring) eliminating
large 2^n strides; this particular optimization will have less effect
in a random-mapping environment, but typically still a positive one
(random mapping also suffers from strides that are multiples of the
page size).

- Changes that tune particularly for specific cache sizes, e.g., cache
blocking.  The results may be supoptimal for the random-mapping case;
probably better than just picking the parameter at random, but in most
runs worse than some other parameter.  I wonder if you get any better
results if you make just one run for a number of parameter values in a
random-mapping environment and pick the parameter that gave the best
result (which may have more to do with the mapping in this run than
with the parameter).

In conclusion, I think that tuning in a page colouring environment
will transfer into a random-mapping environment well in most cases.

- anton
