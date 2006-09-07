Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751613AbWIGVr4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbWIGVr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 17:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751614AbWIGVr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 17:47:56 -0400
Received: from ns.suse.de ([195.135.220.2]:53673 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751559AbWIGVrz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 17:47:55 -0400
Date: Thu, 7 Sep 2006 23:47:53 +0200
From: Nick Piggin <npiggin@suse.de>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
Message-ID: <20060907214753.GA28080@wotan.suse.de>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com> <20060907105801.GC3077@wotan.suse.de> <Pine.LNX.4.64.0609071016250.16674@schroedinger.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609071016250.16674@schroedinger.engr.sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 10:24:26AM -0700, Christoph Lameter wrote:
> Hmmm... Some more comments
> 
> On Thu, 7 Sep 2006, Nick Piggin wrote:
> 
> > So what I worry about with this approach is that it can really blow
> > out the latency of a balancing operation. Say you have N-1 CPUs with
> > lots of stuff locked on their runqueues.
> 
> Right but that situation is rare and the performance is certainly
> better if the unpinned processes are not all running on the same 
> processor.

But the situation is rare full stop otherwise we'd have had more
complaints. And we do tend to care about theoretical max latency
in many other obscure paths than the scheduler.

How about if you have N/2 CPUs with lots of stuff on runqueues?
Then the other N/2 will each be scanning N/2+1 runqueues... that's
a lot of bus traffic going on which you probably don't want.

> 
> > The solution I envisage is to do a "rotor" approach. For example
> > the last attempted CPU could be stored in the starving CPU's sd...
> > and it will subsequently try another one.
> 
> That wont work since the notion of "pinned" is relative to a cpu.
> A process may be pinned to a group of processors. It will only appear to 
> be pinned for cpus outside that set of processors!

A sched-domain is per-CPU as well. Why doesn't it work?

> What good does storing a processor number do if the processes can change 
> dynamically and so may the pinning of processors. We are dealing with
> a set of processes. Each of those may be pinned to a set of processors.

Yes, it isn't going to be perfect, but it would at least work (which
it doesn't now) without introducing that latency.

> 
> > I've been hot and cold on such an implementation for a while: on one
> > hand it is a real problem we have; OTOH I was hoping that the domain
> > balancing might be better generalised. But I increasingly don't
> > think we should let perfect stand in the way of good... ;)
> 
> I think we should fix the problem ASAP. Lets do this fix and then we can 
> think about other solutions. You already had lots of time to think about
> the rotor.

The problem has been known about for many years. It doesn't remain
unfixed because we didn't know about this brute force patch ;)
Given that Ingo also maintains the -RT patchset, it might face a
rocky road... but if he is OK with it then OK by me for now.

> This looks to me as a design flaw that would require either a major rework 
> of the scheduler or (my favorite) a delegation of difficult (and 
> computational complex and expensive) scheduler decisions to user space.

I'd be really happy to move this to userspace :)

