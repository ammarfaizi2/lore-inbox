Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264696AbSJUCb7>; Sun, 20 Oct 2002 22:31:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264697AbSJUCb6>; Sun, 20 Oct 2002 22:31:58 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:32964 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S264696AbSJUCbz>; Sun, 20 Oct 2002 22:31:55 -0400
Message-ID: <3DB36877.9EFF8AA4@attbi.com>
Date: Sun, 20 Oct 2002 22:37:43 -0400
From: Jim Houston <jim.houston@attbi.com>
Reply-To: jim.houston@attbi.com
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
CC: linux-kernel@vger.kernel.org, mingo@elte.hu, andrea@suse.de,
       jim.houston@ccur.com
Subject: Re: [PATCH] Re: Pathological case identified from contest
References: <Pine.LNX.4.44L.0210201214010.22993-100000@imladris.surriel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sat, 19 Oct 2002, Jim Houston wrote:
> > +     if (HZ > 100)
> > +             return(((p)->prio - MAX_RT_PRIO)*4 + 1);
> > +     else
> > +             return(((p)->prio - MAX_RT_PRIO)/2 + 1);
> >  }
> 
> It'd be fun if this code also worked for values of HZ not
> equal to 100 or 1000.  Better put HZ somewhere in this
> calculation and make it HZ-independant.

Yes I will clean this up.  

> > + * The rq->prio_ind is used to raise/rotate the priority of all of the
> > + * processes in the run queue.  I know this  sounds like a pyramid scheme.
> > + * This increase in priority is balanced by two feedback mechanisms.
> > + * First processes which consume there timeslice are moved to a lower
> > + * priority queue.  To continue the pyramid analogy we make the time
> > + * slice smaller for more favorable priorities.
> 
> Sounds like a good strategy, at least in theory.  I suspect
> it'll balance itself well enough to also work in practice.
> 
> > + * The rotate_rate is the rate at which the priorities of processes
> > + * in the run queue increase.  With the initial HZ/10 guess a process
> > + * will go from the worst dynamic priority to the best in 4 seconds.
> 
> How long does it take for a best priority process to go
> down ?

I don't know yet.  My next step will be to instrument this.
There are a many things that I can be tuned here, but I
want the system to tune itself.  For example, I might measure the 
interval at which the lowest priority process gets to run and use
this to adjust the rotate_rate.   

> 
> Or, for how much time can a newly started CPU hog starve
> an older process ?   This is important to know since eg.
> a newly started Mozilla could starve an already running
> movie player.

The patch starts new processes with a neutral priority
of 120.  If it is a cpu hog, it will get one time slice at 
each priority until it reaches the priority where the existing
group of cpu hogs are executing.  At this point it will 
round robin with this group.

The scheduler has no way to know which processes are interactive.  In
your example the user might be waiting for the Mozilla to start
and not care if the movie player skips.

Jim Houston - Concurrent Computer Corp.
