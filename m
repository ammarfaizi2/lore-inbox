Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUIMJEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUIMJEH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 05:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266427AbUIMJEH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 05:04:07 -0400
Received: from asplinux.ru ([195.133.213.194]:5394 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id S266386AbUIMJD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 05:03:58 -0400
Message-ID: <41456536.6090801@sw.ru>
Date: Mon, 13 Sep 2004 13:15:34 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Roel van der Made <roel@telegraafnet.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, torvalds@osdl.org, wli@holomorphy.com
Subject: Re: [PATCH]: Re: kernel 2.6.9-rc1-mm4 oops
References: <20040912184804.GC19067@telegraafnet.nl> <4145550F.8030601@sw.ru> <20040913083100.GA16921@elte.hu>
In-Reply-To: <20040913083100.GA16921@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Kirill Korotaev <dev@sw.ru> wrote:

>>This patch removes sighand checks from the next_thread(), since they
>>are incorrect and has nothing to do with the next_thread() function.
>>So they could trigger BUG() when there were no actually bug at all.
> 
> the problem is, generally it is not valid to have a thread on the thread
> list that has no ->sighand structure. This is what happens when we exit
> a task:
> 
>         write_lock_irq(&tasklist_lock);
> 	...
>         __exit_sighand(p);
>         __unhash_process(p);

> the BUG() is useful for all the code that uses next_thread() - you can
> only do a safe next_thread() iteration if you've locked ->sighand.

1. I don't see spin_lock() on p->sighand->siglock in do_task_stat() 
before calling next_thread(). And the check inside next_thread() permits 
only one of the locks to be taken:

         if (!spin_is_locked(&p->sighand->siglock) &&
                                 !rwlock_is_locked(&tasklist_lock))

which is probably wrong, since tasklist_lock is always required!

2. I think the idea of checking sighand is quite obscure.
Probably it would be better to call pid_alive() for check at such places 
in proc, isn't it?

3. And yes, now I agree that this check and BUG() prevented 
next_thread() from walking through the deleted list_head in tsk->pid_list.

But I would propose to reorganize these checks in next_thread() to 
something like this:

if (!rwlock_is_locked(&tasklist_lock) || p->pids[PIDTYPE_TGID].nr == 0)
	BUG();

the last check ensures that we are still hashed and this check is more 
straithforward for understanding, agree?

4. If we do checks this way, then we can found strange proc numeric 
results. Suppose, you have read the do_task_stat() and it iterated 
through the threads and summed the times in this loop with 
next_thread(). Next, the thread dies and you can read the results w/o 
this loop and threads times, only this thread stats. Looks a bit 
invalid. Don't you think so?
Maybe we should return an error?

> so i believe your fix papers over the real bug which is the use of an
> almost-dead task for thread iterations. Since we've already done
> __unhash_process() not doing the BUG introduces a more subtle bug: the
> use of the stale PID pointers! So i believe the right fix is the one
> below, which (under the safety of read_lock(tasklock)) checks for the
> availability of task->sighand - and skips the thread iterations if so.
You patch is correct. Though I would like to hear on my previous notes 
about pid_alive().

Kirill

