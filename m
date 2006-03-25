Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWCYMF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWCYMF7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 07:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWCYMF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 07:05:59 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:17427 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751374AbWCYMF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 07:05:58 -0500
Date: Sat, 25 Mar 2006 12:05:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: SMP busted on non-cpu-hotplug systems
Message-ID: <20060325120546.GA6100@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	"David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
References: <20060325.024226.53296559.davem@davemloft.net> <20060325034744.35b70f43.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060325034744.35b70f43.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2006 at 03:47:44AM -0800, Andrew Morton wrote:
> "David S. Miller" <davem@davemloft.net> wrote:
> >
> > 
> > I just noticed this on sparc64, as I lost 31 cpus on my
> > Niagara box due to it :)
> > 
> > boot_cpu_init() sets the boot processor ID in cpu_present_map.
> > 
> > But fixup_cpu_present_map() will only populate the cpu_present_map if
> > it is empty, which it won't be because of what boot_cpu_init() just
> > did.
> 
> oops.  I guess most architectures set cpu_present_map while bringing up the
> APs.
> 
> I think it'd be cleanest to require that the arch do that -
> fixup_cpu_present_map() looks like a bit of a hack.
> 
> I guess if we want to perpetuate fixup_cpu_present_map() then we should
> teach it to ignore the boot cpu.   (cpus_weight(&cpu_present_map) == 1)
> would do that.

At setup_arch() time, we initialise cpu_possible_map to contain the CPUs
the system might have.

We then call smp_prepare_boot_cpu() which marks the boot cpu in both
cpu_present_map and cpu_online_map.

Eventually, we call smp_prepare_cpus(), where an architecture may
populate cpu_present_map to indicate which cpus are actually present,
and following this we call fixup_cpu_present_map().

With your proposed change, if a SMP system with has 4 possible CPUs
was passed maxcpus=1, cpu_possible_map may well have 4 CPUs, and
cpu_present_map will only contain the one.  However, due to the
fixup_cpu_present_map(), it will say "oh only one CPU, we need to
populate the others" and so you'd actually try to boot all 4.

So no, this doesn't work.  Isn't it about time the pre-CPU hotplug SMP
stuff was updated, rather than trying to messily support two different
SMP initialisation methodologies in generic code with band aid plasters
all over?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
