Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266017AbUEUVnz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266017AbUEUVnz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 17:43:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266024AbUEUVnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 17:43:55 -0400
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:33479 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S266017AbUEUVnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 17:43:50 -0400
Message-ID: <40AE7824.1080702@am.sony.com>
Date: Fri, 21 May 2004 14:44:04 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org
Subject: Re: CONFIG_SLOW_TIMESTAMPS was Re: ANNOUNCE: CE Linux Forum - Specification
 V1.0 draft
References: <1WVF1-Nn-25@gated-at.bofh.it> <1WVYp-11I-5@gated-at.bofh.it>	<1WXdS-279-41@gated-at.bofh.it> <1XiBG-2sN-37@gated-at.bofh.it>	<1XF55-3Ij-7@gated-at.bofh.it> <1XHzV-5OV-9@gated-at.bofh.it> <m3zn83o20n.fsf_-_@averell.firstfloor.org>
In-Reply-To: <m3zn83o20n.fsf_-_@averell.firstfloor.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Theodore Ts'o <tytso@mit.edu> writes:
> 
>>B) When CONFIG_FAST_TIMESTAMPS is enabled, the kernel SHALL provide
>>the following 2 routines:
>>
>>      2.1 void store_timestamp(timestamp_t *t)
> 
> 
> sched_clock() already exists and does that, although it is a bit confusingly
> named. 

I'm not familiar with this call - I'll take a look at it.
Does this replace get_cycles()?

> Or just use do_gettimeofday() which should be fast - it is used
> in networking after all.
Actually, this call was inspired by the networking guys' desire
to use something besides do_gettimeofday().

See http://lwn.net/Articles/61269/

> 
> 
>>      2.2 void timestamp_to_timeval(timestamp_t *t, struct timeval *tv) 
> 
> 
> I don't think this API is a good idea. 
> 
> The obvious way to implement timestamp_t is just store the CPU integrated
> time stamp counter into it (TSC in x86 terminology). But there are CPUs
> where the TSC frequency changes when the CPU changes its core frequency
> for power saving purposes.

The specification for this is in the context of bootup time.
See http://tree.celinuxforum.org/pubwiki/moin.cgi/TimingAPISpecification_5fR1
The spec. acknowledges that changes in clock frequency will be
problematic for this API, but ignores that in the context
of use during the bootup sequence, where the clock frequency
should be stable.

However, if these calls are used outside of bootup context,
then cpu frequency changes are something that would have to be
dealt with. David Miller's proposed solution for this is to
fall back to do_gettimeofday() when a processor lacks
adequate features to support this properly.  We would probably
do that same thing in our implementations.

You acknowledge that newer TSC implementations (and things like
it on other platforms) now avoid this problem.  In the future,
I think this will be less of a problem.  Hopefully the specification
and discussions like this will help inform other semiconductor
vendors about desired features for fast timestamp clocks in new
chips.

 >...
> Anyways, the only way to avoid this problem would be to not use the
> CPU TSC, but some external timer that is independent of the CPU
> frequency (this is sometimes already done to work around other
> problems). The problem is just that such external timers in the
> southbridge are usually factor 100 and more slower than an TSC access
> that can stay inside the CPU, because an access first has to cross the
> slow CPU front side bus.
> 
> This would turn your fast time stamp into an extremly slow time stamp.
Yes.  Our preference would be for all chips to provide good TSC-like
features.  Most of the major semiconductor vendors (and SOC makers
for CE products) are members of the forum.  So hopefully we can drill
this into their brains.

> You would be probably better of by just using do_gettimeofday(), which
> actually has a chance to use the TSC sanely and is not really that
> slow usually.

As I said above, the idea to decouple the timestamp retrieval from
the conversion to normalized units came from the suggestion by
network guys that do_gettimeofday has too much overhead for their
packet-stamping requirements.  In their case, very often the stamps
are not used, and so they thought it would be nice if the conversion
of the values into normalized units (as do_gettimeofday does) were
a separate operation, that could be performed only as needed.

In the case of instrumentation code, the conversion to normalized
units (seconds/microseconds) can often be deferred until the
dump is post-processed in user space.  So if it's possible (but
only if it's possible, mind you :-), then it's nice to separate
these two operations.

Instrumentation code is extremely sensitive to the overhead
introduced by the timing code.  Even for code which uses the
TSC we have seen something like 8% variance in timing of bootup code
because of the introduction of the instrumentation.

Another issue with do_gettimeofday() is that it is not available
as early as we would like in the bootup sequence.  This is because
it requires setup, which usually doesn't happen until setup_arch().
(I know, this happens pretty soon, but we want to capture everything
from start_kernel and beyond.)

Finally, another reason (which is only mentioned very briefly
in the spec.) for not using do_gettimeofday is that we envision
instrumentation scenarios where the time measured goes even
back before start_kernel (that is, it includes the bootloader.

It is pretty easy to get uniformity of time measurements
across both firmware and the kernel using a TSC-like feature, because
the TSC requires no setup. do_gettimeofday() does not have this property.
Other CPU-external clocks could be configured by firmware, and
left alone by the kernel, but then read by this API, to achieve
this objective (of measurement uniformity across the kernel
start boundary).

Thanks very much for the feedback.  I'll take a look at sched_clock(),
and, as I said above, we'll probably use do_gettimeofday() for
architectures where the CPU or platform doesn't have features that
support our needs.

The basic idea of this particular feature is to create a standardized
API available on all platforms that instrumentation system authors
can rely on to be there.  A lot of the very good instrumentation
systems (LTT, timepegs, kernel function instrumentation) have historically
relied on TSC reads and many have not been portable to other platforms.
This specification, and the implementations that we're working on now
related to it, are intended to help aid in increasing that portability.

Here' a page of background info, for those interested:
http://tree.celinuxforum.org/pubwiki/moin.cgi/InstrumentationAPI

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

