Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263362AbVBCVdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263362AbVBCVdn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 16:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbVBCV3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 16:29:00 -0500
Received: from mx2.elte.hu ([157.181.151.9]:11984 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262962AbVBCV2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 16:28:22 -0500
Date: Thu, 3 Feb 2005 22:28:05 +0100
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
Message-ID: <20050203212805.GA27255@elte.hu>
References: <20050203204711.GB25018@elte.hu> <200502032115.j13LFWFY009703@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200502032115.j13LFWFY009703@localhost.localdomain>
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

> however, i don't agree that futexes are conceptually superior. they
> don't express the intended operation nearly as accurately as
> yield_to(tid) would. the operation is "i have nothing else to do, and
> i want <tid> to run next". a futex says "this particular condition is
> satisfied, which might wake one or more tasks". [...]

what i suggested was to use one of the pthread APIs - not to use raw
futexes.

so the basic model is that you have a processing dependency between
threads, correct? If one thread finishes, you know which one should come
next - based on the graph. The first thread is triggered by some
external event. (timer or audio event.)

this can be cleanly implemented by attaching a pthread spinlock to each
node of the graph, and initializing the lock to a locked state. The
threads go sleeping by 'taking the lock'. The one that does processing,
wakes up the next one by unlocking that graph node, and then it goes to
sleep by locking its own node.

(it would be cleaner to use POSIX semaphores for this, but you mentioned
the requirement for the mechanism to work on 2.4 kernels too - pthread
spinlocks will work inter-process on 2.4 too, and will schedule nicely.)

> [...] its still necessary for the caller to go to sleep explicitly,
> its still necessary for the tasks involved to know about the futexes,
> which actually are really irrelevant - there are no conditions to
> satisfy, just a series of tasks we want to run.

well, no. Unless i misunderstood your application model, you want
threads to sleep until they are woken up. So you want a very basic
sleep/wake mechanism. But yield_to() does not achieve that! yield_to()
will yield to _already running_ (i.e. in the runqueue) threads. Using
yield() (or yield_to()) for this is really suboptimal. By using a futex
based mechanism you get a very nice schedule/sleep pattern.

(you could also use kill()/sigwait(), but that is slower than futexes.)

	Ingo
