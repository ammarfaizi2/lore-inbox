Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261385AbRE3PTP>; Wed, 30 May 2001 11:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbRE3PTF>; Wed, 30 May 2001 11:19:05 -0400
Received: from www.wen-online.de ([212.223.88.39]:14861 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S261297AbRE3PTA>;
	Wed, 30 May 2001 11:19:00 -0400
Date: Wed, 30 May 2001 17:18:01 +0200 (CEST)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Craig Kulesa <ckulesa@as.arizona.edu>, <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: Plain 2.4.5 VM
In-Reply-To: <l03130301b73a9b647979@[192.168.239.105]>
Message-ID: <Pine.LNX.4.33.0105301626420.410-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001, Jonathan Morton wrote:

> >The page aging logic does seems fragile as heck.  You never know how
> >many folks are aging pages or at what rate.  If aging happens too fast,
> >it defeats the garbage identification logic and you rape your cache. If
> >aging happens too slowly...... sigh.
>
> Then it sounds like the current algorithm is totally broken and needs
> replacement.  If it's impossible to make a system stable by choosing the
> right numbers, the system needs changing, not the numbers.  I think that's
> pretty much what we're being taught in Control Engineering.  :)

I wouldn't go so far as to say totally broken (mostly because I've tried
like _hell_ to find a better way, and [despite minor successes] I've not
been able to come up with something which covers all cases that even _I_
[hw tech] can think of well).  Hard numbers are just plain bad, see below.

I _will_ say that it is entirely too easy to break for comfort ;-)

> Not having studied the code too closely, it sounds as though there are half
> a dozen different "clocks" running for different types of memory, and each
> one runs at a different speed and is updated at a different time.
> Meanwhile, the paging-out is done on the assumption that all the clocks are
> (at least roughly) in sync.  Makes sense, right?  (not!)

No, I don't think that's the case at all.  The individual zone balancing
logic (or individual page [content] type logic) hasn't been inplimented
yet (content type handling I don't think we want), but doesn't look like
it'll be any trouble to do with the structures in place.  That's just a
fleshing out thing.  The variations in aging rate is the most difficult
problem I can see.  IMHO, it needs to be either decoupled and done by an
impartial bystander (tried that, ran into info flow troubles because of
scheduling) or integrated tightly into the allocator proper (tried that..
interesting results but has problems of it's own wrt the massive changes
in general strategy needed to make it work.. approaches rewrite)

> I think it's worthwhile to think of the page/buffer caches as having a
> working set of their own - if they are being heavily used, they should get
> more memory than if they are only lightly used.  The important point to get
> right is to ensure that the "clocks" used for each memory area remain in
> sync - they don't have to measure real time, just be consistent and fine
> granularity.

IMHO, the only thing of interest you can do with clocks is set your state
sample rate.  If state is changing rapidly, you must sample rapidly.  As
far as corrections go, you can only insert a corrective vector into the
mix and then see if the sum induced the desired change in direction.  The
correct magnitude of this vector is not even possible to know.. that's
what makes it so darn hard [defining numerical goals is utterly bogus].

> I'm working on some relatively small changes to vmscan.c which should help
> improve the behaviour without upsetting the balance too much.  Watch this
> space...

With much interest :)

	-Mike

