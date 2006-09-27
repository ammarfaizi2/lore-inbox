Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964996AbWI0Pzk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964996AbWI0Pzk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 11:55:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964997AbWI0Pzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 11:55:40 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:29146 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S964996AbWI0Pzj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 11:55:39 -0400
Subject: Re: question about __raw_spin_lock()
From: Steven Rostedt <rostedt@goodmis.org>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
In-Reply-To: <E5DA3895-7CFB-47BB-A6B3-D9F073F9F5A3@e18.physik.tu-muenchen.de>
References: <E5DA3895-7CFB-47BB-A6B3-D9F073F9F5A3@e18.physik.tu-muenchen.de>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 11:55:19 -0400
Message-Id: <1159372520.13500.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trying to catchup on LKML (only 5234 messages to go :P)

On Wed, 2006-09-06 at 10:25 +0200, Roland Kuhn wrote:
> Dear experts!
> 
> Trying to inform myself about the locking possibilities on i386, I  
> read linux/include/asm-i386/spinlock.h. I'm no expert on inline  
> assembly, so I'm asking myself what would happen on a very big system  
> if more than 128 threads are waiting on the same raw_spinlock_t.  
> Would the 129th locker erroneously succeed immediately?

Any machine today that has 129 processors had better be a 64 bit
machine. And this is not an issue on x86_64.  If you do have a 128+ CPU
i386 machine, then modify the kernel yourself :)

> 
> As a side note: I was looking because I have to implement a simple  
> lock between processes in shared memory, and unfortunately I cannot  
> use the NPTL :-( SysV semaphores presumably are much too heavy to  
> protect simple linked list operations (no scanning of the list under  
> the lock, just inserting on one end and removing from the other).  
> Does anybody have a better idea than spinning in user space---with a  
> nanosleep now and then---or does this have problems I'm not aware of?

userspace spinlocks are really bad.  Unless you pin all the threads that
share that lock to their own CPU, you can have one thread preempting
another that owns the lock, and then spin waiting for the owner to
release the lock, while the owner is waiting to run on the processor
that has the spinning thread.  In the RT world, this can spell death.

Look into using futexes.  They are fast userspace mutexes.  I believe
the pthread mutex code uses these.  They are also robust and can also
include priority inheritance.  They run in userspace unless there is
contention, which they then go into the kernel.

-- Steve


