Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSICMT3>; Tue, 3 Sep 2002 08:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSICMT3>; Tue, 3 Sep 2002 08:19:29 -0400
Received: from h181n1fls11o1004.telia.com ([195.67.254.181]:37763 "EHLO
	ringstrom.mine.nu") by vger.kernel.org with ESMTP
	id <S318767AbSICMTY>; Tue, 3 Sep 2002 08:19:24 -0400
Date: Tue, 3 Sep 2002 14:23:49 +0200 (CEST)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: tori@boris.prodako.se
To: Ingo Molnar <mingo@elte.hu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209031220230.25506-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0209031322210.7658-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Ingo Molnar wrote:

> do you expect a task that uses up 50% CPU time over an extended period of
> time to be rated 'interactive'?

Interactive is not the best word, but I would not expect a process like
the one I described to be considedred a CPU hog.  It's a deadline driven
semi realtime process.

> we might make the '50%' rule to be '100% / nr_running_avg', so that if
> your task is the only one in the system then it gets rated interactive -
> but i suspect it will still be rated a CPU hog if it keeps trying to use
> up 50% of CPU time even during busier periods. I have tried the
> (1/nr_running) rule in earlier incarnations of the scheduler, and it didnt
> make much difference, but we obviously need a boundary case like yours to
> see the differences.

I think the problem I have (that I loose a lot of performance to processes
such as crond, httpd, etc.) is common to the whole class of semi-realtime
processes, at least if they use >50% CPU.  This means that CPU intensive
audio and video (e.g. DVD) playback programs might have the same problem.

I see three simple ways to solve the problem without changing the
scheduler.  Either run the process with nice -20, use SCHED_RR, or use a
dedicated server with no other processes (such as crond, httpd, etc).  
The first two might be OK, but you need root privilegies to run renice and
to change the scheduler policy.  The third one is not an option for all
users, and definately not for the video playback case.

A problem is that this new scheduler behaviour will hit people running
semi realtime processes as a regression when they switch to 2.6.  It would
be nice to avoid that.

One solution might be to teach the scheduler how to detect these deadline
driven semi-realtime processes, and not punish them.  It is not obvious to
me how to do that.

Another much simpler solution that might work just as well is be to change
the CPU utilization threshold from 50% to 90%.

You're the expert of course.  I'm only fumbling in the dark...  :-)

> (it could in theory make a difference in some rare cases, in which the
> frequency of sampling resonates with internal timings of the application -
> i asked for this only to make sure there are no interactions.)

I'll try it out and let you know if it does make a difference.

/Tobias

