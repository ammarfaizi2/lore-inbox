Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314459AbSILI6i>; Thu, 12 Sep 2002 04:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314514AbSILI6i>; Thu, 12 Sep 2002 04:58:38 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:11409 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S314459AbSILI6g>; Thu, 12 Sep 2002 04:58:36 -0400
Date: Thu, 12 Sep 2002 11:03:19 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209121005430.5452-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209121008160.26031-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Sep 2002, Ingo Molnar wrote:

> On Wed, 11 Sep 2002, Tobias Ringstrom wrote:
> 
> > In other words:  Any nice-0 task that has been sleeping for two seconds
> > or more will be able to monololize the CPU for up to 0.7 seconds.  Do
> > you agree that this is a problem, or am I being too narrow-minded?  :-)
> 
> well, 'monopolize' the CPU from CPU-hogs - yes. Take the CPU from other
> interactive tasks: no.

(Thanks Ingo for your quick answers!)

I don't mind that interactive processes can take the CPU from CPU hogs,
but I do think that there is room for classification improvements.

A few observations (with suggested solutions):

1. The nice levels are not symmetric.  Compared to a nice 0 process, a
   nice 19 process will get 6% CPU, but compared to a nice -20 process, a
   nice 0 process will get 33 % CPU.  This can be solved by scaling the
   conversion from nice level to priority in a different way.  The
   drawback of this is shorter time slices for nice 0 processes.

2. Nice -20 is really impotent.  In addition to the point above, the
   interactive classification stuff is what makes it really impotent.
   That a nice -20 process loses 0.7 seconds to a nice 0 task says it all.  
   How about making -20 processes interactive unconditionally?

3. More than 90% of all tasks in a system are classified as interactive at
   any given time (since they are sleeping).  For example all cron jobs
   are classified as interactive, which sounds really strange.  IMHO, it's
   a good example of a non-interactive background job.  (I'll run my crond
   at nice 19 for now.)

   I'm curious, why are you using the process average sleep time to
   determine interactiveness and not the presense of prematurely abandoned
   timeslices?

4. Using SCHED_RR is one way out, but I suspect that the busy-loop
   nanosleep implementation for "realtime" processes will lock up the
   machine in my case.  I suggest that the 2 ms limit is removed.  It can
   be done in userspace as a gettimeofday loop for applications which
   care.

I'll continue thinking about this to see if I can come up with something
constructive, but it would be extremely valuable to get your view since
you are the expert and you have been working on this for a long time.

/Tobias

