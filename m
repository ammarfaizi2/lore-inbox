Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264886AbTBTFe5>; Thu, 20 Feb 2003 00:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264903AbTBTFe5>; Thu, 20 Feb 2003 00:34:57 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1408 "EHLO
	bilbo.tmr.com") by vger.kernel.org with ESMTP id <S264886AbTBTFe4>;
	Thu, 20 Feb 2003 00:34:56 -0500
Date: Thu, 20 Feb 2003 00:44:55 -0500 (EST)
From: davidsen <root@tmr.com>
Reply-To: Bill Davidsen <davidsen@tmr.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] [2.5.61-ac1] set_rtc_mss back
In-Reply-To: <Pine.LNX.4.44.0302191658080.1167-100000@bilbo.tmr.com>
Message-ID: <Pine.LNX.4.44.0302200040040.1128-100000@bilbo.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2003, davidsen@tmr.com wrote:

> set_rtc_mmss: can't update from 5 to 55
> 
> I used to get this message in early 4.5.5x kernels, and there was some 
> discussion which I can't easily track right now, then it went away. This 
> system was up for 25 days on 2.5.59+patches, and the console showed none 
> of these since boot.

My bad, see below, I just lucked out not to boot at the wrong time, and 
after that the problem doesn't happen (or is unlikely).

> I just built 2.5.61-ac1 and booted. The good news is that it is up and 
> looks reasonably stable (rebuilt the kernel). Bad news is that this 
> message is coming out often enough to make the console hard to use.
> 
> No details, I assume that whatever fixed this before will fix it again, 
> just so someone knows it is happening again.

Okay, now I see what's happening. In arch/i386/kernel/time.c, the routine 
is far more limited than the comments admit. And the code tests for a 30 
minute change, while the comments only say 15.

Since the code change is complex, requiring backing the time over an hour 
and potentially date boundary, I just patch the comment to admit what's 
happening.

--- time.c.ORIG	Thu Feb 20 00:10:33 2003
+++ time.c	Thu Feb 20 00:32:37 2003
@@ -169,7 +169,10 @@
 	 * since we're only adjusting minutes and seconds,
 	 * don't interfere with hour overflow. This avoids
 	 * messing with unknown time zones but requires your
-	 * RTC not to be off by more than 15 minutes
+	 * RTC not to be off by more than 30 minutes. It also
+	 * will fail to set back the minutes over an hour boundary,
+	 * say from 1 to 59, even though that's only 2 minutes,
+	 * to avoid being off by an hour.
 	 */
 	real_seconds = nowtime % 60;
 	real_minutes = nowtime / 60;

-- 
bill davidsen, CTO TMR Associates, Inc <davidsen@tmr.com>
  Having the feature freeze for Linux 2.5 on Hallow'een is appropriate,
since using 2.5 kernels includes a lot of things jumping out of dark
corners to scare you.


