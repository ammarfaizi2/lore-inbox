Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWG2NwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWG2NwE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 09:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWG2NwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 09:52:04 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:12681 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932144AbWG2NwD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 09:52:03 -0400
Date: Sat, 29 Jul 2006 15:45:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Ashok Raj <ashok.raj@intel.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Dave Jones <davej@redhat.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
Message-ID: <20060729134527.GA10899@elte.hu>
References: <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org> <1153921207.3381.21.camel@laptopd505.fenrus.org> <20060726155114.GA28945@redhat.com> <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org> <1153942954.3381.50.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org> <20060726205810.GB23488@in.ibm.com> <Pine.LNX.4.64.0607261422110.4168@g5.osdl.org> <20060727014049.GA13187@elte.hu> <20060727103811.A29962@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727103811.A29962@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.9 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5000]
	-0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Ashok Raj <ashok.raj@intel.com> wrote:

> On Thu, Jul 27, 2006 at 03:40:49AM +0200, Ingo Molnar wrote:
> > 
> > * Linus Torvalds <torvalds@osdl.org> wrote:
> > 
> > > But I agree with Arjan - I think the fundamental problem is that cpu 
> > > hotplug locking is just is fundamentally badly designed as-is. There's 
> > > really very little point to making it a _lock_ per se, since most 
> > > people really want more of a "I'm using this CPU, don't try to remove 
> > > it right now" thing which is more of a ref-counting-like issue.
> > 
> > we'd also need a facility to wait on that refcount - i.e. a waitqueue. 
> > Which means we'd have a "refcount + waitqueue", which is equivalent to a 
> > "recursive, sleeping read-lock", where the write-side could be used as a 
> > simple facility to "wait for all readers to go away and block new 
> > readers from entering the critical sections". [which type of lock Linux 
> > does not have right now. rwsems come the closest but they dont recurse.]
> 
> sounds like some varient of conditional variables, caveat might be 
> that new readers permitted if in the same call thread/cpu?

well, i'd just call it a recursive rwsem. (sure, you can express it via 
condition variables, but just about any locking method can be expressed 
via them.)

> > Also, the hotplug lock is global right now which is pretty unscalable, 
> > so the rw-mutex should also be per-CPU, and the hotplug locking API 
> > should be changed to something like:
> > 
> > 	cpu = cpu_hotplug_lock();
> 
> so this is sort of like the get_cpu()/put_cpu() interface that does 
> preempt_disable() + get current cpu.

the API is similar - behavior is different in that the 'per-cpu lock' 
i'm talking about _does_ allow preemption and migration to another CPU.

	Ingo
