Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261661AbVEDUtl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261661AbVEDUtl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbVEDUtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:49:36 -0400
Received: from penta.pentaserver.com ([216.74.97.66]:60835 "EHLO
	penta.pentaserver.com") by vger.kernel.org with ESMTP
	id S261650AbVEDUss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:48:48 -0400
Message-ID: <4279343A.1000707@kromtek.com>
Date: Thu, 05 May 2005 00:44:42 +0400
From: Manu Abraham <manu@kromtek.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, greg@kroah.com, js@linuxtv.org,
       kraxel@bytesex.org
Subject: [PATCH] Fix dst i2c read/write timeout failure.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - penta.pentaserver.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kromtek.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Attached is a patch to bttv which fixes the following problems.


Affected cards and problems:
~~~~~~~~~~~~~~~~~~~~~~~~
o VP-1020 (200103A) Tuning problems, device detection.
o VP-1020 (DST-MOT) Errors during tuning, device detection fails in a while.
o VP-1030 (DST-CI) Tuning sometimes fails after CI commands.
o VP-2031 (DCT-CI) Tuning problems


The timeout happens before the actual timeout occured in the MCU
on the board, and hence the problems.


Changes: (bttv-i2c.diff)
~~~~~~~~~~~~~~~~~~~~~~~~
o Changed the custom wait queue to wait_event_interruptible_timeout()
      - Suggestion by Johannes Stezenbach.

o Fixed the wait queue timeout problem
      - This fixes the timeout problem on various cards.
      - This problem was visible as many
          * Cannot tune to channels, when signal levels are very low.
          * app_info does not work in some conditions for CI based cards
      - Smaller values worked good for newer cards, but the older cards
suffered, settled down to the worst case values that could happen in any
eventuality.


Signed-off-by: Manu Abraham <manu@kromtek.com>


Index: linux-2.6.12-rc3/drivers/media/video/bttv-i2c.c
========================================
--- linux-2.6.12-rc3.orig/drivers/media/video/bttv-i2c.c	2005-05-03
16:04:28.000000000 +0400
+++ linux-2.6.12-rc3/drivers/media/video/bttv-i2c.c	2005-05-05
00:01:00.000000000 +0400
@@ -29,6 +29,7 @@
   #include <linux/moduleparam.h>
   #include <linux/init.h>
   #include <linux/delay.h>
+#include <linux/jiffies.h>
   #include <asm/io.h>

   #include "bttvp.h"
@@ -130,17 +131,14 @@ static u32 functionality(struct i2c_adap
   static int
   bttv_i2c_wait_done(struct bttv *btv)
   {
-	DECLARE_WAITQUEUE(wait, current);
   	int rc = 0;

-	add_wait_queue(&btv->i2c_queue, &wait);
-	if (0 == btv->i2c_done)
-		msleep_interruptible(20);
-	remove_wait_queue(&btv->i2c_queue, &wait);
-
-	if (0 == btv->i2c_done)
-		/* timeout */
-		rc = -EIO;
+	/* timeout */
+	if (wait_event_interruptible_timeout(btv->i2c_queue,
+		btv->i2c_done, msecs_to_jiffies(85)) == -ERESTARTSYS)
+
+	rc = -EIO;
+	
   	if (btv->i2c_done & BT848_INT_RACK)
   		rc = 1;
   	btv->i2c_done = 0;



