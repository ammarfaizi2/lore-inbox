Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUKXClv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUKXClv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 21:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKXClv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 21:41:51 -0500
Received: from mx1.elte.hu ([157.181.1.137]:21151 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261693AbUKXClF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 21:41:05 -0500
Date: Wed, 24 Nov 2004 04:42:57 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Esben Nielsen <simlo@phys.au.dk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Priority Inheritance Test (Real-Time Preemption)
Message-ID: <20041124034257.GA12571@elte.hu>
References: <20041123133456.GA10453@elte.hu> <Pine.OSF.4.05.10411232343010.4816-100000@da410.ifa.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.OSF.4.05.10411232343010.4816-100000@da410.ifa.au.dk>
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

> I have an idea about what the error(s) is(are): In rt.c policy ==
> SCHED_NORMAL tasks are threaded specially. A task boosted into the
> real-time realm by mutex_setprio() is _still_ SCHED_NORMAL and do not
> gain all the privileges of a real-time task. I suggest that the tests
> on SCHED_NORMAL are replaced by using the rt_task() test which just
> looks at the current priority and thus also would be true on tasks
> temporarely boosted in the real-time realm. [...]

ah, indeed. I thought i fixed all these places but you are right that
there's one more instance remaining, in pick_new_owner():

+               if (w->task->policy == SCHED_NORMAL)
+                       break;

> [...] Another thing: A SCHED_NORMAL task will not be added to the
> pi_waiters list, but it ought to be when it is later boosted into the
> real-time realm. [...]

ok, this is an important one too. Fixing this bug will complicate
pi_setprio() some more, but should be pretty straightforward: the task
that is boosted can be blocked on a single rt-mutex at most.

i'll fix these bugs in the next release. Your systematic testing of PI
is very useful, it already uncovered _tons_ of PI bugs that would be
quite hard to find via normal testing.

> [...] Also, you ignore all tasks being SCHED_NORMAL in the tail of the
> wait list when you try to find the next owner: It could be that one of
> those is boosted.

correct.

> --- linux-2.6.10-rc2-mm2-V0.7.30-9/drivers/char/blocker.c.orig  2004-11-23 20:18:28.000000000 +0100
> +++ linux-2.6.10-rc2-mm2-V0.7.30-9/drivers/char/blocker.c       2004-11-23 20:41:57.742899751 +0100

thx, i'll add this too. Do you have uploaded the matching pi_test
userspace changes too? (url?)

	Ingo
