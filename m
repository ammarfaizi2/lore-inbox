Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263610AbVBCOVq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263610AbVBCOVq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 09:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVBCOVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 09:21:45 -0500
Received: from out008pub.verizon.net ([206.46.170.108]:1790 "EHLO
	out008.verizon.net") by vger.kernel.org with ESMTP id S263492AbVBCOVF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 09:21:05 -0500
Message-Id: <200502031420.j13EKwFx005545@localhost.localdomain>
To: Bill Huey (hui) <bhuey@lnxw.com>
cc: Ingo Molnar <mingo@elte.hu>, "Jack O'Quin" <joq@io.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Con Kolivas <kernel@kolivas.org>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature 
In-reply-to: Your message of "Wed, 02 Feb 2005 18:46:50 PST."
             <20050203024650.GA15334@nietzsche.lynx.com> 
Date: Thu, 03 Feb 2005 09:20:55 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out008.verizon.net from [151.197.207.111] at Thu, 3 Feb 2005 08:21:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>This is a bit off topic, but I'm interested in applications that are
>more driven by time and has abstraction closer to that in a pure way.
>A lot of audio kits tend to be overly about DSP and not about time.
>This is difficult to explain, but what I'm referring to here is ideally
>the next generation these applications and their design, not the current
>lot. A lot more can be done.
>
>> And it makes possible some of the most sophisticated *audio* apps on
>> the planet, though admittedly not video and other data at this time.
>
>Again, the notion of time based processing with broader uses and not
>just DSP which what a lot of current graph driven audio frameworks
>seem to still do at this time. Think gaming audio in 3d, etc...

Ever since I started work on JACK, it has always been in the back of
my head that on at least one level, its not about audio at all. Its a
user-space cooperative scheduler. All it really is a way to fire up a
bunch of processes (and/or internal callbacks) based on the passing of
time as measured by some kernel-induced wakeup. It comes with a lot of
extra stuff, like ports for passing around data, and the notion of a
"backend" which is what actually responds to the wakeup and has
somewhat more specific semantics than the client model. It also has
the notion of enforcing time-related deadlines by evicting clients
that appear to cause them to be violated. Even so, there is remarkably
little about audio/DSP that affects the core design of JACK, which is
why it can be run without any audio hardware, can provide network
data transport, etc. etc.

There are several kernel-side attributes that would make JACK better from
my perspective:

	* better ways to acquire and release RT scheduling
	* better kernel scheduling latency (which has now come a long
	    way already)
	* real inter-process handoff. i am thinking of something like
	    sched_yield(), but it would take a TID as the target
	    of the yield. this would avoid all the crap we have to 
	    go through to drive the graph of clients with FIFO's and
	    write(2) and poll(2). Futexes might be a usable
	    approximation in 2.6 (we are supporting 2.4, so we can't
	    use them all the time)
	* better ways to know what to lock into physical RAM

Gaming audio is really a very different model from
pro-audio. Developers there have evolved a different approach to
dealing with latency issues. They use lots of kernel/hardware
buffering for audio, but they require the ability to overwrite what
they have already written to the buffers. This lets them get away with
using rather large audio latency (especially by comparison with us
audio folk), but still allows them stick new audio into the playback
stream at short notice based on user actions. This is a design that
won't work very well for pro-audio. Gamers could use the pro-audio
"calculate everything at the last moment" model, but guess what:
they'd be beating down on kernel scheduling door and RT-acquisition
policy center just like we have, only in much larger numbers :)

--p


