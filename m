Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTEVARd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:17:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbTEVARd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:17:33 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:4777 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262369AbTEVARa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:17:30 -0400
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: jamesclv@us.ibm.com, haveblue@us.ibm.com, pbadari@us.ibm.com,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com, mannthey@us.ibm.com
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: userspace irq balancer 
In-reply-to: Your message of Wed, 21 May 2003 14:43:18 PDT.
             <3014AAAC8E0930438FD38EBF6DCEB5640204334F@fmsmsx407.fm.intel.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5155.1053563385.1@us.ibm.com>
Date: Wed, 21 May 2003 17:29:45 -0700
Message-Id: <E19Idxq-0001LD-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, I suppose this userland policy change means we should pull
the scheduler policy decisions out of the kernel and write user level
HT, NUMA, SMP and UP schedulers.  Also, the IO schedulers should
probably be pulled out - I'm sure AS and CFQ and linus_scheduler
could be user land policies, as well as the elevator.  Memory
placement and swapping policies, too.

Oh, wait, some people actually do this - they call it, what,
Workload Management or some such thing.  But I don't know any
style of workload management that leaves *no* default, semi-sane
policy in the kernel.

gerrit

On Wed, 21 May 2003 14:43:18 PDT, "Nakajima, Jun" wrote:
> Again, since the userland is using /proc/irq/N/smp_affinity, the
> in-kernel one won't touch whatever settings done by the userlannd. So
> I don't think we have issues here - if the userland has more knowledge,
> then it simply uses binding. If not, use the generic but dumb one in the
> kernel. Same thing as scheduling. If the dumb one has a critical problem,
> we should fix it.
> 
> At the same time, I don't believe a single almighty userland policy
> exists, either. One might need to write or modify his program to do the
> best for the system anyway. Or a very simple script might just work fine.
> 
> Jun
> > -----Original Message-----
> > From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> > Sent: Wednesday, May 21, 2003 7:27 AM
> > To: David S. Miller; akpm@digeo.com
> > Cc: arjanv@redhat.com; haveblue@us.ibm.com; wli@holomorphy.com;
> > pbadari@us.ibm.com; linux-kernel@vger.kernel.org; gh@us.ibm.com;
> > johnstul@us.ibm.com; mannthey@us.ibm.com
> > Subject: Re: userspace irq balancer
> > 
> > On Tuesday 20 May 2003 05:22 pm, David S. Miller wrote:
> > >    From: Andrew Morton <akpm@digeo.com>
> > >    Date: Tue, 20 May 2003 02:17:12 -0700
> > >
> > >    Concerns have been expressed that the /proc interface may be a bit
> > racy.
> > >    One thing we do need to do is to write a /proc stresstest tool which
> > > pokes numbers into the /proc files at high rates, run that under traffic
> > > for a few hours.
> > >
> > > This issue is %100 independant of whether policy belongs in the
> > > kernel or not.  Also, the /proc race problem exists and should be
> > > fixed regardless.
> > >
> > >    Nobody has tried improving the current balancer.
> > >
> > > Policy does not belong in the kernel.  I don't care what algorithm
> > > people decide to use, but such decisions do NOT belong in the kernel.
> > 
> > You keep saying that, but suppose I want to try HW IRQ balancing using the
> > TPR
> > registers.  How could I do that from userspace?  And if I could, wouldn't
> > the
> > benefit of real time IRQ routing be lost?
> > 
> > It seems to me that only long term interrupt policy can be done from
> > userland.
> > Anything that does fast responses to fluctuating load must be inside the
> > kernel.
> > 
> > At the moment we don't do any fast IRQ policy.  Even the original
> > irq_balance
> > only looked for idle CPUs after an interrupt was serviced.  However,
> > suppose
> > you had a P4 with hyperthreading turned on.  If an IRQ is to be delivered
> > to
> > the main thread but it is busy and its sibling is idle, why shouldn't we
> > deliver the interrupt to the idle sibling?  They both share the same
> > caches,
> > etc, so cache warmth isn't a problem.
> > 
> > --
> > James Cleverdon
> > IBM xSeries Linux Solutions
> > {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
