Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267604AbUIAVgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267604AbUIAVgU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267953AbUIAVHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:07:43 -0400
Received: from baikonur.stro.at ([213.239.196.228]:13024 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267951AbUIAU4X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:56:23 -0400
Subject: [patch 08/25]  drivers/char/riscom8.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:56:22 +0200
Message-ID: <E1C2c9W-0007Kr-N1@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/riscom8.c |   20 ++++++++------------
 1 files changed, 8 insertions(+), 12 deletions(-)

diff -puN drivers/char/riscom8.c~min-max-char_riscom8 drivers/char/riscom8.c
--- linux-2.6.9-rc1-bk7/drivers/char/riscom8.c~min-max-char_riscom8	2004-09-01 19:34:08.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/riscom8.c	2004-09-01 19:34:08.000000000 +0200
@@ -75,10 +75,6 @@
 	 ASYNC_SPD_HI       | ASYNC_SPEED_VHI    | ASYNC_SESSION_LOCKOUT | \
 	 ASYNC_PGRP_LOCKOUT | ASYNC_CALLOUT_NOHUP)
 
-#ifndef MIN
-#define MIN(a,b) ((a) < (b) ? (a) : (b))
-#endif
-
 #define RS_EVENT_WRITE_WAKEUP	0
 
 static struct riscom_board * IRQ_to_board[16];
@@ -107,7 +103,7 @@ static struct riscom_board rc_board[RC_N
 };
 
 static struct riscom_port rc_port[RC_NBOARD * RC_NPORT];
-		
+
 /* RISCom/8 I/O ports addresses (without address translation) */
 static unsigned short rc_ioport[] =  {
 #if 1	
@@ -483,7 +479,7 @@ static inline void rc_transmit(struct ri
 				rc_out(bp, CD180_TDR, CD180_C_SBRK);
 				port->COR2 &= ~COR2_ETC;
 			}
-			count = MIN(port->break_length, 0xff);
+			count = min_t(int, port->break_length, 0xff);
 			rc_out(bp, CD180_TDR, CD180_C_ESC);
 			rc_out(bp, CD180_TDR, CD180_C_DELAY);
 			rc_out(bp, CD180_TDR, count);
@@ -1165,8 +1161,8 @@ static int rc_write(struct tty_struct * 
 		down(&tmp_buf_sem);
 		while (1) {
 			cli();		
-			c = MIN(count, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
-					   SERIAL_XMIT_SIZE - port->xmit_head));
+			c = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+						  SERIAL_XMIT_SIZE - port->xmit_head));
 			if (c <= 0)
 				break;
 
@@ -1178,8 +1174,8 @@ static int rc_write(struct tty_struct * 
 			}
 
 			cli();
-			c = MIN(c, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
-				       SERIAL_XMIT_SIZE - port->xmit_head));
+			c = min_t(c, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+					 SERIAL_XMIT_SIZE - port->xmit_head));
 			memcpy(port->xmit_buf + port->xmit_head, tmp_buf, c);
 			port->xmit_head = (port->xmit_head + c) & (SERIAL_XMIT_SIZE-1);
 			port->xmit_cnt += c;
@@ -1193,8 +1189,8 @@ static int rc_write(struct tty_struct * 
 	} else {
 		while (1) {
 			cli();		
-			c = MIN(count, MIN(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
-					   SERIAL_XMIT_SIZE - port->xmit_head));
+			c = min_t(int, count, min(SERIAL_XMIT_SIZE - port->xmit_cnt - 1,
+						  SERIAL_XMIT_SIZE - port->xmit_head));
 			if (c <= 0) {
 				restore_flags(flags);
 				break;

_
