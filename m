Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272437AbTHIRnX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 13:43:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272582AbTHIRnW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 13:43:22 -0400
Received: from imap.gmx.net ([213.165.64.20]:44673 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272437AbTHIRnV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 13:43:21 -0400
Message-Id: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sat, 09 Aug 2003 19:47:27 +0200
To: Daniel Phillips <phillips@arcor.de>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy
  ...
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200308091505.45295.phillips@arcor.de>
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
 <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:05 PM 8/9/2003 +0100, Daniel Phillips wrote:
>Hi Davide,
>
>On Sunday 13 July 2003 22:51, Davide Libenzi wrote:
> > This should (hopefully) avoid other tasks starvation exploits :
> >
> > http://www.xmailserver.org/linux-patches/softrr.html
>
>    "We will define a new scheduler policy SCHED_SOFTRR that will make the
>    target task to run with realtime priority while, at the same time, we will
>    enforce a bound for the CPU time the process itself will consume."
>
>This needs to be a global bound, not per-task, otherwise realtime tasks can
>starve the system, as others have noted.
>
>But the patch has a much bigger problem: there is no way a SOFTRR task can be
>realtime as long as higher priority non-realtime tasks can preempt it.  The
>new dynamic priority adjustment makes it certain that we will regularly see
>normal tasks with priority elevated above so-called realtime tasks.  Even
>without dynamic priority adjustment, any higher priority system task can
>unwttingly make a mockery of realtime schedules.

Not so.  Dynamic priority adjustment will not put a SCHED_OTHER task above 
SCHED_RR, SCHED_FIFO or SCHED_SOFTRR, so they won't preempt.  Try 
this.  Make a SCHED_FIFO task loop, then try to change vt's.  You won't 
ever get there from here unless you have made 'events' a higher priority 
realtime task than your SCHED_FIFO cpu hog.  (not equal, must be higher 
because SCHED_FIFO can't be requeued via timeslice expiration... since it 
doesn't have one)

I do see ~problems with this idea though...

1.  SCHED_SOFTRR tasks can disturb (root) SCHED_RR/SCHED_FIFO tasks as is. 
SCHED_SOFTRR should probably be a separate band, above SCHED_OTHER, but 
below realtime queues.

2.   It's not useful for video (I see no difference between realtime 
component of video vs audio), and if the cpu restriction were opened up 
enough to become useful, you'd end up with ~pure SCHED_RR, which you can no 
way allow Joe User access to.  As a SCHED_LOWLATENCY, it seems like it 
might be useful, but I wonder how useful.

         -Mike 

