Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265911AbUACEZB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 23:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbUACEZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 23:25:01 -0500
Received: from esperance.ozonline.com.au ([203.23.159.248]:14242 "EHLO
	ozonline.com.au") by vger.kernel.org with ESMTP id S262652AbUACEYy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 23:24:54 -0500
Date: Sat, 3 Jan 2004 15:28:02 +1100
From: Davin McCall <davmac@ozonline.com.au>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: [PATCH] fix issues with loading PCI ide drivers as modules (linux
 2.6.0)
Message-Id: <20040103152802.6e27f5c5.davmac@ozonline.com.au>
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When loading the piix.ko module (generic IDE support is compiled in) I get error messages- the ports are already in use, the block devices are already registered.

The problems seem to be:

1) the hwif structures aren't getting marked as being used if the generic IDE layer is controlling them (->chipset is left as "ide_unknown" instead of "ide_generic")

2) if the pci module is granted control of an already initialized hwif, the drive probing etc. (including I/O port allocation) is re-run. When it fails, the drives are marked as not-present which doesn't appear to cause any problems but seems dangerous.

Patch below fixes this and allows a chipset-specific module to take over the primary IDE interface correctly. Comments welcome.

Davin



diff -urN linux-2.6.0/drivers/ide/ide-probe.c linux-2.6.0-mine/drivers/ide/ide-probe.c
--- linux-2.6.0/drivers/ide/ide-probe.c	Thu Nov 27 07:44:24 2003
+++ linux-2.6.0-mine/drivers/ide/ide-probe.c	Sat Jan  3 13:08:22 2004
@@ -864,6 +864,12 @@
 int hwif_init (ide_hwif_t *hwif);
 int probe_hwif_init (ide_hwif_t *hwif)
 {
+	if( hwif->chipset == ide_pci_takeover )
+	{
+		hwif->chipset = ide_pci;
+		return 0;
+	}
+	
 	hwif->initializing = 1;
 	probe_hwif(hwif);
 	hwif_init(hwif);
@@ -1343,6 +1349,8 @@
 			int unit;
 			if (!hwif->present)
 				continue;
+			
+			if( hwif->chipset == ide_unknown ) hwif->chipset = ide_generic;
 			for (unit = 0; unit < MAX_DRIVES; ++unit)
 				if (hwif->drives[unit].present)
 					ata_attach(&hwif->drives[unit]);
diff -urN linux-2.6.0/drivers/ide/ide.c linux-2.6.0-mine/drivers/ide/ide.c
--- linux-2.6.0/drivers/ide/ide.c	Thu Nov 27 07:43:29 2003
+++ linux-2.6.0-mine/drivers/ide/ide.c	Sat Jan  3 11:34:11 2004
@@ -1915,7 +1915,7 @@
 	const char max_hwif  = '0' + (MAX_HWIFS - 1);
 
 	
-	if (strncmp(s,"hd",2) == 0 && s[2] == '=')	/* hd= is for hd.c   */
+	if (strncmp(s,"hd=",3) == 0 )	/* hd= is for hd.c   */
 		return 0;				/* driver and not us */
 
 	if (strncmp(s,"ide",3) &&
diff -urN linux-2.6.0/drivers/ide/setup-pci.c linux-2.6.0-mine/drivers/ide/setup-pci.c
--- linux-2.6.0/drivers/ide/setup-pci.c	Thu Nov 27 07:43:39 2003
+++ linux-2.6.0-mine/drivers/ide/setup-pci.c	Sat Jan  3 12:52:41 2004
@@ -449,7 +449,17 @@
 	} else if (hwif->io_ports[IDE_CONTROL_OFFSET] != (ctl | 2)) {
 		goto fixup_address;
 	}
-	hwif->chipset = ide_pci;
+
+	/*
+	 * if the chipset of the returned hwif is currently ide_generic, the PCI
+	 * ide driver can take over control of the hwif. We use the special
+	 * ide_pci_takeover value to prevent re-probing the drives etc in
+	 * probe_hwif_init.
+	 */
+	 
+	if( hwif->chipset == ide_generic ) hwif->chipset = ide_pci_takeover;
+	else hwif->chipset = ide_pci;
+
 	hwif->pci_dev = dev;
 	hwif->cds = (struct ide_pci_device_s *) d;
 	hwif->channel = port;
diff -urN linux-2.6.0/include/linux/ide.h linux-2.6.0-mine/include/linux/ide.h
--- linux-2.6.0/include/linux/ide.h	Thu Nov 27 07:43:36 2003
+++ linux-2.6.0-mine/include/linux/ide.h	Sat Jan  3 04:55:42 2004
@@ -275,6 +275,10 @@
 /*
  * hwif_chipset_t is used to keep track of the specific hardware
  * chipset used by each IDE interface, if known.
+ *
+ * ide_pci_takeover is a temporary state used when a chipset-specific
+ * driver is loaded as a module and has to take control of a controller
+ * previously being supervised by the generic pci driver.
  */
 typedef enum {	ide_unknown,	ide_generic,	ide_pci,
 		ide_cmd640,	ide_dtc2278,	ide_ali14xx,
@@ -282,7 +286,7 @@
 		ide_pdc4030,	ide_rz1000,	ide_trm290,
 		ide_cmd646,	ide_cy82c693,	ide_4drives,
 		ide_pmac,	ide_etrax100,	ide_acorn,
-		ide_pc9800
+		ide_pc9800, ide_pci_takeover
 } hwif_chipset_t;
 
 /*



