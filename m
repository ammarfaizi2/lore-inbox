Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271757AbRICRUZ>; Mon, 3 Sep 2001 13:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271758AbRICRUP>; Mon, 3 Sep 2001 13:20:15 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:27936 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S271757AbRICRUB>; Mon, 3 Sep 2001 13:20:01 -0400
Date: Mon, 3 Sep 2001 19:20:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: mmap-rb-7 [was Re: /proc/<n>/maps growing...]
Message-ID: <20010903192036.W699@athlon.random>
In-Reply-To: <000f01c1349b$263fb890$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000f01c1349b$263fb890$010411ac@local>; from manfred@colorfullife.com on Mon, Sep 03, 2001 at 07:09:03PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 07:09:03PM +0200, Manfred Spraul wrote:
> > +/*
> > + * vma->vm_start/vm_end cannot change under us because the caller is
> required
> > + * to hold the mmap_sem in write mode. We need to get the spinlock
> only
> > + * before relocating the vma range ourself.
> > + */
> 
> There is one exception to that rule: a growable stack grows with
> mmap_sem only acquired in read mode. vm_start can change on platforms

expand_stack was broken. I fixed that, see the other patch posted to l-k
today. growsup faults must grab the write semaphore too of course.

> > - lock_vma_mappings(vma);
> > - spin_lock(&vma->vm_mm->page_table_lock);
> >  vma->vm_pgoff += (end - vma->vm_start) >> PAGE_SHIFT;
> > + lock_vma_mappings(vma);
> > + spin_lock(&mm->page_table_lock);
> > vma->vm_start = end;
> 
> Could be wrong with concurrent stack faults.

even if the growsdown faults would acquire only the read seamphore that
change would still be obviously right because there (madvise) we hold
the write semaphore, and even in the buggy 2.4.10pre4 the stack faults
at least grab the read semaphore so they cannot race.

Andrea
