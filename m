Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267558AbUIGKsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267558AbUIGKsd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 06:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267833AbUIGKsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 06:48:33 -0400
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:52159 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S267558AbUIGKrb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 06:47:31 -0400
Date: Tue, 07 Sep 2004 19:47:23 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Kernel bug in futex_wait, cause application hang with NPTL
In-reply-to: <20040907060455.GA25073@elte.hu>
To: Ingo Molnar <mingo@elte.hu>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Ulrich Drepper <drepper@redhat.com>,
       Roland McGrath <roland@redhat.com>, Jakub Jelinek <jakub@redhat.com>
Message-id: <413D91BB.3000407@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: ja, en-us, en
User-Agent: Mozilla Thunderbird 0.7.3 (Windows/20040803)
References: <413BC346.5090708@jp.fujitsu.com> <20040907060455.GA25073@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Few weeks ago, I was asked to research a trace of an application which hangs with
NPTL but runs with LinuxThread. In the result I found a problem in futex.
I made a patch and confirmed that my fix make an application to work with NPTL.

Last week I explained it to Rusty, and today I received following mail from Ingo.

Andrew, please read Ingo's mail and fix this kernel bug in 2.6.
(Only 2.4 patchs are here... but port to 2.6 is strongly recommended.)

I sure that this fix would deliver many thread applications from a certain death.

Thank you for your kind cooperation, Rusty, Ingo, Jakub and all concerning experts.

H.Seto

-----

Ingo Molnar wrote:
> Seto san, please find Jakub's reply below. He too agrees with your
> analysis and patch. Please send it to Andrew for upstream inclusion, i
> think it should get into 2.6.9.
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> 
> 	Ingo
> 
> On Mon, Sep 06, 2004 at 08:02:40AM +0200, Ingo Molnar wrote:
> 
>>hm, looks like a valid observation?
> 
> 
> To my knowledge NPTL never even looks at return value from futex (x,
> FUTEX_WAIT, ...).
> The problem as I understand from his explanation is not about return
> value, but a race:
> 
> CPU0			CPU1			CPU2
> FUTEX_WAIT (val = 0)
> ...
> if (curval (== 1) != val (== 0)) {
> unlock_futex_mm();
> ret = -EWOULDBLOCK;
> goto out;
> }
> 			FUTEX_WAIT (val = 1)
> 			...
> 			add_wait_queue(&q.waiters, &wait);
> 			set_current_state(TASK_INTERRUPTIBLE);
> 			if (!list_empty(&q.list)) {
> 			unlock_futex_mm();
> 			time = schedule_timeout(time);
> 						FUTEX_WAKE (nr = 1)
> 						If at this point it is possible
> 						that FUTEX_WAKE awakes CPU0's task (which is
> 						not really waiting) instead of CPU1's task, 
> 						there is a kernel bug
> out:
> ...
> /* Were we woken up anyway? */
> if (!unqueue_me(&q))
> ret = 0;
> put_page(q.page);
> return ret;
> 
> When kernel decides a FUTEX_WAIT will return with -EWOULDBLOCK, it shouldn't
> be on the futex queue already, as it was already awaken by the curval !=
> val, so it must not be doubly awaken.
> 
> For RHEL3 the cure ought to be easy, either replace
> unlock_futex_mm();
> ret = -EWOULDBLOCK;
> goto out;
> 
> with
> list_del(&q.list);
> __detach_vcache(&q.vcache);
> put_page(q.page);
> return -EWOULDBLOCK;
> 
> or move __queue_me after the curval != val check and just put_page(q.page);
> return -EWOULDBLOCK there.
> 
> futex_lock and vcache_lock are held from before the current __queue_me
> call until after this curval != val check, so I believe no
> FUTEX_WAKE/REQUEUE/CMP_REQUEUE call can make a difference here.
> 
> Which means his patch looks correct.
> 
> What I don't understand at all about RHEL3 code is:
>         add_wait_queue(&q.waiters, &wait);
>         set_current_state(TASK_INTERRUPTIBLE);
>         if (!list_empty(&q.list)) {
>                 unlock_futex_mm();
>                 time = schedule_timeout(time);
>         }
>         set_current_state(TASK_RUNNING);
> 1) I don't imagine how q.list can be empty here, futex_lock/vcache_lock
>    are still held
> 2) if it for some reason is empty, then we are in bad trouble, as
>    unlock_futex_mm() is not called, so IMHO we get stuck in unqueue_me
>    because it tries to acquire vcache_lock which is already held by the
>    current task
> 
> 2.6.x futex.c is very different, but I would guess there is similar
> problem, though not sure which lock protects stuff while doing curval != val
> check.
> 
> 	Jakub
> 
> 
-----------------------------------------------------
My temporary patch for futex(RHEL3) is here:

Signed-off-by: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Signed-off-by: Ingo Molnar <mingo@elte.hu>


diff -Naur linux-2.4.21-EL3_org/kernel/futex.c linux-2.4.21-EL3/kernel/futex.c
--- linux-2.4.21-EL3_org/kernel/futex.c	2004-08-25 19:47:35.418632860 +0900
+++ linux-2.4.21-EL3/kernel/futex.c	2004-08-25 19:48:32.505546224 +0900
@@ -297,14 +297,20 @@

  	spin_lock(&vcache_lock);
  	spin_lock(&futex_lock);
+	ret = __unqueue_me(q);
+	spin_unlock(&futex_lock);
+	spin_unlock(&vcache_lock);
+	return ret;
+}
+
+static inline int __unqueue_me(struct futex_q *q)
+{
  	if (!list_empty(&q->list)) {
  		list_del(&q->list);
  		__detach_vcache(&q->vcache);
-		ret = 1;
+		return 1;
  	}
-	spin_unlock(&futex_lock);
-	spin_unlock(&vcache_lock);
-	return ret;
+	return 0;
  }

  static inline int futex_wait(unsigned long uaddr,
@@ -333,13 +339,18 @@
  	 * Page is pinned, but may no longer be in this address space.
  	 * It cannot schedule, so we access it with the spinlock held.
  	 */
-	if (!access_ok(VERIFY_READ, uaddr, 4))
-		goto out_fault;
+	if (!access_ok(VERIFY_READ, uaddr, 4)) {
+		__unqueue_me(&q);
+		unlock_futex_mm();
+		ret = -EFAULT;
+		goto out;
+	}
  	kaddr = kmap_atomic(page, KM_USER0);
  	curval = *(int*)(kaddr + offset);
  	kunmap_atomic(kaddr, KM_USER0);

  	if (curval != val) {
+		__unqueue_me(&q);
  		unlock_futex_mm();
  		ret = -EWOULDBLOCK;
  		goto out;
@@ -364,22 +375,18 @@
  	 */
  	if (time == 0) {
  		ret = -ETIMEDOUT;
-		goto out;
+		goto out_wait;
  	}
  	if (signal_pending(current))
  		ret = -EINTR;
-out:
+out_wait:
  	/* Were we woken up anyway? */
  	if (!unqueue_me(&q))
  		ret = 0;
+out:
  	put_page(q.page);

  	return ret;
-
-out_fault:
-	unlock_futex_mm();
-	ret = -EFAULT;
-	goto out;
  }

  long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,

-----------------------------------------------------
Refined version by Jakub:

> Well, I think it would be cheaper to just move the __queue_me call down,
> as in (untested RHEL3 patch below).
> The 2.6.9 patch will likely be quite different though.

--- linux-2.4.21-20.EL/kernel/futex.c	2004-08-18 20:29:54.000000000 -0400
+++ linux-2.4.21-20.EL/kernel/futex.c	2004-09-07 03:33:34.035447554 -0400
@@ -346,23 +346,26 @@ static inline int futex_wait(unsigned lo
  		unlock_futex_mm();
  		return -EFAULT;
  	}
-	__queue_me(&q, page, uaddr, offset, -1, NULL);

  	/*
  	 * Page is pinned, but may no longer be in this address space.
  	 * It cannot schedule, so we access it with the spinlock held.
  	 */
-	if (!access_ok(VERIFY_READ, uaddr, 4))
-		goto out_fault;
+	if (!access_ok(VERIFY_READ, uaddr, 4)) {
+		ret = -EFAULT;
+		goto out_unlock;
+	}
  	kaddr = kmap_atomic(page, KM_USER0);
  	curval = *(int*)(kaddr + offset);
  	kunmap_atomic(kaddr, KM_USER0);

  	if (curval != val) {
-		unlock_futex_mm();
  		ret = -EWOULDBLOCK;
-		goto out;
+		goto out_unlock;
  	}
+
+	__queue_me(&q, page, uaddr, offset, -1, NULL);
+
  	/*
  	 * The get_user() above might fault and schedule so we
  	 * cannot just set TASK_INTERRUPTIBLE state when queueing
@@ -372,10 +375,9 @@ static inline int futex_wait(unsigned lo
  	 */
  	add_wait_queue(&q.waiters, &wait);
  	set_current_state(TASK_INTERRUPTIBLE);
-	if (!list_empty(&q.list)) {
-		unlock_futex_mm();
-		time = schedule_timeout(time);
-	}
+	BUG_ON (list_empty(&q.list));
+	unlock_futex_mm();
+	time = schedule_timeout(time);
  	set_current_state(TASK_RUNNING);
  	/*
  	 * NOTE: we don't remove ourselves from the waitqueue because
@@ -395,10 +397,10 @@ out:

  	return ret;

-out_fault:
+out_unlock:
  	unlock_futex_mm();
-	ret = -EFAULT;
-	goto out;
+	put_page(q.page);
+	return ret;
  }

  long do_futex(unsigned long uaddr, int op, int val, unsigned long timeout,

