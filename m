Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbUBWVLk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 16:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262003AbUBWVLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 16:11:16 -0500
Received: from mail.convergence.de ([212.84.236.4]:49642 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S262042AbUBWVFB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 16:05:01 -0500
To: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       hunold@linuxtv.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 7/9] tda1004x DVB frontend update
In-Reply-To: <10775702831806@convergence.de>
Message-Id: <10775702843054@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 23 Feb 2004 16:05:01 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] tda1004x: standardised where the firmware should be.
- [DVB] tda1004x: need to re-invert inversion for tda10046 in get_fe()
- [DVB] tda1004x: reset chip before uploading firmware
- [DVB] tda1004x: split firmware upload off from frontend init. the initial tune attempt was taking too long. provide explanation of tuner frequency calculations
- [DVB] tda1004x: Fixed signal strength reading for tda10046h
diff -uNrwB --new-file xx-linux-2.6.3/drivers/media/dvb/frontends/tda1004x.c linux-2.6.3.p/drivers/media/dvb/frontends/tda1004x.c
--- xx-linux-2.6.3/drivers/media/dvb/frontends/tda1004x.c	2004-01-09 09:22:40.000000000 +0100
+++ linux-2.6.3.p/drivers/media/dvb/frontends/tda1004x.c	2004-02-02 19:28:30.000000000 +0100
@@ -1,6 +1,8 @@
   /*
      Driver for Philips tda1004xh OFDM Frontend
 
+     (c) 2003, 2004 Andrew de Quincey & Robert Schlabbach
+
      This program is free software; you can redistribute it and/or modify
      it under the terms of the GNU General Public License as published by
      the Free Software Foundation; either version 2 of the License, or
@@ -20,7 +22,7 @@
 
 /*
     This driver needs a copy of the DLL "ttlcdacc.dll" from the Haupauge or Technotrend
-    windows driver saved as '/usr/lib/hotplug/firmware/tda1004x.mc'.
+    windows driver saved as '/usr/lib/hotplug/firmware/tda1004x.bin'.
     You can also pass the complete file name with the module parameter 'tda1004x_firmware'.
 
     Currently the DLL from v2.15a of the technotrend driver is supported. Other versions can
@@ -45,16 +47,12 @@
 #include "dvb_functions.h"
 
 #ifndef DVB_TDA1004X_FIRMWARE_FILE
-#define DVB_TDA1004X_FIRMWARE_FILE "/usr/lib/hotplug/firmware/tda1004x.mc"
+#define DVB_TDA1004X_FIRMWARE_FILE "/usr/lib/hotplug/firmware/tda1004x.bin"
 #endif
 
 static int tda1004x_debug = 0;
 static char *tda1004x_firmware = DVB_TDA1004X_FIRMWARE_FILE;
 
-
-#define TDA10045H_ADDRESS        0x08
-#define TD1344_ADDRESS           0x61
-#define TDM1316L_ADDRESS         0x63
 #define MC44BC374_ADDRESS        0x65
 
 #define TDA1004X_CHIPID          0x00
@@ -66,8 +64,8 @@
 #define TDA1004X_STATUS_CD       0x06
 #define TDA1004X_CONFC4          0x07
 #define TDA1004X_DSSPARE2        0x0C
-#define TDA1004X_CODE_IN         0x0D
-#define TDA1004X_FWPAGE          0x0E
+#define TDA10045H_CODE_IN        0x0D
+#define TDA10045H_FWPAGE         0x0E
 #define TDA1004X_SCAN_CPT        0x10
 #define TDA1004X_DSP_CMD         0x11
 #define TDA1004X_DSP_ARG         0x12
@@ -75,10 +73,11 @@
 #define TDA1004X_DSP_DATA2       0x14
 #define TDA1004X_CONFADC1        0x15
 #define TDA1004X_CONFC1          0x16
-#define TDA1004X_SIGNAL_STRENGTH 0x1a
+#define TDA10045H_S_AGC          0x1a
+#define TDA10046H_AGC_TUN_LEVEL  0x1a
 #define TDA1004X_SNR             0x1c
-#define TDA1004X_REG1E           0x1e
-#define TDA1004X_REG1F           0x1f
+#define TDA1004X_CONF_TS1        0x1e
+#define TDA1004X_CONF_TS2        0x1f
 #define TDA1004X_CBER_RESET      0x20
 #define TDA1004X_CBER_MSB        0x21
 #define TDA1004X_CBER_LSB        0x22
@@ -87,18 +86,58 @@
 #define TDA1004X_VBER_MID        0x25
 #define TDA1004X_VBER_LSB        0x26
 #define TDA1004X_UNCOR           0x27
-#define TDA1004X_CONFPLL_P       0x2D
-#define TDA1004X_CONFPLL_M_MSB   0x2E
-#define TDA1004X_CONFPLL_M_LSB   0x2F
-#define TDA1004X_CONFPLL_N       0x30
-#define TDA1004X_UNSURW_MSB      0x31
-#define TDA1004X_UNSURW_LSB      0x32
-#define TDA1004X_WREF_MSB        0x33
-#define TDA1004X_WREF_MID        0x34
-#define TDA1004X_WREF_LSB        0x35
-#define TDA1004X_MUXOUT          0x36
+
+#define TDA10045H_CONFPLL_P      0x2D
+#define TDA10045H_CONFPLL_M_MSB  0x2E
+#define TDA10045H_CONFPLL_M_LSB  0x2F
+#define TDA10045H_CONFPLL_N      0x30
+
+#define TDA10046H_CONFPLL1       0x2D
+#define TDA10046H_CONFPLL2       0x2F
+#define TDA10046H_CONFPLL3       0x30
+#define TDA10046H_TIME_WREF1     0x31
+#define TDA10046H_TIME_WREF2     0x32
+#define TDA10046H_TIME_WREF3     0x33
+#define TDA10046H_TIME_WREF4     0x34
+#define TDA10046H_TIME_WREF5     0x35
+
+#define TDA10045H_UNSURW_MSB     0x31
+#define TDA10045H_UNSURW_LSB     0x32
+#define TDA10045H_WREF_MSB       0x33
+#define TDA10045H_WREF_MID       0x34
+#define TDA10045H_WREF_LSB       0x35
+#define TDA10045H_MUXOUT         0x36
 #define TDA1004X_CONFADC2        0x37
-#define TDA1004X_IOFFSET         0x38
+
+#define TDA10045H_IOFFSET        0x38
+
+#define TDA10046H_CONF_TRISTATE1 0x3B
+#define TDA10046H_CONF_TRISTATE2 0x3C
+#define TDA10046H_CONF_POLARITY  0x3D
+#define TDA10046H_FREQ_OFFSET    0x3E
+#define TDA10046H_GPIO_OUT_SEL   0x41
+#define TDA10046H_GPIO_SELECT    0x42
+#define TDA10046H_AGC_CONF       0x43
+#define TDA10046H_AGC_GAINS      0x46
+#define TDA10046H_AGC_TUN_MIN    0x47
+#define TDA10046H_AGC_TUN_MAX    0x48
+#define TDA10046H_AGC_IF_MIN     0x49
+#define TDA10046H_AGC_IF_MAX     0x4A
+
+#define TDA10046H_FREQ_PHY2_MSB  0x4D
+#define TDA10046H_FREQ_PHY2_LSB  0x4E
+
+#define TDA10046H_CVBER_CTRL     0x4F
+#define TDA10046H_AGC_IF_LEVEL   0x52
+#define TDA10046H_CODE_CPT       0x57
+#define TDA10046H_CODE_IN        0x58
+
+
+#define FE_TYPE_TDA10045H     0
+#define FE_TYPE_TDA10046H     1
+
+#define TUNER_TYPE_TD1344     0
+#define TUNER_TYPE_TD1316     1
 
 #define dprintk if (tda1004x_debug) printk
 
@@ -115,11 +154,27 @@
 	    FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO
 };
 
+static struct dvb_frontend_info tda10046h_info = {
+        .name = "Philips TDA10046H",
+        .type = FE_OFDM,
+        .frequency_min = 51000000,
+        .frequency_max = 858000000,
+        .frequency_stepsize = 166667,
+        .caps =
+            FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
+            FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
+            FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO |
+            FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO
+};
+
+
 #pragma pack(1)
 struct tda1004x_state {
 	u8 tda1004x_address;
 	u8 tuner_address;
 	u8 initialised:1;
+        u8 tuner_type:2;
+        u8 fe_type:2;
 };
 #pragma pack()
 
@@ -131,6 +186,9 @@
 static struct fwinfo tda10045h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x34cc5,.fw_size = 30555} };
 static int tda10045h_fwinfo_count = sizeof(tda10045h_fwinfo) / sizeof(struct fwinfo);
 
+static struct fwinfo tda10046h_fwinfo[] = { {.file_size = 286720,.fw_offset = 0x3c4f9,.fw_size = 24479} };
+static int tda10046h_fwinfo_count = sizeof(tda10046h_fwinfo) / sizeof(struct fwinfo);
+
 static int errno;
 
 
@@ -245,46 +302,98 @@
         switch (bandwidth) {
 	case BANDWIDTH_6_MHZ:
 		tda1004x_write_byte(i2c, tda_state, TDA1004X_DSSPARE2, 0x14);
-		tda1004x_write_buf(i2c, tda_state, TDA1004X_CONFPLL_P, bandwidth_6mhz, sizeof(bandwidth_6mhz));
+                tda1004x_write_buf(i2c, tda_state, TDA10045H_CONFPLL_P, bandwidth_6mhz, sizeof(bandwidth_6mhz));
 		break;
 
 	case BANDWIDTH_7_MHZ:
 		tda1004x_write_byte(i2c, tda_state, TDA1004X_DSSPARE2, 0x80);
-		tda1004x_write_buf(i2c, tda_state, TDA1004X_CONFPLL_P, bandwidth_7mhz, sizeof(bandwidth_7mhz));
+                tda1004x_write_buf(i2c, tda_state, TDA10045H_CONFPLL_P, bandwidth_7mhz, sizeof(bandwidth_7mhz));
 		break;
 
 	case BANDWIDTH_8_MHZ:
 		tda1004x_write_byte(i2c, tda_state, TDA1004X_DSSPARE2, 0x14);
-		tda1004x_write_buf(i2c, tda_state, TDA1004X_CONFPLL_P, bandwidth_8mhz, sizeof(bandwidth_8mhz));
+                tda1004x_write_buf(i2c, tda_state, TDA10045H_CONFPLL_P, bandwidth_8mhz, sizeof(bandwidth_8mhz));
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	tda1004x_write_byte(i2c, tda_state, TDA1004X_IOFFSET, 0);
+        tda1004x_write_byte(i2c, tda_state, TDA10045H_IOFFSET, 0);
+
+        // done
+        return 0;
+}
+
+
+static int tda10046h_set_bandwidth(struct dvb_i2c_bus *i2c,
+                                   struct tda1004x_state *tda_state,
+                                   fe_bandwidth_t bandwidth)
+{
+        static u8 bandwidth_6mhz[] = { 0x80, 0x15, 0xfe, 0xab, 0x8e };
+        static u8 bandwidth_7mhz[] = { 0x6e, 0x02, 0x53, 0xc8, 0x25 };
+        static u8 bandwidth_8mhz[] = { 0x60, 0x12, 0xa8, 0xe4, 0xbd };
+
+        switch (bandwidth) {
+        case BANDWIDTH_6_MHZ:
+                tda1004x_write_buf(i2c, tda_state, TDA10046H_TIME_WREF1, bandwidth_6mhz, sizeof(bandwidth_6mhz));
+                tda1004x_write_byte(i2c, tda_state, TDA1004X_DSSPARE2, 0);
+                break;
+
+        case BANDWIDTH_7_MHZ:
+                tda1004x_write_buf(i2c, tda_state, TDA10046H_TIME_WREF1, bandwidth_7mhz, sizeof(bandwidth_7mhz));
+                tda1004x_write_byte(i2c, tda_state, TDA1004X_DSSPARE2, 0);
+                break;
+
+        case BANDWIDTH_8_MHZ:
+                tda1004x_write_buf(i2c, tda_state, TDA10046H_TIME_WREF1, bandwidth_8mhz, sizeof(bandwidth_8mhz));
+                tda1004x_write_byte(i2c, tda_state, TDA1004X_DSSPARE2, 0xFF);
+                break;
+
+        default:
+                return -EINVAL;
+        }
 
         // done
         return 0;
 }
 
 
-static int tda1004x_init(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
+static int tda1004x_fwupload(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
 {
 	u8 fw_buf[65];
 	struct i2c_msg fw_msg = {.addr = 0,.flags = 0,.buf = fw_buf,.len = 0 };
-	struct i2c_msg tuner_msg = {.addr = 0,.flags = 0,.buf = 0,.len = 0 };
 	unsigned char *firmware = NULL;
 	int filesize;
 	int fd;
 	int fwinfo_idx;
 	int fw_size = 0;
-	int fw_pos;
+        int fw_pos, fw_offset;
 	int tx_size;
-        static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
 	mm_segment_t fs = get_fs();
-
-	dprintk("%s\n", __FUNCTION__);
+        int dspCodeCounterReg=0, dspCodeInReg=0, dspVersion=0;
+        int fwInfoCount=0;
+        struct fwinfo* fwInfo = NULL;
+        unsigned long timeout;
+
+        // DSP parameters
+        switch(tda_state->fe_type) {
+        case FE_TYPE_TDA10045H:
+                dspCodeCounterReg = TDA10045H_FWPAGE;
+                dspCodeInReg = TDA10045H_CODE_IN;
+                dspVersion = 0x2c;
+                fwInfoCount = tda10045h_fwinfo_count;
+                fwInfo = tda10045h_fwinfo;
+                break;
+
+        case FE_TYPE_TDA10046H:
+                dspCodeCounterReg = TDA10046H_CODE_CPT;
+                dspCodeInReg = TDA10046H_CODE_IN;
+                dspVersion = 0x20;
+                fwInfoCount = tda10046h_fwinfo_count;
+                fwInfo = tda10046h_fwinfo;
+                break;
+        }
 
 	// Load the firmware
 	set_fs(get_ds());
@@ -302,17 +411,18 @@
 		return -EIO;
 	}
 
-	// find extraction parameters
-	for (fwinfo_idx = 0; fwinfo_idx < tda10045h_fwinfo_count; fwinfo_idx++) {
-		if (tda10045h_fwinfo[fwinfo_idx].file_size == filesize)
+        // find extraction parameters for firmware
+        for (fwinfo_idx = 0; fwinfo_idx < fwInfoCount; fwinfo_idx++) {
+                if (fwInfo[fwinfo_idx].file_size == filesize)
 			break;
 	}
-	if (fwinfo_idx >= tda10045h_fwinfo_count) {
+        if (fwinfo_idx >= fwInfoCount) {
 		printk("%s: Unsupported firmware %s\n", __FUNCTION__, tda1004x_firmware);
 		sys_close(fd);
 		return -EIO;
 	}
-	fw_size = tda10045h_fwinfo[fwinfo_idx].fw_size;
+        fw_size = fwInfo[fwinfo_idx].fw_size;
+        fw_offset = fwInfo[fwinfo_idx].fw_offset;
 
 	// allocate buffer for it
 	firmware = vmalloc(fw_size);
@@ -324,7 +434,7 @@
 	}
 
 	// read it!
-	lseek(fd, tda10045h_fwinfo[fwinfo_idx].fw_offset, 0);
+        lseek(fd, fw_offset, 0);
 	if (read(fd, firmware, fw_size) != fw_size) {
 		printk("%s: Failed to read firmware\n", __FUNCTION__);
 		vfree(firmware);
@@ -334,26 +444,35 @@
 	sys_close(fd);
 	set_fs(fs);
 
-	// Disable the MC44BC374C
-	tda1004x_enable_tuner_i2c(i2c, tda_state);
-	tuner_msg.addr = MC44BC374_ADDRESS;
-	tuner_msg.buf = disable_mc44BC374c;
-	tuner_msg.len = sizeof(disable_mc44BC374c);
-	if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
-		i2c->xfer(i2c, &tuner_msg, 1);
-	}
-	tda1004x_disable_tuner_i2c(i2c, tda_state);
+        // set some valid bandwith parameters before uploading
+        switch(tda_state->fe_type) {
+        case FE_TYPE_TDA10045H:
+                // reset chip
+                tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8);
+                tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 0);
+                dvb_delay(10);
 
-	// set some valid bandwith parameters
-        switch(tda_state->tda1004x_address) {
-        case TDA10045H_ADDRESS:
+                // set parameters
                 tda10045h_set_bandwidth(i2c, tda_state, BANDWIDTH_8_MHZ);
                 break;
+
+        case FE_TYPE_TDA10046H:
+                // reset chip
+                tda1004x_write_mask(i2c, tda_state, TDA10046H_CONF_TRISTATE1, 1, 0);
+                dvb_delay(10);
+
+                // set parameters
+                tda1004x_write_byte(i2c, tda_state, TDA10046H_CONFPLL2, 10);
+                tda1004x_write_byte(i2c, tda_state, TDA10046H_CONFPLL3, 0);
+                tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_OFFSET, 99);
+                tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_PHY2_MSB, 0xd4);
+                tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_PHY2_LSB, 0x2c);
+                tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8); // going to boot from HOST
+                break;
         }
-	dvb_delay(500);
 
 	// do the firmware upload
-	tda1004x_write_byte(i2c, tda_state, TDA1004X_FWPAGE, 0);
+        tda1004x_write_byte(i2c, tda_state, dspCodeCounterReg, 0); // clear code counter
         fw_msg.addr = tda_state->tda1004x_address;
 	fw_pos = 0;
 	while (fw_pos != fw_size) {
@@ -357,16 +476,19 @@
         fw_msg.addr = tda_state->tda1004x_address;
 	fw_pos = 0;
 	while (fw_pos != fw_size) {
+
 		// work out how much to send this time
 		tx_size = fw_size - fw_pos;
-		if (tx_size > 64) {
-			tx_size = 64;
+                if (tx_size > 0x10) {
+                        tx_size = 0x10;
 		}
+
 		// send the chunk
-		fw_buf[0] = TDA1004X_CODE_IN;
+                fw_buf[0] = dspCodeInReg;
 		memcpy(fw_buf + 1, firmware + fw_pos, tx_size);
 		fw_msg.len = tx_size + 1;
 		if (i2c->xfer(i2c, &fw_msg, 1) != 1) {
+                        printk("tda1004x: Error during firmware upload\n");
 			vfree(firmware);
 			return -EIO;
 		}
@@ -374,35 +496,128 @@
 
 		dprintk("%s: fw_pos=0x%x\n", __FUNCTION__, fw_pos);
 	}
-	dvb_delay(100);
 	vfree(firmware);
 
-	// Initialise the DSP and check upload was OK
-	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x10, 0);
+        // wait for DSP to initialise
+        switch(tda_state->fe_type) {
+        case FE_TYPE_TDA10045H:
+                // DSPREADY doesn't seem to work on the TDA10045H
+                dvb_delay(100);
+                break;
+
+        case FE_TYPE_TDA10046H:
+                timeout = jiffies + HZ;
+                while(!(tda1004x_read_byte(i2c, tda_state, TDA1004X_STATUS_CD) & 0x20)) {
+                        if (time_after(jiffies, timeout)) {
+                                printk("tda1004x: DSP failed to initialised.\n");
+                                return -EIO;
+                        }
+
+                        dvb_delay(1);
+                }
+                break;
+        }
+
+        // check upload was OK
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x10, 0); // we want to read from the DSP
 	tda1004x_write_byte(i2c, tda_state, TDA1004X_DSP_CMD, 0x67);
 	if ((tda1004x_read_byte(i2c, tda_state, TDA1004X_DSP_DATA1) != 0x67) ||
-	    (tda1004x_read_byte(i2c, tda_state, TDA1004X_DSP_DATA2) != 0x2c)) {
+            (tda1004x_read_byte(i2c, tda_state, TDA1004X_DSP_DATA2) != dspVersion)) {
 		printk("%s: firmware upload failed!\n", __FUNCTION__);
 		return -EIO;
 	}
 
+        // success
+        return 0;
+}
+
+
+static int tda10045h_init(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
+{
+        struct i2c_msg tuner_msg = {.addr = 0,.flags = 0,.buf = 0,.len = 0 };
+        static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
+
+        dprintk("%s\n", __FUNCTION__);
+
+        // Disable the MC44BC374C
+        tda1004x_enable_tuner_i2c(i2c, tda_state);
+        tuner_msg.addr = MC44BC374_ADDRESS;
+        tuner_msg.buf = disable_mc44BC374c;
+        tuner_msg.len = sizeof(disable_mc44BC374c);
+        if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
+                i2c->xfer(i2c, &tuner_msg, 1);
+        }
+        tda1004x_disable_tuner_i2c(i2c, tda_state);
+
 	// tda setup
-	tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 8, 0);
-        tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 0x10, 0x10);
-        tda1004x_write_mask(i2c, tda_state, TDA1004X_IN_CONF2, 0xC0, 0x0);
-        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x20, 0);
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x20, 0); // disable DSP watchdog timer
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 8, 0); // select HP stream
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x40, 0); // no frequency inversion
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x80, 0x80); // enable pulse killer
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 0x10, 0x10); // enable auto offset
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_IN_CONF2, 0xC0, 0x0); // no frequency offset
+        tda1004x_write_byte(i2c, tda_state, TDA1004X_CONF_TS1, 0); // setup MPEG2 TS interface
+        tda1004x_write_byte(i2c, tda_state, TDA1004X_CONF_TS2, 0); // setup MPEG2 TS interface
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_VBER_MSB, 0xe0, 0xa0); // 10^6 VBER measurement bits
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x10, 0); // VAGC polarity
         tda1004x_write_byte(i2c, tda_state, TDA1004X_CONFADC1, 0x2e);
-	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x80, 0x80);
-	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x40, 0);
-	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x10, 0);
-        tda1004x_write_byte(i2c, tda_state, TDA1004X_REG1E, 0);
-	tda1004x_write_byte(i2c, tda_state, TDA1004X_REG1F, 0);
-	tda1004x_write_mask(i2c, tda_state, TDA1004X_VBER_MSB, 0xe0, 0xa0);
 
 	// done
 	return 0;
 }
 
+
+
+static int tda10046h_init(struct dvb_i2c_bus *i2c, struct tda1004x_state *tda_state)
+{
+        struct i2c_msg tuner_msg = {.addr = 0,.flags = 0,.buf = 0,.len = 0 };
+        static u8 disable_mc44BC374c[] = { 0x1d, 0x74, 0xa0, 0x68 };
+
+        dprintk("%s\n", __FUNCTION__);
+
+        // Disable the MC44BC374C
+        tda1004x_enable_tuner_i2c(i2c, tda_state);
+        tuner_msg.addr = MC44BC374_ADDRESS;
+        tuner_msg.buf = disable_mc44BC374c;
+        tuner_msg.len = sizeof(disable_mc44BC374c);
+        if (i2c->xfer(i2c, &tuner_msg, 1) != 1) {
+                i2c->xfer(i2c, &tuner_msg, 1);
+        }
+        tda1004x_disable_tuner_i2c(i2c, tda_state);
+
+        // tda setup
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x20, 0); // disable DSP watchdog timer
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x40, 0x40); // TT TDA10046H needs inversion ON
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 8, 0); // select HP stream
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x80, 0); // disable pulse killer
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_CONFPLL2, 10); // PLL M = 10
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_CONFPLL3, 0); // PLL P = N = 0
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_OFFSET, 99); // FREQOFFS = 99
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_PHY2_MSB, 0xd4); // } PHY2 = -11221
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_FREQ_PHY2_LSB, 0x2c); // }
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_AGC_CONF, 0); // AGC setup
+        tda1004x_write_mask(i2c, tda_state, TDA10046H_CONF_POLARITY, 0x60, 0x60); // set AGC polarities
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_AGC_TUN_MIN, 0);    // }
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_AGC_TUN_MAX, 0xff); // } AGC min/max values
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_AGC_IF_MIN, 0);     // }
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_AGC_IF_MAX, 0xff);  // }
+        tda1004x_write_mask(i2c, tda_state, TDA10046H_CVBER_CTRL, 0x30, 0x10); // 10^6 VBER measurement bits
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_AGC_GAINS, 1); // IF gain 2, TUN gain 1
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 0x80, 0); // crystal is 50ppm
+        tda1004x_write_byte(i2c, tda_state, TDA1004X_CONF_TS1, 7); // MPEG2 interface config
+        tda1004x_write_mask(i2c, tda_state, TDA1004X_CONF_TS2, 0x31, 0); // MPEG2 interface config
+        tda1004x_write_mask(i2c, tda_state, TDA10046H_CONF_TRISTATE1, 0x9e, 0); // disable AGC_TUN
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_CONF_TRISTATE2, 0xe1); // tristate setup
+        tda1004x_write_byte(i2c, tda_state, TDA10046H_GPIO_OUT_SEL, 0xcc); // GPIO output config
+        tda1004x_write_mask(i2c, tda_state, TDA10046H_GPIO_SELECT, 8, 8); // GPIO select
+        tda10046h_set_bandwidth(i2c, tda_state, BANDWIDTH_8_MHZ); // default bandwidth 8 MHz
+
+        // done
+        return 0;
+}
+
+
+
 static int tda1004x_encode_fec(int fec)
 {
 	// convert known FEC values
@@ -449,17 +664,18 @@
 {
 	u8 tuner_buf[4];
 	struct i2c_msg tuner_msg = {.addr=0, .flags=0, .buf=tuner_buf, .len=sizeof(tuner_buf) };
-	int tuner_frequency;
+        int tuner_frequency = 0;
         u8 band, cp, filter;
 	int counter, counter2;
 
 	dprintk("%s\n", __FUNCTION__);
 
 	// setup the frequency buffer
-	switch (tda_state->tuner_address) {
-	case TD1344_ADDRESS:
+        switch (tda_state->tuner_type) {
+        case TUNER_TYPE_TD1344:
 
 		// setup tuner buffer
+                // ((Fif+((1000000/6)/2)) + Finput)/(1000000/6)
 		tuner_frequency =
                         (((fe_params->frequency / 1000) * 6) + 217502) / 1000;
 		tuner_buf[0] = tuner_frequency >> 8;
@@ -498,7 +714,7 @@
 		tda1004x_disable_tuner_i2c(i2c, tda_state);
 		break;
 
-	case TDM1316L_ADDRESS:
+        case TUNER_TYPE_TD1316:
 		// determine charge pump
 		tuner_frequency = fe_params->frequency + 36130000;
 		if (tuner_frequency < 87000000) {
@@ -541,9 +757,7 @@
 		// work out filter
 		switch (fe_params->u.ofdm.bandwidth) {
 		case BANDWIDTH_6_MHZ:
-                        // 6 MHz isn't supported directly, but set this to
-                        // the 8 MHz setting in case we can fiddle it later
-                        filter = 1;
+                        filter = 0;
                         break;
 
                 case BANDWIDTH_7_MHZ:
@@ -558,15 +772,27 @@
 			return -EINVAL;
 		}
 
-		// calculate tuner parameters
+                // calculate divisor
+                // ((36130000+((1000000/6)/2)) + Finput)/(1000000/6)
 		tuner_frequency =
                         (((fe_params->frequency / 1000) * 6) + 217280) / 1000;
+
+                // setup tuner buffer
 		tuner_buf[0] = tuner_frequency >> 8;
 		tuner_buf[1] = tuner_frequency & 0xff;
 		tuner_buf[2] = 0xca;
 		tuner_buf[3] = (cp << 5) | (filter << 3) | band;
 
 		// tune it
+                if (tda_state->fe_type == FE_TYPE_TDA10046H) {
+                        // setup auto offset
+                        tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 0x10, 0x10);
+                        tda1004x_write_mask(i2c, tda_state, TDA1004X_IN_CONF1, 0x80, 0);
+                        tda1004x_write_mask(i2c, tda_state, TDA1004X_IN_CONF2, 0xC0, 0);
+
+                        // disable agc_conf[2]
+                        tda1004x_write_mask(i2c, tda_state, TDA10046H_AGC_CONF, 4, 0);
+                }
 		tda1004x_enable_tuner_i2c(i2c, tda_state);
 		tuner_msg.addr = tda_state->tuner_address;
 		tuner_msg.len = 4;
@@ -575,6 +801,8 @@
 		}
 		dvb_delay(1);
 		tda1004x_disable_tuner_i2c(i2c, tda_state);
+                if (tda_state->fe_type == FE_TYPE_TDA10046H)
+                        tda1004x_write_mask(i2c, tda_state, TDA10046H_AGC_CONF, 4, 4);
 		break;
 
 	default:
@@ -592,6 +820,7 @@
 		           struct dvb_frontend_parameters *fe_params)
 {
 	int tmp;
+        int inversion;
 
 	dprintk("%s\n", __FUNCTION__);
 
@@ -595,10 +824,8 @@
 
 	dprintk("%s\n", __FUNCTION__);
 
-
 	// set frequency
-	tmp = tda1004x_set_frequency(i2c, tda_state, fe_params);
-	if (tmp < 0)
+        if ((tmp = tda1004x_set_frequency(i2c, tda_state, fe_params)) < 0)
 		return tmp;
 
         // hardcoded to use auto as much as possible
@@ -672,14 +899,24 @@
 	}
 
         // set bandwidth
-        switch(tda_state->tda1004x_address) {
-        case TDA10045H_ADDRESS:
+        switch(tda_state->fe_type) {
+        case FE_TYPE_TDA10045H:
                 tda10045h_set_bandwidth(i2c, tda_state, fe_params->u.ofdm.bandwidth);
                 break;
+
+        case FE_TYPE_TDA10046H:
+                tda10046h_set_bandwidth(i2c, tda_state, fe_params->u.ofdm.bandwidth);
+                break;
+        }
+
+        // need to invert the inversion for TT TDA10046H
+        inversion = fe_params->inversion;
+        if (tda_state->fe_type == FE_TYPE_TDA10046H) {
+                inversion = inversion ? INVERSION_OFF : INVERSION_ON;
         }
 
 	// set inversion
-	switch (fe_params->inversion) {
+        switch (inversion) {
 	case INVERSION_OFF:
 		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC1, 0x20, 0);
 		break;
@@ -744,10 +981,19 @@
 		return -EINVAL;
 	}
 
-	// reset DSP
+        // start the lock
+        switch(tda_state->fe_type) {
+        case FE_TYPE_TDA10045H:
 	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8);
 	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 0);
 	dvb_delay(10);
+                break;
+
+        case FE_TYPE_TDA10046H:
+                tda1004x_write_mask(i2c, tda_state, TDA1004X_AUTO, 0x40, 0x40);
+                dvb_delay(10);
+                break;
+        }
 
 	// done
 	return 0;
@@ -765,8 +1010,15 @@
 		fe_params->inversion = INVERSION_ON;
 	}
 
+        // need to invert the inversion for TT TDA10046H
+        if (tda_state->fe_type == FE_TYPE_TDA10046H) {
+                fe_params->inversion = fe_params->inversion ? INVERSION_OFF : INVERSION_ON;
+        }
+
 	// bandwidth
-	switch (tda1004x_read_byte(i2c, tda_state, TDA1004X_WREF_LSB)) {
+        switch(tda_state->fe_type) {
+        case FE_TYPE_TDA10045H:
+                switch (tda1004x_read_byte(i2c, tda_state, TDA10045H_WREF_LSB)) {
 	case 0x14:
 		fe_params->u.ofdm.bandwidth = BANDWIDTH_8_MHZ;
 		break;
@@ -777,6 +1029,22 @@
 		fe_params->u.ofdm.bandwidth = BANDWIDTH_6_MHZ;
 		break;
 	}
+                break;
+
+        case FE_TYPE_TDA10046H:
+                switch (tda1004x_read_byte(i2c, tda_state, TDA10046H_TIME_WREF1)) {
+                case 0x60:
+                        fe_params->u.ofdm.bandwidth = BANDWIDTH_8_MHZ;
+                        break;
+                case 0x6e:
+                        fe_params->u.ofdm.bandwidth = BANDWIDTH_7_MHZ;
+                        break;
+                case 0x80:
+                        fe_params->u.ofdm.bandwidth = BANDWIDTH_6_MHZ;
+                        break;
+                }
+                break;
+        }
 
 	// FEC
 	fe_params->u.ofdm.code_rate_HP =
@@ -905,11 +1173,23 @@
 static int tda1004x_read_signal_strength(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state, u16 * signal)
 {
 	int tmp;
+        int reg = 0;
 
 	dprintk("%s\n", __FUNCTION__);
 
+        // determine the register to use
+        switch(tda_state->fe_type) {
+        case FE_TYPE_TDA10045H:
+                reg = TDA10045H_S_AGC;
+                break;
+
+        case FE_TYPE_TDA10046H:
+                reg = TDA10046H_AGC_IF_LEVEL;
+                break;
+        }
+
 	// read it
-	tmp = tda1004x_read_byte(i2c, tda_state, TDA1004X_SIGNAL_STRENGTH);
+        tmp = tda1004x_read_byte(i2c, tda_state, reg);
 	if (tmp < 0)
 		return -EIO;
 
@@ -1008,10 +1288,14 @@
 
 	switch (cmd) {
 	case FE_GET_INFO:
-                switch(tda_state->tda1004x_address) {
-                case TDA10045H_ADDRESS:
+                switch(tda_state->fe_type) {
+                case FE_TYPE_TDA10045H:
         		memcpy(arg, &tda10045h_info, sizeof(struct dvb_frontend_info));
                         break;
+
+                case FE_TYPE_TDA10046H:
+                        memcpy(arg, &tda10046h_info, sizeof(struct dvb_frontend_info));
+                        break;
                 }
 		break;
 
@@ -1042,7 +1327,15 @@
 			return 0;
 
 		// OK, perform initialisation
-                status = tda1004x_init(i2c, tda_state);
+                switch(tda_state->fe_type) {
+                case FE_TYPE_TDA10045H:
+                        status = tda10045h_init(i2c, tda_state);
+                        break;
+
+                case FE_TYPE_TDA10046H:
+                        status = tda10046h_init(i2c, tda_state);
+                        break;
+                }
 		if (status == 0)
 			tda_state->initialised = 1;
 		return status;
@@ -1059,42 +1352,81 @@
 {
         int tda1004x_address = -1;
 	int tuner_address = -1;
+        int fe_type = -1;
+        int tuner_type = -1;
 	struct tda1004x_state tda_state;
 	struct i2c_msg tuner_msg = {.addr=0, .flags=0, .buf=0, .len=0 };
         static u8 td1344_init[] = { 0x0b, 0xf5, 0x88, 0xab };
-        static u8 tdm1316l_init[] = { 0x0b, 0xf5, 0x85, 0xab };
+        static u8 td1316_init[] = { 0x0b, 0xf5, 0x85, 0xab };
+        static u8 td1316_init_tda10046h[] = { 0x0b, 0xf5, 0x80, 0xab };
+        int status;
 
 	dprintk("%s\n", __FUNCTION__);
 
-	// probe for frontend
-        tda_state.tda1004x_address = TDA10045H_ADDRESS;
+        // probe for tda10045h
+        if (tda1004x_address == -1) {
+                tda_state.tda1004x_address = 0x08;
 	if (tda1004x_read_byte(i2c, &tda_state, TDA1004X_CHIPID) == 0x25) {
-                tda1004x_address = TDA10045H_ADDRESS;
+                        tda1004x_address = 0x08;
+                        fe_type = FE_TYPE_TDA10045H;
                 printk("tda1004x: Detected Philips TDA10045H.\n");
         }
+        }
+
+        // probe for tda10046h
+        if (tda1004x_address == -1) {
+                tda_state.tda1004x_address = 0x08;
+                if (tda1004x_read_byte(i2c, &tda_state, TDA1004X_CHIPID) == 0x46) {
+                        tda1004x_address = 0x08;
+                        fe_type = FE_TYPE_TDA10046H;
+                        printk("tda1004x: Detected Philips TDA10046H.\n");
+                }
+        }
 
         // did we find a frontend?
         if (tda1004x_address == -1) {
 		return -ENODEV;
         }
 
-	// supported tuner?
+        // enable access to the tuner
 	tda1004x_enable_tuner_i2c(i2c, &tda_state);
-	tuner_msg.addr = TD1344_ADDRESS;
+
+        // check for a TD1344 first
+        if (tuner_address == -1) {
+                tuner_msg.addr = 0x61;
 	tuner_msg.buf = td1344_init;
 	tuner_msg.len = sizeof(td1344_init);
 	if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
                 dvb_delay(1);
-		tuner_address = TD1344_ADDRESS;
-		printk("tda1004x: Detected Philips TD1344 tuner. PLEASE CHECK THIS AND REPORT BACK!.\n");
-	} else {
-		tuner_msg.addr = TDM1316L_ADDRESS;
-                tuner_msg.buf = tdm1316l_init;
-                tuner_msg.len = sizeof(tdm1316l_init);
+                        tuner_address = 0x61;
+                        tuner_type = TUNER_TYPE_TD1344;
+                        printk("tda1004x: Detected Philips TD1344 tuner.\n");
+                }
+        }
+
+        // OK, try a TD1316 on address 0x63
+        if (tuner_address == -1) {
+                tuner_msg.addr = 0x63;
+                tuner_msg.buf = td1316_init;
+                tuner_msg.len = sizeof(td1316_init);
                 if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
                         dvb_delay(1);
-			tuner_address = TDM1316L_ADDRESS;
-			printk("tda1004x: Detected Philips TDM1316L tuner.\n");
+                        tuner_address = 0x63;
+                        tuner_type = TUNER_TYPE_TD1316;
+                        printk("tda1004x: Detected Philips TD1316 tuner.\n");
+                }
+        }
+
+        // OK, TD1316 again, on address 0x60 (TDA10046H)
+        if (tuner_address == -1) {
+                tuner_msg.addr = 0x60;
+                tuner_msg.buf = td1316_init_tda10046h;
+                tuner_msg.len = sizeof(td1316_init_tda10046h);
+                if (i2c->xfer(i2c, &tuner_msg, 1) == 1) {
+                        dvb_delay(1);
+                        tuner_address = 0x60;
+                        tuner_type = TUNER_TYPE_TD1316;
+                        printk("tda1004x: Detected Philips TD1316 tuner.\n");
 		}
 	}
 	tda1004x_disable_tuner_i2c(i2c, &tda_state);
@@ -1107,16 +1439,25 @@
 
         // create state
         tda_state.tda1004x_address = tda1004x_address;
+        tda_state.fe_type = fe_type;
 	tda_state.tuner_address = tuner_address;
+        tda_state.tuner_type = tuner_type;
 	tda_state.initialised = 0;
 
+        // upload firmware
+        if ((status = tda1004x_fwupload(i2c, &tda_state)) != 0) return status;
+
 	// register
-        switch(tda_state.tda1004x_address) {
-        case TDA10045H_ADDRESS:
+        switch(tda_state.fe_type) {
+        case FE_TYPE_TDA10045H:
         	return dvb_register_frontend(tda1004x_ioctl, i2c, (void *)(*((u32*) &tda_state)), &tda10045h_info);
-	default:
-		return -ENODEV;
+
+        case FE_TYPE_TDA10046H:
+                return dvb_register_frontend(tda1004x_ioctl, i2c, (void *)(*((u32*) &tda_state)), &tda10046h_info);
         }
+
+        // should not get here
+        return -EINVAL;
 }
 
 
@@ -1145,7 +1486,7 @@
 module_init(init_tda1004x);
 module_exit(exit_tda1004x);
 
-MODULE_DESCRIPTION("Philips TDA10045H DVB-T Frontend");
+MODULE_DESCRIPTION("Philips TDA10045H & TDA10046H DVB-T Frontend");
 MODULE_AUTHOR("Andrew de Quincey & Robert Schlabbach");
 MODULE_LICENSE("GPL");
 


