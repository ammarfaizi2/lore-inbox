Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268005AbUIAVEd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268005AbUIAVEd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267833AbUIAVE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:04:26 -0400
Received: from baikonur.stro.at ([213.239.196.228]:61927 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267986AbUIAU44
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:56 -0400
Subject: [patch 14/25]  drivers/char/synclink.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:55 +0200
Message-ID: <E1C2cA3-0007P7-Iz@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/synclink.c |   22 +++++++++-------------
 1 files changed, 9 insertions(+), 13 deletions(-)

diff -puN drivers/char/synclink.c~min-max-char_synclink drivers/char/synclink.c
--- linux-2.6.9-rc1-bk7/drivers/char/synclink.c~min-max-char_synclink	2004-09-01 19:34:13.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/synclink.c	2004-09-01 19:34:13.000000000 +0200
@@ -930,10 +930,6 @@ static struct tty_driver *serial_driver;
 static void mgsl_change_params(struct mgsl_struct *info);
 static void mgsl_wait_until_sent(struct tty_struct *tty, int timeout);
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * 1st function defined in .text section. Calling this function in
  * init_module() followed by a breakpoint allows a remote debugger
@@ -2246,8 +2242,8 @@ static int mgsl_write(struct tty_struct 
 		if (from_user) {
 			down(&tmp_buf_sem);
 			while (1) {
-				c = MIN(count,
-					MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+				c = min_t(int, count,
+					min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					    SERIAL_XMIT_SIZE - info->xmit_head));
 				if (c <= 0)
 					break;
@@ -2260,7 +2256,7 @@ static int mgsl_write(struct tty_struct 
 					break;
 				}
 				spin_lock_irqsave(&info->irq_spinlock,flags);
-				c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+				c = min_t(int, c, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					       SERIAL_XMIT_SIZE - info->xmit_head));
 				memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
 				info->xmit_head = ((info->xmit_head + c) &
@@ -2275,8 +2271,8 @@ static int mgsl_write(struct tty_struct 
 		} else {
 			while (1) {
 				spin_lock_irqsave(&info->irq_spinlock,flags);
-				c = MIN(count,
-					MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+				c = min_t(int, count,
+					min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
 					    SERIAL_XMIT_SIZE - info->xmit_head));
 				if (c <= 0) {
 					spin_unlock_irqrestore(&info->irq_spinlock,flags);
@@ -3314,7 +3310,7 @@ static void mgsl_wait_until_sent(struct 
 		char_time = 1;
 		
 	if (timeout)
-		char_time = MIN(char_time, timeout);
+		char_time = min_t(unsigned long, char_time, timeout);
 		
 	if ( info->params.mode == MGSL_MODE_HDLC ||
 		info->params.mode == MGSL_MODE_RAW ) {
@@ -6767,7 +6763,7 @@ int mgsl_get_rx_frame(struct mgsl_struct
 			
 	if ( debug_level >= DEBUG_LEVEL_DATA )
 		mgsl_trace_block(info,info->rx_buffer_list[StartIndex].virt_addr,
-			MIN(framesize,DMABUFFERSIZE),0);	
+			min_t(int, framesize, DMABUFFERSIZE),0);
 		
 	if (framesize) {
 		if ( ( (info->params.crc_type & HDLC_CRC_RETURN_EX) &&
@@ -6982,7 +6978,7 @@ int mgsl_get_raw_rx_frame(struct mgsl_st
 
 		if ( debug_level >= DEBUG_LEVEL_DATA )
 			mgsl_trace_block(info,info->rx_buffer_list[CurrentIndex].virt_addr,
-				MIN(framesize,DMABUFFERSIZE),0);
+				min_t(int, framesize, DMABUFFERSIZE),0);
 
 		if (framesize) {
 			/* copy dma buffer(s) to contiguous intermediate buffer */
@@ -7042,7 +7038,7 @@ void mgsl_load_tx_dma_buffer(struct mgsl
 	DMABUFFERENTRY *pBufEntry;
 	
 	if ( debug_level >= DEBUG_LEVEL_DATA )
-		mgsl_trace_block(info,Buffer, MIN(BufferSize,DMABUFFERSIZE), 1);	
+		mgsl_trace_block(info,Buffer, min_t(int, BufferSize, DMABUFFERSIZE), 1);
 
 	if (info->params.flags & HDLC_FLAG_HDLC_LOOPMODE) {
 		/* set CMR:13 to start transmit when

_
