Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266561AbUBQTzu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUBQTzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:55:50 -0500
Received: from [63.107.13.101] ([63.107.13.101]:13445 "EHLO mail.metavize.com")
	by vger.kernel.org with ESMTP id S266561AbUBQTze (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:55:34 -0500
Message-ID: <403271B2.3040107@metavize.com>
Date: Tue, 17 Feb 2004 11:55:30 -0800
From: Dirk Morris <dmorris@metavize.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031221 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.2] Badness in futex_wait revisited
References: <20040217051911.6AC112C066@lists.samba.org>
In-Reply-To: <20040217051911.6AC112C066@lists.samba.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I installed this patch. (which gives be lots of Badness in sched.c errors)

Here is the dump of what I believe is the offending awakening:

Feb 17 10:49:09 timmy kernel: iptables 0 waking foobar: 898 898
Feb 17 10:49:09 timmy kernel: Badness in try_to_wake_up at 
kernel/sched.c:666
Feb 17 10:49:09 timmy kernel: Call Trace:
Feb 17 10:49:09 timmy kernel:  [<c0117e79>] try_to_wake_up+0x1b9/0x1c0
Feb 17 10:49:09 timmy kernel:  [<c0117eba>] wake_up_state+0x1a/0x20
Feb 17 10:49:09 timmy kernel:  [<c0126358>] do_notify_parent+0x3f8/0x530
Feb 17 10:49:09 timmy kernel:  [<c013fb03>] unmap_page_range+0x43/0x70
Feb 17 10:49:09 timmy kernel:  [<c014ede9>] __fput+0x99/0xf0
Feb 17 10:49:09 timmy kernel:  [<c011d831>] exit_notify+0x211/0x750
Feb 17 10:49:09 timmy kernel:  [<c011d31e>] put_files_struct+0x8e/0xc0
Feb 17 10:49:09 timmy kernel:  [<c011df0c>] do_exit+0x19c/0x370
Feb 17 10:49:09 timmy kernel:  [<c011e113>] sys_exit+0x13/0x20
Feb 17 10:49:09 timmy kernel:  [<c010922b>] syscall_call+0x7/0xb

foobar makes a system("iptables -t nat -L") like call from one pthread.
Around this time... Some other thread (or possibly the same one?) gets 
an EINTR from sem_wait.

I am still unable to replicate this in a simple test program.
It also seems that the Badness in futex_wait message is only printed 
some of the time.

This is with SMP and preempt off. (again, doesnt happen in old 2.2.x libc)

I also have pages worth of other taking debug messages if anyone would 
like them.
Let me know if I can help further.

-Dirk

Rusty Russell wrote:

>In message <40311703.8070309@metavize.com> you write:
>  
>
>>Please send me the patch, and I'll give you some updated information.
>>    
>>
>
>Here it is: Andrew's patch updated and fixed.
>
>Thanks!
>Rusty.
>--
>  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
>
>Name: Who's Spuriously Waking Futexes?
>Author: Andrew Morton, Rusty Russell
>Status: Tested on 2.6.3-bk1
>
>Someone is triggering the WARN_ON() in futex.c.  We know that software
>suspend could do it, in theory.  But noone else should be.
>
>This code adds a PF_FUTEX_DEBUG flag, which is set in the futex code
>when we sleep, and also when we wake up.  If a task with
>PF_FUTEX_DEBUG is woken by a task without PF_FUTEX_DEBUG, we have
>found our culprit.
>
>diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6375-linux-2.6.3-rc3-bk1/include/linux/sched.h .6375-linux-2.6.3-rc3-bk1.updated/include/linux/sched.h
>--- .6375-linux-2.6.3-rc3-bk1/include/linux/sched.h	2004-02-15 18:17:21.000000000 +1100
>+++ .6375-linux-2.6.3-rc3-bk1.updated/include/linux/sched.h	2004-02-17 12:01:47.000000000 +1100
>@@ -500,6 +500,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
> #define PF_SWAPOFF	0x00080000	/* I am in swapoff */
> #define PF_LESS_THROTTLE 0x00100000	/* Throttle me less: I clean memory */
> #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
>+#define PF_FUTEX_DEBUG	0x00400000
> 
> #ifdef CONFIG_SMP
> extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
>diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6375-linux-2.6.3-rc3-bk1/kernel/futex.c .6375-linux-2.6.3-rc3-bk1.updated/kernel/futex.c
>--- .6375-linux-2.6.3-rc3-bk1/kernel/futex.c	2004-02-15 18:17:21.000000000 +1100
>+++ .6375-linux-2.6.3-rc3-bk1.updated/kernel/futex.c	2004-02-17 12:01:47.000000000 +1100
>@@ -269,7 +269,11 @@ static void wake_futex(struct futex_q *q
> 	 * The lock in wake_up_all() is a crucial memory barrier after the
> 	 * list_del_init() and also before assigning to q->lock_ptr.
> 	 */
>+	
>+	current->flags |= PF_FUTEX_DEBUG;
> 	wake_up_all(&q->waiters);
>+	current->flags &= ~PF_FUTEX_DEBUG;
>+
> 	/*
> 	 * The waiting task can free the futex_q as soon as this is written,
> 	 * without taking any locks.  This must come last.
>@@ -490,8 +494,11 @@ static int futex_wait(unsigned long uadd
> 	 * !list_empty() is safe here without any lock.
> 	 * q.lock_ptr != 0 is not safe, because of ordering against wakeup.
> 	 */
>-	if (likely(!list_empty(&q.list)))
>+	if (likely(!list_empty(&q.list))) {
>+		current->flags |= PF_FUTEX_DEBUG;
> 		time = schedule_timeout(time);
>+		current->flags &= ~PF_FUTEX_DEBUG;
>+	}
> 	__set_current_state(TASK_RUNNING);
> 
> 	/*
>diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .6375-linux-2.6.3-rc3-bk1/kernel/sched.c .6375-linux-2.6.3-rc3-bk1.updated/kernel/sched.c
>--- .6375-linux-2.6.3-rc3-bk1/kernel/sched.c	2004-02-15 18:17:22.000000000 +1100
>+++ .6375-linux-2.6.3-rc3-bk1.updated/kernel/sched.c	2004-02-17 12:02:24.000000000 +1100
>@@ -658,6 +658,14 @@ static int try_to_wake_up(task_t * p, un
> 	long old_state;
> 	runqueue_t *rq;
> 
>+	if ((p->flags & PF_FUTEX_DEBUG)
>+	    && !(current->flags & PF_FUTEX_DEBUG)) {
>+		printk("%s %i waking %s: %i %i\n",
>+		       current->comm, (int)in_interrupt(),
>+		       p->comm, p->tgid, p->pid);
>+		WARN_ON(1);
>+	}
>+
> repeat_lock_task:
> 	rq = task_rq_lock(p, &flags);
> 	old_state = p->state;
>  
>

