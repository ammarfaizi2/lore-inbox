Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268663AbUJPHzV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268663AbUJPHzV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 03:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268677AbUJPHzV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 03:55:21 -0400
Received: from mx2.elte.hu ([157.181.151.9]:41143 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S268663AbUJPHzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 03:55:14 -0400
Date: Sat, 16 Oct 2004 09:56:35 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Adam Heath <doogie@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
Message-ID: <20041016075635.GA462@elte.hu>
References: <20041011215909.GA20686@elte.hu> <20041012091501.GA18562@elte.hu> <20041012123318.GA2102@elte.hu> <20041012195424.GA3961@elte.hu> <20041013061518.GA1083@elte.hu> <20041014002433.GA19399@elte.hu> <20041014143131.GA20258@elte.hu> <20041014234202.GA26207@elte.hu> <20041015102633.GA20132@elte.hu> <Pine.LNX.4.58.0410152157030.1219@gradall.private.brainfood.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0410152157030.1219@gradall.private.brainfood.com>
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


* Adam Heath <doogie@debian.org> wrote:

> On Fri, 15 Oct 2004, Ingo Molnar wrote:
> 
> >
> > i have released the -U3 PREEMPT_REALTIME patch:
> >
> >   http://redhat.com/~mingo/voluntary-preempt/voluntary-preempt-2.6.9-rc4-mm1-U3
> 
> scheduling while atomic: postmaster/0x04000002/3175
> caller is cond_resched+0x53/0x70
>  [<c01069f7>] dump_stack+0x17/0x20
>  [<c027b457>] schedule+0x517/0x550
>  [<c027b9c3>] cond_resched+0x53/0x70
>  [<c012cdc7>] _mutex_lock+0x17/0x40
>  [<c012ce18>] _mutex_lock_irqsave+0x8/0x10
>  [<c01b21ae>] avc_has_perm_noaudit+0x2e/0x180
>  [<c01b2335>] avc_has_perm+0x35/0x68
>  [<c01b79ca>] ipc_has_perm+0x6a/0x80
>  [<c01ab716>] semctl_main+0xa6/0x410
>  [<c01abcad>] sys_semctl+0xad/0xb0
>  [<c010bafd>] sys_ipc+0xad/0x250
>  [<c0105bff>] syscall_call+0x7/0xb

thanks - that's the IPC code that is not converted over from RCU yet.

a suggestion for future testing: please enable PREEMPT_TIMING for the
next kernels you build, it will print such entries at the end of
stacktraces:

 preempt count: 2
 entry 1: cpu_idle+0x38/0x90 / (start_kernel+0x1ac/0x1f0)
 entry 2: _spin_lock+0x22/0x80 / (timer_interrupt+0x1b/0x130)

while in this particular IPC case it's immediately visible that it's the
IPC RCU use that is the root of the problem, the preemption trace
printout can be very helpful in other cases to quickly identify where
the preemptible section was started. E.g. the networking code sometimes
has very deep nesting and non-obvious locking. Thanks,

	Ingo
