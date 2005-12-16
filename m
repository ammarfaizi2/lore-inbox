Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbVLPQ1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbVLPQ1W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 11:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLPQ1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 11:27:21 -0500
Received: from styx.suse.cz ([82.119.242.94]:64954 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932300AbVLPQ1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 11:27:19 -0500
Date: Fri, 16 Dec 2005 17:27:17 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: Problems in the SiS IDE driver
Message-ID: <20051216162717.GA22388@ucw.cz>
References: <1134587705.25663.67.camel@localhost.localdomain> <20051214211216.GA6045@corona.suse.de> <1134685088.20495.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <1134685088.20495.2.camel@localhost.localdomain>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 15, 2005 at 10:18:08PM +0000, Alan Cox wrote:
> On Mer, 2005-12-14 at 22:12 +0100, Vojtech Pavlik wrote:
> > > And timing can be zero....
> > > 
> > > Would be useful to know if this is a bug, and also what the correct
> > > behaviour is at this point as I don't have all the SiS data sheets.
> > 
> > This is a bug - test1 should be initialized to 0.
> 
> Thanks. Will fix that in the pata_ version. The MWDMA support for some
> chips also appears to be missing (it doesn't load timing values at all
> and it doesn't do PIO/MWDMA setup timing checks).
 
MWDMA setup is the same as PIO, although the numbers may differ a bit.

I'm attaching my old rewritten SiS driver, which only supports
pre-ATA100 chipsets, but should have all the registers setup correctly.
It might help you.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis5513.c"

/*
 * $Id: sis5513.c,v 1.1 2000/10/10 22:58:60 vojtech Exp $
 *
 *  Copyright (c) 2000 Vojtech Pavlik
 *
 *  Based on the work of:
 *      Andre Hedrick
 */

/*
 * SiS5513 IDE driver for Linux.
 */

/*
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 * Should you need to contact me, the author, you can do so either by
 * e-mail - mail your message to <vojtech@ucw.cz>, or by paper mail:
 * Vojtech Pavlik, Simunkova 1594, Prague 8, 182 00 Czech Republic
 */

#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/ioport.h>
#include <linux/blkdev.h>
#include <linux/pci.h>
#include <linux/init.h>
#include <linux/ide.h>
#include <asm/io.h>

#include "ide-timing.h"

#define SIS_DRIVE_TIMING	0x40
#define SIS_IDE_STATUS		0x48
#define SIS_CMD_TIMING		0x48
#define SIS_GENCTL_0		0x4a
#define SIS_GENCTL_1		0x4b
#define SIS_PREFETCH		0x4c
#define SIS_MISC		0x52

#define SIS_UDMA		0x07
#define SIS_UDMA_33		0x01
#define SIS_UDMA_66		0x02
#define SIS_LATENCY		0x08
#define SIS_CMDTIME		0x10

/*
 * SiS chips
 */

static struct sis_isa_bridge {
	char *name;
	unsigned short id;
	unsigned char flags;
} sis_isa_bridges[] = {
	{ "630",	PCI_DEVICE_ID_SI_630,	SIS_UDMA_66 | SIS_LATENCY },
	{ "620",	PCI_DEVICE_ID_SI_620,	SIS_UDMA_66 | SIS_LATENCY },
	{ "540",	PCI_DEVICE_ID_SI_540,	SIS_UDMA_66 },
	{ "530",	PCI_DEVICE_ID_SI_530,	SIS_UDMA_66 },
	{ "5600",	PCI_DEVICE_ID_SI_5600,	SIS_UDMA_33 | SIS_CMDTIME },
	{ "5597",	PCI_DEVICE_ID_SI_5597,	SIS_UDMA_33 | SIS_CMDTIME },
	{ "5591",	PCI_DEVICE_ID_SI_5591,	SIS_UDMA_33 | SIS_CMDTIME },
	{ "5511",	PCI_DEVICE_ID_SI_5511,	SIS_CMDTIME },
	{ NULL }
};

static struct sis_isa_bridge *sis_config;
static unsigned char sis_enabled;
static unsigned int sis_80w;

static unsigned char sis_cyc2act[] = { 1, 1, 2, 3, 4, 5, 6, 7, 0, 8, 8, 8, 8 };
static unsigned char sis_cyc2rec[] = { 1, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0, 12, 13, 14 };
static unsigned char sis_act2cyc[] = { 8, 1, 2, 3, 4, 5, 6, 12 };
static unsigned char sis_rec2cyc[] = { 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 13, 14, 15, 15 };

/*
 * SiS /proc entry.
 */

#ifdef CONFIG_PROC_FS

#include <linux/stat.h>
#include <linux/proc_fs.h>

byte sis_proc;
int sis_base;
static struct pci_dev *bmide_dev, *isa_dev;
extern int (*sis_display_info)(char *, char **, off_t, int); /* ide-proc.c */

#define sis_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
#define sis_print_drive(name, format, arg...)\
	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");

static int sis_get_info(char *buffer, char **addr, off_t offset, int count)
{
	short pci_clock, speed[4], cycle[4], active[4],
		recover[4], uen[4], udma[4], active8b[4], recover8b[4];
	struct pci_dev *dev = bmide_dev;
	unsigned int i;
	unsigned short c;
	unsigned char t, x;
	char *p = buffer;

	sis_print("----------SiS BusMastering IDE Configuration----------------");

	sis_print("Driver Version:                     1.1");
	sis_print("South Bridge:                       SiS %s", sis_config->name);

	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
	pci_read_config_byte(dev, PCI_REVISION_ID, &x);
	sis_print("Revision:                           ISA %#x IDE %#x", t, x);

	sis_print("BM-DMA base:                        %#x", sis_base);
	sis_print("PCI clock:                          %dMHz", pci_clock = system_bus_clock());

	sis_print("-----------------------Primary IDE-------Secondary IDE------");

	pci_read_config_byte(dev, SIS_GENCTL_0, &t);
	sis_print("Enabled:               %10s%20s", (t & 0x01) ? "yes" : "no", (t & 0x02) ? "yes" : "no");

	c = inb(sis_base + 0x02) | (inb(sis_base + 0x0a) << 8);
	sis_print("Simplex only:          %10s%20s", (c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");

	if ((sis_config->flags & SIS_UDMA) == SIS_UDMA_66)
		pci_read_config_byte(dev, SIS_IDE_STATUS, &t); else t = 0;
	sis_print("Cable Type:            %10s%20s", (t & 0x10) ? "80w" : "40w", (t & 0x20) ? "80w" : "40w");

	sis_print("-------------------drive0----drive1----drive2----drive3-----");

	pci_read_config_byte(dev, SIS_GENCTL_1, &t);
	sis_print_drive("Prefetch:      ", "%10s", (t & (0x01 << i)) ? "yes" : "no");
	sis_print_drive("Post Write:    ", "%10s", (t & (0x10 << i)) ? "yes" : "no");

	for (i = 0; i < 4; i++) {

		pci_read_config_byte(dev, SIS_DRIVE_TIMING + i * 3 + 0, &t);
		recover[i] = sis_rec2cyc[t & 0x0f];
		recover8b[i] = recover[i];

		pci_read_config_byte(dev, SIS_DRIVE_TIMING + i * 3 + 1, &t);
		active[i] = sis_act2cyc[t & 0x07];
		active8b[i] = active[i];

		if (sis_config->flags & SIS_CMDTIME) {
			pci_read_config_byte(dev, SIS_MISC, &t);
			if (t & 0x08) {
				pci_read_config_byte(dev, SIS_CMD_TIMING + 0, &t);
				recover8b[i] = sis_rec2cyc[t & 0x0f];
				pci_read_config_byte(dev, SIS_CMD_TIMING + 1, &t);
				active8b[i] = sis_act2cyc[t & 0x07];
			}
		}

		if (sis_config->flags & SIS_UDMA) {
			uen[i]    = (t & 0x80) ? 1 : 0;
			udma[i]   = (((t >> 4) & 0x07) | ((sis_config->flags & SIS_UDMA) == SIS_UDMA_33)) + 1;
		} else uen[i] = udma[i] = 0;

		speed[i] = 40 * pci_clock / (uen[i] ? udma[i] : (active[i] + recover[i]) * 2);
		cycle[i] = 1000 / pci_clock * (uen[i] ? udma[i] : (active[i] + recover[i]) * 2) / 2;
	}

	sis_print_drive("Transfer Mode: ", "%10s",
			(c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2)) ? (uen[i] ? "UDMA" : "DMA") : "PIO");

	sis_print_drive("Address Setup: ", "%8dns", (1000 / pci_clock) * 3);
	sis_print_drive("Cmd Active:    ", "%8dns", (1000 / pci_clock) * active8b[i]);
	sis_print_drive("Cmd Recovery:  ", "%8dns", (1000 / pci_clock) * recover8b[i]);
	sis_print_drive("Data Active:   ", "%8dns", (1000 / pci_clock) * active[i]);
	sis_print_drive("Data Recovery: ", "%8dns", (1000 / pci_clock) * recover[i]);
	sis_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
	sis_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 10, speed[i] % 10);

	return p - buffer;	/* hoping it is less than 4K... */
}

#endif

/*
 * sis_set_speed() writes timing values to the chipset registers
 */

static void sis_set_speed(struct pci_dev *dev, unsigned char dn, struct ide_timing *timing)
{
	unsigned char t;

	if (sis_config->flags & SIS_CMDTIME) {
		pci_write_config_byte(dev, SIS_CMD_TIMING + 0, sis_cyc2rec[FIT(timing->rec8b, 1, 15)]);
		pci_write_config_byte(dev, SIS_CMD_TIMING + 1, sis_cyc2act[FIT(timing->act8b, 1, 12)]);
	}

	pci_write_config_byte(dev, SIS_DRIVE_TIMING + dn * 3 + 0, sis_cyc2rec[FIT(timing->recover, 1, 15)]);

	t = sis_cyc2act[FIT(timing->active, 1, 12)];

	switch(sis_config->flags & SIS_UDMA) {
		case SIS_UDMA_33: t |= timing->udma ? (0x80 | ((FIT(timing->udma, 2, 4) - 1) << 5)) : 0x60; break;
		case SIS_UDMA_66: t |= timing->udma ? (0x80 | ((FIT(timing->udma, 2, 8) - 1) << 4)) : 0x70; break;
	}

	pci_write_config_byte(dev, SIS_DRIVE_TIMING + dn * 3 + 1, t);
}

/*
 * sis_set_drive() computes timing values configures the drive and
 * the chipset to a desired transfer mode. It also can be called
 * by upper layers.
 */

static int sis_set_drive(ide_drive_t *drive, unsigned char speed)
{
	ide_drive_t *peer;
	struct ide_timing t, p;
	int i, err, T, UT;

	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
		if ((err = ide_config_drive_speed(drive, speed)))
			return err;

	T = 1000 / system_bus_clock();
	UT = T / MAX(sis_config->flags & SIS_UDMA, 1);

	ide_timing_compute(drive, speed, &t, T, UT);

	if (sis_config->flags & SIS_CMDTIME) {
		for (i = 0; i < 4; i++) {
			peer = HWIF(drive)->drives + i;
			if (!peer->present) continue;
			ide_timing_compute(peer, peer->current_speed, &p, T, UT);
			ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
		}
	} else {
		t.recover = MAX(t.recover, t.rec8b);
		t.active = MAX(t.active, t.act8b);
	}

	sis_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);

	if (!drive->init_speed)	
		drive->init_speed = speed;
	drive->current_speed = speed;

	return 0;
}

/*
 * sis5513_tune_drive() is a callback from upper layers for
 * PIO-only tuning.
 */

static void sis5513_tune_drive(ide_drive_t *drive, unsigned char pio)
{
	if (!((sis_enabled >> HWIF(drive)->channel) & 1))
		return;

	if (pio == 255) {
		sis_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
		return;
	}

	sis_set_drive(drive, XFER_PIO_0 + MIN(pio, 5));
}

#ifdef CONFIG_BLK_DEV_IDEDMA

/*
 * sis5513_dmaproc() is a callback from upper layers that can do
 * a lot, but we use it for DMA/PIO tuning only, delegating everything
 * else to the default ide_dmaproc().
 */

int sis5513_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
{

	if (func == ide_dma_check) {

		short w80 = eighty_ninty_three(drive);

		short speed = ide_find_best_mode(drive,
			XFER_PIO | XFER_EPIO | XFER_SWDMA | XFER_MWDMA |
			(sis_config->flags & SIS_UDMA ? XFER_UDMA : 0) |
			(w80 && (sis_config->flags & SIS_UDMA) == SIS_UDMA_66 ? XFER_UDMA_66 : 0));

		func =  ((speed & XFER_MODE) != XFER_PIO) ? ide_dma_on : ide_dma_off_quietly;

		if (sis_set_drive(drive, speed))
			func =  ide_dma_off;
	}

	return ide_dmaproc(func, drive);
}

#endif /* CONFIG_BLK_DEV_IDEDMA */

/*
 * The initialization callback. Here we determine the IDE chip type
 * and initialize its drive independent registers.
 */

unsigned int __init pci_init_sis5513(struct pci_dev *dev, const char *name)
{
	struct pci_dev *isa = NULL;
	unsigned char t;
	int i;

/*
 * Find ISA bridge to see how good the IDE is.
 */

	for (sis_config = sis_isa_bridges; sis_config->id; sis_config++)
		if ((isa = pci_find_device(PCI_VENDOR_ID_SI, sis_config->id, NULL))) 
			break;

	if (!sis_config->id) {
		printk(KERN_WARNING "SIS5513: Unknown SiS chip, contact Vojtech Pavlik <vojtech@suse.cz>\n");
		return -ENODEV;
	}

/*
 * Fix latency setting.
 */

	if (sis_config->flags & SIS_LATENCY)
		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x10);

/*
 * Enable prefetch and postwrite on all drives.
 */

	pci_write_config_byte(dev, SIS_GENCTL_1, 0xff);
	pci_write_config_word(dev, SIS_PREFETCH + 0, 512);
	pci_write_config_word(dev, SIS_PREFETCH + 1, 512);

/*
 * Set separate command timing, disable IDE Granting Timer and set 64 byte FIFO.
 */

	if (sis_config->flags & SIS_CMDTIME)
		pci_write_config_byte(dev, SIS_MISC, 0x01);

/*
 * Check 80-wire cable presence.
 */

	if ((sis_config->flags & SIS_UDMA) == SIS_UDMA_66) {
		pci_read_config_byte(dev, SIS_IDE_STATUS, &t);
		sis_80w = (t >> 4) & 3;
	}

	pci_read_config_byte(dev, SIS_GENCTL_0, &t);
	sis_enabled = (t >> 1) & 3;

/*
 * Print the boot message.
 */

	printk(KERN_INFO "SIS5512: SIS %s IDE %s controller on pci%d:%d.%d\n",
			sis_config->name,
			(sis_config->flags & SIS_UDMA) == SIS_UDMA_66 ? "UDMA66" :
			(sis_config->flags & SIS_UDMA) == SIS_UDMA_33 ? "UDMA33" : "MWDMA16",
			dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));

/*
 * Register /proc/ide/sis entry
 */

#ifdef CONFIG_PROC_FS
	if (!sis_proc) {
		for (i = 0; i < 6; i++)
                	if (pci_resource_flags(dev, i) & IORESOURCE_IO)
                        	break;
		
		sis_base = pci_resource_start(dev, i);
		bmide_dev = dev;
		isa_dev = isa;
		sis_display_info = &sis_get_info;
		sis_proc = 1;

	}
#endif

	return 0;
}

unsigned int __init ata66_sis5513(ide_hwif_t *hwif)
{
	return ((sis_enabled & sis_80w) >> hwif->channel) & 1;
}

void __init ide_init_sis5513(ide_hwif_t *hwif)
{
	int i;

	hwif->tuneproc = &sis5513_tune_drive;
	hwif->speedproc = &sis_set_drive;
	hwif->autodma = 0;

	for (i = 0; i < 2; i++) {
		hwif->drives[i].io_32bit = 1;
		hwif->drives[i].unmask = 1;
		hwif->drives[i].autotune = 1;
		hwif->drives[i].dn = hwif->channel * 2 + i;
	}

#ifdef CONFIG_BLK_DEV_IDEDMA
	if (hwif->dma_base) {
		hwif->dmaproc = &sis5513_dmaproc;
		hwif->autodma = 1;
	}
#endif /* CONFIG_BLK_DEV_IDEDMA */
}

/*
 * We allow the BM-DMA driver only work on enabled interfaces.
 */

void __init ide_dmacapable_sis5513(ide_hwif_t *hwif, unsigned long dmabase)
{
	if ((sis_enabled >> hwif->channel) & 1)
		ide_setup_dma(hwif, dmabase, 8);
}

--C7zPtVaVf+AK4Oqc--
