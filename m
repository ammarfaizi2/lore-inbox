Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263710AbUJ3L6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263710AbUJ3L6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263712AbUJ3L6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:58:16 -0400
Received: from mx1.elte.hu ([157.181.1.137]:45482 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263710AbUJ3L6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:58:11 -0400
Date: Sat, 30 Oct 2004 13:58:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Florian Schmidt <mista.tapas@gmx.net>,
       Paul Davis <paul@linuxaudiosystems.com>,
       Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>, mark_h_johnson@raytheon.com,
       Bill Huey <bhuey@lnxw.com>, Adam Heath <doogie@debian.org>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Karsten Wiese <annabellesgarden@yahoo.de>,
       jackit-devel <jackit-devel@lists.sourceforge.net>,
       Rui Nuno Capela <rncbc@rncbc.org>
Subject: Re: [Fwd: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0.4]
Message-ID: <20041030115808.GA29692@elte.hu>
References: <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu> <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu> <1099086166.1468.4.camel@krustophenia.net> <20041029214602.GA15605@elte.hu> <1099091566.1461.8.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099091566.1461.8.camel@krustophenia.net>
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


* Lee Revell <rlrevell@joe-job.com> wrote:

> Here is the dmesg output.  It looks like the problem could be related
> to jackd's printing from the realtime thread.  But, this has to be the
> kernel's fault on some level, because with an earlier version I get no
> xruns.

with the earlier version these spinlocks were simply disabling
preemption, while now they will schedule away on contention. If that tty
lock is held for a long time by a lowprio task then that could delay the
highprio thread. We are starting to see priority inversion problems. 
But, the core issue is doing tty printouts - does jackd do that
periodically, or only as a reaction to an already existing latency?

> jackd:1846 userspace BUG: scheduling in user-atomic context!
>  [<c01069fc>] dump_stack+0x1c/0x20 (20)
>  [<c0283e60>] schedule+0x70/0x100 (24)
>  [<c0119efa>] do_exit+0x29a/0x500 (24)
>  [<c011a196>] sys_exit+0x16/0x20 (12)
>  [<c0106367>] syscall_call+0x7/0xb (-8124)

this one is interesting - does the jackd highprio thread start new
threads and lets them exit? The above schedule() is the final one of an
exit()-ing thread.

> jackd:1854 userspace BUG: scheduling in user-atomic context!
>  [<c01069fc>] dump_stack+0x1c/0x20 (20)
>  [<c0283e60>] schedule+0x70/0x100 (24)
>  [<c0119efa>] do_exit+0x29a/0x500 (24)

same exit() scenario. That would be pretty much a no-no, a new child
thread inherits the parent's SCHED_FIFO priority and due to
child-runs-first it could delay the parent possibly indefinitely.

	Ingo
