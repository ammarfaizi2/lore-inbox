Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWCGXCD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWCGXCD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 18:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751822AbWCGXCD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 18:02:03 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:65245 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751594AbWCGXCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 18:02:02 -0500
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
	<44074479.15D306EB@tv-sign.ru>
	<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
	<440CA459.6627024C@tv-sign.ru>
	<m1fylu2ybx.fsf@ebiederm.dsl.xmission.com>
	<440DF4F8.1DC7F5A5@tv-sign.ru>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 07 Mar 2006 16:00:37 -0700
In-Reply-To: <440DF4F8.1DC7F5A5@tv-sign.ru> (Oleg Nesterov's message of
 "Wed, 08 Mar 2006 00:02:48 +0300")
Message-ID: <m1wtf5zwq2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> writes:

> "Eric W. Biederman" wrote:
>> 
>>  struct pid
>>  {
>> +       atomic_t count;
>>         /* Try to keep pid_chain in the same cacheline as nr for find_pid */
>>         int nr;
>>         struct hlist_node pid_chain;
>>         /* list of pids with the same nr, only one of them is in the hash */
>> -       struct list_head pid_list;
>> -       /* Does a weak reference of this type exist to the task struct? */
>> -       struct task_ref *tref;
>> +       struct list_head tasks[PIDTYPE_MAX];
>> +       struct rcu_head rcu;
>>  };
>>
>> ...
>>
>> +static void rcu_put_pid(struct rcu_head *rhp)
>> +{
>> +       struct pid *pid = container_of(rhp, struct pid, rcu);
>> +       put_pid(pid);
>> +}
>
> I hope we can do it without pid->rcu and rcu_put_pid(). Hopefuly
> we can use SLAB_DESTROY_BY_RCU. To do so we need some changes in
> find_task_by_pid_type().

I am fairly certain that SLAB_DESTROY_BY_RCU is a entire slab
operation, not something that applies on an individual slab
entry basis.

Delaying the decrement of the struct pid with call_rcu does have the
advantage that we can safely do an atomic_inc(&pid->count) after
looking up the pid.

> I'll try to look closer at this patch tomorrow.

Thanks.  One semi painful thing that has occurred to me is that
we may want to make the definition.

struct pid
{
       atomic_t count;
       /* Try to keep pid_chain in the same cacheline as nr for find_pid */
       int nr;
       struct hlist_node pid_chain;
       /* list of pids with the same nr, only one of them is in the hash */
       struct hlist_head tasks[PIDTYPE_MAX];
       struct rcu_head rcu;
};

Using a hlist_head for tasks cuts the size of the structure almost in
half.   Which for a long lived structure is a desirable property.
Unfortunately hlist_for_each_entry_rcu takes an additional argument,
compared to list_for_each_entry_rcu.

Eric

