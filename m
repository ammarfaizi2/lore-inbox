Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132888AbRDQVuH>; Tue, 17 Apr 2001 17:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132884AbRDQVt6>; Tue, 17 Apr 2001 17:49:58 -0400
Received: from maniola.plus.net.uk ([195.166.135.195]:25218 "HELO
	mail.plus.net.uk") by vger.kernel.org with SMTP id <S132880AbRDQVtr>;
	Tue, 17 Apr 2001 17:49:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
To: andrea@suse.de
Subject: Re: generic rwsem [Re: Alpha "process table hang"]
Date: Tue, 17 Apr 2001 22:48:02 +0100
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org, dhowells@redhat.com, torvalds@transmeta.com
MIME-Version: 1.0
Message-Id: <01041722480200.05613@orion.ddi.co.uk>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I am sure ppc couldn't race (at least unless up_read/up_write were excuted 
> from irq/softnet context and that never happens in 2.4.4pre3, see below ;). 

This is not actually using the rwsem code I wrote at the moment.

> And incidentally the above is what (I guess Richard) did on the alpha and
> that should really go into common code instead of having
> asm-i386/rwsem-xadd.h asm-alpha/rwsem.h etcc.etc... just implement
> atomic_inc_return using xadd in asm-i386/atomic.h, that's much better
> design IMHO. 

I disagree... you want such primitives to be as efficient as possible. The 
whole point of having asm/xxxx.h files is that you can stuff them full of 
dirty tricks specific to certain architectures.

> That can obviously be done for example with C code like this: 
>        count = atomic_inc_return(&sem->count); 
>        if (__builtin_expect(count == 0, 0)) 
>                slow_path() 
>
> The above is the perfect C implementation IMHO

But not so efficient since it _has_ to take a jump unless the compiler can 
emit code in alternative text sections when it seems appropriate. Plus, you 
have to test count's value. XADD sets EFLAGS based on the result in memory, 
something that allows all but one fastpath to be two instructions in length 
(the one that isn't is three).

But, yes, there should probably be two generic cases: one implemented with a 
spinlock in the rwsem struct (as I supply) and one implemented using 
atomic_add_return(). Note, however! atomic_add_return() is not necessarily 
implemented efficiently: if it involves a cmpxchg loop (as many seem to), 
then that is really quite inefficient, and may be better done as a spinlock 
anyway.

I've had a look at your implementation... It seems to hold the spinlocks for 
an awfully long time... specifically around the local variable initialisation 
in the 'failed' functions. Don't forget that the compiler can't reorder these 
because they're inside the spinlock. I would, if I were you, fold the 
'failed' functions into the main ones to avoid this problem.

Your rw_semaphore structure is also rather large: 46 bytes without debugging 
stuff (16 bytes apiece for the waitqueues and 12 bytes for the rest). 
Contrast that with mine: generic is 24 bytes and the i386-xadd optimised is 
20.

Admittedly, though, yours is extremely simple and easy to follow, but I don't 
think it's going to be very fast.

Of course, I still prefer mine... smaller, faster, more efficient:-)

David
