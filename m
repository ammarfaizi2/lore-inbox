Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTHZXOc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 19:14:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbTHZXOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 19:14:32 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:8385 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S262987AbTHZXO1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 19:14:27 -0400
Date: Wed, 27 Aug 2003 01:02:32 +0200
From: Dominik Brodowski <linux@brodo.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Dave Jones <davej@redhat.com>, kernel list <linux-kernel@vger.kernel.org>,
       paul.devriendt@amd.com, aj@suse.de, mark.langsdorf@amd.com,
       richard.brunner@amd.com, cpufreq@www.linux.org.uk
Subject: Re: Cpufreq for opteron
Message-ID: <20030826230232.GA31860@brodo.de>
References: <20030822135946.GA2194@elf.ucw.cz> <20030822144340.GE3111@redhat.com> <20030822200549.GC2327@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030822200549.GC2327@elf.ucw.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 22, 2003 at 10:05:49PM +0200, Pavel Machek wrote:
> Hi!
> 
> Here's an updated version. It is quite a bit shorter, and thats
> good. Does it look good enough for inclusion?

> +#define VERSION "version 1.00.06 - August 13, 2003"

If AMD wants it in, let's put it into the /* comment header at the top */ ?

> +#ifdef CONFIG_SMP
> +#error cpufreq support is disabled for config_smp
> +#endif
> +#ifdef CONFIG_PREEMPT
> +#warning noone tested this on preempt system, beware
> +#endif

Actually I doubt an #error and a #warning are necessary here. I'd like to
hear more about the CONFIG_SMP && CONFIG_CPU_FREQ issues; please discuss
this on cpufreq@www.linux.org.uk . The #warning is more of an assumption and
can go away, IMHO.

> +/*
> +The PSB table supplied by BIOS allows for the definition of the number of
> +p-states that can be used when running on a/c, and the number of p-states
> +that can be used when running on battery. This allows laptop manufacturers
> +to force the system to save power when running from battery. The relationship 
> +is :
> +   1 <= number_of_battery_p_states <= maximum_number_of_p_states
> +
> +This driver does NOT have the support in it to detect transitions from
> +a/c power to battery power, and thus trigger the transition to a lower
> +p-state if required. This is because I need ACPI and the 2.6 kernel to do 
> +this, and this is a 2.4 kernel driver. Check back for a new improved driver
> +for the 2.6 kernel soon.
> +
> +This code therefore assumes it is on battery at all times, and thus
> +restricts performance to number_of_battery_p_states. For desktops, 
> +  number_of_battery_p_states == maximum_number_of_pstates, 
> +so this is not actually a restriction.
> +*/
> +
> +static u32 batterypstates;	/* limit on the number of p states when on battery */
> +			   /* - set by BIOS in the PSB/PST                    */
> +
> +static int onbattery = 1;	/* Set if running on battery, reset otherwise. */
> +			   /* Of no relevance unless batterypstates <     */
> +			   /* numpstates, as defined in the PSB/PST.      */


I dislike this interaction between ACPI and cpufreq -- it should be done
more generally. Let's discuss that seperately, though. And if the code is
dead code at the moment.


> +	if (num_online_cpus() != 1) {
> +		printk(KERN_ERR PFX "multiprocessor systems not currently supported\n");
> +		return 0;
> +	}
> +
> +	if (c->x86_vendor != X86_VENDOR_AMD) {
> +		printk(KERN_INFO PFX "Not an AMD processor\n");

Please don't be so verbose if it's such a clear failing reason. dprintk
would be enough.

> +		printk(KERN_ERR PFX "AMD Athlon 64 or AMD Opteron processor required\n");
same here.

> +static int
> +drv_verify(struct cpufreq_policy *pol)
> +{
<snip>
> +	dprintk(KERN_DEBUG PFX
> +		"ver: cpu%d, min %d, max %d, cur %d, pol %d (%s)\n", pol->cpu,
> +		pol->min, pol->max, pol->cur, pol->policy,
> +		pol->policy ==
> +		CPUFREQ_POLICY_POWERSAVE ? "psave" : pol->policy ==
> +		CPUFREQ_POLICY_PERFORMANCE ? "perf" : "unk");
> +
> +	if (pol->cpu != 0) {
> +		printk(KERN_ERR PFX "verify - cpu not 0\n");
> +		return -ENODEV;
> +	}
> +
> +	res = find_match(&targ, &min, &max,
> +			 pol->policy ==
> +			 CPUFREQ_POLICY_POWERSAVE ? SEARCH_DOWN : SEARCH_UP, 0,
> +			 0);

Why do you check for CPUFREQ_POLICY here??? In a ->target class cpufreq
driver[*] you must not worry about the policy, only about min and max
frequency.

[*] ->target class cpufreq drivers [cpufreq_driver->target is used] have
specific operating frequencies.
    ->setpolicy class cpufreq drivers have operating frequency ranges
[currently only available on Transmeta Crusoe processors]


Also, it'd be great if this driver were converted to use the CPUfreq
freuqency table helpers -- check drivers/cpufreq/freq_table.c in
linux-2.6.0-test4. Using it makes the code much cleaner, easier to 
understand, and less prone to errors.

	Dominik
