Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267988AbUIAVEO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267988AbUIAVEO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:04:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267989AbUIAVDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:03:43 -0400
Received: from baikonur.stro.at ([213.239.196.228]:57562 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267987AbUIAU5B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:01 -0400
Subject: [patch 15/25]  drivers/char/synclinkmp.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:00 +0200
Message-ID: <E1C2cA9-0007Pp-2y@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/synclinkmp.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)

diff -puN drivers/char/synclinkmp.c~min-max-char_synclinkmp drivers/char/synclinkmp.c
--- linux-2.6.9-rc1-bk7/drivers/char/synclinkmp.c~min-max-char_synclinkmp	2004-09-01 19:34:13.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/synclinkmp.c	2004-09-01 19:34:13.000000000 +0200
@@ -515,10 +515,6 @@ static struct tty_driver *serial_driver;
 /* number of characters left in xmit buffer before we ask for more */
 #define WAKEUP_CHARS 256
 
-#ifndef MIN
-#define MIN(a,b) ((a) < (b) ? (a) : (b))
-#endif
-
 
 /* tty callbacks */
 
@@ -1000,8 +996,8 @@ static int write(struct tty_struct *tty,
 	}
 
 	for (;;) {
-		c = MIN(count,
-			MIN(info->max_frame_size - info->tx_count - 1,
+		c = min_t(int, count,
+			min(info->max_frame_size - info->tx_count - 1,
 			    info->max_frame_size - info->tx_put));
 		if (c <= 0)
 			break;
@@ -1144,7 +1140,7 @@ static void wait_until_sent(struct tty_s
 		char_time = 1;
 
 	if (timeout)
-		char_time = MIN(char_time, timeout);
+		char_time = min_t(unsigned long, char_time, timeout);
 
 	if ( info->params.mode == MGSL_MODE_HDLC ) {
 		while (info->tx_active) {
@@ -5024,7 +5020,7 @@ CheckAgain:
 
 	if ( debug_level >= DEBUG_LEVEL_DATA )
 		trace_block(info,info->rx_buf_list_ex[StartIndex].virt_addr,
-			MIN(framesize,SCABUFSIZE),0);
+			min_t(int, framesize,SCABUFSIZE),0);
 
 	if (framesize) {
 		if (framesize > info->max_frame_size)
@@ -5039,7 +5035,7 @@ CheckAgain:
 			info->icount.rxok++;
 
 			while(copy_count) {
-				int partial_count = MIN(copy_count,SCABUFSIZE);
+				int partial_count = min(copy_count,SCABUFSIZE);
 				memcpy( ptmp,
 					info->rx_buf_list_ex[index].virt_addr,
 					partial_count );
@@ -5096,14 +5092,14 @@ void tx_load_dma_buffer(SLMP_INFO *info,
 	SCADESC_EX *desc_ex;
 
 	if ( debug_level >= DEBUG_LEVEL_DATA )
-		trace_block(info,buf, MIN(count,SCABUFSIZE), 1);
+		trace_block(info,buf, min_t(int, count,SCABUFSIZE), 1);
 
 	/* Copy source buffer to one or more DMA buffers, starting with
 	 * the first transmit dma buffer.
 	 */
 	for(i=0;;)
 	{
-		copy_count = MIN(count,SCABUFSIZE);
+		copy_count = min_t(unsigned short,count,SCABUFSIZE);
 
 		desc = &info->tx_buf_list[i];
 		desc_ex = &info->tx_buf_list_ex[i];

_
