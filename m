Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268095AbTGTTsB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:48:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbTGTTsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:48:00 -0400
Received: from mout0.freenet.de ([194.97.50.131]:13991 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id S268095AbTGTTr6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:47:58 -0400
From: =?utf-8?q?J=C3=BCrgen=20Stohr?= <juergen.stohr@gmx.de>
To: andre@linux-ide.org
Subject: BUG in pdc202xx_old.c
Date: Sun, 20 Jul 2003 22:06:21 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200307202206.21872.juergen.stohr@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,
in pdc202xx_old.c is a bug that prevents the use of "66 Clocking". The driver 
always falls back to UDMA 33. The reason for this bug is found in function 
"config_chipset_for_dma" when checking if the "other" drive is capable of 
UDMA 66. The follwing patch, which should apply against 2.4.22-pre7, solves 
the problem for me:

--- pdc202xx_old.c.broken       2003-07-20 20:12:39.000000000 +0200
+++ pdc202xx_old.c      2003-07-20 20:18:50.000000000 +0200
@@ -425,7 +425,7 @@
                         * check to make sure drive on same channel
                         * is u66 capable
                         */
-                       if (hwif->drives[!(drive->dn%2)].id) {
+                       if (hwif->drives[!(drive->dn%2)].present) {
                                if (hwif->drives[!(drive->dn%2)].id->dma_ultra 
& 0x0078) {
                                        hwif->OUTB(CLKSPD | mask, 
(hwif->dma_master + 0x11));
                                } else {

regards,
Jürgen

