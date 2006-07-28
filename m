Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161217AbWG1SVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161217AbWG1SVR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161220AbWG1SVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:21:17 -0400
Received: from rune.pobox.com ([208.210.124.79]:44223 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1161217AbWG1SVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:21:15 -0400
Date: Fri, 28 Jul 2006 13:20:41 -0500
From: Nathan Lynch <ntl@pobox.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH -mm][resend] Disable CPU hotplug during suspend
Message-ID: <20060728182041.GI19076@localdomain>
References: <200607281015.30048.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607281015.30048.rjw@sisk.pl>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael-

A couple of minor comments:


> +int cpu_down(unsigned int cpu)
> +{
> +	int err = 0;
> +
> +	mutex_lock(&cpu_add_remove_lock);
> +	if (cpu_hotplug_disabled)
> +		err = -EPERM;
> +	else
> +		err = __cpu_down(cpu);
> +
>  	mutex_unlock(&cpu_add_remove_lock);
>  	return err;
>  }
> @@ -191,6 +203,11 @@ int __devinit cpu_up(unsigned int cpu)
>  	void *hcpu = (void *)(long)cpu;
>  
>  	mutex_lock(&cpu_add_remove_lock);
> +	if (cpu_hotplug_disabled) {
> +		ret = -EPERM;
> +		goto out;
> +	}

I think -EBUSY would be more appropriate than -EPERM, perhaps?


> +#ifdef CONFIG_SUSPEND_SMP
> +static cpumask_t frozen_cpus;
> +
> +int disable_nonboot_cpus(void)
> +{
> +	int cpu, error = 0;
> +
> +	/* We take all of the non-boot CPUs down in one shot to avoid races
> +	 * with the userspace trying to use the CPU hotplug at the same time
> +	 */
> +	mutex_lock(&cpu_add_remove_lock);
> +	cpus_clear(frozen_cpus);
> +	printk("Disabling non-boot CPUs ...\n");
> +	for_each_online_cpu(cpu) {
> +		if (cpu == 0)
> +			continue;

Assuming cpu 0 is online is not okay in generic code.  This should be
something like:

	int cpu, first_cpu, error = 0;

	/* We take all of the non-boot CPUs down in one shot to avoid races
	 * with the userspace trying to use the CPU hotplug at the same time
	 */
	mutex_lock(&cpu_add_remove_lock);
	cpus_clear(frozen_cpus);
	first_cpu = first_cpu(cpu_online_mask);
	printk("Disabling non-boot CPUs ...\n");
	for_each_online_cpu(cpu) {
		if (cpu == first_cpu)
			continue;


> +		error = __cpu_down(cpu);
> +		if (!error) {
> +			cpu_set(cpu, frozen_cpus);
> +			printk("CPU%d is down\n", cpu);
> +		} else {
> +			printk(KERN_ERR "Error taking CPU%d down: %d\n",
> +				cpu, error);
> +			break;
> +		}
> +	}
> +	if (!error) {
> +		BUG_ON(num_online_cpus() > 1);
> +		BUG_ON(raw_smp_processor_id() != 0);

Same problem here.

Otherwise, I think the patch looks okay.

