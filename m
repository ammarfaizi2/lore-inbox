Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWINXFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWINXFb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 19:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWINXFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 19:05:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:57028 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932109AbWINXF3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 19:05:29 -0400
Date: Thu, 14 Sep 2006 19:04:42 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: keith mannthey <kmannth@us.ibm.com>
Cc: dave hansen <haveblue@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in get_memcfg_from_srat
Message-ID: <20060914230442.GE25044@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1158113895.9562.13.camel@keithlap> <1158269696.15745.5.camel@keithlap> <1158271274.24414.6.camel@localhost.localdomain> <1158273830.15745.14.camel@keithlap>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1158273830.15745.14.camel@keithlap>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2006 at 03:43:50PM -0700, keith mannthey wrote:
> On Thu, 2006-09-14 at 15:01 -0700, Dave Hansen wrote:
> > Keith, can you get printouts of the phys_addrs it is trying to use
> > there?  In fact, can you print out all of the calls to all of the
> > functions and all of their arguments in that file?
> The call to boot_ioremap is always the same
> 
> (works)
>  BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
>  BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000eff91840 (usable)
>  BIOS-e820: 00000000eff91840 - 00000000eff9c340 (ACPI data)
>  BIOS-e820: 00000000eff9c340 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 00000001d0000000 (usable)
> Node: 0, start_pfn: 0, end_pfn: 156
> Node: 0, start_pfn: 256, end_pfn: 982929
> Node: 0, start_pfn: 1048576, end_pfn: 1900544
> get_memcfg_from_srat: assigning address to rsdp fdfc0
> RSD PTR  v0 [IBM   ]
> rsdp->rsdt_address eff9c2c0
> boot_ioremap phys_addr = eff9c2c0 long = 44
> boot_ioremap and I return c04da2c0
> rsdt = c04da2c0 header is RSDT4
> Begin SRAT table scan....
> .... 
> 
> (no works)
>  BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
>  BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 00000000eff91840 (usable)
>  BIOS-e820: 00000000eff91840 - 00000000eff9c340 (ACPI data)
>  BIOS-e820: 00000000eff9c340 - 00000000f0000000 (reserved)
>  BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
>  BIOS-e820: 0000000100000000 - 00000001d0000000 (usable)
> Node: 0, start_pfn: 0, end_pfn: 156
> Node: 0, start_pfn: 256, end_pfn: 982929
> Node: 0, start_pfn: 1048576, end_pfn: 1900544
> get_memcfg_from_srat: assigning address to rsdp fdfc0
> RSD PTR  v0 [IBM   ]
> rsdp->rsdt_address eff9c2c0
> boot_ioremap phys_addr = eff9c2c0 long = 44
> boot_ioremap and I return c13db2c0
> rsdt = c13db2c0 header is
> ACPI: RSDT signature incorrect
> failed to get NUMA memory information from SRAT table
> NUMA - single node, flat memory mode
> ...
> 
> 
> > Also, it might be possible that this data somehow got pushed above the
> > 8MB boundary.  Getting me those addresses will let me check that.
> 
> I think the kernel starts @ 16mb with i386 kdump.  

Yes, generally we start at non 1MB addresses for kdump. But normal cases
also we should be able to boot at physical addr 16MB.

I think I know what is going on wrong here. boot_ioremap() is assuming 
that only first 8MB of physical memory is being mapped and while
calculating the index into page table (boot_pte_index) we will truncate
any higher address bits.

When we compile the kernel for address 16MB, initial boot page tables
map much more physical memory (roughly 20MB, assuming kernel size to
be 4MB). So roughly 5 page table pages are required, say pg0, pg1, pg2
pg3 and pg4. Kernel will most likely be mapped in pg4 and pg5. But
current boot_ioremap() logic will map the new physical address either
in pg0 or pg1. Hence we don't update the right address and end up 
reading wrong data.

I hope, I understand the code right. :-)

Thanks
Vivek
