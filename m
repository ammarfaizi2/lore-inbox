Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263772AbTJ0XpT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:45:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTJ0XpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:45:19 -0500
Received: from users.ccur.com ([208.248.32.211]:44451 "HELO rudolph.ccur.com")
	by vger.kernel.org with SMTP id S263772AbTJ0Xo6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:44:58 -0500
Date: Mon, 27 Oct 2003 18:44:47 -0500
From: Joe Korty <joe.korty@ccur.com>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: gettimeofday resolution seriously degraded in test9
Message-ID: <20031027234447.GA7417@rudolph.ccur.com>
Reply-To: Joe Korty <joe.korty@ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ 2nd posting, the first seems to have been lost ]

Linus,
 This bit of -test9 code reduces the resolution of gettimeofday(2) from
1 microsecond to 1 millisecond whenever a negative time adjustment is
in progress.  This seriously damages efforts to measure time intervals
accurately with gettimeofday.  Please consider backing it out.

Joe


diff -Nura linux-2.6.0-test8/arch/i386/kernel/time.c linux-2.6.0-test9/arch/i386/kernel/time.c
--- linux-2.6.0-test8/arch/i386/kernel/time.c	2003-10-17 17:43:11.000000000 -0400
+++ linux-2.6.0-test9/arch/i386/kernel/time.c	2003-10-25 14:43:37.000000000 -0400
@@ -104,6 +104,15 @@
 		lost = jiffies - wall_jiffies;
 		if (lost)
 			usec += lost * (1000000 / HZ);
+
+		/*
+		 * If time_adjust is negative then NTP is slowing the clock
+		 * so make sure not to go into next possible interval.
+		 * Better to lose some accuracy than have time go backwards..
+		 */
+		if (unlikely(time_adjust < 0) && usec > tickadj)
+			usec = tickadj;
+
 		sec = xtime.tv_sec;
 		usec += (xtime.tv_nsec / 1000);
 	} while (read_seqretry(&xtime_lock, seq));



