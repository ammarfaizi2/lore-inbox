Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263576AbUJ2VRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263576AbUJ2VRX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 17:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262649AbUJ2VO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 17:14:28 -0400
Received: from mx1.elte.hu ([157.181.1.137]:61366 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263577AbUJ2VLK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 17:11:10 -0400
Date: Fri, 29 Oct 2004 23:11:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041029211112.GA9836@elte.hu>
References: <20041029203320.GC5186@elte.hu> <200410292051.i9TKptOi007283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410292051.i9TKptOi007283@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Davis <paul@linuxaudiosystems.com> wrote:

>   [ I trimmed the CC: line because several people there are on
>     jackit-devel. ]
> 
> >> compiles and boots fine. no observable change in xrun behaviour though. 
> >
> >ok, so there's something else going on as well - or i missed an ioctl. 
> 
> i really don't think the ioctl's are relevant. 
> 
> consider what will happen if jackd does make a system call that causes
> a major delay (say, because of the BKL). we will get an xrun, yes, but
> this will cause jackd to stop the audio interface and restart.
> max_delay is not affected by this behaviour.

indeed. I'd exclude the ioctls at this point. But:

> as far as i can tell, the number reported by max_delay entirely (or
> almost entirely) represents problems in kernel scheduling, specifically
> with a combination of:
> 
>      a) handling the audio interface interrupt in time.
>      b) marking the relevant jackd thread runnable
>      c) context switching back to the relevant jackd thread
> 
> things that jackd does once its running do not, it appear to me, have
> any impact on max_delay, which is based on the simple observation: 
> 
>    "i was just woken, i expect to be awakened again in N usecs or
>    less.

i dont yet see how this conclusion follows. Here's the poll() code
(simplified):

                poll_enter = jack_get_microseconds ();

                ret = poll (driver->pfd, nfds, driver->poll_timeout);

		[...]

		if (extra_fd < 0) {
			if (driver->poll_next && poll_ret > driver->poll_next) {
				*delayed_usecs = poll_ret - driver->poll_next;
			} 
			driver->poll_last = poll_ret;
			driver->poll_next = poll_ret + driver->period_usecs;
			driver->engine->transport_cycle_start (driver->engine, 
							       poll_ret);
		}

is there a mechanism that ensures that the next poll() will be called
_before_ ->poll_next? Do you get a real hard ALSA xrun in that case or
something similar?

if it's possible to 'silently' overrun the next due interrupt (somewhat,
but not large enough overrun to cause a hard ALSA xrun) then the
processing delay will i believe be accounted as a 'wakeup delay'. In
that case to make the delayed_usecs value truly accurate, i'd at least
add this:

                poll_enter = jack_get_microseconds ();

		if (poll_enter > driver->poll_next) {
			/*
			 * This processing cycle got delayed over
			 * the next due interrupt! Do not account this
			 * as a wakeup delay:
			 */
			driver->poll_next = 0;
		}

but i'd also suggest to put in a counter into that branch so that this
condition doesnt get lost. In fact the Maximum Process Cycle stat from
Rui:

>>   Maximum Delay . . . . . . . . .    6904       921       721    usecs
>>   Maximum Process Cycle . . . . .    1449      1469      1590    usecs

seems to suggest that there can be significant processing delays? (if
Maximum Process Cycle is indeed the time spent from poll_ret to the next
poll_enter.)

	Ingo
