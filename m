Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271156AbUJVBSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271156AbUJVBSC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271148AbUJVBPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:15:12 -0400
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:43954 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S271167AbUJVBJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 21:09:56 -0400
Date: Fri, 22 Oct 2004 03:10:57 +0200
From: Andrea Arcangeli <andrea@novell.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ZONE_PADDING wastes 4 bytes of the new cacheline
Message-ID: <20041022011057.GC14325@dualathlon.random>
References: <20041021011714.GQ24619@dualathlon.random> <417728B0.3070006@yahoo.com.au> <20041020213622.77afdd4a.akpm@osdl.org> <417837A7.8010908@yahoo.com.au> <20041021224533.GB8756@dualathlon.random> <41785585.6030809@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41785585.6030809@yahoo.com.au>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 10:34:13AM +1000, Nick Piggin wrote:
> Andrea Arcangeli wrote:
> 
> >
> >looks reasonable. only cons is that this rejects on my tree ;), pages_*
> >and protection is gone in my tree, replaced by watermarks[] using the
> >very same optimal and proven algo of 2.4 (enabled by default of course).
> >I'll reevaluate the false sharing later on.
> >
> 
> May I again ask what you think is wrong with ->protection[] apart from
> it being turned off by default? (I don't think our previous conversation
> ever reached a conclusion...)

the API is flawed, how can set it up by default? if somebody tweaks
pages_min it get screwed.

plus it's worthless to have pages_min/low/high and protection[] when you
can combine the two things together. those pages_min/low/high and
protection combined when protection itself is calculated in function of
pages_min/low/high just creates confusion. I believe this comments
explains it well enough:

/*
 * setup_per_zone_protection - called whenver min_free_kbytes or
 *	sysctl_lower_zone_protection changes.  Ensures that each zone
 *	has a correct pages_protected value, so an adequate number of
 *	pages are left in the zone after a successful __alloc_pages().
 *
 *	This algorithm is way confusing.  I tries to keep the same
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 *	behavior
 *	as we had with the incremental min iterative algorithm.
 */

I've to agree with the comment, if I've to start doing math on top of
this algorithm, it's almost faster to replace it with the 2.4 one that
has clear semantics.

Example of the runtime behavaiour of the very well understood
lowmem_reserve from 2.4, it's easier to make an example than to explain
it with words:

	1G machine -> (16M dma, 800M-16M normal, 1G-800M high)
	1G machine -> (16M dma, 784M normal, 224M high)

sysctl defaults are:

int sysctl_lower_zone_reserve_ratio[MAX_NR_ZONES-1] = { 256, 32 };

the results will be:

1) NORMAL allocation will leave 784M/256 of ram reserved in the ZONE_DMA

2) HIGHMEM allocation will leave 224M/32 of ram reserved in ZONE_NORMAL

3) HIGHMEM allocation will (224M+784M)/256 of ram reserved in ZONE_DMA

I invented this algorithm to scale in all machines and to make the
memory reservation not noticeable and only beneficial. With this API is
trivial to tune and to understand what will happen, the default value
looks good and they're proven by years of production in 2.4. Most
important: it's only in function of the sizes of the zones, the
pages_min levels have nothing to do with it.

I'm still unsure if the 2.6 lower_zone_protection completely mimics the
2.4 lowmem_zone_reserve algorithm if tuned by reversing the pages_min
settings accordingly, but I believe it's easier to drop it and replace
with a clear understandable API that as well drops the pages_min levels
that have no reason to exists anymore, than to leave it in its current
state and to start reversing pages_min algorithm to tune it from
userspace (in the hope nobody could ever tweak pages_min calculation in
the kernel, to avoid breaking the userspace that would require
kernel-internal knowledge to have a chance to tune lowmem_protection
from a rc.d script).
