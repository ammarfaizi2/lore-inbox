Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261523AbVACTEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261523AbVACTEN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jan 2005 14:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVACTBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jan 2005 14:01:31 -0500
Received: from gprs214-42.eurotel.cz ([160.218.214.42]:28033 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261617AbVACRfH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jan 2005 12:35:07 -0500
Date: Mon, 3 Jan 2005 18:34:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org, plazmcman@softhome.net
Subject: Re: Screwy clock after apm suspend
Message-ID: <20050103173428.GA10065@elf.ucw.cz>
References: <200412291138.iBTBcbw6023631@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412291138.iBTBcbw6023631@harpo.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >2.6.10 screws up my system clock.
> >Two kernel/hardware clock readings, before and after suspend.
> >-------------
> >plaz@gonzo:~$ date ;hwclock
> >Tue Dec 28 15:52:39 PST 2004
> >Tue Dec 28 14:54:07 2004 -0.503621 seconds
> >#suspend, resume
> >plaz@gonzo:~$ date ;hwclock
> >Tue Dec 28 16:11:58 PST 2004
> >Tue Dec 28 15:04:06 2004 -0.168262 seconds
> ...
> >I did not have this problem with 2.6.9. My machine uses APM, clock 
> >stores local time (specified in kernel config). I use PIT for 
> >timesource, as others were losing ticks when on battery power (changes 
> >CPU clock speed). Again, did _not_ have this problem with 2.6.9.
> 
> I reported this problem a while ago for 2.6.10-rc1:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110172841429272&w=2.
> At the time I thought the APM daemon's hwclock --hctosys at resume
> might be in conflict with the kernel change, but I've since disabled
> that and it didn't solve the problem.
> 
> For now, I'm using the patch below to revert the i386 time.c's
> behaviour to what it was before the broken change in 2.6.10-rc1.


Hmm, this will break time on ACPI systems :-(. Perhaps what we want is
equivalent of hwclock --hctosys here?

> --- linux-2.6.10/arch/i386/kernel/time.c.~1~	2004-12-25 12:16:17.000000000 +0100
> +++ linux-2.6.10/arch/i386/kernel/time.c	2004-12-25 23:56:19.000000000 +0100
> @@ -319,7 +319,7 @@ unsigned long get_cmos_time(void)
>  	return retval;
>  }
>  
> -static long clock_cmos_diff, sleep_start;
> +static long clock_cmos_diff;
>  
>  static int timer_suspend(struct sys_device *dev, u32 state)
>  {
> @@ -328,7 +328,6 @@ static int timer_suspend(struct sys_devi
>  	 */
>  	clock_cmos_diff = -get_cmos_time();
>  	clock_cmos_diff += get_seconds();
> -	sleep_start = get_cmos_time();
>  	return 0;
>  }
>  
> @@ -336,19 +335,16 @@ static int timer_resume(struct sys_devic
>  {
>  	unsigned long flags;
>  	unsigned long sec;
> -	unsigned long sleep_length;
>  
>  #ifdef CONFIG_HPET_TIMER
>  	if (is_hpet_enabled())
>  		hpet_reenable();
>  #endif
>  	sec = get_cmos_time() + clock_cmos_diff;
> -	sleep_length = get_cmos_time() - sleep_start;
>  	write_seqlock_irqsave(&xtime_lock, flags);
>  	xtime.tv_sec = sec;
>  	xtime.tv_nsec = 0;
>  	write_sequnlock_irqrestore(&xtime_lock, flags);
> -	jiffies += sleep_length * HZ;
>  	return 0;

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
