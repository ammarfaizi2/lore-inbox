Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262552AbUKECCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262552AbUKECCJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 21:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbUKECCI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 21:02:08 -0500
Received: from fmr04.intel.com ([143.183.121.6]:33701 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S262552AbUKECBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 21:01:52 -0500
Date: Thu, 4 Nov 2004 17:57:55 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, rusty@rustcorp.com.au,
       mochel@digitalimplant.org, anton@samba.org
Subject: Re: [RFC/PATCH 3/4] introduce cpu_add and cpu_remove
Message-ID: <20041104175755.B9271@unix-os.sc.intel.com>
References: <20041024094551.28808.28284.87316@biclops> <20041024094613.28808.17748.71291@biclops>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20041024094613.28808.17748.71291@biclops>; from nathanl@austin.ibm.com on Sun, Oct 24, 2004 at 05:42:31AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 24, 2004 at 05:42:31AM -0400, Nathan Lynch wrote:
> 
> These functions safely update cpu_present_map (i.e. with the
> cpucontrol semaphore held) and register or unregister the cpu device
> as needed.  These are needed by systems which can add or remove cpus
> from the system after boot (e.g. ppc64 and ia64), and are intended to
> be called from the platform-specific code such as the ACPI or Open
> Firmware layers.
> 
> Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
> 
> 
> ---
> 
> 
> +
> +/*
> + * Add a cpu to the system.  Return the number of the cpu added,
> + * or NR_CPUS if no more slots available.
> + */
> +unsigned int cpu_add(void)
> +{
> +	unsigned int cpu = NR_CPUS;
> +
> +	lock_cpu_hotplug();
> +
> +	if (num_present_cpus() == num_possible_cpus())
> +goto out;
> +
> +	for_each_cpu(cpu)
> +		if (!cpu_present(cpu))
> +			break;

     could we simplify this by

   cpus_compliment(cpu_compliment_map, cpu_present_map);
   cpu = first_cpu(cpu_compliment_map);

> +
> +	if (register_cpu(cpu)) {
> +		cpu = NR_CPUS;
> +		goto out;
> +	}
> +	cpu_set(cpu, cpu_present_map);

I would prefer that register_cpu is performed in arch side, as there may be other setup 
necessary to capture the hardware->logical associations before consuming these. 


> +out:
> +	unlock_cpu_hotplug();
> +	return cpu;
> +}
> +
> +/*
> + * Remove a cpu from the system.
> + */
> +void cpu_remove(unsigned int cpu)
> +{
> +	lock_cpu_hotplug();
> +
> +	BUG_ON(cpu_present(cpu));
> +
> +	unregister_cpu(cpu);
> +
> +	cpu_clear(cpu, cpu_present_map);
> +
> +	unlock_cpu_hotplug();
> +}
>  #else
>  static inline int cpu_run_sbin_hotplug(unsigned int cpu, const char *action)
>  {
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
