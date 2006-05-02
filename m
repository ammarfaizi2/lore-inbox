Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965012AbWEBV5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965012AbWEBV5K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965016AbWEBV5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:57:10 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:3790 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S965012AbWEBV5H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:57:07 -0400
Message-ID: <4457D568.6090001@ru.mvista.com>
Date: Wed, 03 May 2006 01:55:52 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH][RFT] Fix HPT37x timing tables
References: <444B3BDE.1030106@ru.mvista.com>
In-Reply-To: <444B3BDE.1030106@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------060201070604090707050609"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060201070604090707050609
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Fix/remove bad/unused timing tables: HPT370/A 66 MHz tables weren't really
needed (the chips are not UltraATA/133 capable and shouldn't support 66 MHz
PCI) and had many modes over- and underclocked, HPT372 33 MHz table was in
fact for 66 MHz and 50 MHz table missed UltraDMA mode 6, HPT374 33 MHz table
was really for 50 MHz... (Actually, HPT370/A 33 MHz tables also have issues.
e.g. HPT370 has PIO modes 0/1 overlocked.)
    There's also no need in the separate HPT374 tables because HPT372 timings
should be the same (and those tables has UltraDMA mode 6 which HPT374 supports
depending on HPT374_ALLOW_ATA133_6 #define)...
    Have been tested and works fine on HPT370 and 371N...

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>




--------------060201070604090707050609
Content-Type: text/plain;
 name="HPT37x-fix-timing-tables.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT37x-fix-timing-tables.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -67,6 +67,10 @@
  * - add support for HPT302N and HPT371N clocking (the same as for HPT372N)
  * - HPT371/N are single channel chips, so avoid touching the primary channel
  *   which exists only virtually (there's no pins for it)
+ * - fix/remove bad/unused timing tables: HPT370/A  66 MHz tables weren't really
+ *   needed and had many modes over- and  underclocked,  HPT372 33 MHz table was
+ *   for 66 MHz and 50 MHz table missed UltraDMA mode 6, HPT374 33 MHz table was
+ *   really for 50 MHz; switch to using HPT372 tables for HPT374...
  *		<source@mvista.com>
  *
  */
@@ -265,26 +269,6 @@ static struct chipset_bus_clock_list_ent
 	{	0,		0x06514e57	}
 };
 
-static struct chipset_bus_clock_list_entry sixty_six_base_hpt370[] = {
-	{	XFER_UDMA_5,	0x14846231	},
-	{	XFER_UDMA_4,	0x14886231	},
-	{	XFER_UDMA_3,	0x148c6231	},
-	{	XFER_UDMA_2,	0x148c6231	},
-	{	XFER_UDMA_1,	0x14906231	},
-	{	XFER_UDMA_0,	0x14986231	},
-
-	{	XFER_MW_DMA_2,	0x26514e21	},
-	{	XFER_MW_DMA_1,	0x26514e33	},
-	{	XFER_MW_DMA_0,	0x26514e97	},
-
-	{	XFER_PIO_4,	0x06514e21	},
-	{	XFER_PIO_3,	0x06514e22	},
-	{	XFER_PIO_2,	0x06514e33	},
-	{	XFER_PIO_1,	0x06914e43	},
-	{	XFER_PIO_0,	0x06914e57	},
-	{	0,		0x06514e57	}
-};
-
 /* these are the current (4 sep 2001) timings from highpoint */
 static struct chipset_bus_clock_list_entry thirty_three_base_hpt370a[] = {
 	{	XFER_UDMA_5,	0x12446231	},
@@ -306,27 +290,6 @@ static struct chipset_bus_clock_list_ent
 	{	0,		0x06814ea7	}
 };
 
-/* 2x 33MHz timings */
-static struct chipset_bus_clock_list_entry sixty_six_base_hpt370a[] = {
-	{	XFER_UDMA_5,	0x1488e673	},
-	{	XFER_UDMA_4,	0x1488e673	},
-	{	XFER_UDMA_3,	0x1498e673	},
-	{	XFER_UDMA_2,	0x1490e673	},
-	{	XFER_UDMA_1,	0x1498e677	},
-	{	XFER_UDMA_0,	0x14a0e73f	},
-
-	{	XFER_MW_DMA_2,	0x2480fa73	},
-	{	XFER_MW_DMA_1,	0x2480fa77	}, 
-	{	XFER_MW_DMA_0,	0x2480fb3f	},
-
-	{	XFER_PIO_4,	0x0c82be73	},
-	{	XFER_PIO_3,	0x0c82be95	},
-	{	XFER_PIO_2,	0x0c82beb7	},
-	{	XFER_PIO_1,	0x0d02bf37	},
-	{	XFER_PIO_0,	0x0d02bf5f	},
-	{	0,		0x0d02bf5f	}
-};
-
 static struct chipset_bus_clock_list_entry fifty_base_hpt370a[] = {
 	{	XFER_UDMA_5,	0x12848242	},
 	{	XFER_UDMA_4,	0x12ac8242	},
@@ -348,27 +311,28 @@ static struct chipset_bus_clock_list_ent
 };
 
 static struct chipset_bus_clock_list_entry thirty_three_base_hpt372[] = {
-	{	XFER_UDMA_6,	0x1c81dc62	},
-	{	XFER_UDMA_5,	0x1c6ddc62	},
-	{	XFER_UDMA_4,	0x1c8ddc62	},
-	{	XFER_UDMA_3,	0x1c8edc62	},	/* checkme */
-	{	XFER_UDMA_2,	0x1c91dc62	},
-	{	XFER_UDMA_1,	0x1c9adc62	},	/* checkme */
-	{	XFER_UDMA_0,	0x1c82dc62	},	/* checkme */
-
-	{	XFER_MW_DMA_2,	0x2c829262	},
-	{	XFER_MW_DMA_1,	0x2c829266	},	/* checkme */
-	{	XFER_MW_DMA_0,	0x2c82922e	},	/* checkme */
+	{	XFER_UDMA_6,	0x12446231	},	/* 0x12646231 ?? */
+	{	XFER_UDMA_5,	0x12446231	},
+	{	XFER_UDMA_4,	0x12446231	},
+	{	XFER_UDMA_3,	0x126c6231	},
+	{	XFER_UDMA_2,	0x12486231	},
+	{	XFER_UDMA_1,	0x124c6233	},
+	{	XFER_UDMA_0,	0x12506297	},
 
-	{	XFER_PIO_4,	0x0c829c62	},
-	{	XFER_PIO_3,	0x0c829c84	},
-	{	XFER_PIO_2,	0x0c829ca6	},
-	{	XFER_PIO_1,	0x0d029d26	},
-	{	XFER_PIO_0,	0x0d029d5e	},
-	{	0,		0x0d029d5e	}
+	{	XFER_MW_DMA_2,	0x22406c31	},
+	{	XFER_MW_DMA_1,	0x22406c33	},
+	{	XFER_MW_DMA_0,	0x22406c97	},
+
+	{	XFER_PIO_4,	0x06414e31	},
+	{	XFER_PIO_3,	0x06414e42	},
+	{	XFER_PIO_2,	0x06414e53	},
+	{	XFER_PIO_1,	0x06814e93	},
+	{	XFER_PIO_0,	0x06814ea7	},
+	{	0,		0x06814ea7	}
 };
 
 static struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
+	{	XFER_UDMA_6,	0x12848242	},
 	{	XFER_UDMA_5,	0x12848242	},
 	{	XFER_UDMA_4,	0x12ac8242	},
 	{	XFER_UDMA_3,	0x128c8242	},
@@ -390,7 +354,7 @@ static struct chipset_bus_clock_list_ent
 
 static struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
 	{	XFER_UDMA_6,	0x1c869c62	},
-	{	XFER_UDMA_5,	0x1cae9c62	},
+	{	XFER_UDMA_5,	0x1cae9c62	},	/* 0x1c8a9c62 */
 	{	XFER_UDMA_4,	0x1c8a9c62	},
 	{	XFER_UDMA_3,	0x1c8e9c62	},
 	{	XFER_UDMA_2,	0x1c929c62	},
@@ -409,50 +373,6 @@ static struct chipset_bus_clock_list_ent
 	{	0,		0x0d029d26	}
 };
 
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt374[] = {
-	{	XFER_UDMA_6,	0x12808242	},
-	{	XFER_UDMA_5,	0x12848242	},
-	{	XFER_UDMA_4,	0x12ac8242	},
-	{	XFER_UDMA_3,	0x128c8242	},
-	{	XFER_UDMA_2,	0x120c8242	},
-	{	XFER_UDMA_1,	0x12148254	},
-	{	XFER_UDMA_0,	0x121882ea	},
-
-	{	XFER_MW_DMA_2,	0x22808242	},
-	{	XFER_MW_DMA_1,	0x22808254	},
-	{	XFER_MW_DMA_0,	0x228082ea	},
-
-	{	XFER_PIO_4,	0x0a81f442	},
-	{	XFER_PIO_3,	0x0a81f443	},
-	{	XFER_PIO_2,	0x0a81f454	},
-	{	XFER_PIO_1,	0x0ac1f465	},
-	{	XFER_PIO_0,	0x0ac1f48a	},
-	{	0,		0x06814e93	}
-};
-
-/* FIXME: 50MHz timings for HPT374 */
-
-#if 0
-static struct chipset_bus_clock_list_entry sixty_six_base_hpt374[] = {
-	{	XFER_UDMA_6,	0x12406231	},	/* checkme */
-	{	XFER_UDMA_5,	0x12446231	},	/* 0x14846231 */
-	{	XFER_UDMA_4,	0x16814ea7	},	/* 0x14886231 */
-	{	XFER_UDMA_3,	0x16814ea7	},	/* 0x148c6231 */
-	{	XFER_UDMA_2,	0x16814ea7	},	/* 0x148c6231 */
-	{	XFER_UDMA_1,	0x16814ea7	},	/* 0x14906231 */
-	{	XFER_UDMA_0,	0x16814ea7	},	/* 0x14986231 */
-	{	XFER_MW_DMA_2,	0x16814ea7	},	/* 0x26514e21 */
-	{	XFER_MW_DMA_1,	0x16814ea7	},	/* 0x26514e97 */
-	{	XFER_MW_DMA_0,	0x16814ea7	},	/* 0x26514e97 */
-	{	XFER_PIO_4,	0x06814ea7	},	/* 0x06514e21 */
-	{	XFER_PIO_3,	0x06814ea7	},	/* 0x06514e22 */
-	{	XFER_PIO_2,	0x06814ea7	},	/* 0x06514e33 */
-	{	XFER_PIO_1,	0x06814ea7	},	/* 0x06914e43 */
-	{	XFER_PIO_0,	0x06814ea7	},	/* 0x06914e57 */
-	{	0,		0x06814ea7	}
-};
-#endif
-
 #define HPT366_DEBUG_DRIVE_INFO		0
 #define HPT374_ALLOW_ATA133_6		0
 #define HPT371_ALLOW_ATA133_6		0
@@ -1212,9 +1132,7 @@ static void __devinit hpt37x_clocking(id
 			pll = F_LOW_PCI_66;
 	
 		if (pll == F_LOW_PCI_33) {
-			if (info->revision >= 8)
-				info->speed = thirty_three_base_hpt374;
-			else if (info->revision >= 5)
+			if (info->revision >= 5)
 				info->speed = thirty_three_base_hpt372;
 			else if (info->revision >= 4)
 				info->speed = thirty_three_base_hpt370a;
@@ -1224,26 +1142,17 @@ static void __devinit hpt37x_clocking(id
 		} else if (pll == F_LOW_PCI_40) {
 			/* Unsupported */
 		} else if (pll == F_LOW_PCI_50) {
-			if (info->revision >= 8)
-				info->speed = fifty_base_hpt370a;
-			else if (info->revision >= 5)
+			if (info->revision >= 5)
 				info->speed = fifty_base_hpt372;
-			else if (info->revision >= 4)
-				info->speed = fifty_base_hpt370a;
 			else
 				info->speed = fifty_base_hpt370a;
 			printk(KERN_DEBUG "HPT37X: using 50MHz PCI clock\n");
 		} else {
-			if (info->revision >= 8) {
-				printk(KERN_ERR "HPT37x: 66MHz timings are not supported.\n");
-			}
-			else if (info->revision >= 5)
+			if (info->revision >= 5) {
 				info->speed = sixty_six_base_hpt372;
-			else if (info->revision >= 4)
-				info->speed = sixty_six_base_hpt370a;
-			else
-				info->speed = sixty_six_base_hpt370;
-			printk(KERN_DEBUG "HPT37X: using 66MHz PCI clock\n");
+				printk(KERN_DEBUG "HPT37X: using 66MHz PCI clock\n");
+			} else
+				printk(KERN_ERR "HPT37x: 66MHz timings not supported.\n");
 		}
 	}
 




--------------060201070604090707050609--
