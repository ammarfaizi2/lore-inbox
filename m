Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbVEJQzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbVEJQzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 12:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbVEJQzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 12:55:23 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:29079 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261703AbVEJQzN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 12:55:13 -0400
Date: Tue, 10 May 2005 09:55:12 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Joe Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RCU + SMR for preemptive kernel/user threads.
Message-ID: <20050510165512.GA1569@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <opsqivh7agehbc72@grunion> <opsqkajto6ehbc72@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opsqkajto6ehbc72@grunion>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 09:32:07AM -0400, Joe Seigh wrote:
> I think you need a release memory barrier if you store into a hazard
> pointer that is non null to prevent prior accesses from occurring after
> the store.  That's an extra memory barrier for hazard pointers that I
> overlooked. One thing that could be done is wait an extra RCU grace
> period after the hazard pointer scan to ensure prior accesses have
> completed before freeing the resource.  That would lengthen the delay
> to approximately 2 RCU grace periods.  Could be a problem if you have
> a high write rate and are trying to keep that delay minimal.
> 
> There might be another way.  I'd have to investigate it a little more.

Here is what I thought you were suggesting for the updater:

	Remove item from list
	Send IPIs to all CPUs, relying on exact interrupts (which might
		not be present on all CPUs) to serialize the instruction
		streams of the other CPUs
	Wait for all IPIs to complete
	Wait until there are no hazard pointers referencing the item
		before freeing.

For the traverser:

	1. allocate hazard pointer (SW engr problem: what to do if
		allocation fails?  If deeply nested, holding locks, &c?)
	2. retry:
	3. Pick up pointer, store into hazard pointer.
	4. Tell the compiler not to reorder memory references across this point
	5. If hazard pointer does not match the pointer, goto retry.
	6. begin critical section

If the updater and traverser run concurrently, the interrupt forces
serialization -- look at all the possible interleavings to see this:
1.	Before this point, the traverser cannot see the removed element.
2.	Ditto.
3.	Ditto.
4.	Before this point, the traverser might have stored a pointer to
	the remove element into the hazard pointer, but will see the 
	disappearance when it returns from interrupt.
5.	Ditto.
6.	At this point, the hazard pointer has been set, and the
	interrupt will force memory ordering.

Similar reasoning when the traverser NULLs the hazard pointer.

Or am I missing something?  Or is there some CPU that Linux supports that
does inexact interrupts?

I must admit that I am not completely comfortable with this approach -- it
needs to be beaten up pretty thoroughly with both testing and theoretical
analysis.  And there might well be a flaw in my reasoning above.  ;-)

							Thanx, Paul
