Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262792AbTLSMre (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 07:47:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263424AbTLSMre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 07:47:34 -0500
Received: from mail.linuxtv.org ([212.84.236.4]:29114 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262792AbTLSM2n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 07:28:43 -0500
Subject: [PATCH 4/12] Update Skystar2 DVB driver
In-Reply-To: <10718369203166@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Fri, 19 Dec 2003 13:28:41 +0100
Message-Id: <10718369211552@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DVB: - complete revamp of the original driver: code beautification + linux coding sytle, full diseqc support, hardware filtering support, support for different card revisions and lots of other stuff. 
diff -uNrwB --new-file linux-2.6.0/drivers/media/dvb/b2c2/skystar2.c linux-2.6.0-p/drivers/media/dvb/b2c2/skystar2.c
--- linux-2.6.0/drivers/media/dvb/b2c2/skystar2.c	2003-12-18 03:59:16.000000000 +0100
+++ linux-2.6.0-p/drivers/media/dvb/b2c2/skystar2.c	2003-12-11 15:03:39.000000000 +0100
@@ -2,7 +2,19 @@
  * skystar2.c - driver for the Technisat SkyStar2 PCI DVB card
  *              based on the FlexCopII by B2C2,Inc.
  *
- * Copyright (C) 2003  V.C. , skystar@moldova.cc
+ * Copyright (C) 2003  Vadim Catana, skystar@moldova.cc
+ *
+ * FIX: DISEQC Tone Burst in flexcop_diseqc_ioctl()
+ * FIX: FULL soft DiSEqC for skystar2 (FlexCopII rev 130) VP310 equipped 
+ *     Vincenzo Di Massa, hawk.it at tiscalinet.it
+ * 	
+ * Converted to Linux coding style
+ * Misc reorganization, polishing, restyling
+ *     Roberto Ragusa, r.ragusa at libero.it
+ *       
+ * Added hardware filtering support, 
+ *     Niklas Peinecke, peinecke at gdv.uni-hannover.de
+ *
  *
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU Lesser General Public License
@@ -27,7 +40,6 @@
 
 #include "dvb_i2c.h"
 #include "dvb_frontend.h"
-#include "dvb_functions.h"
 
 #include <linux/dvb/frontend.h>
 #include <linux/dvb/dmx.h>
@@ -38,14 +50,20 @@
 #include "demux.h"
 #include "dvb_net.h"
 
+#include "dvb_functions.h"
+
 static int debug = 0;
-#define dprintk(x...) do { if (debug) printk(x); } while (0)
+#define dprintk(x...)	do { if (debug>=1) printk(x); } while (0)
+#define ddprintk(x...)	do { if (debug>=2) printk(x); } while (0)
+static int enable_hw_filters = 2;
 
-#define SizeOfBufDMA1	0x3AC00
-#define SizeOfBufDMA2	0x758
+#define SIZE_OF_BUF_DMA1	0x3ac00
+#define SIZE_OF_BUF_DMA2	0x758
 
-struct dmaq {
+#define MAX_N_HW_FILTERS	(6+32)
+#define N_PID_SLOTS		256
 
+struct dmaq {
 	u32 bus_addr;
 	u32 head;
 	u32 tail;
@@ -53,20 +71,8 @@
 	u8 *buffer;
 };
 
-struct packet_header {
-
-	u32 sync_byte;
-	u32 transport_error_indicator;
-	u32 payload_unit_start_indicator;
-	u32 transport_priority;
-	u32 pid;
-	u32 transport_scrambling_control;
-	u32 adaptation_field_control;
-	u32 continuity_counter;
-};
 
 struct adapter {
-
 	struct pci_dev *pdev;
 
 	u8 card_revision;
@@ -71,13 +77,13 @@
 
 	u8 card_revision;
 	u32 b2c2_revision;
-	u32 PidFilterMax;
-	u32 MacFilterMax;
+	u32 pid_filter_max;
+	u32 mac_filter_max;
 	u32 irq;
 	unsigned long io_mem;
 	unsigned long io_port;
 	u8 mac_addr[8];
-	u32 dwSramType;
+	u32 dw_sram_type;
 
 	struct dvb_adapter *dvb_adapter;
 	struct dvb_demux demux;
@@ -95,44 +101,42 @@
 	u32 dma_ctrl;
 	u32 dma_status;
 
-	u32 capturing;
+	int capturing;
 
 	spinlock_t lock;
 
-	u16 pids[0x27];
+	int useable_hw_filters;
+	u16 hw_pids[MAX_N_HW_FILTERS];
+	u16 pid_list[N_PID_SLOTS];
+	int pid_rc[N_PID_SLOTS];	// ref counters for the pids
+	int pid_count;
+	int whole_bandwidth_count;
 	u32 mac_filter;
 };
 
-#define WriteRegDW(adapter,reg,value) writel(value, adapter->io_mem + reg)
-#define ReadRegDW(adapter,reg) readl(adapter->io_mem + reg)
+#define write_reg_dw(adapter,reg,value) writel(value, adapter->io_mem + reg)
+#define read_reg_dw(adapter,reg) readl(adapter->io_mem + reg)
 
-static void WriteRegOp(struct adapter *adapter, u32 reg, u32 operation, u32 andvalue, u32 orvalue)
+static void write_reg_bitfield(struct adapter *adapter, u32 reg, u32 zeromask, u32 orvalue)
 {
 	u32 tmp;
 
-	tmp = ReadRegDW(adapter, reg);
-
-	if (operation == 1)
-		tmp = tmp | orvalue;
-	if (operation == 2)
-		tmp = tmp & andvalue;
-	if (operation == 3)
-		tmp = (tmp & andvalue) | orvalue;
-
-	WriteRegDW(adapter, reg, tmp);
+	tmp = read_reg_dw(adapter, reg);
+	tmp = (tmp & ~zeromask) | orvalue;
+	write_reg_dw(adapter, reg, tmp);
 }
 
 /* i2c functions */
-static int i2cMainWriteForFlex2(struct adapter * adapter, u32 command, u8 * buf, u32 retries)
+static int i2c_main_write_for_flex2(struct adapter *adapter, u32 command, u8 *buf, int retries)
 {
-	u32 i;
+	int i;
 	u32 value;
 
-	WriteRegDW(adapter, 0x100, 0);
-	WriteRegDW(adapter, 0x100, command);
+	write_reg_dw(adapter, 0x100, 0);
+	write_reg_dw(adapter, 0x100, command);
 
 	for (i = 0; i < retries; i++) {
-		value = ReadRegDW(adapter, 0x100);
+		value = read_reg_dw(adapter, 0x100);
 
 		if ((value & 0x40000000) == 0) {
 			if ((value & 0x81000000) == 0x80000000) {
@@ -141,11 +145,9 @@
 
 				return 1;
 			}
-
 		} else {
-
-			WriteRegDW(adapter, 0x100, 0);
-			WriteRegDW(adapter, 0x100, command);
+			write_reg_dw(adapter, 0x100, 0);
+			write_reg_dw(adapter, 0x100, command);
 		}
 	}
 
@@ -153,7 +155,7 @@
 }
 
 /* device = 0x10000000 for tuner, 0x20000000 for eeprom */
-static void i2cMainSetup(u32 device, u32 chip_addr, u8 op, u8 addr, u32 value, u32 len, u32 *command)
+static void i2c_main_setup(u32 device, u32 chip_addr, u8 op, u8 addr, u32 value, u32 len, u32 *command)
 {
 	*command = device | ((len - 1) << 26) | (value << 16) | (addr << 8) | chip_addr;
 
@@ -163,20 +165,20 @@
 		*command = *command | 0x01000000;
 }
 
-static int FlexI2cRead4(struct adapter * adapter, u32 device, u32 chip_addr, u16 addr, u8 * buf, u8 len)
+static int flex_i2c_read4(struct adapter *adapter, u32 device, u32 chip_addr, u16 addr, u8 *buf, u8 len)
 {
 	u32 command;
 	u32 value;
 
 	int result, i;
 
-	i2cMainSetup(device, chip_addr, 1, addr, 0, len, &command);
+	i2c_main_setup(device, chip_addr, 1, addr, 0, len, &command);
 
-	result = i2cMainWriteForFlex2(adapter, command, buf, 100000);
+	result = i2c_main_write_for_flex2(adapter, command, buf, 100000);
 
 	if ((result & 0xff) != 0) {
 		if (len > 1) {
-			value = ReadRegDW(adapter, 0x104);
+			value = read_reg_dw(adapter, 0x104);
 
 			for (i = 1; i < len; i++) {
 				buf[i] = value & 0xff;
@@ -188,7 +190,7 @@
 	return result;
 }
 
-static int FlexI2cWrite4(struct adapter * adapter, u32 device, u32 chip_addr, u32 addr, u8 * buf, u8 len)
+static int flex_i2c_write4(struct adapter *adapter, u32 device, u32 chip_addr, u32 addr, u8 *buf, u8 len)
 {
 	u32 command;
 	u32 value;
@@ -202,12 +204,12 @@
 			value = value | buf[i - 1];
 		}
 
-		WriteRegDW(adapter, 0x104, value);
+		write_reg_dw(adapter, 0x104, value);
 	}
 
-	i2cMainSetup(device, chip_addr, 0, addr, buf[0], len, &command);
+	i2c_main_setup(device, chip_addr, 0, addr, buf[0], len, &command);
 
-	return i2cMainWriteForFlex2(adapter, command, 0, 100000);
+	return i2c_main_write_for_flex2(adapter, command, 0, 100000);
 }
 
 static void fixchipaddr(u32 device, u32 bus, u32 addr, u32 *ret)
@@ -218,13 +220,13 @@
 	*ret = bus;
 }
 
-static u32 FLEXI2C_read(struct adapter * adapter, u32 device, u32 bus, u32 addr, u8 * buf, u32 len)
+static u32 flex_i2c_read(struct adapter *adapter, u32 device, u32 bus, u32 addr, u8 *buf, u32 len)
 {
 	u32 chipaddr;
 	u32 bytes_to_transfer;
 	u8 *start;
 
-//  dprintk("%s:\n", __FUNCTION__);
+	ddprintk("%s:\n", __FUNCTION__);
 
 	start = buf;
 
@@ -236,7 +238,7 @@
 
 		fixchipaddr(device, bus, addr, &chipaddr);
 
-		if (FlexI2cRead4(adapter, device, chipaddr, addr, buf, bytes_to_transfer) == 0)
+		if (flex_i2c_read4(adapter, device, chipaddr, addr, buf, bytes_to_transfer) == 0)
 			return buf - start;
 
 		buf = buf + bytes_to_transfer;
@@ -247,13 +249,13 @@
 	return buf - start;
 }
 
-static u32 FLEXI2C_write(struct adapter * adapter, u32 device, u32 bus, u32 addr, u8 * buf, u32 len)
+static u32 flex_i2c_write(struct adapter *adapter, u32 device, u32 bus, u32 addr, u8 *buf, u32 len)
 {
 	u32 chipaddr;
 	u32 bytes_to_transfer;
 	u8 *start;
 
-//  dprintk("%s:\n", __FUNCTION__);
+	ddprintk("%s:\n", __FUNCTION__);
 
 	start = buf;
 
@@ -265,7 +267,7 @@
 
 		fixchipaddr(device, bus, addr, &chipaddr);
 
-		if (FlexI2cWrite4(adapter, device, chipaddr, addr, buf, bytes_to_transfer) == 0)
+		if (flex_i2c_write4(adapter, device, chipaddr, addr, buf, bytes_to_transfer) == 0)
 			return buf - start;
 
 		buf = buf + bytes_to_transfer;
@@ -284,75 +286,81 @@
 	if (down_interruptible(&tmp->i2c_sem))
 		return -ERESTARTSYS;
 
-	if (0) {
-		dprintk("%s:\n", __FUNCTION__);
+	ddprintk("%s: %d messages to transfer\n", __FUNCTION__, num);
 
 		for (i = 0; i < num; i++) {
-			printk("message %d: flags=%x, addr=0x%04x, buf=%p, len=%d \n", i, msgs[i].flags, msgs[i].addr, msgs[i].buf, msgs[i].len);
-		}
-	}
+		ddprintk("message %d: flags=0x%x, addr=0x%x, buf=0x%x, len=%d \n", i,
+			 msgs[i].flags, msgs[i].addr, msgs[i].buf[0], msgs[i].len);
 	
-	/* allow only the vp310 frontend to access the bus */
-	if ((msgs[0].addr != 0x0E) && (msgs[0].addr != 0x61)) {
+		/* allow only the mt312 and stv0299 frontends to access the bus */
+		if ((msgs[i].addr != 0x0e) && (msgs[i].addr != 0x68) && (msgs[i].addr != 0x61)) {
 		up(&tmp->i2c_sem);
 
 		return -EREMOTEIO;
 	}
+	}
 
-	if ((num == 1) && (msgs[0].buf != NULL)) {
-		if (msgs[0].flags == I2C_M_RD) {
-			ret = -EINVAL;
+	// read command
+	if ((num == 2) && (msgs[0].flags == 0) && (msgs[1].flags == I2C_M_RD) && (msgs[0].buf != NULL) && (msgs[1].buf != NULL)) {
 
-		} else {
+		ret = flex_i2c_read(tmp, 0x10000000, msgs[0].addr, msgs[0].buf[0], msgs[1].buf, msgs[1].len);
 
-			// single writes do have the reg addr in buf[0] and data in buf[1] to buf[n]
-			ret = FLEXI2C_write(tmp, 0x10000000, msgs[0].addr, msgs[0].buf[0], &msgs[0].buf[1], msgs[0].len - 1);
+		up(&tmp->i2c_sem);
 
-			if (ret != msgs[0].len - 1)
-				ret = -EREMOTEIO;
-			else
-				ret = num;
+		if (ret != msgs[1].len) {
+			printk("%s: read error !\n", __FUNCTION__);
+
+			for (i = 0; i < 2; i++) {
+				printk("message %d: flags=0x%x, addr=0x%x, buf=0x%x, len=%d \n", i,
+				       msgs[i].flags, msgs[i].addr, msgs[i].buf[0], msgs[i].len);
 		}
 
-	} else if ((num == 2) && (msgs[1].buf != NULL)) {
+			return -EREMOTEIO;
+		}
 
-		// i2c reads consist of a reg addr _write_ followed by a data read, so msg[1].flags has to be examined
-		if (msgs[1].flags == I2C_M_RD) {
-			ret = FLEXI2C_read(tmp, 0x10000000, msgs[0].addr, msgs[0].buf[0], msgs[1].buf, msgs[1].len);
+		return num;
+	}
+	// write command
+	for (i = 0; i < num; i++) {
 
-		} else {
+		if ((msgs[i].flags != 0) || (msgs[i].buf == NULL) || (msgs[i].len < 2))
+			return -EINVAL;
+
+		ret = flex_i2c_write(tmp, 0x10000000, msgs[i].addr, msgs[i].buf[0], &msgs[i].buf[1], msgs[i].len - 1);
+
+		up(&tmp->i2c_sem);
 
-			ret = FLEXI2C_write(tmp, 0x10000000, msgs[0].addr, msgs[0].buf[0], msgs[1].buf, msgs[1].len);
+		if (ret != msgs[0].len - 1) {
+			printk("%s: write error %i !\n", __FUNCTION__, ret);
+
+			printk("message %d: flags=0x%x, addr=0x%x, buf[0]=0x%x, len=%d \n", i,
+			       msgs[i].flags, msgs[i].addr, msgs[i].buf[0], msgs[i].len);
+
+			return -EREMOTEIO;
 		}
 
-		if (ret != msgs[1].len)
-			ret = -EREMOTEIO;
-		else
-			ret = num;
+		return num;
 	}
 
-	up(&tmp->i2c_sem);
+	printk("%s: unknown command format !\n", __FUNCTION__);
 
-	/* master xfer functions always return the number of successfully
-	   transmitted messages, not the number of transmitted bytes.
-	   return -EREMOTEIO in case of failure. */
-	return ret;
+	return -EINVAL;
 }
 
 /* SRAM (Skystar2 rev2.3 has one "ISSI IS61LV256" chip on board,
    but it seems that FlexCopII can work with more than one chip) */
-static void SRAMSetNetDest(struct adapter * adapter, u8 dest)
+static void sram_set_net_dest(struct adapter *adapter, u8 dest)
 {
 	u32 tmp;
 
 	udelay(1000);
 
-	tmp = (ReadRegDW(adapter, 0x714) & 0xFFFFFFFC) | (dest & 3);
+	tmp = (read_reg_dw(adapter, 0x714) & 0xfffffffc) | (dest & 3);
 
 	udelay(1000);
 
-	WriteRegDW(adapter, 0x714, tmp);
-	WriteRegDW(adapter, 0x714, tmp);
+	write_reg_dw(adapter, 0x714, tmp);
+	write_reg_dw(adapter, 0x714, tmp);
 
 	udelay(1000);
 
@@ -360,19 +368,19 @@
 /*	return tmp; */
 }
 
-static void SRAMSetCaiDest(struct adapter * adapter, u8 dest)
+static void sram_set_cai_dest(struct adapter *adapter, u8 dest)
 {
 	u32 tmp;
 
 	udelay(1000);
 
-	tmp = (ReadRegDW(adapter, 0x714) & 0xFFFFFFF3) | ((dest & 3) << 2);
+	tmp = (read_reg_dw(adapter, 0x714) & 0xfffffff3) | ((dest & 3) << 2);
 
 	udelay(1000);
 	udelay(1000);
 
-	WriteRegDW(adapter, 0x714, tmp);
-	WriteRegDW(adapter, 0x714, tmp);
+	write_reg_dw(adapter, 0x714, tmp);
+	write_reg_dw(adapter, 0x714, tmp);
 
 	udelay(1000);
 
@@ -380,19 +388,19 @@
 /*	return tmp; */
 }
 
-static void SRAMSetCaoDest(struct adapter * adapter, u8 dest)
+static void sram_set_cao_dest(struct adapter *adapter, u8 dest)
 {
 	u32 tmp;
 
 	udelay(1000);
 
-	tmp = (ReadRegDW(adapter, 0x714) & 0xFFFFFFCF) | ((dest & 3) << 4);
+	tmp = (read_reg_dw(adapter, 0x714) & 0xffffffcf) | ((dest & 3) << 4);
 
 	udelay(1000);
 	udelay(1000);
 
-	WriteRegDW(adapter, 0x714, tmp);
-	WriteRegDW(adapter, 0x714, tmp);
+	write_reg_dw(adapter, 0x714, tmp);
+	write_reg_dw(adapter, 0x714, tmp);
 
 	udelay(1000);
 
@@ -400,19 +408,19 @@
 /*	return tmp; */
 }
 
-static void SRAMSetMediaDest(struct adapter * adapter, u8 dest)
+static void sram_set_media_dest(struct adapter *adapter, u8 dest)
 {
 	u32 tmp;
 
 	udelay(1000);
 
-	tmp = (ReadRegDW(adapter, 0x714) & 0xFFFFFF3F) | ((dest & 3) << 6);
+	tmp = (read_reg_dw(adapter, 0x714) & 0xffffff3f) | ((dest & 3) << 6);
 
 	udelay(1000);
 	udelay(1000);
 
-	WriteRegDW(adapter, 0x714, tmp);
-	WriteRegDW(adapter, 0x714, tmp);
+	write_reg_dw(adapter, 0x714, tmp);
+	write_reg_dw(adapter, 0x714, tmp);
 
 	udelay(1000);
 
@@ -429,16 +437,17 @@
     bits 28-29 : memory bank selector
     bit  31    : busy flag
 */
-static void FlexSramWrite(struct adapter *adapter, u32 bank, u32 addr, u8 * buf, u32 len)
+static void flex_sram_write(struct adapter *adapter, u32 bank, u32 addr, u8 *buf, u32 len)
 {
-	u32 i, command, retries;
+	int i, retries;
+	u32 command;
 
 	for (i = 0; i < len; i++) {
 		command = bank | addr | 0x04000000 | (*buf << 0x10);
 
 		retries = 2;
 
-		while (((ReadRegDW(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
+		while (((read_reg_dw(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
 			mdelay(1);
 			retries--;
 		};
@@ -446,23 +455,24 @@
 		if (retries == 0)
 			printk("%s: SRAM timeout\n", __FUNCTION__);
 
-		WriteRegDW(adapter, 0x700, command);
+		write_reg_dw(adapter, 0x700, command);
 
 		buf++;
 		addr++;
 	}
 }
 
-static void FlexSramRead(struct adapter *adapter, u32 bank, u32 addr, u8 * buf, u32 len)
+static void flex_sram_read(struct adapter *adapter, u32 bank, u32 addr, u8 *buf, u32 len)
 {
-	u32 i, command, value, retries;
+	int i, retries;
+	u32 command, value;
 
 	for (i = 0; i < len; i++) {
 		command = bank | addr | 0x04008000;
 
 		retries = 10000;
 
-		while (((ReadRegDW(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
+		while (((read_reg_dw(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
 			mdelay(1);
 			retries--;
 		};
@@ -470,11 +480,11 @@
 		if (retries == 0)
 			printk("%s: SRAM timeout\n", __FUNCTION__);
 
-		WriteRegDW(adapter, 0x700, command);
+		write_reg_dw(adapter, 0x700, command);
 
 		retries = 10000;
 
-		while (((ReadRegDW(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
+		while (((read_reg_dw(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
 			mdelay(1);
 			retries--;
 		};
@@ -482,7 +492,7 @@
 		if (retries == 0)
 			printk("%s: SRAM timeout\n", __FUNCTION__);
 
-		value = ReadRegDW(adapter, 0x700) >> 0x10;
+		value = read_reg_dw(adapter, 0x700) >> 0x10;
 
 		*buf = (value & 0xff);
 
@@ -491,47 +501,47 @@
 	}
 }
 
-static void SRAM_writeChunk(struct adapter *adapter, u32 addr, u8 * buf, u16 len)
+static void sram_writeChunk(struct adapter *adapter, u32 addr, u8 *buf, u16 len)
 {
 	u32 bank;
 
 	bank = 0;
 
-	if (adapter->dwSramType == 0x20000) {
-		bank = (addr & 0x18000) << 0x0D;
+	if (adapter->dw_sram_type == 0x20000) {
+		bank = (addr & 0x18000) << 0x0d;
 	}
 
-	if (adapter->dwSramType == 0x00000) {
-		if ((addr >> 0x0F) == 0)
+	if (adapter->dw_sram_type == 0x00000) {
+		if ((addr >> 0x0f) == 0)
 			bank = 0x20000000;
 		else
 			bank = 0x10000000;
 	}
 
-	FlexSramWrite(adapter, bank, addr & 0x7FFF, buf, len);
+	flex_sram_write(adapter, bank, addr & 0x7fff, buf, len);
 }
 
-static void SRAM_readChunk(struct adapter *adapter, u32 addr, u8 * buf, u16 len)
+static void sram_readChunk(struct adapter *adapter, u32 addr, u8 *buf, u16 len)
 {
 	u32 bank;
 
 	bank = 0;
 
-	if (adapter->dwSramType == 0x20000) {
-		bank = (addr & 0x18000) << 0x0D;
+	if (adapter->dw_sram_type == 0x20000) {
+		bank = (addr & 0x18000) << 0x0d;
 	}
 
-	if (adapter->dwSramType == 0x00000) {
-		if ((addr >> 0x0F) == 0)
+	if (adapter->dw_sram_type == 0x00000) {
+		if ((addr >> 0x0f) == 0)
 			bank = 0x20000000;
 		else
 			bank = 0x10000000;
 	}
 
-	FlexSramRead(adapter, bank, addr & 0x7FFF, buf, len);
+	flex_sram_read(adapter, bank, addr & 0x7fff, buf, len);
 }
 
-static void SRAM_read(struct adapter *adapter, u32 addr, u8 * buf, u32 len)
+static void sram_read(struct adapter *adapter, u32 addr, u8 *buf, u32 len)
 {
 	u32 length;
 
@@ -541,11 +551,11 @@
 		// check if the address range belongs to the same 
 		// 32K memory chip. If not, the data is read from 
 		// one chip at a time.
-		if ((addr >> 0x0F) != ((addr + len - 1) >> 0x0F)) {
-			length = (((addr >> 0x0F) + 1) << 0x0F) - addr;
+		if ((addr >> 0x0f) != ((addr + len - 1) >> 0x0f)) {
+			length = (((addr >> 0x0f) + 1) << 0x0f) - addr;
 		}
 
-		SRAM_readChunk(adapter, addr, buf, length);
+		sram_readChunk(adapter, addr, buf, length);
 
 		addr = addr + length;
 		buf = buf + length;
@@ -553,7 +563,7 @@
 	}
 }
 
-static void SRAM_write(struct adapter *adapter, u32 addr, u8 * buf, u32 len)
+static void sram_write(struct adapter *adapter, u32 addr, u8 *buf, u32 len)
 {
 	u32 length;
 
@@ -563,11 +573,11 @@
 		// check if the address range belongs to the same 
 		// 32K memory chip. If not, the data is written to
 		// one chip at a time.
-		if ((addr >> 0x0F) != ((addr + len - 1) >> 0x0F)) {
-			length = (((addr >> 0x0F) + 1) << 0x0F) - addr;
+		if ((addr >> 0x0f) != ((addr + len - 1) >> 0x0f)) {
+			length = (((addr >> 0x0f) + 1) << 0x0f) - addr;
 		}
 
-		SRAM_writeChunk(adapter, addr, buf, length);
+		sram_writeChunk(adapter, addr, buf, length);
 
 		addr = addr + length;
 		buf = buf + length;
@@ -575,92 +585,92 @@
 	}
 }
 
-static void SRAM_setSize(struct adapter *adapter, u32 mask)
+static void sram_set_size(struct adapter *adapter, u32 mask)
 {
-	WriteRegDW(adapter, 0x71C, (mask | (~0x30000 & ReadRegDW(adapter, 0x71C))));
+	write_reg_dw(adapter, 0x71c, (mask | (~0x30000 & read_reg_dw(adapter, 0x71c))));
 }
 
-static void SRAM_init(struct adapter *adapter)
+static void sram_init(struct adapter *adapter)
 {
 	u32 tmp;
 
-	tmp = ReadRegDW(adapter, 0x71C);
+	tmp = read_reg_dw(adapter, 0x71c);
 
-	WriteRegDW(adapter, 0x71C, 1);
+	write_reg_dw(adapter, 0x71c, 1);
 
-	if (ReadRegDW(adapter, 0x71C) != 0) {
-		WriteRegDW(adapter, 0x71C, tmp);
+	if (read_reg_dw(adapter, 0x71c) != 0) {
+		write_reg_dw(adapter, 0x71c, tmp);
 
-		adapter->dwSramType = tmp & 0x30000;
+		adapter->dw_sram_type = tmp & 0x30000;
 
-		dprintk("%s: dwSramType = %x\n", __FUNCTION__, adapter->dwSramType);
+		ddprintk("%s: dw_sram_type = %x\n", __FUNCTION__, adapter->dw_sram_type);
 
 	} else {
 
-		adapter->dwSramType = 0x10000;
+		adapter->dw_sram_type = 0x10000;
 
-		dprintk("%s: dwSramType = %x\n", __FUNCTION__, adapter->dwSramType);
+		ddprintk("%s: dw_sram_type = %x\n", __FUNCTION__, adapter->dw_sram_type);
 	}
 
 	/* return value is never used? */
-/*	return adapter->dwSramType; */
+/*	return adapter->dw_sram_type; */
 }
 
-static int SRAM_testLocation(struct adapter *adapter, u32 mask, u32 addr)
+static int sram_test_location(struct adapter *adapter, u32 mask, u32 addr)
 {
 	u8 tmp1, tmp2;
 
 	dprintk("%s: mask = %x, addr = %x\n", __FUNCTION__, mask, addr);
 
-	SRAM_setSize(adapter, mask);
-	SRAM_init(adapter);
+	sram_set_size(adapter, mask);
+	sram_init(adapter);
 
-	tmp2 = 0xA5;
-	tmp1 = 0x4F;
+	tmp2 = 0xa5;
+	tmp1 = 0x4f;
 
-	SRAM_write(adapter, addr, &tmp2, 1);
-	SRAM_write(adapter, addr + 4, &tmp1, 1);
+	sram_write(adapter, addr, &tmp2, 1);
+	sram_write(adapter, addr + 4, &tmp1, 1);
 
 	tmp2 = 0;
 
 	mdelay(20);
 
-	SRAM_read(adapter, addr, &tmp2, 1);
-	SRAM_read(adapter, addr, &tmp2, 1);
+	sram_read(adapter, addr, &tmp2, 1);
+	sram_read(adapter, addr, &tmp2, 1);
 
-	dprintk("%s: wrote 0xA5, read 0x%2x\n", __FUNCTION__, tmp2);
+	dprintk("%s: wrote 0xa5, read 0x%2x\n", __FUNCTION__, tmp2);
 
-	if (tmp2 != 0xA5)
+	if (tmp2 != 0xa5)
 		return 0;
 
-	tmp2 = 0x5A;
-	tmp1 = 0xF4;
+	tmp2 = 0x5a;
+	tmp1 = 0xf4;
 
-	SRAM_write(adapter, addr, &tmp2, 1);
-	SRAM_write(adapter, addr + 4, &tmp1, 1);
+	sram_write(adapter, addr, &tmp2, 1);
+	sram_write(adapter, addr + 4, &tmp1, 1);
 
 	tmp2 = 0;
 
 	mdelay(20);
 
-	SRAM_read(adapter, addr, &tmp2, 1);
-	SRAM_read(adapter, addr, &tmp2, 1);
+	sram_read(adapter, addr, &tmp2, 1);
+	sram_read(adapter, addr, &tmp2, 1);
 
-	dprintk("%s: wrote 0x5A, read 0x%2x\n", __FUNCTION__, tmp2);
+	dprintk("%s: wrote 0x5a, read 0x%2x\n", __FUNCTION__, tmp2);
 
-	if (tmp2 != 0x5A)
+	if (tmp2 != 0x5a)
 		return 0;
 
 	return 1;
 }
 
-static u32 SRAM_length(struct adapter * adapter)
+static u32 sram_length(struct adapter *adapter)
 {
-	if (adapter->dwSramType == 0x10000)
+	if (adapter->dw_sram_type == 0x10000)
 		return 32768;	//  32K
-	if (adapter->dwSramType == 0x00000)
+	if (adapter->dw_sram_type == 0x00000)
 		return 65536;	//  64K        
-	if (adapter->dwSramType == 0x20000)
+	if (adapter->dw_sram_type == 0x20000)
 		return 131072;	// 128K
 
 	return 32768;		// 32K
@@ -674,103 +684,104 @@
    FlexCop works only with one bank at a time. The bank is selected
    by bits 28-29 of the 0x700 register.
   
-   bank 0 covers addresses 0x00000-0x07FFF
-   bank 1 covers addresses 0x08000-0x0FFFF
-   bank 2 covers addresses 0x10000-0x17FFF
-   bank 3 covers addresses 0x18000-0x1FFFF
+   bank 0 covers addresses 0x00000-0x07fff
+   bank 1 covers addresses 0x08000-0x0ffff
+   bank 2 covers addresses 0x10000-0x17fff
+   bank 3 covers addresses 0x18000-0x1ffff
 */
-static int SramDetectForFlex2(struct adapter *adapter)
+static int sram_detect_for_flex2(struct adapter *adapter)
 {
 	u32 tmp, tmp2, tmp3;
 
 	dprintk("%s:\n", __FUNCTION__);
 
-	tmp = ReadRegDW(adapter, 0x208);
-	WriteRegDW(adapter, 0x208, 0);
+	tmp = read_reg_dw(adapter, 0x208);
+	write_reg_dw(adapter, 0x208, 0);
 
-	tmp2 = ReadRegDW(adapter, 0x71C);
+	tmp2 = read_reg_dw(adapter, 0x71c);
 
 	dprintk("%s: tmp2 = %x\n", __FUNCTION__, tmp2);
 
-	WriteRegDW(adapter, 0x71C, 1);
+	write_reg_dw(adapter, 0x71c, 1);
 
-	tmp3 = ReadRegDW(adapter, 0x71C);
+	tmp3 = read_reg_dw(adapter, 0x71c);
 
 	dprintk("%s: tmp3 = %x\n", __FUNCTION__, tmp3);
 
-	WriteRegDW(adapter, 0x71C, tmp2);
+	write_reg_dw(adapter, 0x71c, tmp2);
 
 	// check for internal SRAM ???
 	tmp3--;
 	if (tmp3 != 0) {
-		SRAM_setSize(adapter, 0x10000);
-		SRAM_init(adapter);
-		WriteRegDW(adapter, 0x208, tmp);
+		sram_set_size(adapter, 0x10000);
+		sram_init(adapter);
+		write_reg_dw(adapter, 0x208, tmp);
 
 		dprintk("%s: sram size = 32K\n", __FUNCTION__);
 
 		return 32;
 	}
 
-	if (SRAM_testLocation(adapter, 0x20000, 0x18000) != 0) {
-		SRAM_setSize(adapter, 0x20000);
-		SRAM_init(adapter);
-		WriteRegDW(adapter, 0x208, tmp);
+	if (sram_test_location(adapter, 0x20000, 0x18000) != 0) {
+		sram_set_size(adapter, 0x20000);
+		sram_init(adapter);
+		write_reg_dw(adapter, 0x208, tmp);
 
 		dprintk("%s: sram size = 128K\n", __FUNCTION__);
 
 		return 128;
 	}
 
-	if (SRAM_testLocation(adapter, 0x00000, 0x10000) != 0) {
-		SRAM_setSize(adapter, 0x00000);
-		SRAM_init(adapter);
-		WriteRegDW(adapter, 0x208, tmp);
+	if (sram_test_location(adapter, 0x00000, 0x10000) != 0) {
+		sram_set_size(adapter, 0x00000);
+		sram_init(adapter);
+		write_reg_dw(adapter, 0x208, tmp);
 
 		dprintk("%s: sram size = 64K\n", __FUNCTION__);
 
 		return 64;
 	}
 
-	if (SRAM_testLocation(adapter, 0x10000, 0x00000) != 0) {
-		SRAM_setSize(adapter, 0x10000);
-		SRAM_init(adapter);
-		WriteRegDW(adapter, 0x208, tmp);
+	if (sram_test_location(adapter, 0x10000, 0x00000) != 0) {
+		sram_set_size(adapter, 0x10000);
+		sram_init(adapter);
+		write_reg_dw(adapter, 0x208, tmp);
 
 		dprintk("%s: sram size = 32K\n", __FUNCTION__);
 
 		return 32;
 	}
 
-	SRAM_setSize(adapter, 0x10000);
-	SRAM_init(adapter);
-	WriteRegDW(adapter, 0x208, tmp);
+	sram_set_size(adapter, 0x10000);
+	sram_init(adapter);
+	write_reg_dw(adapter, 0x208, tmp);
 
 	dprintk("%s: SRAM detection failed. Set to 32K \n", __FUNCTION__);
 
 	return 0;
 }
 
-static void SLL_detectSramSize(struct adapter *adapter)
+static void sll_detect_sram_size(struct adapter *adapter)
 {
-	SramDetectForFlex2(adapter);
+	sram_detect_for_flex2(adapter);
 }
+
 /* EEPROM (Skystar2 has one "24LC08B" chip on board) */
 /*
-static int EEPROM_write(struct adapter *adapter, u16 addr, u8 * buf, u16 len)
+static int eeprom_write(struct adapter *adapter, u16 addr, u8 *buf, u16 len)
 {
-	return FLEXI2C_write(adapter, 0x20000000, 0x50, addr, buf, len);
+	return flex_i2c_write(adapter, 0x20000000, 0x50, addr, buf, len);
 }
 */
 
-static int EEPROM_read(struct adapter *adapter, u16 addr, u8 * buf, u16 len)
+static int eeprom_read(struct adapter *adapter, u16 addr, u8 *buf, u16 len)
 {
-	return FLEXI2C_read(adapter, 0x20000000, 0x50, addr, buf, len);
+	return flex_i2c_read(adapter, 0x20000000, 0x50, addr, buf, len);
 }
 
-u8 calc_LRC(u8 * buf, u32 len)
+u8 calc_lrc(u8 *buf, int len)
 {
-	u32 i;
+	int i;
 	u8 sum;
 
 	sum = 0;
@@ -781,13 +792,13 @@
 	return sum;
 }
 
-static int EEPROM_LRC_read(struct adapter *adapter, u32 addr, u32 len, u8 * buf, u32 retries)
+static int eeprom_lrc_read(struct adapter *adapter, u32 addr, u32 len, u8 *buf, int retries)
 {
 	int i;
 
 	for (i = 0; i < retries; i++) {
-		if (EEPROM_read(adapter, addr, buf, len) == len) {
-			if (calc_LRC(buf, len - 1) == buf[len - 1])
+		if (eeprom_read(adapter, addr, buf, len) == len) {
+			if (calc_lrc(buf, len - 1) == buf[len - 1])
 				return 1;
 		}
 	}
@@ -796,13 +807,13 @@
 }
 
 /*
-static int EEPROM_LRC_write(struct adapter *adapter, u32 addr, u32 len, u8 * wbuf, u8 * rbuf, u32 retries)
+static int eeprom_lrc_write(struct adapter *adapter, u32 addr, u32 len, u8 *wbuf, u8 *rbuf, int retries)
 {
 	int i;
 
 	for (i = 0; i < retries; i++) {
-		if (EEPROM_write(adapter, addr, wbuf, len) == len) {
-			if (EEPROM_LRC_read(adapter, addr, len, rbuf, retries) == 1)
+		if (eeprom_write(adapter, addr, wbuf, len) == len) {
+			if (eeprom_lrc_read(adapter, addr, len, rbuf, retries) == 1)
 				return 1;
 		}
 	}
@@ -811,33 +822,11 @@
 }
 */
 
-/* These functions could be called from the initialization routine 
-   to unlock SkyStar2 cards, locked by "Europe On Line".
-        
-   in cards from "Europe On Line" the key is:
-
-       u8 key[20] = {
- 	    0xB2, 0x01, 0x00, 0x00,
- 	    0x00, 0x00, 0x00, 0x00,
- 	    0x00, 0x00, 0x00, 0x00,
- 	    0x00, 0x00, 0x00, 0x00,
-       };
-
-       LRC = 0xB3;
 
-  in unlocked cards the key is:
+/* These functions could be used to unlock SkyStar2 cards. */
 
-       u8 key[20] = {
- 	    0xB2, 0x00, 0x00, 0x00,
- 	    0x00, 0x00, 0x00, 0x00,
- 	    0x00, 0x00, 0x00, 0x00,
- 	    0x00, 0x00, 0x00, 0x00,
-       };
-
-      LRC = 0xB2;
-*/
 /*
-static int EEPROM_writeKey(struct adapter *adapter, u8 * key, u32 len)
+static int eeprom_writeKey(struct adapter *adapter, u8 *key, u32 len)
 {
 	u8 rbuf[20];
 	u8 wbuf[20];
@@ -850,37 +839,38 @@
 	wbuf[16] = 0;
 	wbuf[17] = 0;
 	wbuf[18] = 0;
-	wbuf[19] = calc_LRC(wbuf, 19);
+	wbuf[19] = calc_lrc(wbuf, 19);
 
-	return EEPROM_LRC_write(adapter, 0x3E4, 20, wbuf, rbuf, 4);
+	return eeprom_lrc_write(adapter, 0x3e4, 20, wbuf, rbuf, 4);
 }
-*/
-static int EEPROM_readKey(struct adapter *adapter, u8 * key, u32 len)
+
+static int eeprom_readKey(struct adapter *adapter, u8 *key, u32 len)
 {
 	u8 buf[20];
 
 	if (len != 16)
 		return 0;
 
-	if (EEPROM_LRC_read(adapter, 0x3E4, 20, buf, 4) == 0)
+	if (eeprom_lrc_read(adapter, 0x3e4, 20, buf, 4) == 0)
 		return 0;
 
 	memcpy(key, buf, len);
 
 	return 1;
 }
+*/
 
-static int EEPROM_getMacAddr(struct adapter *adapter, char type, u8 * mac)
+static int eeprom_get_mac_addr(struct adapter *adapter, char type, u8 *mac)
 {
 	u8 tmp[8];
 
-	if (EEPROM_LRC_read(adapter, 0x3F8, 8, tmp, 4) != 0) {
+	if (eeprom_lrc_read(adapter, 0x3f8, 8, tmp, 4) != 0) {
 		if (type != 0) {
 			mac[0] = tmp[0];
 			mac[1] = tmp[1];
 			mac[2] = tmp[2];
-			mac[3] = 0xFE;
-			mac[4] = 0xFF;
+			mac[3] = 0xfe;
+			mac[4] = 0xff;
 			mac[5] = tmp[3];
 			mac[6] = tmp[4];
 			mac[7] = tmp[5];
@@ -912,7 +902,7 @@
 }
 
 /*
-static char EEPROM_setMacAddr(struct adapter *adapter, char type, u8 * mac)
+static char eeprom_set_mac_addr(struct adapter *adapter, char type, u8 *mac)
 {
 	u8 tmp[8];
 
@@ -935,9 +925,9 @@
 	}
 
 	tmp[6] = 0;
-	tmp[7] = calc_LRC(tmp, 7);
+	tmp[7] = calc_lrc(tmp, 7);
 
-	if (EEPROM_write(adapter, 0x3F8, tmp, 8) == 8)
+	if (eeprom_write(adapter, 0x3f8, tmp, 8) == 8)
 		return 1;
 
 	return 0;
@@ -945,529 +935,319 @@
 */
 
 /* PID filter */
-static void FilterEnableStream1Filter(struct adapter *adapter, u32 op)
-{
-	dprintk("%s: op=%x\n", __FUNCTION__, op);
-
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000001, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000001);
-	}
-}
-
-static void FilterEnableStream2Filter(struct adapter *adapter, u32 op)
-{
-	dprintk("%s: op=%x\n", __FUNCTION__, op);
-
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000002, 0);
 
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000002);
+/* every flexcop has 6 "lower" hw PID filters     */
+/* these are enabled by setting bits 0-5 of 0x208 */
+/* for the 32 additional filters we have to select one */
+/* of them through 0x310 and modify through 0x314 */
+/* op: 0=disable, 1=enable */
+static void filter_enable_hw_filter(struct adapter *adapter, int id, u8 op)
+{
+	dprintk("%s: id=%d op=%d\n", __FUNCTION__, id, op);
+	if (id <= 5) {
+		u32 mask = (0x00000001 << id);
+		write_reg_bitfield(adapter, 0x208, mask, op ? mask : 0);
+	} else {
+		/* select */
+		write_reg_bitfield(adapter, 0x310, 0x1f, (id - 6) & 0x1f);
+		/* modify */
+		write_reg_bitfield(adapter, 0x314, 0x00006000, op ? 0x00004000 : 0);
 	}
 }
 
-static void FilterEnablePcrFilter(struct adapter *adapter, u32 op)
-{
-	dprintk("%s: op=%x\n", __FUNCTION__, op);
-
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000004, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000004);
+/* this sets the PID that should pass the specified filter */
+static void pid_set_hw_pid(struct adapter *adapter, int id, u16 pid)
+{
+	dprintk("%s: id=%d  pid=%d\n", __FUNCTION__, id, pid);
+	if (id <= 5) {
+		u32 adr = 0x300 + ((id & 6) << 1);
+		int shift = (id & 1) ? 16 : 0;
+		dprintk("%s: id=%d  addr=%x %c  pid=%d\n", __FUNCTION__, id, adr, (id & 1) ? 'h' : 'l', pid);
+		write_reg_bitfield(adapter, adr, (0x7fff) << shift, (pid & 0x1fff) << shift);
+	} else {
+		/* select */
+		write_reg_bitfield(adapter, 0x310, 0x1f, (id - 6) & 0x1f);
+		/* modify */
+		write_reg_bitfield(adapter, 0x314, 0x1fff, pid & 0x1fff);
 	}
 }
 
-static void FilterEnablePmtFilter(struct adapter *adapter, u32 op)
-{
-	dprintk("%s: op=%x\n", __FUNCTION__, op);
-
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000008, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000008);
-	}
-}
-
-static void FilterEnableEmmFilter(struct adapter *adapter, u32 op)
-{
-	dprintk("%s: op=%x\n", __FUNCTION__, op);
-
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000010, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000010);
-	}
-}
-
-static void FilterEnableEcmFilter(struct adapter *adapter, u32 op)
-{
-	dprintk("%s: op=%x\n", __FUNCTION__, op);
-
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000020, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000020);
-	}
-}
 
 /*
-static void FilterEnableNullFilter(struct adapter *adapter, u32 op)
+static void filter_enable_null_filter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000040, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000040);
-	}
+	write_reg_bitfield(adapter, 0x208, 0x00000040, op?0x00000040:0);
 }
 */
 
-static void FilterEnableMaskFilter(struct adapter *adapter, u32 op)
+static void filter_enable_mask_filter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000080, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000080);
-	}
+	write_reg_bitfield(adapter, 0x208, 0x00000080, op ? 0x00000080 : 0);
 }
 
 
-static void CtrlEnableMAC(struct adapter *adapter, u32 op)
+static void ctrl_enable_mac(struct adapter *adapter, u32 op)
 {
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00004000, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00004000);
-	}
+	write_reg_bitfield(adapter, 0x208, 0x00004000, op ? 0x00004000 : 0);
 }
 
-static int CASetMacDstAddrFilter(struct adapter *adapter, u8 * mac)
+static int ca_set_mac_dst_addr_filter(struct adapter *adapter, u8 *mac)
 {
 	u32 tmp1, tmp2;
 
 	tmp1 = (mac[3] << 0x18) | (mac[2] << 0x10) | (mac[1] << 0x08) | mac[0];
 	tmp2 = (mac[5] << 0x08) | mac[4];
 
-	WriteRegDW(adapter, 0x418, tmp1);
-	WriteRegDW(adapter, 0x41C, tmp2);
+	write_reg_dw(adapter, 0x418, tmp1);
+	write_reg_dw(adapter, 0x41c, tmp2);
 
 	return 0;
 }
 
 /*
-static void SetIgnoreMACFilter(struct adapter *adapter, u8 op)
+static void set_ignore_mac_filter(struct adapter *adapter, u8 op)
 {
 	if (op != 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00004000, 0);
-
+		write_reg_bitfield(adapter, 0x208, 0x00004000, 0);
 		adapter->mac_filter = 1;
-
 	} else {
-
 		if (adapter->mac_filter != 0) {
 			adapter->mac_filter = 0;
-
-			WriteRegOp(adapter, 0x208, 1, 0, 0x00004000);
+			write_reg_bitfield(adapter, 0x208, 0x00004000, 0x00004000);
 		}
 	}
 }
 */
 
 /*
-static void CheckNullFilterEnable(struct adapter *adapter)
+static void check_null_filter_enable(struct adapter *adapter)
 {
-	FilterEnableNullFilter(adapter, 1);
-	FilterEnableMaskFilter(adapter, 1);
+	filter_enable_null_filter(adapter, 1);
+	filter_enable_mask_filter(adapter, 1);
 }
 */
 
-static void InitPIDsInfo(struct adapter *adapter)
-{
-	int i;
-
-	for (i = 0; i < 0x27; i++)
-		adapter->pids[i] = 0x1FFF;
-}
-
-static int CheckPID(struct adapter *adapter, u16 pid)
-{
-	u32 i;
-
-	if (pid == 0x1FFF)
-		return 0;
-
-	for (i = 0; i < 0x27; i++) {
-		if (adapter->pids[i] == pid)
-			return 1;
-	}
-
-	return 0;
-}
-
-static void PidSetGroupPID(struct adapter * adapter, u32 pid)
+static void pid_set_group_pid(struct adapter *adapter, u16 pid)
 {
 	u32 value;
 
 	dprintk("%s: pid=%x\n", __FUNCTION__, pid);
-
-	value = (pid & 0x3FFF) | (ReadRegDW(adapter, 0x30C) & 0xFFFF0000);
-
-	WriteRegDW(adapter, 0x30C, value);
-
-	/* return value is never used? */
-/*	return value; */
+	value = (pid & 0x3fff) | (read_reg_dw(adapter, 0x30c) & 0xffff0000);
+	write_reg_dw(adapter, 0x30c, value);
 }
 
-static void PidSetGroupMASK(struct adapter * adapter, u32 pid)
+static void pid_set_group_mask(struct adapter *adapter, u16 pid)
 {
 	u32 value;
 
 	dprintk("%s: pid=%x\n", __FUNCTION__, pid);
-
-	value = ((pid & 0x3FFF) << 0x10) | (ReadRegDW(adapter, 0x30C) & 0xFFFF);
-
-	WriteRegDW(adapter, 0x30C, value);
-
-	/* return value is never used? */
-/*	return value; */
+	value = ((pid & 0x3fff) << 0x10) | (read_reg_dw(adapter, 0x30c) & 0xffff);
+	write_reg_dw(adapter, 0x30c, value);
 }
 
-static void PidSetStream1PID(struct adapter * adapter, u32 pid)
-{
-	u32 value;
-
-	dprintk("%s: pid=%x\n", __FUNCTION__, pid);
-
-	value = (pid & 0x3FFF) | (ReadRegDW(adapter, 0x300) & 0xFFFFC000);
-
-	WriteRegDW(adapter, 0x300, value);
-
-	/* return value is never used? */
-/*	return value; */
-}
-
-static void PidSetStream2PID(struct adapter * adapter, u32 pid)
-{
-	u32 value;
-
-	dprintk("%s: pid=%x\n", __FUNCTION__, pid);
-
-	value = ((pid & 0x3FFF) << 0x10) | (ReadRegDW(adapter, 0x300) & 0xFFFF);
-
-	WriteRegDW(adapter, 0x300, value);
-
-	/* return value is never used? */
-/*	return value; */
-}
-
-static void PidSetPcrPID(struct adapter * adapter, u32 pid)
-{
-	u32 value;
-
-	dprintk("%s: pid=%x\n", __FUNCTION__, pid);
-
-	value = (pid & 0x3FFF) | (ReadRegDW(adapter, 0x304) & 0xFFFFC000);
-
-	WriteRegDW(adapter, 0x304, value);
-
-	/* return value is never used? */
-/*	return value; */
-}
-
-static void PidSetPmtPID(struct adapter * adapter, u32 pid)
+/*
+static int pid_get_group_pid(struct adapter *adapter)
 {
-	u32 value;
-
-	dprintk("%s: pid=%x\n", __FUNCTION__, pid);
-
-	value = ((pid & 0x3FFF) << 0x10) | (ReadRegDW(adapter, 0x304) & 0x3FFF);
-
-	WriteRegDW(adapter, 0x304, value);
-
-	/* return value is never used? */
-/*	return value; */
+	return read_reg_dw(adapter, 0x30c) & 0x00001fff;
 }
 
-static void PidSetEmmPID(struct adapter * adapter, u32 pid)
+static int pid_get_group_mask(struct adapter *adapter)
 {
-	u32 value;
-
-	dprintk("%s: pid=%x\n", __FUNCTION__, pid);
-
-	value = (pid & 0xFFFF) | (ReadRegDW(adapter, 0x308) & 0xFFFF0000);
-
-	WriteRegDW(adapter, 0x308, value);
-
-	/* return value is never used? */
-/*	return value; */
+	return (read_reg_dw(adapter, 0x30c) >> 0x10)& 0x00001fff;
 }
+*/
 
-static void PidSetEcmPID(struct adapter * adapter, u32 pid)
+/*
+static void reset_hardware_pid_filter(struct adapter *adapter)
 {
-	u32 value;
-
-	dprintk("%s: pid=%x\n", __FUNCTION__, pid);
+	pid_set_stream1_pid(adapter, 0x1fff);
 
-	value = (pid << 0x10) | (ReadRegDW(adapter, 0x308) & 0xFFFF);
+	pid_set_stream2_pid(adapter, 0x1fff);
+	filter_enable_stream2_filter(adapter, 0);
 
-	WriteRegDW(adapter, 0x308, value);
+	pid_set_pcr_pid(adapter, 0x1fff);
+	filter_enable_pcr_filter(adapter, 0);
 
-	/* return value is never used? */
-/*	return value; */
-}
+	pid_set_pmt_pid(adapter, 0x1fff);
+	filter_enable_pmt_filter(adapter, 0);
 
-static int PidGetStream1PID(struct adapter * adapter)
-{
-	return ReadRegDW(adapter, 0x300) & 0x00001FFF;
-}
+	pid_set_ecm_pid(adapter, 0x1fff);
+	filter_enable_ecm_filter(adapter, 0);
 
-static int PidGetStream2PID(struct adapter * adapter)
-{
-	return (ReadRegDW(adapter, 0x300) >> 0x10)& 0x00001FFF;
+	pid_set_emm_pid(adapter, 0x1fff);
+	filter_enable_emm_filter(adapter, 0);
 }
+*/
 
-static int PidGetPcrPID(struct adapter * adapter)
+static void init_pids(struct adapter *adapter)
 {
-	return ReadRegDW(adapter, 0x304) & 0x00001FFF;
-}
+	int i;
 
-static int PidGetPmtPID(struct adapter * adapter)
-{
-	return (ReadRegDW(adapter, 0x304) >> 0x10)& 0x00001FFF;
+	adapter->pid_count = 0;
+	adapter->whole_bandwidth_count = 0;
+	for (i = 0; i < adapter->useable_hw_filters; i++) {
+		dprintk("%s: setting filter %d to 0x1fff\n", __FUNCTION__, i);
+		adapter->hw_pids[i] = 0x1fff;
+		pid_set_hw_pid(adapter, i, 0x1fff);
 }
 
-static int PidGetEmmPID(struct adapter * adapter)
-{
-	return ReadRegDW(adapter, 0x308) & 0x00001FFF;
+	pid_set_group_pid(adapter, 0);
+	pid_set_group_mask(adapter, 0x1fe0);
 }
 
-static int PidGetEcmPID(struct adapter * adapter)
+static void open_whole_bandwidth(struct adapter *adapter)
 {
-	return (ReadRegDW(adapter, 0x308) >> 0x10)& 0x00001FFF;
+	dprintk("%s:\n", __FUNCTION__);
+	pid_set_group_pid(adapter, 0);
+	pid_set_group_mask(adapter, 0);
+/*
+	filter_enable_mask_filter(adapter, 1);
+*/
 }
 
-static int PidGetGroupPID(struct adapter * adapter)
+static void close_whole_bandwidth(struct adapter *adapter)
 {
-	return ReadRegDW(adapter, 0x30C) & 0x00001FFF;
+	dprintk("%s:\n", __FUNCTION__);
+	pid_set_group_pid(adapter, 0);
+	pid_set_group_mask(adapter, 0x1fe0);
+/*
+	filter_enable_mask_filter(adapter, 1);
+*/
 }
 
-static int PidGetGroupMASK(struct adapter * adapter)
+static void whole_bandwidth_inc(struct adapter *adapter)
 {
-	return (ReadRegDW(adapter, 0x30C) >> 0x10)& 0x00001FFF;
+	if (adapter->whole_bandwidth_count++ == 0)
+		open_whole_bandwidth(adapter);
 }
 
-/*
-static void ResetHardwarePIDFilter(struct adapter *adapter)
+static void whole_bandwidth_dec(struct adapter *adapter)
 {
-	PidSetStream1PID(adapter, 0x1FFF);
-
-	PidSetStream2PID(adapter, 0x1FFF);
-	FilterEnableStream2Filter(adapter, 0);
-
-	PidSetPcrPID(adapter, 0x1FFF);
-	FilterEnablePcrFilter(adapter, 0);
-
-	PidSetPmtPID(adapter, 0x1FFF);
-	FilterEnablePmtFilter(adapter, 0);
-
-	PidSetEcmPID(adapter, 0x1FFF);
-	FilterEnableEcmFilter(adapter, 0);
-
-	PidSetEmmPID(adapter, 0x1FFF);
-	FilterEnableEmmFilter(adapter, 0);
+	if (--adapter->whole_bandwidth_count <= 0)
+		close_whole_bandwidth(adapter);
 }
-*/
 
-static void OpenWholeBandwidth(struct adapter *adapter)
+/* The specified PID has to be let through the
+   hw filters.
+   We try to allocate an hardware filter and open whole
+   bandwidth when allocation is impossible.
+   All pids<=0x1f pass through the group filter.
+   Returns 1 on success, -1 on error */
+static int add_hw_pid(struct adapter *adapter, u16 pid)
 {
-	PidSetGroupPID(adapter, 0);
-
-	PidSetGroupMASK(adapter, 0);
-
-	FilterEnableMaskFilter(adapter, 1);
-}
+	int i;
 
-static int AddHwPID(struct adapter *adapter, u32 pid)
-{
 	dprintk("%s: pid=%d\n", __FUNCTION__, pid);
 
-	if (pid <= 0x1F)
-		return 1;
-
-	if ((PidGetGroupMASK(adapter) == 0) && (PidGetGroupPID(adapter) == 0))
-		return 0;
-
-	if (PidGetStream1PID(adapter) == 0x1FFF) {
-		PidSetStream1PID(adapter, pid & 0xFFFF);
-
-		FilterEnableStream1Filter(adapter, 1);
-
+	if (pid <= 0x1f)
 		return 1;
-	}
-
-	if (PidGetStream2PID(adapter) == 0x1FFF) {
-		PidSetStream2PID(adapter, (pid & 0xFFFF));
-
-		FilterEnableStream2Filter(adapter, 1);
 
+	/* we can't use a filter for 0x2000, so no search */
+	if (pid != 0x2000) {
+		/* find an unused hardware filter */
+		for (i = 0; i < adapter->useable_hw_filters; i++) {
+			dprintk("%s: pid=%d searching slot=%d\n", __FUNCTION__, pid, i);
+			if (adapter->hw_pids[i] == 0x1fff) {
+				dprintk("%s: pid=%d slot=%d\n", __FUNCTION__, pid, i);
+				adapter->hw_pids[i] = pid;
+				pid_set_hw_pid(adapter, i, pid);
+				filter_enable_hw_filter(adapter, i, 1);
 		return 1;
 	}
-
-	if (PidGetPcrPID(adapter) == 0x1FFF) {
-		PidSetPcrPID(adapter, (pid & 0xFFFF));
-
-		FilterEnablePcrFilter(adapter, 1);
-
-		return 1;
 	}
-
-	if ((PidGetPmtPID(adapter) & 0x1FFF) == 0x1FFF) {
-		PidSetPmtPID(adapter, (pid & 0xFFFF));
-
-		FilterEnablePmtFilter(adapter, 1);
-
-		return 1;
 	}
-
-	if ((PidGetEmmPID(adapter) & 0x1FFF) == 0x1FFF) {
-		PidSetEmmPID(adapter, (pid & 0xFFFF));
-
-		FilterEnableEmmFilter(adapter, 1);
-
+	/* if we have not used a filter, this pid depends on whole bandwidth */
+	dprintk("%s: pid=%d whole_bandwidth\n", __FUNCTION__, pid);
+	whole_bandwidth_inc(adapter);
 		return 1;
 	}
 
-	if ((PidGetEcmPID(adapter) & 0x1FFF) == 0x1FFF) {
-		PidSetEcmPID(adapter, (pid & 0xFFFF));
-
-		FilterEnableEcmFilter(adapter, 1);
-
-		return 1;
-	}
-
-	return -1;
-}
-
-static int RemoveHwPID(struct adapter *adapter, u32 pid)
+/* returns -1 if the pid was not present in the filters */
+static int remove_hw_pid(struct adapter *adapter, u16 pid)
 {
-	dprintk("%s: pid=%d\n", __FUNCTION__, pid);
-
-	if (pid <= 0x1F)
-		return 1;
-
-	if (PidGetStream1PID(adapter) == pid) {
-		PidSetStream1PID(adapter, 0x1FFF);
-
-		return 1;
-	}
-
-	if (PidGetStream2PID(adapter) == pid) {
-		PidSetStream2PID(adapter, 0x1FFF);
+	int i;
 
-		FilterEnableStream2Filter(adapter, 0);
+	dprintk("%s: pid=%d\n", __FUNCTION__, pid);
 
+	if (pid <= 0x1f)
 		return 1;
-	}
-
-	if (PidGetPcrPID(adapter) == pid) {
-		PidSetPcrPID(adapter, 0x1FFF);
-
-		FilterEnablePcrFilter(adapter, 0);
 
+	/* we can't use a filter for 0x2000, so no search */
+	if (pid != 0x2000) {
+		for (i = 0; i < adapter->useable_hw_filters; i++) {
+			dprintk("%s: pid=%d searching slot=%d\n", __FUNCTION__, pid, i);
+			if (adapter->hw_pids[i] == pid) {	// find the pid slot
+				dprintk("%s: pid=%d slot=%d\n", __FUNCTION__, pid, i);
+				adapter->hw_pids[i] = 0x1fff;
+				pid_set_hw_pid(adapter, i, 0x1fff);
+				filter_enable_hw_filter(adapter, i, 0);
 		return 1;
 	}
-
-	if (PidGetPmtPID(adapter) == pid) {
-		PidSetPmtPID(adapter, 0x1FFF);
-
-		FilterEnablePmtFilter(adapter, 0);
-
-		return 1;
 	}
-
-	if (PidGetEmmPID(adapter) == pid) {
-		PidSetEmmPID(adapter, 0x1FFF);
-
-		FilterEnableEmmFilter(adapter, 0);
-
-		return 1;
 	}
-
-	if (PidGetEcmPID(adapter) == pid) {
-		PidSetEcmPID(adapter, 0x1FFF);
-
-		FilterEnableEcmFilter(adapter, 0);
-
+	/* if we have not used a filter, this pid depended on whole bandwith */
+	dprintk("%s: pid=%d whole_bandwidth\n", __FUNCTION__, pid);
+	whole_bandwidth_dec(adapter);
 		return 1;
 	}
 
-	return -1;
-}
-
-static int AddPID(struct adapter *adapter, u32 pid)
+/* Adds a PID to the filters.
+   Adding a pid more than once is possible, we keep reference counts.
+   Whole stream available through pid==0x2000.
+   Returns 1 on success, -1 on error */
+static int add_pid(struct adapter *adapter, u16 pid)
 {
 	int i;
 
 	dprintk("%s: pid=%d\n", __FUNCTION__, pid);
 
-	if (pid > 0x1FFE)
+	if (pid > 0x1ffe && pid != 0x2000)
 		return -1;
 
-	if (CheckPID(adapter, pid) == 1)
+	// check if the pid is already present
+	for (i = 0; i < adapter->pid_count; i++)
+		if (adapter->pid_list[i] == pid) {
+			adapter->pid_rc[i]++;	// increment ref counter
 		return 1;
+		}
 
-	for (i = 0; i < 0x27; i++) {
-		if (adapter->pids[i] == 0x1FFF)	// find free pid filter
-		{
-			adapter->pids[i] = pid;
-
-			if (AddHwPID(adapter, pid) < 0)
-				OpenWholeBandwidth(adapter);
+	if (adapter->pid_count == N_PID_SLOTS)
+		return -1;	// no more pids can be added
+	adapter->pid_list[adapter->pid_count] = pid;	// register pid
+	adapter->pid_rc[adapter->pid_count] = 1;
+	adapter->pid_count++;
+	// hardware setting
+	add_hw_pid(adapter, pid);
 
 			return 1;
 		}
-	}
-
-	return -1;
-}
 
-static int RemovePID(struct adapter *adapter, u32 pid)
+/* Removes a PID from the filters. */
+static int remove_pid(struct adapter *adapter, u16 pid)
 {
-	u32 i;
+	int i, j;
 
 	dprintk("%s: pid=%d\n", __FUNCTION__, pid);
 
-	if (pid > 0x1FFE)
+	if (pid > 0x1ffe && pid != 0x2000)
 		return -1;
 
-	for (i = 0; i < 0x27; i++) {
-		if (adapter->pids[i] == pid) {
-			adapter->pids[i] = 0x1FFF;
-
-			RemoveHwPID(adapter, pid);
-
+	// check if the pid is present (it must be!)
+	for (i = 0; i < adapter->pid_count; i++) {
+		if (adapter->pid_list[i] == pid) {
+			adapter->pid_rc[i]--;
+			if (adapter->pid_rc[i] <= 0) {
+				// remove from the list
+				adapter->pid_count--;
+				adapter->pid_list[i]=adapter->pid_list[adapter->pid_count];
+				adapter->pid_rc[i] = adapter->pid_rc[adapter->pid_count];
+				// hardware setting
+				remove_hw_pid(adapter, pid);
+			}
 			return 1;
 		}
 	}
@@ -1475,21 +1254,16 @@
 	return -1;
 }
 
+
 /* dma & irq */
-static void CtrlEnableSmc(struct adapter *adapter, u32 op)
+static void ctrl_enable_smc(struct adapter *adapter, u32 op)
 {
-	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00000800, 0);
-
-	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00000800);
-	}
+	write_reg_bitfield(adapter, 0x208, 0x00000800, op ? 0x00000800 : 0);
 }
 
-static void DmaEnableDisableIrq(struct adapter *adapter, u32 flag1, u32 flag2, u32 flag3)
+static void dma_enable_disable_irq(struct adapter *adapter, u32 flag1, u32 flag2, u32 flag3)
 {
-	adapter->dma_ctrl = adapter->dma_ctrl & 0x000F0000;
+	adapter->dma_ctrl = adapter->dma_ctrl & 0x000f0000;
 
 	if (flag1 == 0) {
 		if (flag2 == 0)
@@ -1516,16 +1290,16 @@
 	}
 }
 
-static void IrqDmaEnableDisableIrq(struct adapter * adapter, u32 op)
+static void irq_dma_enable_disable_irq(struct adapter *adapter, u32 op)
 {
 	u32 value;
 
-	value = ReadRegDW(adapter, 0x208) & 0xFFF0FFFF;
+	value = read_reg_dw(adapter, 0x208) & 0xfff0ffff;
 
 	if (op != 0)
-		value = value | (adapter->dma_ctrl & 0x000F0000);
+		value = value | (adapter->dma_ctrl & 0x000f0000);
 
-	WriteRegDW(adapter, 0x208, value);
+	write_reg_dw(adapter, 0x208, value);
 }
 
 /* FlexCopII has 2 dma channels. DMA1 is used to transfer TS data to
@@ -1544,7 +1318,7 @@
        subbuffer. The last 2 bits contain 0, when dma1 is disabled and 1,
        when dma1 is enabled.
 
-       the first 30 bits of register 0x00C contain the address of the second
+       the first 30 bits of register 0x00c contain the address of the second
        subbuffer. the last 2 bits contain 1.
 
        register 0x008 will contain the address of the subbuffer that was filled
@@ -1559,13 +1333,13 @@
        subbuffer.  The last 2 bits contain 0, when dma1 is disabled and 1,
        when dma1 is enabled.
 
-       the first 30 bits of register 0x01C contain the address of the second
+       the first 30 bits of register 0x01c contain the address of the second
        subbuffer. the last 2 bits contain 1.
 
        register 0x018 contains the address of the subbuffer that was filled
        with TS data, when FlexCopII generates an interrupt.
 */
-static int DmaInitDMA(struct adapter *adapter, u32 dma_channel)
+static int dma_init_dma(struct adapter *adapter, u32 dma_channel)
 {
 	u32 subbuffers, subbufsize, subbuf0, subbuf1;
 
@@ -1576,37 +1350,37 @@
 
 		subbufsize = (((adapter->dmaq1.buffer_size / 2) / 4) << 8) | subbuffers;
 
-		subbuf0 = adapter->dmaq1.bus_addr & 0xFFFFFFFC;
+		subbuf0 = adapter->dmaq1.bus_addr & 0xfffffffc;
 
-		subbuf1 = ((adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) & 0xFFFFFFFC) | 1;
+		subbuf1 = ((adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) & 0xfffffffc) | 1;
 
 		dprintk("%s: first subbuffer address = 0x%x\n", __FUNCTION__, subbuf0);
 		udelay(1000);
-		WriteRegDW(adapter, 0x000, subbuf0);
+		write_reg_dw(adapter, 0x000, subbuf0);
 
 		dprintk("%s: subbuffer size = 0x%x\n", __FUNCTION__, (subbufsize >> 8) * 4);
 		udelay(1000);
-		WriteRegDW(adapter, 0x004, subbufsize);
+		write_reg_dw(adapter, 0x004, subbufsize);
 
 		dprintk("%s: second subbuffer address = 0x%x\n", __FUNCTION__, subbuf1);
 		udelay(1000);
-		WriteRegDW(adapter, 0x00C, subbuf1);
+		write_reg_dw(adapter, 0x00c, subbuf1);
 
-		dprintk("%s: counter = 0x%x\n", __FUNCTION__, adapter->dmaq1.bus_addr & 0xFFFFFFFC);
-		WriteRegDW(adapter, 0x008, adapter->dmaq1.bus_addr & 0xFFFFFFFC);
+		dprintk("%s: counter = 0x%x\n", __FUNCTION__, adapter->dmaq1.bus_addr & 0xfffffffc);
+		write_reg_dw(adapter, 0x008, adapter->dmaq1.bus_addr & 0xfffffffc);
 		udelay(1000);
 
 		if (subbuffers == 0)
-			DmaEnableDisableIrq(adapter, 0, 1, 0);
+			dma_enable_disable_irq(adapter, 0, 1, 0);
 		else
-			DmaEnableDisableIrq(adapter, 0, 1, 1);
+			dma_enable_disable_irq(adapter, 0, 1, 1);
 
-		IrqDmaEnableDisableIrq(adapter, 1);
+		irq_dma_enable_disable_irq(adapter, 1);
 
-		SRAMSetMediaDest(adapter, 1);
-		SRAMSetNetDest(adapter, 1);
-		SRAMSetCaiDest(adapter, 2);
-		SRAMSetCaoDest(adapter, 2);
+		sram_set_media_dest(adapter, 1);
+		sram_set_net_dest(adapter, 1);
+		sram_set_cai_dest(adapter, 2);
+		sram_set_cao_dest(adapter, 2);
 	}
 
 	if (dma_channel == 1) {
@@ -1616,39 +1390,35 @@
 
 		subbufsize = (((adapter->dmaq2.buffer_size / 2) / 4) << 8) | subbuffers;
 
-		subbuf0 = adapter->dmaq2.bus_addr & 0xFFFFFFFC;
+		subbuf0 = adapter->dmaq2.bus_addr & 0xfffffffc;
 
-		subbuf1 = ((adapter->dmaq2.bus_addr + adapter->dmaq2.buffer_size / 2) & 0xFFFFFFFC) | 1;
+		subbuf1 = ((adapter->dmaq2.bus_addr + adapter->dmaq2.buffer_size / 2) & 0xfffffffc) | 1;
 
 		dprintk("%s: first subbuffer address = 0x%x\n", __FUNCTION__, subbuf0);
 		udelay(1000);
-		WriteRegDW(adapter, 0x010, subbuf0);
+		write_reg_dw(adapter, 0x010, subbuf0);
 
 		dprintk("%s: subbuffer size = 0x%x\n", __FUNCTION__, (subbufsize >> 8) * 4);
 		udelay(1000);
-		WriteRegDW(adapter, 0x014, subbufsize);
+		write_reg_dw(adapter, 0x014, subbufsize);
 
 		dprintk("%s: second buffer address = 0x%x\n", __FUNCTION__, subbuf1);
 		udelay(1000);
-		WriteRegDW(adapter, 0x01C, subbuf1);
+		write_reg_dw(adapter, 0x01c, subbuf1);
 
-		SRAMSetCaiDest(adapter, 2);
+		sram_set_cai_dest(adapter, 2);
 	}
 
 	return 0;
 }
 
-static void CtrlEnableReceiveData(struct adapter *adapter, u32 op)
+static void ctrl_enable_receive_data(struct adapter *adapter, u32 op)
 {
 	if (op == 0) {
-		WriteRegOp(adapter, 0x208, 2, ~0x00008000, 0);
-
+		write_reg_bitfield(adapter, 0x208, 0x00008000, 0);
 		adapter->dma_status = adapter->dma_status & ~0x00000004;
-
 	} else {
-
-		WriteRegOp(adapter, 0x208, 1, 0, 0x00008000);
-
+		write_reg_bitfield(adapter, 0x208, 0x00008000, 0x00008000);
 		adapter->dma_status = adapter->dma_status | 0x00000004;
 	}
 }
@@ -1656,7 +1426,7 @@
 /* bit 0 of dma_mask is set to 1 if dma1 channel has to be enabled/disabled
    bit 1 of dma_mask is set to 1 if dma2 channel has to be enabled/disabled
 */
-static void DmaStartStop0x2102(struct adapter *adapter, u32 dma_mask, u32 start_stop)
+static void dma_start_stop(struct adapter *adapter, u32 dma_mask, int start_stop)
 {
 	u32 dma_enable, dma1_enable, dma2_enable;
 
@@ -1679,83 +1449,82 @@
 		}
 		// enable dma1 and dma2
 		if ((dma1_enable == 1) && (dma2_enable == 1)) {
-			WriteRegDW(adapter, 0x000, adapter->dmaq1.bus_addr | 1);
-			WriteRegDW(adapter, 0x00C, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
-			WriteRegDW(adapter, 0x010, adapter->dmaq2.bus_addr | 1);
+			write_reg_dw(adapter, 0x000, adapter->dmaq1.bus_addr | 1);
+			write_reg_dw(adapter, 0x00c, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
+			write_reg_dw(adapter, 0x010, adapter->dmaq2.bus_addr | 1);
 
-			CtrlEnableReceiveData(adapter, 1);
+			ctrl_enable_receive_data(adapter, 1);
 
 			return;
 		}
 		// enable dma1
 		if ((dma1_enable == 1) && (dma2_enable == 0)) {
-			WriteRegDW(adapter, 0x000, adapter->dmaq1.bus_addr | 1);
-			WriteRegDW(adapter, 0x00C, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
+			write_reg_dw(adapter, 0x000, adapter->dmaq1.bus_addr | 1);
+			write_reg_dw(adapter, 0x00c, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
 
-			CtrlEnableReceiveData(adapter, 1);
+			ctrl_enable_receive_data(adapter, 1);
 
 			return;
 		}
 		// enable dma2
 		if ((dma1_enable == 0) && (dma2_enable == 1)) {
-			WriteRegDW(adapter, 0x010, adapter->dmaq2.bus_addr | 1);
+			write_reg_dw(adapter, 0x010, adapter->dmaq2.bus_addr | 1);
 
-			CtrlEnableReceiveData(adapter, 1);
+			ctrl_enable_receive_data(adapter, 1);
 
 			return;
 		}
 		// start dma
 		if ((dma1_enable == 0) && (dma2_enable == 0)) {
-			CtrlEnableReceiveData(adapter, 1);
+			ctrl_enable_receive_data(adapter, 1);
 
 			return;
 		}
 
 	} else {
 
-		dprintk("%s: stoping dma\n", __FUNCTION__);
+		dprintk("%s: stopping dma\n", __FUNCTION__);
 
 		dma_enable = adapter->dma_status & 0x00000003;
 
 		if (((dma_mask & 1) != 0) && ((adapter->dma_status & 1) != 0)) {
-			dma_enable = dma_enable & 0xFFFFFFFE;
+			dma_enable = dma_enable & 0xfffffffe;
 		}
 
 		if (((dma_mask & 2) != 0) && ((adapter->dma_status & 2) != 0)) {
-			dma_enable = dma_enable & 0xFFFFFFFD;
+			dma_enable = dma_enable & 0xfffffffd;
 		}
 		//stop dma
 		if ((dma_enable == 0) && ((adapter->dma_status & 4) != 0)) {
-			CtrlEnableReceiveData(adapter, 0);
+			ctrl_enable_receive_data(adapter, 0);
 
 			udelay(3000);
 		}
 		//disable dma1
 		if (((dma_mask & 1) != 0) && ((adapter->dma_status & 1) != 0) && (adapter->dmaq1.bus_addr != 0)) {
-			WriteRegDW(adapter, 0x000, adapter->dmaq1.bus_addr);
-			WriteRegDW(adapter, 0x00C, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
+			write_reg_dw(adapter, 0x000, adapter->dmaq1.bus_addr);
+			write_reg_dw(adapter, 0x00c, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
 
 			adapter->dma_status = adapter->dma_status & ~0x00000001;
 		}
 		//disable dma2
 		if (((dma_mask & 2) != 0) && ((adapter->dma_status & 2) != 0) && (adapter->dmaq2.bus_addr != 0)) {
-			WriteRegDW(adapter, 0x010, adapter->dmaq2.bus_addr);
+			write_reg_dw(adapter, 0x010, adapter->dmaq2.bus_addr);
 
 			adapter->dma_status = adapter->dma_status & ~0x00000002;
 		}
 	}
 }
 
-static void OpenStream(struct adapter *adapter, u32 pid)
+static void open_stream(struct adapter *adapter, u16 pid)
 {
 	u32 dma_mask;
 
-	if (adapter->capturing == 0)
-		adapter->capturing = 1;
+	++adapter->capturing;
 
-	FilterEnableMaskFilter(adapter, 1);
+	filter_enable_mask_filter(adapter, 1);
 
-	AddPID(adapter, pid);
+	add_pid(adapter, pid);
 
 	dprintk("%s: adapter->dma_status=%x\n", __FUNCTION__, adapter->dma_status);
 
@@ -1779,23 +1548,22 @@
 		}
 
 		if (dma_mask != 0) {
-			IrqDmaEnableDisableIrq(adapter, 1);
+			irq_dma_enable_disable_irq(adapter, 1);
 
-			DmaStartStop0x2102(adapter, dma_mask, 1);
+			dma_start_stop(adapter, dma_mask, 1);
 		}
 	}
 }
 
-static void CloseStream(struct adapter *adapter, u32 pid)
+static void close_stream(struct adapter *adapter, u16 pid)
 {
-	u32 dma_mask;
-
-	if (adapter->capturing != 0)
-		adapter->capturing = 0;
+	if (adapter->capturing > 0)
+		--adapter->capturing;
 
 	dprintk("%s: dma_status=%x\n", __FUNCTION__, adapter->dma_status);
 
-	dma_mask = 0;
+	if (adapter->capturing == 0) {
+		u32 dma_mask = 0;
 
 	if ((adapter->dma_status & 1) != 0)
 		dma_mask = dma_mask | 0x00000001;
@@ -1803,94 +1571,76 @@
 		dma_mask = dma_mask | 0x00000002;
 
 	if (dma_mask != 0) {
-		DmaStartStop0x2102(adapter, dma_mask, 0);
+			dma_start_stop(adapter, dma_mask, 0);
 	}
-
-	RemovePID(adapter, pid);
+	}
+	remove_pid(adapter, pid);
 }
 
-static void InterruptServiceDMA1(struct adapter *adapter)
+static void interrupt_service_dma1(struct adapter *adapter)
 {
 	struct dvb_demux *dvbdmx = &adapter->demux;
-	struct packet_header packet_header;
 
-	int nCurDmaCounter;
-	u32 nNumBytesParsed;
-	u32 nNumNewBytesTransferred;
-	u32 dwDefaultPacketSize = 188;
-	u8 gbTmpBuffer[188];
-	u8 *pbDMABufCurPos;
+	int n_cur_dma_counter;
+	u32 n_num_bytes_parsed;
+	u32 n_num_new_bytes_transferred;
+	u32 dw_default_packet_size = 188;
+	u8 gb_tmp_buffer[188];
+	u8 *pb_dma_buf_cur_pos;
 
-	nCurDmaCounter = readl(adapter->io_mem + 0x008) - adapter->dmaq1.bus_addr;
-	nCurDmaCounter = (nCurDmaCounter / dwDefaultPacketSize) * dwDefaultPacketSize;
+	n_cur_dma_counter = readl(adapter->io_mem + 0x008) - adapter->dmaq1.bus_addr;
+	n_cur_dma_counter = (n_cur_dma_counter / dw_default_packet_size) * dw_default_packet_size;
 
-	if ((nCurDmaCounter < 0) || (nCurDmaCounter > adapter->dmaq1.buffer_size)) {
+	if ((n_cur_dma_counter < 0) || (n_cur_dma_counter > adapter->dmaq1.buffer_size)) {
 		dprintk("%s: dma counter outside dma buffer\n", __FUNCTION__);
 		return;
 	}
 
-	adapter->dmaq1.head = nCurDmaCounter;
+	adapter->dmaq1.head = n_cur_dma_counter;
 
-	if (adapter->dmaq1.tail <= nCurDmaCounter) {
-		nNumNewBytesTransferred = nCurDmaCounter - adapter->dmaq1.tail;
+	if (adapter->dmaq1.tail <= n_cur_dma_counter) {
+		n_num_new_bytes_transferred = n_cur_dma_counter - adapter->dmaq1.tail;
 
 	} else {
 
-		nNumNewBytesTransferred = (adapter->dmaq1.buffer_size - adapter->dmaq1.tail) + nCurDmaCounter;
+		n_num_new_bytes_transferred = (adapter->dmaq1.buffer_size - adapter->dmaq1.tail) + n_cur_dma_counter;
 	}
 
-//  dprintk("%s: nCurDmaCounter   = %d\n" , __FUNCTION__, nCurDmaCounter);
-//	dprintk("%s: dmaq1.tail       = %d\n" , __FUNCTION__, adapter->dmaq1.tail):
-//  dprintk("%s: BytesTransferred = %d\n" , __FUNCTION__, nNumNewBytesTransferred);
+	ddprintk("%s: n_cur_dma_counter = %d\n", __FUNCTION__, n_cur_dma_counter);
+	ddprintk("%s: dmaq1.tail        = %d\n", __FUNCTION__, adapter->dmaq1.tail);
+	ddprintk("%s: bytes_transferred = %d\n", __FUNCTION__, n_num_new_bytes_transferred);
 
-	if (nNumNewBytesTransferred < dwDefaultPacketSize)
+	if (n_num_new_bytes_transferred < dw_default_packet_size)
 		return;
 
-	nNumBytesParsed = 0;
+	n_num_bytes_parsed = 0;
 
-	while (nNumBytesParsed < nNumNewBytesTransferred) {
-		pbDMABufCurPos = adapter->dmaq1.buffer + adapter->dmaq1.tail;
+	while (n_num_bytes_parsed < n_num_new_bytes_transferred) {
+		pb_dma_buf_cur_pos = adapter->dmaq1.buffer + adapter->dmaq1.tail;
 
 		if (adapter->dmaq1.buffer + adapter->dmaq1.buffer_size < adapter->dmaq1.buffer + adapter->dmaq1.tail + 188) {
-			memcpy(gbTmpBuffer, adapter->dmaq1.buffer + adapter->dmaq1.tail, adapter->dmaq1.buffer_size - adapter->dmaq1.tail);
-			memcpy(gbTmpBuffer + (adapter->dmaq1.buffer_size - adapter->dmaq1.tail), adapter->dmaq1.buffer, (188 - (adapter->dmaq1.buffer_size - adapter->dmaq1.tail)));
+			memcpy(gb_tmp_buffer, adapter->dmaq1.buffer + adapter->dmaq1.tail,
+			       adapter->dmaq1.buffer_size - adapter->dmaq1.tail);
+			memcpy(gb_tmp_buffer + (adapter->dmaq1.buffer_size - adapter->dmaq1.tail), adapter->dmaq1.buffer,
+			       (188 - (adapter->dmaq1.buffer_size - adapter->dmaq1.tail)));
 
-			pbDMABufCurPos = gbTmpBuffer;
+			pb_dma_buf_cur_pos = gb_tmp_buffer;
 		}
 
 		if (adapter->capturing != 0) {
-			u32 *dq = (u32 *) pbDMABufCurPos;
-
-			packet_header.sync_byte = *dq & 0x000000FF;
-			packet_header.transport_error_indicator = *dq & 0x00008000;
-			packet_header.payload_unit_start_indicator = *dq & 0x00004000;
-			packet_header.transport_priority = *dq & 0x00002000;
-			packet_header.pid = ((*dq & 0x00FF0000) >> 0x10) | (*dq & 0x00001F00);
-			packet_header.transport_scrambling_control = *dq >> 0x1E;
-			packet_header.adaptation_field_control = (*dq & 0x30000000) >> 0x1C;
-			packet_header.continuity_counter = (*dq & 0x0F000000) >> 0x18;
-
-			if ((packet_header.sync_byte == 0x47) && (packet_header.transport_error_indicator == 0) && (packet_header.pid != 0x1FFF)) {
-				if (CheckPID(adapter, packet_header.pid & 0x0000FFFF) != 0) {
-					dvb_dmx_swfilter_packets(dvbdmx, pbDMABufCurPos, dwDefaultPacketSize / 188);
-
-				} else {
-
-//                  dprintk("%s: pid=%x\n", __FUNCTION__, packet_header.pid);
-				}
-			}
+			dvb_dmx_swfilter_packets(dvbdmx, pb_dma_buf_cur_pos, dw_default_packet_size / 188);
 		}
 
-		nNumBytesParsed = nNumBytesParsed + dwDefaultPacketSize;
+		n_num_bytes_parsed = n_num_bytes_parsed + dw_default_packet_size;
 
-		adapter->dmaq1.tail = adapter->dmaq1.tail + dwDefaultPacketSize;
+		adapter->dmaq1.tail = adapter->dmaq1.tail + dw_default_packet_size;
 
 		if (adapter->dmaq1.tail >= adapter->dmaq1.buffer_size)
 			adapter->dmaq1.tail = adapter->dmaq1.tail - adapter->dmaq1.buffer_size;
 	};
 }
 
-static void InterruptServiceDMA2(struct adapter *adapter)
+static void interrupt_service_dma2(struct adapter *adapter)
 {
 	printk("%s:\n", __FUNCTION__);
 }
@@ -1901,28 +1651,28 @@
 
 	u32 value;
 
-//  dprintk("%s:\n", __FUNCTION__);
+	ddprintk("%s:\n", __FUNCTION__);
 
 	spin_lock_irq(&tmp->lock);
 
-	if (0 == ((value = ReadRegDW(tmp, 0x20C)) & 0x0F)) {
+	if (0 == ((value = read_reg_dw(tmp, 0x20c)) & 0x0f)) {
 		spin_unlock_irq(&tmp->lock);
 		return IRQ_NONE;
 	}
 	
 	while (value != 0) {
 		if ((value & 0x03) != 0)
-			InterruptServiceDMA1(tmp);
-		if ((value & 0x0C) != 0)
-			InterruptServiceDMA2(tmp);
-		value = ReadRegDW(tmp, 0x20C) & 0x0F;
+			interrupt_service_dma1(tmp);
+		if ((value & 0x0c) != 0)
+			interrupt_service_dma2(tmp);
+		value = read_reg_dw(tmp, 0x20c) & 0x0f;
 	}
 
 	spin_unlock_irq(&tmp->lock);
 	return IRQ_HANDLED;
 }
 
-static void Initdmaqueue(struct adapter *adapter)
+static void init_dma_queue(struct adapter *adapter)
 {
 	dma_addr_t dma_addr;
 
@@ -1933,19 +1683,19 @@
 	adapter->dmaq1.tail = 0;
 	adapter->dmaq1.buffer = 0;
 
-	adapter->dmaq1.buffer = pci_alloc_consistent(adapter->pdev, SizeOfBufDMA1 + 0x80, &dma_addr);
+	adapter->dmaq1.buffer = pci_alloc_consistent(adapter->pdev, SIZE_OF_BUF_DMA1 + 0x80, &dma_addr);
 
 	if (adapter->dmaq1.buffer != 0) {
-		memset(adapter->dmaq1.buffer, 0, SizeOfBufDMA1);
+		memset(adapter->dmaq1.buffer, 0, SIZE_OF_BUF_DMA1);
 
 		adapter->dmaq1.bus_addr = dma_addr;
-		adapter->dmaq1.buffer_size = SizeOfBufDMA1;
+		adapter->dmaq1.buffer_size = SIZE_OF_BUF_DMA1;
 
-		DmaInitDMA(adapter, 0);
+		dma_init_dma(adapter, 0);
 
 		adapter->dma_status = adapter->dma_status | 0x10000000;
 
-		dprintk("%s: allocated dma buffer at 0x%p, length=%d\n", __FUNCTION__, adapter->dmaq1.buffer, SizeOfBufDMA1);
+		ddprintk("%s: allocated dma buffer at 0x%p, length=%d\n", __FUNCTION__, adapter->dmaq1.buffer, SIZE_OF_BUF_DMA1);
 
 	} else {
 
@@ -1959,19 +1709,19 @@
 	adapter->dmaq2.tail = 0;
 	adapter->dmaq2.buffer = 0;
 
-	adapter->dmaq2.buffer = pci_alloc_consistent(adapter->pdev, SizeOfBufDMA2 + 0x80, &dma_addr);
+	adapter->dmaq2.buffer = pci_alloc_consistent(adapter->pdev, SIZE_OF_BUF_DMA2 + 0x80, &dma_addr);
 
 	if (adapter->dmaq2.buffer != 0) {
-		memset(adapter->dmaq2.buffer, 0, SizeOfBufDMA2);
+		memset(adapter->dmaq2.buffer, 0, SIZE_OF_BUF_DMA2);
 
 		adapter->dmaq2.bus_addr = dma_addr;
-		adapter->dmaq2.buffer_size = SizeOfBufDMA2;
+		adapter->dmaq2.buffer_size = SIZE_OF_BUF_DMA2;
 
-		DmaInitDMA(adapter, 1);
+		dma_init_dma(adapter, 1);
 
 		adapter->dma_status = adapter->dma_status | 0x20000000;
 
-		dprintk("%s: allocated dma buffer at 0x%p, length=%d\n", __FUNCTION__, adapter->dmaq2.buffer, (int) SizeOfBufDMA2);
+		ddprintk("%s: allocated dma buffer at 0x%p, length=%d\n", __FUNCTION__, adapter->dmaq2.buffer, (int) SIZE_OF_BUF_DMA2);
 
 	} else {
 
@@ -1979,10 +1729,10 @@
 	}
 }
 
-static void Freedmaqueue(struct adapter *adapter)
+static void free_dma_queue(struct adapter *adapter)
 {
 	if (adapter->dmaq1.buffer != 0) {
-		pci_free_consistent(adapter->pdev, SizeOfBufDMA1 + 0x80, adapter->dmaq1.buffer, adapter->dmaq1.bus_addr);
+		pci_free_consistent(adapter->pdev, SIZE_OF_BUF_DMA1 + 0x80, adapter->dmaq1.buffer, adapter->dmaq1.bus_addr);
 
 		adapter->dmaq1.bus_addr = 0;
 		adapter->dmaq1.head = 0;
@@ -1992,7 +1742,7 @@
 	}
 
 	if (adapter->dmaq2.buffer != 0) {
-		pci_free_consistent(adapter->pdev, SizeOfBufDMA2 + 0x80, adapter->dmaq2.buffer, adapter->dmaq2.bus_addr);
+		pci_free_consistent(adapter->pdev, SIZE_OF_BUF_DMA2 + 0x80, adapter->dmaq2.buffer, adapter->dmaq2.bus_addr);
 
 		adapter->dmaq2.bus_addr = 0;
 		adapter->dmaq2.head = 0;
@@ -2002,16 +1752,16 @@
 	}
 }
 
-static void FreeAdapterObject(struct adapter *adapter)
+static void free_adapter_object(struct adapter *adapter)
 {
 	dprintk("%s:\n", __FUNCTION__);
 
-	CloseStream(adapter, 0);
+	close_stream(adapter, 0);
 
 	if (adapter->irq != 0)
 		free_irq(adapter->irq, adapter);
 
-	Freedmaqueue(adapter);
+	free_dma_queue(adapter);
 
 	if (adapter->io_mem != 0)
 		iounmap((void *) adapter->io_mem);
@@ -2022,7 +1772,7 @@
 
 static struct pci_driver skystar2_pci_driver;
 
-static int ClaimAdapter(struct adapter *adapter)
+static int claim_adapter(struct adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
 
@@ -2062,20 +1812,58 @@
 }
 
 /*
-static int SLL_reset_FlexCOP(struct adapter *adapter)
+static int sll_reset_flexcop(struct adapter *adapter)
 {
-	WriteRegDW(adapter, 0x208, 0);
-	WriteRegDW(adapter, 0x210, 0xB2FF);
+	write_reg_dw(adapter, 0x208, 0);
+	write_reg_dw(adapter, 0x210, 0xb2ff);
 
 	return 0;
 }
 */
 
-static int DriverInitialize(struct pci_dev * pdev)
+static void decide_how_many_hw_filters(struct adapter *adapter)
+{
+	int hw_filters;
+	int mod_option_hw_filters;
+
+	// FlexCop IIb & III have 6+32 hw filters    
+	// FlexCop II has 6 hw filters, every other should have at least 6
+	switch (adapter->b2c2_revision) {
+	case 0x82:		/* II */
+		hw_filters = 6;
+		break;
+	case 0xc3:		/* IIB */
+		hw_filters = 6 + 32;
+		break;
+	case 0xc0:		/* III */
+		hw_filters = 6 + 32;
+		break;
+	default:
+		hw_filters = 6;
+		break;
+	}
+	printk("%s: the chip has %i hardware filters", __FILE__, hw_filters);
+
+	mod_option_hw_filters = 0;
+	if (enable_hw_filters >= 1)
+		mod_option_hw_filters += 6;
+	if (enable_hw_filters >= 2)
+		mod_option_hw_filters += 32;
+
+	if (mod_option_hw_filters >= hw_filters) {
+		adapter->useable_hw_filters = hw_filters;
+	} else {
+		adapter->useable_hw_filters = mod_option_hw_filters;
+		printk(", but only %d will be used because of module option", mod_option_hw_filters);
+	}
+	printk("\n");
+	dprintk("%s: useable_hardware_filters set to %i\n", __FILE__, adapter->useable_hw_filters);
+}
+
+static int driver_initialize(struct pci_dev *pdev)
 {
 	struct adapter *adapter;
 	u32 tmp;
-	u8 key[16];
 
 	if (!(adapter = kmalloc(sizeof(struct adapter), GFP_KERNEL))) {
 		dprintk("%s: out of memory!\n", __FUNCTION__);
@@ -2090,113 +1878,114 @@
 	adapter->pdev = pdev;
 	adapter->irq = pdev->irq;
 
-	if ((ClaimAdapter(adapter)) != 1) {
-		FreeAdapterObject(adapter);
+	if ((claim_adapter(adapter)) != 1) {
+		free_adapter_object(adapter);
 
 		return -ENODEV;
 	}
 
-	IrqDmaEnableDisableIrq(adapter, 0);
+	irq_dma_enable_disable_irq(adapter, 0);
 
 	if (request_irq(pdev->irq, isr, 0x4000000, "Skystar2", adapter) != 0) {
 		dprintk("%s: unable to allocate irq=%d !\n", __FUNCTION__, pdev->irq);
 
-		FreeAdapterObject(adapter);
+		free_adapter_object(adapter);
 
 		return -ENODEV;
 	}
 
-	ReadRegDW(adapter, 0x208);
-	WriteRegDW(adapter, 0x208, 0);
-	WriteRegDW(adapter, 0x210, 0xB2FF);
-	WriteRegDW(adapter, 0x208, 0x40);
-
-	InitPIDsInfo(adapter);
-
-	PidSetGroupPID(adapter, 0);
-	PidSetGroupMASK(adapter, 0x1FE0);
-	PidSetStream1PID(adapter, 0x1FFF);
-	PidSetStream2PID(adapter, 0x1FFF);
-	PidSetPmtPID(adapter, 0x1FFF);
-	PidSetPcrPID(adapter, 0x1FFF);
-	PidSetEcmPID(adapter, 0x1FFF);
-	PidSetEmmPID(adapter, 0x1FFF);
+	read_reg_dw(adapter, 0x208);
+	write_reg_dw(adapter, 0x208, 0);
+	write_reg_dw(adapter, 0x210, 0xb2ff);
+	write_reg_dw(adapter, 0x208, 0x40);
 
-	Initdmaqueue(adapter);
+	init_dma_queue(adapter);
 
 	if ((adapter->dma_status & 0x30000000) == 0) {
-		FreeAdapterObject(adapter);
+		free_adapter_object(adapter);
 
 		return -ENODEV;
 	}
 
-	adapter->b2c2_revision = (ReadRegDW(adapter, 0x204) >> 0x18);
-
-	if ((adapter->b2c2_revision != 0x82) && (adapter->b2c2_revision != 0xC3))
-		if (adapter->b2c2_revision != 0x82) {
-			dprintk("%s: The revision of the FlexCopII chip on your card is - %d\n", __FUNCTION__, adapter->b2c2_revision);
-			dprintk("%s: This driver works now only with FlexCopII(rev.130) and FlexCopIIB(rev.195).\n", __FUNCTION__);
-
-			FreeAdapterObject(adapter);
+	adapter->b2c2_revision = (read_reg_dw(adapter, 0x204) >> 0x18);
 
+	switch (adapter->b2c2_revision) {
+	case 0x82:
+		printk("%s: FlexCopII(rev.130) chip found\n", __FILE__);
+		break;
+	case 0xc3:
+		printk("%s: FlexCopIIB(rev.195) chip found\n", __FILE__);
+		break;
+	case 0xc0:
+		printk("%s: FlexCopIII(rev.192) chip found\n", __FILE__);
+		break;
+	default:
+		printk("%s: The revision of the FlexCop chip on your card is %d\n", __FILE__, adapter->b2c2_revision);
+		printk("%s: This driver works only with FlexCopII(rev.130), FlexCopIIB(rev.195) and FlexCopIII(rev.192).\n", __FILE__);
+		free_adapter_object(adapter);
+		pci_set_drvdata(pdev, NULL);
+		release_region(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1));
+		release_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0));
 			return -ENODEV;
 		}
 
-	tmp = ReadRegDW(adapter, 0x204);
+	decide_how_many_hw_filters(adapter);
+
+	init_pids(adapter);
 
-	WriteRegDW(adapter, 0x204, 0);
+	tmp = read_reg_dw(adapter, 0x204);
+
+	write_reg_dw(adapter, 0x204, 0);
 	mdelay(20);
 
-	WriteRegDW(adapter, 0x204, tmp);
+	write_reg_dw(adapter, 0x204, tmp);
 	mdelay(10);
 
-	tmp = ReadRegDW(adapter, 0x308);
-	WriteRegDW(adapter, 0x308, 0x4000 | tmp);
+	tmp = read_reg_dw(adapter, 0x308);
+	write_reg_dw(adapter, 0x308, 0x4000 | tmp);
 
-	adapter->dwSramType = 0x10000;
+	adapter->dw_sram_type = 0x10000;
 
-	SLL_detectSramSize(adapter);
+	sll_detect_sram_size(adapter);
 
-	dprintk("%s sram length = %d, sram type= %x\n", __FUNCTION__, SRAM_length(adapter), adapter->dwSramType);
+	dprintk("%s sram length = %d, sram type= %x\n", __FUNCTION__, sram_length(adapter), adapter->dw_sram_type);
 
-	SRAMSetMediaDest(adapter, 1);
-	SRAMSetNetDest(adapter, 1);
+	sram_set_media_dest(adapter, 1);
+	sram_set_net_dest(adapter, 1);
 
-	CtrlEnableSmc(adapter, 0);
+	ctrl_enable_smc(adapter, 0);
 
-	SRAMSetCaiDest(adapter, 2);
-	SRAMSetCaoDest(adapter, 2);
+	sram_set_cai_dest(adapter, 2);
+	sram_set_cao_dest(adapter, 2);
 
-	DmaEnableDisableIrq(adapter, 1, 0, 0);
+	dma_enable_disable_irq(adapter, 1, 0, 0);
 
-	if (EEPROM_getMacAddr(adapter, 0, adapter->mac_addr) != 0) {
-		printk("%s MAC address = %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x \n", __FUNCTION__, adapter->mac_addr[0], adapter->mac_addr[1], adapter->mac_addr[2], adapter->mac_addr[3], adapter->mac_addr[4], adapter->mac_addr[5], adapter->mac_addr[6], adapter->mac_addr[7]
+	if (eeprom_get_mac_addr(adapter, 0, adapter->mac_addr) != 0) {
+		printk("%s MAC address = %02x:%02x:%02x:%02x:%02x:%02x:%02x:%02x \n", __FUNCTION__, adapter->mac_addr[0],
+		       adapter->mac_addr[1], adapter->mac_addr[2], adapter->mac_addr[3], adapter->mac_addr[4], adapter->mac_addr[5],
+		       adapter->mac_addr[6], adapter->mac_addr[7]
 		    );
 
-		CASetMacDstAddrFilter(adapter, adapter->mac_addr);
-		CtrlEnableMAC(adapter, 1);
+		ca_set_mac_dst_addr_filter(adapter, adapter->mac_addr);
+		ctrl_enable_mac(adapter, 1);
 	}
 
-	EEPROM_readKey(adapter, key, 16);
-
-	printk("%s key = \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n", __FUNCTION__, key[0], key[1], key[2], key[3], key[4], key[5], key[6], key[7], key[8], key[9], key[10], key[11], key[12], key[13], key[14], key[15]);
-
 	adapter->lock = SPIN_LOCK_UNLOCKED;
 
 	return 0;
 }
 
-static void DriverHalt(struct pci_dev *pdev)
+static void driver_halt(struct pci_dev *pdev)
 {
 	struct adapter *adapter;
 
 	adapter = pci_get_drvdata(pdev);
 
-	IrqDmaEnableDisableIrq(adapter, 0);
+	irq_dma_enable_disable_irq(adapter, 0);
 
-	CtrlEnableReceiveData(adapter, 0);
+	ctrl_enable_receive_data(adapter, 0);
 
-	FreeAdapterObject(adapter);
+	free_adapter_object(adapter);
 
 	pci_set_drvdata(pdev, NULL);
 
@@ -2212,7 +2001,7 @@
 
 	dprintk("%s: PID=%d, type=%d\n", __FUNCTION__, dvbdmxfeed->pid, dvbdmxfeed->type);
 
-	OpenStream(adapter, dvbdmxfeed->pid);
+	open_stream(adapter, dvbdmxfeed->pid);
 
 	return 0;
 }
@@ -2224,7 +2013,7 @@
 
 	dprintk("%s: PID=%d, type=%d\n", __FUNCTION__, dvbdmxfeed->pid, dvbdmxfeed->type);
 
-	CloseStream(adapter, dvbdmxfeed->pid);
+	close_stream(adapter, dvbdmxfeed->pid);
 
 	return 0;
 }
@@ -2232,23 +2021,23 @@
 /* lnb control */
 static void set_tuner_tone(struct adapter *adapter, u8 tone)
 {
-	u16 wzHalfPeriodFor45MHz[] = { 0x01FF, 0x0154, 0x00FF, 0x00CC };
+	u16 wz_half_period_for_45_mhz[] = { 0x01ff, 0x0154, 0x00ff, 0x00cc };
 	u16 ax;
 
 	dprintk("%s: %u\n", __FUNCTION__, tone);
 
 	switch (tone) {
 	case 1:
-		ax = wzHalfPeriodFor45MHz[0];
+		ax = wz_half_period_for_45_mhz[0];
 		break;
 	case 2:
-		ax = wzHalfPeriodFor45MHz[1];
+		ax = wz_half_period_for_45_mhz[1];
 		break;
 	case 3:
-		ax = wzHalfPeriodFor45MHz[2];
+		ax = wz_half_period_for_45_mhz[2];
 		break;
 	case 4:
-		ax = wzHalfPeriodFor45MHz[3];
+		ax = wz_half_period_for_45_mhz[3];
 		break;
 
 	default:
@@ -2256,11 +2045,11 @@
 	}
 
 	if (ax != 0) {
-		WriteRegDW(adapter, 0x200, ((ax << 0x0F) + (ax & 0x7FFF)) | 0x40000000);
+		write_reg_dw(adapter, 0x200, ((ax << 0x0f) + (ax & 0x7fff)) | 0x40000000);
 
 	} else {
 
-		WriteRegDW(adapter, 0x200, 0x40FF8000);
+		write_reg_dw(adapter, 0x200, 0x40ff8000);
 	}
 }
 
@@ -2270,7 +2059,7 @@
 
 	dprintk("%s : polarity = %u \n", __FUNCTION__, polarity);
 
-	var = ReadRegDW(adapter, 0x204);
+	var = read_reg_dw(adapter, 0x204);
 
 	if (polarity == 0) {
 		dprintk("%s: LNB power off\n", __FUNCTION__);
@@ -2287,82 +2076,150 @@
 		var = var | 4;
 	}
 
-	WriteRegDW(adapter, 0x204, var);
+	write_reg_dw(adapter, 0x204, var);
 }
 
-static int flexcop_diseqc_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
+static void diseqc_send_bit(struct adapter *adapter, int data)
 {
-	struct adapter *adapter = fe->before_after_data;
+	set_tuner_tone(adapter, 1);
+	udelay(data ? 500 : 1000);
+	set_tuner_tone(adapter, 0);
+	udelay(data ? 1000 : 500);
+}
 
-	switch (cmd) {
-	case FE_SLEEP:
+
+static void diseqc_send_byte(struct adapter *adapter, int data)
 		{
-			printk("%s: FE_SLEEP\n", __FUNCTION__);
+	int i, par = 1, d;
 
-			set_tuner_polarity(adapter, 0);
+	for (i = 7; i >= 0; i--) {
+		d = (data >> i) & 1;
+		par ^= d;
+		diseqc_send_bit(adapter, d);
+	}
 
-			// return -EOPNOTSUPP, to make DVB core also send "FE_SLEEP" command to frontend.
-			return -EOPNOTSUPP;
+	diseqc_send_bit(adapter, par);
 		}
 
-	case FE_SET_VOLTAGE:
-		{
-			dprintk("%s: FE_SET_VOLTAGE\n", __FUNCTION__);
 
-			switch ((fe_sec_voltage_t) arg) {
-			case SEC_VOLTAGE_13:
+static int send_diseqc_msg(struct adapter *adapter, int len, u8 *msg, unsigned long burst)
+{
+	int i;
 
-				printk("%s: SEC_VOLTAGE_13, %x\n", __FUNCTION__, SEC_VOLTAGE_13);
+	set_tuner_tone(adapter, 0);
+	mdelay(16);
 
-				set_tuner_polarity(adapter, 1);
+	for (i = 0; i < len; i++)
+		diseqc_send_byte(adapter, msg[i]);
 
-				break;
+	mdelay(16);
 
-			case SEC_VOLTAGE_18:
+	if (burst != -1) {
+		if (burst)
+			diseqc_send_byte(adapter, 0xff);
+		else {
+			set_tuner_tone(adapter, 1);
+			udelay(12500);
+			set_tuner_tone(adapter, 0);
+		}
+		dvb_delay(20);
+	}
 
-				printk("%s: SEC_VOLTAGE_18, %x\n", __FUNCTION__, SEC_VOLTAGE_18);
+	return 0;
+}
 
-				set_tuner_polarity(adapter, 2);
 
+int soft_diseqc(struct adapter *adapter, unsigned int cmd, void *arg)
+{
+	switch (cmd) {
+	case FE_SET_TONE:
+		switch ((fe_sec_tone_mode_t) arg) {
+		case SEC_TONE_ON:
+			set_tuner_tone(adapter, 1);
+			break;
+		case SEC_TONE_OFF:
+			set_tuner_tone(adapter, 0);
 				break;
-
 			default:
-
 				return -EINVAL;
 			};
+		break;
 
+	case FE_DISEQC_SEND_MASTER_CMD:
+		{
+			struct dvb_diseqc_master_cmd *cmd = arg;
+
+			send_diseqc_msg(adapter, cmd->msg_len, cmd->msg, 0);
 			break;
 		}
 
-	case FE_SET_TONE:
+	case FE_DISEQC_SEND_BURST:
+		send_diseqc_msg(adapter, 0, NULL, (unsigned long) arg);
+		break;
+
+	default:
+		return -EOPNOTSUPP;
+	};
+
+	return 0;
+}
+
+static int flexcop_diseqc_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
 		{
-			dprintk("%s: FE_SET_TONE\n", __FUNCTION__);
+	struct adapter *adapter = fe->before_after_data;
 
-			switch ((fe_sec_tone_mode_t) arg) {
-			case SEC_TONE_ON:
+	struct dvb_frontend_info info;
 
-				printk("%s: SEC_TONE_ON, %x\n", __FUNCTION__, SEC_TONE_ON);
+	fe->ioctl(fe, FE_GET_INFO, &info);
 
-				set_tuner_tone(adapter, 1);
+	// we must use different DiSEqC hw
 
-				break;
+	if (strcmp(info.name, "Zarlink MT312") == 0) {
+		//VP310 using mt312 driver for tuning only: diseqc not wired
+		//use FCII instead
+		if (!soft_diseqc(adapter, cmd, arg))
+			return 0;
+	}
 
-			case SEC_TONE_OFF:
+	switch (cmd) {
+	case FE_SLEEP:
+		{
+			dprintk("%s: FE_SLEEP\n", __FUNCTION__);
 
-				printk("%s: SEC_TONE_OFF, %x\n", __FUNCTION__, SEC_TONE_OFF);
+			set_tuner_polarity(adapter, 0);
 
-				set_tuner_tone(adapter, 0);
+			// return -EOPNOTSUPP, to make DVB core also send "FE_SLEEP" command to frontend.
+			return -EOPNOTSUPP;
+		}
 
-				break;
+	case FE_SET_VOLTAGE:
+		{
+			dprintk("%s: FE_SET_VOLTAGE\n", __FUNCTION__);
+
+			switch ((fe_sec_voltage_t) arg) {
+			case SEC_VOLTAGE_13:
+
+				dprintk("%s: SEC_VOLTAGE_13, %x\n", __FUNCTION__, SEC_VOLTAGE_13);
+
+				set_tuner_polarity(adapter, 1);
+
+				return 0;
+
+			case SEC_VOLTAGE_18:
+
+				dprintk("%s: SEC_VOLTAGE_18, %x\n", __FUNCTION__, SEC_VOLTAGE_18);
+
+				set_tuner_polarity(adapter, 2);
+
+				return 0;
 
 			default:
 
 				return -EINVAL;
 			};
-
-			break;
 		}
 
+
 	default:
 
 		return -EOPNOTSUPP;
@@ -2382,7 +2240,7 @@
 	if (pdev == NULL)
 		return -ENODEV;
 
-	if (DriverInitialize(pdev) != 0)
+	if (driver_initialize(pdev) != 0)
 		return -ENODEV;
 
 	dvb_register_adapter(&dvb_adapter, skystar2_pci_driver.name);
@@ -2390,7 +2248,7 @@
 	if (dvb_adapter == NULL) {
 		printk("%s: Error registering DVB adapter\n", __FUNCTION__);
 
-		DriverHalt(pdev);
+		driver_halt(pdev);
 
 		return -ENODEV;
 	}
@@ -2411,8 +2269,8 @@
 	dvbdemux = &adapter->demux;
 
 	dvbdemux->priv = (void *) adapter;
-	dvbdemux->filternum = 32;
-	dvbdemux->feednum = 32;
+	dvbdemux->filternum = N_PID_SLOTS;
+	dvbdemux->feednum = N_PID_SLOTS;
 	dvbdemux->start_feed = dvb_start_feed;
 	dvbdemux->stop_feed = dvb_stop_feed;
 	dvbdemux->write_to_decoder = 0;
@@ -2422,7 +2280,7 @@
 
 	adapter->hw_frontend.source = DMX_FRONTEND_0;
 
-	adapter->dmxdev.filternum = 32;
+	adapter->dmxdev.filternum = N_PID_SLOTS;
 	adapter->dmxdev.demux = &dvbdemux->dmx;
 	adapter->dmxdev.capabilities = 0;
 
@@ -2475,13 +2333,13 @@
 
 			dvb_unregister_adapter(adapter->dvb_adapter);
 		}
-
-		DriverHalt(pdev);
+		driver_halt(pdev);
 	}
 }
 
 static struct pci_device_id skystar2_pci_tbl[] = {
-	{0x000013D0, 0x00002103, 0xFFFFFFFF, 0xFFFFFFFF, 0x00000000, 0x00000000, 0x00000000},
+	{0x000013d0, 0x00002103, 0xffffffff, 0xffffffff, 0x00000000, 0x00000000, 0x00000000},
+	{0x000013d0, 0x00002200, 0xffffffff, 0xffffffff, 0x00000000, 0x00000000, 0x00000000},	//FCIII
 	{0,},
 };
 
@@ -2505,5 +2363,10 @@
 module_init(skystar2_init);
 module_exit(skystar2_cleanup);
 
+MODULE_PARM(debug, "i");
+MODULE_PARM_DESC(debug, "enable verbose debug messages: supported values: 1 and 2");
+MODULE_PARM(enable_hw_filters, "i");
+MODULE_PARM_DESC(enable_hw_filters, "enable hardware filters: supported values: 0 (none), 1, 2");
+
 MODULE_DESCRIPTION("Technisat SkyStar2 DVB PCI Driver");
 MODULE_LICENSE("GPL");

