Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265256AbUFAWab@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265256AbUFAWab (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 18:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265269AbUFAWab
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 18:30:31 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:13221 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S265256AbUFAWaV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 18:30:21 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE update [6/10]
Date: Wed, 2 Jun 2004 00:28:03 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200406020020.22387.bzolnier@elka.pw.edu.pl>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[PATCH] ide: use generic ide_init_hwif_ports() on m68k

Also print the same warning as on m68k on other archs too.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>

 linux-2.6.7-rc2-bk2-bzolnier/include/asm-m68k/ide.h |   13 -------------
 linux-2.6.7-rc2-bk2-bzolnier/include/linux/ide.h    |   14 ++++++++------
 2 files changed, 8 insertions(+), 19 deletions(-)

diff -puN include/asm-m68k/ide.h~ide_init_hwif_ports include/asm-m68k/ide.h
--- linux-2.6.7-rc2-bk2/include/asm-m68k/ide.h~ide_init_hwif_ports	2004-06-01 19:57:05.182438352 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/asm-m68k/ide.h	2004-06-01 19:57:05.190437136 +0200
@@ -61,19 +61,6 @@ static __inline__ unsigned long ide_defa
           return 0;
 }
 
-
-/*
- * Set up a hw structure for a specified data port, control port and IRQ.
- * This should follow whatever the default interface uses.
- */
-static __inline__ void ide_init_hwif_ports(hw_regs_t *hw,
-					   unsigned long data_port,
-					   unsigned long ctrl_port, int *irq)
-{
-	if (data_port || ctrl_port)
-		printk("ide_init_hwif_ports: must not be called\n");
-}
-
 #define ide_init_default_irq(base)	(0)
 
 /*
diff -puN include/linux/ide.h~ide_init_hwif_ports include/linux/ide.h
--- linux-2.6.7-rc2-bk2/include/linux/ide.h~ide_init_hwif_ports	2004-06-01 19:57:05.186437744 +0200
+++ linux-2.6.7-rc2-bk2-bzolnier/include/linux/ide.h	2004-06-01 19:57:05.192436832 +0200
@@ -308,11 +308,7 @@ static inline void ide_std_init_ports(hw
 /*
  * ide_init_hwif_ports() is OBSOLETE and will be removed in 2.7 series.
  * New ports shouldn't define IDE_ARCH_OBSOLETE_INIT in <asm/ide.h>.
- *
- * m68k, m68knommu (broken) and i386-pc9800 (broken)
- * still have their own versions.
  */
-#ifndef CONFIG_M68K
 #ifdef IDE_ARCH_OBSOLETE_INIT
 static inline void ide_init_hwif_ports(hw_regs_t *hw,
 				       unsigned long io_addr,
@@ -335,9 +331,15 @@ static inline void ide_init_hwif_ports(h
 #endif
 }
 #else
-# define ide_init_hwif_ports(hw, io, ctl, irq)	do {} while (0)
+static inline void ide_init_hwif_ports(hw_regs_t *hw,
+				       unsigned long io_addr,
+				       unsigned long ctl_addr,
+				       int *irq)
+{
+	if (io_addr || ctl_addr)
+		printk(KERN_WARNING "%s: must not be called\n", __FUNCTION__);
+}
 #endif /* IDE_ARCH_OBSOLETE_INIT */
-#endif /* !M68K */
 
 /* Currently only m68k, apus and m8xx need it */
 #ifndef IDE_ARCH_ACK_INTR

_

