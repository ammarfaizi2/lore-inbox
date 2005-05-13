Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262570AbVEMWow@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262570AbVEMWow (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 18:44:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbVEMWnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 18:43:43 -0400
Received: from terminus.zytor.com ([209.128.68.124]:41121 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262575AbVEMWk5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 18:40:57 -0400
Message-ID: <42852CE2.4090102@zytor.com>
Date: Fri, 13 May 2005 15:40:34 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Cachemap for 2.6.12rc4-mm1.  Was Re: [PATCH] enhance x86
 MTRR handling
References: <s2832b02.028@emea1-mh.id2.novell.com> <20050512161825.GC17618@redhat.com> <20050512214118.GA25065@redhat.com>
In-Reply-To: <20050512214118.GA25065@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> +	switch (boot_cpu_data.x86_vendor) {
> +	case X86_VENDOR_AMD:
> +		wrmsr(IA32_CR_PAT, AMD_PAT_31_0, AMD_PAT_63_32);
> +		atomic_inc(&pat_cpus_enabled);
> +		break;
> +	case X86_VENDOR_INTEL:
> +		wrmsr(IA32_CR_PAT, INTEL_PAT_31_0, INTEL_PAT_63_32);
> +		atomic_inc(&pat_cpus_enabled);
> +		break;
> +	default:
> +		printk("Unknown vendor in setup_pat()\n");
> +	}

Drop the vendor check; PAT is a generic x86 feature.  If AMD is not 
compatible (see below), then use X86_VENDOR_AMD: and default:.

> +
> +	/* checks copied from arch/i386/kernel/cpu/mtrr/main.c */
> +	/* do these only apply to mtrrs or pat as well? */

It would apply to both; the chipset wouldn't even know how it got invoked.

> +/* Here is the PAT's default layout on ia32 cpus when we are done.
> + * PAT0: Write Back
> + * PAT1: Write Combine
> + * PAT2: Uncached
> + * PAT3: Uncacheable
> + * PAT4: Write Through
> + * PAT5: Write Protect
> + * PAT6: Uncached
> + * PAT7: Uncacheable

Bad move.  Some (Intel) processors drop the top bit, so it's much better 
to pick the protection methods one cares about (usually WB, WC, UC) and 
stick them in the first four, then duplicate the whole thing in the 
second half.

Unless you actually expect someone to use WT or WP, no need to tickle 
this particular bug.

> + * Note: On Athlon cpus PAT2/PAT3 & PAT6/PAT7 are both Uncacheable since 
> + *	 there is no uncached type.

If one sets the PAT to "uncached", does one get the same function as 
"uncachable"?

	-hpa
