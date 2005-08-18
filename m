Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVHRFNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVHRFNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 01:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVHRFNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 01:13:25 -0400
Received: from siaag2ag.compuserve.com ([149.174.40.140]:18877 "EHLO
	siaag2ag.compuserve.com") by vger.kernel.org with ESMTP
	id S1750709AbVHRFNY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 01:13:24 -0400
Date: Thu, 18 Aug 2005 01:09:40 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc6] watchdog: fix oops in softdog driver
To: Wim Van Sebroeck <wim@iguana.be>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200508180113_MC3-1-A77D-A127@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wim,
  The softdog watchdog timer has a bug that can create an oops:

  1.  Load the module without the nowayout option.
  2.  Open the driver and close it without writing 'V' before close.
  3.  Unload the module.  The timer will continue to run...
  4.  Oops happens when timer fires.

  Reported Sun, 10 Oct 2004, by Michael Schierl <schierlm@gmx.de>

  Fix is easy: always take a reference on the module on open.
Release it only when the device is closed and no timer is running.
Tested on 2.6.13-rc6 using the soft_noboot option.  While the
timer is running and the device is closed, the module use count
stays at 1.  After the timer fires, it drops to 0.  Repeatedly
opening and closing the driver caused no problems.  Please apply.


Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 drivers/char/watchdog/softdog.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

--- 2.6.13-rc6c.orig/drivers/char/watchdog/softdog.c
+++ 2.6.13-rc6c/drivers/char/watchdog/softdog.c
@@ -77,7 +77,7 @@ static void watchdog_fire(unsigned long)
 
 static struct timer_list watchdog_ticktock =
 		TIMER_INITIALIZER(watchdog_fire, 0, 0);
-static unsigned long timer_alive;
+static unsigned long driver_open, orphan_timer;
 static char expect_close;
 
 
@@ -87,6 +87,9 @@ static char expect_close;
 
 static void watchdog_fire(unsigned long data)
 {
+	if (test_and_clear_bit(0, &orphan_timer))
+		module_put(THIS_MODULE);
+
 	if (soft_noboot)
 		printk(KERN_CRIT PFX "Triggered - Reboot ignored.\n");
 	else
@@ -128,9 +131,9 @@ static int softdog_set_heartbeat(int t)
 
 static int softdog_open(struct inode *inode, struct file *file)
 {
-	if(test_and_set_bit(0, &timer_alive))
+	if (test_and_set_bit(0, &driver_open))
 		return -EBUSY;
-	if (nowayout)
+	if (!test_and_clear_bit(0, &orphan_timer))
 		__module_get(THIS_MODULE);
 	/*
 	 *	Activate timer
@@ -147,11 +150,13 @@ static int softdog_release(struct inode 
 	 */
 	if (expect_close == 42) {
 		softdog_stop();
+		module_put(THIS_MODULE);
 	} else {
 		printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
+		set_bit(0, &orphan_timer);
 		softdog_keepalive();
 	}
-	clear_bit(0, &timer_alive);
+	clear_bit(0, &driver_open);
 	expect_close = 0;
 	return 0;
 }
__
Chuck
