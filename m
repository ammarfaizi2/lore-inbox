Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267864AbTGOM2L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 08:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267718AbTGOM2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 08:28:03 -0400
Received: from mail.convergence.de ([212.84.236.4]:39328 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S267561AbTGOMGM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 08:06:12 -0400
Subject: [PATCH 15/17] Update various other frontend drivers
In-Reply-To: <10582716591780@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Tue, 15 Jul 2003 14:21:00 +0200
Message-Id: <10582716601905@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) 
	<hunold@convergence.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[DVB] - In alps_tdlb7.c read SP8870 status reg to clear pending irqs in FE_SET_FRONTEND, as suggested by Ragnar Sundblad to avoid frontend hang-ups.
[DVB] - the vp310 support in mt312.c support should be configured to 90Mhz, too. skystar2 driver with bugfixed master_xfer() should probably work now.
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/frontends/alps_tdlb7.c linux-2.6.0-test1.patch/drivers/media/dvb/frontends/alps_tdlb7.c
--- linux-2.6.0-test1.work/drivers/media/dvb/frontends/alps_tdlb7.c	2003-07-15 09:42:37.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/frontends/alps_tdlb7.c	2003-07-14 11:56:37.000000000 +0200
@@ -349,6 +349,9 @@
 
 		sp5659_set_tv_freq (i2c, p->frequency);
 
+		// read status reg in order to clear pending irqs
+		sp8870_readreg(i2c, 0x200);
+
 		// sample rate correction bit [23..17]
 		sp8870_writereg(i2c,0x0319,0x000A);
 		
diff -uNrwB --new-file linux-2.6.0-test1.work/drivers/media/dvb/frontends/mt312.c linux-2.6.0-test1.patch/drivers/media/dvb/frontends/mt312.c
--- linux-2.6.0-test1.work/drivers/media/dvb/frontends/mt312.c	2003-07-15 10:59:46.000000000 +0200
+++ linux-2.6.0-test1.patch/drivers/media/dvb/frontends/mt312.c	2003-06-27 00:04:06.000000000 +0200
@@ -34,6 +34,7 @@
 
 #define I2C_ADDR_MT312		0x0e
 #define I2C_ADDR_SL1935		0x61
+#define I2C_ADDR_TSA5059	0x61
 
 #define MT312_DEBUG		0
 
@@ -207,12 +208,32 @@
 	return mt312_pll_write(i2c, I2C_ADDR_SL1935, buf, sizeof(buf));
 }
 
+static int tsa5059_set_tv_freq(struct dvb_i2c_bus *i2c, u32 freq, u32 sr)
+{
+	u8 buf[4];
+
+	u32 ref = mt312_div(freq, 125);
+
+	buf[0] = (ref >> 8) & 0x7f;
+	buf[1] = (ref >> 0) & 0xff;
+	buf[2] = 0x84 | ((ref >> 10) & 0x60);
+	buf[3] = 0x80;
+	
+	if (freq < 1550000)
+		buf[3] |= 0x02;
+
+	printk(KERN_INFO "synth dword = %02x%02x%02x%02x\n", buf[0],
+	       buf[1], buf[2], buf[3]);
+
+	return mt312_pll_write(i2c, I2C_ADDR_TSA5059, buf, sizeof(buf));
+}
+
 static int mt312_reset(struct dvb_i2c_bus *i2c, const u8 full)
 {
 	return mt312_writereg(i2c, RESET, full ? 0x80 : 0x40);
 }
 
-static int mt312_init(struct dvb_i2c_bus *i2c)
+static int mt312_init(struct dvb_i2c_bus *i2c, const long id)
 {
 	int ret;
 	u8 buf[2];
@@ -240,6 +261,9 @@
 	if ((ret = mt312_writereg(i2c, SNR_THS_HIGH, 0x32)) < 0)
 		return ret;
 
+	if ((ret = mt312_writereg(i2c, OP_CTRL, 0x53)) < 0)
+		return ret;
+
 	/* TS_SW_LIM */
 	buf[0] = 0x8c;
 	buf[1] = 0x98;
@@ -427,7 +451,8 @@
 }
 
 static int mt312_set_frontend(struct dvb_i2c_bus *i2c,
-			      const struct dvb_frontend_parameters *p)
+			      const struct dvb_frontend_parameters *p,
+			      const long id)
 {
 	int ret;
 	u8 buf[5];
@@ -437,6 +462,8 @@
 	    { 0x00, 0x01, 0x02, 0x04, 0x3f, 0x08, 0x10, 0x20, 0x3f, 0x3f };
 	const u8 inv_tab[3] = { 0x00, 0x40, 0x80 };
 
+	int (*set_tv_freq)(struct dvb_i2c_bus *i2c, u32 freq, u32 sr);
+
 	if ((p->frequency < mt312_info.frequency_min)
 	    || (p->frequency > mt312_info.frequency_max))
 		return -EINVAL;
@@ -457,8 +484,18 @@
 	    || (p->u.qpsk.fec_inner == FEC_8_9))
 		return -EINVAL;
 
-	if ((ret =
-	     sl1935_set_tv_freq(i2c, p->frequency, p->u.qpsk.symbol_rate)) < 0)
+	switch (id) {
+	case ID_VP310:
+		set_tv_freq = tsa5059_set_tv_freq;
+		break;
+	case ID_MT312:
+		set_tv_freq = sl1935_set_tv_freq;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if ((ret = set_tv_freq(i2c, p->frequency, p->u.qpsk.symbol_rate)) < 0)
 		return ret;
 
 	/* sr = (u16)(sr * 256.0 / 1000000.0) */
@@ -552,9 +589,7 @@
 {
 	const fe_code_rate_t fec_tab[8] =
 	    { FEC_1_2, FEC_2_3, FEC_3_4, FEC_5_6, FEC_6_7, FEC_7_8,
-		FEC_AUTO,
-		FEC_AUTO
-	};
+		FEC_AUTO, FEC_AUTO };
 
 	int ret;
 	u8 fec_status;
@@ -652,7 +687,7 @@
 		return mt312_read_ubc(i2c, arg);
 
 	case FE_SET_FRONTEND:
-		return mt312_set_frontend(i2c, arg);
+		return mt312_set_frontend(i2c, arg, (long) fe->data);
 
 	case FE_GET_FRONTEND:
 		return mt312_get_frontend(i2c, arg);
@@ -664,7 +699,7 @@
 		return mt312_sleep(i2c);
 
 	case FE_INIT:
-		return mt312_init(i2c);
+		return mt312_init(i2c, (long) fe->data);
 
 	case FE_RESET:
 		return mt312_reset(i2c, 0);

