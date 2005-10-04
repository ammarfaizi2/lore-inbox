Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750921AbVJDJQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750921AbVJDJQc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 05:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbVJDJQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 05:16:32 -0400
Received: from gate.crashing.org ([63.228.1.57]:24749 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750921AbVJDJQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 05:16:32 -0400
Subject: Re: [PATCH] ppc64: Add cpufreq support for SMU based G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Piel <Eric.Piel@lifl.fr>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <43424202.7070600@lifl.fr>
References: <1128403842.31063.24.camel@gaston>  <43424202.7070600@lifl.fr>
Content-Type: text/plain
Date: Tue, 04 Oct 2005 19:12:24 +1000
Message-Id: <1128417145.6291.25.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know only very little about cpufreq, probably you could post your 
> patch to the cpufreq mailing list for better review : 
> cpufreq@lists.linux.org.uk (you may have to subscride before posting, 
> don't remember).

I should probably have CC'd it... oh well, this isn't terribly important
at this point but I'll do if I post a new release. It's powermac
specific anyway.

> For what have seen, your patch looks pretty good in general. However, is 
> this kind of CPU only in one CPU machines? 

So far, only single CPU machines shipped with an SMU.

> Your patch doesn't seem 
> support SMP, then it's probably safer to prevent compilation on an SMP 
> kernel in the Makefile? Or you can add SMP support (shouldn't be so hard 
> in theory, but with no hardware to test it might be pointless), you can 
> have a look at other drivers that support it, like in 
> arch/i386/kernel/cpu/cpufreq/p4-clockmod.c .

There are several problems (and that leads to problems in the cpufreq
core too btw). The problem with the cpufreq core is that it disables
adjusting of loops_per_jiffies when CONFIG_SMP is set. That can lead to
pretty disastrous results when running an SMP kernel on a laptop...
Fortunately, the driver provided by this patch doesn't need it as ppc64
has constants loops_per_jiffies (it uses the HW timebase which doesn't
change frequency).

The other problem is that the 970FX "PowerTune" mecanism will actually
broadcast messages to the bus that sync all CPUs to the same speed. That
is, all CPUs in the machine will always change frequency simultaneously,
thus the whole SMP stuff doesn't make that much sense, and I'm not sure
how to "inform" the cpufreq core of that fact (that changing one CPU
actually triggered a change of all of them).

But as I wrote earlier, there is currently no PowerMac SMP machine that
has an SMU chip and a 970FX to which this driver would apply.

Finally, as for preventing build with CONFIG_SMP, I think distros would
kill me as I don't know any of them who intends to ship a G5 kernel with
CONFIG_SMP disabled :)

> Just a little more thing, concerning:
> +	policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
> Could you have a look if you could find the real info about how long it 
> takes to change the speed (put the worse case latency)?

I didn't find. Apple didn't bother putting it in the OF device-tree
afaik, and while it might be in one of the undocumented SMU data
partitions, I have no way to know. The problem isn't the frequency
switch per-se which is extremely fast (and I could know), but the
voltage switch that goes with it. I suppose I could measure and put an
overestimated value in there, but that isn't critical for now. userland
powernowd & friends work fine and I need the reduced frequency mostly
for the thermal control driver so it can clamp it down when the CPU
overtemps.

>  Maybe the info 
> can be found in some parts of the ROM you read? I don't know if 
> conservative or ondemand governors are supposed to be able to mix with 
> your code (especially wrt Windfarm) but not putting this info will 
> prevent them from ever working...

Which is what I want for now, until I find out more about how well I can
make them to work with those machines :)

Let's call that a "conservative" approach ;)

Ben.


