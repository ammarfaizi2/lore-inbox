Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263090AbUJ2AC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263090AbUJ2AC4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 20:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbUJ2ACC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 20:02:02 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:27078 "EHLO
	exch01smtp11.hdi.tvcabo") by vger.kernel.org with ESMTP
	id S263155AbUJ1XwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 19:52:08 -0400
Message-ID: <32806.192.168.1.5.1099007364.squirrel@192.168.1.5>
Date: Fri, 29 Oct 2004 00:49:24 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, "Lee Revell" <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Bill Huey" <bhuey@lnxw.com>, "Adam Heath" <doogie@debian.org>,
       "Florian Schmidt" <mista.tapas@gmx.net>,
       "Thomas Gleixner" <tglx@linutronix.de>,
       "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>,
       "Fernando Pablo Lopez-Lezcano" <nando@ccrma.stanford.edu>,
       "Karsten Wiese" <annabellesgarden@yahoo.de>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
References: <12917.195.245.190.94.1098890763.squirrel@195.245.190.94>      
    <20041027205126.GA25091@elte.hu> <20041027211957.GA28571@elte.hu>      
    <33083.192.168.1.5.1098919913.squirrel@192.168.1.5>      
    <20041028063630.GD9781@elte.hu>      
    <20668.195.245.190.93.1098952275.squirrel@195.245.190.93>      
    <20041028085656.GA21535@elte.hu>      
    <26253.195.245.190.93.1098955051.squirrel@195.245.190.93>      
    <20041028093215.GA27694@elte.hu>      
    <43163.195.245.190.94.1098981230.squirrel@195.245.190.94>      
    <20041028191605.GA3877@elte.hu>
In-Reply-To: <20041028191605.GA3877@elte.hu>
X-OriginalArrivalTime: 28 Oct 2004 23:52:06.0713 (UTC) FILETIME=[2198A290:01C4BD49]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela wrote:
>
>> OK. Here are my early consolidated results. Feel free to comment.
>>
>>                                     2.6.9     RT-U3   RT-V0.4.3
>>                                   --------- --------- ---------
>>   XRUN Rate . . . . . . . . . . .     424         8         4    /hour
>>   Delay Rate (>spare time)  . . .     496         0         0    /hour
>>   Delay Rate (>1000 usecs)  . . .     940         8         4    /hour
>>   Maximum Delay . . . . . . . . .    6904       921       721    usecs
>>   Maximum Process Cycle . . . . .    1449      1469      1590    usecs
>>   Average DSP CPU Load  . . . . .      38        39        40    %
>>   Average Context-Switch Rate . .    7480      8929      9726    /sec
>
> looks pretty good, doesnt it?
>

Yes indeed :)


> how is the 'maximum delay' calculated? Could you put in a tracing hook
> into jackd whenever such a ~720 usecs maximum is hit? I'd _love_ to see
> how such a latency path looks like, it seems a bit long.
>

That 'maximum delay' is collected on each jackd process cycle. AFAICS, it
is the figure of a scheduling delay, as measured by jackd as the time
interval between interrupt and effective jackd process handler (re)entry.

Please note that I'm not a JACK developer. I'm just a regular user
with ancient coding skills ;) I do however subscribe to the jackit-devel
maillist. And the author of qjackctl, if that matters...

For reading this 'maximum delay' I am actually using a custom patch
against jack-0.99.7cvs, being a Lee Revell's original.


> It should be a relatively simple hack to jackd. Firstly, download the
> -V0.5.3 patch and enable LATENCY_TRACE, then do:
>
>         echo 2 > /proc/sys/kernel/trace_enabled
>
> this activates the 'application-triggered kernel tracer' functionality.
>
> No tracing happens by default, but tracing starts if the application
> executes this function:
>
>         gettimeofday(0,1);
>
> and tracing stops if the application does:
>
>         gettimeofday(0,0);
>
> whenever the app does this (0,0) call the trace gets saved and you can
> retrieve it from /proc/latency_trace where you can retrieve it. There is
> no combination of these parameters that can break the kernel, so it's a
> 100% safe tracing facility. You can 'ignore' a latency [e.g. if it's not
> a maximum] by simply not doing the (0,0) call. The next (0,1) call done
> will override the previous, already running trace.
>
> [stupid function but this combination of the syscall parameters is not
> used otherwise so the latency tracer hijacks it.]
>
> i dont know how Jackd does things, but i'd suggest to enable tracing the
> first time possible when getting an interrupt - in theory this should
> happen as soon as the wakeup-latency-tracer says - i.e. at most in like
> 30 usecs. The bulk of the remaining 700 usecs will be spent in jackd,
> and you can trace those 700 usecs.
>
> or if you would be willing to do a little bit of ALSA hacking, you could
> add this to the ALSA interrupt handler:
>
>         #include <linux/syscalls.h>
>
>         ...
>         sys_gettimeofday(0, 1);
>
> [the attached patch implements this for ali5451.]
>
> and do the gettimeofday(0,0) in jackd [if the latency measured there is
> a new maximum]! This way tracing is turned on within the kernel IRQ
> handler (i.e. as soon as possible) and turned off within ALSA. This will
> enable us to see an even more complete latency path.
>
> NOTE: there can only be one trace active at a time. So if there can be
> multiple channels active at a time then this user-triggered tracer might
> be less useful. Do these channels have any priority? Or if multiple
> channels are necessary then you could modify the patch to only do the
> (0,1) call for say channel #0:
>
>         if (channel == 0)
>                 sys_gettimeofday(0, 1);
>
> in this case the trace-off-save (0,0) call in Jackd must also only do
> this for channel 0 processing! (or whichever channel you find the most
> interesting.)
>

Ouch. This is a bit too much to digest in so little time :) I'll try to
re-read this from cache, erm... tomorrow ;)

BTW, this means that I have to re-enable LATENCY_TIMING back again? Notice
that all my results were taken with a production configuration, that is,
with all debug options now set to off (OK, I think I've left the
stack-overflow on, but that was the only one).

OTOH, this latency timing has been troublesome on either of my setups,
recently. But I'll give it another try...


> also, i looked at the sound/pci/ali5451/ali5451.c driver code and it has
> one weird piece of code on line 988:
>
>         udelay(100);
>
> that adds a 100 usecs latency to the main path, for no good reason! It
> also spends that time burning CPU time, delaying other processing. Could
> you add an IRQs/sec measurement too if possible, so that we can compare
> the IRQ rates of various kernels?
>

Yes, I can add interrupts/sec measuring with nmeter. Neat utility indeed,
thanks to Denis Vlasenko.


> Also, i'd suggest to simply remove that line (or apply the attached
> patch) - does the driver still work fine with that?
>

Now that you call, I remember to hack that very same line, some time go,
but couldn't get no better than a udelay(33). Removing that line just
ended in some kind of malfunction, but can't remember what exactly. One
thing's for sure, sound didn't came out of it :-/


> plus i've also got questions about how Jackd interfaces with ALSA: does
> it use SIGIO, or some direct driver ioctl? If SIGIO is used then how is
> it done precisely - is an 'RT' queued signal used or ordinary SIGIO?
> Also, how is the 'channel' information established upon getting a SIGIO,
> is it in the siginfo structure?
>

Now that's really pushing me over. Any ALSA-JACK developers around here to
comment?

Bye now.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

