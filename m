Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264215AbUFKQ0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264215AbUFKQ0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 12:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264176AbUFKQRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 12:17:23 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:8089 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264117AbUFKQQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 12:16:09 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-ide@vger.kernel.org
Subject: [PATCH] IDE update for 2.6.7-rc3 [5/12]
Date: Fri, 11 Jun 2004 17:56:06 +0200
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, Jesper Juhl <juhl@dif.dk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406111756.06384.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: ide-pnp update

- do not unregister ide-pnp driver during detaching random
  IDE device from random IDE device driver if IDE is modular
  (somebody added this in 2.3.51)
- clear 'hw_regs_t hw' allocated from stack
- mark idepnp_init() with __init
- use ide_std_init_ports() instead of ide_setup_ports()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc3-bzolnier/drivers/ide/ide-pnp.c |   36 ++++---------------------
 linux-2.6.7-rc3-bzolnier/drivers/ide/ide.c     |   13 ++-------
 2 files changed, 11 insertions(+), 38 deletions(-)

diff -puN drivers/ide/ide-pnp.c~ide_pnp drivers/ide/ide-pnp.c
--- linux-2.6.7-rc3/drivers/ide/ide-pnp.c~ide_pnp	2004-06-11 16:51:38.333848144 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide-pnp.c	2004-06-11 16:51:38.341846928 +0200
@@ -16,25 +16,9 @@
  * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.  
  */
 
-#include <linux/ide.h>
 #include <linux/init.h>
-
 #include <linux/pnp.h>
-
-#define GENERIC_HD_DATA		0
-#define GENERIC_HD_ERROR	1
-#define GENERIC_HD_NSECTOR	2
-#define GENERIC_HD_SECTOR	3
-#define GENERIC_HD_LCYL		4
-#define GENERIC_HD_HCYL		5
-#define GENERIC_HD_SELECT	6
-#define GENERIC_HD_STATUS	7
-
-static int generic_ide_offsets[IDE_NR_PORTS] = {
-	GENERIC_HD_DATA, GENERIC_HD_ERROR, GENERIC_HD_NSECTOR, 
-	GENERIC_HD_SECTOR, GENERIC_HD_LCYL, GENERIC_HD_HCYL,
-	GENERIC_HD_SELECT, GENERIC_HD_STATUS, -1, -1
-};
+#include <linux/ide.h>
 
 /* Add your devices here :)) */
 struct pnp_device_id idepnp_devices[] = {
@@ -52,12 +36,10 @@ static int idepnp_probe(struct pnp_dev *
 	if (!(pnp_port_valid(dev, 0) && pnp_port_valid(dev, 1) && pnp_irq_valid(dev, 0)))
 		return -1;
 
-	ide_setup_ports(&hw, (unsigned long) pnp_port_start(dev, 0),
-			generic_ide_offsets,
-			(unsigned long) pnp_port_start(dev, 1),
-			0, NULL,
-//			generic_pnp_ide_iops,
-			pnp_irq(dev, 0));
+	memset(&hw, 0, sizeof(hw));
+	ide_std_init_ports(&hw, pnp_port_start(dev, 0),
+				pnp_port_start(dev, 1));
+	hw.irq = pnp_irq(dev, 0);
 
 	index = ide_register_hw(&hw, &hwif);
 
@@ -86,11 +68,7 @@ static struct pnp_driver idepnp_driver =
 	.remove		= idepnp_remove,
 };
 
-
-void pnpide_init(int enable)
+void __init pnpide_init(void)
 {
-	if(enable)
-		pnp_register_driver(&idepnp_driver);
-	else
-		pnp_unregister_driver(&idepnp_driver);
+	pnp_register_driver(&idepnp_driver);
 }
diff -puN drivers/ide/ide.c~ide_pnp drivers/ide/ide.c
--- linux-2.6.7-rc3/drivers/ide/ide.c~ide_pnp	2004-06-11 16:51:38.337847536 +0200
+++ linux-2.6.7-rc3-bzolnier/drivers/ide/ide.c	2004-06-11 16:51:38.343846624 +0200
@@ -2002,6 +2002,7 @@ done:
 	return 1;
 }
 
+extern void pnpide_init(void);
 extern void h8300_ide_init(void);
 
 /*
@@ -2068,12 +2069,9 @@ static void __init probe_for_hwifs (void
 		buddha_init();
 	}
 #endif /* CONFIG_BLK_DEV_BUDDHA */
-#if defined(CONFIG_BLK_DEV_IDEPNP) && defined(CONFIG_PNP)
-	{
-		extern void pnpide_init(int enable);
-		pnpide_init(1);
-	}
-#endif /* CONFIG_BLK_DEV_IDEPNP */
+#ifdef CONFIG_BLK_DEV_IDEPNP
+	pnpide_init();
+#endif
 #ifdef CONFIG_H8300
 	h8300_ide_init();
 #endif
@@ -2211,9 +2209,6 @@ int ide_unregister_subdriver (ide_drive_
 		up(&ide_setting_sem);
 		return 1;
 	}
-#if defined(CONFIG_BLK_DEV_IDEPNP) && defined(CONFIG_PNP) && defined(MODULE)
-	pnpide_init(0);
-#endif /* CONFIG_BLK_DEV_IDEPNP */
 #ifdef CONFIG_PROC_FS
 	ide_remove_proc_entries(drive->proc, DRIVER(drive)->proc);
 	ide_remove_proc_entries(drive->proc, generic_subdriver_entries);

_

