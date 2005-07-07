Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVGGEEM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVGGEEM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 00:04:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbVGGEEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 00:04:11 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:56131 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S262164AbVGGEEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 00:04:00 -0400
Message-ID: <42CCA9C1.5080506@m1k.net>
Date: Thu, 07 Jul 2005 00:04:17 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>, linux-dvb@linuxtv.org
Subject: [-mm PATCH] LGDT3302 read status fix
Content-Type: multipart/mixed;
 boundary="------------010803000309070804010408"
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
--------------010803000309070804010408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

- Fix bug in lgdt3302_read_status to return correct
  FE_HAS_SIGNAL and FS_HAS_CARRIER status.
- Removed #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,10).

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>



-- 
Michael Krufky


--------------010803000309070804010408
Content-Type: text/plain;
 name="lgdt3302-read-status-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="lgdt3302-read-status-fix.patch"

- Fix bug in lgdt3302_read_status to return correct
  FE_HAS_SIGNAL and FS_HAS_CARRIER status.
- Removed #if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,10).

Signed-off-by: Mac Michaels <wmichaels1@earthlink.net>
Signed-off-by: Michael Krufky <mkrufky@m1k.net>

 linux/drivers/media/dvb/frontends/lgdt3302.c |   43 +++++++------------
 1 files changed, 18 insertions(+), 25 deletions(-)

diff -u linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c linux/drivers/media/dvb/frontends/lgdt3302.c
--- linux-2.6.13/drivers/media/dvb/frontends/lgdt3302.c	2005-07-06 22:32:22.000000000 +0000
+++ linux/drivers/media/dvb/frontends/lgdt3302.c	2005-07-06 23:53:06.000000000 +0000
@@ -1,5 +1,5 @@
 /*
- * $Id: lgdt3302.c,v 1.2 2005/06/28 23:50:48 mkrufky Exp $
+ * $Id: lgdt3302.c,v 1.5 2005/07/07 03:47:15 mkrufky Exp $
  *
  *    Support for LGDT3302 (DViCO FustionHDTV 3 Gold) - VSB/QAM
  *
@@ -34,7 +34,6 @@
  *
  */
 
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
@@ -208,8 +207,6 @@
 	struct lgdt3302_state* state =
 		(struct lgdt3302_state*) fe->demodulator_priv;
 
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,10)
-
 	/* Use 50MHz parameter values from spec sheet since xtal is 50 */
 	static u8 top_ctrl_cfg[]   = { TOP_CONTROL, 0x03 };
 	static u8 vsb_freq_cfg[]   = { VSB_CARRIER_FREQ0, 0x00, 0x87, 0x8e, 0x01 };
@@ -301,9 +298,6 @@
 		lgdt3302_SwReset(state);
 		state->current_modulation = param->u.vsb.modulation;
 	}
-#else
-	printk("lgdt3302: %s: you need a newer kernel for this, sorry\n",__FUNCTION__);
-#endif
 
 	/* Change only if we are actually changing the channel */
 	if (state->current_frequency != param->frequency) {
@@ -352,11 +346,28 @@
 	 * This is done in SwReset();
 	 */
 
+	/* AGC status register */
+	i2c_selectreadbytes(state, AGC_STATUS, buf, 1);
+	dprintk("%s: AGC_STATUS = 0x%02x\n", __FUNCTION__, buf[0]);
+	if ((buf[0] & 0x0c) == 0x8){
+		/* Test signal does not exist flag */
+		/* as well as the AGC lock flag.   */
+		*status |= FE_HAS_SIGNAL;
+	} else {
+		/* Without a signal all other status bits are meaningless */
+		return 0;
+	}
+
 	/* signal status */
 	i2c_selectreadbytes(state, TOP_CONTROL, buf, sizeof(buf));
 	dprintk("%s: TOP_CONTROL = 0x%02x, IRO_MASK = 0x%02x, IRQ_STATUS = 0x%02x\n", __FUNCTION__, buf[0], buf[1], buf[2]);
+
+#if 0
+	/* Alternative method to check for a signal */
+	/* using the SNR good/bad interrupts.   */
 	if ((buf[2] & 0x30) == 0x10)
 		*status |= FE_HAS_SIGNAL;
+#endif
 
 	/* sync status */
 	if ((buf[2] & 0x03) == 0x01) {
@@ -369,17 +380,6 @@
 		*status |= FE_HAS_VITERBI;
 	}
 
-#if 0
-	/* Alternative method to check for a signal */
-	/* AGC status register */
-	i2c_selectreadbytes(state, AGC_STATUS, buf, 1);
-	dprintk("%s: AGC_STATUS = 0x%02x\n", __FUNCTION__, buf[0]);
-	if ((buf[0] & 0x0c) == 0x80) /* Test signal does not exist flag */
-		/* Test AGC lock flag */
-		*status |= FE_HAS_SIGNAL;
-	else
-		return 0;
-
 	/* Carrier Recovery Lock Status Register */
 	i2c_selectreadbytes(state, CARRIER_LOCK, buf, 1);
 	dprintk("%s: CARRIER_LOCK = 0x%02x\n", __FUNCTION__, buf[0]);
@@ -389,21 +389,14 @@
 		/* Need to undestand why there are 3 lock levels here */
 		if ((buf[0] & 0x07) == 0x07)
 			*status |= FE_HAS_CARRIER;
-		else
-			return 0;
 		break;
-#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,10)
 	case VSB_8:
 		if ((buf[0] & 0x80) == 0x80)
 			*status |= FE_HAS_CARRIER;
-		else
-			return 0;
 		break;
-#endif
 	default:
 		printk("KERN_WARNING lgdt3302: %s: Modulation set to unsupported value\n", __FUNCTION__);
 	}
-#endif
 
 	return 0;
 }

--------------010803000309070804010408--
