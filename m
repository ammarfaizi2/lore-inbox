Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTEZOWF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 10:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264393AbTEZOWF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 10:22:05 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31486 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264387AbTEZOWD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 10:22:03 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: torvalds@transmeta.com, alan@redhat.com
Subject: [PATCH] IDE: fix "biostimings" and legacy chipsets' boot parameters interaction
Date: Mon, 26 May 2003 16:35:05 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200305261635.05348.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
please apply.

I hope this time no whitespace breakage.
--
Bartlomiej

IDE: fix "biostimings" and legacy chipsets' boot parameters interaction.

"biostimings" cannot be hardcoded to -19, make it -8.
Code in ide_setup() assumes that everything <= -11 is a legacy
chipset name, so fe. "ide0=ali14xx ide0=biostimings" will fail
while "ide0=biostimings ide0=ali14xx" will be okay.

 drivers/ide/ide.c |   17 ++++++++---------
 1 files changed, 8 insertions(+), 9 deletions(-)

diff -puN drivers/ide/ide.c~ideX_biostimings_fix drivers/ide/ide.c
--- linux-2.5.69-bk17/drivers/ide/ide.c~ideX_biostimings_fix	Sun May 25 23:26:20 2003
+++ linux-2.5.69-bk17-root/drivers/ide/ide.c	Sun May 25 23:29:32 2003
@@ -1939,13 +1939,13 @@ int __init ide_setup (char *s)
 	if (s[3] >= '0' && s[3] <= max_hwif) {
 		/*
 		 * Be VERY CAREFUL changing this: note hardcoded indexes below
-		 * -8,-9,-10 : are reserved for future idex calls to ease the hardcoding.
+		 * -9,-10 : are reserved for future idex calls to ease the hardcoding.
 		 */
 		const char *ide_words[] = {
 			"noprobe", "serialize", "autotune", "noautotune", 
-			"reset", "dma", "ata66", "minus8", "minus9", "minus10",
-			"four", "qd65xx", "ht6560b", "cmd640_vlb", "dtc2278", 
-			"umc8672", "ali14xx", "dc4030", "biostimings", NULL };
+			"reset", "dma", "ata66", "biostimings", "minus9",
+			"minus10", "four", "qd65xx", "ht6560b", "cmd640_vlb",
+			"dtc2278", "umc8672", "ali14xx", "dc4030", NULL };
 		hw = s[3] - '0';
 		hwif = &ide_hwifs[hw];
 		i = match_parm(&s[4], ide_words, vals, 3);
@@ -1964,10 +1964,6 @@ int __init ide_setup (char *s)
 		}
 
 		switch (i) {
-			case -19: /* "biostimings" */
-				hwif->drives[0].autotune = IDE_TUNE_BIOS;
-				hwif->drives[1].autotune = IDE_TUNE_BIOS;
-				goto done;
 #ifdef CONFIG_BLK_DEV_PDC4030
 			case -18: /* "dc4030" */
 			{
@@ -2038,8 +2034,11 @@ int __init ide_setup (char *s)
 #endif /* CONFIG_BLK_DEV_4DRIVES */
 			case -10: /* minus10 */
 			case -9: /* minus9 */
-			case -8: /* minus8 */
 				goto bad_option;
+			case -8: /* "biostimings" */
+				hwif->drives[0].autotune = IDE_TUNE_BIOS;
+				hwif->drives[1].autotune = IDE_TUNE_BIOS;
+				goto done;
 			case -7: /* ata66 */
 #ifdef CONFIG_BLK_DEV_IDEPCI
 				hwif->udma_four = 1;

_

