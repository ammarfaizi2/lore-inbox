Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318097AbSGROgQ>; Thu, 18 Jul 2002 10:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318098AbSGROgQ>; Thu, 18 Jul 2002 10:36:16 -0400
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:44186 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S318097AbSGROgP>;
	Thu, 18 Jul 2002 10:36:15 -0400
Message-ID: <3D36D311.2030402@acm.org>
Date: Thu, 18 Jul 2002 09:39:13 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to make a kernel thread sleep for a short amount of time?
References: <3D24BC95.3030006@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am using high-res timers 
(http://sourceforge.net/projects/high-res-timers) in a driver to do 
sub-millisecond timing for a driver I am developing.  With high-res 
timers, I have some code that looks like:

#ifdef CONFIG_HIGH_RES_TIMERS
        /* If the state machine asks for a short delay, then shorten
           the timer timeout. */
        if (kcs_result == KCS_CALL_WITH_DELAY) {
                kcs_timer.sub_expires
                        += usec_to_arch_cycles(KCS_SHORT_TIMEOUT_USEC);
                while (kcs_timer.sub_expires >= cycles_per_jiffies) {
                        kcs_timer.expires++;
                        kcs_timer.sub_expires -= cycles_per_jiffies;
                }
        } else {
                kcs_timer.expires += KCS_TIMEOUT_JIFFIES;
         }
#else
        kcs_timer.expires += KCS_TIMEOUT_JIFFIES;
#endif

But the high-res timers are not in the kernel right now, it's a patch 
you have to add, and the user has to have it configured.

-Corey

Ben Greear wrote:

> I am re-working the net/core/pktgen code to be a kernel thread.
>
> It is basically working, but I am having trouble making the thread
> efficiently sleep for durations in the milisecond and micro-second range.
>
> I have looked at the udelay and mdelay methods, but they busy
> wait.
>
> I do not need absolute real-time precision, so if I ask the thread
> to sleep for 100 micro-seconds, it is not a big deal if it does
> not wake up for 5000us.  On average, it should be very close to 100us.
>
> I believe the answer may be to use some sort of timer and have my
> thread sleep on this timer, but I cannot find any examples or
> documentation on how to do this on the web.
>
> If anyone can point me to some example code or documentation, I
> would appreciate it.
>
> Thanks,
> Ben
>



