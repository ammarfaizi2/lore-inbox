Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262529AbSJBSYg>; Wed, 2 Oct 2002 14:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262531AbSJBSYg>; Wed, 2 Oct 2002 14:24:36 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:12988 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262529AbSJBSYe>;
	Wed, 2 Oct 2002 14:24:34 -0400
Subject: Re: [RFC] Simple NUMA scheduler patch
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Erich Focht <efocht@ess.nec.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <200210021954.39358.efocht@ess.nec.de>
References: <Pine.LNX.4.44.0209050905180.8086-100000@localhost.localdomain>
	<1033516540.1209.144.camel@dyn9-47-17-164.beaverton.ibm.com> 
	<200210021954.39358.efocht@ess.nec.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 02 Oct 2002 11:26:57 -0700
Message-Id: <1033583217.25427.23.camel@dyn9-47-17-164.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-10-02 at 10:54, Erich Focht wrote:
> Hi Michael,
> 
> On Wednesday 02 October 2002 01:55, Michael Hohnbaum wrote:
> > Attached is a patch which provides a rudimentary NUMA scheduler.
> > This patch basically does two things:
> >
> > * at exec() it finds the least loaded CPU to assign a task to;
> > * at load_balance() (find_busiest_queue() actually) it favors
> >   cpus on the same node for taking tasks from.
> 
> it's a start. But I'm afraid a full solution will need much more code
> (which is one of the problems with my NUMA scheduler patch).

Yes, I agree that a full solution needs much more, however I think that
what is in this patch is a good start which can be extended over time.
Making a process sticky to a node is the next feature that I would like
to add.
> 
> The ideas behind your patch are:
> 1. Do initial load balancing, choose the least loaded CPU at the
> beginning of exec().
> 2. Favor own node for stealing if any CPU on the own node is >25%
> more loaded. Otherwise steal from another CPU if that one is >100%
> more loaded.
> 
> 1. is fine but should ideally aim for equal load among nodes. In
> the current form I believe that the original load balancer does the
> job right after fork() (which must have happened before exec()). As
> you changed the original load balancer, you really need this initial
> balancing.

Actually, what is implemented now will on a loaded system result in 
a reasonable balance between nodes.  On a lightly loaded system tasks
will tend to fill one node before new processes get distributed to
other nodes.  This actually benefits keeping memory accesses local 
on the same node assuming that the small number of processes are 
inter-related.
> 
> 2. is ok as it makes it harder to change the node. But again, you don't
> aim at equally balanced nodes. And: if the task gets away from the node
> on which it got its memory, it has no reason to ever come back to it.

Again, I believe that as a system becomes loaded, the nodes get
balanced.  Running the numa_test that you sent me, shows thats
once the number of processes is greater than 2*NCPU we get a fairly
equal distribution across nodes.  I've made a few tweaks since I
sent the patch out that helps on this (which I'll repost later today).
> 
> For a final solution I believe that we will need targets like:
> (a) equally balance nodes
> (b) return tasks to the nodes where their memory is
> (c) make nodes "sticky" for tasks which have their memory on them,
> "repulsive" for other tasks.
> But for a first attempt to get the scheduler more NUMA aware all this
> might be just too much.

I agree completely on b and c.  a is a reasonable goal that I think is
fairly close already with this patch.
> 
> With simple benchmarks you will most probably beat the plain O(1)
> scheduler on NUMA if you implement (a) in just 1. and 2. as your node
> is already somewhat "sticky". In complicated benchmarks (like a kernel
> compile ;-) it could already be too difficult to understand when the
> load balancer did what and why...
> 
> It would be nice to see some numbers.

Yep.  What sort of numbers would you like?  I've got kernbench numbers
and profile results from 2.5.38-mm1 which I'll put in a followup post.
These show a modest performance benefit, but don't provide detail on 
process to node mapping.  I've also have various test programs you've
sent that provide a good mapping of process to nodes.

                   Michael

 
> 
> Best regards,
> Erich
> 
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

