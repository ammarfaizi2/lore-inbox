Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946467AbWJTUaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946467AbWJTUaR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 16:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946479AbWJTUaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 16:30:17 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59839 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946467AbWJTUaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 16:30:15 -0400
Date: Sat, 21 Oct 2006 02:00:16 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Paul Jackson <pj@sgi.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, mbligh@google.com, akpm@osdl.org,
       menage@google.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org,
       rohitseth@google.com, holt@sgi.com, dipankar@in.ibm.com,
       suresh.b.siddha@intel.com, clameter@sgi.com
Subject: Re: [RFC] cpuset: remove sched domain hooks from cpusets
Message-ID: <20061020203016.GA26421@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20061019092358.17547.51425.sendpatchset@sam.engr.sgi.com> <4537527B.5050401@yahoo.com.au> <20061019120358.6d302ae9.pj@sgi.com> <4537D056.9080108@yahoo.com.au> <4537D6E8.8020501@google.com> <4538F34A.7070703@yahoo.com.au> <20061020120005.61239317.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020120005.61239317.pj@sgi.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

This mail seems to be as good as any to reply to, so here goes

On Fri, Oct 20, 2006 at 12:00:05PM -0700, Paul Jackson wrote:
> > The patch I posted previously should (modulo bugs) only do partitioning
> > in the top-most cpuset. I still need clarification from Paul as to why
> > this is unacceptable, though.
> 
> That patch partitioned on the children of the top cpuset, not the
> top cpuset itself.
> 
> There is only one top cpuset - and that covers the entire system.
> 
> Consider the following example:
> 
> 	/dev/cpuset		cpu_exclusive=1, cpus=0-7, task A
> 	/dev/cpuset/a		cpu_exclusive=1, cpus=0-3, task B
> 	/dev/cpuset/b		cpu_exclusive=1, cpus=4-7, task C
> 
> We have three cpusets - the top cpuset and two children, 'a' and 'b'.
> 
> We have three tasks, A, B and C.  Task A is running in the top cpuset,
> with access to all 8 cpus on the system.  Tasks B and C are each in
> a child cpuset, with access to just 4 cpus.
> 
> By your patch, the cpu_exclusive cpusets 'a' and 'b' partition the
> sched domains in two halves, each covering 4 of the systems 8 cpus.
> (That, or I'm still a sched domain idiot - quite possible.)
> 
> As a result, task A is screwed.  If it happens to be on any of cpus
> 0-3 when the above is set up and the sched domains become partitioned,
> it will never be considered for load balancing on any of cpus 4-7.
> Or vice versa, if it is on any of cpus 4-7, it has no chance of
> subsequently running on cpus 0-3.

ok I see the issue here, although the above has been the case all along.
I think the main issue here is that most of the users dont have to
do more than one level of partitioning (having to partitioning a system
with not more than 16 - 32 cpus, mostly less) and it is fairly easy to keep
track of exclusive cpusets and task placements and this is not such
a big problem at all. However I can see that with 1024 cpus this is not
trivial anymore to remember all of the partitioning especially if the
partioning is more than 2 levels deep and that its gets unwieldy

So I propose the following changes to cpusets

1. Have a new flag that takes care of sched domains. (say sched_domain)
   Although I still think that we can still tag sched domains at the
   back of exclusive cpusets, I think it best to separate the two
   and maybe even add a separate CONFIG option for this. This way we
   can keep any complexity arising out of this, such as hotplug/sched
   domains all under the config.
2. The main change is that we dont allow tasks to be added to a cpuset
   if it has child cpusets that also have the sched_domain flag turned on
   (Maybe return a EINVAL if the user tries to do that)

Clearly one issue remains, tasks that are already running at the top cpuset.
Unless these are manually moved down to the correct cpuset heirarchy they
will continue to have the problem as before. I still dont have a simple
enough solution for this at the moment other than to document this at the
moment. But I still think on smaller systems this should be fairly easy task
for the administrator if they really know what they are doing. And the
fact that we have a separate flag to indicate the sched domain partitioning
should make it harder for them to shoot themselves in the foot.
Maybe there are other better ways to resolve this ?

One point I would argue against is to completely decouple cpusets and
sched domains. We do need a way to partition sched domains and doing
it along the lines of cpusets seems to be the most logical. This is
also much simpler in terms of additional lines of code needed to support
this feature. (as compared to adding a whole new API just to do this)

	-Dinakar
