Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbTJIKxr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 06:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262001AbTJIKx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 06:53:28 -0400
Received: from mail.convergence.de ([212.84.236.4]:43172 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S261973AbTJIKr5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 06:47:57 -0400
Subject: [PATCH 5/7] Misc. fixes for ALPS TDLB7 DVB frontend driver
In-Reply-To: <10656964751857@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 9 Oct 2003 12:47:56 +0200
Message-Id: <10656964763874@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Michael Hunold (LinuxTV.org CVS maintainer) <hunold@linuxtv.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] applied latest changes by Juergen Peitz (great work!)
  - as a workaround for the lockup problem the data valid signal is checked after every channel switch. If it is not set FEC parameters are set again.
  - disabled autoprobing if FEC settings are known (from sp887x).
  - added support for FE_READ_UNCORRECTED_BLOCKS (from sp887x).
  - added support for FE_SLEEP (from sp887x).
  - bit error rate is now not only read from register 0xC07 but also from 0xC08 (from sp887x).
  - I2C feedthrough to the tuner is now only enabled when needed (from sp887x).
  - Added FE_CAN_QAM_AUTO and FE_CAN_HIERARCHY_AUTO to dvb_frontend_info.
  - Removed obsolete setting of default frontend parameters in sp8870_init.
  - Removed obsolete module parameter 'loadcode' because changes in the saa7146 driver made firmware loading very fast.
diff -uNrwB --new-file linux-2.6.0-test7/drivers/media/dvb/frontends/alps_tdlb7.c linux-2.6.0-test7-patch/drivers/media/dvb/frontends/alps_tdlb7.c
--- linux-2.6.0-test7/drivers/media/dvb/frontends/alps_tdlb7.c	2003-10-09 10:40:19.000000000 +0200
+++ linux-2.6.0-test7-patch/drivers/media/dvb/frontends/alps_tdlb7.c	2003-10-09 10:44:10.000000000 +0200
@@ -1,7 +1,7 @@
 /*
     Driver for Alps TDLB7 Frontend
 
-    Copyright (C) 1999 Juergen Peitz <peitz@snafu.de>
+    Copyright (C) 1999 Juergen Peitz
 
     This program is free software; you can redistribute it and/or modify
     it under the terms of the GNU General Public License as published by
@@ -22,23 +22,9 @@
 
 
 /* 
-    
-    Wrote this code mainly to get my own card running. It's working for me, but I
-    hope somebody who knows more about linux programming and the DVB driver can 
-    improve it.
-    
-    Reused a lot from the existing driver and tuner code.
-    Thanks to everybody who worked on it!
-    
-    This driver needs a copy of the microcode file 'Sc_main.mc' from the Haupauge 
-    windows driver in the 'usr/lib/DVB/driver/frontends' directory.  
-    You can also pass the complete file name with the module parameter 'mcfile'.
-    
-    The code only needs to be loaded once after a power on. Because loading the 
-    microcode to the card takes some time, you can use the 'loadcode=0' module 
-    parameter, if you only want to reload the dvb driver.      
-    
-    Juergen Peitz
+    This driver needs a copy of the firmware file 'Sc_main.mc' from the Haupauge
+    windows driver in the '/usr/lib/DVB/driver/frontends' directory.
+    You can also pass the complete file name with the module parameter 'firmware_file'.
     
 */  
 
@@ -50,49 +35,46 @@
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
 #include <linux/unistd.h>
+#include <linux/delay.h>
 
 #include "dvb_frontend.h"
+#include "dvb_functions.h"
 
-static int debug = 0;
-
-static int loadcode = 1;
+#ifndef CONFIG_ALPS_TDLB7_FIRMWARE_LOCATION
+#define CONFIG_ALPS_TDLB7_FIRMWARE_LOCATION "/usr/lib/DVB/driver/frontends/Sc_main.mc"
+#endif
 
-static char * mcfile = "/usr/lib/DVB/driver/frontends/Sc_main.mc";
+static char * firmware_file = CONFIG_ALPS_TDLB7_FIRMWARE_LOCATION;
+static int debug = 0;
 
 #define dprintk	if (debug) printk
 
-/* microcode size for sp8870 */
-#define SP8870_CODE_SIZE 16382
+/* firmware size for sp8870 */
+#define SP8870_FIRMWARE_SIZE 16382
 
-/* starting point for microcode in file 'Sc_main.mc' */
-#define SP8870_CODE_OFFSET 0x0A
+/* starting point for firmware in file 'Sc_main.mc' */
+#define SP8870_FIRMWARE_OFFSET 0x0A
 
 
 static int errno;
 
 static struct dvb_frontend_info tdlb7_info = {
-	.name			 = "Alps TDLB7",
-	.type			 = FE_OFDM,
-	.frequency_min		 = 470000000,
-	.frequency_max		 = 860000000,
-	.frequency_stepsize	 = 166666,
-#if 0
-    	.frequency_tolerance	 = ???,
-	.symbol_rate_min	 = ???,
-	.symbol_rate_max	 = ???,
-	.symbol_rate_tolerance	 = ???,
-	.notifier_delay	 = 0,
-#endif
-	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+	name: "Alps TDLB7",
+	type: FE_OFDM,
+	frequency_min: 470000000,
+	frequency_max: 860000000,
+	frequency_stepsize: 166666,
+	caps: FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
-	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64
+	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+	      FE_CAN_HIERARCHY_AUTO |  FE_CAN_RECOVER
 };
 
 
 static int sp8870_writereg (struct dvb_i2c_bus *i2c, u16 reg, u16 data)
 {
         u8 buf [] = { reg >> 8, reg & 0xff, data >> 8, data & 0xff };
-	struct i2c_msg msg = { .addr = 0x71, .flags = 0, .buf =  buf, .len = 4 };
+	struct i2c_msg msg = { addr: 0x71, flags: 0, buf: buf, len: 4 };
 	int err;
 
         if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
@@ -109,13 +91,15 @@
 	int ret;
 	u8 b0 [] = { reg >> 8 , reg & 0xff };
 	u8 b1 [] = { 0, 0 };
-	struct i2c_msg msg [] = { { .addr = 0x71, .flags = 0, .buf = b0, .len = 2 },
-			   { .addr = 0x71, .flags = I2C_M_RD, .buf = b1, .len = 2 } };
+	struct i2c_msg msg [] = { { addr: 0x71, flags: 0, buf: b0, len: 2 },
+			   { addr: 0x71, flags: I2C_M_RD, buf: b1, len: 2 } };
 
 	ret = i2c->xfer (i2c, msg, 2);
 
-	if (ret != 2)
+	if (ret != 2) {
 		dprintk("%s: readreg error (ret == %i)\n", __FUNCTION__, ret);
+		return -1;
+	}
 
 	return (b1[0] << 8 | b1[1]);
 }
@@ -124,7 +108,7 @@
 static int sp5659_write (struct dvb_i2c_bus *i2c, u8 data [4])
 {
         int ret;
-        struct i2c_msg msg = { .addr = 0x60, .flags = 0, .buf = data, .len = 4 };
+        struct i2c_msg msg = { addr: 0x60, flags: 0, buf: data, len: 4 };
 
         ret = i2c->xfer (i2c, &msg, 1);
 
@@ -135,7 +119,7 @@
 }
 
 
-static int sp5659_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
+static void sp5659_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
 {
         u32 div = (freq + 36200000) / 166666;
         u8 buf [4];
@@ -151,42 +135,50 @@
 	buf[2] = 0x85;
 	buf[3] = pwr << 6;
 
-	return sp5659_write (i2c, buf);
+	/* open i2c gate for PLL message transmission... */
+	sp8870_writereg(i2c, 0x206, 0x001);
+	sp5659_write (i2c, buf);
+	sp8870_writereg(i2c, 0x206, 0x000);
 }
 
 
-static int sp8870_read_code(const char *fn, char **fp)
+static int sp8870_read_firmware_file (const char *fn, char **fp)
 {
         int fd;
-	loff_t l;
+	loff_t filesize;
 	char *dp;
 
 	fd = open(fn, 0, 0);
 	if (fd == -1) {
-                printk(KERN_INFO "%s: Unable to load '%s'.\n", __FUNCTION__, fn);
-		return -1;
+                printk("%s: unable to open '%s'.\n", __FUNCTION__, fn);
+		return -EIO;
 	}
-	l = lseek(fd, 0L, 2);
-	if (l <= 0 || l < SP8870_CODE_OFFSET+SP8870_CODE_SIZE) {
-	        printk(KERN_INFO "%s: code file too small '%s'\n", __FUNCTION__, fn);
+
+	filesize = lseek(fd, 0L, 2);
+	if (filesize <= 0 || filesize < SP8870_FIRMWARE_OFFSET + SP8870_FIRMWARE_SIZE) {
+	        printk("%s: firmware filesize to small '%s'\n", __FUNCTION__, fn);
 		sys_close(fd);
-		return -1;
+		return -EIO;
 	}
-	lseek(fd, SP8870_CODE_OFFSET, 0);
-	*fp= dp = vmalloc(SP8870_CODE_SIZE);
+
+	*fp= dp = vmalloc(SP8870_FIRMWARE_SIZE);
 	if (dp == NULL)	{
-		printk(KERN_INFO "%s: Out of memory loading '%s'.\n", __FUNCTION__, fn);
+		printk("%s: out of memory loading '%s'.\n", __FUNCTION__, fn);
 		sys_close(fd);
-		return -1;
+		return -EIO;
 	}
-	if (read(fd, dp, SP8870_CODE_SIZE) != SP8870_CODE_SIZE) {
-		printk(KERN_INFO "%s: Failed to read '%s'.\n",__FUNCTION__, fn);
+
+	lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
+	if (read(fd, dp, SP8870_FIRMWARE_SIZE) != SP8870_FIRMWARE_SIZE) {
+		printk("%s: failed to read '%s'.\n",__FUNCTION__, fn);
 		vfree(dp);
 		sys_close(fd);
-		return -1;
+		return -EIO;
 	}
+
 	sys_close(fd);
 	*fp = dp;
+
 	return 0;
 }
 
@@ -191,62 +183,98 @@
 }
 
 
-static int sp8870_load_code(struct dvb_i2c_bus *i2c)
+static int sp8870_firmware_upload (struct dvb_i2c_bus *i2c)
 {
-	/* this takes a long time. is there a way to do it faster? */
-	char *lcode;
 	struct i2c_msg msg;
-	unsigned char buf[255];
-	int err;
-	int p=0;
-	int c;
+	char *fw_buf = NULL;
+	int fw_pos;
+	u8 tx_buf[255];
+	int tx_len;
+	int err = 0;
 	mm_segment_t fs = get_fs();
 
+	dprintk ("%s: ...\n", __FUNCTION__);
+
 	// system controller stop 
 	sp8870_writereg(i2c,0x0F00,0x0000);
 
 	// instruction RAM register hiword
-	sp8870_writereg(i2c,0x8F08,((SP8870_CODE_SIZE/2) & 0xFFFF));
+	sp8870_writereg(i2c, 0x8F08, ((SP8870_FIRMWARE_SIZE / 2) & 0xFFFF));
 
 	// instruction RAM MWR
-	sp8870_writereg(i2c,0x8F0A,((SP8870_CODE_SIZE/2) >> 16));
+	sp8870_writereg(i2c, 0x8F0A, ((SP8870_FIRMWARE_SIZE / 2) >> 16));
 
+	// reading firmware file to buffer
 	set_fs(get_ds());
-        if (sp8870_read_code(mcfile,(char**) &lcode)<0) return -1;
+        err = sp8870_read_firmware_file(firmware_file, (char**) &fw_buf);
 	set_fs(fs);
-	while (p<SP8870_CODE_SIZE){
-		c = (p<=SP8870_CODE_SIZE-252) ? 252 : SP8870_CODE_SIZE-p;
-		buf[0]=0xCF;
-		buf[1]=0x0A;
-		memcpy(&buf[2],lcode+p,c);
-		c+=2;
+	if (err != 0) {
+		printk("%s: reading firmware file failed!\n", __FUNCTION__);
+		return err;
+	}
+
+	// do firmware upload
+	fw_pos = 0;
+	while (fw_pos < SP8870_FIRMWARE_SIZE){
+		tx_len = (fw_pos <= SP8870_FIRMWARE_SIZE - 252) ? 252 : SP8870_FIRMWARE_SIZE - fw_pos;
+		// write register 0xCF0A
+		tx_buf[0] = 0xCF;
+		tx_buf[1] = 0x0A;
+		memcpy(&tx_buf[2], fw_buf + fw_pos, tx_len);
 		msg.addr=0x71;
 		msg.flags=0;
-		msg.buf=buf;
-		msg.len=c;
+		msg.buf = tx_buf;
+		msg.len = tx_len + 2;
         	if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
-			dprintk ("%s: i2c error (err == %i)\n",
-				 __FUNCTION__, err);
-        		vfree(lcode);
-			return -EREMOTEIO;
+			printk("%s: firmware upload failed!\n", __FUNCTION__);
+			printk ("%s: i2c error (err == %i)\n", __FUNCTION__, err);
+        		vfree(fw_buf);
+			return err;
 		}
-
-		p+=252;
+		fw_pos += tx_len;
 	}
-        vfree(lcode);
+
+	vfree(fw_buf);
+
+	dprintk ("%s: done!\n", __FUNCTION__);
 	return 0;
 };
 
 
-static int sp8870_init (struct dvb_i2c_bus *i2c)
+static void sp8870_microcontroller_stop (struct dvb_i2c_bus *i2c)
+{
+	sp8870_writereg(i2c, 0x0F08, 0x000);
+	sp8870_writereg(i2c, 0x0F09, 0x000);
+
+	// microcontroller STOP
+	sp8870_writereg(i2c, 0x0F00, 0x000);
+}
+
+
+static void sp8870_microcontroller_start (struct dvb_i2c_bus *i2c)
 {
+	sp8870_writereg(i2c, 0x0F08, 0x000);
+	sp8870_writereg(i2c, 0x0F09, 0x000);
+
+	// microcontroller START
+	sp8870_writereg(i2c, 0x0F00, 0x001);
+	// not documented but if we don't read 0x0D01 out here
+	// we don't get a correct data valid signal
+	sp8870_readreg(i2c, 0x0D01);
+}
+
 
+static int sp8870_init (struct dvb_i2c_bus *i2c)
+{
 	dprintk ("%s\n", __FUNCTION__);
 
+	/* enable TS output and interface pins */
+	sp8870_writereg(i2c, 0xc18, 0x00d);
+
 	// system controller stop 
-	sp8870_writereg(i2c,0x0F00,0x0000);
+	sp8870_microcontroller_stop(i2c);
 
-	// ADC mode: 2 for MT8872, 3 for MT8870/8871 
+	// ADC mode
 	sp8870_writereg(i2c,0x0301,0x0003);
 
 	// Reed Solomon parity bytes passed to output
@@ -255,103 +283,214 @@
 	// MPEG clock is suppressed if no valid data
 	sp8870_writereg(i2c,0x0C14,0x0001);
 
-	// sample rate correction bit [23..17]
-	sp8870_writereg(i2c,0x0319,0x000A);
+	/* bit 0x010: enable data valid signal */
+	sp8870_writereg(i2c, 0x0D00, 0x010);
+	sp8870_writereg(i2c, 0x0D01, 0x000);
 
-	// sample rate correction bit [16..0]
-	sp8870_writereg(i2c,0x031A,0x0AAB);
+	return 0;
+}
 
-	// integer carrier offset
-	sp8870_writereg(i2c,0x0309,0x0400);
 
-	// fractional carrier offset
-	sp8870_writereg(i2c,0x030A,0x0000);
+static int sp8870_read_status (struct dvb_i2c_bus *i2c,  fe_status_t * fe_status)
+{
+	int status;
+	int signal;
 
-	// filter for 8 Mhz channel 
-	sp8870_writereg(i2c,0x0311,0x0000);
+	*fe_status = 0;
 
-	// scan order: 2k first = 0x0000, 8k first = 0x0001 
-	sp8870_writereg(i2c,0x0338,0x0000);
+	status = sp8870_readreg (i2c, 0x0200);
+	if (status < 0)
+		return -EIO;
+
+	signal = sp8870_readreg (i2c, 0x0303);
+	if (signal < 0)
+		return -EIO;
+
+	if (signal > 0x0F)
+		*fe_status |= FE_HAS_SIGNAL;
+	if (status & 0x08)
+		*fe_status |= FE_HAS_SYNC;
+	if (status & 0x04)
+		*fe_status |= FE_HAS_LOCK | FE_HAS_CARRIER | FE_HAS_VITERBI;
 
 	return 0;
 }
 
 
-static int tdlb7_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+static int sp8870_read_ber (struct dvb_i2c_bus *i2c, u32 * ber)
 {
-	struct dvb_i2c_bus *i2c = fe->i2c;
+	int ret;
+	u32 tmp;
 
-        switch (cmd) {
-        case FE_GET_INFO:
-		memcpy (arg, &tdlb7_info, sizeof(struct dvb_frontend_info));
-		break;
+	*ber = 0;
 
-        case FE_READ_STATUS:
-	{
-		fe_status_t *status = arg;
-		int sync = sp8870_readreg (i2c, 0x0200);
-		int signal = 0xff-sp8870_readreg (i2c, 0x303);
+	ret = sp8870_readreg(i2c, 0xC08);
+	if (ret < 0)
+		return -EIO;
 
-		*status=0;
-		if (signal>10) // FIXME: is 10 the right value ?
-			*status |= FE_HAS_SIGNAL;
+	tmp = ret & 0x3F;
 
-		if (sync&0x04) // FIXME: find criteria
-			*status |= FE_HAS_CARRIER;
+	ret = sp8870_readreg(i2c, 0xC07);
+	if (ret < 0)
+		return -EIO;
 
-		if (sync&0x04) // FIXME
-			*status |= FE_HAS_VITERBI;
+	 tmp = ret << 6;
 
-		if (sync&0x08) // FIXME
-			*status |= FE_HAS_SYNC;
+	if (tmp >= 0x3FFF0)
+		tmp = ~0;
 
-		if (sync&0x04)
-			*status |= FE_HAS_LOCK;
-		break;
+	*ber = tmp;
 
+	return 0;
 	}
 
-        case FE_READ_BER:
+
+static int sp8870_read_signal_strength (struct dvb_i2c_bus *i2c,  u16 * signal)
 	{
-		u32 *ber=(u32 *) arg;
-		// bit error rate before Viterbi
-		*ber=sp8870_readreg(i2c,0x0C07);
-		break;
+	int ret;
+	u16 tmp;
 
-	}
+	*signal = 0;
 
-        case FE_READ_SIGNAL_STRENGTH:		// FIXME: correct registers ?
-	{
-		*((u16*) arg) = 0xffff-((sp8870_readreg (i2c, 0x306) << 8) | sp8870_readreg (i2c, 0x303));
-		break;
+	ret = sp8870_readreg (i2c, 0x306);
+	if (ret < 0)
+		return -EIO;
+
+	tmp = ret << 8;
+
+	ret = sp8870_readreg (i2c, 0x303);
+	if (ret < 0)
+		return -EIO;
+
+	tmp |= ret;
+
+	if (tmp)
+		*signal = 0xFFFF - tmp;
+
+	return 0;
 	}
 
-        case FE_READ_SNR:			// not supported by hardware?
+
+static int sp8870_read_snr(struct dvb_i2c_bus *i2c, u32* snr)
 	{
-		s32 *snr=(s32 *) arg;
                 *snr=0;  
 		return -EOPNOTSUPP;
 	}
 
-	case FE_READ_UNCORRECTED_BLOCKS: 	// not supported by hardware?
+
+static int sp8870_read_uncorrected_blocks (struct dvb_i2c_bus *i2c, u32* ublocks)
 	{
-		u32 *ublocks=(u32 *) arg;
+		int ret;
+
 		*ublocks=0;  
-		return -EOPNOTSUPP;
+
+		ret = sp8870_readreg(i2c, 0xC0C);
+		if (ret < 0)
+			return -EIO;
+
+		if (ret == 0xFFFF)
+			ret = ~0;
+
+		*ublocks = ret;
+
+		return 0;
 	}
 
-        case FE_SET_FRONTEND:
+
+static int sp8870_read_data_valid_signal(struct dvb_i2c_bus *i2c)
+{
+	return (sp8870_readreg(i2c, 0x0D02) > 0);
+}
+
+
+static
+int configure_reg0xc05 (struct dvb_frontend_parameters *p, u16 *reg0xc05)
+{
+	int known_parameters = 1;
+
+	*reg0xc05 = 0x000;
+
+	switch (p->u.ofdm.constellation) {
+	case QPSK:
+		break;
+	case QAM_16:
+		*reg0xc05 |= (1 << 10);
+		break;
+	case QAM_64:
+		*reg0xc05 |= (2 << 10);
+		break;
+	case QAM_AUTO:
+		known_parameters = 0;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	switch (p->u.ofdm.hierarchy_information) {
+	case HIERARCHY_NONE:
+		break;
+	case HIERARCHY_1:
+		*reg0xc05 |= (1 << 7);
+		break;
+	case HIERARCHY_2:
+		*reg0xc05 |= (2 << 7);
+		break;
+	case HIERARCHY_4:
+		*reg0xc05 |= (3 << 7);
+		break;
+	case HIERARCHY_AUTO:
+		known_parameters = 0;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	switch (p->u.ofdm.code_rate_HP) {
+	case FEC_1_2:
+		break;
+	case FEC_2_3:
+		*reg0xc05 |= (1 << 3);
+		break;
+	case FEC_3_4:
+		*reg0xc05 |= (2 << 3);
+		break;
+	case FEC_5_6:
+		*reg0xc05 |= (3 << 3);
+		break;
+	case FEC_7_8:
+		*reg0xc05 |= (4 << 3);
+		break;
+	case FEC_AUTO:
+		known_parameters = 0;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	if (known_parameters)
+		*reg0xc05 |= (2 << 1);	/* use specified parameters */
+	else
+		*reg0xc05 |= (1 << 1);	/* enable autoprobing */
+
+	return 0;
+}
+
+
+static int sp8870_set_frontend_parameters (struct dvb_i2c_bus *i2c,
+				      struct dvb_frontend_parameters *p)
         {
-		struct dvb_frontend_parameters *p = arg;
+	int  err;
+	u16 reg0xc05;
+
+	if ((err = configure_reg0xc05(p, &reg0xc05)))
+		return err;
 
 		// system controller stop 
-		sp8870_writereg(i2c,0x0F00,0x0000);
+	sp8870_microcontroller_stop(i2c);
 
+	// set tuner parameters
 		sp5659_set_tv_freq (i2c, p->frequency);
 
-		// read status reg in order to clear pending irqs
-		sp8870_readreg(i2c, 0x200);
-
 		// sample rate correction bit [23..17]
 		sp8870_writereg(i2c,0x0319,0x000A);
 		
@@ -378,28 +517,141 @@
 		else
 			sp8870_writereg(i2c,0x0338,0x0001);
 
-		// instruction RAM register loword
-		sp8870_writereg(i2c,0x0F09,0x0000);
+	sp8870_writereg(i2c, 0xc05, reg0xc05);
 
-		// instruction RAM register hiword
-		sp8870_writereg(i2c,0x0F08,0x0000);
+	// read status reg in order to clear pending irqs
+	sp8870_readreg(i2c, 0x200);
 
 		// system controller start
-		sp8870_writereg(i2c,0x0F00,0x0001);
+	sp8870_microcontroller_start(i2c);
 
-		break;
+	return 0;
         }
 
-	case FE_GET_FRONTEND:  // FIXME: read known values back from Hardware...
+
+// number of trials to recover from lockup
+#define MAXTRIALS 5
+// maximum checks for data valid signal
+#define MAXCHECKS 100
+
+// only for debugging: counter for detected lockups
+static int lockups = 0;
+// only for debugging: counter for channel switches
+static int switches = 0;
+
+static int sp8870_set_frontend (struct dvb_i2c_bus *i2c, struct dvb_frontend_parameters *p)
 	{
+	/*
+	    The firmware of the sp8870 sometimes locks up after setting frontend parameters.
+	    We try to detect this by checking the data valid signal.
+	    If it is not set after MAXCHECKS we try to recover the lockup by setting
+	    the frontend parameters again.
+	*/
+
+	int err = 0;
+	int valid = 0;
+	int trials = 0;
+	int check_count = 0;
+
+	dprintk("%s: frequency = %i\n", __FUNCTION__, p->frequency);
+
+	for (trials = 1; trials <= MAXTRIALS; trials++) {
+
+		if ((err = sp8870_set_frontend_parameters(i2c, p)))
+			return err;
+
+		for (check_count = 0; check_count < MAXCHECKS; check_count++) {
+//			valid = ((sp8870_readreg(i2c, 0x0200) & 4) == 0);
+			valid = sp8870_read_data_valid_signal(i2c);
+			if (valid) {
+				dprintk("%s: delay = %i usec\n",
+					__FUNCTION__, check_count * 10);
+				break;
+			}
+			udelay(10);
+		}
+		if (valid)
 		break;
 	}
 
-        case FE_SLEEP:			// is this supported by hardware?
+	if (!valid) {
+		printk("%s: firmware crash!!!!!!\n", __FUNCTION__);
+		return -EIO;
+	}
+
+	if (debug) {
+		if (valid) {
+			if (trials > 1) {
+				printk("%s: firmware lockup!!!\n", __FUNCTION__);
+				printk("%s: recovered after %i trial(s))\n",  __FUNCTION__, trials - 1);
+				lockups++;
+			}
+		}
+		switches++;
+		printk("%s: switches = %i lockups = %i\n", __FUNCTION__, switches, lockups);
+	}
+
+	return 0;
+}
+
+
+static int sp8870_sleep(struct dvb_i2c_bus *i2c)
+{
+	// tristate TS output and disable interface pins
+	return sp8870_writereg(i2c, 0xC18, 0x000);
+}
+
+
+static int sp8870_wake_up(struct dvb_i2c_bus *i2c)
+{
+	// enable TS output and interface pins
+	return sp8870_writereg(i2c, 0xC18, 0x00D);
+}
+
+
+static int tdlb7_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
+{
+	struct dvb_i2c_bus *i2c = fe->i2c;
+
+        switch (cmd) {
+        case FE_GET_INFO:
+		memcpy (arg, &tdlb7_info, sizeof(struct dvb_frontend_info));
+		break;
+
+        case FE_READ_STATUS:
+		return sp8870_read_status(i2c, (fe_status_t *) arg);
+
+        case FE_READ_BER:
+		return sp8870_read_ber(i2c, (u32 *) arg);
+
+        case FE_READ_SIGNAL_STRENGTH:
+		return sp8870_read_signal_strength(i2c, (u16 *) arg);
+
+        case FE_READ_SNR:				// not supported by hardware?
+		return sp8870_read_snr(i2c, (u32 *) arg);
+
+	case FE_READ_UNCORRECTED_BLOCKS:
+		return sp8870_read_uncorrected_blocks(i2c, (u32 *) arg);
+
+        case FE_SET_FRONTEND:
+		return sp8870_set_frontend(i2c, (struct dvb_frontend_parameters*) arg);
+
+	case FE_RESET:
+		return -EOPNOTSUPP;
+
+	case FE_GET_FRONTEND:			 // FIXME: read known values back from Hardware...
 		return -EOPNOTSUPP;
 
+        case FE_SLEEP:
+		return sp8870_sleep(i2c);
+
         case FE_INIT:
-		return sp8870_init (i2c);
+		sp8870_wake_up(i2c);
+		if (fe->data == NULL) {		// first time initialisation...
+			fe->data = (void*) ~0;
+			sp8870_init (i2c);
+		}
+		break;
 
 	default:
 		return -EOPNOTSUPP;
@@ -409,31 +661,22 @@
 }
 
 
-static int tdlb7_attach (struct dvb_i2c_bus *i2c)
+static int tdlb7_attach (struct dvb_i2c_bus *i2c, void **data)
 {
-
-	struct i2c_msg msg = { .addr = 0x71, .flags = 0, .buf = NULL, .len = 0 };
+	struct i2c_msg msg = { addr: 0x71, flags: 0, buf: NULL, len: 0 };
 
 	dprintk ("%s\n", __FUNCTION__);
 
 	if (i2c->xfer (i2c, &msg, 1) != 1)
                 return -ENODEV;
 
-	if (loadcode) {
-		dprintk("%s: loading mcfile '%s' !\n", __FUNCTION__, mcfile);
-		if (sp8870_load_code(i2c)==0)
-		    dprintk("%s: microcode loaded!\n", __FUNCTION__);
-	}else{
-		dprintk("%s: without loading mcfile!\n", __FUNCTION__);
-	}
-
-	dvb_register_frontend (tdlb7_ioctl, i2c, NULL, &tdlb7_info);
+	sp8870_firmware_upload(i2c);
 
-	return 0;
+	return dvb_register_frontend (tdlb7_ioctl, i2c, NULL, &tdlb7_info);
 }
 
 
-static void tdlb7_detach (struct dvb_i2c_bus *i2c)
+static void tdlb7_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -464,11 +707,8 @@
 MODULE_PARM(debug,"i");
 MODULE_PARM_DESC(debug, "enable verbose debug messages");
 
-MODULE_PARM(loadcode,"i");
-MODULE_PARM_DESC(loadcode, "load tuner microcode");
-
-MODULE_PARM(mcfile,"s");
-MODULE_PARM_DESC(mcfile, "where to find the microcode file");
+MODULE_PARM(firmware_file,"s");
+MODULE_PARM_DESC(firmware_file, "where to find the firmware file");
 
 MODULE_DESCRIPTION("TDLB7 DVB-T Frontend");
 MODULE_AUTHOR("Juergen Peitz");

