Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751075AbWCWRUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbWCWRUV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCWRUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:20:21 -0500
Received: from ns2.suse.de ([195.135.220.15]:17085 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751075AbWCWRUR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:20:17 -0500
From: Andi Kleen <ak@suse.de>
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH 3/3] x86-64: Calgary IOMMU - hook it in
Date: Thu, 23 Mar 2006 17:36:43 +0100
User-Agent: KMail/1.9.1
Cc: Jon Mason <jdmason@us.ibm.com>, Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
References: <20060320084848.GA21729@granada.merseine.nu> <20060320085416.GB21729@granada.merseine.nu> <20060320085641.GC21729@granada.merseine.nu>
In-Reply-To: <20060320085641.GC21729@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603231736.44223.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 March 2006 09:56, Muli Ben-Yehuda wrote:
> This patch hooks Calgary into the build and the x86-64 IOMMU
> initialization paths.

Needs more description

> diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/Kconfig linux/arch/x86_64/Kconfig
> --- iommu_detected/arch/x86_64/Kconfig	2006-03-20 09:12:23.000000000 +0200
> +++ linux/arch/x86_64/Kconfig	2006-03-20 09:30:10.000000000 +0200
> @@ -372,6 +372,19 @@ config GART_IOMMU
>  	  and a software emulation used on other systems.
>  	  If unsure, say Y.
>  
> +config CALGARY_IOMMU
> +	bool "IBM x366 server IOMMU"
> +	default y
> +	depends on PCI && MPSC && EXPERIMENTAL

&& MPSC is wrong. First most kernels are GENERIC and then even a K8 optimized
kernel should support all hardware. Just drop it.
 
> +	help
> +	  Support for hardware IOMMUs in IBM's xSeries x366 and x460
> +	  systems. Needed to run systems with more than 3GB of memory
> +	  properly with 32-bit PCI devices that do not support DAC
> +	  (Double Address Cycle).  The IOMMU can be turned off at
> +	  boot time with the iommu=off parameter.  Normally the kernel
> +	  will make the right choice by iteself.
> +	  If unsure, say Y.

If it does isolation then it has much more advantages than that
by protecting against buggy devices and drivers and is also useful
for debugging. You should mention that.

> +static int __init pci_iommu_init(void)
> +{
> +	int rc = 0;
> +
> +#ifdef CONFIG_GART_IOMMU
> +	rc = gart_iommu_init();
> +	if (!rc) /* success? */
> +		return 0;
> +#endif
> +#ifdef CONFIG_CALGARY_IOMMU
> +	rc = calgary_iommu_init();
> +#endif

This is weird. Normally I would expect you to detect the calgary thing first
and only then run the gart_iommu detection if not found. Why this order?


Fixing that would also not require adding the additional hacks to gart iommu
you added.

> -/* Must execute after PCI subsystem */
> -fs_initcall(pci_iommu_init);

So where is it called now?

> +#ifdef CONFIG_CALGARY_IOMMU 
> +		if (!memcmp(from,"calgary=",8)) { 
> +			calgary_parse_options(from+8);
> +		}
> +#endif

Why does this need to be an early option? 


-Andi
