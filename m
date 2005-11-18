Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbVKRIDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbVKRIDY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:03:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030443AbVKRIDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:03:24 -0500
Received: from silver.veritas.com ([143.127.12.111]:48528 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1030441AbVKRIDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:03:23 -0500
Date: Fri, 18 Nov 2005 08:02:02 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "David S. Miller" <davem@davemloft.net>
cc: nickpiggin@yahoo.com.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/11] unpaged: COW on VM_UNPAGED
In-Reply-To: <20051117.224516.118147408.davem@davemloft.net>
Message-ID: <Pine.LNX.4.61.0511180730530.5435@goblin.wat.veritas.com>
References: <Pine.LNX.4.61.0511171936440.4563@goblin.wat.veritas.com>
 <20051117.155230.25121238.davem@davemloft.net> <437D6AD0.5080909@yahoo.com.au>
 <20051117.224516.118147408.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 18 Nov 2005 08:03:22.0791 (UTC) FILETIME=[8BBEF370:01C5EC16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the abortive earlier send...

On Thu, 17 Nov 2005, David S. Miller wrote:
> From: Nick Piggin <nickpiggin@yahoo.com.au>
> Date: Fri, 18 Nov 2005 16:46:56 +1100
> 
> > I think for 2.6.15, yes. We [read: I :(] was too hasty in removing
> > this completely.

No, that was not too hasty: we all agreed that the case _ought_ not to
arise, and we hadn't worked out the right code to handle it if it did
arise.  What was disappointing is that nobody hit the warnings while
it was in -mm, but only when it hit Linus' tree.

> > However I think it would not be unresonable to spit
> > out a warning, and remove it in 2.6.??

Yes.

> I am so convinced that handling COW faults on VM_RESERVED is
> unnecessary, that I think it's prudent to spit out a warning
> for MAP_PRIVATE+VM_RESERVED and changing it to MAP_SHARED
> to complete the mmap() call.
> 
> I bet every single application still works.

Maybe, but MAP_SHARED PROT_WRITE needs write permission on the device,
whereas MAP_PRIVATE PROT_WRITE only needs read permission.  I'd hate
to be giving away write permissions like this.

If I remember rightly from earlier trawls around here, one of the
nasty things I found was many drivers not checking whether private
or shared, but giving a writable vm_page_prot in either case (you
hint at this in one of your other mails).

I expect there are devices where read permission is in fact just as
dangerous as write permission; but nonetheless we ought to clean
that up with checks in the drivers.

> And we'll have none of this rediculious complex crap handling COW
> pages in VM_RESERVED areas, which I believe is seriously more
> complicated than what we started with before any of the VM_RESERVED
> changed went into 2.6.15.  In fact, we might as well go back to the
> 2.6.14 stuff instead.  I do not see the second half of Hugh's patches
> as progress, it's a severe regression to even 2.6.14

I agree with your principles, but not with your timings.

That code is necessary to reproduce the existing behaviour, which has
always done COW on PageReserved mappings without complaint - if the
vm_page_prot didn't already let you slip through without a WP fault.

(But even if the driver set up too relaxed a vm_page_prot intentionally,
that's vulnerable to having write protection added by mprotect or more
likely fork, if the mapping is actually declared to be private.)

You may be right that in fact nothing has ever been doing COW on
PageReserved mappings.  But we don't know that.  And we don't have
time to waste letting 2.6.15 sail forward, without being able to
handle the case if it turns out it is really needed.  Changing the
apps (and all the user installations) at short notice is not a
sensible option.

We should stick with my "rediculious complex crap handling" for now
(it's not bad at all!  and you should see what I originally sent
Nick for that!), and I should send Andrew a patch to add a warning
there later in the day.

> Doing a get_user_pages() on a VM_UNPAGED area, that's sane, and
> we know exactly what makes use of that.  COW faults on VM_UNPAGED
> areas, that's not sane, and we don't know of a single instance
> which correctly needs that behavior.
> 
> MAP_SHARED mappings of reserved pages shared between driver, device,
> and userspace is common and understandable.  But MAP_PRIVATE mappings
> of such things?  Please show me an example of something legitimately
> using that, and not doing so by mistake.  I will drop all of my
> arguments once I see that :-)
> 
> Because, frankly, a lot of these COW on VM_UNPAGED patches seemingly
> are derived from studying the MM and a few drivers and saying "oh yes,
> that's _possible_" but that is far from being enough to justify this
> complexity.  We really need to see real usage, that makes sense.
> All the cases I've investigated in userspace are "they really want
> MAP_SHARED" or "they didn't need PROT_WRITE in the first place".

Yes, we do agree with this, which is why the core PageReserved removal
started out with just warning messages and refusal.

But 2.6.15-rc2 is the wrong point for conducting experiments in what
strange applications might be up to.  And we know there's lots of
driver cleanup to be done around here: I agree with your suggestions
in earlier mail about tidying them up, but it probably won't happen
quickly.  vmalloc_to_page was a _huge_ improvement to them, but
that's about the only thing that's been done in many years.

It's one of those areas where you go in, and find more and more,
and it's hard ever to wrap it up.  I'm sure it's already too late
to expect any such cleanup in 2.6.16, but 2.6.17 or 2.6.18 perhaps.

Hugh
