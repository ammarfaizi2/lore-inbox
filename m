Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWIAIVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWIAIVi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 04:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWIAIVh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 04:21:37 -0400
Received: from ns2.suse.de ([195.135.220.15]:8128 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751271AbWIAIVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 04:21:35 -0400
From: Andi Kleen <ak@suse.de>
To: adurbin@google.com
Subject: Re: [PATCH] i386/x86_64: add HPET(s) into resource map
Date: Fri, 1 Sep 2006 10:21:25 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
References: <20060831235245.GC21338@google.com>
In-Reply-To: <20060831235245.GC21338@google.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609011021.25737.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 September 2006 01:52, adurbin@google.com wrote:
> 
> Add HPET(s) into resource map. This will allow for the HPET(s) to be
> visibile within /proc/iomem.

Applied thanks.

Actually it would be more for Len Brown/linux-acpi (cc'ed with full quote) but I'll take
it for now.

-Andi

> 
> Signed-off-by: Aaron Durbin <adurbin@google.com>
> 
> ---
> 
> diff --git a/arch/i386/kernel/acpi/boot.c b/arch/i386/kernel/acpi/boot.c
> index ee003bc..d3fafb2 100644
> --- a/arch/i386/kernel/acpi/boot.c
> +++ b/arch/i386/kernel/acpi/boot.c
> @@ -29,6 +29,8 @@ #include <linux/efi.h>
>  #include <linux/module.h>
>  #include <linux/dmi.h>
>  #include <linux/irq.h>
> +#include <linux/bootmem.h>
> +#include <linux/ioport.h>
>  
>  #include <asm/pgtable.h>
>  #include <asm/io_apic.h>
> @@ -579,6 +581,8 @@ #ifdef CONFIG_HPET_TIMER
>  static int __init acpi_parse_hpet(unsigned long phys, unsigned long size)
>  {
>  	struct acpi_table_hpet *hpet_tbl;
> +	struct resource *hpet_res;
> +	resource_size_t res_start;
>  
>  	if (!phys || !size)
>  		return -EINVAL;
> @@ -594,12 +598,26 @@ static int __init acpi_parse_hpet(unsign
>  		       "memory.\n");
>  		return -1;
>  	}
> +
> +#define HPET_RESOURCE_NAME_SIZE 9
> +	hpet_res = alloc_bootmem(sizeof(*hpet_res) + HPET_RESOURCE_NAME_SIZE);
> +	if (hpet_res) {
> +		memset(hpet_res, 0, sizeof(*hpet_res));
> +		hpet_res->name = (void *)&hpet_res[1];
> +		hpet_res->flags = IORESOURCE_MEM | IORESOURCE_BUSY;
> +		snprintf((char *)hpet_res->name, HPET_RESOURCE_NAME_SIZE, 
> +			 "HPET %u", hpet_tbl->number);
> +		hpet_res->end = (1 * 1024) - 1;
> +	}
> +
>  #ifdef	CONFIG_X86_64
>  	vxtime.hpet_address = hpet_tbl->addr.addrl |
>  	    ((long)hpet_tbl->addr.addrh << 32);
>  
>  	printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
>  	       hpet_tbl->id, vxtime.hpet_address);
> +
> +	res_start = vxtime.hpet_address;
>  #else				/* X86 */
>  	{
>  		extern unsigned long hpet_address;
> @@ -607,9 +625,17 @@ #else				/* X86 */
>  		hpet_address = hpet_tbl->addr.addrl;
>  		printk(KERN_INFO PREFIX "HPET id: %#x base: %#lx\n",
>  		       hpet_tbl->id, hpet_address);
> +
> +		res_start = hpet_address;
>  	}
>  #endif				/* X86 */
>  
> +	if (hpet_res) {
> +		hpet_res->start = res_start;
> +		hpet_res->end += res_start;
> +		insert_resource(&iomem_resource, hpet_res);
> +	}
> +
>  	return 0;
>  }
>  #else
> 
