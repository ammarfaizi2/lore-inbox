Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750727AbWH0GLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750727AbWH0GLu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 02:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWH0GLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 02:11:50 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:39140 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750727AbWH0GLt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 02:11:49 -0400
Date: Sun, 27 Aug 2006 11:41:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060827061155.GC22565@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060824102618.GA2395@in.ibm.com> <20060824091704.cae2933c.akpm@osdl.org> <20060825095008.GC22293@redhat.com> <Pine.LNX.4.64.0608261404350.11811@g5.osdl.org> <20060826150422.a1d492a7.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826150422.a1d492a7.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 03:04:22PM -0700, Andrew Morton wrote:
> On Sat, 26 Aug 2006 14:09:55 -0700 (PDT)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > I definitely want to have this fixed, and Gautham's patches look like a 
> > good thing to me, but the "trying to fix up the current mess" part was 
> > really about trying to get 2.6.18 in a mostly working state rather than 
> > anything else. I think it's been too late to try to actually _fix_ it for 
> > 2.6.18 for a long time already.
> > 
> > So my reaction is that this redesign should go in asap after 2.6.18, 
> > unless people feel strongly that the current locking has so many bugs that 
> > people can actually _hit_ in practice that it's better to go for the 
> > redesign early.
> 
> It certainly needs a redesign.  A new sort of lock which makes it appear to
> work won't fix races like:
> 
> int cpufreq_update_policy(unsigned int cpu)
> {
> 	struct cpufreq_policy *data = cpufreq_cpu_get(cpu);
> 
> 	...
> 
> 	lock_cpu_hotplug();
> 

The problem with cpufreq was that it used lock_cpu_hotplug() 
in some common routines because it
was needed in some paths and then also called the same routines
from the CPU hotplug callback path. That is easily fixable and
Gautham's patch 1/4 does exactly that.
One thing I have privately suggested to Gautham is to do an audit
of bad lock_cpu_hotplug() uses.

Now coming to the read-side of lock_cpu_hotplug() - cpu hotplug
is a very special asynchronous event. You cannot protect against
it using your own subsystem lock because you don't control
access to cpu_online_map. With multiple low-level subsystems
needing it, it also becomes difficult to work out the lock
hierarchies. The right way to do this is what Gautham and Ingo
are discussing - a scalable rw semaphore type lock that allows
recursive readers.

> 
> I rather doubt that anyone will be hitting the races in practice.  I'd
> recommend simply removing all the lock_cpu_hotplug() calls for 2.6.18.

I don't think that is a good idea. The right thing to do would be to
do an audit and clean up the bad lock_cpu_hotplug() calls. People
seem to have just got lazy with lock_cpu_hotplug().

Thanks
Dipankar
