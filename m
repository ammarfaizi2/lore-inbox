Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261815AbVCSVWK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261815AbVCSVWK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 16:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbVCSVWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 16:22:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:55504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261815AbVCSVWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 16:22:03 -0500
Date: Sat, 19 Mar 2005 13:21:34 -0800
From: Andrew Morton <akpm@osdl.org>
To: george@mvista.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clean up FIXME in do_timer_interrupt-lock fix
Message-Id: <20050319132134.5953f176.akpm@osdl.org>
In-Reply-To: <423BF1E6.9030902@mvista.com>
References: <1109869828.2908.18.camel@mindpipe>
	<20050303164520.0c0900df.akpm@osdl.org>
	<1109899148.3630.5.camel@mindpipe>
	<42283857.9050007@mvista.com>
	<1109968985.6710.16.camel@mindpipe>
	<4228CBFB.3000602@mvista.com>
	<1110313644.4600.13.camel@mindpipe>
	<422E33F0.6020403@mvista.com>
	<4230087E.3080307@mvista.com>
	<1110579830.19661.10.camel@mindpipe>
	<20050311143459.54c74dd0.akpm@osdl.org>
	<423BF1E6.9030902@mvista.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

George Anzinger <george@mvista.com> wrote:
>
> Did you pick this up?  First sent on 3-11.

I did, although now looking at it I have issues.

>  I was not happy with the locking on this.  Two changes:
>  1) Turn off irq while setting the clock.
>  2) Call the timer code only through the timer interface 
>     (set a short timer to do it from the ntp call).

I would consider this to be an inadequate description :(

>  Signed-off-by: George Anzinger <george@mvista.com>
> 
>   time.c |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
> 
>  Index: linux-2.6.12-rc/arch/i386/kernel/time.c
>  ===================================================================
>  --- linux-2.6.12-rc.orig/arch/i386/kernel/time.c
>  +++ linux-2.6.12-rc/arch/i386/kernel/time.c
>  @@ -176,12 +176,12 @@ static int set_rtc_mmss(unsigned long no
>   	int retval;
>   
>   	/* gets recalled with irq locally disabled */
>  -	spin_lock(&rtc_lock);
>  +	spin_lock_irq(&rtc_lock);
>   	if (efi_enabled)
>   		retval = efi_set_rtc_mmss(nowtime);
>   	else
>   		retval = mach_set_rtc_mmss(nowtime);
>  -	spin_unlock(&rtc_lock);
>  +	spin_unlock_irq(&rtc_lock);
>   
>   	return retval;
>   }

If the comment is correct, and this code is called with local irq's
disabled then this patch should be using spin_lock_irqsave()

>  @@ -338,7 +338,7 @@ static void sync_cmos_clock(unsigned lon
>   }
>   void notify_arch_cmos_timer(void)
>   {
>  -	sync_cmos_clock(0);
>  +	mod_timer(&sync_cmos_timer, jiffies + 1);
>   }
>   static long clock_cmos_diff, sleep_start;
>   

Your description says what this does, but it doesn't way why it was done?
