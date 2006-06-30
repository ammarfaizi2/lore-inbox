Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWF3TWg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWF3TWg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 15:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933097AbWF3TWg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 15:22:36 -0400
Received: from liaag1af.mx.compuserve.com ([149.174.40.32]:51362 "EHLO
	liaag1af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932168AbWF3TWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 15:22:35 -0400
Date: Fri, 30 Jun 2006 15:17:14 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 10/17] 2.6.17.1 perfmon2 patch for review: PMU
  context switch
To: Andi Kleen <ak@suse.de>
Cc: Stephane Eranian <eranian@hpl.hp.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606301519_MC3-1-C3E0-AD22@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200606302042.23661.ak@suse.de>

On Fri, 30 Jun 2006 20:42:23 +0200. Andi Kleen wrote:

> > > I don't quite see the point because on x86 the PMU doesn't run
> > > during C states anyways. So you get idle excluded automatically.
> > 
> > Looks like it does run:
> 
> I'm pretty sure it doesn't. You can see it by watching 
> the frequency of the perfctr mode NMI watchdog in /proc/interrupts 
> under different loads.
>
> When the system is idle the frequency goes down and increases
> when the system is busy.

But that is using cpu_clk_unhalted (isn't it?)  If so, it would slow down
when the system is idle.

The BIOS writer's guide, Ch. 10.2, says only events outside of the
processor, like northbridge DMA accesses, stop counting during halt.
(And by definition cpu_clk_unhalted.)

> Are you sure you didn't boot with poll=idle?

$ pfmon --smpl-module=inst-hist --smpl-show-function --smpl-show-top=40 \
  -ecpu_clk_unhalted -k --long-smpl-period=10000 --resolve-addr --system-wide -t 10
only kernel symbols are resolved in system-wide mode
<session to end in 10 seconds>
# counts   %self    %cum code address
    2501  85.42%  85.42% __do_softirq<kernel>
     222   7.58%  93.00% acpi_processor_idle<kernel>   <========
     100   3.42%  96.41% ehci_watchdog<kernel>
      39   1.33%  97.75% ehci_hub_status_data<kernel>

I'm pretty sure. :)  Looking at that pile of code in acpi_processor_idle
and the way it disables interrupts I think I'll switch to idle=halt, though.

> Otherwise something must be wrong with your measurements.

In that case it's all Stephane's fault: he wrote the code!

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
