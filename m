Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264929AbRFUILP>; Thu, 21 Jun 2001 04:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264931AbRFUILF>; Thu, 21 Jun 2001 04:11:05 -0400
Received: from www.wen-online.de ([212.223.88.39]:41222 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S264929AbRFUIKu>;
	Thu, 21 Jun 2001 04:10:50 -0400
Date: Thu, 21 Jun 2001 10:10:14 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.5-ac15
In-Reply-To: <Pine.LNX.4.21.0106210226330.14247-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.33.0106210934460.1243-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2001, Marcelo Tosatti wrote:

> On Thu, 21 Jun 2001, Mike Galbraith wrote:
>
> > On Thu, 21 Jun 2001, Marcelo Tosatti wrote:
> >
> > > >  2  4  2  77084   1524  18396  66904   0 1876   108  2220 2464 66079   198   1
> >                                                                    ^^^^^
> > > Ok, I suspect that GFP_BUFFER allocations are fucking up here (they can't
> > > block on IO, so they loop insanely).
> >
> > Why doesn't the VM hang the syncing of queued IO on these guys via
> > wait_event or such instead of trying to just let the allocation fail?
>
> Actually the VM should limit the amount of data being queued for _all_
> kind of allocations.

Limiting the amount of data being queued for IO will make things less
ragged, but you can't limit the IO.. pages returning to service upon
completion is the only thing keeping you alive.  That's why I hate not
seeing my disk utterly saturated when things get hot and heavy.  The
only thing that I can see that's possible is to let tasks proceed in
an ordered fashion as pages return.. take a number and wait.  IMHO,
right now we try to maintain low latency way too long and end up with
the looping problem because of that.  We need a more controlled latency
roll-down to the full disk speed wall.  We hit it and go splat ;-)

> The problem is the lack of a mechanism which allows us to account the
> approximated amount of queued IO by the VM. (except for swap pages)

Ingo once mentioned an io thingy for vm, but I got kind of dizzy trying
to figure out exactly how I'd impliment, what with clustering and getting
information to seperate io threads and back ;-)

> You can see it this way: To get free memory we're "polling" instead of
> waiting on the IO completion of pages.
>
> > (which seems to me will only cause the allocation to be resubmitted,
> > effectively changing nothing but adding overhead)
>
> Yes.

(not that overhead really matters once you are well and truely iobound)

	-Mike

