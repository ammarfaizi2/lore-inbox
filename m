Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261400AbVFCRQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261400AbVFCRQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 13:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbVFCRQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 13:16:12 -0400
Received: from fmr23.intel.com ([143.183.121.15]:61866 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261400AbVFCRQC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 13:16:02 -0400
Date: Fri, 3 Jun 2005 10:15:04 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>
Cc: Zwane Mwaikambo <zwane@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>, ashok.raj@intel.com
Subject: Re: [patch 0/5] x86_64 CPU hotplug patch series.
Message-ID: <20050603101503.A29134@unix-os.sc.intel.com>
References: <20050602125754.993470000@araj-em64t> <Pine.LNX.4.61.0506021421130.3157@montezuma.fsmlabs.com> <m1zmu7v1oq.fsf@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m1zmu7v1oq.fsf@muc.de>; from ak@muc.de on Fri, Jun 03, 2005 at 06:35:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2005 at 06:35:01PM +0200, Andi Kleen wrote:
> Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:
> 
> >
> > I don't think it's worth the extra boot time complexity to use the boot 
> > workaround and i'm not convinced the extra mask against cpu_online_map 
> > slows down that path enough to show up compared to waiting for remote 
> > processor IPI handling to commence/complete.
> 
> What boot slowdown? 

Its really not slowdown, but un-necessary complexity, either in terms
of detecting if not to use broadcast, or even like you mention to continue
to perform broadcast, and handle the cleanup of queued ipi,s before 
turning the cpu online.

> 
> I assume any practical CPU hotplug will have a way to detect it 
> at boot - e.g. ACPI will probably need to tell you about spare
> CPUs that could be started or there is a command line option.

what about case when we need to use logical cpu up/down that is required
for suspend/resume? its really not a platform hotplug, just another feature.

Now you select this by default, and in reallity, all mobile/servers would
end up using this, and all the code to detect hotplug availibty would just
become bit-rotting.

ACPI is pretty static name space, so if you have a 4 socket system and only 
have 2 socket populated, all that you see is 2 present, and 2 not present.

The only indication if hotplug is supported would be presence of _EJD.
Again if this is a NUMA node or wrapped under a bigger module device
its probably required only in the top level object. 

There is nothing there that suggest platform supports hotplug, may be we do
that via mach-*, it seems un-necessary to do all this complexity without
knowing what problem we are solving by doing all this?
> 
> My request was basically to set a flag when "CPU hotplug possible"
> is detected and then only use the slow fast path method when
> CPU hotplug is possible.

Why do you call it slow for using mask version? The tsc stats test case
i sent out doesnt show any indication of being slow by any means. Broadcast
and mask came about equal in numbers.

There is just one extra write to local apic, but that doesnt seem to be 
adding anything that significant to be called slow in the grand scheme of 
events.

> 
> Actually that was only the second best solution, better would
> be to just fix the relatively obscure race in the CPU hotplug bootup
> path, but Ashok for some reason seems to be very adverse to that
> option.

The easier way to fix the problem is fix the source of the problem. So 
if broadcast is introducing an un-necessary race, why not just eliminate that
altogether, when there is really no loss in performance per-se. Instead
of wring whole bunch of code to hande the race doesnt seem appealing.

If we can fix it with less code and there is no *real* loss in performance, 
why not pick a less complicated approach.

The cycle count results doenst seem to indicate any slowness, but freqently
you mention mask varient as slow approach? Doing an extra reg write doesnt
matter, what matters is how long smp_call_function() takes, and that seems
pretty much the same in both instances.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center
