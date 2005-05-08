Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262937AbVEHUJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262937AbVEHUJJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 16:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262942AbVEHUBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 16:01:20 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:3223 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S262937AbVEHTKQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 15:10:16 -0400
Message-Id: <20050508184349.197853000@abc>
References: <20050508184229.957247000@abc>
Date: Sun, 08 May 2005 20:42:59 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Disposition: inline; filename=dvb-bt8xx-dst-tuning.patch
X-SA-Exim-Connect-IP: 217.231.45.168
Subject: [DVB patch 30/37] DST: fixed tuning problem
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fixed a tuning problem for cards based on the old firmware
(Steffen Motzer, Manu Abraham)

Signed-off-by: Johannes Stezenbach <js@linuxtv.org>
---

 drivers/media/dvb/bt8xx/dst.c        |   57 +++++++++++++++++++++++------------
 drivers/media/dvb/bt8xx/dst_common.h |    6 +--
 2 files changed, 41 insertions(+), 22 deletions(-)

Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:39.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst.c	2005-05-08 18:13:44.000000000 +0200
@@ -81,9 +81,7 @@ int dst_gpio_outb(struct dst_state* stat
 		dprintk("%s: dst_gpio_enb error (err == %i, mask == %02x, enb == %02x)\n", __FUNCTION__, err, mask, enbb);
 		return -EREMOTEIO;
 	}
-
-	msleep(1);
-
+	udelay(1000);
 	/* because complete disabling means no output, no need to do output packet */
 	if (enbb == 0)
 		return 0;
@@ -150,8 +148,7 @@ int rdc_8820_reset(struct dst_state *sta
 		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
 		return -1;
 	}
-	msleep(1);
-
+	udelay(1000);
 	if (dst_gpio_outb(state, RDC_8820_RESET, RDC_8820_RESET, RDC_8820_RESET, DELAY) < 0) {
 		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
 		return -1;
@@ -167,8 +164,7 @@ int dst_pio_enable(struct dst_state *sta
 		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
 		return -1;
 	}
-	msleep(1);
-
+	udelay(1000);
 	return 0;
 }
 EXPORT_SYMBOL(dst_pio_enable);
@@ -179,6 +175,8 @@ int dst_pio_disable(struct dst_state *st
 		dprintk("%s: dst_gpio_outb ERROR !\n", __FUNCTION__);
 		return -1;
 	}
+	if (state->type_flags & DST_TYPE_HAS_FW_1)
+		udelay(1000);
 
 	return 0;
 }
@@ -200,7 +198,7 @@ int dst_wait_dst_ready(struct dst_state 
 				dprintk("%s: dst wait ready after %d\n", __FUNCTION__, i);
 			return 1;
 		}
-		msleep(1);
+		msleep(35);
 	}
 	if (verbose > 1)
 		dprintk("%s: dst wait NOT ready after %d\n", __FUNCTION__, i);
@@ -245,6 +243,11 @@ int dst_comm_init(struct dst_state* stat
 		dprintk("%s: RDC 8820 State RESET Failed.\n", __FUNCTION__);
 		return -1;
 	}
+	if (state->type_flags & DST_TYPE_HAS_FW_1)
+		msleep(100);
+	else
+		msleep(5);
+
 	return 0;
 }
 EXPORT_SYMBOL(dst_comm_init);
@@ -328,8 +331,9 @@ static int dst_set_freq(struct dst_state
 	u8 *val;
 
 	state->frequency = freq;
+	if (debug > 4)
+		dprintk("%s: set Frequency %u\n", __FUNCTION__, freq);
 
-	// dprintk("%s: set frequency %u\n", __FUNCTION__, freq);
 	if (state->dst_type == DST_TYPE_IS_SAT) {
 		freq = freq / 1000;
 		if (freq < 950 || freq > 2150)
@@ -452,7 +456,8 @@ static int dst_set_symbolrate(struct dst
 	if (state->dst_type == DST_TYPE_IS_TERR) {
 		return 0;
 	}
-	// dprintk("%s: set srate %u\n", __FUNCTION__, srate);
+	if (debug > 4)
+		dprintk("%s: set symrate %u\n", __FUNCTION__, srate);
 	srate /= 1000;
 	val = &state->tx_tuna[0];
 
@@ -461,7 +466,10 @@ static int dst_set_symbolrate(struct dst
 		sval <<= 20;
 		do_div(sval, 88000);
 		symcalc = (u32) sval;
-		// dprintk("%s: set symcalc %u\n", __FUNCTION__, symcalc);
+
+		if (debug > 4)
+			dprintk("%s: set symcalc %u\n", __FUNCTION__, symcalc);
+
 		val[5] = (u8) (symcalc >> 12);
 		val[6] = (u8) (symcalc >> 4);
 		val[7] = (u8) (symcalc << 4);
@@ -504,6 +512,7 @@ static void dst_type_flags_print(u32 typ
 		printk(" 0x%x firmware version = 2", DST_TYPE_HAS_FW_2);
 	if (type_flags & DST_TYPE_HAS_FW_3)
 		printk(" 0x%x firmware version = 3", DST_TYPE_HAS_FW_3);
+//	if ((type_flags & DST_TYPE_HAS_FW_BUILD) && new_fw)
 
 	printk("\n");
 }
@@ -617,13 +626,13 @@ struct dst_types dst_tlist[] = {
 		.dst_type = DST_TYPE_IS_SAT,
 		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_1,
 		.dst_feature = DST_TYPE_HAS_CA
-	},	/* unknown to vendor	*/
+	},	/*	An OEM board	*/
 
 	{
 		.device_id = "DSTMCI",
 		.offset = 1,
 		.dst_type = DST_TYPE_IS_SAT,
-		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_2,
+		.type_flags = DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_2 | DST_TYPE_HAS_FW_BUILD,
 		.dst_feature = DST_TYPE_HAS_CA | DST_TYPE_HAS_DISEQC3 | DST_TYPE_HAS_DISEQC4
 							| DST_TYPE_HAS_MOTO | DST_TYPE_HAS_MAC
 	},
@@ -640,7 +649,8 @@ struct dst_types dst_tlist[] = {
 		.device_id = "DCT-CI",
 		.offset = 1,
 		.dst_type = DST_TYPE_IS_CABLE,
-		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_1									| DST_TYPE_HAS_FW_2,
+		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_NEWTUNE | DST_TYPE_HAS_FW_1
+							| DST_TYPE_HAS_FW_2 | DST_TYPE_HAS_FW_BUILD,
 		.dst_feature = DST_TYPE_HAS_CA
 	},
 
@@ -656,7 +666,7 @@ struct dst_types dst_tlist[] = {
 		.device_id = "DTT-CI",
 		.offset = 1,
 		.dst_type = DST_TYPE_IS_TERR,
-		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_FW_2,
+		.type_flags = DST_TYPE_HAS_TS204 | DST_TYPE_HAS_FW_2 | DST_TYPE_HAS_FW_BUILD,
 		.dst_feature = 0
 	},
 
@@ -782,7 +792,7 @@ static int dst_probe(struct dst_state *s
 		dprintk("%s: DST Initialization Failed.\n", __FUNCTION__);
 		return -1;
 	}
-
+	msleep(100);
 	if (dst_get_device_id(state) < 0) {
 		dprintk("%s: unknown device.\n", __FUNCTION__);
 		return -1;
@@ -812,6 +822,8 @@ int dst_command(struct dst_state* state,
 		dprintk("%s: PIO Disable Failed.\n", __FUNCTION__);
 		return -1;
 	}
+	if (state->type_flags & DST_TYPE_HAS_FW_1)
+		udelay(3000);
 
 	if (read_dst(state, &reply, GET_ACK)) {
 		if (verbose > 1)
@@ -829,6 +841,13 @@ int dst_command(struct dst_state* state,
 	}
 	if (len >= 2 && data[0] == 0 && (data[1] == 1 || data[1] == 3))
 		return 0;
+
+//	udelay(3000);
+	if (state->type_flags & DST_TYPE_HAS_FW_1)
+		udelay(3000);
+	else
+		udelay(2000);
+
 	if (!dst_wait_dst_ready(state, NO_DELAY))
 		return -1;
 
@@ -919,8 +938,6 @@ static int dst_get_tuna(struct dst_state
 	if (!dst_wait_dst_ready(state, NO_DELAY))
 		return 0;
 
-	msleep(10);
-
 	if (state->type_flags & DST_TYPE_HAS_NEWTUNE) {
 		/* how to get variable length reply ???? */
 		retval = read_dst(state, state->rx_tuna, 10);
@@ -969,7 +986,9 @@ static int dst_write_tuna(struct dvb_fro
 	int retval;
 	u8 reply;
 
-	dprintk("%s: type_flags 0x%x \n", __FUNCTION__, state->type_flags);
+	if (debug > 4)
+		dprintk("%s: type_flags 0x%x \n", __FUNCTION__, state->type_flags);
+
 	state->decode_freq = 0;
 	state->decode_lock = state->decode_strength = state->decode_snr = 0;
 	if (state->dst_type == DST_TYPE_IS_SAT) {
Index: linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_common.h
===================================================================
--- linux-2.6.12-rc4.orig/drivers/media/dvb/bt8xx/dst_common.h	2005-05-08 18:13:30.000000000 +0200
+++ linux-2.6.12-rc4/drivers/media/dvb/bt8xx/dst_common.h	2005-05-08 18:13:44.000000000 +0200
@@ -46,7 +46,7 @@
 #define DST_TYPE_HAS_FW_1	8
 #define DST_TYPE_HAS_FW_2	16
 #define DST_TYPE_HAS_FW_3	32
-
+#define DST_TYPE_HAS_FW_BUILD	64
 
 
 /*	Card capability list	*/
@@ -117,8 +117,8 @@ struct dst_types {
 	char *device_id;
 	int offset;
 	u8 dst_type;
-	u32 type_flags;
-	u8 dst_feature;
+	u64 type_flags;
+	u64 dst_feature;
 };
 
 

--

