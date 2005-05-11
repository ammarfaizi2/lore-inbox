Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261294AbVEKWpd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261294AbVEKWpd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVEKWpd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:45:33 -0400
Received: from main.gmane.org ([80.91.229.2]:6798 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261294AbVEKWpJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:45:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joe Seigh" <jseigh_02@xemaps.com>
Subject: Re: RCU + SMR for preemptive kernel/user threads.
Date: Wed, 11 May 2005 17:47:52 -0400
Message-ID: <opsqmr52snehbc72@grunion>
References: <opsqivh7agehbc72@grunion> <opsqkajto6ehbc72@grunion> <20050510165512.GA1569@us.ibm.com> <opsqkzxij0ehbc72@grunion> <20050511150454.GA1343@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005 08:04:54 -0700, Paul E. McKenney <paulmck@us.ibm.com>  
wrote:

> On Tue, May 10, 2005 at 06:40:20PM -0400, Joe Seigh wrote:


> In classic RCU, the release is supplied by the context switch.  In your
> scheme, couldn't you do the following on the update side?
>
> 	1.  Gather up all the hazard pointers.
> 	2.  Send IPIs to all other CPUs.
> 	3.  Check the hazard pointers gathered in #1 against the
> 	    blocks to be freed.

You need to do the IPIs before you look at the hazard pointers.

>
> The read side would do the following when letting go of a hazard pointer:
>
> 	1.  Prevent the compiler from reordering memory references
> 	    (the CPU would still be free to do so).
> 	2.  Set the hazard pointer to NULL.
> 	3.  begin non-critical-section code.
>
> Checking where the IPI is received by the read side:
>
> 1.  Before this point, the updater would have seen the non-NULL hazard
>     pointer (if the hazard pointer referenced the data item that was
>     previously removed).
> 2.  Ditto.
> 3.  Before this point, the hazard pointer could be seen as NULL, but
>     the read-side CPU will also have stopped using the pointer (since
>     we are assuming precise interrupts).

The problem is you don't know when the hazard pointer was set to NULL.
It could have been set soon after the IPI interrupt was received and
any outstanding accesses made since the IPI interrupt aren't syncronized
with respect to setting the hazard pointer to null.

But if you looked at the hazard pointer in the IPI interrupt handler,
you could use that information to decide whether you had to wait an
additional RCU interval.  So updater logic would be

          1.  Set global pointer to NULL.  // make object unreachable
          2.  Send IPIs  to all other CPUs
              (IPI interrupt handler will copy CPU's hazard pointers)
          3.  Check objects to be freed against copied hazard pointers.
          4.  There is no step 4.  Even if the actual hazard pointers
              that pointed to the object is NULL by this point (but not
              its copy), you'd still have to wait and addtional RCU
              interval so you might as well leave it out as redundant.

This is better.  I may try that trick I used to make NPTL condvars
faster to see if I can keep Linux user space version of this from
tanking.  It uses unix signals instead of IPIs.



>
> Again, not sure if all CPUs support precise interrupts.  The ones that I
> am familiar with do, at least for IPIs.
>
>> Additionally if you replace any non NULL hazard pointer value you will
>> need to use
>> release semantics.
>
> The trick is that the IPI provides the release semantics, but only
> when needed.  Right?
>
>> There might be something you can do to avoid the extra RCU wait but
>> I'd have to study it a little more to get a better handle on the
>> trade offs.
>
> True, there will need to be either two RCU waits or two rounds of IPIs.

Yes, it might better be called RCU+SMR+RCU in that case.


>>
>> I suppose I should do some kind of formal analysis of this.  I'm  
>> figuring
>> out
>> if this technique is interesting enough first before I go through all  
>> that
>> work.
>
> Hard to say without some experimentation.


I've done plenty of that.  I have some atomically thread-safe reference
counting impletations and a proxy GC based on those which I compare to
an RCU for user threads implementation.  Using lock-free in user space
gives you much more dramatic performance improvements than in the kernel.
It cuts down on unnecessary context switching which can slow things down
considerably.  Also mutexes and rwlocks are prone to starvation.  Making
them FIFO for guaranteed service order slows them down even further.

I usually use a semaphore to keep the updaters from running out of  
resources.
It slows down updater throughput but then I'm more concerned with reader
throughput.  If I want faster recovery of resources I'll used the atomic
refcounted pointer or the proxy based on it.  Slightly slower updater  
performance
but resources are recovered more quickly.

-- 
Joe Seigh

