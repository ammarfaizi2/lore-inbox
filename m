Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbTEARah (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 13:30:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTEARah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 13:30:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:52636 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261651AbTEARad convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 13:30:33 -0400
Content-Type: text/plain;
  charset="utf-8"
From: Hubertus Franke <frankeh@watson.ibm.com>
Reply-To: frankeh@watson.ibm.com
Organization: IBM Research
To: Robert Love <rml@tech9.net>, Rick Lindsley <ricklind@us.ibm.com>
Subject: Re: must-fix list for 2.6.0
Date: Thu, 1 May 2003 12:50:20 -0400
User-Agent: KMail/1.4.3
Cc: Andrew Morton <akpm@digeo.com>, Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       linux-kernel@vger.kernel.org, frankeh@us.ibm.com
References: <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com> <1051746092.17629.25.camel@localhost>
In-Reply-To: <1051746092.17629.25.camel@localhost>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305011250.20322.frankeh@watson.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In good/bad I simply tried to identify what behavior will be observed. 
Let's put OpenOffice to rest as sooner or later folks will get to use the 
corrected version. 

What is the semantics of yield?    (again) 
Two things need to be considered. 
(a) continuation of execution 
(b) length of time slice at continuation 

In the OLD version (a) would be run after all other tasks and (b) default 
timeslice reset. 
In the new version (a) would be on the same level and (b) would be no 
changes to the current timeslice 

To me both seems wrong. If you do the OLD version, one clearly limits the 
forward progress of the task, namely by revoking its current timeslice and 
deferring continuation for some time. 
The new version does exactly the opposite. Defer execution for a short 
time, but don't revoke any timeslice.

So it boils down to the common use of sched_yield(). 
(i) create some interactivity and allow all others to run based on some 
app knowledge. 
(ii) yielding based on locking and the potential lock hold time. 

If (i) then the old version seems better. 
If (ii) then it depends on the lock hold time and arrival rate and the 
optimism that one wants to assume. 


The conservative method is to move to expired, however the lock might have 
been reacquired. 
The aggressive method is to move the task one slot down in the active 
queue.  The NEW method is somewhat in between but on the aggressive side

Dropping the effective priority seems a reasonable medium ground, because 
moving to the expired list is simply a bit worse then dropping the effective 
priority to the lowest level. So why not drop the 
effective priority based on sched_yield invocation frequency or recency. 
This is a gradual step towards the "harsh" solution to move to the expired, 
but at the same time avoids potential cpu hogging. 
I am afraid there are simply contradictory situations and it will be 
difficult to serve both perfectly. 

Hubertus Franke,   IBM Research
email: frankeh@us.ibm.com



On Wednesday 30 April 2003 19:41, Robert Love wrote:
> On Wed, 2003-04-30 at 19:11, Rick Lindsley wrote:
> >    OLD: when sched_yield() is called the task moves to expired,
> > 	every other task in the active queue will run first before the
> > 	yielding task will run again.
>
> I really think this is the right way.
>
> >    NEW: move the yielding task to the end of its current priority level,
> > 	but keeps it active not expired.
>
> This takes us back to the problem we saw in earlier sched_yield()
> implementations.  A group of yielding threads just round-robin between
> themselves, yielding over and over.  Worse, even a single task alone in
> a priorty level will show up as a CPU hog if it keeps calling
> sched_yield() in a loop.
>
> It goes on.  Assume we have two runnable tasks, one that does whatever
> it wants (hopefully something useful), and the other which does:
>
> 	while(1)
> 		sched_yield();
>
> With the current sched_yield(), the second will receive much less
> processor time than the first (nearly none vs. most of the processor).
> With the sched_yield() mentioned above, they will receive identical
> amounts of processor time.  That does not seem sane to me.
>
> I think it is important that sched_yield() give processor time to all
> tasks, and not just between multiple yielding tasks.
>
> The current implementation does this.  If an application (*cough* Open
> Office *cough*) calls sched_yield() over and over, what does it expect?
>
> Now that we have futexes, sched_yield() no longer needs to be used as a
> poor replacement for blocking, and it can have sane semantics, such as
> _really_ yielding the processor.
>
> > 	What else could be done?
> > 	(a) drop the effective priority of the yielding task by a percentile,
> > 	    but don't reduce the time slice!
>
> This works, too.  We used to do this..
>
> There are a couple bits that need to be added, though, to deal with
> threads that call sched_yield() over and over (which are the ones where
> we have problems).  We need to drop the task a priority level every time
> it calls sched_yield().  Eventually it will reach the lowest priority
> (or some earlier threshold we want to check for) and then we need to put
> it on the expired list, like the current behavior.
>
> So for the big offenders, I think this ends up being the same, no?
>
> Also, this approach does not work for real-time tasks, for whom we must
> not change their priority... so we end up just requeing them, too.
>
> Just my thoughts...
>
> 	Robert Love
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

