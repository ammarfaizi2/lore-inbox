Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132589AbRC2Jms>; Thu, 29 Mar 2001 04:42:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132662AbRC2Jmi>; Thu, 29 Mar 2001 04:42:38 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:24564 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S132589AbRC2Jmb>; Thu, 29 Mar 2001 04:42:31 -0500
Date: Thu, 29 Mar 2001 15:13:30 +0530
From: Dipankar Sarma <dipankar@sequent.com>
To: george anzinger <george@mvista.com>
Cc: Dipankar Sarma <dipankar@sequent.com>, nigel@nrg.org,
   linux-kernel@vger.kernel.org, mckenney@sequent.com
Subject: Re: [PATCH for 2.5] preemptible kernel
Message-ID: <20010329151330.A7361@in.ibm.com>
Reply-To: dipankar@sequent.com
In-Reply-To: <16074.985137800@kao2.melbourne.sgi.com> <Pine.LNX.4.05.10103201920410.26853-100000@cosmic.nrg.org> <3AC1BAD3.BBBD97E1@sequent.com> <3AC24EB6.1F0DD551@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3AC24EB6.1F0DD551@mvista.com>; from george@mvista.com on Wed, Mar 28, 2001 at 12:51:02PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 28, 2001 at 12:51:02PM -0800, george anzinger wrote:
> Dipankar Sarma wrote:
> > 
> > Also, a task could be preempted and then rescheduled on the same cpu
> > making
> > the depth counter 0 (right ?), but it could still be holding references
> > to data
> > structures to be updated using synchronize_kernel(). There seems to be
> > two
> > approaches to tackle preemption -
> > 
> > 1. Disable pre-emption during the time when references to data
> > structures
> > updated using such Two-phase updates are held.
> 
> Doesn't this fly in the face of the whole Two-phase system?  It seems to
> me that the point was to not require any locks.  Preemption disable IS a
> lock.  Not as strong as some, but a lock none the less.

The point is to avoid acquring costly locks, so it is a question of 
relative cost. Disabling preemption (by an atomic increment) for 
short critical sections may not be as bad as spin-waiting for 
highly contended locks or thrashing lock cachelines.


> > 
> > Pros: easy to implement using a flag (ctx_sw_off() ?)
> > Cons: not so easy to use since critical sections need to be clearly
> > identified and interfaces defined. also affects preemptive behavior.
> > 
> > 2. In synchronize_kernel(), distinguish between "natural" and preemptive
> > schedules() and ignore preemptive ones.
> > 
> > Pros: easy to use
> > Cons: Not so easy to implement. Also a low priority task that keeps
> > getting
> > preempted often can affect update side performance significantly.
> 
> Actually is is fairly easy to distinguish the two (see TASK_PREEMPTED in
> state).  Don't you also have to have some sort of task flag that
> indicates that the task is one that needs to sync?  Something that gets
> set when it enters the area of interest and cleared when it hits the
> sync point?  

None of the two two-phase update implementations (synchronize_kernel())
by Rusty and read-copy update by us, monitor the tasks that require
sync for update. synchronize_kernel() forces a schedule on every
cpu and read-copy update waits until every cpu goes through
a quiscent state, before updating. Both approaches will require
significant special handling because they implicitly assume 
that tasks inside the kernel are bound to the current cpu until it
reaches a quiescent state (like a "normal"
context switch). Since preempted tasks can run later on any cpu, we
will have to keep track of sync points on a per-task basis and
that will probably require using a snapshot of the running
tasks from the global runqueue. That may not be a good thing
from performance standpoint, not to mention the complexity.

Also, in situations where read-to-write ratio is not heavily
skewed towards read or lots of updates happening, a very low
priority task can have a significant impact on performance
by getting preempted all the time.

Thanks
Dipankar
-- 
Dipankar Sarma  (dipankar@sequent.com)
IBM Linux Technology Center
IBM Software Lab, Bangalore, India.
Project Page: http://lse.sourceforge.net
