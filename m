Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932514AbVKWEjF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbVKWEjF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 23:39:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbVKWEjF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 23:39:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:62348 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932514AbVKWEjD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 23:39:03 -0500
Date: Tue, 22 Nov 2005 20:38:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ashok Raj <ashok.raj@intel.com>
Cc: linux-kernel@vger.kernel.org, ashok.raj@intel.com, ak@muc.de,
       gregkh@suse.de, venkatesh.pallipadi@intel.com
Subject: Re: [patch 2/2] Convert bigsmp to use flat physical mode
Message-Id: <20051122203847.7d01f4c5.akpm@osdl.org>
In-Reply-To: <20051121170411.A15347@unix-os.sc.intel.com>
References: <20051122000204.890352000@araj-sfield-2>
	<20051121170411.A15347@unix-os.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ashok Raj <ashok.raj@intel.com> wrote:
>
> @@ -219,13 +225,18 @@ static void __devinit MP_processor_info 
>   	cpu_set(num_processors, cpu_possible_map);
>   	num_processors++;
>   
>  -	if ((num_processors > 8) &&
>  -	    APIC_XAPIC(ver) &&
>  -	    (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL))
>  -		def_to_bigsmp = 1;
>  -	else
>  -		def_to_bigsmp = 0;
>  -
>  +	if (CPU_HOTPLUG_ENABLED || (num_processors > 8)) {
>  +		switch (boot_cpu_data.x86_vendor) {
>  +			case X86_VENDOR_INTEL:
>  +				if (!APIC_XAPIC(ver)) {
>  +					def_to_bigsmp = 0;
>  +					break;
>  +				}
>  +				/* If P4 and above fall through */
>  +			case X86_VENDOR_AMD:
>  +				def_to_bigsmp = 1;
>  +		}
>  +	}
>   	bios_cpu_apicid[num_processors - 1] = m->mpc_apicid;

The code you're patching here is changed:

	if ((num_processors > 8) &&
	    ((APIC_XAPIC(ver) &&
	     (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)) ||
	     (boot_cpu_data.x86_vendor == X86_VENDOR_AMD)))
		def_to_bigsmp = 1;

But the fixup was obvious.

While I was there I unindented the body of the switch statement by one tab
stop, as we usually do.

Please avoid sending multiple patches with the same Subject:, thanks.
