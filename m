Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUIXADt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUIXADt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267250AbUIXADF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:03:05 -0400
Received: from baikonur.stro.at ([213.239.196.228]:10193 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267212AbUIWUo3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:44:29 -0400
Subject: [patch 7/9]  block/pt: replace pt_sleep() with 	msleep_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:44:29 +0200
Message-ID: <E1CAaS5-0002aa-VJ@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. This is a re-push of a patch I
submitted 20 July which hasn't been merged as of
2.6.9-rc1-mm5/2.6.9-rc2. 

Description: msleep_interruptible() is used instead of pt_sleep()
to guarantee the task delays as expected. The definition of pt_sleep()
is also removed.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/block/paride/pt.c |   14 ++++----------
 1 files changed, 4 insertions(+), 10 deletions(-)

diff -puN drivers/block/paride/pt.c~msleep_interruptible-drivers_block_pt drivers/block/paride/pt.c
--- linux-2.6.9-rc2-bk7/drivers/block/paride/pt.c~msleep_interruptible-drivers_block_pt	2004-09-21 21:07:55.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/paride/pt.c	2004-09-21 21:07:55.000000000 +0200
@@ -401,12 +401,6 @@ static int pt_atapi(struct pt_unit *tape
 	return r;
 }
 
-static void pt_sleep(int cs)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(cs);
-}
-
 static int pt_poll_dsc(struct pt_unit *tape, int pause, int tmo, char *msg)
 {
 	struct pi_adapter *pi = tape->pi;
@@ -416,7 +410,7 @@ static int pt_poll_dsc(struct pt_unit *t
 	e = 0;
 	s = 0;
 	while (k < tmo) {
-		pt_sleep(pause);
+		msleep_interruptible(jiffies_to_msecs(pause));
 		k++;
 		pi_connect(pi);
 		write_reg(pi, 6, DRIVE(tape));
@@ -474,11 +468,11 @@ static int pt_reset(struct pt_unit *tape
 	write_reg(pi, 6, DRIVE(tape));
 	write_reg(pi, 7, 8);
 
-	pt_sleep(20 * HZ / 1000);
+	msleep_interruptible(20);
 
 	k = 0;
 	while ((k++ < PT_RESET_TMO) && (status_reg(pi) & STAT_BUSY))
-		pt_sleep(HZ / 10);
+		msleep_interruptible(100);
 
 	flg = 1;
 	for (i = 0; i < 5; i++)
@@ -512,7 +506,7 @@ static int pt_ready_wait(struct pt_unit 
 		if (!(((p & 0xffff) == 0x0402) || ((p & 0xff) == 6)))
 			return p;
 		k++;
-		pt_sleep(HZ);
+		msleep_interruptible(1000);
 	}
 	return 0x000020;	/* timeout */
 }
_
