Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262752AbVHDWL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262752AbVHDWL0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 18:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbVHDWLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 18:11:16 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:51663 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262755AbVHDWIf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 18:08:35 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Matt Tolentino <metolent@snoqualmie.dp.intel.com>
Subject: Re: [patch] fix ACPI table discovery from EFI for x86
Date: Thu, 4 Aug 2005 16:07:35 -0600
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, linux-ia64@vger.kernel.org,
       tony.luck@intel.com
References: <200507140109.j6E19a58013012@snoqualmie.dp.intel.com>
In-Reply-To: <200507140109.j6E19a58013012@snoqualmie.dp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508041607.35914.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 July 2005 7:09 pm, Matt Tolentino wrote:
> This patch addresses a problem on x86 EFI systems with larger memory
> configurations.  Up until now, we've relied on the fact that the 
> ACPI RSDT would reside somewhere in low memory that could be permanently 
> mapped in kernel address space - so __va() has been sufficient.  However,
> on EFI systems, the RSDT is often anywhere in the lower 4GB of physical
> address space.  So, we may need to remap it on x86 systems.  

The hunk below breaks HP rx7620, rx8620, and Superdome (all ia64)
systems.  This is from 2.6.13-rc4-mm1, in

    acpi-fix-table-discovery-from-efi-for-x86.patch

> @@ -187,7 +187,9 @@ acpi_status
>  acpi_os_map_memory(acpi_physical_address phys, acpi_size size, void __iomem **virt)
>  {
>  	if (efi_enabled) {
> -		if (EFI_MEMORY_WB & efi_mem_attributes(phys)) {
> +		/* determine whether or not we need to call ioremap */
> +		if ((EFI_MEMORY_WB & efi_mem_attributes(phys)) && 
> +			((unsigned long)phys < (unsigned long)__pa(high_memory))) {
>  			*virt = (void __iomem *) phys_to_virt(phys);
>  		} else {
>  			*virt = ioremap(phys, size);

If "phys >= __pa(high_memory)", we use ioremap(), but there's no
guarantee that phys is in memory that supports UC.  On the systems
I mentioned, phys is above high_memory, but in memory that only
supports WB, which leads to an MCA.

Here's a bit of the memmap:

available  0000000100000000-00000007FDFFFFFF  00000000006FE000 0000000000000008
reserved   00000040000A0000-00000040000BFFFF  0000000000000020 0000000000000008
available  0000004080000000-00000040FED9FFFF  000000000007EDA0 0000000000000008
BS_data    00000040FEDA0000-00000040FEDA1FFF  0000000000000002 0000000000000008
available  00000040FEDA2000-00000040FEDA7FFF  0000000000000006 0000000000000008
BS_data    00000040FEDA8000-00000040FF1FFFFF  0000000000000458 0000000000000008
available  00000040FF200000-00000040FF555FFF  0000000000000356 0000000000000008
RT_code    00000040FF556000-00000040FF5BFFFF  000000000000006A 8000000000000008
BS_code    00000040FF5C0000-00000040FF5FFFFF  0000000000000040 0000000000000008
available  00000040FF600000-00000040FF641FFF  0000000000000042 0000000000000008
RT_code    00000040FF642000-00000040FF67FFFF  000000000000003E 8000000000000008
available  00000040FF680000-00000040FF7DFFFF  0000000000000160 0000000000000008
RT_data    00000040FF7E0000-00000040FF7FFFFF  0000000000000020 8000000000000008
RT_code    00000703FF000000-00000703FFFFFFFF  0000000000001000 8000000000000008
PAL_code   00000723FF000000-00000723FF03FFFF  0000000000000040 8000000000000008
RT_code    00000723FF040000-00000723FFBAFFFF  0000000000000B70 8000000000000008
reserved   00000723FFBB0000-00000723FFE8FFFF  00000000000002E0 8000000000000008
RT_code    00000723FFE90000-00000723FFFFFFFF  0000000000000170 8000000000000008
MemMapIO   00000F0000000000-00000F003FFFFFFF  0000000000040000 8000000000000001

The firmware tables are up in the reserved section at 0x723FFBB0000:

    EFI v1.10 by HP: SALsystab=0x723ff7e7640 ACPI 2.0=0x723ffbb0000 HCDP=0x723ffbf27f0 SMBIOS=0x7fffe000

But high_memory is only 0x00000040ff000000 because there's no available
memory for the OS to use above that point (there are a few pages marked
"available", but we ignore them to avoid attribute aliasing on ia64).

So we erroneously try to ioremap the ACPI tables, which causes uncached
accesses to them, which blows up because they really live in memory that
doesn't support UC.
