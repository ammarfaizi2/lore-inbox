Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268974AbRG0VML>; Fri, 27 Jul 2001 17:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268087AbRG0VLv>; Fri, 27 Jul 2001 17:11:51 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:15365 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S268112AbRG0VLo>; Fri, 27 Jul 2001 17:11:44 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Lawrence Greenfield <leg+@andrew.cmu.edu>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: ext3-2.4-0.9.4
Date: Fri, 27 Jul 2001 23:16:30 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E15QAon-00061p-00@the-village.bc.nu> <200107271741.f6RHfe8U010593@acap-dev.nas.cmu.edu>
In-Reply-To: <200107271741.f6RHfe8U010593@acap-dev.nas.cmu.edu>
MIME-Version: 1.0
Message-Id: <0107272316300R.00285@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Friday 27 July 2001 19:41, Lawrence Greenfield wrote:
> From: Alan Cox <alan@lxorguk.ukuu.org.uk>
> > Lawrence Greenfield wrote:
> > > You want to help performance?  Give us an fsync() that works on
> > > multiple file descriptors at once, or an async fsync() call. 
> > > Don't make us fight the OS on getting data to disk.
> >
> > And what pray does an asynchronous fsync do. It seems to be a nop
> to me.
>
> An async fsync allows me to issue multiple fsyncs and then wait for
> all of them to complete, hopefully in the same framework that I would
> do async I/O (but that's an argument for another day).

I'll say.  While it's truly desirable, all known filesystems are *far* 
from being able to do that.  An efficient, reliable fsync would do the 
trick for you, or even an efficient sync.  And somewhere in Andrew 
Morton's bag of tricks is something to fix you up too, read his 
comments carefully.

Looking forward, a sanely defined filesystem transaction interface 
from userland would give the best possible combination of performance 
and reliability.[1]  Since we now have four filesystems (five if you 
count JFFS) that could implement such a transaction interface, now is 
the time to figure out what it would look like.  That would include 
accomodating the needs of MTA developers.  It would be Linux-specific 
for sure.  It would also be progress.  If it turned out to be the 
fastest way to run a mailer we'd see it migrate to other nixes soon 
enough.

>    Doing reliabile transactions on disk is a hard problem. That is
> why oracle and friends have spent many man years of research on this
> kind of problem.

Tell me about it ;-)

> Current unix mailers do the smoke mirrors and prayer
> bit to reduce the probability a little that is all, regardless of fs
> and os.
>
> Isn't the point of the operating system to try to make it as easy as
> possible to do these things correctly?

   begin_transaction (filesystem_handle);
   <send the mail>;
   if (!end_transaction (filesystem_handle))
	<confirm sent>;

Something like that.[2]  Caveat: this is blue-sky stuff, it is not 
going to solve your problem today.  Andrew Morton and Hans Reiser are 
working on solving the problem today by giving you at least one mode 
where rename is synchronous, or at least giving you a fast fsync.

I'm with those who think that a little short-term pain is worth it if 
the final result is superior.

> Otherwise you force anyone who wants to write a reliable application
> (be it e-mail or not) to go to Oracle and one wonders why fsync() is
> even implemented.

[1] Al Viro pointed out that such a transaction interface could open up 
new possibilities for DOS attacks, something that has to be anticipated 
in the design.

[2] I see Alan suggested essentially the same thing in another branch 
of this thread.  Then by the "million flies" theorum...

--
Daniel
