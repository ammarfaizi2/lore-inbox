Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270981AbVBFHgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270981AbVBFHgn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 02:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262938AbVBFHgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 02:36:42 -0500
Received: from smtp209.mail.sc5.yahoo.com ([216.136.130.117]:26554 "HELO
	smtp209.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262481AbVBFHgX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 02:36:23 -0500
Message-ID: <4205C8EF.2000604@yahoo.com.au>
Date: Sun, 06 Feb 2005 18:36:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, bstroesser@fujitsu-siemens.com,
       roland@redhat.com, jdike@addtoit.com, blaisorblade_spam@yahoo.it,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix wait_task_inactive race (was Re: Race condition in
 ptrace)
References: <42021E35.8050601@fujitsu-siemens.com> <4202C18F.5010605@yahoo.com.au> <42036C2C.5040503@fujitsu-siemens.com> <4203F40C.8040707@yahoo.com.au> <20050204143917.1f9507cb.akpm@osdl.org> <4204020F.2000501@yahoo.com.au> <42044D17.5040703@yahoo.com.au> <42058E52.8030306@yahoo.com.au> <20050206071935.GA19991@elte.hu>
In-Reply-To: <20050206071935.GA19991@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>When a task is put to sleep, it is dequeued from the runqueue
>>while it is still running. The problem is that the runqueue
>>lock can be dropped and retaken in schedule() before the task
>>actually schedules off, and wait_task_inactive did not account
>>for this.
> 
> 
> ugh. This has been the Nth time we got bitten by the fundamental
> unrobustness of non-atomic scheduling on some architectures ...
> (And i'll say the N+1th time that this is not good.)
> 

This is actually due to wake_sleeping_dependent and
dependent_sleeper dropping the runqueue lock.

Actually idle_balance can (in rare cases) drop the lock as well,
which I didn't notice earlier, so it is something that we
have been doing forever. The smtnice locking has just exposed
the problem for us, so I wrongfully bashed it earlier *blush*.

> 
>>+static int task_onqueue(runqueue_t *rq, task_t *p)
>>+{
>>+	return (p->array || task_running(rq, p));
>>+}
> 
> 
> the fix looks good, but i'd go for the simplified oneliner patch below. 
> I dont like the name 'task_onqueue()', a because a task is 'on the
> queue' when it has p->array != NULL. The task is running when it's
> task_running().  On architectures with nonatomic scheduling a task may
> be running while not on the queue and external observers with the
> runqueue lock might notice this - and wait_task_inactive() has to take
> care of this case. I'm not sure how introducing a function named
> "task_onqueue()" will make the situation any clearer.
> 
> ok?
> 

Well just because there is a specific condition that both callsites
require. That is, the task is neither running nor on the runqueue.

While task_onqueue is technically wrong if you're looking down into
the fine details of the priority queue management, I think it is OK
to go up a level of abstraction and say that the task is
"on the runqueue" if it is either running or waiting to run.

It is really the one condition that is made un-intuitive due to the
locking in schedule(), so I thought formalising it would be better.
Suggestions for a better name welcome? ;)

Your one liner would fix the problem too, of course. The important
thing at this stage is that it gets fixed for 2.6.11.

Thanks,
Nick


