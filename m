Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161231AbWG1TAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161231AbWG1TAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 15:00:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161241AbWG1TAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 15:00:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:38411 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161231AbWG1TAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 15:00:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:date:x-x-sender:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type:from;
        b=U5bwczRCWdq1UaXldZtyDFKKcV5orV6ZSb0uToJBBjgcWaQy+jYxA/qDGq9esznL8I0lZx28jr3BASI1XuRrjtOcoF0xZcj7xOEUm8/bEPDyjHLgxJiPaeTnU6+CyjvPZtnXQPfDzvu/tVsDgXyor2QxODz79YXhf9XcsWw/Cso=
Date: Fri, 28 Jul 2006 21:00:31 +0100 (BST)
X-X-Sender: simlo@localhost.localdomain
To: "Paul E. McKenney" <paulmck@us.ibm.com>
cc: Esben Nielsen <nielsen.esben@googlemail.com>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, rostedt@goodmis.org, dipankar@in.ibm.com,
       billh@gnuppy.monkey.org, mingo@elte.hu, tytso@us.ibm.com,
       dvhltc@us.ibm.com
Subject: Re: [RFC, PATCH, -rt] Early prototype RCU priority-boost patch
In-Reply-To: <20060728155220.GC1289@us.ibm.com>
Message-ID: <Pine.LNX.4.64.0607282051300.11593@localhost.localdomain>
References: <20060728001918.GA2634@us.ibm.com>
 <Pine.LNX.4.64.0607281222580.10047@localhost.localdomain>
 <20060728155220.GC1289@us.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
From: Esben Nielsen <nielsen.esben@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006, Paul E. McKenney wrote:

> On Fri, Jul 28, 2006 at 12:38:33PM +0100, Esben Nielsen wrote:
>> Hi,
>>  I have considered an idea to make this work with the PI: Add the ability
>> to at a waiter not refering to a lock to the PI list. I think a few
>> subsystems can use that if they temporarely want to boost a task in a
>> consistend way (HR-timers is one). After a little renaming getting the
>> boosting part seperated out of rt_mutex_waiter:
>>
>>  struct prio_booster {
>> 	struct plist_node	booster_list_entry;
>>  };
>>
>>  void add_prio_booster(struct task_struct *, struct prio_booster *booster);
>>  void remove_prio_booster(struct task_struct *, struct prio_booster
>> *booster);
>>  void change_prio_booster(struct task_struct *, struct prio_booster
>> *booster, int new_prio);
>>
>> (these functions takes care of doing/triggering a lock chain traversal if
>> needed) and change
>>
>>  struct rt_mutext_waiter {
>>     ...
>>     struct prio_booster booster;
>>     ...
>>  };
>
> I must defer to Ingo, Thomas, and Steve Rostedt on what the right thing
> to do is here, but I do much appreciate the pointers!
>
> If I understand what you are getting at, this is what I would need to
> do to in order to have a synchronize_rcu() priority-boost RCU readers?
> Or is this what I need to legitimately priority-boost RCU readers in
> any case (for example, to properly account for other boosting and
> deboosting that might happen while the RCU reader is priority boosted)?
>
> Here are the RCU priority-boost situations I see:
>
> 1.	"Out of nowhere" RCU-reader priority boost.  This is what
> 	the patch I submitted was intended to cover.  If I need your
> 	prio_booster struct in this case, then I would need to put
> 	one in the task structure, right?
>
> 	Would another be needed to handle a second boost?  My guess
> 	is that the first could be reused.

Yes, put one in the task structure and use change_prio_booster().
>
> 2.	RCU reader boosting a lock holder.  This ends up being a
> 	combination of #1 (because the act of blocking on a lock implies
> 	an "out of nowhere" priority boost) and normal lock boosting.
>

That is the normal chain walking of the PI code. It is basicly already 
handled there.

> 3.	A call_rcu() or synchronize_rcu() boosting all readers.  I am
> 	not sure we really need this, but in case we do...  One would
> 	need an additional prio_booster for each task to be boosted,
> 	right?  This would seem to require an additional prio_booster
> 	struct in each task structure.
>
> Or am I off the mark here?

Hmm, yes.
You would need a list of all preempted rcu-readers per CPU.
Then you need to use change_prio_booster() on all of them. However, you 
can do it on the first now, and then update the next at next schedule etc. 
Each CPU can only run one of these tasks until it calls schedule() 
anyways :-)

>
>> There are issues with lock orderings between task->pi_lock (which should
>> be renamed to task->prio_lock) and rq->lock. The lock ordering probably
>> have to be reversed, thus integrating the boosting system directly into
>> the scheduler instead of into rtmutex-subsystem.
>
> This does sound a bit scary.  What exactly am I adding that would motivate
> inverting the lock ordering?

I came to think about it, it might not be so good an idea. In the 
rtmutex the lock order is task->pi_lock then rq->lock. But if it should 
probably the scheduler ought take next->prio_lock, so it can avoid 
moving a boosted task down in priority below the boost. But when it does 
that it already has the rq->lock. On the other hand a trylock would 
probably work and if that in rare cicumstances fail it can release the 
rq->lock and jump back and try again.
So probably no reversal of lock ordering is needed.

Esben

>
> 							Thanx, Paul
>
