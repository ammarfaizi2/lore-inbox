Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135859AbREDGXo>; Fri, 4 May 2001 02:23:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135861AbREDGXf>; Fri, 4 May 2001 02:23:35 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:32023 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S135859AbREDGXV>; Fri, 4 May 2001 02:23:21 -0400
Date: Fri, 4 May 2001 02:23:15 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
Subject: Patch for shared interrupts in PCI IDE
Message-ID: <20010504022315.C4441@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One of our customers has a Fujitsu laptop, poor thing...
It shares IRQ10 between Eepro, additional IDE for CD-ROM (CMD646),
and USB controllers. I talked this over with DaveM briefly,
and if I understood him right, something like the attached
patch may be in order. Anyone cares to comment?

Thank you,
-- Pete

diff -ur -X dontdiff linux-2.4.4/include/linux/ide.h linux-2.4.4-niph/include/linux/ide.h
--- linux-2.4.4/include/linux/ide.h	Fri Apr 27 15:48:56 2001
+++ linux-2.4.4-niph/include/linux/ide.h	Thu May  3 23:03:27 2001
@@ -408,6 +408,10 @@
 		ide_pmac
 } hwif_chipset_t;
 
+#define IDE_CHIPSET_PCI_MASK	\
+    ((1<<ide_pci)|(1<<ide_cmd646)|(1<<ide_ali14xx))
+#define IDE_CHIPSET_IS_PCI(c)	((IDE_CHIPSET_PCI_MASK >> (c)) & 1)
+
 #ifdef CONFIG_BLK_DEV_IDEPCI
 typedef struct ide_pci_devid_s {
 	unsigned short	vid;
diff -ur -X dontdiff linux-2.4.4/drivers/ide/ide-probe.c linux-2.4.4-niph/drivers/ide/ide-probe.c
--- linux-2.4.4/drivers/ide/ide-probe.c	Sun Mar 18 09:25:02 2001
+++ linux-2.4.4-niph/drivers/ide/ide-probe.c	Thu May  3 23:07:37 2001
@@ -681,9 +681,9 @@
 	 */
 	if (!match || match->irq != hwif->irq) {
 #ifdef CONFIG_IDEPCI_SHARE_IRQ
-		int sa = (hwif->chipset == ide_pci) ? SA_SHIRQ : SA_INTERRUPT;
+		int sa = IDE_CHIPSET_IS_PCI(hwif->chipset) ? SA_SHIRQ : SA_INTERRUPT;
 #else /* !CONFIG_IDEPCI_SHARE_IRQ */
-		int sa = (hwif->chipset == ide_pci) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
+		int sa = IDE_CHIPSET_IS_PCI(hwif->chipset) ? SA_INTERRUPT|SA_SHIRQ : SA_INTERRUPT;
 #endif /* CONFIG_IDEPCI_SHARE_IRQ */
 		if (ide_request_irq(hwif->irq, &ide_intr, sa, hwif->name, hwgroup)) {
 			if (!match)
