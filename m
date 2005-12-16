Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932080AbVLPCRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbVLPCRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 21:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVLPCRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 21:17:37 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:29155 "EHLO
	mailout3.samsung.com") by vger.kernel.org with ESMTP
	id S932080AbVLPCRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 21:17:37 -0500
Date: Fri, 16 Dec 2005 11:17:29 +0900
From: Kyungmin Park <kyungmin.park@samsung.com>
Subject: RE: drivers/mtd/onenand/: unacceptable stack usage
In-reply-to: <20051216005505.GW23349@stusta.de>
To: "'Adrian Bunk'" <bunk@stusta.de>
Cc: dwmw2@infradead.org, linux-mtd@lists.infradead.org,
       "'Linus Torvalds'" <torvalds@osdl.org>,
       "'Andrew Morton'" <akpm@osdl.org>, linux-kernel@vger.kernel.org
Reply-to: kyungmin.park@samsung.com
Message-id: <0IRK00I50JP6FZ@mmp1.samsung.com>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Thread-index: AcYB21rUSo89ZMh+R0a3mzso9wa7/QABZPqQ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

OK. I change the source code. 
It is working well on OMAP H4 with 2.6.15-rc4 kernel and LTP fs test is
passed.

And please apply the recent onenand patch

	- check correct manufacturer 
	- unlock problem in DDP (Double Density Package)
	- add platform_device.h instead of device.h

Thank you

Kyungmin Park

1. check correct manufacturer

Index: drivers/mtd/onenand/onenand_base.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/onenand/onenand_base.c,v
retrieving revision 1.8
diff -u -p -r1.8 onenand_base.c
--- drivers/mtd/onenand/onenand_base.c	29 Nov 2005 14:49:36 -0000	1.8
+++ drivers/mtd/onenand/onenand_base.c	2 Dec 2005 06:20:29 -0000
@@ -1346,7 +1346,6 @@ static void onenand_print_device_info(in
 
 static const struct onenand_manufacturers onenand_manuf_ids[] = {
         {ONENAND_MFR_SAMSUNG, "Samsung"},
-        {ONENAND_MFR_UNKNOWN, "Unknown"}
 };
 
 /**
@@ -1357,17 +1356,22 @@ static const struct onenand_manufacturer
  */
 static int onenand_check_maf(int manuf)
 {
+	int size = ARRAY_SIZE(onenand_manuf_ids);
+	char *name;
         int i;
 
-        for (i = 0; onenand_manuf_ids[i].id; i++) {
+        for (i = 0; i < size; i++)
                 if (manuf == onenand_manuf_ids[i].id)
                         break;
-        }
 
-        printk(KERN_DEBUG "OneNAND Manufacturer: %s (0x%0x)\n",
-                onenand_manuf_ids[i].name, manuf);
+	if (i < size)
+		name = onenand_manuf_ids[i].name;
+	else
+		name = "Unknown";
+
+        printk(KERN_DEBUG "OneNAND Manufacturer: %s (0x%0x)\n", name,
manuf);
 
-        return (i != ONENAND_MFR_UNKNOWN);
+        return (i == size);
 }
 
 /**
Index: include/linux/mtd/onenand.h
===================================================================
RCS file: /home/cvs/mtd/include/linux/mtd/onenand.h,v
retrieving revision 1.8
diff -u -p -r1.8 onenand.h
--- include/linux/mtd/onenand.h	7 Nov 2005 11:14:55 -0000	1.8
+++ include/linux/mtd/onenand.h	2 Dec 2005 06:20:30 -0000
@@ -140,7 +140,6 @@ struct onenand_chip {
  * OneNAND Flash Manufacturer ID Codes
  */
 #define ONENAND_MFR_SAMSUNG	0xec
-#define ONENAND_MFR_UNKNOWN	0x00
 
 /**
  * struct nand_manufacturers - NAND Flash Manufacturer ID Structure

2. unlock problem in DDP

Index: drivers/mtd/onenand/onenand_base.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/onenand/onenand_base.c,v
retrieving revision 1.9
diff -u -p -r1.9 onenand_base.c
--- drivers/mtd/onenand/onenand_base.c	2 Dec 2005 07:43:37 -0000	1.9
+++ drivers/mtd/onenand/onenand_base.c	16 Dec 2005 00:37:59 -0000
@@ -1296,6 +1296,12 @@ static int onenand_unlock(struct mtd_inf
 
 	/* Block lock scheme */
 	for (block = start; block < end; block++) {
+		/* Set block address */
+		value = onenand_block_address(this, block);
+		this->write_word(value, this->base +
ONENAND_REG_START_ADDRESS1);
+		/* Select DataRAM for DDP */
+		value = onenand_bufferram_address(this, block);
+		this->write_word(value, this->base +
ONENAND_REG_START_ADDRESS2);
 		/* Set start block address */
 		this->write_word(block, this->base +
ONENAND_REG_START_BLOCK_ADDRESS);
 		/* Write unlock command */
@@ -1309,10 +1315,6 @@ static int onenand_unlock(struct mtd_inf
 		    & ONENAND_CTRL_ONGO)
 			continue;
 
-		/* Set block address for read block status */
-		value = onenand_block_address(this, block);
-		this->write_word(value, this->base +
ONENAND_REG_START_ADDRESS1);
-
 		/* Check lock status */
 		status = this->read_word(this->base +
ONENAND_REG_WP_STATUS);
 		if (!(status & ONENAND_WP_US))


# reduce stack usage

Index: drivers/mtd/onenand/onenand_base.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/onenand/onenand_base.c,v
retrieving revision 1.10
diff -u -p -r1.10 onenand_base.c
--- drivers/mtd/onenand/onenand_base.c	16 Dec 2005 00:41:48 -0000	1.10
+++ drivers/mtd/onenand/onenand_base.c	16 Dec 2005 01:45:15 -0000
@@ -940,7 +940,7 @@ static int onenand_writev_ecc(struct mtd
 	u_char *eccbuf, struct nand_oobinfo *oobsel)
 {
 	struct onenand_chip *this = mtd->priv;
-	unsigned char buffer[MAX_ONENAND_PAGESIZE], *pbuf;
+	unsigned char *pbuf;
 	size_t total_len, len;
 	int i, written = 0;
 	int ret = 0;
@@ -975,7 +975,7 @@ static int onenand_writev_ecc(struct mtd
 	/* Loop until all keve's data has been written */
 	len = 0;
 	while (count) {
-		pbuf = buffer;
+		pbuf = this->page_buf;
 		/*
 		 * If the given tuple is >= pagesize then
 		 * write it out from the iov
@@ -995,7 +995,7 @@ static int onenand_writev_ecc(struct mtd
 			int cnt = 0, thislen;
 			while (cnt < mtd->oobblock) {
 				thislen = min_t(int, mtd->oobblock - cnt,
vecs->iov_len - len);
-				memcpy(buffer + cnt, vecs->iov_base + len,
thislen);
+				memcpy(this->page_buf + cnt, vecs->iov_base
+ len, thislen);
 				cnt += thislen;
 				len += thislen;
 
@@ -1519,6 +1519,18 @@ int onenand_scan(struct mtd_info *mtd, i
 		this->read_bufferram = onenand_sync_read_bufferram;
 	}
 
+	/* Allocate buffers, if necessary */
+	if (!this->page_buf) {
+		size_t len;
+		len = mtd->oobblock + mtd->oobsize;
+		this->page_buf = kmalloc(len, GFP_KERNEL);
+		if (!this->page_buf) {
+			printk(KERN_ERR "onenand_scan(): Can't allocate
page_buf\n");
+			return -ENOMEM;
+		}
+		this->options |= ONENAND_PAGEBUF_ALLOC;
+	}
+
 	this->state = FL_READY;
 	init_waitqueue_head(&this->wq);
 	spin_lock_init(&this->chip_lock);
@@ -1580,12 +1592,21 @@ int onenand_scan(struct mtd_info *mtd, i
  */
 void onenand_release(struct mtd_info *mtd)
 {
+	struct onenand_chip *this = mtd->priv;
+
 #ifdef CONFIG_MTD_PARTITIONS
 	/* Deregister partitions */
 	del_mtd_partitions (mtd);
 #endif
 	/* Deregister the device */
 	del_mtd_device (mtd);
+
+	/* Free bad block table memory, if allocated */
+	if (this->bbm)
+		kfree(this->bbm);
+	/* Buffer allocated by onenand_scan */
+	if (this->options & ONENAND_PAGEBUF_ALLOC)
+		kfree(this->page_buf);
 }
 
 EXPORT_SYMBOL_GPL(onenand_scan);
Index: drivers/mtd/onenand/onenand_bbt.c
===================================================================
RCS file: /home/cvs/mtd/drivers/mtd/onenand/onenand_bbt.c,v
retrieving revision 1.1
diff -u -p -r1.1 onenand_bbt.c
--- drivers/mtd/onenand/onenand_bbt.c	27 Sep 2005 10:26:36 -0000	1.1
+++ drivers/mtd/onenand/onenand_bbt.c	16 Dec 2005 01:45:15 -0000
@@ -118,10 +118,10 @@ static int create_bbt(struct mtd_info *m
  */
 static inline int onenand_memory_bbt (struct mtd_info *mtd, struct
nand_bbt_descr *bd)
 {
-	unsigned char data_buf[MAX_ONENAND_PAGESIZE];
+	struct onenand_chip *this = mtd->priv;
 
         bd->options &= ~NAND_BBT_SCANEMPTY;
-        return create_bbt(mtd, data_buf, bd, -1);
+        return create_bbt(mtd, this->page_buf, bd, -1);
 }
 
 /**
Index: include/linux/mtd/onenand.h
===================================================================
RCS file: /home/cvs/mtd/include/linux/mtd/onenand.h,v
retrieving revision 1.9
diff -u -p -r1.9 onenand.h
--- include/linux/mtd/onenand.h	2 Dec 2005 07:43:38 -0000	1.9
+++ include/linux/mtd/onenand.h	16 Dec 2005 01:45:15 -0000
@@ -17,7 +17,6 @@
 #include <linux/mtd/bbm.h>
 
 #define MAX_BUFFERRAM		2
-#define MAX_ONENAND_PAGESIZE	(2048 + 64)
 
 /* Scan and identify a OneNAND device */
 extern int onenand_scan(struct mtd_info *mtd, int max_chips);
@@ -110,6 +109,7 @@ struct onenand_chip {
 	spinlock_t		chip_lock;
 	wait_queue_head_t	wq;
 	onenand_state_t		state;
+	unsigned char		*page_buf;
 
 	struct nand_oobinfo	*autooob;
 
@@ -134,7 +134,7 @@ struct onenand_chip {
  * Options bits
  */
 #define ONENAND_CONT_LOCK		(0x0001)
-
+#define ONENAND_PAGEBUF_ALLOC		(0x1000)
 
 /*
  * OneNAND Flash Manufacturer ID Codes

4. Add platform_device.h instead device.h

diff --git a/drivers/mtd/onenand/generic.c b/drivers/mtd/onenand/generic.c
--- a/drivers/mtd/onenand/generic.c
+++ b/drivers/mtd/onenand/generic.c
@@ -12,9 +12,9 @@
  *   This is a device driver for the OneNAND flash for generic boards.
  */

-#include <linux/device.h>
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/platform_device.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/onenand.h>
 #include <linux/mtd/partitions.h>
@@ -39,7 +39,7 @@ static int __devinit generic_onenand_pro
 {
        struct onenand_info *info;
        struct platform_device *pdev = to_platform_device(dev);
-       struct onenand_platform_data *pdata = pdev->dev.platform_data;
+       struct flash_platform_data *pdata = pdev->dev.platform_data;
        struct resource *res = pdev->resource;
        unsigned long size = res->end - res->start + 1;
        int err;
--

> -----Original Message-----
> From: Adrian Bunk [mailto:bunk@stusta.de] 
> Sent: Friday, December 16, 2005 9:55 AM
> To: Kyungmin Park
> Cc: dwmw2@infradead.org; linux-mtd@lists.infradead.org; Linus 
> Torvalds; Andrew Morton; linux-kernel@vger.kernel.org
> Subject: drivers/mtd/onenand/: unacceptable stack usage
> 
> In 2.6.15-rc, the following driver was added:
> 
> 
> include/linux/mtd/onenand.h:
> #define MAX_ONENAND_PAGESIZE        (2048 + 64)
> 
> 
> drivers/mtd/onenand/onenand_base.c:
> static int onenand_writev_ecc(struct mtd_info *mtd, const 
> struct kvec *vecs,
>         unsigned long count, loff_t to, size_t *retlen,
>         u_char *eccbuf, struct nand_oobinfo *oobsel)
> {
>         struct onenand_chip *this = mtd->priv;
>         unsigned char buffer[MAX_ONENAND_PAGESIZE], *pbuf;
> 
> 
> drivers/mtd/onenand/onenand_bbt.c:
> static inline int onenand_memory_bbt (struct mtd_info *mtd, 
> struct nand_bbt_descr *bd)
> {
>         unsigned char data_buf[MAX_ONENAND_PAGESIZE];
> 
> 
> These are variables on the stack that are > 2kB which is not 
> acceptable 
> since the complete stack might be only 4kB.
> 
> 
> Please either fix this before 2.6.15 or mark the MTD_ONENAND 
> driver as 
> BROKEN until it's fixed.
> 
> 
> TIA
> Adrian
> 
> -- 
> 
>        "Is there not promise of rain?" Ling Tan asked suddenly out
>         of the darkness. There had been need of rain for many days.
>        "Only a promise," Lao Er said.
>                                        Pearl S. Buck - Dragon Seed
> 
> 
> 

