Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263698AbUJ3L1w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263698AbUJ3L1w (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 07:27:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263699AbUJ3L1v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 07:27:51 -0400
Received: from mx1.elte.hu ([157.181.1.137]:48546 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S263698AbUJ3L1e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 07:27:34 -0400
Date: Sat, 30 Oct 2004 13:28:05 +0200
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
Message-ID: <20041030112805.GB23493@elte.hu>
References: <20041029170948.GA13727@elte.hu> <20041029193303.7d3990b4@mango.fruits.de> <20041029172151.GB16276@elte.hu> <20041029172243.GA19630@elte.hu> <20041029203619.37b54cba@mango.fruits.de> <20041029204220.GA6727@elte.hu> <20041029233117.6d29c383@mango.fruits.de> <20041029212545.GA13199@elte.hu> <20041030003122.03bcf01b@mango.fruits.de> <1099107364.1551.7.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1099107364.1551.7.camel@krustophenia.net>
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

> Ingo, here are some of my traces with the same settings.  These do
> seem to correspond to the xruns.  Many of them look tty related -
> could the recent changes to the tty layer be responsible?  Possibly
> this has nothing to do with RT preempt, but is an unrelated bug in
> -mm?  The xruns do seem to correspond to display activity such as
> switching tabs in gnome-terminal. 
> 
> jackd:1507 userspace BUG: scheduling in user-atomic context!
>  [<c01069fc>] dump_stack+0x1c/0x20 (20)
>  [<c02834d0>] schedule+0x70/0x100 (24)
>  [<c010639b>] work_resched+0x6/0x17 (-8124)

ok, this shows jackd getting preempted by a higher-prio task. This could
be the watchdog thread - could you chrt the watchdog thread to make sure
jackd itself never gets (legitimately) preempted by any other thread?

also, in my tree i fixed this codepath to not trigger an atomicity
warning, since this is an involuntary rescheduling event.

> jackd:1507 userspace BUG: scheduling in user-atomic context!
>  [<c01069fc>] dump_stack+0x1c/0x20 (20)
>  [<c02834d0>] schedule+0x70/0x100 (24)
>  [<c028465d>] down_write_mutex+0xbd/0x180 (36)
>  [<c012cbf6>] __mutex_lock+0x36/0x40 (16)
>  [<c012cc75>] _mutex_lock_irqsave+0x15/0x20 (16)
>  [<c01f1237>] tty_ldisc_try+0x17/0x50 (20)
>  [<c01f1287>] tty_ldisc_ref_wait+0x17/0xc0 (88)
>  [<c01f21fd>] tty_write+0x7d/0x230 (68)
>  [<c01546ac>] vfs_write+0xbc/0x110 (36)
>  [<c01547b1>] sys_write+0x41/0x70 (44)
>  [<c0106367>] syscall_call+0x7/0xb (-8124)

this too i'd consider a false positive, because this particular printout
happened due to a mutex, and a mutex blockage we can consider
involuntary blockage. But ... tty writes can cause BKL locking.

> We know that jackd prints from the realtime thread, and that in theory
> this could be a problem, in practice it works OK.  Maybe some recent
> changes to the tty layer made this problematic.

i'd suggest to do an atomic_off() whenever jackd prints an xrun warning 
from the highprio thread.

> I think there was a patch posted to the JACK mailing list to print
> from a separate thread, I will look into this.

that would be the better longterm solution.

	Ingo
