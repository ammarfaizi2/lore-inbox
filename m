Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281734AbRKQIJF>; Sat, 17 Nov 2001 03:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281725AbRKQIIz>; Sat, 17 Nov 2001 03:08:55 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:38135 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S281733AbRKQIIj>; Sat, 17 Nov 2001 03:08:39 -0500
Message-ID: <3BF61AEB.2C186512@mvista.com>
Date: Sat, 17 Nov 2001 00:08:11 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mike Kravetz <kravetz@us.ibm.com>
CC: Davide Libenzi <davidel@xmailserver.org>, lse-tech@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: Real Time Runqueue
In-Reply-To: <20011116154701.G1152@w-mikek2.des.beaverton.ibm.com> <Pine.LNX.4.40.0111161620050.998-100000@blue1.dev.mcafeelabs.com> <20011116163224.H1152@w-mikek2.des.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz wrote:
> 
> On Fri, Nov 16, 2001 at 04:28:33PM -0800, Davide Libenzi wrote:
> > On Fri, 16 Nov 2001, Mike Kravetz wrote:
> >
> > > Suppose you have a 2 CPU system with 4 runnable tasks.  3 of these
> > > tasks are realtime with the same realtime priority and the other is
> > > an ordinary SCHED_OTHER task.  The task distribution on the runqueues
> > > looks something like this.
> > >
> > > CPU 0             CPU 1
> > > ---------         ---------
> > > RT Task A         RT Task B
> > > Other Task C      RT Task D
> > >
> > > Task A and Task B are currently running on the 2 CPUs.  Now, Task A
> > > voluntarily gives up CPU 0 and Task B is still running on CPU 1.
> > > At this point, Task D should be chosen to run on CPU 0.  Correct?
> > > Isn't this a required RT semantic?  I'm curious how you plan on
> > > accomplishing this.
> >
> > Well I don't know how RT sematics apply to SMP systems.
> 
> Me either (not exactly).
> 
> > The easy solution ( == big common lock ) would be to have a single RT
> > queue that is checked before the private one.
> > Anyway, sometime it happens that the cure is worst than the disease and to
> > solve a corner case you're going to punish common case performances (
> > Linux is not an RT OS even with that fix ).
> 
> The reason I ask is that we went through the pains of a separate
> realtime RQ in our MQ scheduler.  And yes, it does hurt the common
> case, not to mention the extra/complex code paths.  I was hoping
> that someone in the know could enlighten us as to how RT semantics
> apply to SMP systems.  If the semantics I suggest above are required,
> then it implies support must be added to any possible future
> scheduler implementations.
> 
For what its worth here is my $.02 worth.  A strict following of the
standard seems to me to mean that in a N cpu system with M>N ready real
time tasks, the N highest priority tasks should be allocated CPUs. 
Remember that, for real time tasks, it is MORE important to run the
highest priority tasks than to worry about thru put or performance
(beyond getting to the highest priority task(s) ASAP).  I assume that
this is what a user is saying when he declares a task "real time". 

That said, the pragmatic view is that the customer is always right. 
After all, he paid for the machine.  We have customers who want
decidedly non "S" SMP.  There are some who want all real time tasks to
run on one cpu and all other tasks to run on another.  There are also
some who want a group of tasks (real time and otherwise) to always run
on a particular cpu while other tasks (again real time and otherwise)
run on other cpus.

What I plan to do is to have a non-affined real-time ready list and an
affined list.  I really think all the lists should be priority ordered
with one per priority so when I say a non-affined ready list I mean one
for each priority (see the rtsched on source forge, for example of a
list per priority (URL in my signature)).  I am not yet sure if the
affined list should have the option of being shared with more than one
cpu, but as you note, there are performance problems with multiple lists
so I only plan to have the cpu check at most two lists, the non-affined,
and one affined list.  With this scheme it is possible to have a case
where a ready real time task will not get an idle cpu, however, this
should only happen if the task has affined it self to some other
cpu(s).  By using priority order lists or a list per priority the
overhead and lock contention can, IMHO, be managed.

A couple of addition points.  There should be an API to declare cpu
affinity, and cpu affinity should be passed thru fork and exec.  You may
need to be god (root) to use the API however.  (I think cpu affinity is
currently passed thru fork and exec, by the way.)
-- 
George           george@mvista.com
High-res-timers: http://sourceforge.net/projects/high-res-timers/
Real time sched: http://sourceforge.net/projects/rtsched/
