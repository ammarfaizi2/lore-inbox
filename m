Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVACROj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVACROj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 12:14:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVACROi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 12:14:38 -0500
Received: from gprs214-42.eurotel.cz ([160.218.214.42]:28288 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261507AbVACROI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:14:08 -0500
Date: Mon, 3 Jan 2005 18:08:07 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: lindqvist@netstar.se, edi@gmx.de, john@hjsoft.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Message-ID: <20050103170807.GA8163@elf.ucw.cz>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> swsusp does not suspend and resume *all* devices, including system
> devices. This has been the case since at least 2.6.9, if not earlier.
> 
> One effect of this is that resuming fails to properly reconfigure
> interrupt routers. In 2.6.9 this was obscured by other kernel code,
> but in 2.6.10 this often causes post-resume APIC errors and near-total
> failure of some PCI devices (e.g. network, sound and USB controllers).
> 
> On at least one of my systems, without this patch I also have to "ifdown
> eth0;ifup eth0" to get networking to function after resuming, even after
> working around the interrupt routing problem mentioned above. With this
> patch, networking simply works after a resume, and the ifdown/ifup is
> no longer needed.
> 
> This patch is against 2.6.10-mm1, although it applies with an offset to
> 2.6.10-bk4 as well. I have tested it against 2.6.10-mm1 and 2.6.10-bk4,
> with and without "noapic", with and without "acpi=off". However, I have
> not tested it on a highmem system.
> 
> I believe this patch fixes a severe problem in swsusp; I would like to
> see this patch (or at least *some* kind of fix for this problem) tested
> more widely and committed to mainline before the 2.6.11 release.
> 
> Signed-off-by: Barry K. Nathan <barryn@pobox.com>

Ack. [I have similar patch in my tree, but yours is better in error
checking area. Please push it to akpm.]
								Pavel


> --- linux-2.6.10-mm1/kernel/power/swsusp.c	2005-01-03 02:16:15.175265255 -0800
> +++ linux-2.6.10-mm1-bkn3/kernel/power/swsusp.c	2005-01-03 06:27:07.753344731 -0800
> @@ -843,11 +843,22 @@
>  	if ((error = arch_prepare_suspend()))
>  		return error;
>  	local_irq_disable();
> +	/* At this point, device_suspend() has been called, but *not*
> +	 * device_power_down(). We *must* device_power_down() now.
> +	 * Otherwise, drivers for some devices (e.g. interrupt controllers)
> +	 * become desynchronized with the actual state of the hardware
> +	 * at resume time, and evil weirdness ensues.
> +	 */
> +	if ((error = device_power_down(PM_SUSPEND_DISK))) {
> +		local_irq_enable();
> +		return error;
> +	}
>  	save_processor_state();
>  	error = swsusp_arch_suspend();
>  	/* Restore control flow magically appears here */
>  	restore_processor_state();
>  	restore_highmem();
> +	device_power_up();
>  	local_irq_enable();
>  	return error;
>  }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
