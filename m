Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbULYShZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbULYShZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 13:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbULYShZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 13:37:25 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:27885 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261552AbULYSg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 13:36:56 -0500
Date: Sat, 25 Dec 2004 19:36:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Robert_Hentosh@Dell.com, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH][1/2] adjust dirty threshold for lowmem-only mappings
Message-ID: <20041225183629.GV13747@dualathlon.random>
References: <Pine.LNX.4.61.0412201013080.13935@chimarrao.boston.redhat.com> <20041220125443.091a911b.akpm@osdl.org> <Pine.LNX.4.61.0412231420260.5468@chimarrao.boston.redhat.com> <20041224160136.GG4459@dualathlon.random> <Pine.LNX.4.61.0412241118590.11520@chimarrao.boston.redhat.com> <20041224164024.GK4459@dualathlon.random> <Pine.LNX.4.61.0412241711180.11520@chimarrao.boston.redhat.com> <20041225020707.GQ13747@dualathlon.random> <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412251253090.18130@chimarrao.boston.redhat.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2004 at 12:59:10PM -0500, Rik van Riel wrote:
> 4) any memory that could be affected by the swap token (process
>    text, data, stack, ...) is allocated with __GFP_HIGHMEM, so
>    that all lives in the highmem zone with 2.5GB free
> 5) since dd is not being paged out at all, and can dirty memory
>    without limit, the VM gets backed into a corner and will
>    trigger an OOM kill - even though most of lowmem is simply
>    dirty page cache

This shouldn't happen of course, and it's a bit hard to see how can it
work fine for 23 hours and break at the 24th hour since it's quite a
repetitive algorithm. (sure it could be a race or the algorithm being
very fragile, but I can't reproduce problems here)

Plus doing cp /dev/zero . should be even worse since it also fills up
the highmem.

Are you sure cron isn't spawning something big?

Anyway my point is that swap-token is _proven_ to trigger suprious oom
kills, so if you could just reproduce once with Con's patch applied and
default sysctl value, then you would provide the proof it's unrelated.

I agree with your reasoning, I think you're right, but I'd like to be
sure we're not missing something. There are definitely other reports
where the ignore-token patch wasn't enough and Con's patch fixed it.

I also recommend you to keep vmstat in the background, in my experience
swap token was filling all swap with freeable swapcache (but it wasn't
freeable due the referenced ++ that swap-token does), and then the oom
killer was invoked despite all that freeable swapcache.

So on a computer that had plenty of lowmem and highmem free, in seconds
it would run out of memory with all swap allocated.

I agree dd shouldn't be enough, but the 1 day variable may be just some
big cron task that we didn't put into the equation.

So I still would like to see a `vmstat 1` before/after the killing, and
to hear the confirmation that Con's patch doesn't help.

The only thing I can imagine being wrong with `cp /dev/zero /dev/sd?`
while working fine on `cp /dev/zero .`, are the write throttling levels
that might be taking highmem into account while they really cannot take
highmem into account, I mean nr_free_buffer_pages must be used by the
write throttling and not nr_free_pages, but I'd be surprised if this
wasn't correct. You may want to check this bit just in case. If this is
correct then doing cp /dev/zero . should fail too, no? I for sure can't
reproduce here, and by your same arguments about the highmem levels, it
shouldn't matter how much ram I have (I've 1G). The less ram I have, the
worse it should behave.

Without more data and without being able to reproduce I can't be more
helpful than this.

Thanks.
