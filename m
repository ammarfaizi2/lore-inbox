Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287633AbSBCTWw>; Sun, 3 Feb 2002 14:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287645AbSBCTWn>; Sun, 3 Feb 2002 14:22:43 -0500
Received: from PACIFIC-CARRIER-ANNEX.MIT.EDU ([18.7.21.83]:16287 "EHLO
	pacific-carrier-annex.mit.edu") by vger.kernel.org with ESMTP
	id <S287633AbSBCTWf>; Sun, 3 Feb 2002 14:22:35 -0500
Message-Id: <200202031922.OAA17250@multics.mit.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Dan Kegel <dank@kegel.com>
cc: Vincent Sweeney <v.sweeney@barrysworld.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coder-com@undernet.org" <coder-com@undernet.org>,
        "Kevin L. Mitchell" <klmitch@MIT.EDU>
Subject: Re: PROBLEM: high system usage / poor SMP network performance
In-Reply-To: Your message of "Sun, 03 Feb 2002 00:03:57 PST."
             <3C5CEEED.E98D35B7@kegel.com> 
Date: Sun, 03 Feb 2002 14:22:28 -0500
From: Kev <klmitch@MIT.EDU>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm.  Have a look at
> http://www.mail-archive.com/coder-com@undernet.org/msg00060.html
> It looks like the mainline Undernet ircd was rewritten around May 2001
> to support high efficiency techniques like /dev/poll and kqueue.
> The source you pointed to is way behind Undernet's current sources.

This code is still in beta testing, by the way.  It's certainly not the
prettiest way of doing it, though, and I've started working on a new
implementation of the basic idea in a library, which I will then use in
a future version of Undernet's ircd.

> Undernet's ircd has engine_{select,poll,devpoll,kqueue}.c, 
> but not yet an engine_rtsig.c, as far as I know.
> If you want ircd to handle zillions of simultaneous connections
> on a stock 2.4 Linux kernel, rtsignals are the way to go at the
> moment.  What's needed is to write ircd's engine_rtsig.c, and 
> modify ircd's os_linux.c to notice EWOULDBLOCK
> return values and feed them to engine_rtsig.c (that's the icky
> part about the way linux currently does this kind of event 
> notification - signals are used for 'I'm ready now', but return
> values from I/O functions are where you learn 'I'm no longer ready').

I haven't examined the usage of the realtime signals stuff, but I did
originally choose not to bother with it.  It may be possible to set up
an engine that uses it, and if anyone gets it working, I sure wouldn't
mind seeing the patches.  Still, I'd say that the best bet is probably
to either use the /dev/poll patch for linux, or grab the /dev/epoll patch
and implement a new engine to use it.  (I should note that I haven't tried
either of these patches, yet, so YMMV.)

> So I dunno if I'm going to go ahead and do that myself, but at least I've
> scoped out the situation.  Before I did any work, I'd measure CPU
> usage under a simulated load of 2000 clients, just to verify that
> poll() was indeed a bottleneck (ok, can't imagine it not being a
> bottleneck, but it's nice to have a baseline to compare the improved
> version against).

I'm very certain that poll() is a bottle-neck in any piece of software like
ircd.  I have some preliminary data which suggests that not only does the
/dev/poll engine reduce the load averages, but that it scales much better:
Load averages on that beta test server dropped from about 1.30 to about
0.30 for the same number of clients, and adding more clients increases the
load much less than under the previous version using poll().  Of course,
I haven't compared loads under the same server version with two different
engines--it's possible other changes we made have resulted in much of that
load difference.

I should probably note that the beta test server I am refering to is running
Solaris; I have not tried to use the Linux /dev/poll patch as of yet...
-- 
Kevin L. Mitchell <klmitch@mit.edu>

