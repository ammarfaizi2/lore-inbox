Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVDSHmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVDSHmN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 03:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261382AbVDSHmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 03:42:12 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39384 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261380AbVDSHmC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 03:42:02 -0400
Date: Tue, 19 Apr 2005 13:30:22 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Paul Jackson <pj@sgi.com>, Simon Derr <Simon.Derr@bull.net>,
       lkml <linux-kernel@vger.kernel.org>,
       lsetech <lse-tech@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>,
       Dipankar Sarma <dipankar@in.ibm.com>,
       Matthew Dobson <colpatch@us.ibm.com>
Subject: Re: [RFC PATCH] Dynamic sched domains aka Isolated cpusets
Message-ID: <20050419080021.GA3963@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <1097110266.4907.187.camel@arrakis> <20050418202644.GA5772@in.ibm.com> <42644646.3030104@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42644646.3030104@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 09:44:06AM +1000, Nick Piggin wrote:
> Very good, I was wondering when someone would try to implement this ;)

Thank you for the feedback !

> >-static void __devinit arch_init_sched_domains(void)
> >+static void attach_domains(cpumask_t cpu_map)
> > {
> 
> This shouldn't be needed. There should probably just be one place that
> attaches all domains. It is a bit difficult to explain what I mean when
> you have 2 such places below.
> 

Can you explain a bit more, not sure I understand what you mean

> Interface isn't bad. It would seem to be able to handle everything, but
> I think it can be made a bit simpler.
> 
> 	fn_name(cpumask_t span1, cpumask_t span2)
> 
> Yeah? The change_map is implicitly the union of the 2 spans. Also I don't
> really like the name. It doesn't rebuild so much as split (or join). I
> can't think of anything good off the top of my head.

Yeah agreed. It kinda lived on from earlier versions I had

> 
> >+	unsigned long flags;
> >+	int i;
> >+
> >+	local_irq_save(flags);
> >+
> >+	for_each_cpu_mask(i, change_map)
> >+		spin_lock(&cpu_rq(i)->lock);
> >+
> 
> Locking is wrong. And it has changed again in the latest -mm kernel.
> Please diff against that.
> 

I havent looked at the RCU sched domain changes as yet, but I put this in
to address some problems I noticed during stress testing.
Basically with the current hotplug code, it is possible to have a scenario
like this

         rebuild domains                  load balance
                |                               |
                |                     take existing sd pointer
                |                               |
     attach to dummy domain                     |
                |                     loop thro sched groups
     change sched group info                    |
                                      access invalid pointer and panic


> >+	if (!cpus_empty(span1))
> >+		build_sched_domains(span1);
> >+	if (!cpus_empty(span2))
> >+		build_sched_domains(span2);
> >+
> 
> You also can't do this - you have to 'offline' the domains first before
> building new ones. See the CPU hotplug code that handles this.
> 

By offline if you mean attach to dummy domain, see above

> This makes a hotplug event destroy your nicely set up isolated domains,
> doesn't it?
> 
> This looks like the most difficult problem to overcome. It needs some
> external information to redo the cpuset splits at cpu hotplug time.
> Probably a hotplug handler in the cpusets code might be the best way
> to do that.

Yes I am aware of this. What I have in mind is for the hotplug code
from scheduler to call into cpusets code. This will just return say 1
when cpusets is not compiled in and the sched code can continue to do
what it is doing right now, else the cpusets code will find the leaf 
cpuset that contains the hotplugged cpu and rebuild the domains accordingly
However the question still remains as to how cpusets should handle 
this hotplugged cpu

	-Dinakar
