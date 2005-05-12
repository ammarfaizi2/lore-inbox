Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVELSKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVELSKM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 14:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262094AbVELSKK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 14:10:10 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:6853 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S262093AbVELSJl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 14:09:41 -0400
In-Reply-To: <20050512171251.GA21656@in.ibm.com>
Subject: Re: [RFC] (How to) Let idle CPUs sleep
To: vatsa@in.ibm.com
Cc: george@mvista.com, jdike@addtoit.com,
       Jesse Barnes <jesse.barnes@intel.com>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Lee Revell <rlrevell@joe-job.com>, Tony Lindgren <tony@atomide.com>
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF86BA5D99.FE159896-ONC1256FFF.0062E865-C1256FFF.0063A681@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Thu, 12 May 2005 20:08:26 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 12/05/2005 20:09:36
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Seems like we could schedule timer interrupts based solely on add_timer

> > type stuff; the scheduler could use it if necessary for load balancing
> > (along with fork/exec based balancing perhaps) on large machines where
> > load imbalances hurt throughput a lot.  But on small systems if all
>
> Even if we were to go for this tickless design, the fundamental question
> remains: who wakes up the (sleeping) idle CPU upon a imbalance? Does some
other
> (busy) CPU wake it up (which makes the implementation complex) or the
idle CPU
> checks imbalance itself at periodic intervals (which restricts the amount
of
> time a idle CPU may sleep).

I would prefer a solution where the busy CPU wakes up an idle CPU if the
imbalance is too large. Any scheme that requires an idle CPU to poll at
some intervals will have one of two problem: either the poll intervall
is large then the imbalance will stay around for a long time, or the
poll intervall is small then this will behave badly in a heavily
virtualized environment with many images.

> > your processes were blocked, you'd just go to sleep indefinitely and
> > save a bit of power and avoid unnecessary overhead.
> >
> > I haven't looked at the lastest tickless patches, so I'm not sure if my
> > claims of simplicity are overblown, but especially as multiprocessor
> > systems become more and more common it just seems wasteful to wakeup
> > all the CPUs every so often only to have them find that they have
> > nothing to do.
>
> I guess George's experience in implementing tickless systems is that
> it is more of an overhead for a general purpose OS like Linux. George?

The original implementation of a tickless system introduced an overhead
in the system call path. The recent solution is tickless while in idle
that does not have that overhead any longer. The second source of
overhead is the need to reprogram the timer interrupt source. That
can be expensive (see i386) or cheap (see s390). So it depends, as usual.
In our experience on s390 tickless systems is a huge win.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH


