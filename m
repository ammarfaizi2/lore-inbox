Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWCYMTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWCYMTs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750739AbWCYMTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:19:48 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50139 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751213AbWCYMTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:19:47 -0500
Date: Sat, 25 Mar 2006 04:15:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org
Subject: Re: SMP busted on non-cpu-hotplug systems
Message-Id: <20060325041559.63011426.akpm@osdl.org>
In-Reply-To: <20060325120546.GA6100@flint.arm.linux.org.uk>
References: <20060325.024226.53296559.davem@davemloft.net>
	<20060325034744.35b70f43.akpm@osdl.org>
	<20060325120546.GA6100@flint.arm.linux.org.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
>
> On Sat, Mar 25, 2006 at 03:47:44AM -0800, Andrew Morton wrote:
> > "David S. Miller" <davem@davemloft.net> wrote:
> > >
> > > 
> > > I just noticed this on sparc64, as I lost 31 cpus on my
> > > Niagara box due to it :)
> > > 
> > > boot_cpu_init() sets the boot processor ID in cpu_present_map.
> > > 
> > > But fixup_cpu_present_map() will only populate the cpu_present_map if
> > > it is empty, which it won't be because of what boot_cpu_init() just
> > > did.
> > 
> > oops.  I guess most architectures set cpu_present_map while bringing up the
> > APs.
> > 
> > I think it'd be cleanest to require that the arch do that -
> > fixup_cpu_present_map() looks like a bit of a hack.
> > 
> > I guess if we want to perpetuate fixup_cpu_present_map() then we should
> > teach it to ignore the boot cpu.   (cpus_weight(&cpu_present_map) == 1)
> > would do that.
> 
> At setup_arch() time, we initialise cpu_possible_map to contain the CPUs
> the system might have.

OK.

> We then call smp_prepare_boot_cpu() which marks the boot cpu in both
> cpu_present_map and cpu_online_map.

OK.

> Eventually, we call smp_prepare_cpus(), where an architecture may
> populate cpu_present_map to indicate which cpus are actually present,
> and following this we call fixup_cpu_present_map().

OK.

> With your proposed change,

Which proposed change?  I proposed two.

> if a SMP system with has 4 possible CPUs
> was passed maxcpus=1, cpu_possible_map may well have 4 CPUs, and
> cpu_present_map will only contain the one.  However, due to the
> fixup_cpu_present_map(), it will say "oh only one CPU, we need to
> populate the others" and so you'd actually try to boot all 4.

The change we appear to be going with is to remove fixup_cpu_present_map()
which appears to address this.

> So no, this doesn't work.

What doesn't work?

>  Isn't it about time the pre-CPU hotplug SMP
> stuff was updated, rather than trying to messily support two different
> SMP initialisation methodologies in generic code with band aid plasters
> all over?

What two methodologies?  arch-doing-it and fixup_cpu_present_map() doing it?
