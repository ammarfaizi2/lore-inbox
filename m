Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265293AbUAFCs7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 21:48:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265299AbUAFCs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 21:48:59 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:62925 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S265293AbUAFCst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 21:48:49 -0500
Date: Tue, 6 Jan 2004 13:51:55 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules
 (linux 2.6.0)
Message-Id: <20040106135155.66535c13.davmac@ozonline.com.au>
In-Reply-To: <200401051516.03364.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401041547.52615.bzolnier@elka.pw.edu.pl>
	<20040105130939.3cca1648.davmac@ozonline.com.au>
	<200401051516.03364.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok - fourth try! Hopefully I'm getting better.

On Mon, 5 Jan 2004 15:16:03 +0100
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> You don't need to export "initializing" variable from ide.c,
> just use "pre_init" variable from setup-pci.c :-).
> 

Yes - of course.

But actually I have found an even better solution - "hwif->present" tells us if the hwif is currently being controlled by some chipset driver (that's what it's there for!) so I check that instead.

> > Plus, everything works as before - including "idex=..." parameters.
> 
> Except when using them for IDE PCI modules with non default ports:
> - hwif->chipset is set to ide_generic during boot
> - main IDE driver initialization
> - module load fails (because hwif->chipset == ide_generic && !initializing)
> 
> You can fix it by replacing all current occurrences of ide_generic by some
> new type (ide_forced).  It will also clear confusion about ide_generic name.

I've changed all occurrences of "ide_generic" to "ide_forced" and removed "ide_generic" altogether.

Now, "ide_forced" means what it should. The chipset is changed to "ide_unknown" or "ide_pci" when some chipset driver takes over (be it the standard ide, or some PCI specific). So no hwif which is actually present will be left as "ide_forced".

Also I have slightly modified match_hwif to check hwif->present when it is trying to find a free entry (otherwise, there is a chance that it will return one that cannot be used, even when there is a truly free one available).

This doesn't *exactly* match what you said, but it seems to me to be very clean and solve all the issues at once. If you can see any problems let me know and I will revert it to the previous way (with your improvements incorporated).

regards
Davin


diff -urN linux-2.6.0-vanilla/drivers/ide/ide-probe.c linux-2.6.0/drivers/ide/ide-probe.c
--- linux-2.6.0-vanilla/drivers/ide/ide-probe.c	Thu Nov 27 07:44:24 2003
+++ linux-2.6.0/drivers/ide/ide-probe.c	Tue Jan  6 12:54:50 2004
@@ -1343,6 +1343,8 @@
 			int unit;
 			if (!hwif->present)
 				continue;
+			if (hwif->chipset == ide_forced)
+				hwif->chipset = ide_unknown;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
 				if (hwif->drives[unit].present)
 					ata_attach(&hwif->drives[unit]);
diff -urN linux-2.6.0-vanilla/drivers/ide/ide-proc.c linux-2.6.0/drivers/ide/ide-proc.c
--- linux-2.6.0-vanilla/drivers/ide/ide-proc.c	Thu Nov 27 07:44:17 2003
+++ linux-2.6.0/drivers/ide/ide-proc.c	Tue Jan  6 12:40:58 2004
@@ -348,9 +348,13 @@
 	int		len;
 	const char	*name;
 
+	/*
+	 * Note: Don't need to handle "ide_forced" as that should never be set at
+	 * this stage.
+	 */
+	
 	switch (hwif->chipset) {
 		case ide_unknown:	name = "(none)";	break;
-		case ide_generic:	name = "generic";	break;
 		case ide_pci:		name = "pci";		break;
 		case ide_cmd640:	name = "cmd640";	break;
 		case ide_dtc2278:	name = "dtc2278";	break;
diff -urN linux-2.6.0-vanilla/drivers/ide/ide.c linux-2.6.0/drivers/ide/ide.c
--- linux-2.6.0-vanilla/drivers/ide/ide.c	Thu Nov 27 07:43:29 2003
+++ linux-2.6.0/drivers/ide/ide.c	Tue Jan  6 12:41:19 2004
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
+++ linux-2.6.0/drivers/ide/pci/cmd640.c	Tue Jan  6 12:42:20 2004
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
+++ linux-2.6.0/drivers/ide/setup-pci.c	Tue Jan  6 13:44:45 2004
@@ -59,7 +59,7 @@
 	for (h = 0; h < MAX_HWIFS; ++h) {
 		hwif = &ide_hwifs[h];
 		if (hwif->io_ports[IDE_DATA_OFFSET] == io_base) {
-			if (hwif->chipset == ide_generic)
+			if (hwif->chipset == ide_forced)
 				return hwif; /* a perfect match */
 		}
 	}
@@ -91,19 +91,19 @@
 	if (bootable) {
 		for (h = 0; h < MAX_HWIFS; ++h) {
 			hwif = &ide_hwifs[h];
-			if (hwif->chipset == ide_unknown)
+			if (hwif->chipset == ide_unknown && !hwif->present)
 				return hwif;	/* pick an unused entry */
 		}
 	} else {
 		for (h = 2; h < MAX_HWIFS; ++h) {
 			hwif = ide_hwifs + h;
-			if (hwif->chipset == ide_unknown)
+			if (hwif->chipset == ide_unknown && !hwif->present)
 				return hwif;	/* pick an unused entry */
 		}
 	}
 	for (h = 0; h < 2; ++h) {
 		hwif = ide_hwifs + h;
-		if (hwif->chipset == ide_unknown)
+		if (hwif->chipset == ide_unknown && !hwif->present)
 			return hwif;	/* pick an unused entry */
 	}
 	printk(KERN_ERR "%s: too many IDE interfaces, no room in table\n", name);
@@ -441,6 +441,8 @@
 	}
 	if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL)
 		return NULL;	/* no room in ide_hwifs[] */
+	if (hwif->present)
+		return NULL;
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
 fixup_address:
 		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
diff -urN linux-2.6.0-vanilla/include/linux/ide.h linux-2.6.0/include/linux/ide.h
--- linux-2.6.0-vanilla/include/linux/ide.h	Thu Nov 27 07:43:36 2003
+++ linux-2.6.0/include/linux/ide.h	Tue Jan  6 12:36:46 2004
@@ -276,7 +276,7 @@
  * hwif_chipset_t is used to keep track of the specific hardware
  * chipset used by each IDE interface, if known.
  */
-typedef enum {	ide_unknown,	ide_generic,	ide_pci,
+typedef enum {	ide_unknown,	ide_forced,	ide_pci,
 		ide_cmd640,	ide_dtc2278,	ide_ali14xx,
 		ide_qd65xx,	ide_umc8672,	ide_ht6560b,
 		ide_pdc4030,	ide_rz1000,	ide_trm290,

