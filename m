Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTEKOwI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 10:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbTEKOwI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 10:52:08 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:38545 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261704AbTEKOva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 10:51:30 -0400
Date: Sun, 11 May 2003 17:03:12 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Christoph Hellwig <hch@infradead.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.21-rc2 IDE Modular non-compile
Message-ID: <20030511150312.GB5376@louise.pinerecords.com>
References: <20030509064035.4C6612C014@lists.samba.org> <20030509075319.A10102@infradead.org> <20030510102615.GB12431@louise.pinerecords.com> <1052577101.16165.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052577101.16165.4.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [alan@lxorguk.ukuu.org.uk]
> 
> On Sad, 2003-05-10 at 11:26, Tomas Szepe wrote:
> > > [hch@infradead.org]
> > > 
> > > This is the patch I sent marcelo just after rc1 was released, I gues
> > > it will still apply..
> > 
> > Christoph, for a fully modular IDE (.config snippet included at the
> > end of the post) on .21rc2 I need to apply the following patch on top
> > of the one you have posted.  100% untested.
> 
> You can't have CMD640 support modular. The bool is intentional.
> 
> Second problem - your export hacks create a dependancy loop for the modules
> you have to link them together not do ugly export hacks (which btw should
> also be _GPL)

Okay, let me try again, this time with brains_enable set to 1.  8)

The patch (against 2.4.21-rc2-ac1) is rather large, because it
	o  moves cmd640.c from drivers/ide/pci to drivers/ide, and
	o  deletes cmd640.h as it is no longer used.

I'm sure the patch is far from perfect yet (esp. what I did to
ide-default.c isn't nice at all -- I couldn't see why the object
was meant to be a module, or maybe I just got lost in untangling the
reference loops), the result, however, seems to work (for a change).

The patch also contains a fix to what I reckon might be a trivial
bug -- search for "-1513,9".

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/drivers/ide/Makefile b/drivers/ide/Makefile
--- a/drivers/ide/Makefile	2003-05-11 15:50:14.000000000 +0200
+++ b/drivers/ide/Makefile	2003-05-11 16:33:00.000000000 +0200
@@ -8,18 +8,21 @@
 # In the future, some of these should be built conditionally.
 #
 
-O_TARGET := idedriver.o
+O_TARGET	:= idedriver.o
 
-export-objs := ide-iops.o ide-taskfile.o ide-proc.o ide.o ide-probe.o ide-dma.o ide-lib.o setup-pci.o ide-io.o ide-disk.o
+export-objs	:= ide-iops.o ide-taskfile.o ide-proc.o ide.o \
+			ide-probe.o ide-dma.o ide-lib.o setup-pci.o \
+			ide-io.o ide-disk.o
+
+list-multi	:= ide-mod.o ide-probe-mod.o
 
 all-subdirs	:= arm legacy pci ppc raid
 mod-subdirs	:= arm legacy pci ppc raid
 
 obj-y		:=
 obj-m		:=
-ide-obj-y	:=
 
-subdir-$(CONFIG_BLK_DEV_IDE) += legacy ppc arm raid pci
+subdir-$(CONFIG_BLK_DEV_IDE)	+= legacy ppc arm raid pci
 
 # First come modules that register themselves with the core
 
@@ -29,24 +32,12 @@
 
 # Core IDE code - must come before legacy
 
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-probe.o ide-geometry.o ide-iops.o ide-taskfile.o ide.o ide-lib.o ide-io.o ide-default.o
-obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o
-obj-$(CONFIG_BLK_DEV_IDECD)		+= ide-cd.o
-obj-$(CONFIG_BLK_DEV_IDETAPE)		+= ide-tape.o
-obj-$(CONFIG_BLK_DEV_IDEFLOPPY)		+= ide-floppy.o
-
-ifeq ($(CONFIG_BLK_DEV_IDEPCI),y)
-obj-$(CONFIG_BLK_DEV_IDE)		+= setup-pci.o
-endif
-ifeq ($(CONFIG_BLK_DEV_IDEDMA_PCI),y)
-obj-$(CONFIG_BLK_DEV_IDE)		+= ide-dma.o
-endif
-obj-$(CONFIG_BLK_DEV_ISAPNP)		+= ide-pnp.o
-
-
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
-obj-$(CONFIG_PROC_FS)			+= ide-proc.o
-endif
+obj-$(CONFIG_BLK_DEV_IDE)	+= ide-mod.o ide-probe-mod.o
+obj-$(CONFIG_BLK_DEV_IDEDISK)	+= ide-disk.o
+obj-$(CONFIG_BLK_DEV_IDECD)	+= ide-cd.o
+obj-$(CONFIG_BLK_DEV_IDETAPE)	+= ide-tape.o
+obj-$(CONFIG_BLK_DEV_IDEFLOPPY)	+= ide-floppy.o
+obj-$(CONFIG_BLK_DEV_ISAPNP)	+= ide-pnp.o
 
 ifeq ($(CONFIG_BLK_DEV_IDE),y)
   obj-y		+= legacy/idedriver-legacy.o
@@ -54,14 +45,35 @@
   obj-y		+= arm/idedriver-arm.o
 else
   ifeq ($(CONFIG_BLK_DEV_HD_ONLY),y)
-	obj-y	+= legacy/idedriver-legacy.o
+    obj-y	+= legacy/idedriver-legacy.o
   endif
 endif
 
-
-ifeq ($(CONFIG_BLK_DEV_IDE),y)
 # RAID must be last of all
+ifeq ($(CONFIG_BLK_DEV_IDE),y)
   obj-y		+= raid/idedriver-raid.o
 endif
 
+ide-mod-objs		:= ide-iops.o ide-taskfile.o ide.o ide-lib.o \
+				ide-proc.o ide-io.o ide-default.o
+ide-probe-mod-objs	:= ide-probe.o ide-geometry.o
+
+ifeq ($(CONFIG_BLK_DEV_IDEPCI),y)
+  ide-mod-objs	+= setup-pci.o
+endif
+
+ifeq ($(CONFIG_BLK_DEV_IDEDMA_PCI),y)
+  ide-mod-objs	+= ide-dma.o
+endif
+
+ifeq ($(CONFIG_BLK_DEV_CMD640),y)
+  ide-mod-objs	+= cmd640.o
+endif
+
 include $(TOPDIR)/Rules.make
+
+ide-mod.o: $(ide-mod-objs)
+	$(LD) -r -o $@ $(ide-mod-objs)
+
+ide-probe-mod.o: $(ide-probe-mod-objs)
+	$(LD) -r -o $@ $(ide-probe-mod-objs)
diff -urN a/drivers/ide/cmd640.c b/drivers/ide/cmd640.c
--- a/drivers/ide/cmd640.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/ide/cmd640.c	2003-05-11 16:10:02.000000000 +0200
@@ -0,0 +1,879 @@
+/*
+ *  linux/drivers/ide/pci/cmd640.c		Version 1.02  Sep 01, 1996
+ *
+ *  Copyright (C) 1995-1996  Linus Torvalds & authors (see below)
+ */
+
+/*
+ *  Original authors:	abramov@cecmow.enet.dec.com (Igor Abramov)
+ *  			mlord@pobox.com (Mark Lord)
+ *
+ *  See linux/MAINTAINERS for address of current maintainer.
+ *
+ *  This file provides support for the advanced features and bugs
+ *  of IDE interfaces using the CMD Technologies 0640 IDE interface chip.
+ *
+ *  These chips are basically fucked by design, and getting this driver
+ *  to work on every motherboard design that uses this screwed chip seems
+ *  bloody well impossible.  However, we're still trying.
+ *
+ *  Version 0.97 worked for everybody.
+ *
+ *  User feedback is essential.  Many thanks to the beta test team:
+ *
+ *  A.Hartgers@stud.tue.nl, JZDQC@CUNYVM.CUNY.edu, abramov@cecmow.enet.dec.com,
+ *  bardj@utopia.ppp.sn.no, bart@gaga.tue.nl, bbol001@cs.auckland.ac.nz,
+ *  chrisc@dbass.demon.co.uk, dalecki@namu26.Num.Math.Uni-Goettingen.de,
+ *  derekn@vw.ece.cmu.edu, florian@btp2x3.phy.uni-bayreuth.de,
+ *  flynn@dei.unipd.it, gadio@netvision.net.il, godzilla@futuris.net,
+ *  j@pobox.com, jkemp1@mises.uni-paderborn.de, jtoppe@hiwaay.net,
+ *  kerouac@ssnet.com, meskes@informatik.rwth-aachen.de, hzoli@cs.elte.hu,
+ *  peter@udgaard.isgtec.com, phil@tazenda.demon.co.uk, roadcapw@cfw.com,
+ *  s0033las@sun10.vsz.bme.hu, schaffer@tam.cornell.edu, sjd@slip.net,
+ *  steve@ei.org, ulrpeg@bigcomm.gun.de, ism@tardis.ed.ac.uk, mack@cray.com
+ *  liug@mama.indstate.edu, and others.
+ *
+ *  Version 0.01	Initial version, hacked out of ide.c,
+ *			and #include'd rather than compiled separately.
+ *			This will get cleaned up in a subsequent release.
+ *
+ *  Version 0.02	Fixes for vlb initialization code, enable prefetch
+ *			for versions 'B' and 'C' of chip by default,
+ *			some code cleanup.
+ *
+ *  Version 0.03	Added reset of secondary interface,
+ *			and black list for devices which are not compatible
+ *			with prefetch mode. Separate function for setting
+ *			prefetch is added, possibly it will be called some
+ *			day from ioctl processing code.
+ *
+ *  Version 0.04	Now configs/compiles separate from ide.c
+ *
+ *  Version 0.05	Major rewrite of interface timing code.
+ *			Added new function cmd640_set_mode to set PIO mode
+ *			from ioctl call. New drives added to black list.
+ *
+ *  Version 0.06	More code cleanup. Prefetch is enabled only for
+ *			detected hard drives, not included in prefetch
+ *			black list.
+ *
+ *  Version 0.07	Changed to more conservative drive tuning policy.
+ *			Unknown drives, which report PIO < 4 are set to
+ *			(reported_PIO - 1) if it is supported, or to PIO0.
+ *			List of known drives extended by info provided by
+ *			CMD at their ftp site.
+ *
+ *  Version 0.08	Added autotune/noautotune support.
+ *
+ *  Version 0.09	Try to be smarter about 2nd port enabling.
+ *  Version 0.10	Be nice and don't reset 2nd port.
+ *  Version 0.11	Try to handle more weird situations.
+ *
+ *  Version 0.12	Lots of bug fixes from Laszlo Peter
+ *			irq unmasking disabled for reliability.
+ *			try to be even smarter about the second port.
+ *			tidy up source code formatting.
+ *  Version 0.13	permit irq unmasking again.
+ *  Version 0.90	massive code cleanup, some bugs fixed.
+ *			defaults all drives to PIO mode0, prefetch off.
+ *			autotune is OFF by default, with compile time flag.
+ *			prefetch can be turned OFF/ON using "hdparm -p8/-p9"
+ *			 (requires hdparm-3.1 or newer)
+ *  Version 0.91	first release to linux-kernel list.
+ *  Version 0.92	move initial reg dump to separate callable function
+ *			change "readahead" to "prefetch" to avoid confusion
+ *  Version 0.95	respect original BIOS timings unless autotuning.
+ *			tons of code cleanup and rearrangement.
+ *			added CONFIG_BLK_DEV_CMD640_ENHANCED option
+ *			prevent use of unmask when prefetch is on
+ *  Version 0.96	prevent use of io_32bit when prefetch is off
+ *  Version 0.97	fix VLB secondary interface for sjd@slip.net
+ *			other minor tune-ups:  0.96 was very good.
+ *  Version 0.98	ignore PCI version when disabled by BIOS
+ *  Version 0.99	display setup/active/recovery clocks with PIO mode
+ *  Version 1.00	Mmm.. cannot depend on PCMD_ENA in all systems
+ *  Version 1.01	slow/fast devsel can be selected with "hdparm -p6/-p7"
+ *			 ("fast" is necessary for 32bit I/O in some systems)
+ *  Version 1.02	fix bug that resulted in slow "setup times"
+ *			 (patch courtesy of Zoltan Hidvegi)
+ */
+
+#undef REALLY_SLOW_IO		/* most systems can safely undef this */
+#define CMD640_PREFETCH_MASKS 1
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/timer.h>
+#include <linux/mm.h>
+#include <linux/ioport.h>
+#include <linux/blkdev.h>
+#include <linux/hdreg.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+
+#include <asm/io.h>
+
+#include "ide_modes.h"
+
+/*
+ * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
+ */
+int cmd640_vlb = 0;
+
+/*
+ * CMD640 specific registers definition.
+ */
+
+#define VID		0x00
+#define DID		0x02
+#define PCMD		0x04
+#define   PCMD_ENA	0x01
+#define PSTTS		0x06
+#define REVID		0x08
+#define PROGIF		0x09
+#define SUBCL		0x0a
+#define BASCL		0x0b
+#define BaseA0		0x10
+#define BaseA1		0x14
+#define BaseA2		0x18
+#define BaseA3		0x1c
+#define INTLINE		0x3c
+#define INPINE		0x3d
+
+#define	CFR		0x50
+#define   CFR_DEVREV		0x03
+#define   CFR_IDE01INTR		0x04
+#define	  CFR_DEVID		0x18
+#define	  CFR_AT_VESA_078h	0x20
+#define	  CFR_DSA1		0x40
+#define	  CFR_DSA0		0x80
+
+#define CNTRL		0x51
+#define	  CNTRL_DIS_RA0		0x40
+#define   CNTRL_DIS_RA1		0x80
+#define	  CNTRL_ENA_2ND		0x08
+
+#define	CMDTIM		0x52
+#define	ARTTIM0		0x53
+#define	DRWTIM0		0x54
+#define ARTTIM1 	0x55
+#define DRWTIM1		0x56
+#define ARTTIM23	0x57
+#define   ARTTIM23_DIS_RA2	0x04
+#define   ARTTIM23_DIS_RA3	0x08
+#define DRWTIM23	0x58
+#define BRST		0x59
+
+/*
+ * Registers and masks for easy access by drive index:
+ */
+static u8 prefetch_regs[4]  = {CNTRL, CNTRL, ARTTIM23, ARTTIM23};
+static u8 prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
+
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+
+static u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
+static u8 drwtim_regs[4] = {DRWTIM0, DRWTIM1, DRWTIM23, DRWTIM23};
+
+/*
+ * Current cmd640 timing values for each drive.
+ * The defaults for each are the slowest possible timings.
+ */
+static u8 setup_counts[4]    = {4, 4, 4, 4};     /* Address setup count (in clocks) */
+static u8 active_counts[4]   = {16, 16, 16, 16}; /* Active count   (encoded) */
+static u8 recovery_counts[4] = {16, 16, 16, 16}; /* Recovery count (encoded) */
+
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+
+/*
+ * These are initialized to point at the devices we control
+ */
+static ide_hwif_t  *cmd_hwif0, *cmd_hwif1;
+static ide_drive_t *cmd_drives[4];
+
+/*
+ * Interface to access cmd640x registers
+ */
+static unsigned int cmd640_key;
+static void (*__put_cmd640_reg)(u16 reg, u8 val);
+static u8 (*__get_cmd640_reg)(u16 reg);
+
+/*
+ * This is read from the CFR reg, and is used in several places.
+ */
+static unsigned int cmd640_chip_version;
+
+/*
+ * The CMD640x chip does not support DWORD config write cycles, but some
+ * of the BIOSes use them to implement the config services.
+ * Therefore, we must use direct IO instead.
+ */
+
+/* PCI method 1 access */
+
+static void put_cmd640_reg_pci1 (u16 reg, u8 val)
+{
+	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
+	outb_p(val, (reg & 3) | 0xcfc);
+}
+
+static u8 get_cmd640_reg_pci1 (u16 reg)
+{
+	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
+	return inb_p((reg & 3) | 0xcfc);
+}
+
+/* PCI method 2 access (from CMD datasheet) */
+
+static void put_cmd640_reg_pci2 (u16 reg, u8 val)
+{
+	outb_p(0x10, 0xcf8);
+	outb_p(val, cmd640_key + reg);
+	outb_p(0, 0xcf8);
+}
+
+static u8 get_cmd640_reg_pci2 (u16 reg)
+{
+	u8 b;
+
+	outb_p(0x10, 0xcf8);
+	b = inb_p(cmd640_key + reg);
+	outb_p(0, 0xcf8);
+	return b;
+}
+
+/* VLB access */
+
+static void put_cmd640_reg_vlb (u16 reg, u8 val)
+{
+	outb_p(reg, cmd640_key);
+	outb_p(val, cmd640_key + 4);
+}
+
+static u8 get_cmd640_reg_vlb (u16 reg)
+{
+	outb_p(reg, cmd640_key);
+	return inb_p(cmd640_key + 4);
+}
+
+static u8 get_cmd640_reg(u16 reg)
+{
+	u8 b;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	b = __get_cmd640_reg(reg);
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return b;
+}
+
+static void put_cmd640_reg(u16 reg, u8 val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	__put_cmd640_reg(reg,val);
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
+static int __init match_pci_cmd640_device (void)
+{
+	const u8 ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
+	unsigned int i;
+	for (i = 0; i < 4; i++) {
+		if (get_cmd640_reg(i) != ven_dev[i])
+			return 0;
+	}
+#ifdef STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT
+	if ((get_cmd640_reg(PCMD) & PCMD_ENA) == 0) {
+		printk("ide: cmd640 on PCI disabled by BIOS\n");
+		return 0;
+	}
+#endif /* STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT */
+	return 1; /* success */
+}
+
+/*
+ * Probe for CMD640x -- pci method 1
+ */
+static int __init probe_for_cmd640_pci1 (void)
+{
+	__get_cmd640_reg = get_cmd640_reg_pci1;
+	__put_cmd640_reg = put_cmd640_reg_pci1;
+	for (cmd640_key = 0x80000000;
+	     cmd640_key <= 0x8000f800;
+	     cmd640_key += 0x800) {
+		if (match_pci_cmd640_device())
+			return 1; /* success */
+	}
+	return 0;
+}
+
+/*
+ * Probe for CMD640x -- pci method 2
+ */
+static int __init probe_for_cmd640_pci2 (void)
+{
+	__get_cmd640_reg = get_cmd640_reg_pci2;
+	__put_cmd640_reg = put_cmd640_reg_pci2;
+	for (cmd640_key = 0xc000; cmd640_key <= 0xcf00; cmd640_key += 0x100) {
+		if (match_pci_cmd640_device())
+			return 1; /* success */
+	}
+	return 0;
+}
+
+/*
+ * Probe for CMD640x -- vlb
+ */
+static int __init probe_for_cmd640_vlb (void)
+{
+	u8 b;
+
+	__get_cmd640_reg = get_cmd640_reg_vlb;
+	__put_cmd640_reg = put_cmd640_reg_vlb;
+	cmd640_key = 0x178;
+	b = get_cmd640_reg(CFR);
+	if (b == 0xff || b == 0x00 || (b & CFR_AT_VESA_078h)) {
+		cmd640_key = 0x78;
+		b = get_cmd640_reg(CFR);
+		if (b == 0xff || b == 0x00 || !(b & CFR_AT_VESA_078h))
+			return 0;
+	}
+	return 1; /* success */
+}
+
+/*
+ *  Returns 1 if an IDE interface/drive exists at 0x170,
+ *  Returns 0 otherwise.
+ */
+static int __init secondary_port_responding (void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+
+	outb_p(0x0a, 0x170 + IDE_SELECT_OFFSET);	/* select drive0 */
+	udelay(100);
+	if ((inb_p(0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x0a) {
+		outb_p(0x1a, 0x170 + IDE_SELECT_OFFSET); /* select drive1 */
+		udelay(100);
+		if ((inb_p(0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x1a) {
+			spin_unlock_irqrestore(&ide_lock, flags);
+			return 0; /* nothing responded */
+		}
+	}
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return 1; /* success */
+}
+
+#ifdef CMD640_DUMP_REGS
+/*
+ * Dump out all cmd640 registers.  May be called from ide.c
+ */
+static void cmd640_dump_regs (void)
+{
+	unsigned int reg = cmd640_vlb ? 0x50 : 0x00;
+
+	/* Dump current state of chip registers */
+	printk("ide: cmd640 internal register dump:");
+	for (; reg <= 0x59; reg++) {
+		if (!(reg & 0x0f))
+			printk("\n%04x:", reg);
+		printk(" %02x", get_cmd640_reg(reg));
+	}
+	printk("\n");
+}
+#endif
+
+/*
+ * Check whether prefetch is on for a drive,
+ * and initialize the unmask flags for safe operation.
+ */
+static void __init check_prefetch (unsigned int index)
+{
+	ide_drive_t *drive = cmd_drives[index];
+	u8 b = get_cmd640_reg(prefetch_regs[index]);
+
+	if (b & prefetch_masks[index]) {	/* is prefetch off? */
+		drive->no_unmask = 0;
+		drive->no_io_32bit = 1;
+		drive->io_32bit = 0;
+	} else {
+#if CMD640_PREFETCH_MASKS
+		drive->no_unmask = 1;
+		drive->unmask = 0;
+#endif
+		drive->no_io_32bit = 0;
+	}
+}
+
+/*
+ * Figure out which devices we control
+ */
+static void __init setup_device_ptrs (void)
+{
+	unsigned int i;
+
+	cmd_hwif0 = &ide_hwifs[0]; /* default, if not found below */
+	cmd_hwif1 = &ide_hwifs[1]; /* default, if not found below */
+	for (i = 0; i < MAX_HWIFS; i++) {
+		ide_hwif_t *hwif = &ide_hwifs[i];
+		if (hwif->chipset == ide_unknown || hwif->chipset == ide_generic) {
+			if (hwif->io_ports[IDE_DATA_OFFSET] == 0x1f0)
+				cmd_hwif0 = hwif;
+			else if (hwif->io_ports[IDE_DATA_OFFSET] == 0x170)
+				cmd_hwif1 = hwif;
+		}
+	}
+	cmd_drives[0] = &cmd_hwif0->drives[0];
+	cmd_drives[1] = &cmd_hwif0->drives[1];
+	cmd_drives[2] = &cmd_hwif1->drives[0];
+	cmd_drives[3] = &cmd_hwif1->drives[1];
+}
+
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+
+/*
+ * Sets prefetch mode for a drive.
+ */
+static void set_prefetch_mode (unsigned int index, int mode)
+{
+	ide_drive_t *drive = cmd_drives[index];
+	int reg = prefetch_regs[index];
+	u8 b;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	b = __get_cmd640_reg(reg);
+	if (mode) {	/* want prefetch on? */
+#if CMD640_PREFETCH_MASKS
+		drive->no_unmask = 1;
+		drive->unmask = 0;
+#endif
+		drive->no_io_32bit = 0;
+		b &= ~prefetch_masks[index];	/* enable prefetch */
+	} else {
+		drive->no_unmask = 0;
+		drive->no_io_32bit = 1;
+		drive->io_32bit = 0;
+		b |= prefetch_masks[index];	/* disable prefetch */
+	}
+	__put_cmd640_reg(reg, b);
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
+/*
+ * Dump out current drive clocks settings
+ */
+static void display_clocks (unsigned int index)
+{
+	u8 active_count, recovery_count;
+
+	active_count = active_counts[index];
+	if (active_count == 1)
+		++active_count;
+	recovery_count = recovery_counts[index];
+	if (active_count > 3 && recovery_count == 1)
+		++recovery_count;
+	if (cmd640_chip_version > 1)
+		recovery_count += 1;  /* cmd640b uses (count + 1)*/
+	printk(", clocks=%d/%d/%d\n", setup_counts[index], active_count, recovery_count);
+}
+
+/*
+ * Pack active and recovery counts into single byte representation
+ * used by controller
+ */
+inline static u8 pack_nibbles (u8 upper, u8 lower)
+{
+	return ((upper & 0x0f) << 4) | (lower & 0x0f);
+}
+
+/*
+ * This routine retrieves the initial drive timings from the chipset.
+ */
+static void __init retrieve_drive_counts (unsigned int index)
+{
+	u8 b;
+
+	/*
+	 * Get the internal setup timing, and convert to clock count
+	 */
+	b = get_cmd640_reg(arttim_regs[index]) & ~0x3f;
+	switch (b) {
+		case 0x00: b = 4; break;
+		case 0x80: b = 3; break;
+		case 0x40: b = 2; break;
+		default:   b = 5; break;
+	}
+	setup_counts[index] = b;
+
+	/*
+	 * Get the active/recovery counts
+	 */
+	b = get_cmd640_reg(drwtim_regs[index]);
+	active_counts[index]   = (b >> 4)   ? (b >> 4)   : 0x10;
+	recovery_counts[index] = (b & 0x0f) ? (b & 0x0f) : 0x10;
+}
+
+
+/*
+ * This routine writes the prepared setup/active/recovery counts
+ * for a drive into the cmd640 chipset registers to active them.
+ */
+static void program_drive_counts (unsigned int index)
+{
+	unsigned long flags;
+	u8 setup_count    = setup_counts[index];
+	u8 active_count   = active_counts[index];
+	u8 recovery_count = recovery_counts[index];
+
+	/*
+	 * Set up address setup count and drive read/write timing registers.
+	 * Primary interface has individual count/timing registers for
+	 * each drive.  Secondary interface has one common set of registers,
+	 * so we merge the timings, using the slowest value for each timing.
+	 */
+	if (index > 1) {
+		unsigned int mate;
+		if (cmd_drives[mate = index ^ 1]->present) {
+			if (setup_count < setup_counts[mate])
+				setup_count = setup_counts[mate];
+			if (active_count < active_counts[mate])
+				active_count = active_counts[mate];
+			if (recovery_count < recovery_counts[mate])
+				recovery_count = recovery_counts[mate];
+		}
+	}
+
+	/*
+	 * Convert setup_count to internal chipset representation
+	 */
+	switch (setup_count) {
+		case 4:	 setup_count = 0x00; break;
+		case 3:	 setup_count = 0x80; break;
+		case 1:
+		case 2:	 setup_count = 0x40; break;
+		default: setup_count = 0xc0; /* case 5 */
+	}
+
+	/*
+	 * Now that everything is ready, program the new timings
+	 */
+	spin_lock_irqsave(&ide_lock, flags);
+	/*
+	 * Program the address_setup clocks into ARTTIM reg,
+	 * and then the active/recovery counts into the DRWTIM reg
+	 * (this converts counts of 16 into counts of zero -- okay).
+	 */
+	setup_count |= __get_cmd640_reg(arttim_regs[index]) & 0x3f;
+	__put_cmd640_reg(arttim_regs[index], setup_count);
+	__put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count, recovery_count));
+	spin_unlock_irqrestore(&ide_lock, flags);
+}
+
+/*
+ * Set a specific pio_mode for a drive
+ */
+static void cmd640_set_mode (unsigned int index, u8 pio_mode, unsigned int cycle_time)
+{
+	int setup_time, active_time, recovery_time, clock_time;
+	u8 setup_count, active_count, recovery_count, recovery_count2, cycle_count;
+	int bus_speed = system_bus_clock();
+
+	if (pio_mode > 5)
+		pio_mode = 5;
+	setup_time  = ide_pio_timings[pio_mode].setup_time;
+	active_time = ide_pio_timings[pio_mode].active_time;
+	recovery_time = cycle_time - (setup_time + active_time);
+	clock_time = 1000 / bus_speed;
+	cycle_count = (cycle_time + clock_time - 1) / clock_time;
+
+	setup_count = (setup_time + clock_time - 1) / clock_time;
+
+	active_count = (active_time + clock_time - 1) / clock_time;
+	if (active_count < 2)
+		active_count = 2; /* minimum allowed by cmd640 */
+
+	recovery_count = (recovery_time + clock_time - 1) / clock_time;
+	recovery_count2 = cycle_count - (setup_count + active_count);
+	if (recovery_count2 > recovery_count)
+		recovery_count = recovery_count2;
+	if (recovery_count < 2)
+		recovery_count = 2; /* minimum allowed by cmd640 */
+	if (recovery_count > 17) {
+		active_count += recovery_count - 17;
+		recovery_count = 17;
+	}
+	if (active_count > 16)
+		active_count = 16; /* maximum allowed by cmd640 */
+	if (cmd640_chip_version > 1)
+		recovery_count -= 1;  /* cmd640b uses (count + 1)*/
+	if (recovery_count > 16)
+		recovery_count = 16; /* maximum allowed by cmd640 */
+
+	setup_counts[index]    = setup_count;
+	active_counts[index]   = active_count;
+	recovery_counts[index] = recovery_count;
+
+	/*
+	 * In a perfect world, we might set the drive pio mode here
+	 * (using WIN_SETFEATURE) before continuing.
+	 *
+	 * But we do not, because:
+	 *	1) this is the wrong place to do it (proper is do_special() in ide.c)
+	 * 	2) in practice this is rarely, if ever, necessary
+	 */
+	program_drive_counts (index);
+}
+
+/*
+ * Drive PIO mode selection:
+ */
+static void cmd640_tune_drive (ide_drive_t *drive, u8 mode_wanted)
+{
+	u8 b;
+	ide_pio_data_t  d;
+	unsigned int index = 0;
+
+	while (drive != cmd_drives[index]) {
+		if (++index > 3) {
+			printk("%s: bad news in cmd640_tune_drive\n", drive->name);
+			return;
+		}
+	}
+	switch (mode_wanted) {
+		case 6: /* set fast-devsel off */
+		case 7: /* set fast-devsel on */
+			mode_wanted &= 1;
+			b = get_cmd640_reg(CNTRL) & ~0x27;
+			if (mode_wanted)
+				b |= 0x27;
+			put_cmd640_reg(CNTRL, b);
+			printk("%s: %sabled cmd640 fast host timing (devsel)\n", drive->name, mode_wanted ? "en" : "dis");
+			return;
+
+		case 8: /* set prefetch off */
+		case 9: /* set prefetch on */
+			mode_wanted &= 1;
+			set_prefetch_mode(index, mode_wanted);
+			printk("%s: %sabled cmd640 prefetch\n", drive->name, mode_wanted ? "en" : "dis");
+			return;
+	}
+
+	(void) ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
+	cmd640_set_mode (index, d.pio_mode, d.cycle_time);
+
+	printk ("%s: selected cmd640 PIO mode%d (%dns)%s",
+		drive->name,
+		d.pio_mode,
+		d.cycle_time,
+		d.overridden ? " (overriding vendor mode)" : "");
+	display_clocks(index);
+	return;
+}
+
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+
+static int pci_conf1(void)
+{
+	u32 tmp;
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	outb(0x01, 0xCFB);
+	tmp = inl(0xCF8);
+	outl(0x80000000, 0xCF8);
+	if (inl(0xCF8) == 0x80000000) {
+		outl(tmp, 0xCF8);
+		spin_unlock_irqrestore(&ide_lock, flags);
+		return 1;
+	}
+	outl(tmp, 0xCF8);
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return 0;
+}
+
+static int pci_conf2(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ide_lock, flags);
+	outb(0x00, 0xCFB);
+	outb(0x00, 0xCF8);
+	outb(0x00, 0xCFA);
+	if (inb(0xCF8) == 0x00 && inb(0xCF8) == 0x00) {
+		spin_unlock_irqrestore(&ide_lock, flags);
+		return 1;
+	}
+	spin_unlock_irqrestore(&ide_lock, flags);
+	return 0;
+}
+
+/*
+ * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
+ */
+int __init ide_probe_for_cmd640x (void)
+{
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+	int second_port_toggled = 0;
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+	int second_port_cmd640 = 0;
+	const char *bus_type, *port2;
+	unsigned int index;
+	u8 b, cfr;
+
+	if (cmd640_vlb && probe_for_cmd640_vlb()) {
+		bus_type = "VLB";
+	} else {
+		cmd640_vlb = 0;
+		/* Find out what kind of PCI probing is supported otherwise
+		   Justin Gibbs will sulk.. */
+		if (pci_conf1() && probe_for_cmd640_pci1())
+			bus_type = "PCI (type1)";
+		else if (pci_conf2() && probe_for_cmd640_pci2())
+			bus_type = "PCI (type2)";
+		else
+			return 0;
+	}
+	/*
+	 * Undocumented magic (there is no 0x5b reg in specs)
+	 */
+	put_cmd640_reg(0x5b, 0xbd);
+	if (get_cmd640_reg(0x5b) != 0xbd) {
+		printk(KERN_ERR "ide: cmd640 init failed: wrong value in reg 0x5b\n");
+		return 0;
+	}
+	put_cmd640_reg(0x5b, 0);
+
+#ifdef CMD640_DUMP_REGS
+	CMD640_DUMP_REGS;
+#endif
+
+	/*
+	 * Documented magic begins here
+	 */
+	cfr = get_cmd640_reg(CFR);
+	cmd640_chip_version = cfr & CFR_DEVREV;
+	if (cmd640_chip_version == 0) {
+		printk ("ide: bad cmd640 revision: %d\n", cmd640_chip_version);
+		return 0;
+	}
+
+	/*
+	 * Initialize data for primary port
+	 */
+	setup_device_ptrs ();
+	printk("%s: buggy cmd640%c interface on %s, config=0x%02x\n",
+	       cmd_hwif0->name, 'a' + cmd640_chip_version - 1, bus_type, cfr);
+	cmd_hwif0->chipset = ide_cmd640;
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+	cmd_hwif0->tuneproc = &cmd640_tune_drive;
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+
+	/*
+	 * Ensure compatibility by always using the slowest timings
+	 * for access to the drive's command register block,
+	 * and reset the prefetch burstsize to default (512 bytes).
+	 *
+	 * Maybe we need a way to NOT do these on *some* systems?
+	 */
+	put_cmd640_reg(CMDTIM, 0);
+	put_cmd640_reg(BRST, 0x40);
+
+	/*
+	 * Try to enable the secondary interface, if not already enabled
+	 */
+	if (cmd_hwif1->noprobe) {
+		port2 = "not probed";
+	} else {
+		b = get_cmd640_reg(CNTRL);
+		if (secondary_port_responding()) {
+			if ((b & CNTRL_ENA_2ND)) {
+				second_port_cmd640 = 1;
+				port2 = "okay";
+			} else if (cmd640_vlb) {
+				second_port_cmd640 = 1;
+				port2 = "alive";
+			} else
+				port2 = "not cmd640";
+		} else {
+			put_cmd640_reg(CNTRL, b ^ CNTRL_ENA_2ND); /* toggle the bit */
+			if (secondary_port_responding()) {
+				second_port_cmd640 = 1;
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+				second_port_toggled = 1;
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+				port2 = "enabled";
+			} else {
+				put_cmd640_reg(CNTRL, b); /* restore original setting */
+				port2 = "not responding";
+			}
+		}
+	}
+
+	/*
+	 * Initialize data for secondary cmd640 port, if enabled
+	 */
+	if (second_port_cmd640) {
+		cmd_hwif0->serialized = 1;
+		cmd_hwif1->serialized = 1;
+		cmd_hwif1->chipset = ide_cmd640;
+		cmd_hwif0->mate = cmd_hwif1;
+		cmd_hwif1->mate = cmd_hwif0;
+		cmd_hwif1->channel = 1;
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+		cmd_hwif1->tuneproc = &cmd640_tune_drive;
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+	}
+	printk(KERN_INFO "%s: %sserialized, secondary interface %s\n", cmd_hwif1->name,
+		cmd_hwif0->serialized ? "" : "not ", port2);
+
+	/*
+	 * Establish initial timings/prefetch for all drives.
+	 * Do not unnecessarily disturb any prior BIOS setup of these.
+	 */
+	for (index = 0; index < (2 + (second_port_cmd640 << 1)); index++) {
+		ide_drive_t *drive = cmd_drives[index];
+#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
+		if (drive->autotune || ((index > 1) && second_port_toggled)) {
+	 		/*
+	 		 * Reset timing to the slowest speed and turn off prefetch.
+			 * This way, the drive identify code has a better chance.
+			 */
+			setup_counts    [index] = 4;	/* max possible */
+			active_counts   [index] = 16;	/* max possible */
+			recovery_counts [index] = 16;	/* max possible */
+			program_drive_counts (index);
+			set_prefetch_mode (index, 0);
+			printk("cmd640: drive%d timings/prefetch cleared\n", index);
+		} else {
+			/*
+			 * Record timings/prefetch without changing them.
+			 * This preserves any prior BIOS setup.
+			 */
+			retrieve_drive_counts (index);
+			check_prefetch (index);
+			printk("cmd640: drive%d timings/prefetch(%s) preserved",
+				index, drive->no_io_32bit ? "off" : "on");
+			display_clocks(index);
+		}
+#else
+		/*
+		 * Set the drive unmask flags to match the prefetch setting
+		 */
+		check_prefetch (index);
+		printk("cmd640: drive%d timings/prefetch(%s) preserved\n",
+			index, drive->no_io_32bit ? "off" : "on");
+#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
+	}
+
+#ifdef CMD640_DUMP_REGS
+	CMD640_DUMP_REGS;
+#endif
+	return 1;
+}
+
diff -urN a/drivers/ide/ide-default.c b/drivers/ide/ide-default.c
--- a/drivers/ide/ide-default.c	2003-05-11 15:50:07.000000000 +0200
+++ b/drivers/ide/ide-default.c	2003-05-11 16:35:15.000000000 +0200
@@ -2,14 +2,14 @@
  *	ide-default		-	Driver for unbound ide devices
  *
  *	This provides a clean way to bind a device to default operations
- *	by having an actual driver class that rather than special casing
+ *	by having an actual driver class rather than special casing
  *	"no driver" all over the IDE code
  *
  *	Copyright (C) 2003, Red Hat <alan@redhat.com>
  */
 
 #include <linux/config.h>
-#include <linux/module.h>
+/* #include <linux/module.h> */
 #include <linux/types.h>
 #include <linux/string.h>
 #include <linux/kernel.h>
@@ -68,7 +68,7 @@
 int idedefault_attach (ide_drive_t *drive)
 {
 	int ret = 0;
-	MOD_INC_USE_COUNT;
+	/* MOD_INC_USE_COUNT; */
 	if (ide_register_subdriver(drive,
 			&idedefault_driver, IDE_SUBDRIVER_VERSION)) {
 		printk(KERN_ERR "ide-default: %s: Failed to register the "
@@ -81,11 +81,11 @@
 	DRIVER(drive)->busy--;
 
 bye_game_over:
-	MOD_DEC_USE_COUNT;
+	/* MOD_DEC_USE_COUNT; */
 	return ret;
 }
 
-MODULE_DESCRIPTION("IDE Default Driver");
+/* MODULE_DESCRIPTION("IDE Default Driver"); */
 
 int idedefault_init (void)
 {
@@ -93,5 +93,5 @@
 	return 0;
 }
 
-module_init(idedefault_init);
-MODULE_LICENSE("GPL");
+/* module_init(idedefault_init);
+MODULE_LICENSE("GPL"); */
diff -urN a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
--- a/drivers/ide/ide-io.c	2003-05-11 15:50:07.000000000 +0200
+++ b/drivers/ide/ide-io.c	2003-05-11 16:38:14.000000000 +0200
@@ -895,6 +895,7 @@
 {
 	ide_do_request(q->queuedata, IDE_NO_IRQ);
 }
+EXPORT_SYMBOL_GPL(do_ide_request);
 
 /*
  * un-busy the hwgroup etc, and clear any pending DMA status. we want to
diff -urN a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c	2003-05-11 15:50:14.000000000 +0200
+++ b/drivers/ide/ide.c	2003-05-11 16:32:43.000000000 +0200
@@ -1413,6 +1413,7 @@
 		ide_add_setting(drive,	"ide-scsi",		SETTING_RW,					-1,		HDIO_SET_IDE_SCSI,		TYPE_BYTE,	0,	1,				1,		1,		&drive->scsi,			ide_atapi_to_scsi);
 #endif		
 }
+EXPORT_SYMBOL_GPL(ide_add_generic_settings);
 
 /*
  * Delay for *at least* 50ms.  As we don't know how much time is left
@@ -1513,9 +1514,11 @@
 		default:
 		{
 			extern int idedefault_attach(ide_drive_t *drive);
-			if(idedefault_attach(drive))
+			if(idedefault_attach(drive)) {
 				printk(KERN_CRIT "ide: failed to attach default driver.\n");
-			return 1;
+				return 1;
+			}
+			break;
 		}
 	}
 	return 0;
@@ -2115,7 +2118,7 @@
 #ifdef CONFIG_BLK_DEV_CMD640
 			case -14: /* "cmd640_vlb" */
 			{
-				extern int cmd640_vlb; /* flag for cmd640.c */
+				extern int cmd640_vlb;	/* flag for cmd640.c */
 				cmd640_vlb = 1;
 				goto done;
 			}
@@ -2308,7 +2311,7 @@
 
 void __init ide_init_builtin_subdrivers (void)
 {
-	idedefault_init();
+	(void) idedefault_init();
 #ifdef CONFIG_BLK_DEV_IDEDISK
 	(void) idedisk_init();
 #endif /* CONFIG_BLK_DEV_IDEDISK */
diff -urN a/drivers/ide/pci/Makefile b/drivers/ide/pci/Makefile
--- a/drivers/ide/pci/Makefile	2003-05-11 15:50:07.000000000 +0200
+++ b/drivers/ide/pci/Makefile	2003-05-11 16:07:36.000000000 +0200
@@ -8,7 +8,6 @@
 obj-$(CONFIG_BLK_DEV_AEC62XX)		+= aec62xx.o
 obj-$(CONFIG_BLK_DEV_ALI15X3)		+= alim15x3.o
 obj-$(CONFIG_BLK_DEV_AMD74XX)		+= amd74xx.o
-obj-$(CONFIG_BLK_DEV_CMD640)		+= cmd640.o
 obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
diff -urN a/drivers/ide/pci/cmd640.c b/drivers/ide/pci/cmd640.c
--- a/drivers/ide/pci/cmd640.c	2003-05-11 15:50:07.000000000 +0200
+++ b/drivers/ide/pci/cmd640.c	1970-01-01 01:00:00.000000000 +0100
@@ -1,879 +0,0 @@
-/*
- *  linux/drivers/ide/pci/cmd640.c		Version 1.02  Sep 01, 1996
- *
- *  Copyright (C) 1995-1996  Linus Torvalds & authors (see below)
- */
-
-/*
- *  Original authors:	abramov@cecmow.enet.dec.com (Igor Abramov)
- *  			mlord@pobox.com (Mark Lord)
- *
- *  See linux/MAINTAINERS for address of current maintainer.
- *
- *  This file provides support for the advanced features and bugs
- *  of IDE interfaces using the CMD Technologies 0640 IDE interface chip.
- *
- *  These chips are basically fucked by design, and getting this driver
- *  to work on every motherboard design that uses this screwed chip seems
- *  bloody well impossible.  However, we're still trying.
- *
- *  Version 0.97 worked for everybody.
- *
- *  User feedback is essential.  Many thanks to the beta test team:
- *
- *  A.Hartgers@stud.tue.nl, JZDQC@CUNYVM.CUNY.edu, abramov@cecmow.enet.dec.com,
- *  bardj@utopia.ppp.sn.no, bart@gaga.tue.nl, bbol001@cs.auckland.ac.nz,
- *  chrisc@dbass.demon.co.uk, dalecki@namu26.Num.Math.Uni-Goettingen.de,
- *  derekn@vw.ece.cmu.edu, florian@btp2x3.phy.uni-bayreuth.de,
- *  flynn@dei.unipd.it, gadio@netvision.net.il, godzilla@futuris.net,
- *  j@pobox.com, jkemp1@mises.uni-paderborn.de, jtoppe@hiwaay.net,
- *  kerouac@ssnet.com, meskes@informatik.rwth-aachen.de, hzoli@cs.elte.hu,
- *  peter@udgaard.isgtec.com, phil@tazenda.demon.co.uk, roadcapw@cfw.com,
- *  s0033las@sun10.vsz.bme.hu, schaffer@tam.cornell.edu, sjd@slip.net,
- *  steve@ei.org, ulrpeg@bigcomm.gun.de, ism@tardis.ed.ac.uk, mack@cray.com
- *  liug@mama.indstate.edu, and others.
- *
- *  Version 0.01	Initial version, hacked out of ide.c,
- *			and #include'd rather than compiled separately.
- *			This will get cleaned up in a subsequent release.
- *
- *  Version 0.02	Fixes for vlb initialization code, enable prefetch
- *			for versions 'B' and 'C' of chip by default,
- *			some code cleanup.
- *
- *  Version 0.03	Added reset of secondary interface,
- *			and black list for devices which are not compatible
- *			with prefetch mode. Separate function for setting
- *			prefetch is added, possibly it will be called some
- *			day from ioctl processing code.
- *
- *  Version 0.04	Now configs/compiles separate from ide.c
- *
- *  Version 0.05	Major rewrite of interface timing code.
- *			Added new function cmd640_set_mode to set PIO mode
- *			from ioctl call. New drives added to black list.
- *
- *  Version 0.06	More code cleanup. Prefetch is enabled only for
- *			detected hard drives, not included in prefetch
- *			black list.
- *
- *  Version 0.07	Changed to more conservative drive tuning policy.
- *			Unknown drives, which report PIO < 4 are set to
- *			(reported_PIO - 1) if it is supported, or to PIO0.
- *			List of known drives extended by info provided by
- *			CMD at their ftp site.
- *
- *  Version 0.08	Added autotune/noautotune support.
- *
- *  Version 0.09	Try to be smarter about 2nd port enabling.
- *  Version 0.10	Be nice and don't reset 2nd port.
- *  Version 0.11	Try to handle more weird situations.
- *
- *  Version 0.12	Lots of bug fixes from Laszlo Peter
- *			irq unmasking disabled for reliability.
- *			try to be even smarter about the second port.
- *			tidy up source code formatting.
- *  Version 0.13	permit irq unmasking again.
- *  Version 0.90	massive code cleanup, some bugs fixed.
- *			defaults all drives to PIO mode0, prefetch off.
- *			autotune is OFF by default, with compile time flag.
- *			prefetch can be turned OFF/ON using "hdparm -p8/-p9"
- *			 (requires hdparm-3.1 or newer)
- *  Version 0.91	first release to linux-kernel list.
- *  Version 0.92	move initial reg dump to separate callable function
- *			change "readahead" to "prefetch" to avoid confusion
- *  Version 0.95	respect original BIOS timings unless autotuning.
- *			tons of code cleanup and rearrangement.
- *			added CONFIG_BLK_DEV_CMD640_ENHANCED option
- *			prevent use of unmask when prefetch is on
- *  Version 0.96	prevent use of io_32bit when prefetch is off
- *  Version 0.97	fix VLB secondary interface for sjd@slip.net
- *			other minor tune-ups:  0.96 was very good.
- *  Version 0.98	ignore PCI version when disabled by BIOS
- *  Version 0.99	display setup/active/recovery clocks with PIO mode
- *  Version 1.00	Mmm.. cannot depend on PCMD_ENA in all systems
- *  Version 1.01	slow/fast devsel can be selected with "hdparm -p6/-p7"
- *			 ("fast" is necessary for 32bit I/O in some systems)
- *  Version 1.02	fix bug that resulted in slow "setup times"
- *			 (patch courtesy of Zoltan Hidvegi)
- */
-
-#undef REALLY_SLOW_IO		/* most systems can safely undef this */
-#define CMD640_PREFETCH_MASKS 1
-
-#include <linux/config.h>
-#include <linux/types.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/timer.h>
-#include <linux/mm.h>
-#include <linux/ioport.h>
-#include <linux/blkdev.h>
-#include <linux/hdreg.h>
-#include <linux/ide.h>
-#include <linux/init.h>
-
-#include <asm/io.h>
-
-#include "ide_modes.h"
-
-/*
- * This flag is set in ide.c by the parameter:  ide0=cmd640_vlb
- */
-int cmd640_vlb = 0;
-
-/*
- * CMD640 specific registers definition.
- */
-
-#define VID		0x00
-#define DID		0x02
-#define PCMD		0x04
-#define   PCMD_ENA	0x01
-#define PSTTS		0x06
-#define REVID		0x08
-#define PROGIF		0x09
-#define SUBCL		0x0a
-#define BASCL		0x0b
-#define BaseA0		0x10
-#define BaseA1		0x14
-#define BaseA2		0x18
-#define BaseA3		0x1c
-#define INTLINE		0x3c
-#define INPINE		0x3d
-
-#define	CFR		0x50
-#define   CFR_DEVREV		0x03
-#define   CFR_IDE01INTR		0x04
-#define	  CFR_DEVID		0x18
-#define	  CFR_AT_VESA_078h	0x20
-#define	  CFR_DSA1		0x40
-#define	  CFR_DSA0		0x80
-
-#define CNTRL		0x51
-#define	  CNTRL_DIS_RA0		0x40
-#define   CNTRL_DIS_RA1		0x80
-#define	  CNTRL_ENA_2ND		0x08
-
-#define	CMDTIM		0x52
-#define	ARTTIM0		0x53
-#define	DRWTIM0		0x54
-#define ARTTIM1 	0x55
-#define DRWTIM1		0x56
-#define ARTTIM23	0x57
-#define   ARTTIM23_DIS_RA2	0x04
-#define   ARTTIM23_DIS_RA3	0x08
-#define DRWTIM23	0x58
-#define BRST		0x59
-
-/*
- * Registers and masks for easy access by drive index:
- */
-static u8 prefetch_regs[4]  = {CNTRL, CNTRL, ARTTIM23, ARTTIM23};
-static u8 prefetch_masks[4] = {CNTRL_DIS_RA0, CNTRL_DIS_RA1, ARTTIM23_DIS_RA2, ARTTIM23_DIS_RA3};
-
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-
-static u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
-static u8 drwtim_regs[4] = {DRWTIM0, DRWTIM1, DRWTIM23, DRWTIM23};
-
-/*
- * Current cmd640 timing values for each drive.
- * The defaults for each are the slowest possible timings.
- */
-static u8 setup_counts[4]    = {4, 4, 4, 4};     /* Address setup count (in clocks) */
-static u8 active_counts[4]   = {16, 16, 16, 16}; /* Active count   (encoded) */
-static u8 recovery_counts[4] = {16, 16, 16, 16}; /* Recovery count (encoded) */
-
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-
-/*
- * These are initialized to point at the devices we control
- */
-static ide_hwif_t  *cmd_hwif0, *cmd_hwif1;
-static ide_drive_t *cmd_drives[4];
-
-/*
- * Interface to access cmd640x registers
- */
-static unsigned int cmd640_key;
-static void (*__put_cmd640_reg)(u16 reg, u8 val);
-static u8 (*__get_cmd640_reg)(u16 reg);
-
-/*
- * This is read from the CFR reg, and is used in several places.
- */
-static unsigned int cmd640_chip_version;
-
-/*
- * The CMD640x chip does not support DWORD config write cycles, but some
- * of the BIOSes use them to implement the config services.
- * Therefore, we must use direct IO instead.
- */
-
-/* PCI method 1 access */
-
-static void put_cmd640_reg_pci1 (u16 reg, u8 val)
-{
-	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
-	outb_p(val, (reg & 3) | 0xcfc);
-}
-
-static u8 get_cmd640_reg_pci1 (u16 reg)
-{
-	outb_p((reg & 0xfc) | cmd640_key, 0xcf8);
-	return inb_p((reg & 3) | 0xcfc);
-}
-
-/* PCI method 2 access (from CMD datasheet) */
-
-static void put_cmd640_reg_pci2 (u16 reg, u8 val)
-{
-	outb_p(0x10, 0xcf8);
-	outb_p(val, cmd640_key + reg);
-	outb_p(0, 0xcf8);
-}
-
-static u8 get_cmd640_reg_pci2 (u16 reg)
-{
-	u8 b;
-
-	outb_p(0x10, 0xcf8);
-	b = inb_p(cmd640_key + reg);
-	outb_p(0, 0xcf8);
-	return b;
-}
-
-/* VLB access */
-
-static void put_cmd640_reg_vlb (u16 reg, u8 val)
-{
-	outb_p(reg, cmd640_key);
-	outb_p(val, cmd640_key + 4);
-}
-
-static u8 get_cmd640_reg_vlb (u16 reg)
-{
-	outb_p(reg, cmd640_key);
-	return inb_p(cmd640_key + 4);
-}
-
-static u8 get_cmd640_reg(u16 reg)
-{
-	u8 b;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	b = __get_cmd640_reg(reg);
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return b;
-}
-
-static void put_cmd640_reg(u16 reg, u8 val)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	__put_cmd640_reg(reg,val);
-	spin_unlock_irqrestore(&ide_lock, flags);
-}
-
-static int __init match_pci_cmd640_device (void)
-{
-	const u8 ven_dev[4] = {0x95, 0x10, 0x40, 0x06};
-	unsigned int i;
-	for (i = 0; i < 4; i++) {
-		if (get_cmd640_reg(i) != ven_dev[i])
-			return 0;
-	}
-#ifdef STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT
-	if ((get_cmd640_reg(PCMD) & PCMD_ENA) == 0) {
-		printk("ide: cmd640 on PCI disabled by BIOS\n");
-		return 0;
-	}
-#endif /* STUPIDLY_TRUST_BROKEN_PCMD_ENA_BIT */
-	return 1; /* success */
-}
-
-/*
- * Probe for CMD640x -- pci method 1
- */
-static int __init probe_for_cmd640_pci1 (void)
-{
-	__get_cmd640_reg = get_cmd640_reg_pci1;
-	__put_cmd640_reg = put_cmd640_reg_pci1;
-	for (cmd640_key = 0x80000000;
-	     cmd640_key <= 0x8000f800;
-	     cmd640_key += 0x800) {
-		if (match_pci_cmd640_device())
-			return 1; /* success */
-	}
-	return 0;
-}
-
-/*
- * Probe for CMD640x -- pci method 2
- */
-static int __init probe_for_cmd640_pci2 (void)
-{
-	__get_cmd640_reg = get_cmd640_reg_pci2;
-	__put_cmd640_reg = put_cmd640_reg_pci2;
-	for (cmd640_key = 0xc000; cmd640_key <= 0xcf00; cmd640_key += 0x100) {
-		if (match_pci_cmd640_device())
-			return 1; /* success */
-	}
-	return 0;
-}
-
-/*
- * Probe for CMD640x -- vlb
- */
-static int __init probe_for_cmd640_vlb (void)
-{
-	u8 b;
-
-	__get_cmd640_reg = get_cmd640_reg_vlb;
-	__put_cmd640_reg = put_cmd640_reg_vlb;
-	cmd640_key = 0x178;
-	b = get_cmd640_reg(CFR);
-	if (b == 0xff || b == 0x00 || (b & CFR_AT_VESA_078h)) {
-		cmd640_key = 0x78;
-		b = get_cmd640_reg(CFR);
-		if (b == 0xff || b == 0x00 || !(b & CFR_AT_VESA_078h))
-			return 0;
-	}
-	return 1; /* success */
-}
-
-/*
- *  Returns 1 if an IDE interface/drive exists at 0x170,
- *  Returns 0 otherwise.
- */
-static int __init secondary_port_responding (void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-
-	outb_p(0x0a, 0x170 + IDE_SELECT_OFFSET);	/* select drive0 */
-	udelay(100);
-	if ((inb_p(0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x0a) {
-		outb_p(0x1a, 0x170 + IDE_SELECT_OFFSET); /* select drive1 */
-		udelay(100);
-		if ((inb_p(0x170 + IDE_SELECT_OFFSET) & 0x1f) != 0x1a) {
-			spin_unlock_irqrestore(&ide_lock, flags);
-			return 0; /* nothing responded */
-		}
-	}
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return 1; /* success */
-}
-
-#ifdef CMD640_DUMP_REGS
-/*
- * Dump out all cmd640 registers.  May be called from ide.c
- */
-static void cmd640_dump_regs (void)
-{
-	unsigned int reg = cmd640_vlb ? 0x50 : 0x00;
-
-	/* Dump current state of chip registers */
-	printk("ide: cmd640 internal register dump:");
-	for (; reg <= 0x59; reg++) {
-		if (!(reg & 0x0f))
-			printk("\n%04x:", reg);
-		printk(" %02x", get_cmd640_reg(reg));
-	}
-	printk("\n");
-}
-#endif
-
-/*
- * Check whether prefetch is on for a drive,
- * and initialize the unmask flags for safe operation.
- */
-static void __init check_prefetch (unsigned int index)
-{
-	ide_drive_t *drive = cmd_drives[index];
-	u8 b = get_cmd640_reg(prefetch_regs[index]);
-
-	if (b & prefetch_masks[index]) {	/* is prefetch off? */
-		drive->no_unmask = 0;
-		drive->no_io_32bit = 1;
-		drive->io_32bit = 0;
-	} else {
-#if CMD640_PREFETCH_MASKS
-		drive->no_unmask = 1;
-		drive->unmask = 0;
-#endif
-		drive->no_io_32bit = 0;
-	}
-}
-
-/*
- * Figure out which devices we control
- */
-static void __init setup_device_ptrs (void)
-{
-	unsigned int i;
-
-	cmd_hwif0 = &ide_hwifs[0]; /* default, if not found below */
-	cmd_hwif1 = &ide_hwifs[1]; /* default, if not found below */
-	for (i = 0; i < MAX_HWIFS; i++) {
-		ide_hwif_t *hwif = &ide_hwifs[i];
-		if (hwif->chipset == ide_unknown || hwif->chipset == ide_generic) {
-			if (hwif->io_ports[IDE_DATA_OFFSET] == 0x1f0)
-				cmd_hwif0 = hwif;
-			else if (hwif->io_ports[IDE_DATA_OFFSET] == 0x170)
-				cmd_hwif1 = hwif;
-		}
-	}
-	cmd_drives[0] = &cmd_hwif0->drives[0];
-	cmd_drives[1] = &cmd_hwif0->drives[1];
-	cmd_drives[2] = &cmd_hwif1->drives[0];
-	cmd_drives[3] = &cmd_hwif1->drives[1];
-}
-
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-
-/*
- * Sets prefetch mode for a drive.
- */
-static void set_prefetch_mode (unsigned int index, int mode)
-{
-	ide_drive_t *drive = cmd_drives[index];
-	int reg = prefetch_regs[index];
-	u8 b;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	b = __get_cmd640_reg(reg);
-	if (mode) {	/* want prefetch on? */
-#if CMD640_PREFETCH_MASKS
-		drive->no_unmask = 1;
-		drive->unmask = 0;
-#endif
-		drive->no_io_32bit = 0;
-		b &= ~prefetch_masks[index];	/* enable prefetch */
-	} else {
-		drive->no_unmask = 0;
-		drive->no_io_32bit = 1;
-		drive->io_32bit = 0;
-		b |= prefetch_masks[index];	/* disable prefetch */
-	}
-	__put_cmd640_reg(reg, b);
-	spin_unlock_irqrestore(&ide_lock, flags);
-}
-
-/*
- * Dump out current drive clocks settings
- */
-static void display_clocks (unsigned int index)
-{
-	u8 active_count, recovery_count;
-
-	active_count = active_counts[index];
-	if (active_count == 1)
-		++active_count;
-	recovery_count = recovery_counts[index];
-	if (active_count > 3 && recovery_count == 1)
-		++recovery_count;
-	if (cmd640_chip_version > 1)
-		recovery_count += 1;  /* cmd640b uses (count + 1)*/
-	printk(", clocks=%d/%d/%d\n", setup_counts[index], active_count, recovery_count);
-}
-
-/*
- * Pack active and recovery counts into single byte representation
- * used by controller
- */
-inline static u8 pack_nibbles (u8 upper, u8 lower)
-{
-	return ((upper & 0x0f) << 4) | (lower & 0x0f);
-}
-
-/*
- * This routine retrieves the initial drive timings from the chipset.
- */
-static void __init retrieve_drive_counts (unsigned int index)
-{
-	u8 b;
-
-	/*
-	 * Get the internal setup timing, and convert to clock count
-	 */
-	b = get_cmd640_reg(arttim_regs[index]) & ~0x3f;
-	switch (b) {
-		case 0x00: b = 4; break;
-		case 0x80: b = 3; break;
-		case 0x40: b = 2; break;
-		default:   b = 5; break;
-	}
-	setup_counts[index] = b;
-
-	/*
-	 * Get the active/recovery counts
-	 */
-	b = get_cmd640_reg(drwtim_regs[index]);
-	active_counts[index]   = (b >> 4)   ? (b >> 4)   : 0x10;
-	recovery_counts[index] = (b & 0x0f) ? (b & 0x0f) : 0x10;
-}
-
-
-/*
- * This routine writes the prepared setup/active/recovery counts
- * for a drive into the cmd640 chipset registers to active them.
- */
-static void program_drive_counts (unsigned int index)
-{
-	unsigned long flags;
-	u8 setup_count    = setup_counts[index];
-	u8 active_count   = active_counts[index];
-	u8 recovery_count = recovery_counts[index];
-
-	/*
-	 * Set up address setup count and drive read/write timing registers.
-	 * Primary interface has individual count/timing registers for
-	 * each drive.  Secondary interface has one common set of registers,
-	 * so we merge the timings, using the slowest value for each timing.
-	 */
-	if (index > 1) {
-		unsigned int mate;
-		if (cmd_drives[mate = index ^ 1]->present) {
-			if (setup_count < setup_counts[mate])
-				setup_count = setup_counts[mate];
-			if (active_count < active_counts[mate])
-				active_count = active_counts[mate];
-			if (recovery_count < recovery_counts[mate])
-				recovery_count = recovery_counts[mate];
-		}
-	}
-
-	/*
-	 * Convert setup_count to internal chipset representation
-	 */
-	switch (setup_count) {
-		case 4:	 setup_count = 0x00; break;
-		case 3:	 setup_count = 0x80; break;
-		case 1:
-		case 2:	 setup_count = 0x40; break;
-		default: setup_count = 0xc0; /* case 5 */
-	}
-
-	/*
-	 * Now that everything is ready, program the new timings
-	 */
-	spin_lock_irqsave(&ide_lock, flags);
-	/*
-	 * Program the address_setup clocks into ARTTIM reg,
-	 * and then the active/recovery counts into the DRWTIM reg
-	 * (this converts counts of 16 into counts of zero -- okay).
-	 */
-	setup_count |= __get_cmd640_reg(arttim_regs[index]) & 0x3f;
-	__put_cmd640_reg(arttim_regs[index], setup_count);
-	__put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count, recovery_count));
-	spin_unlock_irqrestore(&ide_lock, flags);
-}
-
-/*
- * Set a specific pio_mode for a drive
- */
-static void cmd640_set_mode (unsigned int index, u8 pio_mode, unsigned int cycle_time)
-{
-	int setup_time, active_time, recovery_time, clock_time;
-	u8 setup_count, active_count, recovery_count, recovery_count2, cycle_count;
-	int bus_speed = system_bus_clock();
-
-	if (pio_mode > 5)
-		pio_mode = 5;
-	setup_time  = ide_pio_timings[pio_mode].setup_time;
-	active_time = ide_pio_timings[pio_mode].active_time;
-	recovery_time = cycle_time - (setup_time + active_time);
-	clock_time = 1000 / bus_speed;
-	cycle_count = (cycle_time + clock_time - 1) / clock_time;
-
-	setup_count = (setup_time + clock_time - 1) / clock_time;
-
-	active_count = (active_time + clock_time - 1) / clock_time;
-	if (active_count < 2)
-		active_count = 2; /* minimum allowed by cmd640 */
-
-	recovery_count = (recovery_time + clock_time - 1) / clock_time;
-	recovery_count2 = cycle_count - (setup_count + active_count);
-	if (recovery_count2 > recovery_count)
-		recovery_count = recovery_count2;
-	if (recovery_count < 2)
-		recovery_count = 2; /* minimum allowed by cmd640 */
-	if (recovery_count > 17) {
-		active_count += recovery_count - 17;
-		recovery_count = 17;
-	}
-	if (active_count > 16)
-		active_count = 16; /* maximum allowed by cmd640 */
-	if (cmd640_chip_version > 1)
-		recovery_count -= 1;  /* cmd640b uses (count + 1)*/
-	if (recovery_count > 16)
-		recovery_count = 16; /* maximum allowed by cmd640 */
-
-	setup_counts[index]    = setup_count;
-	active_counts[index]   = active_count;
-	recovery_counts[index] = recovery_count;
-
-	/*
-	 * In a perfect world, we might set the drive pio mode here
-	 * (using WIN_SETFEATURE) before continuing.
-	 *
-	 * But we do not, because:
-	 *	1) this is the wrong place to do it (proper is do_special() in ide.c)
-	 * 	2) in practice this is rarely, if ever, necessary
-	 */
-	program_drive_counts (index);
-}
-
-/*
- * Drive PIO mode selection:
- */
-static void cmd640_tune_drive (ide_drive_t *drive, u8 mode_wanted)
-{
-	u8 b;
-	ide_pio_data_t  d;
-	unsigned int index = 0;
-
-	while (drive != cmd_drives[index]) {
-		if (++index > 3) {
-			printk("%s: bad news in cmd640_tune_drive\n", drive->name);
-			return;
-		}
-	}
-	switch (mode_wanted) {
-		case 6: /* set fast-devsel off */
-		case 7: /* set fast-devsel on */
-			mode_wanted &= 1;
-			b = get_cmd640_reg(CNTRL) & ~0x27;
-			if (mode_wanted)
-				b |= 0x27;
-			put_cmd640_reg(CNTRL, b);
-			printk("%s: %sabled cmd640 fast host timing (devsel)\n", drive->name, mode_wanted ? "en" : "dis");
-			return;
-
-		case 8: /* set prefetch off */
-		case 9: /* set prefetch on */
-			mode_wanted &= 1;
-			set_prefetch_mode(index, mode_wanted);
-			printk("%s: %sabled cmd640 prefetch\n", drive->name, mode_wanted ? "en" : "dis");
-			return;
-	}
-
-	(void) ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
-	cmd640_set_mode (index, d.pio_mode, d.cycle_time);
-
-	printk ("%s: selected cmd640 PIO mode%d (%dns)%s",
-		drive->name,
-		d.pio_mode,
-		d.cycle_time,
-		d.overridden ? " (overriding vendor mode)" : "");
-	display_clocks(index);
-	return;
-}
-
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-
-static int pci_conf1(void)
-{
-	u32 tmp;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	outb(0x01, 0xCFB);
-	tmp = inl(0xCF8);
-	outl(0x80000000, 0xCF8);
-	if (inl(0xCF8) == 0x80000000) {
-		outl(tmp, 0xCF8);
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 1;
-	}
-	outl(tmp, 0xCF8);
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return 0;
-}
-
-static int pci_conf2(void)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&ide_lock, flags);
-	outb(0x00, 0xCFB);
-	outb(0x00, 0xCF8);
-	outb(0x00, 0xCFA);
-	if (inb(0xCF8) == 0x00 && inb(0xCF8) == 0x00) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return 1;
-	}
-	spin_unlock_irqrestore(&ide_lock, flags);
-	return 0;
-}
-
-/*
- * Probe for a cmd640 chipset, and initialize it if found.  Called from ide.c
- */
-int __init ide_probe_for_cmd640x (void)
-{
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-	int second_port_toggled = 0;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-	int second_port_cmd640 = 0;
-	const char *bus_type, *port2;
-	unsigned int index;
-	u8 b, cfr;
-
-	if (cmd640_vlb && probe_for_cmd640_vlb()) {
-		bus_type = "VLB";
-	} else {
-		cmd640_vlb = 0;
-		/* Find out what kind of PCI probing is supported otherwise
-		   Justin Gibbs will sulk.. */
-		if (pci_conf1() && probe_for_cmd640_pci1())
-			bus_type = "PCI (type1)";
-		else if (pci_conf2() && probe_for_cmd640_pci2())
-			bus_type = "PCI (type2)";
-		else
-			return 0;
-	}
-	/*
-	 * Undocumented magic (there is no 0x5b reg in specs)
-	 */
-	put_cmd640_reg(0x5b, 0xbd);
-	if (get_cmd640_reg(0x5b) != 0xbd) {
-		printk(KERN_ERR "ide: cmd640 init failed: wrong value in reg 0x5b\n");
-		return 0;
-	}
-	put_cmd640_reg(0x5b, 0);
-
-#ifdef CMD640_DUMP_REGS
-	CMD640_DUMP_REGS;
-#endif
-
-	/*
-	 * Documented magic begins here
-	 */
-	cfr = get_cmd640_reg(CFR);
-	cmd640_chip_version = cfr & CFR_DEVREV;
-	if (cmd640_chip_version == 0) {
-		printk ("ide: bad cmd640 revision: %d\n", cmd640_chip_version);
-		return 0;
-	}
-
-	/*
-	 * Initialize data for primary port
-	 */
-	setup_device_ptrs ();
-	printk("%s: buggy cmd640%c interface on %s, config=0x%02x\n",
-	       cmd_hwif0->name, 'a' + cmd640_chip_version - 1, bus_type, cfr);
-	cmd_hwif0->chipset = ide_cmd640;
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-	cmd_hwif0->tuneproc = &cmd640_tune_drive;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-
-	/*
-	 * Ensure compatibility by always using the slowest timings
-	 * for access to the drive's command register block,
-	 * and reset the prefetch burstsize to default (512 bytes).
-	 *
-	 * Maybe we need a way to NOT do these on *some* systems?
-	 */
-	put_cmd640_reg(CMDTIM, 0);
-	put_cmd640_reg(BRST, 0x40);
-
-	/*
-	 * Try to enable the secondary interface, if not already enabled
-	 */
-	if (cmd_hwif1->noprobe) {
-		port2 = "not probed";
-	} else {
-		b = get_cmd640_reg(CNTRL);
-		if (secondary_port_responding()) {
-			if ((b & CNTRL_ENA_2ND)) {
-				second_port_cmd640 = 1;
-				port2 = "okay";
-			} else if (cmd640_vlb) {
-				second_port_cmd640 = 1;
-				port2 = "alive";
-			} else
-				port2 = "not cmd640";
-		} else {
-			put_cmd640_reg(CNTRL, b ^ CNTRL_ENA_2ND); /* toggle the bit */
-			if (secondary_port_responding()) {
-				second_port_cmd640 = 1;
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-				second_port_toggled = 1;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-				port2 = "enabled";
-			} else {
-				put_cmd640_reg(CNTRL, b); /* restore original setting */
-				port2 = "not responding";
-			}
-		}
-	}
-
-	/*
-	 * Initialize data for secondary cmd640 port, if enabled
-	 */
-	if (second_port_cmd640) {
-		cmd_hwif0->serialized = 1;
-		cmd_hwif1->serialized = 1;
-		cmd_hwif1->chipset = ide_cmd640;
-		cmd_hwif0->mate = cmd_hwif1;
-		cmd_hwif1->mate = cmd_hwif0;
-		cmd_hwif1->channel = 1;
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-		cmd_hwif1->tuneproc = &cmd640_tune_drive;
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-	}
-	printk(KERN_INFO "%s: %sserialized, secondary interface %s\n", cmd_hwif1->name,
-		cmd_hwif0->serialized ? "" : "not ", port2);
-
-	/*
-	 * Establish initial timings/prefetch for all drives.
-	 * Do not unnecessarily disturb any prior BIOS setup of these.
-	 */
-	for (index = 0; index < (2 + (second_port_cmd640 << 1)); index++) {
-		ide_drive_t *drive = cmd_drives[index];
-#ifdef CONFIG_BLK_DEV_CMD640_ENHANCED
-		if (drive->autotune || ((index > 1) && second_port_toggled)) {
-	 		/*
-	 		 * Reset timing to the slowest speed and turn off prefetch.
-			 * This way, the drive identify code has a better chance.
-			 */
-			setup_counts    [index] = 4;	/* max possible */
-			active_counts   [index] = 16;	/* max possible */
-			recovery_counts [index] = 16;	/* max possible */
-			program_drive_counts (index);
-			set_prefetch_mode (index, 0);
-			printk("cmd640: drive%d timings/prefetch cleared\n", index);
-		} else {
-			/*
-			 * Record timings/prefetch without changing them.
-			 * This preserves any prior BIOS setup.
-			 */
-			retrieve_drive_counts (index);
-			check_prefetch (index);
-			printk("cmd640: drive%d timings/prefetch(%s) preserved",
-				index, drive->no_io_32bit ? "off" : "on");
-			display_clocks(index);
-		}
-#else
-		/*
-		 * Set the drive unmask flags to match the prefetch setting
-		 */
-		check_prefetch (index);
-		printk("cmd640: drive%d timings/prefetch(%s) preserved\n",
-			index, drive->no_io_32bit ? "off" : "on");
-#endif /* CONFIG_BLK_DEV_CMD640_ENHANCED */
-	}
-
-#ifdef CMD640_DUMP_REGS
-	CMD640_DUMP_REGS;
-#endif
-	return 1;
-}
-
diff -urN a/drivers/ide/pci/cmd640.h b/drivers/ide/pci/cmd640.h
--- a/drivers/ide/pci/cmd640.h	2003-05-11 15:50:07.000000000 +0200
+++ b/drivers/ide/pci/cmd640.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,32 +0,0 @@
-#ifndef CMD640_H
-#define CMD640_H
-
-#include <linux/config.h>
-#include <linux/pci.h>
-#include <linux/ide.h>
-
-#define IDE_IGNORE      ((void *)-1)
-
-static ide_pci_device_t cmd640_chipsets[] __initdata = {
-	{
-		.vendor		= PCI_VENDOR_ID_CMD,
-		.device		= PCI_DEVICE_ID_CMD_640,
-		.name		= "CMD640",
-		.init_setup	= NULL,
-		.init_chipset	= NULL,
-		.init_iops	= NULL,
-		.init_hwif	= IDE_IGNORE,
-		.init_dma	= NULL,
-		.channels	= 2,
-		.autodma	= NODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x00,0x00,0x00}},
-		.bootable	= ON_BOARD,
-		.extra		= 0
-	},{
-		.vendor		= 0,
-		.device		= 0,
-		.bootable	= EOL,
-	}
-}
-
-#endif /* CMD640_H */
