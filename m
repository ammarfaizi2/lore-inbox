Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbWBBUJL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbWBBUJL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 15:09:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWBBUJL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 15:09:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56241 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932203AbWBBUJJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 15:09:09 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH] pidhash:  Kill switch_exec_pids
References: <m1r76lslhi.fsf@ebiederm.dsl.xmission.com>
	<43E26AB1.8509A175@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 02 Feb 2006 13:08:24 -0700
In-Reply-To: <43E26AB1.8509A175@tv-sign.ru> (Oleg Nesterov's message of
 "Thu, 02 Feb 2006 23:25:21 +0300")
Message-ID: <m13bj1sevb.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Eric W. Biederman wrote:
>>
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -699,7 +699,17 @@ static int de_thread(struct task_struct 
>>  		remove_parent(current);
>>  		remove_parent(leader);
>>  
>> -		switch_exec_pids(leader, current);
>> +
>> +		/* Become a process group leader with the old leader's pid.
>> +		 * Note: The old leader also uses thispid until release_task
>> +		 *       is called.  Odd but simple and correct.
>> +		 */
>> +		detach_pid(current, PIDTYPE_PID);
>> +		current->pid = leader->pid;
>> +		attach_pid(current, PIDTYPE_PID,  current->pid);
>
> What happens after de_thread() unlocks tasklist_lock and before
> it is taken again in release_task() ?
>
> In that window find_task_by_pid() will return dead leader, not
> the new leader of thread group. This means we can miss tkill()
> or ptrace(), for example.

A reasonable concern.  For some reason I had it in my
head that find_pid didn't need that tasklist_lock
but it does.  kthread and vmscan need to be fixed.

All I have done is enlarged the window where this
race is possible.  So for tkill I am not concerned,
as it wants a particular thread.  Nor am I concerned
about anything else that wants a particular thread.

The fact that the group_leader does not point
at the actual thread group leader might be a problem,
as I have opened a window where that is now the case.

For signals that is not a problem as signals are still shared.
This applies to most other resources as well.

Looking through all of the callers of find_task_by_pid
I couldn't see anything that looks like it cares.

So until we spot that case I'm ready to put this down
of one of those cases in de_thread that looks wrong
but happens to work.  Now if there is a way to make
it work more cleanly that may be worth looking at.


Eric

