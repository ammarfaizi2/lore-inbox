Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261342AbUL2Liw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261342AbUL2Liw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Dec 2004 06:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbUL2Liw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Dec 2004 06:38:52 -0500
Received: from aun.it.uu.se ([130.238.12.36]:4302 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261342AbUL2Lit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Dec 2004 06:38:49 -0500
Date: Wed, 29 Dec 2004 12:38:37 +0100 (MET)
Message-Id: <200412291138.iBTBcbw6023631@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: linux-kernel@vger.kernel.org, plazmcman@softhome.net
Subject: Re: Screwy clock after apm suspend
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004 16:29:44 -0800, Brannon Klopfer wrote:
>2.6.10 screws up my system clock.
>Two kernel/hardware clock readings, before and after suspend.
>-------------
>plaz@gonzo:~$ date ;hwclock
>Tue Dec 28 15:52:39 PST 2004
>Tue Dec 28 14:54:07 2004 -0.503621 seconds
>#suspend, resume
>plaz@gonzo:~$ date ;hwclock
>Tue Dec 28 16:11:58 PST 2004
>Tue Dec 28 15:04:06 2004 -0.168262 seconds
...
>I did not have this problem with 2.6.9. My machine uses APM, clock 
>stores local time (specified in kernel config). I use PIT for 
>timesource, as others were losing ticks when on battery power (changes 
>CPU clock speed). Again, did _not_ have this problem with 2.6.9.

I reported this problem a while ago for 2.6.10-rc1:
http://marc.theaimsgroup.com/?l=linux-kernel&m=110172841429272&w=2.
At the time I thought the APM daemon's hwclock --hctosys at resume
might be in conflict with the kernel change, but I've since disabled
that and it didn't solve the problem.

For now, I'm using the patch below to revert the i386 time.c's
behaviour to what it was before the broken change in 2.6.10-rc1.

/Mikael

--- linux-2.6.10/arch/i386/kernel/time.c.~1~	2004-12-25 12:16:17.000000000 +0100
+++ linux-2.6.10/arch/i386/kernel/time.c	2004-12-25 23:56:19.000000000 +0100
@@ -319,7 +319,7 @@ unsigned long get_cmos_time(void)
 	return retval;
 }
 
-static long clock_cmos_diff, sleep_start;
+static long clock_cmos_diff;
 
 static int timer_suspend(struct sys_device *dev, u32 state)
 {
@@ -328,7 +328,6 @@ static int timer_suspend(struct sys_devi
 	 */
 	clock_cmos_diff = -get_cmos_time();
 	clock_cmos_diff += get_seconds();
-	sleep_start = get_cmos_time();
 	return 0;
 }
 
@@ -336,19 +335,16 @@ static int timer_resume(struct sys_devic
 {
 	unsigned long flags;
 	unsigned long sec;
-	unsigned long sleep_length;
 
 #ifdef CONFIG_HPET_TIMER
 	if (is_hpet_enabled())
 		hpet_reenable();
 #endif
 	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = get_cmos_time() - sleep_start;
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec = sec;
 	xtime.tv_nsec = 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
-	jiffies += sleep_length * HZ;
 	return 0;
 }
 
