Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946363AbWJSSuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946363AbWJSSuF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 14:50:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946362AbWJSSuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 14:50:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:1193 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1946363AbWJSSuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 14:50:01 -0400
Subject: Re: 2.6.18 and tsc clocksource on SMP
From: john stultz <johnstul@us.ibm.com>
To: Krzysztof Oledzki <olel@ans.pl>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0610182125580.29565@bizon.gios.gov.pl>
References: <Pine.LNX.4.64.0610182125580.29565@bizon.gios.gov.pl>
Content-Type: text/plain
Date: Thu, 19 Oct 2006 11:48:16 -0700
Message-Id: <1161283696.6961.137.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-18 at 21:32 +0200, Krzysztof Oledzki wrote:
> Hello,
> 
> I have just upgraded kernel (2.6.16.x->2.6.18.1) on on of my servers (Dell 
> PowerEdge1425SC with 2 CPUs with HT - total 4 CPUs) and noticed that 
> system no longer uses HPET as a clocksource.
> 
> # cat /sys/devices/system/clocksource/clocksource0/available_clocksource
> acpi_pm jiffies hpet tsc pit
> 
> # cat /sys/devices/system/clocksource/clocksource0/current_clocksource
> tsc

Yep. You'll notice the hpet is still available, but by default we select
the TSC (unless it is marked as unstable).


> AFAIK TSC should not be used on SMP systems, shouldn't it?

This was done to unify the behavior between i386 and x86_64. Previously
i386 was overly cautious, selecting the TSC only if ACPI PM, or HPET
were not available. However this impacted performance as the TSC is much
faster. In fact, many distros reversed the order to prefer the TSC.

It has been asserted that many Intel SMP systems can safely use the TSC,
while AMD smp boxes for the most part cannot. On any system, if the
system enters C3, or we notice cpufreq changes in the TSC, it will be
disqualified and it will fall back to the hpet or the next best
available clocksource. Hopefully this will always select the best
clocksource.

Please do let us know if you see any problems due to this change.

thanks
-john


