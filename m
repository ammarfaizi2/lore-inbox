Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263840AbUDZOCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263840AbUDZOCc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 10:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbUDZOCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 10:02:32 -0400
Received: from mail.convergence.de ([212.84.236.4]:50564 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S263840AbUDZNmV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 09:42:21 -0400
To: hunold@linuxtv.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
From: Michael Hunold <hunold@linuxtv.org>
Subject: [PATCH 7/9] DVB: Misc. DVB frontend driver updates
In-Reply-To: <10829868842348@convergence.de>
Message-Id: <1082986903219@convergence.de>
X-Mailer: gregkh_patchbomb_levon_offspring_mihu_extended
Date: Mon, 26 Apr 2004 09:42:21 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- [DVB] follow changes in dvb-core for frontend drivers (ves1x93, ves1820, nxt6000, sp887x, tda1004x, stv0299, mt312, alps_tdlb7, alps_tdmb7, at76c651, cx24110, dst, dvb_dummy_fe, grundig_29504-401, grundig_29504-491)
- [DVB] tda1004x: updated timeout to 800ms, implemented FE_SLEEP
- [DVB] cx24110: add FE_CAN_RECOVER to reduce kdvb-fe CPU load
- [DVB] grundig_29504-401: added 200ms delay after first FE_INIT, Implemented FE_GET_FRONTEND
- [DVB] alps_tdlb7, alps_tdmb7: upped tuning delays to fix tuning
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/alps_tdlb7.c linux-2.6.5-patched/drivers/media/dvb/frontends/alps_tdlb7.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/alps_tdlb7.c	2004-04-09 17:42:17.000000000 +0200
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/alps_tdlb7.c	2004-03-25 20:07:25.000000000 +0100
@@ -29,11 +29,11 @@
 */  
 
 
+#define __KERNEL_SYSCALLS__
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/vmalloc.h>
 #include <linux/fs.h>
-#include <linux/syscalls.h>
 #include <linux/unistd.h>
 #include <linux/delay.h>
 
@@ -56,6 +56,8 @@
 #define SP8870_FIRMWARE_OFFSET 0x0A
 
 
+static int errno;
+
 static struct dvb_frontend_info tdlb7_info = {
 	.name			= "Alps TDLB7",
 	.type			= FE_OFDM,
@@ -74,12 +75,7 @@
 static int sp8870_writereg (struct dvb_i2c_bus *i2c, u16 reg, u16 data)
 {
         u8 buf [] = { reg >> 8, reg & 0xff, data >> 8, data & 0xff };
-	struct i2c_msg msg = {
-		.addr = 0x71,
-		.flags = 0,
-		.buf = buf,
-		.len =  4
-	};
+	struct i2c_msg msg = { .addr = 0x71, .flags = 0, .buf = buf, .len = 4 };
 	int err;
 
         if ((err = i2c->xfer (i2c, &msg, 1)) != 1) {
@@ -96,20 +92,8 @@
 	int ret;
 	u8 b0 [] = { reg >> 8 , reg & 0xff };
 	u8 b1 [] = { 0, 0 };
-	struct i2c_msg msg [] = {
-		{
-			.addr 	= 0x71,
-			.flags	= 0,
-			.buf	= b0,
-			.len	= 2
-		},
-		{
-			.addr	= 0x71,
-			.flags	= I2C_M_RD,
-			.buf	= b1,
-			.len	= 2
-		}
-	};
+	struct i2c_msg msg [] = { { .addr = 0x71, .flags = 0, .buf = b0, .len = 2 },
+			   { .addr = 0x71, .flags = I2C_M_RD, .buf = b1, .len = 2 } };
 
 	ret = i2c->xfer (i2c, msg, 2);
 
@@ -125,12 +109,7 @@
 static int sp5659_write (struct dvb_i2c_bus *i2c, u8 data [4])
 {
         int ret;
-        struct i2c_msg msg = {
-		.addr	= 0x60,
-		.flags	= 0,
-		.buf	= data,
-		.len	=4
-	};
+        struct i2c_msg msg = { .addr = 0x60, .flags = 0, .buf = data, .len = 4 };
 
         ret = i2c->xfer (i2c, &msg, 1);
 
@@ -170,13 +149,13 @@
 	loff_t filesize;
 	char *dp;
 
-	fd = sys_open(fn, 0, 0);
+	fd = open(fn, 0, 0);
 	if (fd == -1) {
                 printk("%s: unable to open '%s'.\n", __FUNCTION__, fn);
 		return -EIO;
 	}
 
-	filesize = sys_lseek(fd, 0L, 2);
+	filesize = lseek(fd, 0L, 2);
 	if (filesize <= 0 || filesize < SP8870_FIRMWARE_OFFSET + SP8870_FIRMWARE_SIZE) {
 	        printk("%s: firmware filesize to small '%s'\n", __FUNCTION__, fn);
 		sys_close(fd);
@@ -190,8 +169,8 @@
 		return -EIO;
 	}
 
-	sys_lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
-	if (sys_read(fd, dp, SP8870_FIRMWARE_SIZE) != SP8870_FIRMWARE_SIZE) {
+	lseek(fd, SP8870_FIRMWARE_OFFSET, 0);
+	if (read(fd, dp, SP8870_FIRMWARE_SIZE) != SP8870_FIRMWARE_SIZE) {
 		printk("%s: failed to read '%s'.\n",__FUNCTION__, fn);
 		vfree(dp);
 		sys_close(fd);
@@ -658,9 +637,6 @@
         case FE_SET_FRONTEND:
 		return sp8870_set_frontend(i2c, (struct dvb_frontend_parameters*) arg);
 
-	case FE_RESET:
-		return -EOPNOTSUPP;
-
 	case FE_GET_FRONTEND:			 // FIXME: read known values back from Hardware...
 		return -EOPNOTSUPP;
 
@@ -675,6 +651,15 @@
 		}
 		break;
 
+	case FE_GET_TUNE_SETTINGS:
+	{
+	        struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+	        fesettings->min_delay_ms = 150;
+	        fesettings->step_size = 166667;
+	        fesettings->max_drift = 166667*2;
+	        return 0;
+	}	    
+	    
 	default:
 		return -EOPNOTSUPP;
         };
@@ -687,21 +672,8 @@
 {
         u8 b0 [] = { 0x02 , 0x00 };
         u8 b1 [] = { 0, 0 };
-        struct i2c_msg msg [] =
-			{
-				{
-					.addr = 0x71,
-					.flags = 0,
-					.buf = b0,
-					.len = 2
-				},
-				{
-					.addr = 0x71,
-					.flags = I2C_M_RD,
-					.buf = b1,
-					.len = 2
-				}
-			};
+        struct i2c_msg msg [] = { { .addr = 0x71, .flags = 0, .buf = b0, .len = 2 },
+                                  { .addr = 0x71, .flags = I2C_M_RD, .buf = b1, .len = 2 } };
 
 	dprintk ("%s\n", __FUNCTION__);
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/alps_tdmb7.c linux-2.6.5-patched/drivers/media/dvb/frontends/alps_tdmb7.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/alps_tdmb7.c	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/alps_tdmb7.c	2004-03-25 20:07:25.000000000 +0100
@@ -50,7 +50,7 @@
 	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
 	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | 
-	      FE_CAN_CLEAN_SETUP | FE_CAN_RECOVER
+              FE_CAN_RECOVER
 };
 
 
@@ -390,8 +390,14 @@
         case FE_INIT:
 		return cx22700_init (i2c);
 
-        case FE_RESET:
-                break;
+	case FE_GET_TUNE_SETTINGS:
+	{
+	        struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+	        fesettings->min_delay_ms = 150;
+	        fesettings->step_size = 166667;
+	        fesettings->max_drift = 166667*2;
+	        return 0;
+	}	    
 
 	default:
 		return -EOPNOTSUPP;
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/at76c651.c linux-2.6.5-patched/drivers/media/dvb/frontends/at76c651.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/at76c651.c	2004-01-16 18:25:17.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/at76c651.c	2004-03-11 19:40:44.000000000 +0100
@@ -71,9 +71,7 @@
 	    FE_CAN_FEC_4_5 | FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 |
 	    FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 | FE_CAN_FEC_AUTO |
 	    FE_CAN_QAM_16 | FE_CAN_QAM_32 | FE_CAN_QAM_64 | FE_CAN_QAM_128 |
-	    FE_CAN_QAM_256 /* | FE_CAN_QAM_512 | FE_CAN_QAM_1024 */ |
-	    FE_CAN_RECOVER | FE_CAN_CLEAN_SETUP | FE_CAN_MUTE_TS
-
+	    FE_CAN_MUTE_TS | FE_CAN_QAM_256 | FE_CAN_RECOVER
 };
 
 #if ! defined(__powerpc__)
@@ -361,6 +358,7 @@
 	at76c651_set_symbolrate(i2c, p->u.qam.symbol_rate);
 	at76c651_set_inversion(i2c, p->inversion);
 	at76c651_set_auto_config(i2c);
+        at76c651_reset(i2c);
 
 	return 0;
 
@@ -462,8 +459,14 @@
 	case FE_INIT:
 		return at76c651_set_defaults(fe->i2c);
 
-	case FE_RESET:
-		return at76c651_reset(fe->i2c);
+	case FE_GET_TUNE_SETTINGS:
+	{
+	        struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+	        fesettings->min_delay_ms = 50;
+	        fesettings->step_size = 0;
+	        fesettings->max_drift = 0;
+	        return 0;
+	}	    
 
 	default:
 		return -ENOIOCTLCMD;
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/cx24110.c linux-2.6.5-patched/drivers/media/dvb/frontends/cx24110.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/cx24110.c	2004-01-16 18:25:17.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/cx24110.c	2004-04-08 17:10:52.000000000 +0200
@@ -59,8 +59,7 @@
 	.caps = FE_CAN_INVERSION_AUTO |
 		FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 		FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
-		FE_CAN_QPSK |
-		FE_CAN_CLEAN_SETUP
+		FE_CAN_QPSK | FE_CAN_RECOVER
 };
 /* fixme: are these values correct? especially ..._tolerance and caps */
 
@@ -621,11 +620,6 @@
         case FE_INIT:
 		return cx24110_init (i2c);
 
-	case FE_RESET:
-/* no idea what to do for this call */
-/* fixme (medium): fill me in */
-		break;
-
 	case FE_SET_TONE:
 		return cx24110_writereg(i2c,0x76,(cx24110_readreg(i2c,0x76)&~0x10)|((((fe_sec_tone_mode_t) arg)==SEC_TONE_ON)?0x10:0));
 	case FE_SET_VOLTAGE:
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/dst.c linux-2.6.5-patched/drivers/media/dvb/frontends/dst.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/dst.c	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/dst.c	2004-03-11 19:40:44.000000000 +0100
@@ -963,7 +963,6 @@
 	{FE_GET_FRONTEND,            "FE_GET_FRONTEND:" },
 	{FE_SLEEP,                   "FE_SLEEP:" },
 	{FE_INIT,                    "FE_INIT:" },
-	{FE_RESET,                   "FE_RESET:" },
 	{FE_SET_TONE,                "FE_SET_TONE:" },
 	{FE_SET_VOLTAGE,             "FE_SET_VOLTAGE:" },
 	};
@@ -1091,9 +1090,6 @@
 		dst_init(dst);
 		break;
 
-	case FE_RESET:
-		break;
-
 	case FE_DISEQC_SEND_MASTER_CMD:
 	{
 		struct dvb_diseqc_master_cmd *cmd = (struct dvb_diseqc_master_cmd *)arg;
@@ -1149,8 +1145,8 @@
 	}
 
 	dst_init (dst);
-	dprintk("%s: register dst %p bt %p i2c %p\n", __FUNCTION__, 
-		dst, dst->bt, dst->i2c);
+	dprintk("%s: register dst %8.8x bt %8.8x i2c %8.8x\n", __FUNCTION__, 
+			(u32)dst, (u32)(dst->bt), (u32)(dst->i2c));
 
 	info = &dst_info_sat;
 	if (dst->dst_type == DST_TYPE_IS_TERR)
@@ -1166,7 +1162,7 @@
 static void dst_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dvb_unregister_frontend (dst_ioctl, i2c);
-	dprintk("%s: unregister dst %p\n", __FUNCTION__, data);
+	dprintk("%s: unregister dst %8.8x\n", __FUNCTION__, (u32)(data));
 	if (data)
 		kfree(data);
 }
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/dvb_dummy_fe.c linux-2.6.5-patched/drivers/media/dvb/frontends/dvb_dummy_fe.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/dvb_dummy_fe.c	2003-12-18 03:58:38.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/dvb_dummy_fe.c	2004-03-11 19:40:44.000000000 +0100
@@ -62,8 +62,7 @@
 #endif
 	.caps = FE_CAN_QAM_16 | FE_CAN_QAM_32 | FE_CAN_QAM_64 |
 		FE_CAN_QAM_128 | FE_CAN_QAM_256 | 
-		FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO |
-		FE_CAN_CLEAN_SETUP
+		FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO
 };
 
 static struct dvb_frontend_info dvb_t_dummyfe_info = {
@@ -157,9 +156,6 @@
         case FE_INIT:
 		return 0;
 
-	case FE_RESET:
-		return 0;
-
 	case FE_SET_TONE:
 		return -EOPNOTSUPP;
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/grundig_29504-401.c linux-2.6.5-patched/drivers/media/dvb/frontends/grundig_29504-401.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/grundig_29504-401.c	2003-12-18 03:58:15.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/grundig_29504-401.c	2004-03-25 22:09:41.000000000 +0100
@@ -35,6 +35,9 @@
 
 #define dprintk	if (debug) printk
 
+struct grundig_state {
+	int first:1;
+};
 
 struct dvb_frontend_info grundig_29504_401_info = {
 	.name = "Grundig 29504-401",
@@ -48,7 +51,7 @@
 	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
 	      FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 |
-	      FE_CAN_MUTE_TS /*| FE_CAN_CLEAN_SETUP*/
+              FE_CAN_MUTE_TS
 };
 
 
@@ -102,6 +105,7 @@
  */
 static int tsa5060_set_tv_freq (struct dvb_i2c_bus *i2c, u32 freq)
 {
+#if 1
 	u32 div;
 	u8 buf [4];
 	u8 cfg, cpump, band_select;
@@ -118,6 +122,20 @@
 	buf [1] = div & 0xff;
 	buf [2] = ((div >> 10) & 0x60) | cfg;
 	buf [3] = (cpump << 6) | band_select;
+#else
+	/* old code which seems to work better for at least one person */
+        u32 div;
+        u8 buf [4];
+        u8 cfg;
+
+        div = (36000000 + freq) / 166666;
+        cfg = 0x88;
+
+        buf [0] = (div >> 8) & 0x7f;
+        buf [1] = div & 0xff;
+        buf [2] = ((div >> 10) & 0x60) | cfg;
+        buf [3] = 0xc0;
+#endif
 
 	return tsa5060_write (i2c, buf);
 }
@@ -276,6 +295,123 @@
 }
 
 
+static int get_frontend(struct dvb_i2c_bus* i2c, struct dvb_frontend_parameters* param)
+{
+	int tmp;
+
+
+	tmp = l64781_readreg(i2c, 0x04);
+	switch(tmp & 3) {
+	case 0: 
+		param->u.ofdm.guard_interval = GUARD_INTERVAL_1_32; 
+		break;
+	case 1:
+		param->u.ofdm.guard_interval = GUARD_INTERVAL_1_16;
+		break;
+	case 2:
+		param->u.ofdm.guard_interval = GUARD_INTERVAL_1_8; 
+		break;
+	case 3:
+		param->u.ofdm.guard_interval = GUARD_INTERVAL_1_4; 
+		break;
+	}
+	switch((tmp >> 2) & 3) {
+	case 0: 
+		param->u.ofdm.transmission_mode = TRANSMISSION_MODE_2K;
+		break;
+	case 1:
+		param->u.ofdm.transmission_mode = TRANSMISSION_MODE_8K;
+		break;
+	default:
+		printk("Unexpected value for transmission_mode\n");
+	}
+	
+	
+	
+	tmp = l64781_readreg(i2c, 0x05);
+	switch(tmp & 7) {
+	case 0: 
+		param->u.ofdm.code_rate_HP = FEC_1_2;
+		break;
+	case 1:
+		param->u.ofdm.code_rate_HP = FEC_2_3;
+		break;
+	case 2:
+		param->u.ofdm.code_rate_HP = FEC_3_4;
+		break;
+	case 3:
+		param->u.ofdm.code_rate_HP = FEC_5_6;
+		break;
+	case 4:
+		param->u.ofdm.code_rate_HP = FEC_7_8;
+		break;
+	default:
+		printk("Unexpected value for code_rate_HP\n");
+	}
+	switch((tmp >> 3) & 7) {
+	case 0: 
+		param->u.ofdm.code_rate_LP = FEC_1_2;
+		break;
+	case 1:
+		param->u.ofdm.code_rate_LP = FEC_2_3;
+		break;
+	case 2:
+		param->u.ofdm.code_rate_LP = FEC_3_4;
+		break;
+	case 3:
+		param->u.ofdm.code_rate_LP = FEC_5_6;
+		break;
+	case 4:
+		param->u.ofdm.code_rate_LP = FEC_7_8;
+		break;
+	default:
+		printk("Unexpected value for code_rate_LP\n");
+	}
+	
+	
+	tmp = l64781_readreg(i2c, 0x06);
+	switch(tmp & 3) {
+	case 0: 
+		param->u.ofdm.constellation = QPSK;
+		break;
+	case 1:
+		param->u.ofdm.constellation = QAM_16;
+		break;
+	case 2:
+		param->u.ofdm.constellation = QAM_64;
+		break;
+	default:
+		printk("Unexpected value for constellation\n");
+	}
+	switch((tmp >> 2) & 7) {
+	case 0: 
+		param->u.ofdm.hierarchy_information = HIERARCHY_NONE;
+		break;
+	case 1:
+		param->u.ofdm.hierarchy_information = HIERARCHY_1;
+		break;
+	case 2:
+		param->u.ofdm.hierarchy_information = HIERARCHY_2;
+		break;
+	case 3:
+		param->u.ofdm.hierarchy_information = HIERARCHY_4;
+		break;
+	default:
+		printk("Unexpected value for hierarchy\n");
+	}
+
+
+	tmp = l64781_readreg (i2c, 0x1d);
+	param->inversion = (tmp & 0x80) ? INVERSION_ON : INVERSION_OFF;
+
+	tmp = (int) (l64781_readreg (i2c, 0x08) | 
+		     (l64781_readreg (i2c, 0x09) << 8) |
+		     (l64781_readreg (i2c, 0x0a) << 16));
+	param->frequency += tmp;
+
+	return 0;
+}
+
 
 static int init (struct dvb_i2c_bus *i2c)
 {
@@ -318,6 +454,9 @@
 			     unsigned int cmd, void *arg)
 {
 	struct dvb_i2c_bus *i2c = fe->i2c;
+	int res;
+	struct grundig_state* state = (struct grundig_state*) fe->data;
+
         switch (cmd) {
         case FE_GET_INFO:
 		memcpy (arg, &grundig_29504_401_info,
@@ -393,18 +532,33 @@
 		tsa5060_set_tv_freq (i2c, p->frequency);
 		return apply_frontend_param (i2c, p);
 	}
+
         case FE_GET_FRONTEND:
-		/*  we could correct the frequency here, but...
-		 *  (...do you want to implement this?;)
-		 */
-		return 0;
+	{
+		struct dvb_frontend_parameters *p = arg;
+		return get_frontend(i2c, p);
+	}
 
 	case FE_SLEEP:
 		/* Power down */
 		return l64781_writereg (i2c, 0x3e, 0x5a);
 
 	case FE_INIT:
-		return init (i2c);
+		res = init (i2c);
+		if ((res == 0) && (state->first)) {
+			state->first = 0;
+			dvb_delay(200);
+		}
+		return res;
+
+	case FE_GET_TUNE_SETTINGS:
+	{
+	        struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+	        fesettings->min_delay_ms = 200;
+	        fesettings->step_size = 166667;
+	        fesettings->max_drift = 166667*2;
+	        return 0;
+	}
 
         default:
 		dprintk ("%s: unknown command !!!\n", __FUNCTION__);
@@ -422,6 +576,7 @@
 	u8 b1 [] = { 0x00 };
 	struct i2c_msg msg [] = { { .addr = 0x55, .flags = 0, .buf = b0, .len = 1 },
 			   { .addr = 0x55, .flags = I2C_M_RD, .buf = b1, .len = 1 } };
+	struct grundig_state* state;
 
 	/**
 	 *  the L64781 won't show up before we send the reset_and_configure()
@@ -465,7 +620,12 @@
 	        goto bailout;
 	}
 
-	return dvb_register_frontend (grundig_29504_401_ioctl, i2c, NULL,
+	state = kmalloc(sizeof(struct grundig_state), GFP_KERNEL);
+	if (state == NULL) goto bailout;
+	*data = state;
+	state->first = 1;
+
+	return dvb_register_frontend (grundig_29504_401_ioctl, i2c, state,
 			       &grundig_29504_401_info);
 
  bailout:
@@ -477,6 +637,7 @@
 
 static void l64781_detach (struct dvb_i2c_bus *i2c, void *data)
 {
+	kfree(data);
 	dvb_unregister_frontend (grundig_29504_401_ioctl, i2c);
 }
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/grundig_29504-491.c linux-2.6.5-patched/drivers/media/dvb/frontends/grundig_29504-491.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/grundig_29504-491.c	2003-12-18 03:59:20.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/grundig_29504-491.c	2004-03-11 19:40:44.000000000 +0100
@@ -52,8 +52,7 @@
 		FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 		FE_CAN_FEC_4_5 | FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 |
 		FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 | FE_CAN_FEC_AUTO |
-		FE_CAN_QPSK |
-		FE_CAN_MUTE_TS | FE_CAN_CLEAN_SETUP
+		FE_CAN_QPSK | FE_CAN_MUTE_TS
 };
 
 
@@ -398,11 +397,6 @@
 		tda8083_writereg (i2c, 0x00, 0x04);
 		break;
 
-	case FE_RESET:
-		tda8083_writereg (i2c, 0x00, 0x3c);
-		tda8083_writereg (i2c, 0x00, 0x04);
-		break;
-
 	case FE_DISEQC_SEND_MASTER_CMD:
 		return tda8083_send_diseqc_msg (i2c, arg);
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/mt312.c linux-2.6.5-patched/drivers/media/dvb/frontends/mt312.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/mt312.c	2004-01-16 18:25:17.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/mt312.c	2004-03-11 19:40:44.000000000 +0100
@@ -66,8 +66,8 @@
 	.caps =
 	    FE_CAN_INVERSION_AUTO | FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 |
 	    FE_CAN_FEC_3_4 | FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
-	    FE_CAN_FEC_AUTO | FE_CAN_QPSK | FE_CAN_RECOVER |
-	    FE_CAN_CLEAN_SETUP | FE_CAN_MUTE_TS
+	    FE_CAN_FEC_AUTO | FE_CAN_QPSK | FE_CAN_MUTE_TS | 
+            FE_CAN_RECOVER
 };
 
 static int mt312_read(struct dvb_i2c_bus *i2c,
@@ -570,6 +570,8 @@
 	if ((ret = mt312_write(i2c, SYM_RATE_H, buf, sizeof(buf))) < 0)
 		return ret;
 
+        mt312_reset(i2c, 0);
+
 	return 0;
 }
 
@@ -756,8 +758,14 @@
 		else
 			return mt312_init(i2c, (long) fe->data, (u8) 60);
 
-	case FE_RESET:
-		return mt312_reset(i2c, 0);
+	case FE_GET_TUNE_SETTINGS:
+	{
+	        struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+	        fesettings->min_delay_ms = 50;
+	        fesettings->step_size = 0;
+	        fesettings->max_drift = 0;
+	        return 0;
+	}	    
 
 	default:
 		return -ENOIOCTLCMD;
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/nxt6000.c linux-2.6.5-patched/drivers/media/dvb/frontends/nxt6000.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/nxt6000.c	2004-03-12 20:31:28.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/nxt6000.c	2004-03-11 19:40:44.000000000 +0100
@@ -55,7 +52,12 @@
 	.symbol_rate_max = 9360000,	/* FIXME */
 	.symbol_rate_tolerance = 4000,
 	.notifier_delay = 0,
-	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 | FE_CAN_FEC_4_5 | FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 | FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 | FE_CAN_FEC_AUTO | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO | FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO | FE_CAN_HIERARCHY_AUTO,
+	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 | 
+                FE_CAN_FEC_4_5 | FE_CAN_FEC_5_6 | FE_CAN_FEC_6_7 | 
+                FE_CAN_FEC_7_8 | FE_CAN_FEC_8_9 | FE_CAN_FEC_AUTO | 
+                FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_QAM_AUTO | 
+                FE_CAN_TRANSMISSION_MODE_AUTO | FE_CAN_GUARD_INTERVAL_AUTO | 
+                FE_CAN_HIERARCHY_AUTO,
 };
 
 struct nxt6000_config {
@@ -762,9 +662,6 @@
 			nxt6000_setup(fe);
 		break;
 
-	case FE_RESET:
-			break;
-		
 		case FE_SET_FRONTEND:
 		{
 			struct nxt6000_config *nxt = FE2NXT(fe);
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/sp887x.c linux-2.6.5-patched/drivers/media/dvb/frontends/sp887x.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/sp887x.c	2004-04-09 17:42:17.000000000 +0200
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/sp887x.c	2004-03-11 19:40:44.000000000 +0100
@@ -12,13 +12,13 @@
    next 0x4000 loaded. This may change in future versions.
  */
 
+#define __KERNEL_SYSCALLS__
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/syscalls.h>
 #include <linux/fs.h>
 #include <linux/unistd.h>
 #include <linux/fcntl.h>
@@ -64,19 +64,17 @@
 	.frequency_stepsize = 166666,
 	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 		FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 | FE_CAN_FEC_AUTO |
-		FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 | FE_CAN_RECOVER
+		FE_CAN_QPSK | FE_CAN_QAM_16 | FE_CAN_QAM_64 |
+                FE_CAN_RECOVER
 };
 
+static int errno;
+
 static
 int i2c_writebytes (struct dvb_frontend *fe, u8 addr, u8 *buf, u8 len)
 {
 	struct dvb_i2c_bus *i2c = fe->i2c;
-	struct i2c_msg msg = {
-		.addr	= addr,
-		.flags	= 0,
-		.buf	= buf,
-		.len	= len
-	};
+	struct i2c_msg msg = { .addr = addr, .flags = 0, .buf = buf, .len = len };
 	int err;
 
 	LOG("i2c_writebytes", msg.addr, msg.buf, msg.len);
@@ -213,13 +211,13 @@
 
 	// Load the firmware
 	set_fs(get_ds());
-	fd = sys_open(sp887x_firmware, 0, 0);
+	fd = open(sp887x_firmware, 0, 0);
 	if (fd < 0) {
 		printk(KERN_WARNING "%s: Unable to open firmware %s\n", __FUNCTION__,
 		       sp887x_firmware);
 		return -EIO;
 	}
-	filesize = sys_lseek(fd, 0L, 2);
+	filesize = lseek(fd, 0L, 2);
 	if (filesize <= 0) {
 		printk(KERN_WARNING "%s: Firmware %s is empty\n", __FUNCTION__,
 		       sp887x_firmware);
@@ -241,8 +239,8 @@
 	// read it!
 	// read the first 16384 bytes from the file
 	// ignore the first 10 bytes
-	sys_lseek(fd, 10, 0);
-	if (sys_read(fd, firmware, fw_size) != fw_size) {
+	lseek(fd, 10, 0);
+	if (read(fd, firmware, fw_size) != fw_size) {
 		printk(KERN_WARNING "%s: Failed to read firmware\n", __FUNCTION__);
 		vfree(firmware);
 		sys_close(fd);
@@ -635,6 +633,15 @@
 		sp887x_writereg(fe, 0xc18, 0x00d);
 		break;
 
+	case FE_GET_TUNE_SETTINGS:
+	{
+	        struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+	        fesettings->min_delay_ms = 50;
+	        fesettings->step_size = 0;
+	        fesettings->max_drift = 0;
+	        return 0;
+	}	    
+
 	default:
 		return -EOPNOTSUPP;
         };
@@ -647,12 +654,7 @@
 static
 int sp887x_attach (struct dvb_i2c_bus *i2c, void **data)
 {
-	struct i2c_msg msg = {
-		.addr	= 0x70,
-		.flags	= 0,
-		.buf	= NULL,
-		.len	= 0
-	};
+	struct i2c_msg msg = {.addr = 0x70, .flags = 0, .buf = NULL, .len = 0 };
 
 	dprintk ("%s\n", __FUNCTION__);
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/stv0299.c linux-2.6.5-patched/drivers/media/dvb/frontends/stv0299.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/stv0299.c	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/stv0299.c	2004-03-19 18:13:55.000000000 +0100
@@ -49,6 +49,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
+#include <linux/slab.h>
 #include <asm/div64.h>
 
 #include "dvb_frontend.h"
@@ -61,6 +62,7 @@
 #endif
 
 static int stv0299_status = 0;
+static int disable_typhoon = 0;
 
 #define STATUS_BER 0
 #define STATUS_UCBLOCKS 1
@@ -68,12 +70,13 @@
 
 /* frontend types */
 #define UNKNOWN_FRONTEND  -1
-#define PHILIPS_SU1278_TSA      0 // SU1278 with TSA5959 synth and datasheet recommended settings
+#define PHILIPS_SU1278_TSA	0 // SU1278 with TSA5059 synth and datasheet recommended settings
 #define ALPS_BSRU6         1
 #define LG_TDQF_S001F      2
 #define PHILIPS_SU1278_TUA      3 // SU1278 with TUA6100 synth
 #define SAMSUNG_TBMU24112IMB    4
-#define PHILIPS_SU1278_TSA_TT   5 // SU1278 with TSA5959 synth and TechnoTrend settings
+#define PHILIPS_SU1278_TSA_TT	5 // SU1278 with TSA5059 synth and TechnoTrend settings
+#define PHILIPS_SU1278_TSA_TY	6 // SU1278 with TUA5059 synth and Typhoon wiring
 
 /* Master Clock = 88 MHz */
 #define M_CLK (88000000UL) 
@@ -95,8 +98,16 @@
 	.caps = FE_CAN_FEC_1_2 | FE_CAN_FEC_2_3 | FE_CAN_FEC_3_4 |
 	      FE_CAN_FEC_5_6 | FE_CAN_FEC_7_8 |
 	      FE_CAN_QPSK |
-	      FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO |
-	      FE_CAN_CLEAN_SETUP
+	      FE_CAN_FEC_AUTO
+};
+
+
+struct stv0299_state {
+	u8 tuner_type;
+	u8 initialised:1;
+	u32 tuner_frequency;
+	u32 symbol_rate;
+	fe_code_rate_t fec_inner;
 };
 
 
@@ -253,6 +264,9 @@
         0x34, 0x13
 };
 
+static int stv0299_set_FEC (struct dvb_i2c_bus *i2c, fe_code_rate_t fec);
+static int stv0299_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate, int tuner_type);
+
 static int stv0299_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
 {
 	int ret;
@@ -305,12 +319,8 @@
 static int pll_write (struct dvb_i2c_bus *i2c, u8 addr, u8 *data, int len)
 {
 	int ret;
-	struct i2c_msg msg = {
-		.addr = addr,
-		.flags = 0,
-		.buf = data,
-		.len = len
-	};
+	struct i2c_msg msg = { addr: addr, .flags = 0, .buf = data, .len = len };
+
 
 	stv0299_writereg(i2c, 0x05, 0xb5);	/*  enable i2c repeater on stv0299  */
 
@@ -353,17 +363,22 @@
 	u8 addr;
 	u32 div;
 	u8 buf[4];
-        int i, divisor, regcode;
+	int divisor, regcode;
 
 	dprintk ("%s: freq %i, ftype %i\n", __FUNCTION__, freq, ftype);
 
 	if ((freq < 950000) || (freq > 2150000)) return -EINVAL;
 
+	if (ftype == PHILIPS_SU1278_TSA_TT) {
         divisor = 500;
         regcode = 2;
+	} else {
+		divisor = 125;
+		regcode = 4;
+	}
 
 	// setup frequency divisor
-	div = freq / divisor;
+	div = (freq + (divisor - 1)) / divisor; // round correctly
 	buf[0] = (div >> 8) & 0x7f;
 	buf[1] = div & 0xff;
 	buf[2] = 0x80 | ((div & 0x18000) >> 10) | regcode;
@@ -373,7 +388,12 @@
 	switch(ftype) {
 	case PHILIPS_SU1278_TSA:
 	case PHILIPS_SU1278_TSA_TT:
+	case PHILIPS_SU1278_TSA_TY:
+		if (ftype == PHILIPS_SU1278_TSA_TY)
+			addr = 0x61;
+		else
 		addr = 0x60;
+
 		buf[3] |= 0x20;
 
 		if (srate < 4000000) buf[3] |= 1;
@@ -378,15 +398,16 @@
 
 		if (srate < 4000000) buf[3] |= 1;
 	   
-		if (freq <= 1250000) buf[3] |= 0;
-		else if (freq <= 1550000) buf[3] |= 0x40;
-		else if (freq <= 2050000) buf[3] |= 0x80;
-		else if (freq <= 2150000) buf[3] |= 0xC0;
+		if (freq < 1250000) buf[3] |= 0;
+		else if (freq < 1550000) buf[3] |= 0x40;
+		else if (freq < 2050000) buf[3] |= 0x80;
+		else if (freq < 2150000) buf[3] |= 0xC0;
 		break;
 
 	case ALPS_BSRU6:
 		addr = 0x61;
-		buf[3] |= 0xC0;
+		buf[3] = 0xC4;
+		if (freq > 1530000) buf[3] = 0xc0;
 	 	break;
 
 	default:
@@ -595,7 +616,7 @@
 		stv0299_writereg (i2c, init_tab[i], init_tab[i+1]);
 
         /* AGC1 reference register setup */
-		if (ftype == PHILIPS_SU1278_TSA)
+		if (ftype == PHILIPS_SU1278_TSA || ftype == PHILIPS_SU1278_TSA_TY)
 		  stv0299_writereg (i2c, 0x0f, 0x92);  /* Iagc = Inverse, m1 = 18 */
 		else if (ftype == PHILIPS_SU1278_TUA)
 		  stv0299_writereg (i2c, 0x0f, 0x94);  /* Iagc = Inverse, m1 = 20 */
@@ -618,23 +639,6 @@
 }
 
 
-static int stv0299_check_inversion (struct dvb_i2c_bus *i2c)
-{
-	dprintk ("%s\n", __FUNCTION__);
-
-	if ((stv0299_readreg (i2c, 0x1b) & 0x98) != 0x98) {
-		dvb_delay(30);
-		if ((stv0299_readreg (i2c, 0x1b) & 0x98) != 0x98) {
-		u8 val = stv0299_readreg (i2c, 0x0c);
-			dprintk ("%s : changing inversion\n", __FUNCTION__);
-		return stv0299_writereg (i2c, 0x0c, val ^ 0x01);
-	}
-	}
-
-	return 0;
-}
-
-
 static int stv0299_set_FEC (struct dvb_i2c_bus *i2c, fe_code_rate_t fec)
 {
 	dprintk ("%s\n", __FUNCTION__);
@@ -824,7 +828,8 @@
 }
 
 
-static int stv0299_set_voltage (struct dvb_i2c_bus *i2c, fe_sec_voltage_t voltage)
+static int stv0299_set_voltage (struct dvb_i2c_bus *i2c, fe_sec_voltage_t voltage,
+				int tuner_type)
 {
 	u8 reg0x08;
 	u8 reg0x0c;
@@ -842,22 +847,26 @@
 	reg0x0c &= 0x0f;
 
 	if (voltage == SEC_VOLTAGE_OFF) {
-		stv0299_writereg (i2c, 0x08, reg0x08 & ~0x40);
-		return stv0299_writereg (i2c, 0x0c, reg0x0c & ~0x40);
-	} else {
+		stv0299_writereg (i2c, 0x0c, 0x00); /*	LNB power off! */
+		return stv0299_writereg (i2c, 0x08, 0x00); /*	LNB power off! */
+	}
+	
 		stv0299_writereg (i2c, 0x08, reg0x08 | 0x40);
-		reg0x0c |= 0x40;   /* LNB power on */
 
 	switch (voltage) {
 	case SEC_VOLTAGE_13:
-			return stv0299_writereg (i2c, 0x0c, reg0x0c);
-	case SEC_VOLTAGE_18:
+		if (tuner_type == PHILIPS_SU1278_TSA_TY)
 			return stv0299_writereg (i2c, 0x0c, reg0x0c | 0x10);
+		else
+			return stv0299_writereg (i2c, 0x0c, reg0x0c | 0x40);
+
+	case SEC_VOLTAGE_18:
+		return stv0299_writereg (i2c, 0x0c, reg0x0c | 0x50);
+
 	default:
 		return -EINVAL;
 	};
 }
-}
 
 
 static int stv0299_set_symbolrate (struct dvb_i2c_bus *i2c, u32 srate, int tuner_type)
@@ -875,6 +884,7 @@
         // calculate value to program
 	if (tuner_type == PHILIPS_SU1278_TSA_TT) Mclk = M_CLK_SU1278_TSA_TT;
         big = big << 20;
+	big += (Mclk-1); // round correctly
         do_div(big, Mclk);
         ratio = big << 4;
 
@@ -909,6 +920,7 @@
 	        stv0299_writereg (i2c, 0x21, (ratio      ) & 0xf0);
 	        break;
 
+	case PHILIPS_SU1278_TSA_TY:
 	case PHILIPS_SU1278_TSA:
 		aclk = 0xb5;
 		if (srate < 2000000) bclk = 0x86;
@@ -929,20 +941,18 @@
 
 	case ALPS_BSRU6:
 	default:
-		if (srate <= 1500000) { aclk = 0xb7; bclk = 0x87; }
-		else if (srate <= 3000000) { aclk = 0xb7; bclk = 0x8b; }
-		else if (srate <= 7000000) { aclk = 0xb7; bclk = 0x8f; }
-		else if (srate <= 14000000) { aclk = 0xb7; bclk = 0x93; }
-		else if (srate <= 30000000) { aclk = 0xb6; bclk = 0x93; }
-		else if (srate <= 45000000) { aclk = 0xb4; bclk = 0x91; }
-		m1 = 0x12;
+		if (srate < 1500000) { aclk = 0xb7; bclk = 0x47; }
+		else if (srate < 3000000) { aclk = 0xb7; bclk = 0x4b; }
+		else if (srate < 7000000) { aclk = 0xb7; bclk = 0x4f; }
+		else if (srate < 14000000) { aclk = 0xb7; bclk = 0x53; }
+		else if (srate < 30000000) { aclk = 0xb6; bclk = 0x53; }
+		else if (srate < 45000000) { aclk = 0xb4; bclk = 0x51; }
   
 	stv0299_writereg (i2c, 0x13, aclk);
 	stv0299_writereg (i2c, 0x14, bclk);
 	stv0299_writereg (i2c, 0x1f, (ratio >> 16) & 0xff);
 	stv0299_writereg (i2c, 0x20, (ratio >>  8) & 0xff);
 	stv0299_writereg (i2c, 0x21, (ratio      ) & 0xf0);
-	stv0299_writereg (i2c, 0x0f, (stv0299_readreg(i2c, 0x0f) & 0xc0) | m1);
 		break;
 	}
 
@@ -986,11 +995,10 @@
 	return srate;
 }
 
-
 static int uni0299_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
-        int tuner_type = (long) fe->data;
 	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct stv0299_state *state = (struct stv0299_state *) fe->data;
 
 	dprintk ("%s\n", __FUNCTION__);
 
@@ -1000,7 +1008,7 @@
 	        struct dvb_frontend_info* tmp = (struct dvb_frontend_info*) arg;
 		memcpy (arg, &uni0299_info, sizeof(struct dvb_frontend_info));
 
-	        if (tuner_type == PHILIPS_SU1278_TSA_TT) {
+		if (state->tuner_type == PHILIPS_SU1278_TSA_TT) {
 		        tmp->frequency_tolerance = M_CLK_SU1278_TSA_TT / 2000;
 		}
 		break;
@@ -1078,23 +1086,67 @@
         case FE_SET_FRONTEND:
         {
 		struct dvb_frontend_parameters *p = arg;
+		int invval = 0;
 
 		dprintk ("%s : FE_SET_FRONTEND\n", __FUNCTION__);
 
-		pll_set_tv_freq (i2c, p->frequency, tuner_type,
-				 p->u.qpsk.symbol_rate);
+		// set the inversion
+		if (p->inversion == INVERSION_OFF) invval = 0;
+		else if (p->inversion == INVERSION_ON) invval = 1;
+		else {
+			printk("stv0299 does not support auto-inversion\n");
+			return -EINVAL;
+		}
+		if (state->tuner_type == ALPS_BSRU6) invval = (~invval) & 1;
+		stv0299_writereg(i2c, 0x0c, (stv0299_readreg(i2c, 0x0c) & 0xfe) | invval);
+
+		switch(state->tuner_type) {
+		case PHILIPS_SU1278_TSA_TT: 
+		{
+			/* check if we should do a finetune */
+			int frequency_delta = p->frequency - state->tuner_frequency;
+			int minmax = p->u.qpsk.symbol_rate / 2000;
+			if (minmax < 5000) minmax = 5000;
+		   
+			if ((frequency_delta > -minmax) && (frequency_delta < minmax) && (frequency_delta != 0) &&
+			    (state->fec_inner == p->u.qpsk.fec_inner) && 
+			    (state->symbol_rate == p->u.qpsk.symbol_rate)) {
+				int Drot_freq = (frequency_delta << 16) / (M_CLK_SU1278_TSA_TT / 1000);
+
+				// zap the derotator registers first
+				stv0299_writereg (i2c, 0x22, 0x00); 
+				stv0299_writereg (i2c, 0x23, 0x00);
 
+				// now set them as we want
+				stv0299_writereg (i2c, 0x22, Drot_freq >> 8);
+				stv0299_writereg (i2c, 0x23, Drot_freq);
+			} else {
+				/* A "normal" tune is requested */
+				pll_set_tv_freq (i2c, p->frequency, state->tuner_type, p->u.qpsk.symbol_rate);
+				stv0299_writereg (i2c, 0x32, 0x80);
+				stv0299_writereg (i2c, 0x22, 0x00);
+				stv0299_writereg (i2c, 0x23, 0x00);
+				stv0299_writereg (i2c, 0x32, 0x19);
+				stv0299_set_symbolrate (i2c, p->u.qpsk.symbol_rate, state->tuner_type);
                 stv0299_set_FEC (i2c, p->u.qpsk.fec_inner);
-                stv0299_set_symbolrate (i2c, p->u.qpsk.symbol_rate, tuner_type);
+			}
+			break;
+		}
+		    
+		default:
+			pll_set_tv_freq (i2c, p->frequency, state->tuner_type, p->u.qpsk.symbol_rate);
+			stv0299_set_FEC (i2c, p->u.qpsk.fec_inner);
+			stv0299_set_symbolrate (i2c, p->u.qpsk.symbol_rate, state->tuner_type);
 		stv0299_writereg (i2c, 0x22, 0x00);
 		stv0299_writereg (i2c, 0x23, 0x00);
-	        if (tuner_type != PHILIPS_SU1278_TSA_TT) {
 		stv0299_readreg (i2c, 0x23);
 		stv0299_writereg (i2c, 0x12, 0xb9);
+			break;
 		}
-		stv0299_check_inversion (i2c);
 
-		/* printk ("%s: tsa5059 status: %x\n", __FUNCTION__, tsa5059_read_status(i2c)); */
+		state->tuner_frequency = p->frequency;
+		state->fec_inner = p->u.qpsk.fec_inner;
+		state->symbol_rate = p->u.qpsk.symbol_rate;
                 break;
         }
 
@@ -1103,8 +1155,9 @@
 		struct dvb_frontend_parameters *p = arg;
 		s32 derot_freq;
 	        int Mclk = M_CLK;
+		int invval;
 
-	        if (tuner_type == PHILIPS_SU1278_TSA_TT) Mclk = M_CLK_SU1278_TSA_TT;
+		if (state->tuner_type == PHILIPS_SU1278_TSA_TT) Mclk = M_CLK_SU1278_TSA_TT;
 
 		derot_freq = (s32)(s16) ((stv0299_readreg (i2c, 0x22) << 8)
 					| stv0299_readreg (i2c, 0x23));
@@ -1114,10 +1167,13 @@
 		derot_freq /= 1000;
 
 		p->frequency += derot_freq;
-		p->inversion = (stv0299_readreg (i2c, 0x0c) & 1) ?
-						INVERSION_OFF : INVERSION_ON;
+
+		invval = stv0299_readreg (i2c, 0x0c) & 1;
+		if (state->tuner_type == ALPS_BSRU6) invval = (~invval) & 1;
+		p->inversion = invval ? INVERSION_ON : INVERSION_OFF;
+
 		p->u.qpsk.fec_inner = stv0299_get_fec (i2c);
-		p->u.qpsk.symbol_rate = stv0299_get_symbolrate (i2c, tuner_type);
+		p->u.qpsk.symbol_rate = stv0299_get_symbolrate (i2c, state->tuner_type);
                 break;
         }
 
@@ -1125,10 +1181,23 @@
 		stv0299_writereg (i2c, 0x0c, 0x00);  /*  LNB power off! */
 		stv0299_writereg (i2c, 0x08, 0x00); /*  LNB power off! */
 		stv0299_writereg (i2c, 0x02, 0x80);
+		state->initialised = 0;
 		break;
 
         case FE_INIT:
-		return stv0299_init (i2c, tuner_type);
+		switch(state->tuner_type) {
+		case PHILIPS_SU1278_TSA_TT:
+			state->tuner_frequency = 0;
+			if (!state->initialised) {
+				state->initialised = 1;
+				return stv0299_init (i2c, state->tuner_type);
+			}
+			break;
+
+		default:
+			return stv0299_init (i2c, state->tuner_type);
+		}
+		break;
 
 	case FE_DISEQC_SEND_MASTER_CMD:
 		return stv0299_send_diseqc_msg (i2c, arg);
@@ -1140,7 +1209,39 @@
 		return stv0299_set_tone (i2c, (fe_sec_tone_mode_t) arg);
 
 	case FE_SET_VOLTAGE:
-		return stv0299_set_voltage (i2c, (fe_sec_voltage_t) arg);
+		return stv0299_set_voltage (i2c, (fe_sec_voltage_t) arg,
+					    state->tuner_type);
+
+	case FE_GET_TUNE_SETTINGS:
+	{
+		struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+	    
+		switch(state->tuner_type) {
+		case PHILIPS_SU1278_TSA_TT:
+			fesettings->min_delay_ms = 50;
+			if (fesettings->parameters.u.qpsk.symbol_rate < 10000000) {
+				fesettings->step_size = fesettings->parameters.u.qpsk.symbol_rate / 32000;
+				fesettings->max_drift = 5000;
+			} else {
+				fesettings->step_size = fesettings->parameters.u.qpsk.symbol_rate / 16000;
+				fesettings->max_drift = fesettings->parameters.u.qpsk.symbol_rate / 2000;
+			}
+			break;
+
+		default:
+			fesettings->min_delay_ms = 100;
+			if (fesettings->parameters.u.qpsk.symbol_rate < 10000000) {
+				fesettings->step_size = fesettings->parameters.u.qpsk.symbol_rate / 32000;
+				fesettings->max_drift = 5000;
+			} else {
+				fesettings->step_size = fesettings->parameters.u.qpsk.symbol_rate / 16000;
+				fesettings->max_drift = fesettings->parameters.u.qpsk.symbol_rate / 2000;
+			}
+			break;		    
+		}
+
+		return 0;
+	}
 
 	default:
 		return -EOPNOTSUPP;
@@ -1158,48 +1259,12 @@
         u8 stat [] = { 0 };
 	u8 tda6100_buf [] = { 0, 0 };
 	int ret;
-	struct i2c_msg msg1 [] = {
-		{
-			.addr	= 0x68,
-			.flags	= 0,
-			.buf	= rpt,
-			.len	= 2
-		},
-		{
-			.addr	= 0x60,
-			.flags	= I2C_M_RD,
-			.buf	= stat,
-			.len	= 1
-		}
-	};
-	struct i2c_msg msg2 [] = {
-		{
-			.addr	= 0x68,
-			.flags	= 0,
-			.buf	= rpt,
-			.len	= 2
-		},
-		{
-			.addr	= 0x61,
-			.flags	= I2C_M_RD,
-			.buf	= stat,
-			.len	= 1
-		}
-	};
-	struct i2c_msg msg3 [] = {
-		{
-			.addr	= 0x68,
-			.flags	= 0,
-			.buf	= rpt,
-			.len	= 2
-		},
-		{
-			.addr	= 0x60,
-			.flags	= 0,
-			.buf	= tda6100_buf,
-			.len	= 2
-		}
-	};
+	struct i2c_msg msg1 [] = {{ .addr = 0x68, .flags = 0, .buf = rpt,  len: 2 },
+			   { .addr = 0x60, .flags = I2C_M_RD, .buf = stat, .len = 1 }};
+	struct i2c_msg msg2 [] = {{ .addr = 0x68, .flags = 0, .buf = rpt,  len: 2 },
+			   { .addr = 0x61, .flags = I2C_M_RD, .buf = stat, .len = 1 }};
+	struct i2c_msg msg3 [] = {{ .addr = 0x68, .flags = 0, .buf = rpt,  len: 2 },
+			   { .addr = 0x60, .flags = 0, .buf = tda6100_buf, .len = 2 }};
 
 	stv0299_writereg (i2c, 0x01, 0x15);
 	stv0299_writereg (i2c, 0x02, 0x30);
@@ -1218,18 +1283,28 @@
 	if ((ret = i2c->xfer(i2c, msg1, 2)) == 2) {
 	        if ( strcmp(adapter->name, "TT-Budget/WinTV-NOVA-CI PCI") == 0 ) {
 		        // technotrend cards require non-datasheet settings
-		        printk ("%s: setup for tuner SU1278 (TSA5959 synth) on TechnoTrend hardware\n", __FILE__);
+			printk ("%s: setup for tuner SU1278 (TSA5059 synth) on"
+				" TechnoTrend hardware\n", __FILE__);
 		        return PHILIPS_SU1278_TSA_TT;
 		}  else {
 		        // fall back to datasheet-recommended settings
-		        printk ("%s: setup for tuner SU1278 (TSA5959 synth)\n", __FILE__);
+			printk ("%s: setup for tuner SU1278 (TSA5059 synth)\n",
+				__FILE__);
 		        return PHILIPS_SU1278_TSA;
 		}
 		}
 
 	if ((ret = i2c->xfer(i2c, msg2, 2)) == 2) {
-		//if ((stat[0] & 0x3f) == 0) {
-		if (0) {	
+		if ( strcmp(adapter->name, "KNC1 DVB-S") == 0 &&
+		     !disable_typhoon )
+		{
+			// Typhoon cards have unusual wiring.
+			printk ("%s: setup for tuner SU1278 (TSA5059 synth) on"
+				" Typhoon hardware\n", __FILE__);
+			return PHILIPS_SU1278_TSA_TY;
+		}
+		//else if ((stat[0] & 0x3f) == 0) {
+		else if (0) {
 			printk ("%s: setup for tuner TDQF-S001F\n", __FILE__);
 			return LG_TDQF_S001F;
 	} else {
@@ -1245,7 +1320,8 @@
 	stv0299_writereg (i2c, 0x02, 0x00);
 
 	if ((ret = i2c->xfer(i2c, msg3, 2)) == 2) {
-		printk ("%s: setup for tuner Philips SU1278 (TUA6100 synth)\n", __FILE__);
+		printk ("%s: setup for tuner Philips SU1278 (TUA6100 synth)\n",
+			__FILE__);
 		return PHILIPS_SU1278_TUA;
 	}
 
@@ -1259,10 +1335,12 @@
 
 static int uni0299_attach (struct dvb_i2c_bus *i2c, void **data)
 {
-        long tuner_type;
+	struct stv0299_state* state;
+	int tuner_type;
 	u8 id;
  
-	stv0299_writereg (i2c, 0x02, 0x00); /* standby off */
+	stv0299_writereg (i2c, 0x02, 0x34); /* standby off */
+	dvb_delay(200);
 	id = stv0299_readreg (i2c, 0x00);
 
 	dprintk ("%s: id == 0x%02x\n", __FUNCTION__, id);
@@ -1275,7 +1353,15 @@
 	if ((tuner_type = probe_tuner(i2c)) < 0)
 		return -ENODEV;
 
-	return dvb_register_frontend (uni0299_ioctl, i2c, (void*) tuner_type, 
+	if ((state = kmalloc(sizeof(struct stv0299_state), GFP_KERNEL)) == NULL) {
+		return -ENOMEM;
+	}
+
+	*data = state;
+	state->tuner_type = tuner_type;
+	state->tuner_frequency = 0;
+	state->initialised = 0;
+	return dvb_register_frontend (uni0299_ioctl, i2c, (void *) state,
 			       &uni0299_info);
 }
 
@@ -1283,6 +1369,7 @@
 static void uni0299_detach (struct dvb_i2c_bus *i2c, void *data)
 {
 	dprintk ("%s\n", __FUNCTION__);
+	kfree(data);
 	dvb_unregister_frontend (uni0299_ioctl, i2c);
 }
 
@@ -1305,8 +1391,11 @@
 module_exit (exit_uni0299);
 
 MODULE_DESCRIPTION("Universal STV0299/TSA5059/SL1935 DVB Frontend driver");
-MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Peter Schildmann, Felix Domke, Andreas Oberritter");
+MODULE_AUTHOR("Ralph Metzler, Holger Waechtler, Peter Schildmann, Felix Domke, Andreas Oberritter, Andrew de Quincey");
 MODULE_LICENSE("GPL");
 
 MODULE_PARM(stv0299_status, "i");
 MODULE_PARM_DESC(stv0299_status, "Which status value to support (0: BER, 1: UCBLOCKS)");
+
+MODULE_PARM(disable_typhoon, "i");
+MODULE_PARM_DESC(disable_typhoon, "Disable support for Philips SU1278 on Typhoon hardware.");
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/tda1004x.c linux-2.6.5-patched/drivers/media/dvb/frontends/tda1004x.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/tda1004x.c	2004-04-09 17:42:17.000000000 +0200
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/tda1004x.c	2004-04-23 10:55:47.000000000 +0200
@@ -32,14 +32,15 @@
  */
 
 
+#define __KERNEL_SYSCALLS__
 #include <linux/kernel.h>
 #include <linux/vmalloc.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/syscalls.h>
 #include <linux/fs.h>
+#include <linux/unistd.h>
 #include <linux/fcntl.h>
 #include <linux/errno.h>
 #include "dvb_frontend.h"
@@ -167,7 +168,6 @@
 };
 
 
-#pragma pack(1)
 struct tda1004x_state {
 	u8 tda1004x_address;
 	u8 tuner_address;
@@ -175,7 +175,7 @@
         u8 tuner_type:2;
         u8 fe_type:2;
 };
-#pragma pack()
+
 
 struct fwinfo {
 	int file_size;
@@ -397,13 +396,13 @@
 
 	// Load the firmware
 	set_fs(get_ds());
-	fd = sys_open(tda1004x_firmware, 0, 0);
+	fd = open(tda1004x_firmware, 0, 0);
 	if (fd < 0) {
 		printk("%s: Unable to open firmware %s\n", __FUNCTION__,
 		       tda1004x_firmware);
 		return -EIO;
 	}
-	filesize = sys_lseek(fd, 0L, 2);
+	filesize = lseek(fd, 0L, 2);
 	if (filesize <= 0) {
 		printk("%s: Firmware %s is empty\n", __FUNCTION__,
 		       tda1004x_firmware);
@@ -434,8 +433,8 @@
 	}
 
 	// read it!
-        sys_lseek(fd, fw_offset, 0);
-	if (sys_read(fd, firmware, fw_size) != fw_size) {
+	lseek(fd, fw_offset, 0);
+	if (read(fd, firmware, fw_size) != fw_size) {
 		printk("%s: Failed to read firmware\n", __FUNCTION__);
 		vfree(firmware);
 		sys_close(fd);
@@ -448,6 +447,7 @@
         switch(tda_state->fe_type) {
         case FE_TYPE_TDA10045H:
                 // reset chip
+		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 0x10, 0);
                 tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 8);
                 tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 8, 0);
                 dvb_delay(10);
@@ -458,6 +458,7 @@
 
         case FE_TYPE_TDA10046H:
                 // reset chip
+		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 1, 0);
                 tda1004x_write_mask(i2c, tda_state, TDA10046H_CONF_TRISTATE1, 1, 0);
                 dvb_delay(10);
 
@@ -539,6 +540,8 @@
 
         dprintk("%s\n", __FUNCTION__);
 
+	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFADC1, 0x10, 0); // wake up the ADC
+
         // Disable the MC44BC374C
         tda1004x_enable_tuner_i2c(i2c, tda_state);
         tuner_msg.addr = MC44BC374_ADDRESS;
@@ -575,6 +578,8 @@
 
         dprintk("%s\n", __FUNCTION__);
 
+	tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 1, 0); // wake up the chip
+
         // Disable the MC44BC374C
         tda1004x_enable_tuner_i2c(i2c, tda_state);
         tuner_msg.addr = MC44BC374_ADDRESS;
@@ -1278,12 +1282,27 @@
 	return 0;
 }
 
+static int tda1004x_sleep(struct dvb_i2c_bus *i2c, struct tda1004x_state* tda_state)
+{
+	switch(tda_state->fe_type) {
+	case FE_TYPE_TDA10045H:
+		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFADC1, 0x10, 0x10);
+		break;
+
+	case FE_TYPE_TDA10046H:
+		tda1004x_write_mask(i2c, tda_state, TDA1004X_CONFC4, 1, 1);
+		break;
+	}
+
+	return 0;
+}
+
 
 static int tda1004x_ioctl(struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
 	int status = 0;
 	struct dvb_i2c_bus *i2c = fe->i2c;
-	struct tda1004x_state *tda_state = (struct tda1004x_state *) &(fe->data);
+	struct tda1004x_state *tda_state = (struct tda1004x_state *) fe->data;
 
 	dprintk("%s: cmd=0x%x\n", __FUNCTION__, cmd);
 
@@ -1321,7 +1340,12 @@
 	case FE_GET_FRONTEND:
 		return tda1004x_get_fe(i2c, tda_state, (struct dvb_frontend_parameters*) arg);
 
+	case FE_SLEEP:
+		tda_state->initialised = 0;
+		return tda1004x_sleep(i2c, tda_state);
+
 	case FE_INIT:
+
 		// don't bother reinitialising
 		if (tda_state->initialised)
 			return 0;
@@ -1340,6 +1364,15 @@
 			tda_state->initialised = 1;
 		return status;
 
+	case FE_GET_TUNE_SETTINGS:
+	{
+		struct dvb_frontend_tune_settings* fesettings = (struct dvb_frontend_tune_settings*) arg;
+		fesettings->min_delay_ms = 800;
+		fesettings->step_size = 166667;
+		fesettings->max_drift = 166667*2;
+		return 0;
+	}
+	    
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -1355,6 +1388,7 @@
         int fe_type = -1;
         int tuner_type = -1;
 	struct tda1004x_state tda_state;
+	struct tda1004x_state* ptda_state;
 	struct i2c_msg tuner_msg = {.addr=0, .flags=0, .buf=0, .len=0 };
         static u8 td1344_init[] = { 0x0b, 0xf5, 0x88, 0xab };
         static u8 td1316_init[] = { 0x0b, 0xf5, 0x85, 0xab };
@@ -1447,13 +1481,20 @@
         // upload firmware
         if ((status = tda1004x_fwupload(i2c, &tda_state)) != 0) return status;
 
+	// create the real state we'll be passing about
+	if ((ptda_state = (struct tda1004x_state*) kmalloc(sizeof(struct tda1004x_state), GFP_KERNEL)) == NULL) {
+		return -ENOMEM;
+	}
+	memcpy(ptda_state, &tda_state, sizeof(struct tda1004x_state));
+	*data = ptda_state;
+
 	// register
         switch(tda_state.fe_type) {
         case FE_TYPE_TDA10045H:
-        	return dvb_register_frontend(tda1004x_ioctl, i2c, (void *)(*((u32*) &tda_state)), &tda10045h_info);
+		return dvb_register_frontend(tda1004x_ioctl, i2c, ptda_state, &tda10045h_info);
 
         case FE_TYPE_TDA10046H:
-                return dvb_register_frontend(tda1004x_ioctl, i2c, (void *)(*((u32*) &tda_state)), &tda10046h_info);
+		return dvb_register_frontend(tda1004x_ioctl, i2c, ptda_state, &tda10046h_info);
         }
 
         // should not get here
@@ -1466,6 +1507,7 @@
 {
 	dprintk("%s\n", __FUNCTION__);
 
+	kfree(data);
 	dvb_unregister_frontend(tda1004x_ioctl, i2c);
 }
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/ves1820.c linux-2.6.5-patched/drivers/media/dvb/frontends/ves1820.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/ves1820.c	2004-03-12 20:31:29.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/ves1820.c	2004-03-11 19:40:44.000000000 +0100
@@ -111,8 +111,7 @@
 #endif
 	.caps = FE_CAN_QAM_16 | FE_CAN_QAM_32 | FE_CAN_QAM_64 |
 		FE_CAN_QAM_128 | FE_CAN_QAM_256 | 
-		FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO |
-		FE_CAN_CLEAN_SETUP | FE_CAN_RECOVER
+		FE_CAN_FEC_AUTO | FE_CAN_INVERSION_AUTO,
 };
 
 
diff -urawBN xx-linux-2.6.5/drivers/media/dvb/frontends/ves1x93.c linux-2.6.5-patched/drivers/media/dvb/frontends/ves1x93.c
--- xx-linux-2.6.5/drivers/media/dvb/frontends/ves1x93.c	2004-02-22 14:48:47.000000000 +0100
+++ linux-2.6.5-patched/drivers/media/dvb/frontends/ves1x93.c	2004-03-14 14:46:20.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 
 #include "dvb_frontend.h"
+#include "dvb_functions.h"
 
 static int debug = 0;
 #define dprintk	if (debug) printk
@@ -67,10 +68,10 @@
  */
 
 static u8 init_1893_tab [] = {
-	0x01, 0xa4, 0x35, 0x81, 0x2a, 0x0d, 0x55, 0xc4,
+	0x01, 0xa4, 0x35, 0x80, 0x2a, 0x0b, 0x55, 0xc4,
 	0x09, 0x69, 0x00, 0x86, 0x4c, 0x28, 0x7f, 0x00,
 	0x00, 0x81, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-	0x80, 0x00, 0x31, 0xb0, 0x14, 0x00, 0xdc, 0x00,
+	0x80, 0x00, 0x21, 0xb0, 0x14, 0x00, 0xdc, 0x00,
 	0x81, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
 	0x00, 0x55, 0x00, 0x00, 0x7f, 0x00
@@ -109,6 +110,11 @@
 	1,1,1,0,1,1,1,1, 1,1,1,1,1
 };
 
+struct ves1x93_state {
+	fe_spectral_inversion_t inversion;
+};
+
+
 
 static int ves1x93_writereg (struct dvb_i2c_bus *i2c, u8 reg, u8 data)
 {
@@ -247,8 +253,16 @@
 {
         ves1x93_writereg (i2c, 0, init_1x93_tab[0] & 0xfe);
         ves1x93_writereg (i2c, 0, init_1x93_tab[0]);
+	dvb_delay(5);
+	return 0;
+}
+
+static int ves1x93_init_aquire (struct dvb_i2c_bus *i2c)
+{
         ves1x93_writereg (i2c, 3, 0x00);
-        return ves1x93_writereg (i2c, 3, init_1x93_tab[3]);
+	ves1x93_writereg (i2c, 3, init_1x93_tab[3]);
+	dvb_delay(5);
+	return 0;
 }
 
 
@@ -275,10 +289,7 @@
 		return -EINVAL;
 	}
 
-	/* needs to be saved for FE_GET_FRONTEND */
-	init_1x93_tab[0x0c] = (init_1x93_tab[0x0c] & 0x3f) | val;
-
-	return ves1x93_writereg (i2c, 0x0c, init_1x93_tab[0x0c]);
+	return ves1x93_writereg (i2c, 0x0c, (init_1x93_tab[0x0c] & 0x3f) | val);
 }
 
 
@@ -403,6 +414,25 @@
 }
 
 
+static int ves1x93_afc (struct dvb_i2c_bus *i2c, u32 freq, u32 srate)
+{
+	int afc;
+
+	afc = ((int)((ves1x93_readreg (i2c, 0x0a) << 1) & 0xff))/2;
+	afc = (afc * (int)(srate/1000/8))/16;
+    
+	if (afc) {
+	
+		freq -= afc;
+
+		tuner_set_tv_freq (i2c, freq, 0);
+
+		ves1x93_init_aquire (i2c);
+	}
+       
+	return 0;
+}
+
 static int ves1x93_set_voltage (struct dvb_i2c_bus *i2c, fe_sec_voltage_t voltage)
 {
 	switch (voltage) {
@@ -421,6 +451,7 @@
 static int ves1x93_ioctl (struct dvb_frontend *fe, unsigned int cmd, void *arg)
 {
 	struct dvb_i2c_bus *i2c = fe->i2c;
+	struct ves1x93_state *state = (struct ves1x93_state*) fe->data;
 
         switch (cmd) {
         case FE_GET_INFO:
@@ -497,6 +528,8 @@
 		ves1x93_set_inversion (i2c, p->inversion);
 		ves1x93_set_fec (i2c, p->u.qpsk.fec_inner);
 		ves1x93_set_symbolrate (i2c, p->u.qpsk.symbol_rate);
+		ves1x93_afc (i2c, p->frequency, p->u.qpsk.symbol_rate);	    
+		state->inversion = p->inversion;
                 break;
         }
 
@@ -514,7 +547,7 @@
 		 * inversion indicator is only valid
 		 * if auto inversion was used
 		 */
-		if (!(init_1x93_tab[0x0c] & 0x80))
+		if (state->inversion == INVERSION_AUTO)
 			p->inversion = (ves1x93_readreg (i2c, 0x0f) & 2) ? 
 					INVERSION_OFF : INVERSION_ON;
 		p->u.qpsk.fec_inner = ves1x93_get_fec (i2c);
@@ -530,9 +563,6 @@
         case FE_INIT:
 		return ves1x93_init (i2c);
 
-	case FE_RESET:
-		return ves1x93_clr_bit (i2c);
-
 	case FE_SET_TONE:
 		return -EOPNOTSUPP;  /* the ves1893 can generate the 22k */
 		                     /* let's implement this when we have */
@@ -552,14 +582,21 @@
 static int ves1x93_attach (struct dvb_i2c_bus *i2c, void **data)
 {
 	u8 identity = ves1x93_readreg(i2c, 0x1e);
+	struct ves1x93_state* state;
 
 	switch (identity) {
 	case 0xdc: /* VES1893A rev1 */
+		printk("ves1x93: Detected ves1893a rev1\n");
+		demod_type = DEMOD_VES1893;
+		ves1x93_info.name[4] = '8';
+		break;
 	case 0xdd: /* VES1893A rev2 */
+		printk("ves1x93: Detected ves1893a rev2\n");
 		demod_type = DEMOD_VES1893;
 		ves1x93_info.name[4] = '8';
 		break;
 	case 0xde: /* VES1993 */
+		printk("ves1x93: Detected ves1993\n");
 		demod_type = DEMOD_VES1993;
 		ves1x93_info.name[4] = '9';
 		break;
@@ -568,12 +605,19 @@
 		return -ENODEV;
 	}
 
-	return dvb_register_frontend (ves1x93_ioctl, i2c, NULL, &ves1x93_info);
+	if ((state = kmalloc(sizeof(struct ves1x93_state), GFP_KERNEL)) == NULL) {
+		return -ENOMEM;
+	}
+	state->inversion = INVERSION_OFF;
+	*data = state;
+
+	return dvb_register_frontend (ves1x93_ioctl, i2c, (void*) state, &ves1x93_info);
 }
 
 
 static void ves1x93_detach (struct dvb_i2c_bus *i2c, void *data)
 {
+	kfree(data);
 	dvb_unregister_frontend (ves1x93_ioctl, i2c);
 }
 


