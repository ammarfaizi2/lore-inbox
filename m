Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129729AbRALI2m>; Fri, 12 Jan 2001 03:28:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129825AbRALI2c>; Fri, 12 Jan 2001 03:28:32 -0500
Received: from styx.suse.cz ([195.70.145.226]:61688 "EHLO kerberos.suse.cz")
	by vger.kernel.org with ESMTP id <S129729AbRALI2Y>;
	Fri, 12 Jan 2001 03:28:24 -0500
Date: Fri, 12 Jan 2001 09:28:13 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD760/765 DDR Athlon testers needed....
Message-ID: <20010112092813.C812@suse.cz>
In-Reply-To: <Pine.LNX.4.10.10101110942250.29587-200000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10101110942250.29587-200000@master.linux-ide.org>; from andre@linux-ide.org on Thu, Jan 11, 2001 at 09:46:41AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

Hmm, seems like I've got that one covered a while ago already ...
though I must admit my code isn't tested yet.

Vojtech

On Thu, Jan 11, 2001 at 09:46:41AM -0800, Andre Hedrick wrote:
> 
> Calling AMD Geeks^H^H^H^H^HUsers,
> 
> I have one of these DDR boxes from AMD with the AMD760/765 cores, if you
> have one please let me know if you wnat to test this new code?
> It is only ATA66 limited and the DOCS I have do not have the ATA100
> timings.
> 
> Cheers,
> 
> Andre Hedrick
> Linux ATA Development

> Inspecting /boot/System.map
> Symbol table has incorrect version number.
> 
> <6>Uniform Multi-Platform E-IDE driver Revision: 6.30
> <4>ide: Assuming 33MHz system bus speed for PIO modes
> <4>AMD7411: IDE controller on PCI bus 00 dev 39
> <4>AMD7411: chipset revision 1
> <4>AMD7411: not 100% native mode: will probe irqs later
> <4>    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
> <4>    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
> <4>PDC20267: IDE controller on PCI bus 00 dev 58
> <4>PDC20267: chipset revision 2
> <4>PDC20267: not 100% native mode: will probe irqs later
> <4>PDC20267: ROM enabled at 0xe7000000
> <4>PDC20267: (U)DMA Burst Bit ENABLED Primary PCI Mode Secondary PCI Mode.
> <4>    ide2: BM-DMA at 0xe800-0xe807, BIOS settings: hde:DMA, hdf:pio
> <4>    ide3: BM-DMA at 0xe808-0xe80f, BIOS settings: hdg:DMA, hdh:pio
> <4>hda: QUANTUM FIREBALL CX13.0A, ATA DISK drive
> <4>hdb: QUANTUM FIREBALL CR4.3A, ATA DISK drive
> <4>hdc: ATAPI CD ROM DRIVE 50X MAX, ATAPI CDROM drive
> <4>hdd: HITACHI DVD-RAM GF-2000, ATAPI CDROM drive
> <4>ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
> <4>ide1 at 0x170-0x177,0x376 on irq 15
> <4>hda: TF.1=x00 TF.2=x00 TF.3=x00 TF.4=x00 TF.5=x00 TF.6=x40 TF.7=xf8 
> <6>hda: QUANTUM FIREBALL CX13.0A, 12416MB w/418kB Cache, CHS=25228/16/63, UDMA(33)
> <4>hdb: TF.1=x00 TF.2=x00 TF.3=x00 TF.4=x00 TF.5=x00 TF.6=x40 TF.7=xf8 
> <6>hdb: QUANTUM FIREBALL CR4.3A, 4110MB w/418kB Cache, CHS=14848/9/63, UDMA(66)
> <4>hdc: ATAPI 50X CD-ROM drive, 128kB Cache, UDMA(33)
> <6>Uniform CD-ROM driver Revision: 3.11
> <4>hdd: ATAPI DVD-ROM DVD-R drive, 512kB Cache, UDMA(33)

-- 
Vojtech Pavlik
SuSE Labs

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amd7409.c"

/*
 * $Id: amd7409.c,v 1.4 2000/09/19 08:33:60 vojtech Exp $
 *
 *  Copyright (c) 2000 Vojtech Pavlik
 *
 *  Based on the work of:
 *	Andre Hedrick
 *
 *  Sponsored by SuSE
 */

/*
 * AMD755/756 IDE driver for Linux.
 *
 * UDMA66 and higher modes are autodetected only in case the BIOS has enabled
 * them. To force UDMA66, use 'ide0=ata66' or 'ide1=ata66' on the kernel
 * command line. You may also need to configure the kernel IDE driver to ignore
 * byte93 UDMA66 enable bits if your drives don't use them correctly.
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
 * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
 * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
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

#define AMD_IDE_ENABLE		0x40
#define AMD_IDE_CONFIG		0x41
#define AMD_CABLE_DETECT	0x42
#define AMD_DRIVE_TIMING	0x48
#define AMD_8BIT_TIMING		0x4e
#define AMD_ADDRESS_SETUP	0x4c
#define AMD_UDMA_TIMING		0x50

#define AMD_UDMA		0x07
#define AMD_UDMA_33		0x01
#define AMD_UDMA_66		0x02
#define AMD_UDMA_100		0x04
#define AMD_NO_SWDMA		0x08
#define AMD_CABLE		0x10

#ifndef PCI_DEVICE_ID_AMD_VIPPL_7411
#define PCI_DEVICE_ID_AMD_VIPPL_7411	0x7411
#endif

/*
 * AMD SouthBridge chips.
 */

static struct amd_ide_chip {
	char *name;
	unsigned short id;
	unsigned char rev;
	unsigned char flags;
} amd_ide_chips[] = {
	{ "766 ViperPlus",	PCI_DEVICE_ID_AMD_VIPPL_7411, 0x00, AMD_UDMA_100 | AMD_CABLE },
	{ "756/c4+ Viper",	PCI_DEVICE_ID_AMD_VIPER_7409, 0x07, AMD_UDMA_66 },
	{ "756 Viper",		PCI_DEVICE_ID_AMD_VIPER_7409, 0x00, AMD_UDMA_66 | AMD_NO_SWDMA },
	{ "755 Cobra",		PCI_DEVICE_ID_AMD_COBRA_7401, 0x00, AMD_UDMA_33 | AMD_NO_SWDMA },
	{ NULL }
};

static struct amd_ide_chip *amd_config;
static unsigned char amd_enabled;
static unsigned int amd_80w;

static unsigned char amd_cyc2udma[] = { 5, 5, 5, 4, 0, 1, 1, 2, 2, 3, 3 };
static unsigned char amd_udma2cyc[] = { 4, 6, 8, 10, 3, 2, 1, 1 };

/*
 * AMD /proc entry.
 */

#ifdef CONFIG_PROC_FS

#include <linux/stat.h>
#include <linux/proc_fs.h>

int amd7409_proc, amd_base;
static struct pci_dev *bmide_dev;
extern int (*amd7409_display_info)(char *, char **, off_t, int); /* ide-proc.c */

#define amd_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
#define amd_print_drive(name, format, arg...)\
	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");

static int amd_get_info(char *buffer, char **addr, off_t offset, int count)
{
	short pci_clock, speed[4], cycle[4], setup[4], active[4],
		recover[4], uen[4], udma[4], active8b[4], recover8b[4];
	struct pci_dev *dev = bmide_dev;
	unsigned int v, u, i;
	unsigned short c, w;
	unsigned char t;
	char *p = buffer;

	amd_print("----------AMD BusMastering IDE Configuration----------------");

	amd_print("Driver Version:                     1.4");
	amd_print("South Bridge:                       AMD-%s", amd_config->name);

	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
	amd_print("Revision:                           IDE %#x", t);

	amd_print("BM-DMA base:                        %#x", amd_base);
	amd_print("PCI clock:                          %dMHz", pci_clock = system_bus_clock());

	amd_print("-----------------------Primary IDE-------Secondary IDE------");

	pci_read_config_byte(dev, AMD_IDE_CONFIG, &t);
	amd_print("Prefetch Buffer:       %10s%20s", (t & 0x80) ? "yes" : "no", (t & 0x20) ? "yes" : "no");
	amd_print("Post Write Buffer:     %10s%20s", (t & 0x40) ? "yes" : "no", (t & 0x10) ? "yes" : "no");

	pci_read_config_byte(dev, AMD_IDE_ENABLE, &t);
	amd_print("Enabled:               %10s%20s", (t & 0x02) ? "yes" : "no", (t & 0x01) ? "yes" : "no");

	c = inb(amd_base + 0x02) | (inb(amd_base + 0x0a) << 8);
	amd_print("Simplex only:          %10s%20s", (c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");

	amd_print("Cable Type:            %10s%20s", (amd_80w & 1) ? "80w" : "40w", (amd_80w & 2) ? "80w" : "40w");

	amd_print("-------------------drive0----drive1----drive2----drive3-----");

	pci_read_config_byte(dev, AMD_ADDRESS_SETUP, &t);
	pci_read_config_dword(dev, AMD_DRIVE_TIMING, &v);
	pci_read_config_word(dev, AMD_8BIT_TIMING, &w);
	pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);

	for (i = 0; i < 4; i++) {
		setup[i]     = ((t >> ((3 - i) << 1)) & 0x3) + 1;
		recover8b[i] = ((w >> ((1 - (i >> 1)) << 3)) & 0xf) + 1;
		active8b[i]  = ((w >> (((1 - (i >> 1)) << 3) + 4)) & 0xf) + 1;
		active[i]    = ((v >> (((3 - i) << 3) + 4)) & 0xf) + 1;
		recover[i]   = ((v >> ((3 - i) << 3)) & 0xf) + 1;

		udma[i] = amd_udma2cyc[((u >> ((3 - i) << 3)) & 0x7)];
		uen[i]  = ((u >> ((3 - i) << 3)) & 0x40) ? 1 : 0;

		speed[i] = 40 * pci_clock / (uen[i] ? udma[i] : (active[i] + recover[i]) * 2);
		cycle[i] = 1000 / pci_clock * (uen[i] ? udma[i] : (active[i] + recover[i]) * 2) / 2;
	}

	amd_print_drive("Transfer Mode: ", "%10s",
			(c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2)) ? (uen[i] ? "UDMA" : "DMA") : "PIO");

	amd_print_drive("Address Setup: ", "%8dns", (1000 / pci_clock) * setup[i]);
	amd_print_drive("Cmd Active:    ", "%8dns", (1000 / pci_clock) * active8b[i]);
	amd_print_drive("Cmd Recovery:  ", "%8dns", (1000 / pci_clock) * recover8b[i]);
	amd_print_drive("Data Active:   ", "%8dns", (1000 / pci_clock) * active[i]);
	amd_print_drive("Data Recovery: ", "%8dns", (1000 / pci_clock) * recover[i]);
	amd_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
	amd_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 10, speed[i] % 10);

	return p - buffer;	/* hoping it is less than 4K... */
}

#endif

/*
 * amd_set_speed() writes timing values to the chipset registers
 */

static void amd_set_speed(struct pci_dev *dev, unsigned char dn, struct ide_timing *timing)
{
	unsigned char t;

	pci_read_config_byte(dev, AMD_ADDRESS_SETUP, &t);
	t = (t & ~(3 << ((3 - dn) << 1))) | ((FIT(timing->setup, 1, 4) - 1) << ((3 - dn) << 1));
	pci_write_config_byte(dev, AMD_ADDRESS_SETUP, t);

	pci_write_config_byte(dev, AMD_8BIT_TIMING + (1 - (dn >> 1)),
		((FIT(timing->act8b, 1, 16) - 1) << 4) | (FIT(timing->rec8b, 1, 16) - 1));

	pci_write_config_byte(dev, AMD_DRIVE_TIMING + (3 - dn),
		((FIT(timing->active, 1, 16) - 1) << 4) | (FIT(timing->recover, 1, 16) - 1));

	switch(amd_config->flags & AMD_UDMA) {
		case AMD_UDMA_33: t = timing->udma ? (0xc0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
		case AMD_UDMA_66: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 2, 10)]) : 0x03; break;
		case AMD_UDMA_100: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma / 2, 2, 10)]) : 0x03; break;
	}

	pci_write_config_byte(dev, AMD_UDMA_TIMING + (3 - dn), t);
}

/*
 * amd_set_drive() computes timing values configures the drive and
 * the chipset to a desired transfer mode. It also can be called
 * by upper layers.
 */

static int amd_set_drive(ide_drive_t *drive, unsigned char speed)
{
	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
	struct ide_timing t, p;
	int err, T, UT;

	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
		if ((err = ide_config_drive_speed(drive, speed)))
			return err;

	T = 1000 / system_bus_clock();
	UT = T / MAX(amd_config->flags & AMD_UDMA, 1);

	ide_timing_compute(drive, speed, &t, T, UT);

	if (peer->present) {
		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
	}

	amd_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);

	if (!drive->init_speed)	
		drive->init_speed = speed;
	drive->current_speed = speed;

	return 0;
}

/*
 * amd7409_tune_drive() is a callback from upper layers for
 * PIO-only tuning.
 */

static void amd7409_tune_drive(ide_drive_t *drive, unsigned char pio)
{
	if (!((amd_enabled >> HWIF(drive)->channel) & 1))
		return;

	if (pio == 255) {
		amd_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
		return;
	}

	amd_set_drive(drive, XFER_PIO_0 + MIN(pio, 5));
}

#ifdef CONFIG_BLK_DEV_IDEDMA

/*
 * amd7409_dmaproc() is a callback from upper layers that can do
 * a lot, but we use it for DMA/PIO tuning only, delegating everything
 * else to the default ide_dmaproc().
 */

int amd7409_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
{

	if (func == ide_dma_check) {

		short w80 = eighty_ninty_three(drive);

		short speed = ide_find_best_mode(drive,
			XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA |
			((amd_config->flags & AMD_NO_SWDMA) ? 0 : XFER_SWDMA) |
			(w80 && (amd_config->flags & AMD_UDMA) == AMD_UDMA_66 ? XFER_UDMA_66 : 0) |
			(w80 && (amd_config->flags & AMD_UDMA) == AMD_UDMA_100 ? XFER_UDMA_100 : 0));

		func = ((speed & XFER_MODE) != XFER_PIO) ? ide_dma_on : ide_dma_off_quietly;

		if (amd_set_drive(drive, speed))
			func = ide_dma_off;
	}

	return ide_dmaproc(func, drive);
}

#endif /* CONFIG_BLK_DEV_IDEDMA */

/*
 * The initialization callback. Here we determine the IDE chip type
 * and initialize its drive independent registers.
 */

unsigned int __init pci_init_amd7409(struct pci_dev *dev, const char *name)
{
	unsigned char t;
	unsigned int u;
	int i;

/*
 * Find out what AMD IDE this is.
 */

	for (amd_config = amd_ide_chips; amd_config->id; amd_config++) {
			pci_read_config_byte(dev, PCI_REVISION_ID, &t);
			if (dev->device == amd_config->id && t >= amd_config->rev)
				break;
		}

	if (!amd_config->id) {
		printk(KERN_WARNING "AMD7409: Unknown AMD IDE Chip, contact Vojtech Pavlik <vojtech@suse.cz>\n");
		return -ENODEV;
	}

/*
 * Check UDMA66 mode or cable info set by BIOS.
 */

	if ((amd_config->flags & AMD_UDMA) > AMD_UDMA_33) {

		if (amd_config->flags & AMD_CABLE) {
			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
			amd_80w = ((u & 0x3) ? 1 : 0) | ((u & 0xc) ? 2 : 0);
		} else {
			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
			for (i = 24; i >= 0; i -= 8)
				if ((u >> i) & 4)
					amd_80w |= (1 << (1 - (i >> 4)));
		}
	}

	pci_read_config_dword(dev, AMD_IDE_ENABLE, &u);
	amd_enabled = ((u & 1) ? 2 : 0) | ((u & 2) ? 1 : 0);

/*
 * Set up prefetch & postwrite.
 */

	pci_read_config_byte(dev, AMD_IDE_CONFIG, &t);
	pci_write_config_byte(dev, AMD_IDE_CONFIG, t | 0xf0);

/*
 * Print the boot message.
 */

	printk(KERN_INFO "AMD7409: AMD-%s IDE %s controller on pci%d:%d.%d\n",
			amd_config->name,
			(amd_config->flags & AMD_UDMA) == AMD_UDMA_100 ? "UDMA100" :
			(amd_config->flags & AMD_UDMA) == AMD_UDMA_66 ? "UDMA66" : "UDMA33",
			dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));

/*
 * Register /proc/ide/via entry
 */

#ifdef CONFIG_PROC_FS
	if (!amd7409_proc) {
		for (i = 0; i < 6; i++)
                	if (pci_resource_flags(dev, i) & IORESOURCE_IO)
                        	break;

		amd_base = pci_resource_start(dev, i);
		bmide_dev = dev;
		amd7409_display_info = &amd_get_info;
		amd7409_proc = 1;

	}
#endif

	return 0;
}

unsigned int __init ata66_amd7409(ide_hwif_t *hwif)
{
	return ((amd_enabled & amd_80w) >> hwif->channel) & 1;
}

void __init ide_init_amd7409(ide_hwif_t *hwif)
{
	int i;

	hwif->tuneproc = &amd7409_tune_drive;
	hwif->speedproc = &amd_set_drive;
	hwif->autodma = 0;

	for (i = 0; i < 2; i++) {
		hwif->drives[i].io_32bit = 1;
		hwif->drives[i].unmask = 1;
		hwif->drives[i].autotune = 1;
		hwif->drives[i].dn = hwif->channel * 2 + i;
	}

#ifdef CONFIG_BLK_DEV_IDEDMA
	if (hwif->dma_base) {
		hwif->dmaproc = &amd7409_dmaproc;
		hwif->autodma = 1;
	}
#endif /* CONFIG_BLK_DEV_IDEDMA */
}

/*
 * We allow the BM-DMA driver only work on enabled interfaces.
 */

void __init ide_dmacapable_amd7409(ide_hwif_t *hwif, unsigned long dmabase)
{
	if ((amd_enabled >> hwif->channel) & 1)
		ide_setup_dma(hwif, dmabase, 8);
}

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ide-timing.h"

#ifndef _IDE_TIMING_H
#define _IDE_TIMING_H

/*
 * $Id: ide-timing.h,v 1.4 2000/10/02 20:48:56 vojtech Exp $
 *
 *  Copyright (c) 1999-2000 Vojtech Pavlik
 *
 *  Sponsored by SuSE
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
 * e-mail - mail your message to <vojtech@suse.cz>, or by paper mail:
 * Vojtech Pavlik, Ucitelska 1576, Prague 8, 182 00 Czech Republic
 */

#include <linux/hdreg.h>

#ifndef XFER_PIO_5
#define XFER_PIO_5		0x0d
#endif

struct ide_timing {
	short mode;
	short setup;	/* t1 */
	short act8b;	/* t2 for 8-bit io */
	short rec8b;	/* t2i for 8-bit io */
	short cyc8b;	/* t0 for 8-bit io */
	short active;	/* t2 or tD */
	short recover;	/* t2i or tK */
	short cycle;	/* t0 */
	short udma;	/* t2CYCTYP/2 */
};

/*
 * PIO 0-5, MWDMA 0-2 and UDMA 0-5 timings (in nanoseconds).
 * These were taken from ATA/ATAPI-6 standard, rev 0a, except
 * for PIO 5, which is a nonstandard extension.
 */

static struct ide_timing ide_timing[] = {

	{ XFER_UDMA_5,     0,   0,   0,   0,   0,   0,   0,  20 },
	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },

	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
                                          
	{ XFER_MW_DMA_2,  25,   0,   0,   0,  70,  25, 120,   0 },
	{ XFER_MW_DMA_1,  45,   0,   0,   0,  80,  50, 150,   0 },
	{ XFER_MW_DMA_0,  60,   0,   0,   0, 215, 215, 480,   0 },
                                          
	{ XFER_SW_DMA_2,  60,   0,   0,   0, 120, 120, 240,   0 },
	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },

	{ XFER_PIO_5,     20,  50,  30, 100,  50,  30, 100,   0 },
	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },

	{ XFER_PIO_2,     30, 290,  40, 330, 100,  90, 240,   0 },
	{ XFER_PIO_1,     50, 290,  93, 383, 125, 100, 383,   0 },
	{ XFER_PIO_0,     70, 290, 240, 600, 165, 150, 600,   0 },

	{ XFER_PIO_SLOW, 120, 290, 240, 960, 290, 240, 960,   0 },

	{ -1 }
};

#define IDE_TIMING_SETUP	0x01
#define IDE_TIMING_ACT8B	0x02
#define IDE_TIMING_REC8B	0x04
#define IDE_TIMING_CYC8B	0x08
#define IDE_TIMING_8BIT		0x0e
#define IDE_TIMING_ACTIVE	0x10
#define IDE_TIMING_RECOVER	0x20
#define IDE_TIMING_CYCLE	0x40
#define IDE_TIMING_UDMA		0x80
#define IDE_TIMING_ALL		0xff

#define MIN(a,b)	((a)<(b)?(a):(b))
#define MAX(a,b)	((a)>(b)?(a):(b))
#define FIT(v,min,max)	MAX(MIN(v,max),min)
#define ENOUGH(v,unit)	(((v)-1)/(unit)+1)
#define EZ(v,unit)	((v)?ENOUGH(v,unit):0)

#define XFER_MODE	0xf0
#define XFER_UDMA_100	0x44
#define XFER_UDMA_66	0x42
#define XFER_UDMA	0x40
#define XFER_MWDMA	0x20
#define XFER_SWDMA	0x10
#define XFER_EPIO	0x01
#define XFER_PIO	0x00

static short ide_find_best_mode(ide_drive_t *drive, int map)
{
	struct hd_driveid *id = drive->id;
	short best = 0;

	if (!id)
		return XFER_PIO_SLOW;

	if ((map & XFER_UDMA) && (id->field_valid & 4)) {	/* Want UDMA and UDMA bitmap valid */

		if ((map & XFER_UDMA_100) == XFER_UDMA_100)
			if ((best = (id->dma_ultra & 0x0020) ? XFER_UDMA_5 : 0)) return best;

		if ((map & XFER_UDMA_66) == XFER_UDMA_66)
			if ((best = (id->dma_ultra & 0x0010) ? XFER_UDMA_4 :
                	    	    (id->dma_ultra & 0x0008) ? XFER_UDMA_3 : 0)) return best;

                if ((best = (id->dma_ultra & 0x0004) ? XFER_UDMA_2 :
                	    (id->dma_ultra & 0x0002) ? XFER_UDMA_1 :
                	    (id->dma_ultra & 0x0001) ? XFER_UDMA_0 : 0)) return best;
	}

	if ((map & XFER_MWDMA) && (id->field_valid & 2)) {	/* Want MWDMA and drive has EIDE fields */

		if ((best = (id->dma_mword & 0x0004) ? XFER_MW_DMA_2 :
                	    (id->dma_mword & 0x0002) ? XFER_MW_DMA_1 :
                	    (id->dma_mword & 0x0001) ? XFER_MW_DMA_0 : 0)) return best;
	}

	if (map & XFER_SWDMA) {					/* Want SWDMA */

 		if (id->field_valid & 2) {			/* EIDE SWDMA */

			if ((best = (id->dma_1word & 0x0004) ? XFER_SW_DMA_2 :
      				    (id->dma_1word & 0x0002) ? XFER_SW_DMA_1 :
				    (id->dma_1word & 0x0001) ? XFER_SW_DMA_0 : 0)) return best;
		}

		if (id->capability & 1) {			/* Pre-EIDE style SWDMA */

			if ((best = (id->tDMA == 2) ? XFER_SW_DMA_2 :
				    (id->tDMA == 1) ? XFER_SW_DMA_1 :
				    (id->tDMA == 0) ? XFER_SW_DMA_0 : 0)) return best;
		}
	}


	if ((map & XFER_EPIO) && (id->field_valid & 2)) {	/* EIDE PIO modes */

		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
	}
	
	return  (drive->id->tPIO == 2) ? XFER_PIO_2 :
		(drive->id->tPIO == 1) ? XFER_PIO_1 :
		(drive->id->tPIO == 0) ? XFER_PIO_0 : XFER_PIO_SLOW;
}

static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
{
	q->setup   = EZ(t->setup,   T);
	q->act8b   = EZ(t->act8b,   T);
	q->rec8b   = EZ(t->rec8b,   T);
	q->cyc8b   = EZ(t->cyc8b,   T);
	q->active  = EZ(t->active,  T);
	q->recover = EZ(t->recover, T);
	q->cycle   = EZ(t->cycle,   T);
	q->udma    = EZ(t->udma,   UT);
}

static void ide_timing_merge(struct ide_timing *a, struct ide_timing *b, struct ide_timing *m, unsigned int what)
{
	if (what & IDE_TIMING_SETUP  ) m->setup   = MAX(a->setup,   b->setup);
	if (what & IDE_TIMING_ACT8B  ) m->act8b   = MAX(a->act8b,   b->act8b);
	if (what & IDE_TIMING_REC8B  ) m->rec8b   = MAX(a->rec8b,   b->rec8b);
	if (what & IDE_TIMING_CYC8B  ) m->cyc8b   = MAX(a->cyc8b,   b->cyc8b);
	if (what & IDE_TIMING_ACTIVE ) m->active  = MAX(a->active,  b->active);
	if (what & IDE_TIMING_RECOVER) m->recover = MAX(a->recover, b->recover);
	if (what & IDE_TIMING_CYCLE  ) m->cycle   = MAX(a->cycle,   b->cycle);
	if (what & IDE_TIMING_UDMA   ) m->udma    = MAX(a->udma,    b->udma);
}

static struct ide_timing* ide_timing_find_mode(short speed)
{
	struct ide_timing *t;

	for (t = ide_timing; t->mode != speed; t++)
		if (t->mode < 0)
			return NULL;
	return t; 
}

static int ide_timing_compute(ide_drive_t *drive, short speed, struct ide_timing *t, int T, int UT)
{
	struct hd_driveid *id = drive->id;
	struct ide_timing *s, p;

/*
 * Find the mode.
 */

	if (!(s = ide_timing_find_mode(speed)))
		return -EINVAL;

/*
 * If the drive is an EIDE drive, it can tell us it needs extended
 * PIO/MWDMA cycle timing.
 */

	if (id && id->field_valid & 2) {	/* EIDE drive */

		memset(&p, 0, sizeof(p));

		switch (speed & XFER_MODE) {

			case XFER_PIO:
				if (speed <= XFER_PIO_2) p.cycle = p.cyc8b = id->eide_pio;
						    else p.cycle = p.cyc8b = id->eide_pio_iordy;
				break;

			case XFER_MWDMA:
				p.cycle = id->eide_dma_min;
				break;
		}

		ide_timing_merge(&p, t, t, IDE_TIMING_CYCLE | IDE_TIMING_CYC8B);
	}

/*
 * Convert the timing to bus clock counts.
 */

	ide_timing_quantize(s, t, T, UT);

/*
 * Even in DMA/UDMA modes we still use PIO access for IDENTIFY, S.M.A.R.T
 * and some other commands. We have to ensure that the DMA cycle timing is
 * slower/equal than the fastest PIO timing.
 */

	if ((speed & XFER_MODE) != XFER_PIO) {
		ide_timing_compute(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO), &p, T, UT);
		ide_timing_merge(&p, t, t, IDE_TIMING_ALL);
	}

/*
 * Lenghten active & recovery time so that cycle time is correct.
 */

	if (t->act8b + t->rec8b < t->cyc8b) {
		t->act8b += (t->cyc8b - (t->act8b + t->rec8b)) / 2;
		t->rec8b = t->cyc8b - t->act8b;
	}

	if (t->active + t->recover < t->cycle) {
		t->active += (t->cycle - (t->active + t->recover)) / 2;
		t->recover = t->cycle - t->active;
	}

	return 0;
}

#endif

--XsQoSWH+UP9D9v3l--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
