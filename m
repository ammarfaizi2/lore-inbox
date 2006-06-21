Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751631AbWFUO2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751631AbWFUO2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWFUO22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:28:28 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:30630
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751625AbWFUO2O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:28:14 -0400
Subject: [PATCH] add synclink_gt custom hdlc idle
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:27:56 -0500
Message-Id: <1150900076.3708.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add custom HDLC idle pattern feature.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/drivers/char/synclink_gt.c	2006-06-21 09:04:11.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-06-21 09:10:31.000000000 -0500
@@ -2515,7 +2515,8 @@ static int set_txidle(struct slgt_info *
 	DBGINFO(("%s set_txidle(%d)\n", info->device_name, idle_mode));
 	spin_lock_irqsave(&info->lock,flags);
 	info->idle_mode = idle_mode;
-	tx_set_idle(info);
+	if (info->params.mode != MGSL_MODE_ASYNC)
+		tx_set_idle(info);
 	spin_unlock_irqrestore(&info->lock,flags);
 	return 0;
 }
@@ -3940,8 +3941,6 @@ static void async_mode(struct slgt_info 
 
 	msc_set_vcr(info);
 
-	tx_set_idle(info);
-
 	/* SCR (serial control)
 	 *
 	 * 15  1=tx req on FIFO half empty
@@ -4175,17 +4174,38 @@ static void hdlc_mode(struct slgt_info *
  */
 static void tx_set_idle(struct slgt_info *info)
 {
-	unsigned char val = 0xff;
+	unsigned char val;
+	unsigned short tcr;
 
-	switch(info->idle_mode)
-	{
-	case HDLC_TXIDLE_FLAGS:          val = 0x7e; break;
-	case HDLC_TXIDLE_ALT_ZEROS_ONES: val = 0xaa; break;
-	case HDLC_TXIDLE_ZEROS:          val = 0x00; break;
-	case HDLC_TXIDLE_ONES:           val = 0xff; break;
-	case HDLC_TXIDLE_ALT_MARK_SPACE: val = 0xaa; break;
-	case HDLC_TXIDLE_SPACE:          val = 0x00; break;
-	case HDLC_TXIDLE_MARK:           val = 0xff; break;
+	/* if preamble enabled (tcr[6] == 1) then tx idle size = 8 bits
+	 * else tcr[5:4] = tx idle size: 00 = 8 bits, 01 = 16 bits
+	 */
+	tcr = rd_reg16(info, TCR);
+	if (info->idle_mode & HDLC_TXIDLE_CUSTOM_16) {
+		/* disable preamble, set idle size to 16 bits */
+		tcr = (tcr & ~(BIT6 + BIT5)) | BIT4;
+		/* MSB of 16 bit idle specified in tx preamble register (TPR) */
+		wr_reg8(info, TPR, (unsigned char)((info->idle_mode >> 8) & 0xff));
+	} else if (!(tcr & BIT6)) {
+		/* preamble is disabled, set idle size to 8 bits */
+		tcr &= ~(BIT5 + BIT4);
+	}
+	wr_reg16(info, TCR, tcr);
+
+	if (info->idle_mode & (HDLC_TXIDLE_CUSTOM_8 | HDLC_TXIDLE_CUSTOM_16)) {
+		/* LSB of custom tx idle specified in tx idle register */
+		val = (unsigned char)(info->idle_mode & 0xff);
+	} else {
+		/* standard 8 bit idle patterns */
+		switch(info->idle_mode)
+		{
+		case HDLC_TXIDLE_FLAGS:          val = 0x7e; break;
+		case HDLC_TXIDLE_ALT_ZEROS_ONES:
+		case HDLC_TXIDLE_ALT_MARK_SPACE: val = 0xaa; break;
+		case HDLC_TXIDLE_ZEROS:
+		case HDLC_TXIDLE_SPACE:          val = 0x00; break;
+		default:                         val = 0xff;
+		}
 	}
 
 	wr_reg8(info, TIR, val);
--- a/include/linux/synclink.h	2006-06-21 09:04:26.000000000 -0500
+++ b/include/linux/synclink.h	2006-06-21 09:10:44.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * SyncLink Multiprotocol Serial Adapter Driver
  *
- * $Id: synclink.h,v 3.11 2006/02/06 21:20:29 paulkf Exp $
+ * $Id: synclink.h,v 3.13 2006/05/23 18:25:06 paulkf Exp $
  *
  * Copyright (C) 1998-2000 by Microgate Corporation
  *
@@ -97,6 +97,8 @@
 #define HDLC_TXIDLE_ALT_MARK_SPACE	4
 #define HDLC_TXIDLE_SPACE		5
 #define HDLC_TXIDLE_MARK		6
+#define HDLC_TXIDLE_CUSTOM_8            0x10000000
+#define HDLC_TXIDLE_CUSTOM_16           0x20000000
 
 #define HDLC_ENCODING_NRZ			0
 #define HDLC_ENCODING_NRZB			1


