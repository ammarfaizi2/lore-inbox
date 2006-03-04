Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWCDKwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWCDKwX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 05:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbWCDKwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 05:52:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2726 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750716AbWCDKwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 05:52:22 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
	<44089798.F004D18B@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 04 Mar 2006 03:51:46 -0700
In-Reply-To: <44089798.F004D18B@tv-sign.ru> (Oleg Nesterov's message of
 "Fri, 03 Mar 2006 22:23:04 +0300")
Message-ID: <m1r75icwjh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> Eric W. Biederman wrote:
>>
>> +++ devel-akpm/kernel/task_ref.c	2006-02-27 20:28:59.000000000 -0800
>> @@ -0,0 +1,131 @@
>> +#include <linux/sched.h>
>> +#include <linux/task_ref.h>
>> +
>> +struct task_ref init_tref = {
>> +	.count = ATOMIC_INIT(1),
>> +	.type  = PIDTYPE_PID,
>> +	.pid   = 0,
>> +	.task  = NULL,
>> +};
>
> Make it static? Actually, I don't understand why init_tref is better
> than NULL. Yes, NULL will add some checks into task_ref.c, but we can
> avoid some costly atoimic ops.

init_tref isn't for task_ref.c so much as it is there to allow the
users of task_refs to avoid the checks.  I have enough helper
functions an appropriate helper instead of a well prescribed value
may be an equally valid approach.

>> +void tref_put(struct task_ref *ref)
>> +{
>> +	might_sleep();
>> +	if (atomic_dec_and_test(&ref->count)) {
>> +		struct task_struct *task;
>> +		BUG_ON(ref == &init_tref);
>> + /* Carefully serialize against __detach_pid and tref_get_by_pid */
>> +		write_lock_irq(&tasklist_lock);
>> +		task = ref->task;
>> +		if (task)
>> +			task->pids[ref->type].ref = NULL;
>> +		write_unlock_irq(&tasklist_lock);
>> +		kfree(ref);
>> +	}
>
> I think this is racy. Suppose ref->count == 1. What if another cpu does
> tref_get_by_task() between atomic_dec_and_test() and write_lock_irq() ?
> It takes tasklist_lock, increments ->count again, and returns the pointer
> to the memory which will be freed soon.

Agreed.  Grumble.  This needs to get fixed.

>> +struct task_ref *tref_get_by_pid(int pid, enum pid_type type)
>> +{
>> +	struct task_struct *task;
>> +	struct task_ref *tref;
>> +
>> +	/* Lookup the and pin the task */
>> +	read_lock(&tasklist_lock);
>> +	task = find_task_by_pid_type(type, pid);
>> +	if (task)
>> +		get_task_struct(task);
>> +	read_unlock(&tasklist_lock);
>> +
>> +	/* Now get the tref */
>> +	if (task) {
>> +		tref = tref_get_by_task(task, type);
>> +		put_task_struct(task);
>> +	}
>> +	else
>> +		tref = tref_get(&init_tref);
>> +	return tref;
>> +}
>
> I beleive this could be simplified, we don't need to get/put task_struct,
>
> 	rcu_read_lock();
>
> 	task = find_task_by_pid_type(type, pid);
> 	if (task)
> 		tref = tref_get_by_task(task, type);
> 	else
> 		tref = tref_get(&init_tref);
>
> 	rcu_read_unlock();

Nope kmalloc can sleep.

Eric

