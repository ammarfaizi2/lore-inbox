Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274893AbTHFHXw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 03:23:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274896AbTHFHXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 03:23:31 -0400
Received: from hera.cwi.nl ([192.16.191.8]:43663 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S274893AbTHFHXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 03:23:07 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 6 Aug 2003 09:23:02 +0200 (MEST)
Message-Id: <UTC200308060723.h767N2T02315.aeb@smtp.cwi.nl>
To: B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Add identify decoding 4/4
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here a somewhat uneven commented ide_identify.h.
This is part of a larger patch, but suffices for now.

diff -u --recursive --new-file -X /linux/dontdiff a/include/linux/ide-identify.h b/include/linux/ide-identify.h
--- a/include/linux/ide-identify.h	Thu Jan  1 01:00:00 1970
+++ b/include/linux/ide-identify.h	Wed Aug  6 09:52:17 2003
@@ -0,0 +1,285 @@
+#ifndef _IDE_IDENTIFY_H
+#define _IDE_IDENTIFY_H
+
+#include <linux/hdreg.h>
+
+/*
+ * Decoding the IDENTIFY DEVICE information
+ */
+
+/*
+ * word 0 for CF:
+ *  0x848a
+ *
+ * word 0 for ATA:
+ *  bit 15: 0
+ *  bit 7: removable
+ *  bit 6: not removable
+ *  bit 2: incomplete response
+ *  bit 0: reserved
+ *
+ * word 0 for ATAPI:
+ *  bits 15-14: 1,0
+ *  bit 13: reserved
+ *  bits 12-8: device type
+ *  bit 7: removable
+ *  bits 6-5: drq timing
+ *  bits 4-3: reserved
+ *  bit 2: incomplete response
+ *  bits 1-0: packet size
+ */
+
+static inline int
+ide_is_compactflash(const struct hd_driveid *id) {
+	return (id->config == 0x848a);
+}
+
+static inline int
+ide_is_ata(const struct hd_driveid *id) {
+	return ((id->config & 0x8000) == 0);
+}
+
+static inline int
+ide_is_atapi(const struct hd_driveid *id) {
+	return ((id->config & 0xc000) == 0x8000);
+}
+
+static inline int
+ide_is_removable(const struct hd_driveid *id) {
+	return (id->config & 0x0080);
+}
+
+static inline int
+ide_incomplete_response(const struct hd_driveid *id) {
+	return (id->config & 0x0004);
+}
+
+/* ATAPI packet device identify */
+
+/*
+ * Device type:
+ *  0: direct access, 1: sequential access, 2: printer,
+ *  3: processor, 4: write-once, 5: CD-ROM, 6: scanner,
+ *  7: optical memory, 8: medium changer, 9: communications,
+ *  10,11: graphic arts pre-press devices,
+ *  12: array controller, 13: enclosure services,
+ *  14: reduced block command, 15: optical card reader/writer,
+ *  31: unknown or no device
+ * just like for SCSI
+ */
+static inline int
+atapi_device_type(const struct hd_driveid *id) {
+	return (id->config & 0x1f00) >> 8;
+}
+
+/* 0: slow, 1: interrupt (no longer in ATA5), 2: fast, 3: reserved */
+static inline int
+atapi_drq_type(const struct hd_driveid *id) {
+	return (id->config & 0x0060) >> 5;
+}
+
+static inline int
+atapi_drq_sets_intrq(const struct hd_driveid *id) {
+	return id && (atapi_drq_type(id) == 1);
+}
+
+/* 0: 12 bytes, 1: 16 bytes, 2,3: reserved */
+static inline int
+atapi_packet_size(const struct hd_driveid *id) {
+	return (id->config & 0x0003);
+}
+
+static inline int
+ide_supports_dma(const struct hd_driveid *id) {
+	return (id->capability & 0x0100);
+}
+
+
+
+/* Three drivers contained the same code, each time included only
+   when debugging was enabled. Here a single copy of the code,
+   also included only when debugging is enabled. */
+#ifdef IDE_IDENTIFY_DEBUG
+
+/*
+ * called with name = "ide-tape" or "ide-floppy" or "isd200"
+ */
+#define Printk1(x)	printk(KERN_INFO "%s: " x, name)
+#define Printk(x,y...)	printk(KERN_INFO "%s: " x, name, y)
+
+#define ATA	0
+#define	ATAPI	1
+#define CF	2
+#define UNKN	3
+
+static void
+ide_dump_identify_info(const struct hd_driveid *id, const char *name)
+{
+	char *s;
+	int i, type;
+	unsigned short mask;
+
+	Printk1("Dumping IDE Identify Device parameters\n");
+
+	if (ide_is_compactflash(id)) {
+		s = "CompactFlash";
+		type = CF;
+	} else if (ide_is_atapi(id)) {
+		s = "ATAPI";
+		type = ATAPI;
+	} else if (ide_is_ata(id)) {
+		s = "ATA";
+		type = ATA;
+	} else {
+		s = "Reserved";
+		type = UNKN;
+	}
+	Printk("Protocol Type: %s\n", s);
+
+	if (type == CF)
+		return;
+
+	Printk("Model: %.40s\n", id->model);
+	Printk("Firmware Revision: %.8s\n", id->fw_rev);
+	Printk("Serial Number: %.20s\n", id->serial_no);
+
+	i = ide_is_removable(id);
+	Printk("%s\n", i ? "Removable" : "Not removable");
+
+	if (type == ATAPI) {
+
+		switch (atapi_device_type(id)) {
+		case 0: s = "Direct-access Device"; break;
+		case 1: s = "Streaming Tape Device"; break;
+		case 5: s = "CD-ROM Device"; break;
+		case 7: s = "Optical memory Device"; break;
+		case 31: s = "Unknown or no Device type"; break;
+		default: s = "Reserved";
+		}
+		Printk("Device Type: %d - %s\n", atapi_device_type(id), s);
+
+		switch (atapi_drq_type(id)) {
+		case 0: s = "Microprocessor DRQ"; break;
+		case 1: s = "Interrupt DRQ"; break;
+		case 2: s = "Accelerated DRQ"; break;
+		case 3: s = "Reserved"; break;
+		}
+		Printk("Command Packet DRQ Type: %s\n", s);
+
+		switch (atapi_packet_size(id)) {
+		case 0: s = "12 bytes"; break;
+		case 1: s = "16 bytes"; break;
+		default: s = "Reserved"; break;
+		}
+		Printk("Command Packet Size: %s\n", s);
+
+		if (ide_incomplete_response(id)) {
+			Printk("ID Incomplete. Word 2: 0x%04x\n",
+			       id->reserved2);
+			return;
+		}
+	} else {
+		Printk("Config word: 0x%x\n", id->config);
+		Printk("C/H/S: %d/%d/%d\n",
+		       id->cyls, id->heads, id->sectors);
+		Printk("Current C/H/S: %d/%d/%d, cur_capacity %d\n",
+		       id->cur_cyls, id->cur_heads, id->cur_sectors,
+		       (id->cur_capacity1 << 16) + id->cur_capacity0);
+		Printk("LBA capacity = %d\n", id->lba_capacity);
+	}
+
+	if (id->buf_type)
+		Printk("Buffertype: %d\n", id->buf_type);
+	if (id->buf_size)
+		Printk("Buffer size: %d bytes\n", id->buf_size*512);
+		
+	Printk("%sDMA, %sLBA, tDMA = %d, tPIO = %d\n",
+	       (id->capability & 0x01) ? "" : "No ",
+	       (id->capability & 0x02) ? "" : "no ",
+	       id->tDMA, id->tPIO);
+	Printk("IORDY can be disabled: %s",
+	       id->capability & 0x04 ? "Yes\n":"No\n");
+	Printk("IORDY supported: %s",
+	       id->capability & 0x08 ? "Yes\n":"Unknown\n");
+	if (type == ATAPI)
+		Printk("ATAPI overlap supported: %s",
+		       id->capability & 0x20 ? "Yes\n":"No\n");
+
+	/* not in ATA4, ATA5 */
+	if (id->dma_1word) {
+		Printk1("Single Word DMA supported modes: ");
+		for (i=0, mask=1; i<8; i++, mask<<=1) {
+			if (id->dma_1word & mask)
+				printk("%d ",i);
+			if (id->dma_1word & (mask << 8))
+				printk("(active) ");
+		}
+		printk("\n");
+	}
+
+	if (id->dma_mword) {
+		Printk1("Multi Word DMA supported modes: ");
+		for (i=0, mask=1; i<8; i++, mask<<=1) {
+			if (id->dma_mword & mask)
+				printk("%d ",i);
+			if (id->dma_mword & (mask << 8))
+				printk("(active) ");
+		}
+		printk("\n");
+	}
+
+	if (type == ATA) {
+		Printk("Multsect = %d\n", id->multsect);
+		Printk("Max_multsect = 0x%x\n", id->max_multsect);
+		Printk("Dword_io = 0x%x\n", id->dword_io);
+		Printk("Ecc_bytes = 0x%x\n", id->ecc_bytes);
+	}
+
+	Printk("Capability = 0x%x\n", id->capability);
+	Printk("Field_valid = 0x%x\n", id->field_valid);
+
+	if (id->field_valid & 0x0002) {
+		Printk("Enhanced PIO Modes: %s\n",
+		       (id->eide_pio_modes & 1) ? "Mode 3" : "None");
+		Printk1("Minimum Multi-word DMA cycle per word: ");
+		if (id->eide_dma_min == 0)
+			printk("Not supported\n");
+		else
+			printk("%d ns\n",id->eide_dma_min);
+
+		Printk1("Manufacturer\'s Recommended Multi-word cycle: ");
+		if (id->eide_dma_time == 0)
+			printk("Not supported\n");
+		else
+			printk("%d ns\n",id->eide_dma_time);
+
+		Printk1("Minimum PIO cycle without IORDY: ");
+		if (id->eide_pio == 0)
+			printk("Not supported\n");
+		else
+			printk("%d ns\n",id->eide_pio);
+
+		Printk1("Minimum PIO cycle with IORDY: ");
+		if (id->eide_pio_iordy == 0)
+			printk("Not supported\n");
+		else
+			printk("%d ns\n",id->eide_pio_iordy);
+		
+	} else
+		Printk1("According to the device, "
+			"fields 64-70 are not valid.\n");
+
+	if (id->command_set_1)
+		Printk("Command_set_1 = 0x%x\n", id->command_set_1);
+	if (id->command_set_2)
+		Printk("Command_set_2 = 0x%x\n", id->command_set_2);
+}
+
+#undef ATA
+#undef ATAPI
+#undef CF
+#undef UNKN
+	
+#endif /* IDE_IDENTIFY_DEBUG */
+
+#endif /* _IDE_IDENTIFY_H */
