Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031272AbWK3Tkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031272AbWK3Tkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 14:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031274AbWK3Tkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 14:40:35 -0500
Received: from smtp.osdl.org ([65.172.181.25]:9916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031272AbWK3Tke (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 14:40:34 -0500
Date: Thu, 30 Nov 2006 11:40:09 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, davej@redhat.com, dipankar@in.ibm.com,
       vatsa@in.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-Id: <20061130114009.ed473fc0.akpm@osdl.org>
In-Reply-To: <20061130114617.GA2324@elte.hu>
References: <20061129152404.GA7082@in.ibm.com>
	<20061130083144.GC29609@elte.hu>
	<20061130102410.GB23354@in.ibm.com>
	<20061130110315.GA30460@elte.hu>
	<20061130031933.5d30ec09.akpm@osdl.org>
	<20061130114617.GA2324@elte.hu>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 12:46:17 +0100
Ingo Molnar <mingo@elte.hu> wrote:

> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > > This would be done totally serialized and while holding the hotplug 
> > > lock, so no CPU could go away or arrive while this operation is 
> > > going on.
> > 
> > You said "the hotplug lock".  That is the problem.
> 
> maybe i'm too dense today but i still dont see the fundamental problem. 
> 
> Even with complex inter-subsystem interactions, hotplugging could be 
> effectively and scalably controlled via a self-recursive per-CPU mutex, 
> and a pointer to it embedded in task_struct:

Yes, I suppose we could come up with now new lock type which fixes the
problem.  But first, let us review the problem.

Someone went through cpufreq sprinkling lock_cpu_hotplug() everywhere as if
it had magical properties.  For the past year or more, others have been
picking through the resulting bugs, trying to make things better and
treating that initial magic-pixie-dust as if it were inviolate and nobody
had a chance of understanding it.

IOW, cpufreq is screwed up, and we keep on trying to come up with more
complexity to unscrew it.

So what I would propose is that rather than going ahead and piling more
complexity on top of the existing poo-pile in an attempt to make it seem to
work, we should simply rip all the cpu-hotplug locking out of cpufreq
(there's a davej patch for that in -mm) and then just redo it all in an
organised fashion.

If, as a result of that exercise, we decide that the existing cpu-hotplug
serialisation mechanisms (ie: per-subsystem notification callbacks and
preempt_disable()) are insufficient then sure, that is the time to think
about more sophisticated locking primitives.

But please, let's stop asking "how do we make cpufreq's hotplug locking
work?".  Let's instead ask "how do we make cpufreq safe wrt hotplug?"

To do the latter is a matter of

- identify the per-cpu resources which need locking

- decide what mechanism is to be used to protect each such resource

- design the locking and its hierarchy

- implement, test.

In all this time, Gautham's emails from yesterday were the first occasion
on which anybody has taken the time to sit down and get us started on this
quite ordinary design & devel process.


Let me re-re-re-re-reiterate: this is a cpufreq problem.  It has not yet
been demonstrated (AFAICS) that it is a general problem.  I am unaware of
any other subsystems having got themselves into such a mess over hotplug
locking.  Now, maybe that's because cpufreq really is especially hard.  Or
maybe it's because it's just messed up.  I don't believe we know which of
those is true yet.
