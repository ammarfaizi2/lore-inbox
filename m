Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267585AbRGZMCr>; Thu, 26 Jul 2001 08:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbRGZMCh>; Thu, 26 Jul 2001 08:02:37 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:61960 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S267585AbRGZMC2>; Thu, 26 Jul 2001 08:02:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: ebiederm@xmission.com (Eric W. Biederman),
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: [RFC] Optimization for use-once pages
Date: Thu, 26 Jul 2001 14:06:29 +0200
X-Mailer: KMail [version 1.2]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
        Ben LaHaise <bcrl@redhat.com>, Mike Galbraith <mikeg@wen-online.de>
In-Reply-To: <Pine.LNX.4.33L.0107251340550.20326-100000@duckman.distro.conectiva> <m1ae1sf5od.fsf@frodo.biederman.org>
In-Reply-To: <m1ae1sf5od.fsf@frodo.biederman.org>
MIME-Version: 1.0
Message-Id: <0107261406290L.00907@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Thursday 26 July 2001 10:36, Eric W. Biederman wrote:
> Rik van Riel <riel@conectiva.com.br> writes:
> > On Wed, 25 Jul 2001, Daniel Phillips wrote:
> > > On Wednesday 25 July 2001 08:33, Marcelo Tosatti wrote:
> > > > Now I'm not sure why directly adding swapcache pages to the
> > > > inactive dirty lits with 0 zero age improves things.
> > >
> > > Because it moves the page rapidly down the inactive queue towards
> > > the ->writepage instead of leaving it floating around on the
> > > active ring waiting to be noticed.  We already know we want to
> > > evict that page,
> >
> > We don't.
>
> Agreed.  The kinds of ``aging'' don't match up so we can't tell if
> it meets our usual criteria for aging.

Well, in the absence of of benchmark evidence its hard to tell how 
valuable the usual criteria really are.  That's another topic though, 
because the question here is not how the aging matches up, but how the 
inactive queue handling matches up, see below.

> > The page gets unmapped and added to the swap cache the first
> > time it wasn't referenced by the process.
> >
> > This is before any page aging is done.
>
> Actually there has been aging done.  Unless you completely disable
> testing for pte_young.  It is a different kind of aging but it is
> aging.

In the case of a process page and in the case of a file IO page the 
situation is the same: we have decided to put the page on trial.  Once 
we have arrived at that decision its previous history doesn't matter,
so it makes sense to set its age to a known state.  In this case it's 
0, meaning "on trial".

Consider that the process page will only ever be down-aged after being 
unmapped.  So if we put it on the active queue, it just acts like a 
big, slow, inefficient timer.  Why not put it on a fifo queue instead?  
It's the same thing, just more efficient.  But we already have a fifo 
queue, the inactive_dirty_queue, which we are using for everything 
else, so why not use it for this too, then at least we know its fair.

In other words, there is no obvious need to treat a process page 
differently from a file IO page once decide to put it on trial.

There does seem to be a dangling thread here though - when a process 
page is unmapped and added to swap cache in try_to_swap_out then later 
faulted back in, I don't see where we "rescue" the page from the 
inactive queue.  Maybe I'm just not looking hard enough.

--
Daniel
