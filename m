Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266580AbUBLUBF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:01:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266581AbUBLUBF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:01:05 -0500
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:40180 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266580AbUBLUBA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:01:00 -0500
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Athol Mullen <athol_SPIT_SPAM@idl.net.au>, Willy Tarreau <willy@w.ods.org>
Subject: (was Re: [RFC] IDE 80-core cable detect - chipset-specific code to over-ride eighty_ninty_three())
Date: Thu, 12 Feb 2004 21:06:41 +0100
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402122106.41947.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

word93 of drive identify is:

0x603b for IC35L120AVV207-0
0x3469 for QUANTUM FIREBALLlct20 30

and eighty_ninty_three() checks for bit 0x4000, so...

Willy, it seems you are hitting some other problem.
Have you already tried booting with "ide0=ata66"?

Athol, does this patch solves your problem?

[PATCH] add 80-wires cable detection quirk for QUANTUM FIREBALLlct20 30

 linux-2.6.3-rc2-root/drivers/ide/ide-iops.c |   30 ++++++++++++++--------------
 1 files changed, 16 insertions(+), 14 deletions(-)

diff -puN drivers/ide/ide-iops.c~ide_quantum_ivb_fix drivers/ide/ide-iops.c
--- linux-2.6.3-rc2/drivers/ide/ide-iops.c~ide_quantum_ivb_fix	2004-02-12 19:53:14.480791880 +0100
+++ linux-2.6.3-rc2-root/drivers/ide/ide-iops.c	2004-02-12 20:00:32.562193384 +0100
@@ -618,10 +618,14 @@ EXPORT_SYMBOL(ide_wait_stat);
  */
 u8 eighty_ninty_three (ide_drive_t *drive)
 {
-#if 0
+	struct hd_driveid *id = drive->id;
+#ifndef CONFIG_IDEDMA_IVB
+	unsigned int ivb = 0;
+#endif
+
 	if (!HWIF(drive)->udma_four)
 		return 0;
-
+#if 0
 	if (drive->id->major_rev_num) {
 		int hssbd = 0;
 		int i;
@@ -641,21 +645,19 @@ u8 eighty_ninty_three (ide_drive_t *driv
 				return 0;
 		}
 	}
-
-	return ((u8) (
+#endif
 #ifndef CONFIG_IDEDMA_IVB
-		(drive->id->hw_config & 0x4000) &&
-#endif /* CONFIG_IDEDMA_IVB */
-		 (drive->id->hw_config & 0x6000)) ? 1 : 0);
-
+	/* We can convert this to ivb_drives list if necessary. */
+	if (!strcmp("QUANTUM FIREBALLlct20 30", id->model) &&
+	    !strcmp("APL.0900", id->fw_rev))
+		ivb = 1;
+	if ((id->hw_config & 0x4000) || (ivb && (id->hw_config & 0x2000)))
+		return 1;
 #else
-
-	return ((u8) ((HWIF(drive)->udma_four) &&
-#ifndef CONFIG_IDEDMA_IVB
-			(drive->id->hw_config & 0x4000) &&
-#endif /* CONFIG_IDEDMA_IVB */
-			(drive->id->hw_config & 0x6000)) ? 1 : 0);
+	if (id->hw_config & 0x6000)
+		return 1;
 #endif
+	return 0;
 }
 
 EXPORT_SYMBOL(eighty_ninty_three);

_

