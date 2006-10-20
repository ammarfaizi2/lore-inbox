Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423249AbWJTWgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423249AbWJTWgC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 18:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422748AbWJTWf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 18:35:59 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:34196 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423249AbWJTWfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 18:35:53 -0400
Date: Sat, 21 Oct 2006 04:05:53 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: nickpiggin@yahoo.com.au, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-ID: <20061020223553.GA14357@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com> <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com> <4538F34A.7070703@yahoo.com.au> <20061020120005.61239317.pj@sgi.com> <20061020203016.GA26421@in.ibm.com> <20061020144153.b40b2cc9.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020144153.b40b2cc9.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 02:41:53PM -0700, Paul Jackson wrote:
> 
> > 2. The main change is that we dont allow tasks to be added to a cpuset
> >    if it has child cpusets that also have the sched_domain flag turned on
> >    (Maybe return a EINVAL if the user tries to do that)
> 
> This I would not like.  It's ok to have tasks in cpusets that are
> cut by sched domain partitions (which is what I think you were getting
> at), just so long as one doesn't mind that they don't load balance
> across the partition boundaries.
> 
> For example, we -always- have several tasks per-cpu in the top cpuset.
> These are the per-cpu kernel threads.  They have zero interest in
> load balancing, because they are pinned on a cpu, for their life.

I cannot think of any reason why this change would affect per-cpu tasks.

> 
> Or, for a slightly more interesting example, one might have a sleeping
> job (batch scheduler sent SIGPAUSE to all its threads) that is in a
> cpuset cut by the current sched domain partitioning.  Since that job is
> not running, we don't care whether it gets good load balancing services
> or not.

ok here's when I think a system administrator would want to partition
sched domains. If there is an application that is very sensitive to
performance and latencies and would have very low tolerance for 
interference from any other code running on the cpus, then the
admin would partition the sched domain and separate this application
from the rest of the system. (per-cpu threads obviously will 
continue to run in the same domain as the app)

So in this example, clearly there is no sense in letting a batch job
run in the same sched domain as our application. Now lets say if our
performance and latency sensitive application only runs during the
day, then the admin can turn off the sched domain flag and tear down
the sched domain for the night. This will then enable the batch job
running in the parent cpuset to get a chance to run on all the cpus.

Returning -EINVAL when trying to attach a job to the top cpuset when
it has a child cpuset(s) that has the sched_domain flag turned on, would
mean that the administrator would know that s/he does not have all of
the cpus in that cpuset for their use. However by attaching jobs
(such as the batch job in your example) to the top cpuset, before
doing any sched domain partitioning would mean that they make the best
use of resources as well (sort of a backdoor). However if you feel
that this puts too much of a restriction on the admin for creating
tasks such as the batch job, then we would have to do without it
(just documenting the sched_domain and its effects)

> 
> I still suspect we will just have to let the admin partition their
> system as they will, and if they screw up their load balancing,
> the best we can do is to make all this as transparent and simple
> and obvious as we can, and wish them well.
> 
> One thing I'm sure of.  The current (ab)use of the 'cpu_exclusive' flag
> to define sched domain partitions is flunking the "transparent, simple
> and obvious" test ;).

I think this is a case of one set of folks talking <32 cpu systems
and another set talking >512 cpu systems

> 
> > I think the main issue here is that most of the users dont have to
> > do more than one level of partitioning (having to partitioning a system
> > with not more than 16 - 32 cpus, mostly less)
> 
> Could you (or some sched domain wizard) explain to me why we would even
> want sched domain partitions on such 'small' systems?  I've been operating
> under the (mis?)conception that these sched domain partitions were just
> a performance band-aid for the humongous systems, where load balancing
> across say 1024 CPUs was difficult to do efficiently.

Well it makes a difference for applications that have a RT/performance
sensitive componant that needs a sched domain of its own

	-Dinakar
