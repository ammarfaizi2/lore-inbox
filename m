Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUIXBqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUIXBqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUIXBiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:38:50 -0400
Received: from baikonur.stro.at ([213.239.196.228]:15085 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267330AbUIWUoX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:44:23 -0400
Subject: [patch 5/9]  block/pf: replace pf_sleep() with 	msleep_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:44:23 +0200
Message-ID: <E1CAaS0-0002SZ-5W@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. This is a re-push of a patch I
submitted 20 July which hasn't been merged as of
2.6.9-rc1-mm5/2.6.9-rc2. 

Description: msleep_interruptible() is used instead of pf_sleep()
to guarantee the task delays as expected. The defintion of pf_sleep()
is also removed.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/block/paride/pf.c |   10 ++--------
 1 files changed, 2 insertions(+), 8 deletions(-)

diff -puN drivers/block/paride/pf.c~msleep_interruptible-drivers_block_pf drivers/block/paride/pf.c
--- linux-2.6.9-rc2-bk7/drivers/block/paride/pf.c~msleep_interruptible-drivers_block_pf	2004-09-21 21:07:53.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/paride/pf.c	2004-09-21 21:07:53.000000000 +0200
@@ -526,12 +526,6 @@ static void pf_eject(struct pf_unit *pf)
 
 #define PF_RESET_TMO   30	/* in tenths of a second */
 
-static void pf_sleep(int cs)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(cs);
-}
-
 /* the ATAPI standard actually specifies the contents of all 7 registers
    after a reset, but the specification is ambiguous concerning the last
    two bytes, and different drives interpret the standard differently.
@@ -546,11 +540,11 @@ static int pf_reset(struct pf_unit *pf)
 	write_reg(pf, 6, 0xa0+0x10*pf->drive);
 	write_reg(pf, 7, 8);
 
-	pf_sleep(20 * HZ / 1000);
+	msleep_interruptible(20);
 
 	k = 0;
 	while ((k++ < PF_RESET_TMO) && (status_reg(pf) & STAT_BUSY))
-		pf_sleep(HZ / 10);
+		msleep_interruptible(100);
 
 	flg = 1;
 	for (i = 0; i < 5; i++)
_
