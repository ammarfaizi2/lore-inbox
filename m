Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267999AbUIAXN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267999AbUIAXN7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Sep 2004 19:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268048AbUIAVBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Sep 2004 17:01:17 -0400
Received: from baikonur.stro.at ([213.239.196.228]:64915 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S267846AbUIAU5e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Sep 2004 16:57:34 -0400
Subject: [patch 21/25]  hvc_console: replace schedule_timeout() 	with msleep()
To: linux-kernel@vger.kernel.org
Cc: akpm@digeo.com, janitor@sternwelten.at
From: janitor@sternwelten.at
Date: Wed, 01 Sep 2004 22:57:33 +0200
Message-ID: <E1C2cAg-0007UH-3I@sputnik>
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

 linux-2.6.9-rc1-bk7-max/drivers/char/hvc_console.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/char/hvc_console.c~msleep-drivers_char_hvc_console drivers/char/hvc_console.c
--- linux-2.6.9-rc1-bk7/drivers/char/hvc_console.c~msleep-drivers_char_hvc_console	2004-09-01 21:01:32.000000000 +0200
+++ linux-2.6.9-rc1-bk7-max/drivers/char/hvc_console.c	2004-09-01 21:02:32.000000000 +0200
@@ -26,6 +26,7 @@
 #include <linux/tty.h>
 #include <linux/tty_flip.h>
 #include <linux/sched.h>
+#include <linux/delay.h>
 #include <linux/kbd_kern.h>
 #include <asm/uaccess.h>
 #include <linux/spinlock.h>
@@ -40,7 +41,7 @@ extern int hvc_put_chars(int index, cons
 
 #define MAX_NR_HVC_CONSOLES	4
 
-#define TIMEOUT		((HZ + 99) / 100)
+#define TIMEOUT		10
 
 static struct tty_driver *hvc_driver;
 static int hvc_offset;
@@ -276,8 +277,7 @@ int khvcd(void *unused)
 			for (i = 0; i < MAX_NR_HVC_CONSOLES; ++i)
 				hvc_poll(i);
 		}
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(TIMEOUT);
+		msleep(TIMEOUT);
 	}
 }
 

_
