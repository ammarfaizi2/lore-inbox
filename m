Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271061AbUJUXXJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271061AbUJUXXJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271051AbUJUXXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 19:23:06 -0400
Received: from gprs214-34.eurotel.cz ([160.218.214.34]:54659 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S271114AbUJUXUq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 19:20:46 -0400
Date: Fri, 22 Oct 2004 01:20:17 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michal Semler <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hibernation and time and dhcp
Message-ID: <20041021232017.GA7260@elf.ucw.cz>
References: <200410202045.24388.cijoml@volny.cz> <20041021230151.GA24980@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041021230151.GA24980@elf.ucw.cz>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > with 2.6.9 hibernation to disk finally works! Thanks
> > To ram it still don't work, system starts with lcd disabled - but it is 
> > another story.
> > 
> > I have now this problem - when I hibernate and then system is started up in 
> > other company, it don't update time and shows still for example 14:00 - when 
> > I rehibernate for example in 20:00 - could you ask bios for current time? 
> > It's better to have bad time about few seconds instead of hours.
> > 
> > Same problem with dhcp - it should ask for IP when rehibernate.
> 
> Known bug and I posted patch at least to acpi list few hours ago.

Here it is...

							Pavel

--- clean/arch/i386/kernel/time.c	2004-10-01 00:29:59.000000000 +0200
+++ linux/arch/i386/kernel/time.c	2004-10-19 15:16:14.000000000 +0200
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
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
