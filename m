Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263319AbUJ2Nhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263319AbUJ2Nhb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263323AbUJ2Nha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 09:37:30 -0400
Received: from out002pub.verizon.net ([206.46.170.141]:31647 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP id S263319AbUJ2NgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 09:36:04 -0400
Message-Id: <200410291335.i9TDZvjZ006279@localhost.localdomain>
To: Ingo Molnar <mingo@elte.hu>
cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Lee Revell <rlrevell@joe-job.com>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4] 
In-reply-to: Your message of "Fri, 29 Oct 2004 13:36:52 +0200."
             <20041029113652.GC32204@elte.hu> 
Date: Fri, 29 Oct 2004 09:35:57 -0400
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out002.verizon.net from [141.151.88.122] at Fri, 29 Oct 2004 08:35:59 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(sorry for the slow turnaround. i am also going offline for the next 6
hours, so this is my last reply till later ...)

>> the "max delay" measurement isn't a reflection of the runtime activity
>> of jackd. its simply a measurement of the delay between when jackd
>> expected to be next woken from poll and when it actually was.
>> 
>> as you noted, jackd generally goes back to sleep in poll typically a
>> long time before the next interrupt is expected. hence any delay in
>> the wakeup is between the interrupt handler and the scheduler getting
>> jackd's main thread back on the processor. i think.
>
>this brings up the next question: does the jackd measurement also
>timestamp the time when it calls poll() - hence detecting in-jackd
>processing delays? If yes, which value is this from Rui's stats? If not
>then it might make sense to add it.

i'm not quite sure what you mean. the timestamps used to measure
max_delay look like this:
	  

                ... set up poll fd struct  ....

		poll_enter = jack_get_microseconds ();

		if (poll (driver->pfd, nfds, driver->poll_timeout) < 0) {

			if (errno == EINTR) {
				printf ("poll interrupt\n");
				// this happens mostly when run
				// under gdb, or when exiting due to a signal
				if (under_gdb) {
					goto again;
				}
				*status = -2;
				return 0;
			}
			
			jack_error ("ALSA: poll call failed (%s)",
				    strerror (errno));
			*status = -3;
			return 0;
			
		}

		poll_ret = jack_get_microseconds ();

		if (extra_fd < 0) {
			if (driver->poll_next && poll_ret > driver->poll_next) {
				*delayed_usecs = poll_ret - driver->poll_next;
			} 
			driver->poll_last = poll_ret;
			driver->poll_next = poll_ret + driver->period_usecs;
			driver->engine->transport_cycle_start (driver->engine, 
							       poll_ret);
		}

you can view this here in context:

   http://jackit.sourceforge.net/cgi-bin/lxr/http/source/drivers/alsa/alsa_driver.c
  
(its at line 1195)

the max_delay value is taken from "delayed_usecs" above. each backend
(the one shown is the ALSA driver) sets this every time its "wait"
function is called; jackd collects the figures and these days manages
them as a set of statistics.

as you can see, poll_enter is available, but we don't use it for much
at all (mostly just some information in the very unusual event that
poll times out).

jack_get_microseconds() uses the cycle timer to compute elapsed time,
there is no system call involved.

--p
