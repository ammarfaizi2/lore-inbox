Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbWIKX4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbWIKX4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWIKX4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:56:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:26054 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965182AbWIKX4T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:56:19 -0400
Message-ID: <4505F79E.6070302@garzik.org>
Date: Mon, 11 Sep 2006 19:56:14 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
CC: neilb@suse.de, linux-raid@vger.kernel.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, christopher.leech@intel.com
Subject: Re: [PATCH 18/19] iop3xx: Give Linux control over PCI (ATU) initialization
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com> <20060911231910.4737.16639.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060911231910.4737.16639.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Currently the iop3xx platform support code assumes that RedBoot is the
> bootloader and has already initialized the ATU.  Linux should handle this
> initialization for three reasons:
> 
> 1/ The memory map that RedBoot sets up is not optimal (page_to_dma and
> virt_to_phys return different addresses).  The effect of this is that using
> the dma mapping API for the internal bus dma units generates pci bus
> addresses that are incorrect for the internal bus.
> 
> 2/ Not all iop platforms use RedBoot
> 
> 3/ If the ATU is already initialized it indicates that the iop is an add-in
> card in another host, it does not own the PCI bus, and should not be
> re-initialized.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
>  arch/arm/mach-iop32x/Kconfig         |    8 ++
>  arch/arm/mach-iop32x/ep80219.c       |    4 +
>  arch/arm/mach-iop32x/iq31244.c       |    5 +
>  arch/arm/mach-iop32x/iq80321.c       |    5 +
>  arch/arm/mach-iop33x/Kconfig         |    8 ++
>  arch/arm/mach-iop33x/iq80331.c       |    5 +
>  arch/arm/mach-iop33x/iq80332.c       |    4 +
>  arch/arm/plat-iop/pci.c              |  140 ++++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-iop32x/iop32x.h |    9 ++
>  include/asm-arm/arch-iop32x/memory.h |    4 -
>  include/asm-arm/arch-iop33x/iop33x.h |   10 ++
>  include/asm-arm/arch-iop33x/memory.h |    4 -
>  include/asm-arm/hardware/iop3xx.h    |   20 ++++-
>  13 files changed, 214 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/arm/mach-iop32x/Kconfig b/arch/arm/mach-iop32x/Kconfig
> index 05549a5..b2788e3 100644
> --- a/arch/arm/mach-iop32x/Kconfig
> +++ b/arch/arm/mach-iop32x/Kconfig
> @@ -22,6 +22,14 @@ config ARCH_IQ80321
>  	  Say Y here if you want to run your kernel on the Intel IQ80321
>  	  evaluation kit for the IOP321 processor.
>  
> +config IOP3XX_ATU
> +        bool "Enable the PCI Controller"
> +        default y
> +        help
> +          Say Y here if you want the IOP to initialize its PCI Controller.
> +          Say N if the IOP is an add in card, the host system owns the PCI
> +          bus in this case.
> +
>  endmenu
>  
>  endif
> diff --git a/arch/arm/mach-iop32x/ep80219.c b/arch/arm/mach-iop32x/ep80219.c
> index f616d3e..1a5c586 100644
> --- a/arch/arm/mach-iop32x/ep80219.c
> +++ b/arch/arm/mach-iop32x/ep80219.c
> @@ -100,7 +100,7 @@ ep80219_pci_map_irq(struct pci_dev *dev,
>  
>  static struct hw_pci ep80219_pci __initdata = {
>  	.swizzle	= pci_std_swizzle,
> -	.nr_controllers = 1,
> +	.nr_controllers = 0,
>  	.setup		= iop3xx_pci_setup,
>  	.preinit	= iop3xx_pci_preinit,
>  	.scan		= iop3xx_pci_scan_bus,
> @@ -109,6 +109,8 @@ static struct hw_pci ep80219_pci __initd
>  
>  static int __init ep80219_pci_init(void)
>  {
> +	if (iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE)
> +		ep80219_pci.nr_controllers = 1;
>  #if 0
>  	if (machine_is_ep80219())
>  		pci_common_init(&ep80219_pci);
> diff --git a/arch/arm/mach-iop32x/iq31244.c b/arch/arm/mach-iop32x/iq31244.c
> index 967a696..25d5d62 100644
> --- a/arch/arm/mach-iop32x/iq31244.c
> +++ b/arch/arm/mach-iop32x/iq31244.c
> @@ -97,7 +97,7 @@ iq31244_pci_map_irq(struct pci_dev *dev,
>  
>  static struct hw_pci iq31244_pci __initdata = {
>  	.swizzle	= pci_std_swizzle,
> -	.nr_controllers = 1,
> +	.nr_controllers = 0,
>  	.setup		= iop3xx_pci_setup,
>  	.preinit	= iop3xx_pci_preinit,
>  	.scan		= iop3xx_pci_scan_bus,
> @@ -106,6 +106,9 @@ static struct hw_pci iq31244_pci __initd
>  
>  static int __init iq31244_pci_init(void)
>  {
> +	if (iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE)
> +		iq31244_pci.nr_controllers = 1;
> +
>  	if (machine_is_iq31244())
>  		pci_common_init(&iq31244_pci);
>  
> diff --git a/arch/arm/mach-iop32x/iq80321.c b/arch/arm/mach-iop32x/iq80321.c
> index ef4388c..cdd2265 100644
> --- a/arch/arm/mach-iop32x/iq80321.c
> +++ b/arch/arm/mach-iop32x/iq80321.c
> @@ -97,7 +97,7 @@ iq80321_pci_map_irq(struct pci_dev *dev,
>  
>  static struct hw_pci iq80321_pci __initdata = {
>  	.swizzle	= pci_std_swizzle,
> -	.nr_controllers = 1,
> +	.nr_controllers = 0,
>  	.setup		= iop3xx_pci_setup,
>  	.preinit	= iop3xx_pci_preinit,
>  	.scan		= iop3xx_pci_scan_bus,
> @@ -106,6 +106,9 @@ static struct hw_pci iq80321_pci __initd
>  
>  static int __init iq80321_pci_init(void)
>  {
> +	if (iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE)
> +		iq80321_pci.nr_controllers = 1;
> +
>  	if (machine_is_iq80321())
>  		pci_common_init(&iq80321_pci);
>  
> diff --git a/arch/arm/mach-iop33x/Kconfig b/arch/arm/mach-iop33x/Kconfig
> index 9aa016b..45598e0 100644
> --- a/arch/arm/mach-iop33x/Kconfig
> +++ b/arch/arm/mach-iop33x/Kconfig
> @@ -16,6 +16,14 @@ config MACH_IQ80332
>  	  Say Y here if you want to run your kernel on the Intel IQ80332
>  	  evaluation kit for the IOP332 chipset.
>  
> +config IOP3XX_ATU
> +	bool "Enable the PCI Controller"
> +	default y
> +	help
> +	  Say Y here if you want the IOP to initialize its PCI Controller.
> +	  Say N if the IOP is an add in card, the host system owns the PCI
> +	  bus in this case.
> +
>  endmenu
>  
>  endif
> diff --git a/arch/arm/mach-iop33x/iq80331.c b/arch/arm/mach-iop33x/iq80331.c
> index 7714c94..3807000 100644
> --- a/arch/arm/mach-iop33x/iq80331.c
> +++ b/arch/arm/mach-iop33x/iq80331.c
> @@ -78,7 +78,7 @@ iq80331_pci_map_irq(struct pci_dev *dev,
>  
>  static struct hw_pci iq80331_pci __initdata = {
>  	.swizzle	= pci_std_swizzle,
> -	.nr_controllers = 1,
> +	.nr_controllers = 0,
>  	.setup		= iop3xx_pci_setup,
>  	.preinit	= iop3xx_pci_preinit,
>  	.scan		= iop3xx_pci_scan_bus,
> @@ -87,6 +87,9 @@ static struct hw_pci iq80331_pci __initd
>  
>  static int __init iq80331_pci_init(void)
>  {
> +	if (iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE)
> +		iq80331_pci.nr_controllers = 1;
> +
>  	if (machine_is_iq80331())
>  		pci_common_init(&iq80331_pci);
>  
> diff --git a/arch/arm/mach-iop33x/iq80332.c b/arch/arm/mach-iop33x/iq80332.c
> index a3fa7f8..8780d55 100644
> --- a/arch/arm/mach-iop33x/iq80332.c
> +++ b/arch/arm/mach-iop33x/iq80332.c
> @@ -93,6 +93,10 @@ static struct hw_pci iq80332_pci __initd
>  
>  static int __init iq80332_pci_init(void)
>  {
> +
> +	if (iop3xx_get_init_atu() == IOP3XX_INIT_ATU_ENABLE)
> +		iq80332_pci.nr_controllers = 1;
> +
>  	if (machine_is_iq80332())
>  		pci_common_init(&iq80332_pci);
>  
> diff --git a/arch/arm/plat-iop/pci.c b/arch/arm/plat-iop/pci.c
> index e647812..19aace9 100644
> --- a/arch/arm/plat-iop/pci.c
> +++ b/arch/arm/plat-iop/pci.c
> @@ -55,7 +55,7 @@ static u32 iop3xx_cfg_address(struct pci
>   * This routine checks the status of the last configuration cycle.  If an error
>   * was detected it returns a 1, else it returns a 0.  The errors being checked
>   * are parity, master abort, target abort (master and target).  These types of
> - * errors occure during a config cycle where there is no device, like during
> + * errors occur during a config cycle where there is no device, like during
>   * the discovery stage.
>   */
>  static int iop3xx_pci_status(void)
> @@ -223,8 +223,111 @@ struct pci_bus *iop3xx_pci_scan_bus(int 
>  	return pci_scan_bus(sys->busnr, &iop3xx_ops, sys);
>  }
>  
> +void __init iop3xx_atu_setup(void)
> +{
> +	/* BAR 0 ( Disabled ) */
> +	*IOP3XX_IAUBAR0 = 0x0;
> +	*IOP3XX_IABAR0  = 0x0;
> +	*IOP3XX_IATVR0  = 0x0;
> +	*IOP3XX_IALR0   = 0x0;
> +
> +	/* BAR 1 ( Disabled ) */
> +	*IOP3XX_IAUBAR1 = 0x0;
> +	*IOP3XX_IABAR1  = 0x0;
> +	*IOP3XX_IALR1   = 0x0;
> +
> +	/* BAR 2 (1:1 mapping with Physical RAM) */
> +	/* Set limit and enable */
> +	*IOP3XX_IALR2 = ~((u32)IOP3XX_MAX_RAM_SIZE - 1) & ~0x1;
> +	*IOP3XX_IAUBAR2 = 0x0;
> +
> +	/* Align the inbound bar with the base of memory */
> +	*IOP3XX_IABAR2 = PHYS_OFFSET |
> +			       PCI_BASE_ADDRESS_MEM_TYPE_64 |
> +			       PCI_BASE_ADDRESS_MEM_PREFETCH;
> +
> +	*IOP3XX_IATVR2 = PHYS_OFFSET;
> +
> +	/* Outbound window 0 */
> +	*IOP3XX_OMWTVR0 = IOP3XX_PCI_LOWER_MEM_PA;
> +	*IOP3XX_OUMWTVR0 = 0;
> +
> +	/* Outbound window 1 */
> +	*IOP3XX_OMWTVR1 = IOP3XX_PCI_LOWER_MEM_PA + IOP3XX_PCI_MEM_WINDOW_SIZE;
> +	*IOP3XX_OUMWTVR1 = 0;
> +
> +	/* BAR 3 ( Disabled ) */
> +	*IOP3XX_IAUBAR3 = 0x0;
> +	*IOP3XX_IABAR3  = 0x0;
> +	*IOP3XX_IATVR3  = 0x0;
> +	*IOP3XX_IALR3   = 0x0;
> +
> +	/* Setup the I/O Bar
> +	 */
> +	*IOP3XX_OIOWTVR = IOP3XX_PCI_LOWER_IO_PA;;
> +
> +	/* Enable inbound and outbound cycles
> +	 */
> +	*IOP3XX_ATUCMD |= PCI_COMMAND_MEMORY | PCI_COMMAND_MASTER |
> +			       PCI_COMMAND_PARITY | PCI_COMMAND_SERR;
> +	*IOP3XX_ATUCR |= IOP3XX_ATUCR_OUT_EN;
> +}
> +
> +void __init iop3xx_atu_disable(void)
> +{
> +	*IOP3XX_ATUCMD = 0;
> +	*IOP3XX_ATUCR = 0;
> +
> +	/* wait for cycles to quiesce */
> +	while (*IOP3XX_PCSR & (IOP3XX_PCSR_OUT_Q_BUSY |
> +				     IOP3XX_PCSR_IN_Q_BUSY))
> +		cpu_relax();
> +
> +	/* BAR 0 ( Disabled ) */
> +	*IOP3XX_IAUBAR0 = 0x0;
> +	*IOP3XX_IABAR0  = 0x0;
> +	*IOP3XX_IATVR0  = 0x0;
> +	*IOP3XX_IALR0   = 0x0;
> +
> +	/* BAR 1 ( Disabled ) */
> +	*IOP3XX_IAUBAR1 = 0x0;
> +	*IOP3XX_IABAR1  = 0x0;
> +	*IOP3XX_IALR1   = 0x0;
> +
> +	/* BAR 2 ( Disabled ) */
> +	*IOP3XX_IAUBAR2 = 0x0;
> +	*IOP3XX_IABAR2  = 0x0;
> +	*IOP3XX_IATVR2  = 0x0;
> +	*IOP3XX_IALR2   = 0x0;
> +
> +	/* BAR 3 ( Disabled ) */
> +	*IOP3XX_IAUBAR3 = 0x0;
> +	*IOP3XX_IABAR3  = 0x0;
> +	*IOP3XX_IATVR3  = 0x0;
> +	*IOP3XX_IALR3   = 0x0;
> +
> +	/* Clear the outbound windows */
> +	*IOP3XX_OIOWTVR  = 0;
> +
> +	/* Outbound window 0 */
> +	*IOP3XX_OMWTVR0 = 0;
> +	*IOP3XX_OUMWTVR0 = 0;
> +
> +	/* Outbound window 1 */
> +	*IOP3XX_OMWTVR1 = 0;
> +	*IOP3XX_OUMWTVR1 = 0;

You should be using readl(), writel() variants rather than writing C 
code that appears to be normal, but in reality has hardware side-effects.

	Jeff



