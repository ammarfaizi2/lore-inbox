Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285062AbRLQJae>; Mon, 17 Dec 2001 04:30:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285065AbRLQJaZ>; Mon, 17 Dec 2001 04:30:25 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:24077 "EHLO
	bart.one-2-one.net") by vger.kernel.org with ESMTP
	id <S285062AbRLQJaG>; Mon, 17 Dec 2001 04:30:06 -0500
Date: Mon, 17 Dec 2001 10:32:26 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: "Sottek, Matthew J" <matthew.j.sottek@intel.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: zap_page_range in a module
In-Reply-To: <20011214213142.A28867@redhat.com>
Message-ID: <Pine.LNX.4.21.0112162341400.444-100000@notebook.diehl.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Dec 2001, Benjamin LaHaise wrote:

> > I have a 64k sliding "window" into a 1MB region. You can only access
> > 64k at a time then you have to switch the "bank" to access the next
> > 64k. Address 0xa0000-0xaffff is the 64k window. The actual 1MB of
> > memory is above the top of memory and not directly addressable by the
> > CPU, you have to go through the banks.
> 
> Stop right there.  You can't do that.  The code will deadlock on page 
> faults for certain usage patterns.  It's slow, inefficient and a waste 
> of effort.

Would you mind giving a hint how the predicted deadlock path would look
like or what the usage pattern might be, please?

I'm asking because I'm happily doing something very similar to what
Matthew describes without ever running into trouble - and this operates
at major page fault rates up to 1000/sec here. What I'm doings is:

in fops->mmap(vma), serialized with other file operations:
	drv->vaddr = vma->vm_start;
	drv->vlen = vma->vm_end - vma->vm_start;
	vma->vm_flags |= VM_RESERVED;
	vma->vm_ops = &my_vm_ops;

vma->vm_ops->nopage() is my overloaded page fault handler which maps
_selectable_ kmalloc'ed kernel pages to the userland vma.

in fops->ioctl(), again serialized with other file operations:
	down_write(&current->mm->mmap_sem);
	zap_page_range(current->mm, drv->vaddr, drv->vlen);
	up_write(&current->mm->mmap_sem);

note that this is pretty much the same what sys_munmap() is doing - with
one important difference: the mmap'ed vma isn't freed, it just remains
unchanged and a major page fault is triggered on the next access.

Finally let me point out that performance is not an issue here - and IMHO
simple creation and destruction of pte's pointing to advance-kmalloc'ed 
pages shouldn't be that slow anyway. OTOH, ability to use the page fault
handler to control which page gets mapped to this vma (including none,
i.e. forcing SIGBUS) is an issue.

Regards,
Martin

