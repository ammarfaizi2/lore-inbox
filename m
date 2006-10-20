Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423246AbWJTVmS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423246AbWJTVmS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 17:42:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423239AbWJTVmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 17:42:17 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:18101 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1423235AbWJTVmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 17:42:14 -0400
Date: Fri, 20 Oct 2006 14:41:53 -0700
From: Paul Jackson <pj@sgi.com>
To: dino@in.ibm.com
Cc: nickpiggin@yahoo.com.au, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-Id: <20061020144153.b40b2cc9.pj@sgi.com>
In-Reply-To: <20061020203016.GA26421@in.ibm.com>
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com>
	<4537527B.5050401@yahoo.com.au>
	<20061019120358.6d302ae9.pj@sgi.com>
	<4537D056.9080108@yahoo.com.au>
	<4537D6E8.8020501@google.com>
	<4538F34A.7070703@yahoo.com.au>
	<20061020120005.61239317.pj@sgi.com>
	<20061020203016.GA26421@in.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One point I would argue against is to completely decouple cpusets and
> sched domains. We do need a way to partition sched domains and doing
> it along the lines of cpusets seems to be the most logical. This is
> also much simpler in terms of additional lines of code needed to support
> this feature. (as compared to adding a whole new API just to do this)

The "simpler" (fewer code lines) point I can certainly agree with.

The "most logical" point I go back and forth on.

The flat partitions, forming a complete, non-overlapping cover, needed
by sched domains can be mapped to selected cpusets in their nested
hierarchy, if we impose the probably reasonable constraint that for
any cpuset across which we require to load balance, we would want that
cpusets cpus to be entirely contained within a single sched domain
partition.

Earlier, such as last week and before, I had been operating under the
assumption that sched domain partitions were hierarchical too, so that
just because a partition boundary ran right down the middle of my most
active cpuset didn't stop load balancing across that boundary, but just
perhaps slowed load balancing down a bit, as it would only occur at some
higher level in the partition hierarchy, which presumably balanced less
frequently.  Apparently this sched domain partition hierarchy was a
figment of my over active imagination, along with the tooth fairy and
Santa Claus.

Anyhow, if we consider that constraint (don't split or cut an active
cpuset across partitions) not only reasonable, but desirable to impose,
then integrating the sched domain partitioning with cpusets, as you
describe, would indeed seem "most logical."

> 2. The main change is that we dont allow tasks to be added to a cpuset
>    if it has child cpusets that also have the sched_domain flag turned on
>    (Maybe return a EINVAL if the user tries to do that)

This I would not like.  It's ok to have tasks in cpusets that are
cut by sched domain partitions (which is what I think you were getting
at), just so long as one doesn't mind that they don't load balance
across the partition boundaries.

For example, we -always- have several tasks per-cpu in the top cpuset.
These are the per-cpu kernel threads.  They have zero interest in
load balancing, because they are pinned on a cpu, for their life.

Or, for a slightly more interesting example, one might have a sleeping
job (batch scheduler sent SIGPAUSE to all its threads) that is in a
cpuset cut by the current sched domain partitioning.  Since that job is
not running, we don't care whether it gets good load balancing services
or not.

I still suspect we will just have to let the admin partition their
system as they will, and if they screw up their load balancing,
the best we can do is to make all this as transparent and simple
and obvious as we can, and wish them well.

One thing I'm sure of.  The current (ab)use of the 'cpu_exclusive' flag
to define sched domain partitions is flunking the "transparent, simple
and obvious" test ;).

> I think the main issue here is that most of the users dont have to
> do more than one level of partitioning (having to partitioning a system
> with not more than 16 - 32 cpus, mostly less)

Could you (or some sched domain wizard) explain to me why we would even
want sched domain partitions on such 'small' systems?  I've been operating
under the (mis?)conception that these sched domain partitions were just
a performance band-aid for the humongous systems, where load balancing
across say 1024 CPUs was difficult to do efficiently.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
