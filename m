Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750696AbWHPQBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750696AbWHPQBO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbWHPQBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:01:14 -0400
Received: from hera.kernel.org ([140.211.167.34]:39901 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S1750696AbWHPQBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:01:13 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Andi Kleen <ak@suse.de>, ashok.raj@intel.com
Subject: Re: [PATCH for review] [133/145] x86_64: Support physical cpu hotplug for x86_64
Date: Wed, 16 Aug 2006 12:02:46 -0400
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060810 935.775038000@suse.de> <20060810193733.28CA013B8E@wotan.suse.de>
In-Reply-To: <20060810193733.28CA013B8E@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161202.46783.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 August 2006 15:37, Andi Kleen wrote:
> r
> 
> From: Ashok Raj <ashok.raj@intel.com>
> 
> This patch enables ACPI based physical CPU hotplug support for x86_64. 
> Implements acpi_map_lsapic() and acpi_unmap_lsapic() to support physical cpu
> hotplug.

> Signed-off-by: Ashok Raj <ashok.raj@intel.com>
> Signed-off-by: Andi Kleen <ak@suse.de>
> Cc: Andi Kleen <ak@muc.de>
> Cc: "Brown, Len" <len.brown@intel.com>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  arch/i386/kernel/acpi/boot.c |   69 ++++++++++++++++++++++++++++++++++++++++---
>  arch/i386/kernel/mpparse.c   |    2 -
>  include/asm-i386/smp.h       |    1 
>  3 files changed, 67 insertions(+), 5 deletions(-)
> 
> Index: linux/arch/i386/kernel/acpi/boot.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/acpi/boot.c
> +++ linux/arch/i386/kernel/acpi/boot.c
> @@ -26,6 +26,7 @@
>  #include <linux/init.h>
>  #include <linux/acpi.h>
>  #include <linux/efi.h>
> +#include <linux/cpumask.h>
>  #include <linux/module.h>
>  #include <linux/dmi.h>
>  #include <linux/irq.h>
> @@ -512,16 +513,76 @@ EXPORT_SYMBOL(acpi_register_gsi);
>  #ifdef CONFIG_ACPI_HOTPLUG_CPU
>  int acpi_map_lsapic(acpi_handle handle, int *pcpu)
>  {
> -	/* TBD */
> -	return -EINVAL;
> +	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +	union acpi_object *obj;
> +	struct acpi_table_lapic *lapic;

Lets _not_ have a routine called acpi_map_lsapic() that on ia64 maps an lsapic
and on i386 and x86_64 maps a lapic.

If you can't share the same routine between 3 architectures, then at least give
it a generic name that applies to both lsapic and lapic.

thanks,
-Len


> +	cpumask_t tmp_map, new_map;
> +	u8 physid;
> +	int cpu;
> +
> +	if (ACPI_FAILURE(acpi_evaluate_object(handle, "_MAT", NULL, &buffer)))
> +		return -EINVAL;
> +
> +	if (!buffer.length || !buffer.pointer)
> +		return -EINVAL;
> +
> +	obj = buffer.pointer;
> +	if (obj->type != ACPI_TYPE_BUFFER ||
> +	    obj->buffer.length < sizeof(*lapic)) {
> +		kfree(buffer.pointer);
> +		return -EINVAL;
> +	}
> +
> +	lapic = (struct acpi_table_lapic *)obj->buffer.pointer;
> +
> +	if ((lapic->header.type != ACPI_MADT_LAPIC) ||
> +	    (!lapic->flags.enabled)) {
> +		kfree(buffer.pointer);
> +		return -EINVAL;
> +	}
> +
> +	physid = lapic->id;
> +
> +	kfree(buffer.pointer);
> +	buffer.length = ACPI_ALLOCATE_BUFFER;
> +	buffer.pointer = NULL;
> +
> +	tmp_map = cpu_present_map;
> +	mp_register_lapic(physid, lapic->flags.enabled);
> +
> +	/*
> +	 * If mp_register_lapic successfully generates a new logical cpu
> +	 * number, then the following will get us exactly what was mapped
> +	 */
> +	cpus_andnot(new_map, cpu_present_map, tmp_map);
> +	if (cpus_empty(new_map)) {
> +		printk ("Unable to map lapic to logical cpu number\n");
> +		return -EINVAL;
> +	}
> +
> +	cpu = first_cpu(new_map);
> +
> +	*pcpu = cpu;
> +	return 0;
>  }
>  
>  EXPORT_SYMBOL(acpi_map_lsapic);
>  
>  int acpi_unmap_lsapic(int cpu)
>  {
> -	/* TBD */
> -	return -EINVAL;
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		if (x86_acpiid_to_apicid[i] == x86_cpu_to_apicid[cpu]) {
> +			x86_acpiid_to_apicid[i] = -1;
> +			break;
> +		}
> +	}
> +	x86_cpu_to_apicid[cpu] = -1;
> +	cpu_clear(cpu, cpu_present_map);
> +	num_processors--;
> +
> +	return (0);
>  }
>  
>  EXPORT_SYMBOL(acpi_unmap_lsapic);
> Index: linux/arch/i386/kernel/mpparse.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/mpparse.c
> +++ linux/arch/i386/kernel/mpparse.c
> @@ -69,7 +69,7 @@ unsigned int def_to_bigsmp = 0;
>  /* Processor that is doing the boot up */
>  unsigned int boot_cpu_physical_apicid = -1U;
>  /* Internal processor count */
> -static unsigned int __devinitdata num_processors;
> +unsigned int __cpuinitdata num_processors;
>  
>  /* Bitmask of physically existing CPUs */
>  physid_mask_t phys_cpu_present_map;
> Index: linux/include/asm-i386/smp.h
> ===================================================================
> --- linux.orig/include/asm-i386/smp.h
> +++ linux/include/asm-i386/smp.h
> @@ -84,6 +84,7 @@ static inline int hard_smp_processor_id(
>  
>  extern int __cpu_disable(void);
>  extern void __cpu_die(unsigned int cpu);
> +extern unsigned int num_processors;
>  
>  #endif /* !__ASSEMBLY__ */
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
