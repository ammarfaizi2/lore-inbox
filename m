Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287874AbSBCWt3>; Sun, 3 Feb 2002 17:49:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287866AbSBCWtK>; Sun, 3 Feb 2002 17:49:10 -0500
Received: from mx2.elte.hu ([157.181.151.9]:50311 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S287860AbSBCWtG>;
	Sun, 3 Feb 2002 17:49:06 -0500
Date: Mon, 4 Feb 2002 01:46:45 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Ed Tomlinson <tomlins@cam.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <20020203154603.BDDDB9251@oscar.casa.dyndns.org>
Message-ID: <Pine.LNX.4.33.0202040137070.19391-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 3 Feb 2002, Ed Tomlinson wrote:

> > these changes do two things: they decrease the timeslice of nice +19 tasks
> > (pretty dramatically, relative to current kernels), and they make sure
> > that heavily reniced tasks cannot reach interactive status easily.
> >
> > do you still see higher priority CPU-bound task starving?
>
> The other half of this is does the java application remain responsive?
> Remember it is interactive it that parts of it feed a local browser.

yes. Priority boost/penalty works for reniced tasks just as well.

with the -K2 scheduler (i will release the patch soon) it will be
progressively harder for reniced tasks to gain 'heavily interactive'
status (ie. to be reinserted into the active array). For nice +19 tasks it
will be impossible to get this status. (for nice +15 tasks it's still
possible.)

> If system tasks are a problem its easy to exclude them.  I did not do
> this since monitoring who was triggering this code did not show system
> tasks.

the fact that we might need to 'exclude' certain tasks from a mechanism
shows that the mechanism is not robust.

> What happens when the java threads really _are_ interactive?  In my
> case the test application is a freenet node.  Part of it is acting as
> a http proxy.  Starving this results in an unresponsive system.  Why
> should I have to renice at all?

you have to renice if you want to give non-java tasks a higher share of
the CPU time. Java threads will still be interactive relative to each
other.

> > i think your workload shows a weakness in the current handling of reniced
> > workloads, which can be fixed without adding any new mechanism.
>
> Are you sure we really want renice to be needed get good response for
> common workloads? [...]

'response' in terms of interactive latencies should be good, yes.

'response' in terms of relative CPU time given to CPU hogs and interactive
tasks wont be as 'good' as with the old scheduler. (ie. CPU hogs *will* be
punished harder - this is what is needed for good interactivity after
all.) So if you see that some of your interactive tasks are not as
important as you'd like them to be, then renicing them somewhat will give
more CPU time even to CPU hogs. The kernel wont be able to figure out what
is important to you though - the default right now is that interactive
tasks are more important. If the opposite is desired then the kernel needs
external help - ie. nice values.

	Ingo

