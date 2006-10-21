Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161504AbWJUXNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161504AbWJUXNv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 19:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161502AbWJUXNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 19:13:50 -0400
Received: from mx2.cs.washington.edu ([128.208.2.105]:24765 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S1161160AbWJUXNt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 19:13:49 -0400
Date: Sat, 21 Oct 2006 16:13:28 -0700 (PDT)
From: David Rientjes <rientjes@cs.washington.edu>
To: Andi Kleen <ak@suse.de>
cc: Muli Ben-Yehuda <muli@il.ibm.com>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2/2] x86_64: increase PHB1 split transaction timeout
In-Reply-To: <20061021225053.A213913B62@wotan.suse.de>
Message-ID: <Pine.LNX.4.64N.0610211606430.9839@attu3.cs.washington.edu>
References: <200610221250.493223000@suse.de> <20061021225053.A213913B62@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Oct 2006, Andi Kleen wrote:

> Index: linux/arch/x86_64/kernel/pci-calgary.c
> ===================================================================
> --- linux.orig/arch/x86_64/kernel/pci-calgary.c
> +++ linux/arch/x86_64/kernel/pci-calgary.c
> @@ -52,7 +52,8 @@
>  #define ONE_BASED_CHASSIS_NUM   1
>  
>  /* register offsets inside the host bridge space */
> -#define PHB_CSR_OFFSET		0x0110
> +#define CALGARY_CONFIG_REG	0x0108
> +#define PHB_CSR_OFFSET		0x0110 /* Channel Status */
>  #define PHB_PLSSR_OFFSET	0x0120
>  #define PHB_CONFIG_RW_OFFSET	0x0160
>  #define PHB_IOBASE_BAR_LOW	0x0170
> @@ -83,6 +84,8 @@
>  #define TAR_VALID		0x0000000000000008UL
>  /* CSR (Channel/DMA Status Register) */
>  #define CSR_AGENT_MASK		0xffe0ffff
> +/* CCR (Calgary Configuration Register) */
> +#define CCR_2SEC_TIMEOUT        0x000000000000000EUL
>  
>  #define MAX_NUM_OF_PHBS		8 /* how many PHBs in total? */
>  #define MAX_NUM_CHASSIS		8 /* max number of chassis */
> @@ -732,6 +735,38 @@ static void calgary_watchdog(unsigned lo
>  	}
>  }
>  
> +static void __init calgary_increase_split_completion_timeout(void __iomem *bbar,
> +	unsigned char busnum)
> +{
> +	u64 val64;
> +	void __iomem *target;
> +	unsigned long phb_shift = -1;

The initialization of this to -1 is unclear to me since we fall through to 
BUG_ON() if busno_to_phbid() returns anything under than 0-3.  A shift 
value of MAX_ULONG is never appropriate.

> +	u64 mask;
> +
> +	switch (busno_to_phbid(busnum)) {
> +	case 0: phb_shift = (63 - 19);
> +		break;
> +	case 1: phb_shift = (63 - 23);
> +		break;
> +	case 2: phb_shift = (63 - 27);
> +		break;
> +	case 3: phb_shift = (63 - 35);
> +		break;
> +	default:
> +		BUG_ON(busno_to_phbid(busnum));
> +	}
> +
> +	target = calgary_reg(bbar, CALGARY_CONFIG_REG);
> +	val64 = be64_to_cpu(readq(target));
> +
> +	/* zero out this PHB's timer bits */
> +	mask = ~(0xFUL << phb_shift);
> +	val64 &= mask;
> +	val64 |= (CCR_2SEC_TIMEOUT << phb_shift);
> +	writeq(cpu_to_be64(val64), target);
> +	readq(target); /* flush */
> +}
> +
>  static void __init calgary_enable_translation(struct pci_dev *dev)
>  {
>  	u32 val32;
> @@ -756,6 +791,13 @@ static void __init calgary_enable_transl
>  	writel(cpu_to_be32(val32), target);
>  	readl(target); /* flush */
>  
> +	/*
> +	 * Give split completion a longer timeout on bus 1 for aic94xx
> +	 * http://bugzilla.kernel.org/show_bug.cgi?id=7180
> +	 */
> +	if (busnum == 1)
> +		calgary_increase_split_completion_timeout(bbar, busnum);
> +
>  	init_timer(&tbl->watchdog_timer);
>  	tbl->watchdog_timer.function = &calgary_watchdog;
>  	tbl->watchdog_timer.data = (unsigned long)dev;
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
