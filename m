Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318283AbSHUN06>; Wed, 21 Aug 2002 09:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318284AbSHUN06>; Wed, 21 Aug 2002 09:26:58 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:24765 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S318283AbSHUN03>;
	Wed, 21 Aug 2002 09:26:29 -0400
Date: Wed, 21 Aug 2002 15:27:25 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Linus Torvalds <torvalds@transmeta.com>,
       Anton Altaparmakov <aia21@cantab.net>,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
Subject: Re: IDE?
Message-ID: <20020821152725.A4351@ucw.cz>
References: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk> <Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com> <20020818131515.A15547@ucw.cz> <1029672964.15858.17.camel@irongate.swansea.linux.org.uk> <20020821121747.A3801@ucw.cz> <1029936007.26411.3.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1029936007.26411.3.camel@irongate.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Aug 21, 2002 at 02:20:07PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 21, 2002 at 02:20:07PM +0100, Alan Cox wrote:
>  
> On Wed, 2002-08-21 at 11:17, Vojtech Pavlik wrote:
> > I have completely rewritten (and very well tested) versions of the amd
> > and piix pci ide drivers.
> 
> I have completely non-rewritten piix drivers that work extremely well
> are now easy to read, commented and have done for a very long time. Why
> do I want rewritten ones ?

Even nicer? Easier to add new devices? Not having switch(deviceid)
everywhere? Don't know. I believe they're better. In any case it's a lot
of good work thrown away, yours or mine. :(

The two drivers in question attached in their form suitable for
2.4-non-ac, you can take a look. If there is a chance to get them into
2.4-ac/2.5, I can change them to fit the kernels as needed.

> > I'm now looking through 2.4.20-pre2-ac5 and your version of via82cxxx.c,
> > and all looks quite good to me, except for some of the indentation
> > changes which seem to make the code fit into 78 columns at the loss of
> > readability. Was the file run through indent?
> 
> Andre may have indented it a bit. I've probably caused a bit of noise in
> checking all the static's etc

It's awful in my opinion, others may differ. Would you mind if I sent
you patch that'd put the indentation back, while keeping all the code as
you have it now? 

-- 
Vojtech Pavlik
SuSE Labs

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="piix.c"

/*
 * Version 1.4
 *
 * Intel PIIX/ICH and Efar Victory66 IDE driver for Linux.
 *
 * Copyright (c) 2000-2002 Vojtech Pavlik
 * Copyright (c) 1998-2000 Andre Hedrick
 * Copyright (c) 1998-1999 Andrzej Krzysztofowicz
 *
 *  Thanks to Daniela Egbert for advice on PIIX bugs.
 */

/*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation; either version 2 of the License.
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

#define PIIX_IDETIM0		0x40
#define PIIX_IDETIM1		0x42
#define PIIX_SIDETIM		0x44
#define PIIX_IDESTAT		0x47
#define PIIX_UDMACTL		0x48
#define PIIX_UDMATIM		0x4a
#define PIIX_IDECFG		0x54

#define PIIX_UDMA		0x07
#define PIIX_UDMA_NONE		0x00
#define PIIX_UDMA_33		0x01
#define PIIX_UDMA_66		0x02
#define PIIX_UDMA_100		0x03
#define PIIX_UDMA_133		0x04
#define PIIX_NO_SITRE		0x08	/* Chip doesn't have separate slave timing */
#define PIIX_PINGPONG		0x10	/* Enable ping-pong buffers */
#define PIIX_VICTORY		0x20	/* Efar Victory66 has a different UDMA setup */
#define PIIX_CHECK_REV		0x40	/* May be a buggy revision of PIIX */
#define PIIX_NODMA		0x80	/* Don't do DMA with this chip */

/*
 * Intel IDE chips
 */

static struct piix_ide_chip {
	unsigned short id;
	unsigned char flags;
} piix_ide_chips[] = {
	{ PCI_DEVICE_ID_INTEL_82801DB_9,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801DB ICH4 */
	{ PCI_DEVICE_ID_INTEL_82801CA_11,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CA ICH3/ICH3-S */
	{ PCI_DEVICE_ID_INTEL_82801CA_10,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801CAM ICH3-M */
	{ PCI_DEVICE_ID_INTEL_82801E_9,		PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801E C-ICH */
	{ PCI_DEVICE_ID_INTEL_82801BA_9,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BA ICH2 */
	{ PCI_DEVICE_ID_INTEL_82801BA_8,	PIIX_UDMA_100 | PIIX_PINGPONG },                    /* Intel 82801BAM ICH2-M */
	{ PCI_DEVICE_ID_INTEL_82801AB_1,	PIIX_UDMA_33  | PIIX_PINGPONG },                    /* Intel 82801AB ICH0 */
	{ PCI_DEVICE_ID_INTEL_82801AA_1,	PIIX_UDMA_66  | PIIX_PINGPONG },                    /* Intel 82801AA ICH */
	{ PCI_DEVICE_ID_INTEL_82372FB_1,	PIIX_UDMA_66 },	                                    /* Intel 82372FB PIIX5 */
	{ PCI_DEVICE_ID_INTEL_82443MX_1,	PIIX_UDMA_33 },                                     /* Intel 82443MX MPIIX4 */
	{ PCI_DEVICE_ID_INTEL_82371AB,		PIIX_UDMA_33 },                                     /* Intel 82371AB/EB PIIX4/PIIX4E */
	{ PCI_DEVICE_ID_INTEL_82371SB_1,	PIIX_UDMA_NONE },                                   /* Intel 82371SB PIIX3 */
	{ PCI_DEVICE_ID_INTEL_82371FB_1,	PIIX_UDMA_NONE | PIIX_NO_SITRE | PIIX_CHECK_REV },  /* Intel 82371FB PIIX */
	{ PCI_DEVICE_ID_EFAR_SLC90E66_1,	PIIX_UDMA_66 | PIIX_VICTORY },                      /* Efar Victory66 */
	{ 0 }
};

static struct piix_ide_chip *piix_config;
static unsigned char piix_enabled;
static unsigned int piix_80w;
static unsigned int piix_clock;

static char *piix_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };

/*
 * PIIX/ICH /proc entry.
 */

#ifdef CONFIG_PROC_FS

#include <linux/stat.h>
#include <linux/proc_fs.h>

byte piix_proc;
int piix_base;
static struct pci_dev *bmide_dev;
extern int (*piix_display_info)(char *, char **, off_t, int); /* ide-proc.c */

#define piix_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
#define piix_print_drive(name, format, arg...)\
	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");

static int piix_get_info(char *buffer, char **addr, off_t offset, int count)
{
	int speed[4], cycle[4], active[4], recover[4], dmaen[4], uen[4], udma[4], umul;
	struct pci_dev *dev = bmide_dev;
	unsigned int i, u;
	unsigned short c, d, e;
	unsigned char t;
	char *p = buffer;

	piix_print("----------PIIX BusMastering IDE Configuration---------------");

	piix_print("Driver Version:                     1.4");
	piix_print("South Bridge:                       %s", bmide_dev->name);

	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
	piix_print("Revision:                           IDE %#x", t);
	piix_print("Highest DMA rate:                   %s", piix_config->flags & PIIX_NODMA ? "No DMA"
								: piix_dma[piix_config->flags & PIIX_UDMA]);

	piix_print("BM-DMA base:                        %#x", piix_base);
	piix_print("PCI clock:                          %d.%dMHz", piix_clock / 1000, piix_clock / 100 % 10);

	piix_print("-----------------------Primary IDE-------Secondary IDE------");

	pci_read_config_word(dev, PIIX_IDETIM0, &d);
	pci_read_config_word(dev, PIIX_IDETIM1, &e);
	piix_print("Enabled:               %10s%20s", (d & 0x8000) ? "yes" : "no", (e & 0x8000) ? "yes" : "no");

	c = inb(piix_base + 0x02) | (inb(piix_base + 0x0a) << 8);
	piix_print("Simplex only:          %10s%20s", (c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");

	piix_print("Cable Type:            %10s%20s", (piix_80w & 1) ? "80w" : "40w", (piix_80w & 2) ? "80w" : "40w");

	if (!piix_clock)
                return p - buffer;

	piix_print("-------------------drive0----drive1----drive2----drive3-----");

	piix_print_drive("Prefetch+Post: ", "%10s", (((i & 2) ? d : e) & (1 << (2 + ((i & 1) << 2)))) ? "yes" : "no");

	for (i = 0; i < 4; i++) {

		pci_read_config_word(dev, PIIX_IDETIM0 + (i & 2), &d);
		if (~piix_config->flags & PIIX_NO_SITRE)
			pci_read_config_byte(dev, PIIX_SIDETIM, &t);

		umul = 4;
		udma[i] = uen[i] = 0;
		active[i] = 12;
		recover[i] = 18;

		switch (i & 1) {
			case 1: if (~d & 0x10) break;
				if ((~piix_config->flags & PIIX_NO_SITRE) && (d & 0x4000)) {
					active[i]  = 5 - ((t >> (((i & 2) << 1) + 2)) & 3); 
					recover[i] = 4 - ((t >> (((i & 2) << 1) + 0)) & 3); 
					break;
				}

			case 0: if (~d & 0x01) break;
				active[i] =  5 - ((d >> 12) & 3);
				recover[i] = 4 - ((d >> 8) & 3);
		}

		dmaen[i] = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
		cycle[i] = 1000000 / piix_clock * (active[i] + recover[i]);
		speed[i] = 2 * piix_clock / (active[i] + recover[i]);

		if (!(piix_config->flags & PIIX_UDMA))
			continue;

		pci_read_config_byte(dev, PIIX_UDMACTL, &t);
		uen[i]  = (t & (1 << i)) ? dmaen[i] : 0;

		if (!uen[i])
			continue;

		pci_read_config_word(dev, PIIX_UDMATIM, &e);
		pci_read_config_dword(dev, PIIX_IDECFG, &u);

		if (~piix_config->flags & PIIX_VICTORY) {
			if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 && (u & (1 << i))) umul = 2;
			if ((piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 && (u & (1 << (i + 12)))) umul = 1;
			udma[i] = (4 - ((e >> (i << 2)) & 3)) * umul;
		} else  udma[i] = (8 - ((e >> (i << 2)) & 7)) * 2;

		speed[i] = 8 * piix_clock / udma[i];
		cycle[i] = 250000 * udma[i] / piix_clock;
	}

	piix_print_drive("Transfer Mode: ", "%10s", dmaen[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");

	piix_print_drive("Address Setup: ", "%8dns", (1000000 / piix_clock) * 3);
	piix_print_drive("Cmd Active:    ", "%8dns", (1000000 / piix_clock) * 12);
	piix_print_drive("Cmd Recovery:  ", "%8dns", (1000000 / piix_clock) * 18);
	piix_print_drive("Data Active:   ", "%8dns", (1000000 / piix_clock) * active[i]);
	piix_print_drive("Data Recovery: ", "%8dns", (1000000 / piix_clock) * recover[i]);
	piix_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
	piix_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);

	return p - buffer;	/* hoping it is less than 4K... */
}

#endif

/*
 * piix_set_speed() writes timing values to the chipset registers
 */

static void piix_set_speed(struct pci_dev *dev, unsigned char dn, struct ide_timing *timing, int umul)
{
	unsigned short t;
	unsigned char u;
	unsigned int c;

	pci_read_config_word(dev, PIIX_IDETIM0 + (dn & 2), &t);

	switch (dn & 1) {

		case 1: 
			if (timing->cycle > 9) {
				t &= ~0x30;
				break;
			}

			if (~piix_config->flags & PIIX_NO_SITRE) {
				pci_read_config_byte(dev, PIIX_SIDETIM, &u);
				u &= ~(0xf << ((dn & 2) << 1));
				t |= 0x30;
				u |= (4 - FIT(timing->recover, 1, 4)) << ((dn & 2) << 1);
				u |= (5 - FIT(timing->active, 2, 5)) << (((dn & 2) << 1) + 2);
				pci_write_config_byte(dev, PIIX_SIDETIM, u);
				break;
			}

		case 0:
			if ((~dn & 1) && timing->cycle > 9) {
				t &= ~0x03;
				break;
			}

			t &= 0xccff;
			t |= 0x03 << ((dn & 1) << 2);
			t |= (4 - FIT(timing->recover, 1, 4)) << 8;
			t |= (5 - FIT(timing->active, 2, 5)) << 12;
	}

	pci_write_config_word(dev, PIIX_IDETIM0 + (dn & 2), t);

	if (!(piix_config->flags & PIIX_UDMA)) return;

	pci_read_config_byte(dev, PIIX_UDMACTL, &u);
	u &= ~(1 << dn);

	if (timing->udma) {

		u |= 1 << dn;

		pci_read_config_word(dev, PIIX_UDMATIM, &t);

		if (piix_config->flags & PIIX_VICTORY) {
			t &= ~(0x07 << (dn << 2));
			t |= (8 - FIT(timing->udma, 2, 8)) << (dn << 2);
		} else {
			t &= ~(0x03 << (dn << 2));
			t |= (4 - FIT(timing->udma, 2, 4)) << (dn << 2);
		}

		pci_write_config_word(dev, PIIX_UDMATIM, t);

		if ((piix_config->flags & PIIX_UDMA) > PIIX_UDMA_33
			&& ~piix_config->flags & PIIX_VICTORY) {

			pci_read_config_dword(dev, PIIX_IDECFG, &c);
			
			if ((piix_config->flags & PIIX_UDMA) > PIIX_UDMA_66)
				c &= ~(1 << (dn + 12));
			c &= ~(1 << dn);

			switch (umul) {
				case 2: c |= 1 << dn;		break;
				case 4: c |= 1 << (dn + 12);	break;
			}

			pci_write_config_dword(dev, PIIX_IDECFG, c);
		}
	}

	pci_write_config_byte(dev, PIIX_UDMACTL, u);
}

/*
 * piix_set_drive() computes timing values configures the drive and
 * the chipset to a desired transfer mode. It also can be called
 * by upper layers.
 */

static int piix_set_drive(ide_drive_t *drive, unsigned char speed)
{
	ide_drive_t *peer = drive->channel->drives + (~drive->dn & 1);
	struct ide_timing t, p;
	int err, T, UT, umul = 1;

	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
		if ((err = ide_config_drive_speed(drive, speed)))
			return err;

	if (speed > XFER_UDMA_2 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66)
		umul = 2;
	if (speed > XFER_UDMA_4 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100)
		umul = 4;
	
	T = 1000000000 / piix_clock;
	UT = T / umul;

	ide_timing_compute(drive, speed, &t, T, UT);

	if ((piix_config->flags & PIIX_NO_SITRE) && peer->present) {
			ide_timing_compute(peer, peer->current_speed, &p, T, UT);
			if (t.cycle <= 9 && p.cycle <= 9)
				ide_timing_merge(&p, &t, &t, IDE_TIMING_ALL);
	}

	piix_set_speed(drive->channel->pci_dev, drive->dn, &t, umul);

	if (!drive->init_speed)	
		drive->init_speed = speed;
	drive->current_speed = speed;

	return 0;
}

/*
 * piix_tune_drive() is a callback from upper layers for
 * PIO-only tuning.
 */

static void piix_tune_drive(ide_drive_t *drive, unsigned char pio)
{
	if (!((piix_enabled >> drive->channel->unit) & 1))
		return;

	if (pio == 255) {
		piix_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
		return;
	}

	piix_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
}

#ifdef CONFIG_BLK_DEV_IDEDMA

/*
 * piix_dmaproc() is a callback from upper layers that can do
 * a lot, but we use it for DMA/PIO tuning only, delegating everything
 * else to the default ide_dmaproc().
 */

int piix_dmaproc(ide_dma_action_t func, struct ide_device *drive, struct request *rq)
{

	if (func == ide_dma_check) {

		short w80 = drive->channel->udma_four;

		short speed = ide_find_best_mode(drive,
			XFER_PIO | XFER_EPIO | 
			(piix_config->flags & PIIX_NODMA ? 0 : (XFER_SWDMA | XFER_MWDMA |
			(piix_config->flags & PIIX_UDMA ? XFER_UDMA : 0) |
			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_66 ? XFER_UDMA_66 : 0) |
			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_100 ? XFER_UDMA_100 : 0) |
			(w80 && (piix_config->flags & PIIX_UDMA) >= PIIX_UDMA_133 ? XFER_UDMA_133 : 0))));

		piix_set_drive(drive, speed);

		func = (drive->channel->autodma && (speed & XFER_MODE) != XFER_PIO)
			? ide_dma_on : ide_dma_off_quietly;

	}

	return ide_dmaproc(func, drive, rq);
}

#endif /* CONFIG_BLK_DEV_IDEDMA */

/*
 * The initialization callback. Here we determine the IDE chip type
 * and initialize its drive independent registers.
 */

unsigned int __init pci_init_piix(struct pci_dev *dev, const char *name)
{
	unsigned int u;
	unsigned short w;
	unsigned char t;
	int i;

/*
 * Find out which Intel IDE this is.
 */

	for (piix_config = piix_ide_chips; piix_config->id != 0; ++piix_config)
		if (dev->device == piix_config->id)
			break;

	if (!piix_config->id) {
		printk(KERN_WARNING "PIIX: Unknown PIIX/ICH chip %#x, disabling DMA.\n", dev->device);
		return -ENODEV;
	}

/*
 * Check for possibly broken DMA configs.
 */

	{
		struct pci_dev *orion = NULL;

		if (piix_config->flags & PIIX_CHECK_REV) {
			pci_read_config_byte(dev, PCI_REVISION_ID, &t);
			if (t < 2) {
				printk(KERN_INFO "PIIX: Found buggy old PIIX rev %#x, disabling DMA\n", t);
				piix_config->flags |= PIIX_NODMA;
			}
		}

		if ((orion = pci_find_device(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82454GX, NULL))) {
			pci_read_config_byte(orion, PCI_REVISION_ID, &t);
			if (t < 4) {
				printk(KERN_INFO "PIIX: Found buggy 82454GX Orion bridge rev %#x, disabling DMA\n", t);
				piix_config->flags |= PIIX_NODMA;
			}
		}
	}

/*
 * Check 80-wire cable presence.
 */

	switch (piix_config->flags & PIIX_UDMA) {

		case PIIX_UDMA_66:
			if (piix_config->flags && PIIX_VICTORY) {
				pci_read_config_byte(dev, PIIX_IDESTAT, &t);
				piix_80w = ((t & 2) ? 1 : 0) | ((t & 1) ? 2 : 0);
				break;
			}

		case PIIX_UDMA_100:
		case PIIX_UDMA_133:
			pci_read_config_dword(dev, PIIX_IDECFG, &u);
			piix_80w = ((u & 0x30) ? 1 : 0) | ((u & 0xc0) ? 2 : 0);
			break;
	}

/*
 * Enable ping-pong buffers where applicable.
 */

	if (piix_config->flags & PIIX_PINGPONG) {
		pci_read_config_dword(dev, PIIX_IDECFG, &u);
		u |= 0x400; 
		pci_write_config_dword(dev, PIIX_IDECFG, u);
	}

/*
 * Detect enabled interfaces, enable slave separate timing if possible.
 */

	for (i = 0; i < 2; i++) {
		pci_read_config_word(dev, PIIX_IDETIM0 + (i << 1), &w);
		piix_enabled |= (w & 0x8000) ? (1 << i) : 0;
		w &= 0x8c00;
		if (~piix_config->flags & PIIX_NO_SITRE) w |= 0x4000;
		w |= 0x44;
		pci_write_config_word(dev, PIIX_IDETIM0 + (i << 1), w);
	}

/*
 * Determine the system bus clock.
 */

	piix_clock = system_bus_speed * 1000;

	switch (piix_clock) {
		case 33000: piix_clock = 33333; break;
		case 37000: piix_clock = 37500; break;
		case 41000: piix_clock = 41666; break;
	}

	if (piix_clock < 20000 || piix_clock > 50000) {
		printk(KERN_WARNING "PIIX: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", piix_clock);
		printk(KERN_WARNING "PIIX: Use ide0=ata66 if you want to assume 80-wire cable\n");
		piix_clock = 33333;
	}

/*
 * Print the boot message.
 */

	printk(KERN_INFO "PIIX: %s %s controller on pci%s\n",
		dev->name, piix_dma[piix_config->flags & PIIX_UDMA], dev->slot_name);

/*
 * Register /proc/ide/piix entry
 */

#ifdef CONFIG_PROC_FS
	if (!piix_proc) {
		piix_base = pci_resource_start(dev, 4);
		bmide_dev = dev;
		piix_display_info = &piix_get_info;
		piix_proc = 1;
	}
#endif

	return 0;
}

unsigned int __init ata66_piix(ide_hwif_t *hwif)
{
	return ((piix_enabled & piix_80w) >> hwif->unit) & 1;
}

void __init ide_init_piix(ide_hwif_t *hwif)
{
	int i;

	hwif->tuneproc = &piix_tune_drive;
	hwif->speedproc = &piix_set_drive;
	hwif->autodma = 0;
	hwif->io_32bit = 1;
	hwif->unmask = 1;
	for (i = 0; i < 2; i++) {
		hwif->drives[i].autotune = 1;
		hwif->drives[i].dn = hwif->unit * 2 + i;
	}

#ifdef CONFIG_BLK_DEV_IDEDMA
	if (hwif->dma_base) {
		hwif->highmem = 1;
		hwif->udma = piix_dmaproc;
#ifdef CONFIG_IDEDMA_AUTO
		if (!noautodma)
			hwif->autodma = 1;
#endif
	}
#endif /* CONFIG_BLK_DEV_IDEDMA */
}

/*
 * We allow the BM-DMA driver only work on enabled interfaces,
 * and only if DMA is safe with the chip and bridge.
 */

void __init ide_dmacapable_piix(ide_hwif_t *hwif, unsigned long dmabase)
{
	if (((piix_enabled >> hwif->unit) & 1)
		&& !(piix_config->flags & PIIX_NODMA))
			ide_setup_dma(hwif, dmabase, 8);
}

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="amd74xx.c"

/*
 * Version 2.9
 *
 * AMD 755/756/766/8111 and nVidia nForce IDE driver for Linux.
 * 
 * Copyright (c) 2000-2002 Vojtech Pavlik
 * Copyright (c) 1999-2000 Andre Hedrick
 *
 */

/*
 * This program is free software; you can redistribute it and/or modify it
 * under the terms of the GNU General Public License version 2 as published by
 * the Free Software Foundation.
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

#define AMD_IDE_ENABLE		(0x00 + amd_config->base)
#define AMD_IDE_CONFIG		(0x01 + amd_config->base)
#define AMD_CABLE_DETECT	(0x02 + amd_config->base)
#define AMD_DRIVE_TIMING	(0x08 + amd_config->base)
#define AMD_8BIT_TIMING		(0x0e + amd_config->base)
#define AMD_ADDRESS_SETUP	(0x0c + amd_config->base)
#define AMD_UDMA_TIMING		(0x10 + amd_config->base)

#define AMD_UDMA		0x07
#define AMD_UDMA_33		0x01
#define AMD_UDMA_66		0x02
#define AMD_UDMA_100		0x03
#define AMD_BAD_SWDMA		0x08
#define AMD_BAD_FIFO		0x10

/*
 * AMD SouthBridge chips.
 */

static struct amd_ide_chip {
	unsigned short id;
	unsigned char rev;
	unsigned int base;
	unsigned char flags;
} amd_ide_chips[] = {
	{ PCI_DEVICE_ID_AMD_8111_IDE,  0x00, 0x40, AMD_UDMA_100 },			/* AMD-8111 */
	{ PCI_DEVICE_ID_AMD_OPUS_7441, 0x00, 0x40, AMD_UDMA_100 },			/* AMD-768 Opus */
	{ PCI_DEVICE_ID_AMD_VIPER_7411, 0x00, 0x40, AMD_UDMA_100 | AMD_BAD_FIFO },	/* AMD-766 Viper */
	{ PCI_DEVICE_ID_AMD_VIPER_7409, 0x07, 0x40, AMD_UDMA_66 },			/* AMD-756/c4+ Viper */
	{ PCI_DEVICE_ID_AMD_VIPER_7409, 0x00, 0x40, AMD_UDMA_66 | AMD_BAD_SWDMA },	/* AMD-756 Viper */
	{ PCI_DEVICE_ID_AMD_COBRA_7401, 0x00, 0x40, AMD_UDMA_33 | AMD_BAD_SWDMA },	/* AMD-755 Cobra */
	{ PCI_DEVICE_ID_NVIDIA_NFORCE_IDE, 0x00, 0x50, AMD_UDMA_100 },			/* nVidia nForce */
	{ 0 }
};

static struct amd_ide_chip *amd_config;
static unsigned char amd_enabled;
static unsigned int amd_80w;
static unsigned int amd_clock;

static unsigned char amd_cyc2udma[] = { 6, 6, 5, 4, 0, 1, 1, 2, 2, 3, 3 };
static unsigned char amd_udma2cyc[] = { 4, 6, 8, 10, 3, 2, 1, 1 };
static char *amd_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100" };

/*
 * AMD /proc entry.
 */

#ifdef CONFIG_PROC_FS

#include <linux/stat.h>
#include <linux/proc_fs.h>

byte amd74xx_proc;
int amd_base;
static struct pci_dev *bmide_dev;
extern int (*amd74xx_display_info)(char *, char **, off_t, int); /* ide-proc.c */

#define amd_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
#define amd_print_drive(name, format, arg...)\
	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");

static int amd_get_info(char *buffer, char **addr, off_t offset, int count)
{
	int speed[4], cycle[4], setup[4], active[4], recover[4], den[4],
		 uen[4], udma[4], active8b[4], recover8b[4];
	struct pci_dev *dev = bmide_dev;
	unsigned int v, u, i;
	unsigned short c, w;
	unsigned char t;
	char *p = buffer;

	amd_print("----------AMD BusMastering IDE Configuration----------------");

	amd_print("Driver Version:                     2.9");
	amd_print("South Bridge:                       %s", bmide_dev->name);

	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
	amd_print("Revision:                           IDE %#x", t);
	amd_print("Highest DMA rate:                   %s", amd_dma[amd_config->flags & AMD_UDMA]);

	amd_print("BM-DMA base:                        %#x", amd_base);
	amd_print("PCI clock:                          %d.%dMHz", amd_clock / 1000, amd_clock / 100 % 10);
	
	amd_print("-----------------------Primary IDE-------Secondary IDE------");

	pci_read_config_byte(dev, AMD_IDE_CONFIG, &t);
	amd_print("Prefetch Buffer:       %10s%20s", (t & 0x80) ? "yes" : "no", (t & 0x20) ? "yes" : "no");
	amd_print("Post Write Buffer:     %10s%20s", (t & 0x40) ? "yes" : "no", (t & 0x10) ? "yes" : "no");

	pci_read_config_byte(dev, AMD_IDE_ENABLE, &t);
	amd_print("Enabled:               %10s%20s", (t & 0x02) ? "yes" : "no", (t & 0x01) ? "yes" : "no");

	c = inb(amd_base + 0x02) | (inb(amd_base + 0x0a) << 8);
	amd_print("Simplex only:          %10s%20s", (c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");

	amd_print("Cable Type:            %10s%20s", (amd_80w & 1) ? "80w" : "40w", (amd_80w & 2) ? "80w" : "40w");

	if (!amd_clock)
                return p - buffer;

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
		den[i]  = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));

		if (den[i] && uen[i] && udma[i] == 1) {
			speed[i] = amd_clock * 3;
			cycle[i] = 666666 / amd_clock;
			continue;
		}

		speed[i] = 4 * amd_clock / ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2);
		cycle[i] = 1000000 * ((den[i] && uen[i]) ? udma[i] : (active[i] + recover[i]) * 2) / amd_clock / 2;
	}

	amd_print_drive("Transfer Mode: ", "%10s", den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");

	amd_print_drive("Address Setup: ", "%8dns", 1000000 * setup[i] / amd_clock);
	amd_print_drive("Cmd Active:    ", "%8dns", 1000000 * active8b[i] / amd_clock);
	amd_print_drive("Cmd Recovery:  ", "%8dns", 1000000 * recover8b[i] / amd_clock);
	amd_print_drive("Data Active:   ", "%8dns", 1000000 * active[i] / amd_clock);
	amd_print_drive("Data Recovery: ", "%8dns", 1000000 * recover[i] / amd_clock);
	amd_print_drive("Cycle Time:    ", "%8dns", cycle[i]);
	amd_print_drive("Transfer Rate: ", "%4d.%dMB/s", speed[i] / 1000, speed[i] / 100 % 10);

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

	switch (amd_config->flags & AMD_UDMA) {
		case AMD_UDMA_33:  t = timing->udma ? (0xc0 | (FIT(timing->udma, 2, 5) - 2)) : 0x03; break;
		case AMD_UDMA_66:  t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 2, 10)]) : 0x03; break;
		case AMD_UDMA_100: t = timing->udma ? (0xc0 | amd_cyc2udma[FIT(timing->udma, 1, 10)]) : 0x03; break;
		default: return;
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
	int T, UT;

	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
		if (ide_config_drive_speed(drive, speed))
			printk(KERN_WARNING "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
				drive->dn >> 1, drive->dn & 1);

	T = 1000000000 / amd_clock;
	UT = T / min_t(int, max_t(int, amd_config->flags & AMD_UDMA, 1), 2);

	ide_timing_compute(drive, speed, &t, T, UT);

	if (peer->present) {
		ide_timing_compute(peer, peer->current_speed, &p, T, UT);
		ide_timing_merge(&p, &t, &t, IDE_TIMING_8BIT);
	}

	if (speed == XFER_UDMA_5 && amd_clock <= 33333) t.udma = 1;

	amd_set_speed(HWIF(drive)->pci_dev, drive->dn, &t);

	if (!drive->init_speed)	
		drive->init_speed = speed;
	drive->current_speed = speed;

	return 0;
}

/*
 * amd74xx_tune_drive() is a callback from upper layers for
 * PIO-only tuning.
 */

static void amd74xx_tune_drive(ide_drive_t *drive, unsigned char pio)
{
	if (!((amd_enabled >> HWIF(drive)->channel) & 1))
		return;

	if (pio == 255) {
		amd_set_drive(drive, ide_find_best_mode(drive, XFER_PIO | XFER_EPIO));
		return;
	}

	amd_set_drive(drive, XFER_PIO_0 + min_t(byte, pio, 5));
}

#ifdef CONFIG_BLK_DEV_IDEDMA

/*
 * amd74xx_dmaproc() is a callback from upper layers that can do
 * a lot, but we use it for DMA/PIO tuning only, delegating everything
 * else to the default ide_dmaproc().
 */

int amd74xx_dmaproc(ide_dma_action_t func, ide_drive_t *drive)
{

	if (func == ide_dma_check) {

		short w80 = HWIF(drive)->udma_four;

		short speed = ide_find_best_mode(drive,
			XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA |
			((amd_config->flags & AMD_BAD_SWDMA) ? 0 : XFER_SWDMA) |
			(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_66 ? XFER_UDMA_66 : 0) |
			(w80 && (amd_config->flags & AMD_UDMA) >= AMD_UDMA_100 ? XFER_UDMA_100 : 0));

		amd_set_drive(drive, speed);

		func = (HWIF(drive)->autodma && (speed & XFER_MODE) != XFER_PIO)
			? ide_dma_on : ide_dma_off_quietly;
	}

	return ide_dmaproc(func, drive);
}

#endif /* CONFIG_BLK_DEV_IDEDMA */

/*
 * The initialization callback. Here we determine the IDE chip type
 * and initialize its drive independent registers.
 */

unsigned int __init pci_init_amd74xx(struct pci_dev *dev, const char *name)
{
	unsigned char t;
	unsigned int u;
	int i;

/*
 * Find out what AMD IDE is this.
 */

	for (amd_config = amd_ide_chips; amd_config->id; amd_config++) {
			pci_read_config_byte(dev, PCI_REVISION_ID, &t);
			if (dev->device == amd_config->id && t >= amd_config->rev)
				break;
		}

	if (!amd_config->id) {
		printk(KERN_WARNING "AMD_IDE: Unknown AMD IDE Chip %#x, disabling DMA.\n", dev->device);
		return -ENODEV;
	}

/*
 * Check 80-wire cable presence.
 */

	switch (amd_config->flags & AMD_UDMA) {

		case AMD_UDMA_100:
			pci_read_config_byte(dev, AMD_CABLE_DETECT, &t);
			amd_80w = ((u & 0x3) ? 1 : 0) | ((u & 0xc) ? 2 : 0);
			for (i = 24; i >= 0; i -= 8)
				if (((u >> i) & 4) && !(amd_80w & (1 << (1 - (i >> 4))))) {
					printk(KERN_WARNING "AMD_IDE: Bios didn't set cable bits corectly. Enabling workaround.\n");
					amd_80w |= (1 << (1 - (i >> 4)));
				}
			break;

		case AMD_UDMA_66:
			pci_read_config_dword(dev, AMD_UDMA_TIMING, &u);
			for (i = 24; i >= 0; i -= 8)
				if ((u >> i) & 4)
					amd_80w |= (1 << (1 - (i >> 4)));
			break;
	}

	pci_read_config_dword(dev, AMD_IDE_ENABLE, &u);
	amd_enabled = ((u & 1) ? 2 : 0) | ((u & 2) ? 1 : 0);

/*
 * Take care of prefetch & postwrite.
 */

	pci_read_config_byte(dev, AMD_IDE_CONFIG, &t);
	pci_write_config_byte(dev, AMD_IDE_CONFIG,
		(amd_config->flags & AMD_BAD_FIFO) ? (t & 0x0f) : (t | 0xf0));

/*
 * Determine the system bus clock.
 */

	amd_clock = system_bus_speed * 1000;

	switch (amd_clock) {
		case 33000: amd_clock = 33333; break;
		case 37000: amd_clock = 37500; break;
		case 41000: amd_clock = 41666; break;
	}

	if (amd_clock < 20000 || amd_clock > 50000) {
		printk(KERN_WARNING "AMD_IDE: User given PCI clock speed impossible (%d), using 33 MHz instead.\n", amd_clock);
		printk(KERN_WARNING "AMD_IDE: Use ide0=ata66 if you want to assume 80-wire cable\n");
		amd_clock = 33333;
	}

/*
 * Print the boot message.
 */

	pci_read_config_byte(dev, PCI_REVISION_ID, &t);
	printk(KERN_INFO "AMD_IDE: %s (rev %02x) %s controller on pci%s\n",
		dev->name, t, amd_dma[amd_config->flags & AMD_UDMA], dev->slot_name);

/*
 * Register /proc/ide/amd74xx entry
 */

#ifdef CONFIG_PROC_FS
	if (!amd74xx_proc) {
		amd_base = pci_resource_start(dev, 4);
		bmide_dev = dev;
		amd74xx_display_info = &amd_get_info;
		amd74xx_proc = 1;
	}
#endif

	return 0;
}

unsigned int __init ata66_amd74xx(ide_hwif_t *hwif)
{
	return ((amd_enabled & amd_80w) >> hwif->channel) & 1;
}

void __init ide_init_amd74xx(ide_hwif_t *hwif)
{
	int i;

	hwif->tuneproc = &amd74xx_tune_drive;
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
		hwif->highmem = 1;
		hwif->dmaproc = &amd74xx_dmaproc;
#ifdef CONFIG_IDEDMA_AUTO
		if (!noautodma)
			hwif->autodma = 1;
#endif
	}
#endif /* CONFIG_BLK_DEV_IDEDMA */
}

/*
 * We allow the BM-DMA driver only work on enabled interfaces.
 */

void __init ide_dmacapable_amd74xx(ide_hwif_t *hwif, unsigned long dmabase)
{
	if ((amd_enabled >> hwif->channel) & 1)
		ide_setup_dma(hwif, dmabase, 8);
}

--2oS5YaxWCcQjTEyO--
