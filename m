Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261539AbVALWyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261539AbVALWyV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbVALWwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:52:06 -0500
Received: from gprs214-252.eurotel.cz ([160.218.214.252]:51628 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261527AbVALWub (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:50:31 -0500
Date: Wed, 12 Jan 2005 23:50:11 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Shawn Starr <shawn.starr@rogers.com>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.10][Suspend] - Time problems
Message-ID: <20050112225011.GQ1408@elf.ucw.cz>
References: <200501110235.37039.shawn.starr@rogers.com> <20050112222400.GA2139@elf.ucw.cz> <200501122344.11508.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501122344.11508.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > When resuming from suspend, I noticed the clock is waay off (its 10:16pm, 
> it 
> > > shows 2:34AM EST time). This is even after a reboot the bios now shows 
> wrong 
> > > time?
> > 
> > Yes, see for example thread "2.6.10-mm2: swsusp regression
> > [update]". Nigel has some patch that should fix it...
> 
> Do you mean patches in the "[RFC] Patches to reduce delay in 
> arch/kernel/time.c" thread?

I meant this one... (cut&pasted, apply by hand). But it seems to be
included in 2.6.11-rc1. I'm now confused.
								Pavel

diff -ruNp 910-original-time-patch-old/arch/i386/kernel/time.c
910-original-time-patch-new/arch/i386/kernel/time.c
--- 910-original-time-patch-old/arch/i386/kernel/time.c 2004-12-27
+++ 910-original-time-patch-new/arch/i386/kernel/time.c 2005-01-08
@@ -343,12 +343,13 @@ static int timer_resume(struct sys_devic
                hpet_reenable();
 #endif
        sec = get_cmos_time() + clock_cmos_diff;
-       sleep_length = get_cmos_time() - sleep_start;
+       sleep_length = (get_cmos_time() - sleep_start) * HZ;
        write_seqlock_irqsave(&xtime_lock, flags);
        xtime.tv_sec = sec;
        xtime.tv_nsec = 0;
        write_sequnlock_irqrestore(&xtime_lock, flags);
-       jiffies += sleep_length * HZ;
+       jiffies += sleep_length;
+       wall_jiffies += sleep_length;
        return 0;
 }


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
