Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbWIGWUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbWIGWUo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 18:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbWIGWUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 18:20:44 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:24487 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751911AbWIGWUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 18:20:43 -0400
Date: Thu, 7 Sep 2006 15:20:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <npiggin@suse.de>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler.
In-Reply-To: <20060907214753.GA28080@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0609071511370.18416@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
 <20060907105801.GC3077@wotan.suse.de> <Pine.LNX.4.64.0609071016250.16674@schroedinger.engr.sgi.com>
 <20060907214753.GA28080@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Sep 2006, Nick Piggin wrote:

> > Right but that situation is rare and the performance is certainly
> > better if the unpinned processes are not all running on the same 
> > processor.
> 
> But the situation is rare full stop otherwise we'd have had more
> complaints. And we do tend to care about theoretical max latency
> in many other obscure paths than the scheduler.

The situation is rare if you just have a couple of cpus and it also does 
not occur if you do not pin processors.

> How about if you have N/2 CPUs with lots of stuff on runqueues?
> Then the other N/2 will each be scanning N/2+1 runqueues... that's
> a lot of bus traffic going on which you probably don't want.

Then the load will likely be sitting on a runqueue and run 
much slower since it has to share cpus although many cpus are available 
to take new jobs. The scanning is very fast and it is certainly better 
than continuing to overload a single processor.

> > That wont work since the notion of "pinned" is relative to a cpu.
> > A process may be pinned to a group of processors. It will only appear to 
> > be pinned for cpus outside that set of processors!
> 
> A sched-domain is per-CPU as well. Why doesn't it work?

Lets say you store the latest set of pinned cpus encountered (I am not 
sure what cpu number would accomplish). The next time you have to 
reschedule the situation may be completely different and you would have
to revalidate the per cpu pinned cpu set. 

> > What good does storing a processor number do if the processes can change 
> > dynamically and so may the pinning of processors. We are dealing with
> > a set of processes. Each of those may be pinned to a set of processors.
> 
> Yes, it isn't going to be perfect, but it would at least work (which
> it doesn't now) without introducing that latency.

Could you tell us how this could work?

> > This looks to me as a design flaw that would require either a major rework 
> > of the scheduler or (my favorite) a delegation of difficult (and 
> > computational complex and expensive) scheduler decisions to user space.
> 
> I'd be really happy to move this to userspace :)

Can we merge this patch and then I will try to move this as fast as 
possible to userspace?

Ok then we need to do the following to address the current issue and to
open up the possibilities for future enhancements:

1. Add a new field to /proc/<pid>/cpu that can be written to and that
   forces the process to be moved to the corresponding cpu.

2. Extend statistics in /proc/<pid>/ to allow the export of more scheduler
   information and a special flag that is set if a process cannot be 
   rescheduling. initially the user space scheduler may just poll this 
  field.

3. Optional: Some sort of notification mechanism that a user space 
   scheduler helper could subscribe to. If a pinned tasks situation
   is encountered then the notification passes the number of the
   idle cpu.

