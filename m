Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbUJ0LWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbUJ0LWx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 07:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbUJ0LWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 07:22:53 -0400
Received: from gockel.physik3.uni-rostock.de ([139.30.44.16]:23266 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262390AbUJ0LU6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 07:20:58 -0400
Date: Wed, 27 Oct 2004 13:20:29 +0200 (CEST)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Strange IO behaviour on wakeup from sleep
In-Reply-To: <1098845804.606.4.camel@gaston>
Message-ID: <Pine.LNX.4.53.0410271308360.9839@gockel.physik3.uni-rostock.de>
References: <1098845804.606.4.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Oct 2004, Benjamin Herrenschmidt wrote:

> Not much datas at this point yet, but paulus and I noticed that current
> bk (happened already last saturday or so) has a very strange problem
> when waking up from sleep (suspend to ram) on our laptops.

It's a shot in the dark, but I am concerned whether timers continue to 
work correctly after suspend with the following patch from Linus' bk tree.
I think jiffies may not be set behind the back of the timer subsystem, but 
maybe it works if we can guarantee there are no timers scheduled.

It might be worth backing out and retesting.

Tim


  [PATCH] swsusp: fix process start times after resume

  http://linus.bkbits.net:8080/linux-2.5/cset@4174ae167_Yica8ChkiLcj_rmOcG1Q?nav=index.html|ChangeSet@-2w

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/10/18 23:03:02-07:00 pavel@ucw.cz
#   [PATCH] swsusp: fix process start times after resume
#   
#   Currently, process start times change after swsusp (because they are
#   derived from jiffies and current time, oops).  This should fix it.
#
#   Signed-off-by: Andrew Morton <akpm@osdl.org>
#   Signed-off-by: Linus Torvalds <torvalds@osdl.org>
#
# arch/i386/kernel/time.c
#   2004/10/18 22:26:45-07:00 pavel@ucw.cz +5 -1
#   swsusp: fix process start times after resume
#
diff -Nru a/arch/i386/kernel/time.c b/arch/i386/kernel/time.c
--- a/arch/i386/kernel/time.c	2004-10-27 03:58:08 -07:00
+++ b/arch/i386/kernel/time.c	2004-10-27 03:58:08 -07:00
@@ -319,7 +319,7 @@
 	return retval;
 }

-static long clock_cmos_diff;
+static long clock_cmos_diff, sleep_start;
 
 static int time_suspend(struct sys_device *dev, u32 state)
 {
@@ -328,6 +328,7 @@
 	 */
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
+	sleep_start = get_cmos_time();
 	return 0;
 }

@@ -335,10 +336,13 @@
 {
 	unsigned long flags;
 	unsigned long sec = get_cmos_time() + clock_cmos_diff;
+	unsigned long sleep_length = get_cmos_time() - sleep_start;
+
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
+	jiffies += sleep_length * HZ;
 	return 0;
 }

