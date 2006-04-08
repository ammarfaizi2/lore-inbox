Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWDHQIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWDHQIq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 12:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWDHQIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 12:08:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:1229 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965003AbWDHQIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 12:08:45 -0400
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
References: <20060406220403.GA205@oleg>
	<m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
	<20060407234653.GB11460@oleg> <20060407155113.37d6a3b3.akpm@osdl.org>
	<20060407155619.18f3c5ec.akpm@osdl.org>
	<m1d5fslcwx.fsf@ebiederm.dsl.xmission.com> <20060408172745.GA89@oleg>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 08 Apr 2006 10:07:33 -0600
In-Reply-To: <20060408172745.GA89@oleg> (Oleg Nesterov's message of "Sat, 8
 Apr 2006 21:27:45 +0400")
Message-ID: <m1r748jbju.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 04/08, Eric W. Biederman wrote:
>>
>> Agreed.  That is ugly.
>
> Yes, I agree also.
>
>>
>> -#define thread_group_leader(p)	(p->pid == p->tgid)
>> +#define thread_group_leader(p)	(p == p->group_leader)
>>
>> ...
>>
>> -		leader->group_leader = leader;
>> +		leader->group_leader = current;
>
> I thought about similar change too, but I am unsure about
> release_task(old_leader)->proc_flush_task() path (because
> I don't understand this code).

proc_flush_task() is purely an optimization to kill the
proc dcache entries when a process exits.  So we don't
plug up the dcache with old proc entries.

All it looks at currently and pid an tgid.

So proc_flush_task() should not be a non-issue.

proc_pid_unhash() in -linus is a little more
serious but it only unhashes things.

> This change can confuse next_tid(), but this is minor.
> I don't see other problems.

next_tid?

> However, I think we can do something better instead of
> attach_pid(current)/detach_pid(leader):
>
> 	void exec_pid(task_t *old, task_t * new, enum pid_type type)
> 	{
> 		new->pids[type].pid = old->pids[type].pid;
> 		hlist_replace_rcu(&old->pids[type].node, &new->pids[type].node);
> 		old->pids[type].pid = NULL;
> 	}
>
> So de_thread() can do
>
> 	exec_pid(leader, current, PIDTYPE_PGID);
> 	exec_pid(leader, current, PIDTYPE_SID);
>
> This allows us to iterate over pgrp/session lockless without
> seeing the same task twice, btw. But may be it is just unneeded
> complication.

I think it may be worthwhile.  Currently we can't do any process
group or session traversal lockless so it isn't worth looking
at until we get the bug fix handled.

Ultimately I think I would like PGID and SID to live in ->signal
in which case we would not need to touch them at all.

>> This requires changing the leaders parents
>>
>>  		current->parent = current->real_parent = leader->real_parent;
>> -		leader->parent = leader->real_parent = child_reaper;
>> +		leader->parent = leader->real_parent = current;
>>  		current->group_leader = current;
>
> I don't understand why do we need this change.

I was just trying to come as close as I could to normal
thread semantics.  The fewer special cases in de_thread,
the fewer problems it is.

> Actually, I think leader doesn't need reparenting at all.
> ptrace_unlink(leader) already restored leader->parent = ->real_parent
> and ->sibling. So I think we can do (for review only, should go in a
> separate patch) this:

Duh.  All processes in a thread group share the same real_parent.
It looks like the only practical thing we accomplish
with remove_parent/add_parent is to change our place on
our parents list of children.

Since ptrace_link and ptrace_unlink already does this we don't have a
guaranteed order on that list, so skipping the order change
should definitely be safe.

This means your patch doesn't go far enough.  We should be
able to kill all of the parent list manipulation in
de_thread.   Doing reduces the places that assign
real_parent to just fork and exit.

Eric
