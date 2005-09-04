Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVIDXcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVIDXcg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 19:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932126AbVIDXcB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 19:32:01 -0400
Received: from allen.werkleitz.de ([80.190.251.108]:62849 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S932153AbVIDXbV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 19:31:21 -0400
Message-Id: <20050904232331.276061000@abc>
References: <20050904232259.777473000@abc>
Date: Mon, 05 Sep 2005 01:23:38 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Manu Abraham <manu@linuxtv.org>
Content-Disposition: inline; filename=dvb-bt8xx-dst-dprintk-cleanup.patch
X-SA-Exim-Connect-IP: 84.189.198.88
Subject: [DVB patch 39/54] dst: dprrintk cleanup
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manu Abraham <manu@linuxtv.org>

Code Cleanup:
o Remove debug noise
o Remove debug module parameter
  debug level is achieved using the verbosity level
o Updated to kernel coding style
  (case labels should not be indented)

Signed-off-by: Manu Abraham <manu@linuxtv.org>
Signed-off-by: Johannes Stezenbach <js@linuxtv.org>

 drivers/media/dvb/bt8xx/dst.c        |  645 ++++++++++++++---------------------
 drivers/media/dvb/bt8xx/dst_ca.c     |  441 +++++++++--------------
 drivers/media/dvb/bt8xx/dst_common.h |    4 
 3 files changed, 458 insertions(+), 632 deletions(-)

--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:32.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst.c	2005-09-04 22:28:34.000000000 +0200
@@ -1,5 +1,4 @@
 /*
-
 	Frontend/Card driver for TwinHan DST Frontend
 	Copyright (C) 2003 Jamie Honan
 	Copyright (C) 2004, 2005 Manu Abraham (manu@kromtek.com)
@@ -19,7 +18,6 @@
 	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -28,31 +26,45 @@
 #include <linux/vmalloc.h>
 #include <linux/delay.h>
 #include <asm/div64.h>
-
 #include "dvb_frontend.h"
 #include "dst_priv.h"
 #include "dst_common.h"
 
-
 static unsigned int verbose = 1;
 module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");
 
-static unsigned int debug = 1;
-module_param(debug, int, 0644);
-MODULE_PARM_DESC(debug, "debug messages, default is 0 (yes)");
-
 static unsigned int dst_addons;
 module_param(dst_addons, int, 0644);
 MODULE_PARM_DESC(dst_addons, "CA daughterboard, default is 0 (No addons)");
 
-#define dprintk	if (debug) printk
+#define HAS_LOCK		1
+#define ATTEMPT_TUNE		2
+#define HAS_POWER		4
+
+#define DST_ERROR		0
+#define DST_NOTICE		1
+#define DST_INFO		2
+#define DST_DEBUG		3
+
+#define dprintk(x, y, z, format, arg...) do {						\
+	if (z) {									\
+		if	((x > DST_ERROR) && (x > y))					\
+			printk(KERN_ERR "%s: " format "\n", __FUNCTION__ , ##arg);	\
+		else if	((x > DST_NOTICE) && (x > y))					\
+			printk(KERN_NOTICE "%s: " format "\n", __FUNCTION__, ##arg);	\
+		else if ((x > DST_INFO) && (x > y))					\
+			printk(KERN_INFO "%s: " format "\n", __FUNCTION__, ##arg);	\
+		else if ((x > DST_DEBUG) && (x > y))					\
+			printk(KERN_DEBUG "%s: " format "\n", __FUNCTION__, ##arg);	\
+	} else {									\
+		if (x > y)								\
+			printk(format, ##arg);						\
+	}										\
+} while(0)
 
-#define HAS_LOCK	1
-#define ATTEMPT_TUNE	2
-#define HAS_POWER	4
 
-static void dst_packsize(struct dst_state* state, int psize)
+static void dst_packsize(struct dst_state *state, int psize)
 {
 	union dst_gpio_packet bits;
 
@@ -60,7 +72,7 @@ static void dst_packsize(struct dst_stat
 	bt878_device_control(state->bt, DST_IG_TS, &bits);
 }
 
-int dst_gpio_outb(struct dst_state* state, u32 mask, u32 enbb, u32 outhigh, int delay)
+int dst_gpio_outb(struct dst_state *state, u32 mask, u32 enbb, u32 outhigh, int delay)
 {
 	union dst_gpio_packet enb;
 	union dst_gpio_packet bits;
@@ -68,63 +80,55 @@ int dst_gpio_outb(struct dst_state* stat
 
 	enb.enb.mask = mask;
 	enb.enb.enable = enbb;
-	if (verbose > 4)
-		dprintk("%s: mask=[%04x], enbb=[%04x], outhigh=[%04x]\n", __FUNCTION__, mask, enbb, outhigh);
 
+	dprintk(verbose, DST_INFO, 1, "mask=[%04x], enbb=[%04x], outhigh=[%04x]", mask, enbb, outhigh);
 	if ((err = bt878_device_control(state->bt, DST_IG_ENABLE, &enb)) < 0) {
-		dprintk("%s: dst_gpio_enb error (err == %i, mask == %02x, enb == %02x)\n", __FUNCTION__, err, mask, enbb);
+		dprintk(verbose, DST_INFO, 1, "dst_gpio_enb error (err == %i, mask == %02x, enb == %02x)", err, mask, enbb);
 		return -EREMOTEIO;
 	}
 	udelay(1000);
 	/* because complete disabling means no output, no need to do output packet */
 	if (enbb == 0)
 		return 0;
-
 	if (delay)
 		msleep(10);
-
 	bits.outp.mask = enbb;
 	bits.outp.highvals = outhigh;
-
 	if ((err = bt878_device_control(state->bt, DST_IG_WRITE, &bits)) < 0) {
-		dprintk("%s: dst_gpio_outb error (err == %i, enbb == %02x, outhigh == %02x)\n", __FUNCTION__, err, enbb, outhigh);
+		dprintk(verbose, DST_INFO, 1, "dst_gpio_outb error (err == %i, enbb == %02x, outhigh == %02x)", err, enbb, outhigh);
 		return -EREMOTEIO;
 	}
+
 	return 0;
 }
 EXPORT_SYMBOL(dst_gpio_outb);
 
-int dst_gpio_inb(struct dst_state *state, u8 * result)
+int dst_gpio_inb(struct dst_state *state, u8 *result)
 {
 	union dst_gpio_packet rd_packet;
 	int err;
 
 	*result = 0;
-
 	if ((err = bt878_device_control(state->bt, DST_IG_READ, &rd_packet)) < 0) {
-		dprintk("%s: dst_gpio_inb error (err == %i)\n", __FUNCTION__, err);
+		dprintk(verbose, DST_ERROR, 1, "dst_gpio_inb error (err == %i)\n", err);
 		return -EREMOTEIO;
 	}
-
 	*result = (u8) rd_packet.rd.value;
+
 	return 0;
 }
 EXPORT_SYMBOL(dst_gpio_inb);
 
 int rdc_reset_state(struct dst_state *state)
 {
-	if (verbose > 1)
-		dprintk("%s: Resetting state machine\n", __FUNCTION__);
-
+	dprintk(verbose, DST_INFO, 1, "Resetting state machine");
 	if (dst_gpio_outb(state, RDC_8820_INT, RDC_8820_INT, 0, NO_DELAY) < 0) {
-		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "dst_gpio_outb ERROR !");
 		return -1;
 	}
-
 	msleep(10);
-
 	if (dst_gpio_outb(state, RDC_8820_INT, RDC_8820_INT, RDC_8820_INT, NO_DELAY) < 0) {
-		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "dst_gpio_outb ERROR !");
 		msleep(10);
 		return -1;
 	}
@@ -135,16 +139,14 @@ EXPORT_SYMBOL(rdc_reset_state);
 
 int rdc_8820_reset(struct dst_state *state)
 {
-	if (verbose > 1)
-		dprintk("%s: Resetting DST\n", __FUNCTION__);
-
+	dprintk(verbose, DST_DEBUG, 1, "Resetting DST");
 	if (dst_gpio_outb(state, RDC_8820_RESET, RDC_8820_RESET, 0, NO_DELAY) < 0) {
-		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "dst_gpio_outb ERROR !");
 		return -1;
 	}
 	udelay(1000);
 	if (dst_gpio_outb(state, RDC_8820_RESET, RDC_8820_RESET, RDC_8820_RESET, DELAY) < 0) {
-		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "dst_gpio_outb ERROR !");
 		return -1;
 	}
 
@@ -155,10 +157,11 @@ EXPORT_SYMBOL(rdc_8820_reset);
 int dst_pio_enable(struct dst_state *state)
 {
 	if (dst_gpio_outb(state, ~0, RDC_8820_PIO_0_ENABLE, 0, NO_DELAY) < 0) {
-		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "dst_gpio_outb ERROR !");
 		return -1;
 	}
 	udelay(1000);
+
 	return 0;
 }
 EXPORT_SYMBOL(dst_pio_enable);
@@ -166,7 +169,7 @@ EXPORT_SYMBOL(dst_pio_enable);
 int dst_pio_disable(struct dst_state *state)
 {
 	if (dst_gpio_outb(state, ~0, RDC_8820_PIO_0_DISABLE, RDC_8820_PIO_0_DISABLE, NO_DELAY) < 0) {
-		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "dst_gpio_outb ERROR !");
 		return -1;
 	}
 	if (state->type_flags & DST_TYPE_HAS_FW_1)
@@ -183,19 +186,16 @@ int dst_wait_dst_ready(struct dst_state 
 
 	for (i = 0; i < 200; i++) {
 		if (dst_gpio_inb(state, &reply) < 0) {
-			dprintk("%s: dst_gpio_inb ERROR !\n", __FUNCTION__);
+			dprintk(verbose, DST_ERROR, 1, "dst_gpio_inb ERROR !");
 			return -1;
 		}
-
 		if ((reply & RDC_8820_PIO_0_ENABLE) == 0) {
-			if (verbose > 4)
-				dprintk("%s: dst wait ready after %d\n", __FUNCTION__, i);
+			dprintk(verbose, DST_INFO, 1, "dst wait ready after %d", i);
 			return 1;
 		}
 		msleep(10);
 	}
-	if (verbose > 1)
-		dprintk("%s: dst wait NOT ready after %d\n", __FUNCTION__, i);
+	dprintk(verbose, DST_NOTICE, 1, "dst wait NOT ready after %d", i);
 
 	return 0;
 }
@@ -203,7 +203,7 @@ EXPORT_SYMBOL(dst_wait_dst_ready);
 
 int dst_error_recovery(struct dst_state *state)
 {
-	dprintk("%s: Trying to return from previous errors...\n", __FUNCTION__);
+	dprintk(verbose, DST_NOTICE, 1, "Trying to return from previous errors.");
 	dst_pio_disable(state);
 	msleep(10);
 	dst_pio_enable(state);
@@ -215,7 +215,7 @@ EXPORT_SYMBOL(dst_error_recovery);
 
 int dst_error_bailout(struct dst_state *state)
 {
-	dprintk("%s: Trying to bailout from previous error...\n", __FUNCTION__);
+	dprintk(verbose, DST_INFO, 1, "Trying to bailout from previous error.");
 	rdc_8820_reset(state);
 	dst_pio_disable(state);
 	msleep(10);
@@ -224,17 +224,15 @@ int dst_error_bailout(struct dst_state *
 }
 EXPORT_SYMBOL(dst_error_bailout);
 
-
-int dst_comm_init(struct dst_state* state)
+int dst_comm_init(struct dst_state *state)
 {
-	if (verbose > 1)
-		dprintk ("%s: Initializing DST..\n", __FUNCTION__);
+	dprintk(verbose, DST_INFO, 1, "Initializing DST.");
 	if ((dst_pio_enable(state)) < 0) {
-		dprintk("%s: PIO Enable Failed.\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "PIO Enable Failed");
 		return -1;
 	}
 	if ((rdc_reset_state(state)) < 0) {
-		dprintk("%s: RDC 8820 State RESET Failed.\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "RDC 8820 State RESET Failed.");
 		return -1;
 	}
 	if (state->type_flags & DST_TYPE_HAS_FW_1)
@@ -246,36 +244,33 @@ int dst_comm_init(struct dst_state* stat
 }
 EXPORT_SYMBOL(dst_comm_init);
 
-
 int write_dst(struct dst_state *state, u8 *data, u8 len)
 {
 	struct i2c_msg msg = {
-		.addr = state->config->demod_address,.flags = 0,.buf = data,.len = len
+		.addr = state->config->demod_address,
+		.flags = 0,
+		.buf = data,
+		.len = len
 	};
 
 	int err;
-	int cnt;
-	if (debug && (verbose > 4)) {
-		u8 i;
-		if (verbose > 4) {
-			dprintk("%s writing [ ", __FUNCTION__);
-			for (i = 0; i < len; i++)
-				dprintk("%02x ", data[i]);
-			dprintk("]\n");
-		}
-	}
+	u8 cnt, i;
+
+	dprintk(verbose, DST_NOTICE, 0, "writing [ ");
+	for (i = 0; i < len; i++)
+		dprintk(verbose, DST_NOTICE, 0, "%02x ", data[i]);
+	dprintk(verbose, DST_NOTICE, 0, "]\n");
+
 	for (cnt = 0; cnt < 2; cnt++) {
 		if ((err = i2c_transfer(state->i2c, &msg, 1)) < 0) {
-			dprintk("%s: _write_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, data[0]);
+			dprintk(verbose, DST_INFO, 1, "_write_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)", err, len, data[0]);
 			dst_error_recovery(state);
 			continue;
 		} else
 			break;
 	}
-
 	if (cnt >= 2) {
-		if (verbose > 1)
-			printk("%s: RDC 8820 RESET...\n", __FUNCTION__);
+		dprintk(verbose, DST_INFO, 1, "RDC 8820 RESET");
 		dst_error_bailout(state);
 
 		return -1;
@@ -285,36 +280,37 @@ int write_dst(struct dst_state *state, u
 }
 EXPORT_SYMBOL(write_dst);
 
-int read_dst(struct dst_state *state, u8 * ret, u8 len)
+int read_dst(struct dst_state *state, u8 *ret, u8 len)
 {
-	struct i2c_msg msg = {.addr = state->config->demod_address,.flags = I2C_M_RD,.buf = ret,.len = len };
+	struct i2c_msg msg = {
+		.addr = state->config->demod_address,
+		.flags = I2C_M_RD,
+		.buf = ret,
+		.len = len
+	};
+
 	int err;
 	int cnt;
 
 	for (cnt = 0; cnt < 2; cnt++) {
 		if ((err = i2c_transfer(state->i2c, &msg, 1)) < 0) {
-
-			dprintk("%s: read_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)\n", __FUNCTION__, err, len, ret[0]);
+			dprintk(verbose, DST_INFO, 1, "read_dst error (err == %i, len == 0x%02x, b0 == 0x%02x)", err, len, ret[0]);
 			dst_error_recovery(state);
-
 			continue;
 		} else
 			break;
 	}
 	if (cnt >= 2) {
-		if (verbose > 1)
-			printk("%s: RDC 8820 RESET...\n", __FUNCTION__);
+		dprintk(verbose, DST_INFO, 1, "RDC 8820 RESET");
 		dst_error_bailout(state);
 
 		return -1;
 	}
-	if (debug && (verbose > 4)) {
-		dprintk("%s reply is 0x%x\n", __FUNCTION__, ret[0]);
-		for (err = 1; err < len; err++)
-			dprintk(" 0x%x", ret[err]);
-		if (err > 1)
-			dprintk("\n");
-	}
+	dprintk(verbose, DST_DEBUG, 1, "reply is 0x%x", ret[0]);
+	for (err = 1; err < len; err++)
+		dprintk(verbose, DST_DEBUG, 0, " 0x%x", ret[err]);
+	if (err > 1)
+		dprintk(verbose, DST_DEBUG, 0, "\n");
 
 	return 0;
 }
@@ -323,19 +319,16 @@ EXPORT_SYMBOL(read_dst);
 static int dst_set_polarization(struct dst_state *state)
 {
 	switch (state->voltage) {
-		case SEC_VOLTAGE_13:	// vertical
-			dprintk("%s: Polarization=[Vertical]\n", __FUNCTION__);
-			state->tx_tuna[8] &= ~0x40;  //1
-			break;
-
-		case SEC_VOLTAGE_18:	// horizontal
-			dprintk("%s: Polarization=[Horizontal]\n", __FUNCTION__);
-			state->tx_tuna[8] |= 0x40;  // 0
-			break;
-
-		case SEC_VOLTAGE_OFF:
-
-			break;
+	case SEC_VOLTAGE_13:	/*	Vertical	*/
+		dprintk(verbose, DST_INFO, 1, "Polarization=[Vertical]");
+		state->tx_tuna[8] &= ~0x40;
+		break;
+	case SEC_VOLTAGE_18:	/*	Horizontal	*/
+		dprintk(verbose, DST_INFO, 1, "Polarization=[Horizontal]");
+		state->tx_tuna[8] |= 0x40;
+		break;
+	case SEC_VOLTAGE_OFF:
+		break;
 	}
 
 	return 0;
@@ -344,14 +337,12 @@ static int dst_set_polarization(struct d
 static int dst_set_freq(struct dst_state *state, u32 freq)
 {
 	state->frequency = freq;
-	if (verbose > 4)
-		dprintk("%s: set Frequency %u\n", __FUNCTION__, freq);
+	dprintk(verbose, DST_INFO, 1, "set Frequency %u", freq);
 
 	if (state->dst_type == DST_TYPE_IS_SAT) {
 		freq = freq / 1000;
 		if (freq < 950 || freq > 2150)
 			return -EINVAL;
-
 		state->tx_tuna[2] = (freq >> 8);
 		state->tx_tuna[3] = (u8) freq;
 		state->tx_tuna[4] = 0x01;
@@ -360,27 +351,24 @@ static int dst_set_freq(struct dst_state
 			if (freq < 1531)
 				state->tx_tuna[8] |= 0x04;
 		}
-
 	} else if (state->dst_type == DST_TYPE_IS_TERR) {
 		freq = freq / 1000;
 		if (freq < 137000 || freq > 858000)
 			return -EINVAL;
-
 		state->tx_tuna[2] = (freq >> 16) & 0xff;
 		state->tx_tuna[3] = (freq >> 8) & 0xff;
 		state->tx_tuna[4] = (u8) freq;
-
 	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
 		state->tx_tuna[2] = (freq >> 16) & 0xff;
 		state->tx_tuna[3] = (freq >> 8) & 0xff;
 		state->tx_tuna[4] = (u8) freq;
-
 	} else
 		return -EINVAL;
+
 	return 0;
 }
 
-static int dst_set_bandwidth(struct dst_state* state, fe_bandwidth_t bandwidth)
+static int dst_set_bandwidth(struct dst_state *state, fe_bandwidth_t bandwidth)
 {
 	state->bandwidth = bandwidth;
 
@@ -388,90 +376,82 @@ static int dst_set_bandwidth(struct dst_
 		return 0;
 
 	switch (bandwidth) {
-		case BANDWIDTH_6_MHZ:
-			if (state->dst_hw_cap & DST_TYPE_HAS_CA)
-				state->tx_tuna[7] = 0x06;
-			else {
-				state->tx_tuna[6] = 0x06;
-				state->tx_tuna[7] = 0x00;
-			}
-			break;
-
-		case BANDWIDTH_7_MHZ:
-			if (state->dst_hw_cap & DST_TYPE_HAS_CA)
-				state->tx_tuna[7] = 0x07;
-			else {
-				state->tx_tuna[6] = 0x07;
-				state->tx_tuna[7] = 0x00;
-			}
-			break;
-
-		case BANDWIDTH_8_MHZ:
-			if (state->dst_hw_cap & DST_TYPE_HAS_CA)
-				state->tx_tuna[7] = 0x08;
-			else {
-				state->tx_tuna[6] = 0x08;
-				state->tx_tuna[7] = 0x00;
-			}
-			break;
-
-		default:
-			return -EINVAL;
+	case BANDWIDTH_6_MHZ:
+		if (state->dst_hw_cap & DST_TYPE_HAS_CA)
+			state->tx_tuna[7] = 0x06;
+		else {
+			state->tx_tuna[6] = 0x06;
+			state->tx_tuna[7] = 0x00;
+		}
+		break;
+	case BANDWIDTH_7_MHZ:
+		if (state->dst_hw_cap & DST_TYPE_HAS_CA)
+			state->tx_tuna[7] = 0x07;
+		else {
+			state->tx_tuna[6] = 0x07;
+			state->tx_tuna[7] = 0x00;
+		}
+		break;
+	case BANDWIDTH_8_MHZ:
+		if (state->dst_hw_cap & DST_TYPE_HAS_CA)
+			state->tx_tuna[7] = 0x08;
+		else {
+			state->tx_tuna[6] = 0x08;
+			state->tx_tuna[7] = 0x00;
+		}
+		break;
+	default:
+		return -EINVAL;
 	}
+
 	return 0;
 }
 
-static int dst_set_inversion(struct dst_state* state, fe_spectral_inversion_t inversion)
+static int dst_set_inversion(struct dst_state *state, fe_spectral_inversion_t inversion)
 {
 	state->inversion = inversion;
 	switch (inversion) {
-		case INVERSION_OFF:	// Inversion = Normal
-			state->tx_tuna[8] &= ~0x80;
-			break;
-
-		case INVERSION_ON:
-			state->tx_tuna[8] |= 0x80;
-			break;
-		default:
-			return -EINVAL;
+	case INVERSION_OFF:	/*	Inversion = Normal	*/
+		state->tx_tuna[8] &= ~0x80;
+		break;
+	case INVERSION_ON:
+		state->tx_tuna[8] |= 0x80;
+		break;
+	default:
+		return -EINVAL;
 	}
+
 	return 0;
 }
 
-static int dst_set_fec(struct dst_state* state, fe_code_rate_t fec)
+static int dst_set_fec(struct dst_state *state, fe_code_rate_t fec)
 {
 	state->fec = fec;
 	return 0;
 }
 
-static fe_code_rate_t dst_get_fec(struct dst_state* state)
+static fe_code_rate_t dst_get_fec(struct dst_state *state)
 {
 	return state->fec;
 }
 
-static int dst_set_symbolrate(struct dst_state* state, u32 srate)
+static int dst_set_symbolrate(struct dst_state *state, u32 srate)
 {
 	u32 symcalc;
 	u64 sval;
 
 	state->symbol_rate = srate;
-
 	if (state->dst_type == DST_TYPE_IS_TERR) {
 		return 0;
 	}
-	if (debug > 4)
-		dprintk("%s: set symrate %u\n", __FUNCTION__, srate);
+	dprintk(verbose, DST_INFO, 1, "set symrate %u", srate);
 	srate /= 1000;
-
 	if (state->type_flags & DST_TYPE_HAS_SYMDIV) {
 		sval = srate;
 		sval <<= 20;
 		do_div(sval, 88000);
 		symcalc = (u32) sval;
-
-		if (debug > 4)
-			dprintk("%s: set symcalc %u\n", __FUNCTION__, symcalc);
-
+		dprintk(verbose, DST_INFO, 1, "set symcalc %u", symcalc);
 		state->tx_tuna[5] = (u8) (symcalc >> 12);
 		state->tx_tuna[6] = (u8) (symcalc >> 4);
 		state->tx_tuna[7] = (u8) (symcalc << 4);
@@ -496,32 +476,27 @@ static int dst_set_modulation(struct dst
 
 	state->modulation = modulation;
 	switch (modulation) {
-		case QAM_16:
-			state->tx_tuna[8] = 0x10;
-			break;
-
-		case QAM_32:
-			state->tx_tuna[8] = 0x20;
-			break;
-
-		case QAM_64:
-			state->tx_tuna[8] = 0x40;
-			break;
-
-		case QAM_128:
-			state->tx_tuna[8] = 0x80;
-			break;
-
-		case QAM_256:
-			state->tx_tuna[8] = 0x00;
-			break;
-
-		case QPSK:
-		case QAM_AUTO:
-		case VSB_8:
-		case VSB_16:
-		default:
-			return -EINVAL;
+	case QAM_16:
+		state->tx_tuna[8] = 0x10;
+		break;
+	case QAM_32:
+		state->tx_tuna[8] = 0x20;
+		break;
+	case QAM_64:
+		state->tx_tuna[8] = 0x40;
+		break;
+	case QAM_128:
+		state->tx_tuna[8] = 0x80;
+		break;
+	case QAM_256:
+		state->tx_tuna[8] = 0x00;
+		break;
+	case QPSK:
+	case QAM_AUTO:
+	case VSB_8:
+	case VSB_16:
+	default:
+		return -EINVAL;
 
 	}
 
@@ -534,7 +509,7 @@ static fe_modulation_t dst_get_modulatio
 }
 
 
-u8 dst_check_sum(u8 * buf, u32 len)
+u8 dst_check_sum(u8 *buf, u32 len)
 {
 	u32 i;
 	u8 val = 0;
@@ -549,26 +524,24 @@ EXPORT_SYMBOL(dst_check_sum);
 
 static void dst_type_flags_print(u32 type_flags)
 {
-	printk("DST type flags :");
+	dprintk(verbose, DST_ERROR, 0, "DST type flags :");
 	if (type_flags & DST_TYPE_HAS_NEWTUNE)
-		printk(" 0x%x newtuner", DST_TYPE_HAS_NEWTUNE);
+		dprintk(verbose, DST_ERROR, 0, " 0x%x newtuner", DST_TYPE_HAS_NEWTUNE);
 	if (type_flags & DST_TYPE_HAS_TS204)
-		printk(" 0x%x ts204", DST_TYPE_HAS_TS204);
+		dprintk(verbose, DST_ERROR, 0, " 0x%x ts204", DST_TYPE_HAS_TS204);
 	if (type_flags & DST_TYPE_HAS_SYMDIV)
-		printk(" 0x%x symdiv", DST_TYPE_HAS_SYMDIV);
+		dprintk(verbose, DST_ERROR, 0, " 0x%x symdiv", DST_TYPE_HAS_SYMDIV);
 	if (type_flags & DST_TYPE_HAS_FW_1)
-		printk(" 0x%x firmware version = 1", DST_TYPE_HAS_FW_1);
+		dprintk(verbose, DST_ERROR, 0, " 0x%x firmware version = 1", DST_TYPE_HAS_FW_1);
 	if (type_flags & DST_TYPE_HAS_FW_2)
-		printk(" 0x%x firmware version = 2", DST_TYPE_HAS_FW_2);
+		dprintk(verbose, DST_ERROR, 0, " 0x%x firmware version = 2", DST_TYPE_HAS_FW_2);
 	if (type_flags & DST_TYPE_HAS_FW_3)
-		printk(" 0x%x firmware version = 3", DST_TYPE_HAS_FW_3);
-//	if ((type_flags & DST_TYPE_HAS_FW_BUILD) && new_fw)
-
-	printk("\n");
+		dprintk(verbose, DST_ERROR, 0, " 0x%x firmware version = 3", DST_TYPE_HAS_FW_3);
+	dprintk(verbose, DST_ERROR, 0, "\n");
 }
 
 
-static int dst_type_print (u8 type)
+static int dst_type_print(u8 type)
 {
 	char *otype;
 	switch (type) {
@@ -585,10 +558,10 @@ static int dst_type_print (u8 type)
 		break;
 
 	default:
-		printk("%s: invalid dst type %d\n", __FUNCTION__, type);
+		dprintk(verbose, DST_INFO, 1, "invalid dst type %d", type);
 		return -EINVAL;
 	}
-	printk("DST type : %s\n", otype);
+	dprintk(verbose, DST_INFO, 1, "DST type: %s", otype);
 
 	return 0;
 }
@@ -772,53 +745,45 @@ static int dst_get_device_id(struct dst_
 
 	if (write_dst(state, device_type, FIXED_COMM))
 		return -1;		/*	Write failed		*/
-
 	if ((dst_pio_disable(state)) < 0)
 		return -1;
-
 	if (read_dst(state, &reply, GET_ACK))
 		return -1;		/*	Read failure		*/
-
 	if (reply != ACK) {
-		dprintk("%s: Write not Acknowledged! [Reply=0x%02x]\n", __FUNCTION__, reply);
+		dprintk(verbose, DST_INFO, 1, "Write not Acknowledged! [Reply=0x%02x]", reply);
 		return -1;		/*	Unack'd write		*/
 	}
-
 	if (!dst_wait_dst_ready(state, DEVICE_INIT))
 		return -1;		/*	DST not ready yet	*/
-
 	if (read_dst(state, state->rxbuffer, FIXED_COMM))
 		return -1;
 
 	dst_pio_disable(state);
-
 	if (state->rxbuffer[7] != dst_check_sum(state->rxbuffer, 7)) {
-		dprintk("%s: Checksum failure! \n", __FUNCTION__);
+		dprintk(verbose, DST_INFO, 1, "Checksum failure!");
 		return -1;		/*	Checksum failure	*/
 	}
-
 	state->rxbuffer[7] = '\0';
 
-	for (i = 0, p_dst_type = dst_tlist; i < ARRAY_SIZE (dst_tlist); i++, p_dst_type++) {
+	for (i = 0, p_dst_type = dst_tlist; i < ARRAY_SIZE(dst_tlist); i++, p_dst_type++) {
 		if (!strncmp (&state->rxbuffer[p_dst_type->offset], p_dst_type->device_id, strlen (p_dst_type->device_id))) {
 			use_type_flags = p_dst_type->type_flags;
 			use_dst_type = p_dst_type->dst_type;
 
 			/*	Card capabilities	*/
 			state->dst_hw_cap = p_dst_type->dst_feature;
-			printk ("%s: Recognise [%s]\n", __FUNCTION__, p_dst_type->device_id);
+			dprintk(verbose, DST_ERROR, 1, "Recognise [%s]\n", p_dst_type->device_id);
 
 			break;
 		}
 	}
 
 	if (i >= sizeof (dst_tlist) / sizeof (dst_tlist [0])) {
-		printk("%s: Unable to recognize %s or %s\n", __FUNCTION__, &state->rxbuffer[0], &state->rxbuffer[1]);
-		printk("%s: please email linux-dvb@linuxtv.org with this type in\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "Unable to recognize %s or %s", &state->rxbuffer[0], &state->rxbuffer[1]);
+		dprintk(verbose, DST_ERROR, 1, "please email linux-dvb@linuxtv.org with this type in");
 		use_dst_type = DST_TYPE_IS_SAT;
 		use_type_flags = DST_TYPE_HAS_SYMDIV;
 	}
-
 	dst_type_print(use_dst_type);
 	state->type_flags = use_type_flags;
 	state->dst_type = use_dst_type;
@@ -834,7 +799,7 @@ static int dst_get_device_id(struct dst_
 static int dst_probe(struct dst_state *state)
 {
 	if ((rdc_8820_reset(state)) < 0) {
-		dprintk("%s: RDC 8820 RESET Failed.\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "RDC 8820 RESET Failed.");
 		return -1;
 	}
 	if (dst_addons & DST_TYPE_HAS_CA)
@@ -843,80 +808,69 @@ static int dst_probe(struct dst_state *s
 		msleep(100);
 
 	if ((dst_comm_init(state)) < 0) {
-		dprintk("%s: DST Initialization Failed.\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "DST Initialization Failed.");
 		return -1;
 	}
 	msleep(100);
 	if (dst_get_device_id(state) < 0) {
-		dprintk("%s: unknown device.\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "unknown device.");
 		return -1;
 	}
 
 	return 0;
 }
 
-int dst_command(struct dst_state* state, u8 * data, u8 len)
+int dst_command(struct dst_state *state, u8 *data, u8 len)
 {
 	u8 reply;
 	if ((dst_comm_init(state)) < 0) {
-		dprintk("%s: DST Communication Initialization Failed.\n", __FUNCTION__);
+		dprintk(verbose, DST_NOTICE, 1, "DST Communication Initialization Failed.");
 		return -1;
 	}
-
 	if (write_dst(state, data, len)) {
-		if (verbose > 1)
-			dprintk("%s: Tring to recover.. \n", __FUNCTION__);
+		dprintk(verbose, DST_INFO, 1, "Tring to recover.. ");
 		if ((dst_error_recovery(state)) < 0) {
-			dprintk("%s: Recovery Failed.\n", __FUNCTION__);
+			dprintk(verbose, DST_ERROR, 1, "Recovery Failed.");
 			return -1;
 		}
 		return -1;
 	}
 	if ((dst_pio_disable(state)) < 0) {
-		dprintk("%s: PIO Disable Failed.\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "PIO Disable Failed.");
 		return -1;
 	}
 	if (state->type_flags & DST_TYPE_HAS_FW_1)
 		udelay(3000);
-
 	if (read_dst(state, &reply, GET_ACK)) {
-		if (verbose > 1)
-			dprintk("%s: Trying to recover.. \n", __FUNCTION__);
+		dprintk(verbose, DST_DEBUG, 1, "Trying to recover.. ");
 		if ((dst_error_recovery(state)) < 0) {
-			dprintk("%s: Recovery Failed.\n", __FUNCTION__);
+			dprintk(verbose, DST_INFO, 1, "Recovery Failed.");
 			return -1;
 		}
 		return -1;
 	}
-
 	if (reply != ACK) {
-		dprintk("%s: write not acknowledged 0x%02x \n", __FUNCTION__, reply);
+		dprintk(verbose, DST_INFO, 1, "write not acknowledged 0x%02x ", reply);
 		return -1;
 	}
 	if (len >= 2 && data[0] == 0 && (data[1] == 1 || data[1] == 3))
 		return 0;
-
-//	udelay(3000);
 	if (state->type_flags & DST_TYPE_HAS_FW_1)
 		udelay(3000);
 	else
 		udelay(2000);
-
 	if (!dst_wait_dst_ready(state, NO_DELAY))
 		return -1;
-
 	if (read_dst(state, state->rxbuffer, FIXED_COMM)) {
-		if (verbose > 1)
-			dprintk("%s: Trying to recover.. \n", __FUNCTION__);
+		dprintk(verbose, DST_DEBUG, 1, "Trying to recover.. ");
 		if ((dst_error_recovery(state)) < 0) {
-			dprintk("%s: Recovery failed.\n", __FUNCTION__);
+			dprintk(verbose, DST_INFO, 1, "Recovery failed.");
 			return -1;
 		}
 		return -1;
 	}
-
 	if (state->rxbuffer[7] != dst_check_sum(state->rxbuffer, 7)) {
-		dprintk("%s: checksum failure\n", __FUNCTION__);
+		dprintk(verbose, DST_INFO, 1, "checksum failure");
 		return -1;
 	}
 
@@ -924,7 +878,7 @@ int dst_command(struct dst_state* state,
 }
 EXPORT_SYMBOL(dst_command);
 
-static int dst_get_signal(struct dst_state* state)
+static int dst_get_signal(struct dst_state *state)
 {
 	int retval;
 	u8 get_signal[] = { 0x00, 0x05, 0x00, 0x00, 0x00, 0x00, 0x00, 0xfb };
@@ -955,13 +909,12 @@ static int dst_get_signal(struct dst_sta
 	return 0;
 }
 
-static int dst_tone_power_cmd(struct dst_state* state)
+static int dst_tone_power_cmd(struct dst_state *state)
 {
 	u8 paket[8] = { 0x00, 0x09, 0xff, 0xff, 0x01, 0x00, 0x00, 0x00 };
 
 	if (state->dst_type == DST_TYPE_IS_TERR)
 		return 0;
-
 	paket[4] = state->tx_tuna[4];
 	paket[2] = state->tx_tuna[2];
 	paket[3] = state->tx_tuna[3];
@@ -971,61 +924,53 @@ static int dst_tone_power_cmd(struct dst
 	return 0;
 }
 
-static int dst_get_tuna(struct dst_state* state)
+static int dst_get_tuna(struct dst_state *state)
 {
 	int retval;
 
 	if ((state->diseq_flags & ATTEMPT_TUNE) == 0)
 		return 0;
-
 	state->diseq_flags &= ~(HAS_LOCK);
 	if (!dst_wait_dst_ready(state, NO_DELAY))
 		return 0;
-
-	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
+	if (state->type_flags & DST_TYPE_HAS_NEWTUNE)
 		/* how to get variable length reply ???? */
 		retval = read_dst(state, state->rx_tuna, 10);
-	} else {
+	else
 		retval = read_dst(state, &state->rx_tuna[2], FIXED_COMM);
-	}
-
 	if (retval < 0) {
-		dprintk("%s: read not successful\n", __FUNCTION__);
+		dprintk(verbose, DST_DEBUG, 1, "read not successful");
 		return 0;
 	}
-
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
 		if (state->rx_tuna[9] != dst_check_sum(&state->rx_tuna[0], 9)) {
-			dprintk("%s: checksum failure?\n", __FUNCTION__);
+			dprintk(verbose, DST_INFO, 1, "checksum failure ? ");
 			return 0;
 		}
 	} else {
 		if (state->rx_tuna[9] != dst_check_sum(&state->rx_tuna[2], 7)) {
-			dprintk("%s: checksum failure?\n", __FUNCTION__);
+			dprintk(verbose, DST_INFO, 1, "checksum failure? ");
 			return 0;
 		}
 	}
 	if (state->rx_tuna[2] == 0 && state->rx_tuna[3] == 0)
 		return 0;
 	state->decode_freq = ((state->rx_tuna[2] & 0x7f) << 8) + state->rx_tuna[3];
-
 	state->decode_lock = 1;
 	state->diseq_flags |= HAS_LOCK;
 
 	return 1;
 }
 
-static int dst_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage);
+static int dst_set_voltage(struct dvb_frontend *fe, fe_sec_voltage_t voltage);
 
-static int dst_write_tuna(struct dvb_frontend* fe)
+static int dst_write_tuna(struct dvb_frontend *fe)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 	int retval;
 	u8 reply;
 
-	if (debug > 4)
-		dprintk("%s: type_flags 0x%x \n", __FUNCTION__, state->type_flags);
-
+	dprintk(verbose, DST_INFO, 1, "type_flags 0x%x ", state->type_flags);
 	state->decode_freq = 0;
 	state->decode_lock = state->decode_strength = state->decode_snr = 0;
 	if (state->dst_type == DST_TYPE_IS_SAT) {
@@ -1035,35 +980,31 @@ static int dst_write_tuna(struct dvb_fro
 	state->diseq_flags &= ~(HAS_LOCK | ATTEMPT_TUNE);
 
 	if ((dst_comm_init(state)) < 0) {
-		dprintk("%s: DST Communication initialization failed.\n", __FUNCTION__);
+		dprintk(verbose, DST_DEBUG, 1, "DST Communication initialization failed.");
 		return -1;
 	}
-
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
 		state->tx_tuna[9] = dst_check_sum(&state->tx_tuna[0], 9);
 		retval = write_dst(state, &state->tx_tuna[0], 10);
-
 	} else {
 		state->tx_tuna[9] = dst_check_sum(&state->tx_tuna[2], 7);
 		retval = write_dst(state, &state->tx_tuna[2], FIXED_COMM);
 	}
 	if (retval < 0) {
 		dst_pio_disable(state);
-		dprintk("%s: write not successful\n", __FUNCTION__);
+		dprintk(verbose, DST_DEBUG, 1, "write not successful");
 		return retval;
 	}
-
 	if ((dst_pio_disable(state)) < 0) {
-		dprintk("%s: DST PIO disable failed !\n", __FUNCTION__);
+		dprintk(verbose, DST_DEBUG, 1, "DST PIO disable failed !");
 		return -1;
 	}
-
 	if ((read_dst(state, &reply, GET_ACK) < 0)) {
-		dprintk("%s: read verify not successful.\n", __FUNCTION__);
+		dprintk(verbose, DST_DEBUG, 1, "read verify not successful.");
 		return -1;
 	}
 	if (reply != ACK) {
-		dprintk("%s: write not acknowledged 0x%02x \n", __FUNCTION__, reply);
+		dprintk(verbose, DST_DEBUG, 1, "write not acknowledged 0x%02x ", reply);
 		return 0;
 	}
 	state->diseq_flags |= ATTEMPT_TUNE;
@@ -1085,14 +1026,13 @@ static int dst_write_tuna(struct dvb_fro
  * Diseqc 4    0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xfc, 0xe0
  */
 
-static int dst_set_diseqc(struct dvb_frontend* fe, struct dvb_diseqc_master_cmd* cmd)
+static int dst_set_diseqc(struct dvb_frontend *fe, struct dvb_diseqc_master_cmd *cmd)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 	u8 paket[8] = { 0x00, 0x08, 0x04, 0xe0, 0x10, 0x38, 0xf0, 0xec };
 
 	if (state->dst_type != DST_TYPE_IS_SAT)
 		return 0;
-
 	if (cmd->msg_len == 0 || cmd->msg_len > 4)
 		return -EINVAL;
 	memcpy(&paket[3], cmd->msg, cmd->msg_len);
@@ -1101,65 +1041,61 @@ static int dst_set_diseqc(struct dvb_fro
 	return 0;
 }
 
-static int dst_set_voltage(struct dvb_frontend* fe, fe_sec_voltage_t voltage)
+static int dst_set_voltage(struct dvb_frontend *fe, fe_sec_voltage_t voltage)
 {
 	int need_cmd;
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 
 	state->voltage = voltage;
-
 	if (state->dst_type != DST_TYPE_IS_SAT)
 		return 0;
 
 	need_cmd = 0;
-	switch (voltage) {
-		case SEC_VOLTAGE_13:
-		case SEC_VOLTAGE_18:
-			if ((state->diseq_flags & HAS_POWER) == 0)
-				need_cmd = 1;
-			state->diseq_flags |= HAS_POWER;
-			state->tx_tuna[4] = 0x01;
-			break;
 
-		case SEC_VOLTAGE_OFF:
+	switch (voltage) {
+	case SEC_VOLTAGE_13:
+	case SEC_VOLTAGE_18:
+		if ((state->diseq_flags & HAS_POWER) == 0)
 			need_cmd = 1;
-			state->diseq_flags &= ~(HAS_POWER | HAS_LOCK | ATTEMPT_TUNE);
-			state->tx_tuna[4] = 0x00;
-			break;
-
-		default:
-			return -EINVAL;
+		state->diseq_flags |= HAS_POWER;
+		state->tx_tuna[4] = 0x01;
+		break;
+	case SEC_VOLTAGE_OFF:
+		need_cmd = 1;
+		state->diseq_flags &= ~(HAS_POWER | HAS_LOCK | ATTEMPT_TUNE);
+		state->tx_tuna[4] = 0x00;
+		break;
+	default:
+		return -EINVAL;
 	}
+
 	if (need_cmd)
 		dst_tone_power_cmd(state);
 
 	return 0;
 }
 
-static int dst_set_tone(struct dvb_frontend* fe, fe_sec_tone_mode_t tone)
+static int dst_set_tone(struct dvb_frontend *fe, fe_sec_tone_mode_t tone)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 
 	state->tone = tone;
-
 	if (state->dst_type != DST_TYPE_IS_SAT)
 		return 0;
 
 	switch (tone) {
-		case SEC_TONE_OFF:
-			if (state->type_flags & DST_TYPE_HAS_OBS_REGS)
-			    state->tx_tuna[2] = 0x00;
-			else
-			    state->tx_tuna[2] = 0xff;
-
-			break;
-
-		case SEC_TONE_ON:
-			state->tx_tuna[2] = 0x02;
-			break;
+	case SEC_TONE_OFF:
+		if (state->type_flags & DST_TYPE_HAS_OBS_REGS)
+		    state->tx_tuna[2] = 0x00;
+		else
+		    state->tx_tuna[2] = 0xff;
+		break;
 
-		default:
-			return -EINVAL;
+	case SEC_TONE_ON:
+		state->tx_tuna[2] = 0x02;
+		break;
+	default:
+		return -EINVAL;
 	}
 	dst_tone_power_cmd(state);
 
@@ -1172,16 +1108,14 @@ static int dst_send_burst(struct dvb_fro
 
 	if (state->dst_type != DST_TYPE_IS_SAT)
 		return 0;
-
 	state->minicmd = minicmd;
-
 	switch (minicmd) {
-		case SEC_MINI_A:
-			state->tx_tuna[3] = 0x02;
-			break;
-		case SEC_MINI_B:
-			state->tx_tuna[3] = 0xff;
-			break;
+	case SEC_MINI_A:
+		state->tx_tuna[3] = 0x02;
+		break;
+	case SEC_MINI_B:
+		state->tx_tuna[3] = 0xff;
+		break;
 	}
 	dst_tone_power_cmd(state);
 
@@ -1189,42 +1123,37 @@ static int dst_send_burst(struct dvb_fro
 }
 
 
-static int dst_init(struct dvb_frontend* fe)
+static int dst_init(struct dvb_frontend *fe)
 {
-	struct dst_state* state = fe->demodulator_priv;
-	static u8 ini_satci_tuna[] = { 9, 0, 3, 0xb6, 1, 0, 0x73, 0x21, 0, 0 };
-	static u8 ini_satfta_tuna[] = { 0, 0, 3, 0xb6, 1, 0x55, 0xbd, 0x50, 0, 0 };
-	static u8 ini_tvfta_tuna[] = { 0, 0, 3, 0xb6, 1, 7, 0x0, 0x0, 0, 0 };
-	static u8 ini_tvci_tuna[] = { 9, 0, 3, 0xb6, 1, 7, 0x0, 0x0, 0, 0 };
-	static u8 ini_cabfta_tuna[] = { 0, 0, 3, 0xb6, 1, 7, 0x0, 0x0, 0, 0 };
-	static u8 ini_cabci_tuna[] = { 9, 0, 3, 0xb6, 1, 7, 0x0, 0x0, 0, 0 };
-//	state->inversion = INVERSION_ON;
+	struct dst_state *state = fe->demodulator_priv;
+
+	static u8 sat_tuna_188[] = { 0x09, 0x00, 0x03, 0xb6, 0x01, 0x00, 0x73, 0x21, 0x00, 0x00 };
+	static u8 sat_tuna_204[] = { 0x00, 0x00, 0x03, 0xb6, 0x01, 0x55, 0xbd, 0x50, 0x00, 0x00 };
+	static u8 ter_tuna_188[] = { 0x09, 0x00, 0x03, 0xb6, 0x01, 0x07, 0x00, 0x00, 0x00, 0x00 };
+	static u8 ter_tuna_204[] = { 0x00, 0x00, 0x03, 0xb6, 0x01, 0x07, 0x00, 0x00, 0x00, 0x00 };
+	static u8 cab_tuna_204[] = { 0x00, 0x00, 0x03, 0xb6, 0x01, 0x07, 0x00, 0x00, 0x00, 0x00 };
+	static u8 cab_tuna_188[] = { 0x09, 0x00, 0x03, 0xb6, 0x01, 0x07, 0x00, 0x00, 0x00, 0x00 };
+
 	state->inversion = INVERSION_OFF;
 	state->voltage = SEC_VOLTAGE_13;
 	state->tone = SEC_TONE_OFF;
-	state->symbol_rate = 29473000;
-	state->fec = FEC_AUTO;
 	state->diseq_flags = 0;
 	state->k22 = 0x02;
 	state->bandwidth = BANDWIDTH_7_MHZ;
 	state->cur_jiff = jiffies;
-	if (state->dst_type == DST_TYPE_IS_SAT) {
-		state->frequency = 950000;
-		memcpy(state->tx_tuna, ((state->type_flags & DST_TYPE_HAS_NEWTUNE) ? ini_satci_tuna : ini_satfta_tuna), sizeof(ini_satfta_tuna));
-	} else if (state->dst_type == DST_TYPE_IS_TERR) {
-		state->frequency = 137000000;
-		memcpy(state->tx_tuna, ((state->type_flags & DST_TYPE_HAS_NEWTUNE) ? ini_tvci_tuna : ini_tvfta_tuna), sizeof(ini_tvfta_tuna));
-	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
-		state->frequency = 51000000;
-		memcpy(state->tx_tuna, ((state->type_flags & DST_TYPE_HAS_NEWTUNE) ? ini_cabci_tuna : ini_cabfta_tuna), sizeof(ini_cabfta_tuna));
-	}
+	if (state->dst_type == DST_TYPE_IS_SAT)
+		memcpy(state->tx_tuna, ((state->type_flags & DST_TYPE_HAS_NEWTUNE) ? sat_tuna_188 : sat_tuna_204), sizeof (sat_tuna_204));
+	else if (state->dst_type == DST_TYPE_IS_TERR)
+		memcpy(state->tx_tuna, ((state->type_flags & DST_TYPE_HAS_NEWTUNE) ? ter_tuna_188 : ter_tuna_204), sizeof (ter_tuna_204));
+	else if (state->dst_type == DST_TYPE_IS_CABLE)
+		memcpy(state->tx_tuna, ((state->type_flags & DST_TYPE_HAS_NEWTUNE) ? cab_tuna_188 : cab_tuna_204), sizeof (cab_tuna_204));
 
 	return 0;
 }
 
-static int dst_read_status(struct dvb_frontend* fe, fe_status_t* status)
+static int dst_read_status(struct dvb_frontend *fe, fe_status_t *status)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 
 	*status = 0;
 	if (state->diseq_flags & HAS_LOCK) {
@@ -1236,9 +1165,9 @@ static int dst_read_status(struct dvb_fr
 	return 0;
 }
 
-static int dst_read_signal_strength(struct dvb_frontend* fe, u16* strength)
+static int dst_read_signal_strength(struct dvb_frontend *fe, u16 *strength)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 
 	dst_get_signal(state);
 	*strength = state->decode_strength;
@@ -1246,9 +1175,9 @@ static int dst_read_signal_strength(stru
 	return 0;
 }
 
-static int dst_read_snr(struct dvb_frontend* fe, u16* snr)
+static int dst_read_snr(struct dvb_frontend *fe, u16 *snr)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 
 	dst_get_signal(state);
 	*snr = state->decode_snr;
@@ -1256,28 +1185,24 @@ static int dst_read_snr(struct dvb_front
 	return 0;
 }
 
-static int dst_set_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
+static int dst_set_frontend(struct dvb_frontend *fe, struct dvb_frontend_parameters *p)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 
 	dst_set_freq(state, p->frequency);
-	if (verbose > 4)
-		dprintk("Set Frequency=[%d]\n", p->frequency);
+	dprintk(verbose, DST_DEBUG, 1, "Set Frequency=[%d]", p->frequency);
 
-//	dst_set_inversion(state, p->inversion);
 	if (state->dst_type == DST_TYPE_IS_SAT) {
 		if (state->type_flags & DST_TYPE_HAS_OBS_REGS)
 			dst_set_inversion(state, p->inversion);
-
 		dst_set_fec(state, p->u.qpsk.fec_inner);
 		dst_set_symbolrate(state, p->u.qpsk.symbol_rate);
 		dst_set_polarization(state);
-		if (verbose > 4)
-			dprintk("Set Symbolrate=[%d]\n", p->u.qpsk.symbol_rate);
+		dprintk(verbose, DST_DEBUG, 1, "Set Symbolrate=[%d]", p->u.qpsk.symbol_rate);
 
-	} else if (state->dst_type == DST_TYPE_IS_TERR) {
+	} else if (state->dst_type == DST_TYPE_IS_TERR)
 		dst_set_bandwidth(state, p->u.ofdm.bandwidth);
-	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
+	else if (state->dst_type == DST_TYPE_IS_CABLE) {
 		dst_set_fec(state, p->u.qam.fec_inner);
 		dst_set_symbolrate(state, p->u.qam.symbol_rate);
 		dst_set_modulation(state, p->u.qam.modulation);
@@ -1287,16 +1212,14 @@ static int dst_set_frontend(struct dvb_f
 	return 0;
 }
 
-static int dst_get_frontend(struct dvb_frontend* fe, struct dvb_frontend_parameters *p)
+static int dst_get_frontend(struct dvb_frontend *fe, struct dvb_frontend_parameters *p)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 
 	p->frequency = state->decode_freq;
-//	p->inversion = state->inversion;
 	if (state->dst_type == DST_TYPE_IS_SAT) {
 		if (state->type_flags & DST_TYPE_HAS_OBS_REGS)
 			p->inversion = state->inversion;
-
 		p->u.qpsk.symbol_rate = state->symbol_rate;
 		p->u.qpsk.fec_inner = dst_get_fec(state);
 	} else if (state->dst_type == DST_TYPE_IS_TERR) {
@@ -1304,16 +1227,15 @@ static int dst_get_frontend(struct dvb_f
 	} else if (state->dst_type == DST_TYPE_IS_CABLE) {
 		p->u.qam.symbol_rate = state->symbol_rate;
 		p->u.qam.fec_inner = dst_get_fec(state);
-//		p->u.qam.modulation = QAM_AUTO;
 		p->u.qam.modulation = dst_get_modulation(state);
 	}
 
 	return 0;
 }
 
-static void dst_release(struct dvb_frontend* fe)
+static void dst_release(struct dvb_frontend *fe)
 {
-	struct dst_state* state = fe->demodulator_priv;
+	struct dst_state *state = fe->demodulator_priv;
 	kfree(state);
 }
 
@@ -1321,9 +1243,8 @@ static struct dvb_frontend_ops dst_dvbt_
 static struct dvb_frontend_ops dst_dvbs_ops;
 static struct dvb_frontend_ops dst_dvbc_ops;
 
-struct dst_state* dst_attach(struct dst_state *state, struct dvb_adapter *dvb_adapter)
+struct dst_state *dst_attach(struct dst_state *state, struct dvb_adapter *dvb_adapter)
 {
-
 	/* check if the ASIC is there */
 	if (dst_probe(state) < 0) {
 		if (state)
@@ -1336,17 +1257,14 @@ struct dst_state* dst_attach(struct dst_
 	case DST_TYPE_IS_TERR:
 		memcpy(&state->ops, &dst_dvbt_ops, sizeof(struct dvb_frontend_ops));
 		break;
-
 	case DST_TYPE_IS_CABLE:
 		memcpy(&state->ops, &dst_dvbc_ops, sizeof(struct dvb_frontend_ops));
 		break;
-
 	case DST_TYPE_IS_SAT:
 		memcpy(&state->ops, &dst_dvbs_ops, sizeof(struct dvb_frontend_ops));
 		break;
-
 	default:
-		printk("%s: unknown DST type. please report to the LinuxTV.org DVB mailinglist.\n", __FUNCTION__);
+		dprintk(verbose, DST_ERROR, 1, "unknown DST type. please report to the LinuxTV.org DVB mailinglist.");
 		if (state)
 			kfree(state);
 
@@ -1374,12 +1292,9 @@ static struct dvb_frontend_ops dst_dvbt_
 	},
 
 	.release = dst_release,
-
 	.init = dst_init,
-
 	.set_frontend = dst_set_frontend,
 	.get_frontend = dst_get_frontend,
-
 	.read_status = dst_read_status,
 	.read_signal_strength = dst_read_signal_strength,
 	.read_snr = dst_read_snr,
@@ -1401,16 +1316,12 @@ static struct dvb_frontend_ops dst_dvbs_
 	},
 
 	.release = dst_release,
-
 	.init = dst_init,
-
 	.set_frontend = dst_set_frontend,
 	.get_frontend = dst_get_frontend,
-
 	.read_status = dst_read_status,
 	.read_signal_strength = dst_read_signal_strength,
 	.read_snr = dst_read_snr,
-
 	.diseqc_send_burst = dst_send_burst,
 	.diseqc_send_master_cmd = dst_set_diseqc,
 	.set_voltage = dst_set_voltage,
@@ -1432,18 +1343,14 @@ static struct dvb_frontend_ops dst_dvbc_
 	},
 
 	.release = dst_release,
-
 	.init = dst_init,
-
 	.set_frontend = dst_set_frontend,
 	.get_frontend = dst_get_frontend,
-
 	.read_status = dst_read_status,
 	.read_signal_strength = dst_read_signal_strength,
 	.read_snr = dst_read_snr,
 };
 
-
 MODULE_DESCRIPTION("DST DVB-S/T/C Combo Frontend driver");
 MODULE_AUTHOR("Jamie Honan, Manu Abraham");
 MODULE_LICENSE("GPL");
--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst_ca.c	2005-09-04 22:28:33.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst_ca.c	2005-09-04 22:28:34.000000000 +0200
@@ -18,30 +18,42 @@
 	Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */
 
-
-
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/string.h>
-
 #include <linux/dvb/ca.h>
 #include "dvbdev.h"
 #include "dvb_frontend.h"
-
 #include "dst_ca.h"
 #include "dst_common.h"
 
+#define DST_CA_ERROR		0
+#define DST_CA_NOTICE		1
+#define DST_CA_INFO		2
+#define DST_CA_DEBUG		3
+
+#define dprintk(x, y, z, format, arg...) do {						\
+	if (z) {									\
+		if	((x > DST_CA_ERROR) && (x > y))					\
+			printk(KERN_ERR "%s: " format "\n", __FUNCTION__ , ##arg);	\
+		else if	((x > DST_CA_NOTICE) && (x > y))				\
+			printk(KERN_NOTICE "%s: " format "\n", __FUNCTION__, ##arg);	\
+		else if ((x > DST_CA_INFO) && (x > y))					\
+			printk(KERN_INFO "%s: " format "\n", __FUNCTION__, ##arg);	\
+		else if ((x > DST_CA_DEBUG) && (x > y))					\
+			printk(KERN_DEBUG "%s: " format "\n", __FUNCTION__, ##arg);	\
+	} else {									\
+		if (x > y)								\
+			printk(format, ##arg);						\
+	}										\
+} while(0)
+
+
 static unsigned int verbose = 5;
 module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, "verbose startup messages, default is 1 (yes)");
 
-static unsigned int debug = 1;
-module_param(debug, int, 0644);
-MODULE_PARM_DESC(debug, "debug messages, default is 1 (yes)");
-
-#define dprintk if (debug) printk
-
 /*	Need some more work	*/
 static int ca_set_slot_descr(void)
 {
@@ -61,27 +73,20 @@ static int put_checksum(u8 *check_string
 {
 	u8 i = 0, checksum = 0;
 
-	if (verbose > 3) {
-		dprintk("%s: ========================= Checksum calculation ===========================\n", __FUNCTION__);
-		dprintk("%s: String Length=[0x%02x]\n", __FUNCTION__, length);
+	dprintk(verbose, DST_CA_DEBUG, 1, " ========================= Checksum calculation ===========================");
+	dprintk(verbose, DST_CA_DEBUG, 1, " String Length=[0x%02x]", length);
+	dprintk(verbose, DST_CA_DEBUG, 1, " String=[");
 
-		dprintk("%s: String=[", __FUNCTION__);
-	}
 	while (i < length) {
-		if (verbose > 3)
-			dprintk(" %02x", check_string[i]);
+		dprintk(verbose, DST_CA_DEBUG, 0, " %02x", check_string[i]);
 		checksum += check_string[i];
 		i++;
 	}
-	if (verbose > 3) {
-		dprintk(" ]\n");
-		dprintk("%s: Sum=[%02x]\n", __FUNCTION__, checksum);
-	}
+	dprintk(verbose, DST_CA_DEBUG, 0, " ]\n");
+	dprintk(verbose, DST_CA_DEBUG, 1, "Sum=[%02x]\n", checksum);
 	check_string[length] = ~checksum + 1;
-	if (verbose > 3) {
-		dprintk("%s: Checksum=[%02x]\n", __FUNCTION__, check_string[length]);
-		dprintk("%s: ==========================================================================\n", __FUNCTION__);
-	}
+	dprintk(verbose, DST_CA_DEBUG, 1, " Checksum=[%02x]", check_string[length]);
+	dprintk(verbose, DST_CA_DEBUG, 1, " ==========================================================================");
 
 	return 0;
 }
@@ -94,30 +99,26 @@ static int dst_ci_command(struct dst_sta
 	msleep(65);
 
 	if (write_dst(state, data, len)) {
-		dprintk("%s: Write not successful, trying to recover\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_INFO, 1, " Write not successful, trying to recover");
 		dst_error_recovery(state);
 		return -1;
 	}
-
 	if ((dst_pio_disable(state)) < 0) {
-		dprintk("%s: DST PIO disable failed.\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " DST PIO disable failed.");
 		return -1;
 	}
-
 	if (read_dst(state, &reply, GET_ACK) < 0) {
-		dprintk("%s: Read not successful, trying to recover\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_INFO, 1, " Read not successful, trying to recover");
 		dst_error_recovery(state);
 		return -1;
 	}
-
 	if (read) {
 		if (! dst_wait_dst_ready(state, LONG_DELAY)) {
-			dprintk("%s: 8820 not ready\n", __FUNCTION__);
+			dprintk(verbose, DST_CA_NOTICE, 1, " 8820 not ready");
 			return -1;
 		}
-
 		if (read_dst(state, ca_string, 128) < 0) {	/*	Try to make this dynamic	*/
-			dprintk("%s: Read not successful, trying to recover\n", __FUNCTION__);
+			dprintk(verbose, DST_CA_INFO, 1, " Read not successful, trying to recover");
 			dst_error_recovery(state);
 			return -1;
 		}
@@ -133,8 +134,7 @@ static int dst_put_ci(struct dst_state *
 
 	while (dst_ca_comm_err < RETRIES) {
 		dst_comm_init(state);
-		if (verbose > 2)
-			dprintk("%s: Put Command\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_NOTICE, 1, " Put Command");
 		if (dst_ci_command(state, data, ca_string, len, read)) {	// If error
 			dst_error_recovery(state);
 			dst_ca_comm_err++; // work required here.
@@ -153,18 +153,15 @@ static int ca_get_app_info(struct dst_st
 
 	put_checksum(&command[0], command[0]);
 	if ((dst_put_ci(state, command, sizeof(command), state->messages, GET_REPLY)) < 0) {
-		dprintk("%s: -->dst_put_ci FAILED !\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " -->dst_put_ci FAILED !");
 		return -1;
 	}
-	if (verbose > 1) {
-		dprintk("%s: -->dst_put_ci SUCCESS !\n", __FUNCTION__);
-
-		dprintk("%s: ================================ CI Module Application Info ======================================\n", __FUNCTION__);
-		dprintk("%s: Application Type=[%d], Application Vendor=[%d], Vendor Code=[%d]\n%s: Application info=[%s]\n",
-			__FUNCTION__, state->messages[7], (state->messages[8] << 8) | state->messages[9],
-			(state->messages[10] << 8) | state->messages[11], __FUNCTION__, (char *)(&state->messages[12]));
-		dprintk("%s: ==================================================================================================\n", __FUNCTION__);
-	}
+	dprintk(verbose, DST_CA_INFO, 1, " -->dst_put_ci SUCCESS !");
+	dprintk(verbose, DST_CA_INFO, 1, " ================================ CI Module Application Info ======================================");
+	dprintk(verbose, DST_CA_INFO, 1, " Application Type=[%d], Application Vendor=[%d], Vendor Code=[%d]\n%s: Application info=[%s]",
+		state->messages[7], (state->messages[8] << 8) | state->messages[9],
+		(state->messages[10] << 8) | state->messages[11], __FUNCTION__, (char *)(&state->messages[12]));
+	dprintk(verbose, DST_CA_INFO, 1, " ==================================================================================================");
 
 	return 0;
 }
@@ -177,31 +174,26 @@ static int ca_get_slot_caps(struct dst_s
 
 	put_checksum(&slot_command[0], slot_command[0]);
 	if ((dst_put_ci(state, slot_command, sizeof (slot_command), slot_cap, GET_REPLY)) < 0) {
-		dprintk("%s: -->dst_put_ci FAILED !\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " -->dst_put_ci FAILED !");
 		return -1;
 	}
-	if (verbose > 1)
-		dprintk("%s: -->dst_put_ci SUCCESS !\n", __FUNCTION__);
+	dprintk(verbose, DST_CA_NOTICE, 1, " -->dst_put_ci SUCCESS !");
 
 	/*	Will implement the rest soon		*/
 
-	if (verbose > 1) {
-		dprintk("%s: Slot cap = [%d]\n", __FUNCTION__, slot_cap[7]);
-		dprintk("===================================\n");
-		for (i = 0; i < 8; i++)
-			dprintk(" %d", slot_cap[i]);
-		dprintk("\n");
-	}
+	dprintk(verbose, DST_CA_INFO, 1, " Slot cap = [%d]", slot_cap[7]);
+	dprintk(verbose, DST_CA_INFO, 0, "===================================\n");
+	for (i = 0; i < 8; i++)
+		dprintk(verbose, DST_CA_INFO, 0, " %d", slot_cap[i]);
+	dprintk(verbose, DST_CA_INFO, 0, "\n");
 
 	p_ca_caps->slot_num = 1;
 	p_ca_caps->slot_type = 1;
 	p_ca_caps->descr_num = slot_cap[7];
 	p_ca_caps->descr_type = 1;
 
-
-	if (copy_to_user((struct ca_caps *)arg, p_ca_caps, sizeof (struct ca_caps))) {
+	if (copy_to_user((struct ca_caps *)arg, p_ca_caps, sizeof (struct ca_caps)))
 		return -EFAULT;
-	}
 
 	return 0;
 }
@@ -222,39 +214,32 @@ static int ca_get_slot_info(struct dst_s
 
 	put_checksum(&slot_command[0], 7);
 	if ((dst_put_ci(state, slot_command, sizeof (slot_command), slot_info, GET_REPLY)) < 0) {
-		dprintk("%s: -->dst_put_ci FAILED !\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " -->dst_put_ci FAILED !");
 		return -1;
 	}
-	if (verbose > 1)
-		dprintk("%s: -->dst_put_ci SUCCESS !\n", __FUNCTION__);
+	dprintk(verbose, DST_CA_INFO, 1, " -->dst_put_ci SUCCESS !");
 
 	/*	Will implement the rest soon		*/
 
-	if (verbose > 1) {
-		dprintk("%s: Slot info = [%d]\n", __FUNCTION__, slot_info[3]);
-		dprintk("===================================\n");
-		for (i = 0; i < 8; i++)
-			dprintk(" %d", slot_info[i]);
-		dprintk("\n");
-	}
+	dprintk(verbose, DST_CA_INFO, 1, " Slot info = [%d]", slot_info[3]);
+	dprintk(verbose, DST_CA_INFO, 0, "===================================\n");
+	for (i = 0; i < 8; i++)
+		dprintk(verbose, DST_CA_INFO, 0, " %d", slot_info[i]);
+	dprintk(verbose, DST_CA_INFO, 0, "\n");
 
 	if (slot_info[4] & 0x80) {
 		p_ca_slot_info->flags = CA_CI_MODULE_PRESENT;
 		p_ca_slot_info->num = 1;
 		p_ca_slot_info->type = CA_CI;
-	}
-	else if (slot_info[4] & 0x40) {
+	} else if (slot_info[4] & 0x40) {
 		p_ca_slot_info->flags = CA_CI_MODULE_READY;
 		p_ca_slot_info->num = 1;
 		p_ca_slot_info->type = CA_CI;
-	}
-	else {
+	} else
 		p_ca_slot_info->flags = 0;
-	}
 
-	if (copy_to_user((struct ca_slot_info *)arg, p_ca_slot_info, sizeof (struct ca_slot_info))) {
+	if (copy_to_user((struct ca_slot_info *)arg, p_ca_slot_info, sizeof (struct ca_slot_info)))
 		return -EFAULT;
-	}
 
 	return 0;
 }
@@ -268,24 +253,21 @@ static int ca_get_message(struct dst_sta
 	if (copy_from_user(p_ca_message, (void *)arg, sizeof (struct ca_msg)))
 		return -EFAULT;
 
-
 	if (p_ca_message->msg) {
-		if (verbose > 3)
-			dprintk("Message = [%02x %02x %02x]\n", p_ca_message->msg[0], p_ca_message->msg[1], p_ca_message->msg[2]);
+		dprintk(verbose, DST_CA_NOTICE, 1, " Message = [%02x %02x %02x]", p_ca_message->msg[0], p_ca_message->msg[1], p_ca_message->msg[2]);
 
 		for (i = 0; i < 3; i++) {
 			command = command | p_ca_message->msg[i];
 			if (i < 2)
 				command = command << 8;
 		}
-		if (verbose > 3)
-			dprintk("%s:Command=[0x%x]\n", __FUNCTION__, command);
+		dprintk(verbose, DST_CA_NOTICE, 1, " Command=[0x%x]", command);
 
 		switch (command) {
-			case CA_APP_INFO:
-				memcpy(p_ca_message->msg, state->messages, 128);
-				if (copy_to_user((void *)arg, p_ca_message, sizeof (struct ca_msg)) )
-					return -EFAULT;
+		case CA_APP_INFO:
+			memcpy(p_ca_message->msg, state->messages, 128);
+			if (copy_to_user((void *)arg, p_ca_message, sizeof (struct ca_msg)) )
+				return -EFAULT;
 			break;
 		}
 	}
@@ -300,10 +282,9 @@ static int handle_dst_tag(struct dst_sta
 		hw_buffer->msg[3] = p_ca_message->msg[2];	/*	LSB	*/
 	} else {
 		if (length > 247) {
-			dprintk("%s: Message too long ! *** Bailing Out *** !\n", __FUNCTION__);
+			dprintk(verbose, DST_CA_ERROR, 1, " Message too long ! *** Bailing Out *** !");
 			return -1;
 		}
-
 		hw_buffer->msg[0] = (length & 0xff) + 7;
 		hw_buffer->msg[1] = 0x40;
 		hw_buffer->msg[2] = 0x03;
@@ -324,13 +305,12 @@ static int handle_dst_tag(struct dst_sta
 static int write_to_8820(struct dst_state *state, struct ca_msg *hw_buffer, u8 length, u8 reply)
 {
 	if ((dst_put_ci(state, hw_buffer->msg, length, hw_buffer->msg, reply)) < 0) {
-		dprintk("%s: DST-CI Command failed.\n", __FUNCTION__);
-		dprintk("%s: Resetting DST.\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " DST-CI Command failed.");
+		dprintk(verbose, DST_CA_NOTICE, 1, " Resetting DST.");
 		rdc_reset_state(state);
 		return -1;
 	}
-	if (verbose > 2)
-		dprintk("%s: DST-CI Command succes.\n", __FUNCTION__);
+	dprintk(verbose, DST_CA_NOTICE, 1, " DST-CI Command succes.");
 
 	return 0;
 }
@@ -341,15 +321,15 @@ u32 asn_1_decode(u8 *asn_1_array)
 	u32 length = 0;
 
 	length_field = asn_1_array[0];
-	dprintk("%s: Length field=[%02x]\n", __FUNCTION__, length_field);
+	dprintk(verbose, DST_CA_DEBUG, 1, " Length field=[%02x]", length_field);
 	if (length_field < 0x80) {
 		length = length_field & 0x7f;
-		dprintk("%s: Length=[%02x]\n", __FUNCTION__, length);
+		dprintk(verbose, DST_CA_DEBUG, 1, " Length=[%02x]\n", length);
 	} else {
 		word_count = length_field & 0x7f;
 		for (count = 0; count < word_count; count++) {
 			length = (length | asn_1_array[count + 1]) << 8;
-			dprintk("%s: Length=[%04x]\n", __FUNCTION__, length);
+			dprintk(verbose, DST_CA_DEBUG, 1, " Length=[%04x]", length);
 		}
 	}
 	return length;
@@ -359,10 +339,10 @@ static int debug_string(u8 *msg, u32 len
 {
 	u32 i;
 
-	dprintk(" String=[ ");
+	dprintk(verbose, DST_CA_DEBUG, 0, " String=[ ");
 	for (i = offset; i < length; i++)
-		dprintk("%02x ", msg[i]);
-	dprintk("]\n");
+		dprintk(verbose, DST_CA_DEBUG, 0, "%02x ", msg[i]);
+	dprintk(verbose, DST_CA_DEBUG, 0, "]\n");
 
 	return 0;
 }
@@ -373,8 +353,7 @@ static int ca_set_pmt(struct dst_state *
 	u8 tag_length = 8;
 
 	length = asn_1_decode(&p_ca_message->msg[3]);
-	dprintk("%s: CA Message length=[%d]\n", __FUNCTION__, length);
-	dprintk("%s: ASN.1 ", __FUNCTION__);
+	dprintk(verbose, DST_CA_DEBUG, 1, " CA Message length=[%d]", length);
 	debug_string(&p_ca_message->msg[4], length, 0); /*	length is excluding tag & length	*/
 
 	memset(hw_buffer->msg, '\0', length);
@@ -396,26 +375,24 @@ static int dst_check_ca_pmt(struct dst_s
 	/*	Do test board			*/
 	/*	Not there yet but soon		*/
 
-
 	/*	CA PMT Reply capable		*/
 	if (ca_pmt_reply_test) {
 		if ((ca_set_pmt(state, p_ca_message, hw_buffer, 1, GET_REPLY)) < 0) {
-			dprintk("%s: ca_set_pmt.. failed !\n", __FUNCTION__);
+			dprintk(verbose, DST_CA_ERROR, 1, " ca_set_pmt.. failed !");
 			return -1;
 		}
 
 	/*	Process CA PMT Reply		*/
 	/*	will implement soon		*/
-		dprintk("%s: Not there yet\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " Not there yet");
 	}
 	/*	CA PMT Reply not capable	*/
 	if (!ca_pmt_reply_test) {
 		if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, NO_REPLY)) < 0) {
-			dprintk("%s: ca_set_pmt.. failed !\n", __FUNCTION__);
+			dprintk(verbose, DST_CA_ERROR, 1, " ca_set_pmt.. failed !");
 			return -1;
 		}
-		if (verbose > 3)
-			dprintk("%s: ca_set_pmt.. success !\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_NOTICE, 1, " ca_set_pmt.. success !");
 	/*	put a dummy message		*/
 
 	}
@@ -431,11 +408,10 @@ static int ca_send_message(struct dst_st
 	struct ca_msg *hw_buffer;
 
 	if ((hw_buffer = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
-		dprintk("%s: Memory allocation failure\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
 		return -ENOMEM;
 	}
-	if (verbose > 3)
-		dprintk("%s\n", __FUNCTION__);
+	dprintk(verbose, DST_CA_DEBUG, 1, " ");
 
 	if (copy_from_user(p_ca_message, (void *)arg, sizeof (struct ca_msg)))
 		return -EFAULT;
@@ -450,51 +426,35 @@ static int ca_send_message(struct dst_st
 			if (i < 2)
 				command = command << 8;
 		}
-		if (verbose > 3)
-			dprintk("%s:Command=[0x%x]\n", __FUNCTION__, command);
+		dprintk(verbose, DST_CA_DEBUG, 1, " Command=[0x%x]\n", command);
 
 		switch (command) {
-			case CA_PMT:
-				if (verbose > 3)
-//					dprintk("Command = SEND_CA_PMT\n");
-					dprintk("Command = SEND_CA_PMT\n");
-//				if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, 0)) < 0) {
-				if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, 0)) < 0) {	// code simplification started
-					dprintk("%s: -->CA_PMT Failed !\n", __FUNCTION__);
-					return -1;
-				}
-				if (verbose > 3)
-					dprintk("%s: -->CA_PMT Success !\n", __FUNCTION__);
-//				retval = dummy_set_pmt(state, p_ca_message, hw_buffer, 0, 0);
-
-				break;
-
-			case CA_PMT_REPLY:
-				if (verbose > 3)
-					dprintk("Command = CA_PMT_REPLY\n");
-				/*      Have to handle the 2 basic types of cards here  */
-				if ((dst_check_ca_pmt(state, p_ca_message, hw_buffer)) < 0) {
-					dprintk("%s: -->CA_PMT_REPLY Failed !\n", __FUNCTION__);
-					return -1;
-				}
-				if (verbose > 3)
-					dprintk("%s: -->CA_PMT_REPLY Success !\n", __FUNCTION__);
-
-				/*      Certain boards do behave different ?            */
-//				retval = ca_set_pmt(state, p_ca_message, hw_buffer, 1, 1);
-
-			case CA_APP_INFO_ENQUIRY:		// only for debugging
-				if (verbose > 3)
-					dprintk("%s: Getting Cam Application information\n", __FUNCTION__);
-
-				if ((ca_get_app_info(state)) < 0) {
-					dprintk("%s: -->CA_APP_INFO_ENQUIRY Failed !\n", __FUNCTION__);
-					return -1;
-				}
-				if (verbose > 3)
-					dprintk("%s: -->CA_APP_INFO_ENQUIRY Success !\n", __FUNCTION__);
+		case CA_PMT:
+			dprintk(verbose, DST_CA_DEBUG, 1, "Command = SEND_CA_PMT");
+			if ((ca_set_pmt(state, p_ca_message, hw_buffer, 0, 0)) < 0) {	// code simplification started
+				dprintk(verbose, DST_CA_ERROR, 1, " -->CA_PMT Failed !");
+				return -1;
+			}
+			dprintk(verbose, DST_CA_INFO, 1, " -->CA_PMT Success !");
+			break;
+		case CA_PMT_REPLY:
+			dprintk(verbose, DST_CA_INFO, 1, "Command = CA_PMT_REPLY");
+			/*      Have to handle the 2 basic types of cards here  */
+			if ((dst_check_ca_pmt(state, p_ca_message, hw_buffer)) < 0) {
+				dprintk(verbose, DST_CA_ERROR, 1, " -->CA_PMT_REPLY Failed !");
+				return -1;
+			}
+			dprintk(verbose, DST_CA_INFO, 1, " -->CA_PMT_REPLY Success !");
+			break;
+		case CA_APP_INFO_ENQUIRY:		// only for debugging
+			dprintk(verbose, DST_CA_INFO, 1, " Getting Cam Application information");
 
-				break;
+			if ((ca_get_app_info(state)) < 0) {
+				dprintk(verbose, DST_CA_ERROR, 1, " -->CA_APP_INFO_ENQUIRY Failed !");
+				return -1;
+			}
+			dprintk(verbose, DST_CA_INFO, 1, " -->CA_APP_INFO_ENQUIRY Success !");
+			break;
 		}
 	}
 	return 0;
@@ -509,121 +469,88 @@ static int dst_ca_ioctl(struct inode *in
 	struct ca_msg *p_ca_message;
 
 	if ((p_ca_message = (struct ca_msg *) kmalloc(sizeof (struct ca_msg), GFP_KERNEL)) == NULL) {
-		dprintk("%s: Memory allocation failure\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
 		return -ENOMEM;
 	}
-
 	if ((p_ca_slot_info = (struct ca_slot_info *) kmalloc(sizeof (struct ca_slot_info), GFP_KERNEL)) == NULL) {
-		dprintk("%s: Memory allocation failure\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
 		return -ENOMEM;
 	}
-
 	if ((p_ca_caps = (struct ca_caps *) kmalloc(sizeof (struct ca_caps), GFP_KERNEL)) == NULL) {
-		dprintk("%s: Memory allocation failure\n", __FUNCTION__);
+		dprintk(verbose, DST_CA_ERROR, 1, " Memory allocation failure");
 		return -ENOMEM;
 	}
-
 	/*	We have now only the standard ioctl's, the driver is upposed to handle internals.	*/
 	switch (cmd) {
-		case CA_SEND_MSG:
-			if (verbose > 1)
-				dprintk("%s: Sending message\n", __FUNCTION__);
-			if ((ca_send_message(state, p_ca_message, arg)) < 0) {
-				dprintk("%s: -->CA_SEND_MSG Failed !\n", __FUNCTION__);
-				return -1;
-			}
-
-			break;
-
-		case CA_GET_MSG:
-			if (verbose > 1)
-				dprintk("%s: Getting message\n", __FUNCTION__);
-			if ((ca_get_message(state, p_ca_message, arg)) < 0) {
-				dprintk("%s: -->CA_GET_MSG Failed !\n", __FUNCTION__);
-				return -1;
-			}
-			if (verbose > 1)
-				dprintk("%s: -->CA_GET_MSG Success !\n", __FUNCTION__);
-
-			break;
-
-		case CA_RESET:
-			if (verbose > 1)
-				dprintk("%s: Resetting DST\n", __FUNCTION__);
-			dst_error_bailout(state);
-			msleep(4000);
-
-			break;
-
-		case CA_GET_SLOT_INFO:
-			if (verbose > 1)
-				dprintk("%s: Getting Slot info\n", __FUNCTION__);
-			if ((ca_get_slot_info(state, p_ca_slot_info, arg)) < 0) {
-				dprintk("%s: -->CA_GET_SLOT_INFO Failed !\n", __FUNCTION__);
-				return -1;
-			}
-			if (verbose > 1)
-				dprintk("%s: -->CA_GET_SLOT_INFO Success !\n", __FUNCTION__);
-
-			break;
-
-		case CA_GET_CAP:
-			if (verbose > 1)
-				dprintk("%s: Getting Slot capabilities\n", __FUNCTION__);
-			if ((ca_get_slot_caps(state, p_ca_caps, arg)) < 0) {
-				dprintk("%s: -->CA_GET_CAP Failed !\n", __FUNCTION__);
-				return -1;
-			}
-			if (verbose > 1)
-				dprintk("%s: -->CA_GET_CAP Success !\n", __FUNCTION__);
-
-			break;
-
-		case CA_GET_DESCR_INFO:
-			if (verbose > 1)
-				dprintk("%s: Getting descrambler description\n", __FUNCTION__);
-			if ((ca_get_slot_descr(state, p_ca_message, arg)) < 0) {
-				dprintk("%s: -->CA_GET_DESCR_INFO Failed !\n", __FUNCTION__);
-				return -1;
-			}
-			if (verbose > 1)
-				dprintk("%s: -->CA_GET_DESCR_INFO Success !\n", __FUNCTION__);
-
-			break;
-
-		case CA_SET_DESCR:
-			if (verbose > 1)
-				dprintk("%s: Setting descrambler\n", __FUNCTION__);
-			if ((ca_set_slot_descr()) < 0) {
-				dprintk("%s: -->CA_SET_DESCR Failed !\n", __FUNCTION__);
-				return -1;
-			}
-			if (verbose > 1)
-				dprintk("%s: -->CA_SET_DESCR Success !\n", __FUNCTION__);
-
-			break;
-
-		case CA_SET_PID:
-			if (verbose > 1)
-				dprintk("%s: Setting PID\n", __FUNCTION__);
-			if ((ca_set_pid()) < 0) {
-				dprintk("%s: -->CA_SET_PID Failed !\n", __FUNCTION__);
-				return -1;
-			}
-			if (verbose > 1)
-				dprintk("%s: -->CA_SET_PID Success !\n", __FUNCTION__);
-
-		default:
-			return -EOPNOTSUPP;
-		};
+	case CA_SEND_MSG:
+		dprintk(verbose, DST_CA_INFO, 1, " Sending message");
+		if ((ca_send_message(state, p_ca_message, arg)) < 0) {
+			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_SEND_MSG Failed !");
+			return -1;
+		}
+		break;
+	case CA_GET_MSG:
+		dprintk(verbose, DST_CA_INFO, 1, " Getting message");
+		if ((ca_get_message(state, p_ca_message, arg)) < 0) {
+			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_GET_MSG Failed !");
+			return -1;
+		}
+		dprintk(verbose, DST_CA_INFO, 1, " -->CA_GET_MSG Success !");
+		break;
+	case CA_RESET:
+		dprintk(verbose, DST_CA_ERROR, 1, " Resetting DST");
+		dst_error_bailout(state);
+		msleep(4000);
+		break;
+	case CA_GET_SLOT_INFO:
+		dprintk(verbose, DST_CA_INFO, 1, " Getting Slot info");
+		if ((ca_get_slot_info(state, p_ca_slot_info, arg)) < 0) {
+			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_GET_SLOT_INFO Failed !");
+			return -1;
+		}
+		dprintk(verbose, DST_CA_INFO, 1, " -->CA_GET_SLOT_INFO Success !");
+		break;
+	case CA_GET_CAP:
+		dprintk(verbose, DST_CA_INFO, 1, " Getting Slot capabilities");
+		if ((ca_get_slot_caps(state, p_ca_caps, arg)) < 0) {
+			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_GET_CAP Failed !");
+			return -1;
+		}
+		dprintk(verbose, DST_CA_INFO, 1, " -->CA_GET_CAP Success !");
+		break;
+	case CA_GET_DESCR_INFO:
+		dprintk(verbose, DST_CA_INFO, 1, " Getting descrambler description");
+		if ((ca_get_slot_descr(state, p_ca_message, arg)) < 0) {
+			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_GET_DESCR_INFO Failed !");
+			return -1;
+		}
+		dprintk(verbose, DST_CA_INFO, 1, " -->CA_GET_DESCR_INFO Success !");
+		break;
+	case CA_SET_DESCR:
+		dprintk(verbose, DST_CA_INFO, 1, " Setting descrambler");
+		if ((ca_set_slot_descr()) < 0) {
+			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_SET_DESCR Failed !");
+			return -1;
+		}
+		dprintk(verbose, DST_CA_INFO, 1, " -->CA_SET_DESCR Success !");
+		break;
+	case CA_SET_PID:
+		dprintk(verbose, DST_CA_INFO, 1, " Setting PID");
+		if ((ca_set_pid()) < 0) {
+			dprintk(verbose, DST_CA_ERROR, 1, " -->CA_SET_PID Failed !");
+			return -1;
+		}
+		dprintk(verbose, DST_CA_INFO, 1, " -->CA_SET_PID Success !");
+	default:
+		return -EOPNOTSUPP;
+	};
 
 	return 0;
 }
 
 static int dst_ca_open(struct inode *inode, struct file *file)
 {
-	if (verbose > 4)
-		dprintk("%s:Device opened [%p]\n", __FUNCTION__, file);
+	dprintk(verbose, DST_CA_DEBUG, 1, " Device opened [%p] ", file);
 	try_module_get(THIS_MODULE);
 
 	return 0;
@@ -631,27 +558,24 @@ static int dst_ca_open(struct inode *ino
 
 static int dst_ca_release(struct inode *inode, struct file *file)
 {
-	if (verbose > 4)
-		dprintk("%s:Device closed.\n", __FUNCTION__);
+	dprintk(verbose, DST_CA_DEBUG, 1, " Device closed.");
 	module_put(THIS_MODULE);
 
 	return 0;
 }
 
-static int dst_ca_read(struct file *file, char __user * buffer, size_t length, loff_t * offset)
+static int dst_ca_read(struct file *file, char __user *buffer, size_t length, loff_t *offset)
 {
 	int bytes_read = 0;
 
-	if (verbose > 4)
-		dprintk("%s:Device read.\n", __FUNCTION__);
+	dprintk(verbose, DST_CA_DEBUG, 1, " Device read.");
 
 	return bytes_read;
 }
 
-static int dst_ca_write(struct file *file, const char __user * buffer, size_t length, loff_t * offset)
+static int dst_ca_write(struct file *file, const char __user *buffer, size_t length, loff_t *offset)
 {
-	if (verbose > 4)
-		dprintk("%s:Device write.\n", __FUNCTION__);
+	dprintk(verbose, DST_CA_DEBUG, 1, " Device write.");
 
 	return 0;
 }
@@ -676,8 +600,7 @@ static struct dvb_device dvbdev_ca = {
 int dst_ca_attach(struct dst_state *dst, struct dvb_adapter *dvb_adapter)
 {
 	struct dvb_device *dvbdev;
-	if (verbose > 4)
-		dprintk("%s:registering DST-CA device\n", __FUNCTION__);
+	dprintk(verbose, DST_CA_ERROR, 1, "registering DST-CA device");
 	dvb_register_device(dvb_adapter, &dvbdev, &dvbdev_ca, dst, DVB_DEVICE_CA);
 	return 0;
 }
--- linux-2.6.13-git4.orig/drivers/media/dvb/bt8xx/dst_common.h	2005-09-04 22:24:23.000000000 +0200
+++ linux-2.6.13-git4/drivers/media/dvb/bt8xx/dst_common.h	2005-09-04 22:28:34.000000000 +0200
@@ -61,7 +61,6 @@
 #define	DST_TYPE_HAS_ANALOG	64	/*	Analog inputs	*/
 #define DST_TYPE_HAS_SESSION	128
 
-
 #define RDC_8820_PIO_0_DISABLE	0
 #define RDC_8820_PIO_0_ENABLE	1
 #define RDC_8820_INT		2
@@ -124,15 +123,12 @@ struct dst_types {
 	u32 dst_feature;
 };
 
-
-
 struct dst_config
 {
 	/* the ASIC i2c address */
 	u8 demod_address;
 };
 
-
 int rdc_reset_state(struct dst_state *state);
 int rdc_8820_reset(struct dst_state *state);
 

--

