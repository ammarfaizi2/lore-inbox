Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964970AbVKAIN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbVKAIN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 03:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964972AbVKAIN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 03:13:28 -0500
Received: from hulk.hostingexpert.com ([69.57.134.39]:44486 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S964970AbVKAINV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 03:13:21 -0500
Message-ID: <43672375.1020603@m1k.net>
Date: Tue, 01 Nov 2005 03:12:37 -0500
From: Michael Krufky <mkrufky@m1k.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, linux-dvb-maintainer@linuxtv.org
Subject: [PATCH 05/37] dvb: add alternate stv0297-driver
Content-Type: multipart/mixed;
 boundary="------------050002000708090104000204"
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050002000708090104000204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit




--------------050002000708090104000204
Content-Type: text/x-patch;
 name="2365.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2365.patch"

From: Patrick Boettcher <pb@linuxtv.org>

adding special stv0297-driver for the Technisat/B2C2 CableStar2 PCI and USB
devices (USB untested)

This driver could also be used with other stv0297-based cards, but someone has
to do it.

The CableStar2's stv0297-driver is tested with QAM32/64/128/256 and has a very
nice reception-qualitiy.

Signed-off-by: Patrick Boettcher <pb@linuxtv.org>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>

 drivers/media/dvb/b2c2/Makefile           |    2 
 drivers/media/dvb/b2c2/flexcop-fe-tuner.c |  143 +----
 drivers/media/dvb/b2c2/stv0297_cs2.c      |  776 ++++++++++++++++++++++++++++++
 drivers/media/dvb/b2c2/stv0297_cs2.h      |   51 +
 drivers/media/dvb/b2c2/stv0297_priv.h     |  154 +++++
 5 files changed, 1029 insertions(+), 97 deletions(-)

--- linux-2.6.14-git3.orig/drivers/media/dvb/b2c2/Makefile
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/Makefile
@@ -3,6 +3,8 @@
 	flexcop-dma.o
 obj-$(CONFIG_DVB_B2C2_FLEXCOP) += b2c2-flexcop.o
 
+obj-$(CONFIG_DVB_B2C2_FLEXCOP) += stv0297_cs2.o
+
 b2c2-flexcop-pci-objs = flexcop-pci.o
 obj-$(CONFIG_DVB_B2C2_FLEXCOP_PCI) += b2c2-flexcop-pci.o
 
--- linux-2.6.14-git3.orig/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/flexcop-fe-tuner.c
@@ -11,7 +11,7 @@
 #include "mt352.h"
 #include "nxt2002.h"
 #include "bcm3510.h"
-#include "stv0297.h"
+#include "stv0297_cs2.h"
 #include "mt312.h"
 
 /* lnb control */
@@ -334,105 +334,54 @@
 	.pll_set = skystar23_samsung_tbdu18132_pll_set,
 };
 
+int alps_tdee4_stv0297_pll_set (struct dvb_frontend* fe, struct dvb_frontend_parameters *fep)
+{
+	struct flexcop_device *fc = fe->dvb->priv;
+	u8 buf[4];
+	u16 div;
+	int ret;
+
+/*  62.5 kHz * 10 */
+#define REF_FREQ    625
+#define FREQ_OFFSET 36125
+
+	div = ((fep->frequency/1000 + FREQ_OFFSET ) * 10)  / REF_FREQ; // 4 MHz = 4000 KHz
+
+	buf[0] = (u8)( div >> 8) & 0x7f;
+	buf[1] = (u8)        div & 0xff;
+
+/* F(osc) = N * Reference Freq. (62.5 kHz)
+ * byte 2 :  0 N14 N13 N12 N11 N10 N9  N8
+ * byte 3 : N7 N6  N5  N4  N3  N2  N1  N0
+ * byte 4 : 1  *   *   AGD R3  R2  R1  R0
+ * byte 5 : C1 *   RE  RTS BS4 BS3 BS2 BS1
+ * AGD = 1, R3 R2 R1 R0 = 0 1 0 1 => byte 4 = 1**10101 = 0x95 */
+	buf[2] = 0x95;
+
+// Range(MHz)  C1 *  RE RTS BS4 BS3 BS2 BS1  Byte 5
+//  47 - 153   0  *  0   0   0   0   0   1   0x01
+// 153 - 430   0  *  0   0   0   0   1   0   0x02
+// 430 - 822   0  *  0   0   1   0   0   0   0x08
+// 822 - 862   1  *  0   0   1   0   0   0   0x88
+
+	     if (fep->frequency <= 153000000) buf[3] = 0x01;
+	else if (fep->frequency <= 430000000) buf[3] = 0x02;
+	else if (fep->frequency <= 822000000) buf[3] = 0x08;
+	else buf[3] = 0x88;
+
+	deb_tuner("tuner buffer for %d Hz: %x %x %x %x\n",fep->frequency, buf[0],buf[1],buf[2],buf[3]);
+	ret = fc->i2c_request(fc,FC_WRITE,FC_I2C_PORT_TUNER,0x61,buf[0],&buf[1],3);
+	deb_tuner("tuner write returned: %d\n",ret);
+
+	return 0;
+}
 
-static u8 alps_tdee4_stv0297_inittab[] = {
-	0x80, 0x01,
-	0x80, 0x00,
-	0x81, 0x01,
-	0x81, 0x00,
-	0x00, 0x09,
-	0x01, 0x69,
-	0x03, 0x00,
-	0x04, 0x00,
-	0x07, 0x00,
-	0x08, 0x00,
-	0x20, 0x00,
-	0x21, 0x40,
-	0x22, 0x00,
-	0x23, 0x00,
-	0x24, 0x40,
-	0x25, 0x88,
-	0x30, 0xff,
-	0x31, 0x00,
-	0x32, 0xff,
-	0x33, 0x00,
-	0x34, 0x50,
-	0x35, 0x7f,
-	0x36, 0x00,
-	0x37, 0x20,
-	0x38, 0x00,
-	0x40, 0x1c,
-	0x41, 0xff,
-	0x42, 0x29,
-	0x43, 0x00,
-	0x44, 0xff,
-	0x45, 0x00,
-	0x46, 0x00,
-	0x49, 0x04,
-	0x4a, 0x00,
-	0x4b, 0xf8,
-	0x52, 0x30,
-	0x55, 0xae,
-	0x56, 0x47,
-	0x57, 0xe1,
-	0x58, 0x3a,
-	0x5a, 0x1e,
-	0x5b, 0x34,
-	0x60, 0x00,
-	0x63, 0x00,
-	0x64, 0x00,
-	0x65, 0x00,
-	0x66, 0x00,
-	0x67, 0x00,
-	0x68, 0x00,
-	0x69, 0x00,
-	0x6a, 0x02,
-	0x6b, 0x00,
-	0x70, 0xff,
-	0x71, 0x00,
-	0x72, 0x00,
-	0x73, 0x00,
-	0x74, 0x0c,
-	0x80, 0x00,
-	0x81, 0x00,
-	0x82, 0x00,
-	0x83, 0x00,
-	0x84, 0x04,
-	0x85, 0x80,
-	0x86, 0x24,
-	0x87, 0x78,
-	0x88, 0x10,
-	0x89, 0x00,
-	0x90, 0x01,
-	0x91, 0x01,
-	0xa0, 0x04,
-	0xa1, 0x00,
-	0xa2, 0x00,
-	0xb0, 0x91,
-	0xb1, 0x0b,
-	0xc0, 0x53,
-	0xc1, 0x70,
-	0xc2, 0x12,
-	0xd0, 0x00,
-	0xd1, 0x00,
-	0xd2, 0x00,
-	0xd3, 0x00,
-	0xd4, 0x00,
-	0xd5, 0x00,
-	0xde, 0x00,
-	0xdf, 0x00,
-	0x61, 0x49,
-	0x62, 0x0b,
-	0x53, 0x08,
-	0x59, 0x08,
-	0xff, 0xff,
-};
 
 static struct stv0297_config alps_tdee4_stv0297_config = {
 	.demod_address = 0x1c,
-	.inittab = alps_tdee4_stv0297_inittab,
-//	.invert = 1,
-//	.pll_set = alps_tdee4_stv0297_pll_set,
+	.pll_set = alps_tdee4_stv0297_pll_set,
+	.fclk = STV0297_PAL_FCLK,
+	.demodfreq = STV0297_PAL_IF - STV0297_PAL_FCLK,
 };
 
 /* try to figure out the frontend, each card/box can have on of the following list */
@@ -464,7 +413,7 @@
 		info("found the bcm3510 at i2c address: 0x%02x",air2pc_atsc_first_gen_config.demod_address);
 	} else
 	/* try the cable dvb (stv0297) */
-	if ((fc->fe = stv0297_attach(&alps_tdee4_stv0297_config, &fc->i2c_adap)) != NULL) {
+	if ((fc->fe = stv0297_cs2_attach(&alps_tdee4_stv0297_config, &fc->i2c_adap)) != NULL) {
 		fc->dev_type                        = FC_CABLE;
 		info("found the stv0297 at i2c address: 0x%02x",alps_tdee4_stv0297_config.demod_address);
 	} else
--- /dev/null
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/stv0297_cs2.c
@@ -0,0 +1,776 @@
+/*
+ * Driver for the DVB-C STV0297 demodulator
+ *
+ *  a special, temporary version for the CableStar2 which can hopefully be
+ *  rewritten to be used with the other stv0297-based cards
+ *
+ *  Copyright (C) 2005 Patrick Boettcher <patrick.boettcher@desy.de>
+ *
+ *  Copyright (C) 2004 Andrew de Quincey <adq_dvb@lidskialf.net>
+ *
+ *  Copyright (C) 2003-2004 Dennis Noermann <dennis.noermann@noernet.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc., 675
+ *  Mass Ave, Cambridge, MA 02139, USA.
+ *
+ *  Changelog 2005-03-24 - revamp in order to get the CableStar2 working
+ *  (thanks to John Jurrius, BBTI Inc.)
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+
+#include "dvb_frontend.h"
+
+#include "stv0297_cs2.h"
+
+#include "stv0297_priv.h"
+
+struct stv0297_state {
+	struct i2c_adapter *i2c;
+	struct dvb_frontend_ops ops;
+	const struct stv0297_config *config;
+	struct dvb_frontend frontend;
+
+	int invert;
+	u32 lastber;
+	unsigned long base_freq;
+};
+
+static int debug;
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "set debugging level (1=info,2=i2c,4=calc (|-able)).");
+
+#define dprintk(level,x...) if (level & debug) printk(x)
+#define dbufout(b,l) if (debug & 0x02) {\
+	int i; \
+	for (i = 0; i < l; i++) \
+		deb_i2c("%02x ",b[i]); \
+}
+#define deb_info(args...) dprintk(0x01,args)
+#define deb_i2c(args...)  dprintk(0x02,args)
+#define deb_calc(args...) dprintk(0x04,args)
+
+#define abs64(x) (x) < 0 ? -(x) : (x);
+static s64 div64(s64 dividend,s64 divisor)
+{
+	s64 rdiv,remainder,result=0,i;
+	s64 divbits,valbits;
+	s64 neg = 0;
+
+	if (divisor == 0)
+		return 0;
+
+	if (dividend < 0)
+		neg = !neg;
+	if (divisor < 0)
+		neg = !neg;
+
+	dividend = abs64(dividend);
+	divisor  = abs64(divisor);
+
+	deb_calc("%Ld / %Ld\n",dividend,divisor);
+
+	for (i = 1,divbits = 0; i < divisor;  i *= 2, divbits++);
+	for (i = 1,valbits = 0; i < dividend; i *= 2, valbits++);
+
+	rdiv = divisor << (valbits-divbits);
+	for (i = valbits; i >= divbits; i--) {
+		result <<= 1;
+		if (dividend >= rdiv) {
+			result |= 1;
+			dividend -= rdiv;
+		}
+		rdiv >>= 1;
+	}
+	remainder = dividend;
+	if (neg)
+		return -result;
+	else
+		return result;
+}
+
+static int stv0297_writeregsI(struct stv0297_state *state, u8 reg1, u8 *b, u8 len)
+{
+	int ret;
+	u8 buf[len+1];
+	struct i2c_msg msg = {
+		.addr = state->config->demod_address, .flags = 0, .buf = buf, .len = len+1
+	};
+
+	deb_i2c("wr: %02x ",reg1);
+	dbufout(b,len);
+	deb_i2c("\n");
+
+	buf[0] = reg1;
+	memcpy(&buf[1],b,len);
+
+	if ((ret = i2c_transfer(state->i2c, &msg, 1)) != 1)
+		deb_info("%s: writereg error (reg == 0x%02x, datalen == %d, "
+			"ret == %i)\n", __FUNCTION__, reg1, len, ret);
+
+	return (ret != 1) ? -EREMOTEIO : 0;
+}
+
+static int stv0297_writeregI(struct stv0297_state *state, u8 reg, u8 data)
+{
+	return stv0297_writeregsI(state,reg,&data,1);
+}
+
+static int stv0297_readregsI(struct stv0297_state *state, u8 reg1, u8 *b, u8 len)
+{
+	int ret;
+	struct i2c_msg msg[] = {
+		{ .addr = state->config->demod_address, .flags = 0,        .buf = &reg1,.len = 1},
+		{ .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = b,    .len = len}
+	};
+
+	/* the Nexus-CA needs a STOP between the register and data, but this breaks
+	 * the common i2c-routine, where you have 2 i2c-message in a package
+	 * when doing a read operation TODO
+	 */
+
+	if ((ret = i2c_transfer(state->i2c, msg, 2)) != 2) {
+		deb_info("%s: readreg error (reg == 0x%02x, ret == %i)\n", __FUNCTION__, reg1, ret);
+		return -EREMOTEIO;
+	}
+
+	deb_i2c("rd: %02x ",reg1);
+	dbufout(b,len);
+	deb_i2c("\n");
+
+	/*
+	if ((ret = i2c_transfer(state->i2c, &msg[1], 1)) != 1) {
+		deb_info("%s: readreg error (reg == 0x%02x, ret == %i)\n", __FUNCTION__, reg1, ret);
+		return -1;
+	}*/
+
+	return 0;
+}
+
+
+static int stv0297_readregI(struct stv0297_state *state, u8 reg)
+{
+	int ret;
+	u8 b[] = { 0 };
+
+	if ((ret = stv0297_readregsI(state,reg,b,1)) < 0)
+		return ret;
+
+	return b[0];
+}
+
+static int stv0297_writereg_maskI(struct stv0297_state *state, u8 reg, u8 mask, u8 data)
+{
+	int val;
+
+	if ((val = stv0297_readregI(state, reg)) < 0)
+		return val;
+	val &= ~mask;
+	val |= (data & mask);
+	return stv0297_writeregI(state, reg, val);
+}
+
+
+static void stv0297_set_symbolrate(struct stv0297_state *state, u32 srate)
+{
+	u64 tmp = div64(((u64) srate) << 32,state->config->fclk);
+	deb_info("symbolrate: %u, regval: %016Lx\n",srate,tmp );
+
+	stv0297_writeregI(state, ST_LOOP5, tmp & 0xFF);
+	stv0297_writeregI(state, ST_LOOP6, tmp >> 8);
+	stv0297_writeregI(state, ST_LOOP7, tmp >> 16);
+	stv0297_writeregI(state, ST_LOOP8, tmp >> 24);
+}
+
+static u32 stv0297_get_symbolrate(struct stv0297_state *state)
+{
+	u64 tmp;
+	tmp  = stv0297_readregI(state, ST_LOOP5);
+	tmp |= stv0297_readregI(state, ST_LOOP6) << 8;
+	tmp |= stv0297_readregI(state, ST_LOOP7) << 16;
+	tmp |= stv0297_readregI(state, ST_LOOP8) << 24;
+
+	tmp *= state->config->fclk;
+	tmp >>= 32;
+	return (u32) tmp;
+}
+
+
+static void stv0297_set_crl(struct stv0297_state *state, struct dvb_frontend_parameters *p, s32 car_offset)
+{
+	u8 crlbuf[10] = { 0 };
+	u32 sweeprate,iphase;
+	u64 tmp;
+	u16 sweepvalue;
+
+	     if (p->u.qam.symbol_rate < 2000000UL) sweeprate =   80000UL;
+	else if (p->u.qam.symbol_rate < 3500000UL) sweeprate =  200000UL;
+	else if (p->u.qam.symbol_rate < 4500000UL) sweeprate =  800000UL;
+	else                                       sweeprate = 1000000UL;
+
+	tmp = div64(((u64) sweeprate) << 29, p->u.qam.symbol_rate);
+	sweepvalue = div64(tmp,1000000UL);
+	if (sweepvalue & 1)
+		sweepvalue += 2; /* round up, adjust */
+	sweepvalue >>=1;
+
+	deb_calc("symbol_rate: %u, sweeprate: %u, sweepvalue: %u (%x)\n",p->u.qam.symbol_rate,sweeprate,sweepvalue,sweepvalue);
+
+	crlbuf[0] = sweepvalue & 0xff;
+	crlbuf[9] = (sweepvalue >> 4) & 0xf0;
+
+	if (p->u.qam.modulation == QAM_256)
+		crlbuf[1] = 0x58;
+	else
+		crlbuf[1] = 0x49;
+
+	crlbuf[2] = 0x0a;
+	crlbuf[3] = crlbuf[4] = crlbuf[5] = 0x00;
+
+	/* carrier offset */
+	if (p->u.qam.modulation == QAM_16)
+		iphase = 0;
+	else
+		iphase = div64(((u64) car_offset) << 28, p->u.qam.symbol_rate);
+
+	deb_calc("symbol_rate: %u, car_offset %d, iphase: %u (%x)\n",p->u.qam.symbol_rate,car_offset,iphase,iphase);
+	crlbuf[6]  =  iphase        & 0xff;
+	crlbuf[7]  = (iphase >>  8) & 0xff;
+	crlbuf[8]  = (iphase >> 16) & 0xff;
+	crlbuf[9] |= (iphase >> 24) & 0x0f;
+
+	stv0297_writeregsI(state,CRL_0,crlbuf,sizeof(crlbuf));
+}
+
+/*
+static long stv0297_get_carrieroffset(struct stv0297_state *state)
+{
+	s64 tmp;
+
+	stv0297_writeregI(state, CRL_11, 0x00);
+
+	tmp = stv0297_readregI(state, CRL_6);
+	tmp |= (stv0297_readregI(state, CRL_7) << 8);
+	tmp |= (stv0297_readregI(state, CRL_8) << 16);
+	tmp |= (stv0297_readregI(state, CRL_9) & 0x0F) << 24;
+
+	tmp *= stv0297_get_symbolrate(state);
+	tmp >>= 28;
+
+	return (s32) tmp;
+}
+*/
+
+static int stv0297_set_modulation(struct stv0297_state *state, fe_modulation_t modulation)
+{
+	int val = stv0297_readregI(state,EQU_0) & STV0297_CLEARQAM;
+	switch (modulation) {
+		case QAM_16:  val = STV0297_QAM16; break;
+		case QAM_32:  val = STV0297_QAM32; break;
+		case QAM_64:  val = STV0297_QAM64; break;
+		case QAM_128: val = STV0297_QAM128; break;
+		case QAM_256: val = STV0297_QAM256; break;
+		default: return -EINVAL;
+	}
+	stv0297_writeregI(state, EQU_0, val);
+	return 0;
+}
+
+static int stv0297_set_inversion(struct stv0297_state *state, fe_spectral_inversion_t inversion)
+{
+	int val = 0;
+	switch (inversion) {
+		case INVERSION_OFF: val = 0; break;
+		case INVERSION_ON:  val = 1; break;
+		default: return -EINVAL;
+	}
+	stv0297_writereg_maskI(state, CTRL_3, 0x08, val << 3);
+	return 0;
+}
+
+int stv0297_cs2_enable_plli2c(struct dvb_frontend *fe)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+
+	stv0297_writeregI(state, CTRL_7, 0x78);
+	stv0297_writeregI(state, CTRL_6, 0xc8);
+
+	return 0;
+}
+
+static int stv0297_init(struct dvb_frontend *fe)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+
+	state->invert = 0;
+	return 0;
+}
+
+static int stv0297_reset(struct dvb_frontend *fe)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+
+	/* soft reset */
+	stv0297_writeregI(state, CTRL_0, 0x01);
+	stv0297_writeregI(state, CTRL_0, 0x00);
+
+	/* reset deinterleaver */
+	stv0297_writeregI(state, CTRL_1, 0x01);
+	stv0297_writeregI(state, CTRL_1, 0x00);
+
+	/* device specific initialization here */
+/*	state->config_struct->demod_init(fe); */
+
+	/* this is the initialization for the CableStar, maybe it works for other too */
+	{
+		u8 equ0[] = { 0x48, 0x58 }; /* QAM64, for QAM256: { 0x3a, 0x8a } */
+		u8 equ3[] = { 0x00, 0x00 };
+		u8 equ7[] = { 0x00, 0x00 };
+		u8 delagc[] = { 0xff, /* gold, original: 0x6b or 0x54 */
+						 0x9d, 0xff, /* ALPS, MT203x: 0x54 (Gold) 0xb5 */
+						 0x00, /* gold, original: 0x44 or 0xff, 0xb0, 0x8b */
+						 0x29, /* original, or 0x00, 0x07, 0xb3 */
+						 0x55, /* gold */
+						 0x80, /* original */
+						 0x6e, 0x9c };
+		u8 wbagc0[] = { 0x1a, 0xfe, 0x33, 0x00 /* original */, 0xff, 0x00, 0x00 };
+		u8 wbagc9[] = { 0x04, 0x51, 0xf8 };
+#define GAIN_PATH0 0x01
+#define GAIN_PATH1 0x04
+#define INTEGRAL_GAIN_HI 0X0
+#define INTEGRAL_GAIN_LO 0X06
+#define DIRECT_GAIN_HI   0x0
+#define DIRECT_GAIN_LO   0x06
+#define STLOOP_ALGORITHM 0x00
+		u8 st_loop2[] = { (GAIN_PATH0 << 5) | (GAIN_PATH1 << 2) | INTEGRAL_GAIN_HI, DIRECT_GAIN_LO };
+		u8 st_loop9[] = { DIRECT_GAIN_HI | INTEGRAL_GAIN_LO, 0x5e /* original */, 0x04 | (STLOOP_ALGORITHM << 4) };
+		u8 pmfagc0[] = { 0xff, 0x04, 0x00, 0x00, 0x0c };
+		u8 ctrl[] = { 0x20, 0x00, 0x30,
+			stv0297_readregI(state,CTRL_3) & SPECTRAL_INVERSION_TOGGLE, /* Clear, except the Spectral Inversion Bit. */
+			0x04,0x22,0x08,0x1b,0x00 /* Gold */,0x00 };
+		u8 deint_sync[] = { 0x00, 0x04 };
+		u8 bert[] = { 0x86, 0x00, 0x00 }; /* bit4 of byte0 toggles byte-wise-counting */
+		u8 deint[] = { 0x91, 0x0b };
+		u8 outformat[] = { 0x5b, 0x10, 0x12 };
+		u8 rs_desc0[] = { 0x02, 0x00, 0x00, 0x00, 0x02, 0x00 };
+		u8 rs_desc14[] = { 0x00, 0x01 };
+
+		stv0297_writeregsI(state,EQU_0,equ0,sizeof(equ0));
+		stv0297_writeregsI(state,EQU_3,equ3,sizeof(equ3));
+		stv0297_writeregsI(state,EQU_7,equ7,sizeof(equ7));
+		stv0297_writeregsI(state,DELAGC_0,delagc,sizeof(delagc));
+		stv0297_writeregsI(state,WBAGC_0,wbagc0,sizeof(wbagc0));
+		stv0297_writeregsI(state,WBAGC_9,wbagc9,sizeof(wbagc9));
+		stv0297_writeregsI(state,ST_LOOP2,st_loop2,sizeof(st_loop2));
+		stv0297_writeregsI(state,ST_LOOP9,st_loop9,sizeof(st_loop9));
+		stv0297_writeregsI(state,PMFAGC_0,pmfagc0,sizeof(pmfagc0));
+		stv0297_writeregsI(state,CTRL_0,ctrl,sizeof(ctrl));
+		stv0297_writeregsI(state,DEINT_SYNC_0,deint_sync,sizeof(deint_sync));
+		stv0297_writeregsI(state,BERT_0,bert,sizeof(bert));
+		stv0297_writeregsI(state,DEINT_0,deint,sizeof(deint));
+		stv0297_writeregsI(state,OUTFORMAT_0,outformat,sizeof(outformat));
+		stv0297_writeregsI(state,RS_DESC_0,rs_desc0,sizeof(rs_desc0));
+		stv0297_writeregsI(state,RS_DESC_14,rs_desc14,sizeof(rs_desc14));
+	}
+
+	state->lastber = 0;
+
+	if (state->config->pll_init)
+		state->config->pll_init(fe);
+
+	return 0;
+}
+
+
+static void stv0297_set_initdemod(struct stv0297_state *state, s32 offset)
+{
+	u16 initdemod = div64( (s64) (state->config->demodfreq - offset) << 16 , state->config->fclk);
+	u8 initdem[6];
+
+	deb_calc("demodfreq: %d, offset: %d, fclk: %d, initdemod: %d (%x)\n",
+			state->config->demodfreq, offset, state->config->fclk, initdemod, initdemod);
+
+	initdem[0] =  initdemod       & 0xff;
+	initdem[1] = (initdemod >> 8) & 0xff;
+	initdem[2] = 0x00;
+	initdem[3] = 0x00;
+	initdem[4] = 0x40;
+	initdem[5] = 0x88;
+
+	stv0297_writeregsI(state,INITDEM_0, initdem,6);
+}
+
+#define try(expr,num,sleep) \
+	for (i = 0; i < (num) && !(expr); i++) msleep(sleep);
+
+static int stv0297_set_frontend(struct dvb_frontend *fe, struct dvb_frontend_parameters *p)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+	int i;
+	u8 equ_save[2];
+	fe_spectral_inversion_t inversion;
+
+	switch (p->inversion) {
+		case INVERSION_AUTO: /* fall through wanted */
+		case INVERSION_OFF:
+			inversion = state->invert ? INVERSION_ON : INVERSION_OFF;
+			break;
+		case INVERSION_ON:
+			inversion = state->invert ? INVERSION_OFF : INVERSION_ON;
+			break;
+		default:
+			return -EINVAL;
+	}
+	deb_info("spectrum inversion: %s\n",inversion == INVERSION_ON ? "on" : "off");
+
+	stv0297_reset(fe);
+	state->config->pll_set(fe, p);
+/* clear software interrupts */
+	stv0297_writeregI(state, CTRL_2, 0x00);
+
+/* set initial demodulation frequency */
+	stv0297_set_initdemod(state, 0);
+/* setup AGC */
+	stv0297_writeregI(state, WBAGC_3, 0x00);
+/* Wide Band AGC agc2sd initialisation: mid-range */
+	stv0297_writeregI(state, WBAGC_1, 0x00);
+//	stv0297_writereg_maskI(state, WBAGC_2, 0x03, 0x01);
+/* Wide Band AGC1&AGC2 nofreeze */
+	stv0297_writereg_maskI(state, DELAGC_6, 0x7f, 0x00);
+/* PMF AGC accumulator reset */
+	stv0297_writereg_maskI(state, PMFAGC_1, 0x80, 0x80);
+	stv0297_writeregI(state, PMFAGC_2, 0x00);
+	stv0297_writeregI(state, PMFAGC_3, 0x00);
+	stv0297_writereg_maskI(state, PMFAGC_4, 0x7f, 0x00);
+/* Force AGC ACQ low */
+	stv0297_writereg_maskI(state, WBAGC_3, 0x08, 0x00);
+/* Disable unlock forcing. */
+	stv0297_writereg_maskI(state, PMFAGC_1, 0x80, 0x00);
+/* setup STL
+ * Phase clear */
+	stv0297_writereg_maskI(state, ST_LOOP10, 0x20, 0x20);
+/* STL integral path clear */
+	stv0297_writereg_maskI(state, ST_LOOP11, 0x02, 0x02);
+/* STL integral path clear release */
+	stv0297_writereg_maskI(state, ST_LOOP11, 0x02, 0x00);
+/* integral path enabled only */
+	stv0297_writereg_maskI(state, ST_LOOP11, 0x01, 0x00);
+/* direct path immediatly enabled */
+	stv0297_writereg_maskI(state, ST_LOOP10, 0x40, 0x40);
+/* disable frequency sweep */
+	stv0297_writereg_maskI(state, CRL_10, 0x01, 0x00);
+/* reset deinterleaver */
+	stv0297_writereg_maskI(state, CTRL_1, 0x01, 0x01);
+	stv0297_writereg_maskI(state, CTRL_1, 0x01, 0x00);
+/* ??? */
+	stv0297_writereg_maskI(state, CTRL_3, 0x20, 0x20);
+	stv0297_writereg_maskI(state, CTRL_3, 0x20, 0x00);
+/* Reed-Salomon clear */
+	stv0297_writereg_maskI(state, CTRL_3, 0x10, 0x10);
+	stv0297_writereg_maskI(state, CTRL_3, 0x10, 0x00);
+/* Equalizer values capture */
+	stv0297_readregsI(state, EQU_0, equ_save, 2);
+/* reset equalizer */
+	stv0297_writereg_maskI(state, CTRL_4, 0x01, 0x01);
+	stv0297_writereg_maskI(state, CTRL_4, 0x01, 0x00);
+/* Equalizer values restore */
+	stv0297_writeregsI(state, EQU_0, equ_save, 2);
+/* data comes from internal A/D */
+	stv0297_writereg_maskI(state, CTRL_7, 0x80, 0x00);
+
+/* set parameters */
+	stv0297_set_modulation(state, p->u.qam.modulation);
+	stv0297_set_symbolrate(state, p->u.qam.symbol_rate);
+	stv0297_set_crl(state, p, -130000);
+	stv0297_set_inversion(state, inversion);
+
+	stv0297_writereg_maskI(state, EQU_0, 0x0f, 0x09);
+	stv0297_writeregI(state, EQU_1, 0x69);
+
+/* only disable corner detection for QAM256 and QAM128, otherwise, enable it */
+	if (p->u.qam.modulation == QAM_256 ||
+		p->u.qam.modulation == QAM_128)
+		stv0297_writereg_maskI(state, CTRL_8, 0x08, 0x00);
+	else
+		stv0297_writereg_maskI(state, CTRL_8, 0x08, 0x08);
+
+/* Phase clear release */
+	stv0297_writereg_maskI(state, ST_LOOP10, 0x20, 0x00);
+
+/* Sweep Enable */
+	stv0297_writereg_maskI(state, CRL_10, 0x01, 0x01);
+	msleep(10);
+/*  Clear wide band AGC */
+	stv0297_writereg_maskI(state, WBAGC_3, 0x40, 0x40);
+
+/* enable wide band AGC */
+	stv0297_writereg_maskI(state, WBAGC_3, 0x10, WAGC_EN);
+
+	deb_info("initialized - waiting for the locks now\n");
+
+	/* wait for WBAGC lock */
+	deb_info("waiting for WBAGC lock\n");
+	try(stv0297_readregI(state, WBAGC_3) & 0x08, 200, 10);
+	if (i == 200)
+		goto timeout;
+	deb_info("WBAGC has lock\n");
+	msleep(20);
+
+	/* wait for equalizer 1 lock */
+	deb_info("waiting for equalizer 1 lock\n");
+	try(stv0297_readregI(state, CTRL_2) & 0x04, 400, 10);
+	if (i == 400)
+		goto timeout;
+	deb_info("equalizer 1 has lock\n");
+
+	/* wait for equalizer 2 lock and if it's stable */
+	deb_info("waiting for equalizer 2 lock\n");
+	try(stv0297_readregI(state, CTRL_2) & 0x08, 200, 10);
+	if (i == 200)
+		goto timeout;
+
+	deb_info("equalizer 2 has lock\n");
+	msleep(20);
+	if (!(stv0297_readregI(state, CTRL_2) & 0x08))
+		goto timeout;
+	deb_info("equalizer 2 is stable\n");
+
+	/* we have modulation, do we have data */
+	deb_info("waiting for data lock\n");
+	try(stv0297_readregI(state,RS_DESC_15) & 0x80,5,10);
+	if (i == 5) { /* try to invert the inversion during the next run */
+		deb_info("no data lock achieved, trying to invert the spectrum in the next run.\n");
+		state->invert = !state->invert;
+		goto timeout;
+	}
+	deb_info("we have data lock\n");
+
+/*  Turn off corner detection */
+	stv0297_writereg_maskI(state, CTRL_8,0x08, 0x00);
+	/* success!! */
+	state->base_freq = p->frequency;
+	return 0;
+
+timeout:
+	deb_info("timed out\n");
+	stv0297_writereg_maskI(state, CRL_10, 0x01, 0x00);
+	return 0;
+}
+
+static int stv0297_get_frontend(struct dvb_frontend *fe, struct dvb_frontend_parameters *p)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+	int reg_00, reg_83;
+
+	reg_00 = stv0297_readregI(state, EQU_0);
+	reg_83 = stv0297_readregI(state, CTRL_3);
+
+	p->frequency = state->base_freq;
+
+	if (reg_83 & 0x08)
+		p->inversion = INVERSION_ON;
+	else
+		p->inversion = INVERSION_OFF;
+
+	p->u.qam.symbol_rate = stv0297_get_symbolrate(state);
+	p->u.qam.fec_inner = FEC_NONE;
+
+	switch (reg_00 & 0x70) {
+		case STV0297_QAM16:
+			p->u.qam.modulation = QAM_16;
+			break;
+		case STV0297_QAM32:
+			p->u.qam.modulation = QAM_32;
+			break;
+		case STV0297_QAM128:
+			p->u.qam.modulation = QAM_128;
+			break;
+		case STV0297_QAM256:
+			p->u.qam.modulation = QAM_256;
+			break;
+		case STV0297_QAM64:
+			p->u.qam.modulation = QAM_64;
+			break;
+	}
+
+	return 0;
+}
+
+static int stv0297_sleep(struct dvb_frontend *fe)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+	deb_info("stv0297 is going to bed.\n");
+
+	stv0297_writereg_maskI(state, CTRL_0, 1, 1);
+
+	return 0;
+}
+
+static int stv0297_read_status(struct dvb_frontend *fe, fe_status_t * status)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+	u8 ctrl_2 = stv0297_readregI(state, CTRL_2);
+	*status = 0;
+
+/* The following status assignments are only guesses, but we wanted to have a
+ * kind of grade here */
+
+	if (stv0297_readregI(state, WBAGC_3) & 0x08)
+		*status |= FE_HAS_SIGNAL;
+
+	if (ctrl_2 & 0x04)
+		 *status |= FE_HAS_CARRIER;
+
+	if (ctrl_2 & 0x08)
+		*status |= FE_HAS_VITERBI;
+
+	if (stv0297_readregI(state, RS_DESC_15) & 0x80)
+		*status |= FE_HAS_SYNC | FE_HAS_LOCK;
+
+	return 0;
+}
+
+static int stv0297_read_signal_strength(struct dvb_frontend *fe, u16 * strength)
+{
+	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	u8 STRENGTH[2];
+
+	stv0297_readregsI(state, WBAGC_1, STRENGTH, 2);
+	*strength = (STRENGTH[1] & 0x03) << 8 | STRENGTH[0];
+
+	return 0;
+}
+
+static int stv0297_read_snr(struct dvb_frontend *fe, u16 * snr)
+{
+	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	u8 SNR[2];
+
+	stv0297_readregsI(state, EQU_7, SNR, 2);
+	*snr = SNR[1] << 8 | SNR[0];
+
+	return 0;
+}
+
+static int stv0297_read_ber(struct dvb_frontend *fe, u32 * ber)
+{
+	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+	u8 BER[3];
+	*ber = 0;
+
+	stv0297_readregsI(state, BERT_0, BER, 3);
+	if (!(BER[0] & 0x80)) {
+		state->lastber = (BER[0] & 0x07 << 16) | (BER[2] << 8) | BER[1];
+		/* reset the BER counter */
+		BER[0] |= 0x80;
+		BER[1] = BER[2] = 0x00;
+		stv0297_writeregsI(state, BERT_0, BER, 3);
+	}
+	*ber = state->lastber;
+
+	return 0;
+}
+
+static int stv0297_read_ucblocks(struct dvb_frontend *fe, u32 * ucblocks)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+	u8 block_count[6];
+
+	stv0297_writeregI(state,RS_DESC_15,0x03); /* freeze the counters */
+	stv0297_readregsI(state,RS_DESC_0,block_count,6);
+	stv0297_writeregI(state,RS_DESC_15,0x02); /* clear the counters */
+	stv0297_writeregI(state,RS_DESC_15,0x01); /* re-enable the counters */
+
+/*	LastBlockCount          = (block_count[1] << 8) | block_count[0]; */
+/*	LastCorrectedBlockCount = (block_count[3] << 8) | block_count[2]; */
+	*ucblocks               = (block_count[5] << 8) | block_count[4];
+	return 0;
+}
+
+static void stv0297_release(struct dvb_frontend *fe)
+{
+	struct stv0297_state *state = fe->demodulator_priv;
+	kfree(state);
+}
+
+static struct dvb_frontend_ops stv0297_ops;
+
+struct dvb_frontend *stv0297_cs2_attach(const struct stv0297_config *config,
+				    struct i2c_adapter *i2c)
+{
+	struct stv0297_state *state = NULL;
+
+	/* allocate memory for the internal state */
+	state = kmalloc(sizeof(struct stv0297_state), GFP_KERNEL);
+	if (state == NULL)
+		goto error;
+
+	/* setup the state */
+	state->config = config;
+	state->i2c = i2c;
+	memcpy(&state->ops, &stv0297_ops, sizeof(struct dvb_frontend_ops));
+	state->base_freq = 0;
+
+	/* check if the demod is there */
+	if ((stv0297_readregI(state, CTRL_0) & 0x70) != 0x20)
+		goto error;
+
+	/* create dvb_frontend */
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+	return &state->frontend;
+
+error:
+	kfree(state);
+	return NULL;
+}
+
+static struct dvb_frontend_ops stv0297_ops = {
+
+	.info = {
+		 .name = "ST STV0297 DVB-C",
+		 .type = FE_QAM,
+		 .frequency_min = 64000000,
+		 .frequency_max = 1300000000,
+		 .frequency_stepsize = 62500,
+		 .symbol_rate_min = 870000,
+		 .symbol_rate_max = 11700000,
+		 .caps = FE_CAN_QAM_16 | FE_CAN_QAM_32 | FE_CAN_QAM_64 |
+		 FE_CAN_QAM_128 | FE_CAN_QAM_256 | FE_CAN_FEC_AUTO},
+
+	.release = stv0297_release,
+
+	.init = stv0297_init,
+	.sleep = stv0297_sleep,
+
+	.set_frontend = stv0297_set_frontend,
+	.get_frontend = stv0297_get_frontend,
+
+	.read_status = stv0297_read_status,
+	.read_ber = stv0297_read_ber,
+	.read_signal_strength = stv0297_read_signal_strength,
+	.read_snr = stv0297_read_snr,
+	.read_ucblocks = stv0297_read_ucblocks,
+};
+
+MODULE_DESCRIPTION("ST STV0297 DVB-C Demodulator driver");
+MODULE_AUTHOR("Dennis Noermann, Andrew de Quincey and Patrick Boettcher");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+
+EXPORT_SYMBOL(stv0297_cs2_attach);
+EXPORT_SYMBOL(stv0297_cs2_enable_plli2c);
--- /dev/null
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/stv0297_cs2.h
@@ -0,0 +1,51 @@
+/*
+    Driver for STV0297 demodulator
+
+    Copyright (C) 2003-2004 Dennis Noermann <dennis.noermann@noernet.de>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+
+#ifndef STV0297_H
+#define STV0297_H
+
+#include <linux/dvb/frontend.h>
+#include "dvb_frontend.h"
+
+#define STV0297_NTSC_FCLK            33868800UL
+#define STV0297_NTSC_IF              43750000UL
+
+#define STV0297_PAL_FCLK             28900000UL
+#define STV0297_PAL_IF               36125000UL
+
+struct stv0297_config
+{
+	/* the demodulator's i2c address */
+	u8 demod_address;
+
+	/* clocks in Hz */
+	u32 fclk;
+	u32 demodfreq;
+
+	/* PLL maintenance */
+	int (*pll_init)(struct dvb_frontend* fe);
+	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
+};
+
+extern struct dvb_frontend* stv0297_cs2_attach(const struct stv0297_config* config,
+					   struct i2c_adapter* i2c);
+extern int stv0297_cs2_enable_plli2c(struct dvb_frontend* fe);
+
+#endif // STV0297_H
--- /dev/null
+++ linux-2.6.14-git3/drivers/media/dvb/b2c2/stv0297_priv.h
@@ -0,0 +1,154 @@
+/*
+ * Driver for the DVB-C STV0297 demodulator - chip stuff
+ *
+ *  Copyright (C) 2005 Patrick Boettcher <patrick.boettcher@desy.de>
+ *
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License as published by the Free
+ *  Software Foundation; either version 2 of the License, or (at your option)
+ *  any later version.
+ *
+ *  This program is distributed in the hope that it will be useful, but WITHOUT
+ *  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ *  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ *  more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc., 675
+ *  Mass Ave, Cambridge, MA 02139, USA.
+ */
+#ifndef __STV0297_PRIV_INCLUDED__
+#define __STV0297_PRIV_INCLUDED__
+
+enum stv0297_registers {
+	EQU_0			= 0x00,
+	EQU_1,
+	EQU_2,
+	EQU_3,
+	EQU_4,
+	EQU_5,
+	EQU_6,
+	EQU_7,
+	EQU_8,
+	INITDEM_0		= 0x20,
+	INITDEM_1,
+	INITDEM_2,
+	INITDEM_3,
+	INITDEM_4,
+	INITDEM_5,
+	DELAGC_0		= 0x30,
+	DELAGC_1,
+	DELAGC_2,
+	DELAGC_3,
+	DELAGC_4,
+	DELAGC_5,
+	DELAGC_6,
+	DELAGC_7,
+	DELAGC_8,
+	DELAGC_BLK_LEN  = 1+DELAGC_8-DELAGC_0,
+	WBAGC_0			= 0x40,
+	WBAGC_1,
+	WBAGC_2,
+	WBAGC_3,
+	WBAGC_4,
+	WBAGC_5,
+	WBAGC_6,
+	WBAGC_7,
+	WBAGC_8,
+	WBAGC_9,
+	WBAGC_10,
+	WBAGC_11,
+	WBAGC_BLK_LEN   = 1+WBAGC_11-WBAGC_0,
+	ST_LOOP2		= 0x52,
+	ST_LOOP3,
+	ST_LOOP4,  // Not used.
+	ST_LOOP5,
+	ST_LOOP6,
+	ST_LOOP7,
+	ST_LOOP8,
+	ST_LOOP9,
+	ST_LOOP10,
+	ST_LOOP11,
+	CRL_0			= 0x60,
+	CRL_1,
+	CRL_2,
+	CRL_3,
+	CRL_4,
+	CRL_5,
+	CRL_6,
+	CRL_7,
+	CRL_8,
+	CRL_9,
+	CRL_10,
+	CRL_11,
+	PMFAGC_0		= 0x70,
+	PMFAGC_1,
+	PMFAGC_2,
+	PMFAGC_3,
+	PMFAGC_4,
+	CTRL_0			= 0x80,
+	CTRL_1,
+	CTRL_2,
+	CTRL_3,
+	CTRL_4,
+	CTRL_5,
+	CTRL_6,
+	CTRL_7,
+	CTRL_8,
+	CTRL_9,
+	DEINT_SYNC_0	= 0x90,
+	DEINT_SYNC_1,
+	BERT_0			= 0xA0,
+	BERT_1,
+	BERT_2,
+	DEINT_0			= 0xB0,
+	DEINT_1,
+	DEINT_2,
+	DEINT_3,
+	OUTFORMAT_0		= 0xC0,
+	OUTFORMAT_1,
+	OUTFORMAT_2,
+	RS_DESC_0		= 0xD0,
+	RS_DESC_1,
+	RS_DESC_2,
+	RS_DESC_3,
+	RS_DESC_4,
+	RS_DESC_5,
+	RS_DESC_14		=0xDE,
+	RS_DESC_15
+};
+
+enum {
+	WAGC_EN			= 0x10,
+	STV0297_QAM16	= 0x00,
+	STV0297_QAM32	= 0x10,
+	STV0297_QAM64	= 0x40,
+	STV0297_QAM128	= 0x20,
+	STV0297_QAM256	= 0x30,
+	STV0297_CLEARQAM = ~0x70
+};
+
+#define AGC2MAX			DELAGC_0
+#define AGC2MIN			DELAGC_1
+#define AGC1MAX			DELAGC_2
+#define AGC1MIN			DELAGC_3
+#define AGC2_THRESH		DELAGC_5
+
+#define NO_AGC_FREEZE	0x80
+#define SOFT_AGC_FREEZE	0x28
+
+#define SPECTRAL_INVERSION_TOGGLE 0x08
+
+#define MINIMUM_SYMBOL_RATE_IN_BAUD       1000000UL
+#define MAXIMUM_SYMBOL_RATE_IN_BAUD       7000000UL
+#define MAXIMUM_NTSC_SYMBOL_RATE          5300000UL
+
+#define MINIMUM_FREQUENCY_IN_KHz         48000000UL
+#define MAXIMUM_FREQUENCY_IN_KHz        860000000UL
+
+/* Set to an invalid, non-zero figure. */
+#define INITIAL_SYMBOL_RATE MAXIMUM_SYMBOL_RATE_IN_BAUD+1
+
+#define TOGGLE_MASK 0x03
+
+#endif


--------------050002000708090104000204--
