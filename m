Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbTCWFL7>; Sun, 23 Mar 2003 00:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262776AbTCWFL7>; Sun, 23 Mar 2003 00:11:59 -0500
Received: from dp.samba.org ([66.70.73.150]:6793 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262523AbTCWFL5>;
	Sun, 23 Mar 2003 00:11:57 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15997.17378.538276.91950@nanango.paulus.ozlabs.org>
Date: Sun, 23 Mar 2003 16:19:30 +1100 (EST)
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] fix powerbook media bay
X-Mailer: VM 6.75 under Emacs 20.7.2
Reply-To: paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a couple of bugs and compile errors in the powerbook
media bay driver.  It was getting initialized after the IDE subsystem,
whereas it needs to be initialized before so that the IDE subsystem
can see the CD-ROM drive in the bay.

Please apply.

Paul.

diff -urN linux-2.5/drivers/macintosh/mediabay.c pmac-2.5/drivers/macintosh/mediabay.c
--- linux-2.5/drivers/macintosh/mediabay.c	2002-11-12 00:18:24.000000000 +1100
+++ pmac-2.5/drivers/macintosh/mediabay.c	2003-03-22 20:11:14.000000000 +1100
@@ -23,6 +23,7 @@
 #include <linux/stddef.h>
 #include <linux/unistd.h>
 #include <linux/init.h>
+#include <linux/ide.h>
 #include <asm/prom.h>
 #include <asm/pgtable.h>
 #include <asm/io.h>
@@ -493,7 +494,7 @@
 			} while(--timeout);
 			printk(KERN_DEBUG "Timeount waiting IDE in bay %d\n", i);
 			return -ENODEV;
-		} 
+		}
 #endif
 	
 	return -ENODEV;
@@ -567,9 +568,10 @@
 				hw_regs_t hw;
 
 				pmu_suspend();
-				ide_init_hwif_ports(&hw, (ide_ioreg_t) bay->cd_base, (ide_ioreg_t) 0, NULL);
+				ide_init_hwif_ports(&hw, (unsigned long) bay->cd_base, (unsigned long) 0, NULL);
 				hw.irq = bay->cd_irq;
-				bay->cd_index = ide_register_hw(&hw);
+				hw.chipset = ide_pmac;
+				bay->cd_index = ide_register_hw(&hw, NULL);
 				pmu_resume();
 			}
 			if (bay->cd_index == -1) {
@@ -834,4 +836,4 @@
 	return 0;
 }
 
-device_initcall(media_bay_init);
+subsys_initcall(media_bay_init);
