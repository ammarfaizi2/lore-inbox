Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269615AbUJUNSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269615AbUJUNSy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 09:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268594AbUJUNRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 09:17:41 -0400
Received: from smtp4.netcabo.pt ([212.113.174.31]:60818 "EHLO
	exch01smtp12.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S269216AbUJUNEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 09:04:35 -0400
Message-ID: <21840.195.245.190.94.1098363807.squirrel@195.245.190.94>
Date: Thu, 21 Oct 2004 14:03:27 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-rc4-mm1-U8
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu>  
        <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu>  
        <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu>  
        <20041016153344.GA16766@elte.hu> <20041018145008.GA25707@elte.hu>  
        <20041019124605.GA28896@elte.hu> <20041019180059.GA23113@elte.hu>  
        <20041020094508.GA29080@elte.hu>   
    <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
In-Reply-To: <30690.195.245.190.93.1098349976.squirrel@195.245.190.93>
X-OriginalArrivalTime: 21 Oct 2004 13:04:33.0000 (UTC) FILETIME=[82164680:01C4B76E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Nuno Capela wrote:
> Ingo Molnar wrote:
>>
>> i have released the -U8 Real-Time Preemption patch:
>>
>>   http://redhat.com/~mingo/realtime-preempt/realtime-preempt-2.6.9-rc4-mm1-U8
>>
> [...]
>
> b) Laptop P4 2.533Ghz UP (Mandrake 10.1c)
>    config-2.6.9-rc4-mm1-RT-U8.1.gz
>
>    This box was known to work without major issues until U4. With U8 it's
> a real pain. Once trivial operations turns out fatal now. Running jackd
> -R, which has been a flagship before, now freezes the whole system in
> no time. (I'll take some netconsole capture sessions later)
>

OK.

Now that the usb-storage crash has been ironed out, thanks to Thomas
Gleixner's patch, I proceeded with some local experiments regarding the
jackd -R issue.

The fact is jackd -R (realtime mode; SCHED_FIFO) hosing the system, and
thats exposed as soon as some jack audio client application enters into
the chain.

Running jackd non-realtime (SCHED_OTHER) does not expose this problem, so
I think it's a scheduling related one.

With a default scenario, with all IRQ handlers under SCHED_OTHER
scheduling class and default priority, running jackd -R freezes completely
the system. Only a hard-reset or power-off is the way out.

Then I try tweaking the keyboard (IRQs 1,12), rtc (IRQ 8) and soundcard
(IRQ 5) scheduling policies to SCHED_FIFO and priority to something higher
than jackd's (e.g. chrt --fifo 60).

This way, running jack -R still hoses the system, in a somewhat less
egoistic manner, but still seems that it's the only process running on the
system taking full control of it. The evidence I could find was that
jackd's verbose output keeps pumping, as it would usually, but all the
rest poor things freeze to death. This time however, magic SysRq is of
some use, barely thanks to the i8042 IRQ scheduling promotion.

So it all seems that jackd -R is not crashing, nor anything else, for this
matter.

I really hate to say this, but this should be investigated for the RT
patch sake, obviously because the only purpose I find to it is precisely
running jackd -R, and I can swear it has been near perfection until U4
inclusive (think it was called VP back then :).

I hope I'm not the only one.

(IIRC Florian Schmidt was experiencing something similar, like system
intermitence, pauses, whatever, while also running jackd -R.)

Strange enough, all this is running on another SMP/HT box of mine, without
major issues. Guess that SMP makes the difference here.

But wait, now I remember to notice something there yet: running some jack
clients (e.g. fluidsynth) is much more expensive than usual wrt.CPU usage,
reaching very unusual levels above 40% sustained (this is actual CPU% as
reported by procps tools, not the DSP usage as reported by jack itself).
IMHO the SMP/HT effect just seems to mask the real trouble, as the
increased cost affects only one of the (virtual) CPUs.

I wonder if this does ring some bell out there. :)

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

