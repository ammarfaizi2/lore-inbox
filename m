Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932373AbWDKJKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWDKJKZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 05:10:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbWDKJKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 05:10:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6313 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932373AbWDKJKY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 05:10:24 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Oleg Nesterov <oleg@tv-sign.ru>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Michael Kerrisk <mtk-lkml@gmx.net>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] fix de_thread() vs do_coredump() deadlock
In-Reply-To: Oleg Nesterov's message of  Tuesday, 11 April 2006 15:47:53 +0400 <20060411114753.GA1088@oleg>
X-Windows: never had it, never will.
Message-Id: <20060411091007.484B52204D9@magilla.sf.frob.com>
Date: Tue, 11 Apr 2006 02:10:07 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Once again. Process starts exec, it has no pending signals. Execer thread sets
> SIGNAL_GROUP_EXEC, sends SIGKILL to other threads, and waits them to die.
> The first thread which dequeues SIGKILL will change SIGNAL_GROUP_EXEC to
> SIGNAL_GROUP_EXIT, thus aborting exec.

You are very right.  Sorry I did not manage to understand your objection
the first time around.  Sigh, trying to think on too little sleep again, I guess.

> Sorry for persistance if I really misunderstand this patch.

Thanks for the persistence.


What I'd really like to do here is get rid of these fake SIGKILLs.  We're
already waking the threads up directly in zap_other_threads.  We don't
really need to set SIGKILL pending.  By setting group_stop_count we can
make sure recalc_sigpending_tsk keeps signal_pending set, and every thread will
get into handle_group_stop.  The (SIGNAL_GROUP_EXIT | SIGNAL_GROUP_EXEC)
check there can just do_exit directly, instead of using the fatal signal path.
I'm inclined to get rid of zap_other_threads, since the part of it common
to both callers (de_thread and do_group_exit) will be just:

	for (t = next_thread(p); t != p; t = next_thread(t))
		if (!unlikely(t->exit_state))
			signal_wake_up(t, 1);

(The exit_signal business in the zap_other_threads loop is already dead
cruft, because ->exit_signal is always -1 in non-leader threads nowadays.)

If this makes sense to you, I'll rework my patch along these lines.  
But it seems like it will be easiest to do it after your other coredump and
de_thread changes are all resolved.

Also, I've realized that the same lost signal issue can occur for stop
signals.  There it's real hard to see what can be done other than trying to
stuff the signal back on the queue, which I've said is problematical.
I need to think about this more.


Thanks again,
Roland
