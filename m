Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262960AbUA0JA0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 04:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbUA0JA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 04:00:26 -0500
Received: from gprs194-55.eurotel.cz ([160.218.194.55]:24192 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262960AbUA0JAR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 04:00:17 -0500
Date: Tue, 27 Jan 2004 09:39:36 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Huw Rogers <count0@localnet.com>
Cc: linux-kernel@vger.kernel.org, linux-laptop@mobilix.org
Subject: Re: 2.6.2-rc1 / ACPI sleep / irqbalance / kirqd / pentium 4 HT problems on Uniwill N258SA0
Message-ID: <20040127083936.GA18246@elf.ucw.cz>
References: <20040124233749.5637.COUNT0@localnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040124233749.5637.COUNT0@localnet.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> irqbalance just locks up the machine totally, hard power-off needed, no
> traces in the logs. Probably some issue (race?) with it writing to
> /proc/irq/X/smp_affinity. And how is irqbalance supposed to play with
> kirqd anyway? Grepping this list and others doesn't give any kind of an
> answer. But disabling it gives all interrupts to cpu0 (looking at
> /proc/interrupts). kirqd apparently only balances between CPU packages,
> not between HT siblings (info gleaned from this list).
> 
> Anyway, sleep/suspend/standby functionality (important to most laptop
> users, need to close the lid and go): This checkin to
> kernel/power/main.c seems to disable suspend with SMP (!?):
> 
> --- 1.3/kernel/power/main.c	Sat Jan 24 20:44:47 2004
> +++ 1.4/kernel/power/main.c	Sat Jan 24 20:44:47 2004
> @@ -172,6 +172,12 @@
>  	if (down_trylock(&pm_sem))
>  		return -EBUSY;
>  
> +	/* Suspend is hard to get right on SMP. */
> +	if (num_online_cpus() != 1) {
> +		error = -EPERM;
> +		goto Unlock;
> +	}
> +
>  	if ((error = suspend_prepare(state)))
>  		goto Unlock;
> 
> ... which, given the prevalence of hyperthreaded CPUs on laptops, is
> fighting a trend. I backed out the above with a #if 0 then tried echo -n
> 1>/proc/acpi/sleep again. This time I got:

Well, no sleep developers have SMP or HT machines, AFAICT.

If you back that out... well you are on your own.

> A lot of effort is going into swsusp/pmdisk - but a lot of laptop users
> prefer S1 to S4, as it's faster and more reliable. It'd be nice to see a
> simpler "spin down the hard drive, reduce CPU clock speed to a minimum,
> and power down display/ether/wireless/usb/PCMCIA" working ahead of
> hibernation.

As far as I can see, noone is interested in S1. If you want to help
with it... [There's no need to stop tasks/stop devices on non-broken
hardware. Unfortunately there's a lot of broken hw out there, so I'm
not sure we can do it by default.]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
