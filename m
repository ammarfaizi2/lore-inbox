Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUAECGq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 21:06:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265845AbUAECGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 21:06:46 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:19887 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S265843AbUAECGh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 21:06:37 -0500
Date: Mon, 5 Jan 2004 13:09:39 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: Re: [PATCH] fix issues with loading PCI ide drivers as modules
 (linux 2.6.0)
Message-Id: <20040105130939.3cca1648.davmac@ozonline.com.au>
In-Reply-To: <200401041547.52615.bzolnier@elka.pw.edu.pl>
References: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
	<200401040452.17659.bzolnier@elka.pw.edu.pl>
	<20040104173129.60cde487.davmac@ozonline.com.au>
	<200401041547.52615.bzolnier@elka.pw.edu.pl>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jan 2004 15:47:52 +0100
Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl> wrote:

> Please explain me why to change current behavior.  "takeover" still want be
> possible, so it will be only cosmetic change which complicates code.
> 
> --bart
> 

Alright - I have a PIIX4 chipset in my system. when I compile the PIIX4 ide driver as a module (ie. "piix.ko") and load it after booting the system I get kernel messages because
1) it can't allocate the I/O ports for the ide interfaces, io 0x170-0x177  0x1F0-0x1F7 etc
   because they have been allocated by the non-PCI driver (ide.c)
2) it can't register block devices; they've already been allocated

Looking at the code it is clear that when I get these messages, the hwif will then be marked "not present" (ie. hwif->present = 0) and the drives (hda, hdb and hdc in my case) will also be marked not present.

The "hwif" structures corresponding to ide0/ide1 have been trashed - even though the piix module shouldn't have been granted control of the interfaces. The reason is that "ide_hwif_configure()" (setup-pci.c) calls "ide_match_hwif" which returns whatever hwif structure matches the io-base address (which the chipset is "ide_unknown" or "ide_generic"), and then, ide_hwif_configure() USES that hwif and for instance sets its chipset to "ide_pci" and returns it to the caller (ide_pci_setup_ports) which continues to trash it, tries to allocate the base and ctl ports (which fails) and register the block devices (which fails).

You can verify that the hwif has been modified by "cat /proc/ide/ide0/model" before and after inserting the piix module - before, i get "unknown", afterwards i get "pci".

Sure, the current code doesn't cause a crash - but it's very, very ugly. It generates some confusing error messages, and it makes it look like the module has taken control of the IDE interfaces but really the drives haven't been re-probed etc.

Is this not worth fixing?

> 
> Ehh, more hwif->chipset crap.
> 

Alright, this newer patch below mostly avoids the "hwif->chipset crap" (it doesn't introduce any new chipset types). But it has to export the "initializing" variable from ide.c (I changed its name to "ide_initializing").

Plus, everything works as before - including "idex=..." parameters.

Davin.




diff -urN linux-2.6.0-vanilla/drivers/ide/ide-probe.c linux-2.6.0/drivers/ide/ide-probe.c
--- linux-2.6.0-vanilla/drivers/ide/ide-probe.c	Thu Nov 27 07:44:24 2003
+++ linux-2.6.0/drivers/ide/ide-probe.c	Sun Jan  4 14:46:04 2004
@@ -1343,6 +1343,7 @@
 			int unit;
 			if (!hwif->present)
 				continue;
+			if (hwif->chipset == ide_unknown) hwif->chipset = ide_generic;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
 				if (hwif->drives[unit].present)
 					ata_attach(&hwif->drives[unit]);
diff -urN linux-2.6.0-vanilla/drivers/ide/ide.c linux-2.6.0/drivers/ide/ide.c
--- linux-2.6.0-vanilla/drivers/ide/ide.c	Thu Nov 27 07:43:29 2003
+++ linux-2.6.0/drivers/ide/ide.c	Sun Jan  4 19:36:42 2004
@@ -173,7 +173,9 @@
 
 static int idebus_parameter;	/* holds the "idebus=" parameter */
 static int system_bus_speed;	/* holds what we think is VESA/PCI bus speed */
-static int initializing;	/* set while initializing built-in drivers */
+
+int ide_initializing;		/* set while initializing built-in drivers */
+EXPORT_SYMBOL(ide_initializing);
 
 DECLARE_MUTEX(ide_cfg_sem);
 spinlock_t ide_lock __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
@@ -1011,8 +1013,8 @@
 			hwif = &ide_hwifs[index];
 			if (hwif->hold)
 				continue;
-			if ((!hwif->present && !hwif->mate && !initializing) ||
-			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && initializing))
+			if ((!hwif->present && !hwif->mate && !ide_initializing) ||
+			    (!hwif->hw.io_ports[IDE_DATA_OFFSET] && ide_initializing))
 				goto found;
 		}
 		for (index = 0; index < MAX_HWIFS; index++)
@@ -1032,7 +1034,7 @@
 	hwif->noprobe = 0;
 	hwif->chipset = hw->chipset;
 
-	if (!initializing) {
+	if (!ide_initializing) {
 		ide_probe_module();
 #ifdef CONFIG_PROC_FS
 		create_proc_ide_interfaces();
@@ -1042,7 +1044,7 @@
 	if (hwifp)
 		*hwifp = hwif;
 
-	return (initializing || hwif->present) ? index : -1;
+	return (ide_initializing || hwif->present) ? index : -1;
 }
 
 EXPORT_SYMBOL(ide_register_hw);
@@ -2606,9 +2608,9 @@
 		(void)qd65xx_init();
 #endif
 
-	initializing = 1;
+	ide_initializing = 1;
 	ide_init_builtin_drivers();
-	initializing = 0;
+	ide_initializing = 0;
 
 	return 0;
 }
diff -urN linux-2.6.0-vanilla/drivers/ide/setup-pci.c linux-2.6.0/drivers/ide/setup-pci.c
--- linux-2.6.0-vanilla/drivers/ide/setup-pci.c	Thu Nov 27 07:43:39 2003
+++ linux-2.6.0/drivers/ide/setup-pci.c	Sun Jan  4 19:41:09 2004
@@ -441,6 +441,9 @@
 	}
 	if ((hwif = ide_match_hwif(base, d->bootable, d->name)) == NULL)
 		return NULL;	/* no room in ide_hwifs[] */
+	if (hwif->chipset == ide_generic && ! ide_initializing )
+		return NULL;  /* clash with already allocated hwif */
+
 	if (hwif->io_ports[IDE_DATA_OFFSET] != base) {
 fixup_address:
 		ide_init_hwif_ports(&hwif->hw, base, (ctl | 2), NULL);
diff -urN linux-2.6.0-vanilla/include/linux/ide.h linux-2.6.0/include/linux/ide.h
--- linux-2.6.0-vanilla/include/linux/ide.h	Thu Nov 27 07:43:36 2003
+++ linux-2.6.0/include/linux/ide.h	Sun Jan  4 19:40:28 2004
@@ -1246,6 +1246,8 @@
 extern ide_devices_t   *idetape;
 extern ide_devices_t   *idescsi;
 
+extern int ide_initializing;
+
 #endif
 extern int noautodma;
 






