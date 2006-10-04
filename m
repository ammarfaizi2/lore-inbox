Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030820AbWJDLyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030820AbWJDLyu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 07:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030689AbWJDLyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 07:54:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:44001 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030820AbWJDLyt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 07:54:49 -0400
From: Andi Kleen <ak@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] x86 therm_throttle: handle sysfs errors
Date: Wed, 4 Oct 2006 13:54:44 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       dmitriyz@google.com
References: <20061004112859.GA20672@havoc.gtf.org>
In-Reply-To: <20061004112859.GA20672@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610041354.44967.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 October 2006 13:28, Jeff Garzik wrote:
> 
> Signed-off-by: Jeff Garzik <jeff@garzik.org>
> 
> ---
> 
> Not sure if NOTIFY_BAD is the correct way to handle the error.
> Please review.

Best you cc the patch author.
(full quote)

-Andi

> 
>  arch/i386/kernel/cpu/mcheck/therm_throt.c |   31 +++++++++++++++++++++---------
>  1 files changed, 22 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/i386/kernel/cpu/mcheck/therm_throt.c b/arch/i386/kernel/cpu/mcheck/therm_throt.c
> index 4f43047..86a47f7 100644
> --- a/arch/i386/kernel/cpu/mcheck/therm_throt.c
> +++ b/arch/i386/kernel/cpu/mcheck/therm_throt.c
> @@ -112,15 +112,13 @@ #ifdef CONFIG_SYSFS
>  /* Add/Remove thermal_throttle interface for CPU device */
>  staticdmitriyz@google.com __cpuinit int thermal_throttle_add_dev(struct sys_device * sys_dev)
>  {
> -	sysfs_create_group(&sys_dev->kobj, &thermal_throttle_attr_group);
> -	return 0;
> +	return sysfs_create_group(&sys_dev->kobj, &thermal_throttle_attr_group);
>  }
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -static __cpuinit int thermal_throttle_remove_dev(struct sys_device * sys_dev)
> +static __cpuinit void thermal_throttle_remove_dev(struct sys_device * sys_dev)
>  {
>  	sysfs_remove_group(&sys_dev->kobj, &thermal_throttle_attr_group);
> -	return 0;
>  }
>  
>  /* Mutex protecting device creation against CPU hotplug */
> @@ -133,19 +131,21 @@ static __cpuinit int thermal_throttle_cp
>  {
>  	unsigned int cpu = (unsigned long)hcpu;
>  	struct sys_device *sys_dev;
> +	int rc = 0;
>  
>  	sys_dev = get_cpu_sysdev(cpu);
>  	mutex_lock(&therm_cpu_lock);
>  	switch (action) {
>  	case CPU_ONLINE:
> -		thermal_throttle_add_dev(sys_dev);
> +		rc = thermal_throttle_add_dev(sys_dev);
>  		break;
>  	case CPU_DEAD:
>  		thermal_throttle_remove_dev(sys_dev);
>  		break;
>  	}
>  	mutex_unlock(&therm_cpu_lock);
> -	return NOTIFY_OK;
> +
> +	return rc ? NOTIFY_BAD : NOTIFY_OK;
>  }
>  
>  static struct notifier_block thermal_throttle_cpu_notifier =
> @@ -156,7 +156,8 @@ #endif /* CONFIG_HOTPLUG_CPU */
>  
>  static __init int thermal_throttle_init_device(void)
>  {
> -	unsigned int cpu = 0;
> +	unsigned int cpu = 0, cpu_err;
> +	int err = 0;
>  
>  	if (!atomic_read(&therm_throt_en))
>  		return 0;
> @@ -167,13 +168,25 @@ #ifdef CONFIG_HOTPLUG_CPU
>  	mutex_lock(&therm_cpu_lock);
>  #endif
>  	/* connect live CPUs to sysfs */
> -	for_each_online_cpu(cpu)
> -		thermal_throttle_add_dev(get_cpu_sysdev(cpu));
> +	for_each_online_cpu(cpu) {
> +		if (!err)
> +			err = thermal_throttle_add_dev(get_cpu_sysdev(cpu));
> +	}
> +	if (err)
> +		goto err_out;
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  	mutex_unlock(&therm_cpu_lock);
>  #endif
>  
>  	return 0;
> +
> +err_out:
> +	for_each_online_cpu(cpu_err) {
> +		if (cpu_err < cpu)
> +			thermal_throttle_remove_dev(get_cpu_sysdev(cpu_err));
> +	}
> +	return err;
>  }
>  
>  device_initcall(thermal_throttle_init_device);
> 
