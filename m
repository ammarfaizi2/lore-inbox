Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbWKBE2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbWKBE2k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 23:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752641AbWKBE2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 23:28:40 -0500
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:9904 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751701AbWKBE2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 23:28:39 -0500
Date: Thu, 2 Nov 2006 09:57:43 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Gautham Shenoy <ego@in.ibm.com>, vatsa@in.ibm.com, dipankar@in.ibm.com
Subject: Re: Remove hotplug cpu crap from cpufreq.
Message-ID: <20061102042743.GA4663@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061101225925.GA17363@redhat.com> <Pine.LNX.4.64.0611011507480.25218@g5.osdl.org> <20061101161723.f132d208.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101161723.f132d208.akpm@osdl.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 04:17:23PM -0800, Andrew Morton wrote:
> On Wed, 1 Nov 2006 15:09:52 -0800 (PST)
> Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > 
> > 
> > On Wed, 1 Nov 2006, Dave Jones wrote:
> > >
> > > I've had it with this stuff.  For months, we've had various warnings
> > > popping up from this code (which was clearly half-baked at best when it
> > > went in).
> > > 
> > > Until someone steps up who actually gives a damn about fixing it, can
> > > we just rip this crap out so I stop getting mails from users who couldn't
> > > care less about CPU hotplug anyway?
> > 
> > Hmm. People _have_ given a damn, and I think you were even cc'd.
> 
> I don't think Gautham cares about cpufreq-vs-hotplug per-se.  He cares

I *do* care about cpufreq-vs-hotplug. This was infact the main motivation to
fix the whole thing!

> about the crappy cpufreq code and the warnings it emits.

Cpufreq code is crappy with respect to hotplug "locking". The 
reason may be because of the fact that cpufreq was written before
cpu-hotplug was. I'm not sure, I need to check my history books!

I'm sure, as you pointed out in one of the earlier threads, folks have
misunderstood lock_cpu_hotplug and have sprinkled it everywhere
they could. Which was not good. I think the name "lock_cpu_hotplug"
is to blame.

Anyway,the way I see it, lock_cpu_hotplug was a mechanism provided to ensure 
that cpu's don't vanish/appear during some critical operation which uses the 
"online cpus" state information.

So, it was upto the subsystems to make use of it responsibly.
In case of cpufreq, the "perfect" (and the only) place to "lock" hot-cpu state 
is inside __cpufreq_driver_target around the call cpufreq_driver->target just
before changing frequencies on a set of cpus.

But unfortunately, the existing cpufreq-design does not allow this :(

> > Did you take a look at the 5-patch (or was it 6?) series by Gautham R 
> > Shenoy <ego@in.ibm.com>? I'm cc'ing him, in case you weren't on the 
> > original list, and he should talk to you ;)
> 
> Gautham's work is "add lots of complex machinery so cpufreq's existing crap
> works as it was supposed to". We end up with complex machinery as well as
> crappy cpufreq.
> The alternative is to rip all that stuff out of cpufreq and then go back
> and reimplement cpufreq cpu-hotplug safety from scratch.

My concern was interdependent subsystem calling lock_cpu_hotplug recursively.
cpufreq-workqueue interdependency was the only example for such an 
interdependency, though it could be avoided with the right design of cpufreq.

> > Right now, for 2.6.19, I'd prefer to not touch that mess unless there are 
> > known conditions that actually cause more problems than just stupid 
> > warnings..
> 
> afaik the warnings are the only symptom.

IMHO, we do need the feature to postpone a cpu-hotplug operation.
Question is how do we provide this feature? 

a) Globally as it was (and still is!) done by "lock_cpu_hotplug" 
	OR
b) Per-subsystem-wise as done by workqueue_mutex in kernel/workqueue.c.

I have been experimenting with both these approaches, and they both 
seem to work just fine for me.

Thanks and Regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
