Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUIXBqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUIXBqO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUIXBjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 21:39:14 -0400
Received: from baikonur.stro.at ([213.239.196.228]:52421 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267327AbUIWUoU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:44:20 -0400
Subject: [patch 4/9]  block/pcd: replace pcd_sleep() with 	msleep_interruptible()
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:44:20 +0200
Message-ID: <E1CAaRx-0002Oj-8X@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. This is a re-push of a patch I
submitted 19 July which hasn't been merged as of
2.6.9-rc1-mm5/2.6.9-rc2. 

Description: msleep_interruptible() is used instead of pcd_sleep()
to guarantee the task delays as expected. The defintion of pcd_sleep()
is also removed.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/block/paride/pcd.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff -puN drivers/block/paride/pcd.c~msleep_interruptible-drivers_block_pcd drivers/block/paride/pcd.c
--- linux-2.6.9-rc2-bk7/drivers/block/paride/pcd.c~msleep_interruptible-drivers_block_pcd	2004-09-21 21:07:52.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/block/paride/pcd.c	2004-09-21 21:07:52.000000000 +0200
@@ -534,12 +534,6 @@ static int pcd_tray_move(struct cdrom_de
 			 position ? "eject" : "close tray");
 }
 
-static void pcd_sleep(int cs)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(cs);
-}
-
 static int pcd_reset(struct pcd_unit *cd)
 {
 	int i, k, flg;
@@ -549,11 +543,11 @@ static int pcd_reset(struct pcd_unit *cd
 	write_reg(cd, 6, 0xa0 + 0x10 * cd->drive);
 	write_reg(cd, 7, 8);
 
-	pcd_sleep(20 * HZ / 1000);	/* delay a bit */
+	msleep_interruptible(20);	/* delay a bit */
 
 	k = 0;
 	while ((k++ < PCD_RESET_TMO) && (status_reg(cd) & IDE_BUSY))
-		pcd_sleep(HZ / 10);
+		msleep_interruptible(100);
 
 	flg = 1;
 	for (i = 0; i < 5; i++)
@@ -592,7 +586,7 @@ static int pcd_ready_wait(struct pcd_uni
 		if (!(((p & 0xffff) == 0x0402) || ((p & 0xff) == 6)))
 			return p;
 		k++;
-		pcd_sleep(HZ);
+		msleep_interruptible(1000);
 	}
 	return 0x000020;	/* timeout */
 }
_
