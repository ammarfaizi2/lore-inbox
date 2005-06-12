Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVFLBF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVFLBF3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 21:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVFLBF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 21:05:29 -0400
Received: from vms046pub.verizon.net ([206.46.252.46]:4758 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S261866AbVFLBFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 21:05:12 -0400
Date: Sat, 11 Jun 2005 21:05:10 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: [PATCH] local_irq_disable removal
In-reply-to: <1118534993.5593.175.camel@sdietrich-xp.vilm.net>
To: linux-kernel@vger.kernel.org
Message-id: <200506112105.11067.gene.heskett@verizon.net>
Organization: None, usuallly detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.44.0506111345400.12084-100000@dhcp153.mvista.com>
 <1118533485.13312.91.camel@tglx.tec.linutronix.de>
 <1118534993.5593.175.camel@sdietrich-xp.vilm.net>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 11 June 2005 20:09, Sven-Thorsten Dietrich wrote:
>On Sun, 2005-06-12 at 01:44 +0200, Thomas Gleixner wrote:
>> On Sat, 2005-06-11 at 13:51 -0700, Daniel Walker wrote:
>> > On Sat, 11 Jun 2005, Ingo Molnar wrote:
>> >
>> > Interesting .. So "cli" takes 7 cycles , "sti" takes 7 cycles.
>> > The current method does "lea" which takes 1 cycle, and "or"
>> > which takes 1 cycle. I'm not sure if there is any function call
>> > overhead .. So the soft replacment of cli/sti is 70% faster on a
>> > per instruction level .. So it's at least not any slower .. Does
>> > everyone agree on that?
>>
>> No, because x86 is not the whole universe
>
>Das Dehnt sich aus.
>
>Even if there is a case of minimal expansion in the overhead on some
>architecture, it may justify the effort for a certain class of
>applications which require known interrupt response latencies.
>
>The concept model here is, that you will have all interrupts running
> in threads, EXCEPT one or more SA_NODELAY real-time IRQs. Those
> RT-IRQs may be required to track satellites, manage I/O for a QOS
> or RF protocol stack, shut down a SAW, or a variety of RT-related
> services.

Lets add the operation of 4 or more stepper motors in real time for 
smaller milling machines.  There, the constraints are more related to 
maintaining a steady flow of step/direction data at high enough 
speeds to make a stepper, with 8 microsteps per step, and 240 steps 
per revolution, run smoothly at speeds up to say 20 kilohertz, or 50 
microseconds per step, maintaining that 50 microseconds plus or minus 
not more than 5 microseconds else the motors will start sounding 
ragged and stuttering.

That would correspond to (if my calculator's button pusher didn't 
screw up) 625 rpm at the motor shaft.  Thats faster than it would 
ever move while actually cutting, but would certainly be valuable in 
reaching the next point to start a fresh cut pass in a reasonable 
length of time.  Adeos is apparently able to do this now, given a rip 
snorter cpu of 2GHZ or more real clock speed.  Cutting the rep rate 
to 200 u-secs, cuts the motor speeds down into the 150 rpm range, but 
is then quite usable and the cpu has some time to do other things, 
like pay attention to the mouse and its clicks, or refresh the screen 
on a 500+ mhz box.  100 u-sec on a 1400 mhz Athlon, and the rest of 
the machine, while slow, is 100% usable.

These are the time constraints, generally speaking, it takes to run a 
small milling machine under the control of emc.  And this is the 
range we would expect for much of the machine controller world.

One of the complaints we (I at least) have in the adeos environment, 
is that the cpu is equally hogged, and the machine lags, full time 
even if the emc state is stopped.  This I think is an emc problem 
moreso than a kernel problem, in that emc should be capable of 
dynamicly adjusting the RT loops timeing, so that if the machine is 
in stop, the machine gives up its cpu to other tasks, making the 
machine much friendlier.  This is something needed by emc IMO, but 
the experts in emc may have other limits I don't know about.

Anyway, my $0.02 on the guaranteed 'deterministic' aspect of this.
Currently running V0.7.48-10 in mode 3 with hardirq threading turned 
off as turning it on still kills tvtimes video dma.  Its running 
quite decently in fact.

>The IRQ-disable-removal allows that the RT-IRQ encounters minimal
>delay.
>
>Often, that IRQ will also wake up a process, and that process may
> have some response-time constraints on it, as well.
>
>SO that's one model that is helped by this design.
>
>
>
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.35% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2005 by Maurice Eugene Heskett, all rights reserved.
