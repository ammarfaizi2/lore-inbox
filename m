Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262551AbUKEB4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262551AbUKEB4h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 20:56:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbUKEB4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 20:56:37 -0500
Received: from fmr04.intel.com ([143.183.121.6]:1188 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262551AbUKEB4W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 20:56:22 -0500
Date: Thu, 4 Nov 2004 17:51:25 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, rusty@rustcorp.com.au,
       mochel@digitalimplant.org, anton@samba.org
Subject: Re: [RFC/PATCH 1/4] dynamic cpu registration - core changes
Message-ID: <20041104175125.A9271@unix-os.sc.intel.com>
References: <20041024094551.28808.28284.87316@biclops> <20041024094559.28808.12445.63352@biclops>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041024094559.28808.12445.63352@biclops>; from nathanl@austin.ibm.com on Sun, Oct 24, 2004 at 05:42:17AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 05:42:17AM -0400, Nathan Lynch wrote:
> 
> Register cpu system devices in the core code instead of leaving it to
> the architecture.  At boot, allocate an array of num_possible_cpus()
> cpu sysdevs, and register sysdevs for cpus which are marked present.
> Also, leave to the node "driver" the creation of symlinks from node to
> cpu devices.
> 
> Change register_cpu so that it no longer requires struct cpu* and
> struct node * arguments, only a logical cpu number.  Break the weird
> cpu->no_control semantics (for now).  Introduce unregister_cpu, which
> removes the cpu entry from sysfs.
> 
> Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
> 
> 
> -					  &cpu->sysdev.kobj,
> -					  kobject_name(&cpu->sysdev.kobj));
> +
> +	/* XXX FIXME: cpu->no_control is always zero...
> +	 * Maybe should introduce an arch-overridable "hotpluggable" map.
> +	 */


Iam getting obsessed with these __attribute__((weak)) these days...:-)

simple solution seems like you can have a platform_prefilter() and post_filter() declared
in the core with weak atteibute, and let the platform that cares about this provide an override
function. So if you need to hang off additional files for platform this can be handy. so for
ppc64, based on LPAR or not, you can add these no_control flag before the file is created?


>  	if (!error && !cpu->no_control)
>  		register_cpu_control(cpu);
>  	return error;
>  }
>  
> +void unregister_cpu(int num)
> +{
> +	struct cpu *cpu = &cpu_devices[num];
>  
> +	sysdev_remove_file(&cpu->sysdev, &attr_online);
> +	sysdev_unregister(&cpu->sysdev);
> +}
>  
>  int __init cpu_dev_init(void)
>  {
> -	return sysdev_class_register(&cpu_sysdev_class);
> +	unsigned int cpu;
> +	int ret = -ENOMEM;
> +	size_t size = sizeof(*cpu_devices) * num_possible_cpus();
> +
> +	cpu_devices = kmalloc(size, GFP_KERNEL);
> +	if (!cpu_devices)
> +		goto out;
> +
> +	sysdev_class_register(&cpu_sysdev_class);
> +
> +	for_each_present_cpu(cpu) {
> +		ret = register_cpu(cpu);
> +		if (ret)
> +			goto out;
> +	}
> +out:
> +	return ret;
>  }
> diff -puN include/linux/cpu.h~dynamic-cpu-registration include/linux/cpu.h
> --- 2.6.10-rc1/include/linux/cpu.h~dynamic-cpu-registration	2004-10-24 00:09:39.000000000 -0500
> +++ 2.6.10-rc1-nathanl/include/linux/cpu.h	2004-10-24 03:52:43.000000000 -0500
> @@ -31,7 +31,8 @@ struct cpu {
>  	struct sys_device sysdev;
>  };
>  
> -extern int register_cpu(struct cpu *, int, struct node *);
> +extern int register_cpu(int);
> +extern void unregister_cpu(int);
>  struct notifier_block;
>  
>  #ifdef CONFIG_SMP
> 
> _
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers,
Ashok Raj
- Linux OS & Technology Team
