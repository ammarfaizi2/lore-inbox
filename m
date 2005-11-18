Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030594AbVKRJ3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030594AbVKRJ3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 04:29:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030598AbVKRJ3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 04:29:04 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:51177 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030594AbVKRJ3D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 04:29:03 -0500
Date: Fri, 18 Nov 2005 10:29:09 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Singleton <dsingleton@mvista.com>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051118092909.GC4858@elte.hu>
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437D0C59.1060607@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Singleton <dsingleton@mvista.com> wrote:

> >I was testing PI support in the -rt tree (-rt13) when I hit the BUG
> >below. I am using the BULL/Montavista glibc patches. However I would
> >think this can be reproduced using just plain FUTEX_WAKE/WAIT_ROBUST
> >APIs as well, though I havent tried.  I can send out the test code
> >if anybody is interested. I have attached the .config below.
> > 
> >

>    If I make the lock in the timer_base_s struct a raw spinlock this 
> BUG goes away.

that most likely just papers over the real bug. Given task-reference 
count bug i fixed in the robust/PI-futexes code (see the patch below) i 
suspect some more races and/or plain incorrect code.

[this patch below also converts the robust/PI-futex code to use RCU 
instead of the tasklist_lock - which should remove a major latency 
source from the futex code].

	Ingo

Index: linux/kernel/rt.c
===================================================================
--- linux.orig/kernel/rt.c
+++ linux/kernel/rt.c
@@ -2939,15 +2939,20 @@ EXPORT_SYMBOL(rt_mutex_owned_by);
  * and now own the lock, or negative values for failure, or positive
  * values for the amount of time we waited before getting the lock.
  */
-int fastcall down_futex(struct rt_mutex *lock, unsigned long time, pid_t owner_pid)
+int fastcall
+down_futex(struct rt_mutex *lock, unsigned long time, pid_t owner_pid)
 {
 	struct task_struct *owner_task = NULL;
 #ifdef CONFIG_DEBUG_DEADLOCKS
 	unsigned long eip = CALLER_ADDR0;
 #endif
-	read_lock(&tasklist_lock);
+	int ret;
+
+	rcu_read_lock();
 	owner_task = find_task_by_pid(owner_pid);
-	read_unlock(&tasklist_lock);
+	if (!get_task_struct_rcu(owner_task))
+		owner_task = NULL;
+	rcu_read_unlock();
 
 	if (!owner_task)
 		return -EOWNERDEAD;
@@ -2956,7 +2961,10 @@ int fastcall down_futex(struct rt_mutex 
 		__down_mutex(lock __EIP__);
 		rt_mutex_set_owner(lock, owner_task->thread_info);
 	}
-	return __down_interruptible(lock, time __EIP__);
+	ret = __down_interruptible(lock, time __EIP__);
+	put_task_struct(owner_task);
+
+	return ret;
 }
 EXPORT_SYMBOL(down_futex);
 
