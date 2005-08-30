Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVH3Imt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVH3Imt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 04:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVH3Imt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 04:42:49 -0400
Received: from az33egw02.freescale.net ([192.88.158.103]:28145 "EHLO
	az33egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1751238AbVH3Ims (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 04:42:48 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467302C7C0A5@zch01exm40.ap.freescale.net>
From: Li Tony-r64360 <Tony.Li@freescale.com>
To: "Gala Kumar K.-galak" <kumar.gala@freescale.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
Subject: RE: [PATCH] ppc32 :Added PCI support for MPC83xx
Date: Tue, 30 Aug 2005 16:42:42 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, you are right. I missed this. I will send a new patch with this corrected.

Tony Li 

-----Original Message-----
From: Gala Kumar K.-galak 
Sent: Tuesday, August 30, 2005 12:28 PM
To: Li Tony-r64360
Cc: linuxppc-embedded; linux-kernel@vger.kernel.org; Chu hanjin-r52514
Subject: Re: [PATCH] ppc32 :Added PCI support for MPC83xx

Hmm, well the PCI spec seems to be clear on the fact that PCI interrupts should be level sensitive.

- kumar

On Aug 29, 2005, at 10:02 PM, Li Tony-r64360 wrote:

> I think it is OK. The external interrupt can be edged. And it works 
> well in my board.
>
> Tony Li
>
> -----Original Message-----
> From: Gala Kumar K.-galak
> Sent: Tuesday, August 30, 2005 1:43 AM
> To: Li Tony-r64360
> Cc: linuxppc-embedded; linux-kernel@vger.kernel.org; Gala Kumar 
> K.-galak; Chu hanjin-r52514
> Subject: Re: [PATCH] ppc32 :Added PCI support for MPC83xx
>
> I noticed that you aren't updating the senses array in 
> mpc834x_sys_init_IRQ for the PCI interrupt lines, is this correct?
> Should they not be IRQ_SENSE_LEVEL?
>
> Also, I've done a bit of cosmetic cleanup to the patch, take a look 
> and let me know if it works.  Once we close on the IRQ sense issue I 
> will send this upstream.
>
> - kumar
>
> ---
>
> diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
> --- a/arch/ppc/Kconfig
> +++ b/arch/ppc/Kconfig
> @@ -713,6 +713,12 @@ config MPC834x_SYS
>      help
>        This option enables support for the MPC 834x SYS evaluation 
> board.
>
> +      Be aware that PCI buses can only function when SYS board is
> plugged on
> +      PIB (Platform IO Board) board from Freescale which provide 3
> PCI slots.
> +      Just like PC,the board level initalization is bootloader`s
> responsiblilty.
> +      The PCI deponds on bootloader configurate board corretly.
> Refer to Freescale
> +      to get more information about this.
> +
>  endchoice
>
>  config PQ2ADS
> @@ -1193,6 +1199,11 @@ config PCI
>  config PCI_DOMAINS
>      bool
>      default PCI
> +
> +config MPC83xx_PCI2
> +    bool "  Supprt for 2nd PCI host controller"
> +    depends on PCI && MPC834x
> +    default y if MPC834x_SYS
>
>  config PCI_QSPAN
>      bool "QSpan PCI"
> diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.c
> b/arch/ppc/platforms/83xx/mpc834x_sys.c
> --- a/arch/ppc/platforms/83xx/mpc834x_sys.c
> +++ b/arch/ppc/platforms/83xx/mpc834x_sys.c
> @@ -62,9 +62,29 @@ extern unsigned long total_memory;    /* in
>  unsigned char __res[sizeof (bd_t)];
>
>  #ifdef CONFIG_PCI
> -#error "PCI is not supported"
> -/* NEED mpc83xx_map_irq & mpc83xx_exclude_device
> -   see platforms/85xx/mpc85xx_ads_common.c */
> +int
> +mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel, unsigned
> char
>
> +pin) {
> +    static char pci_irq_table[][4] =
> +        /*
> +         *      PCI IDSEL/INTPIN->INTLINE
> +         *       A      B      C      D
> +         */
> +    {
> +        {PIRQA, PIRQB,  PIRQC,  PIRQD}, /* idsel 0x11 */
> +        {PIRQC, PIRQD,  PIRQA,  PIRQB}, /* idsel 0x12 */
> +        {PIRQD, PIRQA,  PIRQB,  PIRQC}  /* idsel 0x13 */
> +    };
> +
> +    const long min_idsel = 0x11, max_idsel = 0x13, irqs_per_slot =
> 4;
> +    return PCI_IRQ_TABLE_LOOKUP;
> +}
> +
> +int
> +mpc83xx_exclude_device(u_char bus, u_char devfn) {
> +    return PCIBIOS_SUCCESSFUL;
> +}
>  #endif /* CONFIG_PCI */
>
>  /*
> ********************************************************************** 
> **
> @@ -88,7 +108,7 @@ mpc834x_sys_setup_arch(void)
>
>  #ifdef CONFIG_PCI
>      /* setup PCI host bridges */
> -    mpc83xx_sys_setup_hose();
> +    mpc83xx_setup_hose();
>  #endif
>      mpc83xx_early_serial_map();
>
> diff --git a/arch/ppc/platforms/83xx/mpc834x_sys.h
> b/arch/ppc/platforms/83xx/mpc834x_sys.h
> --- a/arch/ppc/platforms/83xx/mpc834x_sys.h
> +++ b/arch/ppc/platforms/83xx/mpc834x_sys.h
> @@ -26,7 +26,7 @@
>  #define VIRT_IMMRBAR        ((uint)0xfe000000)
>
>  #define BCSR_PHYS_ADDR        ((uint)0xf8000000)
> -#define BCSR_SIZE        ((uint)(32 * 1024))
> +#define BCSR_SIZE        ((uint)(128 * 1024))
>
>  #define BCSR_MISC_REG2_OFF    0x07
>  #define BCSR_MISC_REG2_PORESET    0x01
> @@ -34,23 +34,25 @@
>  #define BCSR_MISC_REG3_OFF    0x08
>  #define BCSR_MISC_REG3_CNFLOCK    0x80
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
> +#define PIRQA    MPC83xx_IRQ_EXT4
> +#define PIRQB    MPC83xx_IRQ_EXT5
> +#define PIRQC    MPC83xx_IRQ_EXT6
> +#define PIRQD    MPC83xx_IRQ_EXT7
> +
> +#define MPC83xx_PCI1_LOWER_IO    0x00000000
> +#define MPC83xx_PCI1_UPPER_IO    0x00ffffff
> +#define MPC83xx_PCI1_LOWER_MEM    0x80000000
> +#define MPC83xx_PCI1_UPPER_MEM    0x9fffffff
> +#define MPC83xx_PCI1_IO_BASE    0xe2000000
> +#define MPC83xx_PCI1_MEM_OFFSET    0x00000000
> +#define MPC83xx_PCI1_IO_SIZE    0x01000000
> +
> +#define MPC83xx_PCI2_LOWER_IO    0x00000000
> +#define MPC83xx_PCI2_UPPER_IO    0x00ffffff
> +#define MPC83xx_PCI2_LOWER_MEM    0xa0000000
> +#define MPC83xx_PCI2_UPPER_MEM    0xbfffffff
> +#define MPC83xx_PCI2_IO_BASE    0xe3000000
> +#define MPC83xx_PCI2_MEM_OFFSET    0x00000000
> +#define MPC83xx_PCI2_IO_SIZE    0x01000000
>
>  #endif                /* __MACH_MPC83XX_SYS_H__ */
> diff --git a/arch/ppc/syslib/ppc83xx_pci.h
> b/arch/ppc/syslib/ppc83xx_pci.h new file mode 100644
> --- /dev/null
> +++ b/arch/ppc/syslib/ppc83xx_pci.h
> @@ -0,0 +1,151 @@
> +/* Created by Tony Li <tony.li@freescale.com>
> + * Copyright (c) 2005 freescale semiconductor
> + *
> + * This program is free software; you can redistribute  it and/or
> +modify it
> + * under  the terms of  the GNU General  Public License as  
> published by
>
> +the
> + * Free Software Foundation;  either version 2 of the  License, or  
> (at
> +your
> + * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,  
> but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the  GNU General Public License
> +along
> + * with this program; if not, write  to the Free Software Foundation,
> +Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + */
> +
> +#ifndef __PPC_SYSLIB_PPC83XX_PCI_H
> +#define __PPC_SYSLIB_PPC83XX_PCI_H
> +
> +typedef struct immr_clk {
> +    u32 spmr; /* system PLL mode Register  */
> +    u32 occr; /* output clock control Register  */
> +    u32 sccr; /* system clock control Register  */
> +    u8 res0[0xF4];
> +} immr_clk_t;
> +
> +/*
> + * Sequencer
> + */
> +typedef struct immr_ios {
> +    u32    potar0;
> +    u8    res0[4];
> +    u32    pobar0;
> +    u8    res1[4];
> +    u32    pocmr0;
> +    u8    res2[4];
> +    u32    potar1;
> +    u8    res3[4];
> +    u32    pobar1;
> +    u8    res4[4];
> +    u32    pocmr1;
> +    u8    res5[4];
> +    u32    potar2;
> +    u8    res6[4];
> +    u32    pobar2;
> +    u8    res7[4];
> +    u32    pocmr2;
> +    u8    res8[4];
> +    u32    potar3;
> +    u8    res9[4];
> +    u32    pobar3;
> +    u8    res10[4];
> +    u32    pocmr3;
> +    u8    res11[4];
> +    u32    potar4;
> +    u8    res12[4];
> +    u32    pobar4;
> +    u8    res13[4];
> +    u32    pocmr4;
> +    u8    res14[4];
> +    u32    potar5;
> +    u8    res15[4];
> +    u32    pobar5;
> +    u8    res16[4];
> +    u32    pocmr5;
> +    u8    res17[4];
> +    u8    res18[0x60];
> +    u32    pmcr;
> +    u8    res19[4];
> +    u32    dtcr;
> +    u8    res20[4];
> +} immr_ios_t;
> +#define POTAR_TA_MASK    0x000fffff
> +#define POBAR_BA_MASK    0x000fffff
> +#define POCMR_EN    0x80000000
> +#define POCMR_IO    0x40000000 /* 0--memory space 1--I/O space */
> +#define POCMR_SE    0x20000000 /* streaming enable */
> +#define POCMR_DST    0x10000000 /* 0--PCI1 1--PCI2 */
> +#define POCMR_CM_MASK    0x000fffff
> +
> +/*
> + * PCI Controller Control and Status Registers  */ typedef struct
> +immr_pcictrl {
> +    u32    esr;
> +    u32    ecdr;
> +    u32    eer;
> +    u32    eatcr;
> +    u32    eacr;
> +    u32    eeacr;
> +    u32    edlcr;
> +    u32    edhcr;
> +    u32    gcr;
> +    u32    ecr;
> +    u32    gsr;
> +    u8    res0[12];
> +    u32    pitar2;
> +    u8    res1[4];
> +    u32    pibar2;
> +    u32    piebar2;
> +    u32    piwar2;
> +    u8    res2[4];
> +    u32    pitar1;
> +    u8    res3[4];
> +    u32    pibar1;
> +    u32    piebar1;
> +    u32    piwar1;
> +    u8    res4[4];
> +    u32    pitar0;
> +    u8    res5[4];
> +    u32    pibar0;
> +    u8    res6[4];
> +    u32    piwar0;
> +    u8    res7[132];
> +} immr_pcictrl_t;
> +#define PITAR_TA_MASK    0x000fffff
> +#define PIBAR_MASK    0xffffffff
> +#define PIEBAR_EBA_MASK    0x000fffff
> +#define PIWAR_EN    0x80000000
> +#define PIWAR_PF    0x20000000
> +#define PIWAR_RTT_MASK    0x000f0000
> +#define PIWAR_RTT_NO_SNOOP    0x00040000
> +#define PIWAR_RTT_SNOOP    0x00050000
> +#define PIWAR_WTT_MASK    0x0000f000
> +#define PIWAR_WTT_NO_SNOOP    0x00004000
> +#define PIWAR_WTT_SNOOP    0x00005000
> +#define PIWAR_IWS_MASK    0x0000003F
> +#define PIWAR_IWS_4K    0x0000000B
> +#define PIWAR_IWS_8K    0x0000000C
> +#define PIWAR_IWS_16K    0x0000000D
> +#define PIWAR_IWS_32K    0x0000000E
> +#define PIWAR_IWS_64K    0x0000000F
> +#define PIWAR_IWS_128K    0x00000010
> +#define PIWAR_IWS_256K    0x00000011
> +#define PIWAR_IWS_512K    0x00000012
> +#define PIWAR_IWS_1M    0x00000013
> +#define PIWAR_IWS_2M    0x00000014
> +#define PIWAR_IWS_4M    0x00000015
> +#define PIWAR_IWS_8M    0x00000016
> +#define PIWAR_IWS_16M    0x00000017
> +#define PIWAR_IWS_32M    0x00000018
> +#define PIWAR_IWS_64M    0x00000019
> +#define PIWAR_IWS_128M    0x0000001A
> +#define PIWAR_IWS_256M    0x0000001B
> +#define PIWAR_IWS_512M    0x0000001C
> +#define PIWAR_IWS_1G    0x0000001D
> +#define PIWAR_IWS_2G    0x0000001E
> +
> +#endif /* __PPC_SYSLIB_PPC83XX_PCI_H */
> diff --git a/arch/ppc/syslib/ppc83xx_setup.c
> b/arch/ppc/syslib/ppc83xx_setup.c
> --- a/arch/ppc/syslib/ppc83xx_setup.c
> +++ b/arch/ppc/syslib/ppc83xx_setup.c
> @@ -11,6 +11,17 @@
>   * under  the terms of  the GNU General  Public License as  
> published by
> the
>   * Free Software Foundation;  either version 2 of the  License, or  
> (at
> your
>   * option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,  
> but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the  GNU General Public License
> + along
> + * with this program; if not, write  to the Free Software Foundation,
> + Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
> + *
> + * Added PCI support -- Tony Li <tony.li@freescale.com>
>   */
>
>  #include <linux/config.h>
> @@ -31,6 +42,10 @@
>  #include <asm/delay.h>
>
>  #include <syslib/ppc83xx_setup.h>
> +#if defined(CONFIG_PCI)
> +#include <asm/delay.h>
> +#include <syslib/ppc83xx_pci.h>
> +#endif
>
>  phys_addr_t immrbar;
>
> @@ -162,4 +177,237 @@ mpc83xx_halt(void)
>      for(;;);
>  }
>
> -/* PCI SUPPORT DOES NOT EXIT, MODEL after ppc85xx_setup.c */
> +#if defined(CONFIG_PCI)
> +void __init
> +mpc83xx_setup_pci1(struct pci_controller *hose) {
> +    u16 reg16;
> +    volatile immr_pcictrl_t * pci_ctrl;
> +    volatile immr_ios_t * ios;
> +    bd_t *binfo = (bd_t *) __res;
> +
> +    pci_ctrl = ioremap(binfo->bi_immr_base + 0x8500,
> sizeof(immr_pcictrl_t));
> +    ios = ioremap(binfo->bi_immr_base + 0x8400, sizeof(immr_ios_t));
> +
> +    /*
> +     * Configure PCI Outbound Translation Windows
> +     */
> +    ios->potar0 = (MPC83xx_PCI1_LOWER_MEM >> 12) & POTAR_TA_MASK;
> +    ios->pobar0 = (MPC83xx_PCI1_LOWER_MEM >> 12) & POBAR_BA_MASK;
> +    ios->pocmr0 = POCMR_EN |
> +        (((0xffffffff - (MPC83xx_PCI1_UPPER_MEM -
> +                MPC83xx_PCI1_LOWER_MEM)) >> 12) &
> POCMR_CM_MASK);
> +
> +    /* mapped to PCI1 IO space */
> +    ios->potar1 = (MPC83xx_PCI1_LOWER_IO >> 12) & POTAR_TA_MASK;
> +    ios->pobar1 = (MPC83xx_PCI1_IO_BASE >> 12) & POBAR_BA_MASK;
> +    ios->pocmr1 = POCMR_EN | POCMR_IO |
> +        (((0xffffffff - (MPC83xx_PCI1_UPPER_IO -
> +                MPC83xx_PCI1_LOWER_IO)) >> 12) &
> POCMR_CM_MASK);
> +
> +    /*
> +     * Configure PCI Inbound Translation Windows
> +     */
> +    pci_ctrl->pitar1 = 0x0;
> +    pci_ctrl->pibar1 = 0x0;
> +    pci_ctrl->piebar1 = 0x0;
> +    pci_ctrl->piwar1 = PIWAR_EN | PIWAR_PF | PIWAR_RTT_SNOOP |
> +PIWAR_WTT_SNOOP | PIWAR_IWS_2G;
> +
> +    /*
> +     * Release PCI RST signal
> +     */
> +    pci_ctrl->gcr = 0;
> +    udelay(2000);
> +    pci_ctrl->gcr = 1;
> +    udelay(2000);
> +
> +    reg16 = 0xff;
> +    early_read_config_word(hose, hose->first_busno, 0, PCI_COMMAND,
> &reg16);
> +    reg16 |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER |
> PCI_COMMAND_MEMORY;
> +    early_write_config_word(hose, hose->first_busno, 0, PCI_COMMAND,
>
> +reg16);
> +
> +    /*
> +     * Clear non-reserved bits in status register.
> +     */
> +    early_write_config_word(hose, hose->first_busno, 0, PCI_STATUS,
> 0xffff);
> +    early_write_config_byte(hose, hose->first_busno, 0,
> PCI_LATENCY_TIMER,
> +0x80);
> +
> +    iounmap(pci_ctrl);
> +    iounmap(ios);
> +}
> +
> +void __init
> +mpc83xx_setup_pci2(struct pci_controller *hose) {
> +    u16 reg16;
> +    volatile immr_pcictrl_t * pci_ctrl;
> +    volatile immr_ios_t * ios;
> +    bd_t *binfo = (bd_t *) __res;
> +
> +    pci_ctrl = ioremap(binfo->bi_immr_base + 0x8600,
> sizeof(immr_pcictrl_t));
> +    ios = ioremap(binfo->bi_immr_base + 0x8400, sizeof(immr_ios_t));
> +
> +    /*
> +     * Configure PCI Outbound Translation Windows
> +     */
> +    ios->potar3 = (MPC83xx_PCI2_LOWER_MEM >> 12) & POTAR_TA_MASK;
> +    ios->pobar3 = (MPC83xx_PCI2_LOWER_MEM >> 12) & POBAR_BA_MASK;
> +    ios->pocmr3 = POCMR_EN | POCMR_DST |
> +        (((0xffffffff - (MPC83xx_PCI2_UPPER_MEM -
> +                MPC83xx_PCI2_LOWER_MEM)) >> 12) &
> POCMR_CM_MASK);
> +
> +    /* mapped to PCI2 IO space */
> +    ios->potar4 = (MPC83xx_PCI2_LOWER_IO >> 12) & POTAR_TA_MASK;
> +    ios->pobar4 = (MPC83xx_PCI2_IO_BASE >> 12) & POBAR_BA_MASK;
> +    ios->pocmr4 = POCMR_EN | POCMR_DST | POCMR_IO |
> +        (((0xffffffff - (MPC83xx_PCI2_UPPER_IO -
> +                MPC83xx_PCI2_LOWER_IO)) >> 12) &
> POCMR_CM_MASK);
> +
> +    /*
> +     * Configure PCI Inbound Translation Windows
> +     */
> +    pci_ctrl->pitar1 = 0x0;
> +    pci_ctrl->pibar1 = 0x0;
> +    pci_ctrl->piebar1 = 0x0;
> +    pci_ctrl->piwar1 = PIWAR_EN | PIWAR_PF | PIWAR_RTT_SNOOP |
> +PIWAR_WTT_SNOOP | PIWAR_IWS_2G;
> +
> +    /*
> +     * Release PCI RST signal
> +     */
> +    pci_ctrl->gcr = 0;
> +    udelay(2000);
> +    pci_ctrl->gcr = 1;
> +    udelay(2000);
> +
> +    reg16 = 0xff;
> +    early_read_config_word(hose, hose->first_busno, 0, PCI_COMMAND,
> &reg16);
> +    reg16 |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER |
> PCI_COMMAND_MEMORY;
> +    early_write_config_word(hose, hose->first_busno, 0, PCI_COMMAND,
>
> +reg16);
> +
> +    /*
> +     * Clear non-reserved bits in status register.
> +     */
> +    early_write_config_word(hose, hose->first_busno, 0, PCI_STATUS,
> 0xffff);
> +    early_write_config_byte(hose, hose->first_busno, 0,
> PCI_LATENCY_TIMER,
> +0x80);
> +
> +    iounmap(pci_ctrl);
> +    iounmap(ios);
> +}
> +
> +/*
> + * PCI buses can be enabled only if SYS board combinates with PIB
> + * (Platform IO Board) board which provide 3 PCI slots. There is 2  
> PCI
> +buses
> + * and 3 PCI slots, so people must configure the routes between them
> +before
> + * enable PCI bus. This routes are under the control of PCA9555PW
> +device which
> + * can be accessed via I2C bus 2 and are configured by firmware.  
> Refer
> +to
> + * Freescale to get more information about firmware configuration.
> + */
> +
> +extern int mpc83xx_exclude_device(u_char bus, u_char devfn);  
> extern int
>
> +mpc83xx_map_irq(struct pci_dev *dev, unsigned char idsel,
> +        unsigned char pin);
> +void __init
> +mpc83xx_setup_hose(void)
> +{
> +    u32 val32;
> +    volatile immr_clk_t * clk;
> +    struct pci_controller * hose1;
> +#ifdef CONFIG_MPC83xx_PCI2
> +    struct pci_controller * hose2;
> +#endif
> +    bd_t * binfo = (bd_t *)__res;
> +
> +    clk = ioremap(binfo->bi_immr_base + 0xA00,
> +            sizeof(immr_clk_t));
> +
> +    /*
> +     * Configure PCI controller and PCI_CLK_OUTPUT both in 66M mode
> +     */
> +    val32 = clk->occr;
> +    udelay(2000);
> +    clk->occr = 0xff000000;
> +    udelay(2000);
> +
> +    iounmap(clk);
> +
> +    hose1 = pcibios_alloc_controller();
> +    if(!hose1)
> +        return;
> +
> +    ppc_md.pci_swizzle = common_swizzle;
> +    ppc_md.pci_map_irq = mpc83xx_map_irq;
> +
> +    hose1->bus_offset = 0;
> +    hose1->first_busno = 0;
> +    hose1->last_busno = 0xff;
> +
> +    setup_indirect_pci(hose1, binfo->bi_immr_base +
> PCI1_CFG_ADDR_OFFSET,
> +            binfo->bi_immr_base + PCI1_CFG_DATA_OFFSET);
> +    hose1->set_cfg_type = 1;
> +
> +    mpc83xx_setup_pci1(hose1);
> +
> +    hose1->pci_mem_offset = MPC83xx_PCI1_MEM_OFFSET;
> +    hose1->mem_space.start = MPC83xx_PCI1_LOWER_MEM;
> +    hose1->mem_space.end = MPC83xx_PCI1_UPPER_MEM;
> +
> +    hose1->io_base_phys = MPC83xx_PCI1_IO_BASE;
> +    hose1->io_space.start = MPC83xx_PCI1_LOWER_IO;
> +    hose1->io_space.end = MPC83xx_PCI1_UPPER_IO; #ifdef
> +CONFIG_MPC83xx_PCI2
> +    isa_io_base = (unsigned long)ioremap(MPC83xx_PCI1_IO_BASE,
> +            MPC83xx_PCI1_IO_SIZE + MPC83xx_PCI2_IO_SIZE);
> #else
> +    isa_io_base = (unsigned long)ioremap(MPC83xx_PCI1_IO_BASE,
> +            MPC83xx_PCI1_IO_SIZE);
> +#endif /* CONFIG_MPC83xx_PCI2 */
> +    hose1->io_base_virt = (void *)isa_io_base;
> +    /* setup resources */
> +    pci_init_resource(&hose1->io_resource,
> +            MPC83xx_PCI1_LOWER_IO,
> +            MPC83xx_PCI1_UPPER_IO,
> +            IORESOURCE_IO, "PCI host bridge 1");
> +    pci_init_resource(&hose1->mem_resources[0],
> +            MPC83xx_PCI1_LOWER_MEM,
> +            MPC83xx_PCI1_UPPER_MEM,
> +            IORESOURCE_MEM, "PCI host bridge 1");
> +
> +    ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> +    hose1->last_busno = pciauto_bus_scan(hose1, hose1->first_busno);
> +
> +#ifdef CONFIG_MPC83xx_PCI2
> +    hose2 = pcibios_alloc_controller();
> +    if(!hose2)
> +        return;
> +
> +    hose2->bus_offset = hose1->last_busno + 1;
> +    hose2->first_busno = hose1->last_busno + 1;
> +    hose2->last_busno = 0xff;
> +    setup_indirect_pci(hose2, binfo->bi_immr_base +
> PCI2_CFG_ADDR_OFFSET,
> +            binfo->bi_immr_base + PCI2_CFG_DATA_OFFSET);
> +    hose2->set_cfg_type = 1;
> +
> +    mpc83xx_setup_pci2(hose2);
> +
> +    hose2->pci_mem_offset = MPC83xx_PCI2_MEM_OFFSET;
> +    hose2->mem_space.start = MPC83xx_PCI2_LOWER_MEM;
> +    hose2->mem_space.end = MPC83xx_PCI2_UPPER_MEM;
> +
> +    hose2->io_base_phys = MPC83xx_PCI2_IO_BASE;
> +    hose2->io_space.start = MPC83xx_PCI2_LOWER_IO;
> +    hose2->io_space.end = MPC83xx_PCI2_UPPER_IO;
> +    hose2->io_base_virt = (void *)(isa_io_base +
> MPC83xx_PCI1_IO_SIZE);
> +    /* setup resources */
> +    pci_init_resource(&hose2->io_resource,
> +            MPC83xx_PCI2_LOWER_IO,
> +            MPC83xx_PCI2_UPPER_IO,
> +            IORESOURCE_IO, "PCI host bridge 2");
> +    pci_init_resource(&hose2->mem_resources[0],
> +            MPC83xx_PCI2_LOWER_MEM,
> +            MPC83xx_PCI2_UPPER_MEM,
> +            IORESOURCE_MEM, "PCI host bridge 2");
> +
> +    hose2->last_busno = pciauto_bus_scan(hose2, hose2->first_busno);
>
> +#endif /* CONFIG_MPC83xx_PCI2 */ } #endif /*CONFIG_PCI*/
> diff --git a/arch/ppc/syslib/ppc83xx_setup.h
> b/arch/ppc/syslib/ppc83xx_setup.h
> --- a/arch/ppc/syslib/ppc83xx_setup.h
> +++ b/arch/ppc/syslib/ppc83xx_setup.h
> @@ -12,6 +12,14 @@
>   * Free Software Foundation;  either version 2 of the  License, or  
> (at
> your
>   * option) any later version.
>   *
> + * This program is distributed in the hope that it will be useful,  
> but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + * You should have received a copy of the  GNU General Public License
> + along
> + * with this program; if not, write  to the Free Software Foundation,
> + Inc.,
> + * 675 Mass Ave, Cambridge, MA 02139, USA.
>   */
>
>  #ifndef __PPC_SYSLIB_PPC83XX_SETUP_H
> @@ -19,7 +27,6 @@
>
>  #include <linux/config.h>
>  #include <linux/init.h>
> -#include <asm/ppcboot.h>
>
>  extern unsigned long mpc83xx_find_end_of_memory(void) __init;  extern
> long mpc83xx_time_init(void) __init; @@ -31,13 +38,11 @@ extern void
> mpc83xx_halt(void);  extern void mpc83xx_setup_hose(void) __init;
>
>  /* PCI config */
> -#if 0
> -#define PCI1_CFG_ADDR_OFFSET    (FIXME)
> -#define PCI1_CFG_DATA_OFFSET    (FIXME)
> +#define PCI1_CFG_ADDR_OFFSET (0x8300)
> +#define PCI1_CFG_DATA_OFFSET (0x8304)
>
> -#define PCI2_CFG_ADDR_OFFSET    (FIXME)
> -#define PCI2_CFG_DATA_OFFSET    (FIXME)
> -#endif
> +#define PCI2_CFG_ADDR_OFFSET (0x8380)
> +#define PCI2_CFG_DATA_OFFSET (0x8384)
>
>  /* Serial Config */
>  #ifdef CONFIG_SERIAL_MANY_PORTS
>
