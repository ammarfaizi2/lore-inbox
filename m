Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262990AbTC1PPA>; Fri, 28 Mar 2003 10:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263008AbTC1PPA>; Fri, 28 Mar 2003 10:15:00 -0500
Received: from mx1.elte.hu ([157.181.1.137]:17125 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262990AbTC1PO7>;
	Fri, 28 Mar 2003 10:14:59 -0500
Date: Fri, 28 Mar 2003 16:25:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Mike Galbraith <efault@gmx.de>, Andrew Morton <akpm@digeo.com>,
       Ed Tomlinson <tomlins@cam.org>, <linux-kernel@vger.kernel.org>,
       <linux-mm@kvack.org>
Subject: Re: 2.5.66-mm1
In-Reply-To: <Pine.LNX.4.50.0303280942420.2884-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.44.0303281619530.9943-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Mar 2003, Zwane Mwaikambo wrote:

> Hmm i think i may have his this one but i never posted due to being
> unable to reproduce it on a vanilla kernel or the same kernel afterwards
> (which was hacked so i won't vouch for it's cleanliness). I think
> preempt might have bitten him in a bad place (mine is also
> CONFIG_PREEMPT), is it possible that when we did the task_rq_unlock we
> got preempted and when we got back we used the local variable
> requeue_waker which was set before dropping the lock, and therefore
> might not be valid anymore due to scheduler decisions done after
> dropping the runqueue lock?

yes, this one was my only suspect, but it should really never cause any
problems. We might change sleep_avg during the wakeup, and carry the
requeue_waker flag over a preemptible window, but the requeueing itself
re-takes the runqueue lock, and does not take anything for granted. The
flag could very well be random as well, and the code should still be
correct - there's no requirement to recalculate the priority every time we
change sleep_avg. (in fact we at times intentionally keep those values
detached.)

	Ingo

