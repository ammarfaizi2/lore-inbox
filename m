Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263711AbUJ3Amf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUJ3Amf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 20:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbUJ3Ajb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 20:39:31 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:14503 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S263703AbUJ3Afg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 20:35:36 -0400
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM LTC (xSeries Solutions
To: Suresh Siddha <suresh.b.siddha@intel.com>, ak@suse.de, akpm@osdl.org
Subject: Re: [Patch] x86-64: fix sibling map again!
Date: Fri, 29 Oct 2004 17:35:32 -0700
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20041029170215.A26372@unix-os.sc.intel.com>
In-Reply-To: <20041029170215.A26372@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410291735.32175.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Suresh,

Can you tell me why Intel considers cpuid to be The One True
Way(TM) to get sibling info?  Especially on x86-64, which
doesn't have the same level of APIC weirdness that i386 does.

(I won't even mention the fact that someone messed up on the
MSR the BIOS can use to set bits 7:5 in the cpuid ID value.
It should allow the BIOS to set bits 7:3.)


On Friday 29 October 2004 05:02 pm, Suresh Siddha wrote:
> Recent x86-64 sibling map fix for clustered mode by James
> (http://linux.bkbits.net:8080/linux-2.6/cset@414b34a6jkiHQ5AnhA269av7
>6y3ZAw?nav=index.html) is not the recommended way of fixing it.
>
> That patch assumes BIOS for non-clustered systems accept the HW
> assigned value. Why make this assumption when we can fix it in a
> better fashion(which is also used by x86 kernel's today)
>
> Basically use HW assigned apic_id's(returned by cpuid) for non
> clustered systems and for clustered use BIOS provided apic_id's.
> Appended patch does this.
>
> Note: Similar issue was earlier disussed in context of x86 approx an
> year back and James then backed out his changes.
> http://www.ussg.iu.edu/hypermail/linux/kernel/0312.2/0167.html

Not quite.  I just stopped arguing and tried to reach _some_
sort of compromise.   8-)

> --
>
> Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
>
>
> diff -Nru linux-2.6.10-rc1/arch/x86_64/kernel/genapic_cluster.c
> linux-ht/arch/x86_64/kernel/genapic_cluster.c ---
> linux-2.6.10-rc1/arch/x86_64/kernel/genapic_cluster.c	2004-10-08
> 20:32:25.000000000 -0700 +++
> linux-ht/arch/x86_64/kernel/genapic_cluster.c	2004-10-09
> 18:55:32.091017328 -0700 @@ -111,6 +111,16 @@
>  		return BAD_APICID;
>  }
>
> +/* cpuid returns the value latched in the HW at reset, not the APIC
> ID + * register's value.  For any box whose BIOS changes APIC IDs,
> like + * clustered APIC systems, we must use hard_smp_processor_id. +
> *
> + * See Intel's IA-32 SW Dev's Manual Vol2 under CPUID.
> + */
> +static unsigned int phys_pkg_id(int index_msb)
> +{
> +	return hard_smp_processor_id() >> index_msb;
> +}
>
>  struct genapic apic_cluster = {
>  	.name = "clustered",
> @@ -124,4 +134,5 @@
>  	.send_IPI_allbutself = cluster_send_IPI_allbutself,
>  	.send_IPI_mask = cluster_send_IPI_mask,
>  	.cpu_mask_to_apicid = cluster_cpu_mask_to_apicid,
> +	.phys_pkg_id = phys_pkg_id,
>  };
> diff -Nru linux-2.6.10-rc1/arch/x86_64/kernel/genapic_flat.c
> linux-ht/arch/x86_64/kernel/genapic_flat.c ---
> linux-2.6.10-rc1/arch/x86_64/kernel/genapic_flat.c	2004-10-08
> 20:32:25.000000000 -0700 +++
> linux-ht/arch/x86_64/kernel/genapic_flat.c	2004-10-09
> 18:55:25.908957144 -0700 @@ -103,6 +103,13 @@
>  	return cpus_addr(cpumask)[0] & APIC_ALL_CPUS;
>  }
>
> +static unsigned int phys_pkg_id(int index_msb)
> +{
> +	u32 ebx;
> +
> +	ebx = cpuid_ebx(1);
> +	return ((ebx >> 24) & 0xFF) >> index_msb;
> +}
>
>  struct genapic apic_flat =  {
>  	.name = "flat",
> @@ -116,4 +123,5 @@
>  	.send_IPI_allbutself = flat_send_IPI_allbutself,
>  	.send_IPI_mask = flat_send_IPI_mask,
>  	.cpu_mask_to_apicid = flat_cpu_mask_to_apicid,
> +	.phys_pkg_id = phys_pkg_id,
>  };
> diff -Nru linux-2.6.10-rc1/arch/x86_64/kernel/setup.c
> linux-ht/arch/x86_64/kernel/setup.c ---
> linux-2.6.10-rc1/arch/x86_64/kernel/setup.c	2004-10-22
> 14:38:16.000000000 -0700 +++
> linux-ht/arch/x86_64/kernel/setup.c	2004-10-09 15:24:02.000000000
> -0700 @@ -56,6 +56,7 @@
>  #include <asm/smp.h>
>  #include <asm/proto.h>
>  #include <asm/setup.h>
> +#include <asm/mach_apic.h>
>
>  /*
>   * Machine setup..
> @@ -710,7 +711,6 @@
>  #ifdef CONFIG_SMP
>  	u32 	eax, ebx, ecx, edx;
>  	int 	index_lsb, index_msb, tmp;
> -	int	initial_apic_id;
>  	int 	cpu = smp_processor_id();
>
>  	if (!cpu_has(c, X86_FEATURE_HT))
> @@ -745,8 +745,7 @@
>  		}
>  		if (index_lsb != index_msb )
>  			index_msb++;
> -		initial_apic_id = hard_smp_processor_id();
> -		phys_proc_id[cpu] = initial_apic_id >> index_msb;
> +		phys_proc_id[cpu] = phys_pkg_id(index_msb);
>
>  		printk(KERN_INFO  "CPU: Physical Processor ID: %d\n",
>  		       phys_proc_id[cpu]);
> diff -Nru linux-2.6.10-rc1/include/asm-x86_64/genapic.h
> linux-ht/include/asm-x86_64/genapic.h ---
> linux-2.6.10-rc1/include/asm-x86_64/genapic.h	2004-10-08
> 20:32:26.000000000 -0700 +++
> linux-ht/include/asm-x86_64/genapic.h	2004-10-09 15:23:45.000000000
> -0700 @@ -26,6 +26,7 @@
>  	void (*send_IPI_all)(int vector);
>  	/* */
>  	unsigned int (*cpu_mask_to_apicid)(cpumask_t cpumask);
> +	unsigned int (*phys_pkg_id)(int index_msb);
>  };
>
>
> diff -Nru linux-2.6.10-rc1/include/asm-x86_64/mach_apic.h
> linux-ht/include/asm-x86_64/mach_apic.h ---
> linux-2.6.10-rc1/include/asm-x86_64/mach_apic.h	2004-10-08
> 20:32:26.000000000 -0700 +++
> linux-ht/include/asm-x86_64/mach_apic.h	2004-10-08 20:42:09.000000000
> -0700 @@ -24,5 +24,6 @@
>  #define send_IPI_allbutself (genapic->send_IPI_allbutself)
>  #define send_IPI_all (genapic->send_IPI_all)
>  #define cpu_mask_to_apicid (genapic->cpu_mask_to_apicid)
> +#define phys_pkg_id	(genapic->phys_pkg_id)
>
>  #endif /* __ASM_MACH_APIC_H */

-- 
James Cleverdon
IBM LTC (xSeries Linux Solutions)
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot comm

