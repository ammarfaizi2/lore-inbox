Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUIIMgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUIIMgz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUIIMgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:36:55 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:15097 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S261724AbUIIMgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:36:53 -0400
Date: Thu, 9 Sep 2004 08:41:23 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Paul Mackerras <paulus@samba.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Matt Mackall <mpm@selenic.com>, Anton Blanchard <anton@samba.org>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: [PATCH][5/8] Arch agnostic completely out of line locks / ppc64
In-Reply-To: <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.53.0409090810550.15087@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com>
 <16703.60725.153052.169532@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Paul,

On Thu, 9 Sep 2004, Paul Mackerras wrote:

> Just got a chance to look at the new out-of-line spinlock stuff
> (better late than never :).  I see a couple of problems there.  First,
> we now go two levels deep on SMP && PREEMPT: spin_lock is _spin_lock,
> which is out of line in kernel/sched.c.  That calls
> __preempt_spin_lock, which is out of line in kernel/sched.c, and isn't
> in the .text.lock section.  So if we get a timer interrupt in there,
> we won't attribute the profile tick to the original caller.

I think that bit is actually intentional since __preempt_spin_lock is also 
marked __sched so that it'll get charged as a scheduling function.

> The second problem is that __preempt_spin_lock doesn't do the yield to
> the hypervisor which we need to do on shared processor systems.  This
> is actually a long-standing problem, not one you have just introduced,
> but I have only just noticed it.  I can't make cpu_relax do the yield
> because the yield is a directed yield to a specific other virtual cpu
> (it says "give the rest of my timeslice to that guy over there") and I
> need the value in the lock variable in order to know who is holding
> the lock.

I think cpu_relax() (or some other primitive) should actually take a 
parameter, this will allow for us to use monitor/mwait on i386 too so 
that in cases where we're spinning waiting on memory modify we could do 
something akin to the following;

while (spin_is_locked(lock))
	cpu_relax(lock);

Although there are wakeup latencies when using monitor/mwait for such, 
some cases such as above should be ok (although there are implementation 
details such as the cost of a monitor operation on things like spin 
unlock paths). I believe such an API modification would be beneficiel for 
you too. What do others think?

Thanks,
	Zwane
