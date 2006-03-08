Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030222AbWCHWOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWCHWOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 17:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030226AbWCHWOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 17:14:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63210 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030222AbWCHWOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 17:14:10 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH rc5-mm] pids: kill PIDTYPE_TGID
References: <440DEADB.72C3A8A6@tv-sign.ru>
	<m11wxd27wx.fsf@ebiederm.dsl.xmission.com>
	<440EED04.57FF5594@tv-sign.ru>
	<m1slpsx61f.fsf@ebiederm.dsl.xmission.com>
	<440F2F4A.3E91C272@tv-sign.ru>
	<m1irqovh8l.fsf@ebiederm.dsl.xmission.com>
	<440F50A7.EBAD87D5@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Mar 2006 15:12:59 -0700
In-Reply-To: <440F50A7.EBAD87D5@tv-sign.ru> (Oleg Nesterov's message of
 "Thu, 09 Mar 2006 00:46:15 +0300")
Message-ID: <m1zmk0twk4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Eric W. Biederman wrote:
>>
>> >               p->group_leader = current->group_leader;
>> > +             list_add_tail_rcu(&p->thread_group, &current->thread_group);
>> Can this be:
>> list_add_tail_rcu(&p->thread_group, &current->group_leader->thread_group);
>
> Done.
>
>> That way at least the odds of missing a new task_struct when doing an
>> rcu traversal are reduced almost to 0.
>
> Am I understand correctly? This change has effect when we are doing the
> traversal starting from ->group_leader in a "best effort" manner lockless,
> yes?

Yes.  The important point for reasoning about it is that we have a fixed
point that we append or prepend to.

I think I have finally figured out the invariants we will need to
send signals using just the rcu_read_lock().  In that case we want to
traverse the list in such a way that we are guaranteed to never see
new entries.  That gives us an atomic snapshot of the tasks to send
signals to, and it gives us a progress guarantee.

Now I need to look and see if any one has documented any rules
regarding atomicity of sending signals to a group of processes.


> [PATCH rc5-mm] pids: kill PIDTYPE_TGID
>
> depends on pidhash-dont-count-idle-threads.patch
>
> This patch kills PIDTYPE_TGID pid_type thus saving one hash table
> in kernel/pid.c and speeding up subthreads create/destroy a bit.
> It is also a preparation for the further tref/pids rework.
>
> This patch adds 'struct list_head thread_group' to 'struct task_struct'
> instead.
>
> We don't detach group leader from PIDTYPE_PID namespace until another
> thread inherits it's ->pid == ->tgid, so we are safe wrt premature
> free_pidmap(->tgid) call.
>
> Currently there are no users of find_task_by_pid_type(PIDTYPE_TGID).
> Should the need arise, we can use find_task_by_pid()->group_leader.
>
>  include/linux/pid.h   |    1 -
>  include/linux/sched.h |   11 ++++++++---
>  kernel/exit.c         |   10 +---------
>  kernel/fork.c         |    4 +++-
>  4 files changed, 12 insertions(+), 14 deletions(-)
>
> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

Acked-By: Eric Biederman <ebiederm@xmission.com>
