Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293133AbSCAFGA>; Fri, 1 Mar 2002 00:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310228AbSCAFC0>; Fri, 1 Mar 2002 00:02:26 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:25383 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S310339AbSCAFBo>; Fri, 1 Mar 2002 00:01:44 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, <mingo@elte.hu>,
        Matthew Kirkwood <matthew@hairy.beasts.org>,
        Benjamin LaHaise <bcrl@redhat.com>, David Axmark <david@mysql.com>,
        William Lee Irwin III <wli@holomorphy.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lightweight userspace semaphores...
In-Reply-To: <Pine.LNX.4.33.0202241719330.1420-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 28 Feb 2002 21:56:45 -0700
In-Reply-To: <Pine.LNX.4.33.0202241719330.1420-100000@home.transmeta.com>
Message-ID: <m1r8n43mya.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Mon, 25 Feb 2002, Rusty Russell wrote:
> >
> > Bugger.  How about:
> >
> > 	sys_sem_area(void *pagestart, size_t len)
> > 	sys_unsem_area(void *pagestart, size_t len)
> >
> > Is that sufficient?  Is sys_unsem_area required at all?
> 
> The above is sufficient, but I would personally actually prefer an
> interface more like

Hmm.  My preference is for something like
mprotect(start, len, PROT_SEM | PROT_READ | PROT_WRITE);

And then 
#ifdef PROT_SEM && PROT_SEM
mprotect ....
#else
/* This architecture needs not special support skip the mprotect...
#endif

> 	fd = sem_initialize();
> 	mmap(fd, ...)
> 	..
> 	munmap(..)
> 
> which gives you a handle for the semaphore.

Ouch.  

The common case for a decent lock is the uncontended case.  In which
case you only need kernel support on demand.  What you suggest would
create kernel data structures for all of the uncontended locks.  That
sounds heavy.  Especially as the memory on most architectures is already
safe to use for locks.

So if nothing else can we separate the two cases of having user space
memory safe for user space spin locks.   And how to setup a wait queue
of user space waiters on when we need to wait?

Eric

