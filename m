Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261616AbVBHSVy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261616AbVBHSVy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 13:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbVBHSVx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 13:21:53 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:57475 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261616AbVBHSVJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 13:21:09 -0500
Date: Tue, 8 Feb 2005 08:51:00 -0800
From: Tony Lindgren <tony@atomide.com>
To: Joerg Sommrey <jo@sommrey.de>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Need advice on amd76x_pm [patch included]
Message-ID: <20050208165059.GB13224@atomide.com>
References: <20050208120437.GA6979@sommrey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208120437.GA6979@sommrey.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Joerg Sommrey <jo@sommrey.de> [050208 04:07]:
> Hi all,
> 
> can anybody comment on some amd76x_pm issues?  I've played around with
> this module for months and I'm quite satisfied with it now, but a couple
> of questions remain.
> 
> The changes I made:
> - rediffed to 2.6.10
> - new module macro syntax
> - renamed module parameter l to lazy_idle
> - added C3 counter in sysfs (if enabled)
> - tried to make it preemp-safe
> - added a "dummy operation" after wake up

Nice to hear you've done some more work on it! I haven't spent much
time on this because of the ACPI/BIOS problems on my s2460 make the
box go to sleep when I load the module...

> There were problems with the module wrt system clock stability.  To
> solve these I took a look at the ACPI C2/C3 stuff.  They enter C2/C3
> with local_irq_disable(), so this seems sane.  Some tests with
> preempt_disable() showed worse clock stability, so I kept using
> local_irq_disable().  From Documentation/preempt-locking.txt I got the
> impression that preempt_check_resched() is needed after
> local_irq_enable().  Is this true?  It is not done in the ACPI code.
> 
> The ACPI code does a "dummy operation" after returning from C2/C3.  I
> don't know what this is good for, but I coded something similar in
> amd76x_pm.  Clock stability seems to be a bit better with this dummy
> inb().
> I'm still unsure if the code is correct for a preemptible kernel.
> 

OK. Maybe you can check out the idle loop in my recent dyn-tick
patch? [1] You should be able to modify the idle loop from dyn-tick
patch for amx76x_pm.c. The locking should be better. Then see also 
cpu_idle_wait() for unloading the module for kernels > 2.6.10.

> Regarding C3: A JH comment in the source states, that the C3 code never
> was reached.  Reducing lazy_idle to < 6 results in entering C3 on my box.
> However, on one side there was no additional temperature reduction with
> C3 and on the other side I need lazy_idle > 100 to have a clock with
> acceptable stability. (Currently I use lazy_idle=128.)  That's why I
> didn't enable C3 in the code.

OK.

> Another issue: On Ingo's RT-kernels this module caused a real bad system
> clock stability. ntpd was even unable to syncronize the system clock
> with an attached radio clock.

Is this also with the ACPI PM timer?

> The patch was tested on AMD768 only and surely needs some testing on other
> hardware.

I'll try it out here on my S2460 also. (Assuming I can get my system
woken up after I load the module :)

> Are there any chances for this patch to be merged into mainline in the
> future and what needs to be done to achieve this?

Considering that's it's been in 2.4 for few years now, It should be
safe to merge after some changes I suggested above.

Regards,

Tony

[1] http://lkml.org/lkml/2005/2/5/216
