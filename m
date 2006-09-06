Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWIFLYh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWIFLYh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 07:24:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWIFLYh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 07:24:37 -0400
Received: from host-84-9-200-167.bulldogdsl.com ([84.9.200.167]:15712 "EHLO
	aeryn.fluff.org.uk") by vger.kernel.org with ESMTP id S1750806AbWIFLYg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 07:24:36 -0400
Date: Wed, 6 Sep 2006 12:24:35 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: linux-kernel@vger.kernel.org, wim@iguana.be
Subject: [PATCH] S3C24XX: Fix watchdog driver way-out path
Message-ID: <20060906112435.GA23384@home.fluff.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

If the driver is not configured for `no way out`,
then the open method should not automatically allow
the setting of allow_close to CLOSE_STATE_ALLOW.

The setting of allow_close nullifies the use of
the magic close via the write path. It means that
in the default state, the watchdog will shut-down
even if the magic close has not been issued.

Signed-off-by: Ben Dooks <ben-linux@fluff.org>


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2618-rc6-wdog-wayout-fix.patch"

diff -urpN -X ../dontdiff linux-2.6.18-rc5-s3c2412-r5/drivers/char/watchdog/s3c2410_wdt.c linux-2.6.18-rc5-s3c2412-r6/drivers/char/watchdog/s3c2410_wdt.c
--- linux-2.6.18-rc5-s3c2412-r5/drivers/char/watchdog/s3c2410_wdt.c	2006-08-31 10:13:07.000000000 +0100
+++ linux-2.6.18-rc5-s3c2412-r6/drivers/char/watchdog/s3c2410_wdt.c	2006-09-06 12:09:49.000000000 +0100
@@ -62,7 +62,7 @@
 #define CONFIG_S3C2410_WATCHDOG_ATBOOT		(0)
 #define CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME	(15)
 
-static int nowayout = WATCHDOG_NOWAYOUT;
+static int nowayout	= WATCHDOG_NOWAYOUT;
 static int tmr_margin	= CONFIG_S3C2410_WATCHDOG_DEFAULT_TIME;
 static int tmr_atboot	= CONFIG_S3C2410_WATCHDOG_ATBOOT;
 static int soft_noboot	= 0;
@@ -213,11 +213,10 @@ static int s3c2410wdt_open(struct inode 
 	if(down_trylock(&open_lock))
 		return -EBUSY;
 
-	if (nowayout) {
+	if (nowayout)
 		__module_get(THIS_MODULE);
-	} else {
-		allow_close = CLOSE_STATE_ALLOW;
-	}
+
+	allow_close = CLOSE_STATE_NOT;
 
 	/* start the timer */
 	s3c2410wdt_start();
@@ -230,6 +229,7 @@ static int s3c2410wdt_release(struct ino
 	 *	Shut off the timer.
 	 * 	Lock it in if it's a module and we set nowayout
 	 */
+
 	if (allow_close == CLOSE_STATE_ALLOW) {
 		s3c2410wdt_stop();
 	} else {

--lrZ03NoBR/3+SXJZ--
