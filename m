Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTIEBfm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 21:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261945AbTIEBfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 21:35:42 -0400
Received: from mail.inter-page.com ([12.5.23.93]:8204 "EHLO
	mail.inter-page.com") by vger.kernel.org with ESMTP id S261909AbTIEBfQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 21:35:16 -0400
From: "Robert White" <rwhite@casabyte.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'Larry McVoy'" <lm@work.bitmover.com>,
       "'Brown, Len'" <len.brown@intel.com>,
       "'Giuliano Pochini'" <pochini@shiny.it>,
       "'Larry McVoy'" <lm@bitmover.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Scaling noise
Date: Thu, 4 Sep 2003 18:34:25 -0700
Organization: Casabyte, Inc.
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAz5vR6kM6UkadUOOwLJu68wEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4510
In-Reply-To: <20030903181550.GR4306@holomorphy.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Not to throw a flag on the play but...

Larry asks why penalize low end systems by making the kernel
many-cpu-friendly.  The implicit postulate in his question is that the
current design path is "unfair" to the single and very-small-N N-way systems
in favor of the larger-N and very-large-N niche user base.
 
Lots of discussions then ensue about high end scalability and the
performance penalties of doing memory barriers and atomic actions for large
numbers of CPUs.

I'm not sure I get it.  The large-end dynamics don't seem to apply to the
question, in support nor rebut.  Is there any concrete evidence to support
the inference?

What really is the impact of high-end scalability issues on the low end
machines?

It *seems* that the high-end diminishing returns due to having any one CPU's
cache invalidated by N companions is clearly decoupled from the
uni-processor model because there are no "other" CPUs to cause the bulk of
such invalidations when there is only one processor.

It *seems* that in a single-kernel architecture, as soon as you reach "more
than one CPU" what "must be shared" ...er... must be shared.

It *seems* that what is unique to each CPU (the instances CPU private data
structure) are wholly unlikely to be faulted out because of the actions of
other CPUs.  (that *is* part of why they are in separate spaces, right?)

It *seems* that the high-end degradation of cache performance as N increases
is coupled singularly to the increase in N and the follow-on multi-state
competition for resources.  (That is, it is the real presence of the 64 CPUs
and not the code to accommodate them is the cause of the invalidations.  If,
on my 2-way box I set the MAX_CPU_COUNT to 8 or 64, the only difference in
runtime is the unused memory for the 6 or 62 per-cpu-data structures.  The
cache-invalidation and memory-barrier cost is bounded by the two real CPUs
and not the 62 empty slots.)

It *seems* that any attempt to make a large N system cache friendly would
involve preventing as many invalidations as possible.

And finally, it *seems* that any large-N design, e.g. one that keeps cache
invalidation to a minimum, would, by definition, directly *benefit* the
small N systems because they would naturally also have less invalidation.

That is, "change a pointer, flush a cache" is true for all N greater than 1,
yes?  So if I share between 2 or 1000, it is the actions of the 2 or 1000 at
runtime that exact the cost.  Any design to better accommodate "up to 1000"
will naturally tend to better accommodate "up to 4".

So...

What/where, if any, are the examples of something being written (or some
technique being propounded) in the current kernel design that "penalizes" a
2-by or 4-by box in the name of making a 64-by or 128-by machine perform
better?

Clearly keeping more private data private is "better" and "worse" for its
respective reasons in a memory-footprint for cache-separation tradeoff, but
that is true for all N >= 2.

Is there some concrete example(s) of SMP code that is wrought overlarge?  I
mean all values of N between 1 and 255 fit in one byte (duh 8-) but cache
invalidations happen in more than two bytes, so having some MAX_CPU_COUNT
bounded at 65535 is only one byte more expansive and no-bytes more expensive
in the cache-consistency-conflict space.  At runtime, any loop that iterates
across the number of active CPUs will be clamped at the actual number, and
not the theoretical max.

I suspect that the original question is specious and generally presumes
facts not in evidence.  Of course, just because *I* cannot immediately
conceive of any useful optimization for a 128-way machine that is inherently
detrimental to a 2-way or 4-way box, doesn't mean that no such optimization
exists.

Someone enlighten me please.

Rob White




-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of William Lee Irwin
III
Sent: Wednesday, September 03, 2003 11:16 AM
To: Larry McVoy; Brown, Len; Giuliano Pochini; Larry McVoy;
linux-kernel@vger.kernel.org
Subject: Re: Scaling noise

At some point in the past, I wrote:
>> The lines of reasoning presented against tightly coupled systems are
>> grossly flawed. 

On Wed, Sep 03, 2003 at 11:05:47AM -0700, Larry McVoy wrote:
> [etc].
> Only problem with your statements is that IBM has already implemented all
> of the required features in VM.  And multiple Linux instances are running
> on it today, with shared disks underneath so they don't replicate all the
> stuff that doesn't need to be replicated, and they have shared memory 
> across instances.

Independent operating system instances running under a hypervisor don't
qualify as a cache-coherent cluster that I can tell; it's merely dynamic
partitioning, which is great, but nothing to do with clustering or SMP.


-- wli
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



