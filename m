Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274774AbRJFAe5>; Fri, 5 Oct 2001 20:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274784AbRJFAer>; Fri, 5 Oct 2001 20:34:47 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:26342 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S274774AbRJFAej>; Fri, 5 Oct 2001 20:34:39 -0400
Subject: Re: Wierd /proc/cpuinfo with 2.4.11-pre4
From: Alessandro Suardi <alessandro.suardi@oracle.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Dan Merillat <harik@chaos.ao.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1570684149.1002298064@mbligh.des.sequent.com>
In-Reply-To: <1570684149.1002298064@mbligh.des.sequent.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 06 Oct 2001 02:37:22 +0200
Message-Id: <1002328646.1085.1.camel@dolphin>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-10-06 at 01:07, Martin J. Bligh wrote:
> > Doesn't build here...
> 
> Looks like you need the other patch I posted here too.

Thanks, builds - boots - fixes /proc/cpuinfo on my UP :)

> Combined reformated patch below:
> 
> diff -urN virgin-2.4.11-pre4/arch/i386/kernel/setup.c numa-2.4.11-pre4/arch/i386/kernel/setup.c
> --- virgin-2.4.11-pre4/arch/i386/kernel/setup.c	Fri Oct  5 15:39:54 2001
> +++ numa-2.4.11-pre4/arch/i386/kernel/setup.c	Fri Oct  5 15:42:37 2001
> @@ -2420,7 +2420,7 @@
>  	 * WARNING - nasty evil hack ... if we print > 8, it overflows the
>  	 * page buffer and corrupts memory - this needs fixing properly
>  	 */
> -	for (n = 0; n < 8; n++, c++) {
> +	for (n = 0; n < (clustered_apic_mode ? 8 : NR_CPUS); n++, c++) {
>  	/* for (n = 0; n < NR_CPUS; n++, c++) { */
>  		int fpu_exception;
>  #ifdef CONFIG_SMP
> diff -urN virgin-2.4.11-pre4/include/asm-i386/smp.h numa-2.4.11-pre4/include/asm-i386/smp.h
> --- virgin-2.4.11-pre4/include/asm-i386/smp.h	Fri Oct  5 15:40:46 2001
> +++ numa-2.4.11-pre4/include/asm-i386/smp.h	Fri Oct  5 15:44:57 2001
> @@ -22,7 +22,7 @@
>  #endif
>  #endif
>  
> -#if CONFIG_SMP
> +#ifdef CONFIG_SMP
>  # ifdef CONFIG_MULTIQUAD
>  #  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
>  #  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
> @@ -31,9 +31,20 @@
>  #  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
>  # endif
>  #else
> +# define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
>  # define TARGET_CPUS 0x01
>  #endif
>  
> +#ifndef clustered_apic_mode
> + #ifdef CONFIG_MULTIQUAD
> +  #define clustered_apic_mode (1)
> +  #define esr_disable (1)
> + #else /* !CONFIG_MULTIQUAD */
> +  #define clustered_apic_mode (0)
> +  #define esr_disable (0)
> + #endif /* CONFIG_MULTIQUAD */
> +#endif 
> +
>  #ifdef CONFIG_SMP
>  #ifndef ASSEMBLY
>  
> @@ -76,16 +87,6 @@
>  extern volatile int physical_apicid_to_cpu[MAX_APICID];
>  extern volatile int cpu_to_logical_apicid[NR_CPUS];
>  extern volatile int logical_apicid_to_cpu[MAX_APICID];
> -
> -#ifndef clustered_apic_mode
> - #ifdef CONFIG_MULTIQUAD
> -  #define clustered_apic_mode (1)
> -  #define esr_disable (1)
> - #else /* !CONFIG_MULTIQUAD */
> -  #define clustered_apic_mode (0)
> -  #define esr_disable (0)
> - #endif /* CONFIG_MULTIQUAD */
> -#endif 
>  
>  /*
>   * General functions that each host system must provide.
>


--alessandro

 "this is no time to get cute, it's a mad dog's promenade
  so walk tall, or baby don't walk at all"
                (Bruce Springsteen, 'New York City Serenade')

