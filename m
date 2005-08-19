Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVHSNQo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVHSNQo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 09:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbVHSNQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 09:16:44 -0400
Received: from mail.tv-sign.ru ([213.234.233.51]:48327 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932239AbVHSNQn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 09:16:43 -0400
Message-ID: <4305DE3C.EC56B48C@tv-sign.ru>
Date: Fri, 19 Aug 2005 17:27:24 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Ingo Molnar <mingo@elte.hu>, Dipankar Sarma <dipankar@in.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC,PATCH] Use RCU to protect tasklist for unicast signals
References: <42FB41B5.98314BA5@tv-sign.ru> <20050812015607.GR1300@us.ibm.com> <42FC6305.E7A00C0A@tv-sign.ru> <20050815174403.GE1562@us.ibm.com> <4301D455.AC721EB7@tv-sign.ru> <20050816170714.GA1319@us.ibm.com> <20050817014857.GA3192@us.ibm.com> <43034B17.3DEE0884@tv-sign.ru> <20050817211957.GN1300@us.ibm.com> <43047570.4089FCF1@tv-sign.ru> <20050819012918.GG1372@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
>
> I have indeed been thinking along these lines, but all of the devil plans
> that I have come up thus far are quite intrusive, and might have some
> performance problems in some situations.  So it seems best to remove
> tasklist_lock in steps:
>
> 1.	Single-recipient catch and ignore cases.
>
> 2.	Single-recipient stop/continue cases.
>
> 3.	Single-recipient fatal cases.
>
> 4.	Single-process multi-threaded stop/continue cases.
>
> 5.	Single-process multi-threaded fatal cases.
>
> 6.	And on to process-group cases.

Paul, I am not an expert at all, but honestly I don't see how
this could be achieved. This lock is heavily overloaded for
quite different purposes. I think that may be it makes sense
to try other steps, for example (random order):

  1. Tasklist protects ->sighand changing (de_thread) - rework
     sighand access/locking.

  2. Tasklist protects reparenting - fix this.

  .......

  N. PTRACE!!! Well, I close my eyes immediately when I see this
     word in the sources.

Only then we can eliminate tasklist locking from signal sending
path. But I don't see the easy way to solve any of these 1 - N
problems.

Currently I don't see how your patch could be "fixed" for SIGCONT
case, except very ugly:

	kill_proc_info(sig)
	{
		p = find_task_by_pid(pid);
		if (sig == SIGCONT)
			read_lock(&tasklist_lock);

		error = group_send_sig_info(...);
		...
	}

But there are other problems too.

Look at __group_complete_signal(), it scans p->pids[PIDTYPE_TGID].pid_list
list to find a a suitable thread. What if 'p' does clone(CLONE_THREAD) now?
Let's look at copy_process(), it does attach_pid(p, PIDTYPE_TGID, p->tgid)
under the lovely tasklist_lock again.

So, I don't beleive we can solve even the simplest case (single-recipient,
non fatal, non stop/cont) without significant locking rework.

I hope that your patch will stimulate this work.

Oleg.
