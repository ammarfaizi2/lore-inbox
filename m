Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131508AbRDSRdt>; Thu, 19 Apr 2001 13:33:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131562AbRDSRdk>; Thu, 19 Apr 2001 13:33:40 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:36524 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S131508AbRDSRdg>;
	Thu, 19 Apr 2001 13:33:36 -0400
Date: Thu, 19 Apr 2001 13:33:02 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104190937400.3842-100000@penguin.transmeta.com>
Message-ID: <Pine.GSO.4.21.0104191249200.16930-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Linus Torvalds wrote:

> 
> 
> On Thu, 19 Apr 2001, Alexander Viro wrote:
> >
> > I certainly agree that introducing ioctl() in _any_ API is a shootable
> > offense. However, I wonder whether we really need any kernel changes
> > at all.
> 
> I'd certainly be interested in seeing the pipe-based approach. Especially
> if you make the pipe allocation lazy. That isn'tr trivial (it needs to be
> done right with both up_failed() and down_failed() trying to allocate the
> pipe on contention and using an atomic cmpxchg-style setting if none
> existed before). It has the BIG advantage of working on old kernels, so
> that you don't need to have backwards compatibility cruft in the
> libraries.

Ehh... Non-lazy variant is just read() and write() as down_failed() and
up_wakeup() Lazy... How about

	if (Lock <= 1)
		goto must_open;
opened:
	/* as in non-lazy case */


must_open:
	pipe(fd);
	lock decl Lock
	jg lost_it	/* Already seriously positive - clean up and go */
	jl spin_and_lose
	/* Lock went from 1 to 0 - go ahead */
	reader = fd[0];
	writer = fd[1];
	Lock = MAX_INT;
	goto opened;
spin_and_lose:
	/* Won't take long - another guy got to do 3 memory writes */
	while (Lock <= 0)
		;
lost_it:
	lock incl Lock
	close(fd[0]);
	close(fd[1]);
	goto opened;

								Al

