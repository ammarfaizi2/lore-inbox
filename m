Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbUBWTra (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 14:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbUBWTra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 14:47:30 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:38796 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262015AbUBWTrQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 14:47:16 -0500
Subject: [PATCH] linux-2.6.3_time-interpolator-fix_A0
From: john stultz <johnstul@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris McDermott <lcm@us.ibm.com>, ia64 <linux-ia64@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>,
       David Mosberger <davidm@hpl.hp.com>
In-Reply-To: <16435.3326.193311.110598@napali.hpl.hp.com>
References: <1077081648.985.27.camel@cog.beaverton.ibm.com>
	 <1077086574.985.56.camel@cog.beaverton.ibm.com>
	 <16435.3326.193311.110598@napali.hpl.hp.com>
Content-Type: text/plain
Message-Id: <1077565468.19860.78.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 23 Feb 2004 11:44:29 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Resending to Andrew and LKML]

All,
	In developing the ia64-cyclone patch, which implements a cyclone based
time interpolator, I found the following bug which could cause time
inconsistencies. 

In update_wall_time_one_tick(), which is called each timer interrupt, we
call time_interpolator_update(delta_nsec) where delta_nsec is
approximately NSEC_PER_SEC/HZ. This directly correlates with the changes
to xtime which occurs in update_wall_time_one_tick().

However in update_wall_time(), on a second overflow, we again call
time_interpolator_update(NSEC_PER_SEC). However while the components of
xtime are being changed, the overall value of xtime does not (nsec is
decremented NSEC_PER_SEC and sec is incremented).  Thus this call to
time_interpolator_update is incorrect.

This patch removes the incorrect call to time_interpolator_update and
was found to resolve the time inconsistencies I had seen while
developing the ia64-cyclone patch.

Please consider for inclusion.


diff -Nru a/kernel/timer.c b/kernel/timer.c
--- a/kernel/timer.c	Wed Feb 18 12:04:03 2004
+++ b/kernel/timer.c	Wed Feb 18 12:04:03 2004
@@ -677,7 +677,6 @@
 	if (xtime.tv_nsec >= 1000000000) {
 	    xtime.tv_nsec -= 1000000000;
 	    xtime.tv_sec++;
-	    time_interpolator_update(NSEC_PER_SEC);
 	    second_overflow();
 	}
 }


