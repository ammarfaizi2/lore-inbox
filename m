Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422676AbVLOKBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422676AbVLOKBe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 05:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422683AbVLOKBd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 05:01:33 -0500
Received: from rtsoft2.corbina.net ([85.21.88.2]:37565 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S1422676AbVLOKBc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 05:01:32 -0500
Date: Thu, 15 Dec 2005 13:02:05 +0300
From: Vitaly Wool <vwool@ru.mvista.com>
To: linux-kernel@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net, david-b@pacbell.net,
       dpervushin@gmail.com, akpm@osdl.org, greg@kroah.com,
       basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, Joachim_Jaeger@digi.com
Subject: Re: [PATCH 2.6-git 2/3] SPI core refresh: MTD dataflash driver
Message-Id: <20051215130205.2ebdea18.vwool@ru.mvista.com>
In-Reply-To: <20051215130027.1347634b.vwool@ru.mvista.com>
References: <20051215125800.4fa95de6.vwool@ru.mvista.com>
	<20051215130027.1347634b.vwool@ru.mvista.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Dmitry Pervushin <dpervushin@gmail.com>
Signed-off-by: Vitaly Wool <vwool@ru.mvista.com>

 drivers/mtd/devices/Kconfig         |    8
 drivers/mtd/devices/Makefile        |    1
 drivers/mtd/devices/mtd_dataflash.c |  601 ++++++++++++++++++++++++++++++++++++
 include/linux/spi/flash.h           |   27 +
 4 files changed, 637 insertions(+)

Index: linux-2.6.orig/drivers/mtd/devices/Kconfig
===================================================================
--- linux-2.6.orig.orig/drivers/mtd/devices/Kconfig
+++ linux-2.6.orig/drivers/mtd/devices/Kconfig
@@ -255,5 +255,13 @@ config MTD_DOCPROBE_55AA
 	  LinuxBIOS or if you need to recover a DiskOnChip Millennium on which
 	  you have managed to wipe the first block.
 
+config MTD_DATAFLASH
+	tristate "Support for AT45xxx DataFlash"
+	depends on MTD && SPI && EXPERIMENTAL
+	help
+	  This enables access to AT45xxx DataFlash chips, using SPI.
+	  Sometimes DataFlash chips are packaged inside MMC-format
+	  cards; at this writing, the MMC stack won't handle those.
+
 endmenu
 
Index: linux-2.6.orig/drivers/mtd/devices/Makefile
===================================================================
--- linux-2.6.orig.orig/drivers/mtd/devices/Makefile
+++ linux-2.6.orig/drivers/mtd/devices/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_MTD_MTDRAM)	+= mtdram.o
 obj-$(CONFIG_MTD_LART)		+= lart.o
 obj-$(CONFIG_MTD_BLKMTD)	+= blkmtd.o
 obj-$(CONFIG_MTD_BLOCK2MTD)	+= block2mtd.o
+obj-$(CONFIG_MTD_DATAFLASH)	+= mtd_dataflash.o
Index: linux-2.6.orig/drivers/mtd/devices/mtd_dataflash.c
===================================================================
--- /dev/null
+++ linux-2.6.orig/drivers/mtd/devices/mtd_dataflash.c
@@ -0,0 +1,601 @@
+/*
+ * Atmel AT45xxx DataFlash MTD driver for lightweight SPI framework
+ *
+ * Largely derived from at91_dataflash.c:
+ *  Copyright (C) 2003-2005 SAN People (Pty) Ltd
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+*/
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/spi.h>
+#include <linux/spi/flash.h>
+
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/partitions.h>
+
+
+/*
+ * DataFlash is a kind of SPI flash.  Most AT45 chips have two buffers in
+ * each chip, which may be used for double buffered I/O; but this driver
+ * doesn't (yet) use these for any kind of i/o overlap or prefetching.
+ *
+ * Sometimes DataFlash is packaged in MMC-format cards.  This driver does
+ * not (yet) expect to be hotplugged through MMC or SPI.  That's fair,
+ * since the MMC stack can't even use SPI (yet), much less distinguish
+ * between MMC and DataFlash protocols during enumeration.
+ */
+
+#define CONFIG_DATAFLASH_WRITE_VERIFY
+
+
+/* reads can bypass the buffers */
+#define OP_READ_CONTINUOUS	0xE8
+#define OP_READ_PAGE		0xD2
+
+/* group B requests can run even while status reports "busy" */
+#define OP_READ_STATUS		0xD7	/* group B */
+
+/* move data between host and buffer */
+#define OP_READ_BUFFER1		0xD4	/* group B */
+#define OP_READ_BUFFER2		0xD6	/* group B */
+#define OP_WRITE_BUFFER1	0x84	/* group B */
+#define OP_WRITE_BUFFER2	0x87	/* group B */
+
+/* erasing flash */
+#define OP_ERASE_PAGE		0x81
+#define OP_ERASE_BLOCK		0x50
+
+/* move data between buffer and flash */
+#define OP_TRANSFER_BUF1	0x53
+#define OP_TRANSFER_BUF2	0x55
+#define OP_MREAD_BUFFER1	0xD4
+#define OP_MREAD_BUFFER2	0xD6
+#define OP_MWERASE_BUFFER1	0x83
+#define OP_MWERASE_BUFFER2	0x86
+#define OP_MWRITE_BUFFER1	0x88	/* sector must be pre-erased */
+#define OP_MWRITE_BUFFER2	0x89	/* sector must be pre-erased */
+
+/* write to buffer, then write-erase to flash */
+#define OP_PROGRAM_VIA_BUF1	0x82
+#define OP_PROGRAM_VIA_BUF2	0x85
+
+/* compare buffer to flash */
+#define OP_COMPARE_BUF1		0x60
+#define OP_COMPARE_BUF2		0x61
+
+/* read flash to buffer, then write-erase to flash */
+#define OP_REWRITE_VIA_BUF1	0x58
+#define OP_REWRITE_VIA_BUF2	0x59
+
+/* newer chips report JEDEC manufacturer and device IDs; chip
+ * serial number and OTP bits; and per-sector writeprotect.
+ */
+#define OP_READ_ID		0x9F
+#define OP_READ_SECURITY	0x77
+#define OP_WRITE_SECURITY	0x9A	/* OTP bits */
+
+
+struct dataflash {
+	u8			command[4];
+	char			name[24];
+
+	unsigned short		page_offset;	/* offset in flash address */
+	unsigned int		page_size;	/* of bytes per page */
+
+	struct semaphore	lock;
+	struct spi_device	*spi;
+
+	struct mtd_info		mtd;
+};
+
+/* ......................................................................... */
+
+/*
+ * Return the status of the DataFlash device.
+ */
+static inline int dataflash_status(struct spi_device *spi)
+{
+	/* NOTE:  at45db321c over 25 MHz wants to write
+	 * a dummy byte after the opcode...
+	 */
+	return spi_w8r8(spi, OP_READ_STATUS);
+}
+
+/*
+ * Poll the DataFlash device until it is READY.
+ * This usually takes 5-20 msec or so; more for sector erase.
+ */
+static int dataflash_waitready(struct spi_device *spi)
+{
+	int	status;
+
+	for (;;) {
+		status = dataflash_status(spi);
+		if (status < 0) {
+			DEBUG(MTD_DEBUG_LEVEL1, "%s: status %d?\n",
+					spi->dev.bus_id, status);
+			status = 0;
+		}
+
+		if (status & (1 << 7))	/* RDY/nBSY */
+			return status;
+
+		msleep(3);
+	}
+}
+
+/* ......................................................................... */
+
+/*
+ * Erase pages of flash.
+ */
+static int dataflash_erase(struct mtd_info *mtd, struct erase_info *instr)
+{
+	struct dataflash	*priv = (struct dataflash *)mtd->priv;
+	struct spi_device	*spi = priv->spi;
+	u8			*command;
+
+	DEBUG(MTD_DEBUG_LEVEL2, "%s: erase addr=%x len %x\n",
+			spi->dev.bus_id,
+			instr->addr, instr->len);
+
+	/* Sanity checks */
+	if ((instr->addr + instr->len) > mtd->size
+			|| (instr->len % priv->page_size) != 0
+			|| (instr->addr % priv->page_size) != 0)
+		return -EINVAL;
+
+	command = priv->command;
+
+	down(&priv->lock);
+	while (instr->len > 0) {
+		unsigned int	pageaddr;
+		int		status;
+
+		/* Calculate flash page address */
+		// REVISIT: pageaddr == instr->addr, yes???
+		pageaddr = (instr->addr / priv->page_size) << priv->page_offset;
+
+		/* REVISIT block erase is faster, if this page is at a block
+		 * boundary and the next eight pages must all be erased ...
+		 */
+		command[0] = OP_ERASE_PAGE;
+		command[1] = (u8)(pageaddr >> 16);
+		command[2] = (u8)(pageaddr >> 8);
+		command[3] = 0;
+
+		DEBUG(MTD_DEBUG_LEVEL3, "ERASE: (%x) %x %x %x [%i]\n",
+			command[0], command[1], command[2], command[3],
+			pageaddr);
+
+		status = spi_write (spi, SPI_M_CS | SPI_M_CSREL, command, 4);
+		(void) dataflash_waitready(spi);
+
+		if (status < 0) {
+			printk(KERN_ERR "%s: erase %x, err %d\n",
+				spi->dev.bus_id, pageaddr, status);
+			continue;
+		}
+
+		instr->addr += priv->page_size;	/* next page */
+		instr->len -= priv->page_size;
+	}
+	up(&priv->lock);
+
+	/* Inform MTD subsystem that erase is complete */
+	instr->state = MTD_ERASE_DONE;
+	mtd_erase_callback(instr);
+
+	return 0;
+}
+
+/*
+ * Read from the DataFlash device.
+ *   from   : Start offset in flash device
+ *   len    : Amount to read
+ *   retlen : About of data actually read
+ *   buf    : Buffer containing the data
+ */
+static int dataflash_read(struct mtd_info *mtd, loff_t from, size_t len,
+			       size_t *retlen, u_char *buf)
+{
+	struct dataflash	*priv = (struct dataflash *)mtd->priv;
+	unsigned int		addr;
+	u8			*command;
+	int			status = 0;
+	struct spi_msg		*msg;
+
+	DEBUG(MTD_DEBUG_LEVEL2, "%s: read %x..%x\n",
+		priv->spi->dev.bus_id, (unsigned)from, (unsigned)(from + len));
+
+	*retlen = 0;
+
+	/* Sanity checks */
+	if (!len)
+		return 0;
+	if (from + len > mtd->size)
+		return -EINVAL;
+
+	/* Calculate flash page/byte address */
+	addr = (((unsigned)from / priv->page_size) << priv->page_offset)
+		+ ((unsigned)from % priv->page_size);
+
+	command = priv->command;
+
+	DEBUG(MTD_DEBUG_LEVEL3, "READ: (%x) %x %x %x\n",
+		command[0], command[1], command[2], command[3]);
+
+	down(&priv->lock);
+
+	/* Continuous read, max clock = f(car) which may be less than
+	 * the peak rate available.  Some chips support commands with
+	 * fewer "don't care" bytes.  Both buffers stay unchanged.
+	 */
+	command[0] = OP_READ_CONTINUOUS;
+	command[1] = (u8)(addr >> 16);
+	command[2] = (u8)(addr >> 8);
+	command[3] = (u8)(addr >> 0);
+	/* plus 4 "don't care" bytes */
+
+	msg = spimsg_alloc(priv->spi,
+			SPI_M_RD | SPI_M_CS,
+			command,
+			8,
+			NULL);
+	if (!msg) {
+		status = -ENOMEM;
+		goto out;
+	}
+	if (!spimsg_chain(msg,
+			SPI_M_RD | SPI_M_CSREL,
+			buf,
+			len,
+			NULL)) {
+		status = -ENOMEM;
+		goto out;
+	}
+	status = spi_transfer(msg, NULL);
+
+	spimsg_free(msg);
+
+	up(&priv->lock);
+
+	if (status >= 0) {
+		*retlen = status;
+		status = 0;
+	} else
+		DEBUG(MTD_DEBUG_LEVEL1, "%s: read %x..%x --> %d\n",
+			priv->spi->dev.bus_id,
+			(unsigned)from, (unsigned)(from + len),
+			status);
+out:
+	return status;
+}
+
+/*
+ * Write to the DataFlash device.
+ *   to     : Start offset in flash device
+ *   len    : Amount to write
+ *   retlen : Amount of data actually written
+ *   buf    : Buffer containing the data
+ */
+static int dataflash_write(struct mtd_info *mtd, loff_t to, size_t len,
+				size_t * retlen, const u_char * buf)
+{
+	struct dataflash	*priv = (struct dataflash *)mtd->priv;
+	struct spi_device	*spi = priv->spi;
+	unsigned int		pageaddr, addr, offset, writelen;
+	size_t			remaining = len;
+	u_char			*writebuf = (u_char *) buf;
+	int			status = -EINVAL;
+	u8			*command = priv->command;
+	struct spi_msg		*msg;
+
+	DEBUG(MTD_DEBUG_LEVEL2, "%s: write %x..%x\n",
+		spi->dev.bus_id, (unsigned)to, (unsigned)(to + len));
+
+	*retlen = 0;
+
+	/* Sanity checks */
+	if (!len)
+		return 0;
+	if ((to + len) > mtd->size)
+		return -EINVAL;
+
+	pageaddr = ((unsigned)to / priv->page_size);
+	offset = ((unsigned)to % priv->page_size);
+	if (offset + len > priv->page_size)
+		writelen = priv->page_size - offset;
+	else
+		writelen = len;
+
+	down(&priv->lock);
+	while (remaining > 0) {
+		DEBUG(MTD_DEBUG_LEVEL3, "write @ %i:%i len=%i\n",
+			pageaddr, offset, writelen);
+
+		/* REVISIT:
+		 * (a) each page in a sector must be rewritten at least
+		 *     once every 10K sibling erase/program operations.
+		 * (b) for pages that are already erased, we could
+		 *     use WRITE+MWRITE not PROGRAM for ~30% speedup.
+		 * (c) WRITE to buffer could be done while waiting for
+		 *     a previous MWRITE/MWERASE to complete ...
+		 * (d) error handling here seems to be mostly missing.
+		 *
+		 * Two persistent bits per page, plus a per-sector counter,
+		 * could support (a) and (b) ... we might consider using
+		 * the second half of sector zero, which is just one block,
+		 * to track that state.  (On AT91, that sector should also
+		 * support boot-from-DataFlash.)
+		 */
+
+		addr = pageaddr << priv->page_offset;
+
+		/* (1) Maybe transfer partial page to Buffer1 */
+		if (writelen != priv->page_size) {
+			command[0] = OP_TRANSFER_BUF1;
+			command[1] = (addr & 0x00FF0000) >> 16;
+			command[2] = (addr & 0x0000FF00) >> 8;
+			command[3] = 0;
+
+			DEBUG(MTD_DEBUG_LEVEL3, "TRANSFER: (%x) %x %x %x\n",
+				command[0], command[1], command[2], command[3]);
+
+			spi_write (spi, SPI_M_CS | SPI_M_CSREL, command, 4);
+			if (status < 0)
+				DEBUG(MTD_DEBUG_LEVEL1, "%s: xfer %u -> %d \n",
+					spi->dev.bus_id, addr, status);
+
+			(void) dataflash_waitready(priv->spi);
+		}
+
+		/* (2) Program full page via Buffer1 */
+		addr += offset;
+		command[0] = OP_PROGRAM_VIA_BUF1;
+		command[1] = (addr & 0x00FF0000) >> 16;
+		command[2] = (addr & 0x0000FF00) >> 8;
+		command[3] = (addr & 0x000000FF);
+
+		DEBUG(MTD_DEBUG_LEVEL3, "PROGRAM: (%x) %x %x %x\n",
+			command[0], command[1], command[2], command[3]);
+
+		msg = spimsg_alloc(spi,
+			SPI_M_WR | SPI_M_CS,
+			command,
+			4,
+			NULL);
+		if (!msg)
+			return -ENOMEM;
+		if (!spimsg_chain(msg,
+			SPI_M_WR | SPI_M_CSREL,
+			writebuf,
+			writelen,
+			NULL))
+			return -ENOMEM;
+
+		status = spi_transfer(msg, NULL);
+		spimsg_free(msg);
+
+		if (status < 0)
+			DEBUG(MTD_DEBUG_LEVEL1, "%s: pgm %u/%u -> %d \n",
+				spi->dev.bus_id, addr, writelen, status);
+
+		(void) dataflash_waitready(priv->spi);
+
+#ifdef	CONFIG_DATAFLASH_WRITE_VERIFY
+
+		/* (3) Compare to Buffer1 */
+		addr = pageaddr << priv->page_offset;
+		command[0] = OP_COMPARE_BUF1;
+		command[1] = (addr & 0x00FF0000) >> 16;
+		command[2] = (addr & 0x0000FF00) >> 8;
+		command[3] = 0;
+
+		DEBUG(MTD_DEBUG_LEVEL3, "COMPARE: (%x) %x %x %x\n",
+			command[0], command[1], command[2], command[3]);
+
+		status = spi_write (spi, SPI_M_CS | SPI_M_CSREL, command, 4);
+		if (status < 0)
+			DEBUG(MTD_DEBUG_LEVEL1, "%s: compare %u -> %d \n",
+				spi->dev.bus_id, addr, status);
+
+		status = dataflash_waitready(priv->spi);
+
+		/* Check result of the compare operation */
+		if ((status & (1 << 6)) == 1) {
+			printk(KERN_ERR "%s: compare page %u, err %d\n",
+				spi->dev.bus_id, pageaddr, status);
+			remaining = 0;
+			status = -EIO;
+			break;
+		} else
+			status = 0;
+
+#endif	/* CONFIG_DATAFLASH_WRITE_VERIFY */
+
+		remaining = remaining - writelen;
+		pageaddr++;
+		offset = 0;
+		writebuf += writelen;
+		*retlen += writelen;
+
+		if (remaining > priv->page_size)
+			writelen = priv->page_size;
+		else
+			writelen = remaining;
+	}
+	up(&priv->lock);
+
+	return status;
+}
+
+/* ......................................................................... */
+
+/*
+ * Register DataFlash device with MTD subsystem.
+ */
+static int __init
+add_dataflash(struct spi_device *spi, char *name,
+		int nr_pages, int pagesize, int pageoffset)
+{
+	struct dataflash		*priv;
+	struct mtd_info			*device;
+	struct flash_platform_data	*pdata = spi->dev.platform_data;
+
+	priv = (struct dataflash *) kzalloc(sizeof *priv, GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	init_MUTEX(&priv->lock);
+	priv->spi = spi;
+	priv->page_size = pagesize;
+	priv->page_offset = pageoffset;
+
+	/* name must be usable with cmdlinepart */
+	sprintf(priv->name, "mtd-%s",
+			spi->dev.parent->bus_id);  /* mtd-spipnx0 */
+
+	device = &priv->mtd;
+	device->name = (pdata && pdata->name) ? pdata->name : priv->name;
+	device->size = nr_pages * pagesize;
+	device->erasesize = pagesize;
+	device->owner = THIS_MODULE;
+	device->type = MTD_DATAFLASH;
+	device->flags = MTD_CAP_NORFLASH;
+	device->erase = dataflash_erase;
+	device->read = dataflash_read;
+	device->write = dataflash_write;
+	device->priv = priv;
+
+	dev_info(&spi->dev, "%s (%d KBytes)\n", name, device->size/1024);
+	dev_set_drvdata(&spi->dev, priv);
+
+#ifdef CONFIG_MTD_PARTITIONS
+	{
+		struct mtd_partition	*parts;
+		int			nr_parts = 0;
+
+#ifdef CONFIG_MTD_CMDLINE_PARTS
+		static const char *part_probes[] = { "cmdlinepart", NULL, };
+
+		nr_parts = parse_mtd_partitions(device, part_probes, &parts, 0);
+#endif
+
+		if (nr_parts <= 0 && pdata && pdata->parts) {
+			parts = pdata->parts;
+			nr_parts = pdata->nr_parts;
+		}
+
+		if (nr_parts > 0)
+			return add_mtd_partitions(device, parts, nr_parts);
+	}
+#endif
+	return add_mtd_device(device);
+}
+
+/*
+ * Detect and initialize DataFlash device:
+ *
+ *   Device      Density         ID code          #Pages PageSize  Offset
+ *   AT45DB011B  1Mbit   (128K)  xx0011xx (0x0c)    512    264      9
+ *   AT45DB021B  2Mbit   (256K)  xx0101xx (0x14)   1025    264      9
+ *   AT45DB041B  4Mbit   (512K)  xx0111xx (0x1c)   2048    264      9
+ *   AT45DB081B  8Mbit   (1M)    xx1001xx (0x24)   4096    264      9
+ *   AT45DB0161B 16Mbit  (2M)    xx1011xx (0x2c)   4096    528     10
+ *   AT45DB0321B 32Mbit  (4M)    xx1101xx (0x34)   8192    528     10
+ *   AT45DB0642  64Mbit  (8M)    xx111xxx (0x3c)   8192   1056     11
+ *   AT45DB1282  128Mbit (16M)   xx0100xx (0x10)  16384   1056     11
+ */
+static int __init dataflash_probe(struct spi_device *spi)
+{
+	int status;
+
+	/* if there's a device there, assume it's dataflash.
+	 * board setup should have set spi->max_speed_max to
+	 * match f(car) for continuous reads, mode 0 or 3.
+	 */
+	status = dataflash_status(spi);
+	if (status > 0 && status != 0xff) {
+		switch (status & 0x3c) {
+		case 0x0c:	/* 0 0 1 1 x x */
+			status = add_dataflash(spi, "AT45DB011B",
+					512, 264, 9);
+			break;
+		case 0x14:	/* 0 1 0 1 x x */
+			status = add_dataflash(spi, "AT45DB021B",
+					1025, 264, 9);
+			break;
+		case 0x1c:	/* 0 1 1 1 x x */
+			status = add_dataflash(spi, "AT45DB041B",
+					2048, 264, 9);
+			break;
+		case 0x24:	/* 1 0 0 1 x x */
+			status = add_dataflash(spi, "AT45DB081B",
+					4096, 264, 9);
+			break;
+		case 0x2c:	/* 1 0 1 1 x x */
+			status = add_dataflash(spi, "AT45DB161x",
+					4096, 528, 10);
+			break;
+		case 0x34:	/* 1 1 0 1 x x */
+			status = add_dataflash(spi, "AT45DB321x",
+					8192, 528, 10);
+			break;
+		case 0x38:	/* 1 1 1 x x x */
+		case 0x3c:
+			status = add_dataflash(spi, "AT45DB642x",
+					8192, 1056, 11);
+			break;
+		/* obsolete AT45DB1282 not (yet?) supported */
+		default:
+			printk(KERN_WARNING "%s: unsupported device (%x)\n",
+				spi->dev.bus_id, status & 0x3c);
+			status = -EINVAL;
+		}
+	}
+
+	return status;
+}
+
+static int __exit dataflash_remove(struct spi_device *spi)
+{
+	// struct dataflash	*flash = dev_get_drvdata(dev);
+
+	dev_warn(&spi->dev, "implement remove!\n");
+	return -EINVAL;
+}
+
+static struct spi_driver dataflash_driver = {
+	.probe		= dataflash_probe,
+	.remove		= __exit_p(dataflash_remove),
+
+	/* FIXME:  investigate suspend and resume... */
+};
+
+static int __init dataflash_init(void)
+{
+	return spi_driver_add(&dataflash_driver);
+}
+module_init(dataflash_init);
+
+#if 0
+static void __exit dataflash_exit(void)
+{
+	driver_unregister(&dataflash_driver);
+}
+module_exit(dataflash_exit);
+#endif
+
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Andrew Victor, David Brownell");
+MODULE_DESCRIPTION("MTD DataFlash driver");
Index: linux-2.6.orig/include/linux/spi/flash.h
===================================================================
--- /dev/null
+++ linux-2.6.orig/include/linux/spi/flash.h
@@ -0,0 +1,27 @@
+#ifndef LINUX_SPI_FLASH_H
+#define LINUX_SPI_FLASH_H
+
+struct mtd_partition;
+
+/**
+ * struct flash_platform_data: board-specific flash data
+ * @name: optional flash device name (eg, as used with mtdparts=)
+ * @parts: optional array of mtd_partitions for static partitioning
+ * @nr_parts: number of mtd_partitions for static partitoning
+ *
+ * Board init code (in arch/.../mach-xxx/board-yyy.c files) can
+ * provide information about SPI flash parts (such as DataFlash) to
+ * help set up the device and its appropriate default partitioning.
+ *
+ * Note that for DataFlash, sizes for pages, blocks, and sectors are
+ * rarely powers of two; and partitions should be sector-aligned.
+ */
+struct flash_platform_data {
+	char		*name;
+	struct mtd_partition *parts;
+	unsigned int	nr_parts;
+
+	/* we'll likely add more ... use JEDEC IDs, etc */
+};
+
+#endif
