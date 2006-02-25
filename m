Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161086AbWBYT31@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbWBYT31 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 14:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWBYT31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 14:29:27 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:52660 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1161086AbWBYT30 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 14:29:26 -0500
Message-ID: <4400AF57.8E40B34@tv-sign.ru>
Date: Sat, 25 Feb 2006 22:26:15 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: linux-kernel@vger.kernel.org, paulmck@us.ibm.com
Subject: Re: [PATCH 3/4] cleanup __exit_signal()
References: <200602250148.k1P1m2ce001979@adara.cs.pdx.edu>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Suzanne Wood wrote:
>
> The extent of the rcu readside critical section is determined
> by the corresponding placements of rcu_read_lock() and
> rcu_read_unlock().  Your recent [PATCH] convert sighand_cache
> to use SLAB_DESTROY_BY_RCU uncovered a comment that elicits
> this request for clarification.  (The initial motivation was in
> seeing the introduction of an rcu_assign_pointer() and
> looking for the corresponding rcu_dereference().)
>
> Jul 13 2004 [PATCH] rmaplock 2/6 SLAB_DESTROY_BY_RCU (and
> consistent with slab.c in linux-2.6.16-rc3), struct slab_rcu
> is described:
>  * struct slab_rcu
>  *
>  * slab_destroy on a SLAB_DESTROY_BY_RCU cache uses this structure to
>  * arrange for kmem_freepages to be called via RCU.  This is useful if
>  * we need to approach a kernel structure obliquely, from its address
>  * obtained without the usual locking.  We can lock the structure to
>  * stabilize it and check it's still at the given address, only if we
>  * can be sure that the memory has not been meanwhile reused for some
>  * other kind of object (which our subsystem's lock might corrupt).
>  *
>  * rcu_read_lock before reading the address, then rcu_read_unlock after
>  * taking the spinlock within the structure expected at that address.
>
> Does this mean that the rcu_read_lock() can safely occur just
> after the spin_lock(&sighand->siglock)?  Since I don't find an
> example that follows this interpretation of the comment, what
> is the intention?  Or, if so, what is the particular context?
> Looks like all kernel occurrences of rcu_dereference()
> with sighand arguments have, within the function definition,
> rcu_read_lock/unlock() pairs enclosing spin lock and unlock
> pairs except that in group_send_sig_info() with a comment on
> requiring rcu_read_lock or tasklist_lock.

Sorry, I can't understand this question. __exit_signal() does
rcu_read_lock() (btw, this is not strictly necessary here due
to tasklist_lock held, it is more a documentation) _before_ it
takes sighand->siglock.

> An example is attached in your patch to move __exit_signal().
> It appears that the rcu readside critical section is in place to
> provide persistence of the task_struct.  __exit_sighand() calls
> sighand_free(sighand) -- proposed to be renamed cleanup_sighand(tsk)
> to call kmem_cache_free(sighand_cachep, sighand) -- before
> spin_unlock(&sighand->siglock) is called in __exit_signal().

This is a very valid question.

Yes, spin_unlock(&sighand->siglock) after kmem_cache_free() means
we are probably writing to the memory which was already reused on
another cpu.

However, SLAB_DESTROY_BY_RCU garantees that this memory was not
released to the system (while we are under rcu_read_lock()), so
this memory is a valid sighand_struct, and it is ok to release
sighand->siglock. That is why we initialize ->siglock (unlike
->count) in sighand_ctor, but not in copy_sighand().

In other words, after kmem_cache_free() we own nothing in sighand,
except this ->siglock.

So we are safe even if another cpu tries to lock this sighand
right now (currently this is not posiible, copy_process or
de_thread should first take tasklist_lock), it will be blocked
until we release it.

This patch was done when __exit_signal had 2 sighand_free() calls.
Now we can change this:

	void cleanup_sighand(struct sighand_struct *sighand)
	{
		if (atomic_dec_and_test(&sighand->count))
			kmem_cache_free(sighand_cachep, sighand);
	}

	void __exit_signal(tsk)
	{
		...

		tsk->signal = NULL;
		tsk->sighand = NULL;	// we must do it before unlocking ->siglock
		spin_unlock(&sighand->siglock);
		rcu_read_unlock();

		cleanup_sighand(sighand)
		...
	}

Oleg.
