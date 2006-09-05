Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWIELh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWIELh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 07:37:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbWIELh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 07:37:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43946 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751281AbWIELhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 07:37:55 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de,
       jdelvare@suse.de, Albert Cahalan <acahalan@gmail.com>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH] proc: readdir race fix
References: <20060825182943.697d9d81.kamezawa.hiroyu@jp.fujitsu.com>
	<m1y7sz4455.fsf@ebiederm.dsl.xmission.com>
	<20060905112621.b663bc7d.kamezawa.hiroyu@jp.fujitsu.com>
	<m14pvn3tam.fsf_-_@ebiederm.dsl.xmission.com>
	<20060905101050.GA128@oleg>
Date: Tue, 05 Sep 2006 05:36:55 -0600
In-Reply-To: <20060905101050.GA128@oleg> (Oleg Nesterov's message of "Tue, 5
	Sep 2006 14:10:50 +0400")
Message-ID: <m1r6yq35pk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> On 09/04, Eric W. Biederman wrote:
>> 
>> -static struct task_struct *next_tgid(struct task_struct *start)
>> -{
>> -	struct task_struct *pos;
>> +	task = NULL;
>>  	rcu_read_lock();
>> -	pos = start;
>> -	if (pid_alive(start))
>> -		pos = next_task(start);
>> -	if (pid_alive(pos) && (pos != &init_task)) {
>> -		get_task_struct(pos);
>> -		goto done;
>> +retry:
>> +	pid = find_next_pid(tgid);
>> +	if (pid) {
>> +		tgid = pid->nr + 1;
>> +		task = pid_task(pid, PIDTYPE_PID);
>> +		if (!task || !thread_group_leader(task))
>                               ^^^^^^^^^^^^^^^^^^^
> There is a window while de_thread() switches leadership, so next_tgid()
> may skip a task doing exec. What do you think about
>
>                              // needs a comment
> 		if (!task || task->pid != task->tgid)
> 			goto retry;
>
> instead? Currently first_tgid() has the same (very minor) problem.

I see the problem, and your test will certainly alleviate the symptom.
You are making the test has this process ever been a thread group leader.

I guess alleviating the symptom is all that is necessary there.

Grumble.  I hate that entire pid transfer case, too bad glibc cares.

If I could in the fix for this I would like to add a clean concept
that we are testing for wrapped in a helper function.  Otherwise
even with a big fat comment this will be easy to break next time
someone refactors the code.


>> +			goto retry;
>> +		get_task_struct(task);
>>  	}
>> -	pos = NULL;
>> -done:
>>  	rcu_read_unlock();
>> -	put_task_struct(start);
>> -	return pos;
>> +	return task;
>> +
>>  }
>
> Emply line before '}'
>
>> +struct pid *find_next_pid(int nr)
>> +{
>> +	struct pid *next;
>> +
>> +	next = find_pid(nr);
>> +	while (!next) {
>> +		nr = next_pidmap(nr);
>> +		if (nr <= 0)
>> +			break;
>> +		next = find_pid(nr);
>> +	}
>> +	return next;
>> +}
>
> This is strange that we are doing find_pid() before and at the end of loop,
> I'd suggest this code:
>
> 	struct pid *find_next_pid(int nr)
> 	{
> 		struct pid *pid;
>
> 		do {
> 			pid = find_pid(nr);
> 			if (pid != NULL)
> 				break;
> 			nr = next_pidmap(nr);
> 		} while (nr > 0);
>
> 		return pid;
> 	}
>
> Imho, a bit easier to read.
It is at least not worse, so it is probably worth doing.

Eric

