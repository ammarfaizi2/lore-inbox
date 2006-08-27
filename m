Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWH0HLM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWH0HLM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 03:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWH0HLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 03:11:11 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:33411 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750755AbWH0HLJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 03:11:09 -0400
Date: Sun, 27 Aug 2006 12:41:16 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060827071116.GD22565@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060824102618.GA2395@in.ibm.com> <20060824091704.cae2933c.akpm@osdl.org> <20060825095008.GC22293@redhat.com> <Pine.LNX.4.64.0608261404350.11811@g5.osdl.org> <20060826150422.a1d492a7.akpm@osdl.org> <20060827061155.GC22565@in.ibm.com> <20060826234618.b9b2535a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060826234618.b9b2535a.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 26, 2006 at 11:46:18PM -0700, Andrew Morton wrote:
> On Sun, 27 Aug 2006 11:41:55 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > Now coming to the read-side of lock_cpu_hotplug() - cpu hotplug
> > is a very special asynchronous event. You cannot protect against
> > it using your own subsystem lock because you don't control
> > access to cpu_online_map.
> 
> Yes you do.  Please, read _cpu_up(), _cpu_down() and the example in
> workqueue_cpu_callback().  It's really very simple.

What are you talking about here ? That is the write side. You are
*not* supposed to do lock_cpu_hotplug() in cpu callbacks paths AFAICT. 
If someone does it (like cpufreq did), it is just *wrong*.

> > With multiple low-level subsystems
> > needing it, it also becomes difficult to work out the lock
> > hierarchies.
> 
> That'll matter if we do crappy code.  Let's not do that?

I am talking about readsides here - you read cpu_online_map and
block then reuse the map and make some calls to another subsystem
that may again do a similar read-side cpu_hotplug lock. I suspect
that it hard to get rid of all possible dependencies.

> > > I rather doubt that anyone will be hitting the races in practice.  I'd
> > > recommend simply removing all the lock_cpu_hotplug() calls for 2.6.18.
> > 
> > I don't think that is a good idea.
> 
> The code's already racy and I don't think anyone has reported a
> cpufreq-vs-hotplug race.

Do cpu hotplugs in a one cpu and change frequencies in another -
I think Gautham has a script to reproduce this. Besides
lockdep apparently complains about it -

http://marc.theaimsgroup.com/?l=linux-kernel&m=115359728428432&w=2

> > The right thing to do would be to
> > do an audit and clean up the bad lock_cpu_hotplug() calls.
> 
> No, that won't fix it.  For example, take a look at all the *callers* of
> cpufreq_update_policy().  AFAICT they're all buggy.  Fiddling with the
> existing lock_cpu_hotplug() sites won't fix that.  (Possibly this
> particular problem can be fixed by checking that the relevant CPU is still
> online after the appropriate locking has been taken - dunno).
> 
> It needs to be ripped out and some understanding, thought and design should
> be applied to the problem.

Really, the hotplug locking rules are fairly simple-

1. If you are in cpu hotplug callback path, don't take any lock.

2. If you are in a non-hotplug path reading cpu_online_map and you don't
   block, you just disable preemption and you are safe from hotplug.

3. If you are in a non-hotplug path and you use cpu_online_map and
   you *really* need to block, you use lock_cpu_hotplug() or 
   cpu_hotplug_disable whatever it is called.

Is this too difficult for people to follow ?

> 
> > People
> > seem to have just got lazy with lock_cpu_hotplug().
> 
> That's because lock_cpu_hotplug() purports to be some magical thing which
> makes all your troubles go away.

No it doesn't. Perhaps we should just document the rules better
and put some static checks for people to get it right.

Thanks
Dipankar
