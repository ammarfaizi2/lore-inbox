Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263276AbUJ2BC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263276AbUJ2BC3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 21:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263255AbUJ2BAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 21:00:09 -0400
Received: from out012pub.verizon.net ([206.46.170.137]:19396 "EHLO
	out012.verizon.net") by vger.kernel.org with ESMTP id S263275AbUJ2A5z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:57:55 -0400
Message-Id: <200410290057.i9T0v5I8011561@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, Lee Revell <rlrevell@joe-job.com>,
       mark_h_johnson@raytheon.com, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Thu, 28 Oct 2004 20:04:23 EDT."
             <1099008264.4199.4.camel@krustophenia.net> 
Date: Thu, 28 Oct 2004 20:57:05 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out012.verizon.net from [141.151.83.217] at Thu, 28 Oct 2004 19:57:45 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Can anyone answer Ingo's questions about JACK & the best way to profile
>it?  This is a bit over my head.
>
>Lee
>
>
>-------- Forwarded Message --------
>Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4
>Date: Thu, 28 Oct 2004 21:16:05 +0200
>* Rui Nuno Capela <rncbc@rncbc.org> wrote:
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
>looks pretty good, doesnt it?

yes and no. its troubling that we're using an extra 100usecs of time
for the max process cycle, if the statistics make that number
meaningful. and why a 30% increase in the context switch rate? is that
an artifact or a real behavioural change? the xrun rate is not bad,
although i'd need to know the period size. 4 clicks per hour would
actually be unacceptable to most professionals, but this may have been
with significant loading outside of JACK - i don't know.

>how is the 'maximum delay' calculated? Could you put in a tracing hook
>into jackd whenever such a ~720 usecs maximum is hit? I'd _love_ to see 
>how such a latency path looks like, it seems a bit long.

"maximum delay" is computed like this:

	 a) we know that jackd should be woken at regular, known
	    intervals based on the interrupt of the audio interface.

	 b) jackd is (often) blocked in poll(2), waiting for the
	    audio interface to become readable+writable.

	 c) on return from poll, we check the time we are returning
	    and compare it to the last wakeup. the difference should
	    be almost exactly the interrupt interval. 

	 d) any amount larger than this is a delay caused by
	    kernel scheduling. we track the largest such delay.

>also, i looked at the sound/pci/ali5451/ali5451.c driver code and it has
>one weird piece of code on line 988:
>
>	udelay(100);

yeah, some ALSA drivers have broken stuff like this in them. its a
definite problem. this is why we know that some audio interfaces are
not able to provide acceptable performance for JACK - that is OK, the
same is true under Win/Mac where some h/w just can't be used for low
latency work.

>plus i've also got questions about how Jackd interfaces with ALSA: does
>it use SIGIO, or some direct driver ioctl? If SIGIO is used then how is
>it done precisely - is an 'RT' queued signal used or ordinary SIGIO? 
>Also, how is the 'channel' information established upon getting a SIGIO,
>is it in the siginfo structure?

we absolutely do not use SIGIO - i am one of the most vocal critics of
this interface even be present. POSIX says that signal handling
context is essentially crippled, so there is very little you can do
from there. in addition, measurements of signal delivery time on Linux
suggest that it is really quite slow. i considered using signals to
wake jack clients, but it was dramatically slower than using a FIFO
plus poll(2).

we block in poll(2), waiting for the interrupt from the audio
interface to mark the relevant jackd thread as runnable.

i don't know what you mean by "channel" information in this context.

--p
