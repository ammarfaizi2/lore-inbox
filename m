Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWDTNZy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWDTNZy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWDTNZy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:25:54 -0400
Received: from outgoing2.smtp.agnat.pl ([193.239.44.84]:62212 "EHLO
	outgoing2.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1750936AbWDTNZx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:25:53 -0400
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: sata suspend resume ...
Date: Thu, 20 Apr 2006 15:25:20 +0200
User-Agent: KMail/1.9.1
Cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, Jeff Garzik <jeff@garzik.org>,
       Matt Mackall <mpm@selenic.com>, Jens Axboe <axboe@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0604192324040.29606@indiana.corp.fedex.com> <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0604191659230.7660@blonde.wat.veritas.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200604201525.20484.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 19 April 2006 18:13, Hugh Dickins wrote:

> A bisection found that Matt Mackall's sensible
> rc1 patch, to speed up get_cmos_time, has removed what often used to be
> a 2 second delay in resuming: things work well when I reinstate that
> delay (1 second has proved not enough).  Below is the patch I'm using -
> where I've failed to resist mucking around to avoid those double calls
> to get_cmos_time, sorry: really it's just mdelay(2000) needed somewhere
> (until someone who knows puts in something more scientific).

FYI: I've started using 2.6.17rc2 + that patch and now resume (from suspend to 
ram) works well on ThinkPad Z60m! (so far several suspend/resume cycles)


> Hugh
>
> --- 2.6.17-rc2/arch/i386/kernel/time.c	2006-03-20 05:53:29.000000000 +0000
> +++ linux/arch/i386/kernel/time.c	2006-04-19 09:56:02.000000000 +0100
> @@ -379,6 +379,7 @@ void notify_arch_cmos_timer(void)
>  }
>
>  static long clock_cmos_diff, sleep_start;
> +unsigned long resume_mdelay = 2000;
>
>  static struct timer_opts *last_timer;
>  static int timer_suspend(struct sys_device *dev, pm_message_t state)
> @@ -386,9 +387,8 @@ static int timer_suspend(struct sys_devi
>  	/*
>  	 * Estimate time zone so that set_time can update the clock
>  	 */
> -	clock_cmos_diff = -get_cmos_time();
> -	clock_cmos_diff += get_seconds();
>  	sleep_start = get_cmos_time();
> +	clock_cmos_diff = get_seconds() - sleep_start;
>  	last_timer = cur_timer;
>  	cur_timer = &timer_none;
>  	if (last_timer->suspend)
> @@ -407,10 +407,11 @@ static int timer_resume(struct sys_devic
>  		hpet_reenable();
>  #endif
>  	setup_pit_timer();
> -	sec = get_cmos_time() + clock_cmos_diff;
> -	sleep_length = (get_cmos_time() - sleep_start) * HZ;
> +	mdelay(resume_mdelay);
> +	sec = get_cmos_time();
> +	sleep_length = (sec - sleep_start) * HZ;
>  	write_seqlock_irqsave(&xtime_lock, flags);
> -	xtime.tv_sec = sec;
> +	xtime.tv_sec = clock_cmos_diff + sec;
>  	xtime.tv_nsec = 0;
>  	jiffies_64 += sleep_length;
>  	wall_jiffies += sleep_length;


-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
