Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262867AbVBCWOq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262867AbVBCWOq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:14:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263169AbVBCWOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:14:45 -0500
Received: from mx2.elte.hu ([157.181.151.9]:10710 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262867AbVBCWA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:00:29 -0500
Date: Thu, 3 Feb 2005 22:59:27 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Con Kolivas <kernel@kolivas.org>, "Bill Huey (hui)" <bhuey@lnxw.com>,
       "Jack O'Quin" <joq@io.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux <linux-kernel@vger.kernel.org>, rlrevell@joe-job.com,
       CK Kernel <ck@vds.kolivas.org>, utz <utz@s2y4n2c.de>,
       Andrew Morton <akpm@osdl.org>, alexn@dsv.su.se,
       Rui Nuno Capela <rncbc@rncbc.org>, Chris Wright <chrisw@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [patch, 2.6.11-rc2] sched: RLIMIT_RT_CPU_RATIO feature
Message-ID: <20050203215927.GA28634@elte.hu>
References: <20050203212805.GA27255@elte.hu> <200502032141.j13Lf6FG009881@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502032141.j13Lf6FG009881@localhost.localdomain>
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

> >well, no. Unless i misunderstood your application model, you want
> >threads to sleep until they are woken up. So you want a very basic
> >sleep/wake mechanism. But yield_to() does not achieve that! yield_to()
> >will yield to _already running_ (i.e. in the runqueue) threads. Using
> >yield() (or yield_to()) for this is really suboptimal. By using a futex
> >based mechanism you get a very nice schedule/sleep pattern.
> 
> i mentioned earlier today in a message to bill huey that JACK is
> really a user-space cooperative scheduler. JACK's "scheduler" knows
> who is doing what and when, and if it doesn't then it can't work at
> all. so the scenario you describe is impossible and/or broken.

that might be all well and good, but i believe you still dont understand
my point: for yield_to() to work the target task _needs to be running_. 
I.e. it needs to be in TASK_RUNNING state. You cannot yield_to() a
sleeping task out of thin air: any 'targeted wakeup' needs some wait
object. Either a futex, a signal or a fifo, or something else. The waker
has to identify the wait object somehow.

so if you want to use yield_to() (which is a targeted variant of
sched_yield()) for this purpose, it wont and cannot work. Maybe you
thought of some other API, but yield_to() just doesnt cut it.

in theory it would be possible to add two new syscalls: sys_suspend()
and sys_wakeup(tid), where suspend would just enter TASK_INTERRUPTIBLE
without being on any waitqueue, and sys_wakeup() would just do a
process_wakeup() of the target task (if the target task is in
TASK_INTERRUPTIBLE state). But this would probably only be marginally
faster than futexes, and you'd still have all the problems with not
having this API on 2.4 kernels. But it would have one big advantage: it
would be evidently and trivially RT-safe :-)

	Ingo
