Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbWDSQNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbWDSQNf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbWDSQNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:13:35 -0400
Received: from gold.veritas.com ([143.127.12.110]:64562 "EHLO gold.veritas.com")
	by vger.kernel.org with ESMTP id S1750730AbWDSQNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:13:34 -0400
X-IronPort-AV: i="4.04,136,1144047600"; 
   d="scan'208"; a="58696097:sNHT31035356"
Date: Wed, 19 Apr 2006 17:13:27 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
cc: Jeff Garzik <jeff@garzik.org>, Matt Mackall <mpm@selenic.com>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: sata suspend resume ...
In-Reply-To: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
Message-ID: <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 19 Apr 2006 16:13:34.0169 (UTC) FILETIME=[35151490:01C663CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006, Jeff Chua wrote:
> 
> Any change of getting suspend/resume to work on my IBM X60s notebook.
> 
> Disk model is ...
> 
> 	MODEL="ATA HTS541060G9SA00"
> 	FW_REV="MB3I"
> 
> Linux 2.6.17-rc2.
> 
> System suspends ok. Resume ok. but no disk access after that.

Not the same disk model, but I've been having similar trouble on a T43p.

I was delighted to see the MSI suspend/resume fix go into 2.6.17-rc2,
but then disappointed.  A bisection found that Matt Mackall's sensible
rc1 patch, to speed up get_cmos_time, has removed what often used to be
a 2 second delay in resuming: things work well when I reinstate that
delay (1 second has proved not enough).  Below is the patch I'm using -
where I've failed to resist mucking around to avoid those double calls
to get_cmos_time, sorry: really it's just mdelay(2000) needed somewhere
(until someone who knows puts in something more scientific).

Your problem, of course, is quite likely to be something else entirely;
but I thought I ought to speak up, in case it does help.

Hugh

--- 2.6.17-rc2/arch/i386/kernel/time.c	2006-03-20 05:53:29.000000000 +0000
+++ linux/arch/i386/kernel/time.c	2006-04-19 09:56:02.000000000 +0100
@@ -379,6 +379,7 @@ void notify_arch_cmos_timer(void)
 }
 
 static long clock_cmos_diff, sleep_start;
+unsigned long resume_mdelay = 2000;
 
 static struct timer_opts *last_timer;
 static int timer_suspend(struct sys_device *dev, pm_message_t state)
@@ -386,9 +387,8 @@ static int timer_suspend(struct sys_devi
 	/*
 	 * Estimate time zone so that set_time can update the clock
 	 */
-	clock_cmos_diff = -get_cmos_time();
-	clock_cmos_diff += get_seconds();
 	sleep_start = get_cmos_time();
+	clock_cmos_diff = get_seconds() - sleep_start;
 	last_timer = cur_timer;
 	cur_timer = &timer_none;
 	if (last_timer->suspend)
@@ -407,10 +407,11 @@ static int timer_resume(struct sys_devic
 		hpet_reenable();
 #endif
 	setup_pit_timer();
-	sec = get_cmos_time() + clock_cmos_diff;
-	sleep_length = (get_cmos_time() - sleep_start) * HZ;
+	mdelay(resume_mdelay);
+	sec = get_cmos_time();
+	sleep_length = (sec - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
-	xtime.tv_sec = sec;
+	xtime.tv_sec = clock_cmos_diff + sec;
 	xtime.tv_nsec = 0;
 	jiffies_64 += sleep_length;
 	wall_jiffies += sleep_length;
