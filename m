Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUIXBhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUIXBhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 21:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266674AbUIWUoG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:44:06 -0400
Received: from baikonur.stro.at ([213.239.196.228]:42423 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267250AbUIWUc1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:32:27 -0400
Subject: [patch 13/21]  media/msp3400: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:32:24 +0200
Message-ID: <E1CAaGO-0001NG-M8@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated.

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/media/video/msp3400.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff -puN drivers/media/video/msp3400.c~msleep_interruptible-drivers_media_video_msp3400 drivers/media/video/msp3400.c
--- linux-2.6.9-rc2-bk7/drivers/media/video/msp3400.c~msleep_interruptible-drivers_media_video_msp3400	2004-09-21 21:16:59.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/media/video/msp3400.c	2004-09-21 21:16:59.000000000 +0200
@@ -191,8 +191,7 @@ msp3400c_read(struct i2c_client *client,
 		err++;
 		printk(KERN_WARNING "msp34xx: I/O error #%d (read 0x%02x/0x%02x)\n",
 		       err, dev, addr);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/10);
+		msleep_interruptible(100);
 	}
 	if (3 == err) {
 		printk(KERN_WARNING "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
@@ -220,8 +219,7 @@ msp3400c_write(struct i2c_client *client
 		err++;
 		printk(KERN_WARNING "msp34xx: I/O error #%d (write 0x%02x/0x%02x)\n",
 		       err, dev, addr);
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(HZ/10);
+		msleep_interruptible(100);
 	}
 	if (3 == err) {
 		printk(KERN_WARNING "msp34xx: giving up, reseting chip. Sound will go off, sorry folks :-|\n");
@@ -740,11 +738,12 @@ static int msp34xx_sleep(struct msp3400c
 
 	add_wait_queue(&msp->wq, &wait);
 	if (!msp->rmmod) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		if (timeout < 0)
+		if (timeout < 0) {
+			set_current_state(TASK_INTERRUPTIBLE);
 			schedule();
+		}
 		else
-			schedule_timeout(timeout);
+			msleep_interruptible(jiffies_to_msecs(timeout));
 	}
 	remove_wait_queue(&msp->wq, &wait);
 	return msp->rmmod || signal_pending(current);
_
