Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318249AbSHDWVY>; Sun, 4 Aug 2002 18:21:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318250AbSHDWVY>; Sun, 4 Aug 2002 18:21:24 -0400
Received: from p0017.as-l042.contactel.cz ([194.108.237.17]:8832 "EHLO
	ppc.vc.cvut.cz") by vger.kernel.org with ESMTP id <S318249AbSHDWVY>;
	Sun, 4 Aug 2002 18:21:24 -0400
Date: Mon, 5 Aug 2002 00:25:42 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: martin@dalecki.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] IDE udma_status = 0x76 and 2.5.30...
Message-ID: <20020804222542.GH13053@ppc.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   patch below fixes troubles with PDC20265 reporting udma_status = 0x76
with kernels since pcidma cleanup (it was already reported here, but
I did not found patch for it). Code before change (IDE110) set highest
bit of last dword to 1 on all devices except TRM290. New code
set it only on TRM290 devices, which breaks at least mine PDC20265.
Please send it to Linus in your next update.

   BTW, are there any TRM290 owners using 2.5.30? Old code set length to
((length >> 2) - 1) << 16, while new code does not have special handling
for TRM290. Or do I miss something?

   And BTW#2, mine problematic Toshiba disk works fine with PDC20265 with
512B request size... It breaks with i845 and i440BX, under any UDMA.
					Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


diff -urdN linux/drivers/ide/pcidma.c linux/drivers/ide/pcidma.c
--- linux/drivers/ide/pcidma.c	2002-08-04 17:54:41.000000000 +0200
+++ linux/drivers/ide/pcidma.c	2002-08-04 23:52:33.000000000 +0200
@@ -403,10 +403,8 @@
 		sg++;
 	}
 
-#ifdef CONFIG_BLK_DEV_TRM290
-	if (ch->chipset == ide_trm290)
+	if (ch->chipset != ide_trm290)
 		*--table |= cpu_to_le32(0x80000000);
-#endif
 
 	return ch->sg_nents;
 }
