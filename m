Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbWJGDTs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbWJGDTs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 23:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbWJGDTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 23:19:47 -0400
Received: from isilmar.linta.de ([213.239.214.66]:62136 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932471AbWJGDTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 23:19:45 -0400
Date: Fri, 6 Oct 2006 23:19:28 -0400
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Cc: pm list <linux-pm@lists.osdl.org>, Matthew Locke <matt@nomadgs.com>,
       Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] CPUFreq PowerOP integratoin, CPUFreq core 1/3
Message-ID: <20061007031928.GB1494@dominikbrodowski.de>
Mail-Followup-To: Dominik Brodowski <linux@dominikbrodowski.net>,
	"Eugeny S. Mints" <eugeny.mints@gmail.com>,
	pm list <linux-pm@lists.osdl.org>, Matthew Locke <matt@nomadgs.com>,
	Amit Kucheria <amit.kucheria@nokia.com>,
	Igor Stoppa <igor.stoppa@nokia.com>,
	kernel list <linux-kernel@vger.kernel.org>
References: <45096A7B.2070007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45096A7B.2070007@gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
> +obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o freq_helpers.o

So every driver is now required to use freq_helpers, even if it does not
even allow for the setting of a specific frequency, but only a frequency
range (longrun)? And drivers are limitied to a specific amount of CPU
frequency states to export?

> -	freqs->flags = cpufreq_driver->flags;
>  	dprintk("notification %u of frequency transition to %u kHz\n",
>  		state, freqs->new);
>  
> +	/* FIXME: don't we need a lock here? */

We're already holding a lock here, unless you changed the calling
conventions.

> -		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
> -			if ((policy) && (policy->cpu == freqs->cpu) &&
> -			    (policy->cur) && (policy->cur != freqs->old)) {
> -				dprintk("Warning: CPU frequency is"
> -					" %u, cpufreq assumed %u kHz.\n",
> -					freqs->old, policy->cur);
> -				freqs->old = policy->cur;
> -			}
> +		if ((policy) && (policy->cpu == freqs->cpu) &&
> +		    (policy->cur) && (policy->cur != freqs->old)) {
> +			dprintk("Warning: CPU frequency is"
> +				" %u, cpufreq assumed %u kHz.\n",
> +				freqs->old, policy->cur);
> +			freqs->old = policy->cur;
>  		}
Why are you removing the check for CONST_LOOPS here?

> +/**
> + * show_scaling_governor - show the current policy for the specified CPU
> + */
> +static ssize_t 
> +show_available_freqs(struct cpufreq_policy *policy, char *buf)

Description does not match function name; also please return type and
function on one line (yes, I know, the current cpufreq core gets this wrong
too, but still...)

>  /**
> - * show_scaling_driver - show the cpufreq driver currently loaded
> - */
> -static ssize_t show_scaling_driver (struct cpufreq_policy * policy, char *buf)
> -{
> -	return scnprintf(buf, CPUFREQ_NAME_LEN, "%s\n", cpufreq_driver->name);
> -}
> -

That breaks userspace.

> +extern cpumask_t arch_get_dependent_cpus_mask(int cpu);


>  
>  /**
>   * cpufreq_add_dev - add a CPU device
> @@ -617,10 +635,10 @@ static int cpufreq_add_dev (struct sys_d
>  	int ret = 0;
>  	struct cpufreq_policy new_policy;
>  	struct cpufreq_policy *policy;
> -	struct freq_attr **drv_attr;
>  	struct sys_device *cpu_sys_dev;
>  	unsigned long flags;
>  	unsigned int j;
> +	char freq_n[CPUFREQ_FREQ_STR_SIZE];

Will cause troubles for gx-suspmod which would want to export >10.000
states.

>  #ifdef CONFIG_SMP
>  	struct cpufreq_policy *managed_policy;
>  #endif
> @@ -630,7 +648,7 @@ #endif
>  
>  	cpufreq_debug_disable_ratelimit();
>  	dprintk("adding CPU %u\n", cpu);
> -
> +	

Inserting trailing whitespace

>  #ifdef CONFIG_SMP
>  	/* check whether a different CPU already registered this
>  	 * CPU because it is in the same boat. */
> @@ -638,15 +656,9 @@ #ifdef CONFIG_SMP
>  	if (unlikely(policy)) {
>  		cpufreq_cpu_put(policy);
>  		cpufreq_debug_enable_ratelimit();
> -		return 0;
> +		return ret;
>  	}
>  #endif

Why are you returning an error here?

> @@ -654,23 +666,38 @@ #endif
>  	}
>  
>  	policy->cpu = cpu;
> -	policy->cpus = cpumask_of_cpu(cpu);
> +
> +	/* 
> +	 * FIXME: this will go away once notifications moved to lower layers 
> +	 * presumably to clock/voltage framework level
> +	 */
> +	policy->cpus = arch_get_dependent_cpus_mask(cpu);

Can't find arch_get_dependent_cpus_mask defined anywhere or in this patch.
As each patch should at least compile and boot, that won't work.

>  	mutex_init(&policy->lock);
>  	mutex_lock(&policy->lock);
>  	init_completion(&policy->kobj_unregister);
>  	INIT_WORK(&policy->update, handle_update, (void *)(long)cpu);
>  
> -	/* call driver. From then on the cpufreq must be able
> -	 * to accept all calls to ->verify and ->setpolicy for this CPU
> -	 */
> -	ret = cpufreq_driver->init(policy);
> -	if (ret) {
> +	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
> +
> +	/* FIXME: soon this will come from PowerOP Core as well */
> +	policy->cpuinfo.transition_latency = 10000; /* 10uS latency */

Ouch.

> @@ -692,8 +719,16 @@ #ifdef CONFIG_SMP
>  
>  			cpufreq_debug_enable_ratelimit();
>  			mutex_unlock(&policy->lock);
> -			ret = 0;
> -			goto err_out_driver_exit; /* call driver->exit() */
> +			/* 
> +			 * FIXME: interesting... cpufreq handles one policy 
> +			 * entry for all affected CPUs... it works since 
> +			 * currently same set of freq/voltage pairs are always 
> +			 * registered for all CPUs. That bacomes not the case
> +			 * with PowerOP approach when we can have different
> +			 * set of operating points even for affected CPUs
> +			 */ 
> +			kfree(policy);
> +			return 0;

No, that's not true -- "affected CPUs" can only be set to the same frequency
at any point. It's the same "clock domain". Therefore, your statement is
invalid.

> @@ -944,6 +972,7 @@ unsigned int cpufreq_quick_get(unsigned 
>  EXPORT_SYMBOL(cpufreq_quick_get);
>  
>  
> +/* FIXME: REVISIT: this routine returns 0 on error! */
>  /**
>   * cpufreq_get - get the current CPU frequency (in kHz)

Yes. For if it were to return -EINVAL, userspace would tell you
that you've got at ~4294 GHz CPU.

> +module_param(smart_cpu, uint, 0644);
> +MODULE_PARM_DESC(smart_cpu, "Define if cpu handles frequency intervals insted oftarget frequencies");

Ouch.

These were just a few comments on the code. On the "big picture", I'll write
a separate e-mail.

Thanks,
	Dominik
