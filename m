Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262532AbVBCKoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262532AbVBCKoR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 05:44:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbVBCKnw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 05:43:52 -0500
Received: from gprs215-57.eurotel.cz ([160.218.215.57]:1920 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262925AbVBCKll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 05:41:41 -0500
Date: Thu, 3 Feb 2005 11:41:26 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LKML <linux-kernel@vger.kernel.org>, Dave Jones <davej@codemonkey.org.uk>
Subject: Re: cpufreq problem wrt suspend/resume on Athlon64
Message-ID: <20050203104126.GC1389@elf.ucw.cz>
References: <200502021428.12134.rjw@sisk.pl> <20050202133153.GD29579@elf.ucw.cz> <200502030108.09508.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502030108.09508.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I have noticed that the condition (cur_freq != cpu_policy->cur), which is
> > > unlikely() according to cpufreq.c:cpufreq_resume(), occurs on every resume
> > > on my box (Athlon64-based Asus).  Every time the box resumes, I get a message
> > > like that:
> > > 
> > > Warning: CPU frequency out of sync: cpufreq and timing core thinks of 1600000, is 1800000 kHz.
> > > 
> > > (the numbers vary: there may be 800000 vs 1600000 or even 800000 vs 1800000).
> > > 
> > > Also, when the box is suspended on AC power and resumed on batteries, it often
> > > reboots.
> > > 
> > > Please let me know if there's anything (relatively simple :-)) that I can do
> > > about it.
> > 
> > Introduce _suspend() routine to cpufreq, and force cpu to 800MHz
> > during suspend().
> 
> Do you mean like that:

Yes, this looks okay. Does it fix your "it reboots during resume" problem?

> --- linux-2.6.11-rc2-orig/drivers/cpufreq/cpufreq.c	2005-01-30 23:30:53.000000000 +0100
> +++ linux-2.6.11-rc2/drivers/cpufreq/cpufreq.c	2005-02-03 00:50:05.000000000 +0100
> @@ -939,10 +939,42 @@
>  	return ret;
>  }
>  
> +static int cpufreq_suspend(struct sys_device * sysdev, u32 state)
> +{
> +	int cpu = sysdev->id;
> +	struct cpufreq_policy *cpu_policy;
> +
> +	dprintk("suspending cpu %u\n", cpu);
> +
> +	if (!cpu_online(cpu))
> +		return 0;
> +
> +	cpu_policy = cpufreq_cpu_get(cpu);
> +	if (!cpu_policy)
> +		return -EINVAL;
> +
> +	/* only handle each CPU group once */
> +	if (unlikely(cpu_policy->cpu != cpu)) {
> +		cpufreq_cpu_put(cpu_policy);
> +		return 0;
> +	}
> +
> +	if (cpufreq_driver->target) {
> +		dprintk("cpufreq: trying to set CPU frequency to the minimal (%u kHz)\n", 
> +				cpu_policy->min);
> +		cpufreq_driver->target(cpu_policy, cpu_policy->min,
> +			CPUFREQ_RELATION_L);
> +	}
> +
> +	cpufreq_cpu_put(cpu_policy);
> +	return 0;
> +}
> +	
>  static struct sysdev_driver cpufreq_sysdev_driver = {
>  	.add		= cpufreq_add_dev,
>  	.remove		= cpufreq_remove_dev,
>  	.resume		= cpufreq_resume,
> +	.suspend	= cpufreq_suspend,
>  };
>  
>  
> 
> > Put it back to right frequency during resume(). 
> 
> Well, I don't know which one is right, because the box might have been
> suspended in different conditions (eg AC power vs batteries).  I think it's
> better to leave it at the minimal frequency for a while.  Moreover, I don't
> know if it's not necessary to force the minimal frequency again in resume()
> (I imagine that some CPUs may change the frequency on the fly if they
> are sufficiently loaded, and eg in swsusp we restore the image between
> suspend() and resume(), so this may very well happen sometimes, it
> seems).

Okay, you are right, restoring it unconditionaly would be bad
idea. Still it would be nice to tell cpufreq governor "please change
the frequency ASAP" so it does not run at 800MHz for half an hour
compiling kernels on AC power.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
