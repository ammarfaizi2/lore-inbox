Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbUKHOl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbUKHOl2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 09:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261891AbUKHOj7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 09:39:59 -0500
Received: from lirs02.phys.au.dk ([130.225.28.43]:38334 "EHLO
	lirs02.phys.au.dk") by vger.kernel.org with ESMTP id S261884AbUKHOgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 09:36:19 -0500
Date: Mon, 8 Nov 2004 15:35:38 +0100 (MET)
From: Esben Nielsen <simlo@phys.au.dk>
To: Bill Huey <bhuey@lnxw.com>
Cc: Scott Wood <scott@timesys.com>, Ingo Molnar <mingo@elte.hu>,
       john cooper <john.cooper@timesys.com>, Mark_H_Johnson@raytheon.com,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       Adam Heath <doogie@debian.org>, "K.R. Foley" <kr@cybsft.com>,
       linux-kernel@vger.kernel.org, Florian Schmidt <mista.tapas@gmx.net>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.Stanford.EDU>,
       Lee Revell <rlrevell@joe-job.com>, Rui Nuno Capela <rncbc@rncbc.org>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.1
In-Reply-To: <20041105223610.GA3756@nietzsche.lynx.com>
Message-Id: <Pine.OSF.4.05.10411081410150.28010-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-DAIMI-Spam-Score: -2.82 () ALL_TRUSTED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Nov 2004, Bill Huey wrote:

> [...] 
> I think of an RT kernel with N threads in terms where it's an SMP
> machine with same N number of processors. If you have N threads
> pounding on the same critical sections, it's effectively N physical
> processors hitting as well.
> 

Not quite. On a UP RT system you know that all lower priority tasks are
not running when your task is running. This gives some nice
properties. If you take care not to sleep your high priority task
effectively blocks all preemption by the lower priority tasks.

On a SMB system you don't have these nice properties. You always have to
take into account that N processes are really running at the same time.

On UP RT systems it is legal to think like this: The processor can
only do one thing. For the overall performance I can just as well lock the
rest out with one big mutex and get my work done in a hurry. This gives
simpler code and it is more efficient since locking/unlocking sections 
takes time. It doesn't destroy the latency of the subsystem as long as you
can verify that the maximum locking time is less than the required latency
for that subsystem. If I can even keep my locking time below the maximum
allowed interrupt latency I can optimize it further by using 
interrupt disable/enable instead of a mutex!

On SMB systems, on the other hand, this gives bad performance to have such
big locking sections. Especially if you use the equivalent of interrupt
disable/enable (spinlocks) you are not only slowing down your own
subsystem but the whole system.

In short: For SMB you have to think of parellization much more than on a
UP RT system. Ofcourse to think of UP RT system as a SMB system doesn't
make your system fail, but it might give you a suboptimal system. On the
other hand a system running on a UP with full preemption might not be
portable to a SMB system as you might be saved by "the nice properties". 
So if you want to be portable, think of it as a SMB system :-)

> [...]
> 
> bill
> 

Esben

