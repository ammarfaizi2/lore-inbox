Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750720AbWH0LG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWH0LG4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 07:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWH0LG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 07:06:56 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:58582 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750720AbWH0LGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 07:06:55 -0400
Date: Sun, 27 Aug 2006 16:36:58 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-ID: <20060827110657.GF22565@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060824102618.GA2395@in.ibm.com> <20060824091704.cae2933c.akpm@osdl.org> <20060825095008.GC22293@redhat.com> <Pine.LNX.4.64.0608261404350.11811@g5.osdl.org> <20060826150422.a1d492a7.akpm@osdl.org> <20060827061155.GC22565@in.ibm.com> <20060826234618.b9b2535a.akpm@osdl.org> <20060827071116.GD22565@in.ibm.com> <20060827004213.4479e0df.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060827004213.4479e0df.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2006 at 12:42:13AM -0700, Andrew Morton wrote:
> On Sun, 27 Aug 2006 12:41:16 +0530
> Dipankar Sarma <dipankar@in.ibm.com> wrote:
> 
> > On Sat, Aug 26, 2006 at 11:46:18PM -0700, Andrew Morton wrote:
> > > Yes you do.  Please, read _cpu_up(), _cpu_down() and the example in
> > > workqueue_cpu_callback().  It's really very simple.
> > 
> > What are you talking about here ?
> 
> Did you look?  workqueue_mutex is used to protect per-cpu workqueue
> resources.  The lock is taken prior to modification of per-cpu resources
> and is released after their modification.  Very very simple.

I did and there is no lock named workqueue_mutex. workqueue_cpu_callback()
is farily simple and doesn't have the issues in cpufreq that
we are talking about (lock_cpu_hotplug() in cpu callback path).

> 
> > That is the write side. You are
> > *not* supposed to do lock_cpu_hotplug() in cpu callbacks paths AFAICT. 
> 
> The workqueue code doesn't use lock_cpu_hotplug().

And that is the right thing to do.


> > I am talking about readsides here - you read cpu_online_map and
> > block then reuse the map and make some calls to another subsystem
> > that may again do a similar read-side cpu_hotplug lock.
> 
> Two unrelated subsystems which have both independent and interdependent CPU
> hotplug locking requirements and neither of which can protect per-cpu
> resources via preempt_disable()?  Sounds unlikely and undesirable.

I would worry about situations where we have to use set_cpus_allowed()
with cpumasks. IIRC, those weren't trivial to handle and can happen
due to interaction between unrelated subsystems one using services
of the other - rtasd -> set_cpus_allowed() for example.

> > 1. If you are in cpu hotplug callback path, don't take any lock.
> 
> That rule is wrong.  The CPU_UP_PREPARE and CPU_DOWN_PREPARE notification
> entrypoints are the logical place for a subsystem to lock any per-cpu resources
> which another thread/cpu might presently be using.

I meant lock_cpu_hotplug(), not any lock. Of course, susbsystems
may need to use their own lock there to handle per-cpu data there.


> > 2. If you are in a non-hotplug path reading cpu_online_map and you don't
> >    block, you just disable preemption and you are safe from hotplug.
> 
> Sure.
> 
> > 3. If you are in a non-hotplug path and you use cpu_online_map and
> >    you *really* need to block, you use lock_cpu_hotplug() or 
> >    cpu_hotplug_disable whatever it is called.
> > 
> > Is this too difficult for people to follow ?
> 
> Apparently.  What's happening is that lock_cpu_hotplug() is seen as some
> amazing thing which will prevent an *event* from occurring.
> 
> There's an old saying "lock data, not code".  What data is being locked
> here?  It's the subsystem's per-cpu resources which we want to lock.  We
> shouldn't consider the lock as being some way of preventing an event from
> happening.

That is what I argued for earlier, but I was given some examples
where they really needed to disable the asynchronous event of
cpu hotplug - otherwise they would have need to use very complex
multi-layer locking.

> > > > seem to have just got lazy with lock_cpu_hotplug().
> > > 
> > > That's because lock_cpu_hotplug() purports to be some magical thing which
> > > makes all your troubles go away.
> > 
> > No it doesn't. Perhaps we should just document the rules better
> > and put some static checks for people to get it right.
> 
> Yes, we could probably fix cpufreq using the existing lock_cpu_hotplug(). 
> But we have a quite large amount of racy-wrt-cpu-hotplug code in the kernel
> and although a lot of it can be fixed with preempt_disable(), it's possible
> that we'll get into scalability problems.
> 
> If we do have scalability problems, they can be fixed on a per-subsystem
> basis: the affected subsystem can use per-cpu locking of its per-cpu data
> within its CPU_UP_PREPARE and CPU_DOWN_PREPARE handlers.  That's a local,
> contained issue, and addressing it this way is better than inventing (and
> debugging) some fancy new lock type.

I would suggest an audit of lock_cpu_hotlpug() users to start with.

Thanks
Dipankar
