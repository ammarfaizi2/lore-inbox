Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750954AbWA2NHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750954AbWA2NHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 08:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbWA2NHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 08:07:15 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:53179 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1750961AbWA2NHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 08:07:14 -0500
Date: Sun, 29 Jan 2006 07:06:59 -0600
From: Jack Steiner <steiner@sgi.com>
To: Nathan Lynch <ntl@pobox.com>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16 - sys_sched_getaffinity & hotplug
Message-ID: <20060129130659.GA17922@sgi.com>
References: <20060127230659.GA4752@sgi.com> <20060128025854.GA18730@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060128025854.GA18730@localhost.localdomain>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 08:58:55PM -0600, Nathan Lynch wrote:
> Jack Steiner wrote:
> > 
> > It appears if CONFIG_HOTPLUG_CPU is enabled, then all possible
> > cpus (0 .. NR_CPUS-1) are set in the cpu_possible_map on IA64.
> 
> That's too bad...

Yes it is! It breaks current applications that expect a set bit
to correspond to a valid cpu that a task can be scheduled on.
We have MPI applications that use sched_getaffinity() to determine
where to place their threads. Placing them on non-existant cpus
is problematic :-)

> 
> 
> > sched_getaffinity() returns the cpu_possible_map and'd with the current
> > task p->cpus_allowed. The default cpus_allowed is all ones.
> > 
> > This is causing problems for apps that use sched_get_sched_affinity()
> > to determine which cpus that they are allowed to run on.
> 
> How?  Are these apps expecting all set bits to correspond to online
> cpus?

Yes. That is what the man page says. That is what sched_getaffinity()
returns if CONFIG_HOTPLUG_CPU is not enabled.


> 
> 
> > The call to sched_getaffinity returns:
> > 
> > 	(from strace on a 2 cpu system with NR_CPUS = 512)
> > 	sched_getaffinity(0, 1024,  { ffffffffffffffff, ffffff ...
> > 
> > 
> > 
> > The man page for sched_getaffinity() is ambiguous. It says:
> > 	- A set bit corresponds to a legally  schedulable  CPU
> > 
> > But it also says:
> > 	- Usually, all bits in the mask are set.
> > 
> > 
> > Should the following change be made to sched_getaffinity(). 
> > 
> > Index: linux/kernel/sched.c
> > ===================================================================
> > --- linux.orig/kernel/sched.c	2006-01-25 08:50:21.401747695 -0600
> > +++ linux/kernel/sched.c	2006-01-27 16:57:24.504871895 -0600
> > @@ -4031,7 +4031,7 @@ long sched_getaffinity(pid_t pid, cpumas
> >  		goto out_unlock;
> >  
> >  	retval = 0;
> > -	cpus_and(*mask, p->cpus_allowed, cpu_possible_map);
> > +	cpus_and(*mask, p->cpus_allowed, cpu_online_map);
> 
> 
> I don't think so.
> 
> For one, that would be mucking around with a kernel/userspace ABI, I
> guess.

I would argue that CONFIG_HOTPLUG_CPU is what changed the API. The 
hotplug code (at least on IA64) has changed the meaning of the bits.

In addition, it does not seem logical that an API should change on IA64
based on whether or not the CONFIG_HOTPLUG_CPU config option is enabled.

> 
> Additionally, it would mean that the result of sched_getaffinity would
> vary with the number of online cpus in the system, which I don't think
> is desirable.

OTOH, if sched_getaffinity() does reflect online cpus, then what does
it reflect? If CONFIG_HOTPLUG_CPU is enabled, sched_getaffinity()
unconditionally returns a mask with NR_CPUS bits set.  This conveys 
no useful infornmation except for a kernel compile option.

-- 
Thanks

Jack Steiner (steiner@sgi.com)          651-683-5302
Principal Engineer                      SGI - Silicon Graphics, Inc.



