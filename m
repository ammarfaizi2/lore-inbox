Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264857AbTBFImM>; Thu, 6 Feb 2003 03:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262038AbTBFImM>; Thu, 6 Feb 2003 03:42:12 -0500
Received: from smtp.dslextreme.com ([66.51.205.17]:1003 "EHLO
	co1.dslextreme.com") by vger.kernel.org with ESMTP
	id <S264857AbTBFImE>; Thu, 6 Feb 2003 03:42:04 -0500
Date: Thu, 6 Feb 2003 00:37:25 -0800
From: Paul Laufer <paul@laufernet.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Adam Belay <ambx1@neo.rr.com>
Subject: OSS Sound Blaster sb_card.c rewrite (PnP, module options, etc)
Message-ID: <20030206083724.GA431@hal9000.laufernet.com>
Mail-Followup-To: Paul Laufer <paul@laufernet.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Adam Belay <ambx1@neo.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This is a rewrite of sound/oss/sb_card.c which handles detection of
Soundblaster ISA cards and clones. This rewrite uses the new PnP and
module APIs.

Attached are two files sb_card.c and sb_card.h that are drop in
replacements for sb_card.c. Verified to work with current bk.

Please test if you have ISA Soundblaster and clone cards and provide
feedback.

Thanks,
Paul Laufer

--mP3DRpeJDSE+ciuQ
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="sb_card.c"

/*
 * sound/oss/sb_card.c
 *
 * Detection routine for the ISA Sound Blaster and compatable sound
 * cards.
 *
 * This file is distributed under the GNU GENERAL PUBLIC LICENSE (GPL)
 * Version 2 (June 1991). See the "COPYING" file distributed with this
 * software for more info.
 *
 * This is a complete rewrite of the detection routines. This was
 * prompted by the PnP API change during v2.5 and the ugly state the
 * code was in.
 *
 * Copyright (C) by Paul Laufer 2002. Based on code originally by
 * Hannu Savolainen which was modified by many others over the
 * years. Authors specifically mentioned in the previous version were:
 * Daniel Stone, Alessandro Zummo, Jeff Garzik, Arnaldo Carvalho de
 * Melo, Daniel Church, and myself.
 *
 * 02-05-2003 Original Release, Paul Laufer <paul@laufernet.com>
 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/moduleparam.h>
#include <linux/init.h>
#ifdef CONFIG_MCA
#include <linux/mca.h>
#endif /* CONFIG_MCA */
#include "sound_config.h"
#include "sb_mixer.h"
#include "sb.h"
#include "sb_card.h"

#ifdef CONFIG_PNP_CARD
#include <linux/pnp.h>
#endif

MODULE_DESCRIPTION("OSS Soundblaster ISA PnP and legacy sound driver");
MODULE_LICENSE("GPL");

extern void *smw_free;

static int __initdata mpu_io	= 0;
static int __initdata io	= -1;
static int __initdata irq	= -1;
static int __initdata dma	= -1;
static int __initdata dma16	= -1;
static int __initdata type	= 0; /* Can set this to a specific card type */
static int __initdata esstype   = 0; /* ESS chip type */
static int __initdata acer 	= 0; /* Do acer notebook init? */
static int __initdata sm_games 	= 0; /* Logitech soundman games? */

struct sb_card_config *legacy = NULL;

#ifdef CONFIG_PNP_CARD
static int __initdata pnp       = 1;
/*
static int __initdata uart401	= 0;
*/
#else
static int __initdata pnp       = 0;
#endif

module_param(io, int, 000);
MODULE_PARM_DESC(io,       "Soundblaster i/o base address (0x220,0x240,0x260,0x280)");
module_param(irq, int, 000);
MODULE_PARM_DESC(irq,	   "IRQ (5,7,9,10)");
module_param(dma, int, 000);
MODULE_PARM_DESC(dma,	   "8-bit DMA channel (0,1,3)");
module_param(dma16, int, 000);
MODULE_PARM_DESC(dma16,	   "16-bit DMA channel (5,6,7)");
module_param(mpu_io, int, 000);
MODULE_PARM_DESC(mpu_io,   "MPU base address");
module_param(type, int, 000);
MODULE_PARM_DESC(type,	   "You can set this to specific card type (doesn't " \
		 "work with pnp)");
module_param(sm_games, int, 000);
MODULE_PARM_DESC(sm_games, "Enable support for Logitech soundman games " \
		 "(doesn't work with pnp)");
module_param(esstype, int, 000);
MODULE_PARM_DESC(esstype,  "ESS chip type (doesn't work with pnp)");
module_param(acer, int, 000);
MODULE_PARM_DESC(acer,	   "Set this to detect cards in some ACER notebooks "\
		 "(doesn't work with pnp)");

#ifdef CONFIG_PNP_CARD
module_param(pnp, int, 000);
MODULE_PARM_DESC(pnp,     "Went set to 0 will disable detection using PnP. "\
		  "Default is 1.\n");
/* Not done yet.... */
/*
module_param(uart401, int, 000);
MODULE_PARM_DESC(uart401,  "When set to 1, will attempt to detect and enable"\
		 "the mpu on some clones");
*/
#endif /* CONFIG_PNP_CARD */

/* OSS subsystem card registration shared by PnP and legacy routines */
static int sb_register_oss(struct sb_card_config *scc, struct sb_module_options *sbmo)
{
	if(!sb_dsp_detect(&scc->conf, 0, 0, sbmo)) {
		printk(KERN_ERR "sb: Failed DSP Detect.\n");
		kfree(scc);
		return -ENODEV;
	}
	if(!sb_dsp_init(&scc->conf, THIS_MODULE)) {
		printk(KERN_ERR "sb: Failed DSP init.\n");
		kfree(scc);
		return -ENODEV;
	}
	if(scc->mpucnf.io_base > 0) {
		scc->mpu = 1;
		printk(KERN_INFO "sb: Turning on MPU\n");
		if(!probe_sbmpu(&scc->mpucnf, THIS_MODULE))
			scc->mpu = 0;
	}

	return 1;
}

static void sb_unload(struct sb_card_config *scc)
{
	sb_dsp_unload(&scc->conf, 0);
	if(scc->mpu)
		unload_sbmpu(&scc->mpucnf);
	kfree(scc);
}

/* Register legacy card with OSS subsystem */
static int sb_init_legacy(void)
{
	struct sb_module_options sbmo = {0};

	if((legacy = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
		return -ENOMEM;
	}
	memset(legacy, 0, sizeof(struct sb_card_config));

	legacy->conf.io_base      = io;
	legacy->conf.irq          = irq;
	legacy->conf.dma          = dma;
	legacy->conf.dma2         = dma16;
	legacy->conf.card_subtype = type;

	legacy->mpucnf.io_base = mpu_io;
	legacy->mpucnf.irq     = -1;
	legacy->mpucnf.dma     = -1;
	legacy->mpucnf.dma2    = -1;

	sbmo.esstype  = esstype;
	sbmo.sm_games = sm_games;
	sbmo.acer     = acer;

	return sb_register_oss(legacy, &sbmo);
}

#ifdef CONFIG_PNP_CARD

/* Populate the OSS subsystem structures with information from PnP */
static void sb_dev2cfg(struct pnp_dev *dev, struct sb_card_config *scc)
{
	scc->conf.io_base   = -1;
	scc->conf.irq       = -1;
	scc->conf.dma       = -1;
	scc->conf.dma2      = -1;
	scc->mpucnf.io_base = -1;
	scc->mpucnf.irq     = -1;
	scc->mpucnf.dma     = -1;
	scc->mpucnf.dma2    = -1;

	/* All clones layout their PnP tables differently and some use
	   different logical devices for the MPU */
	if(!strncmp("CTL",scc->card_id,3)) {
		scc->conf.io_base   = pnp_port_start(dev,0);
		scc->conf.irq       = pnp_irq(dev,0);
		scc->conf.dma       = pnp_dma(dev,0);
		scc->conf.dma2      = pnp_dma(dev,1);
		scc->mpucnf.io_base = pnp_port_start(dev,1);
		return;
	}
	if(!strncmp("ESS",scc->card_id,3)) {
		scc->conf.io_base   = pnp_port_start(dev,0);
		scc->conf.irq       = pnp_irq(dev,0);
		scc->conf.dma       = pnp_dma(dev,0);
		scc->conf.dma2      = pnp_dma(dev,1);
	       	scc->mpucnf.io_base = pnp_port_start(dev,2);
		return;
	}
	if(!strncmp("CMI",scc->card_id,3)) {
		scc->conf.io_base = pnp_port_start(dev,0);
		scc->conf.irq     = pnp_irq(dev,0);
		scc->conf.dma     = pnp_dma(dev,0);
		scc->conf.dma2    = pnp_dma(dev,1);
		return;
	}
	if(!strncmp("RWB",scc->card_id,3)) {
		scc->conf.io_base = pnp_port_start(dev,0);
		scc->conf.irq     = pnp_irq(dev,0);
		scc->conf.dma     = pnp_dma(dev,0);
		return;
	}
	if(!strncmp("ALS",scc->card_id,3)) {
		if(!strncmp("ALS0007",scc->card_id,7)) {
			scc->conf.io_base = pnp_port_start(dev,0);
			scc->conf.irq     = pnp_irq(dev,0);
			scc->conf.dma     = pnp_dma(dev,0);
		} else {
			scc->conf.io_base = pnp_port_start(dev,0);
			scc->conf.irq     = pnp_irq(dev,0);
			scc->conf.dma     = pnp_dma(dev,1);
			scc->conf.dma2    = pnp_dma(dev,0);
		}
		return;
	}
	if(!strncmp("RTL",scc->card_id,3)) {
		scc->conf.io_base = pnp_port_start(dev,0);
		scc->conf.irq     = pnp_irq(dev,0);
		scc->conf.dma     = pnp_dma(dev,1);
		scc->conf.dma2    = pnp_dma(dev,0);
	}
}

/* Probe callback function for the PnP API */
static int sb_pnp_probe(struct pnp_card *card, const struct pnp_card_device_id *card_id)
{
	struct sb_card_config *scc;
	struct sb_module_options sbmo = {0}; /* Default to 0 for PnP */
	struct pnp_dev *dev = pnp_request_card_device(card, card_id->devs[0].id, NULL);
	
	if(!dev){
		return -EBUSY;
	}

	if((scc = kmalloc(sizeof(struct sb_card_config), GFP_KERNEL)) == NULL) {
		printk(KERN_ERR "sb: Error: Could not allocate memory\n");
		return -ENOMEM;
	}
	memset(scc, 0, sizeof(struct sb_card_config));

	printk(KERN_INFO "sb: PnP: Found Card Named = \"%s\", Card PnP id = " \
	       "%s, Device PnP id = %s\n", dev->card->name, card_id->id,
	       dev->id->id);

	scc->card_id = card_id->id;
	scc->dev_id = dev->id->id;
	sb_dev2cfg(dev, scc);

	printk(KERN_INFO "sb: PnP:      Detected at: io=0x%x, irq=%d, " \
	       "dma=%d, dma16=%d\n", scc->conf.io_base, scc->conf.irq,
	       scc->conf.dma, scc->conf.dma2);

	pnpc_set_drvdata(card, scc);

	return sb_register_oss(scc, &sbmo);
}

static void sb_pnp_remove(struct pnp_card *card)
{
	struct sb_card_config *scc = pnpc_get_drvdata(card);

	if(!scc)
		return;

	printk(KERN_INFO "sb: PnP: Removing %s\n", scc->card_id);

	sb_unload(scc);
}

static struct pnpc_driver sb_pnp_driver = {
	.name          = "OSS SndBlstr", /* 16 character limit */
	.id_table      = sb_pnp_card_table,
	.probe         = sb_pnp_probe,
	.remove        = sb_pnp_remove,
};
#endif /* CONFIG_PNP_CARD */

static int __init sb_init(void)
{
	int lres = 0;
	int pres = 0;

	printk(KERN_INFO "sb: Init: Starting Probe...\n");

	if(io != -1 && irq != -1 && dma != -1) {
		printk(KERN_INFO "sb: Probing legacy card with io=%x, "\
		       "irq=%d, dma=%d, dma16=%d\n",io, irq, dma, dma16);
		lres = sb_init_legacy();
	} else if((io != -1 || irq != -1 || dma != -1) ||
		  (!pnp && (io == -1 && irq == -1 && dma == -1)))
		printk(KERN_ERR "sb: Error: At least io, irq, and dma "\
		       "must be set for legacy cards.\n");

#ifdef CONFIG_PNP_CARD
	if(pnp) {
		pres = pnpc_register_driver(&sb_pnp_driver);
	}
#endif
	printk(KERN_INFO "sb: Init: Done\n");

	/* If either PnP or Legacy registered a card then return
	 * success */
	return (pres > 0 || lres > 0) ? 0 : -ENODEV;
}

static void __exit sb_exit(void)
{
	printk(KERN_INFO "sb: Unloading...\n");

	/* Unload legacy card */
	if (legacy) {
		printk (KERN_INFO "sb: Unloading legacy card\n");
		sb_unload(legacy);
	}

#ifdef CONFIG_PNP_CARD
	pnpc_unregister_driver(&sb_pnp_driver);
#endif

	if (smw_free) {
		vfree(smw_free);
		smw_free = NULL;
	}
}

module_init(sb_init);
module_exit(sb_exit);

--mP3DRpeJDSE+ciuQ
Content-Type: text/x-chdr; charset=us-ascii
Content-Disposition: attachment; filename="sb_card.h"

/*
 * sound/oss/sb_card.h
 *
 * This file is distributed under the GNU GENERAL PUBLIC LICENSE (GPL)
 * Version 2 (June 1991). See the "COPYING" file distributed with this
 * software for more info.
 *
 * 02-05-2002 Original Release, Paul Laufer <paul@laufernet.com>
 */

struct sb_card_config {
	struct address_info conf;
	struct address_info mpucnf;
	const  char         *card_id;
	const  char         *dev_id;
	int                 mpu;
};

#ifdef CONFIG_PNP_CARD

/*
 * SoundBlaster PnP tables and structures.
 */

/* Card PnP ID Table */
static struct pnp_card_device_id sb_pnp_card_table[] = {
	/* Sound Blaster 16 */
	{.id = "CTL0024", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL0025", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL0026", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL0027", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL0028", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL0029", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL002a", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL002b", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL002c", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL00ed", .driver_data = 0, devs : { {.id="CTL0041"}, } },
	/* Sound Blaster 16 */
	{.id = "CTL0086", .driver_data = 0, devs : { {.id="CTL0041"}, } },
	/* Sound Blaster Vibra16S */
	{.id = "CTL0051", .driver_data = 0, devs : { {.id="CTL0001"}, } },
	/* Sound Blaster Vibra16C */
	{.id = "CTL0070", .driver_data = 0, devs : { {.id="CTL0001"}, } },
	/* Sound Blaster Vibra16CL */
	{.id = "CTL0080", .driver_data = 0, devs : { {.id="CTL0041"}, } },
	/* Sound Blaster Vibra16CL */
	{.id = "CTL00F0", .driver_data = 0, devs : { {.id="CTL0043"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0039", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0042", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0043", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0044", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0045", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0046", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0047", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0048", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL0054", .driver_data = 0, devs : { {.id="CTL0031"}, } },
	/* Sound Blaster AWE 32 */
	{.id = "CTL009C", .driver_data = 0, devs : { {.id="CTL0041"}, } },
	/* Createive SB32 PnP */
	{.id = "CTL009F", .driver_data = 0, devs : { {.id="CTL0041"}, } },
	/* Sound Blaster AWE 64 */
	{.id = "CTL009D", .driver_data = 0, devs : { {.id="CTL0042"}, } },
	/* Sound Blaster AWE 64 Gold */
	{.id = "CTL009E", .driver_data = 0, devs : { {.id="CTL0044"}, } },
	/* Sound Blaster AWE 64 Gold */
	{.id = "CTL00B2", .driver_data = 0, devs : { {.id="CTL0044"}, } },
	/* Sound Blaster AWE 64 */
	{.id = "CTL00C1", .driver_data = 0, devs : { {.id="CTL0042"}, } },
	/* Sound Blaster AWE 64 */
	{.id = "CTL00C3", .driver_data = 0, devs : { {.id="CTL0045"}, } },
	/* Sound Blaster AWE 64 */
	{.id = "CTL00C5", .driver_data = 0, devs : { {.id="CTL0045"}, } },
	/* Sound Blaster AWE 64 */
	{.id = "CTL00C7", .driver_data = 0, devs : { {.id="CTL0045"}, } },
	/* Sound Blaster AWE 64 */
	{.id = "CTL00E4", .driver_data = 0, devs : { {.id="CTL0045"}, } },
	/* Sound Blaster AWE 64 */
	{.id = "CTL00E9", .driver_data = 0, devs : { {.id="CTL0045"}, } },
	/* ESS 1868 */
	{.id = "ESS0968", .driver_data = 0, devs : { {.id="ESS0968"}, } },
	/* ESS 1868 */
	{.id = "ESS1868", .driver_data = 0, devs : { {.id="ESS1868"}, } },
	/* ESS 1868 */
	{.id = "ESS1868", .driver_data = 0, devs : { {.id="ESS8611"}, } },
	/* ESS 1869 PnP AudioDrive */
	{.id = "ESS0003", .driver_data = 0, devs : { {.id="ESS1869"}, } },
	/* ESS 1869 */
	{.id = "ESS1869", .driver_data = 0, devs : { {.id="ESS1869"}, } },
	/* ESS 1878 */
	{.id = "ESS1878", .driver_data = 0, devs : { {.id="ESS1878"}, } },
	/* ESS 1879 */
	{.id = "ESS1879", .driver_data = 0, devs : { {.id="ESS1879"}, } },
	/* CMI 8330 SoundPRO */
	{.id = "CMI0001", .driver_data = 0, devs : { {.id="@X@0001"},
						     {.id="@H@0001"},
						     {.id="@@@0001"}, } },
	/* Diamond DT0197H */
	{.id = "RWR1688", .driver_data = 0, devs : { {.id="@@@0001"},
						     {.id="@X@0001"},
						     {.id="@H@0001"}, } },
	/* ALS007 */
	{.id = "ALS0007", .driver_data = 0, devs : { {.id="@@@0001"},
						     {.id="@X@0001"},
						     {.id="@H@0001"}, } },
	/* ALS100 */
	{.id = "ALS0001", .driver_data = 0, devs : { {.id="@@@0001"},
						     {.id="@X@0001"},
						     {.id="@H@0001"}, } },
	/* ALS110 */
	{.id = "ALS0110", .driver_data = 0, devs : { {.id="@@@1001"},
						     {.id="@X@1001"},
						     {.id="@H@0001"}, } },
	/* ALS120 */
	{.id = "ALS0120", .driver_data = 0, devs : { {.id="@@@2001"},
						     {.id="@X@2001"},
						     {.id="@H@0001"}, } },
	/* ALS200 */
	{.id = "ALS0200", .driver_data = 0, devs : { {.id="@@@0020"},
						     {.id="@X@0030"},
						     {.id="@H@0001"}, } },
	/* ALS200 */
	{.id = "RTL3000", .driver_data = 0, devs : { {.id="@@@2001"},
						     {.id="@X@2001"},
						     {.id="@H@0001"}, } },
	/* -end- */
	{.id = "", }
};

#endif

--mP3DRpeJDSE+ciuQ--
