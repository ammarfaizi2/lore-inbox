Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264679AbSJUAoE>; Sun, 20 Oct 2002 20:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264680AbSJUAoE>; Sun, 20 Oct 2002 20:44:04 -0400
Received: from packet.digeo.com ([12.110.80.53]:13053 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264679AbSJUAoC>;
	Sun, 20 Oct 2002 20:44:02 -0400
Message-ID: <3DB34F39.C2923F7B@digeo.com>
Date: Sun, 20 Oct 2002 17:50:01 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.42 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hanna Linder <hannal@us.ibm.com>
Subject: Re: [patch] sys_epoll ...
References: <Pine.LNX.4.44.0210201650000.989-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Oct 2002 00:50:01.0607 (UTC) FILETIME=[C9862170:01C2789B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:
> 
> Per Linus request I implemented a syscall interface to the old /dev/epoll
> to avoid the creation of magic inodes inside /dev.

>From a (very) quick read:


+static struct vm_operations_struct eventpoll_mmap_ops = {
+       open: eventpoll_mm_open,
+       close: eventpoll_mm_close,
+};

Please use the C99 form.

+       ep = (struct eventpoll *) file->private_data;

The cast there just adds noise.  private_data is void *.  In
fact you lose a bit of compile-time checking by having the cast
there.


+       addr = do_mmap_pgoff(file, 0, EP_MAP_SIZE(maxfds + 1), PROT_READ | PROT_WRITE,
+                                                MAP_PRIVATE, 0);

You must hold current->mm->mmap-sem for writing before calling
do_mmap_pgoff().  I shall add the missing comment to do_mmap_pgoff.


+asmlinkage int sys_epoll_wait(int epfd, struct pollfd **events, int timeout)
+{
+       int error = -EBADF;
+       unsigned long eaddr;
+       struct file *file;
+       struct eventpoll *ep;
+       struct evpoll dvp;
+
+       DNPRINTK(3, (KERN_INFO "[%p] eventpoll: sys_epoll_wait(%d, %p, %d)\n",
+                                current, epfd, events, timeout));
+
+       file = fget(epfd);
+       if (!file)
+               goto fget_fail;
+       ep = (struct eventpoll *) file->private_data;
+
+       error = -EINVAL;
+       if (!atomic_read(&ep->mmapped))

Will oops if not passed one of your fd's?

(Ditto in sys_epoll_ctl)

+       clear_bit(PG_reserved, &virt_to_page(pages[ii])->flags);

Please use SetPageReserved()/ClearPageReserved().


+static void ep_free(struct eventpoll *ep)
+{
+       int ii;
+       struct list_head *lnk;
+
+       lock_kernel();
+       for (ii = 0; ii <= ep->hmask; ii++) {
+               while ((lnk = list_first(&ep->hash[ii]))) {
+                       struct epitem *dpi = list_entry(lnk, struct epitem, llink);
+

What is locking the nodes in this hashtable?  Here it seems to
be lock_kernel.  Elsewhere it seems to be write_lock_irqsave(&ep->lock);

+static inline struct epitem *ep_find_nl(struct eventpoll *ep, int fd)

Should be uninlined.

+               __copy_from_user(&pfd, buffer, sizeof(pfd));

Check for EFAULT.


+                       if (ep->eventcnt || !timeout)
+                               break;
+                       if (signal_pending(current)) {
+                               res = -EINTR;
+                               break;
+                       }
+
+                       set_current_state(TASK_INTERRUPTIBLE);
+
+                       write_unlock_irqrestore(&ep->lock, flags);
+                       timeout = schedule_timeout(timeout);

You should set current->state before performing the checks.

+               if (res > 0)
+                       copy_to_user((void *) arg, &dvp, sizeof(struct evpoll));

EFAULT?


+       write_lock_irqsave(&ep->lock, flags);
+
+       res = -EINVAL;
+       if (numpages != (2 * ep->numpages))
+               goto out;
+
+       start = vma->vm_start;
+       for (ii = 0; ii < ep->numpages; ii++) {
+               if (remap_page_range(vma, start, __pa(ep->pages0[ii]),
+                                                        PAGE_SIZE, vma->vm_page_prot))

remap_page_range() can sleep in pmd_alloc(), etc.  May not be called under
spinlock.
