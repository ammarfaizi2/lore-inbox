Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932098AbWF2J2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWF2J2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 05:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932770AbWF2J2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 05:28:46 -0400
Received: from de01egw01.freescale.net ([192.88.165.102]:34760 "EHLO
	de01egw01.freescale.net") by vger.kernel.org with ESMTP
	id S932098AbWF2J2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 05:28:45 -0400
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FE2@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Vitaly Bordug'" <vbordug@ru.mvista.com>
Cc: "'Paul Mackerras'" <paulus@samba.org>, linuxppc-dev@ozlabs.org,
       Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
       Chu hanjin-r52514 <Hanjin.Chu@freescale.com>,
       Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Date: Thu, 29 Jun 2006 17:28:39 +0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> -----Original Message-----
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> Sent: Thursday, June 29, 2006 12:59 AM
> To: Li Yang-r58472
> Cc: 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips Kim-R1AAHA; Chu
> hanjin-r52514; Yin Olivia-r63875; 'linux-kernel@vger.kernel.org'
> Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> 
> On Wed, 28 Jun 2006 22:23:03 +0800
> Li Yang-r58472 <LeoLi@freescale.com> wrote:
> 
> > The patch adds mpc8360e MDS Processor Board support.
> Far too short comment I guess.. There should be some information at least, what
> u-boot modifications are required, what family being introduced, etc.

The new revision goes like this:
The patch adds mpc8360e MDS Processor Board support.  MPC8360E is a new processor in the PowerQUICC II pro family, and it's the first one to use the new generation of communication coprocessor called QUICC ENGINE (QE in abbreviation).
The patch needs a flat device tree to work.  It means either u-boot provides a flat device tree blob or somehow a kernel shim passes the tree.  The final mechanism of providing FDT is far beyond this patch.
> 
> >
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Yin Olivia <hong-hua.yin@freescale.com>
> > Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> >
> > ---
> >  arch/powerpc/platforms/83xx/Kconfig       |   13 ++
> >  arch/powerpc/platforms/83xx/Makefile      |    1
> >  arch/powerpc/platforms/83xx/mpc8360e_pb.c |  213
> +++++++++++++++++++++++++++++
> >  arch/powerpc/platforms/83xx/mpc8360e_pb.h |   31 ++++
> >  4 files changed, 258 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/platforms/83xx/Kconfig
> b/arch/powerpc/platforms/83xx/Kconfig
> > index 7675e67..04c4508 100644
> > --- a/arch/powerpc/platforms/83xx/Kconfig
> > +++ b/arch/powerpc/platforms/83xx/Kconfig
> > @@ -16,6 +16,13 @@ config MPC834x_SYS
> >  	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
> >  	  responsiblilty.
> >
> > +config MPC8360E_PB
> > +	bool "Freescale MPC8360E PB"
> > +	select DEFAULT_UIMAGE
> > +	select QUICC_ENGINE
> > +	help
> > +	  This option enables support for the MPC836x EMDS Processor Board.
> > +
> >  endchoice
> 
> I don't think this is really required option. I guess 836x + QUICC_ENGINE should
> be enough (with a proviso that 8360 won't boot without qe.

We select a board and the board implies cpu family and soc feature.  That will be better for users rather than expecting them to know the very detail.
> 
> >
> >  config MPC834x
> > @@ -24,4 +31,10 @@ config MPC834x
> >  	select PPC_INDIRECT_PCI
> >  	default y if MPC834x_SYS
> >
> > +config MPC836x
> > +	bool
> > +	select PPC_UDBG_16550
> 
> debug option made default?

good catch.
> > +	select PPC_INDIRECT_PCI
> > +	default y if MPC8360E_PB
> > +
> >  endmenu
> > diff --git a/arch/powerpc/platforms/83xx/Makefile
> b/arch/powerpc/platforms/83xx/Makefile
> > index 5c72367..0c9ea5c 100644
> > --- a/arch/powerpc/platforms/83xx/Makefile
> > +++ b/arch/powerpc/platforms/83xx/Makefile
> > @@ -4,3 +4,4 @@ #
> >  obj-y				:= misc.o
> >  obj-$(CONFIG_PCI)		+= pci.o
> >  obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o
> > +obj-$(CONFIG_MPC8360E_PB)	+= mpc8360e_pb.o
> > diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.c
> b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
> > new file mode 100644
> > index 0000000..b4ddb0a
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.c
> > @@ -0,0 +1,213 @@
> > +/*
> > + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
> > + *
> > + * Author: Li Yang <LeoLi@freescale.com>
> > + *	   Yin Olivia <Hong-hua.Yin@freescale.com>
> > + *
> > + * Description:
> > + * MPC8360E MDS PB board specific routines.
> > + *
> > + * Changelog:
> > + * Jun 21, 2006	Initial version
> > + *
> No changelog entries for new files please... git tracks it good enough.

This is Freescale protocol.  If it is not welcomed, we will change it.
> 
> > + * This program is free software; you can redistribute  it and/or modify
> it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + */
> > +
> > +#include <linux/config.h>
> > +#include <linux/stddef.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/errno.h>
> > +#include <linux/reboot.h>
> > +#include <linux/pci.h>
> > +#include <linux/kdev_t.h>
> > +#include <linux/major.h>
> > +#include <linux/console.h>
> > +#include <linux/delay.h>
> > +#include <linux/seq_file.h>
> > +#include <linux/root_dev.h>
> > +#include <linux/initrd.h>
> > +
> > +#include <asm/system.h>
> > +#include <asm/atomic.h>
> > +#include <asm/time.h>
> > +#include <asm/io.h>
> > +#include <asm/machdep.h>
> > +#include <asm/ipic.h>
> > +#include <asm/bootinfo.h>
> > +#include <asm/irq.h>
> > +#include <asm/prom.h>
> > +#include <asm/udbg.h>
> > +#include <sysdev/fsl_soc.h>
> > +#ifdef CONFIG_QUICC_ENGINE
> > +#include <asm/immap_qe.h>
> > +#include <asm/qe_ic.h>
> > +#endif				/* CONFIG_QUICC_ENGINE */
> > +#include "mpc83xx.h"
> > +#include "mpc8360e_pb.h"
> > +
> > +#undef DEBUG
> > +
> 
> hmmm? Does it relate nicely with below ?
> > +#ifdef DEBUG
> > +#define DBG(fmt...) udbg_printf(fmt)
> > +#else
> > +#define DBG(fmt...)
> > +#endif
> > +
> > +
> > +#ifndef CONFIG_PCI
> > +unsigned long isa_io_base = 0;
> > +unsigned long isa_mem_base = 0;
> > +#endif
> > +
> > +#ifdef CONFIG_QUICC_ENGINE
> > +extern void qe_reset(void);
> > +extern int par_io_of_config(struct device_node *np);
> > +#endif	/* CONFIG_QUICC_ENGINE */
> 
> I bet this should go to the .h file...
> > +
> > +/*
> ************************************************************************
> > + *
> > + * Setup the architecture
> > + *
> > + */
> > +static void __init mpc8360_sys_setup_arch(void)
> > +{
> > +	struct device_node *np;
> > +
> > +#ifdef CONFIG_QUICC_ENGINE
> > +	u8 *bcsr_regs;
> > +#endif
> > +
> > +	if (ppc_md.progress)
> > +		ppc_md.progress("mpc8360_sys_setup_arch()", 0);
> > +
> > +	np = of_find_node_by_type(NULL, "cpu");
> > +	if (np != 0) {
> > +		unsigned int *fp =
> > +		    (int *)get_property(np, "clock-frequency", NULL);
> > +		if (fp != 0)
> > +			loops_per_jiffy = *fp / HZ;
> > +		else
> > +			loops_per_jiffy = 50000000 / HZ;
> > +		of_node_put(np);
> > +	}
> > +#ifdef CONFIG_PCI
> > +	for (np = NULL; (np = of_find_node_by_type(np, "pci")) != NULL;)
> > +		add_bridge(np);
> > +
> > +	ppc_md.pci_swizzle = common_swizzle;
> > +	ppc_md.pci_exclude_device = mpc83xx_exclude_device;
> > +#endif
> > +
> > +#ifdef CONFIG_QUICC_ENGINE
> > +	qe_reset();
> > +
> > +	for (np = NULL; (np = of_find_node_by_name(np, "ucc")) != NULL;)
> > +		par_io_of_config(np);
> > +
> > +	/* Reset the Ethernet PHY */
> > +	bcsr_regs = (u8 *) ioremap(BCSR_PHYS_ADDR, BCSR_SIZE);
> > +	bcsr_regs[9] &= ~0x20;
> > +	udelay(1000);
> > +	bcsr_regs[9] |= 0x20;
> > +	iounmap(bcsr_regs);
> > +
> And if we have a design, which do not contain real ethernet UCC usage? Or UCC
> geth is disabled somehow explicitly? Stuff like that normally goes to the
> callback that is going to be triggered upon Etherbet init.
I will move it.
> 
> 
> > +#endif				/* CONFIG_QUICC_ENGINE */
> > +
> > +#ifdef CONFIG_BLK_DEV_INITRD
> > +	if (initrd_start)
> > +		ROOT_DEV = Root_RAM0;
> > +	else
> > +#endif
> > +#ifdef  CONFIG_ROOT_NFS
> > +		ROOT_DEV = Root_NFS;
> > +#else
> > +		ROOT_DEV = Root_HDA1;
> > +#endif
> > +}
> > +
> > +void __init mpc8360_sys_init_IRQ(void)
> > +{
> > +	u8 senses[8] = {
> > +		0,		/* EXT 0 */
> > +		IRQ_SENSE_LEVEL,	/* EXT 1 */
> > +		IRQ_SENSE_LEVEL,	/* EXT 2 */
> > +		0,		/* EXT 3 */
> > +#ifdef CONFIG_PCI
> > +		IRQ_SENSE_LEVEL,	/* EXT 4 */
> > +		IRQ_SENSE_LEVEL,	/* EXT 5 */
> > +		IRQ_SENSE_LEVEL,	/* EXT 6 */
> > +		IRQ_SENSE_LEVEL,	/* EXT 7 */
> > +#else
> > +		0,		/* EXT 4 */
> > +		0,		/* EXT 5 */
> > +		0,		/* EXT 6 */
> > +		0,		/* EXT 7 */
> > +#endif
> > +	};
> > +
> > +	ipic_init(get_immrbase() + 0x00700, 0, 0, senses, 8);
> > +
> > +	/* Initialize the default interrupt mapping priorities,
> > +	 * in case the boot rom changed something on us.
> > +	 */
> > +	ipic_set_default_priority();
> > +
> > +#ifdef CONFIG_QUICC_ENGINE
> > +	qe_ic_init(get_qe_base() + 0x00000080,
> > +		   (QE_IC_LOW_SIGNAL | QE_IC_HIGH_SIGNAL), QE_IRQ_OFFSET);
> > +#endif				/* CONFIG_QUICC_ENGINE */
> > +}
> > +
> > +#if defined(CONFIG_I2C_MPC) && defined(CONFIG_SENSORS_DS1374)
> > +extern ulong ds1374_get_rtc_time(void);
> > +extern int ds1374_set_rtc_time(ulong);
> > +
> > +static int __init mpc8360_rtc_hookup(void)
> > +{
> > +	struct timespec tv;
> > +
> > +	ppc_md.get_rtc_time = ds1374_get_rtc_time;
> > +	ppc_md.set_rtc_time = ds1374_set_rtc_time;
> > +
> > +	tv.tv_nsec = 0;
> > +	tv.tv_sec = (ppc_md.get_rtc_time) ();
> > +	do_settimeofday(&tv);
> > +
> > +	return 0;
> > +}
> > +
> > +late_initcall(mpc8360_rtc_hookup);
> > +#endif
> > +
> > +/*
> > + * Called very early, MMU is off, device-tree isn't unflattened
> > + */
> > +static int __init mpc8360_sys_probe(void)
> > +{
> > +	char *model = of_get_flat_dt_prop(of_get_flat_dt_root(),
> > +					  "model", NULL);
> > +	if (model == NULL)
> > +		return 0;
> > +	if (strcmp(model, "MPC8360EPB"))
> > +		return 0;
> > +
> > +	DBG("MPC8360EMDS-PB found\n");
> > +
> > +	return 1;
> > +}
> > +
> > +define_machine(mpc8360_sys) {
> > +	.name 		= "MPC8360E PB",
> > +	.probe 		= mpc8360_sys_probe,
> > +	.setup_arch 	= mpc8360_sys_setup_arch,
> > +	.init_IRQ 	= mpc8360_sys_init_IRQ,
> > +	.get_irq 	= ipic_get_irq,
> > +	.restart 	= mpc83xx_restart,
> > +	.time_init 	= mpc83xx_time_init,
> > +	.calibrate_decr	= generic_calibrate_decr,
> > +	.progress 	= udbg_progress,
> > +};
> > diff --git a/arch/powerpc/platforms/83xx/mpc8360e_pb.h
> b/arch/powerpc/platforms/83xx/mpc8360e_pb.h
> > new file mode 100644
> > index 0000000..4243f4a
> > --- /dev/null
> > +++ b/arch/powerpc/platforms/83xx/mpc8360e_pb.h
> > @@ -0,0 +1,31 @@
> > +/*
> > + * Copyright (C) Freescale Semicondutor, Inc. 2006. All rights reserved.
> > + *
> > + * Author: Li Yang <LeoLi@freescale.com>
> > + *	   Yin Olivia <Hong-hua.Yin@freescale.com>
> > + *
> > + * Description:
> > + * MPC8360E MDS PB board specific header.
> > + *
> > + * Changelog:
> > + * Jun 21, 2006	Initial version
> > + *
> > + * This program is free software; you can redistribute  it and/or modify
> it
> > + * under  the terms of  the GNU General  Public License as published by the
> > + * Free Software Foundation;  either version 2 of the  License, or (at your
> > + * option) any later version.
> > + *
> > + */
> > +
> > +#ifndef __MACH_MPC83XX_SYS_H__
> > +#define __MACH_MPC83XX_SYS_H__
> > +
> > +#define BCSR_PHYS_ADDR		((uint)0xf8000000)
> > +#define BCSR_SIZE		((uint)(32 * 1024))
> > +
> > +#define PIRQA	MPC83xx_IRQ_EXT4
> > +#define PIRQB	MPC83xx_IRQ_EXT5
> > +#define PIRQC	MPC83xx_IRQ_EXT6
> > +#define PIRQD	MPC83xx_IRQ_EXT7
> > +
> 
> Hrm, isn't PCI irq stuff encoded to the dts? Upper pci-related defines seem
> redundant...
I'll remove.
> 
> > +#endif				/* __MACH_MPC83XX_SYS_H__ */
> >
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-dev
> >
> >
> 
> 
> --
> Sincerely,
> Vitaly
