Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267839AbUIAU7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267839AbUIAU7K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267519AbUIAU7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 16:59:05 -0400
Received: from baikonur.stro.at ([213.239.196.228]:19336 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S268003AbUIAU5t
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:49 -0400
Subject: [patch 23/25]  nwflash: replace schedule_timeout() with 	msleep()
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:44 +0200
Message-ID: <E1C2cAr-0007Vh-30@sputnik>
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

Note: I could not find any current Maintainer for this driver. If there
is one I should sent the patch too, please let me know.

Thanks,
Nish



Description: Uses msleep() instead of schedule_timeout() to guarantee
the task delays at least the desired time amount.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>



---

 linux-2.6.9-rc1-bk7-max/drivers/char/nwflash.c |   19 +++++--------------
 1 files changed, 5 insertions(+), 14 deletions(-)

diff -puN drivers/char/nwflash.c~msleep-drivers_char_nwflash drivers/char/nwflash.c
--- linux-2.6.9-rc1-bk7/drivers/char/nwflash.c~msleep-drivers_char_nwflash	2004-09-01 19:34:46.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/nwflash.c	2004-09-01 19:34:46.000000000 +0200
@@ -60,15 +60,6 @@ static DECLARE_MUTEX(nwflash_sem);
 
 extern spinlock_t gpio_lock;
 
-/*
- * the delay routine - it is often required to let the flash "breeze"...
- */
-void flash_wait(int timeout)
-{
-	current->state = TASK_INTERRUPTIBLE;
-	schedule_timeout(timeout);
-}
-
 static int get_flash_id(void)
 {
 	volatile unsigned int c1, c2;
@@ -401,7 +392,7 @@ static int erase_block(int nBlock)
 	/*
 	 * wait 10 ms
 	 */
-	flash_wait(HZ / 100);
+	msleep(10);
 
 	/*
 	 * wait while erasing in process (up to 10 sec)
@@ -409,7 +400,7 @@ static int erase_block(int nBlock)
 	timeout = jiffies + 10 * HZ;
 	c1 = 0;
 	while (!(c1 & 0x80) && time_before(jiffies, timeout)) {
-		flash_wait(HZ / 100);
+		msleep(10);
 		/*
 		 * read any address
 		 */
@@ -440,7 +431,7 @@ static int erase_block(int nBlock)
 	/*
 	 * just to make sure - verify if erased OK...
 	 */
-	flash_wait(HZ / 100);
+	msleep(10);
 
 	pWritePtr = (unsigned char *) ((unsigned int) (FLASH_BASE + (nBlock << 16)));
 
@@ -587,7 +578,7 @@ static int write_block(unsigned long p, 
 				/*
 				 * wait couple ms
 				 */
-				flash_wait(HZ / 100);
+				msleep(10);
 				/*
 				 * red LED == write
 				 */
@@ -612,7 +603,7 @@ static int write_block(unsigned long p, 
 	leds_event(led_amber_off);
 	leds_event(led_green_on);
 
-	flash_wait(HZ / 100);
+	msleep(10);
 
 	pWritePtr = (unsigned char *) ((unsigned int) (FLASH_BASE + p));
 

_
