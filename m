Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263002AbVHEMhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbVHEMhX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbVHEMhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:37:23 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:44179 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S263002AbVHEMhU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:37:20 -0400
Date: Fri, 5 Aug 2005 18:07:54 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com, george@mvista.com,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Message-ID: <20050805123754.GA1262@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <200508031559.24704.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 03, 2005 at 06:05:28AM +0000, Con Kolivas wrote:
> This is the dynamic ticks patch for i386 as written by Tony Lindgen 
> <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>. 
> Patch for 2.6.13-rc5
> 
> There were a couple of things that I wanted to change so here is an updated 
> version. This code should have stabilised enough for general testing now.

Con,
	I have been looking at some of the requirement of tickless idle CPUs in
core kernel areas like scheduler and RCU. Basically, both power management and 
virtualization benefit if idle CPUs can cut off useless timer ticks. Especially 
from a virtualization standpoint, I think it makes sense that we enable this 
feature on a per-CPU basis i.e let individual CPUs cut off their ticks as and 
when they become idle. The benefit of this is more visible in platforms that 
host lot of (SMP) VMs on the same machine. Most of the time, these VMs may be 
partially idle (some CPUs in it are idle, some not) and it is good that we 
quiesce the timer ticks on the partial set of idle CPUs. Both S390 and Xen ports
of Linux kernel have this ability today (S390 has it in mainline already and 
Xen has it out of tree).

>From this viewpoint, I think the current implementation of dynamic tick
falls short of this requirement. It cuts of the timer ticks only when 
all CPUs go idle.

Apart from this observation, I have some others about the current dynamic tick
patch:

- All CPUs seem to cut off the same number of ticks (dyn_tick->skip). Isn't
  this wrong, considering that the timer list is per-CPU? This will cause
  some timers to be serviced much later than usual.

- The fact that dyn_tick_state is global and accessed from all CPUs
  is probably a scalability concern, especially if we allow the ticks
  to be cut off on per-CPU basis.

- Again, when we allow this on a per-CPU basis, subsystems like
  RCU need to know the partial set of idle CPUs. RCU already does
  that thr' nohz_cpu_mask (which will need to replace dyn_cpu_map).

- Looking at dyn_tick_timer_interrupt, would it be nice if we avoid calling 
  do_timer_interrupt so many times and instead update jiffies to
  (skipped_ticks - 1) and then call do_timer_interrupt once? I think
  VST does it that way.

- dyn_tick->max_skip = 0xffffff / apic_timer_val;
	From my reading of Intel docs, APIC_TMICT is 32-bit. So why does the
  above calculation take only 24-bits into account? What am I missing here?


I can take a shot at addressing these concerns in dynamic_tick patch, but it 
seems to me that VST has already addressed all these to a big extent. Had you 
considered VST before? The biggest bottleneck I see in VST going mainline is 
its dependency on HRT patch but IMO it should be possible to write a small patch
to support VST w/o HRT. 

George, what do you think?


-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
