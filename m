Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267823AbUIAXVv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267823AbUIAXVv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUIAXUd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 19:20:33 -0400
Received: from baikonur.stro.at ([213.239.196.228]:51404 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267846AbUIAXPu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 19:15:50 -0400
Subject: [patch 02/14]  mcd: replace schedule_timeout() with 	msleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Thu, 02 Sep 2004 01:15:49 +0200
Message-ID: <E1C2eKU-0002kr-6E@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







I would appreciate any comments from the janitor@sternweltens list. This is one (of
many) cases where I made a decision about replacing

set_current_state(TASK_INTERRUPTIBLE);
schedule_timeout(some_time);

with

msleep(jiffies_to_msecs(some_time));

msleep() is not exactly the same as the previous code, but I only did
this replacement where I thought long delays were *desired*. If this is
not the case here, then just disregard this patch.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/cdrom/mcd.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff -puN drivers/cdrom/mcd.c~msleep-drivers_cdrom_mcd drivers/cdrom/mcd.c
--- linux-2.6.9-rc1-bk7/drivers/cdrom/mcd.c~msleep-drivers_cdrom_mcd	2004-09-01 19:34:42.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/cdrom/mcd.c	2004-09-01 19:34:42.000000000 +0200
@@ -1021,10 +1021,9 @@ static int mcd_open(struct cdrom_device_
 		st = statusCmd();	/* check drive status */
 		if (st == -1)
 			goto err_out;	/* drive doesn't respond */
-		if ((st & MST_READY) == 0) {	/* no disk? wait a sec... */
-			current->state = TASK_INTERRUPTIBLE;
-			schedule_timeout(HZ);
-		}
+		if ((st & MST_READY) == 0) 	/* no disk? wait a sec... */
+			msleep(1000);
+
 	} while (((st & MST_READY) == 0) && count++ < MCD_RETRY_ATTEMPTS);
 
 	if (updateToc() < 0)

_
