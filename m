Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262698AbUKRBbt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262698AbUKRBbt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 20:31:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262692AbUKRBaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 20:30:15 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:2994 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262604AbUKRB1k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 20:27:40 -0500
Date: Thu, 18 Nov 2004 10:29:32 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: Futex queue_me/get_user ordering
In-reply-to: <20041116145803.GA15599@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu
Message-id: <419BFAFC.4010501@jp.fujitsu.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
References: <20041113164048.2f31a8dd.akpm@osdl.org>
 <20041114090023.GA478@mail.shareable.org>
 <20041114010943.3d56985a.akpm@osdl.org>
 <20041114092308.GA4389@mail.shareable.org>
 <20041114095051.GA11391@outpost.ds9a.nl>
 <20041115141247.GC25502@mail.shareable.org> <4199BAA0.1070608@jp.fujitsu.com>
 <20041116145803.GA15599@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Hidetoshi Seto wrote:
> 
>>I have to deeply apologize to all for my mistake.
>>If my understanding is correct, this bug is "2.4 futex"(RHEL3) *SPECIFIC*!!
>>I had swallow the story that 2.6 futex has the same problem...
> 
> Wrong, 2.6 has the same behaviour!
> 
>>So I realize that 2.6 futex never behave:
>>
>>>>     "returns 0 if the futex was not equal to the expected value, but
>>>>      the process was woken by a FUTEX_WAKE call."
>>
>>Update of manpage is now unnecessary, I think.
> 
> It is necessary.
> 
>>First of all, I would appreciate if you could read my old post:
>>"Kernel bug in futex_wait, cause application hang with NPTL"
>>http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/2044.html
> 
>>If my understanding is correct, 2.6 futex does not get any spinlocks,
>>but a semaphore:
>>
>> 286 static int futex_wake(unsigned long uaddr, int nr_wake)
>>  :
>> 294         down_read(&current->mm->mmap_sem);
>>
>> 477 static int futex_wait(unsigned long uaddr, int val, unsigned long time)
>>  :
>> 483         down_read(&current->mm->mmap_sem);
> 
>>This semaphore prevents a waiter which temporarily queued to check the val
>>from being target of wakeup.
> 
> No, because it's a read-write semaphore, and we do "down_read" on it
> which is a shared lock.  It does not prevent concurrent wake and wait
> operations!

Aha, yes. You are right.

> [About 2.4 futex in RHEL3U2 which takes spinlocks instead]:
> 
>>However, this spinlocks fail to prevent topical waiters from wakeups.
>>Because the spinlocks are released *before* unqueue_me(&q) (line 343 & 373).
>>So this failure allows wake_Y to touch the queue while wait_A is in it.
> 
> This order is necessary, because it's not safe to call get_user()
> while holding any spinlocks.  It is not a bug in RHEL.

I think 2.4 is fixable. My original patch for 2.4 was:

/*----- patch begin -----*/

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

/*----- patch end -----*/

This patch just reorder old codes in fault route:

if(fault){
   unlock(futex);
   ret = -ERRVAR;
   unqueue();
   put_page();
   return ret;
}

to new one:

if(fault){
   unqueue_in_lock();
   unlock(futex);
   ret = -ERRVAR;
   put_page();
   return ret;
}

It protects the temporarily queued thread from wakes, doesn't it?

If this work, it could be said that we can fix 2.6 futex with a
spinlock... but it will be slow, slow...


Thanks,
H.Seto

