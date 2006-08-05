Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932637AbWHEWAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932637AbWHEWAL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 18:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932642AbWHEWAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 18:00:11 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:51669 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932637AbWHEWAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 18:00:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=J3UMTyPUFssdZlLOkQs8wa36M9yaUIxIgqDPIVcVKbn1dlmYn8pxo1wYbcXPe5d/p4Z+3/K+qBbkBaFiADmrsz/T1AGSpQxroHhZMmNvfDOJZNDw5Z9k44b7we2vqPgrkwrpr98aej+TrJ9sRO8farVZqtLemuvW6OfskR7V820=
Date: Sat, 5 Aug 2006 17:59:34 -0400
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Joseph Fannin <jfannin@gmail.com>,
       linux-kernel@vger.kernel.org, arjan@infradead.org,
       John Stultz <johnstul@us.ibm.com>
Subject: Re: [patch] lockdep: HPET/RTC fix
Message-ID: <20060805215934.GA8624@palmyra>
Mail-Followup-To: Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@osdl.org>, Joseph Fannin <jfannin@gmail.com>,
	linux-kernel@vger.kernel.org, arjan@infradead.org,
	John Stultz <johnstul@us.ibm.com>
References: <20060709050525.GA1149@nineveh.rivenstone.net> <20060708232512.12b59269.akpm@osdl.org> <20060709074543.GA4444@elte.hu> <20060711051108.GA13574@nineveh.rivenstone.net> <20060711074541.GA5263@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711074541.GA5263@elte.hu>
User-Agent: Mutt/1.5.11
From: jfannin@gmail.com (Joseph Fannin)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 09:45:41AM +0200, Ingo Molnar wrote:

    [Apologies for the very slow turn-around time on this.  If patches
are written in the relatively-near future, I will test and report in a
more timely manner.]

> Subject: lockdep: HPET/RTC fix
> From: Ingo Molnar <mingo@elte.hu>
>
> Joseph Fannin reported that hpet_rtc_interrupt() enables hardirqs
> in irq context:

> --- linux.orig/drivers/char/rtc.c
> +++ linux/drivers/char/rtc.c
> @@ -1222,7 +1222,7 @@ static int rtc_proc_open(struct inode *i
>
>  void rtc_get_rtc_time(struct rtc_time *rtc_tm)
>  {
> -	unsigned long uip_watchdog = jiffies;
> +	unsigned long uip_watchdog = jiffies, flags;
>  	unsigned char ctrl;
>  #ifdef CONFIG_MACH_DECSTATION
>  	unsigned int real_year;
> @@ -1249,7 +1249,7 @@ void rtc_get_rtc_time(struct rtc_time *r
>  	 * RTC has RTC_DAY_OF_WEEK, we should usually ignore it, as it is
>  	 * only updated by the RTC when initially set to a non-zero value.
>  	 */
> -	spin_lock_irq(&rtc_lock);
> +	spin_lock_irqsave(&rtc_lock, flags);
>  	rtc_tm->tm_sec = CMOS_READ(RTC_SECONDS);
>  	rtc_tm->tm_min = CMOS_READ(RTC_MINUTES);
>  	rtc_tm->tm_hour = CMOS_READ(RTC_HOURS);
> @@ -1263,7 +1263,7 @@ void rtc_get_rtc_time(struct rtc_time *r
>  	real_year = CMOS_READ(RTC_DEC_YEAR);
>  #endif
>  	ctrl = CMOS_READ(RTC_CONTROL);
> -	spin_unlock_irq(&rtc_lock);
> +	spin_unlock_irqrestore(&rtc_lock, flags);
>
>  	if (!(ctrl & RTC_DM_BINARY) || RTC_ALWAYS_BCD)
>  	{


    It seems this isn't enough:

[   22.504000] EXT3 FS on sda3, internal journal
[   22.892000] BUG: warning at kernel/lockdep.c:1803/trace_hardirqs_on()
[   22.892000]  [<c0104880>] show_trace_log_lvl+0x1a0/0x1d0
[   22.892000]  [<c0105a7b>] show_trace+0x1b/0x20
[   22.892000]  [<c0105aa4>] dump_stack+0x24/0x30
[   22.892000]  [<c01451e4>] trace_hardirqs_on+0xf4/0x180
[   22.892000]  [<c032e431>] _spin_unlock_irq+0x31/0x60
[   22.892000]  [<c0278a64>] rtc_get_rtc_time+0x44/0x1a0
[   22.892000]  [<c0118742>] hpet_rtc_interrupt+0x152/0x1b0
[   22.892000]  [<c015bb51>] handle_IRQ_event+0x31/0x70
[   22.892000]  [<c015bc29>] __do_IRQ+0x99/0x110
[   22.892000]  [<c0105ef7>] do_IRQ+0x47/0xa0
[   22.892000]  [<c0103eed>] common_interrupt+0x25/0x2c
[   22.892000]  [<c032f902>] do_page_fault+0x82/0x630
[   22.892000]  [<c0104085>] error_code+0x39/0x40
[   22.892000]  [<b7e8d060>] 0xb7e8d060
[   22.892000]  [<c0105a7b>] show_trace+0x1b/0x20
[   22.892000]  [<c0105aa4>] dump_stack+0x24/0x30
[   22.892000]  [<c01451e4>] trace_hardirqs_on+0xf4/0x180
[   22.892000]  [<c032e431>] _spin_unlock_irq+0x31/0x60
[   22.892000]  [<c0278a64>] rtc_get_rtc_time+0x44/0x1a0
[   22.892000]  [<c0118742>] hpet_rtc_interrupt+0x152/0x1b0
[   22.892000]  [<c015bb51>] handle_IRQ_event+0x31/0x70
[   22.892000]  [<c015bc29>] __do_IRQ+0x99/0x110
[   22.892000]  [<c0105ef7>] do_IRQ+0x47/0xa0
[   22.892000]  [<c0103eed>] common_interrupt+0x25/0x2c
[   22.892000]  [<c0104085>] error_code+0x39/0x40

    This is from 2.6.18-rc3, but it's reproducable with pretty much
any kernel (the -rc3 backtrace is longer, it seems).

    Should I file this in Bugzilla?

--
Joseph Fannin
jfannin@gmail.com
