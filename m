Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275822AbRJBFzV>; Tue, 2 Oct 2001 01:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275825AbRJBFzM>; Tue, 2 Oct 2001 01:55:12 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:44713 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S275822AbRJBFzG>;
	Tue, 2 Oct 2001 01:55:06 -0400
Message-ID: <3BB956D3.AE0FCC54@candelatech.com>
Date: Mon, 01 Oct 2001 22:55:31 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org,
        kuznet@ms2.inr.ac.ru, Robert Olsson <Robert.Olsson@data.slu.se>,
        Ingo Molnar <mingo@elte.hu>, netdev@oss.sgi.com
Subject: Re: [announce] [patch] limiting IRQ load, irq-rewrite-2.4.11-B5
In-Reply-To: <20011001210445.D15341@redhat.com> <Pine.GSO.4.30.0110012127410.28105-100000@shell.cyberus.ca> <20011002011351.A20025@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

> You're missing the effect that irq throttling has: it results in a system
> that is effectively running in "polled" mode.  Information does get
> processed, and thruput remains high, it is just that some additional
> latency is found in operations.  Which is acceptable by definition as
> the system is under extreme load.

So, when you turn off the IRQs, are the drivers somehow made
aware of this so that they can go into polling mode?  That might
fix the 10ms latency/starvation problem that bothers me...

Assuming it is fairly easy to put a driver into polling mode, if
you are explicitly told to do so, maybe this generic IRQ coelescing
could be the thing that generically poked all drivers.  Drivers
that are too primitive to understand or deal with polling can just
wait their 10ms, but smarter ones will happily poll away untill told
not to by the IRQ load limiter...

> That information will eventually be picked up.  I doubt the extra latency
> will be of significant note.  If it is, you've got realtime concerns,
> which is not our goal to address at this time.

I'm more worried about dropped pkts.  If you can receive 10k packets per second,
then you can receive (lose) 100 packets in 10ms....

> 
> > and what is this "known safe limit"? ;->
> 
> It's system dependant.  It's load dependant.  For a short list of the number
> of factors that you have to include to compute this:
> 
>         - number of cycles userspace needs to run
>         - number of cache misses that userspace is forced to
>           incur due to irq handlers running
>         - amount of time to dedicate to the irq handler
>         - variance due to error path handling
>         - increased system cpu usage due to higher memory load
>         - front side bus speed of cpu
>         - speed of cpu
>         - length of cpu pipelines
>         - time spent waiting on io cycles
>         .....

Hopefully, at the very worst, you can have configurables like:
 - User-space responsiveness v/s kernel IRQ handling,
   range of 1 to 100, where 100 == userRules.
 - Latency: 1 who cares, so long as work happens, to 100: Fast and furious, or not at all.

In otherwords, for gods sake don't make me have to understand how my
cache and CPU pipeline works!! :)


- Another Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
