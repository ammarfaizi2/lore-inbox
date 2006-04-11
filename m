Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbWDKJQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbWDKJQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 05:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbWDKJQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 05:16:49 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:28129 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932380AbWDKJQs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 05:16:48 -0400
Date: Tue, 11 Apr 2006 17:13:43 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Roland McGrath <roland@redhat.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
Message-ID: <20060411131343.GA113@oleg>
References: <20060410214018.GA635@oleg> <20060411080119.2BBF42204D9@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060411080119.2BBF42204D9@magilla.sf.frob.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Roland McGrath wrote:
>
> > A fatal signal is placed to ->shared_pending in any (non tkill) case, so I
> > think it is not lost (but may be unnoticed for a while).
> >
> > sig_kernel_coredump() is different. It could be stealed by one of sub-threads
> > while another one does de_thread(), that is why it could be lost.
> 
> I am not talking about the case where it's still pending on either queue.
> Those are fine as they are.  What matters is when it's been dequeued, in
> the race window afer releasing the siglock in get_signal_to_deliver.
> There are two windows of race here.  
> 
> The first one is only when ptrace'd, and doesn't even require a race that
> takes good timing to create.  The window is in ptrace_stop when the siglock
> is released, including all the time stopped in TASK_TRACED.  Say another
> thread does an exec (and de_thread) while we're in TASK_TRACED after
> reporting a death signal to the debugger.  The SIGKILL wakes us out of
> ptrace_stop.  Assuming the debugger wasn't racing with a PTRACE_CONT too,
> then the signal remains in ->exit_code and (assuming the SIGNAL_GROUP_EXIT
> check there reverted, as I mentioned before), we just come out of the
> ptrace path with the siglock held as if we'd dequeued the signal without ptrace.

Yes, you are right, thanks.

> Then comes the second window.  With no ptrace, or after ptrace, we've
> dequeued the signal and if it's a SIG_DFL fatal signal, we release the
> siglock.  Here a non-coredump signal just calls do_group_exit.  Meanwhile,
> a racing exec comes along and sets SIGNAL_GROUP_EXIT (or it already did
> earlier while we were in ptrace_stop).  In do_group_exit, we will see that
> SIGNAL_GROUP_EXIT is set, and just do_exit ourselves with the group_exit_code.
> When it's an exec rather than a real exit, we've swallowed the signal.
> This is no different than the coredump case.  (When do_coredump bails out,
> then it joins this very same code path.)

I still think we are ok with no ptrace. If that (non-coredump) signal was
delivered before de_thread sets SIGNAL_GROUP_EXIT, then this flag is set
by __group_complete_signal(), so de_thread return -EAGAIN. If de_thread()
wins, the signal will be dequeued later from ->shared_pending.

tkill() is different, but I don't see any problem here.

Oleg.

