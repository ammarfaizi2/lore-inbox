Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbUK2KAQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbUK2KAQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 05:00:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbUK2KAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 05:00:16 -0500
Received: from mx1.elte.hu ([157.181.1.137]:32188 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261642AbUK2KAB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 05:00:01 -0500
Date: Mon, 29 Nov 2004 10:59:41 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041129095941.GD7868@elte.hu>
References: <20041128084250.GC9814@elte.hu> <Pine.OSF.4.05.10411281630010.23754-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411281630010.23754-100000@da410.ifa.au.dk>
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


* Esben Nielsen <simlo@phys.au.dk> wrote:

> I agree with your analysis: There is no need to change the way the
> mutex is passed to the new task as the current implementation does
> give an upper bound. Also it works the same way on SMP and UP. It also
> performs better. The situations where the bound really is 2^N-1, N>2,
> are very rare if they exist at all.
> 
> There is a tiny "however" I want to mention, though. Who will use a
> Linux kernel with real-time performance? People who want a RT
> application and at the same time want to deploy normal Linux
> applications. The criteria for the RT system to work is that even if
> you put on heavy loads of normal applications the RT application still
> schedules fine. It is very unlikely that anyone will try to calculate
> wether it schedules or not. It is much more common that people just
> test it in the lab and then thrust that the real-time properties of
> the the system not to change when you go into deployment. 

the locking interactions have to be well understood. You really have to
know whether the RT app takes lock1 once or 10 times in a critical path
- in the latter case people might never see the 10x2msec latency in
testing either, so i dont think there's a big difference. I.e. depending
on what kernel subsystems the RT task uses (what kernel subsystems it
uses that shares locks with nonprivileged tasks), it might see higher
latencies.

To give you an extreme example: you cannot run OpenOffice.org with
SCHED_FIFO prio 99 and expect it to have any sane deterministic latency
bounds. The simpler the app, the easier it is to control latencies.

Careful planning and design of hard-RT apps is still vital, and further
RT-friendly locking of kernel subsystems has to be done too. Also, the
actual latencies and characteristics of kernel subsystems has to be
understood too. So e.g.: "if your hard-RT task uses file ops then you
might see latencies up to ... N*open_files" - things like that.

PREEMPT_RT doesnt magically give all kernel subsystems bounded execution
times - it only guarantees bounded scheduling latencies. So it in
essence integrates hard-RT into Linux, but it doesnt by itself make the
kernel itself O(1). But, fortunately, a good portion of the core
functionality of Linux is quite close to O(1) already, and most hard-RT
apps try to stay as simple as possible. But no doubt there's still tons
of work left - PREEMPT_RT is only the core infrastructure.

	Ingo
