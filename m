Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751189AbWFPJsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751189AbWFPJsG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 05:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWFPJsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 05:48:06 -0400
Received: from jaguar.mkp.net ([192.139.46.146]:15306 "EHLO jaguar.mkp.net")
	by vger.kernel.org with ESMTP id S1750839AbWFPJsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 05:48:05 -0400
To: Andi Kleen <ak@suse.de>
Cc: "Tony Luck" <tony.luck@intel.com>, discuss@x86-64.org,
       linux-kernel@vger.kernel.org, libc-alpha@sourceware.org,
       vojtech@suse.cz, linux-ia64@vger.kernel.org
Subject: Re: FOR REVIEW: New x86-64 vsyscall vgetcpu()
References: <200606140942.31150.ak@suse.de>
	<12c511ca0606151144i140c21e5w90dd948af9b536a4@mail.gmail.com>
	<200606160822.23898.ak@suse.de>
From: Jes Sorensen <jes@sgi.com>
Date: 16 Jun 2006 05:48:03 -0400
In-Reply-To: <200606160822.23898.ak@suse.de>
Message-ID: <yq0ejxp2zzg.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andi" == Andi Kleen <ak@suse.de> writes:

Andi> On Thursday 15 June 2006 20:44, Tony Luck wrote:
>> Another alternative would be to provide a mechanism for a process
>> to bind to the current cpu (whatever cpu that happens to be).  Then
>> the kernel gets to make the smart placement decisions, and
>> processes that want to be bound somewhere (but don't really care
>> exactly where) have a way to meet their need.  Perhaps a cpumask of
>> all zeroes to a sched_setaffinity call could be overloaded for
>> this?

Andi> I tried something like this a few years ago and it just didn't
Andi> work (or rather ran usually slower) The scheduler would select a
Andi> home node at startup and then try to move the process there.

Andi> The problem is that not using a CPU costs you much more than
Andi> whatever overhead you get from using non local memory.

It all depends on your application and the type of system you are
running on. What you say applies to smaller cpu counts. However once
we see the upcoming larger count multi-core cpus become commonly
available, this is likely to change and become more like what is seen
today on larger NUMA systems.

In the scientific application space, there are two very common
groupings of jobs. One is simply a large threaded application with a
lot of intercommunication, often via MPI. In many cases one ends up
running a job on just a subset of the system, in which case you want
to see threads placed on the same node(s) to minimize internode
communication. It is desirable to either force the other tasks on the
system (system daemons etc) onto other node(s) to reduce noise and
there could also be space to run another parallel job on the remaining
node(s).

The other common case is to have jobs which spawn off a number of
threads that work together in groups (via OpenMP). In this case you
would like to have all your OpenMP threads placed on the same node for
similar reasons.

Not getting this right can result in significant loss of performance
for jobs which are highly memory bound or rely heavily on
intercommunication and synchronization.

Andi> So by default filling the CPUs must be the highest priority and
Andi> memory policy cannot interfere with that.

I really don't think this approach is going to solve the problem. As
Tony also points out, tasks will eventually migrate. The user needs to
tell the kernel where it wants to run the tasks rather than the kernel
telling the task where it is located. Only the application (or
developer/user) knows how the threads are expected to behave, doing
this automatically is almost never going to be optimal. Obviously the
user needs visibility of the topology of the machine to do so but that
should be available on any NUMA system through /proc or /sys.

In the scientific space the jobs are often run repeatedly with new
data sets every time, so it is worthwhile to spend the effort up front
to get the placement right. One-off runs are obviously something else
and there your method is going to be more beneficial.

IMHO, what we really need is a more advanced way for user applications
to hint at the kernel how to place it's threads.

Cheers,
Jes
