Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbVBVWfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbVBVWfX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 17:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261309AbVBVWfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 17:35:23 -0500
Received: from mail.shareable.org ([81.29.64.88]:23720 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261306AbVBVWfM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 17:35:12 -0500
Date: Tue, 22 Feb 2005 22:34:57 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Olof Johansson <olof@austin.ibm.com>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050222223457.GK22555@mail.shareable.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org> <20050222210752.GG22555@mail.shareable.org> <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0502221317270.2378@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> > 	queue_me(...) etc.
> > 	current->flags |= PF_MMAP_SEM;             <- new
> > 	ret = get_user(...);
> > 	current->flags &= PF_MMAP_SEM;             <- new
> > 	/* the rest */
> 
> That is uglee. 
> 
> We really have this already, and it's called "current->preempt". It 
> handles any lock at all, and doesn't add yet another special case to all 
> the architectures.

Ooh, I didn't know current->preempt did that (been away).

> 	repeat:
> 		down_read(&current->mm->mmap_sem);
> 		get_futex_key(...) etc.
> 		queue_me(...) etc.
> 		inc_preempt_count();
> 		ret = get_user(...);
> 		dec_preempt_count();
> 		if (unlikely(ret)) {
> 			up_read(&current->mm->mmap_sem);
> 			/* Re-do the access outside the lock */
> 			ret = get_user(...);
> 			if (!ret)
> 				goto repeat;
> 			return ret;
>		}

That would work.  I like it. :)

Page faults will enter the fault handler twice (i.e. slower), but
that's not really a disadvantage, because a program always references
the memory just before calling futex_wait anyway.  A fault is rare.

There is one small but important error: the "return ret" mustn't just
return.  It must call unqueue_me(&q) just like the code at out_unqueue,
_including_ the conditional "ret = 0", but _excluding_ the up_read().

Alternatively, since it's a rare case, just shuffle the loop around:

 		down_read(&current->mm->mmap_sem);
 	repeat:
 		get_futex_key(...) etc.
 		queue_me(...) etc.
 		inc_preempt_count();
 		ret = get_user(...);
 		dec_preempt_count();
 		if (unlikely(ret)) {
 			up_read(&current->mm->mmap_sem);
 			/* Re-do the access outside the lock */
 			ret = get_user(...);
			down_read(&current->mm->mmap_sem);
 			if (!ret)
 				goto repeat;
 			goto out_unqueue;
		}

-- Jamie
