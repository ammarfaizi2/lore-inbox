Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262580AbSLZSww>; Thu, 26 Dec 2002 13:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbSLZSwf>; Thu, 26 Dec 2002 13:52:35 -0500
Received: from [195.39.17.254] ([195.39.17.254]:2820 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262580AbSLZSvL>;
	Thu, 26 Dec 2002 13:51:11 -0500
Date: Sun, 22 Dec 2002 22:25:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH 2.5] cpufreq: minor cleanups
Message-ID: <20021222212559.GA24443@elf.ucw.cz>
References: <20021221202509.GA2503@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021221202509.GA2503@brodo.de>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Get rid of CPUFREQ_ALL_CPUS codepaths not used anymore.

Get rid of? Seems you are adding it.

> 	Dominik
> 
> diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
> --- linux-original/kernel/cpufreq.c	2002-12-21 21:21:57.000000000 +0100
> +++ linux/kernel/cpufreq.c	2002-12-21 21:21:46.000000000 +0100
> @@ -365,7 +365,7 @@
>  {
>  	struct cpufreq_policy policy;
>  	down(&cpufreq_driver_sem);
> -	if (!cpufreq_driver || !cpu_max_freq) {
> +	if (!cpufreq_driver || !cpu_max_freq || (cpu > NR_CPUS)) {
>  		up(&cpufreq_driver_sem);
>  		return -EINVAL;
>  	}
> @@ -377,7 +377,20 @@
>  	
>  	up(&cpufreq_driver_sem);
>  
> -	return cpufreq_set_policy(&policy);
> +	if (policy.cpu == CPUFREQ_ALL_CPUS)
> +	{
> +		unsigned int i;
> +		unsigned int ret = 0;
> +		for (i=0; i<NR_CPUS; i++) 
> +		{
> +			policy.cpu = i;
> +			if (cpu_online(i))
> +				ret |= cpufreq_set_policy(&policy);
> +		}
> +		return ret;
> +	} 
> +	else
> +		return cpufreq_set_policy(&policy);
>  }
>  EXPORT_SYMBOL_GPL(cpufreq_set);
>  
> @@ -842,7 +855,6 @@
>   */
>  int cpufreq_set_policy(struct cpufreq_policy *policy)
>  {
> -	unsigned int i;
>  	int ret;
>  
>  	down(&cpufreq_driver_sem);
> @@ -889,24 +901,12 @@
>  
>  	up(&cpufreq_notifier_sem);
>  
> -	if (policy->cpu == CPUFREQ_ALL_CPUS) {
> -		for (i=0;i<NR_CPUS;i++) {
> -			cpufreq_driver->policy[i].min    = policy->min;
> -			cpufreq_driver->policy[i].max    = policy->max;
> -			cpufreq_driver->policy[i].policy = policy->policy;
> -		} 
> -	} else {
> -		cpufreq_driver->policy[policy->cpu].min    = policy->min;
> -		cpufreq_driver->policy[policy->cpu].max    = policy->max;
> -		cpufreq_driver->policy[policy->cpu].policy = policy->policy;
> -	}
> +	cpufreq_driver->policy[policy->cpu].min    = policy->min;
> +	cpufreq_driver->policy[policy->cpu].max    = policy->max;
> +	cpufreq_driver->policy[policy->cpu].policy = policy->policy;
>  
>  #ifdef CONFIG_CPU_FREQ_24_API
> -	if (policy->cpu == CPUFREQ_ALL_CPUS) {
> -		for (i=0;i<NR_CPUS;i++)
> -			cpu_cur_freq[i] = policy->max;
> -	} else
> -		cpu_cur_freq[policy->cpu] = policy->max;
> +	cpu_cur_freq[policy->cpu] = policy->max;
>  #endif
>  
>  	ret = cpufreq_driver->setpolicy(policy);
> @@ -920,15 +920,6 @@
>  
>  
>  /*********************************************************************
> - *                    DYNAMIC CPUFREQ SWITCHING                      *
> - *********************************************************************/
> -#ifdef CONFIG_CPU_FREQ_DYNAMIC
> -/* TBD */
> -#endif /* CONFIG_CPU_FREQ_DYNAMIC */
> -
> -
> -
> -/*********************************************************************
>   *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
>   *********************************************************************/
>  
> @@ -973,12 +964,7 @@
>  		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
>  		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_POSTCHANGE, freqs);
>  #ifdef CONFIG_CPU_FREQ_24_API
> -		if (freqs->cpu == CPUFREQ_ALL_CPUS) {
> -			int i;
> -			for (i=0;i<NR_CPUS;i++)
> -				cpu_cur_freq[i] = freqs->new;
> -		} else
> -			cpu_cur_freq[freqs->cpu] = freqs->new;
> +		cpu_cur_freq[freqs->cpu] = freqs->new;
>  #endif
>  		break;
>  	}
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
