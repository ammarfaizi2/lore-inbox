Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751111AbWEFUJh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbWEFUJh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 16:09:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWEFUJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 16:09:36 -0400
Received: from rtsoft2.corbina.net ([85.21.88.2]:53198 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1751106AbWEFUJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 16:09:35 -0400
Message-ID: <445D023A.5020703@ru.mvista.com>
Date: Sun, 07 May 2006 00:08:26 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Optimize HPT37x timing tables
References: <444B3BDE.1030106@ru.mvista.com> <4457D568.6090001@ru.mvista.com>
In-Reply-To: <4457D568.6090001@ru.mvista.com>
Content-Type: multipart/mixed;
 boundary="------------020505080807010405080108"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020505080807010405080108
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello.

    Save some space on the timing tables by introducing the separate transfer
mode table in which the mode lookup is done to get the index into the timing
table itself. Get rid of the rest of the obsolete/duplicate tables and use one
set of tables for the whole HPT37x chip family like the HighPoint open-source
drivers do. Documnent the different timing register layout for the HPT36x chip 
family (this is my guesswork based on the timing values).
    Have been tested and works fine on HPT370/302/371N. Should apply on top of
the previously sent patches...

MBR, Sergei

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>



--------------020505080807010405080108
Content-Type: text/plain;
 name="HPT3xx-optimize-timing-tables.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="HPT3xx-optimize-timing-tables.patch"

Index: linus/drivers/ide/pci/hpt366.c
===================================================================
--- linus.orig/drivers/ide/pci/hpt366.c
+++ linus/drivers/ide/pci/hpt366.c
@@ -67,10 +67,9 @@
  * - add support for HPT302N and HPT371N clocking (the same as for HPT372N)
  * - HPT371/N are single channel chips, so avoid touching the primary channel
  *   which exists only virtually (there's no pins for it)
- * - fix/remove bad/unused timing tables: HPT370/A  66 MHz tables weren't really
- *   needed and had many modes over- and  underclocked,  HPT372 33 MHz table was
- *   for 66 MHz and 50 MHz table missed UltraDMA mode 6, HPT374 33 MHz table was
- *   really for 50 MHz; switch to using HPT372 tables for HPT374...
+ * - fix/remove bad/unused timing tables and use one set of tables for the whole
+ *   HPT37x chip family; save space by introducing the separate transfer mode
+ *   table in which the mode lookup is done
  * - use f_CNT value saved by  the HighPoint BIOS as reading it directly gives
  *   the wrong PCI frequency since DPLL has already been calibrated by BIOS
  * - fix the hotswap code:  it caused RESET- to glitch when tristating the bus,
@@ -169,214 +168,168 @@ static const char *bad_ata33[] = {
 	NULL
 };
 
-struct chipset_bus_clock_list_entry {
-	u8		xfer_speed;
-	unsigned int	chipset_settings;
+static u8 xfer_speeds[] = {
+	XFER_UDMA_6,
+	XFER_UDMA_5,
+	XFER_UDMA_4,
+	XFER_UDMA_3,
+	XFER_UDMA_2,
+	XFER_UDMA_1,
+	XFER_UDMA_0,
+
+	XFER_MW_DMA_2,
+	XFER_MW_DMA_1,
+	XFER_MW_DMA_0,
+
+	XFER_PIO_4,
+	XFER_PIO_3,
+	XFER_PIO_2,
+	XFER_PIO_1,
+	XFER_PIO_0
 };
 
-/* key for bus clock timings
- * bit
- * 0:3    data_high_time. inactive time of DIOW_/DIOR_ for PIO and MW
- *        DMA. cycles = value + 1
- * 4:8    data_low_time. active time of DIOW_/DIOR_ for PIO and MW
- *        DMA. cycles = value + 1
- * 9:12   cmd_high_time. inactive time of DIOW_/DIOR_ during task file
- *        register access.
- * 13:17  cmd_low_time. active time of DIOW_/DIOR_ during task file
- *        register access.
- * 18:21  udma_cycle_time. clock freq and clock cycles for UDMA xfer.
- *        during task file register access.
- * 22:24  pre_high_time. time to initialize 1st cycle for PIO and MW DMA
- *        xfer.
- * 25:27  cmd_pre_high_time. time to initialize 1st PIO cycle for task
- *        register access.
- * 28     UDMA enable
- * 29     DMA enable
- * 30     PIO_MST enable. if set, the chip is in bus master mode during
- *        PIO.
- * 31     FIFO enable.
+/* Key for bus clock timings
+ * 36x   37x
+ * bits  bits
+ * 0:3	 0:3	data_high_time. Inactive time of DIOW_/DIOR_ for PIO and MW DMA.
+ *		cycles = value + 1
+ * 4:7	 4:8	data_low_time. Active time of DIOW_/DIOR_ for PIO and MW DMA.
+ *		cycles = value + 1
+ * 8:11  9:12	cmd_high_time. Inactive time of DIOW_/DIOR_ during task file
+ *		register access.
+ * 12:15 13:17	cmd_low_time. Active time of DIOW_/DIOR_ during task file
+ *		register access.
+ * 16:18 18:20	udma_cycle_time. Clock cycles for UDMA xfer.
+ * -	 21	CLK frequency: 0=ATA clock, 1=dual ATA clock.
+ * 19:21 22:24	pre_high_time. Time to initialize the 1st cycle for PIO and
+ *		MW DMA xfer.
+ * 22:24 25:27	cmd_pre_high_time. Time to initialize the 1st PIO cycle for
+ *		task file register access.
+ * 28	 28	UDMA enable.
+ * 29	 29	DMA  enable.
+ * 30	 30	PIO MST enable. If set, the chip is in bus master mode during
+ *		PIO xfer.
+ * 31	 31	FIFO enable.
  */
-static struct chipset_bus_clock_list_entry forty_base_hpt366[] = {
-	{	XFER_UDMA_4,	0x900fd943	},
-	{	XFER_UDMA_3,	0x900ad943	},
-	{	XFER_UDMA_2,	0x900bd943	},
-	{	XFER_UDMA_1,	0x9008d943	},
-	{	XFER_UDMA_0,	0x9008d943	},
-
-	{	XFER_MW_DMA_2,	0xa008d943	},
-	{	XFER_MW_DMA_1,	0xa010d955	},
-	{	XFER_MW_DMA_0,	0xa010d9fc	},
-
-	{	XFER_PIO_4,	0xc008d963	},
-	{	XFER_PIO_3,	0xc010d974	},
-	{	XFER_PIO_2,	0xc010d997	},
-	{	XFER_PIO_1,	0xc010d9c7	},
-	{	XFER_PIO_0,	0xc018d9d9	},
-	{	0,		0x0120d9d9	}
-};
-
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt366[] = {
-	{	XFER_UDMA_4,	0x90c9a731	},
-	{	XFER_UDMA_3,	0x90cfa731	},
-	{	XFER_UDMA_2,	0x90caa731	},
-	{	XFER_UDMA_1,	0x90cba731	},
-	{	XFER_UDMA_0,	0x90c8a731	},
-
-	{	XFER_MW_DMA_2,	0xa0c8a731	},
-	{	XFER_MW_DMA_1,	0xa0c8a732	},	/* 0xa0c8a733 */
-	{	XFER_MW_DMA_0,	0xa0c8a797	},
-
-	{	XFER_PIO_4,	0xc0c8a731	},
-	{	XFER_PIO_3,	0xc0c8a742	},
-	{	XFER_PIO_2,	0xc0d0a753	},
-	{	XFER_PIO_1,	0xc0d0a7a3	},	/* 0xc0d0a793 */
-	{	XFER_PIO_0,	0xc0d0a7aa	},	/* 0xc0d0a7a7 */
-	{	0,		0x0120a7a7	}
-};
 
-static struct chipset_bus_clock_list_entry twenty_five_base_hpt366[] = {
-	{	XFER_UDMA_4,	0x90c98521	},
-	{	XFER_UDMA_3,	0x90cf8521	},
-	{	XFER_UDMA_2,	0x90cf8521	},
-	{	XFER_UDMA_1,	0x90cb8521	},
-	{	XFER_UDMA_0,	0x90cb8521	},
-
-	{	XFER_MW_DMA_2,	0xa0ca8521	},
-	{	XFER_MW_DMA_1,	0xa0ca8532	},
-	{	XFER_MW_DMA_0,	0xa0ca8575	},
-
-	{	XFER_PIO_4,	0xc0ca8521	},
-	{	XFER_PIO_3,	0xc0ca8532	},
-	{	XFER_PIO_2,	0xc0ca8542	},
-	{	XFER_PIO_1,	0xc0d08572	},
-	{	XFER_PIO_0,	0xc0d08585	},
-	{	0,		0x01208585	}
+static u32 forty_base_hpt36x[] = {
+	/* XFER_UDMA_6 */	0x900fd943,
+	/* XFER_UDMA_5 */	0x900fd943,
+	/* XFER_UDMA_4 */	0x900fd943,
+	/* XFER_UDMA_3 */	0x900ad943,
+	/* XFER_UDMA_2 */	0x900bd943,
+	/* XFER_UDMA_1 */	0x9008d943,
+	/* XFER_UDMA_0 */	0x9008d943,
+
+	/* XFER_MW_DMA_2 */	0xa008d943,
+	/* XFER_MW_DMA_1 */	0xa010d955,
+	/* XFER_MW_DMA_0 */	0xa010d9fc,
+
+	/* XFER_PIO_4 */	0xc008d963,
+	/* XFER_PIO_3 */	0xc010d974,
+	/* XFER_PIO_2 */	0xc010d997,
+	/* XFER_PIO_1 */	0xc010d9c7,
+	/* XFER_PIO_0 */	0xc018d9d9
 };
 
-/* from highpoint documentation. these are old values */
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt370[] = {
-/*	{	XFER_UDMA_5,	0x1A85F442,	0x16454e31	}, */
-	{	XFER_UDMA_5,	0x16454e31	},
-	{	XFER_UDMA_4,	0x16454e31	},
-	{	XFER_UDMA_3,	0x166d4e31	},
-	{	XFER_UDMA_2,	0x16494e31	},
-	{	XFER_UDMA_1,	0x164d4e31	},
-	{	XFER_UDMA_0,	0x16514e31	},
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
+static u32 thirty_three_base_hpt36x[] = {
+	/* XFER_UDMA_6 */	0x90c9a731,
+	/* XFER_UDMA_5 */	0x90c9a731,
+	/* XFER_UDMA_4 */	0x90c9a731,
+	/* XFER_UDMA_3 */	0x90cfa731,
+	/* XFER_UDMA_2 */	0x90caa731,
+	/* XFER_UDMA_1 */	0x90cba731,
+	/* XFER_UDMA_0 */	0x90c8a731,
+
+	/* XFER_MW_DMA_2 */	0xa0c8a731,
+	/* XFER_MW_DMA_1 */	0xa0c8a732,	/* 0xa0c8a733 */
+	/* XFER_MW_DMA_0 */	0xa0c8a797,
+
+	/* XFER_PIO_4 */	0xc0c8a731,
+	/* XFER_PIO_3 */	0xc0c8a742,
+	/* XFER_PIO_2 */	0xc0d0a753,
+	/* XFER_PIO_1 */	0xc0d0a7a3,	/* 0xc0d0a793 */
+	/* XFER_PIO_0 */	0xc0d0a7aa	/* 0xc0d0a7a7 */
 };
 
-/* these are the current (4 sep 2001) timings from highpoint */
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt370a[] = {
-	{	XFER_UDMA_5,	0x12446231	},
-	{	XFER_UDMA_4,	0x12446231	},
-	{	XFER_UDMA_3,	0x126c6231	},
-	{	XFER_UDMA_2,	0x12486231	},
-	{	XFER_UDMA_1,	0x124c6233	},
-	{	XFER_UDMA_0,	0x12506297	},
-
-	{	XFER_MW_DMA_2,	0x22406c31	},
-	{	XFER_MW_DMA_1,	0x22406c33	},
-	{	XFER_MW_DMA_0,	0x22406c97	},
-
-	{	XFER_PIO_4,	0x06414e31	},
-	{	XFER_PIO_3,	0x06414e42	},
-	{	XFER_PIO_2,	0x06414e53	},
-	{	XFER_PIO_1,	0x06814e93	},
-	{	XFER_PIO_0,	0x06814ea7	},
-	{	0,		0x06814ea7	}
+static u32 twenty_five_base_hpt36x[] = {
+	/* XFER_UDMA_6 */	0x90c98521,
+	/* XFER_UDMA_5 */	0x90c98521,
+	/* XFER_UDMA_4 */	0x90c98521,
+	/* XFER_UDMA_3 */	0x90cf8521,
+	/* XFER_UDMA_2 */	0x90cf8521,
+	/* XFER_UDMA_1 */	0x90cb8521,
+	/* XFER_UDMA_0 */	0x90cb8521,
+
+	/* XFER_MW_DMA_2 */	0xa0ca8521,
+	/* XFER_MW_DMA_1 */	0xa0ca8532,
+	/* XFER_MW_DMA_0 */	0xa0ca8575,
+
+	/* XFER_PIO_4 */	0xc0ca8521,
+	/* XFER_PIO_3 */	0xc0ca8532,
+	/* XFER_PIO_2 */	0xc0ca8542,
+	/* XFER_PIO_1 */	0xc0d08572,
+	/* XFER_PIO_0 */	0xc0d08585
 };
 
-static struct chipset_bus_clock_list_entry fifty_base_hpt370a[] = {
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
-	{	0,		0x0ac1f48a	}
+static u32 thirty_three_base_hpt37x[] = {
+	/* XFER_UDMA_6 */	0x12446231,	/* 0x12646231 ?? */
+	/* XFER_UDMA_5 */	0x12446231,
+	/* XFER_UDMA_4 */	0x12446231,
+	/* XFER_UDMA_3 */	0x126c6231,
+	/* XFER_UDMA_2 */	0x12486231,
+	/* XFER_UDMA_1 */	0x124c6233,
+	/* XFER_UDMA_0 */	0x12506297,
+
+	/* XFER_MW_DMA_2 */	0x22406c31,
+	/* XFER_MW_DMA_1 */	0x22406c33,
+	/* XFER_MW_DMA_0 */	0x22406c97,
+
+	/* XFER_PIO_4 */	0x06414e31,
+	/* XFER_PIO_3 */	0x06414e42,
+	/* XFER_PIO_2 */	0x06414e53,
+	/* XFER_PIO_1 */	0x06814e93,
+	/* XFER_PIO_0 */	0x06814ea7
 };
 
-static struct chipset_bus_clock_list_entry thirty_three_base_hpt372[] = {
-	{	XFER_UDMA_6,	0x12446231	},	/* 0x12646231 ?? */
-	{	XFER_UDMA_5,	0x12446231	},
-	{	XFER_UDMA_4,	0x12446231	},
-	{	XFER_UDMA_3,	0x126c6231	},
-	{	XFER_UDMA_2,	0x12486231	},
-	{	XFER_UDMA_1,	0x124c6233	},
-	{	XFER_UDMA_0,	0x12506297	},
-
-	{	XFER_MW_DMA_2,	0x22406c31	},
-	{	XFER_MW_DMA_1,	0x22406c33	},
-	{	XFER_MW_DMA_0,	0x22406c97	},
-
-	{	XFER_PIO_4,	0x06414e31	},
-	{	XFER_PIO_3,	0x06414e42	},
-	{	XFER_PIO_2,	0x06414e53	},
-	{	XFER_PIO_1,	0x06814e93	},
-	{	XFER_PIO_0,	0x06814ea7	},
-	{	0,		0x06814ea7	}
+static u32 fifty_base_hpt37x[] = {
+	/* XFER_UDMA_6 */	0x12848242,
+	/* XFER_UDMA_5 */	0x12848242,
+	/* XFER_UDMA_4 */	0x12ac8242,
+	/* XFER_UDMA_3 */	0x128c8242,
+	/* XFER_UDMA_2 */	0x120c8242,
+	/* XFER_UDMA_1 */	0x12148254,
+	/* XFER_UDMA_0 */	0x121882ea,
+
+	/* XFER_MW_DMA_2 */	0x22808242,
+	/* XFER_MW_DMA_1 */	0x22808254,
+	/* XFER_MW_DMA_0 */	0x228082ea,
+
+	/* XFER_PIO_4 */	0x0a81f442,
+	/* XFER_PIO_3 */	0x0a81f443,
+	/* XFER_PIO_2 */	0x0a81f454,
+	/* XFER_PIO_1 */	0x0ac1f465,
+	/* XFER_PIO_0 */	0x0ac1f48a
 };
 
-static struct chipset_bus_clock_list_entry fifty_base_hpt372[] = {
-	{	XFER_UDMA_6,	0x12848242	},
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
-	{	0,		0x0a81f443	}
-};
-
-static struct chipset_bus_clock_list_entry sixty_six_base_hpt372[] = {
-	{	XFER_UDMA_6,	0x1c869c62	},
-	{	XFER_UDMA_5,	0x1cae9c62	},	/* 0x1c8a9c62 */
-	{	XFER_UDMA_4,	0x1c8a9c62	},
-	{	XFER_UDMA_3,	0x1c8e9c62	},
-	{	XFER_UDMA_2,	0x1c929c62	},
-	{	XFER_UDMA_1,	0x1c9a9c62	},
-	{	XFER_UDMA_0,	0x1c829c62	},
-
-	{	XFER_MW_DMA_2,	0x2c829c62	},
-	{	XFER_MW_DMA_1,	0x2c829c66	},
-	{	XFER_MW_DMA_0,	0x2c829d2e	},
-
-	{	XFER_PIO_4,	0x0c829c62	},
-	{	XFER_PIO_3,	0x0c829c84	},
-	{	XFER_PIO_2,	0x0c829ca6	},
-	{	XFER_PIO_1,	0x0d029d26	},
-	{	XFER_PIO_0,	0x0d029d5e	},
-	{	0,		0x0d029d26	}
+static u32 sixty_six_base_hpt37x[] = {
+	/* XFER_UDMA_6 */	0x1c869c62,
+	/* XFER_UDMA_5 */	0x1cae9c62,	/* 0x1c8a9c62 */
+	/* XFER_UDMA_4 */	0x1c8a9c62,
+	/* XFER_UDMA_3 */	0x1c8e9c62,
+	/* XFER_UDMA_2 */	0x1c929c62,
+	/* XFER_UDMA_1 */	0x1c9a9c62,
+	/* XFER_UDMA_0 */	0x1c829c62,
+
+	/* XFER_MW_DMA_2 */	0x2c829c62,
+	/* XFER_MW_DMA_1 */	0x2c829c66,
+	/* XFER_MW_DMA_0 */	0x2c829d2e,
+
+	/* XFER_PIO_4 */	0x0c829c62,
+	/* XFER_PIO_3 */	0x0c829c84,
+	/* XFER_PIO_2 */	0x0c829ca6,
+	/* XFER_PIO_1 */	0x0d029d26,
+	/* XFER_PIO_0 */	0x0d029d5e
 };
 
 #define HPT366_DEBUG_DRIVE_INFO		0
@@ -408,7 +361,7 @@ struct hpt_info
 #define IS_3xxN 	2
 #define PCI_66MHZ	4
 				/* Speed table */
-	struct chipset_bus_clock_list_entry *speed;
+	u32 *speed;
 };
 
 /*
@@ -545,12 +498,20 @@ static int check_in_drive_lists (ide_dri
 	return 0;
 }
 
-static unsigned int pci_bus_clock_list (u8 speed, struct chipset_bus_clock_list_entry * chipset_table)
+static u32 pci_bus_clock_list(u8 speed, u32 *chipset_table)
 {
-	for ( ; chipset_table->xfer_speed ; chipset_table++)
-		if (chipset_table->xfer_speed == speed)
-			return chipset_table->chipset_settings;
-	return chipset_table->chipset_settings;
+	int i;
+
+	/*
+	 * Lookup the transfer mode table to get the index into
+	 * the timing table.
+	 *
+	 * NOTE: For XFER_PIO_SLOW, PIO mode 0 timings will be used.
+	 */
+	for (i = 0; i < ARRAY_SIZE(xfer_speeds) - 1; i++)
+		if (xfer_speeds[i] == speed)
+			break;
+	return chipset_table[i];
 }
 
 static int hpt36x_tune_chipset(ide_drive_t *drive, u8 xferspeed)
@@ -1035,14 +996,14 @@ static void __devinit hpt366_clocking(id
 	/* detect bus speed by looking at control reg timing: */
 	switch((reg1 >> 8) & 7) {
 		case 5:
-			info->speed = forty_base_hpt366;
+			info->speed = forty_base_hpt36x;
 			break;
 		case 9:
-			info->speed = twenty_five_base_hpt366;
+			info->speed = twenty_five_base_hpt36x;
 			break;
 		case 7:
 		default:
-			info->speed = thirty_three_base_hpt366;
+			info->speed = thirty_three_base_hpt36x;
 			break;
 	}
 }
@@ -1124,27 +1085,16 @@ static void __devinit hpt37x_clocking(id
 			pll = F_LOW_PCI_66;
 	
 		if (pll == F_LOW_PCI_33) {
-			if (info->revision >= 5)
-				info->speed = thirty_three_base_hpt372;
-			else if (info->revision >= 4)
-				info->speed = thirty_three_base_hpt370a;
-			else
-				info->speed = thirty_three_base_hpt370;
+			info->speed = thirty_three_base_hpt37x;
 			printk(KERN_DEBUG "HPT37X: using 33MHz PCI clock\n");
 		} else if (pll == F_LOW_PCI_40) {
 			/* Unsupported */
 		} else if (pll == F_LOW_PCI_50) {
-			if (info->revision >= 5)
-				info->speed = fifty_base_hpt372;
-			else
-				info->speed = fifty_base_hpt370a;
+			info->speed = fifty_base_hpt37x;
 			printk(KERN_DEBUG "HPT37X: using 50MHz PCI clock\n");
 		} else {
-			if (info->revision >= 5) {
-				info->speed = sixty_six_base_hpt372;
-				printk(KERN_DEBUG "HPT37X: using 66MHz PCI clock\n");
-			} else
-				printk(KERN_ERR "HPT37x: 66MHz timings not supported.\n");
+			info->speed = sixty_six_base_hpt37x;
+			printk(KERN_DEBUG "HPT37X: using 66MHz PCI clock\n");
 		}
 	}
 
@@ -1191,14 +1141,8 @@ static void __devinit hpt37x_clocking(id
 				pci_write_config_dword(dev, 0x5c, 
 						       pll & ~0x100);
 				pci_write_config_byte(dev, 0x5b, 0x21);
-				if (info->revision >= 8)
-					info->speed = fifty_base_hpt370a;
-				else if (info->revision >= 5)
-					info->speed = fifty_base_hpt372;
-				else if (info->revision >= 4)
-					info->speed = fifty_base_hpt370a;
-				else
-					info->speed = fifty_base_hpt370a;
+
+				info->speed = fifty_base_hpt37x;
 				printk("HPT37X: using 50MHz internal PLL\n");
 				goto init_hpt37X_done;
 			}



--------------020505080807010405080108--
