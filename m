Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932470AbWCWRbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932470AbWCWRbl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 12:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932536AbWCWRbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 12:31:40 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:49132 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932674AbWCWRbj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 12:31:39 -0500
Date: Thu, 23 Mar 2006 11:30:48 -0600
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@us.ibm.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 3/3] x86-64: Calgary IOMMU - hook it in
Message-ID: <20060323173047.GA30099@us.ibm.com>
References: <20060320084848.GA21729@granada.merseine.nu> <20060320085416.GB21729@granada.merseine.nu> <20060320085641.GC21729@granada.merseine.nu> <200603231736.44223.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603231736.44223.ak@suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 23, 2006 at 05:36:43PM +0100, Andi Kleen wrote:
> On Monday 20 March 2006 09:56, Muli Ben-Yehuda wrote:
> > This patch hooks Calgary into the build and the x86-64 IOMMU
> > initialization paths.
> 
> Needs more description
> 
> > diff -Naurp --exclude-from /home/muli/w/dontdiff iommu_detected/arch/x86_64/Kconfig linux/arch/x86_64/Kconfig
> > --- iommu_detected/arch/x86_64/Kconfig	2006-03-20 09:12:23.000000000 +0200
> > +++ linux/arch/x86_64/Kconfig	2006-03-20 09:30:10.000000000 +0200
> > @@ -372,6 +372,19 @@ config GART_IOMMU
> >  	  and a software emulation used on other systems.
> >  	  If unsure, say Y.
> >  
> > +config CALGARY_IOMMU
> > +	bool "IBM x366 server IOMMU"
> > +	default y
> > +	depends on PCI && MPSC && EXPERIMENTAL
> 
> && MPSC is wrong. First most kernels are GENERIC and then even a K8 optimized
> kernel should support all hardware. Just drop it.

We have a recent modification to this chunk which does both generic and
em64t.  Since IBM only ships this chip on em64t systems, have the option
on amd64 seems wrong.

> > +	help
> > +	  Support for hardware IOMMUs in IBM's xSeries x366 and x460
> > +	  systems. Needed to run systems with more than 3GB of memory
> > +	  properly with 32-bit PCI devices that do not support DAC
> > +	  (Double Address Cycle).  The IOMMU can be turned off at
> > +	  boot time with the iommu=off parameter.  Normally the kernel
> > +	  will make the right choice by iteself.
> > +	  If unsure, say Y.
> 
> If it does isolation then it has much more advantages than that
> by protecting against buggy devices and drivers and is also useful
> for debugging. You should mention that.

Will do.

> > +static int __init pci_iommu_init(void)
> > +{
> > +	int rc = 0;
> > +
> > +#ifdef CONFIG_GART_IOMMU
> > +	rc = gart_iommu_init();
> > +	if (!rc) /* success? */
> > +		return 0;
> > +#endif
> > +#ifdef CONFIG_CALGARY_IOMMU
> > +	rc = calgary_iommu_init();
> > +#endif
> 
> This is weird. Normally I would expect you to detect the calgary thing first
> and only then run the gart_iommu detection if not found. Why this order?
> 
> 
> Fixing that would also not require adding the additional hacks to gart iommu
> you added.

I'll look into this.

> 
> > -/* Must execute after PCI subsystem */
> > -fs_initcall(pci_iommu_init);
> 
> So where is it called now?

It is called in arch/x86_64/kernel/pci-dma.c

> 
> > +#ifdef CONFIG_CALGARY_IOMMU 
> > +		if (!memcmp(from,"calgary=",8)) { 
> > +			calgary_parse_options(from+8);
> > +		}
> > +#endif
> 
> Why does this need to be an early option? 

Because we need to know the size of the translation tables early, so
that we can alloc them from bootmem.

Thanks,
Jon
> 
> 
> -Andi
