Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVAVSIU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVAVSIU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 13:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAVSIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 13:08:19 -0500
Received: from ipx10786.ipxserver.de ([80.190.251.108]:5074 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262357AbVAVRc5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 12:32:57 -0500
Cc: linux-kernel@vger.kernel.org, js@linuxtv.org
In-Reply-To: <1106415266247@linuxtv.org>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Sat, 22 Jan 2005 18:34:32 +0100
Message-Id: <1106415272187@linuxtv.org>
Mime-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
From: Johannes Stezenbach <js@linuxtv.org>
X-SA-Exim-Connect-IP: 217.231.47.99
Subject: [PATCH 7/9] nxt2002: add ATSC support, misc fixes
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] mt352: exported a mt352_read_reg-function, implemented a single byte
        write_register function (needed for dibusb)
- [DVB] nxt2002: patch by Taylor Jacob to add support for ATSC/VSB frontends
        and the B2C2/BBTI Air2PC-ATSC card
- [DVB] stv0297: fix tuning problems and compile time warnings, patch by Markus Breitenberger
- [DVB] fix spelling errors in various frontend drivers

Signed-off-by: Michael Hunold <hunold@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/mt352.c linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/mt352.c
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/mt352.c	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/mt352.c	2005-01-20 19:56:38.000000000 +0100
@@ -58,16 +58,26 @@
 		if (debug) printk(KERN_DEBUG "mt352: " args); \
 } while (0)
 
-int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen)
+static int mt352_single_write(struct dvb_frontend *fe, u8 reg, u8 val)
 {
 	struct mt352_state* state = (struct mt352_state*) fe->demodulator_priv;
+	u8 buf[2] = { reg, val };
 	struct i2c_msg msg = { .addr = state->config->demod_address, .flags = 0,
-			       .buf = ibuf, .len = ilen };
+			       .buf = buf, .len = 2 };
 	int err = i2c_transfer(state->i2c, &msg, 1);
 	if (err != 1) {
-		dprintk("mt352_write() failed (err = %d)!\n", err);
+		dprintk("mt352_write() to reg %x failed (err = %d)!\n", reg, err);
 		return err;
 }
+	return 0; 
+}
+
+int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen)
+{
+	int err,i;
+	for (i=0; i < ilen-1; i++)
+		if ((err = mt352_single_write(fe,ibuf[0]+i,ibuf[i+1]))) 
+			return err;
 
 	return 0;
 }
@@ -92,9 +102,10 @@
 	return b1[0];
 }
 
-
-
-
+u8 mt352_read(struct dvb_frontend *fe, u8 reg)
+{
+	return mt352_read_register(fe->demodulator_priv,reg);
+}
 
 
 
@@ -556,3 +567,4 @@
 
 EXPORT_SYMBOL(mt352_attach);
 EXPORT_SYMBOL(mt352_write);
+EXPORT_SYMBOL(mt352_read);
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/mt352.h linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/mt352.h
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/mt352.h	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/mt352.h	2005-01-20 19:56:38.000000000 +0100
@@ -54,5 +54,6 @@
 					 struct i2c_adapter* i2c);
 
 extern int mt352_write(struct dvb_frontend* fe, u8* ibuf, int ilen);
+extern u8 mt352_read(struct dvb_frontend *fe, u8 reg);
 
 #endif // MT352_H
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/nxt2002.c linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/nxt2002.c
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/nxt2002.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/nxt2002.c	2004-12-16 16:45:54.000000000 +0100
@@ -0,0 +1,670 @@
+/*
+    Support for B2C2/BBTI Technisat Air2PC - ATSC  
+
+    Copyright (C) 2004 Taylor Jacob <rtjacob@earthlink.net>
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
+
+*/
+
+/*
+ * This driver needs external firmware. Please use the command
+ * "<kerneldir>/Documentation/dvb/get_dvb_firmware nxt2002" to
+ * download/extract it, and then copy it to /usr/lib/hotplug/firmware.
+ */
+#define NXT2002_DEFAULT_FIRMWARE "dvb-fe-nxt2002.fw"
+#define CRC_CCIT_MASK 0x1021
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/device.h>
+#include <linux/firmware.h>
+
+#include "dvb_frontend.h"
+#include "nxt2002.h"
+
+struct nxt2002_state {
+
+	struct i2c_adapter* i2c;
+	struct dvb_frontend_ops ops;
+	const struct nxt2002_config* config;
+	struct dvb_frontend frontend;
+
+	/* demodulator private data */
+	u8 initialised:1;
+};
+
+static int debug;
+#define dprintk(args...) \
+	do { \
+		if (debug) printk(KERN_DEBUG "nxt2002: " args); \
+	} while (0)
+
+static int i2c_writebytes (struct nxt2002_state* state, u8 reg, u8 *buf, u8 len)
+{
+	/* probbably a much better way or doing this */
+	u8 buf2 [256],x;
+	int err;
+	struct i2c_msg msg = { .addr = state->config->demod_address, .flags = 0, .buf = buf2, .len = len + 1 };
+       
+	buf2[0] = reg;
+	for (x = 0 ; x < len ; x++)
+		buf2[x+1] = buf[x];
+
+	if ((err = i2c_transfer (state->i2c, &msg, 1)) != 1) {
+		printk ("%s: i2c write error (addr %02x, err == %i)\n",
+			__FUNCTION__, state->config->demod_address, err);
+		return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+static u8 i2c_readbytes (struct nxt2002_state* state, u8 reg, u8* buf, u8 len)
+{
+	u8 reg2 [] = { reg };
+
+	struct i2c_msg msg [] = { { .addr = state->config->demod_address, .flags = 0, .buf = reg2, .len = 1 },
+			{ .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = buf, .len = len } };
+
+	int err;
+
+	if ((err = i2c_transfer (state->i2c, msg, 2)) != 2) {
+		printk ("%s: i2c read error (addr %02x, err == %i)\n",
+			__FUNCTION__, state->config->demod_address, err);
+		return -EREMOTEIO;
+	}
+
+	return 0;
+}
+
+static u16 nxt2002_crc(u16 crc, u8 c) 
+{
+
+	u8 i;
+	u16 input = (u16) c & 0xFF;
+  
+	input<<=8;
+	for(i=0 ;i<8 ;i++) {
+		if((crc ^ input) & 0x8000)
+			crc=(crc<<1)^CRC_CCIT_MASK;
+		else
+			crc<<=1;
+	input<<=1;
+	}
+	return crc;
+}
+
+static int nxt2002_writereg_multibyte (struct nxt2002_state* state, u8 reg, u8* data, u8 len)
+{
+	u8 buf;
+	dprintk("%s\n", __FUNCTION__);
+
+	/* set multi register length */
+	i2c_writebytes(state,0x34,&len,1);
+
+	/* set mutli register register */
+	i2c_writebytes(state,0x35,&reg,1);
+
+	/* send the actual data */
+	i2c_writebytes(state,0x36,data,len);
+
+	/* toggle the multireg write bit*/
+	buf = 0x02;
+	i2c_writebytes(state,0x21,&buf,1);
+
+	i2c_readbytes(state,0x21,&buf,1);
+
+	if ((buf & 0x02) == 0)
+		return 0;
+ 
+	dprintk("Error writing multireg register %02X\n",reg);
+
+	return 0;
+}
+
+static int nxt2002_readreg_multibyte (struct nxt2002_state* state, u8 reg, u8* data, u8 len)
+{
+	u8 len2;
+	dprintk("%s\n", __FUNCTION__);
+
+	/* set multi register length */
+	len2 = len & 0x80;
+	i2c_writebytes(state,0x34,&len2,1);
+
+	/* set mutli register register */
+	i2c_writebytes(state,0x35,&reg,1);
+
+	/* send the actual data */
+	i2c_readbytes(state,reg,data,len);
+
+	return 0;
+}
+
+static void nxt2002_microcontroller_stop (struct nxt2002_state* state)
+{
+	u8 buf[2],counter = 0;
+	dprintk("%s\n", __FUNCTION__);
+
+	buf[0] = 0x80;
+	i2c_writebytes(state,0x22,buf,1);
+
+	while (counter < 20) { 
+		i2c_readbytes(state,0x31,buf,1);
+		if (buf[0] & 0x40) 
+			return;
+		msleep(10);
+		counter++;
+	}
+
+	dprintk("Timeout waiting for micro to stop.. This is ok after firmware upload\n");
+	return; 
+}
+
+static void nxt2002_microcontroller_start (struct nxt2002_state* state)
+{
+	u8 buf;
+	dprintk("%s\n", __FUNCTION__);
+
+	buf = 0x00;
+	i2c_writebytes(state,0x22,&buf,1);
+}
+
+static int nxt2002_writetuner (struct nxt2002_state* state, u8* data)
+{
+	u8 buf,count = 0;
+
+	dprintk("Tuner Bytes: %02X %02X %02X %02X\n",data[0],data[1],data[2],data[3]);
+
+	dprintk("%s\n", __FUNCTION__);
+	/* stop the micro first */
+	nxt2002_microcontroller_stop(state);
+
+	/* set the i2c transfer speed to the tuner */
+	buf = 0x03;
+	i2c_writebytes(state,0x20,&buf,1);
+
+	/* setup to transfer 4 bytes via i2c */
+	buf = 0x04;
+	i2c_writebytes(state,0x34,&buf,1);
+
+	/* write actual tuner bytes */
+	i2c_writebytes(state,0x36,data,4);
+
+	/* set tuner i2c address */
+	buf = 0xC2;
+	i2c_writebytes(state,0x35,&buf,1);
+
+	/* write UC Opmode to begin transfer */
+	buf = 0x80;
+	i2c_writebytes(state,0x21,&buf,1);
+ 
+	while (count < 20) {
+		i2c_readbytes(state,0x21,&buf,1);
+		if ((buf & 0x80)== 0x00)
+			return 0;
+		msleep(100);
+		count++;
+	}
+
+	printk("nxt2002: timeout error writing tuner\n");
+	return 0;
+}
+
+static void nxt2002_agc_reset(struct nxt2002_state* state)
+{
+	u8 buf;
+	dprintk("%s\n", __FUNCTION__);
+
+	buf = 0x08;
+	i2c_writebytes(state,0x08,&buf,1);
+
+	buf = 0x00;
+	i2c_writebytes(state,0x08,&buf,1);
+
+	return;
+}
+
+static int nxt2002_load_firmware (struct dvb_frontend* fe, const struct firmware *fw)
+{
+
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	u8 buf[256],written = 0,chunkpos = 0;
+	u16 rambase,position,crc = 0;  
+
+	dprintk("%s\n", __FUNCTION__);
+	dprintk("Firmware is %d bytes\n",fw->size);
+
+	/* Get the RAM base for this nxt2002 */
+	i2c_readbytes(state,0x10,buf,1);
+
+	
+	if (buf[0] & 0x10)
+		rambase = 0x1000;
+	else
+		rambase = 0x0000;
+
+	dprintk("rambase on this nxt2002 is %04X\n",rambase);
+
+	/* Hold the micro in reset while loading firmware */
+	buf[0] = 0x80;
+	i2c_writebytes(state,0x2B,buf,1);
+
+        
+	for (position = 0; position < fw->size ; position++) {
+		if (written == 0) {
+			crc = 0;
+			chunkpos = 0x28;
+			buf[0] = ((rambase + position) >> 8);
+			buf[1] = (rambase + position) & 0xFF;
+			buf[2] = 0x81;
+			/* write starting address */
+			i2c_writebytes(state,0x29,buf,3);
+		}
+		written++;          
+		chunkpos++;
+
+		if ((written % 4) == 0)
+			i2c_writebytes(state,chunkpos,&fw->data[position-3],4);
+
+		crc = nxt2002_crc(crc,fw->data[position]);
+
+            
+		if ((written == 255) || (position+1 == fw->size)) {
+			/* write remaining bytes of firmware */
+			i2c_writebytes(state, chunkpos+4-(written %4),
+				&fw->data[position-(written %4) + 1],
+				written %4);
+			buf[0] = crc << 8;
+			buf[1] = crc & 0xFF;
+               
+			/* write crc */
+			i2c_writebytes(state,0x2C,buf,2);
+
+			/* do a read to stop things */
+			i2c_readbytes(state,0x2A,buf,1);
+
+			/* set transfer mode to complete */
+			buf[0] = 0x80;
+			i2c_writebytes(state,0x2B,buf,1);
+
+			written = 0;
+		}
+	}
+
+	printk ("done.\n");
+	return 0;
+};
+
+
+static int nxt2002_setup_frontend_parameters (struct dvb_frontend* fe,
+					     struct dvb_frontend_parameters *p)
+{
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	u32 freq = 0;
+	u16 tunerfreq = 0; 
+	u8 buf[4];
+
+	freq = 44000 + ( p->frequency / 1000 ); 
+
+	dprintk("freq = %d      p->frequency = %d\n",freq,p->frequency);
+
+	tunerfreq = freq * 24/4000;
+ 
+	buf[0] = (tunerfreq >> 8) & 0x7F;
+	buf[1] = (tunerfreq & 0xFF);
+        
+	if (p->frequency <= 214000000) {
+		buf[2] = 0x84 + (0x06 << 3);
+		buf[3] = (p->frequency <= 172000000) ? 0x01 : 0x02;
+	} else if (p->frequency <= 721000000) {
+		buf[2] = 0x84 + (0x07 << 3);
+		buf[3] = (p->frequency <= 467000000) ? 0x02 : 0x08;
+	} else if (p->frequency <= 841000000) {
+		buf[2] = 0x84 + (0x0E << 3);
+		buf[3] = 0x08;
+	} else {
+		buf[2] = 0x84 + (0x0F << 3);         
+		buf[3] = 0x02;
+	}
+
+	/* write frequency information */
+	nxt2002_writetuner(state,buf);
+
+	/* reset the agc now that tuning has been completed */
+	nxt2002_agc_reset(state);
+
+	/* set target power level */
+	buf[0] = 0x70;
+	i2c_writebytes(state,0x42,buf,1);
+
+	/* configure sdm */
+	buf[0] = 0x87;
+	i2c_writebytes(state,0x57,buf,1);
+
+	/* write sdm1 input */
+	buf[0] = 0x10;
+	buf[1] = 0x00;
+	nxt2002_writereg_multibyte(state,0x58,buf,2);
+
+	/* write sdmx input */
+	buf[0] = 0x60;
+	buf[1] = 0x00;
+	nxt2002_writereg_multibyte(state,0x5C,buf,2);
+
+	/* write adc power lpf fc */
+	buf[0] = 0x05;
+	i2c_writebytes(state,0x43,buf,1);
+
+	/* write adc power lpf fc */
+	buf[0] = 0x05;
+	i2c_writebytes(state,0x43,buf,1);
+
+	/* write accumulator2 input */
+	buf[0] = 0x80;
+	buf[1] = 0x00;
+	nxt2002_writereg_multibyte(state,0x4B,buf,2);
+
+	/* write kg1 */
+	buf[0] = 0x00;
+	i2c_writebytes(state,0x4D,buf,1);
+
+	/* write sdm12 lpf fc */
+	buf[0] = 0x44;
+	i2c_writebytes(state,0x55,buf,1);
+
+	/* write agc control reg */
+	buf[0] = 0x04;
+	i2c_writebytes(state,0x41,buf,1);
+
+	/* write agc ucgp0 */
+	buf[0] = 0x00;
+	i2c_writebytes(state,0x30,buf,1);
+
+	/* write agc control reg */
+	buf[0] = 0x00;
+	i2c_writebytes(state,0x41,buf,1);
+
+	/* write accumulator2 input */
+	buf[0] = 0x80;
+	buf[1] = 0x00;
+	nxt2002_writereg_multibyte(state,0x49,buf,2);
+	nxt2002_writereg_multibyte(state,0x4B,buf,2);
+
+	/* write agc control reg */
+	buf[0] = 0x04;
+	i2c_writebytes(state,0x41,buf,1);
+
+	nxt2002_microcontroller_start(state);
+
+	/* adjacent channel detection should be done here, but I don't 
+	have any stations with this need so I cannot test it */
+
+	return 0;
+}
+
+static int nxt2002_read_status(struct dvb_frontend* fe, fe_status_t* status)
+{
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	u8 lock;
+	i2c_readbytes(state,0x31,&lock,1);
+
+	*status = 0;
+	if (lock & 0x20) {
+		*status |= FE_HAS_SIGNAL;
+		*status |= FE_HAS_CARRIER;
+		*status |= FE_HAS_VITERBI;
+		*status |= FE_HAS_SYNC;                
+		*status |= FE_HAS_LOCK;
+	}
+	return 0;
+}
+
+static int nxt2002_read_ber(struct dvb_frontend* fe, u32* ber)
+{
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	u8 b[3];
+
+	nxt2002_readreg_multibyte(state,0xE6,b,3);        
+
+	*ber = ((b[0] << 8) + b[1]) * 8;
+ 
+	return 0;
+}
+
+static int nxt2002_read_signal_strength(struct dvb_frontend* fe, u16* strength)
+{
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	u8 b[2];
+	u16 temp = 0;
+
+	/* setup to read cluster variance */
+	b[0] = 0x00;
+	i2c_writebytes(state,0xA1,b,1);
+
+	/* get multreg val */
+	nxt2002_readreg_multibyte(state,0xA6,b,2);        
+
+	temp = (b[0] << 8) | b[1];
+	*strength = ((0x7FFF - temp) & 0x0FFF) * 16;
+
+	return 0;
+}
+
+static int nxt2002_read_snr(struct dvb_frontend* fe, u16* snr)
+{
+
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	u8 b[2];
+	u16 temp = 0, temp2;
+	u32 snrdb = 0;
+
+	/* setup to read cluster variance */
+	b[0] = 0x00;
+	i2c_writebytes(state,0xA1,b,1);
+
+	/* get multreg val from 0xA6 */
+	nxt2002_readreg_multibyte(state,0xA6,b,2);        
+
+	temp = (b[0] << 8) | b[1];
+	temp2 = 0x7FFF - temp;
+
+	/* snr will be in db */
+	if (temp2 > 0x7F00)
+		snrdb = 1000*24 + ( 1000*(30-24) * ( temp2 - 0x7F00 ) / ( 0x7FFF - 0x7F00 ) );
+	else if (temp2 > 0x7EC0)
+		snrdb = 1000*18 + ( 1000*(24-18) * ( temp2 - 0x7EC0 ) / ( 0x7F00 - 0x7EC0 ) );
+	else if (temp2 > 0x7C00)
+		snrdb = 1000*12 + ( 1000*(18-12) * ( temp2 - 0x7C00 ) / ( 0x7EC0 - 0x7C00 ) );
+	else
+		snrdb = 1000*0 + ( 1000*(12-0) * ( temp2 - 0 ) / ( 0x7C00 - 0 ) );
+
+        /* the value reported back from the frontend will be FFFF=32db 0000=0db */
+
+	*snr = snrdb * (0xFFFF/32000);
+
+	return 0;
+}
+
+static int nxt2002_read_ucblocks(struct dvb_frontend* fe, u32* ucblocks)
+{
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	u8 b[3];
+ 
+	nxt2002_readreg_multibyte(state,0xE6,b,3);
+
+	*ucblocks = b[2];
+
+	return 0;
+}
+
+static int nxt2002_sleep(struct dvb_frontend* fe)
+{
+	return 0;
+}
+
+static int nxt2002_init(struct dvb_frontend* fe)
+{
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	const struct firmware *fw;
+	int ret;
+	u8 buf[2];
+
+	if (!state->initialised) {
+		/* request the firmware, this will block until someone uploads it */
+		printk("nxt2002: Waiting for firmware upload...\n");
+		ret = state->config->request_firmware(fe, &fw, NXT2002_DEFAULT_FIRMWARE);
+		printk("nxt2002: Waiting for firmware upload(2)...\n");
+		if (ret) {
+			printk("nxt2002: no firmware upload (timeout or file not found?)\n");
+			return ret;
+		}
+
+		ret = nxt2002_load_firmware(fe, fw);
+		if (ret) {
+			printk("nxt2002: writing firmware to device failed\n");
+			release_firmware(fw);
+			return ret;
+		}
+
+		/* Put the micro into reset */
+		nxt2002_microcontroller_stop(state);
+ 
+		/* ensure transfer is complete */
+		buf[0]=0;
+		i2c_writebytes(state,0x2B,buf,1);
+
+		/* Put the micro into reset for real this time */
+		nxt2002_microcontroller_stop(state);
+
+		/* soft reset everything (agc,frontend,eq,fec)*/
+		buf[0] = 0x0F;
+		i2c_writebytes(state,0x08,buf,1);
+		buf[0] = 0x00;
+		i2c_writebytes(state,0x08,buf,1);
+
+		/* write agc sdm configure */
+		buf[0] = 0xF1;		
+		i2c_writebytes(state,0x57,buf,1);
+
+		/* write mod output format */
+		buf[0] = 0x20;		
+		i2c_writebytes(state,0x09,buf,1);
+
+		/* write fec mpeg mode */
+		buf[0] = 0x7E;
+		buf[1] = 0x00;
+		i2c_writebytes(state,0xE9,buf,2);
+
+		/* write mux selection */
+		buf[0] = 0x00;
+		i2c_writebytes(state,0xCC,buf,1);
+
+		state->initialised = 1;
+	}
+
+	return 0;
+}
+
+static int nxt2002_get_tune_settings(struct dvb_frontend* fe, struct dvb_frontend_tune_settings* fesettings)
+{
+	fesettings->min_delay_ms = 500;
+	fesettings->step_size = 0;
+	fesettings->max_drift = 0;
+	return 0;
+}
+
+static void nxt2002_release(struct dvb_frontend* fe)
+{
+	struct nxt2002_state* state = (struct nxt2002_state*) fe->demodulator_priv;
+	kfree(state);
+}
+
+static struct dvb_frontend_ops nxt2002_ops;
+
+struct dvb_frontend* nxt2002_attach(const struct nxt2002_config* config,
+				   struct i2c_adapter* i2c)
+{
+	struct nxt2002_state* state = NULL;
+	u8 buf [] = {0,0,0,0,0};
+
+	/* allocate memory for the internal state */
+	state = (struct nxt2002_state*) kmalloc(sizeof(struct nxt2002_state), GFP_KERNEL);
+	if (state == NULL) goto error;
+
+	/* setup the state */
+	state->config = config;
+	state->i2c = i2c;
+	memcpy(&state->ops, &nxt2002_ops, sizeof(struct dvb_frontend_ops));
+	state->initialised = 0;
+
+        /* Check the first 5 registers to ensure this a revision we can handle */
+
+	i2c_readbytes(state, 0x00, buf, 5);
+	if (buf[0] != 0x04) goto error; 		/* device id */
+	if (buf[1] != 0x02) goto error; 		/* fab id */
+	if (buf[2] != 0x11) goto error; 		/* month */
+	if (buf[3] != 0x20) goto error; 		/* year msb */
+	if (buf[4] != 0x00) goto error; 		/* year lsb */
+
+	/* create dvb_frontend */
+	state->frontend.ops = &state->ops;
+	state->frontend.demodulator_priv = state;
+	return &state->frontend;
+
+error:
+	if (state) kfree(state);
+	return NULL;
+}
+
+static struct dvb_frontend_ops nxt2002_ops = {
+
+	.info = {
+		.name = "Nextwave nxt2002 VSB/QAM frontend",
+		.type = FE_ATSC,
+		.frequency_min =  54000000,
+		.frequency_max = 803000000,
+                /* stepsize is just a guess */
+		.frequency_stepsize = 166666,	
+		.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+			FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+			FE_CAN_8VSB 
+	},
+
+	.release = nxt2002_release,
+
+	.init = nxt2002_init,
+	.sleep = nxt2002_sleep,
+
+	.set_frontend = nxt2002_setup_frontend_parameters,
+	.get_tune_settings = nxt2002_get_tune_settings,
+
+	.read_status = nxt2002_read_status,
+	.read_ber = nxt2002_read_ber,
+	.read_signal_strength = nxt2002_read_signal_strength,
+	.read_snr = nxt2002_read_snr,
+	.read_ucblocks = nxt2002_read_ucblocks,
+
+};
+
+module_param(debug, int, 0644);
+MODULE_PARM_DESC(debug, "Turn on/off frontend debugging (default:off).");
+
+MODULE_DESCRIPTION("NXT2002 ATSC (8VSB & ITU J83 AnnexB FEC QAM64/256) demodulator driver");
+MODULE_AUTHOR("Taylor Jacob");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL(nxt2002_attach);
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/nxt2002.h linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/nxt2002.h
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/nxt2002.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/nxt2002.h	2004-12-16 16:45:54.000000000 +0100
@@ -0,0 +1,23 @@
+/*
+   Driver for the Nxt2002 demodulator
+*/
+
+#ifndef NXT2002_H
+#define NXT2002_H
+
+#include <linux/dvb/frontend.h>
+#include <linux/firmware.h>
+
+struct nxt2002_config
+{
+	/* the demodulator's i2c address */
+	u8 demod_address;
+
+	/* request firmware for device */
+	int (*request_firmware)(struct dvb_frontend* fe, const struct firmware **fw, char* name);
+};
+
+extern struct dvb_frontend* nxt2002_attach(const struct nxt2002_config* config,
+					  struct i2c_adapter* i2c);
+
+#endif // NXT2002_H
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/stv0297.c linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/stv0297.c
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/stv0297.c	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/stv0297.c	2005-01-20 19:56:38.000000000 +0100
@@ -38,10 +38,7 @@
 
         struct dvb_frontend frontend;
 
-        int freq_off;
-
 	unsigned long base_freq;
-
 	u8 pwm;
 };
 
@@ -162,8 +159,10 @@
         int ret;
         u8 b0[] = { reg };
         u8 b1[] = { 0 };
-        struct i2c_msg msg [] = { { .addr = state->config->demod_address, .flags = 0, .buf = b0, .len = 1 },
-                                  { .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
+	struct i2c_msg msg[] = { {.addr = state->config->demod_address,.flags = 0,.buf = b0,.len =
+				  1},
+	{.addr = state->config->demod_address,.flags = I2C_M_RD,.buf = b1,.len = 1}
+	};
 
         // this device needs a STOP between the register and data
         if ((ret = i2c_transfer (state->i2c, &msg[0], 1)) != 1) {
@@ -193,8 +192,10 @@
 static int stv0297_readregs (struct stv0297_state* state, u8 reg1, u8 *b, u8 len)
 {
         int ret;
-        struct i2c_msg msg [] = { { .addr = state->config->demod_address, .flags = 0, .buf = &reg1, .len = 1 },
-                                  { .addr = state->config->demod_address, .flags = I2C_M_RD, .buf = b, .len = len } };
+	struct i2c_msg msg[] = { {.addr = state->config->demod_address,.flags = 0,.buf =
+				  &reg1,.len = 1},
+	{.addr = state->config->demod_address,.flags = I2C_M_RD,.buf = b,.len = len}
+	};
 
         // this device needs a STOP between the register and data
         if ((ret = i2c_transfer (state->i2c, &msg[0], 1)) != 1) {
@@ -209,6 +210,21 @@
         return 0;
 }
 
+static u32 stv0297_get_symbolrate(struct stv0297_state *state)
+{
+	u64 tmp;
+
+	tmp = stv0297_readreg(state, 0x55);
+	tmp |= stv0297_readreg(state, 0x56) << 8;
+	tmp |= stv0297_readreg(state, 0x57) << 16;
+	tmp |= stv0297_readreg(state, 0x58) << 24;
+
+	tmp *= STV0297_CLOCK_KHZ;
+	tmp >>= 32;
+
+	return (u32) tmp;
+}
+
 static void stv0297_set_symbolrate(struct stv0297_state *state, u32 srate)
 {
 	long tmp;
@@ -259,39 +275,40 @@
 	stv0297_writereg_mask(state, 0x69, 0x0F, (tmp >> 24) & 0x0f);
 }
 
+/*
 static long stv0297_get_carrieroffset(struct stv0297_state* state)
 {
-        s32 raw;
-	long tmp;
+	s64 tmp;
 
         stv0297_writereg(state,0x6B, 0x00);
 
-        raw =   stv0297_readreg(state,0x66);
-        raw |= (stv0297_readreg(state,0x67) << 8);
-        raw |= (stv0297_readreg(state,0x68) << 16);
-        raw |= (stv0297_readreg(state,0x69) & 0x0F) << 24;
+	tmp = stv0297_readreg(state, 0x66);
+	tmp |= (stv0297_readreg(state, 0x67) << 8);
+	tmp |= (stv0297_readreg(state, 0x68) << 16);
+	tmp |= (stv0297_readreg(state, 0x69) & 0x0F) << 24;
 
-        tmp = raw;
-	tmp /= 26844L;
+	tmp *= stv0297_get_symbolrate(state);
+	tmp >>= 28;
 
-	return tmp;
+	return (s32) tmp;
 }
+*/
 
 static void stv0297_set_initialdemodfreq(struct stv0297_state* state, long freq)
 {
-/*
-        s64 tmp;
+	s32 tmp;
 
-        if (freq > 10000) freq -= STV0297_CLOCK_KHZ;
+	if (freq > 10000)
+		freq -= STV0297_CLOCK_KHZ;
 
-        tmp = freq << 16;
-        do_div(tmp, STV0297_CLOCK_KHZ);
-        if (tmp > 0xffff) tmp = 0xffff; // check this calculation
+	tmp = (STV0297_CLOCK_KHZ * 1000) / (1 << 16);
+	tmp = (freq * 1000) / tmp;
+	if (tmp > 0xffff)
+		tmp = 0xffff;
 
         stv0297_writereg_mask(state, 0x25, 0x80, 0x80);
         stv0297_writereg(state, 0x21, tmp >> 8);
         stv0297_writereg(state, 0x20, tmp);
-*/
 }
 
 static int stv0297_set_qam(struct stv0297_state* state, fe_modulation_t modulation)
@@ -413,6 +430,15 @@
         return 0;
 }
 
+static int stv0297_sleep(struct dvb_frontend *fe)
+{
+	struct stv0297_state *state = (struct stv0297_state *) fe->demodulator_priv;
+
+	stv0297_writereg_mask(state, 0x80, 1, 1);
+
+	return 0;
+}
+
 static int stv0297_read_status(struct dvb_frontend* fe, fe_status_t* status)
 {
         struct stv0297_state* state = (struct stv0297_state*) fe->demodulator_priv;
@@ -484,6 +510,7 @@
         int carrieroffset;
         unsigned long starttime;
         unsigned long timeout;
+	fe_spectral_inversion_t inversion;
 
         switch(p->u.qam.modulation) {
         case QAM_16:
@@ -508,8 +535,11 @@
         }
 
         // determine inversion dependant parameters
+	inversion = p->inversion;
+	if (state->config->invert)
+		inversion = (inversion == INVERSION_ON) ? INVERSION_OFF : INVERSION_ON;
         carrieroffset = -330;
-        switch(p->inversion) {
+	switch (inversion) {
         case INVERSION_OFF:
           break;
 
@@ -522,13 +552,14 @@
           return -EINVAL;
         }
 
+	stv0297_init(fe);
         state->config->pll_set(fe, p);
 
 	/* clear software interrupts */
 	stv0297_writereg(state, 0x82, 0x0);
 
 	/* set initial demodulation frequency */
-        stv0297_set_initialdemodfreq(state, state->freq_off + 7250);
+	stv0297_set_initialdemodfreq(state, 7250);
 
 	/* setup AGC */
         stv0297_writereg_mask(state, 0x43, 0x10, 0x00);
@@ -588,7 +619,7 @@
         stv0297_set_symbolrate(state, p->u.qam.symbol_rate/1000);
 	stv0297_set_sweeprate(state, sweeprate, p->u.qam.symbol_rate / 1000);
         stv0297_set_carrieroffset(state, carrieroffset);
-        stv0297_set_inversion(state, p->inversion);
+	stv0297_set_inversion(state, inversion);
 
 	/* kick off lock */
         stv0297_writereg_mask(state, 0x88, 0x08, 0x08);
@@ -664,7 +695,6 @@
 
 	/* success!! */
         stv0297_writereg_mask(state, 0x5a, 0x40, 0x00);
-        state->freq_off = stv0297_get_carrieroffset(state);
         state->base_freq = p->frequency;
         return 0;
 
@@ -681,10 +711,12 @@
         reg_00 = stv0297_readreg(state, 0x00);
         reg_83 = stv0297_readreg(state, 0x83);
 
-        p->frequency = state->base_freq + state->freq_off;
+	p->frequency = state->base_freq;
         p->inversion = (reg_83 & 0x08) ? INVERSION_ON : INVERSION_OFF;
-	p->u.qam.symbol_rate = 0;
-        p->u.qam.fec_inner = 0;
+	if (state->config->invert)
+		p->inversion = (p->inversion == INVERSION_ON) ? INVERSION_OFF : INVERSION_ON;
+	p->u.qam.symbol_rate = stv0297_get_symbolrate(state) * 1000;
+	p->u.qam.fec_inner = FEC_NONE;
 
         switch((reg_00 >> 4) & 0x7) {
 	case 0:
@@ -729,7 +761,6 @@
         state->config = config;
         state->i2c = i2c;
         memcpy(&state->ops, &stv0297_ops, sizeof(struct dvb_frontend_ops));
-        state->freq_off = 0;
         state->base_freq = 0;
         state->pwm = pwm;
 
@@ -764,6 +795,7 @@
         .release = stv0297_release,
 
         .init = stv0297_init,
+	.sleep = stv0297_sleep,
 
         .set_frontend = stv0297_set_frontend,
         .get_frontend = stv0297_get_frontend,
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/stv0297.h linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/stv0297.h
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/stv0297.h	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/stv0297.h	2004-12-17 22:00:18.000000000 +0100
@@ -29,6 +29,9 @@
 	/* the demodulator's i2c address */
 	u8 demod_address;
 
+	/* does the "inversion" need inverted? */
+	u8 invert:1;
+
 	/* PLL maintenance */
 	int (*pll_init)(struct dvb_frontend* fe);
 	int (*pll_set)(struct dvb_frontend* fe, struct dvb_frontend_parameters* params);
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/tda10021.c linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/tda10021.c
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/tda10021.c	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/tda10021.c	2005-01-20 19:56:38.000000000 +0100
@@ -4,7 +4,7 @@
 
     Copyright (C) 1999 Convergence Integrated Media GmbH <ralph@convergence.de>
     Copyright (C) 2004 Markus Schulz <msc@antzsystem.de>
-                   Suppport for TDA10021
+                   Support for TDA10021
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/tda10021.h linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/tda10021.h
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/tda10021.h	2005-01-20 19:54:04.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/tda10021.h	2005-01-20 19:56:38.000000000 +0100
@@ -4,7 +4,7 @@
 
     Copyright (C) 1999 Convergence Integrated Media GmbH <ralph@convergence.de>
     Copyright (C) 2004 Markus Schulz <msc@antzsystem.de>
-                   Suppport for TDA10021
+                   Support for TDA10021
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
diff -uraNwB linux-2.6.11-rc2/drivers/media/dvb/frontends/tda80xx.c linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/tda80xx.c
--- linux-2.6.11-rc2/drivers/media/dvb/frontends/tda80xx.c	2005-01-20 19:55:47.000000000 +0100
+++ linux-2.6.11-rc2-dvb/drivers/media/dvb/frontends/tda80xx.c	2004-11-18 15:58:34.000000000 +0100
@@ -27,10 +27,10 @@
 #include <linux/spinlock.h>
 #include <linux/threads.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <asm/irq.h>
 #include <asm/div64.h>
 
 #include "dvb_frontend.h"

