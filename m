Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbUEFF14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbUEFF14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 01:27:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUEFF14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 01:27:56 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:32765 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261624AbUEFF1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 01:27:53 -0400
Date: Wed, 05 May 2004 22:27:30 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, jun.nakajima@intel.com,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [PATCH] bug in bigsmp CPU bringup
Message-ID: <494600000.1083821250@[10.10.2.4]>
In-Reply-To: <20040505190332.395cac70.akpm@osdl.org>
References: <88056F38E9E48644A0F562A38C64FB6001BFF5A9@scsmsx403.sc.intel.com> <20040505190332.395cac70.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Len, Martin: please review?

Looked already (in fact I suggested he do that). Looks fine, it's 
exactly the same fix we use for Summit.  Since we're using the other
method instead of the bitmap, this check isn't needed, so we can just
bypass it. This way also has the great advantage of being isolated
to the bigsmp subarch, so it only needs testing there ;-)

Thanks,

M.

> From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
> 
> There is an bug in bigsmp sub-architecture, due to which it will not enable
> all the CPUs when the BIOS-APICIDs are not 0 to n-1 (where n is total
> number of CPUs).  Particularly, only 2 CPU comes up on a system that has 4
> CPUs with BIOS APICID as (0, 1, 6, 7).
> 
> The bug is root caused to check_apicid_present(bit) call in smpboot.c, when
> bigsmp is expecting apicid in place of bit.  check_apicid_present(bit) in
> bigsmp subarchitecture checks the bit with phys_id_present_map (which is
> actually map representing all apicids and not bit).
> 
> One solution is to change check_apicid_present(bit) to
> check_apicid_present(apicid), in smp_boot_cpus().  But, it can affect all
> the other subarchitectures in various subtle ways.  So, here is a simple
> alternate fix (Thanks to Martin Bligh), which solves the above problem.
> 
> 
> ---
> 
>  25-akpm/include/asm-i386/mach-bigsmp/mach_apic.h |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff -puN include/asm-i386/mach-bigsmp/mach_apic.h~bigsmp-cpu-bringup-fix include/asm-i386/mach-bigsmp/mach_apic.h
> --- 25/include/asm-i386/mach-bigsmp/mach_apic.h~bigsmp-cpu-bringup-fix	2004-05-05 19:02:18.299905696 -0700
> +++ 25-akpm/include/asm-i386/mach-bigsmp/mach_apic.h	2004-05-05 19:02:18.302905240 -0700
> @@ -37,9 +37,10 @@ static inline unsigned long check_apicid
>  	return 0;
>  }
>  
> +/* we don't use the phys_cpu_present_map to indicate apicid presence */
>  static inline unsigned long check_apicid_present(int bit) 
>  {
> -	return physid_isset(bit, phys_cpu_present_map);
> +	return 1;
>  }
>  
>  #define apicid_cluster(apicid) (apicid & 0xF0)
> 
> _
> 
> 


