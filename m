Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266428AbUA3DXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 22:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266417AbUA3DXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 22:23:24 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:58822 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S266416AbUA3DXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 22:23:15 -0500
Date: Fri, 30 Jan 2004 14:27:25 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       davmac@ozonline.com.au
Subject: [PATCH] various IDE patches/cleanups
Message-Id: <20040130142725.1a408f9e.davmac@ozonline.com.au>
In-Reply-To: <200401061213.39843.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401051516.03364.bzolnier@elka.pw.edu.pl>
	<20040106135155.66535c13.davmac@ozonline.com.au>
	<200401061213.39843.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been doing some hacking on the IDE layer, just to fix a few issues I noticed going through the code. Due to the complex nature of the code I'm bound to have missed some things and perhaps misunderstood others. Nevertheless I'm posting these patches in the hope that they can be tested on other machines, rejected, or even accepted.

Comments and criticisms are welcome.

The first patch, below, is already included in the -mm tree. The further patches are appearing here for the first time.

All patches are against linux-2.6.0 but apply correctly against 2.6.2-rc2.

Davin

---
First patch: issues loading pci chipset drivers as modules. (don't let the module trash data structures used by current interfaces)


diff -urN linux-2.6.0-vanilla/drivers/ide/ide-probe.c linux-2.6.0/drivers/ide/ide-probe.c
--- linux-2.6.0-vanilla/drivers/ide/ide-probe.c	Thu Nov 27 07:44:24 2003
+++ linux-2.6.0/drivers/ide/ide-probe.c	Tue Jan  6 23:13:28 2004
@@ -1343,6 +1343,8 @@
 			int unit;
 			if (!hwif->present)
 				continue;
+			if (hwif->chipset == ide_unknown || hwif->chipset == ide_forced)
+				hwif->chipset = ide_generic;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
 				if (hwif->drives[unit].present)
 					ata_attach(&hwif->drives[unit]);
diff -urN linux-2.6.0-vanilla/drivers/ide/ide-proc.c linux-2.6.0/drivers/ide/ide-proc.c
--- linux-2.6.0-vanilla/drivers/ide/ide-proc.c	Thu Nov 27 07:44:17 2003
+++ linux-2.6.0/drivers/ide/ide-proc.c	Tue Jan  6 23:07:52 2004
@@ -348,8 +348,11 @@
 	int		len;
 	const char	*name;
 
+	/*
+	 *  Neither ide_unknown nor ide_forced should be set at this point.
+	 */
+	
 	switch (hwif->chipset) {
-		case ide_unknown:	name = "(none)";	break;
 		case ide_generic:	name = "generic";	break;
 		case ide_pci:		name = "pci";		break;
 		case ide_cmd640:	name = "cmd640";	break;
diff -urN linux-2.6.0-vanilla/drivers/ide/ide.c linux-2.6.0/drivers/ide/ide.c
--- linux-2.6.0-vanilla/drivers/ide/ide.c	Thu Nov 27 07:43:29 2003
+++ linux-2.6.0/drivers/ide/ide.c	Tue Jan  6 23:08:17 2004
@@ -2185,7 +2185,7 @@
 				memcpy(hwif->io_ports, hwif->hw.io_ports, sizeof(hwif->io_ports));
 				hwif->irq      = vals[2];
 				hwif->noprobe  = 0;
-				hwif->chipset  = ide_generic;
+				hwif->chipset  = ide_forced;
 				goto done;
 
 			case 0: goto bad_option;
diff -urN linux-2.6.0-vanilla/drivers/ide/pci/cmd640.c linux-2.6.0/drivers/ide/pci/cmd640.c
--- linux-2.6.0-vanilla/drivers/ide/pci/cmd640.c	Thu Nov 27 07:45:36 2003
+++ linux-2.6.0/drivers/ide/pci/cmd640.c	Tue Jan  6 13:07:51 2004
@@ -419,7 +419,7 @@
 	cmd_hwif1 = &ide_hwifs[1]; /* default, if not found below */
 	for (i = 0; i < MAX_HWIFS; i++) {
 		ide_hwif_t *hwif = &ide_hwifs[i];
-		if (hwif->chipset == ide_unknown || hwif->chipset == ide_generic) {
+		if (hwif->chipset == ide_unknown || hwif->chipset == ide_forced) {
 			if (hwif->io_ports[IDE_DATA_OFFSET] == 0x1f0)
 				cmd_hwif0 = hwif;
 			else if (hwif->io_ports[IDE_DATA_OFFSET] == 0x170)
diff -urN linux-2.6.0-vanilla/drivers/ide/setup-pci.c linux-2.6.0/drivers/ide/setup-pci.c
--- linux-2.6.0-vanilla/drivers/ide/setup-pci.c	Thu Nov 27 07:43:39 2003
+++ linux-2.6.0/drivers/ide/setup-pci.c	Tue Jan  6 23:18:50 2004
@@ -59,7 +59,7 @@
 	for (h = 0; h < MAX_HWIFS; ++h) {
 		hwif = &ide_hwifs[h];
 		if (hwif->io_ports[IDE_DATA_OFFSET] == io_base) {
-			if (hwif->chipset == ide_generic)
+			if (hwif->chipset == ide_forced)
 				return hwif; /* a perfect match */
 		}
 	}
diff -urN linux-2.6.0-vanilla/include/linux/ide.h linux-2.6.0/include/linux/ide.h
--- linux-2.6.0-vanilla/include/linux/ide.h	Thu Nov 27 07:43:36 2003
+++ linux-2.6.0/include/linux/ide.h	Tue Jan  6 23:06:23 2004
@@ -282,7 +282,7 @@
 		ide_pdc4030,	ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
-		ide_pc9800
+		ide_pc9800, ide_forced
 } hwif_chipset_t;
 
 /*
