Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269769AbUJMX7r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269769AbUJMX7r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 19:59:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269770AbUJMX7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 19:59:47 -0400
Received: from siaag1aa.compuserve.com ([149.174.40.3]:59602 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S269769AbUJMX7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 19:59:41 -0400
Date: Wed, 13 Oct 2004 19:55:39 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] softdog.c (was: Kernel panic after rmmod softdog
  (2.6.8.1))
To: Arnd Bergmann <arnd@arndb.de>
Cc: Michael Schierl <schierlm@gmx.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Message-ID: <200410131959_MC3-1-8C24-188B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann wrote:

> Now if you do open(), close(), open(), write("V"), close(), the module
> becomes unremovable, even without nowayout=1. Isn't is possible to
> simply add a softdog_stop() call to watchdog_exit()?

  Oh well, at least it can't possibly oops since you can't even remove it.  :)

  How about this instead?

  (Assuming a re-open of the softdog device is allowable; I don't see why not.)

--- linux-2.6.8.1/drivers/char/watchdog/softdog.c.orig  Sun Oct 10 23:08:24 2004
+++ linux-2.6.8.1/drivers/char/watchdog/softdog.c       Wed Oct 13 14:48:20 2004
@@ -82,9 +82,12 @@
 
 static struct timer_list watchdog_ticktock =
                TIMER_INITIALIZER(watchdog_fire, 0, 0);
-static unsigned long timer_alive;
 static char expect_close;
 
+static unsigned long driver_status;
+/* Driver status bits  */
+#define SOFTDOG_TIMER_RUNNING  0
+#define SOFTDOG_DEVICE_OPEN    1
 
 /*
  *     If the timer expires..
@@ -133,9 +136,10 @@
 
 static int softdog_open(struct inode *inode, struct file *file)
 {
-       if(test_and_set_bit(0, &timer_alive))
+       if (test_and_set_bit(SOFTDOG_DEVICE_OPEN, &driver_status))
                return -EBUSY;
-       if (nowayout)
+
+       if ( !test_and_set_bit(SOFTDOG_TIMER_RUNNING, &driver_status))
                __module_get(THIS_MODULE);
        /*
         *      Activate timer
@@ -152,11 +156,13 @@
         */
        if (expect_close == 42) {
                softdog_stop();
+               clear_bit(SOFTDOG_TIMER_RUNNING, &driver_status);
+               module_put(THIS_MODULE);
        } else {
                printk(KERN_CRIT PFX "Unexpected close, not stopping watchdog!\n");
                softdog_keepalive();
        }
-       clear_bit(0, &timer_alive);
+       clear_bit(SOFTDOG_DEVICE_OPEN, &driver_status);
        expect_close = 0;
        return 0;
 }

--Chuck Ebbert  13-Oct-04  19:55:30
