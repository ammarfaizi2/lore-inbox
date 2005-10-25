Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbVJYJmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbVJYJmu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 05:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932114AbVJYJmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 05:42:50 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:37577 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932113AbVJYJmt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 05:42:49 -0400
Date: Tue, 25 Oct 2005 15:12:41 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 mpparse: Only ignore lapic information we can't store
Message-ID: <20051025094241.GE4426@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <m1fyrh8gro.fsf@ebiederm.dsl.xmission.com> <20051021133306.GC3799@in.ibm.com> <m1ach3dj47.fsf@ebiederm.dsl.xmission.com> <20051022145207.GA4501@in.ibm.com> <m11x2deft5.fsf@ebiederm.dsl.xmission.com> <20051024130311.GA5853@in.ibm.com> <m1irvmca2r.fsf_-_@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1irvmca2r.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2005 at 01:47:08AM -0600, Eric W. Biederman wrote:
> 
> After staring at mpparse.c for a little longer I noticed that
> when we hit our limit of num_processors we are filtering out
> information about other processors that we can still store.
> 
> This patch just reorders the code so we store everything we
> can.  
> 
> This should avoid the incorrect warning about our boot CPU
> not being listed by the BIOS that we are now getting in
> the kexec on panic case, and it should allow us to detect
> all apicid conflicts even when our physical number of
> cpus exceeds maxcpus.
> 
> Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
> 
> 

I justed tested the patch. It looks good. BIOS not reporting CPU message
is gone.

Thanks
Vivek

> ---
> 
>  arch/i386/kernel/mpparse.c |   35 +++++++++++++++++++----------------
>  1 files changed, 19 insertions(+), 16 deletions(-)
> 
> applies-to: cf16f96fe9347e42dd2fc6b305005a52783195d4
> 192f11c9442be11c6535b38d371aa3771fd9513e
> diff --git a/arch/i386/kernel/mpparse.c b/arch/i386/kernel/mpparse.c
> index 27aabfc..07555a4 100644
> --- a/arch/i386/kernel/mpparse.c
> +++ b/arch/i386/kernel/mpparse.c
> @@ -182,17 +182,6 @@ static void __init MP_processor_info (st
>  		boot_cpu_physical_apicid = m->mpc_apicid;
>  	}
>  
> -	if (num_processors >= NR_CPUS) {
> -		printk(KERN_WARNING "WARNING: NR_CPUS limit of %i reached."
> -			"  Processor ignored.\n", NR_CPUS); 
> -		return;
> -	}
> -
> -	if (num_processors >= maxcpus) {
> -		printk(KERN_WARNING "WARNING: maxcpus limit of %i reached."
> -			" Processor ignored.\n", maxcpus); 
> -		return;
> -	}
>  	ver = m->mpc_apicver;
>  
>  	if (!MP_valid_apicid(apicid, ver)) {
> @@ -201,11 +190,6 @@ static void __init MP_processor_info (st
>  		return;
>  	}
>  
> -	cpu_set(num_processors, cpu_possible_map);
> -	num_processors++;
> -	phys_cpu = apicid_to_cpu_present(apicid);
> -	physids_or(phys_cpu_present_map, phys_cpu_present_map, phys_cpu);
> -
>  	/*
>  	 * Validate version
>  	 */
> @@ -216,6 +200,25 @@ static void __init MP_processor_info (st
>  		ver = 0x10;
>  	}
>  	apic_version[m->mpc_apicid] = ver;
> +
> +	phys_cpu = apicid_to_cpu_present(apicid);
> +	physids_or(phys_cpu_present_map, phys_cpu_present_map, phys_cpu);
> +
> +	if (num_processors >= NR_CPUS) {
> +		printk(KERN_WARNING "WARNING: NR_CPUS limit of %i reached."
> +			"  Processor ignored.\n", NR_CPUS); 
> +		return;
> +	}
> +
> +	if (num_processors >= maxcpus) {
> +		printk(KERN_WARNING "WARNING: maxcpus limit of %i reached."
> +			" Processor ignored.\n", maxcpus); 
> +		return;
> +	}
> +
> +	cpu_set(num_processors, cpu_possible_map);
> +	num_processors++;
> +
>  	if ((num_processors > 8) &&
>  	    APIC_XAPIC(ver) &&
>  	    (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))
