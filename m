Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUIXDSw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUIXDSw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUIWUfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:35:16 -0400
Received: from baikonur.stro.at ([213.239.196.228]:26313 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266864AbUIWUZw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:52 -0400
Subject: [patch 21/26]  char/stallion: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:52 +0200
Message-ID: <E1CAaA5-0000HA-5V@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. I'm not sure if I did the desired
thing here, as I got rid of stl_delay() completely. After the
msleep_interruptible() replacement, stli_delay() would only be used in
one place. I'm not sure which way is preferred (the original or mine)
regarding the second change, therefore.

Description: Use msleep_interruptible() instead of stl_delay() to
guarantee the task delays as expected. Removed the definition /
prototype of stl_delay() as it was only called in one other place,
where I made the direct change to
set_current_state()/schedule_timeout().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---

 linux-2.6.9-rc2-bk7-max/drivers/char/stallion.c |   26 +++---------------------
 1 files changed, 4 insertions(+), 22 deletions(-)

diff -puN drivers/char/stallion.c~msleep_interruptible-drivers_char_stallion drivers/char/stallion.c
--- linux-2.6.9-rc2-bk7/drivers/char/stallion.c~msleep_interruptible-drivers_char_stallion	2004-09-21 23:22:52.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/stallion.c	2004-09-21 23:54:29.000000000 +0200
@@ -42,6 +42,7 @@
 #include <linux/smp_lock.h>
 #include <linux/devfs_fs_kernel.h>
 #include <linux/device.h>
+#include <linux/delay.h>
 
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -512,7 +513,6 @@ static int	stl_clrportstats(stlport_t *p
 static int	stl_getportstruct(stlport_t __user *arg);
 static int	stl_getbrdstruct(stlbrd_t __user *arg);
 static int	stl_waitcarrier(stlport_t *portp, struct file *filp);
-static void	stl_delay(int len);
 static void	stl_eiointr(stlbrd_t *brdp);
 static void	stl_echatintr(stlbrd_t *brdp);
 static void	stl_echmcaintr(stlbrd_t *brdp);
@@ -1205,7 +1205,7 @@ static void stl_close(struct tty_struct 
 
 	if (portp->openwaitcnt) {
 		if (portp->close_delay)
-			stl_delay(portp->close_delay);
+			msleep_interruptible(jiffies_to_msecs(portp->close_delay));
 		wake_up_interruptible(&portp->open_wait);
 	}
 
@@ -1217,25 +1217,6 @@ static void stl_close(struct tty_struct 
 /*****************************************************************************/
 
 /*
- *	Wait for a specified delay period, this is not a busy-loop. It will
- *	give up the processor while waiting. Unfortunately this has some
- *	rather intimate knowledge of the process management stuff.
- */
-
-static void stl_delay(int len)
-{
-#ifdef DEBUG
-	printk("stl_delay(len=%d)\n", len);
-#endif
-	if (len > 0) {
-		current->state = TASK_INTERRUPTIBLE;
-		schedule_timeout(len);
-	}
-}
-
-/*****************************************************************************/
-
-/*
  *	Write routine. Take data and stuff it in to the TX ring queue.
  *	If transmit interrupts are not running then start them.
  */
@@ -1858,7 +1839,8 @@ static void stl_waituntilsent(struct tty
 	while (stl_datastate(portp)) {
 		if (signal_pending(current))
 			break;
-		stl_delay(2);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(2);
 		if (time_after_eq(jiffies, tend))
 			break;
 	}
_
