Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266578AbUIXCJ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266578AbUIXCJ7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266705AbUIWUlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:41:00 -0400
Received: from baikonur.stro.at ([213.239.196.228]:59578 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266689AbUIWUZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:11 -0400
Subject: [patch 06/26]  char/ftape-io: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:10 +0200
Message-ID: <E1CAa9O-0007xr-Dy@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. 

Description: Use msleep_interruptible() instead of schedule_timeout() to
guarantee the task delays as expected. In this case, this allowed for
the removal of the entire do-while.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 linux-2.6.9-rc2-bk7-max/drivers/char/ftape/lowlevel/ftape-io.c |   20 +++-------
 1 files changed, 7 insertions(+), 13 deletions(-)

diff -puN drivers/char/ftape/lowlevel/ftape-io.c~msleep_interruptible-drivers_char_ftape-io drivers/char/ftape/lowlevel/ftape-io.c
--- linux-2.6.9-rc2-bk7/drivers/char/ftape/lowlevel/ftape-io.c~msleep_interruptible-drivers_char_ftape-io	2004-09-21 22:49:10.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/ftape/lowlevel/ftape-io.c	2004-09-21 22:49:48.000000000 +0200
@@ -32,6 +32,7 @@
 #include <asm/system.h>
 #include <linux/ioctl.h>
 #include <linux/mtio.h>
+#include <linux/delay.h>
 
 #include <linux/ftape.h>
 #include <linux/qic117.h>
@@ -96,19 +97,12 @@ void ftape_sleep(unsigned int time)
 		timeout = ticks;
 		save_flags(flags);
 		sti();
-		set_current_state(TASK_INTERRUPTIBLE);
-		do {
-			/*  Mmm. Isn't current->blocked == 0xffffffff ?
-			 */
-			if (signal_pending(current)) {
-				TRACE(ft_t_err,
-				      "awoken by non-blocked signal :-(");
-				break;	/* exit on signal */
-			}
-			while (current->state != TASK_RUNNING) {
-				timeout = schedule_timeout(timeout);
-			}
-		} while (timeout);
+		msleep_interruptible(jiffies_to_msecs(timeout));
+		/*  Mmm. Isn't current->blocked == 0xffffffff ?
+		 */
+		if (signal_pending(current)) {
+			TRACE(ft_t_err, "awoken by non-blocked signal :-(");
+		}
 		restore_flags(flags);
 	}
 	TRACE_EXIT;
_
