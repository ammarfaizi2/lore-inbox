Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWITTeN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWITTeN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 15:34:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWITTeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 15:34:13 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:39044
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932154AbWITTeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 15:34:11 -0400
Subject: [PATCH] synclink_gt add bisync and monosync modes
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 14:33:37 -0500
Message-Id: <1158780817.8905.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add bisync and monosync serial protocol support
to the synclink_gt driver.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- linux-2.6.18/drivers/char/synclink_gt.c	2006-09-19 22:42:06.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-09-20 11:57:00.000000000 -0500
@@ -461,7 +461,7 @@ static int  adapter_test(struct slgt_inf
 static void reset_adapter(struct slgt_info *info);
 static void reset_port(struct slgt_info *info);
 static void async_mode(struct slgt_info *info);
-static void hdlc_mode(struct slgt_info *info);
+static void sync_mode(struct slgt_info *info);
 
 static void rx_stop(struct slgt_info *info);
 static void rx_start(struct slgt_info *info);
@@ -881,7 +881,9 @@ static int write(struct tty_struct *tty,
 	if (!count)
 		goto cleanup;
 
-	if (info->params.mode == MGSL_MODE_RAW) {
+	if (info->params.mode == MGSL_MODE_RAW ||
+	    info->params.mode == MGSL_MODE_MONOSYNC ||
+	    info->params.mode == MGSL_MODE_BISYNC) {
 		unsigned int bufs_needed = (count/DMABUFSIZE);
 		unsigned int bufs_free = free_tbuf_count(info);
 		if (count % DMABUFSIZE)
@@ -1897,6 +1899,8 @@ static void bh_handler(void* context)
 				while(rx_get_frame(info));
 				break;
 			case MGSL_MODE_RAW:
+			case MGSL_MODE_MONOSYNC:
+			case MGSL_MODE_BISYNC:
 				while(rx_get_buf(info));
 				break;
 			}
@@ -2362,10 +2366,9 @@ static void program_hw(struct slgt_info 
 	rx_stop(info);
 	tx_stop(info);
 
-	if (info->params.mode == MGSL_MODE_HDLC ||
-	    info->params.mode == MGSL_MODE_RAW ||
+	if (info->params.mode != MGSL_MODE_ASYNC ||
 	    info->netcount)
-		hdlc_mode(info);
+		sync_mode(info);
 	else
 		async_mode(info);
 
@@ -2564,6 +2567,10 @@ static int rx_enable(struct slgt_info *i
 	if (enable) {
 		if (!info->rx_enabled)
 			rx_start(info);
+		else if (enable == 2) {
+			/* force hunt mode (write 1 to RCR[3]) */
+			wr_reg16(info, RCR, rd_reg16(info, RCR) | BIT3);
+		}
 	} else {
 		if (info->rx_enabled)
 			rx_stop(info);
@@ -3748,7 +3755,7 @@ static void tx_start(struct slgt_info *i
 {
 	if (!info->tx_enabled) {
 		wr_reg16(info, TCR,
-			(unsigned short)(rd_reg16(info, TCR) | BIT1));
+			 (unsigned short)((rd_reg16(info, TCR) | BIT1) & ~BIT2));
 		info->tx_enabled = TRUE;
 	}
 
@@ -3775,13 +3782,18 @@ static void tx_start(struct slgt_info *i
 				tdma_reset(info);
 				/* set 1st descriptor address */
 				wr_reg32(info, TDDAR, info->tbufs[info->tbuf_start].pdesc);
-				if (info->params.mode == MGSL_MODE_RAW)
+				switch(info->params.mode) {
+				case MGSL_MODE_RAW:
+				case MGSL_MODE_MONOSYNC:
+				case MGSL_MODE_BISYNC:
 					wr_reg32(info, TDCSR, BIT2 + BIT0); /* IRQ + DMA enable */
-				else
+					break;
+				default:
 					wr_reg32(info, TDCSR, BIT0); /* DMA enable */
+				}
 			}
 
-			if (info->params.mode != MGSL_MODE_RAW) {
+			if (info->params.mode == MGSL_MODE_HDLC) {
 				info->tx_timer.expires = jiffies + msecs_to_jiffies(5000);
 				add_timer(&info->tx_timer);
 			}
@@ -3814,7 +3826,6 @@ static void tx_stop(struct slgt_info *in
 	/* reset and disable transmitter */
 	val = rd_reg16(info, TCR) & ~BIT1;          /* clear enable bit */
 	wr_reg16(info, TCR, (unsigned short)(val | BIT2)); /* set reset bit */
-	wr_reg16(info, TCR, val);                  /* clear reset */
 
 	slgt_irq_off(info, IRQ_TXDATA + IRQ_TXIDLE + IRQ_TXUNDER);
 
@@ -3982,7 +3993,7 @@ static void async_mode(struct slgt_info 
 		enable_loopback(info);
 }
 
-static void hdlc_mode(struct slgt_info *info)
+static void sync_mode(struct slgt_info *info)
 {
 	unsigned short val;
 
@@ -3992,7 +4003,7 @@ static void hdlc_mode(struct slgt_info *
 
 	/* TCR (tx control)
 	 *
-	 * 15..13  mode, 000=HDLC 001=raw sync
+	 * 15..13  mode, 000=HDLC 001=raw 010=async 011=monosync 100=bisync
 	 * 12..10  encoding
 	 * 09      CRC enable
 	 * 08      CRC32
@@ -4006,8 +4017,11 @@ static void hdlc_mode(struct slgt_info *
 	 */
 	val = 0;
 
-	if (info->params.mode == MGSL_MODE_RAW)
-		val |= BIT13;
+	switch(info->params.mode) {
+	case MGSL_MODE_MONOSYNC: val |= BIT14 + BIT13; break;
+	case MGSL_MODE_BISYNC:   val |= BIT15; break;
+	case MGSL_MODE_RAW:      val |= BIT13; break;
+	}
 	if (info->if_mode & MGSL_INTERFACE_RTS_EN)
 		val |= BIT7;
 
@@ -4058,7 +4072,7 @@ static void hdlc_mode(struct slgt_info *
 
 	/* RCR (rx control)
 	 *
-	 * 15..13  mode, 000=HDLC 001=raw sync
+	 * 15..13  mode, 000=HDLC 001=raw 010=async 011=monosync 100=bisync
 	 * 12..10  encoding
 	 * 09      CRC enable
 	 * 08      CRC32
@@ -4069,8 +4083,11 @@ static void hdlc_mode(struct slgt_info *
 	 */
 	val = 0;
 
-	if (info->params.mode == MGSL_MODE_RAW)
-		val |= BIT13;
+	switch(info->params.mode) {
+	case MGSL_MODE_MONOSYNC: val |= BIT14 + BIT13; break;
+	case MGSL_MODE_BISYNC:   val |= BIT15; break;
+	case MGSL_MODE_RAW:      val |= BIT13; break;
+	}
 
 	switch(info->params.encoding)
 	{
@@ -4309,10 +4326,15 @@ static void free_rbufs(struct slgt_info 
 	while(!done) {
 		/* reset current buffer for reuse */
 		info->rbufs[i].status = 0;
-		if (info->params.mode == MGSL_MODE_RAW)
+		switch(info->params.mode) {
+		case MGSL_MODE_RAW:
+		case MGSL_MODE_MONOSYNC:
+		case MGSL_MODE_BISYNC:
 			set_desc_count(info->rbufs[i], info->raw_rx_size);
-		else
+			break;
+		default:
 			set_desc_count(info->rbufs[i], DMABUFSIZE);
+		}
 
 		if (i == last)
 			done = 1;
@@ -4477,13 +4499,24 @@ cleanup:
 static int rx_get_buf(struct slgt_info *info)
 {
 	unsigned int i = info->rbuf_current;
+	unsigned int count;
 
 	if (!desc_complete(info->rbufs[i]))
 		return 0;
-	DBGDATA(info, info->rbufs[i].buf, desc_count(info->rbufs[i]), "rx");
-	DBGINFO(("rx_get_buf size=%d\n", desc_count(info->rbufs[i])));
-	ldisc_receive_buf(info->tty, info->rbufs[i].buf,
-			  info->flag_buf, desc_count(info->rbufs[i]));
+	count = desc_count(info->rbufs[i]);
+	switch(info->params.mode) {
+	case MGSL_MODE_MONOSYNC:
+	case MGSL_MODE_BISYNC:
+		/* ignore residue in byte synchronous modes */
+		if (desc_residue(info->rbufs[i]))
+			count--;
+		break;
+	}
+	DBGDATA(info, info->rbufs[i].buf, count, "rx");
+	DBGINFO(("rx_get_buf size=%d\n", count));
+	if (count)
+		ldisc_receive_buf(info->tty, info->rbufs[i].buf,
+				  info->flag_buf, count);
 	free_rbufs(info, i, i);
 	return 1;
 }
@@ -4549,8 +4582,13 @@ static void tx_load(struct slgt_info *in
 		size -= count;
 		buf  += count;
 
-		if (!size && info->params.mode != MGSL_MODE_RAW)
-			set_desc_eof(*d, 1); /* HDLC: set EOF of last desc */
+		/*
+		 * set EOF bit for last buffer of HDLC frame or
+		 * for every buffer in raw mode
+		 */
+		if ((!size && info->params.mode == MGSL_MODE_HDLC) ||
+		    info->params.mode == MGSL_MODE_RAW)
+			set_desc_eof(*d, 1);
 		else
 			set_desc_eof(*d, 0);
 
--- linux-2.6.18/include/linux/synclink.h	2006-09-19 22:42:06.000000000 -0500
+++ b/include/linux/synclink.h	2006-09-20 12:05:07.000000000 -0500
@@ -1,7 +1,7 @@
 /*
  * SyncLink Multiprotocol Serial Adapter Driver
  *
- * $Id: synclink.h,v 3.13 2006/05/23 18:25:06 paulkf Exp $
+ * $Id: synclink.h,v 3.14 2006/07/17 20:15:43 paulkf Exp $
  *
  * Copyright (C) 1998-2000 by Microgate Corporation
  *
@@ -124,6 +124,8 @@
 
 #define MGSL_MODE_ASYNC		1
 #define MGSL_MODE_HDLC		2
+#define MGSL_MODE_MONOSYNC	3
+#define MGSL_MODE_BISYNC	4
 #define MGSL_MODE_RAW		6
 
 #define MGSL_BUS_TYPE_ISA	1


