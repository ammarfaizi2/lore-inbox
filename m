Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750977AbWG0RsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750977AbWG0RsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 13:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750974AbWG0RsK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 13:48:10 -0400
Received: from mga06.intel.com ([134.134.136.21]:3202 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750796AbWG0RsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 13:48:09 -0400
X-IronPort-AV: i="4.07,189,1151910000"; 
   d="scan'208"; a="97044778:sNHT44343236"
Date: Thu, 27 Jul 2006 10:38:12 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Srivatsa Vaddagiri <vatsa@in.ibm.com>,
       Arjan van de Ven <arjan@linux.intel.com>, Dave Jones <davej@redhat.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [patch] Reorganize the cpufreq cpu hotplug locking to not be totally bizare
Message-ID: <20060727103811.A29962@unix-os.sc.intel.com>
References: <1153855844.8932.56.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607251355080.29649@g5.osdl.org> <1153921207.3381.21.camel@laptopd505.fenrus.org> <20060726155114.GA28945@redhat.com> <Pine.LNX.4.64.0607261007530.29649@g5.osdl.org> <1153942954.3381.50.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0607261319160.4168@g5.osdl.org> <20060726205810.GB23488@in.ibm.com> <Pine.LNX.4.64.0607261422110.4168@g5.osdl.org> <20060727014049.GA13187@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060727014049.GA13187@elte.hu>; from mingo@elte.hu on Thu, Jul 27, 2006 at 03:40:49AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 03:40:49AM +0200, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > But I agree with Arjan - I think the fundamental problem is that cpu 
> > hotplug locking is just is fundamentally badly designed as-is. There's 
> > really very little point to making it a _lock_ per se, since most 
> > people really want more of a "I'm using this CPU, don't try to remove 
> > it right now" thing which is more of a ref-counting-like issue.
> 
> we'd also need a facility to wait on that refcount - i.e. a waitqueue. 
> Which means we'd have a "refcount + waitqueue", which is equivalent to a 
> "recursive, sleeping read-lock", where the write-side could be used as a 
> simple facility to "wait for all readers to go away and block new 
> readers from entering the critical sections". [which type of lock Linux 
> does not have right now. rwsems come the closest but they dont recurse.]

sounds like some varient of conditional variables, caveat might be that
new readers permitted if in the same call thread/cpu? 
(i.e recurive inside the same context?)

for e.g with the cpufreq kind of usage today, 

cpu_down()
   waits for ref to drop to zero;
   // now signalled by last reader when refcnt drops to 0
   do pre-remove-notify---> cpufreq 
	// this attempt to acquire read lock again shoudnt be blocked right
        // even though we have officially started waiting for cnt to drop 0?

problem was with the kondemand() when a remove_wq() caused a flush_wq()
that started to yeild and run the other wq thread. Now the depth control
that checked if the locking_task == current wasnt true that caused the 
dead lock again.

> 
> Also, the hotplug lock is global right now which is pretty unscalable, 
> so the rw-mutex should also be per-CPU, and the hotplug locking API 
> should be changed to something like:
> 
> 	cpu = cpu_hotplug_lock();

so this is sort of like the get_cpu()/put_cpu() interface that does 
preempt_disable() + get current cpu.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
