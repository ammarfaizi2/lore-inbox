Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVBVVlV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVBVVlV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261279AbVBVVlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:41:20 -0500
Received: from fire.osdl.org ([65.172.181.4]:28094 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261258AbVBVVkk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:40:40 -0500
Date: Tue, 22 Feb 2005 13:40:10 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: olof@austin.ibm.com, linux-kernel@vger.kernel.org, torvalds@osdl.org,
       rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-Id: <20050222134010.4c286e64.akpm@osdl.org>
In-Reply-To: <20050222210752.GG22555@mail.shareable.org>
References: <20050222190646.GA7079@austin.ibm.com>
	<20050222115503.729cd17b.akpm@osdl.org>
	<20050222210752.GG22555@mail.shareable.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier <jamie@shareable.org> wrote:
>
> ...
> 
> > > One attempt to fix this is included below. It works, but I'm not entirely
> > > happy with the fact that it's a bit messy solution. If anyone has a
> > > better idea for how to solve it I'd be all ears.
> > 
> > It's fairly sane.  Style-wise I'd be inclined to turn this:
> > 
> > 	down_read(&current->mm->mmap_sem);
> > 	while (!check_user_page_readable(current->mm, uaddr1)) {
> > 		up_read(&current->mm->mmap_sem);
> > 		/* Fault in the page through get_user() but discard result */
> > 		if (get_user(curval, (int __user *)uaddr1) != 0)
> > 			return -EFAULT;
> > 		down_read(&current->mm->mmap_sem);
> > 	}
> 
> That won't work because the vma lock must be help between key
> calculation and get_user() - otherwise futex is not reliable.  It
> would work if the futex key calculation was inside the loop.

All the above is trying to do is to convert the initial down_read(mmap_sem)
into a function which, on exit, guarantees that

a) down_read(mmap_sem) is held and

b) the subsequent get_user() of that address will not generate a pagefault.

So it shouldn't affect the futex code's atomicity at all.

However the pte can get unmapped by memory reclaim so we could still take a
minor fault, and hit the same deadlock, yes?

> A much simpler solution (and sorry for not offering it earlier,
> because Andrew Morton pointed out this bug long ago, but I was busy), is:
> 
> In futex.c:
> 
> 	down_read(&current->mm->mmap_sem);
> 	get_futex_key(...) etc.
> 	queue_me(...) etc.
> 	current->flags |= PF_MMAP_SEM;             <- new
> 	ret = get_user(...);
> 	current->flags &= PF_MMAP_SEM;             <- new
> 	/* the rest */
> 
> And in arch/*/mm/fault.c, replace every one of these:
> 
> 	down_read(&mm->mmap_sem);
> 
> 	up_read(&mm->mmap_sem);
> 
> with these:
> 
> 	if (!(current & PF_MMAP_SEM))
> 		down_read(&mm->mmap_sem);
> 
> 	if (!(current & PF_MMAP_SEM))
> 		up_read(&mm->mmap_sem);
> 

Yes, that will work.  However I do feel that it's cleaner to localise this
nastiness into a single function which the futex code calls, rather than
spreading it all around and adding overhead to every pagefault.  If we can
work out how.

wrt this down_read/down_write/down_read deadlock: iirc, the reason why
down_write() takes precedence over down_read() is to avoid the permanent
writer starvation which would occur if there is heavy down_read() traffic.

As Linus points out, an alternative would be to do an inc_preempt_count()
around the offending get_user(), then use __copy_from_user_inatomic(), then
take some sort of remedial action if __copy_from_user_inatomic() returns a
fault.  Something like:

retry:
	if (get_user(uaddr) == -EFAULT)
		return -EFAULT;
	down_read(mmap_sem);
	inc_preempt_count();
	if (__copy_from_user_inatomic(..., uaddr)) {
		up_read(mmap_sem);
		dec_preempt_count();
		goto retry;
	}

	dec_preempt_count();
	up_read(mmap_sem);
