Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271048AbTGPLVC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 07:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271050AbTGPLVC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 07:21:02 -0400
Received: from mail.convergence.de ([212.84.236.4]:57811 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271048AbTGPLUL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 07:20:11 -0400
Subject: [PATCH 1/1] Update Technisat Skystar2 DVB driver
In-Reply-To: 
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Wed, 16 Jul 2003 13:34:59 +0200
Message-Id: <10583552993494@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this is a follow-up patch to my latest patch series.
It fixes the problems and flaws Greg KH has pointed out.

The problem was, that there was a typo in the Makefile, so the
driver was never compiled. But I assumed that it build without
errors. Doh!

Simply apply on top of the other patches.

CU
Michael.

[DVB] - update the Technisat Skystar2 driver:
         - follow kernel coding rules, change comments
         - change function return values from u32 to int where possible
         - make all functions static
         - comment out unused functions
         - fix return values of functions to follow kernel rules
         - removed bogus delay, read and write functions
diff -uNrwB --new-file linux-2.6.0-test1.patch/drivers/media/dvb/b2c2/Makefile linux-2.6.0-test1.work/drivers/media/dvb/b2c2/Makefile
--- linux-2.6.0-test1.patch/drivers/media/dvb/b2c2/Makefile	2003-07-16 11:24:14.000000000 +0200
+++ linux-2.6.0-test1.work/drivers/media/dvb/b2c2/Makefile	2003-07-16 11:26:19.000000000 +0200
@@ -1,3 +1,3 @@
-obj-$(DVB_B2C2_SKYSTAR) += skystar.o
+obj-$(CONFIG_DVB_B2C2_SKYSTAR) += skystar2.o
 
 EXTRA_CFLAGS = -Idrivers/media/dvb/dvb-core/
diff -uNrwB --new-file linux-2.6.0-test1.patch/drivers/media/dvb/b2c2/skystar2.c linux-2.6.0-test1.work/drivers/media/dvb/b2c2/skystar2.c
--- linux-2.6.0-test1.patch/drivers/media/dvb/b2c2/skystar2.c	2003-07-16 11:24:14.000000000 +0200
+++ linux-2.6.0-test1.work/drivers/media/dvb/b2c2/skystar2.c	2003-07-16 11:26:16.000000000 +0200
@@ -35,13 +35,13 @@
 #include "demux.h"
 #include "dvb_net.h"
 
-int debug = 0;
-#define dprintk	if(debug != 0) printk
+static int debug = 0;
+#define dprintk(x...) do { if (debug) printk(x); } while (0)
 
 #define SizeOfBufDMA1	0x3AC00
 #define SizeOfBufDMA2	0x758
 
-struct DmaQ {
+struct dmaq {
 
 	u32 bus_addr;
 	u32 head;
@@ -50,7 +50,7 @@
 	u8 *buffer;
 };
 
-struct packet_header_t {
+struct packet_header {
 
 	u32 sync_byte;
 	u32 transport_error_indicator;
@@ -67,7 +67,7 @@
 	struct pci_dev *pdev;
 
 	u8 card_revision;
-	u32 B2C2_revision;
+	u32 b2c2_revision;
 	u32 PidFilterMax;
 	u32 MacFilterMax;
 	u32 irq;
@@ -86,8 +86,8 @@
 
 	struct semaphore i2c_sem;
 
-	struct DmaQ DmaQ1;
-	struct DmaQ DmaQ2;
+	struct dmaq dmaq1;
+	struct dmaq dmaq2;
 
 	u32 dma_ctrl;
 	u32 dma_status;
@@ -100,38 +100,10 @@
 	u32 mac_filter;
 };
 
+#define WriteRegDW(adapter,reg,value) writel(value, adapter->io_mem + reg)
+#define ReadRegDW(adapter,reg) readl(adapter->io_mem + reg)
 
-void linuxdelayms(u32 usecs)
-{
-	while (usecs > 0) {
-		udelay(1000);
-
-		usecs--;
-	}
-}
-
-/////////////////////////////////////////////////////////////////////
-//              register functions
-/////////////////////////////////////////////////////////////////////
-
-void WriteRegDW(struct adapter *adapter, u32 reg, u32 value)
-{
-	u32 flags;
-
-	save_flags(flags);
-	cli();
-
-	writel(value, adapter->io_mem + reg);
-
-	restore_flags(flags);
-}
-
-u32 ReadRegDW(struct adapter *adapter, u32 reg)
-{
-	return readl(adapter->io_mem + reg);
-}
-
-u32 WriteRegOp(struct adapter * adapter, u32 reg, u32 operation, u32 andvalue, u32 orvalue)
+static void WriteRegOp(struct adapter *adapter, u32 reg, u32 operation, u32 andvalue, u32 orvalue)
 {
 	u32 tmp;
 
@@ -145,15 +117,10 @@
 		tmp = (tmp & andvalue) | orvalue;
 
 	WriteRegDW(adapter, reg, tmp);
-
-	return tmp;
 }
 
-/////////////////////////////////////////////////////////////////////
-//                      I2C
-////////////////////////////////////////////////////////////////////
-
-u32 i2cMainWriteForFlex2(struct adapter * adapter, u32 command, u8 * buf, u32 retries)
+/* i2c functions */
+static int i2cMainWriteForFlex2(struct adapter * adapter, u32 command, u8 * buf, u32 retries)
 {
 	u32 i;
 	u32 value;
@@ -182,33 +148,25 @@
 	return 0;
 }
 
-/////////////////////////////////////////////////////////////////////
-//      device = 0x10000000 for tuner
-//               0x20000000 for eeprom
-/////////////////////////////////////////////////////////////////////
-
-u32 i2cMainSetup(u32 device, u32 chip_addr, u8 op, u8 addr, u32 value, u32 len)
+/* device = 0x10000000 for tuner, 0x20000000 for eeprom */
+static void i2cMainSetup(u32 device, u32 chip_addr, u8 op, u8 addr, u32 value, u32 len, u32 *command)
 {
-	u32 command;
-
-	command = device | ((len - 1) << 26) | (value << 16) | (addr << 8) | chip_addr;
+	*command = device | ((len - 1) << 26) | (value << 16) | (addr << 8) | chip_addr;
 
 	if (op != 0)
-		command = command | 0x03000000;
+		*command = *command | 0x03000000;
 	else
-		command = command | 0x01000000;
-
-	return command;
+		*command = *command | 0x01000000;
 }
 
-u32 FlexI2cRead4(struct adapter * adapter, u32 device, u32 chip_addr, u16 addr, u8 * buf, u8 len)
+static int FlexI2cRead4(struct adapter * adapter, u32 device, u32 chip_addr, u16 addr, u8 * buf, u8 len)
 {
 	u32 command;
 	u32 value;
 
 	int result, i;
 
-	command = i2cMainSetup(device, chip_addr, 1, addr, 0, len);
+	i2cMainSetup(device, chip_addr, 1, addr, 0, len, &command);
 
 	result = i2cMainWriteForFlex2(adapter, command, buf, 100000);
 
@@ -226,7 +184,7 @@
 	return result;
 }
 
-u32 FlexI2cWrite4(struct adapter * adapter, u32 device, u32 chip_addr, u32 addr, u8 * buf, u8 len)
+static int FlexI2cWrite4(struct adapter * adapter, u32 device, u32 chip_addr, u32 addr, u8 * buf, u8 len)
 {
 	u32 command;
 	u32 value;
@@ -243,22 +201,22 @@
 		WriteRegDW(adapter, 0x104, value);
 	}
 
-	command = i2cMainSetup(device, chip_addr, 0, addr, buf[0], len);
+	i2cMainSetup(device, chip_addr, 0, addr, buf[0], len, &command);
 
 	return i2cMainWriteForFlex2(adapter, command, 0, 100000);
 }
 
-u32 fixChipAddr(u32 device, u32 bus, u32 addr)
+static void fixchipaddr(u32 device, u32 bus, u32 addr, u32 *ret)
 {
 	if (device == 0x20000000)
-		return bus | ((addr >> 8) & 3);
+		*ret = bus | ((addr >> 8) & 3);
 
-	return bus;
+	*ret = bus;
 }
 
-u32 FLEXI2C_read(struct adapter * adapter, u32 device, u32 bus, u32 addr, u8 * buf, u32 len)
+static u32 FLEXI2C_read(struct adapter * adapter, u32 device, u32 bus, u32 addr, u8 * buf, u32 len)
 {
-	u32 ChipAddr;
+	u32 chipaddr;
 	u32 bytes_to_transfer;
 	u8 *start;
 
@@ -272,9 +230,9 @@
 		if (bytes_to_transfer > 4)
 			bytes_to_transfer = 4;
 
-		ChipAddr = fixChipAddr(device, bus, addr);
+		fixchipaddr(device, bus, addr, &chipaddr);
 
-		if (FlexI2cRead4(adapter, device, ChipAddr, addr, buf, bytes_to_transfer) == 0)
+		if (FlexI2cRead4(adapter, device, chipaddr, addr, buf, bytes_to_transfer) == 0)
 			return buf - start;
 
 		buf = buf + bytes_to_transfer;
@@ -285,9 +243,9 @@
 	return buf - start;
 }
 
-u32 FLEXI2C_write(struct adapter * adapter, u32 device, u32 bus, u32 addr, u8 * buf, u32 len)
+static u32 FLEXI2C_write(struct adapter * adapter, u32 device, u32 bus, u32 addr, u8 * buf, u32 len)
 {
-	u32 ChipAddr;
+	u32 chipaddr;
 	u32 bytes_to_transfer;
 	u8 *start;
 
@@ -301,9 +259,9 @@
 		if (bytes_to_transfer > 4)
 			bytes_to_transfer = 4;
 
-		ChipAddr = fixChipAddr(device, bus, addr);
+		fixchipaddr(device, bus, addr, &chipaddr);
 
-		if (FlexI2cWrite4(adapter, device, ChipAddr, addr, buf, bytes_to_transfer) == 0)
+		if (FlexI2cWrite4(adapter, device, chipaddr, addr, buf, bytes_to_transfer) == 0)
 			return buf - start;
 
 		buf = buf + bytes_to_transfer;
@@ -329,7 +287,8 @@
 			printk("message %d: flags=%x, addr=0x%04x, buf=%x, len=%d \n", i, msgs[i].flags, msgs[i].addr, (u32) msgs[i].buf, msgs[i].len);
 		}
 	}
-	// allow only the vp310 frontend to access the bus
+	
+	/* allow only the vp310 frontend to access the bus */
 	if ((msgs[0].addr != 0x0E) && (msgs[0].addr != 0x61)) {
 		up(&tmp->i2c_sem);
 
@@ -370,18 +329,15 @@
 
 	up(&tmp->i2c_sem);
 
-	// master xfer functions always return the number of successfully
-	// transmitted messages, not the number of transmitted bytes.
-	// return -EREMOTEIO in case of failure.
+	/* master xfer functions always return the number of successfully
+	   transmitted messages, not the number of transmitted bytes.
+	   return -EREMOTEIO in case of failure. */
 	return ret;
 }
 
-/////////////////////////////////////////////////////////////////////
-// SRAM (Skystar2 rev2.3 has one "ISSI IS61LV256" chip on board,
-// but it seems that FlexCopII can work with more than one chip)
-/////////////////////////////////////////////////////////////////////
-
-u32 SRAMSetNetDest(struct adapter * adapter, u8 dest)
+/* SRAM (Skystar2 rev2.3 has one "ISSI IS61LV256" chip on board,
+   but it seems that FlexCopII can work with more than one chip) */
+static void SRAMSetNetDest(struct adapter * adapter, u8 dest)
 {
 	u32 tmp;
 
@@ -396,10 +352,11 @@
 
 	udelay(1000);
 
-	return tmp;
+	/* return value is never used? */
+/*	return tmp; */
 }
 
-u32 SRAMSetCaiDest(struct adapter * adapter, u8 dest)
+static void SRAMSetCaiDest(struct adapter * adapter, u8 dest)
 {
 	u32 tmp;
 
@@ -415,10 +372,11 @@
 
 	udelay(1000);
 
-	return tmp;
+	/* return value is never used? */
+/*	return tmp; */
 }
 
-u32 SRAMSetCaoDest(struct adapter * adapter, u8 dest)
+static void SRAMSetCaoDest(struct adapter * adapter, u8 dest)
 {
 	u32 tmp;
 
@@ -434,10 +392,11 @@
 
 	udelay(1000);
 
-	return tmp;
+	/* return value is never used? */
+/*	return tmp; */
 }
 
-u32 SRAMSetMediaDest(struct adapter * adapter, u8 dest)
+static void SRAMSetMediaDest(struct adapter * adapter, u8 dest)
 {
 	u32 tmp;
 
@@ -453,21 +412,20 @@
 
 	udelay(1000);
 
-	return tmp;
+	/* return value is never used? */
+/*	return tmp; */
 }
 
-/////////////////////////////////////////////////////////////////////
-// SRAM memory is accessed through a buffer register in the FlexCop
-// chip (0x700). This register has the following structure:
-//  bits 0-14  : address
-//  bit  15    : read/write flag
-//  bits 16-23 : 8-bit word to write
-//  bits 24-27 : = 4
-//  bits 28-29 : memory bank selector
-//  bit  31    : busy flag
-////////////////////////////////////////////////////////////////////
-
-void FlexSramWrite(struct adapter *adapter, u32 bank, u32 addr, u8 * buf, u32 len)
+/* SRAM memory is accessed through a buffer register in the FlexCop
+   chip (0x700). This register has the following structure:
+    bits 0-14  : address
+    bit  15    : read/write flag
+    bits 16-23 : 8-bit word to write
+    bits 24-27 : = 4
+    bits 28-29 : memory bank selector
+    bit  31    : busy flag
+*/
+static void FlexSramWrite(struct adapter *adapter, u32 bank, u32 addr, u8 * buf, u32 len)
 {
 	u32 i, command, retries;
 
@@ -477,7 +435,7 @@
 		retries = 2;
 
 		while (((ReadRegDW(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
-			linuxdelayms(1);
+			mdelay(1);
 			retries--;
 		};
 
@@ -491,7 +449,7 @@
 	}
 }
 
-void FlexSramRead(struct adapter *adapter, u32 bank, u32 addr, u8 * buf, u32 len)
+static void FlexSramRead(struct adapter *adapter, u32 bank, u32 addr, u8 * buf, u32 len)
 {
 	u32 i, command, value, retries;
 
@@ -501,7 +459,7 @@
 		retries = 10000;
 
 		while (((ReadRegDW(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
-			linuxdelayms(1);
+			mdelay(1);
 			retries--;
 		};
 
@@ -513,7 +471,7 @@
 		retries = 10000;
 
 		while (((ReadRegDW(adapter, 0x700) & 0x80000000) != 0) && (retries > 0)) {
-			linuxdelayms(1);
+			mdelay(1);
 			retries--;
 		};
 
@@ -529,7 +487,7 @@
 	}
 }
 
-void SRAM_writeChunk(struct adapter *adapter, u32 addr, u8 * buf, u16 len)
+static void SRAM_writeChunk(struct adapter *adapter, u32 addr, u8 * buf, u16 len)
 {
 	u32 bank;
 
@@ -549,7 +507,7 @@
 	FlexSramWrite(adapter, bank, addr & 0x7FFF, buf, len);
 }
 
-void SRAM_readChunk(struct adapter *adapter, u32 addr, u8 * buf, u16 len)
+static void SRAM_readChunk(struct adapter *adapter, u32 addr, u8 * buf, u16 len)
 {
 	u32 bank;
 
@@ -569,7 +527,7 @@
 	FlexSramRead(adapter, bank, addr & 0x7FFF, buf, len);
 }
 
-void SRAM_read(struct adapter *adapter, u32 addr, u8 * buf, u32 len)
+static void SRAM_read(struct adapter *adapter, u32 addr, u8 * buf, u32 len)
 {
 	u32 length;
 
@@ -591,7 +549,7 @@
 	}
 }
 
-void SRAM_write(struct adapter *adapter, u32 addr, u8 * buf, u32 len)
+static void SRAM_write(struct adapter *adapter, u32 addr, u8 * buf, u32 len)
 {
 	u32 length;
 
@@ -613,12 +571,12 @@
 	}
 }
 
-void SRAM_setSize(struct adapter *adapter, u32 mask)
+static void SRAM_setSize(struct adapter *adapter, u32 mask)
 {
 	WriteRegDW(adapter, 0x71C, (mask | (~0x30000 & ReadRegDW(adapter, 0x71C))));
 }
 
-u32 SRAM_init(struct adapter *adapter)
+static void SRAM_init(struct adapter *adapter)
 {
 	u32 tmp;
 
@@ -640,10 +598,11 @@
 		dprintk("%s: dwSramType = %x\n", __FUNCTION__, adapter->dwSramType);
 	}
 
-	return adapter->dwSramType;
+	/* return value is never used? */
+/*	return adapter->dwSramType; */
 }
 
-int SRAM_testLocation(struct adapter *adapter, u32 mask, u32 addr)
+static int SRAM_testLocation(struct adapter *adapter, u32 mask, u32 addr)
 {
 	u8 tmp1, tmp2;
 
@@ -660,7 +619,7 @@
 
 	tmp2 = 0;
 
-	linuxdelayms(20);
+	mdelay(20);
 
 	SRAM_read(adapter, addr, &tmp2, 1);
 	SRAM_read(adapter, addr, &tmp2, 1);
@@ -678,7 +637,7 @@
 
 	tmp2 = 0;
 
-	linuxdelayms(20);
+	mdelay(20);
 
 	SRAM_read(adapter, addr, &tmp2, 1);
 	SRAM_read(adapter, addr, &tmp2, 1);
@@ -691,7 +650,7 @@
 	return 1;
 }
 
-u32 SRAM_length(struct adapter * adapter)
+static u32 SRAM_length(struct adapter * adapter)
 {
 	if (adapter->dwSramType == 0x10000)
 		return 32768;	//  32K
@@ -703,22 +662,20 @@
 	return 32768;		// 32K
 }
 
-//////////////////////////////////////////////////////////////////////
-// FlexcopII can work with 32K, 64K or 128K of external SRAM memory.
-//  - for 128K there are 4x32K chips at bank 0,1,2,3.
-//  - for  64K there are 2x32K chips at bank 1,2.
-//  - for  32K there is one 32K chip at bank 0.
-//
-// FlexCop works only with one bank at a time. The bank is selected
-// by bits 28-29 of the 0x700 register.
-//
-// bank 0 covers addresses 0x00000-0x07FFF
-// bank 1 covers addresses 0x08000-0x0FFFF
-// bank 2 covers addresses 0x10000-0x17FFF
-// bank 3 covers addresses 0x18000-0x1FFFF
-/////////////////////////////////////////////////////////////////////
-
-int SramDetectForFlex2(struct adapter *adapter)
+/* FlexcopII can work with 32K, 64K or 128K of external SRAM memory.
+    - for 128K there are 4x32K chips at bank 0,1,2,3.
+    - for  64K there are 2x32K chips at bank 1,2.
+    - for  32K there is one 32K chip at bank 0.
+
+   FlexCop works only with one bank at a time. The bank is selected
+   by bits 28-29 of the 0x700 register.
+  
+   bank 0 covers addresses 0x00000-0x07FFF
+   bank 1 covers addresses 0x08000-0x0FFFF
+   bank 2 covers addresses 0x10000-0x17FFF
+   bank 3 covers addresses 0x18000-0x1FFFF
+*/
+static int SramDetectForFlex2(struct adapter *adapter)
 {
 	u32 tmp, tmp2, tmp3;
 
@@ -790,21 +747,19 @@
 	return 0;
 }
 
-void SLL_detectSramSize(struct adapter *adapter)
+static void SLL_detectSramSize(struct adapter *adapter)
 {
 	SramDetectForFlex2(adapter);
 }
-
-/////////////////////////////////////////////////////////////////////
-//      EEPROM (Skystar2 has one "24LC08B" chip on board)
-////////////////////////////////////////////////////////////////////
-
-int EEPROM_write(struct adapter *adapter, u16 addr, u8 * buf, u16 len)
+/* EEPROM (Skystar2 has one "24LC08B" chip on board) */
+/*
+static int EEPROM_write(struct adapter *adapter, u16 addr, u8 * buf, u16 len)
 {
 	return FLEXI2C_write(adapter, 0x20000000, 0x50, addr, buf, len);
 }
+*/
 
-int EEPROM_read(struct adapter *adapter, u16 addr, u8 * buf, u16 len)
+static int EEPROM_read(struct adapter *adapter, u16 addr, u8 * buf, u16 len)
 {
 	return FLEXI2C_read(adapter, 0x20000000, 0x50, addr, buf, len);
 }
@@ -822,7 +777,7 @@
 	return sum;
 }
 
-int EEPROM_LRC_read(struct adapter *adapter, u32 addr, u32 len, u8 * buf, u32 retries)
+static int EEPROM_LRC_read(struct adapter *adapter, u32 addr, u32 len, u8 * buf, u32 retries)
 {
 	int i;
 
@@ -836,7 +791,8 @@
 	return 0;
 }
 
-int EEPROM_LRC_write(struct adapter *adapter, u32 addr, u32 len, u8 * wbuf, u8 * rbuf, u32 retries)
+/*
+static int EEPROM_LRC_write(struct adapter *adapter, u32 addr, u32 len, u8 * wbuf, u8 * rbuf, u32 retries)
 {
 	int i;
 
@@ -849,35 +805,35 @@
 
 	return 0;
 }
+*/
+
+/* These functions could be called from the initialization routine 
+   to unlock SkyStar2 cards, locked by "Europe On Line".
+        
+   in cards from "Europe On Line" the key is:
 
-/////////////////////////////////////////////////////////////////////
-// These functions could be called from the initialization routine 
-// to unlock SkyStar2 cards, locked by "Europe On Line".
-//      
-// in cards from "Europe On Line" the key is:
-//
-//      u8 key[20] = {
-//           0xB2, 0x01, 0x00, 0x00,
-//           0x00, 0x00, 0x00, 0x00,
-//           0x00, 0x00, 0x00, 0x00,
-//           0x00, 0x00, 0x00, 0x00,
-//      };
-//
-//      LRC = 0xB3;
-//
-// in unlocked cards the key is:
-//
-//      u8 key[20] = {
-//           0xB2, 0x00, 0x00, 0x00,
-//           0x00, 0x00, 0x00, 0x00,
-//           0x00, 0x00, 0x00, 0x00,
-//           0x00, 0x00, 0x00, 0x00,
-//      };
-//
-//     LRC = 0xB2;
-/////////////////////////////////////////////////////////////////////
+       u8 key[20] = {
+ 	    0xB2, 0x01, 0x00, 0x00,
+ 	    0x00, 0x00, 0x00, 0x00,
+ 	    0x00, 0x00, 0x00, 0x00,
+ 	    0x00, 0x00, 0x00, 0x00,
+       };
+
+       LRC = 0xB3;
 
-int EEPROM_writeKey(struct adapter *adapter, u8 * key, u32 len)
+  in unlocked cards the key is:
+
+       u8 key[20] = {
+ 	    0xB2, 0x00, 0x00, 0x00,
+ 	    0x00, 0x00, 0x00, 0x00,
+ 	    0x00, 0x00, 0x00, 0x00,
+ 	    0x00, 0x00, 0x00, 0x00,
+       };
+
+      LRC = 0xB2;
+*/
+/*
+static int EEPROM_writeKey(struct adapter *adapter, u8 * key, u32 len)
 {
 	u8 rbuf[20];
 	u8 wbuf[20];
@@ -894,8 +850,8 @@
 
 	return EEPROM_LRC_write(adapter, 0x3E4, 20, wbuf, rbuf, 4);
 }
-
-int EEPROM_readKey(struct adapter *adapter, u8 * key, u32 len)
+*/
+static int EEPROM_readKey(struct adapter *adapter, u8 * key, u32 len)
 {
 	u8 buf[20];
 
@@ -910,7 +866,7 @@
 	return 1;
 }
 
-int EEPROM_getMacAddr(struct adapter *adapter, char type, u8 * mac)
+static int EEPROM_getMacAddr(struct adapter *adapter, char type, u8 * mac)
 {
 	u8 tmp[8];
 
@@ -951,7 +907,8 @@
 	}
 }
 
-char EEPROM_setMacAddr(struct adapter *adapter, char type, u8 * mac)
+/*
+static char EEPROM_setMacAddr(struct adapter *adapter, char type, u8 * mac)
 {
 	u8 tmp[8];
 
@@ -981,12 +938,10 @@
 
 	return 0;
 }
+*/
 
-/////////////////////////////////////////////////////////////////////
-//                      PID filter
-/////////////////////////////////////////////////////////////////////
-
-void FilterEnableStream1Filter(struct adapter *adapter, u32 op)
+/* PID filter */
+static void FilterEnableStream1Filter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
@@ -999,7 +954,7 @@
 	}
 }
 
-void FilterEnableStream2Filter(struct adapter *adapter, u32 op)
+static void FilterEnableStream2Filter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
@@ -1012,7 +967,7 @@
 	}
 }
 
-void FilterEnablePcrFilter(struct adapter *adapter, u32 op)
+static void FilterEnablePcrFilter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
@@ -1025,7 +980,7 @@
 	}
 }
 
-void FilterEnablePmtFilter(struct adapter *adapter, u32 op)
+static void FilterEnablePmtFilter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
@@ -1038,7 +993,7 @@
 	}
 }
 
-void FilterEnableEmmFilter(struct adapter *adapter, u32 op)
+static void FilterEnableEmmFilter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
@@ -1051,7 +1006,7 @@
 	}
 }
 
-void FilterEnableEcmFilter(struct adapter *adapter, u32 op)
+static void FilterEnableEcmFilter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
@@ -1064,7 +1019,8 @@
 	}
 }
 
-void FilterEnableNullFilter(struct adapter *adapter, u32 op)
+/*
+static void FilterEnableNullFilter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
@@ -1076,8 +1032,9 @@
 		WriteRegOp(adapter, 0x208, 1, 0, 0x00000040);
 	}
 }
+*/
 
-void FilterEnableMaskFilter(struct adapter *adapter, u32 op)
+static void FilterEnableMaskFilter(struct adapter *adapter, u32 op)
 {
 	dprintk("%s: op=%x\n", __FUNCTION__, op);
 
@@ -1091,7 +1048,7 @@
 }
 
 
-void CtrlEnableMAC(struct adapter *adapter, u32 op)
+static void CtrlEnableMAC(struct adapter *adapter, u32 op)
 {
 	if (op == 0) {
 		WriteRegOp(adapter, 0x208, 2, ~0x00004000, 0);
@@ -1102,7 +1059,7 @@
 	}
 }
 
-int CASetMacDstAddrFilter(struct adapter *adapter, u8 * mac)
+static int CASetMacDstAddrFilter(struct adapter *adapter, u8 * mac)
 {
 	u32 tmp1, tmp2;
 
@@ -1115,7 +1072,8 @@
 	return 0;
 }
 
-void SetIgnoreMACFilter(struct adapter *adapter, u8 op)
+/*
+static void SetIgnoreMACFilter(struct adapter *adapter, u8 op)
 {
 	if (op != 0) {
 		WriteRegOp(adapter, 0x208, 2, ~0x00004000, 0);
@@ -1131,14 +1089,17 @@
 		}
 	}
 }
+*/
 
-void CheckNullFilterEnable(struct adapter *adapter)
+/*
+static void CheckNullFilterEnable(struct adapter *adapter)
 {
 	FilterEnableNullFilter(adapter, 1);
 	FilterEnableMaskFilter(adapter, 1);
 }
+*/
 
-void InitPIDsInfo(struct adapter *adapter)
+static void InitPIDsInfo(struct adapter *adapter)
 {
 	int i;
 
@@ -1146,7 +1107,7 @@
 		adapter->pids[i] = 0x1FFF;
 }
 
-u32 CheckPID(struct adapter *adapter, u16 pid)
+static int CheckPID(struct adapter *adapter, u16 pid)
 {
 	u32 i;
 
@@ -1161,7 +1122,7 @@
 	return 0;
 }
 
-u32 PidSetGroupPID(struct adapter * adapter, u32 pid)
+static void PidSetGroupPID(struct adapter * adapter, u32 pid)
 {
 	u32 value;
 
@@ -1171,10 +1132,11 @@
 
 	WriteRegDW(adapter, 0x30C, value);
 
-	return value;
+	/* return value is never used? */
+/*	return value; */
 }
 
-u32 PidSetGroupMASK(struct adapter * adapter, u32 pid)
+static void PidSetGroupMASK(struct adapter * adapter, u32 pid)
 {
 	u32 value;
 
@@ -1184,10 +1146,11 @@
 
 	WriteRegDW(adapter, 0x30C, value);
 
-	return value;
+	/* return value is never used? */
+/*	return value; */
 }
 
-u32 PidSetStream1PID(struct adapter * adapter, u32 pid)
+static void PidSetStream1PID(struct adapter * adapter, u32 pid)
 {
 	u32 value;
 
@@ -1197,10 +1160,11 @@
 
 	WriteRegDW(adapter, 0x300, value);
 
-	return value;
+	/* return value is never used? */
+/*	return value; */
 }
 
-u32 PidSetStream2PID(struct adapter * adapter, u32 pid)
+static void PidSetStream2PID(struct adapter * adapter, u32 pid)
 {
 	u32 value;
 
@@ -1210,10 +1174,11 @@
 
 	WriteRegDW(adapter, 0x300, value);
 
-	return value;
+	/* return value is never used? */
+/*	return value; */
 }
 
-u32 PidSetPcrPID(struct adapter * adapter, u32 pid)
+static void PidSetPcrPID(struct adapter * adapter, u32 pid)
 {
 	u32 value;
 
@@ -1223,10 +1188,11 @@
 
 	WriteRegDW(adapter, 0x304, value);
 
-	return value;
+	/* return value is never used? */
+/*	return value; */
 }
 
-u32 PidSetPmtPID(struct adapter * adapter, u32 pid)
+static void PidSetPmtPID(struct adapter * adapter, u32 pid)
 {
 	u32 value;
 
@@ -1236,10 +1202,11 @@
 
 	WriteRegDW(adapter, 0x304, value);
 
-	return value;
+	/* return value is never used? */
+/*	return value; */
 }
 
-u32 PidSetEmmPID(struct adapter * adapter, u32 pid)
+static void PidSetEmmPID(struct adapter * adapter, u32 pid)
 {
 	u32 value;
 
@@ -1249,10 +1216,11 @@
 
 	WriteRegDW(adapter, 0x308, value);
 
-	return value;
+	/* return value is never used? */
+/*	return value; */
 }
 
-u32 PidSetEcmPID(struct adapter * adapter, u32 pid)
+static void PidSetEcmPID(struct adapter * adapter, u32 pid)
 {
 	u32 value;
 
@@ -1262,50 +1230,52 @@
 
 	WriteRegDW(adapter, 0x308, value);
 
-	return value;
+	/* return value is never used? */
+/*	return value; */
 }
 
-u32 PidGetStream1PID(struct adapter * adapter)
+static int PidGetStream1PID(struct adapter * adapter)
 {
-	return ReadRegDW(adapter, 0x300) & 0x0000FFFF;
+	return ReadRegDW(adapter, 0x300) & 0x00001FFF;
 }
 
-u32 PidGetStream2PID(struct adapter * adapter)
+static int PidGetStream2PID(struct adapter * adapter)
 {
-	return ReadRegDW(adapter, 0x300) >> 0x10;
+	return (ReadRegDW(adapter, 0x300) >> 0x10)& 0x00001FFF;
 }
 
-u32 PidGetPcrPID(struct adapter * adapter)
+static int PidGetPcrPID(struct adapter * adapter)
 {
-	return ReadRegDW(adapter, 0x304) & 0x0000FFFF;
+	return ReadRegDW(adapter, 0x304) & 0x00001FFF;
 }
 
-u32 PidGetPmtPID(struct adapter * adapter)
+static int PidGetPmtPID(struct adapter * adapter)
 {
-	return ReadRegDW(adapter, 0x304) >> 0x10;
+	return (ReadRegDW(adapter, 0x304) >> 0x10)& 0x00001FFF;
 }
 
-u32 PidGetEmmPID(struct adapter * adapter)
+static int PidGetEmmPID(struct adapter * adapter)
 {
-	return ReadRegDW(adapter, 0x308) & 0x0000FFFF;
+	return ReadRegDW(adapter, 0x308) & 0x00001FFF;
 }
 
-u32 PidGetEcmPID(struct adapter * adapter)
+static int PidGetEcmPID(struct adapter * adapter)
 {
-	return ReadRegDW(adapter, 0x308) >> 0x10;
+	return (ReadRegDW(adapter, 0x308) >> 0x10)& 0x00001FFF;
 }
 
-u32 PidGetGroupPID(struct adapter * adapter)
+static int PidGetGroupPID(struct adapter * adapter)
 {
-	return ReadRegDW(adapter, 0x30C) & 0x0000FFFF;
+	return ReadRegDW(adapter, 0x30C) & 0x00001FFF;
 }
 
-u32 PidGetGroupMASK(struct adapter * adapter)
+static int PidGetGroupMASK(struct adapter * adapter)
 {
-	return ReadRegDW(adapter, 0x30C) >> 0x10;
+	return (ReadRegDW(adapter, 0x30C) >> 0x10)& 0x00001FFF;
 }
 
-void ResetHardwarePIDFilter(struct adapter *adapter)
+/*
+static void ResetHardwarePIDFilter(struct adapter *adapter)
 {
 	PidSetStream1PID(adapter, 0x1FFF);
 
@@ -1324,8 +1294,9 @@
 	PidSetEmmPID(adapter, 0x1FFF);
 	FilterEnableEmmFilter(adapter, 0);
 }
+*/
 
-void OpenWholeBandwidth(struct adapter *adapter)
+static void OpenWholeBandwidth(struct adapter *adapter)
 {
 	PidSetGroupPID(adapter, 0);
 
@@ -1334,7 +1305,7 @@
 	FilterEnableMaskFilter(adapter, 1);
 }
 
-int AddHwPID(struct adapter *adapter, u32 pid)
+static int AddHwPID(struct adapter *adapter, u32 pid)
 {
 	dprintk("%s: pid=%d\n", __FUNCTION__, pid);
 
@@ -1344,7 +1315,7 @@
 	if ((PidGetGroupMASK(adapter) == 0) && (PidGetGroupPID(adapter) == 0))
 		return 0;
 
-	if ((PidGetStream1PID(adapter) & 0x1FFF) == 0x1FFF) {
+	if (PidGetStream1PID(adapter) == 0x1FFF) {
 		PidSetStream1PID(adapter, pid & 0xFFFF);
 
 		FilterEnableStream1Filter(adapter, 1);
@@ -1352,7 +1323,7 @@
 		return 1;
 	}
 
-	if ((PidGetStream2PID(adapter) & 0x1FFF) == 0x1FFF) {
+	if (PidGetStream2PID(adapter) == 0x1FFF) {
 		PidSetStream2PID(adapter, (pid & 0xFFFF));
 
 		FilterEnableStream2Filter(adapter, 1);
@@ -1360,7 +1331,7 @@
 		return 1;
 	}
 
-	if ((PidGetPcrPID(adapter) & 0x1FFF) == 0x1FFF) {
+	if (PidGetPcrPID(adapter) == 0x1FFF) {
 		PidSetPcrPID(adapter, (pid & 0xFFFF));
 
 		FilterEnablePcrFilter(adapter, 1);
@@ -1395,20 +1366,20 @@
 	return -1;
 }
 
-int RemoveHwPID(struct adapter *adapter, u32 pid)
+static int RemoveHwPID(struct adapter *adapter, u32 pid)
 {
 	dprintk("%s: pid=%d\n", __FUNCTION__, pid);
 
 	if (pid <= 0x1F)
 		return 1;
 
-	if ((PidGetStream1PID(adapter) & 0x1FFF) == pid) {
+	if (PidGetStream1PID(adapter) == pid) {
 		PidSetStream1PID(adapter, 0x1FFF);
 
 		return 1;
 	}
 
-	if ((PidGetStream2PID(adapter) & 0x1FFF) == pid) {
+	if (PidGetStream2PID(adapter) == pid) {
 		PidSetStream2PID(adapter, 0x1FFF);
 
 		FilterEnableStream2Filter(adapter, 0);
@@ -1416,7 +1387,7 @@
 		return 1;
 	}
 
-	if ((PidGetPcrPID(adapter) & 0x1FFF) == pid) {
+	if (PidGetPcrPID(adapter) == pid) {
 		PidSetPcrPID(adapter, 0x1FFF);
 
 		FilterEnablePcrFilter(adapter, 0);
@@ -1424,7 +1395,7 @@
 		return 1;
 	}
 
-	if ((PidGetPmtPID(adapter) & 0x1FFF) == pid) {
+	if (PidGetPmtPID(adapter) == pid) {
 		PidSetPmtPID(adapter, 0x1FFF);
 
 		FilterEnablePmtFilter(adapter, 0);
@@ -1432,7 +1403,7 @@
 		return 1;
 	}
 
-	if ((PidGetEmmPID(adapter) & 0x1FFF) == pid) {
+	if (PidGetEmmPID(adapter) == pid) {
 		PidSetEmmPID(adapter, 0x1FFF);
 
 		FilterEnableEmmFilter(adapter, 0);
@@ -1440,7 +1411,7 @@
 		return 1;
 	}
 
-	if ((PidGetEcmPID(adapter) & 0x1FFF) == pid) {
+	if (PidGetEcmPID(adapter) == pid) {
 		PidSetEcmPID(adapter, 0x1FFF);
 
 		FilterEnableEcmFilter(adapter, 0);
@@ -1451,7 +1422,7 @@
 	return -1;
 }
 
-int AddPID(struct adapter *adapter, u32 pid)
+static int AddPID(struct adapter *adapter, u32 pid)
 {
 	int i;
 
@@ -1478,7 +1449,7 @@
 	return -1;
 }
 
-int RemovePID(struct adapter *adapter, u32 pid)
+static int RemovePID(struct adapter *adapter, u32 pid)
 {
 	u32 i;
 
@@ -1500,11 +1471,8 @@
 	return -1;
 }
 
-/////////////////////////////////////////////////////////////////////
-//                      DMA & IRQ
-/////////////////////////////////////////////////////////////////////
-
-void CtrlEnableSmc(struct adapter *adapter, u32 op)
+/* dma & irq */
+static void CtrlEnableSmc(struct adapter *adapter, u32 op)
 {
 	if (op == 0) {
 		WriteRegOp(adapter, 0x208, 2, ~0x00000800, 0);
@@ -1515,7 +1483,7 @@
 	}
 }
 
-u32 DmaEnableDisableIrq(struct adapter *adapter, u32 flag1, u32 flag2, u32 flag3)
+static void DmaEnableDisableIrq(struct adapter *adapter, u32 flag1, u32 flag2, u32 flag3)
 {
 	adapter->dma_ctrl = adapter->dma_ctrl & 0x000F0000;
 
@@ -1542,11 +1510,9 @@
 		else
 			adapter->dma_ctrl = adapter->dma_ctrl | 0x00080000;
 	}
-
-	return adapter->dma_ctrl;
 }
 
-u32 IrqDmaEnableDisableIrq(struct adapter * adapter, u32 op)
+static void IrqDmaEnableDisableIrq(struct adapter * adapter, u32 op)
 {
 	u32 value;
 
@@ -1556,52 +1522,46 @@
 		value = value | (adapter->dma_ctrl & 0x000F0000);
 
 	WriteRegDW(adapter, 0x208, value);
-
-	return value;
 }
 
-///////////////////////////////////////////////////////////////////////
-//
-// FlexCopII has 2 dma channels. DMA1 is used to transfer TS data to
-// system memory.
-//
-// The DMA1 buffer is divided in 2 subbuffers of equal size.
-// FlexCopII will transfer TS data to one subbuffer, signal an interrupt
-// when the subbuffer is full and continue fillig the second subbuffer.
-//
-// For DMA1:
-//      subbuffer size in 32-bit words is stored in the first 24 bits of
-//      register 0x004. The last 8 bits of register 0x004 contain the number
-//      of subbuffers.
-//      
-//      the first 30 bits of register 0x000 contain the address of the first
-//      subbuffer. The last 2 bits contain 0, when dma1 is disabled and 1,
-//      when dma1 is enabled.
-//
-//      the first 30 bits of register 0x00C contain the address of the second
-//      subbuffer. the last 2 bits contain 1.
-//
-//      register 0x008 will contain the address of the subbuffer that was filled
-//      with TS data, when FlexCopII will generate an interrupt.
-//
-// For DMA2:
-//      subbuffer size in 32-bit words is stored in the first 24 bits of
-//      register 0x014. The last 8 bits of register 0x014 contain the number
-//      of subbuffers.
-//      
-//      the first 30 bits of register 0x010 contain the address of the first
-//      subbuffer.  The last 2 bits contain 0, when dma1 is disabled and 1,
-//      when dma1 is enabled.
-//
-//      the first 30 bits of register 0x01C contain the address of the second
-//      subbuffer. the last 2 bits contain 1.
-//
-//      register 0x018 contains the address of the subbuffer that was filled
-//      with TS data, when FlexCopII generates an interrupt.
-//
-///////////////////////////////////////////////////////////////////////
+/* FlexCopII has 2 dma channels. DMA1 is used to transfer TS data to
+   system memory.
 
-int DmaInitDMA(struct adapter *adapter, u32 dma_channel)
+   The DMA1 buffer is divided in 2 subbuffers of equal size.
+   FlexCopII will transfer TS data to one subbuffer, signal an interrupt
+   when the subbuffer is full and continue fillig the second subbuffer.
+
+   For DMA1:
+       subbuffer size in 32-bit words is stored in the first 24 bits of
+       register 0x004. The last 8 bits of register 0x004 contain the number
+       of subbuffers.
+       
+       the first 30 bits of register 0x000 contain the address of the first
+       subbuffer. The last 2 bits contain 0, when dma1 is disabled and 1,
+       when dma1 is enabled.
+
+       the first 30 bits of register 0x00C contain the address of the second
+       subbuffer. the last 2 bits contain 1.
+
+       register 0x008 will contain the address of the subbuffer that was filled
+       with TS data, when FlexCopII will generate an interrupt.
+
+   For DMA2:
+       subbuffer size in 32-bit words is stored in the first 24 bits of
+       register 0x014. The last 8 bits of register 0x014 contain the number
+       of subbuffers.
+       
+       the first 30 bits of register 0x010 contain the address of the first
+       subbuffer.  The last 2 bits contain 0, when dma1 is disabled and 1,
+       when dma1 is enabled.
+
+       the first 30 bits of register 0x01C contain the address of the second
+       subbuffer. the last 2 bits contain 1.
+
+       register 0x018 contains the address of the subbuffer that was filled
+       with TS data, when FlexCopII generates an interrupt.
+*/
+static int DmaInitDMA(struct adapter *adapter, u32 dma_channel)
 {
 	u32 subbuffers, subbufsize, subbuf0, subbuf1;
 
@@ -1610,11 +1570,11 @@
 
 		subbuffers = 2;
 
-		subbufsize = (((adapter->DmaQ1.buffer_size / 2) / 4) << 8) | subbuffers;
+		subbufsize = (((adapter->dmaq1.buffer_size / 2) / 4) << 8) | subbuffers;
 
-		subbuf0 = adapter->DmaQ1.bus_addr & 0xFFFFFFFC;
+		subbuf0 = adapter->dmaq1.bus_addr & 0xFFFFFFFC;
 
-		subbuf1 = ((adapter->DmaQ1.bus_addr + adapter->DmaQ1.buffer_size / 2) & 0xFFFFFFFC) | 1;
+		subbuf1 = ((adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) & 0xFFFFFFFC) | 1;
 
 		dprintk("%s: first subbuffer address = 0x%x\n", __FUNCTION__, subbuf0);
 		udelay(1000);
@@ -1628,8 +1588,8 @@
 		udelay(1000);
 		WriteRegDW(adapter, 0x00C, subbuf1);
 
-		dprintk("%s: counter = 0x%x\n", __FUNCTION__, adapter->DmaQ1.bus_addr & 0xFFFFFFFC);
-		WriteRegDW(adapter, 0x008, adapter->DmaQ1.bus_addr & 0xFFFFFFFC);
+		dprintk("%s: counter = 0x%x\n", __FUNCTION__, adapter->dmaq1.bus_addr & 0xFFFFFFFC);
+		WriteRegDW(adapter, 0x008, adapter->dmaq1.bus_addr & 0xFFFFFFFC);
 		udelay(1000);
 
 		if (subbuffers == 0)
@@ -1650,11 +1610,11 @@
 
 		subbuffers = 2;
 
-		subbufsize = (((adapter->DmaQ2.buffer_size / 2) / 4) << 8) | subbuffers;
+		subbufsize = (((adapter->dmaq2.buffer_size / 2) / 4) << 8) | subbuffers;
 
-		subbuf0 = adapter->DmaQ2.bus_addr & 0xFFFFFFFC;
+		subbuf0 = adapter->dmaq2.bus_addr & 0xFFFFFFFC;
 
-		subbuf1 = ((adapter->DmaQ2.bus_addr + adapter->DmaQ2.buffer_size / 2) & 0xFFFFFFFC) | 1;
+		subbuf1 = ((adapter->dmaq2.bus_addr + adapter->dmaq2.buffer_size / 2) & 0xFFFFFFFC) | 1;
 
 		dprintk("%s: first subbuffer address = 0x%x\n", __FUNCTION__, subbuf0);
 		udelay(1000);
@@ -1674,7 +1634,7 @@
 	return 0;
 }
 
-void CtrlEnableReceiveData(struct adapter *adapter, u32 op)
+static void CtrlEnableReceiveData(struct adapter *adapter, u32 op)
 {
 	if (op == 0) {
 		WriteRegOp(adapter, 0x208, 2, ~0x00008000, 0);
@@ -1689,11 +1649,10 @@
 	}
 }
 
-///////////////////////////////////////////////////////////////////////////////
-// bit 0 of dma_mask is set to 1 if dma1 channel has to be enabled/disabled
-// bit 1 of dma_mask is set to 1 if dma2 channel has to be enabled/disabled
-
-void DmaStartStop0x2102(struct adapter *adapter, u32 dma_mask, u32 start_stop)
+/* bit 0 of dma_mask is set to 1 if dma1 channel has to be enabled/disabled
+   bit 1 of dma_mask is set to 1 if dma2 channel has to be enabled/disabled
+*/
+static void DmaStartStop0x2102(struct adapter *adapter, u32 dma_mask, u32 start_stop)
 {
 	u32 dma_enable, dma1_enable, dma2_enable;
 
@@ -1705,20 +1664,20 @@
 		dma1_enable = 0;
 		dma2_enable = 0;
 
-		if (((dma_mask & 1) != 0) && ((adapter->dma_status & 1) == 0) && (adapter->DmaQ1.bus_addr != 0)) {
+		if (((dma_mask & 1) != 0) && ((adapter->dma_status & 1) == 0) && (adapter->dmaq1.bus_addr != 0)) {
 			adapter->dma_status = adapter->dma_status | 1;
 			dma1_enable = 1;
 		}
 
-		if (((dma_mask & 2) != 0) && ((adapter->dma_status & 2) == 0) && (adapter->DmaQ2.bus_addr != 0)) {
+		if (((dma_mask & 2) != 0) && ((adapter->dma_status & 2) == 0) && (adapter->dmaq2.bus_addr != 0)) {
 			adapter->dma_status = adapter->dma_status | 2;
 			dma2_enable = 1;
 		}
 		// enable dma1 and dma2
 		if ((dma1_enable == 1) && (dma2_enable == 1)) {
-			WriteRegDW(adapter, 0x000, adapter->DmaQ1.bus_addr | 1);
-			WriteRegDW(adapter, 0x00C, (adapter->DmaQ1.bus_addr + adapter->DmaQ1.buffer_size / 2) | 1);
-			WriteRegDW(adapter, 0x010, adapter->DmaQ2.bus_addr | 1);
+			WriteRegDW(adapter, 0x000, adapter->dmaq1.bus_addr | 1);
+			WriteRegDW(adapter, 0x00C, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
+			WriteRegDW(adapter, 0x010, adapter->dmaq2.bus_addr | 1);
 
 			CtrlEnableReceiveData(adapter, 1);
 
@@ -1726,8 +1685,8 @@
 		}
 		// enable dma1
 		if ((dma1_enable == 1) && (dma2_enable == 0)) {
-			WriteRegDW(adapter, 0x000, adapter->DmaQ1.bus_addr | 1);
-			WriteRegDW(adapter, 0x00C, (adapter->DmaQ1.bus_addr + adapter->DmaQ1.buffer_size / 2) | 1);
+			WriteRegDW(adapter, 0x000, adapter->dmaq1.bus_addr | 1);
+			WriteRegDW(adapter, 0x00C, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
 
 			CtrlEnableReceiveData(adapter, 1);
 
@@ -1735,7 +1694,7 @@
 		}
 		// enable dma2
 		if ((dma1_enable == 0) && (dma2_enable == 1)) {
-			WriteRegDW(adapter, 0x010, adapter->DmaQ2.bus_addr | 1);
+			WriteRegDW(adapter, 0x010, adapter->dmaq2.bus_addr | 1);
 
 			CtrlEnableReceiveData(adapter, 1);
 
@@ -1768,22 +1727,22 @@
 			udelay(3000);
 		}
 		//disable dma1
-		if (((dma_mask & 1) != 0) && ((adapter->dma_status & 1) != 0) && (adapter->DmaQ1.bus_addr != 0)) {
-			WriteRegDW(adapter, 0x000, adapter->DmaQ1.bus_addr);
-			WriteRegDW(adapter, 0x00C, (adapter->DmaQ1.bus_addr + adapter->DmaQ1.buffer_size / 2) | 1);
+		if (((dma_mask & 1) != 0) && ((adapter->dma_status & 1) != 0) && (adapter->dmaq1.bus_addr != 0)) {
+			WriteRegDW(adapter, 0x000, adapter->dmaq1.bus_addr);
+			WriteRegDW(adapter, 0x00C, (adapter->dmaq1.bus_addr + adapter->dmaq1.buffer_size / 2) | 1);
 
 			adapter->dma_status = adapter->dma_status & ~0x00000001;
 		}
 		//disable dma2
-		if (((dma_mask & 2) != 0) && ((adapter->dma_status & 2) != 0) && (adapter->DmaQ2.bus_addr != 0)) {
-			WriteRegDW(adapter, 0x010, adapter->DmaQ2.bus_addr);
+		if (((dma_mask & 2) != 0) && ((adapter->dma_status & 2) != 0) && (adapter->dmaq2.bus_addr != 0)) {
+			WriteRegDW(adapter, 0x010, adapter->dmaq2.bus_addr);
 
 			adapter->dma_status = adapter->dma_status & ~0x00000002;
 		}
 	}
 }
 
-void OpenStream(struct adapter *adapter, u32 pid)
+static void OpenStream(struct adapter *adapter, u32 pid)
 {
 	u32 dma_mask;
 
@@ -1802,17 +1761,17 @@
 		if (((adapter->dma_status & 0x10000000) != 0) && ((adapter->dma_status & 1) == 0)) {
 			dma_mask = dma_mask | 1;
 
-			adapter->DmaQ1.head = 0;
-			adapter->DmaQ1.tail = 0;
+			adapter->dmaq1.head = 0;
+			adapter->dmaq1.tail = 0;
 
-			memset(adapter->DmaQ1.buffer, 0, adapter->DmaQ1.buffer_size);
+			memset(adapter->dmaq1.buffer, 0, adapter->dmaq1.buffer_size);
 		}
 
 		if (((adapter->dma_status & 0x20000000) != 0) && ((adapter->dma_status & 2) == 0)) {
 			dma_mask = dma_mask | 2;
 
-			adapter->DmaQ2.head = 0;
-			adapter->DmaQ2.tail = 0;
+			adapter->dmaq2.head = 0;
+			adapter->dmaq2.tail = 0;
 		}
 
 		if (dma_mask != 0) {
@@ -1823,7 +1782,7 @@
 	}
 }
 
-void CloseStream(struct adapter *adapter, u32 pid)
+static void CloseStream(struct adapter *adapter, u32 pid)
 {
 	u32 dma_mask;
 
@@ -1846,10 +1805,10 @@
 	RemovePID(adapter, pid);
 }
 
-u32 InterruptServiceDMA1(struct adapter *adapter)
+static void InterruptServiceDMA1(struct adapter *adapter)
 {
 	struct dvb_demux *dvbdmx = &adapter->demux;
-	struct packet_header_t packet_header;
+	struct packet_header packet_header;
 
 	int nCurDmaCounter;
 	u32 nNumBytesParsed;
@@ -1858,40 +1817,39 @@
 	u8 gbTmpBuffer[188];
 	u8 *pbDMABufCurPos;
 
-	nCurDmaCounter = readl(adapter->io_mem + 0x008) - adapter->DmaQ1.bus_addr;
+	nCurDmaCounter = readl(adapter->io_mem + 0x008) - adapter->dmaq1.bus_addr;
 	nCurDmaCounter = (nCurDmaCounter / dwDefaultPacketSize) * dwDefaultPacketSize;
 
-	if ((nCurDmaCounter < 0) || (nCurDmaCounter > adapter->DmaQ1.buffer_size)) {
+	if ((nCurDmaCounter < 0) || (nCurDmaCounter > adapter->dmaq1.buffer_size)) {
 		dprintk("%s: dma counter outside dma buffer\n", __FUNCTION__);
-
-		return 1;
+		return;
 	}
 
-	adapter->DmaQ1.head = nCurDmaCounter;
+	adapter->dmaq1.head = nCurDmaCounter;
 
-	if (adapter->DmaQ1.tail <= nCurDmaCounter) {
-		nNumNewBytesTransferred = nCurDmaCounter - adapter->DmaQ1.tail;
+	if (adapter->dmaq1.tail <= nCurDmaCounter) {
+		nNumNewBytesTransferred = nCurDmaCounter - adapter->dmaq1.tail;
 
 	} else {
 
-		nNumNewBytesTransferred = (adapter->DmaQ1.buffer_size - adapter->DmaQ1.tail) + nCurDmaCounter;
+		nNumNewBytesTransferred = (adapter->dmaq1.buffer_size - adapter->dmaq1.tail) + nCurDmaCounter;
 	}
 
 //  dprintk("%s: nCurDmaCounter   = %d\n" , __FUNCTION__, nCurDmaCounter);
-//  dprintk("%s: DmaQ1.tail       = %d\n" , __FUNCTION__, adapter->DmaQ1.tail):
+//	dprintk("%s: dmaq1.tail       = %d\n" , __FUNCTION__, adapter->dmaq1.tail):
 //  dprintk("%s: BytesTransferred = %d\n" , __FUNCTION__, nNumNewBytesTransferred);
 
 	if (nNumNewBytesTransferred < dwDefaultPacketSize)
-		return 0;
+		return;
 
 	nNumBytesParsed = 0;
 
 	while (nNumBytesParsed < nNumNewBytesTransferred) {
-		pbDMABufCurPos = adapter->DmaQ1.buffer + adapter->DmaQ1.tail;
+		pbDMABufCurPos = adapter->dmaq1.buffer + adapter->dmaq1.tail;
 
-		if (adapter->DmaQ1.buffer + adapter->DmaQ1.buffer_size < adapter->DmaQ1.buffer + adapter->DmaQ1.tail + 188) {
-			memcpy(gbTmpBuffer, adapter->DmaQ1.buffer + adapter->DmaQ1.tail, adapter->DmaQ1.buffer_size - adapter->DmaQ1.tail);
-			memcpy(gbTmpBuffer + (adapter->DmaQ1.buffer_size - adapter->DmaQ1.tail), adapter->DmaQ1.buffer, (188 - (adapter->DmaQ1.buffer_size - adapter->DmaQ1.tail)));
+		if (adapter->dmaq1.buffer + adapter->dmaq1.buffer_size < adapter->dmaq1.buffer + adapter->dmaq1.tail + 188) {
+			memcpy(gbTmpBuffer, adapter->dmaq1.buffer + adapter->dmaq1.tail, adapter->dmaq1.buffer_size - adapter->dmaq1.tail);
+			memcpy(gbTmpBuffer + (adapter->dmaq1.buffer_size - adapter->dmaq1.tail), adapter->dmaq1.buffer, (188 - (adapter->dmaq1.buffer_size - adapter->dmaq1.tail)));
 
 			pbDMABufCurPos = gbTmpBuffer;
 		}
@@ -1921,21 +1879,19 @@
 
 		nNumBytesParsed = nNumBytesParsed + dwDefaultPacketSize;
 
-		adapter->DmaQ1.tail = adapter->DmaQ1.tail + dwDefaultPacketSize;
+		adapter->dmaq1.tail = adapter->dmaq1.tail + dwDefaultPacketSize;
 
-		if (adapter->DmaQ1.tail >= adapter->DmaQ1.buffer_size)
-			adapter->DmaQ1.tail = adapter->DmaQ1.tail - adapter->DmaQ1.buffer_size;
+		if (adapter->dmaq1.tail >= adapter->dmaq1.buffer_size)
+			adapter->dmaq1.tail = adapter->dmaq1.tail - adapter->dmaq1.buffer_size;
 	};
-
-	return 1;
 }
 
-void InterruptServiceDMA2(struct adapter *adapter)
+static void InterruptServiceDMA2(struct adapter *adapter)
 {
 	printk("%s:\n", __FUNCTION__);
 }
 
-void isr(int irq, void *dev_id, struct pt_regs *regs)
+static irqreturn_t isr(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct adapter *tmp = dev_id;
 
@@ -1945,67 +1901,73 @@
 
 	spin_lock_irq(&tmp->lock);
 
-	while (((value = ReadRegDW(tmp, 0x20C)) & 0x0F) != 0) {
+	if (0 == ((value = ReadRegDW(tmp, 0x20C)) & 0x0F)) {
+		spin_unlock_irq(&tmp->lock);
+		return IRQ_NONE;
+	}
+	
+	while (value != 0) {
 		if ((value & 0x03) != 0)
 			InterruptServiceDMA1(tmp);
 		if ((value & 0x0C) != 0)
 			InterruptServiceDMA2(tmp);
+		value = ReadRegDW(tmp, 0x20C) & 0x0F;
 	}
 
 	spin_unlock_irq(&tmp->lock);
+	return IRQ_HANDLED;
 }
 
-
-void InitDmaQueue(struct adapter *adapter)
+static void Initdmaqueue(struct adapter *adapter)
 {
 	dma_addr_t dma_addr;
 
-	if (adapter->DmaQ1.buffer != 0)
+	if (adapter->dmaq1.buffer != 0)
 		return;
 
-	adapter->DmaQ1.head = 0;
-	adapter->DmaQ1.tail = 0;
-	adapter->DmaQ1.buffer = 0;
+	adapter->dmaq1.head = 0;
+	adapter->dmaq1.tail = 0;
+	adapter->dmaq1.buffer = 0;
 
-	adapter->DmaQ1.buffer = pci_alloc_consistent(adapter->pdev, SizeOfBufDMA1 + 0x80, &dma_addr);
+	adapter->dmaq1.buffer = pci_alloc_consistent(adapter->pdev, SizeOfBufDMA1 + 0x80, &dma_addr);
 
-	if (adapter->DmaQ1.buffer != 0) {
-		memset(adapter->DmaQ1.buffer, 0, SizeOfBufDMA1);
+	if (adapter->dmaq1.buffer != 0) {
+		memset(adapter->dmaq1.buffer, 0, SizeOfBufDMA1);
 
-		adapter->DmaQ1.bus_addr = dma_addr;
-		adapter->DmaQ1.buffer_size = SizeOfBufDMA1;
+		adapter->dmaq1.bus_addr = dma_addr;
+		adapter->dmaq1.buffer_size = SizeOfBufDMA1;
 
 		DmaInitDMA(adapter, 0);
 
 		adapter->dma_status = adapter->dma_status | 0x10000000;
 
-		dprintk("%s: allocated dma buffer at 0x%x, length=%d\n", __FUNCTION__, (int) adapter->DmaQ1.buffer, SizeOfBufDMA1);
+		dprintk("%s: allocated dma buffer at 0x%x, length=%d\n", __FUNCTION__, (int) adapter->dmaq1.buffer, SizeOfBufDMA1);
 
 	} else {
 
 		adapter->dma_status = adapter->dma_status & ~0x10000000;
 	}
 
-	if (adapter->DmaQ2.buffer != 0)
+	if (adapter->dmaq2.buffer != 0)
 		return;
 
-	adapter->DmaQ2.head = 0;
-	adapter->DmaQ2.tail = 0;
-	adapter->DmaQ2.buffer = 0;
+	adapter->dmaq2.head = 0;
+	adapter->dmaq2.tail = 0;
+	adapter->dmaq2.buffer = 0;
 
-	adapter->DmaQ2.buffer = pci_alloc_consistent(adapter->pdev, SizeOfBufDMA2 + 0x80, &dma_addr);
+	adapter->dmaq2.buffer = pci_alloc_consistent(adapter->pdev, SizeOfBufDMA2 + 0x80, &dma_addr);
 
-	if (adapter->DmaQ2.buffer != 0) {
-		memset(adapter->DmaQ2.buffer, 0, SizeOfBufDMA2);
+	if (adapter->dmaq2.buffer != 0) {
+		memset(adapter->dmaq2.buffer, 0, SizeOfBufDMA2);
 
-		adapter->DmaQ2.bus_addr = dma_addr;
-		adapter->DmaQ2.buffer_size = SizeOfBufDMA2;
+		adapter->dmaq2.bus_addr = dma_addr;
+		adapter->dmaq2.buffer_size = SizeOfBufDMA2;
 
 		DmaInitDMA(adapter, 1);
 
 		adapter->dma_status = adapter->dma_status | 0x20000000;
 
-		dprintk("%s: allocated dma buffer at 0x%x, length=%d\n", __FUNCTION__, (int) adapter->DmaQ2.buffer, (int) SizeOfBufDMA2);
+		dprintk("%s: allocated dma buffer at 0x%x, length=%d\n", __FUNCTION__, (int) adapter->dmaq2.buffer, (int) SizeOfBufDMA2);
 
 	} else {
 
@@ -2013,30 +1975,30 @@
 	}
 }
 
-void FreeDmaQueue(struct adapter *adapter)
+static void Freedmaqueue(struct adapter *adapter)
 {
-	if (adapter->DmaQ1.buffer != 0) {
-		pci_free_consistent(adapter->pdev, SizeOfBufDMA1 + 0x80, adapter->DmaQ1.buffer, adapter->DmaQ1.bus_addr);
+	if (adapter->dmaq1.buffer != 0) {
+		pci_free_consistent(adapter->pdev, SizeOfBufDMA1 + 0x80, adapter->dmaq1.buffer, adapter->dmaq1.bus_addr);
 
-		adapter->DmaQ1.bus_addr = 0;
-		adapter->DmaQ1.head = 0;
-		adapter->DmaQ1.tail = 0;
-		adapter->DmaQ1.buffer_size = 0;
-		adapter->DmaQ1.buffer = 0;
+		adapter->dmaq1.bus_addr = 0;
+		adapter->dmaq1.head = 0;
+		adapter->dmaq1.tail = 0;
+		adapter->dmaq1.buffer_size = 0;
+		adapter->dmaq1.buffer = 0;
 	}
 
-	if (adapter->DmaQ2.buffer != 0) {
-		pci_free_consistent(adapter->pdev, SizeOfBufDMA2 + 0x80, adapter->DmaQ2.buffer, adapter->DmaQ2.bus_addr);
+	if (adapter->dmaq2.buffer != 0) {
+		pci_free_consistent(adapter->pdev, SizeOfBufDMA2 + 0x80, adapter->dmaq2.buffer, adapter->dmaq2.bus_addr);
 
-		adapter->DmaQ2.bus_addr = 0;
-		adapter->DmaQ2.head = 0;
-		adapter->DmaQ2.tail = 0;
-		adapter->DmaQ2.buffer_size = 0;
-		adapter->DmaQ2.buffer = 0;
+		adapter->dmaq2.bus_addr = 0;
+		adapter->dmaq2.head = 0;
+		adapter->dmaq2.tail = 0;
+		adapter->dmaq2.buffer_size = 0;
+		adapter->dmaq2.buffer = 0;
 	}
 }
 
-void FreeAdapterObject(struct adapter *adapter)
+static void FreeAdapterObject(struct adapter *adapter)
 {
 	dprintk("%s:\n", __FUNCTION__);
 
@@ -2045,7 +2007,7 @@
 	if (adapter->irq != 0)
 		free_irq(adapter->irq, adapter);
 
-	FreeDmaQueue(adapter);
+	Freedmaqueue(adapter);
 
 	if (adapter->io_mem != 0)
 		iounmap((void *) adapter->io_mem);
@@ -2054,16 +2016,18 @@
 		kfree(adapter);
 }
 
-int ClaimAdapter(struct adapter *adapter)
+static struct pci_driver skystar2_pci_driver;
+
+static int ClaimAdapter(struct adapter *adapter)
 {
 	struct pci_dev *pdev = adapter->pdev;
 
 	u16 var;
 
-	if (!request_region(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1), pdev->name))
+	if (!request_region(pci_resource_start(pdev, 1), pci_resource_len(pdev, 1), skystar2_pci_driver.name))
 		return -EBUSY;
 
-	if (!request_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0), pdev->name))
+	if (!request_mem_region(pci_resource_start(pdev, 0), pci_resource_len(pdev, 0), skystar2_pci_driver.name))
 		return -EBUSY;
 
 	pci_read_config_byte(pdev, PCI_CLASS_REVISION, &adapter->card_revision);
@@ -2093,15 +2057,17 @@
 	return 1;
 }
 
-int SLL_reset_FlexCOP(struct adapter *adapter)
+/*
+static int SLL_reset_FlexCOP(struct adapter *adapter)
 {
 	WriteRegDW(adapter, 0x208, 0);
 	WriteRegDW(adapter, 0x210, 0xB2FF);
 
 	return 0;
 }
+*/
 
-u32 DriverInitialize(struct pci_dev * pdev)
+static int DriverInitialize(struct pci_dev * pdev)
 {
 	struct adapter *adapter;
 	u32 tmp;
@@ -2115,7 +2081,7 @@
 
 	memset(adapter, 0, sizeof(struct adapter));
 
-	pdev->driver_data = adapter;
+	pci_set_drvdata(pdev,adapter);
 
 	adapter->pdev = pdev;
 	adapter->irq = pdev->irq;
@@ -2123,7 +2089,7 @@
 	if ((ClaimAdapter(adapter)) != 1) {
 		FreeAdapterObject(adapter);
 
-		return 2;
+		return -ENODEV;
 	}
 
 	IrqDmaEnableDisableIrq(adapter, 0);
@@ -2133,7 +2099,7 @@
 
 		FreeAdapterObject(adapter);
 
-		return 2;
+		return -ENODEV;
 	}
 
 	ReadRegDW(adapter, 0x208);
@@ -2152,33 +2118,33 @@
 	PidSetEcmPID(adapter, 0x1FFF);
 	PidSetEmmPID(adapter, 0x1FFF);
 
-	InitDmaQueue(adapter);
+	Initdmaqueue(adapter);
 
 	if ((adapter->dma_status & 0x30000000) == 0) {
 		FreeAdapterObject(adapter);
 
-		return 2;
+		return -ENODEV;
 	}
 
-	adapter->B2C2_revision = (ReadRegDW(adapter, 0x204) >> 0x18);
+	adapter->b2c2_revision = (ReadRegDW(adapter, 0x204) >> 0x18);
 
-	if ((adapter->B2C2_revision != 0x82) && (adapter->B2C2_revision != 0xC3))
-		if (adapter->B2C2_revision != 0x82) {
-			dprintk("%s: The revision of the FlexCopII chip on your card is - %d\n", __FUNCTION__, adapter->B2C2_revision);
+	if ((adapter->b2c2_revision != 0x82) && (adapter->b2c2_revision != 0xC3))
+		if (adapter->b2c2_revision != 0x82) {
+			dprintk("%s: The revision of the FlexCopII chip on your card is - %d\n", __FUNCTION__, adapter->b2c2_revision);
 			dprintk("%s: This driver works now only with FlexCopII(rev.130) and FlexCopIIB(rev.195).\n", __FUNCTION__);
 
 			FreeAdapterObject(adapter);
 
-			return 2;
+			return -ENODEV;
 		}
 
 	tmp = ReadRegDW(adapter, 0x204);
 
 	WriteRegDW(adapter, 0x204, 0);
-	linuxdelayms(20);
+	mdelay(20);
 
 	WriteRegDW(adapter, 0x204, tmp);
-	linuxdelayms(10);
+	mdelay(10);
 
 	tmp = ReadRegDW(adapter, 0x308);
 	WriteRegDW(adapter, 0x308, 0x4000 | tmp);
@@ -2209,15 +2175,14 @@
 
 	EEPROM_readKey(adapter, key, 16);
 
-	printk("%s key = \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n", __FUNCTION__, key[0], key[1], key[2], key[3], key[4], key[5], key[6], key[7], key[8], key[9], key[10], key[11], key[12], key[13], key[14], key[15]
-	    );
+	printk("%s key = \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n %02x %02x %02x %02x \n", __FUNCTION__, key[0], key[1], key[2], key[3], key[4], key[5], key[6], key[7], key[8], key[9], key[10], key[11], key[12], key[13], key[14], key[15]);
 
 	adapter->lock = SPIN_LOCK_UNLOCKED;
 
-	return 1;
+	return 0;
 }
 
-void DriverHalt(struct pci_dev *pdev)
+static void DriverHalt(struct pci_dev *pdev)
 {
 	struct adapter *adapter;
 
@@ -2260,11 +2225,8 @@
 	return 0;
 }
 
-/////////////////////////////////////////////////////////////////////
-//                      LNB control
-/////////////////////////////////////////////////////////////////////
-
-void set_tuner_tone(struct adapter *adapter, u8 tone)
+/* lnb control */
+static void set_tuner_tone(struct adapter *adapter, u8 tone)
 {
 	u16 wzHalfPeriodFor45MHz[] = { 0x01FF, 0x0154, 0x00FF, 0x00CC };
 	u16 ax;
@@ -2298,7 +2260,7 @@
 	}
 }
 
-void set_tuner_polarity(struct adapter *adapter, u8 polarity)
+static void set_tuner_polarity(struct adapter *adapter, u8 polarity)
 {
 	u32 var;
 
@@ -2416,10 +2378,10 @@
 	if (pdev == NULL)
 		return -ENODEV;
 
-	if (DriverInitialize(pdev) != 1)
+	if (DriverInitialize(pdev) != 0)
 		return -ENODEV;
 
-	dvb_register_adapter(&dvb_adapter, pdev->name);
+	dvb_register_adapter(&dvb_adapter, skystar2_pci_driver.name);
 
 	if (dvb_adapter == NULL) {
 		printk("%s: Error registering DVB adapter\n", __FUNCTION__);
@@ -2429,7 +2391,7 @@
 		return -ENODEV;
 	}
 
-	adapter = (struct adapter *) pdev->driver_data;
+	adapter = (struct adapter *) pci_get_drvdata(pdev);
 
 	adapter->dvb_adapter = dvb_adapter;
 
@@ -2528,15 +2489,11 @@
 
 static int skystar2_init(void)
 {
-	printk("\nTechnisat SkyStar2 driver loading\n");
-
 	return pci_module_init(&skystar2_pci_driver);
 }
 
 static void skystar2_cleanup(void)
 {
-	printk("\nTechnisat SkyStar2 driver unloading\n");
-
 	pci_unregister_driver(&skystar2_pci_driver);
 }
 
@@ -2545,4 +2502,3 @@
 
 MODULE_DESCRIPTION("Technisat SkyStar2 DVB PCI Driver");
 MODULE_LICENSE("GPL");
-EXPORT_NO_SYMBOLS;

