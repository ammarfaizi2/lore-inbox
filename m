Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267989AbUIAVEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267989AbUIAVEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 17:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267930AbUIAVDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:03:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:1985 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S267988AbUIAU5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:12 -0400
Subject: [patch 17/25]  drivers/tc/zs.c MIN/MAX removal
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:11 +0200
Message-ID: <E1C2cAK-0007RF-2m@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patch (against 2.6.7) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Feedback is always welcome
Michael

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/tc/zs.c |   14 +++++---------
 1 files changed, 5 insertions(+), 9 deletions(-)

diff -puN drivers/tc/zs.c~min-max-tc_zs drivers/tc/zs.c
--- linux-2.6.9-rc1-bk7/drivers/tc/zs.c~min-max-tc_zs	2004-09-01 19:34:22.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/tc/zs.c	2004-09-01 19:34:22.000000000 +0200
@@ -211,10 +211,6 @@ static void probe_sccs(void);
 static void change_speed(struct dec_serial *info);
 static void rs_wait_until_sent(struct tty_struct *tty, int timeout);
 
-#ifndef MIN
-#define MIN(a,b)	((a) < (b) ? (a) : (b))
-#endif
-
 /*
  * tmp_buf is used as a temporary buffer by serial_write.  We need to
  * lock it in case the copy_from_user blocks while swapping in a page,
@@ -950,16 +946,16 @@ static int rs_write(struct tty_struct * 
 	save_flags(flags);
 	while (1) {
 		cli();		
-		c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				   SERIAL_XMIT_SIZE - info->xmit_head));
+		c = min_t(int, count, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+					  SERIAL_XMIT_SIZE - info->xmit_head));
 		if (c <= 0)
 			break;
 
 		if (from_user) {
 			down(&tmp_buf_sem);
 			copy_from_user(tmp_buf, buf, c);
-			c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
-				       SERIAL_XMIT_SIZE - info->xmit_head));
+			c = min_t(int, c, min(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
+					      SERIAL_XMIT_SIZE - info->xmit_head));
 			memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
 			up(&tmp_buf_sem);
 		} else
@@ -1446,7 +1442,7 @@ static void rs_wait_until_sent(struct tt
 	if (char_time == 0)
 		char_time = 1;
 	if (timeout)
-		char_time = MIN(char_time, timeout);
+		char_time = min_t(unsigned long, char_time, timeout);
 	while ((read_zsreg(info->zs_channel, 1) & Tx_BUF_EMP) == 0) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule_timeout(char_time);

_
