Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbRDSSZB>; Thu, 19 Apr 2001 14:25:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRDSSYv>; Thu, 19 Apr 2001 14:24:51 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:9979 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132318AbRDSSYk>;
	Thu, 19 Apr 2001 14:24:40 -0400
Date: Thu, 19 Apr 2001 14:24:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104191036220.5052-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104191409270.16930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Linus Torvalds wrote:

> 
> 
> On Thu, 19 Apr 2001, Alexander Viro wrote:
> >
> > Ehh... Non-lazy variant is just read() and write() as down_failed() and
> > up_wakeup() Lazy... How about
> 
> Looks good to me. Anybody want to try this out and test some benchmarks?

Ugh. It doesn't look good for me. s/MAX_INT/MAX_INT>>1/ or we will
get into trouble on anything that goes into spin_and_lose. Window is
pretty narrow (notice that lost_it is OK - we only need to worry
about somebody coming in after winner drives Lock from 1 to 0
and before it gets it from 0 to MAX_INT), but we can get into serious
trouble if schedule() will hit that window.

MAX_INT/2 should be enough to deal with that, AFAICS.

However, I would _really_ like to get that code reviewed from the memory
access ordering POV. Warning: right now I'm half-asleep, so the thing can
very well be completely bogus in that area. Extra eyes would be certainly
welcome.

								Al

PS: ->Lock should be set to 1 when we initialize semaphore. Destroying
semaphore should do
	if (sem->Lock > 1) {
		close(sem->writer);
		close(sem->reader);
	}

