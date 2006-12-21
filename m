Return-Path: <linux-kernel-owner+w=401wt.eu-S1422908AbWLUPye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422908AbWLUPye (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 10:54:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422933AbWLUPye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 10:54:34 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:41096 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422908AbWLUPyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 10:54:33 -0500
To: rmk+lkml@arm.linux.org.uk
CC: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-reply-to: <20061221152621.GB3958@flint.arm.linux.org.uk> (message from
	Russell King on Thu, 21 Dec 2006 15:26:21 +0000)
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all that again
References: <20061221152621.GB3958@flint.arm.linux.org.uk>
Message-Id: <E1GxQF2-0000i6-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 21 Dec 2006 16:53:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll first answer the last paragraph.

> I suggest that in order for fuse to work reliably on ARM, it is modified
> to behave more like a reasonable device driver, and use the functions
> defined in asm/uaccess.h when it wants to access the current processes
> VM space.

Fuse needs to use get_user_pages() to work around certain deadlock
scenarios (see Documentation/filesystems/fuse.txt), that are
problematic with copy_*_user().

Other possibilities for dealing with these kinds of deadlocks are:

  1) detect deadlock before it happens

  2) copy data to a temporary buffer before copying to userspace

I think 1) is basically impossible.  2) is easy and would save a lot
of complexity, but it would certainly be much slower than the current
approach, especially for the mainstream architectures, where the
dcache aliasing problem doesn't exist.

> I've recently been asked to look at why fuse doesn't work on ARM.
> In doing so and thinking about what fuse is doing, I've come to
> the conclusion that the way fuse accesses the _current_ processes
> memory space is less than ideal.
> 
> The problem is as follows:
> 
> - current process calls writev()
> - fuse_dev_write is invoked, and this ends up calling
>    get_user_pages(current, current->mm, address, 1, 0, ...)
> - data is then read from the kernel mapping of this page (briefly) via:
>    void *mapaddr = kmap_atomic(page, ..);
>    memcpy(dest, mapaddr + offset, size);
>    kunmap_atomic(mapaddr);
> 
> With a VIVT cache, there is an aliasing issue.  Data may be in the
> cache lines corresponding with the userspace mapping, thereby making
> data read from the kernel mapping incoherent.
> 
> On the face of it, the solution seems simple - we could assume that the
> kernel mapping does not have any cache lines allocated with it, so we
> can just write back the userspace mapping to make that data visible.
> 
> However, the action of that memcpy() will allocate some cache lines
> in the kernel mapping of this page, which means when we next come to
> read it (maybe via the same code) we could end up reading stale data.
> 
> Therefore, we also need to flush - more specifically, discard - the
> kernel mapping cache lines.
> 
> 
> Okay, now let's look at the read case:
> 
> - current process calls readv()
> - fuse_dev_read is invoked, and eventually calls:
>    get_user_pages(current, current->mm, address, 1, 1, ...)
> - data is then written to the kernel mapping of this page (briefly) via:
>    void *mapaddr = kmap_atomic(page, ..);
>    memcpy(mapaddr + offset, source, size);
>    kunmap_atomic(mapaddr);
> 
> A similar problem exists here.  The userspace mapping may have some
> cache lines assocated with it, and as we found out above, so may the
> kernel mapping.  We can apply the same fix to it.
> 
> However, and this is the problem, we need cache maintainence _after_
> that memcpy() has completed - with a write allocate VIVT cache, the
> memcpy() itself will allocate cache lines in the kernel mapping of
> the page which will need to be written back for the user process to
> see that data.

Yes, note the flush_dcache_page() call in fuse_copy_finish().  That
could be replaced by the flush_kernel_dcache_page() (added by James
Bottomley together with flush_anon_page()) when all relevant
architectures have defined it.

> Moreover, the userspace mapping would need its cache lines evicted
> (maybe by get_user_pages()) for the written back kernel cache lines
> to be visible.  The more I think about this, the more I'm convinced
> that this part could only be done by get_user_pages().

Yes, I think that was the concept.

> Now, throw in SMP or preempt with a multi-threaded userspace program
> touching the page in question, and the problem just gets much much
> worse.  In such a scenario, we can not guarantee, no matter how much
> cache maintainence is applied to the kernel, that this API comes
> anywhere near to being safe.

This is only problematic if multiple threads are touching the same
page, no?  If the page(s) used for reading/writing requests are
exclusive to each thread, then there should be no problem.  This is a
reasonable requirement towards the userspace filesystem I think.

> To summarise, in order for get_user_pages() to vaguely work with this
> method of accessing the current processes address space on ARM, we'd
> need to make the following changes:
> 
> 1. get_user_pages() needs to unconditionally write back and invalidate
>    the user space mapping.
> 2. get_user_pages() needs to invalidate the kernel space mapping.
> 3. all users of get_user_pages(current, current->mm, ...) need auditing,
>    and additional cache maintainence added in their write paths to
>    write back and invalidate the kernel mapping.
> 4. all fuse userspace programs need to run single-threaded.
> 
> Note: flush_anon_page() was added to work around 1 and 2 on other
> architectures because fuse tripped over this issue there.
> 
> So, given all this additional complexity _and_ that it would only be
> safe on non-preempt UP, the question becomes: is using get_user_pages()
> to access the current processes memory space legal?  Given the above,
> I would say not.

Note again, fuse is not the only user of get_user_pages().  Other uses
are just as prone to these issues.

Miklos
