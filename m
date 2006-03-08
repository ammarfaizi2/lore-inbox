Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751019AbWCHROK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbWCHROK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 12:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbWCHROK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 12:14:10 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:3816 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751233AbWCHRNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 12:13:48 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH rc5-mm] pids: kill PIDTYPE_TGID
References: <440DEADB.72C3A8A6@tv-sign.ru>
	<m11wxd27wx.fsf@ebiederm.dsl.xmission.com>
	<440EED04.57FF5594@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 08 Mar 2006 09:19:56 -0700
In-Reply-To: <440EED04.57FF5594@tv-sign.ru> (Oleg Nesterov's message of
 "Wed, 08 Mar 2006 17:41:08 +0300")
Message-ID: <m1slpsx61f.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Eric W. Biederman wrote:
>>
>> Oleg Nesterov <oleg@tv-sign.ru> writes:
>>
>> > depends on
>> >
>> > 	pidhash-dont-count-idle-threads.patch
>> > 	pidhash-kill-switch_exec_pids.patch
>> >
>> > otherwise (I think) it is orthogonal to all tref/proc changes.
>>
>> You also depend on your recent change to call __unhash_process
>> under the sighand lock.  Since the ->tgrp is protected by
>> the sighand lock.
>
> Actually now I think it depends only on yours
> 	pidhash-kill-switch_exec_pids.patch
>
> This change (call __unhash_process under the sighand lock) does not
> touch __unhash_process() itself, it only moves the callsite. So this
> patch can go before or after this change. However it needs other
> patches from -mm to avoid rejects.

Agreed.  I misread the code and didn't see that we had the tasklist_lock where
you did the list_add.  

>> > This patch kills PIDTYPE_TGID pid_type thus saving one hash table
>> > in kernel/pid.c and speeding up subthreads create/destroy a bit.
>> > It is also a preparation for the further tref/pids rework.
>> >
>> > This patch adds 'struct list_head tgrp' to 'struct task_struct'
>> > instead. Note that ->tgrp need not to be rcu safe.
>>
>> Is there a reason for this?  I think at least proc could easily
>> take advantage of an rcu safe implementation.
>>
>> Hmm.  At the moment proc is only taking the tasklist_lock during
>> traversal so we may have a problem with the list_add anyway.
>
> tasklist or ->sighand is enough to do threads traversal. Yes,
> adding _rcu suffix allows us to do it under rcu_read_lock().
> However the thread group will not be stable during this traversal,
> we can miss some newly created thread or hit an already unhashed
> one.

Right so if what we are doing is needs to be atomic we can't drop
the lock.  Which makes sense.

> Note also, that this loop:
> 
> 	t = task;
> 	do {
> 		...
> 		t = next_thread(t);
> 	} while (t != task);
>
> requires that task->tgrp is stable (I mean, 'task' must not be
> unhashed during this loop). And I can't see how this is possible
> unless we take ->sighand or tasklist_lock or task == current.
>
> Eric, I know nothing about proc/, so the question is: do you want
> me to add _rcu right now, or do you think it's better to do this
> later?

Let's add the manipulations right now, that way we have the option
to convert the users that can take advantage of it.

> grepping for next_thread in proc/ I have the feeling that we can
> convert the code from:
>
> 	read_lock(tasklist);
> 	if (pid_alive(task)) {
> 		do ... while (t != task);
> 	}
> 	read_unlock(tasklist);
>
> to:
>
> 	rcu_read_lock();
> 	if (lock_task_sighand(task)) {
> 		...
> 		unlock_task_sighand(task);
> 	}
> 	rcu_read_unlock();
>
> But again, I don't understand this code.

For proc we don't even need the lock_task_sighand.  It is purely best
effort.  The more we can remove lock contention from proc the harder it
will be for a user space application to trigger long lock hold
times.

>> Also could we name the member not ->tgrp but ->threads?
>> I keep half expecting tgrp to be a number, and have a hard
>> time not mispelling it tpgrp.
>
> Agreed. I also started with 'threads' name, but we already have
> 'struct thread_struct thread' in the task_struct. So may be
> we could name it thread_group? I am rather agnostic and have nothing
> against 'threads', will resend this patch after yours decision.

Ok.  Let's go with thread_group.  It isn't a frequently used field
so as long as the name doesn't get terribly long things will work,
and thread_group is still much shorter than it's current name :)

Eric
