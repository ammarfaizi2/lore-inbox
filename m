Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWDKJtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWDKJtm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 05:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbWDKJtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 05:49:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:7357 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750702AbWDKJtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 05:49:41 -0400
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
In-Reply-To: Oleg Nesterov's message of  Tuesday, 11 April 2006 17:13:43 +0400 <20060411131343.GA113@oleg>
X-Antipastobozoticataclysm: Bariumenemanilow
Message-Id: <20060411094937.3D4541809BB@magilla.sf.frob.com>
Date: Tue, 11 Apr 2006 02:49:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I still think we are ok with no ptrace. If that (non-coredump) signal was
> delivered before de_thread sets SIGNAL_GROUP_EXIT, then this flag is set
> by __group_complete_signal(), so de_thread return -EAGAIN. If de_thread()
> wins, the signal will be dequeued later from ->shared_pending.

There is no guarantee that __group_complete_signal gets to that code path
when the signal is generated.  There may be no thread that doesn't have it
blocked nor is already descheduled with pending signals.  Then some thread
gets scheduled, or changes it signal mask, and then gets into
get_signal_to_deliver and takes the siglock either before an exec'ing
thread gets the lock, or while the exec'ing thread releases it to wait.
When the dequeuer thread releases the siglock, we have the race window.
(There is another similar case if the signal was handled at generation time
and the handler is reset to SIG_DFL later in a race with another thread
dequeuing the signal and a third doing an exec.)


Thanks,
Roland

