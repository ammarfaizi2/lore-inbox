Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264686AbSJUBOL>; Sun, 20 Oct 2002 21:14:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264687AbSJUBOH>; Sun, 20 Oct 2002 21:14:07 -0400
Received: from x35.xmailserver.org ([208.129.208.51]:55942 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S264686AbSJUBOF>; Sun, 20 Oct 2002 21:14:05 -0400
X-AuthUser: davidel@xmailserver.org
Date: Sun, 20 Oct 2002 18:28:48 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andrew Morton <akpm@digeo.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] sys_epoll ...
In-Reply-To: <3DB34F39.C2923F7B@digeo.com>
Message-ID: <Pine.LNX.4.44.0210201815170.959-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Oct 2002, Andrew Morton wrote:

> Davide Libenzi wrote:
> >
> > Per Linus request I implemented a syscall interface to the old /dev/epoll
> > to avoid the creation of magic inodes inside /dev.
>
> >From a (very) quick read:
>
>
> +static struct vm_operations_struct eventpoll_mmap_ops = {
> +       open: eventpoll_mm_open,
> +       close: eventpoll_mm_close,
> +};
>
> Please use the C99 form.

Consider It Done.



> +       ep = (struct eventpoll *) file->private_data;
>
> The cast there just adds noise.  private_data is void *.  In
> fact you lose a bit of compile-time checking by having the cast
> there.

CID



> +       addr = do_mmap_pgoff(file, 0, EP_MAP_SIZE(maxfds + 1), PROT_READ | PROT_WRITE,
> +                                                MAP_PRIVATE, 0);
>
> You must hold current->mm->mmap-sem for writing before calling
> do_mmap_pgoff().  I shall add the missing comment to do_mmap_pgoff.

True, CID



> +asmlinkage int sys_epoll_wait(int epfd, struct pollfd **events, int timeout)
> +{
> +       int error = -EBADF;
> +       unsigned long eaddr;
> +       struct file *file;
> +       struct eventpoll *ep;
> +       struct evpoll dvp;
> +
> +       DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d)\n",
> +                                current, epfd, events, timeout));
> +
> +       file = fget(epfd);
> +       if (!file)
> +               goto fget_fail;
> +       ep = (struct eventpoll *) file->private_data;
> +
> +       error = -EINVAL;
> +       if (!atomic_read(&ep->mmapped))
>
> Will oops if not passed one of your fd's?

Yes it will. I will find a solution asap.



> +       clear_bit(PG_reserved, &virt_to_page(pages[ii])->flags);
>
> Please use SetPageReserved()/ClearPageReserved().

CID



> +static void ep_free(struct eventpoll *ep)
> +{
> +       int ii;
> +       struct list_head *lnk;
> +
> +       lock_kernel();
> +       for (ii = 0; ii <= ep->hmask; ii++) {
> +               while ((lnk = list_first(&ep->hash[ii]))) {
> +                       struct epitem *dpi = list_entry(lnk, struct epitem, llink);
> +
>
> What is locking the nodes in this hashtable?  Here it seems to
> be lock_kernel.  Elsewhere it seems to be write_lock_irqsave(&ep->lock);



> +static inline struct epitem *ep_find_nl(struct eventpoll *ep, int fd)
>
> Should be uninlined.

CID



>
> +               __copy_from_user(&pfd, buffer, sizeof(pfd));
>
> Check for EFAULT.

CID



> +                       if (ep->eventcnt || !timeout)
> +                               break;
> +                       if (signal_pending(current)) {
> +                               res = -EINTR;
> +                               break;
> +                       }
> +
> +                       set_current_state(TASK_INTERRUPTIBLE);
> +
> +                       write_unlock_irqrestore(&ep->lock, flags);
> +                       timeout = schedule_timeout(timeout);
>
> You should set current->state before performing the checks.



> +               if (res > 0)
> +                       copy_to_user((void *) arg, &dvp, sizeof(struct evpoll));
>
> EFAULT?

CID



> +       write_lock_irqsave(&ep->lock, flags);
> +
> +       res = -EINVAL;
> +       if (numpages != (2 * ep->numpages))
> +               goto out;
> +
> +       start = vma->vm_start;
> +       for (ii = 0; ii < ep->numpages; ii++) {
> +               if (remap_page_range(vma, start, __pa(ep->pages0[ii]),
> +                                                        PAGE_SIZE, vma->vm_page_prot))
>
> remap_page_range() can sleep in pmd_alloc(), etc.  May not be called under
> spinlock.

Yep, true. CID




- Davide



