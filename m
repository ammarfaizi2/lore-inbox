Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbTDDVRN (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 16:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbTDDVRN (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 16:17:13 -0500
Received: from 217-125-129-224.uc.nombres.ttd.es ([217.125.129.224]:23275 "HELO
	cocodriloo.com") by vger.kernel.org with SMTP id S261329AbTDDVRJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 16:17:09 -0500
Date: Fri, 4 Apr 2003 23:36:46 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Hubertus Franke <frankeh@watson.ibm.com>
Cc: Antonio Vargas <wind@cocodriloo.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>,
       frankeh@optonline.net, nagar.us.ibm.com@elinux01.watson.ibm.com
Subject: Re: fairsched + O(1) process scheduler
Message-ID: <20030404213646.GD15864@wind.cocodriloo.com>
References: <20030401125159.GA8005@wind.cocodriloo.com> <20030403192241.GB1828@holomorphy.com> <20030404112704.GA15864@wind.cocodriloo.com> <200304041453.16630.frankeh@watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304041453.16630.frankeh@watson.ibm.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 02:53:16PM -0500, Hubertus Franke wrote:
> On Friday 04 April 2003 06:27, Antonio Vargas wrote:
> > On Thu, Apr 03, 2003 at 11:22:41AM -0800, William Lee Irwin III wrote:
> > > On Thu, Apr 03, 2003 at 02:53:55PM +0200, Antonio Vargas wrote:
> > > > Sorry for not answering sooner, but I had my mail pointing at
> > > > the lkml instead of my personal email.
> > > > Last night I continued coding up but I think I've it a deadlock:
> > > > it seems the system stops calling schedule_tick() when there are
> > > > no more tasks to run, and it's there where I use a workqueue so
> > > > that I can update the user timeslices out of interrupt context.
> > > > I think that because if I put printk's on my code, it continues to
> > > > run OK, but if I remove them it freezes hard.
> > >
> > > Use spin_lock_irq(&uidhash_lock) or you will deadlock if you hold it
> > > while you take a timer tick, but it's wrong anyway. it's O(N) with
> > > respect to number of users present. An O(1) algorithm could easily
> > > make use of reference counts held by tasks.
> > >
> > > On Thu, Apr 03, 2003 at 02:53:55PM +0200, Antonio Vargas wrote:
> > > > About giving ticks to users, I've got an idea: assuming there are N
> > > > total processes in the system and an user has got M processes, we
> > > > should give N * max_timeslice ticks to each user every M *
> > > > max_timeslice * num_users ticks. I've been thinking about it and it
> > > > seems it would balance the ticks correctly.
> > > > About the starvation for low-priority processes, I can get and
> > > > example.. assume user A has process X Y and user B has process Z,
> > > > and max_timeslice = 2:
> > > > max_timeslice = 2 and 4 total processes ==>
> > > > give 2 * 3 = 6 ticks to user A every 2 * 2 * 2 =  8 ticks
> > > > give 2 * 3 = 6 ticks to user B every 1 * 2 * 2 =  4 ticks
> > >
> > > This isn't right, when expiration happens needs to be tracked by both
> > > user and task. Basically which tasks are penalized when the user
> > > expiration happens? The prediction is the same set of tasks will always
> > > be the target of the penalty.
> >
> > Just out of experimenting, I've coded something that looks reasonable
> > and would not experience starvation.
> >
> > In the normal scheduler, a non-interactive task will, when used all his
> > timeslice, reset p->time_slice and queue onto the expired array. I'm
> > now reseting p->reserved_time_slice instead and queuing the task
> > onto a per-user pending task queue.
> >
> > A separate kernel thread walks the user list, calculates the user timeslice
> > and distributes it to it's pending tasks. When a task receives timeslices,
> > it's moved from the per-user pending queue to the expired array of the
> > runqueue, thus preparing it to run on the next array-switch.
> >
> > If the user has many timeslices, he can give timeslices to many tasks, thus
> > getting more work done.
> >
> > While the implementation may not be good enough, due to locking problems
> > and the use of a kernel-thread, I think the fundamental algorithm feels
> > right.
> >
> > William, should I take the lock on the uidhash_list when adding a task
> > to a per-user task list?
> >
> > Greets, Antonio.
> 
> Antonio, I am going right now through some stuff.
> Again I am coming from a class based approach, but fundamentally now 
> difference.
> 
> First there are several issues that need to be addressed and they might have 
> to be handled differently. 
> Shares can be observed under hard limits or soft limits (work preserving).
> The first proposal you put forward was clearly work preserving. The latter one
> (if I understood correctly reading it in 2 seconds) would facilitate hard 
> working limits. The problem to simply do it at array switch time is that
> you could spent increased time in schedule() simply moving tasks between
> active and expired until ticks are regranted to the user.

The testing on pick_next_task is just a failsafe, it should not be done
on the real working patch.

> I have two concerns (and pardon me again if you already addressed them)
> 
> (A) starvation problem. 
> ---------------------------------
> One process could eat all the ticks
> assigned to a user, leading that subsequent scheduled task will always move
> to the expired list.

Yes.

> Effectively, the sum(timeslices) per user is the number of ticks I need to 
> give (given all cpu bound) for a user to get all tasks execute. 

Yes.

> The ratio between the sums of the different users is effectively what is 
> dictated by the shares. 
> One has effectively two means to manipulate that 
> (a) modifying the static_priority of tasks belonging to a user
> (b) modifying the effective_priority of tasks belonging to a user
> (c) modifying the time_slice of tasks
> 
> all modifications are based on whether a user is overspending or underspending 
> at some given rate.
> To me (a) is not an option.
> (b) tells me to modify the urgency of a task to be scheduled
> (c) tells me how long task should run, its also depends on (a).
> 
> What needs to be achieved is that starving tasks move up in the 
> effective_priority above the ones that keep eating allotted ticks.

I've it done correctly in the fairsched-A3 patch I sent. When a task
uses up the timeslice, it goes to the end of a pending list. When the user
receives slices, he gives it to the head of the pending list,
quits it from the pending list and attaches to the expired array just like
if it has gone on the non-fairsched path. So, the tasks just take a sleep
while they wait their relaive per-user turn.

> (B)    O(1) issues
> -------------------------
> 
> By setting tasks aside to wait for replenishment of ticks for the users you 
> might introduce an non O(1) effect, that Ingo might object against.
> One could argue, that you simply put the tasks asleep..

Yes, it's exactly that. Instead of passing a task
from active to expired directly, they
take a detour until the user can "afford" to do it.

When handling more users, there is a natural inflation because
each user can receives less slices per time unit.

----------------------------------  
> 
> I am currently doing the math and coming up with a scheme. I should be 
> hopefully close to something by Monday, which I can then share and if 
> you want you can experiment around with. Need to do this anyway for 
> the OLS paper we are presenting.
> Also, I need to go through your latest patch in more detail, before I give you 
> injustice, I just want to have the framework in my head first.
> 
> Ping me on Monday...
> 
> -- Hubertus

Getting your linux-kernel subscription running would be great,
I almost skipped your mail again because of it ;)

I'll try to code on this during the weekend, so see you on Monday.

Greets, Antonio.
