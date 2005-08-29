Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751266AbVH2SHa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbVH2SHa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 14:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVH2SHa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 14:07:30 -0400
Received: from embeddededge.com ([209.113.146.155]:47110 "EHLO
	penguin.netx4.com") by vger.kernel.org with ESMTP id S1751266AbVH2SH3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 14:07:29 -0400
In-Reply-To: <Pine.LNX.4.61.0508291239180.30997@nylon.am.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467302BEB583@zch01exm40.ap.freescale.net> <Pine.LNX.4.61.0508291239180.30997@nylon.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e62c7e8ed239c5544e044bc5f0054bf3@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc: Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Li Tony-r64360 <Tony.Li@freescale.com>,
       linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: [PATCH] ppc32 :Added PCI support for MPC83xx
Date: Mon, 29 Aug 2005 14:07:05 -0400
To: Kumar Gala <galak@freescale.com>
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Aug 29, 2005, at 1:42 PM, Kumar Gala wrote:

> diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c 
> b/arch/ppc/platforms/83xx/mpc834x_sys.c
> --- a/arch/ppc/platforms/83xx/mpc834x_sys.c
> +++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
> @@ -62,9 +62,29 @@ extern unsigned long total_memory;	/* in
>  unsigned char __res[sizeof (bd_t)];
>
>  #ifdef CONFIG_PCI
> -#error "PCI is not supported"
> -/* NEED mpc83xx_map_irq & mpc83xx_exclude_device
> -   see platforms/85xx/mpc85xx_ads_common.c */
> +int
> +mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned 
> char pin)
> +{
> +	static char pci_irq_table[][4] =
> +	    /*
> +	     *      PCI IDSEL/INTPIN->INTLINE
> +	     *       A      B      C      D
> +	     */
> +	{
> +		{PIRQA, PIRQB,  PIRQC,  PIRQD}, /* idsel 0x11 */
> +		{PIRQC, PIRQD,  PIRQA,  PIRQB}, /* idsel 0x12 */
> +		{PIRQD, PIRQA,  PIRQB,  PIRQC}  /* idsel 0x13 */
> +	};
> +
> +	const long min_idsel = 0x11, max_idsel = 0x13, irqs_per_slot = 4;
> +	return PCI_IRQ_TABLE_LOOKUP;
> +}
> +
> +int
> +mpc83xx_exclude_device(u_char bus, u_char devfn)
> +{
> +	return PCIBIOS_SUCCESSFUL;
> +}
>  #endif /* CONFIG_PCI */

Shouldn't this be in the PQ2FADS board specific file?  Not everyone
is going to map IDSELs and IRQs this way.

> diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h 
> b/arch/ppc/platforms/83xx/mpc834x_sys.h
> --- a/arch/ppc/platforms/83xx/mpc834x_sys.h
> +++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
> @@ -26,7 +26,7 @@
>  #define VIRT_IMMRBAR		((uint)0xfe000000)
>
>  #define BCSR_PHYS_ADDR		((uint)0xf8000000)
> -#define BCSR_SIZE		((uint)(32 * 1024))
> +#define BCSR_SIZE		((uint)(128 * 1024))
>
>  #define BCSR_MISC_REG2_OFF	0x07
>  #define BCSR_MISC_REG2_PORESET	0x01
> @@ -34,23 +34,25 @@
>  #define BCSR_MISC_REG3_OFF	0x08
>  #define BCSR_MISC_REG3_CNFLOCK	0x80
>
> -#ifdef CONFIG_PCI
> -/* PCI interrupt controller */
> -#define PIRQA        MPC83xx_IRQ_IRQ4
> -#define PIRQB        MPC83xx_IRQ_IRQ5
> -#define PIRQC        MPC83xx_IRQ_IRQ6
> -#define PIRQD        MPC83xx_IRQ_IRQ7
> -
> -#define MPC834x_SYS_PCI1_LOWER_IO        0x00000000
> -#define MPC834x_SYS_PCI1_UPPER_IO        0x00ffffff
> -
> -#define MPC834x_SYS_PCI1_LOWER_MEM       0x80000000
> -#define MPC834x_SYS_PCI1_UPPER_MEM       0x9fffffff
> -
> -#define MPC834x_SYS_PCI1_IO_BASE         0xe2000000
> -#define MPC834x_SYS_PCI1_MEM_OFFSET      0x00000000
> -
> -#define MPC834x_SYS_PCI1_IO_SIZE         0x01000000
> -#endif /* CONFIG_PCI */
> +#define PIRQA	MPC83xx_IRQ_EXT4
> +#define PIRQB	MPC83xx_IRQ_EXT5
> +#define PIRQC	MPC83xx_IRQ_EXT6
> +#define PIRQD	MPC83xx_IRQ_EXT7

The same thing with these BCSRs and IRQ mappings ....  FADS specific.

> +
> +#define MPC83xx_PCI1_LOWER_IO	0x00000000
> +#define MPC83xx_PCI1_UPPER_IO	0x00ffffff
> +#define MPC83xx_PCI1_LOWER_MEM	0x80000000
> +#define MPC83xx_PCI1_UPPER_MEM	0x9fffffff
> +#define MPC83xx_PCI1_IO_BASE	0xe2000000
> +#define MPC83xx_PCI1_MEM_OFFSET	0x00000000
> +#define MPC83xx_PCI1_IO_SIZE	0x01000000
> +
> +#define MPC83xx_PCI2_LOWER_IO	0x00000000
> +#define MPC83xx_PCI2_UPPER_IO	0x00ffffff
> +#define MPC83xx_PCI2_LOWER_MEM	0xa0000000
> +#define MPC83xx_PCI2_UPPER_MEM	0xbfffffff
> +#define MPC83xx_PCI2_IO_BASE	0xe3000000
> +#define MPC83xx_PCI2_MEM_OFFSET	0x00000000
> +#define MPC83xx_PCI2_IO_SIZE	0x01000000

These should be generic to everyone, and could be
in the ppc83xx_pci.h file.  Maybe surround them with
#ifndef so a board specific file could move the addresses
if they wanted?  I don't think an #ifndef is needed for each
define, maybe just #fndef MPC83xx_PCI1_LOWER_MEM
and let the board define everything if they want anything different.

  Thanks.

	-- Dan

