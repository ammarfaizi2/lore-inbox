Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbULKWfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbULKWfn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 17:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262031AbULKWfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 17:35:43 -0500
Received: from bgm-24-94-57-164.stny.rr.com ([24.94.57.164]:23192 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262025AbULKWfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 17:35:31 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
From: Steven Rostedt <rostedt@goodmis.org>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: Mark Johnson <Mark_H_Johnson@RAYTHEON.COM>, Ingo Molnar <mingo@elte.hu>,
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
In-Reply-To: <Pine.OSF.4.05.10412112027540.6963-100000@da410.ifa.au.dk>
References: <Pine.OSF.4.05.10412112027540.6963-100000@da410.ifa.au.dk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Kihon Technologies
Date: Sat, 11 Dec 2004 17:34:40 -0500
Message-Id: <1102804480.3691.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-12-11 at 20:50 +0100, Esben Nielsen wrote:
> Linux relies on soft IRQ for delivering packets to the listening
> protocol stacks. That is a problem because you can't just boost the
> priority of soft-IRQ without boosting a lot of things.
> 
> With IRQ-threading the design could be changed such the IRQ thread does
> the job directly. But that will make the whole IRQ thread drive the
> protocol stack as well :-(
> 
> It all depends on what your requirements are. Maybe you can handle
> "driving" the whole IP stack before handling the RT packet - maybe not.
> 
> How did you handle it in your thesis?
> 

I had an irq threaded kernel, and all softirqs where handled by the
softirqd thread. I created two more threads that would handle the
sending and receiving of the packets.  Here's how it worked: 

Each packet had an ip option added that stated the priority of the
packet. (of course the priorities of each machine connected must have
this protocol and priorities mean the same).

When received, the interrupt (in interrupt context not a thread) would
look to see if it was an RT packet. If it was, it placed it on a rt
received queue and woke up the receive thread. If needed it would raise
the priority of that thread. If the packet was not RT, it went the
normal route (placed on the queue for the softirq to handle).

The packet queue was a heap queue sorted by priority. The parts of the
TCP/IP stack was broken up into sections. The receive thread would only
process the packet on top of the queue. At the end of the section, it
would check to see if the queue changed and then start processing the
packet on top, if a higher packet came in at that time.  So the packets
on the queue had a state attached to them.  When the packet eventually
made it to the process waiting, it was then handled by that process. So
if a process was waiting, the process would have been woken up and it
would handle the rest of the processing. Otherwise the receive thread
would do it up to where it can drop it off to the processes. I set the
packet to be once less priority of the process it was sent from and the
one it was going to.

The sending was done mostly by the process, but if it had to wait for
some reason, the sending thread would take over.

This was mostly academic in nature, but was a lot of fun and interesting
to see how results changed with different methods.


> 
> > 
> > I just wanted to bring up this discussion, I guess a general approach is
> > too difficult and not worth the effort.
> >
> 
> If you can think up something there is no harm in trying it :-)
>  

If I ever think of something, I would not hesitate on implementing
it ;-)

> > Thanks,
> > 
> > -- Steve
> > 
> Esben
> 
> 
