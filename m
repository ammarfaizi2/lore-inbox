Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751132AbVI1W3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751132AbVI1W3f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 18:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751133AbVI1W3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 18:29:35 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:58919 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751132AbVI1W3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 18:29:34 -0400
Message-ID: <433B16BD.7040409@gentoo.org>
Date: Wed, 28 Sep 2005 23:18:37 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050820)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
CC: jgarzik@pobox.com, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       posting@blx4.net, vsu@altlinux.ru
Subject: [PATCH] via82cxxx IDE: Remove /proc/via entry
References: <43146CC3.4010005@gentoo.org>	 <58cb370e05083008121f2eb783@mail.gmail.com>	 <43179CC9.8090608@gentoo.org> <58cb370e050927062049be32f8@mail.gmail.com>
In-Reply-To: <58cb370e050927062049be32f8@mail.gmail.com>
Content-Type: multipart/mixed;
 boundary="------------000603010807050005070305"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000603010807050005070305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

This entry adds needless complication to the driver as it requires the use of
global variables to be passed into via_get_info(), making things quite ugly
when we try and make this driver support multiple controllers simultaneously.

This patch removes /proc/via for simplicity.

Signed-off-by: Daniel Drake <dsd@gentoo.org>


--------------000603010807050005070305
Content-Type: text/x-patch;
 name="via82cxxx-no-proc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="via82cxxx-no-proc.patch"

--- linux-2.6.14-rc1/drivers/ide/pci/via82cxxx.c.orig	2005-09-28 22:19:00.000000000 +0100
+++ linux-2.6.14-rc1/drivers/ide/pci/via82cxxx.c	2005-09-28 22:20:46.000000000 +0100
@@ -105,181 +105,6 @@ static unsigned int via_80w;
 static unsigned int via_clock;
 static char *via_dma[] = { "MWDMA16", "UDMA33", "UDMA66", "UDMA100", "UDMA133" };
 
-/*
- * VIA /proc entry.
- */
-
-#if defined(DISPLAY_VIA_TIMINGS) && defined(CONFIG_PROC_FS)
-
-#include <linux/stat.h>
-#include <linux/proc_fs.h>
-
-static u8 via_proc = 0;
-static unsigned long via_base;
-static struct pci_dev *bmide_dev, *isa_dev;
-
-static char *via_control3[] = { "No limit", "64", "128", "192" };
-
-#define via_print(format, arg...) p += sprintf(p, format "\n" , ## arg)
-#define via_print_drive(name, format, arg...)\
-	p += sprintf(p, name); for (i = 0; i < 4; i++) p += sprintf(p, format, ## arg); p += sprintf(p, "\n");
-
-
-/**
- *	via_get_info		-	generate via /proc file 
- *	@buffer: buffer for data
- *	@addr: set to start of data to use
- *	@offset: current file offset
- *	@count: size of read
- *
- *	Fills in buffer with the debugging/configuration information for
- *	the VIA chipset tuning and attached drives
- */
- 
-static int via_get_info(char *buffer, char **addr, off_t offset, int count)
-{
-	int speed[4], cycle[4], setup[4], active[4], recover[4], den[4],
-		 uen[4], udma[4], umul[4], active8b[4], recover8b[4];
-	struct pci_dev *dev = bmide_dev;
-	unsigned int v, u, i;
-	int len;
-	u16 c, w;
-	u8 t, x;
-	char *p = buffer;
-
-	via_print("----------VIA BusMastering IDE Configuration"
-		"----------------");
-
-	via_print("Driver Version:                     3.38");
-	via_print("South Bridge:                       VIA %s",
-		via_config->name);
-
-	pci_read_config_byte(isa_dev, PCI_REVISION_ID, &t);
-	pci_read_config_byte(dev, PCI_REVISION_ID, &x);
-	via_print("Revision:                           ISA %#x IDE %#x", t, x);
-	via_print("Highest DMA rate:                   %s",
-		via_dma[via_config->flags & VIA_UDMA]);
-
-	via_print("BM-DMA base:                        %#lx", via_base);
-	via_print("PCI clock:                          %d.%dMHz",
-		via_clock / 1000, via_clock / 100 % 10);
-
-	pci_read_config_byte(dev, VIA_MISC_1, &t);
-	via_print("Master Read  Cycle IRDY:            %dws",
-		(t & 64) >> 6);
-	via_print("Master Write Cycle IRDY:            %dws",
-		(t & 32) >> 5);
-	via_print("BM IDE Status Register Read Retry:  %s",
-		(t & 8) ? "yes" : "no");
-
-	pci_read_config_byte(dev, VIA_MISC_3, &t);
-	via_print("Max DRDY Pulse Width:               %s%s",
-		via_control3[(t & 0x03)], (t & 0x03) ? " PCI clocks" : "");
-
-	via_print("-----------------------Primary IDE"
-		"-------Secondary IDE------");
-	via_print("Read DMA FIFO flush:   %10s%20s",
-		(t & 0x80) ? "yes" : "no", (t & 0x40) ? "yes" : "no");
-	via_print("End Sector FIFO flush: %10s%20s",
-		(t & 0x20) ? "yes" : "no", (t & 0x10) ? "yes" : "no");
-
-	pci_read_config_byte(dev, VIA_IDE_CONFIG, &t);
-	via_print("Prefetch Buffer:       %10s%20s",
-		(t & 0x80) ? "yes" : "no", (t & 0x20) ? "yes" : "no");
-	via_print("Post Write Buffer:     %10s%20s",
-		(t & 0x40) ? "yes" : "no", (t & 0x10) ? "yes" : "no");
-
-	pci_read_config_byte(dev, VIA_IDE_ENABLE, &t);
-	via_print("Enabled:               %10s%20s",
-		(t & 0x02) ? "yes" : "no", (t & 0x01) ? "yes" : "no");
-
-	c = inb(via_base + 0x02) | (inb(via_base + 0x0a) << 8);
-	via_print("Simplex only:          %10s%20s",
-		(c & 0x80) ? "yes" : "no", (c & 0x8000) ? "yes" : "no");
-
-	via_print("Cable Type:            %10s%20s",
-		(via_80w & 1) ? "80w" : "40w", (via_80w & 2) ? "80w" : "40w");
-
-	via_print("-------------------drive0----drive1"
-		"----drive2----drive3-----");
-
-	pci_read_config_byte(dev, VIA_ADDRESS_SETUP, &t);
-	pci_read_config_dword(dev, VIA_DRIVE_TIMING, &v);
-	pci_read_config_word(dev, VIA_8BIT_TIMING, &w);
-
-	if (via_config->flags & VIA_UDMA)
-		pci_read_config_dword(dev, VIA_UDMA_TIMING, &u);
-	else u = 0;
-
-	for (i = 0; i < 4; i++) {
-
-		setup[i]     = ((t >> ((3 - i) << 1)) & 0x3) + 1;
-		recover8b[i] = ((w >> ((1 - (i >> 1)) << 3)) & 0xf) + 1;
-		active8b[i]  = ((w >> (((1 - (i >> 1)) << 3) + 4)) & 0xf) + 1;
-		active[i]    = ((v >> (((3 - i) << 3) + 4)) & 0xf) + 1;
-		recover[i]   = ((v >> ((3 - i) << 3)) & 0xf) + 1;
-		udma[i]      = ((u >> ((3 - i) << 3)) & 0x7) + 2;
-		umul[i]      = ((u >> (((3 - i) & 2) << 3)) & 0x8) ? 1 : 2;
-		uen[i]       = ((u >> ((3 - i) << 3)) & 0x20);
-		den[i]       = (c & ((i & 1) ? 0x40 : 0x20) << ((i & 2) << 2));
-
-		speed[i] = 2 * via_clock / (active[i] + recover[i]);
-		cycle[i] = 1000000 * (active[i] + recover[i]) / via_clock;
-
-		if (!uen[i] || !den[i])
-			continue;
-
-		switch (via_config->flags & VIA_UDMA) {
-
-			case VIA_UDMA_33:
-				speed[i] = 2 * via_clock / udma[i];
-				cycle[i] = 1000000 * udma[i] / via_clock;
-				break;
-
-			case VIA_UDMA_66:
-				speed[i] = 4 * via_clock / (udma[i] * umul[i]);
-				cycle[i] = 500000 * (udma[i] * umul[i]) / via_clock;
-				break;
-
-			case VIA_UDMA_100:
-				speed[i] = 6 * via_clock / udma[i];
-				cycle[i] = 333333 * udma[i] / via_clock;
-				break;
-
-			case VIA_UDMA_133:
-				speed[i] = 8 * via_clock / udma[i];
-				cycle[i] = 250000 * udma[i] / via_clock;
-				break;
-		}
-	}
-
-	via_print_drive("Transfer Mode: ", "%10s",
-		den[i] ? (uen[i] ? "UDMA" : "DMA") : "PIO");
-
-	via_print_drive("Address Setup: ", "%8dns",
-		1000000 * setup[i] / via_clock);
-	via_print_drive("Cmd Active:    ", "%8dns",
-		1000000 * active8b[i] / via_clock);
-	via_print_drive("Cmd Recovery:  ", "%8dns",
-		1000000 * recover8b[i] / via_clock);
-	via_print_drive("Data Active:   ", "%8dns",
-		1000000 * active[i] / via_clock);
-	via_print_drive("Data Recovery: ", "%8dns",
-		1000000 * recover[i] / via_clock);
-	via_print_drive("Cycle Time:    ", "%8dns",
-		cycle[i]);
-	via_print_drive("Transfer Rate: ", "%4d.%dMB/s",
-		speed[i] / 1000, speed[i] / 100 % 10);
-
-	/* hoping it is less than 4K... */
-	len = (p - buffer) - offset;
-	*addr = buffer + offset;
-
-	return len > count ? count : len;
-}
-
-#endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */
-
 /**
  *	via_set_speed			-	write timing registers
  *	@dev: PCI device
@@ -560,19 +385,6 @@ static unsigned int __devinit init_chips
 		via_dma[via_config->flags & VIA_UDMA],
 		pci_name(dev));
 
-	/*
-	 * Setup /proc/ide/via entry.
-	 */
-
-#if defined(DISPLAY_VIA_TIMINGS) && defined(CONFIG_PROC_FS)
-	if (!via_proc) {
-		via_base = pci_resource_start(dev, 4);
-		bmide_dev = dev;
-		isa_dev = isa;
-		ide_pci_create_host_proc("via", via_get_info);
-		via_proc = 1;
-	}
-#endif /* DISPLAY_VIA_TIMINGS && CONFIG_PROC_FS */
 	return 0;
 }
 

--------------000603010807050005070305--
