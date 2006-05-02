Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWEBQCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWEBQCo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWEBQCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 12:02:44 -0400
Received: from dvhart.com ([64.146.134.43]:49883 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S964904AbWEBQCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 12:02:43 -0400
Message-ID: <4457829E.6090901@mbligh.org>
Date: Tue, 02 May 2006 09:02:38 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Andy Whitcroft <apw@shadowen.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
References: <20060419112130.GA22648@elte.hu> <200605021703.37195.ak@suse.de> <44577822.8050103@mbligh.org> <200605021745.32907.ak@suse.de>
In-Reply-To: <200605021745.32907.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >>>>Bollocks. It works fine,
 >>>
 >>>On what kind of box? Some summit system, right?
 >>
 >>Summit and NUMA-Q, ie everything we originally created it for.
 >
 > Andi:
 >
> That's my point - it usually crashes everywhere else.

Ingo Molnar wrote:
 >
 > i only booted it on a non-NUMA PC. Most likely the instability is
 > caused by some sort of zone mis-sizing. (See more details in this
 > same thread.)

Ooooh, on ordinary PCs. that makes more sense.

> The problem is that it's not regression tested and quite complex and 
 > tends to break often and stay broken.

OK, well the regression testing issue is easily fixed, but whether it's
worth it or not is a different issue. It was originally done for the
distros really, so they could have a single kernel that supported
everything.

> If you don't want to mark it CONFIG_BROKEN then i would suggest a panic
> early when the system isn't SUMMIT (I think NUMAQ does this already)
> 
> Something like the appended patch

apw: this was your baby ... what do you want to do with it? Add it
to the automated regression testing, or kill it?

> -Andi
> 
> i386: Panic the system early when a NUMA kernel doesn't run on IBM NUMA
> 
> It has been broken forever anywhere else and is not too useful
> anyways so best to disable it.
> 
> Signed-off-by: Andi Kleen <ak@suse.de>
> 
> Index: linux/arch/i386/kernel/srat.c
> ===================================================================
> --- linux.orig/arch/i386/kernel/srat.c
> +++ linux/arch/i386/kernel/srat.c
> @@ -327,6 +327,14 @@ int __init get_memcfg_from_srat(void)
>  	int tables = 0;
>  	int i = 0;
>  
> +	extern int use_cyclone;
> +	if (use_cyclone == 0) {
> +		/* Make sure user sees something */
> +		static const char s[] __initdata = "Not an IBM x440/NUMAQ. Don't use i386 CONFIG_NUMA anywhere else."
> +		early_printk(s);
> +		panic(s); 
> +	}
> +
>  	if (ACPI_FAILURE(acpi_find_root_pointer(ACPI_PHYSICAL_ADDRESSING,
>  						rsdp_address))) {
>  		printk("%s: System description tables not found\n",
> Index: linux/arch/i386/Kconfig
> ===================================================================
> --- linux.orig/arch/i386/Kconfig
> +++ linux/arch/i386/Kconfig
> @@ -517,6 +517,9 @@ config NUMA
>  	depends on SMP && HIGHMEM64G && (X86_NUMAQ || X86_GENERICARCH || (X86_SUMMIT && ACPI))
>  	default n if X86_PC
>  	default y if (X86_NUMAQ || X86_SUMMIT)
> +	help
> +		NUMA support. Note this only works on IBM x440 or IBM NUMAQ.
> +		Don't try to use it anywhere else.
>  
>  comment "NUMA (Summit) requires SMP, 64GB highmem support, ACPI"
>  	depends on X86_SUMMIT && (!HIGHMEM64G || !ACPI)
