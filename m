Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbUKPPCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbUKPPCs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262002AbUKPPAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 10:00:44 -0500
Received: from mail.shareable.org ([81.29.64.88]:40323 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262000AbUKPO6f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 09:58:35 -0500
Date: Tue, 16 Nov 2004 14:58:03 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: bert hubert <ahu@ds9a.nl>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au, mingo@elte.hu
Subject: Re: Futex queue_me/get_user ordering
Message-ID: <20041116145803.GA15599@mail.shareable.org>
References: <20041113164048.2f31a8dd.akpm@osdl.org> <20041114090023.GA478@mail.shareable.org> <20041114010943.3d56985a.akpm@osdl.org> <20041114092308.GA4389@mail.shareable.org> <20041114095051.GA11391@outpost.ds9a.nl> <20041115141247.GC25502@mail.shareable.org> <4199BAA0.1070608@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4199BAA0.1070608@jp.fujitsu.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hidetoshi Seto wrote:
> I have to deeply apologize to all for my mistake.
> If my understanding is correct, this bug is "2.4 futex"(RHEL3) *SPECIFIC*!!
> I had swallow the story that 2.6 futex has the same problem...

Wrong, 2.6 has the same behaviour!

> So I realize that 2.6 futex never behave:
> >>      "returns 0 if the futex was not equal to the expected value, but
> >>       the process was woken by a FUTEX_WAKE call."
> 
> Update of manpage is now unnecessary, I think.

It is necessary.

> First of all, I would appreciate if you could read my old post:
> "Kernel bug in futex_wait, cause application hang with NPTL"
> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/2044.html

> If my understanding is correct, 2.6 futex does not get any spinlocks,
> but a semaphore:
>
>  286 static int futex_wake(unsigned long uaddr, int nr_wake)
>   :
>  294         down_read(&current->mm->mmap_sem);
>
>  477 static int futex_wait(unsigned long uaddr, int val, unsigned long time)
>   :
>  483         down_read(&current->mm->mmap_sem);

> This semaphore prevents a waiter which temporarily queued to check the val
> from being target of wakeup.

No, because it's a read-write semaphore, and we do "down_read" on it
which is a shared lock.  It does not prevent concurrent wake and wait
operations!

The only reason we use this semaphore is to block against vma-changing
operations (like mmap) while we look up the futex key and memory word.

> (If it is not possible that there are threads which go around with same
> futex/condvar but each have different mmap_sem,)

Actually it is possible, with process-shared condvars, but it's
irrelevant because down_read doesn't prevent concurrent wakes and
waits.

[About 2.4 futex in RHEL3U2 which takes spinlocks instead]:
> However, this spinlocks fail to prevent topical waiters from wakeups.
> Because the spinlocks are released *before* unqueue_me(&q) (line 343 & 373).
> So this failure allows wake_Y to touch the queue while wait_A is in it.

This order is necessary, because it's not safe to call get_user()
while holding any spinlocks.  It is not a bug in RHEL.

> At least 2.4 futex in RHEL3U2 is buggy.

I don't think it is, because I think the behaviour you'll see with
RHEL3U2 is no different than 2.6, just slower ;)

-- Jamie
