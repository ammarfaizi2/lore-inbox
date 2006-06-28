Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWF1NTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWF1NTR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 09:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWF1NTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 09:19:17 -0400
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:62342 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1030247AbWF1NTQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 09:19:16 -0400
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306DD14E0@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306DD14E0@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1D08936A-03F0-478F-8A29-5BEAC7A0D3FF@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Wed, 28 Jun 2006 08:19:07 -0500
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
X-Mailer: Apple Mail (2.750)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jun 28, 2006, at 1:26 AM, Zhang Wei-r63237 wrote:

> Hi, Kumar,
>
> Why moving these codes from pci.c to mpc86xx_hpcn.c? It's not must be.
> These functions relate to PCI device of MPC8641D HPCn platform.
> And we can also see the 'DECLARE_PCI_FIXUP_HEADER()' declaration in  
> pci.c of Powermac platform.

The point for moving is 86xx/pci.c should apply to all 86xx systems,  
not just the HPCn system.

- kumar

>> -----Original Message-----
>> From: linuxppc-dev-bounces+wei.zhang=freescale.com@ozlabs.org
>> [mailto:linuxppc-dev-bounces+wei.zhang=freescale.com@ozlabs.or
>> g] On Behalf Of Kumar Gala
>> Sent: Wednesday, June 28, 2006 2:01 PM
>> To: Paul Mackerras
>> Cc: linuxppc-dev@ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Please pull from 'for_paulus' branch of powerpc
>>
>> Please pull from 'for_paulus' branch of
>> master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git
>>
>> to receive the following updates:
>>
>>  arch/powerpc/kernel/cputable.c             |   12 --
>>  arch/powerpc/platforms/86xx/mpc86xx.h      |    8 +
>>  arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |  128
>> +++++++++++++++++++++++++--
>>  arch/powerpc/platforms/86xx/mpc86xx_smp.c  |    9 -
>>  arch/powerpc/platforms/86xx/pci.c          |  136
>> +----------------------------
>>  include/asm-powerpc/mpc86xx.h              |    4
>>  6 files changed, 138 insertions(+), 159 deletions(-)
>>
>> Kumar Gala:
>>       powerpc: minor cleanups for mpc86xx
>>
>> diff --git a/arch/powerpc/kernel/cputable.c
>> b/arch/powerpc/kernel/cputable.c index 1c11488..abf7d42 100644
>> --- a/arch/powerpc/kernel/cputable.c
>> +++ b/arch/powerpc/kernel/cputable.c
>> @@ -722,18 +722,6 @@ #if CLASSIC_PPC
>>  		.oprofile_type		= PPC_OPROFILE_G4,
>>  		.platform		= "ppc7450",
>>  	},
>> -        {       /* 8641 */
>> -               .pvr_mask               = 0xffffffff,
>> -               .pvr_value              = 0x80040010,
>> -               .cpu_name               = "8641",
>> -               .cpu_features           = CPU_FTRS_7447A,
>> -               .cpu_user_features      = COMMON_USER |
>> PPC_FEATURE_HAS_ALTIVEC_COMP,
>> -               .icache_bsize           = 32,
>> -               .dcache_bsize           = 32,
>> -               .num_pmcs               = 6,
>> -               .cpu_setup              = __setup_cpu_745x
>> -        },
>> -
>>  	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
>>  		.pvr_mask		= 0x7fff0000,
>>  		.pvr_value		= 0x00810000,
>> diff --git a/arch/powerpc/platforms/86xx/mpc86xx.h
>> b/arch/powerpc/platforms/86xx/mpc86xx.h
>> index e3c9e4f..2834462 100644
>> --- a/arch/powerpc/platforms/86xx/mpc86xx.h
>> +++ b/arch/powerpc/platforms/86xx/mpc86xx.h
>> @@ -15,11 +15,13 @@ #define __MPC86XX_H__
>>   * mpc86xx_* files. Mostly for use by mpc86xx_setup().
>>   */
>>
>> -extern int __init add_bridge(struct device_node *dev);
>> +extern int add_bridge(struct device_node *dev);
>>
>> -extern void __init setup_indirect_pcie(struct pci_controller *hose,
>> +extern int mpc86xx_exclude_device(u_char bus, u_char devfn);
>> +
>> +extern void setup_indirect_pcie(struct pci_controller *hose,
>>  				       u32 cfg_addr, u32
>> cfg_data); -extern void __init
>> setup_indirect_pcie_nomap(struct pci_controller *hose,
>> +extern void setup_indirect_pcie_nomap(struct pci_controller *hose,
>>  					     void __iomem *cfg_addr,
>>  					     void __iomem *cfg_data);
>>
>> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
>> b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
>> index 483c21d..ac7f418 100644
>> --- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
>> +++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
>> @@ -36,6 +36,7 @@ #include <asm/mpic.h>
>>  #include <sysdev/fsl_soc.h>
>>
>>  #include "mpc86xx.h"
>> +#include "mpc8641_hpcn.h"
>>
>>  #ifndef CONFIG_PCI
>>  unsigned long isa_io_base = 0;
>> @@ -186,17 +187,130 @@ mpc86xx_map_irq(struct pci_dev *dev, uns
>>  	return PCI_IRQ_TABLE_LOOKUP + I8259_OFFSET;  }
>>
>> +static void __devinit quirk_ali1575(struct pci_dev *dev) {
>> +	unsigned short temp;
>> +
>> +	/*
>> +	 * ALI1575 interrupts route table setup:
>> +	 *
>> +	 * IRQ pin   IRQ#
>> +	 * PIRQA ---- 3
>> +	 * PIRQB ---- 4
>> +	 * PIRQC ---- 5
>> +	 * PIRQD ---- 6
>> +	 * PIRQE ---- 9
>> +	 * PIRQF ---- 10
>> +	 * PIRQG ---- 11
>> +	 * PIRQH ---- 12
>> +	 *
>> +	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
>> +	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
>> +	 */
>> +	pci_write_config_dword(dev, 0x48, 0xb9317542);
>> +
>> +	/* USB 1.1 OHCI controller 1, interrupt: PIRQE */
>> +	pci_write_config_byte(dev, 0x86, 0x0c);
>> +
>> +	/* USB 1.1 OHCI controller 2, interrupt: PIRQF */
>> +	pci_write_config_byte(dev, 0x87, 0x0d);
>> +
>> +	/* USB 1.1 OHCI controller 3, interrupt: PIRQH */
>> +	pci_write_config_byte(dev, 0x88, 0x0f);
>> +
>> +	/* USB 2.0 controller, interrupt: PIRQ7 */
>> +	pci_write_config_byte(dev, 0x74, 0x06);
>> +
>> +	/* Audio controller, interrupt: PIRQE */
>> +	pci_write_config_byte(dev, 0x8a, 0x0c);
>> +
>> +	/* Modem controller, interrupt: PIRQF */
>> +	pci_write_config_byte(dev, 0x8b, 0x0d);
>> +
>> +	/* HD audio controller, interrupt: PIRQG */
>> +	pci_write_config_byte(dev, 0x8c, 0x0e);
>> +
>> +	/* Serial ATA interrupt: PIRQD */
>> +	pci_write_config_byte(dev, 0x8d, 0x0b);
>> +
>> +	/* SMB interrupt: PIRQH */
>> +	pci_write_config_byte(dev, 0x8e, 0x0f);
>> +
>> +	/* PMU ACPI SCI interrupt: PIRQH */
>> +	pci_write_config_byte(dev, 0x8f, 0x0f);
>> +
>> +	/* Primary PATA IDE IRQ: 14
>> +	 * Secondary PATA IDE IRQ: 15
>> +	 */
>> +	pci_write_config_byte(dev, 0x44, 0x3d);
>> +	pci_write_config_byte(dev, 0x75, 0x0f);
>> +
>> +	/* Set IRQ14 and IRQ15 to legacy IRQs */
>> +	pci_read_config_word(dev, 0x46, &temp);
>> +	temp |= 0xc000;
>> +	pci_write_config_word(dev, 0x46, temp);
>> +
>> +	/* Set i8259 interrupt trigger
>> +	 * IRQ 3:  Level
>> +	 * IRQ 4:  Level
>> +	 * IRQ 5:  Level
>> +	 * IRQ 6:  Level
>> +	 * IRQ 7:  Level
>> +	 * IRQ 9:  Level
>> +	 * IRQ 10: Level
>> +	 * IRQ 11: Level
>> +	 * IRQ 12: Level
>> +	 * IRQ 14: Edge
>> +	 * IRQ 15: Edge
>> +	 */
>> +	outb(0xfa, 0x4d0);
>> +	outb(0x1e, 0x4d1);
>> +}
>>
>> -int
>> -mpc86xx_exclude_device(u_char bus, u_char devfn)
>> +static void __devinit quirk_uli5288(struct pci_dev *dev)
>>  {
>> -#if !defined(CONFIG_PCI)
>> -	if (bus == 0 && PCI_SLOT(devfn) == 0)
>> -		return PCIBIOS_DEVICE_NOT_FOUND;
>> -#endif
>> +	unsigned char c;
>> +
>> +	pci_read_config_byte(dev,0x83,&c);
>> +	c |= 0x80;
>> +	pci_write_config_byte(dev, 0x83, c);
>> +
>> +	pci_write_config_byte(dev, 0x09, 0x01);
>> +	pci_write_config_byte(dev, 0x0a, 0x06);
>> +
>> +	pci_read_config_byte(dev,0x83,&c);
>> +	c &= 0x7f;
>> +	pci_write_config_byte(dev, 0x83, c);
>>
>> -	return PCIBIOS_SUCCESSFUL;
>> +	pci_read_config_byte(dev,0x84,&c);
>> +	c |= 0x01;
>> +	pci_write_config_byte(dev, 0x84, c);
>>  }
>> +
>> +static void __devinit quirk_uli5229(struct pci_dev *dev) {
>> +	unsigned short temp;
>> +	pci_write_config_word(dev, 0x04, 0x0405);
>> +	pci_read_config_word(dev, 0x4a, &temp);
>> +	temp |= 0x1000;
>> +	pci_write_config_word(dev, 0x4a, temp); }
>> +
>> +static void __devinit early_uli5249(struct pci_dev *dev) {
>> +	unsigned char temp;
>> +	pci_write_config_word(dev, 0x04, 0x0007);
>> +	pci_read_config_byte(dev, 0x7c, &temp);
>> +	pci_write_config_byte(dev, 0x7c, 0x80);
>> +	pci_write_config_byte(dev, 0x09, 0x01);
>> +	pci_write_config_byte(dev, 0x7c, temp);
>> +	dev->class |= 0x1;
>> +}
>> +
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575, quirk_ali1575);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5288, quirk_uli5288);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229, quirk_uli5229);
>> +DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL, 0x5249, early_uli5249);
>>  #endif /* CONFIG_PCI */
>>
>>
>> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
>> b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
>> index 944ec4b..9cca3d1 100644
>> --- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
>> +++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
>> @@ -34,8 +34,8 @@ extern unsigned long __secondary_hold_ac
>> static void __init  smp_86xx_release_core(int nr)  {
>> -	void *mcm_vaddr;
>> -	unsigned long vaddr, pcr;
>> +	__be32 __iomem *mcm_vaddr;
>> +	unsigned long pcr;
>>
>>  	if (nr < 0 || nr >= NR_CPUS)
>>  		return;
>> @@ -45,10 +45,9 @@ smp_86xx_release_core(int nr)
>>  	 */
>>  	mcm_vaddr = ioremap(get_immrbase() + MPC86xx_MCM_OFFSET,
>>  			    MPC86xx_MCM_SIZE);
>> -	vaddr = (unsigned long)mcm_vaddr +  MCM_PORT_CONFIG_OFFSET;
>> -	pcr = in_be32((volatile unsigned *)vaddr);
>> +	pcr = in_be32(mcm_vaddr + (MCM_PORT_CONFIG_OFFSET >> 2));
>>  	pcr |= 1 << (nr + 24);
>> -	out_be32((volatile unsigned *)vaddr, pcr);
>> +	out_be32(mcm_vaddr + (MCM_PORT_CONFIG_OFFSET >> 2), pcr);
>>  }
>>
>>
>> diff --git a/arch/powerpc/platforms/86xx/pci.c
>> b/arch/powerpc/platforms/86xx/pci.c
>> index 5180df7..0d8b340 100644
>> --- a/arch/powerpc/platforms/86xx/pci.c
>> +++ b/arch/powerpc/platforms/86xx/pci.c
>> @@ -122,15 +122,12 @@ static void __init
>> setup_pcie_atmu(struc  static void __init
>> mpc86xx_setup_pcie(struct pci_controller *hose, u32
>> pcie_offset, u32 pcie_size)  {
>> -	volatile struct ccsr_pex *pcie;
>>  	u16 cmd;
>>  	unsigned int temps;
>>
>>  	DBG("PCIE host controller register offset 0x%08x, size
>> 0x%08x.\n",
>>  			pcie_offset, pcie_size);
>>
>> -	pcie = ioremap(pcie_offset, pcie_size);
>> -
>>  	early_read_config_word(hose, 0, 0, PCI_COMMAND, &cmd);
>>  	cmd |= PCI_COMMAND_SERR | PCI_COMMAND_MASTER |
>> PCI_COMMAND_MEMORY
>>  	    | PCI_COMMAND_IO;
>> @@ -144,6 +141,14 @@ mpc86xx_setup_pcie(struct pci_controller
>>  	early_write_config_dword(hose, 0, 0, PCI_PRIMARY_BUS, temps);  }
>>
>> +int mpc86xx_exclude_device(u_char bus, u_char devfn) {
>> +	if (bus == 0 && PCI_SLOT(devfn) == 0)
>> +		return PCIBIOS_DEVICE_NOT_FOUND;
>> +
>> +	return PCIBIOS_SUCCESSFUL;
>> +}
>> +
>>  int __init add_bridge(struct device_node *dev)  {
>>  	int len;
>> @@ -198,128 +203,3 @@ int __init add_bridge(struct device_node
>>
>>  	return 0;
>>  }
>> -
>> -static void __devinit quirk_ali1575(struct pci_dev *dev) -{
>> -	unsigned short temp;
>> -
>> -	/*
>> -	 * ALI1575 interrupts route table setup:
>> -	 *
>> -	 * IRQ pin   IRQ#
>> -	 * PIRQA ---- 3
>> -	 * PIRQB ---- 4
>> -	 * PIRQC ---- 5
>> -	 * PIRQD ---- 6
>> -	 * PIRQE ---- 9
>> -	 * PIRQF ---- 10
>> -	 * PIRQG ---- 11
>> -	 * PIRQH ---- 12
>> -	 *
>> -	 * interrupts for PCI slot0 -- PIRQA / PIRQB / PIRQC / PIRQD
>> -	 *                PCI slot1 -- PIRQB / PIRQC / PIRQD / PIRQA
>> -	 */
>> -	pci_write_config_dword(dev, 0x48, 0xb9317542);
>> -
>> -	/* USB 1.1 OHCI controller 1, interrupt: PIRQE */
>> -	pci_write_config_byte(dev, 0x86, 0x0c);
>> -
>> -	/* USB 1.1 OHCI controller 2, interrupt: PIRQF */
>> -	pci_write_config_byte(dev, 0x87, 0x0d);
>> -
>> -	/* USB 1.1 OHCI controller 3, interrupt: PIRQH */
>> -	pci_write_config_byte(dev, 0x88, 0x0f);
>> -
>> -	/* USB 2.0 controller, interrupt: PIRQ7 */
>> -	pci_write_config_byte(dev, 0x74, 0x06);
>> -
>> -	/* Audio controller, interrupt: PIRQE */
>> -	pci_write_config_byte(dev, 0x8a, 0x0c);
>> -
>> -	/* Modem controller, interrupt: PIRQF */
>> -	pci_write_config_byte(dev, 0x8b, 0x0d);
>> -
>> -	/* HD audio controller, interrupt: PIRQG */
>> -	pci_write_config_byte(dev, 0x8c, 0x0e);
>> -
>> -	/* Serial ATA interrupt: PIRQD */
>> -	pci_write_config_byte(dev, 0x8d, 0x0b);
>> -
>> -	/* SMB interrupt: PIRQH */
>> -	pci_write_config_byte(dev, 0x8e, 0x0f);
>> -
>> -	/* PMU ACPI SCI interrupt: PIRQH */
>> -	pci_write_config_byte(dev, 0x8f, 0x0f);
>> -
>> -	/* Primary PATA IDE IRQ: 14
>> -	 * Secondary PATA IDE IRQ: 15
>> -	 */
>> -	pci_write_config_byte(dev, 0x44, 0x3d);
>> -	pci_write_config_byte(dev, 0x75, 0x0f);
>> -
>> -	/* Set IRQ14 and IRQ15 to legacy IRQs */
>> -	pci_read_config_word(dev, 0x46, &temp);
>> -	temp |= 0xc000;
>> -	pci_write_config_word(dev, 0x46, temp);
>> -
>> -	/* Set i8259 interrupt trigger
>> -	 * IRQ 3:  Level
>> -	 * IRQ 4:  Level
>> -	 * IRQ 5:  Level
>> -	 * IRQ 6:  Level
>> -	 * IRQ 7:  Level
>> -	 * IRQ 9:  Level
>> -	 * IRQ 10: Level
>> -	 * IRQ 11: Level
>> -	 * IRQ 12: Level
>> -	 * IRQ 14: Edge
>> -	 * IRQ 15: Edge
>> -	 */
>> -	outb(0xfa, 0x4d0);
>> -	outb(0x1e, 0x4d1);
>> -}
>> -
>> -static void __devinit quirk_uli5288(struct pci_dev *dev) -{
>> -	unsigned char c;
>> -
>> -	pci_read_config_byte(dev,0x83,&c);
>> -	c |= 0x80;
>> -	pci_write_config_byte(dev, 0x83, c);
>> -
>> -	pci_write_config_byte(dev, 0x09, 0x01);
>> -	pci_write_config_byte(dev, 0x0a, 0x06);
>> -
>> -	pci_read_config_byte(dev,0x83,&c);
>> -	c &= 0x7f;
>> -	pci_write_config_byte(dev, 0x83, c);
>> -
>> -	pci_read_config_byte(dev,0x84,&c);
>> -	c |= 0x01;
>> -	pci_write_config_byte(dev, 0x84, c);
>> -}
>> -
>> -static void __devinit quirk_uli5229(struct pci_dev *dev) -{
>> -	unsigned short temp;
>> -	pci_write_config_word(dev, 0x04, 0x0405);
>> -	pci_read_config_word(dev, 0x4a, &temp);
>> -	temp |= 0x1000;
>> -	pci_write_config_word(dev, 0x4a, temp);
>> -}
>> -
>> -static void __devinit early_uli5249(struct pci_dev *dev) -{
>> -	unsigned char temp;
>> -	pci_write_config_word(dev, 0x04, 0x0007);
>> -	pci_read_config_byte(dev, 0x7c, &temp);
>> -	pci_write_config_byte(dev, 0x7c, 0x80);
>> -	pci_write_config_byte(dev, 0x09, 0x01);
>> -	pci_write_config_byte(dev, 0x7c, temp);
>> -	dev->class |= 0x1;
>> -}
>> -
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x1575,
>> quirk_ali1575); -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL,
>> 0x5288, quirk_uli5288);
>> -DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, 0x5229,
>> quirk_uli5229); -DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AL,
>> 0x5249, early_uli5249); diff --git
>> a/include/asm-powerpc/mpc86xx.h
>> b/include/asm-powerpc/mpc86xx.h index d0a6718..00d72a7 100644
>> --- a/include/asm-powerpc/mpc86xx.h
>> +++ b/include/asm-powerpc/mpc86xx.h
>> @@ -20,10 +20,6 @@ #include <asm/mmu.h>
>>
>>  #ifdef CONFIG_PPC_86xx
>>
>> -#ifdef CONFIG_MPC8641_HPCN
>> -#include <platforms/86xx/mpc8641_hpcn.h> -#endif
>> -
>>  #define _IO_BASE        isa_io_base
>>  #define _ISA_MEM_BASE   isa_mem_base
>>  #ifdef CONFIG_PCI
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>>

