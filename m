Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316878AbSGBTMa>; Tue, 2 Jul 2002 15:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316880AbSGBTM3>; Tue, 2 Jul 2002 15:12:29 -0400
Received: from adsl-67-117-73-34.dsl.sntc01.pacbell.net ([67.117.73.34]:55824
	"EHLO muru.com") by vger.kernel.org with ESMTP id <S316878AbSGBTMZ>;
	Tue, 2 Jul 2002 15:12:25 -0400
Date: Tue, 2 Jul 2002 12:14:54 -0700
To: linux-kernel@vger.kernel.org
Subject: amd-smp-idle module avail for testing max 90 W power savings
Message-ID: <20020702191454.GA25135@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Mailer: Mutt http://www.mutt.org/
X-URL: http://www.muru.com/ http://www.atomide.com
X-Accept-Language: fi en
X-Location: USA, California, San Francisco
From: Tony Lindgren <tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all,

I just posted a module to cut down on the energy bill for people with
dual Athlon systems, well currently only tested on Tyan S2460, which is
based on AMD-760MP chipset.

Amd-smp-idle enables the power savings mode like VCool and LVCool, but
amd-smp-idle uses the Linux PCI features, and supports currently SMP
only. So far I've squeezed out maximum 90 Watt power savings out of my
system :)

Adding support for other chipsets, and maybe merging the LVCool
functionality should be easy. Hopefully the core functionality will
eventually make it to the ACPI to provide C2 support.

Please note that there's a bug where loading the module for the first
time after rebooting causes the system to go sleep mode instead of
the idle mode. To wake up the system, just hit the power button once.
So, don't try this out on a remote server :)

The code is following, or you can also download it from:

http://www.muru.com/linux/amd-smp-idle/

Cheers,

Tony



--oyUTqETQ0mS9luUI
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: inline; filename="amd-smp-idle.c"

/*
 * Processor idle mode module for AMD SMP systems
 *
 * Copyright (C) 2002 Tony Lindgren <tony@atomide.com>
 *
 * Using this module saves about 70 - 90W of energy in the idle mode compared
 * to the default idle mode. Waking up from the idle mode is fast to keep the
 * system response time good. Currently no CPU load calculation is done, the
 * system exits the idle mode if the idle function runs twice on the same
 * processor in a row. This only works on SMP systems, but maybe the idle mode
 * enabling can be integrated to ACPI to provide C2 mode at some point.
 *
 * NOTE: Currently there's a bug somewhere where the reading the
 *       P_LVL2 for the first time causes the system to sleep instead of 
 *       idling. This means that you need to hit the power button once to
 *       wake the system after loading the module for the first time after
 *       reboot. After that the system idles as supposed.
 *
 *
 * Influenced by Vcool, and LVCool. Rewrote everything from scratch to
 * use the PCI features in Linux, and to support SMP systems.
 * 
 * Currently only tested on TYAN S2460 (760MP) system. Adding support 
 * for other Athlon SMP or single processor systems should be easy if 
 * desired.
 *
 * This software is licensed under GNU General Public License Version 2 
 * as specified in file COPYING in the Linux kernel source tree main 
 * directory.

 Compile command:
   gcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes \
   -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common \
   -pipe -mpreferred-stack-boundary=2 -march=athlon -DMODULE -DMODVERSIONS \
   -include /usr/src/linux/include/linux/modversions.h -c amd-idle.c

 */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/slab.h>
#include <linux/pci.h>
#include <linux/delay.h>

extern void default_idle(void);
static void amd_smp_idle(void);
static int amd_idle_main(void);
static int __devinit amd_nb_init(struct pci_dev *pdev,
				 const struct pci_device_id *ent);
static void amd_nb_remove(struct pci_dev *pdev);
static int __devinit amd_sb_init(struct pci_dev *pdev,
				 const struct pci_device_id *ent);
static void amd_sb_remove(struct pci_dev *pdev);

#define DEBUG 1
#define VERSION	"20020702"
#define AMD762		0x700c
#define AMD765_766	0x7413
#define CUR_PR	smp_processor_id()

struct pci_dev *pdev_nb;
struct pci_dev *pdev_sb;

struct idle_cfg {
	unsigned int status_reg;
	unsigned int idle_reg;
	unsigned int slp_reg;
	unsigned int resume_reg;
	void (*orig_idle) (void);
	void (*curr_idle) (void);
	int last_pr;
};
static struct idle_cfg amd_idle_cfg;

struct cpu_idle_state {
	int idle;
	int count;
};
static struct cpu_idle_state prs[2];

static struct pci_device_id amd_nb_tbl[] __devinitdata = {
	{PCI_VENDOR_ID_AMD, AMD762, PCI_ANY_ID, PCI_ANY_ID,},
	{0,}
};

static struct pci_device_id amd_sb_tbl[] __devinitdata = {
	{PCI_VENDOR_ID_AMD, AMD765_766, PCI_ANY_ID, PCI_ANY_ID,},
	{0,}
};

static struct pci_driver amd_nb_driver = {
	name:"amd-smp-idle-nb",
	id_table:amd_nb_tbl,
	probe:amd_nb_init,
	remove:__devexit_p(amd_nb_remove),
};

static struct pci_driver amd_sb_driver = {
	name:"amd-smp-idle-sb",
	id_table:amd_sb_tbl,
	probe:amd_sb_init,
	remove:__devexit_p(amd_sb_remove),
};

static int __devinit
amd_nb_init(struct pci_dev *pdev, const struct pci_device_id *ent)
{
	pdev_nb = pdev;
	printk(KERN_INFO "amd-smp-idle: Initializing northbridge %s\n",
	       pdev_nb->name);

	return 0;
}

static void __devexit
amd_nb_remove(struct pci_dev *pdev)
{
}

static int __devinit
amd_sb_init(struct pci_dev *pdev, const struct pci_device_id *ent)
{
	pdev_sb = pdev;
	printk(KERN_INFO "amd-smp-idle: Initializing southbridge %s\n",
	       pdev_sb->name);

	return 0;
}

static void __devexit
amd_sb_remove(struct pci_dev *pdev)
{
}

/*
 * Configures the southbridge to support idle calls, and gets
 * the processor idle call register location.
 */
static int
sb_idle_amd_766(int enable)
{
	unsigned int regdword;
	unsigned short regshort;
	unsigned char regbyte;

#define DCSTOP_EN	(1 << 1)
#define STPCLK_EN	(1 << 2)
#define CPUSTP_EN	(1 << 3)
#define PCISTP_EN	(1 << 4)
#define CPUSLP_EN	(1 << 5)
#define SUSPND_EN	(1 << 6)

#define C2_REGS		0
#define C3_REGS		8
#define POS_REGS	16	

	/* Get the address for pm status, P_LVL2, etc */
	pci_read_config_dword(pdev_sb, 0x58, &regdword);
	regdword &= 0xff80;
	amd_idle_cfg.status_reg = regdword + 0x00;
	amd_idle_cfg.slp_reg = regdword + 0x04;
	amd_idle_cfg.idle_reg = regdword + 0x14;
	amd_idle_cfg.resume_reg = regdword + 0x16;

	/* Set C2 options in C3A50, page 63 in AMD-766 doc */
	pci_read_config_dword(pdev_sb, 0x50, &regdword);

	regdword &= ~((DCSTOP_EN | CPUSTP_EN | PCISTP_EN | 
		       SUSPND_EN) << C2_REGS);

	regdword |= (STPCLK_EN << C2_REGS);	/* ~ 20 Watt savings max */
	regdword |= (CPUSLP_EN << C2_REGS);	/* Additional ~ 70 Watts max! */

	pci_write_config_dword(pdev_sb, 0x50, regdword);

	/* Clear W4SG, set STPGNT and PMIOEN at C3A41 */
	pci_read_config_byte(pdev_sb, 0x41, &regbyte);
	regbyte &= ~(1 << 0);
	regbyte |= ((1 << 1) | (1 << 7));
	pci_write_config_byte(pdev_sb, 0x41, regbyte);

	return 0;
}

/*
 * Configures the northbridge to support idle calls
 */
static int
nb_idle_amd_762(int enable)
{
	unsigned int regdword;

	/* Enable STPGNT in BIU Status/Control for cpu0 */
	pci_read_config_dword(pdev_nb, 0x60, &regdword);
	regdword |= (1 << 17);
	pci_write_config_dword(pdev_nb, 0x60, regdword);

	/* Enable STPGNT in BIU Status/Control for cpu1 */
	pci_read_config_dword(pdev_nb, 0x68, &regdword);
	regdword |= (1 << 17);
	pci_write_config_dword(pdev_nb, 0x68, regdword);

	/* DRAM refresh enable */
	pci_read_config_dword(pdev_nb, 0x58, &regdword);
	regdword &= ~(1 << 19);
	pci_write_config_dword(pdev_nb, 0x58, regdword);

	/* Self refresh enable */
	pci_read_config_dword(pdev_nb, 0x70, &regdword);
	regdword |= (1 << 18);
	pci_write_config_dword(pdev_nb, 0x70, regdword);

	return 0;
}

/*
 * Idle loop for single processor systems
 */
void
amd_idle(void)
{
	// FIXME: Optionally add non-smp idle loop here
}

/*
 * Idle loop for SMP systems, supports currently only 2 processors.
 */
static void
amd_smp_idle(void)
{

#define LAZY_IDLE_DELAY	800	/* 0: Best savings,  3000: More responsive */

	/*
	 * Exit idle mode immediately if the CPU does not change.
	 * Usually that means that we have some load on another CPU.
	 */
	if (prs[0].idle && prs[1].idle && amd_idle_cfg.last_pr == CUR_PR) {
		prs[0].idle = 0;
		prs[1].idle = 0;
		amd_idle_cfg.last_pr = CUR_PR;
		return;
	}

	prs[CUR_PR].count++;

	/* Don't start the idle mode immediately */
	if (prs[CUR_PR].count >= LAZY_IDLE_DELAY) {

		/* Put the current processor into idle mode */
		prs[CUR_PR].idle = 1;

		/* Only idle if both processors are idle */
		if (prs[0].idle && prs[1].idle)
			inb(amd_idle_cfg.idle_reg);

		prs[CUR_PR].count = 0;

	}
	amd_idle_cfg.last_pr = CUR_PR;
}

/*
 * Finds and initializes the bridges, and then sets the idle function
 */
static int
amd_idle_main(void)
{
	int found;

	/* Find northbridge */
	found = pci_module_init(&amd_nb_driver);
	if (found < 0) {
		printk(KERN_ERR "amd-smp-idle: Could not find northbridge\n");
		return 1;
	}

	/* Find southbridge */
	found = pci_module_init(&amd_sb_driver);
	if (found < 0) {
		printk(KERN_ERR "amd-smp-idle: Could not find southbridge\n");
		pci_unregister_driver(&amd_nb_driver);
		return 1;
	}

	/* Init southbridge */
	switch (pdev_sb->device) {
	case AMD765_766:	/* AMD-765 or 766 */
		sb_idle_amd_766(1);
		break;
	default:
		printk(KERN_ERR "amd-smp-idle: No southbridge to initialize\n");
		break;
	}

	/* Init northbridge and queue the new idle function */
	switch (pdev_nb->device) {
	case AMD762:
		nb_idle_amd_762(1);
		amd_idle_cfg.curr_idle = amd_smp_idle;
		break;
	default:
		printk(KERN_ERR "amd-smp-idle: No northbridge to initialize\n");
		break;
	}

	if (!amd_idle_cfg.curr_idle) {
		printk(KERN_ERR "amd-smp-idle: Idle function not changed\n");
		return 1;
	}

	amd_idle_cfg.orig_idle = pm_idle;
	pm_idle = amd_idle_cfg.curr_idle;

	return 0;
}

static int __init
amd_idle_init(void)
{
	printk(KERN_INFO "amd-smp-idle: AMD processor idle module version %s\n",
	       VERSION);
	return amd_idle_main();
}

static void __exit
amd_idle_cleanup(void)
{
	pm_idle = amd_idle_cfg.orig_idle;

	/* 
	 * FIXME: We want to wait until all CPUs have set the new
	 * idle function, otherwise we will oops. This may not be
	 * the right way to do it, but seems to work.
	 */
	schedule();
	mdelay(1000);

	pci_unregister_driver(&amd_nb_driver);
	pci_unregister_driver(&amd_sb_driver);

}

MODULE_LICENSE("GPL");
module_init(amd_idle_init);
module_exit(amd_idle_cleanup);

--oyUTqETQ0mS9luUI--
