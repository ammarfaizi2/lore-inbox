Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271620AbRIGJEH>; Fri, 7 Sep 2001 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271621AbRIGJD6>; Fri, 7 Sep 2001 05:03:58 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:9908 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S271620AbRIGJDp>;
	Fri, 7 Sep 2001 05:03:45 -0400
Date: Fri, 07 Sep 2001 09:58:47 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>,
        riel@conectiva.com.br, linux-kernel@vger.kernel.org
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [RFC] Defragmentation proposal: preventative maintenance and
 cleanup [LONG]
Message-ID: <1426827386.999856726@[169.254.198.40]>
In-Reply-To: <20010907062851Z16136-26184+30@humbolt.nl.linux.org>
In-Reply-To: <20010907062851Z16136-26184+30@humbolt.nl.linux.org>
X-Mailer: Mulberry/2.1.0 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

Some comments in line - if you are modelling this, vital you
understand the first!

>> The buddy allocator will attempt (by looking at lowest order lists first)
>> to allocate pages from fragmented areas first. Assuming pages are freed
>> at random, this would act as a defragmentation process. However, if a
>> system is taken to high utilization and back again to idle, the
>> dispersion of persistent pages (for instance InactiveDirty pages)
>> becomes great, and the buddy allocator performs poorly at coalescing
>> blocks.
>
> It becomes effectively useless.  The probability of all 8 pages of a given
> 8 page unit being free when only 1% of memory is free is (1/100)**8 =
> 1/(10**16).

I thought that, then I tested & measured, and it simply isn't true.
Your mathematical model is wrong.

The reason is because pages are freed at random, but they are not
allocated at random. The buddy allocator allocates pages whose
buddy is allocated (lower order) preferentially to splitting a high
order block. Sorry to sound like a broken record, but apply the
/proc/memareas patch and you can see this happening. After extensive
activity, you see practically none of the free pages in order 0
blocks. You might see only a small number (20 or 30 on a 64k
machine) of (say) order 3 blocks, but if you run your stats
you would have an expected value of well less than one, and the
chance of having 20 or 30 would be vanishingly small. Local
aggregation is actually quite effective, provided that the
density of persistent pages is not too great. However, it
gets considerably less effective as the order increases.

> Moving pages sounds scary.  We already know how to evict pages, but moving
> pages is a whole new mechanism.  We probably would not care about the
> "good" data lost through eviction as opposed to moving fraction of pages
> we'd have to evict to do the required defragmentation is tiny.

The sort of moving I was talking about was a diskless page-out / page-in,
i.e. which didn't require a swap file, or I/O, and was thus much quicker.
Whilst the page would be physically moved, it's virtual address would
stay the same. Though this sounds like a completely new system, I think
there's a high probability of this just being a special case of
the page out routine.

> I'm going to confess that I don't understand your solution in detail yet,
> however, I can see this complaint coming: the changes are too intrusive on
> the existing kernel,

A valid criticism. But difficult to see how defragmentation that actually
takes account of the contents of memory (rather than 'blind' freeing)
could be less intrusive - though I'm open to ideas.

> and if that's what we had to do it would probably be
> easier to just eliminate all high order allocations from the kernel.  I
> already have heard some sentiment that the 0 order allocation failure
> problems do not have to be solved, that they are really the fault of those
> coders that used the feature in the first place.

I'd be especially interested to know how we'd solve this for the
network stuff, which currently relies on physically contiguous packets
in memory. This is a *HUGE* change I think (larger than any we'd
make to the VM system).

> But I'm pretty sure that whatever
> solution we come up with, it has to be very simple in implementation, and
> have roughly zero impact on the rest of the kernel.

This would of course be ideal.

--
Alex Bligh
