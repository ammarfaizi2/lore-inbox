Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267363AbUJNTRh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267363AbUJNTRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 15:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267360AbUJNTR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 15:17:28 -0400
Received: from dfw-gate3.raytheon.com ([199.46.199.232]:62179 "EHLO
	dfw-gate3.raytheon.com") by vger.kernel.org with ESMTP
	id S267388AbUJNTOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 15:14:21 -0400
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U1
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Bill Huey <bhuey@lnxw.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, Adam Heath <doogie@debian.org>,
       Daniel Walker <dwalker@mvista.com>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org,
       Lorenzo Allegrucci <l_allegrucci@yahoo.it>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OFF6785669.51B69427-ON86256F2D.0066DF1F@raytheon.com>
From: Mark_H_Johnson@raytheon.com
Date: Thu, 14 Oct 2004 14:13:15 -0500
X-MIMETrack: Serialize by Router on RTSHOU-DS01/RTS/Raytheon/US(Release 6.5.2|June 01, 2004) at
 10/14/2004 02:13:17 PM
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
X-SPAM: 0.00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I would prefer to not use threaded IRQ's if possible due to lower CPU
>> overhead [see previous email describing results...] and some problems
>> I see with setting priorities on those IRQ's (relative to real time
>> tasks).
>
>the overhead we can try to optimize later on. What problems do you see
>with setting priorities on those IRQs?

Perhaps I am old fashioned, but in building a real time system, I consider
hardware interrupt processing as something that is always at a higher
priority than real time tasks. In general that is not a problem because
hardware interrupt processing should do just enough to keep the hardware
happy and nothing more. I have enough spare CPU cycles within each frame
to account for [could be a large number of] interrupts that follow that
approach. Unthreaded IRQ's preserves that relationship.

However, with the threaded IRQ's, a real time program (e.g., latencytest)
can request a priority higher than IRQ processing - causing problems
interfacing with devices. At a minimum, the default priority of IRQ's
should
be some real time value so that nice -20 jobs won't bother them either.
A possibility that comes to mind is to schedule IRQ's at a range higher
than
available to all real time application tasks. I'll mention another
possibility below as well.

In the systems I have to deal with, I do not have a clear criteria
to set priorities of interrupts relative to each other. For example, I
have a real time simulation system using the following devices:
 - occasional disk access to simulate disk I/O
 - real time network traffic
 - real time delivery of interrupts from a PCI timer card and APIC timers
 - real time interrupts from a shared memory interface
The priorities of real time tasks are basically assigned based on the
rate of execution. 80 Hz tasks run at a higher priority than 60 Hz, 60 Hz >
40 Hz, and so on. A number of tasks can access each device.

As noted above, I can live with a system where I can guarantee that all
the IRQ processing has higher priority than all the real time tasks.

It would be "better" if the priority of the hardware interrupts somehow
inherited the priority (absolute or relative to other IRQ's) of the task
making the request. So in that way, a 40 Hz task making a network transfer
would somehow boost the priority of the network interface until that
transfer was complete. It would also be good if the queue of pending
transfers was reordered by RT priority, but I don't see that as an easy
thing to implement currently in Linux (but I can ask... :-) ).

Needless to say, if you implemented priority inheritance, when the 40 Hz
task is not doing network transfers, I would just as soon prefer that
other network operations (say from a 2 Hz tasks) does not get a priority
boost above a 20 Hz task accessing another device.

--Mark H Johnson
  <mailto:Mark_H_Johnson@raytheon.com>

