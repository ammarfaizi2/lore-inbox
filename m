Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261533AbVEJXhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVEJXhd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 19:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEJXhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 19:37:33 -0400
Received: from main.gmane.org ([80.91.229.2]:11235 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261533AbVEJXhP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 19:37:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joe Seigh" <jseigh_02@xemaps.com>
Subject: Re: RCU + SMR for preemptive kernel/user threads.
Date: Tue, 10 May 2005 18:40:20 -0400
Message-ID: <opsqkzxij0ehbc72@grunion>
References: <opsqivh7agehbc72@grunion> <opsqkajto6ehbc72@grunion> <20050510165512.GA1569@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 May 2005 09:55:12 -0700, Paul E. McKenney <paulmck@us.ibm.com>  
wrote:

> Here is what I thought you were suggesting for the updater:
>
> 	Remove item from list
> 	Send IPIs to all CPUs, relying on exact interrupts (which might
> 		not be present on all CPUs) to serialize the instruction
> 		streams of the other CPUs
> 	Wait for all IPIs to complete
> 	Wait until there are no hazard pointers referencing the item
> 		before freeing.

Well, anything that acts as a memory barrier, occurs frequently or
can be made to do so, and can be monitored.  For the inital user
thread implementations I used unix signals (pthread_kill).  Worked
ok on OS X but pretty much tanked on Linux.  So no signals as a
common unix user thread implementation of this.  It would have to be
/proc type information that would let you infer the threads in question
had done something that synchronized memory.  I don't mess around in
the Linux kernel so I can't make any specific suggestions there.
You're the expert there.

>
> For the traverser:
>
> 	1. allocate hazard pointer (SW engr problem: what to do if
> 		allocation fails?  If deeply nested, holding locks, &c?)
> 	2. retry:
> 	3. Pick up pointer, store into hazard pointer.
> 	4. Tell the compiler not to reorder memory references across this point
> 	5. If hazard pointer does not match the pointer, goto retry.
> 	6. begin critical section
>
> If the updater and traverser run concurrently, the interrupt forces
> serialization -- look at all the possible interleavings to see this:
> 1.	Before this point, the traverser cannot see the removed element.
> 2.	Ditto.
> 3.	Ditto.
> 4.	Before this point, the traverser might have stored a pointer to
> 	the remove element into the hazard pointer, but will see the
> 	disappearance when it returns from interrupt.
> 5.	Ditto.
> 6.	At this point, the hazard pointer has been set, and the
> 	interrupt will force memory ordering.

Right, the memory ordering on 6 means the updater is guaranteed to see
the hazard pointer set if it has a valid value.

>
> Similar reasoning when the traverser NULLs the hazard pointer.

Setting the hazard pointer to NULL requires release semantics to ensure
prior accesses to the element complete before the element is deleted.
That's an MFENCE on Intel, membar #StoreStore+#LoadStore on sparc, and
lwsync on powerpc.  Or you could wait an additional RCU grace period
to ensure those prior accesses complete before deleting the element if
you have RCU set up to track memory synchronization.

RCU "read" access is kind of like a lock.  And when you release
a lock, you need release memory synchronization semantics to prevent
accesses occurring outside of the critical region, the end of which
in this case would be defined by the store of NULL into the hazard pointer.

Additionally if you replace any non NULL hazard pointer value you will  
need to use
release semantics.

There might be something you can do to avoid the extra RCU wait but
I'd have to study it a little more to get a better handle on the
trade offs.

>
> Or am I missing something?  Or is there some CPU that Linux supports that
> does inexact interrupts?

It's not the interrupts per se that are of interest here, it's the memory
synchronization.  If interrupts are a problem, you could always find  
something
that does synchronization in a more orderly manner, or put explicit memory
synchronization in the interrupt handler to force exactitude for this  
particular
case.

>
> I must admit that I am not completely comfortable with this approach --  
> it
> needs to be beaten up pretty thoroughly with both testing and theoretical
> analysis.  And there might well be a flaw in my reasoning above.  ;-)
>

I suppose I should do some kind of formal analysis of this.  I'm figuring  
out
if this technique is interesting enough first before I go through all that  
work.


-- 
Joe Seigh

