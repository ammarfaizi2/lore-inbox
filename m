Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751133AbWDXTDR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751133AbWDXTDR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 15:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750930AbWDXTDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 15:03:16 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47799 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751133AbWDXTDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 15:03:14 -0400
Date: Mon, 24 Apr 2006 14:02:42 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Neil Turton <nturton@level5networks.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: PROBLEM/PATCH: free_iommu leaks entries (x86_64)
Message-ID: <20060424190242.GD24108@us.ibm.com>
References: <444D10AA.6050504@level5networks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444D10AA.6050504@level5networks.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This problem has been already fixed.  See
http://www.x86-64.org/lists/discuss/msg08774.html

That patch is already in 2.6.17-rc2.

Thanks,
Jon


On Mon, Apr 24, 2006 at 06:53:46PM +0100, Neil Turton wrote:
> I've recently tracked down a problem where the IOMMU fills up.  The
> machine is a 2 cpu x86_64 (Opteron) with 6G of RAM and is doing lots of
> network activity on a 32-bit bus mastering PCI card at the time.  The
> following message gets written to the console and the system ends up in
> a partly-functional state.
> 
>    PCI-DMA: Out of IOMMU space for 53248 bytes at device 0000:03:05.0
>    end_request: I/O error, dev sda, sector 84087213
> 
> Since sda holds the root filesystem and swap, that explains the loss of
> functionality.
> 
> The problem is caused by a race condition in free_iommu in pci-gart.c.
> It looks like it has been optimized for the case of single page
> allocations to avoid taking iommu_bitmap_lock, however this isn't valid
> on an SMP machine since the atomic instruction in clear_bit can be
> inserted into the middle of one of the non-atomic (read, modify, write)
> instructions in __clear_bit_string or set_bit_string.   The effect of
> this is that the value written by the non-atomic instruction overwrites
> the value written by the atomic instruction and so that IOMMU entry
> doesn't get freed.  After running for some time with heavy I/O, the
> IOMMU gets full and the system grinds to a halt.
> 
> I've attached a patch against 2.6.16.9 to remove the unsafe optimization.
> 
> Cheers, Neil.
> 
> The IOMMU boot messages were:
>    Checking aperture...
>    CPU 0: aperture @ f2000000 size 32 MB
>    Aperture from northbridge cpu 0 too small (32 MB)
>    No AGP bridge found
>    Your BIOS doesn't leave a aperture memory hole
>    Please enable the IOMMU option in the BIOS setup
>    This costs you 64 MB of RAM
>    Mapping aperture over 65536 KB of RAM @ 4000000
> ...
>    PCI-DMA: Disabling AGP.
>    PCI-DMA: aperture base @ 4000000 size 65536 KB
>    PCI-DMA: Reserving 64MB of IOMMU area in the AGP aperture
> 
> 

> diff -ur linux-2.6.16.9/arch/x86_64/kernel/pci-gart.c linux-2.6.16.9-ndt/arch/x86_64/kernel/pci-gart.c
> --- linux-2.6.16.9/arch/x86_64/kernel/pci-gart.c	2006-04-19 07:10:14.000000000 +0100
> +++ linux-2.6.16.9-ndt/arch/x86_64/kernel/pci-gart.c	2006-04-24 15:53:33.000000000 +0100
> @@ -114,10 +114,6 @@
>  static void free_iommu(unsigned long offset, int size)
>  { 
>  	unsigned long flags;
> -	if (size == 1) { 
> -		clear_bit(offset, iommu_gart_bitmap); 
> -		return;
> -	}
>  	spin_lock_irqsave(&iommu_bitmap_lock, flags);
>  	__clear_bit_string(iommu_gart_bitmap, offset, size);
>  	spin_unlock_irqrestore(&iommu_bitmap_lock, flags);
> 

