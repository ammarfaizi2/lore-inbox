Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbUKPI2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbUKPI2l (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 03:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261938AbUKPI2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 03:28:41 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:17049 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S261936AbUKPI2d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 03:28:33 -0500
Date: Tue, 16 Nov 2004 17:30:24 +0900
From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: Futex queue_me/get_user ordering
In-reply-to: <20041115141247.GC25502@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu
Message-id: <4199BAA0.1070608@jp.fujitsu.com>
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
 <20041115141247.GC25502@mail.shareable.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OMG... Wait, wait... Don't do anything.

I have to deeply apologize to all for my mistake.
If my understanding is correct, this bug is "2.4 futex"(RHEL3) *SPECIFIC*!!
I had swallow the story that 2.6 futex has the same problem...

So I realize that 2.6 futex never behave:
 >>      "returns 0 if the futex was not equal to the expected value, but
 >>       the process was woken by a FUTEX_WAKE call."

Update of manpage is now unnecessary, I think.

#

First of all, I would appreciate if you could read my old post:
"Kernel bug in futex_wait, cause application hang with NPTL"
http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/2044.html

#

Then, let's go on to the main subject.

Jamie Lokier wrote:
 > In fact, waiting does not get the lock for the futex.  It relies on
 > the ordering of (1) adding to the wait queue, (2) checking the current
 > value, and (3) removing from the wait queue if the value doesn't
 > match.  Among other things, this is necessary because checking the
 > current value cannot be done with a spinlock held.

If my understanding is correct, 2.6 futex does not get any spinlocks,
but a semaphore:

[kernel/futex.c](from 2.6, RHEL4b2)
  286 static int futex_wake(unsigned long uaddr, int nr_wake)
  287 {
   :
  294         down_read(&current->mm->mmap_sem);
   :
  306                         wake_futex(this);
   :
  314         up_read(&current->mm->mmap_sem);
  315         return ret;
  316 }
   :
  477 static int futex_wait(unsigned long uaddr, int val, unsigned long time)
  478 {
   :
  483         down_read(&current->mm->mmap_sem);
   :
  489         queue_me(&q, -1, NULL);
   :
  500         if (curval != val) {
  501                 ret = -EWOULDBLOCK;
  502                 goto out_unqueue;
  503         }
   :
  509         up_read(&current->mm->mmap_sem);
   :
  528                 time = schedule_timeout(time);
   :
  536         /* If we were woken (and unqueued), we succeeded, whatever. */
  537         if (!unqueue_me(&q))
  538                 return 0;
  539         if (time == 0)
  540                 return -ETIMEDOUT;
  541         /* A spurious wakeup should never happen. */
  542         WARN_ON(!signal_pending(current));
  543         return -EINTR;
  544
  545  out_unqueue:
  546         /* If we were woken (and unqueued), we succeeded, whatever. */
  547         if (!unqueue_me(&q))
  548                 ret = 0;
  549  out_release_sem:
  550         up_read(&current->mm->mmap_sem);
  551         return ret;
  552 }

This semaphore prevents a waiter which temporarily queued to check the val
from being target of wakeup.

So my "[simulation]" is wrong if it is on 2.6, since wake_Y never be able to
touch the queue while wait_A is in the queue to have the val to be checked.

(If it is not possible that there are threads which go around with same
futex/condvar but each have different mmap_sem,) 2.6 futex is quite good.

#

Next, let's see how about 2.4 futex:

[kernel/futex.c](from 2.4, RHEL3U2)
  154 static inline int futex_wake(unsigned long uaddr, int offset, int num)
  155 {
   :
  160         lock_futex_mm();
   :
  176                         wake_up_all(&this->waiters);
   :
  185         unlock_futex_mm();
   :
  188         return ret;
  189 }
   :
  310 static inline int futex_wait(unsigned long uaddr,
  311                       int offset,
  312                       int val,
  313                       unsigned long time)
  314 {
   :
  323         lock_futex_mm();
   :
  330         __queue_me(&q, page, uaddr, offset, -1, NULL);
   :
  342         if (curval != val) {
  343                 unlock_futex_mm();
  344                 ret = -EWOULDBLOCK;
  345                 goto out;
  346         }
   :
  357                 unlock_futex_mm();
  358                 time = schedule_timeout(time);
   :
  365         if (time == 0) {
  366                 ret = -ETIMEDOUT;
  367                 goto out;
  368         }
  369         if (signal_pending(current))
  370                 ret = -EINTR;
  371 out:
  372         /* Were we woken up anyway? */
  373         if (!unqueue_me(&q))
  374                 ret = 0;
  375         put_page(q.page);
  376
  377         return ret;
   :
  383 }

2.4 futex uses spinlocks.

   74 static inline void lock_futex_mm(void)
   75 {
   76         spin_lock(&current->mm->page_table_lock);
   77         spin_lock(&vcache_lock);
   78         spin_lock(&futex_lock);
   79 }
   80
   81 static inline void unlock_futex_mm(void)
   82 {
   83         spin_unlock(&futex_lock);
   84         spin_unlock(&vcache_lock);
   85         spin_unlock(&current->mm->page_table_lock);
   86 }

However, this spinlocks fail to prevent topical waiters from wakeups.
Because the spinlocks are released *before* unqueue_me(&q) (line 343 & 373).
So this failure allows wake_Y to touch the queue while wait_A is in it.

Of course as you know, this brings bug which I have mentioned.
(I don't know how many distributions have 2.4 futex in itself, but)
At least 2.4 futex in RHEL3U2 is buggy.

#

I regret that I could not notice this fact earlier.
I'm sorry... I hope you'll accept my apology.


Thanks,
H.Seto

