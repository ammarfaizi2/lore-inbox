Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267394AbUGNOaz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267394AbUGNOaz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 10:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267389AbUGNO3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 10:29:23 -0400
Received: from dns.gardena.net ([213.21.177.18]:29844 "HELO dns.gardena.net")
	by vger.kernel.org with SMTP id S264774AbUGNOZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 10:25:49 -0400
Message-ID: <40F50A72.6060601@gardena.net>
Date: Wed, 14 Jul 2004 12:26:58 +0200
From: Benno Senoner <sbenno@gardena.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040421
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "The Linux Audio Developers' Mailing List" 
	<linux-audio-dev@music.columbia.edu>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [linux-audio-dev] Re: [announce] [patch] Voluntary	Kernel	Preemption
 Patch
References: <20040712163141.31ef1ad6.akpm@osdl.org>	<200407130001.i6D01pkJ003489@localhost.localdomain>	<20040712170844.6bd01712.akpm@osdl.org>	<20040713162539.GD974@dualathlon.random>	<1089744137.20381.49.camel@mindpipe>	<20040713142923.568fa35e.akpm@osdl.org>	<1089755130.22175.21.camel@mindpipe> <s5hk6x79dk4.wl@alsa2.suse.de>
In-Reply-To: <s5hk6x79dk4.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:

>>Is it possible that I am simply pushing my hardware past its limits? 
>>Keep in mind this is a 600Mhz C3 processor.
>>    
>>
>
>I think yes.  32 frames / 44.1kHz = 0.725 ms.
>  
>
I don't think so, I think it's because the Linux scheduler (and kernel 
in general) since it's not a RTOS
is pushed to the limits. (but as we see it can still be optimized).

For example I used the same VIA box with RTLinux to remote control servo 
motors which need a PWM signal
of the duration of 2msec and based on the location of the negative flank 
(from high to low) the servo
motor goes in a certain position.
For example if the duration of the pulse is 2msec then setting the flank 
at 0msec (at the beginning of the cycle)
the servo goes to -45degrees , 1msec 0degrees , 2msec +45degrees.

Jitter in the pulse can be detected when the servo is vibrating a bit 
around the nominal position.
Of course a very short lived spike cannot be detected by the servo 
because of the motor's inertia
but I tried to put the box under very high load especially video 
playback (the VIA box uses a shared bus architecture
holding the video data in the PC's RAM), HD load etc but the jitter is 
very minimal, probably 30-40usec because the
servos vibrate only about 1degree or so (only when the box is under very 
high load).

This just to say that the VIA box should easily be able to cope with 32 
audio frames (0.6msec buffers) from a hardware
point of view.
Anyway "worst case" latencies (or better latencies under very high load) 
of <0.5-1msec are completely adequate for
real time multimedia because if you shorten your audio processing cycles 
too much (eg 32 frames) then the setup
overhead of DSP routines, and scheduling overhead becomes big and the 
efficiency of
the algorithms decrease quite a bit.
imagine running jack with 10 client applications and 32 frames (0.6msec 
periods) , this means that within 0.6msec you need
to reschedule 10 times = 60 usec per client. I don't know how much the 
actual rescheduling of a process takes (AFAIK around 1usec ?)
but I guess the main problem is the constant invalidation of the cache 
because those audio clients run for a really short time.
Of course if you have only 1-2 clients running then the efficiency at 32 
frames should still be good (but it will certainly provide 10-20% less
perfromance than using 64 or 128 frames).
Our goal should be rock solid operation at 64msec (around 1msec-1.5msec 
processing periods).
If you use 2-3 buffers then the kernel has still another 1.5-3msec of 
headroom before an actual (audible) xrun occurs.

cheers,
Benno
http://www.linuxsampler.org


>
>Takashi
>
>  
>

