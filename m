Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261450AbVFBXiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261450AbVFBXiT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 19:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbVFBXiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 19:38:19 -0400
Received: from fmr23.intel.com ([143.183.121.15]:52404 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261450AbVFBXeR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 19:34:17 -0400
Date: Thu, 2 Jun 2005 16:33:08 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Ashok Raj <ashok.raj@intel.com>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org, Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 2/5] x86_64: CPU hotplug support.
Message-ID: <20050602163307.C16913@unix-os.sc.intel.com>
References: <20050602125754.993470000@araj-em64t> <20050602130111.816070000@araj-em64t> <Pine.LNX.4.61.0506021416490.3157@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.61.0506021416490.3157@montezuma.fsmlabs.com>; from zwane@arm.linux.org.uk on Thu, Jun 02, 2005 at 02:19:55PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 02, 2005 at 02:19:55PM -0600, Zwane Mwaikambo wrote:
> On Thu, 2 Jun 2005, Ashok Raj wrote:
> 
> > @@ -445,8 +477,10 @@ void __cpuinit start_secondary(void)
> >  	/*
> >  	 * Allow the master to continue.
> >  	 */
> > +	lock_ipi_call_lock();
> >  	cpu_set(smp_processor_id(), cpu_online_map);
> >  	mb();
> > +	unlock_ipi_call_lock();
> 
> What's that? Is this another smp_call_function race workaround? I thought 
> there was an additional patch to avoid the broadcast.

The other patch avoids sending to offline cpu's, but we read cpu_online_map
and clear self bit in smp_call_function. If a cpu comes online, dont we 
want this cpu to take part in smp_call_function?

if we dont care about this new CPU participating, and if cpu_set() is atomic
(for all NR_CPUS) we dont need to hold call_lock, otherwise we need to hold
this as well.

> 
> > +#include <asm/nmi.h>
> > +/* We don't actually take CPU down, just spin without interrupts. */
> > +static inline void play_dead(void)
> > +{
> > +	idle_task_exit();
> > +	mb();
> > +	/* Ack it */
> > +	__get_cpu_var(cpu_state) = CPU_DEAD;
> > +
> > +	local_irq_disable();
> > +	while (1)
> > +		safe_halt();
> > +}
> 
> Might as well drop the local_irq_disable since safe_halt enables 
> interrupts.
> 

Will do. I think we could cleanup more of the cpu state before we do safe_halt.

But i think i need to look how much more state can be cleaned out. 

In Ia64, we have a clear SAL handoff state, and essentially the cpu is handed
off as OS got it back to BIOS land. Althoght that might be a hard goal 
i need to look at what states _must_ be cleaned out as next step.


-- 
Cheers,
Ashok Raj
- Open Source Technology Center
