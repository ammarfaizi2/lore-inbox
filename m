Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbULKTvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbULKTvs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 14:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbULKTvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 14:51:48 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:11721 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S262003AbULKTve
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 14:51:34 -0500
Date: Sat, 11 Dec 2004 20:50:43 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Steven Rostedt <rostedt@goodmis.org>
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
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc2-mm3-V0.7.32-6
In-Reply-To: <1102791574.3691.15.camel@localhost.localdomain>
Message-Id: <Pine.OSF.4.05.10412112027540.6963-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004, Steven Rostedt wrote:

> On Sat, 2004-12-11 at 18:59 +0100, Esben Nielsen wrote:
> > On Fri, 10 Dec 2004, Steven Rostedt wrote:
> 
> > I am not sure I understand you correctly.
> > 
> > If it is a general method of making priority sorting on  wait-queues: Yes,
> > certainly! The highest priority task nearly always ought to be woken
> > first.
> > 
> > But in a lot of cases you send messages from high to low and visa verse
> > without wanting to move their priorities by doing so. If forinstance you
> > want a IRQ-thread to be increased in priority when a RT task listens to
> > packets from that device I think it is a bad idea. The developer should
> > himself set the priorities right. The device might use a lot of CPU in
> > some cases. By increasing it's priority you might destroy the RT
> > properties of all the tasks in between. In general you don't know.
> >  
> 
> Actually, I was thinking of something more configurable (and so, more
> complex).  The main problem I've seen in general, is to differentiate
> services for RT tasks and others. So if a RT task is waiting for some
> disk activity while other RT tasks are running, the IRQ thread (or
> whatever will service the disk) may be starved. I agree that this is
> really more of a design issue, but I thought that there may be ways to
> facilitate the RT design by setting flags in a task before it reads from
> disk, so in case the RT task blocks waiting for a disk read, the disk
> serving thread would inherit the priority of that task. One could argue
> that the task could simply increase the service provider's priority
> before doing the read, but than it may not block, and this would be a
> waist.

Disk access - at least on top of a filesystem - is not real-time. But we
can say it is some other device.

I would take the following approach:
1) Ensure the IRQ handler isn't in anyway using a too much CPU and
increase it's priority staticly.
2) Reconsider my overall design: Apparently the device isn't suit-able for
real-time.

> 
> I guess servicing in general is very hard to predict, so a RT task must
> have all its information read and stored somewhere that it can receive
> in a predictable amount of time, and not on disk or someplace that takes
> another task to do the request that handles other tasks as well (thus
> complicating the priority scheme).  As for sockets, I did my Master's
> thesis on setting up RT sockets that are handle separately from other
> sockets with a protocol that allows for incoming packets to quickly be
> determined that they are RT packets and can go right to where they are
> needed. 

Linux relies on soft IRQ for delivering packets to the listening
protocol stacks. That is a problem because you can't just boost the
priority of soft-IRQ without boosting a lot of things.

With IRQ-threading the design could be changed such the IRQ thread does
the job directly. But that will make the whole IRQ thread drive the
protocol stack as well :-(

It all depends on what your requirements are. Maybe you can handle
"driving" the whole IP stack before handling the RT packet - maybe not.

How did you handle it in your thesis?


> 
> I just wanted to bring up this discussion, I guess a general approach is
> too difficult and not worth the effort.
>

If you can think up something there is no harm in trying it :-)
 
> Thanks,
> 
> -- Steve
> 
Esben


