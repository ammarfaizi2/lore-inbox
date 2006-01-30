Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWA3I5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWA3I5s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 03:57:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWA3I5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 03:57:48 -0500
Received: from ns2.suse.de ([195.135.220.15]:3033 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932140AbWA3I5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 03:57:48 -0500
Message-ID: <43DDD503.3060008@suse.de>
Date: Mon, 30 Jan 2006 09:57:39 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch] fix alarm() return value
Content-Type: multipart/mixed;
 boundary="------------040909010005020104010405"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040909010005020104010405
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

  Hi folks,

This patch fixes the alarm() system call return value.  The alarm(2)
syscall is supposed to return the reamining seconds.  The hrtimer
switchover broke this because the code tries to gather the remaining
time _after_ canceling the timer.  Trivial fix below.

Please apply,

  Gerd

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg

--------------040909010005020104010405
Content-Type: text/plain;
 name="fix-146142"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fix-146142"

Index: linux-2.6.15/kernel/itimer.c
===================================================================
--- linux-2.6.15.orig/kernel/itimer.c	2006-01-27 16:11:33.000000000 +0100
+++ linux-2.6.15/kernel/itimer.c	2006-01-27 17:01:54.000000000 +0100
@@ -151,12 +151,12 @@ int do_setitimer(int which, struct itime
 	switch (which) {
 	case ITIMER_REAL:
 		timer = &tsk->signal->real_timer;
-		hrtimer_cancel(timer);
 		if (ovalue) {
 			ovalue->it_value = itimer_get_remtime(timer);
 			ovalue->it_interval
 				= ktime_to_timeval(tsk->signal->it_real_incr);
 		}
+		hrtimer_cancel(timer);
 		tsk->signal->it_real_incr =
 			timeval_to_ktime(value->it_interval);
 		expires = timeval_to_ktime(value->it_value);

--------------040909010005020104010405--
