Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbVFCO07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbVFCO07 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 10:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbVFCO07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 10:26:59 -0400
Received: from fmr24.intel.com ([143.183.121.16]:64484 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S261262AbVFCO04 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 10:26:56 -0400
Date: Fri, 3 Jun 2005 07:25:57 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Shaohua Li <shaohua.li@intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>, Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       ak <ak@muc.de>, akpm <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, x86-64 <discuss@x86-64.org>,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>
Subject: Re: [patch 2/5] x86_64: CPU hotplug support.
Message-ID: <20050603072556.A27487@unix-os.sc.intel.com>
References: <20050602125754.993470000@araj-em64t> <20050602130111.816070000@araj-em64t> <Pine.LNX.4.61.0506021416490.3157@montezuma.fsmlabs.com> <20050602163307.C16913@unix-os.sc.intel.com> <1117764115.3826.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1117764115.3826.5.camel@linux-hp.sh.intel.com>; from shaohua.li@intel.com on Fri, Jun 03, 2005 at 10:01:55AM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 10:01:55AM +0800, Shaohua Li wrote:
> On Thu, 2005-06-02 at 16:33 -0700, Ashok Raj wrote:
> > On Thu, Jun 02, 2005 at 02:19:55PM -0600, Zwane Mwaikambo wrote:
> > > On Thu, 2 Jun 2005, Ashok Raj wrote:
> > > 
> > > > @@ -445,8 +477,10 @@ void __cpuinit start_secondary(void)
> > > >  	/*
> > > >  	 * Allow the master to continue.
> > > >  	 */
> > > > +	lock_ipi_call_lock();
> > > >  	cpu_set(smp_processor_id(), cpu_online_map);
> > > >  	mb();
> > > > +	unlock_ipi_call_lock();
> > > 
> > > What's that? Is this another smp_call_function race workaround? I thought 
> > > there was an additional patch to avoid the broadcast.
> > 
> > The other patch avoids sending to offline cpu's, but we read cpu_online_map
> > and clear self bit in smp_call_function. If a cpu comes online, dont we 
> > want this cpu to take part in smp_call_function?
> > 
> > if we dont care about this new CPU participating, and if cpu_set() is atomic
> > (for all NR_CPUS) we dont need to hold call_lock, otherwise we need to hold
> > this as well.
> If a CPU isn't online, why should it participates it? If it should
> participate it, it also might do the similar thing before set cpu
> online.

Good point. I was just trying to include the just arrived cpu, in the 
set, but i can convince myself that this would be any real value to include
this newly arrived cpu in that case. I can drop it.

> Some places which really care about it such as smp_send_stop should hold
> cpucontrol semaphore to me.

panic() ends up calling smp_send_stop(), i dont think we could hold a sema
in that path if we end up calling from intr context.

probably from callers of stop_machine/restart we could add lock_cpu_hotplug
not too sure how useful that would be though.
> 
> Thanks,
> Shaohua
> 

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
