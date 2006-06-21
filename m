Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751634AbWFUObD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWFUObD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 10:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751637AbWFUOa7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 10:30:59 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:37030
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751628AbWFUOao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 10:30:44 -0400
Subject: [PATCH] add synclink_gt crc return feature
From: Paul Fulghum <paulkf@microgate.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 09:30:29 -0500
Message-Id: <1150900229.3708.5.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add ability to return HDLC CRC to user application.

Signed-off-by: Paul Fulghum <paulkf@microgate.com>

--- a/drivers/char/synclink_gt.c	2006-06-21 09:04:11.000000000 -0500
+++ b/drivers/char/synclink_gt.c	2006-06-21 09:20:49.000000000 -0500
@@ -3076,7 +3076,7 @@ static int block_til_ready(struct tty_st
 
 static int alloc_tmp_rbuf(struct slgt_info *info)
 {
-	info->tmp_rbuf = kmalloc(info->max_frame_size, GFP_KERNEL);
+	info->tmp_rbuf = kmalloc(info->max_frame_size + 5, GFP_KERNEL);
 	if (info->tmp_rbuf == NULL)
 		return -ENOMEM;
 	return 0;
@@ -4012,7 +4012,7 @@ static void hdlc_mode(struct slgt_info *
 	case HDLC_ENCODING_DIFF_BIPHASE_LEVEL: val |= BIT12 + BIT11 + BIT10; break;
 	}
 
-	switch (info->params.crc_type)
+	switch (info->params.crc_type & HDLC_CRC_MASK)
 	{
 	case HDLC_CRC_16_CCITT: val |= BIT9; break;
 	case HDLC_CRC_32_CCITT: val |= BIT9 + BIT8; break;
@@ -4073,7 +4073,7 @@ static void hdlc_mode(struct slgt_info *
 	case HDLC_ENCODING_DIFF_BIPHASE_LEVEL: val |= BIT12 + BIT11 + BIT10; break;
 	}
 
-	switch (info->params.crc_type)
+	switch (info->params.crc_type & HDLC_CRC_MASK)
 	{
 	case HDLC_CRC_16_CCITT: val |= BIT9; break;
 	case HDLC_CRC_32_CCITT: val |= BIT9 + BIT8; break;
@@ -4313,6 +4313,12 @@ static int rx_get_frame(struct slgt_info
 	unsigned long flags;
 	struct tty_struct *tty = info->tty;
 	unsigned char addr_field = 0xff;
+	unsigned int crc_size = 0;
+
+	switch (info->params.crc_type & HDLC_CRC_MASK) {
+	case HDLC_CRC_16_CCITT: crc_size = 2; break;
+	case HDLC_CRC_32_CCITT: crc_size = 4; break;
+	}
 
 check_again:
 
@@ -4357,7 +4363,7 @@ check_again:
 	status = desc_status(info->rbufs[end]);
 
 	/* ignore CRC bit if not using CRC (bit is undefined) */
-	if (info->params.crc_type == HDLC_CRC_NONE)
+	if ((info->params.crc_type & HDLC_CRC_MASK) == HDLC_CRC_NONE)
 		status &= ~BIT1;
 
 	if (framesize == 0 ||
@@ -4366,34 +4372,34 @@ check_again:
 		goto check_again;
 	}
 
-	if (framesize < 2 || status & (BIT1+BIT0)) {
-		if (framesize < 2 || (status & BIT0))
-			info->icount.rxshort++;
-		else
-			info->icount.rxcrc++;
+	if (framesize < (2 + crc_size) || status & BIT0) {
+		info->icount.rxshort++;
 		framesize = 0;
+	} else if (status & BIT1) {
+		info->icount.rxcrc++;
+		if (!(info->params.crc_type & HDLC_CRC_RETURN_EX))
+			framesize = 0;
+	}
 
 #ifdef CONFIG_HDLC
-		{
-			struct net_device_stats *stats = hdlc_stats(info->netdev);
-			stats->rx_errors++;
-			stats->rx_frame_errors++;
-		}
-#endif
-	} else {
-		/* adjust frame size for CRC, if any */
-		if (info->params.crc_type == HDLC_CRC_16_CCITT)
-			framesize -= 2;
-		else if (info->params.crc_type == HDLC_CRC_32_CCITT)
-			framesize -= 4;
+	if (framesize == 0) {
+		struct net_device_stats *stats = hdlc_stats(info->netdev);
+		stats->rx_errors++;
+		stats->rx_frame_errors++;
 	}
+#endif
 
 	DBGBH(("%s rx frame status=%04X size=%d\n",
 		info->device_name, status, framesize));
 	DBGDATA(info, info->rbufs[start].buf, min_t(int, framesize, DMABUFSIZE), "rx");
 
 	if (framesize) {
-		if (framesize > info->max_frame_size)
+		if (!(info->params.crc_type & HDLC_CRC_RETURN_EX)) {
+			framesize -= crc_size;
+			crc_size = 0;
+		}
+
+		if (framesize > info->max_frame_size + crc_size)
 			info->icount.rxlong++;
 		else {
 			/* copy dma buffer(s) to contiguous temp buffer */
@@ -4413,6 +4419,11 @@ check_again:
 					i = 0;
 			}
 
+			if (info->params.crc_type & HDLC_CRC_RETURN_EX) {
+				*p = (status & BIT1) ? RX_CRC_ERROR : RX_OK;
+				framesize++;
+			}
+
 #ifdef CONFIG_HDLC
 			if (info->netcount)
 				hdlcdev_rx(info,info->tmp_rbuf, framesize);


