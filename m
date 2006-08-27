Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbWH0Gqt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbWH0Gqt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 02:46:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbWH0Gqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 02:46:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47056 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750757AbWH0Gqs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 02:46:48 -0400
Date: Sat, 26 Aug 2006 23:46:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       ego@in.ibm.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       arjan@intel.linux.com, mingo@elte.hu, vatsa@in.ibm.com,
       ashok.raj@intel.com
Subject: Re: [RFC][PATCH 0/4] Redesign cpu_hotplug locking.
Message-Id: <20060826234618.b9b2535a.akpm@osdl.org>
In-Reply-To: <20060827061155.GC22565@in.ibm.com>
References: <20060824102618.GA2395@in.ibm.com>
	<20060824091704.cae2933c.akpm@osdl.org>
	<20060825095008.GC22293@redhat.com>
	<Pine.LNX.4.64.0608261404350.11811@g5.osdl.org>
	<20060826150422.a1d492a7.akpm@osdl.org>
	<20060827061155.GC22565@in.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Aug 2006 11:41:55 +0530
Dipankar Sarma <dipankar@in.ibm.com> wrote:

> Now coming to the read-side of lock_cpu_hotplug() - cpu hotplug
> is a very special asynchronous event. You cannot protect against
> it using your own subsystem lock because you don't control
> access to cpu_online_map.

Yes you do.  Please, read _cpu_up(), _cpu_down() and the example in
workqueue_cpu_callback().  It's really very simple.

> With multiple low-level subsystems
> needing it, it also becomes difficult to work out the lock
> hierarchies.

That'll matter if we do crappy code.  Let's not do that?

> > 
> > I rather doubt that anyone will be hitting the races in practice.  I'd
> > recommend simply removing all the lock_cpu_hotplug() calls for 2.6.18.
> 
> I don't think that is a good idea.

The code's already racy and I don't think anyone has reported a
cpufreq-vs-hotplug race.

> The right thing to do would be to
> do an audit and clean up the bad lock_cpu_hotplug() calls.

No, that won't fix it.  For example, take a look at all the *callers* of
cpufreq_update_policy().  AFAICT they're all buggy.  Fiddling with the
existing lock_cpu_hotplug() sites won't fix that.  (Possibly this
particular problem can be fixed by checking that the relevant CPU is still
online after the appropriate locking has been taken - dunno).

It needs to be ripped out and some understanding, thought and design should
be applied to the problem.

> People
> seem to have just got lazy with lock_cpu_hotplug().

That's because lock_cpu_hotplug() purports to be some magical thing which
makes all your troubles go away.
