Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266706AbUGLEIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266706AbUGLEIX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 00:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266714AbUGLEIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 00:08:23 -0400
Received: from rav-az.mvista.com ([65.200.49.157]:18740 "EHLO
	zipcode.az.mvista.com") by vger.kernel.org with ESMTP
	id S266706AbUGLEIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 00:08:17 -0400
Subject: Re: [ANNOUNCE] Minneapolis Cluster Summit, July 29-30
From: Steven Dake <sdake@mvista.com>
Reply-To: sdake@mvista.com
To: Daniel Phillips <phillips@istop.com>
Cc: Daniel Phillips <phillips@redhat.com>,
       David Teigland <teigland@redhat.com>, linux-kernel@vger.kernel.org,
       Lars Marowsky-Bree <lmb@suse.de>
In-Reply-To: <200407111544.25590.phillips@istop.com>
References: <200407050209.29268.phillips@redhat.com>
	 <200407101657.06314.phillips@redhat.com>
	 <1089501890.19787.33.camel@persist.az.mvista.com>
	 <200407111544.25590.phillips@istop.com>
Content-Type: text/plain
Organization: MontaVista Software, Inc.
Message-Id: <1089605292.19787.62.camel@persist.az.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 11 Jul 2004 21:08:12 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-07-11 at 12:44, Daniel Phillips wrote:
> On Saturday 10 July 2004 19:24, Steven Dake wrote:
> > On Sat, 2004-07-10 at 13:57, Daniel Phillips wrote:
> > > On Saturday 10 July 2004 13:59, Steven Dake wrote:
> > > > overload conditions that have caused the kernel to run low on memory
> > > > are a difficult problem, even for kernel components...
> > > > ...I hope that helps atleast answer that some r&d is underway to solve
> > > > this particular overload problem in userspace.
> > >
> > > I'm certain there's a solution, but until it is demonstrated and proved,
> > > any userspace cluster services must be regarded with narrow squinty
> > > eyes.
> >
> > I agree that a solution must be demonstrated and proved.
> >
> > There is  another option, which I regularly recommend to anyone that
> > must deal with memory overload conditions.  Don't size the applications
> > in such a way as to ever cause memory overload.
> 
> That, and "just add more memory" are the two common mistakes people make when 
> thinking about this problem.  The kernel _normally_ runs near the low-memory 
> barrier, on the theory that caching as much as possible is a good thing.
> 

Running "near low memory conditions" and running in memory overload
which triggers the OOM killer and other bad behaviors are two totally
different conditions in the kernel.

> Unless you can prove that your userspace approach never deadlocks, the other 
> questions don't even move the needle.  I am sure that one day somebody, maybe 
> you, will demonstrate a userspace approach that is provably correct.  Until 
> then, if you want your cluster to stay up and fail over properly, there's 
> only one game in town.  
> 

As soon as you have proved that cman's cluster protocol cannot be the
target of attacks which lead to kernel faults or security faults..

Byzantine failures are a fact of life.  There are protocols to minimize
these sorts of attacks, but implementing them in the kernel is going to
prove very difficult (but possible).  One approach is to get them
working in userspace correctly, and port them to the kernel.

Oom conditions are another fact of life for poorly sized systems.  If a
cluster is within an OOM condition, it should be removed from the
cluster (because it is in overload, under which unknown and generally
bad behaviors occur).

The openais project does just this: If everything goes to hell in a
handbasket on the node running the cluster executive, it will be
rejected from the membership.  This rejection is implemented with a
distributed state machine that ensures, even in low memory conditions,
every node (including the failed node) reaches the same conclusions
about the current membership and works today in the current code.  If at
a later time the processor can reenter the membership because it has
freed up some memory, it will do so correctly.

> We need to worry about ensuring that no API _depends_ on the cluster manager 
> being in-kernel, and we also need to seek out and excise any parts that could 
> possibly be moved out to user space without enabling the deadlock or grossly 
> messing up the kernel code.

> > > > I'd invite you, or others interested in these sorts of services, to
> > > > contribute that code, if interested.
> > >
> > > Humble suggestion: try grabbing the Red Hat (Sistina) DLM code and see
> > > if you can hack it to do what you want.  Just write a kernel module
> > > that exports the DLM interface to userspace in the desired form.
> > >
> > >    http://sources.redhat.com/cluster/dlm/
> >
> > I would rather avoid non-mainline kernel dependencies at this time as it
> > makes adoption difficult until kernel patches are merged into upstream
> > code.  Who wants to patch their kernel to try out some APIs?
> 
> Everybody working on clusters.  It's a fact of life that you have to apply 
> patches to run cluster filesystems right now.  Production will be a different 
> story, but (except for the stable GFS code on 2.4) nobody is close to that.
> 

Perhaps people skilled in running pre-alpha software would consider
patching a kernel to "give it a run".  I have no doubts about that.

I would posit a guess people interested in implementing production
clusters are not too interested about applying kernel patches (and
causing their kernel to become unsupported) to achieve clustering
support any time soon.

> > I am doubtful these sort of kernel patches will be merged without a strong
> > argument of why it absolutely must be implemented in the kernel vs all
> > of the counter arguments against a kernel implementation.
> 
> True.  Do you agree that the PF_MEMALLOC argument is a strong one?
> 

out of memory overload is a sucky situation poorly handled by any
software, kernel, userland, embedded, whatever.  The best solution is to
size the applications such that a memory overload doesn't occur.  Then
if a memory overload condition does occur, that node should aleast
become suspected of a byzantine failure condition which should cause its
rejection from the current membership (in the case of a distributed
system such as a cluster).

> > There is one more advantage to group messaging and distributed locking
> > implemented within the kernel, that I hadn't originally considered; it
> > sure is sexy.
> 
> I don't think it's sexy, I think it's ugly, to tell the truth.  I am actively 
> researching how to move the slow-path cluster infrastructure out of kernel, 
> and I would be pleased to work together with anyone else who is interested in 
> this nasty problem.
> 
There can be some advantages to group messaging being implemented in the
kernel, if it is secure, done correctly (in my view, correctly means
implementing the virtual synchrony model) and has low risk of impact to
other systems.

There are no kernel implemented clustering protocols that come close to
these goals today.

There are userland implementations under way which will meet these
objectives.

Perhaps these protocols could be ported to the kernel if group messaging
absolutely must be available to kernel components without userland
intervention.  But I'm still not convinced userland isn't the correct
place for these sorts of things.

Thanks
-steve

> Regards,
> 
> Daniel

