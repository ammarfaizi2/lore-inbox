Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316390AbSGYU2F>; Thu, 25 Jul 2002 16:28:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316364AbSGYU2E>; Thu, 25 Jul 2002 16:28:04 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32943 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316339AbSGYU17> convert rfc822-to-8bit;
	Thu, 25 Jul 2002 16:27:59 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Subject: Re: 2.4.19-rc3-ac2 SMP
Date: Thu, 25 Jul 2002 13:29:38 -0700
User-Agent: KMail/1.4.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0207250859590.17209-100000@linux-box.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.44.0207250859590.17209-100000@linux-box.realnet.co.sz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207251329.38011.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 25 July 2002 12:11 am, Zwane Mwaikambo wrote:
> On Wed, 24 Jul 2002, James Cleverdon wrote:
> > Ah ha!  Note that while the CPU records in the {MPS,ACPI/MADT} table are
> > in numerical order (as preserved in raw_phys_apicid), the boot CPU is #
> > 02.  The flat code in smp_boot_cpus assumes that the boot CPU will be the
> > first record in the list.  Oops.
>
> Ok i'll give it a whirl, in that case how about the following code to do
> the BSP check in another area too?

That would work, too.  The bug was not in recognizing the boot cpu, but in 
assuming that we would continue (for one reason or another) the first time 
around the loop, because logical ID 0x01 was already assigned.

The previous code got around this dependency in a weird and rather kludgey 
way.  Check -rc3 for the two instances of boot_cpu_logical_apicid in 
mpparse.c and smpboot.c, and the two entirely different sources of 
boot_cpu_logical_apicid's value.  Bizarre.

> Index: linux-2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c
> ===================================================================
> RCS file:
> /home/zwane/source/cvs_rep/linux-2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c,
>v retrieving revision 1.2
> diff -u -r1.2 smpboot.c
> --- linux-2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c	2002/07/25 06:06:56	1.2
> +++ linux-2.4.19-rc3-ac2/arch/i386/kernel/smpboot.c	2002/07/25 06:15:05
> @@ -46,6 +46,7 @@
>  #include <asm/mtrr.h>
>  #include <asm/pgalloc.h>
>  #include <asm/smpboot.h>
> +#include <asm/msr.h>
>
>  /* Set if we find a B stepping CPU			*/
>  static int smp_b_stepping;
> @@ -229,6 +230,14 @@
>  	return res;
>  }
>
> +int smp_cpu_is_bsp (void)
> +{
> +	unsigned long l, h;
> +
> +	rdmsr(MSR_IA32_APICBASE, l, h);
> +	return (l & MSR_IA32_APICBASE_BSP);
> +}
> +
>  static void __init synchronize_tsc_bp (void)
>  {
>  	int i;
> @@ -1067,7 +1076,7 @@
>  	connect_bsp_APIC();
>  	setup_local_APIC();
>
> -	if (GET_APIC_ID(apic_read(APIC_ID)) != boot_cpu_physical_apicid)
> +	if (!smp_cpu_is_bsp())
>  		BUG();
>
>  	/*

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com


