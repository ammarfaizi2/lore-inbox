Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUJLOla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUJLOla (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 10:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264980AbUJLOjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 10:39:55 -0400
Received: from ipx20189.ipxserver.de ([80.190.249.56]:63109 "EHLO
	ipx20189.ipxserver.de") by vger.kernel.org with ESMTP
	id S265773AbUJLOiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 10:38:02 -0400
Date: Tue, 12 Oct 2004 17:38:10 +0300 (EAT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] i386 CPU hotplug updated for -mm
In-Reply-To: <1097590569.6557.107.camel@biclops>
Message-ID: <Pine.LNX.4.61.0410121730110.4190@musoma.fsmlabs.com>
References: <20041001204533.GA18684@elte.hu>  <20041001204642.GA18750@elte.hu>
 <20041001143332.7e3a5aba.akpm@osdl.org>  <Pine.LNX.4.61.0410091550300.2870@musoma.fsmlabs.com>
  <Pine.LNX.4.61.0410102302170.2745@musoma.fsmlabs.com>  <1097560787.6557.99.camel@biclops>
  <20041012060410.GE1479@elte.hu> <1097590569.6557.107.camel@biclops>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2004, Nathan Lynch wrote:

> On Tue, 2004-10-12 at 01:04, Ingo Molnar wrote:
> > * Nathan Lynch <nathanl@austin.ibm.com> wrote:
> > 
> > > I fixed up the warning in cpu_down with the following patch and now am
> > > running with that + 2.6.9-rc4-mm1 + your patch while doing continuous
> > > online/offline and make -j8.  It's been running for about 45 minutes
> > > and I haven't seen the panic yet, although I'm at a loss to explain
> > > why the change would fix it.  Will let it run overnight and report
> > > back...
> > 
> > >  	/* Move it here so it can run. */
> > > -	kthread_bind(p, smp_processor_id());
> > > +	kthread_bind(p, get_cpu());
> > > +	put_cpu();
> > 
> > >  	/* CPU is completely dead: tell everyone.  Too late to complain. */
> > >  	if (notifier_call_chain(&cpu_chain, CPU_DEAD, (void *)(long)cpu)
> > 
> > hm, is there any assurance that smp_processor_id() == cpu?
> 
> Actually, cpu != smp_processor_id().  cpu is the processor we have just
> taken down at that point; we want the kthread to run on some other cpu.

Nathan, thanks for doing that testing, the warning does indeed look to be 
a false positive. Looking at the code again, i realised that there might 
also be cases where someone does the following;

	preempt_disable();
	cpu = smp_processor_id();
	...
	preempt_enable();
	...
	mod_local_cpu_variable[cpu];

So cached values of smp_processor_id() might also be a problem, although i 
haven't found any cases, but maybe that's just being overly paranoid =)
