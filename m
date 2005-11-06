Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVKFKr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVKFKr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 05:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932345AbVKFKr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 05:47:59 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:54944 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932340AbVKFKr6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 05:47:58 -0500
Message-ID: <436DF0A6.342717A6@tv-sign.ru>
Date: Sun, 06 Nov 2005 15:01:42 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: paulmck@us.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org, dipankar@in.ibm.com, suzannew@cs.pdx.edu
Subject: Re: [PATCH] Fixes for RCU handling of task_struct
References: <20051031020535.GA46@us.ibm.com> <20051031140459.GA5664@elte.hu> <20051031205119.5bd897f3.akpm@osdl.org> <20051103190916.GA13417@us.ibm.com> <436B9D5D.3EB28CD5@tv-sign.ru> <20051104200801.GA16092@us.ibm.com> <436CDEAC.A7D56A94@tv-sign.ru> <20051105232027.GA20178@us.ibm.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Paul E. McKenney" wrote:
> 
> So the idea is to error out of send_sigqueue() so that posix_timer_event()
> will instead call send_group_sigqueeue().  But that could suffer from
> the same race if the new leader thread also exits -- or if the exiting
> thread was the leader thread to begin with.

The case when leader exits is ok. If it is the only (last) thread - it will
call exit_itimers(). If not - it (or sys_wait4 from parent) will not call
release_task(), but will stay TASK_ZOMBIE with valid ->signal/sighand until
the last thread in same thread group exits (and call exit_itimers).

> But once send_group_sigqueue() read-acquires tasklist_lock, threads
> and processes must stay put.  So it should be possible to follow the
> ->group_leader chain at that point.

Not quite so, I think. See below.

> Except that the group leader could do an exec(), right?  If it does so,
> it must do so before tasklist_lock is read-acquired.  So the nightmare
> case is where all but one thread exits, and then that one thread does
> and exec().

... and that thread is not group leader. Actually, it does not matter
if other threads exited or not, execing thread will kill other threads.

> If this case can really happen, we want to drop the signal
> on the floor, right?

I think yes.

> diff -urpNa -X dontdiff linux-2.6.14-mm0-fix/kernel/signal.c linux-2.6.14-mm0-fix-2/kernel/signal.c
> --- linux-2.6.14-mm0-fix/kernel/signal.c        2005-11-04 17:23:40.000000000 -0800
> +++ linux-2.6.14-mm0-fix-2/kernel/signal.c      2005-11-05 15:05:38.000000000 -0800
> @@ -1408,6 +1408,11 @@ send_sigqueue(int sig, struct sigqueue *
> 
>  retry:
>         sh = rcu_dereference(p->sighand);
> +       if (sh == NULL) {
> +               /* We raced with pthread_exit()... */
> +               ret = -1;
> +               goto out_err;
> +       }

I lost the plot. Because I can't apply this and previous patches (rejects)
and can't imagine how send_sigqueue() looks now. I think this is ok, but
we also need to re-check ->signal != NULL after lock(->sighand) or check
PF_EXITING (iirc ve do have such check).

> @@ -1474,7 +1479,8 @@ send_group_sigqueue(int sig, struct sigq
>         BUG_ON(!(q->flags & SIGQUEUE_PREALLOC));
> 
>         read_lock(&tasklist_lock);
> -       /* Since it_lock is held, p->sighand cannot be NULL. */
> +       while (p->group_leader != p)
> +               p = p->group_leader;

No, this is definitely not right. de_thread() does not change leader->group_leader
when non-leader execs, so p->group_leader == p always.

Oleg.
