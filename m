Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271353AbTG2Jay (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 05:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271363AbTG2Jay
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 05:30:54 -0400
Received: from mail.convergence.de ([212.84.236.4]:38366 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S271353AbTG2Jaf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 05:30:35 -0400
Subject: [PATCH 4/6] [DVB] Update MAC handling for various DVB PCI cards
In-Reply-To: <10594710311160@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 29 Jul 2003 11:30:31 +0200
Message-Id: <1059471031240@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, torvalds@osdl.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - correctly read MAC from eeprom on Technotrend and KNC1 cards
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/dvb/ttpci/ttpci-eeprom.c linux-2.6.0-test2.patch/drivers/media/dvb/ttpci/ttpci-eeprom.c
--- linux-2.6.0-test2.work/drivers/media/dvb/ttpci/ttpci-eeprom.c	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/dvb/ttpci/ttpci-eeprom.c	2003-07-21 18:15:47.000000000 +0200
@@ -3,9 +3,6 @@
     decode it and store it in the associated adapter struct for
     use by dvb_net.c
 
-    This code was tested on TT-Budget/WinTV-NOVA-CI PCI boards with
-    Atmel and ST Microelectronics EEPROMs.
-
     This card appear to have the 24C16 write protect held to ground,
     thus permitting normal read/write operation. Theoretically it
     would be possible to write routines to burn a different (encoded)
@@ -15,6 +12,9 @@
     Michael Glaum	KVH Industries
     Holger Waechtler	Convergence
 
+    Copyright (C) 2002-2003 Ralph Metzler <rjkm@metzlerbros.de>
+                            Metzler Brothers Systementwicklung GbR
+
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
     the Free Software Foundation; either version 2 of the License, or
@@ -40,23 +40,62 @@
 #include "dvb_functions.h"
 
 #if 1
-#define dprintk(x...) printk(x)
+#define dprintk(x...) do { printk(x); } while (0)
 #else
-#define dprintk(x...)
+#define dprintk(x...) do { } while (0)
 #endif
 
 
+static int check_mac_tt(u8 *buf)
+{
+        int i;
+        u16 tmp = 0xffff;
+
+        for (i = 0; i < 8; i++) {
+                tmp  = (tmp << 8) | ((tmp >> 8) ^ buf[i]);
+                tmp ^= (tmp >> 4) & 0x0f;
+                tmp ^= (tmp << 12) ^ ((tmp & 0xff) << 5);
+        }
+        tmp ^= 0xffff;
+        return (((tmp >> 8) ^ buf[8]) | ((tmp & 0xff) ^ buf[9]));
+}
+
+static int getmac_tt(u8 * decodedMAC, u8 * encodedMAC)
+{
+        u8 xor[20] = { 0x72, 0x23, 0x68, 0x19, 0x5c, 0xa8, 0x71, 0x2c,
+		       0x54, 0xd3, 0x7b, 0xf1, 0x9E, 0x23, 0x16, 0xf6,
+		       0x1d, 0x36, 0x64, 0x78};
+        u8 data[20];
+        int i;
+
+	/* In case there is a sig check failure have the orig contents available */
+	memcpy(data, encodedMAC, 20);
+
+	for (i = 0; i < 20; i++)
+                data[i] ^= xor[i];
+        for (i = 0; i < 10; i++)
+                data[i] = ((data[2 * i + 1] << 8) | data[2 * i])
+			>> ((data[2 * i + 1] >> 6) & 3);
+
+        if (check_mac_tt(data))
+                return -ENODEV;
+
+	decodedMAC[0] = data[2]; decodedMAC[1] = data[1]; decodedMAC[2] = data[0];
+	decodedMAC[3] = data[6]; decodedMAC[4] = data[5]; decodedMAC[5] = data[4];
+        return 0;
+}
+
 static int ttpci_eeprom_read_encodedMAC(struct dvb_i2c_bus *i2c, u8 * encodedMAC)
 {
 	int ret;
-	u8 b0[] = { 0xd4 };
+	u8 b0[] = { 0xcc };
 
 	struct i2c_msg msg[] = {
 		{.addr = 0x50,.flags = 0,.buf = b0,.len = 1},
-		{.addr = 0x50,.flags = I2C_M_RD,.buf = encodedMAC,.len = 6}
+		{ .addr = 0x50, .flags = I2C_M_RD, .buf = encodedMAC, .len = 20 }
 	};
 
-	dprintk("%s\n", __FUNCTION__);
+	/* dprintk("%s\n", __FUNCTION__); */
 
 	ret = i2c->xfer(i2c, msg, 2);
 
@@ -66,34 +105,11 @@
 	return 0;
 }
 
-static void decodeMAC(u8 * decodedMAC, const u8 * encodedMAC)
-{
-	u8 ormask0[3] = { 0x54, 0x7B, 0x9E };
-	u8 ormask1[3] = { 0xD3, 0xF1, 0x23 };
-	u8 low;
-	u8 high;
-	u8 shift;
-	int i;
-
-	decodedMAC[0] = 0x00;
-	decodedMAC[1] = 0xD0;
-	decodedMAC[2] = 0x5C;
-
-	for (i = 0; i < 3; i++) {
-		low = encodedMAC[2 * i] ^ ormask0[i];
-		high = encodedMAC[2 * i + 1] ^ ormask1[i];
-		shift = (high >> 6) & 0x3;
-
-		decodedMAC[5 - i] = ((high << 8) | low) >> shift;
-	}
-
-}
-
 
 int ttpci_eeprom_parse_mac(struct dvb_i2c_bus *i2c)
 {
-	int ret;
-	u8 encodedMAC[6];
+	int ret, i;
+	u8 encodedMAC[20];
 	u8 decodedMAC[6];
 
 	ret = ttpci_eeprom_read_encodedMAC(i2c, encodedMAC);
@@ -104,16 +120,24 @@
 		return ret;
 	}
 
-	decodeMAC(decodedMAC, encodedMAC);
-	memcpy(i2c->adapter->proposed_mac, decodedMAC, 6);
+	ret = getmac_tt(decodedMAC, encodedMAC);
+	if( ret != 0 ) {
+		dprintk("%s adapter %i failed MAC signature check\n",
+			i2c->adapter->name, i2c->adapter->num);
+		dprintk("encoded MAC from EEPROM was " );
+		for(i=0; i<19; i++) {
+			dprintk( "%.2x:", encodedMAC[i]);
+		}
+		dprintk("%.2x\n", encodedMAC[19]);
+		memset(i2c->adapter->proposed_mac, 0, 6);
+		return ret;
+	}
 
-	dprintk("%s adapter %i has MAC addr = %02x:%02x:%02x:%02x:%02x:%02x\n",
+	memcpy(i2c->adapter->proposed_mac, decodedMAC, 6);
+	dprintk("%s adapter %i has MAC addr = %.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
 		i2c->adapter->name, i2c->adapter->num,
 		decodedMAC[0], decodedMAC[1], decodedMAC[2],
 		decodedMAC[3], decodedMAC[4], decodedMAC[5]);
-	dprintk("encoded MAC was %02x:%02x:%02x:%02x:%02x:%02x\n",
-		encodedMAC[0], encodedMAC[1], encodedMAC[2],
-		encodedMAC[3], encodedMAC[4], encodedMAC[5]);
 	return 0;
 }
 
diff -uNrwB --new-file linux-2.6.0-test2.work/drivers/media/dvb/ttpci/budget-av.c linux-2.6.0-test2.patch/drivers/media/dvb/ttpci/budget-av.c
--- linux-2.6.0-test2.work/drivers/media/dvb/ttpci/budget-av.c	2003-07-29 09:10:18.000000000 +0200
+++ linux-2.6.0-test2.patch/drivers/media/dvb/ttpci/budget-av.c	2003-07-21 18:15:47.000000000 +0200
@@ -64,6 +64,19 @@
 	return mm2[0];
 }
 
+static int i2c_readregs(struct dvb_i2c_bus *i2c, u8 id, u8 reg, u8 *buf, u8 len)
+{
+        u8 mm1[] = { reg };
+        struct i2c_msg msgs[2] = {
+		{ addr: id/2, flags: 0, buf: mm1, len: 1 },
+		{ addr: id/2, flags: I2C_M_RD, buf: buf, len: len }
+	};
+
+        if (i2c->xfer(i2c, msgs, 2) != 2)
+		return -EIO;
+	return 0;
+}
+
 
 static int i2c_writereg (struct dvb_i2c_bus *i2c, u8 id, u8 reg, u8 val)
 {
@@ -177,6 +190,7 @@
 {
 	struct budget_av *budget_av;
 	struct budget_info *bi = info->ext_priv;
+	u8 *mac;
 	int err;
 
 	DEB_EE(("dev: %p\n",dev));
@@ -243,6 +257,16 @@
 	/* fixme: find some sane values here... */
 	saa7146_write(dev, PCI_BT_V1, 0x1c00101f);
 
+	mac = budget_av->budget.dvb_adapter->proposed_mac;
+	if (i2c_readregs(budget_av->budget.i2c_bus, 0xa0, 0x30, mac, 6)) {
+		printk("KNC1-%d: Could not read MAC from KNC1 card\n",
+				budget_av->budget.dvb_adapter->num);
+		memset(mac, 0, 6);
+	}
+	else
+		printk("KNC1-%d: MAC addr = %.2x:%.2x:%.2x:%.2x:%.2x:%.2x\n",
+				budget_av->budget.dvb_adapter->num,
+				mac[0], mac[1], mac[2], mac[3], mac[4], mac[5]);
 	return 0;
 }
 

