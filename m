Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265331AbSKABt1>; Thu, 31 Oct 2002 20:49:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265345AbSKABt0>; Thu, 31 Oct 2002 20:49:26 -0500
Received: from dc-mx02.cluster1.charter.net ([209.225.8.12]:32492 "EHLO
	mx02.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S265331AbSKABtX>; Thu, 31 Oct 2002 20:49:23 -0500
Message-ID: <3DC1DEFB.6070206@free-market.net>
Date: Thu, 31 Oct 2002 17:55:07 -0800
From: "Matthew D. Hall" <mhall@free-market.net>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
CC: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-aio@kvack.org, lse-tech@lists.sourceforge.net,
       Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Unifying epoll,aio,futexes etc. (What I really want from epoll)
References: <20021031154112.GB27801@bjl1.asuk.net> <Pine.LNX.4.44.0210311211160.1562-100000@blue1.dev.mcafeelabs.com> <20021031230215.GA29671@bjl1.asuk.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I may respectfully weigh in...

If a new API and/or a significant change in semantics is to be applied 
to the kernel for a unified event notification system, this is obviously 
an issue for 2.7 or 2.9.  As such, we have plenty of time to focus upon 
simplicity and correctness rather than plain old inertia.  We need to 
bring a truly unified, and therefore new, event API to the kernel, and 
it must be done right.  kevent attempts to achieve this for FreeBSD, and 
generally speaking, it succeeds.  But linux can do much better.

The API should present the notion of a general edge-triggered event 
(e.g. I/O upon sockets, pipes, files, timers, etc.), and it should do so 
simply.  Linus made some suggestions on lkml back in 2000 
(http://marc.theaimsgroup.com/?l=linux-kernel&m=97236943118139&w=2) that 
pretty much hit the nail on the head -- with some exceptions.

*  Unless every conceivable event is to be represented as a file (rather 
unintuitive IMHO), his proposed interface fails to accomodate non-I/O 
events (e.g. timers,  signals, directory updates, etc.).  As much as I 
appreciate the UNIX Way, making everything a file is a massive 
oversimplification.  We can often stretch the definition far enough to 
make this work, but I'd be impressed to see how one intends to call, 
e.g., a timer a type of file.

*  There is a seemingly significant overhead in performing exactly one 
callback per event.  Doesn't this prevent any kind of event coalescence? 
 It seems like we could be doing an awful lot of cache thrashing, among 
other things.  In some cases, this might happen anyway, but why should 
the interface enforce such behavior?  In most other cases, it's 
perfectly acceptable to inline an event handler (either via compile-time 
inlining or literally).  I do realize that Linus only suggested that the 
C library do the mass callbacks, BTW, so strictly speaking, it's the 
userland API that would "enforce such behavior."  Nonetheless, this is 
of concern.

Enough of what we shouldn't do.  Here's what we should:

*  The interface should allow the implementation to be highly extensible 
without horrible code contortions within the kernel.  It is important to 
be able to add new types of events as they become necessary.  The 
interface should be general and simple enough to accomodate these 
extensions.  Linux (really, UNIX) has failed to exercise this foresight 
in the past, and that's why we have the current mess of varied 
polling/triggering methods.

*  I might be getting a bit utopian here, but IMHO the kernel should 
move toward a completely edge-triggered event system.  The old 
level-triggered interfaces should only wrap this paradigm.

*  Might as well reiterate: simplicity.  FreeBSD's kevent solves nearly 
all of the traditional problems, but it is gross.  And complicated. 
 There were clearly too many computer scientists and not enough 
engineers on that team.

*  Only one queue per process or kernel thread.  Multiple queues per 
flow of execution is just ugly and ultimately pointless.  That is not to 
say that you can't multithread, but each thread simply uses the same 
queue.  In cases when you want one thread to only wait on a certain 
type(s) of event, you can do this as well; you just can't have one 
thread juggling more than one queue.  Since the event notification is 
edge-triggered, I cannot see any reason for a significant performance 
degradation resulting from this policy.  I am not altogether convinced 
that this must be a strict policy, however; the issue of different 
userspace threads having different event queues inside the same task is 
interesting.

*  No re-arming events.  They must be manually killed.

*  I'm sure everyone would agree that passing an opaque "user context" 
pointer is necessary with each event.

*  Zero-copy event delivery (of course).

Some question marks:
-  Should the kernel attempt to prune the queue of "cancelled" events 
(hints later deemed irrelevant, untrue, or obsolete by newer events)?
-  Is one-queue-per-task really the way to go?  This stops many bad 
practices but could prevent some decent ones (see user threads comment).

Matthew D. Hall


