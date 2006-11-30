Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936365AbWK3MbU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936365AbWK3MbU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 07:31:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936326AbWK3MUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 07:20:46 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:62946 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S936343AbWK3MUU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 07:20:20 -0500
Date: Thu, 30 Nov 2006 17:49:01 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Gautham R Shenoy <ego@in.ibm.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, davej@redhat.com,
       dipankar@in.ibm.com, vatsa@in.ibm.com, paulmck@us.ibm.com
Subject: Re: CPUFREQ-CPUHOTPLUG: Possible circular locking dependency
Message-ID: <20061130121901.GA25439@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061129152404.GA7082@in.ibm.com> <20061130083144.GC29609@elte.hu> <20061130102410.GB23354@in.ibm.com> <20061130110315.GA30460@elte.hu> <20061130114346.GC23354@in.ibm.com> <20061130115327.GB2324@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130115327.GB2324@elte.hu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2006 at 12:53:27PM +0100, Ingo Molnar wrote:
> 
> * Gautham R Shenoy <ego@in.ibm.com> wrote:
> 
> > This is what is currently being done by cpufreq:
> 
> ok!
> 
> > a) get_some_cpu_hotplug_protection() [use either some global mechanism
> > 					or a persubsystem mutex]
> 
> this bit is wrong i think. Any reason why it's not a per-CPU (but
> otherwise global) array of mutexes that controls CPU hotplug - as per my
> previous mail?
> 
> that would flatten the whole locking. Only one kind of lock taken,
> recursive and scalable.

I had posted one such recursive scalable version which can be found here
http://lkml.org/lkml/2006/10/26/73

I remember cc'ing you.

Yeah, it looks complicated and big, but then I did not want to add
another field to the task struct as one such attempt had already been
frowned upon ( I think long back Ashok posted it)

So I ended up writing the whole read/write lock/unlock code myself.

It's a RCU based lock, extremely light on the read side, but costly for the
writers since it does a synchronize_sched.

And yeah, it's partial towards the readers but with an additional field
in the task struct we can have a fair implementation.

Besides, an unfair cpu_hotplug_lock won't work since a process doing a
sched_getaffinity in a forever_while loop can prevent any hotplug from
happening.

> 
> Then the mechanism that changes CPU frequency should take all these
> hotplug locks on all (online) CPUs, and then first stop all processing
> on all CPUs, and then do the frequency change, atomically. This is with
> interrupts disabled everywhere /first/, and /without any additional
> locking/. That would prevent any sort of interaction from other CPUs -
> they'd all be sitting still with interrupts disabled.
> 

Yup.

> 	Ingo

regards
gautham.
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
