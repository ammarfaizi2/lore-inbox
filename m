Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUIXCJ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUIXCJ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 22:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUIWUjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 16:39:44 -0400
Received: from baikonur.stro.at ([213.239.196.228]:63177 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266775AbUIWUZ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:25:27 -0400
Subject: [patch 12/26]  char/istallion: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:25:27 +0200
Message-ID: <E1CAa9g-0008HI-0z@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. I'm not sure if I did the desired
thing here, as I got rid of stli_delay() completely. After the
msleep_interruptible() replacement, stli_delay() would only be used in
one place. I'm not sure which way is preferred (the original or mine)
regarding the second change, therefore.

Description: Use msleep_interruptible() instead of stli_delay() to
guarantee the task delays as expected. Removed the definition /
prototype of stli_delay() as it was only called in one other place,
where I made the direct change to
set_current_state()/schedule_timeout().

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/char/istallion.c |   25 ++---------------------
 1 files changed, 3 insertions(+), 22 deletions(-)

diff -puN drivers/char/istallion.c~msleep_interruptible-drivers_char_istallion drivers/char/istallion.c
--- linux-2.6.9-rc2-bk7/drivers/char/istallion.c~msleep_interruptible-drivers_char_istallion	2004-09-21 21:08:11.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/char/istallion.c	2004-09-21 21:08:11.000000000 +0200
@@ -691,7 +691,6 @@ static int	stli_rawopen(stlibrd_t *brdp,
 static int	stli_rawclose(stlibrd_t *brdp, stliport_t *portp, unsigned long arg, int wait);
 static int	stli_waitcarrier(stlibrd_t *brdp, stliport_t *portp, struct file *filp);
 static void	stli_dohangup(void *arg);
-static void	stli_delay(int len);
 static int	stli_setport(stliport_t *portp);
 static int	stli_cmdwait(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
 static void	stli_sendcmd(stlibrd_t *brdp, stliport_t *portp, unsigned long cmd, void *arg, int size, int copyback);
@@ -1180,7 +1179,7 @@ static void stli_close(struct tty_struct
 
 	if (portp->openwaitcnt) {
 		if (portp->close_delay)
-			stli_delay(portp->close_delay);
+			msleep_interruptible(jiffies_to_msecs(portp->close_delay));
 		wake_up_interruptible(&portp->open_wait);
 	}
 
@@ -1478,25 +1477,6 @@ static int stli_setport(stliport_t *port
 /*****************************************************************************/
 
 /*
- *	Wait for a specified delay period, this is not a busy-loop. It will
- *	give up the processor while waiting. Unfortunately this has some
- *	rather intimate knowledge of the process management stuff.
- */
-
-static void stli_delay(int len)
-{
-#ifdef DEBUG
-	printk("stli_delay(len=%d)\n", len);
-#endif
-	if (len > 0) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(len);
-	}
-}
-
-/*****************************************************************************/
-
-/*
  *	Possibly need to wait for carrier (DCD signal) to come high. Say
  *	maybe because if we are clocal then we don't need to wait...
  */
@@ -2504,7 +2484,8 @@ static void stli_waituntilsent(struct tt
 	while (test_bit(ST_TXBUSY, &portp->state)) {
 		if (signal_pending(current))
 			break;
-		stli_delay(2);
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(2);
 		if (time_after_eq(jiffies, tend))
 			break;
 	}
_
