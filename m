Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265379AbUAPRGD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 12:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265500AbUAPRGD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 12:06:03 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:43382 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265379AbUAPRF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 12:05:58 -0500
Date: Fri, 16 Jan 2004 17:05:55 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: marcel cotta <marcel@kriminell.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.1: kernel BUG at mm/swapfile.c:806
In-Reply-To: <400787F7.4030005@kriminell.com>
Message-ID: <Pine.LNX.4.44.0401161618310.7487-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jan 2004, marcel cotta wrote:
> marcel cotta wrote:
> >> marcel cotta <marcel@kriminell.com> wrote:
> >>>> marcel cotta <marcel@kriminell.com> wrote:
> >>>>
> >>>>> i got this oops after the box swapped like crazy under X for about 
> >>>>> 5 minutes
> >>>>> while swapping it was nearly unusable (jerky mouse, console 
> >>>>> switching took 10 seconds)
> >>>>> the extreme performance drop is always reproducible when swapping 
> >>>>> starts
> >>>>>
> >>>>> kernel BUG at mm/swapfile.c:806!
> >>>
> >>> i used swapfiles, one static 50mb file and the rest in temp 16MB 
> >>> blocks managed by swapd

I'll deal with the main issue below, a couple of minor points first.

> > have a look at the total swap amount, free reports 127476 but the
> > total should be 143656
> 
> thats makes a difference of 16180 kb, so 4 kb must be missing since a 
> swapfile is 16184
> these are exactly the 4 bytes in the /swap/linux8.swp

I think you've made the right calculation there (except "kilobytes"
where you say "bytes" - or "kibibytes" even if dwmw2 is watching).

What's almost certainly happening there is that swapd is at that time
in swapoff /swap/linux8.swp.  Think about it: swapoff takes a significant
amount of time, during that time the swap area is shown, with usual Size
and Used, in /proc/swaps, but what should free show for it?  Years ago
it could even show negative total swap, but I changed swapinfo to count
the still-in-use blocks in total, but not the no-longer-in-use blocks
(whereas for areas not in swapoff it counts both in-use and not-in-use).

> i just tried to less it - the process went right into D state :p

That sounds like an issue that came up a month or two back: seems that
sys_swapon intentionally leaves a semaphore down on a swapfile, until
sys_swapoff.  I don't like that at all!  The noble reason was to stop
that file from being deleted or truncated while in use for swap,
but perhaps we can devise a better way to achieve that sometime -
set S_IMMUTABLE?

The main issue.  I haven't tracked it down for sure, but found enough
wrong in that area that I'm inclined to prepare a patch (today? maybe,
maybe not) rather than decipher further.

Your /swap filesystem: I think its block size is less than 4k, yes?
If not, then I'm entirely off on the wrong track.

The problem I see is that setup_swap_extents (mainly for swapfiles)
gets called after all the traditional badblock stuff, but if many
file pages are not aligned and contiguous on disk page boundaries
then it can severely reduce the number of usable pages in that swap
area: there may be much less swap available than kernel and swapd
think.  Which may explain all the thrashing you see.

Plus, I think, the header page of the swapfile must always be at
offset 0, but setup_swap_extents is liable to map it further down.
I've not yet thought through whether this is only a problem if no
other suitable page is found for swap, or if it's a wider problem.

I must divert from this for now, will be back in touch later.

Hugh

