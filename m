Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261192AbULMV6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbULMV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 16:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261180AbULMV6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 16:58:16 -0500
Received: from smtp.Lynuxworks.com ([207.21.185.24]:14097 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261192AbULMV6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 16:58:01 -0500
Date: Mon, 13 Dec 2004 13:55:49 -0800
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Esben Nielsen <simlo@phys.au.dk>,
       Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
       Amit Shah <amit.shah@codito.com>,
       Karsten Wiese <annabellesgarden@yahoo.de>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, emann@mrv.com,
       Gunther Persoons <gunther_persoons@spymac.com>,
       "K.R. Foley" <kr@cybsft.com>, LKML <linux-kernel@vger.kernel.org>,
       Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Shane Shrybman <shrybman@aei.ca>, Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
Message-ID: <20041213215549.GB29432@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10412112027540.6963-100000@da410.ifa.au.dk> <1102804480.3691.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1102804480.3691.32.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 11, 2004 at 05:34:40PM -0500, Steven Rostedt wrote:
> On Sat, 2004-12-11 at 20:50 +0100, Esben Nielsen wrote:
> > How did you handle it in your thesis?

I'd like to see the code even if it's not ready for inclusion or anything
along those lines just to see what other kind of problems you ran into.

> I had an irq threaded kernel, and all softirqs where handled by the
> softirqd thread. I created two more threads that would handle the
> sending and receiving of the packets.  Here's how it worked: 

[priority tags packets...]

> When received, the interrupt (in interrupt context not a thread) would
> look to see if it was an RT packet. If it was, it placed it on a rt
> received queue and woke up the receive thread. If needed it would raise
> the priority of that thread. If the packet was not RT, it went the
> normal route (placed on the queue for the softirq to handle).

A generalized system to do this is pretty important for folks doing things
like QoS over things like Firewire, SCSI, USB, and other high speed busses
of that nature including networking layers. Folks doing things with clusters
would love to have something like that if the subsystem layer above the
driver responsible for handling the protocol was modified to have this
ability.

One thing that I noticed in this thread is that even though you were talking
about the mechanisms to support these features, it really needs some
consideration as to how it's going to effect the stock kernel since you're
really introduction a first-class threading object/concept into the system.
That means changes to the scheduler, how QoS fits into this, etc...
IMO, it's ultimately about QoS and that alone is a hot button since it's
so invasive throughout the kernel.

Creating a special threaded server object (thinking out loud) might be a
good idea in that it could be attached to any arbitrary subsystem at will,
assuming if that particular subsystem's logic permits this easily.

It's not a light topic and can certain require more folks pushing it. I'm
very interested in getting something like this into Linux, but stability,
latency regularity, contention are things that still need a lot of work.
 
> The packet queue was a heap queue sorted by priority. The parts of the
> TCP/IP stack was broken up into sections. The receive thread would only
> process the packet on top of the queue. At the end of the section, it
> would check to see if the queue changed and then start processing the
> packet on top, if a higher packet came in at that time.  So the packets
> on the queue had a state attached to them.  When the packet eventually
> made it to the process waiting, it was then handled by that process. So
> if a process was waiting, the process would have been woken up and it
> would handle the rest of the processing. Otherwise the receive thread
> would do it up to where it can drop it off to the processes. I set the
> packet to be once less priority of the process it was sent from and the
> one it was going to.
> 
> The sending was done mostly by the process, but if it had to wait for
> some reason, the sending thread would take over.
> 
> This was mostly academic in nature, but was a lot of fun and interesting
> to see how results changed with different methods.

This is a good track to research casually since not that many people have
done so, and so that the problem space is mapped in this particular kernel.
With things like VoIP and relatives becoming popular, this is becoming
more and more essential over time.

It's up to you, but I think this is a great track to pursue.. That's because
if you don't do it, somebody else will... :)

bill

