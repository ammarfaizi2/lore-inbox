Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVBVVIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVBVVIg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 16:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261247AbVBVVIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 16:08:36 -0500
Received: from mail.shareable.org ([81.29.64.88]:16040 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261246AbVBVVIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 16:08:06 -0500
Date: Tue, 22 Feb 2005 21:07:52 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Olof Johansson <olof@austin.ibm.com>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH/RFC] Futex mmap_sem deadlock
Message-ID: <20050222210752.GG22555@mail.shareable.org>
References: <20050222190646.GA7079@austin.ibm.com> <20050222115503.729cd17b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050222115503.729cd17b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> > This will quickly lock up, since the futex_wait code dows a
> > down_read(mmap_sem), then a get_user().
> > 
> > The do_page_fault code on ppc64 (as well as other architectures) needs
> > to take the same semaphore for reading. This is all good until the
> > second thread comes into play: Its mmap call tries to take the same
> > semaphore for writing which causes in the do_page_fault down_read()
> > to get stuck. Classic deadlock.
> 
> Yup.  Jamie says that the futex code _has_ to hold mmap_sem across the
> get_user().  I forget (but could probably locate) the details.

It does - the "key" which identifies a futex depends on a vma
calculation, and the vma must not change between the calculation and
the get_user().

> > One attempt to fix this is included below. It works, but I'm not entirely
> > happy with the fact that it's a bit messy solution. If anyone has a
> > better idea for how to solve it I'd be all ears.
> 
> It's fairly sane.  Style-wise I'd be inclined to turn this:
> 
> 	down_read(&current->mm->mmap_sem);
> 	while (!check_user_page_readable(current->mm, uaddr1)) {
> 		up_read(&current->mm->mmap_sem);
> 		/* Fault in the page through get_user() but discard result */
> 		if (get_user(curval, (int __user *)uaddr1) != 0)
> 			return -EFAULT;
> 		down_read(&current->mm->mmap_sem);
> 	}

That won't work because the vma lock must be help between key
calculation and get_user() - otherwise futex is not reliable.  It
would work if the futex key calculation was inside the loop.

A much simpler solution (and sorry for not offering it earlier,
because Andrew Morton pointed out this bug long ago, but I was busy), is:

In futex.c:

	down_read(&current->mm->mmap_sem);
	get_futex_key(...) etc.
	queue_me(...) etc.
	current->flags |= PF_MMAP_SEM;             <- new
	ret = get_user(...);
	current->flags &= PF_MMAP_SEM;             <- new
	/* the rest */

And in arch/*/mm/fault.c, replace every one of these:

	down_read(&mm->mmap_sem);

	up_read(&mm->mmap_sem);

with these:

	if (!(current & PF_MMAP_SEM))
		down_read(&mm->mmap_sem);

	if (!(current & PF_MMAP_SEM))
		up_read(&mm->mmap_sem);

-- Jamie
