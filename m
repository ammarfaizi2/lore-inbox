Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964951AbWA3U2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWA3U2J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 15:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964952AbWA3U2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 15:28:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36742 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964951AbWA3U2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 15:28:08 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] exec: Cleanup exec from a non thread group leader.
References: <43DDFDE3.58C01234@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 30 Jan 2006 13:27:30 -0700
In-Reply-To: <43DDFDE3.58C01234@tv-sign.ru> (Oleg Nesterov's message of
 "Mon, 30 Jan 2006 14:52:03 +0300")
Message-ID: <m1zmld5uml.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Eric W. Biederman wrote:
>>
>> And for good measure we set the thread group leaders
>> exit_signal to -1 so it will self reap.  We are actually
>> past the point where that matters but it can't hurt, and
>> it might help someday.
>> ...
>>               leader->exit_state = EXIT_DEAD;
>> +             leader->exit_signal = -1;
>
> I disagree. The leader is already practically reaped, it is EXIT_DEAD.
> I think this change will confuse the reader who will try to understand
> why do we need this subtle assignment.

Six of one half dozen of the other.  It doesn't matter so I don't
care.

>>  void switch_exec_pids(task_t *leader, task_t *thread)
>>  {
>> -	__detach_pid(leader, PIDTYPE_PID);
>> -	__detach_pid(leader, PIDTYPE_TGID);
>> -	__detach_pid(leader, PIDTYPE_PGID);
>> -	__detach_pid(leader, PIDTYPE_SID);
>> -
>> -	__detach_pid(thread, PIDTYPE_PID);
>> -	__detach_pid(thread, PIDTYPE_TGID);
>> -
>> -	leader->pid = leader->tgid = thread->pid;
>> -	thread->pid = thread->tgid;
>> -
>> -	attach_pid(thread, PIDTYPE_PID, thread->pid);
>> -	attach_pid(thread, PIDTYPE_TGID, thread->tgid);
>> +	detach_pid(thread, PIDTYPE_PID);
>> +	thread->pid = leader->pid;
>> +	attach_pid(thread, PIDTYPE_PID,  thread->pid);
>>  	attach_pid(thread, PIDTYPE_PGID, thread->signal->pgrp);
>> -	attach_pid(thread, PIDTYPE_SID, thread->signal->session);
>> -	list_add_tail(&thread->tasks, &init_task.tasks);
>
> The last deletion is wrong, I beleive.

list_add_tail is duplicate code.  It is already present in the caller.
So it is noise and confusing to leave it here.
But you already noted that in the following email.


>> +	attach_pid(thread, PIDTYPE_SID,  thread->signal->session);
>>  
>> -	attach_pid(leader, PIDTYPE_PID, leader->pid);
>> -	attach_pid(leader, PIDTYPE_TGID, leader->tgid);
>> -	attach_pid(leader, PIDTYPE_PGID, leader->signal->pgrp);
>> -	attach_pid(leader, PIDTYPE_SID, leader->signal->session);
>> +	detach_pid(leader, PIDTYPE_PID);
>> +	detach_pid(leader, PIDTYPE_TGID);
>> +	detach_pid(leader, PIDTYPE_PGID);
>> +	detach_pid(leader, PIDTYPE_SID);
>>  }
>
> I think most of detach_pid()s could be replaced with __detach_pid(),
> this will save unneccesary pid_hash scanning

Actually 90% of the point was to remove the need for __detach_pid.
But you are right __detach_pid would be safe and we know that because
of the ordering.  At the same time because we are not the last reference
the code will never do that.

I need to relook at this.  To not conflict with your code some of
the detach_pids need to be removed so we don't unhash things twice.

Eric
