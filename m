Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264125AbTIIOtt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264155AbTIIOtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:49:49 -0400
Received: from chaos.analogic.com ([204.178.40.224]:64640 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264125AbTIIOtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:49:45 -0400
Date: Tue, 9 Sep 2003 10:51:44 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Alan Stern <stern@rowland.harvard.edu>
cc: Andreas Dilger <adilger@clusterfs.com>, linux-kernel@vger.kernel.org
Subject: Re: How can I force a read to hit the disk?
In-Reply-To: <Pine.LNX.4.44L0.0309090952560.887-100000@ida.rowland.org>
Message-ID: <Pine.LNX.4.53.0309091037150.5368@chaos>
References: <Pine.LNX.4.44L0.0309090952560.887-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Alan Stern wrote:

> On Tue, 9 Sep 2003, Richard B. Johnson wrote:
>
> > On Mon, 8 Sep 2003, Alan Stern wrote:
> >
> > > > When your thread code starts up, execute
> > > >                 init_rwsem(&current->mm->mmap_sem);
> > > >
> > > > ... This is in the thread's code, not the module init code.
> > >
> > > That doesn't work either; it also causes a segmentation violation.  As I
> > > said before, current->mm is NULL.  It gets set that way by exit_mm() which
> > > is called from daemonize().
> > >
> > > Alan Stern
> > >
> >
> > Gawd. I assumed you knew how to initialize a pointer. I just
> > located the procedure used to initialize the semaphore.
>
> Shucks, I know how to initialize a pointer.  I even know how to initialize
> a read-write semaphore.  The problem here is not _doing_ the
> initialization; it's what _value_ to use.  Kernel threads don't have a
> userpace memory component, so naturally current->mm is NULL -- there's no
> memory map for it to point to.  Without having a memory map, of course
> there's no semaphore to initialize, since the semaphore is _part_ of the
> memory map structure.
>
> Alan Stern
>

The semaphore location exists in the memory map structure, mm_struct.
You only need to allocate some memory the size of that structure to
contain the semaphore. You can readily see what happens in
../kernel/fork.c ...:

    Something like:

          if((current->mm = mm_alloc()) == NULL)
              printk("Some problem with mm_alloc()\n");
          else
              init_rwsem(&current->mm->mmap_sem);

   ... should get you going.

    If, in all your code, the only problem you had was an allocation
problem with your semaphore, and not a problem with actual memory
access, then you are golden. If you are even going to shut down your
kernel thread, you probably need to add your allocation to the
linked list. If not, don't bother.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (794.73 BogoMips).
            Note 96.31% of all statistics are fiction.


