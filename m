Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315278AbSIDURZ>; Wed, 4 Sep 2002 16:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSIDURY>; Wed, 4 Sep 2002 16:17:24 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:38663 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315278AbSIDURB>; Wed, 4 Sep 2002 16:17:01 -0400
Date: Wed, 4 Sep 2002 16:14:45 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Problem with the O(1) scheduler in 2.4.19
In-Reply-To: <Pine.LNX.4.44.0209031852180.30462-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.96.1020904155906.13195B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Ingo Molnar wrote:

> 
> On Tue, 3 Sep 2002, John Alvord wrote:
> 
> > It seems to me that this condition could arise for any server process
> > which is used by many interactive processes. Imagine 300 users and a
> > server process which needs 70% to do the work. This could be a database
> > server as well as the current game server.

As I see it, there are two possibilities here, that the game server is
being run on a dedicated server hardware, or at least with the blessing of
the root user. In that case root can adjust nice appropriately. The other
possibility is that root is counting on the scheduler to protect the other
processes in the system from being starved. In that case it's working
nicely.

> the 2.5 scheduler adds another thing to the mix: if a task behaves in an
> 'interactive' way then it will get more CPU time than what it got in 2.4 -
> if it behaves like a 'CPU hog' then it will get less CPU time than what it
> used to get in 2.4.

Yes, and it works really well! Job mixes which used to result in poor
response now work just fine, nice actually does something, and behaviour
of processes which are intended to get resources can be given negative
nice (nasty?) to make them run well.
 
> the penalty is at most +-5 priority levels, so you can always offset (much
> of) this effect by moving the task 10 priority levels lower. (Hence the
> magic '-10' priority level i keep suggesting, and hence the magic -5
> priority levels i'd like to allow ordinary tasks to lower their priority.)

Seems to defeat all the wonderful work which went into this. On any shared
system there will be people who know how to trick the scheduler into
running their jobs faster. Used to do that myself when machine were really
slow ;-) Actually if I understand the way the scheduler works, and I think
I do at the high level, if this server was a well-behaved threaded app
individual threads would show as interactive, they could have various
priority depending on the behaviour of the threads, and things would run
pretty well. If that server is doing a huge select or poll of 300 users I
bet all the CPU is in the system call anyway.
 
> [the scheduler also has other code to ensure fairness in highly loaded
> situations, it makes sure that no task waits CPU-less for more than 3
> seconds due to the interactiveness bonuses. This effect does not play in
> this current situation, it needs a couple of tens of currently running
> agressive tasks to trigger on most normal boxes.]
> 
> those tasks that need a disproportionate amount of CPU time need to be
> reniced, so that the penalty for being an 'unfair' CPU user is offset.  
> There is no way the scheduler could figure out how important a task is -
> some people have a game server have higher priority, other people would
> give httpd (or remote shells) a higher priority. Since this information is
> only available in the administrator's head, it needs help from the
> administrator to handle the situation. The kernel has a good default, but
> it cannot work in every case, this is why we have the ability to renice
> tasks.

And I suspect that if users can push their own jobs, they will. I really
don't think the scheduler is doing the wrong thing, and there is a well
defined way to make the process have higher priority.

This isn't a kernel issue, it's an administration issue.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

