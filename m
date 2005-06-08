Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261405AbVFHQiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbVFHQiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 12:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbVFHQgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 12:36:50 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:55247 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261353AbVFHQes (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 12:34:48 -0400
Date: Wed, 08 Jun 2005 12:34:46 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc6-V0.7.47-29
In-reply-to: <20050608145922.GA32309@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@elte.hu>, Daniel Walker <dwalker@mvista.com>,
       Esben Nielsen <simlo@phys.au.dk>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Steven Rostedt <rostedt@goodmis.org>
Message-id: <200506081234.46429.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <20050607194119.GA11185@elte.hu>
 <200506081054.50001.gene.heskett@verizon.net> <20050608145922.GA32309@elte.hu>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 June 2005 10:59, Ingo Molnar wrote:
>* Gene Heskett <gene.heskett@verizon.net> wrote:
>> [root@coyote linux-2.6.12-rc6-RT-V0.7.47-30]# grep PREEMPT .config
>> # CONFIG_PREEMPT_NONE is not set
>> CONFIG_PREEMPT_VOLUNTARY=y
>> # CONFIG_PREEMPT_DESKTOP is not set
>> # CONFIG_PREEMPT_RT is not set
>> CONFIG_PREEMPT_SOFTIRQS=y
>> CONFIG_PREEMPT_HARDIRQS=y
>> # CONFIG_PREEMPT_BKL is not set
>>
>> Now, I note that going to the #2 mode (voluntary) turned off
>> threaded RCU's, so I'm going to leave that off and try a mode 3
>> again. BRB.
>
>please try mode 3 and disable softirq/hardirq threading. If that
> fixes things, could you check which of the two options
>(CONFIG_PREEMPT_SOFTIRQS or CONFIG_PREEMPT_HARDIRQS) causes which
> type of regression?

Ok, they are both off, mode 3 and no RCU threading:

[root@coyote linux-2.6.12-rc6-RT-V0.7.47-30]# grep PREEMPT .config
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT_DESKTOP=y
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT=y
# CONFIG_PREEMPT_SOFTIRQS is not set
# CONFIG_PREEMPT_HARDIRQS is not set
# CONFIG_PREEMPT_RCU is not set
CONFIG_PREEMPT_BKL=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_PREEMPT_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set


And tvtime seems normal.  However, when the video works (and this is a 
known seperate problem with the cx88 driver) then the audio is highly 
'aliased' making for very tinny sound until an internal restart with 
new stds (or 3, sometimes it comes back after a few seconds) is done.  
There is a cx88_video.c patch that went by a few days ago, but even 
thats not 100% "bulletproof" :-)

>> And that makes tvtime's video fail with a blue screen, audio ok..
>>
>> Mode 2, FWIW, makes for quite jerky card motions while playing
>> AisleRiot, the solitaire game.
>
>this doesnt happen on PREEMPT_DESKTOP or PREEMPT_RT?

Its subjectively better, but plain old rc6 is the best in this regard.  
And I note that as I play with the soft & hard irq threading off, in 
mode 3, it improves to be equ to rc6 after about 5 or 6 moves.  Like 
the cfq scheduler is dynamicly adjusting priorities or something.  
Thats my default scheduler for the last 2-3 months, should I be 
retrying the others?

On to make one with softirq threading turned on, BRB.
With this:
[root@coyote linux-2.6.12-rc6-RT-V0.7.47-30]# grep PREEMPT .config
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT_DESKTOP=y
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
# CONFIG_PREEMPT_HARDIRQS is not set
# CONFIG_PREEMPT_RCU is not set
CONFIG_PREEMPT_BKL=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_PREEMPT_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set

tvtime seems normal.  So for the next build, turn on 
CONFIG_PREEMPT_RCU=y for effects since I note that its turned on 
along with hardirq threading by CONFIG_PREEMPT_RT=y.  BRB (well, 15 
minutes by the time I reboot).

Speaking of reboot, I saw a 'failed to contact something' message go 
flying by in the shutdown phase the last time around this loop.

With:
[root@coyote linux-2.6.12-rc6-RT-V0.7.47-30]# grep PREEMPT .config
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT_DESKTOP=y
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_SOFTIRQS=y
# CONFIG_PREEMPT_HARDIRQS is not set
CONFIG_PREEMPT_RCU=y
CONFIG_PREEMPT_BKL=y
CONFIG_DEBUG_PREEMPT=y
CONFIG_PREEMPT_TRACE=y
# CONFIG_CRITICAL_PREEMPT_TIMING is not set

tvtime works ok with RCU threading on.

But a "service ntpd restart" which failed during the boot, failed the 
2nd time befrore I did the startx, and here's the 3rd restart:
[root@coyote linux-2.6.12-rc6-RT-V0.7.47-30]# service ntpd restart
Shutting down ntpd:                                        [  OK  ]
ntpd: Synchronizing with time server:                      [FAILED]
Starting ntpd:  -U ntp -p /var/run/ntpd.pid -g             [  OK  ]

According to the lights on the router, it pounded on the server about 
10 times at 1 second intervals before it output the failed message.

So we are flushing out some bugs here.  The missus just came back, 
she's been out to the sawbones with her emphesema so my playtime 
today is about used up.  Many thanks for the quick responses.
>
> Ingo

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
