Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbUCLXbn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:31:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263042AbUCLX3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:29:10 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:64966 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263024AbUCLX0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:26:41 -0500
Date: Fri, 12 Mar 2004 18:26:39 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: long <tlnguyen@snoqualmie.dp.intel.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       davidm@napali.hpl.hp.com, grep@kroah.com, jgarzik@pobox.com,
       jun.nakajima@intel.com, tom.l.nguyen@intel.com, tony.luck@intel.com
Subject: Re: RE[PATCH]2.6.4-rc3 MSI Support for IA64
In-Reply-To: <200403130008.i2D08SMQ011709@snoqualmie.dp.intel.com>
Message-ID: <Pine.LNX.4.58.0403121743310.29087@montezuma.fsmlabs.com>
References: <200403130008.i2D08SMQ011709@snoqualmie.dp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Mar 2004, long wrote:

> Thanks for all inputs received from the previous patch posted a few
> weeks ago. Based on Zwane Mwaikambo's suggestion of using a
> standard name like assign_irq_vector(), we made some changes to
> the previous posted patch. Attached is an update version, based on
> kernel 2.6.4-rc3.

Thanks for doing this, i have a few comments;

> diff -urN linux-2.6.4-rc3/arch/ia64/kernel/irq_ia64.c linux-2.6.4-rc3-msi/arch/ia64/kernel/irq_ia64.c
> --- linux-2.6.4-rc3/arch/ia64/kernel/irq_ia64.c	2004-03-09 19:00:26.000000000 -0500
> +++ linux-2.6.4-rc3-msi/arch/ia64/kernel/irq_ia64.c	2004-03-11 14:52:57.000000000 -0500
> @@ -60,12 +60,18 @@
>  int
>  ia64_alloc_vector (void)
>  {
> +#ifdef CONFIG_PCI_USE_VECTOR
> +	extern int assign_irq_vector(int irq);
> +
> +	return assign_irq_vector(AUTO_ASSIGN);
> +#else
>  	static int next_vector = IA64_FIRST_DEVICE_VECTOR;
>
>  	if (next_vector > IA64_LAST_DEVICE_VECTOR)
>  		/* XXX could look for sharable vectors instead of panic'ing... */
>  		panic("ia64_alloc_vector: out of interrupt vectors!");
>  	return next_vector++;
> +#endif
>  }

This one is slightly confusing readability wise since ia64 already does
the vector based interrupt numbering. Perhaps CONFIG_PCI_USE_VECTOR should
really be CONFIG_MSI but that's up to you. I wonder if we could
consolidate these vector allocators as assign_irq_vector(AUTO_ASSIGN) has
the same semantics as ia64_alloc_vector() and the one for i386 is also
almost the same as its MSI ilk.

> +static inline int vector_resources(void)
> +{
> + 	int res;
> +#ifndef CONFIG_IA64
> + 	int i, repeat;
> + 	for (i = NR_REPEATS; i > 0; i--) {
> + 		if ((FIRST_DEVICE_VECTOR + i * 8) > FIRST_SYSTEM_VECTOR)
> + 			continue;
> + 		break;
> + 	}
> + 	i++;
> + 	repeat = (FIRST_SYSTEM_VECTOR - FIRST_DEVICE_VECTOR)/i;
> + 	res = i * repeat - NR_RESERVED_VECTORS + 1;
>  #else
> -extern void restore_ioapic_irq_handler(int irq);
> + 	res = LAST_DEVICE_VECTOR - FIRST_DEVICE_VECTOR - 1;
>  #endif
> +
> + 	return res;
> +}

Is this supposed to return number of vectors available for external
devices? Also regarding vector allocation, assign_irq_vector() in
drivers/pci/msi.c only can allocate 166 vectors before going -ENOSPC is
this intentional?

Thanks,
	Zwane
