Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265593AbTFRWnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265597AbTFRWnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:43:46 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:15735 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S265593AbTFRWlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:41:47 -0400
Date: Wed, 18 Jun 2003 15:56:37 -0700
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: joe.korty@ccur.com, linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: O(1) scheduler seems to lock up on sched_FIFO and sched_RR
 tasks
Message-Id: <20030618155637.60b3e2f9.akpm@digeo.com>
In-Reply-To: <3EF0E7AC.60007@mvista.com>
References: <3EF0979C.8060603@mvista.com>
	<20030618193053.GA15576@tsunami.ccur.com>
	<3EF0E7AC.60007@mvista.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Jun 2003 22:55:45.0225 (UTC) FILETIME=[C05B0390:01C335EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> Joe Korty wrote:
> > On Wed, Jun 18, 2003 at 09:47:24AM -0700, george anzinger wrote:
> > 
> >>It seems that once a SCHED_FIFO or SCHED_RR tasks gets control it does 
> >>not yield to other tasks of higher priority.
> >>
> >>Attached is a test program (busyloop) that just loops doing 
> >>gettimeofday() for the requested time and a little utility (rt) to run 
> >>programs at real time priorities.
> >>
> >>Here is an annotated example of the problem:
> >>
> >>First, become root then:
> >>
> >>>rt 90 bash        <-- run bash at priority 90 SCHED_RR
> >>>rt -f 30 busyloop 10 &  <-- busyloop 10 at priority 30 SCHED_FIFO
> >>
> >>At this point the bash at priority 90 should be available, but is not. 
> >> When the 10 second busyloop completes, bash returns.
> > 
> > 
> > 
> > Hi George,
> >  When I boost the priority of each of the per-cpu 'events/%d' daemon to
> > 96, the problem goes away.
> 
> Seems like your saying that the events workqueues are involved in the 
> scheduler in some ugly way.  Certainly not what your average rt 
> programmer would expect :(  What is going on here?
> 

Various things like character drivers do rely upon keventd services.  So it
is possible that bash is stuck waiting on keyboard input, but there is no
keyboard input because keventd is locked out.

I'll take a closer look at this, see if there is a specific case which can
be fixed.

Arguably, keventd should be running max-prio RT because it is a kernel
service, providing "process context interrupt service".

IIRC, Andrea's kernel runs keventd as SCHED_FIFO.  I've tried to avoid
making this change for ideological reasons ;) Userspace is more important
than the kernel and the kernel has no damn right to be saying "oh my stuff
is so important that it should run before latency-critical user code".

Tricky.
