Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267427AbSLSAXO>; Wed, 18 Dec 2002 19:23:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267430AbSLSAXO>; Wed, 18 Dec 2002 19:23:14 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:5328 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267427AbSLSAXM>;
	Wed, 18 Dec 2002 19:23:12 -0500
Date: Wed, 18 Dec 2002 16:24:55 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
cc: John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, jamesclv@us.ibm.com,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs 
Message-ID: <20980000.1040257495@flay>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E18E@fmsmsx405.fm.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First thing, can you split this into much smaller pieces, each of
which perform one code change ... then it might be more feasible 
to read it.

> -   bool 'Multi-node NUMA system support' CONFIG_X86_NUMA
> -   if [ "$CONFIG_X86_NUMA" = "y" ]; then
> +   bool 'Clustered APIC (> 8 CPUs) support' CONFIG_X86_APIC_CLUSTER
> +   if [ "$CONFIG_X86_APIC_CLUSTER" = "y" ]; then
> +      define_bool CONFIG_X86_CLUSTERED_APIC y
>        #Platform Choices
>        bool ' Multiquad (IBM/Sequent) NUMAQ support' CONFIG_X86_NUMAQ
>        if [ "$CONFIG_X86_NUMAQ" = "y" ]; then
> -         define_bool CONFIG_X86_CLUSTERED_APIC y
> -		 define_bool CONFIG_MULTIQUAD y
> -      fi
> -      bool ' IBM x440 (Summit/EXA) support' CONFIG_X86_SUMMIT
> -      if [ "$CONFIG_X86_SUMMIT" = "y" ]; then
> -         define_bool CONFIG_X86_CLUSTERED_APIC y
> +                 define_bool CONFIG_MULTIQUAD y

You seem to have lost turning on CONFIG_X86_NUMA.

> --- linux-2.4.21-pre1.org/arch/i386/defconfig	2002-11-28 15:53:09.000000000 -0800
> +++ linux-test1/arch/i386/defconfig	2002-12-14 14:59:52.000000000 -0800
> @@ -62,6 +62,7 @@
>  # CONFIG_MATH_EMULATION is not set
>  # CONFIG_MTRR is not set
>  CONFIG_SMP=y
> +CONFIG_X86_APIC_CLUSTER=y
>  # CONFIG_MULTIQUAD is not set
>  CONFIG_HAVE_DEC_LOCK=y

Errrm ... on by default?
  
> -	if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
> -		id = physical_to_logical_apicid(hard_smp_processor_id());
> +	if(clustered_apic_mode)
> +		id = cpu_2_logical_apicid[smp_processor_id()];

Don't use those arrays directly, use the macros.
And that was off before for NUMA-Q ... you seem to have turned it on.
Unless you've inverted the meaning of clustered_apic_mode, which is
going to confuse the hell out of everyone?

> -	if (clustered_apic_mode != CLUSTERED_APIC_NUMAQ) {
> +	if (configured_platform_type != CONFIGURED_PLATFORM_NUMA) {

OK, what exactly are your switching rules here? Before:

if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ)   -> numaq only
if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)   -> x440
if (clustered_apic_mode)                           -> numaq or x440

Make sure you match that switching logic in whatever you do.
For instance, this whole section gets skipped for NUMA-Q, but not
other NUMA machines.

>  			/* Multi-Quad has an extended PCI Conf1 */
> -			if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
> +			if(configured_platform_type == CONFIGURED_PLATFORM_NUMA)

If that's the direct substitution you're trying to make, don't misname
NUMAQ stuff as NUMA - very confusing ...

OK ... I give up trying to read the rest of it until you explain the
switching rules you're trying to use ... perhaps they're just confusingly
named, but it looks all wrong to me ...

M.
