Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264750AbRFSTnk>; Tue, 19 Jun 2001 15:43:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264751AbRFSTnb>; Tue, 19 Jun 2001 15:43:31 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:61415 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S264750AbRFSTnU>;
	Tue, 19 Jun 2001 15:43:20 -0400
Date: Tue, 19 Jun 2001 15:43:16 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: bert hubert <ahu@ds9a.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Alan Cox quote? (was: Re: accounting for threads)
In-Reply-To: <E15CR1f-0006Wh-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.21.0106191524420.22741-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 19 Jun 2001, Alan Cox wrote:

> There I disagree. Threads introduce parallelism that the majority of user
> space programmers have trouble getting right (not that C is helpful here).

s/user space//

> A threaded program has a set of extremely complex hard to repeat timing based
> behaviour dependancies. An unthreaded app almost always does the same thing on
> the same input. From a verification and coverage point of view that is 
> incredibly important.

	Exactly. And that's one of the reasons why event-drivel stuff tends to
be buggy. In that respect AIO is not going to be much better than threads.

	BTW, threads of execution don't have to share memory to give an
opportunity of screwup. Lovely example:

	pid = fork():
	if (!pid) {
		while(1) {
			long tmp = lseek(fd, 0, SEEK_CUR);
			long len = lseek(fd, 0, SEEK_END);
			lseek(fd, tmp, SEEK_SET);
			if (!foo(len))
				exit(0);
			sleep(1);
		}
	}
	/* write a lot of stuff to fd */

That, BTW, is pretty close to the GUI braindamage Larry had refered to -
helper process implemented a progress bar.

_Extremely_ nasty data corruption - if child loses timeslice between
the first and third lseeks and parent happens to get that timeslice and
write next chunk...  Happy, happy, joy, joy - child will put the IO pointer
back to the place where it used to be and the next chunk will merrily
overwrite the thing.  Real fun to debug - the thing happens rarely (normally
child has rather high priority after voluntary sleep) and corruption has
a good chance to be confused for an OS bug. Especially if box with OS foo
had demonstrated that behaviour couple of times and box with OS bar either
hadn't done that so far, or corruption hadn't been noticed.

And yes, it's a real-world example - been there, LARTed the idiot who had
written that crap.

