Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264428AbTIIUWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264409AbTIIUUC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:20:02 -0400
Received: from ida.rowland.org ([192.131.102.52]:3332 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264495AbTIIUQ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:16:59 -0400
Date: Tue, 9 Sep 2003 16:16:58 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <Pine.LNX.4.53.0309091037150.5368@chaos>
Message-ID: <Pine.LNX.4.44L0.0309091542560.643-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Richard B. Johnson wrote:

> The semaphore location exists in the memory map structure, mm_struct.
> You only need to allocate some memory the size of that structure to
> contain the semaphore. You can readily see what happens in
> ../kernel/fork.c ...:
> 
>     Something like:
> 
>           if((current->mm = mm_alloc()) == NULL)
>               printk("Some problem with mm_alloc()\n");
>           else
>               init_rwsem(&current->mm->mmap_sem);
> 
>    ... should get you going.
> 
>     If, in all your code, the only problem you had was an allocation
> problem with your semaphore, and not a problem with actual memory
> access, then you are golden.

I'm afraid it's not as simple as that.  Yes, my driver is working just 
fine, apart from these conceptual difficulties in getting O_DIRECT to 
perform.  (Without the O_DIRECT, it works perfectly -- other than not 
bypassing the page cache.)

I did what you suggested: current->mm = mm_alloc().  (I had to change
kernel/fork.c since mm_alloc() isn't EXPORTed.)  The call to init_rwsem()  
isn't needed because mm_alloc() calls mm_init(), which does it.  That much
succeeded.  But what about setting current->active_mm?  What about undoing 
the effect of enter_lazy_tlb(), which is called indirectly by daemonize()?  
Or does it not need to be undone?

In the end, your suggestion didn't work.  Subsequent calls to vfs_read()
returned -EFAULT, which obviously isn't useful.  I know very little about
the intimate details of Linux's memory management; is it possible that the
EFAULT occurred because my I/O buffer is in kernel space rather than user
space?  My kernel thread does execute set_fs(get_ds()) before doing much
else.  But the direct_io path seems to do some involved memory-address
calculations; is it only meant to work with user-space buffers?

>  If you are even going to shut down your
> kernel thread, you probably need to add your allocation to the
> linked list. If not, don't bother.

Yes, my thread does need to exit.  To what linked list do you refer -- one
based on init_mm?  Is the mm->mmlist member of my structure the part that
should be linked in, as dup_mmap() does?  What about all the other stuff
dup_mmap() does, that my driver doesn't do?

Simply exiting without doing anything else was disastrous.  The system got
caught in an uninterruptible error loop.

Alan Stern

