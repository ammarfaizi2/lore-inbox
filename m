Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266673AbUF3NmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266673AbUF3NmO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUF3NmO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:42:14 -0400
Received: from out003pub.verizon.net ([206.46.170.103]:44233 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S266675AbUF3Nlx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:41:53 -0400
Date: Wed, 30 Jun 2004 09:41:46 -0400
Message-Id: <200406301341.i5UDfkKX010518@localhost.localdomain>
From: Paul Davis <paul@linuxaudiosystems.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.X, NPTL, SCHED_FIFO and JACK
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [141.152.253.159] at Wed, 30 Jun 2004 08:41:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JACK is the de-facto standard for low latency audio and
inter-application audio routing on Linux (its also widely appreciated
on OS X too). It makes heavy use of threads to provide the
functionality relied on by more than 2 dozen serious Linux audio
applications. For many users, its a requirement to use SCHED_FIFO and
mlockall() with audio applications, because of the realtime, low
latency nature of their configurations/goals.

Because of the recognition by kernel developers that 2.6 does not
perform as well as 2.4+lowlat (the Andrew Morton patches) when it
comes to scheduling latency, most audio developers and users have
remained with 2.4. Recently however, several brave souls have
attempted to test 2.6. The results have been mixed.

On the one hand, it does seem possible to get performance from an
unpatched 2.6 kernel that is pretty close to the 2.4+lowlat
numbers. Using the CKolivas patches for 2.6 only improves things
further. 

However, the ONLY way to get even vaguely reasonable performance in
this area is to disable the use of NPTL using LD_ASSUME_KERNEL. With
NPTL in use, there are a series of apparently interlocking problems
with scheduler parameter inheritance, scheduler performance and
decision making. Its more or less impossible to run JACK-enabled audio
systems on 2.6 with NPTL. A series of ugly kludges are beginning to
emerge within the Linux audio community, and I think its time we cut
them off before things get out of hand.

The JACK group is entirely open to the idea that we have made an error
in our use of the pthreads API, and that NPTL is simply exposing our
mistake. We can't see the error, however, and so for the moment, we
are working on the assumption that there are genuine kernel+glibc
errors. 

The first and most visible issue is with inheritance of SCHED_FIFO
scheduling. Although there are other mechanisms available under 2.6,
many people use the "jackstart" helper application which runs setuid
root and uses capabilities to start up JACK with the required caps to
allow use of SCHED_FIFO and mlockall(). This has worked very well in
2.4 for about 2 years, but in 2.6 JACK fails to get its threads to be
in the SCHED_FIFO scheduling class without a bunch of nasty kludges.

Things work correctly as soon as LD_ASSUME_KERNEL is used. 

We also see apparently impossible thread scheduling, where a thread
that should run immediately is delayed by a significant time, and the
thread that woke the first one up (and should be waiting for it to
execute) runs again, apparently without ever having blocked. Once
more, it all works correctly is LD_ASSUME_KERNEL is used to avoid
NPTL.

Are there known issues with the implementation of NPTL that might give
rise to this behaviour? What can we do to help understand and debug
it?

thanks,

Paul Davis <paul@linuxaudiosystems.com>                 Bala Cynwyd, PA, USA
Linux Audio Systems                                             610-667-4807
----------------------------------------------------------------------------
hybrid rather than pure; compromising rather than clean;
distorted rather than straightforward; ambiguous rather than
articulated; both-and rather than either-or; the difficult
unity of inclusion rather than the easy unity of exclusion.   Robert Venturi
----------------------------------------------------------------------------

