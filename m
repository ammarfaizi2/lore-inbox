Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262323AbREUBzq>; Sun, 20 May 2001 21:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262324AbREUBzg>; Sun, 20 May 2001 21:55:36 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:38590 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262323AbREUBz1>;
	Sun, 20 May 2001 21:55:27 -0400
Message-ID: <3B087587.780CD5F9@mandrakesoft.com>
Date: Sun, 20 May 2001 21:55:19 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: andre@linux-ide.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: ali noautodma, and Alpha AXP
Content-Type: multipart/mixed;
 boundary="------------82C6ABD5BEF7DE8E7368352B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------82C6ABD5BEF7DE8E7368352B
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

The hardware:  UP1000 Alpha, with ALI M1543C IDE.  Fujitsu 2GB udma33
drive, I think.  ATAPI UDMA CDROM.

The problem:  2.2.15 (as packaged with MDK 7.1 for Alpha) works fine. 
2.4.current, both ac tree and linus tree, fail to work at all.  I've
tried all combinations I can think of, for: with and without the
alim15xx.c driver, with/out IDEDMA, with/out IDEDMA on auto, with/out
"ide=nodma" on cmdline.

2.2.x gives the message "DMA disabled (BIOS)", and tunes the drives for
PIO.

2.4.x, even with "nodma", tunes the hard drive and CDROM drive for
udma.  All hard drive accesses fail with "hda: lost interrupt" and "hdc:
lost interrupt".  With the attached patch, it no longer appears to tune
the drives for UDMA, but I still get lost interrupt messages and no
usable drives.

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
--------------82C6ABD5BEF7DE8E7368352B
Content-Type: text/plain; charset=us-ascii;
 name="ali.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ali.patch"

Index: linux_2_4/drivers/ide/alim15x3.c
diff -u linux_2_4/drivers/ide/alim15x3.c:1.1.1.49 linux_2_4/drivers/ide/alim15x3.c:1.1.1.49.6.1
--- linux_2_4/drivers/ide/alim15x3.c:1.1.1.49	Thu May 17 10:12:07 2001
+++ linux_2_4/drivers/ide/alim15x3.c	Sun May 20 16:16:52 2001
@@ -679,19 +679,21 @@
 	hwif->drives[0].autotune = 1;
 	hwif->drives[1].autotune = 1;
 	hwif->speedproc = &ali15x3_tune_chipset;
-#ifndef CONFIG_BLK_DEV_IDEDMA
-	hwif->autodma = 0;
-	return;
-#endif /* CONFIG_BLK_DEV_IDEDMA */
 
+#ifdef CONFIG_BLK_DEV_IDEDMA
 	if ((hwif->dma_base) && (m5229_revision >= 0x20)) {
 		/*
 		 * M1543C or newer for DMAing
 		 */
 		hwif->dmaproc = &ali15x3_dmaproc;
-		if (!noautodma)
-			hwif->autodma = 1;
+		hwif->autodma = 1;
 	}
+
+	if (noautodma)
+		hwif->autodma = 0;
+#else
+	hwif->autodma = 0;
+#endif /* CONFIG_BLK_DEV_IDEDMA */
 }
 
 void __init ide_dmacapable_ali15x3 (ide_hwif_t *hwif, unsigned long dmabase)

--------------82C6ABD5BEF7DE8E7368352B--

